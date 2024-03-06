local PANEL = {}

function PANEL:Init()
    self:SetTitle("Donate Credits to other player")
    self:SetSize(ScrW() * .45, ScrH() * .3)
    self:Center()
    self:MakePopup()

    self.credits = 0
    self.player = nil

    self.btns = self:Add("DPanel")
    self.btns:Dock(BOTTOM)
    self.btns:SetTall(ScrH() * .07)
    self.btns:DockMargin(16, 16, 16, 16)
    self.btns.Paint = function(me, w, h) end 

    self.donate = self.btns:Add("DButton")
    self.donate:Dock(LEFT)
    self.donate:SetText("")
    self.donate.Paint = function(me, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0))

        draw.SimpleText("Donate", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.donate.DoClick = function(me)
        self:Remove()
        if self.player == nil then return end 
        net.Start("CreditStore.DonateCredits")
        net.WriteEntity(self.player)
        net.WriteInt(self.credits, 32)
        net.SendToServer()
    end

    self.cancel = self.btns:Add("DButton")
    self.cancel:Dock(RIGHT)
    self.cancel:SetText("")
    self.cancel.Paint = function(me, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0))

        draw.SimpleText("Cancel", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.cancel.DoClick = function(me)
        self:Remove()
    end

    self.btns.PerformLayout = function(me, w, h)
        self.donate:SetWide(w / 2 - 20)
        self.cancel:SetWide(w / 2 - 20)
    end
    
    surface.SetFont("CreditStore.PlyInfo")
    local textW, textH = surface.GetTextSize("Donate")

    self.box = self:Add("DPanel")
    self.box:Dock(FILL)
    self.box:DockMargin(16, 16, 16, 0)
    self.box.Paint = function(me, w, h)
        draw.SimpleText("Donate", "CreditStore.PlyInfo", 0, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Credits to", "CreditStore.PlyInfo", textW + 32 + ScrW() * .14, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.creditsEntry = self.box:Add("DTextEntry")
    self.creditsEntry:Dock(LEFT)
    self.creditsEntry:DockMargin(textW + 16, 0, 16, 0)
    self.creditsEntry:SetWide(ScrW() * .14)
    self.creditsEntry:SetText(self.credits)
    self.creditsEntry:SetNumeric(true)
    self.creditsEntry:SetTextColor(Color(12, 12, 12))
    self.creditsEntry.OnValueChange = function(me, txt)
        self.credits = tonumber(txt)
    end
    self.creditsEntry:SetContentAlignment(5)
    self.creditsEntry.Paint = function(me, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(230, 230, 230))
        draw.SimpleText(me:GetText(), "CreditStore.PlyInfo", w / 2, h / 2, Color(15, 15, 15), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        -- me:DrawTextEntryText(me.m_colText, me.m_colHighlight, me.m_colCursor)
    end

    surface.SetFont("CreditStore.PlyInfo")
    local textW, textH = surface.GetTextSize("Credits to")

    self.playerEntry = self.box:Add("DComboBox")
    self.playerEntry:Dock(LEFT)
    self.playerEntry:DockMargin(textW + 16, 0, 16, 0)
    self.playerEntry:SetWide(ScrW() * .12)
    self.playerEntry:SetValue("Select Player")
    self.playerEntry.OnSelect = function(_, _, value)
        self.player = value
    end

    for _, v in ipairs(player.GetAll()) do
        if v == LocalPlayer() then continue end 
        self.playerEntry:AddChoice(v:Name(), v)
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(8, 0, 0, w, h, Color(12, 12, 12))
end

vgui.Register("CreditStore.DonateMenu", PANEL, "DFrame")