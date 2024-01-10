VNP.Inventory = VNP.Inventory or {}

VNP.Inventory.UIDs = 0

function VNP.Inventory:CreateItem(name, rarity)
    local data = self:GetItemData(name)
    if !data then return end

    local Item = {}

    
    Item.Name = name

    Item.Label = data.Label or nil

    Item.Type = self:GetItemType(name)
    Item.UID = self:GenerateUID(name)
    Item.Rarity = {
        Name = rarity
    }

    if data.Rarity then
        Item.Rarity.Name = data.Rarity
    end

    if !self:IsUpgrade(Item.Type) then
        Item.Rarity.Modifiers = self:CalcRarityMods(Item)
        Item.Sockets = self:CalcRaritySockets(rarity)
    end

    if self:IsUpgrade(Item.Type) && data.Modifiers then
        Item.Modifiers = {}

        local mods = data.Modifiers

        if mods[rarity] then
            mods = mods[rarity]
        end

        for stat,data in pairs(mods) do
            if data.min && data.max then
                Item.Modifiers[stat] = math.random(data.min, data.max)
            elseif data.val then
                Item.Modifiers[stat] = data.val
            end
        end
    end

    if Item.Type == "SUIT" then
        Item["SuitHealth"] = VNP.Inventory:CalculateMaxStat(Item, "SuitHealth")
        Item["SuitArmor"] = VNP.Inventory:CalculateMaxStat(Item, "SuitArmor")
    end

    return Item
end

function VNP.Inventory:Initialize()

    VNP.Database:InitializeTable("inventory")

    VNP.Database:GetData("inventory", "unique_ids", function(data)
        VNP.Inventory.UIDs = data or 0
    end)

    hook.Add("EntityTakeDamage", "VNP.Inventory.OnHit", function(victim, dmginfo)
        if dmginfo:IsDamageType(DMG_DOT) then return end
        
        local attacker = dmginfo:GetAttacker()

        if victim == attacker then return end
        if !IsValid(attacker) then return end
        if !IsValid(victim) then return end

        -- Attacker stuff
        if attacker:IsPlayer() then
            local wep = attacker:GetActiveWeapon()

            if IsValid(wep) then
                local item = wep:GetItemData()

                if item && item.Sockets && #item.Sockets > 0 then
                    for _,gem in pairs(item.Sockets) do
                        if !gem then continue end
                        local data = VNP.Inventory:GetItemData(gem.Name)

                        if data.OnHit then
                            data.OnHit(victim, gem, wep, dmginfo)
                        end
                    end
                end
            end
        end

        -- Victim stuff
        if victim:IsPlayer() then
            local item = victim.GetSuit && victim:GetSuit() 

            if item && item.Sockets then
                for _,gem in ipairs(item.Sockets) do
                    if !gem then continue end
                    local data = VNP.Inventory:GetItemData(gem.Name)
                    if data.OnOwnerHit then -- owner, attacker, item, dmginfo
                        data.OnOwnerHit(victim, attacker, gem, dmginfo)
                    end
                end
            end
        end
    end)

    hook.Add("PlayerSwitchWeapon", "VNP.Inventory.OnEquip", function(ply, olWep, nWep)
        if !IsValid(ply) then return end
        if IsValid(olWep) then
            local item = olWep.GetItemData && olWep:GetItemData()
            
            if item && item.Sockets && #item.Sockets > 0 then
                for _,gem in pairs(item.Sockets) do
                    if !gem then continue end
                    local data = VNP.Inventory:GetItemData(gem.Name)

                    if data.OnUnequip then
                        data.OnUnequip(ply, gem, olWep)
                    end
                end
            end
        end

        if IsValid(nWep) then
            local item = nWep.GetItemData && nWep:GetItemData()
            
            if item && item.Sockets && #item.Sockets > 0 then
                for _,gem in pairs(item.Sockets) do
                    if !gem then continue end
                    local data = VNP.Inventory:GetItemData(gem.Name)

                    if data.OnEquip then
                        data.OnEquip(ply, gem, nWep)
                    end
                end
            end
        end
    end)

    hook.Add("PlayerDeath", "VNP.Inventory.OnPlayerDeath", function(ply)
        local weps = ply:GetWeapons()
        
        if ply.VNPFrozenProp then ply.VNPFrozenProp:Remove() end

        for _,wep in ipairs(weps) do
            local item = wep:GetItemData()

            if item && item.Sockets && #item.Sockets > 0 then
                for _,gem in pairs(item.Sockets) do
                    if !gem then continue end
                    local data = VNP.Inventory:GetItemData(gem.Name)

                    if data.OnPlayerDeath then
                        data.OnPlayerDeath(ply, item, gem, _)
                    end
                end
            end
        end

        local item = ply.GetSuit && ply:GetSuit()

        if item && item.Sockets && #item.Sockets > 0 then
            for _,gem in pairs(item.Sockets) do
                if !gem then continue end
                local data = VNP.Inventory:GetItemData(gem.Name)

                if data.OnPlayerDeath then
                    data.OnPlayerDeath(ply, item, gem, _)
                end
            end
        end
    end)

    hook.Add("PlayerInitialSpawn", "VNP.LoadInventory", function(ply)
        ply:LoadInventory()
    end)

    hook.Add("PlayerDisconnected", "VNP.SaveInventory", function(ply)
        if !IsValid(ply) then return end
        
        if ply.SellEnts then
            for k,ent in pairs(ply.SellEnts) do
                local item = ent:GetItemData()
                if !item then continue end
                item = table.Copy(item)
                ent:Remove()

                ply:AddInventoryItem(item)
            end
        end

        ply:SaveInventory()

    end)

    hook.Add("onDarkRPWeaponDropped", "VNP.onWeaponDropped", function(ply, droppedWep, wep)
        if !IsValid(wep) then return end
                if ply:GetNWBool("eventmode", false) == true then 
                    ply:ChatPrint("{*Server Is In Event Mode You Cannot Inv Holster!}") 
                    return false 
                end
        local data = wep:GetItemData()
        
        if !data then return end

        droppedWep:SetItemData(data)
    end)

    hook.Add("playerPickedUpWeapon", "VNP.DarkRPWeaponPickup", function(ply, droppedWep, wep)
        if !IsValid(wep) or !IsValid(ply) then return end
        if !VNP.Inventory:GetItemType(wep:GetNick()) then return end
        if ply:GetNWBool("eventmode", false) == true then 
            ply:ChatPrint("{*Server Is In Event Mode You Cannot Inv Holster!}") 
            return 
        end
        local data = wep:GetItemData()

        if droppedWep:GetItemData() then
            data = droppedWep:GetItemData()
        end

        if !data then
            data = VNP.Inventory:CreateItem(wep:GetNick(), "Common")

            if !data then return end
        end

        wep:SetItemData(data)
    end)

//    hook.Add("WeaponEquip", "VNP.WeaponEquip", function(wep, ply)
//        timer.Simple(1, function()
//            if !IsValid(wep) or !IsValid(ply) then return end
//            if ply:GetNWBool("eventmode", false) == true then ply:ChatPrint("{*Server Is In Event Mode You Cannot Inv Holster!}") return end
//            local data = wep:GetItemData()
//
//            if !data then
//                local item = VNP.Inventory:CreateItem(wep:GetNick(), "Common")
//            
//                if !item then return end
//
//                wep:SetItemData(item)
//            end
//        end)
//    end)

    hook.Add("PlayerSay", "VNP.PlayerSay", function(ply, msg)
        msg = string.lower(msg)

        if msg == "/invholster" then

            ply._VNPtagged = ply._VNPtagged or 0
            if CurTime() < ply._VNPtagged && (ply.GetSuit && ply:GetSuit()) then ply:NNotify("Error", "You cannot drop a suit while in combat!") return "" end
            local delayValue = VNP.Inventory.HolsterDelay[(not not ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() or ""] delayValue = (not delayValue) and 0 or delayValue

            timer.Simple(delayValue, function()
                local wep = ply:GetActiveWeapon()
                
                if IsValid(wep) && wep.GetItemData then

                    local canDrop = hook.Call("canDropWeapon", GAMEMODE, ply, wep)
                    if not canDrop then
                        DarkRP.notify(pl, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
                        return
                    end

                    if ply:GetNWBool("eventmode", false) == true then 
                        ply:ChatPrint("{*Server Is In Event Mode You Cannot Inv Holster!}") 
                        return 
                    end

                    local data = wep:GetItemData()
                    if !data then 
                        data = VNP.Inventory:CreateItem(wep:GetNick(), "Common")
                    end

                    if !data then return end

                    data.LSkins = LSkins:GetSkin(wep)
                    wep:SetItemData(data)

                    local data = wep:GetItemData()
                    ply:StripWeapon(wep:GetClass())
                    ply:AddInventoryItem(data)
                end
            end)
            return ""
        elseif string.StartWith(msg, "/31adilinami ") then
            local amt = tonumber(string.sub(msg, string.len("/31adilinami ")))

            if !amt then return "" end
            if amt < 1 then return end

            ply._VNPtagged = ply._VNPtagged or 0
            if CurTime() < ply._VNPtagged && (ply.GetSuit && ply:GetSuit()) then ply:NNotify("Error", "You cannot drop a suit while in combat!") return "" end

            ply.SellEnts = ply.SellEnts or {}

            for _,v in pairs(ply.SellEnts) do
                if !IsValid(v) then ply.SellEnts[_] = nil end
            end

            if table.Count(ply.SellEnts) >= 5 then return end

            local wep = ply:GetActiveWeapon()

            local canDrop = hook.Call("canDropWeapon", GAMEMODE, ply, wep)
            if not canDrop then
                DarkRP.notify(pl, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
                return
            end

            if !IsValid(wep) or !wep.GetItemData then return end

            local data = wep:GetItemData()

            if !data then return end

            local skininfo = LSkins:GetSkin(weapon)
            ply:StripWeapon(wep:GetClass())

            local ent = ents.Create("vnp_item_base")
            ent:SetPos(ply:GetPos()+(ply:GetForward()*3)+Vector(0,0,5))
            ent:Spawn()
            ent:GetPhysicsObject():EnableMotion(false)
            ent:SetItemData(data)

            ent:SetNWBool("VNP.ForSale", true)
            ent:SetNWInt("VNP.Price", amt)

            ent:SetOwner(ply)
            LSkins:SetSkin(ent, skininfo)

            table.insert(ply.SellEnts, ent)

            return ""
        elseif string.StartWith(msg, "/sell ") then
            local amt = tonumber(string.sub(msg, string.len("/sell ")))

            if !amt then return "" end
            if amt < 1 then return "" end

            ply.SellEnts = ply.SellEnts or {}

            for _,v in pairs(ply.SellEnts) do
                if !IsValid(v) then ply.SellEnts[_] = nil end
            end

            if table.Count(ply.SellEnts) >= 5 then return end

            local ent = ply:GetEyeTrace().Entity

            if !IsValid(ent) or !ent.GetItemData or ent:GetOwner() ~= ply then return "" end

            local data = ent:GetItemData()

            if !data then return end
    
            local skininfo = LSkins:GetSkin(ent)
            ent:SetNWBool("VNP.ForSale", true)
            ent:SetNWInt("VNP.Price", amt)
            LSkins:SetSkin(ent, skininfo)

            table.insert(ply.SellEnts, ent)

            return ""
        end
    end)

    local time = VNP.Inventory.SaveTime or 120

    timer.Create("VNP.SaveInventories", time, 0, function()
        for _,ply in ipairs(player.GetHumans()) do

            if !ply._vInventoryLoaded then continue end

            timer.Simple(0.1*_, function()
                if !IsValid(ply) then return end
                ply:SaveInventory()
            end)
        end
    end)

    timer.Create("VNP.SaveUIDs", 5, 0, function()
        VNP.Database:SaveData("inventory", "unique_ids", VNP.Inventory.UIDs)
    end)
end

VNP.Inventory:Initialize()

concommand.Add("AddRandomItems", function(ply, cmd, args)
    if !IsValid(ply) or !ply:IsSuperAdmin() then return end
    
    local rarities = table.GetKeys(VNP.Inventory.Rarities)
    local weps = table.GetKeys(VNP.Inventory.Items["WEAPON"])
    local gems = table.GetKeys(VNP.Inventory.Items["GEM"])
    local scrolls = table.GetKeys(VNP.Inventory.Items["SCROLL"])
    local upgradegems = table.GetKeys(VNP.Inventory.Items["UPGRADEGEM"])

    for i=1,5 do
        local rarity = rarities[math.random(#rarities)]
        local name = weps[math.random(#weps)]
        local data = VNP.Inventory:CreateItem(name, rarity)

        data.Sockets[1] = VNP.Inventory:CreateItem("Fire", "Common")

        if !data then continue end
        ply:AddInventoryItem(data)
    end

    for i=1,5 do
        local rarity = rarities[math.random(#rarities)]
        local name = gems[math.random(#gems)]
        local data = VNP.Inventory:CreateItem(name, rarity)

        if !data then continue end
        ply:AddInventoryItem(data)
    end

    for i=1,5 do
        local rarity = rarities[math.random(#rarities)]
        local name = scrolls[math.random(#scrolls)]
        local data = VNP.Inventory:CreateItem(name, rarity)

        if !data then continue end
        ply:AddInventoryItem(data)
    end

    for i=1,5 do
        local rarity = rarities[math.random(#rarities)]
        local name = upgradegems[math.random(#scrolls)]
        local data = VNP.Inventory:CreateItem(name, rarity)

        if !data then continue end
        ply:AddInventoryItem(data)
    end

end)

concommand.Add("TestSpeed", function(target,cmd,args)
    local speed = target:GetMaxSpeed()

    local effectdata = EffectData()

    target:Paralyze(true)

    timer.Simple(5, function()
        if !IsValid(target) then return end
        
        target:Paralyze(false)
    end)
end)