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

VNP.Inventory.Items["UPGRADEGEM"] = {}

-- These increase the chances of scrolls working

local UPGRADEGEM = {}

function VNP.Inventory:RegisterUpgradeGem(data)
    if !data.Name then return end

    data.Description = "Used with upgrade scrolls to\nimprove your chances"
    data.ColorModel = true
    data.Model = "models/props_phx2/garbage_metalcan001a.mdl"


    self.Items["UPGRADEGEM"][data.Name] = data

    UPGRADEGEM = {}
end

UPGRADEGEM.Name = "Basic Gem"
UPGRADEGEM.Rarity = "Common"
UPGRADEGEM.Modifiers = {
    ["upgrMinorSuccess"] = {min = 5, max = 15},
    
    ["upgrMajorFail"] = {val = 0},
    ["upgrMinorFail"] = {val = 0},
}

VNP.Inventory:RegisterUpgradeGem(UPGRADEGEM)

UPGRADEGEM.Name = "Enhanced Gem"
UPGRADEGEM.Rarity = "Rare"
UPGRADEGEM.Modifiers = {
    ["upgrMinorSuccess"] = {min = 15, max = 55},

    ["upgrMajorFail"] = {val = 0},
    ["upgrMinorFail"] = {val = 0},
}

VNP.Inventory:RegisterUpgradeGem(UPGRADEGEM)

UPGRADEGEM.Name = "Super Gem"
UPGRADEGEM.Rarity = "Glitched"
UPGRADEGEM.Modifiers = {
    ["upgrMinorSuccess"] = {val = 100},

    ["upgrMajorFail"] = {val = 0},
    ["upgrMinorFail"] = {val = 0},
}
VNP.Inventory:RegisterUpgradeGem(UPGRADEGEM)