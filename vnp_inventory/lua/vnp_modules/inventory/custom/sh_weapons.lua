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

VNP.Inventory.Items["WEAPON"] = VNP.Inventory.Items["WEAPON"] or {}

local WEAPON = {}

local WepNames = {}

function VNP.Inventory:RegisterWeapon(data)
    if !data.Name then return end

    if SERVER then
        WepNames[data.Class] = data.Name
    end

    self.Items["WEAPON"][data.Name] = data

    WEAPON = {}
end

function VNP.Inventory:InitWeapons()

    for k,v in pairs( weapons.GetList() ) do

        WEAPON = {}

        if !v.ClassName then continue end
        if CLIENT && !WepNames[v.ClassName] then continue end
        if table.HasValue(self.WeaponBlacklist, v.ClassName) then continue end

        WEAPON.Name = CLIENT && WepNames[v.ClassName] or v.PrintName or v.ClassName

        WEAPON.Class = v.ClassName

        WEAPON.Model = v.WorldModel or "models/weapons/w_smg1.mdl"

        WEAPON.Modifiers = {}

        if !table.HasValue(self.WeaponWhitelist, v.ClassName) then
            if (v.Category ~= "CS:GO Knives") && (!v.Primary.Damage or v.Primary.Damage == 0) then continue end
            //if !v.Primary.Recoil && !v.Primary.KickUp then continue end
            //if !v.Primary.ClipSize or v.Primary.ClipSize == 0 then continue end
        end

        for stat, val in pairs(v.Primary) do
            if !isnumber(val) then continue end

            WEAPON.Modifiers[stat] = val
        end

        WEAPON.UseFunctions = {}
        
        WEAPON.UseFunctions["Equip"] = function(ply, item)
            if !SERVER then return end

            if ply:HasWeapon(v.ClassName) then return end

            local wep = ply:Give(v.ClassName)

            wep:SetItemData(item)

            ply:SelectWeapon(v.ClassName)

            local data = wep:GetItemData()
            LSkins:SetSkin(wep, data.LSkins or "")

            return true
        end

        self:RegisterWeapon(WEAPON)
    end
end

if SERVER then
    hook.Add( "InitPostEntity", "VNP.InitPostEntity", function()
        VNP.Inventory:InitWeapons()
    end)

    hook.Add("PlayerInitialSpawn", "VNP.SyncWeapons", function()
        VNP:Broadcast("VNP.SyncWeapons", {tbl = WepNames})
    end)

    VNP.Inventory:InitWeapons()
    timer.Simple(5, function()
        VNP:Broadcast("VNP.SyncWeapons", {tbl = WepNames})
    end)
else
    VNP:AddNetworkString("VNP.SyncWeapons", function(ply, data)
        local weps = data.tbl

        if !weps then return end

        WepNames = weps
    
        VNP.Inventory:InitWeapons()
    end)
end