--Lukas Leis
--Hope that you enjoy getting ratted 24/7
--Stop buying shit with your parents card before we use it too

-----------------------------------------------
--WARNING:
--We wont stop leaking shit
--Next up is leaking your mothers banking details and her medical details
-----------------------------------------------

--     -bombagroup#4115-
--     -BombaGroup-
--     -"nothing is safe"-

VNP.Inventory = VNP.Inventory or {}
VNP.Inventory.Items = VNP.Inventory.Items or {}
VNP.Inventory.Rarities = VNP.Inventory.Rarities or {}
VNP.Inventory.Language = VNP.Inventory.Language or {}


function VNP.Inventory:RegisterLanguage(key, l, t, suffix, prefix)
    self.Language[key] = {l = l, t = t, s = suffix, p = prefix}
end

function VNP.Inventory:GetLanguageLabel(key)
    if !self.Language[key] then return nil end

    return self.Language[key].l
end

function VNP.Inventory:GetLanguageType(key)
    if !self.Language[key] then return nil end

    return self.Language[key].t
end

function VNP.Inventory:GetLanguageSuffix(key)
    if !self.Language[key] then return "%" end

    return self.Language[key].s
end

function VNP.Inventory:GetLanguagePrefix(key)
    if !self.Language[key] then return "+" end

    return self.Language[key].p
end

function VNP.Inventory:GetItemData(name, val)
    for t,_ in pairs(self.Items) do
        if val && self.Items[t][name] && self.Items[t][name][val] then return self.Items[t][name][val] end
        if self.Items[t][name] then return self.Items[t][name] end
    end

    return false
end

function VNP.Inventory:GetItemType(name)
    for t,_ in pairs(self.Items) do
        if self.Items[t][name] then return t end
    end

    return false
end

function VNP.Inventory:GetRarity(name)
    return self.Rarities[name]
end

function VNP.Inventory:GetRarityValue(name, key)
    if !self.Rarities[name] then return end
    if !self.Rarities[name][key] then return end

    return self.Rarities[name][key]
end

function VNP.Inventory:GetSlotPage(slot)
    local slotsPerPage = self.SlotsY*self.SlotsX

    for p,a in pairs(self.Pages) do
       if slot < (p+1)*slotsPerPage then return p end
    end
end

function VNP.Inventory:GetRaritiesByOrder()
    local newTbl = {}

    for k,v in SortedPairsByMemberValue(self.Rarities, "Order") do
        newTbl[v.Order] = v
    end

    return newTbl
end

function VNP.Inventory:GetPreviousRarity(name, key)
    local rarity

    local order = self.Rarities[name].Order

    rarity = self:GetRaritiesByOrder()[order-1]

    if !rarity then return end

    if key then
        rarity = rarity[key]
    end

    return rarity
end

function VNP.Inventory:GetNextRarity(name, key)
    local rarity

    local order = self.Rarities[name].Order

    rarity = self:GetRaritiesByOrder()[order+1]

    if !rarity then return end

    if key then
        rarity = rarity[key]
    end

    return rarity
end

local upgradeTypes = {
    "SCROLL",
    "UPGRADEGEM",
    "GEM",
}

function VNP.Inventory:IsUpgrade(t)
    if table.HasValue(upgradeTypes, t) then return true end

    return false
end

function VNP.Inventory:IsEnergyWeapon(class)
    if table.HasValue(self.EnergyWeapons, class) then return true end

    return false
end

function VNP.Inventory:SlotsPerPage()
    return self.SlotsY*self.SlotsX
end

local PLAYER = FindMetaTable("Player")

function PLAYER:GetItemsByType(t)
    local tbl = {}
    
    if VNP.Inventory:IsUpgrade(t) then
        for k,v in pairs(self._vInventory["UPGRADES"]) do
            if v.Type ~= t then continue end
            tbl[k] = v
        end
    else
        for k,v in ipairs(self._vInventory) do
            if v.Type ~= t then continue end
            tbl[k] = v
        end
    end
    return tbl
end

function PLAYER:GetScrap()
    return self._vInventory["SCRAP"] or nil
end

function PLAYER:GetInventory()
    return self._vInventory or nil
end

function PLAYER:GetInventoryPages() // returns the total number of pages the player has bought
    self._vInventory["PAGES"] = self._vInventory["PAGES"] or 1
    return self._vInventory["PAGES"]
end

function PLAYER:GetAvailableSlot(page)
    local slotsPerPage = VNP.Inventory.SlotsY*VNP.Inventory.SlotsX
    local min,max
    
    if page then
        min,max = 1+(page*slotsPerPage)-slotsPerPage, (page*slotsPerPage)
    else
        min,max = 1,(self:GetInventoryPages()*slotsPerPage)
    end

    for i=min,max do
        if self._vInventory[i] ~= nil then continue end
        
        return i
    end
end

function PLAYER:GetAvailableUpgradeSlot()
    local slotsPerPage = VNP.Inventory.SlotsY*VNP.Inventory.SlotsX

    for i=1,slotsPerPage do
        if self._vInventory["UPGRADES"][i] ~= nil then continue end
        
        return i
    end
end

local WEAPON = FindMetaTable("Weapon")

function WEAPON:StreamStat(name, val) -- ME no steal
	if (self.Primary and self.Primary[name]) then
		self.Primary[name] = val
	end
    
    if self[name] then
        self[name] = val
    end

    if (self.Secondary and self.Secondary[name]) then
		self.Secondary[name] = val
    end

	if SERVER && self.Primary[name] or self.Secondary[name] or self[name] then
        VNP:Broadcast("VNP.StreamStat", {name = name, val = val, weapon = self})
    end
end

function WEAPON:GetStat(name)
	if (self.Primary and self.Primary[name]) then
		return self.Primary[name]
	end
	
	return self[name]
end

function WEAPON:GetNick()
    if self.PrintName == "Scripted Weapon" then return self.ClassName end
    
    return self.PrintName or self.ClassName
end

local ENTITY = FindMetaTable("Entity")

function ENTITY:GetItemData()
    return self.VNPItemData
end

hook.Add("InitPostEntity", "VNP.Inventory.CreateEntities", function()

    local gems = table.GetKeys(VNP.Inventory.Items["GEM"])
    local scrolls = table.GetKeys(VNP.Inventory.Items["SCROLL"])
    local upgradegems = table.GetKeys(VNP.Inventory.Items["UPGRADEGEM"])
    local rarities = table.GetKeys(VNP.Inventory.Rarities)

    for i,name in ipairs(gems) do
        local BASE = scripted_ents.Get("vnp_item_base")

        BASE.PrintName = name
        BASE.Spawnable = true
        BASE.VNPItemName = name
        BASE.Category = "VNP Gems"

        scripted_ents.Register(BASE, "vnp_gem_"..string.lower(string.Replace(name, " ", "_")))
    end

    for _,rarity in ipairs(rarities) do
        local name = "Upgrade Scroll"
        local BASE = scripted_ents.Get("vnp_item_base")

        BASE.PrintName = name.." ("..rarity..")"
        BASE.Spawnable = true
        BASE.VNPItemName = name
        BASE.ItemRarity = rarity
        BASE.Category = "VNP Scrolls"

        scripted_ents.Register(BASE, "vnp_scroll_"..string.lower(string.Replace(name.."_"..rarity, " ", "_")))
    end

    for i,name in ipairs(upgradegems) do
        local BASE = scripted_ents.Get("vnp_item_base")

        BASE.PrintName = name
        BASE.Spawnable = true
        BASE.VNPItemName = name
        BASE.Category = "VNP Upgrade Gems"

        scripted_ents.Register(BASE, "vnp_upgradegem_"..string.lower(string.Replace(name, " ", "_")))
    end

    if CLIENT then
        RunConsoleCommand("spawnmenu_reload")
    end

    local BASE = scripted_ents.Get("vnp_item_base")
    local name = "Upgrade Scroll (Universal)"
    BASE.PrintName = name
    BASE.Spawnable = true
    BASE.VNPItemName = name
    BASE.Category = "VNP Scrolls"
    
    scripted_ents.Register(BASE, "vnp_scroll_"..string.lower(string.Replace(name, " ", "_")))
    BASE = scripted_ents.Get("vnp_item_base")
    name = "Reroll Scroll"    BASE.PrintName = name
    BASE.Category = "VNP Scrolls"
    BASE.Spawnable = true
    BASE.VNPItemName = name
    scripted_ents.Register(BASE, "vnp_scroll_"..string.lower(string.Replace(name, " ", "_")))


end)

hook.Add("EntityFireBullets", "VNP.Inventory.OnBulletFire", function(ply, bullet)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local wep = ply:GetActiveWeapon()

    if IsValid(wep) then
        local item = wep:GetItemData()

        if item && item.Sockets && #item.Sockets > 0 then
            for _,gem in pairs(item.Sockets) do
                if !gem then continue end
                
                local data = VNP.Inventory:GetItemData(gem.Name)

                if data.OnBulletFire then
                    data.OnBulletFire(ply, gem, wep, bullet)
                end
            end
        end

        return true
    end
end)

function VNP.Inventory:CreateExplosion(pos, damage, damageRadius, effectRadius, duration, attacker) // Totally didn't steal
    if(SERVER) then
		if(!IsValid(attacker) || !attacker:IsPlayer()) then return end
		
		local wep = attacker:GetActiveWeapon()
		if(!IsValid(wep)) then return end

		util.BlastDamage(wep, attacker, pos, damageRadius, damage)
	else
        local dist = LocalPlayer():GetPos():DistToSqr(pos)

        if dist > 1000000 then return end

		local emitter = ParticleEmitter(Vector())
		local offset = Vector(0, 0, 3)

		for i = 1, 20 do
			local prt = emitter:Add(("particle/smokesprites_%04d"):format(math.random(1, 16)), pos + offset)
			prt:SetVelocity(VectorRand() * effectRadius * 5)
			prt:SetDieTime(duration)
			prt:SetStartAlpha(20)
			prt:SetEndAlpha(0)
			prt:SetStartSize(effectRadius * 2)
			prt:SetEndSize(effectRadius * 5)
			prt:SetLighting(true)
			prt:SetColor(Color(0, 0, 0))
		end

		for i = 1, 40 do
			local prt = emitter:Add("particles/flamelet"..math.random(1,5), pos + offset)
			prt:SetVelocity(VectorRand() * effectRadius * 5)
			prt:SetDieTime(duration)
			prt:SetStartAlpha(50)
			prt:SetEndAlpha(0)
			prt:SetStartSize(0)
			prt:SetEndSize(effectRadius * 2)
		end

		timer.Simple(duration, function()
			if(IsValid(emitter)) then emitter:Finish() end
		end)
	end
end

DMG_DOT = 32768