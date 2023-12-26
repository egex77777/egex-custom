util.AddNetworkString("AFKStatus")

hook.Add("PlayerSpawn", "ResetAFK", function(ply)
    SetAFK(ply, false)
end)

hook.Add("PlayerInitialSpawn", "ResetAFK", function(ply)
    SetAFK(ply, false)
end)

function SetAFK(ply, isAFK)
    if ply:GetNWBool("IsAFK", false) ~= isAFK then
        ply:SetNWBool("IsAFK", isAFK)
        net.Start("AFKStatus")
        net.WriteEntity(ply)
        net.WriteBool(isAFK)
        net.Broadcast()
    end
end
