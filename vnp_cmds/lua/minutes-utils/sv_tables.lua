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

skins = {
    ["Aquarium3"] = "models/skins/aquarium3",
    ["Artsy"] = "models/skins/artsy",
    ["Bass"] = "models/skins/bass",
    ["Collisions"] = "models/skins/collisions",
    ["Cracked"] = "models/skins/cracked",
    ["Dance"] = "models/skins/dance",
    ["Disco"] = "models/skins/disco",
    ["Doughnut"] = "models/skins/doughnut",
    ["Glitched"] = "models/skins/glitched",
    ["Lightshow"] = "models/skins/lightshow",
    ["Liquid"] = "models/skins/liquid",
    ["Pulse"] = "models/skins/pulse",
    ["Rainbowdrops"] = "models/skins/rainbowdrops",
    ["Rearranged"] = "models/skins/rearranged",
    ["Shaped"] = "models/skins/shaped",
    ["Sketchy"] = "models/skins/sketchy",
    ["Smallone2"] = "models/skins/smallone2",
    ["Splotches"] = "models/skins/splotches",
    ["Trippy"] = "models/skins/trippy",
    ["Warped"] = "models/skins/warped",
    ["Waves"] = "models/skins/waves",
    ["Wobble"] = "models/skins/wobble",
    ["Elite"] = "models/skins/elite5",
    ["Lethal"] = "models/skins/lethal5",
    ["Nosharp"] = "models/skins/nosharp3",
    ["Simper"] = "models/skins/simpking2",
    ["Boomer"] = "models/skins/bomer5"
}

local vip_ranks = {
    ["Server Backer"] = true,
    ["vip"] = true,
    ["superadmin"] = true,
    ["t-staff-vip"] = true,
    ["operator-vip"] = true,
    ["admin-vip"] = true,
    ["moderator-vip"] = true,
}

function VIPCheck(ply)
   if string.find(string.lower(ply:GetUserGroup()), "vip") or string.find(string.lower(ply:GetUserGroup()), "backer") or string.find(ply:GetUserGroup(), "superadmin") or string.find(ply:GetUserGroup(), "user+") then
       return true
    end
end


function PrinterCheck(ply)
    if (not ply.printers) then ply.printers = {} return false end

    for k, ent in pairs(ply.printers) do
        if (not ent:IsValid()) then
            table.remove(ply.printers, k)
        end
    end
    if (#ply.printers >= 5) then return true end
end

hook.Add("PlayerSay", "VIPPrinter", function(ply, text)
    if (text == "!vipprinter") then
        if (PrinterCheck(ply)) then ply:ChatPrint("{!You Have Too Many Printers!}") return end
        if (VIPCheck(ply)) then
            local ent = ents.Create("printer_rack")
            if (IsValid(ent)) then
                ent:SetPos(ply:GetEyeTrace().HitPos + Vector(0,0,20))
                ent:SetOwner(ply)
                ent:Spawn()
                table.insert(ply.printers, ent)
                print(ent:GetOwner())
            end
        end
    end
end)

hook.Add( "PlayerDisconnected", "PrinterPlyDisconnect", function(ply)
    if (not ply.printers) then ply.printers = {} return end

    for k, ent in pairs(ply.printers) do 
        if (ent:IsValid()) then
            ent:Remove()
        end
    end
end)

local bad_weps = {
    ["weapon_bm_ams"] = true,
    ["weapon_nrgbeam_admin"] = true,
    ["god_lockpick"] = true,
    ["m9k_davy_crockett"] = true
}
function minuteabuselogs(msg)
    http.Post("https://yowaitaminute.xyz/relays/relay.php", {
        title = "[FlexRP] Abuse Logs",
        bar_color = "#FF8C00",
        url = "https://discord.com/api/webhooks/1084613873132376124/wB48VWnMGJ3TuJ-PN3AfEouSRjtMu4c8xG-B5qcxriEmP6TVqhbfcWl7dP6u9Xsncx3o",
        body = msg
    }, function(r)
        print(r)
    end, function(e)
        print(e)
    end)
end
hook.Add( "WeaponEquip", "minutesabusertect", function( weapon, ply )
	timer.Simple( 0, function()
		if not IsValid( weapon ) then return end
        if bad_weps[weapon:GetClass()] then 
                ply:StripWeapon( weapon:GetClass() )
                -- if not ply:SteamID() == "STEAM_0:1:733139137" then
                RunConsoleCommand("sam", "banid", ply:SteamID(), "0", "[mAntiAbuse] Abuse of weapon: " .. weapon:GetClass())
                minuteabuselogs("[mAntiAbuse] " .. ply:Nick() .. " Was abusing " .. ply:SteamID() .. " Weapon: " .. weapon:GetClass())
            return 
        end
	end )
end )