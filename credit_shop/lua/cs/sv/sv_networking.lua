util.AddNetworkString("CreditStore.SyncCredits")
util.AddNetworkString("CreditStore.BuyPackage")
util.AddNetworkString("CreditStore.ExchangeCredits")
util.AddNetworkString("CreditStore.NotifyPurchase")
util.AddNetworkString("CreditStore.OpenMenu")

net.Receive("CreditStore.SyncCredits", function(len, ply)
    net.Start("CreditStore.SyncCredits")
    net.WriteTable(ply:CS_GetPermaWeapons() or {})
    net.WriteTable(ply:CS_GetPermaJobs() or {})
    net.WriteInt(CreditStore.GetCredits(ply:SteamID64()), 32)
    net.Send(ply)
end)

local bad_weps = {
    ["weapon_banhammer"] = true,
    ["amr11"] = true,
    ["blue_gaster"] = true,
    ["weapon_gblaster"] = true,
    ["weapon_gblaster_asriel_rainbow"] = true,
    ["weapon_gblaster_badtime"] = true,
    ["weapon_supreme_badtime_bm_gblaster"] = true,
    ["weapon_bm_rifle"] = true,
    ["weapon_bm_rifle_nonadmin"] = true,
    ["weapon_bm_rifle_admin"] = true,
    ["weapon_freezeray"] = true,
    ["ryry_m134"] = true
}

net.Receive("CreditStore.BuyPackage", function(len, ply)
    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end
    local category = net.ReadString()
    if not CreditStore.Config.Items[category] then return end
    category = CreditStore.Config.Items[category]
    local item = net.ReadInt(32)
    if not category[item] then return end
    item = category[item]

    if item.type == "perma_weapon" then
        for key, value in pairs(ply:CS_GetPermaWeapons() or {}) do
            if tonumber(value.class) == item.class then return end
        end
    elseif item.type == "job" then
        for key, value in pairs(ply:CS_GetPermaJobs() or {}) do
            if tonumber(value.class) == item.class then return end
        end
    end

    if not CreditStore.CanAfford(ply:SteamID64(), item.price) then return DarkRP.notify(ply, 1, 5, "You can't afford that!") end


local suits = {
    ["Admin Suit"] = true,
    ["Admin Suit V2"] = true,
    ["Compensation Suit"] = true,
    ["Elf Suit"] = true,
    ["Flash Suit"] = true,
    ["Godly Armour"] = true,
    ["Horror Suit"] = true,
    ["Horror Suit Tier 2"] = true,
    ["Horror Suit Tier 3"] = true,
    ["Santa Suit"] = true,
    ["Tier 1"] = true,
    ["Tier 2"] = true,
    ["Tier 3"] = true,
    ["Tier 4"] = true,
    ["Tier 5"] = true,
    ["Tier Fallen God"] = true,
    ["Tier God"] = true,
    ["Tier God Slayer"] = true,
    ["Tier Ultra God"] = true
}

    CreditStore.RemoveCredits(ply:SteamID64(), item.price)
    DarkRP.notify(ply, 0, 5, "You bought " .. item.name .. " for " .. item.price .. " credits.")

    if item.type == "weapon" then
        ply:Give(item.class)
    elseif item.type == "perma_weapon" then
        ply:Give(item.class)
        ply:CS_GivePermaWeapon(item.class)
    elseif item.type == "entity" then
        if item.class == "printer_tier" or item.class == "printer_tier_2" or item.class == "wt_rocketboots" then
            local item_ent = ents.Create(item.class)

            if item.model then
                item_ent:SetModel(item.model)
            end

            item_ent:SetPos(ply:LocalToWorld(Vector(50, 0, 0)))

            if item.func then
                item.func(item_ent)
            end

            item_ent:Spawn()

            return
        end
        
        if item.class == "vnp_upgradegem_super_gem" or item.class == "vnp_scroll_upgrade_scroll_(universal)" then
            data = VNP.Inventory:CreateItem(item.name, "Glitched")
            ply:AddInventoryItem(data)
            return
        end
        
        local var = ply:GetActiveWeapon():GetClass()

        if not bad_weps[var] then
            ply:ChatPrint("{*Weapon Is Not Whitelisted}")
            return
        end

        local wep = ply:GetActiveWeapon()
        local upgradeWeaponData = wep:GetItemData()
        data = VNP.Inventory:CreateItem(wep:GetNick(), "Glitched")
        data.LSkins = LSkins:GetSkin(wep)
        wep:SetItemData(upgradeWeaponData)
        ply:AddInventoryItem(data)
        ply:StripWeapon(var)
    elseif item.type == "job" then
        ply:CS_GivePermaJob(item.class)
    elseif item.type == "maxsuit" then
        local suit = ply:GetSuit()
        if not suit then 
            ply:ChatPrint("{*No Suit Equipped.}")
            return
        end
        if not suits[suit.Name] then
            ply:ChatPrint("{*Suit Is Not Whitelisted.}")
            return
        end
        if suit.Rarity.Name == "Glitched" then
            ply:ChatPrint("{*Suit Is Already Glitched.}")
            return
        end
        data = VNP.Inventory:CreateItem(suit.Name, "Glitched")
        data.Sockets[1] = VNP.Inventory:CreateItem("Freeze", "Glitched")
        data.LSkins = suit.LSkins
        ply:SetItemData(suit)
        ply:AddInventoryItem(data)
        ply:RemoveSuit()
    end

    net.Start("CreditStore.NotifyPurchase")
    net.WriteString(item.name)
    net.Send(ply)
    net.Start("CreditStore.SyncCredits")
    net.WriteTable(ply:CS_GetPermaWeapons() or {})
    net.WriteTable(ply:CS_GetPermaJobs() or {})
    net.WriteInt(CreditStore.GetCredits(ply:SteamID64()), 32)
    net.Send(ply)
end)

net.Receive("CreditStore.ExchangeCredits", function(len, ply)
    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end
    local credits = net.ReadInt(32)
    if not credits or not tonumber(credits) then return end
    credits = tonumber(credits) or 0
    if credits < 0 then return end
    local price = CreditStore.Config.ExchangePrice * credits
    if not ply:canAfford(price) then return DarkRP.notify(ply, 1, 5, "You can't afford that!") end
    ply:addMoney(-price)
    CreditStore.AddCredits(ply:SteamID64(), credits)
    DarkRP.notify(ply, 0, 5, "You bought " .. credits .. " credits for " .. DarkRP.formatMoney(price))
    net.Start("CreditStore.SyncCredits")
    net.WriteTable(ply:CS_GetPermaWeapons() or {})
    net.WriteTable(ply:CS_GetPermaJobs() or {})
    net.WriteInt(CreditStore.GetCredits(ply:SteamID64()), 32)
    net.Send(ply)
end)

hook.Add("PlayerSay", "CreditStore.PlayerSay", function(ply, text)
    if CreditStore.Config.ChatCommands[string.lower(text)] then
        net.Start("CreditStore.SyncCredits")
        net.WriteTable(ply:CS_GetPermaWeapons() or {})
        net.WriteTable(ply:CS_GetPermaJobs() or {})
        net.WriteInt(CreditStore.GetCredits(ply:SteamID64()), 32)
        net.Send(ply)
        net.Start("CreditStore.OpenMenu")
        net.Send(ply)

        return ""
    end
end)

hook.Add("PlayerSpawn", "CreditStore.SyncSpawnCredits", function(ply)
    local credits = CreditStore.GetCredits(ply:SteamID64())
    net.Start("CreditStore.SyncCredits")
    net.WriteTable(ply:CS_GetPermaWeapons() or {})
    net.WriteTable(ply:CS_GetPermaJobs() or {})
    net.WriteInt(credits, 32)
    net.Send(ply)
end)