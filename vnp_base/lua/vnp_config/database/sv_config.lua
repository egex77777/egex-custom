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

VNP.Database = VNP.Database or {}

VNP.Database.UseType = "file" -- two options (file, mysql)

VNP.Database.MYSQL = { -- Refer to use type above (REQUIRES MYSQLOO)
    host = "localhost",
    port = "3306",
    database = "darkrp",
    username = "root",
    password = "",
}


hook.Add("DarkRPDBInitialized", "VNP.SyncDatabase", function()
    if RP_MySQLConfig && RP_MySQLConfig.EnableMySQL then -- Specifically for yall
        VNP.Database.UseType = "mysql"
        VNP.Database.MYSQL = {}
        VNP.Database.MYSQL.host = RP_MySQLConfig.Host
        VNP.Database.MYSQL.port = RP_MySQLConfig.Database_port
        VNP.Database.MYSQL.database = RP_MySQLConfig.Database_name
        VNP.Database.MYSQL.username = RP_MySQLConfig.Username
        VNP.Database.MYSQL.password = RP_MySQLConfig.Password
    end
end)