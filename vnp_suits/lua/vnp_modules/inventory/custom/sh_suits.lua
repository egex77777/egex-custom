VNP.Inventory.Items["SUIT"] = VNP.Inventory.Items["SUIT"] or {}

local SUIT = {}

function VNP.Inventory:RegisterSuit(data)
    if not data.Name then return end

    if not SUIT.Model then
        SUIT.Model = "models/Items/item_item_crate.mdl"
    end
    
    SUIT.UseFunctions = SUIT.UseFunctions or {}

    SUIT.UseFunctions["Equip"] = function(ply, item, skins)
        if not SERVER then return end
        local suit = ply:GetSuit()

        if suit then return end

        if item.LSkins ~= "" and item.LSkins ~= nil then
            ply.LSkins = item.LSkins
        end

        ply:SetMaterial(ply.LSkins or "")
        ply:SetSuit(item)

        if ply.LSkins and ply.LSkins ~= "" then
            ply:SetMaterial(ply.LSkins)
        end
        
        return true
    end

    self.Items["SUIT"][data.Name] = data
    
    if SERVER then
        if data.Hooks then
            for name, func in pairs(data.Hooks) do
                hook.Add(name, "VNP.Inventory."..data.Name, func)
            end
        end
    end

    SUIT = {}
end


--[[
    Tier 1
]]--

SUIT.Name = "Tier 1"

SUIT.SuitModel = "models/auditor/r6s/rook/chr_gign_lifeline_ash_engset.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 100},
    ["SuitArmor"] = {val = 350},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitArrestHits"] = {min = 1, max = 2},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier 2
]]--

SUIT.Name = "Tier 2"

SUIT.SuitModel = "models/arachnit/csgoheavyphoenix/tm_phoenix_heavyplayer.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 500},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 35, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"1] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier 3
]]--

SUIT.Name = "Tier 3"

SUIT.SuitModel = "models/kryptonite/inf_war_machine/inf_war_machine.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 800},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 50, chance = 100},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier 4
]]--

SUIT.Name = "Tier 4"

SUIT.SuitModel = "models/models/frix/x01/xo1_powerarmor.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 1000},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 55, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier 5
]]--

SUIT.Name = "Tier 5"

SUIT.SuitModel = "models/mailer/characters/blackknight.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 3000},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 60, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Horror Suit
]]--

SUIT.Name = "Horror Suit"

SUIT.SuitModel = "models/splinks/jeff_the_killer/jeff.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 100},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 60, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Horror Suit Tier 2
]]--

SUIT.Name = "Horror Suit Tier 2"

SUIT.SuitModel = "models/player/scp096.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 500},
    ["SuitArmor"] = {val = 250},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 65, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Horror Suit Tier 3
]]--

SUIT.Name = "Horror Suit Tier 3"

SUIT.SuitModel = "models/siren_head_player_jq1991.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 100},
    ["SuitArmor"] = {val = 350},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 65, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier God
]]--

SUIT.Name = "Tier God"

SUIT.SuitModel = "models/kryptonite/inf_thanos/inf_thanos.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 10000},
    ["SuitArmor"] = {val = 450},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 60, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 200},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 205},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 210},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 210},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 230},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 245},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier Ultra God
]]--

SUIT.Name = "Tier Ultra God"

SUIT.SuitModel = "models/epangelmatikes/mtu/mtultimate.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 25000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 100, chance = 100},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 99, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 175},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 180},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 190},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 201},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 99, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier Fallen God
]]--

SUIT.Name = "Tier Fallen God"

SUIT.SuitModel = "models/mailer/characters/cordana.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 35000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 60, chance = 10},
    ["SuitEnergyResist"] = {chance = 15},
    ["SuitArrestHits"] = {chance = 25},
    ["SuitJump"] = {chance = 25},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 200},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 225},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
       ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 230},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
       ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 240},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 245},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 255},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        ["SuitEnergyResist"] = {min = 1, max = 5},
        ["SuitArrestHits"] = {min = 1, max = 3},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Tier God Slayer
]]--

SUIT.Name = "Tier God Slayer"

SUIT.SuitModel = "models/reverse/ironman_endgame/ironman_endgame.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 45000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 60, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Flash Suit
]]--

SUIT.Name = "Flash Suit"

SUIT.SuitModel = "models/reverse/playermodels/futureflash/futureflash.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 20000},
    //["SuitArmor"] = {val = 0},
    ["SuitRegen"] = {chance = 50},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 300, chance = 100},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        //["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 200},
        //["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 225},
        //["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 230},
        //["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 240},
        //["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 245},
        //["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        //["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 225, max = 300},
        //["SuitArmor"] = {min = 250, max = 500},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 500},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Resistances = { -- Damage types and weapons this weapon is resistant to
    [DMG_FALL] = 0, -- resistant amount in %
    ["weapon_gblaster"] = 100, -- resistant amount in %
    ["weapon_gblaster_asriel_rainbow"] = 100, -- resistant amount in %
    ["weapon_gblaster_pistol"] = 100, -- resistant amount in %
    ["weapon_bm_ams"] = 100, -- resistant amount in %
    ["weapon_supreme_badtime_bm_gblaster"] = 100, -- resistant amount in %
    ["weapon_bm_rifle"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_nonadmin"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_admin"] = 100, -- resistant amount in %    
    ["weapon_bms_gluon"] = 80, -- resistant amount in %
    ["weapon_ginseng_railgun"] = 100, -- resistant amount in %
    ["weapon_plasmanadelauncher"] = 100, -- resistant amount in %
    ["weapon_plasmagrenade"] = 100, -- resistant amount in %
    ["weapon_ginseng_adminrailgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_beamgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_babyrailgun"] = 100, -- resistant amount in %
    ["weapon_nrgbeam"] = 100, -- resistant amount in %
    ["weapon_nrgbeam_admin"] = 100, -- resistant amount in %
    ["inferno_blue"] = 100, -- resistant amount in %
    ["inferno"] = 100, -- resistant amount in %
    ["weapon_lasrifle_ig_fix"] = 100, -- resistant amount in %
    ["x-8"] = 100, -- resistant amount in %
    ["ryry_m134"] = 15, 
    ["nz_wunderwaffe"] = 100, -- resistant amount in %
    ["awpdragon"] = 100, -- resistant amount in %
}
SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Admin Suit
]]--

SUIT.Name = "Admin Suit"

SUIT.SuitModel = "models/player/Combine_Super_Soldier.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 10000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 200},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 225},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 230},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 240},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 245},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 100},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 225, max = 300},
        ["SuitArmor"] = {min = 250, max = 500},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 500},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Resistances = { -- Damage types and weapons this weapon is resistant to
    [DMG_FALL] = 0, -- resistant amount in %
    ["weapon_gblaster"] = 100, -- resistant amount in %
    ["weapon_gblaster_asriel_rainbow"] = 100, -- resistant amount in %
    ["weapon_gblaster_pistol"] = 100, -- resistant amount in %
    ["weapon_bm_ams"] = 100, -- resistant amount in %
    ["weapon_supreme_badtime_bm_gblaster"] = 100, -- resistant amount in %
    ["weapon_bm_rifle"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_nonadmin"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_admin"] = 100, -- resistant amount in %    
    ["weapon_bms_gluon"] = 80, -- resistant amount in %
    ["weapon_ginseng_railgun"] = 100, -- resistant amount in %
    ["weapon_plasmanadelauncher"] = 100, -- resistant amount in %
    ["weapon_plasmagrenade"] = 100, -- resistant amount in %
    ["weapon_ginseng_adminrailgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_beamgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_babyrailgun"] = 100, -- resistant amount in %
    ["weapon_nrgbeam"] = 100, -- resistant amount in %
    ["weapon_nrgbeam_admin"] = 100, -- resistant amount in %
    ["inferno_blue"] = 100, -- resistant amount in %
    ["inferno"] = 100, -- resistant amount in %
    ["weapon_lasrifle_ig_fix"] = 100, -- resistant amount in %
    ["x-8"] = 100, -- resistant amount in %
    ["ryry_m134"] = 15, 
    ["nz_wunderwaffe"] = 100, -- resistant amount in %
    ["awpdragon"] = 100, -- resistant amount in %
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Admin Suit V2
]]--

SUIT.Name = "Admin Suit V2"

SUIT.SuitModel = "models/player/police.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 50000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 20},
    ["SuitResist"] = {chance = 20},
    ["SuitSpeed"] = {chance = 100},
    ["SuitEnergyResist"] = {chance = 100},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        --["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 5, max = 50},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        --["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 10, max = 75},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 100},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 120},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 145},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 165},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 1, max = 10},
        --["SuitResist"] = {min = 1, max = 10},
        ["SuitSpeed"] = {min = 40, max = 250},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 275, max = 300},
        ["SuitArmor"] = {min = 275, max = 300},
        ["SuitRegen"] = {min = 2, max = 12},
        ["SuitResist"] = {min = 2, max = 12},
        ["SuitSpeed"] = {min = 50, max = 450},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Resistances = { -- Damage types and weapons this weapon is resistant to
    [DMG_FALL] = 100, -- resistant amount in %
    ["weapon_gblaster"] = 100, -- resistant amount in %
    ["weapon_gblaster_asriel_rainbow"] = 100, -- resistant amount in %
    ["weapon_gblaster_badtime"] = 100, -- resistant amount in %
    ["weapon_gblaster_pistol"] = 100, -- resistant amount in %
    ["weapon_bm_ams"] = 100, -- resistant amount in %
    ["weapon_supreme_badtime_bm_gblaster"] = 100, -- resistant amount in %
    ["weapon_bm_rifle"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_nonadmin"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_admin"] = 100, -- resistant amount in %    
    ["weapon_bms_gluon"] = 80, -- resistant amount in %
    ["weapon_ginseng_railgun"] = 100, -- resistant amount in %
    ["weapon_plasmanadelauncher"] = 100, -- resistant amount in %
    ["weapon_plasmagrenade"] = 100, -- resistant amount in %
    ["weapon_ginseng_adminrailgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_beamgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_babyrailgun"] = 100, -- resistant amount in %
    ["weapon_nrgbeam"] = 100, -- resistant amount in %
    ["weapon_nrgbeam_admin"] = 100, -- resistant amount in %
    ["inferno_blue"] = 100, -- resistant amount in %
    ["inferno_purple"] = 100, -- resistant amount in %
    ["inferno"] = 100, -- resistant amount in %
    ["weapon_lasrifle_ig_fix"] = 100, -- resistant amount in %
    ["x-8"] = 100, -- resistant amount in %
    ["ryry_m134"] = 15, -- resistant amount in %
    ["amr11"] = 15, -- resistant amount in %
    ["nz_wunderwaffe"] = 100, -- resistant amount in %
    ["awpdragon"] = 100, -- resistant amount in %
}

local stuckDelay = 0
local offset = Vector(2,2,2)


SUIT.Hooks = { // Aids but works
    ["PhysgunPickup"] = function(ply, ent)
        if !ent:IsPlayer() then return end
        if !IsValid(ply) then return end
        if ent._V2PickedUp then return end
        if table.HasValue(VNP.Inventory.StaffRanks, ply:GetUserGroup()) then return end
        local suit = ply:GetSuit()

        if !suit then return end
        if suit.Name ~= "Admin Suit V2" then return end
        
        ent:SetCollisionGroup(COLLISION_GROUP_PLAYER)
        ent:SetMoveType(MOVETYPE_NONE)
        ent._V2PickedUp = ply 

        return true
    end,
    ["PhysgunDrop"] = function(ply, ent)
        if !ent:IsPlayer() then return end
        if !IsValid(ply) then return end
        if table.HasValue(VNP.Inventory.StaffRanks, ply:GetUserGroup()) then return end
        local suit = ply:GetSuit()

        if !suit then return end
        if suit.Name ~= "Admin Suit V2" then return end
        
        ent:Freeze(false)
        ent:SetMoveType(MOVETYPE_WALK)
        ent:RemoveEFlags(FL_FROZEN)
        ent:UnLock()
        
        ent._V2PickedUp = false
         timer.Simple(0.001, function()
			ent:UnLock()
        end)
    end,
    ["Think"] = function()
        if CurTime() < stuckDelay then return end
        stuckDelay = CurTime() + 0.1
        
        for i,ply in ipairs(player.GetAll()) do
            if !ply._V2PickedUp then continue end

            for _,ent in pairs(ents.FindInBox(ply:GetPos()+ply:OBBMins()+offset, ply:GetPos()+ply:OBBMaxs()-offset)) do
                if IsValid(ent) && ply ~= ent && ent:GetClass() == "prop_physics" && ply._V2PickedUp then
                    ply:Freeze(false)
                    ply:SetMoveType(MOVETYPE_WALK)
                    ply:RemoveEFlags(FL_FROZEN)
                    ply:UnLock()
                    ply:SetPos(VNP.Inventory.SpawnLocation or Vector(0,0,0))

                    if IsValid(ply._V2PickedUp) && ply._V2PickedUp:IsPlayer() && ply._V2PickedUp.SetActiveWeapon then 
                        ply._V2PickedUp:SetActiveWeapon(NULL)
                    end

                    ply._V2PickedUp = nil
                    
                    break
                end
            end
        end
    end
} // If ya want any hooks-- fixed by cum zone 

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Godly Armour
]]--

SUIT.Name = "Godly Armour"

SUIT.SuitModel = "models/player/alyx.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 1000},
    ["SuitArmor"] = {val = 500},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Santa Suit
]]--

SUIT.Name = "Santa Suit"

SUIT.SuitModel = "models/player/christmas/santa.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 10000},
    ["SuitArmor"] = {val = 5000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Elf Suit
]]--

SUIT.Name = "Elf Suit"

SUIT.SuitModel = "models/tsbb/elf.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 5000},
    ["SuitArmor"] = {val = 2500},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 100, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)

--[[
    Compensation Suit
]]--

SUIT.Name = "Compensation Suit"

SUIT.SuitModel = "models/mailer/characters/wow_doomguard.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 50000},
    ["SuitArmor"] = {val = 5000},
    ["SuitRegen"] = {chance = 10},
    ["SuitResist"] = {chance = 10},
    ["SuitSpeed"] = {val = 300, chance = 10},
    ["SuitEnergyResist"] = {chance = 10},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        ["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 0, max = 5},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        ["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 5, max = 10},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 15},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 15, max = 20},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 25},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 30},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 35},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 250, max = 300},
        ["SuitArmor"] = {min = 250, max = 300},
        ["SuitRegen"] = {min = 4, max = 5},
        ["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 35, max = 40},
        //["SuitEnergyResist"] = {min = 0, max = 0},
        //["SuitArrestHits"] = {min = 0, max = 0},
        //["SuitJump"] = {min = 0, max = 0},
    },
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)



SUIT.Name = "Bp1 Freezer"

SUIT.SuitModel = "models/ceilciuz/zlorg/zlorg_pm.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 50000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 20},
    ["SuitResist"] = {chance = 20},
    ["SuitSpeed"] = {chance = 100},
    ["SuitEnergyResist"] = {chance = 100},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        --["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 5, max = 50},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        --["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 10, max = 75},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 100},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 120},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 145},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 165},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 1, max = 10},
        --["SuitResist"] = {min = 1, max = 10},
        ["SuitSpeed"] = {min = 40, max = 250},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 275, max = 300},
        ["SuitArmor"] = {min = 275, max = 300},
        ["SuitRegen"] = {min = 2, max = 12},
        ["SuitResist"] = {min = 2, max = 12},
        ["SuitSpeed"] = {min = 100, max = 1000},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        ["SuitJump"] = {min = 5, max = 10},
    },
}

SUIT.Resistances = { -- Damage types and weapons this weapon is resistant to
    [DMG_FALL] = 100, -- resistant amount in %
    ["weapon_gblaster"] = 100, -- resistant amount in %
    ["weapon_gblaster_asriel_rainbow"] = 100, -- resistant amount in %
    ["weapon_gblaster_pistol"] = 100, -- resistant amount in %
    ["weapon_bm_ams"] = 100, -- resistant amount in %
    ["weapon_supreme_badtime_bm_gblaster"] = 100, -- resistant amount in %
    ["weapon_bm_rifle"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_nonadmin"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_admin"] = 100, -- resistant amount in %    
    ["weapon_bms_gluon"] = 100, -- resistant amount in %
    ["weapon_ginseng_railgun"] = 100, -- resistant amount in %
    ["weapon_plasmanadelauncher"] = 100, -- resistant amount in %
    ["weapon_plasmagrenade"] = 100, -- resistant amount in %
    ["weapon_ginseng_adminrailgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_beamgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_babyrailgun"] = 100, -- resistant amount in %
    ["weapon_nrgbeam"] = 100, -- resistant amount in %
    ["weapon_nrgbeam_admin"] = 100, -- resistant amount in %
    ["inferno_blue"] = 100, -- resistant amount in %
    ["inferno"] = 100, -- resistant amount in %
    ["weapon_lasrifle_ig_fix"] = 100, -- resistant amount in %
    ["x-8"] = 100, -- resistant amount in %
    ["ryry_m134"] = 30, 
    ["nz_wunderwaffe"] = 100, -- resistant amount in %
    ["awpdragon"] = 100, -- resistant amount in %
    ["weapon_glock2"] = 99, -- resistant amount in %
    ["clt_glck18_cda"] = 90, -- resistant amount in %
    ["awpdragon"] = 100, 
    ["ls_sniper"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, -- resistant amount in %    
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)


SUIT.Name = "Bp1 Speed"

SUIT.SuitModel = "models/ceilciuz/zlorg/zlorg_pm.mdl"

SUIT.RepairCost = 1000

SUIT.BaseModifiers = {
    ["SuitHealth"] = {val = 50000},
    ["SuitArmor"] = {val = 1000},
    ["SuitRegen"] = {chance = 20},
    ["SuitResist"] = {chance = 20},
    ["SuitSpeed"] = {chance = 100},
    ["SuitEnergyResist"] = {chance = 100},
    //["SuitArrestHits"] = {chance = 10},
    //["SuitJump"] = {chance = 10},
}

SUIT.Modifiers = { // the modifiers per rarity if there is no base value for a modifier it will use the below otherwise its a % multiplier
    ["Common"] = {
        ["SuitHealth"] = {min = 0, max = 100},
        ["SuitArmor"] = {min = 0, max = 100},
        ["SuitRegen"] = {min = 1, max = 2},
        --["SuitResist"] = {min = 1, max = 2},
        ["SuitSpeed"] = {min = 5, max = 50},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Uncommon"] = {
        ["SuitHealth"] = {min = 100, max = 125},
        ["SuitArmor"] = {min = 100, max = 125},
        ["SuitRegen"] = {min = 3, max = 4},
        --["SuitResist"] = {min = 3, max = 4},
        ["SuitSpeed"] = {min = 10, max = 75},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Rare"] = {
        ["SuitHealth"] = {min = 125, max = 150},
        ["SuitArmor"] = {min = 125, max = 150},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 20, max = 100},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Epic"] = {
        ["SuitHealth"] = {min = 150, max = 175},
        ["SuitArmor"] = {min = 150, max = 175},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 25, max = 120},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Legendary"] = {
        ["SuitHealth"] = {min = 175, max = 200},
        ["SuitArmor"] = {min = 175, max = 200},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 30, max = 145},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Celestial"] = {
        ["SuitHealth"] = {min = 200, max = 225},
        ["SuitArmor"] = {min = 200, max = 225},
        ["SuitRegen"] = {min = 4, max = 5},
        --["SuitResist"] = {min = 4, max = 5},
        ["SuitSpeed"] = {min = 10, max = 165},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["God"] = {
        ["SuitHealth"] = {min = 225, max = 250},
        ["SuitArmor"] = {min = 225, max = 250},
        ["SuitRegen"] = {min = 1, max = 10},
        --["SuitResist"] = {min = 1, max = 10},
        ["SuitSpeed"] = {min = 40, max = 250},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        --["SuitJump"] = {min = 0, max = 0},
    },
    ["Glitched"] = {
        ["SuitHealth"] = {min = 275, max = 300},
        ["SuitArmor"] = {min = 275, max = 300},
        ["SuitRegen"] = {min = 2, max = 12},
        ["SuitResist"] = {min = 2, max = 12},
        ["SuitSpeed"] = {min = 100, max = 1000},
        --["SuitEnergyResist"] = {min = 0, max = 0},
        --["SuitArrestHits"] = {min = 0, max = 0},
        ["SuitJump"] = {min = 5, max = 10},
    },
}

SUIT.Resistances = { -- Damage types and weapons this weapon is resistant to
    [DMG_FALL] = 100, -- resistant amount in %
    ["weapon_gblaster"] = 100, -- resistant amount in %
    ["weapon_gblaster_asriel_rainbow"] = 100, -- resistant amount in %
    ["weapon_gblaster_pistol"] = 100, -- resistant amount in %
    ["weapon_bm_ams"] = 100, -- resistant amount in %
    ["weapon_supreme_badtime_bm_gblaster"] = 100, -- resistant amount in %
    ["weapon_bm_rifle"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_nonadmin"] = 100, -- resistant amount in %
    ["weapon_bm_rifle_admin"] = 100, -- resistant amount in %    
    ["weapon_bms_gluon"] = 100, -- resistant amount in %
    ["weapon_ginseng_railgun"] = 100, -- resistant amount in %
    ["weapon_plasmanadelauncher"] = 100, -- resistant amount in %
    ["weapon_plasmagrenade"] = 100, -- resistant amount in %
    ["weapon_ginseng_adminrailgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_beamgun"] = 100, -- resistant amount in %
    ["weapon_ginseng_babyrailgun"] = 100, -- resistant amount in %
    ["weapon_nrgbeam"] = 100, -- resistant amount in %
    ["weapon_nrgbeam_admin"] = 100, -- resistant amount in %
    ["inferno_blue"] = 100, -- resistant amount in %
    ["inferno"] = 100, -- resistant amount in %
    ["weapon_lasrifle_ig_fix"] = 100, -- resistant amount in %
    ["x-8"] = 100, -- resistant amount in %
    ["ryry_m134"] = 30, 
    ["nz_wunderwaffe"] = 100, -- resistant amount in %
    ["awpdragon"] = 100, -- resistant amount in %
    ["weapon_glock2"] = 99, -- resistant amount in %
    ["clt_glck18_cda"] = 90, -- resistant amount in %
    ["awpdragon"] = 100, 
    ["ls_sniper"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, 
    ["awpdragon"] = 100, -- resistant amount in %    
}

SUIT.Hooks = {} // If ya want any hooks

VNP.Inventory:RegisterSuit(SUIT)