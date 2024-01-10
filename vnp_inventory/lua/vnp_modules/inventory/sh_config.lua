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

-- 5x12 inventory slots
VNP.Inventory.SlotsY = 5 -- Number of slots going down
VNP.Inventory.SlotsX = 12 -- Number of slots going right

VNP.Inventory.SlotSize = 70

VNP.Inventory.ItemDeletion = 120 -- Time it takes for a dropped item to delete

VNP.Inventory.Pages = { -- The config for buying pages for the inventory (increases inventory size)
    [1] = 0,
    [2] = 150000,
    [3] = 300000,
    [4] = 600000,
    [5] = 1200000,
    [6] = 2400000,
}

VNP.Inventory.GemSlotUpgrades = { -- Price to socket a gem in these slots on an item
    [1] = 5000,
    [2] = 15000,
    [3] = 30000,
    [4] = 50000,
}
VNP.Inventory.GemSlotUnsocket = 120 -- 120% of the slot price to unsocket a gem
VNP.Inventory.GemSlotIncrement = 5000 -- If there isn't a value above for the specified socket it will use this increment socket number * this value

VNP.Inventory.EnergyWeapons = { -- Put classes of energy weapons here
    "weapon_gblaster",
    "weapon_gblaster_asriel_rainbow",
    "weapon_gblaster_badtime",
    "weapon_gblaster_pistol",
    "weapon_supreme_badtime_bm_gblaster",
    "weapon_bm_rifle",
    "weapon_bm_rifle_nonadmin",
    "weapon_bm_rifle_admin",
    "weapon_ginseng_babyrailgun",
    "weapon_ginseng_beamgun",
    "weapon_ginseng_adminrailgun",
    "weapon_ginseng_railgun",
    "weapon_nrgbeam",
    "inferno_blue",
    "inferno_purple",
    "inferno",
}

VNP.Inventory.GemBlacklist = {
    ["weapon_gblaster"] = {
        "Overload",
    },

    ["weapon_bm_rifle"] = {
        "Freeze",
    },
}

VNP.Inventory.WeaponWhitelist = { -- Weapons that you cant invholster normally
    "weapon_banhammer",
    "weapon_asmd",
    "riot_shield",
    "heavy_shield",
    "blue_gaster",
    "shared",
    "stungun_new",
    "weapon_ginseng_babyrailgun",
    "weapon_ginseng_beamgun",
    "weapon_ginseng_adminrailgun",
    "weapon_plasmagrenade",
    "weapon_plasmanadelauncher",
    "weapon_ginseng_railgun",
    "weapon_cuff_elastic",
    "weapon_cuff_police",
    "weapon_hpwr_stick",
    "noxious_trap",
    "weapon_mastersword",
    "weapon_camo",
    "weapon_jackhammer",
    "weapon_radar",
    "weapon_freezeray",
    "weapon_hexshield",
    "weapon_nrgbeam",
    "inferno_blue",
    "inferno_purple",
    "inferno",
    "weapon_lightsaber",
    "weapon_sh_detector",
    "weapon_sh_keypadcracker_deploy",
    "x-8",
    "broken_lockpick",
    "factory_lockpick",
    "god_lockpick",
    "rusty_lockpick",
    "staff_lockpick",
    "weapon_grapplehook",
    "weapon_thrusterpack",
    "trap_placer",
    "cp_flaregun",
    "zwf_bong01",
    "zwf_bong03",
    "zwf_bong02",
    "weapon_flechettegun",
    "deployable_shield",
    "weapon_vape_mega",
}

VNP.Inventory.WeaponBlacklist = {
    "weapon_lightsaber",
    "weapon_grapplehook", 
    "weapon_gblaster_fake", 
    "weapon_bm_rifle_nonadmin",
    "m9k_dbarrel",
    "vincent1911",
}

VNP.Inventory.SpawnLocation = Vector(1014,-401,-71)
VNP.Inventory.StaffRanks = {

}