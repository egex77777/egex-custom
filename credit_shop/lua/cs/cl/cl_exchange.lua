local PANEL = {}

function PANEL:Init()
    self:SetTitle("Exchange Money for credits")
    self:SetSize(ScrW() * .3375, ScrH() * .225)
    --self:Center()
    self:MakePopup()

    self.creditsToExchange = 0

    self.exchange = self:Add("DButton")
    self.exchange:Dock(BOTTOM)
    self.exchange:SetTall(ScrH() * .07)
    self.exchange:DockMargin(16, 16, 16, 16)
    self.exchange:SetText("")
    self.exchange.DoClick = function(me)
        net.Start("CreditStore.ExchangeCredits")
        net.WriteInt(self.creditsEntry:GetValue(), 32)
        net.SendToServer()
        self:Close()
    end
    self.exchange.Paint = function(me, w, h)
        surface.SetDrawColor(255, 0, 0, 255)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Exchange", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    
    surface.SetFont("CreditStore.PlyInfo")
    local textW, textH = surface.GetTextSize("Buying")

    self.box = self:Add("DPanel")
    self.box:Dock(FILL)
    self.box:DockMargin(16, 16, 16, 0)
    self.box.Paint = function(me, w, h)
        draw.SimpleText("Buying", "CreditStore.PlyInfo", 0, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Credits for " .. DarkRP.formatMoney(CreditStore.Config.ExchangePrice * (math.min(math.floor((LocalPlayer():getDarkRPVar("money") or 0) / CreditStore.Config.ExchangePrice), (tonumber("0" .. self.creditsEntry:GetValue()))))), "CreditStore.PlyInfo", textW + 32 + ScrW() * .1, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end 

    self.creditsEntry = self.box:Add("DTextEntry")
    self.creditsEntry:Dock(LEFT)
    self.creditsEntry:DockMargin(textW + 16, 0, 16, 0)
    self.creditsEntry:SetWide(ScrW() * .105) 
    self.creditsEntry:SetValue(0)
    self.creditsEntry:SetUpdateOnType(true)
    self.creditsEntry:SetNumeric(true)
    self.creditsEntry.Paint = function(s, w, h)
        if s:IsHovered() or s:IsEditing() then
            draw.RoundedBox(5, 0, 0, w, h, Color(100, 100, 255, 150))
        end

        draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(200, 200, 200, 255))
        draw.SimpleText(math.min(math.floor((LocalPlayer():getDarkRPVar("money") or 0) / CreditStore.Config.ExchangePrice), tonumber("0" .. self.creditsEntry:GetValue())), "CreditStore.PlyInfo", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.creditsEntry.OnChange = function(s, value)
        if tonumber("0" .. self.creditsEntry:GetValue()) > math.floor((LocalPlayer():getDarkRPVar("money") or 0) / CreditStore.Config.ExchangePrice) then
            timer.Simple(0, function()
                self.creditsEntry:SetValue(math.floor((LocalPlayer():getDarkRPVar("money") or 0) / CreditStore.Config.ExchangePrice))
            end)
        end
    end

end

function PANEL:Paint(w, h)
    draw.RoundedBox(8, 0, 0, w, h, Color(12, 12, 12))
end

vgui.Register("CreditStore.ExchangeMenu", PANEL, "DFrame")