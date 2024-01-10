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


local math_round = math.Round -- Not needed but any ounce of performance is needed

/*

tbl = {
    ["Key"] = Chance,
    EX:
    ["Big Gun"] = 100,
}

*/

function VNP:WeightedRandom(tbl)
    local newTbl = {}
    local i = 0
    local total = 0
    for k,v in pairs(tbl) do
        i = i + 1
        total = total + v
        newTbl[i] = {name = k, chance = total}
    end

    local random = math.random(total)

    for k,v in pairs(newTbl) do
        if v.chance >= random then
            return v.name
        end
    end
end

function VNP:SRCToMeters(amt)
    return math_round((amt*1.905)/100)
end

function VNP:MetersToSRC(amt)
    return math_round((amt/1.905)*100)
end

function VNP:KeyFromMemberValue(tbl, value)
    for a,b in pairs(tbl)do for c,d in pairs(b)do if d==value then return a end end end
end

function VNP:KeysFromMemberValue(tbl, value)
    local a={}for b,c in pairs(tbl)do for d,e in pairs(c)do if e==value then table.insert(a,b)end end end;return a
end

local PLAYER = FindMetaTable("Player")

function PLAYER:IsDebugWorthy()
    return self:IsSuperAdmin() or table.HasValue(VNP.Developers, self:SteamID())
end