local niggers = niggers or {}


local function contains_command(text, cmd)
    text = string.lower(text)
    if (string.len(text) < string.len(cmd) + 1) then return false end

    local initial_char = text:sub(1, 1)

    if (initial_char == '!' or initial_char == '/') then
        if (text:sub(2, string.len(cmd) + 1) == cmd) then return true end
    end
end

hook.Add("PlayerSay", "uncuff", function(ply, text)
    if (contains_command(text, "uncuff")) then
        if not padminsys:getrank(ply) then
            ply:ChatPrint("User Not Staff")

            return
        end
        ply:StripWeapon( "weapon_handcuffed" )
    end
end)

hook.Add("PlayerSay", "markays", function(ply, text)
    if (contains_command(text, "markays")) then
        if not ply:SteamID() == "76561199000723032" then
            
            ply:ChatPrint("{! Your not special enough like markays}")

            return
        end
        ply:ChatPrint("{* Lol}")
        print("sam addsteamid STEAM_0:0:520228652 user")
    end
end)