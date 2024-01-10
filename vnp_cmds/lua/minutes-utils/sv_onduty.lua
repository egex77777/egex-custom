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

padminsys = padminsys or {}
padminsys.main = {}
padminsys = padminsys or {}

function padminsys:getrank(ply)
    if ply:GetUserGroup() == "user" or ply:GetUserGroup() == "vip" or ply:GetUserGroup() == "Server Backer" then return false end
    for k,v in pairs(sam.ranks.get_ranks()) do
        if ply:GetUserGroup() == v.name then
            return true
        end
    end
end
function padminsys:NotifyPlayers(msg)
    for k, v in pairs(player.GetAll()) do
        v:ChatPrint("{![pAdminSys] }" .. msg)
    end
end

function padminsys:StaffDutyCheck(ply)
    if ply:GetNWBool("padminsys:adminonduty", false) == true then
        return true
    else
        return false
    end
end

hook.Add("PlayerSay", "minutesdutycommand", function(ply, txt)
    if txt == "/staff" then
        if not padminsys:getrank(ply) then
            ply:ChatPrint("{*pAdminSys: User Not Staff}")

            return
        end

            if padminsys:getrank(ply) then
                if padminsys:StaffDutyCheck(ply) then
                ply:SetNWBool("padminsys:adminonduty", false)
                ply:GodDisable()
                ply:SetModel(ply.StaffModel)
                ply:SetPos(ply.StaffPos)
                padminsys:NotifyPlayers(ply:Nick() .. " {*Is Now Off Duty!}")
                flexstafflogs(ply:Nick() .. " Went Off Duty" .. "\n Time: " .. os.date("%H:%M:%S", os.time()) .. " \n Date: " .. os.date("%d/%m/%Y", os.time()))
            else
                ply.StaffPos = ply:GetPos()
                ply.StaffModel = ply:GetModel()
                ply:SetNWBool("padminsys:adminonduty", true)
                ply:SetModel("models/player/combine_super_soldier.mdl")
                ply:SetPos(Vector(1783.991577, -1328.289673, 365.031250))
                ply:GodEnable()
                padminsys:NotifyPlayers(ply:Nick() .. " {*Is Now On Duty!}")
                flexstafflogs(ply:Nick() .. " Went On Duty" .. "\n Time: " .. os.date("%H:%M:%S", os.time()) .. " \n Date: " .. os.date("%d/%m/%Y", os.time()))
            end
        end
    end
end)