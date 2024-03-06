local FindMetaTable = FindMetaTable
local tonumber = tonumber
local sql_Query = sql.Query
local string_format = string.format
local CreditStore = CreditStore
local player_GetBySteamID64 = player.GetBySteamID64
local IsValid = IsValid
local pairs = pairs
local table_HasValue = table.HasValue
local hook_Add = hook.Add
local tobool = tobool
local concommand_Add = concommand.Add
local print = print
local DarkRP = DarkRP
local net_Start = net.Start
local net_Send = net.Send
local string_lower = string.lower

function CreditStore.SetCredits(steamid, credits)
    if tonumber(credits) < 0 then return end
    local data = sql_Query(string_format("SELECT * FROM `cs_players` WHERE `sid64` = '%s'", steamid))
	if (data) then
		sql_Query(string_format("UPDATE `cs_players` SET `credits` = '%s' WHERE `sid64` = '%s'", credits, steamid))
	else
        sql_Query(string_format("INSERT INTO `cs_players` ( sid64, credits ) VALUES('%s', '%s')", steamid, credits))
	end
end

function CreditStore.GetCredits(steamid)
   return sql_Query(string_format("SELECT `credits` FROM `cs_players` WHERE `sid64` = '%s'", steamid)) and tonumber(sql_Query(string_format("SELECT `credits` FROM `cs_players` WHERE `sid64` = '%s'", steamid))[1].credits) or 0
end

function CreditStore.AddCredits(steamid, credits)
    if credits <= 0 then return end
    CreditStore.SetCredits(steamid, CreditStore.GetCredits(steamid) + tonumber(credits))
end

function CreditStore.RemoveCredits(steamid, credits)
    if CreditStore.GetCredits(steamid) < tonumber(credits) then
    	CreditStore.SetCredits(steamid, 0)
    else
        CreditStore.SetCredits(steamid, CreditStore.GetCredits(steamid) - tonumber(credits))
   	end
end

function CreditStore.CanAfford(steamid, credits)
   return CreditStore.GetCredits(steamid) >= tonumber(credits)
end

concommand_Add("creditstore_addcredits", function(ply, cmd, args, argString) 

    if not IsValid(ply) then  
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return print("Invalid Amount") end
        CreditStore.AddCredits(targetPly, amount)
    elseif ply:IsSuperAdmin() then
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return DarkRP.notify(ply, 1, 15, "Invalid Amount") end
        CreditStore.AddCredits(targetPly, amount)
    end

end)

concommand_Add("creditstore_removecredits", function(ply, cmd, args, argString) 

    if not IsValid(ply) then  
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return print("Invalid Amount") end
        CreditStore.RemoveCredits(targetPly, amount)
    elseif ply:IsSuperAdmin() then
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return DarkRP.notify(ply, 1, 15, "Invalid Amount") end
        CreditStore.RemoveCredits(targetPly, amount)
    end

end)

concommand_Add("creditstore_setcredits", function(ply, cmd, args, argString) 

    if not IsValid(ply) then  
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return print("Invalid Amount") end
        CreditStore.SetCredits(targetPly, amount)
    elseif ply:IsSuperAdmin() then
        local targetPly = args[1]
        local amount = tonumber(args[2])
       	if amount <= 0 then return DarkRP.notify(ply, 1, 15, "Invalid Amount") end
        CreditStore.SetCredits(targetPly, amount)
    end

end)