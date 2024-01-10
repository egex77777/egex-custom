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

-- stolen by fr stealer
-- https://discord.gg/R5KpPcrD
-- so free
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize( ) 
 
	self:SetModel( "models/player/police.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
end

local suit_cost = 500000000

function ENT:Use(ply)
    -- if ply:IsSuperAdmin() then
    --     data = VNP.Inventory:CreateItem("Admin Suit V2", "Glitched")
    --     data.Signature = ply:Nick()
    --     data.UID = "-1"
    --     ply:SetItemData(suit)
    --     ply:AddInventoryItem(data)
    --     ply:SetMaterial()
    --     return
    -- end
    if not ply:IsPlayer() then return end
    local suit = ply:GetSuit()

    if not suit then
        ply:ChatPrint("{!Wear A Admin Suit.}")

        return
    end

    if not suit.Name == "Admin Suit" then
        ply:ChatPrint("{!Must Be A Admin Suit}")

        return
    end
    if tostring(suit.SuitHealth) < "34000" then
        ply:ChatPrint("{!Suit Doesn't Have 34k+ HP!}")
        return
    end

    if not ply:canAfford(suit_cost) then
        ply:ChatPrint("{!You Do Not Have 500 Million}")

        return
    end

    if suit.Name == "Admin Suit" and tostring(suit.SuitHealth) > "34000" then
        ply:addMoney(-suit_cost)
        data = VNP.Inventory:CreateItem("Admin Suit V2", "Glitched")
        data.Signature = ply:Nick()
        data.LSkins = suit.LSkins
        ply:AddInventoryItem(data)
        ply:SetMaterial()
        ply:RemoveSuit()
    else
        ply:ChatPrint("{!Not Admin Suit Or Not Above 34k!")
    end
end