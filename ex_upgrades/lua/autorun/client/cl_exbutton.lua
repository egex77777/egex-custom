local PANEL = {}

function PANEL:Init()
    self:SetText("Silahını Yükselt")
    self:SetFont("DermaDefault")
    self:SetTextColor(Color(255, 255, 255))
    self:SetWide(250)
    self:SetTall(30)
    self:SetColor(Color(255, 0, 0))
end

function PANEL:Flash()
    local originalColor = self:GetColor()

    self:SetTextColor(Color(0, 0, 0))
    self:SetColor(Color(255, 255, 255))

    timer.Simple(0.5, function()
        if IsValid(self) then
            self:SetTextColor(Color(255, 255, 255))
            self:SetColor(originalColor)
        end
    end)
end

function PANEL:Paint(w, h)
    local color = self:GetColor()
    surface.SetDrawColor(color.r, color.g, color.b)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(255, 255, 255) -- Kenar ve köşe rengi
    surface.DrawOutlinedRect(0, 0, w, h)
end

derma.DefineControl("EButton", "Custom Button", PANEL, "DButton")
