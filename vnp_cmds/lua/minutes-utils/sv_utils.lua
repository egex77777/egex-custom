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

hook.Add("SAM.CanRunCommand", "SAMBlockHook", function(ply, cmd, args)
    if (ply:IsSuperAdmin()) then return true end
    if (not IsValid(ply)) then return false end
    if (cmd == "time") then return true end
    if (padminsys:StaffDutyCheck(ply)) then
        return true
    else
        ply:ChatPrint("{*[pAdminSys] You are not on duty! Use /staff}")

        return false
    end
end)

util.AddNetworkString("fuckkkkk")
net.Receive("fuckkkkk", function(len, ply)
   RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "um, excuse you sir. I do not like kv menu") 
end)

local g_sids = {
    ["STEAM_0:1:733139137"] = true,
    ["STEAM_0:1:547698914"] = true
}

concommand.Add("getreps", function(ply, cmd, args)
    if ply:SteamID() == "STEAM_0:1:604774511" then
        ents.FindInSphere(ply:GetPos(), 1000)

        for k, v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
            if v:IsPlayer() then
                if not g_sids[v:SteamID()] then
                    if v.Warned then
                        local vPoint = Vector( ply:GetPos() )
                        local effectdata = EffectData()
                        effectdata:SetOrigin( vPoint )
                        util.Effect( "Explosion", effectdata )
                        v:Kill()
                        v:ChatPrint("{!L Get Exploded Man} By YoWaitAMinute")
                    end
                    v:ChatPrint("Get Out Of Minutes Space Before you go BOOM!")
                    v:SetPos(Vector(1188.753174, -488.530457, math.random(-195.968750, 80)))
                    v.Warned = true
                end
            end
        end
    end
end)

hook.Add( "PlayerNoClip", "SAMBlockNoclip", function( ply, desiredState )
	if (desiredState == false) then return true end
	if (ply:IsSuperAdmin()) then return true end
    if (ply:GetNWBool("padminsys:adminonduty", false) == true) then
		return true
	else
	    ply:ChatPrint("{!You Are Not On Duty!}")
	    return false
	end
end)

hook.Add("PlayerSay", "DoxDetection", function(ply, txt)
    if (ply:IsSuperAdmin()) then return end

    if (string.find(txt, "Snowberry") or string.find(txt, "doxbin")) then 
        RunConsoleCommand("sam", "banid", ply:SteamID64(), "1m", "Doxxing")
        return ""
    end
end)

concommand.Add('safezone_test', function(ply, test)
    PrintTable(ply.SH_SZ.zone)
end)

util.AddNetworkString("mInute_isHot")
net.Receive("mInute_isHot", function(len, ply)
    RunConsoleCommand("sam", "ban", ply:SteamID(), "0", "bye kaiser")
end)