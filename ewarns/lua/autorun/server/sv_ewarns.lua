-- SERVER SIDE (sv_ewarns.lua)

if SERVER then
    util.AddNetworkString("OpenWarnMenu")
    util.AddNetworkString("OpenPlayerWarnMenu")
    util.AddNetworkString("SendPlayerWarns")
    util.AddNetworkString("DeletePlayerWarn")

    local playerWarns = {}
    local dataFileName = "player_warns.json"

    local function LoadPlayerWarns()
        local data = file.Read(dataFileName, "DATA")
    
        if data then
            playerWarns = util.JSONToTable(data) or {}
            
            for _, ply in pairs(player.GetAll()) do
                local playerID = GetPlayerID(ply)
                local warns = playerWarns[playerID] or {}
    
                net.Start("SendPlayerWarns")
                net.WriteTable(warns)
                net.Send(ply)
            end
        end
    end

    hook.Add("PlayerAuthed", "SendWarnsOnAuth", function(ply)
        local playerID = GetPlayerID(ply)
        local warns = playerWarns[playerID] or {}
    
        net.Start("SendPlayerWarns")
        net.WriteTable(warns)
        net.Send(ply)
    end)    

    local function SavePlayerWarns()
        local data = util.TableToJSON(playerWarns) or ""
        file.Write(dataFileName, data)
    end

    local function GetPlayerID(ply)
        return ply:SteamID64()
    end

    hook.Add("Initialize", "LoadPlayerWarnsOnInit", LoadPlayerWarns)
    
    -- PlayerInitialSpawn kancasını kullanarak uyarıları gönder
    hook.Add("PlayerInitialSpawn", "LoadPlayerWarnsOnSpawn", function(ply)
        local playerID = GetPlayerID(ply)
        local warns = playerWarns[playerID] or {}

        net.Start("SendPlayerWarns")
        net.WriteTable(warns)
        net.Send(ply)
    end)

    hook.Add("ShutDown", "SavePlayerWarnsOnShutdown", SavePlayerWarns)
    hook.Add("PlayerDisconnected", "SavePlayerWarnsOnDisconnect", function(ply)
        SavePlayerWarns()
    end)

    concommand.Add("warn", function(ply, cmd, args)
        local targetName = args[1]
        local targetPlayer = nil

        for _, player in pairs(player.GetAll()) do
            if string.lower(player:Nick()) == string.lower(targetName) then
                targetPlayer = player
                break
            end
        end

        if not targetPlayer then
            ply:ChatPrint("Oyuncu bulunamadı.")
            return
        end

        local playerID = GetPlayerID(targetPlayer)

        if not playerWarns[playerID] then
            playerWarns[playerID] = {}
        end

        local reason = args[2] or "Belirtilmemiş"
        local warnID = string.format("%06d", #playerWarns[playerID] + 1)

        table.insert(playerWarns[playerID], {id = warnID, reason = reason})

        ply:ChatPrint("Uyarı eklendi: " .. targetPlayer:Nick() .. " - Sebep: " .. reason)

        SavePlayerWarns()
    end)

    concommand.Add("ewarns", function(ply)
        local playerID = GetPlayerID(ply)
        local warns = playerWarns[playerID] or {}

        net.Start("SendPlayerWarns")
        net.WriteTable(warns)
        net.Send(ply)
    end)

    concommand.Add("dwarn", function(ply, cmd, args)
        local targetName = args[1]
        local warnID = args[2]

        local targetPlayer = nil

        for _, player in pairs(player.GetAll()) do
            if string.lower(player:Nick()) == string.lower(targetName) then
                targetPlayer = player
                break
            end
        end

        if not targetPlayer or not playerWarns[GetPlayerID(targetPlayer)] then
            ply:ChatPrint("Oyuncu veya uyarı bulunamadı.")
            return
        end

        for i, warn in ipairs(playerWarns[GetPlayerID(targetPlayer)]) do
            if warn.id == warnID then
                table.remove(playerWarns[GetPlayerID(targetPlayer)], i)
                ply:ChatPrint("Uyarı silindi: " .. targetPlayer:Nick() .. " - ID: " .. warnID)
                SavePlayerWarns()
                return
            end
        end

        ply:ChatPrint("Belirtilen ID'ye sahip bir uyarı bulunamadı.")
    end)

    net.Receive("OpenPlayerWarnMenu", function(_, ply)
        local targetPlayer = net.ReadEntity()

        if not IsValid(targetPlayer) then
            return
        end

        local playerID = GetPlayerID(targetPlayer)
        local warns = playerWarns[playerID] or {}

        net.Start("SendPlayerWarns")
        net.WriteTable(warns)
        net.Send(ply)
    end)
end

concommand.Add("ewarns", function(ply)
    net.Start("OpenWarnMenu")
    net.Send(ply)
end)
