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

VNP.Inventory.Items["SCROLL"] = {}

-- Scrolls are items that directly affect items whether it be rarity or stats

local SCROLL = {}

function VNP.Inventory:RegisterScroll(data)
    if !data.Name then return end

    data.CanEnhance = data.CanEnhance or function()
        return true
    end

    self.Items["SCROLL"][data.Name] = data

    SCROLL = {}
end

SCROLL.Name = "Upgrade Scroll"

SCROLL.UpgradeCost = 5000 -- Cost per rarity
SCROLL.UpgradeIncrement = 2.5 -- Price above multiplies by this increment for every rarity

SCROLL.Description = "Use this on an item to increase it's rarity."

SCROLL.ColorModel = true -- Whether or not to apply the rarity color to the model
SCROLL.Model = "models/props/cs_office/paper_towels.mdl"

SCROLL.CanEnhance = function(scroll, item)
    local prevRarity = VNP.Inventory:GetPreviousRarity(scroll.Rarity.Name, "Name")
    if item.Rarity.Name ~= prevRarity then return false end

    return true
end

SCROLL.OnEnhance = function(ply, scroll, item, gem) -- Return item, DoRemoveScroll, DoRemoveGem, DoRemoveItem
    if !item or !item.Name then return end
    if !scroll or !scroll.Name then return end
    
    if item.Rarity.Name ~= VNP.Inventory:GetPreviousRarity(scroll.Rarity.Name, "Name") then return end

    local data = VNP.Inventory:GetItemData(item.Name)

    if !data then return end

    if !item.Signature then
        item.Signature = ply:Nick()
    end

    local chance = table.Copy(VNP.Inventory:GetRarityValue(scroll.Rarity.Name, "UpgradeChance"))

    for k,v in pairs(chance) do
        if !v.val then chance[k] = nil continue end
        chance[k] = v.val
    end

    local r = math.random(10000)/100

    if gem && gem.Modifiers then -- Modifies the chances based off of the upgrade gem...
        for stat, val in pairs(chance) do
            if gem.Modifiers[stat] then
                chance[stat] = chance[stat] + gem.Modifiers[stat]
            end
        end
    end
    
    local function doStuff(item,rarity)
        item.Rarity.Name = rarity

        if VNP.Inventory:IsUpgrade(item.Type) && item.Modifiers then
            item.Modifiers = {}

            local mods = data.Modifiers

            if mods[rarity] then
                mods = mods[rarity]
            end

            for stat,data in pairs(mods) do
                if data.min && data.max then
                    item.Modifiers[stat] = math.random(data.min, data.max)
                elseif data.val then
                    item.Modifiers[stat] = data.val
                end
            end
        elseif item.Rarity.Modifiers then
            item.Rarity.Modifiers = VNP.Inventory:CalcRarityMods(item)
        end
        return item
    end

    -- Success code
    if chance["upgrMajorSuccess"] && r < chance["upgrMajorSuccess"] then
        
        item = doStuff(item,VNP.Inventory:GetRarityValue(nextRarity, scroll.Rarity.Name))

        return item, true, "Major Success"
    elseif chance["upgrMinorSuccess"] && r < chance["upgrMinorSuccess"] then

        item = doStuff(item,scroll.Rarity.Name)
        
        return item, true, "Success"
    end

    -- Fail Code
    if chance["upgrMajorFail"] && (100-chance["upgrMajorFail"]) < r then

        item = doStuff(item,"Uncommon")

        return item, true, "Major Fail"
    elseif chance["upgrMinorFail"] && (100-chance["upgrMinorFail"]) < r then
        return nil, true, "Minor Fail"
    end

    return nil, true, "Failed"
end

VNP.Inventory:RegisterScroll(SCROLL)

--

SCROLL.Name = "Upgrade Scroll (Universal)"

SCROLL.Rarity = "Glitched"

SCROLL.UpgradeCost = 5000 -- Cost per rarity
SCROLL.UpgradeIncrement = 2.5 -- Price above multiplies by this increment for every rarity

SCROLL.Description = "Use this on an item to increase it's rarity."

SCROLL.ColorModel = true -- Whether or not to apply the rarity color to the model
SCROLL.Model = "models/props/cs_office/paper_towels.mdl"

SCROLL.CanEnhance = function(scroll, item)
    return true
end

SCROLL.OnEnhance = function(ply, scroll, item, gem) -- Return item, DoRemoveScroll, DoRemoveGem, DoRemoveItem
    if !item or !item.Name then return end
    if !scroll or !scroll.Name then return end

    local data = VNP.Inventory:GetItemData(item.Name)

    if !data then return end

    if !item.Signature then
        item.Signature = ply:Nick()
    end

    local nextRarity = VNP.Inventory:GetNextRarity(item.Rarity.Name, "Name")

    local chance = table.Copy(VNP.Inventory:GetRarityValue(nextRarity, "UpgradeChance"))

    for k,v in pairs(chance) do
        if !v.val then chance[k] = nil continue end
        chance[k] = v.val
    end

    local r = math.random(10000)/100

    if gem && gem.Modifiers then -- Modifies the chances based off of the upgrade gem...
        for stat, val in pairs(chance) do
            if gem.Modifiers[stat] then
                chance[stat] = chance[stat] + gem.Modifiers[stat]
            end
        end
    end
    
    local function doStuff(item,rarity)
        item.Rarity.Name = rarity

        if VNP.Inventory:IsUpgrade(item.Type) && item.Modifiers then
            item.Modifiers = {}

            local mods = data.Modifiers

            if mods[rarity] then
                mods = mods[rarity]
            end

            for stat,data in pairs(mods) do
                if data.min && data.max then
                    item.Modifiers[stat] = math.random(data.min, data.max)
                elseif data.val then
                    item.Modifiers[stat] = data.val
                end
            end
        elseif item.Rarity.Modifiers then
            item.Rarity.Modifiers = VNP.Inventory:CalcRarityMods(item)
        end

        if item.Type == "WEAPON" then
            item.Sockets = VNP.Inventory:CalcRaritySockets(rarity)
        elseif item.Type == "SUIT" then
            item["SuitHealth"] = VNP.Inventory:CalculateMaxStat(item, "SuitHealth")
            item["SuitArmor"] = VNP.Inventory:CalculateMaxStat(item, "SuitArmor")

            item.Sockets = VNP.Inventory:CalcRaritySockets(rarity)
        end

        return item
    end

    -- Success code
    if chance["upgrMajorSuccess"] && r < chance["upgrMajorSuccess"] then
        
        item = doStuff(item,VNP.Inventory:GetNextRarity(nextRarity, "Name"))

        return item, true, "Major Success"
    elseif chance["upgrMinorSuccess"] && r < chance["upgrMinorSuccess"] then

        item = doStuff(item,nextRarity)
        
        return item, true, "Success"
    end

    -- Fail Code
    if chance["upgrMajorFail"] && (100-chance["upgrMajorFail"]) < r then

        item = doStuff(item,"Uncommon")

        return item, true, "Major Fail"
    elseif chance["upgrMinorFail"] && (100-chance["upgrMinorFail"]) < r then
        return nil, true, "Minor Fail"
    end

    return nil, true, "Failed"
end

VNP.Inventory:RegisterScroll(SCROLL)

--[[
    Reroll Scroll
]]--
SCROLL.Name = "Reroll Scroll"

SCROLL.Rarity = "Glitched"

SCROLL.UpgradeCost = 1000 -- Cost per rarity
SCROLL.UpgradeIncrement = 1.2 -- Price above multiplies by this increment for every rarity

SCROLL.ColorModel = true -- Whether or not to apply the rarity color to the model
SCROLL.Model = "models/props/cs_office/paper_towels.mdl"

SCROLL.Description = "Use this on an item to increase it's rarity."

SCROLL.CanEnhance = function(scroll, item)
    return true
end

SCROLL.OnEnhance = function(ply, scroll, item, gem)
    if !item then return end
    if !scroll then return end

    if VNP.Inventory:IsUpgrade(item.Type) && item.Modifiers then
        item.Modifiers = {}

        local d = VNP.Inventory:GetItemData(item.Name)

        local mods = d.Modifiers

        if mods[rarity] then
            mods = mods[rarity]
        end

        for stat,data in pairs(mods) do
            if data.min && data.max then
                item.Modifiers[stat] = math.random(data.min, data.max)
            elseif data.val then
                item.Modifiers[stat] = data.val
            end
        end
    elseif item.Rarity.Modifiers then
        item.Rarity.Modifiers = VNP.Inventory:CalcRarityMods(item, true)
    end

    return item, true, "Success"
end

VNP.Inventory:RegisterScroll(SCROLL)
--