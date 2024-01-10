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

VNP.NetFunctions = VNP.NetFunctions or {}

if SERVER then
	util.AddNetworkString(VNP.Net.Message)
end

local util_TableToJSON, util_JSONToTable, util_Decompress, util_Compress = util.TableToJSON, util.JSONToTable, util.Decompress, util.Compress

local PLAYER = FindMetaTable("Player")

local NotificationTypes = {
	["error"] = 1,
	["generic"] = 0,
	["hint"] = 3,
}

function PLAYER:NNotify(Type, Message)
	if !Type or !Message then return end
	if SERVER then
		self:SendData("VNP.Notify", {Type = Type, Message = Message})
	else
		if NotificationTypes[string.lower(Type)] then
			notification.AddLegacy(Message, NotificationTypes[string.lower(Type)], 2)
		elseif string.lower(Type) == "text" then
			if ix.chat then
				ix.chat.Send(self, "["..VNP.Net.TextPrefix.."]: ", Message)
			else
				chat.AddText(VNP.Net.TextColor, "["..VNP.Net.TextPrefix.."]: ", Color(255,255,255), Message)
			end
			chat.AddText(VNP.Net.TextColor, "["..VNP.Net.TextPrefix.."]: ", Color(255,255,255), Message)
		elseif string.lower(Type) == "console" then
			VNP:Print(Message, VNP.Net.TextColor)
		end
	end
end

hook.Add( "InitPostEntity", "VNP.EntitiesInitialized", function()
	VNP.EntitiesInitialized = true
end )

function VNP:EscapeEntities( tbl, bool ) -- Thanks Kirby
	if not tbl then return {} end
	if bool then
		for k, v in pairs( tbl ) do
			if istable( v ) then
				tbl[ k ] = self:EscapeEntities( v, true )
			end
			if isentity( v ) then
				tbl[ k ] = ":;:_" .. v:EntIndex()
			end

		end
		return tbl
	else
		for k, v in pairs( tbl ) do
			if istable( v ) then
				tbl[ k ] = self:EscapeEntities( v, false )
			end
			if isstring( v ) and string.find( v, ":;:_" ) then
				tbl[ k ] = Entity( string.gsub( v, ":;:_", "" ) )
			end
		end
		return tbl
	end
end

function VNP:Compress(data)

	data = self:EscapeEntities(data, true)

	data = util_TableToJSON(data)

	if SERVER then
		data = util_Compress(data)
	end

	return data
end

function VNP:Decompress(data)

	if CLIENT then
		data = util_Decompress(data)
	end

	data = util_JSONToTable(data)

	data = self:EscapeEntities(data, false)

	return data
end

local PLAYER = FindMetaTable("Player")

function PLAYER:SendData(Message, Data) -- Send a net message on either side
	if istable(Message) then 
		Data = Message 
	elseif istable(Data) then
		Data.nwstring = Message
	else
		print("No Data to send")
		return
	end
	
	Data = VNP:Compress(Data)

	net.Start(VNP.Net.Message)
	net.WriteString(#Data)
	net.WriteData(Data, #Data)

	if SERVER then
		net.Send(self)
	else
		net.SendToServer()
	end
end

function VNP:Broadcast(Message, Data, players)
	if istable(Message) then 
		Data = Message 
	elseif istable(Data) then
		Data.nwstring = Message
	else
		print("No Data to send")
		return
	end

	if !istable(Data) then return end

	Data = VNP:Compress(Data)

	net.Start(VNP.Net.Message)
	net.WriteString(#Data)
	net.WriteData(Data, #Data)

	if SERVER && !players then
		net.Broadcast()
	elseif SERVER then
		net.Send(players)
	else
		net.SendToServer()
	end
end

function VNP:AddNetworkString(name, func)
	self.NetFunctions[name] = func
end

net.Receive(VNP.Net.Message, function(len, ply)
	local ply = CLIENT and LocalPlayer() or ply
	local Len = net.ReadString()
	local Data = net.ReadData(tonumber(Len))

	Data = VNP:Decompress(Data)

	local Action = Data.nwstring

	if !VNP.NetFunctions[Action] then return end
	if VNP.EntitiesInitialized && !IsValid(ply) then return end	

	VNP.NetFunctions[Action](ply, Data)
end)

if CLIENT then
    VNP:AddNetworkString("VNP.Notify", function(ply, Data)
		local Type = Data.Type
		local Message = Data.Message
		
		ply:NNotify(Type, Message)
	end)
end