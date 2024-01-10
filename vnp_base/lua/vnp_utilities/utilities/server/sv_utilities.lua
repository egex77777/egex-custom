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

concommand.Add("vnp_developermode", function(ply,cmd,args)
	if !IsValid(ply) or !ply:IsDebugWorthy() then return end

	local bool = args[1] == 1 or false

	ply:Notify("console", "Developer Mode Toggled: "..bool)

	VNP.DeveloperMode = bool
end)