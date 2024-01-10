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
include("shared.lua")
for i=12, 45 do // Not as expensive as people think...
	surface.CreateFont( "ui."..i, { font = "Montserrat", size = i }) 
	surface.CreateFont( "uib."..i, { font = "Montserrat", size = i, weight = 1024 })
end
function ENT:Draw()
	self:DrawModel()

	local p, w, h = LocalPlayer(), ScrW(), ScrH()
	if p:GetPos():Distance( self:GetPos() ) > 250 then return end

	local ply = LocalPlayer()
    local pos = self:GetPos()
    local eyePos = ply:GetPos()
    local dist = pos:Distance(eyePos)
    local alpha = math.Clamp(2500 - dist * 2.7, 0, 255)

    if (alpha <= 0) then return end

    local angle = self:GetAngles()
    local eyeAngle = ply:EyeAngles()

    angle:RotateAroundAxis(angle:Forward(), 90)
    angle:RotateAroundAxis(angle:Right(), - 90)

    cam.Start3D2D(pos + self:GetUp() * 95, Angle(0, eyeAngle.y - 90, 90), 0.04)
      XeninUI:DrawNPCOverhead(self, {
        alpha = alpha,
        text = "Admin Suit Converter",
        icon = Coinflip.Config.NPCIcon,
        sin = true,
        xOffset = 0,
        textOffset = 0,
        iconMargin = 0,
        color = Color(127, 21, 255)
      })
    cam.End3D2D()
end