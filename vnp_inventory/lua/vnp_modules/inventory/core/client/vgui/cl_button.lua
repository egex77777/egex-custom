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

local PANEL = {}

local c = VNP:resFormatW(2)

AccessorFunc( PANEL, "m_bgCol", "BGCol" )

function PANEL:Init()
    self:SetText("Button")
    self:SetFont("VNP.Font.22")
    
    self.m_bgCol = Color(30,30,34)
end

function PANEL:Paint(w,h)
    local color = self:IsHovered() && Color(150,150,150) or Color(100,100,104)

    draw.RoundedBox(5,0,0,w,h,Color(50,50,54))
    draw.RoundedBox(5,c,c,w-c*2,h-c*2,self.m_bgCol)

    if color ~= self:GetFGColor() then
        self:SetFGColor(color)
    end
end

vgui.Register( "VNPButton", PANEL, "DButton")