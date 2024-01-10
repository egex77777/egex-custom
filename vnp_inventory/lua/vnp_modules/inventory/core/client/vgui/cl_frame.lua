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

local xMat = VNP:GetMaterial("https://i.imgur.com/XP4L6rC.png")
local padding = VNP:resFormatW(5)

function PANEL:Init()

    self:SetTitleBarSize(5)
    self:SetTitle("")
    self.SetTitle = function(s, name)
        s.m_Title = name

        local x,y = VNP:GetTextSize(name, 22)

        self.m_titleW, self.m_titleH = x,y

        self:DockPadding(padding, self:GetTitleBarSize() + padding, padding, padding)
    end

    //self:SetDraggable(false)
    self:SetTitle("Frame")

    //self.btnClose:SetVisible(false)
    self.btnMaxim:SetVisible(false)
	self.btnMinim:SetVisible(false)

    self.btnClose.Paint = function(s,w,h)
        if !(xMat) then return end
        VNP:DrawIcon(xMat, w-h,0,h,h)
    end

    self:MakePopup()
end

function PANEL:GetTitle()
    return self.m_Title or ""
end

function PANEL:GetTitleTextSize()
    return self.m_titleW, self.m_titleH
end

function PANEL:GetTitleBarSize()
    local x,y = VNP:GetTextSize(self:GetTitle(), 22)

    return y+self.m_titleBarH
end

function PANEL:SetTitleBarSize(size)
    size = tonumber(size) or 5

    self.m_titleBarH = VNP:resFormatH(size)

    self:DockPadding(padding, self:GetTitleBarSize() + padding, padding, padding)
end

function PANEL:Paint(w,h)
    draw.RoundedBox(5,0,0,w,h,Color(15,15,17,255))

    local H = self:GetTitleBarSize()

    local x,y = self:GetTitleTextSize()

    if self:GetTitle() ~= "" then
		draw.RoundedBox( 6, 0, 0, w, H, Color(30,30,34) )
	end
    VNP:DrawText(self:GetTitle(), 22, w*.025,H/2-y/2, color_white, 0)

    self:PostPaint(w,h)
end

function PANEL:PostPaint()end

function PANEL:PerformLayout()

    DFrame.PerformLayout( self, w, h )

    local x,y = self:GetTitleTextSize()

    local size = self:GetTitleBarSize()

    self.btnClose:SetPos( self:GetWide()-(size*.875), (size*.25)/2 )
	self.btnClose:SetSize( size*.75, size*.75 )

end

vgui.Register( "VNPFrame", PANEL, "DFrame")