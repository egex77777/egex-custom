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

local debug_traceback, pairs, table_Count, print = debug.traceback, pairs, table.Count, print
--
AddCSLuaFile()

VNP = VNP or {}

local ErrorNoHalt = ErrorNoHalt
local include = include
local AddCSLuaFile = AddCSLuaFile

local Color = Color
local MsgC = MsgC

local string = string
local file = file
local math = math

function VNP:Print( msg, col )
	if !self.DeveloperMode then return end
	if not msg then return false end
	col = col and col or CLIENT and Color( 80, 80, 255, 255 ) or Color( 255, 150, 0, 255 )

	MsgC( col, SERVER and "["..self.Prefix.." Server]: " or "["..self.Prefix.." Client]: ", Color( 255, 255, 255, 255 ), msg .. "\n" )
	return true
end

local function printSpacer()
	if !VNP.DeveloperMode then return end
	VNP:Print( "------------------------------------------" )
end

function VNP:Initialize()
	local side = SERVER and "Server" or "Client"


	printSpacer()
	if SERVER then
		self:Print( "-------------Loading Workshop--------------" )
		for i,addon in pairs(engine.GetAddons()) do
			if addon.mounted then
				resource.AddWorkshop( addon.wsid )
				self:Print("Added: "..addon.wsid.." for Client Download!")
			end
		end
	end
	self:Print( "--------------Loading Config---------------" )
	self:RecusiveInclude("vnp_config")
    self:Print( "-------------Loading Utilities-------------" )
	self:RecusiveInclude("vnp_utilities")
	self:Print( "--------------Loading Modules--------------" )
	self:RecusiveInclude("vnp_modules")
	printSpacer()

	if CLIENT then
		RunConsoleCommand("cl_cmdrate", 30)
		RunConsoleCommand("cl_updaterate", 30)
		RunConsoleCommand("cl_interp_ratio", 2)
		RunConsoleCommand("cl_interp", 0.066666)
		RunConsoleCommand("rate", 30000)
	end

end

function VNP:RecusiveInclude( path )

	local files, directorys = file.Find( path .. "/*", "LUA" )

	for k, v in pairs( files ) do
		local b = v:sub( 1, 3 )

		if b == "sv_" then
			self:LoadFile( path .. "/" .. v, "server" )
		elseif b == "cl_" then
			self:LoadFile( path .. "/" .. v, "client" )
		elseif b == "sh_" then
			self:LoadFile( path .. "/" .. v, "shared" )
		end
	end

	if directorys and table_Count( directorys ) > 0 then
		for k, v in pairs( directorys ) do
			if self.DeveloperMode && path == "vnp_modules" then
				self:Print("Loading Module: "..v)
			end
			self:RecusiveInclude( path .. "/" .. v )
		end
	end
end

function VNP:Error( msg )
	if not msg then return false end
	
	ErrorNoHalt( msg .. "\n" )
	if self.DeveloperMode then print( debug_traceback() ) end
	return true
end

function VNP:LoadFile( path, realm )
	
	local r = string.lower( realm )

	if self.DeveloperMode then
		self:Print( "Loading: " .. path )
	end
	if string.lower( r ) == "server" then
		if SERVER then include( path ) end
		return true
	elseif string.lower( r ) == "client" then
		if CLIENT then include( path ) end
		if SERVER then AddCSLuaFile( path ) end
		return true
	elseif string.lower( r ) == "shared" then
		include( path )
		if SERVER then AddCSLuaFile( path ) end
		return true
	else
		self:Error( "VNP:LoadFile(), Incorrect realm var." )
	end

end

VNP:Initialize()