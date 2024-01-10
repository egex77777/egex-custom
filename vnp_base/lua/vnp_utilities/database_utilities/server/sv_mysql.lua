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

if string.lower(VNP.Database.UseType) ~= "mysql" then return end

require("mysqloo")

function VNP.Database:debugfunction(db, desc)
	db.callback = function(query, data) VNP:Print( "MYSQL Success: "..desc, Color(0,255,0)) return true end
	db.onError = function(q, err) VNP:Print( "MYSQL Error: "..err, Color(255,0,0)) return false end
	db.onConnectionFailed = function(err, sql) VNP:Print( "MYSQL Connection Failed: "..tostring(err), Color(255,0,0)) return false end
	db.onConnected = function() VNP:Print( "MYSQL Connected Successfully", Color(0,255,0)) return true end
end

function VNP.Database:Initialize()
    
    self.Connections = self.Connections or {}

    for i=1,5 do
        if self.Connections[i] then
            self.Connections[i]:disconnect(true)
        end

        self.Connections[i] = mysqloo.connect(self.MYSQL.host, self.MYSQL.username, self.MYSQL.password, self.MYSQL.database, self.MYSQL.port)

        if i > 4 then
            self:debugfunction(self.Connections[4])
        end

        self.Connections[i]:connect()

--        timer.Create( "VNP.MYSQL.PING."..i, 298, 0, function()
--            local query = self.Connections[i]:query("SELECT 5+5")
--
--            if self.DebugMode then
--                self:debugfunction(query)
--            end
--        end)
    end

end

function VNP.Database:InitializeTable(tbl)

    local str = [[CREATE TABLE IF NOT EXISTS `]]..tbl..[[` (
        `IDENTIFIER` varchar(255) NOT NULL,
        `DATA` json NOT NULL,
        PRIMARY KEY (`IDENTIFIER`)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
    
    local query = self.Connections[1]:query(str)
    if self.DebugMode then
        self:debugfunction(query, "Create Table "..tbl)
    end

    query:start()

    return query
end

function VNP.Database:SaveData(tbl, identifier, data, callback)

    local data = {data}
    
    data = util.TableToJSON(data)

    local str = "INSERT INTO "..tbl.."(IDENTIFIER, DATA) VALUES('"..identifier.."', '"..data.."') ON DUPLICATE KEY UPDATE DATA='"..data.."'"
    local connection = self.Connections[1]

    for i=1,5 do
        if self.Connections[i]:queueSize() > connection:queueSize() then continue end
        connection = self.Connections[i]
    end

    local query = connection:query(str)

    if self.DebugMode then
        self:debugfunction(query, "Saved data "..data.." to "..tbl.." with identifier: "..identifier)
    end

    if callback && isfunction(callback) then
        function query:onSuccess(data)
            local d = self:getData()
            
            if !d or !d[1] then return end
            
            d = util.JSONToTable(d[1].DATA)
            d = d[1]

            callback(d)
        end
    end

    query:start()

    return query

end

function VNP.Database:DeleteData(tbl, identifier)

    local str = "DELETE FROM "..tbl.." WHERE IDENTIFIER='"..identifier.."'"
    local connection = self.Connections[1]

    for i=1,5 do
        if self.Connections[i]:queueSize() > connection:queueSize() then continue end
        connection = self.Connections[i]
    end

    local query = connection:query(str)

    if self.DebugMode then
        self:debugfunction(query, "Deleted data with identifier: "..identifier.." from "..tbl)
    end

    query:start()

    return query

end

function VNP.Database:GetData(tbl, identifier, callback)

    local str = "SELECT * FROM "..tbl.." WHERE IDENTIFIER='"..identifier.."'"
    local database = self.Connections[1]

    for i=1,5 do
        if self.Connections[i]:queueSize() >= database:queueSize() then continue end
        database = self.Connections[i]
    end

    local query = database:query(str)

    if self.DebugMode then
        self:debugfunction(query, "Load data from "..tbl.." with the identifier of "..identifier)
    end

    if callback && isfunction(callback) then
        function query:onSuccess(data)
            local d = self:getData()
            if !d or !d[1] then return end

            d = util.JSONToTable(d[1].DATA)
            d = d[1]

            callback(d)
        end
    end

    query:start()

    return query

end

function VNP.Database:Query(str, callback)

    local database = self.Connections[1]

    for i=1,5 do
        if self.Connections[i]:queueSize() >= database:queueSize() then continue end
        database = self.Connections[i]
    end

    local query = database:query(str)

    if self.DebugMode then
        self:debugfunction(query, str)
    end

    if callback && isfunction(callback) then
        function query:onSuccess(data)
            local d = self:getData()

            callback(d)
        end
    end

    query:start()

    return query
end

VNP.Database:Initialize()