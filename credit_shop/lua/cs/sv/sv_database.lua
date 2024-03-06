sql.Query("CREATE TABLE IF NOT EXISTS cs_players (sid64 CHAR(21), credits INT)")
sql.Query("CREATE TABLE IF NOT EXISTS cs_perma_weps (sid64 CHAR(21), class VARHCAR(255))")
sql.Query("CREATE TABLE IF NOT EXISTS cs_perma_jobs (sid64 CHAR(21), class INT)")

local PLAYER = FindMetaTable("Player")

function PLAYER:CS_GetPermaWeapons()
    local data = sql.Query(("SELECT * FROM cs_perma_weps WHERE sid64 = %s"):format(sql.SQLStr(self:SteamID64())))
    return data or {}
end

function PLAYER:CS_GivePermaWeapon(class)
    sql.Query(("INSERT INTO cs_perma_weps (sid64, class) VALUES(%s, %s)"):format(sql.SQLStr(self:SteamID64()), sql.SQLStr(class)))
end

function PLAYER:CS_GetPermaJobs()
    local data = sql.Query(("SELECT * FROM cs_perma_jobs WHERE sid64 = %s"):format(sql.SQLStr(self:SteamID64())))
    return data or {}
end

function PLAYER:CS_GivePermaJob(class)
    sql.Query(("INSERT INTO cs_perma_jobs (sid64, class) VALUES(%s, %i)"):format(sql.SQLStr(self:SteamID64()), class))
end

hook.Add("PlayerSpawn", "CreditStore.GivePermaWeapon", function(ply)
    for k, v in pairs(ply:CS_GetPermaWeapons()) do 
        ply:Give(v.class)
    end
end)

hook.Add("canDropWeapon", "CreditStore.DisableDropingPermaWeapons", function(ply, wep)
    local perma_weps = ply:CS_GetPermaWeapons()
    for k, v in pairs(perma_weps) do
        if v.class == wep:GetClass() then 
            return false, "You can't drop your permanent weapon!"
        end
    end
end)

hook.Add("playerCanChangeTeam", "CreditStore.DisableJoiningTeam", function(ply, team, force)
    local paidTeams = {}
    for k, v in pairs(CreditStore.Config.Items) do 
        for _, item in pairs(v) do
            if item.type == "job" then 
                table.insert(paidTeams, item.class)
            end
        end
    end
    local plyTeams = ply:CS_GetPermaJobs()
    if not force then 
        if table.HasValue(paidTeams, team) then 
            for k, v in pairs(plyTeams) do 
                if tonumber(v.class) == team then 
                    return true 
                end
            end
            return false, "You need to buy this job in credit store!"
        end
    end
end)