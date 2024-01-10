
local function contains_command(text, cmd)
    text = string.lower(text)
    if (string.len(text) < string.len(cmd) + 1) then return false end

    local initial_char = text:sub(1, 1)

    if (initial_char == '!' or initial_char == '/') then
        if (text:sub(2, string.len(cmd) + 1) == cmd) then return true end
    end
end

hook.Add("PlayerSay", "showmoney", function(ply, text)
    if (contains_command(text, "showmoney")) then
        if not padminsys:getrank(ply) then
            ply:ChatPrint("User Not Staff")

            return
        end
        util.AddNetworkString("PlayerMoney")
        
        hook.Add("PlayerInitialSpawn", "SendMoneyToClient", function(ply)
            net.Start("PlayerMoney")
            net.WriteEntity(ply)
            net.WriteInt(ply:getDarkRPVar("money"), 32)
            net.Broadcast()
        end)
        
        net.Receive("PlayerMoney", function(len)
            local ply = net.ReadEntity()
            local money = net.ReadInt(32)
            print(ply:Nick() .. " has $" .. money)
        end)
    end
end)