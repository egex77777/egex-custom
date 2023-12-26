hook.Add("KeyPress", "CheckAFK", function(ply, key)
    if ply:IsValid() and not ply:KeyDown(IN_ATTACK) and not ply:KeyDown(IN_FORWARD) and not ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_MOVELEFT) and not ply:KeyDown(IN_MOVERIGHT) and not ply:KeyDown(IN_JUMP) then
        SetAFK(ply, true)
    else
        SetAFK(ply, false)
    end
end)

hook.Add("PlayerBindPress", "CheckAFK", function(ply, bind, pressed)
    if bind == "+jump" then
        SetAFK(ply, false)
    end
end)

hook.Add("StartCommand", "CheckAFK", function(ply, cmd)
    if cmd:GetMouseX() ~= 0 or cmd:GetMouseY() ~= 0 then
        SetAFK(ply, false)
    end
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

hook.Add("PlayerSpawn", "ResetAFK", function(ply)
    SetAFK(ply, false)
end)

hook.Add("PlayerInitialSpawn", "ResetAFK", function(ply)
    SetAFK(ply, false)
end)

util.AddNetworkString("AFKStatus")

net.Receive("AFKStatus", function(len, ply)
    local target = net.ReadEntity()
    local isAFK = net.ReadBool()

    if IsValid(target) then
        target:SetNWBool("IsAFK", isAFK)
    end
end)
