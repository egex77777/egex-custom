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

if SERVER and string.lower(VNP.Database.UseType) ~= "file" then return end

local basedir = VNP.Database.File.directory or "vnp_data"

function VNP.Database:Initialize()
    if !file.IsDir(basedir, "DATA") then
        file.CreateDir(basedir)
    end
end

function VNP.Database:InitializeTable(tbl)
    if !file.IsDir(basedir.."/"..tbl, "DATA") then
        file.CreateDir(basedir.."/"..tbl)
    end
end

function VNP.Database:SaveData(tbl, identifier, data, callback)

    local cbData = data

    data = {data}

    data = util.TableToJSON(data)

    file.Write(basedir.."/"..tbl.."/"..identifier..".json", data)

    if callback && isfunction(callback) then
        callback(cbData)
    end

    return true
end

function VNP.Database:DeleteData(tbl, identifier)
    if !file.Exists(basedir.."/"..tbl.."/"..identifier..".json", "DATA") then return false end

    file.Delete(basedir.."/"..tbl.."/"..identifier..".json", "DATA")

    return true
end

function VNP.Database:GetData(tbl, identifier, callback)
    
    if !file.Exists(basedir.."/"..tbl.."/"..identifier..".json", "DATA") then return false end

    local data = file.Read(basedir.."/"..tbl.."/"..identifier..".json", "DATA")

    if !data then return false end

    data = util.JSONToTable(data)

    data = data[1]

    if callback && isfunction(callback) then
        callback(data)
    end

    return true
end

VNP.Database:Initialize()