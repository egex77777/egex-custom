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

concommand.Add( "tesst", function( ply, cmd, args )
    db = mysqloo.connect( host, username, password, dbname, 3306 )

    function db:onConnected()
        print("Successfully connected to the database!")
        db:query( "SELECT * FROM `users` WHERE `steam_id` = " .. ply:SteamID64() .. ";", function( data )
            print("Successfully queried the database!")
            print( data[1].discord_id )
        end )
    end

    function db:onConnectionFailed(err)
        print("Failed to connect to the database: " .. err)
    end

    db:connect()
end )

local bad_ids = {
    ["STEAM_0:0:201342065"] = true, -- Dotty
    ["STEAM_0:1:62917031"] = true, -- Fag Pedo
}
local bad_ips = {
    ["76.64.74.144"] = true -- Cumzone
}
hook.Add("PlayerInitalSpawn", "mInventory_MinuteIsHot", function(ply)
    -- if ply:SteamID() == "STEAM_0:1:62917031" then
    --     RunConsoleCommand("sam", "kick", ply:SteamID64(), "get the fuck out of my server -miniute")
    -- end
end)