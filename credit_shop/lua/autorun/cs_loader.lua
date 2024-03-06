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

CreditStore = CreditStore || {}
CreditStore.Config = CreditStore.Config || {}

local function loadServer(path)
    if SERVER then
        return include(path)
    end 
end 
 
local function loadClient(path)
    if CLIENT then
        return include(path)
    end

    AddCSLuaFile(path)
end

local function loadShared(path)
    loadClient(path)
    return loadServer(path) 
end

local function loadDir(dir)
    local files, directories = file.Find(dir .. "/*", "LUA")

    for k, v in ipairs(files) do 
        local path = dir .. "/" .. v 

        if v:StartWith("cl_") then 
            loadClient(path)
        elseif v:StartWith("sv_") then 
            loadServer(path)
        else 
            loadShared(path)
        end
    end

    for k, v in ipairs(directories) do 
        loadDir(dir .. "/" .. v)
    end
end 

loadDir("cs")