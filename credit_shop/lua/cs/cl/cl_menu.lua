local PANEL = {}

surface.CreateFont("CreditStore.Sidebar", {
    font = "Arial",
    size = math.max(28 * (ScrH() / 1080), 1),
    weight = 600,
    extended = true,
    antialias = true
})

surface.CreateFont("CreditStore.PlyInfo", {
    font = "Arial",
    size = math.max(28 * (ScrH() / 1080), 1),
    weight = 450,
    extended = true,
    antialias = true
})

surface.CreateFont("CreditStore.ItemTitle", {
    font = "Arial",
    size = math.max(24 * (ScrH() / 1080), 1),
    weight = 600,
    extended = true,
    antialias = true
})

surface.CreateFont("CreditStore.ItemDesc", {
    font = "Arial",
    size = math.max(24 * (ScrH() / 1080), 1),
    weight = 450,
    extended = true,
    antialias = true
})

local materials = {}
file.CreateDir("victorious")

local function DownloadImage(path, name, callback)
    local format = path:sub(#path - 3)
    local endPart = path:gsub("https://i.imgur.com/", "")

    http.Fetch("https://i.imgur.com/" .. endPart, function(body)
        file.Write("victorious/" .. name .. format, body)
        callback(Material("../data/victorious/" .. name .. format, "smooth"))
    end, function(err)
        callback(false)
    end)
end

timer.Simple(0.1, function()
    for k, v in pairs(CreditStore.Config.Items) do
        for key, value in pairs(v) do 
            if not value.display_path then continue end
            value.mat = Material("")
            value.notLoaded = true
            DownloadImage(value.display_path, k, function(mat)
                value.mat = mat
                value.notLoaded = false
            end)
        end
    end
end)

function PANEL:Init()
    local w, h = ScrW(), ScrH()
    local ply = LocalPlayer()

    self:SetTitle("Credit Shop")
    self:SetSize(ScrW() * .8, ScrH() * .85)
    self:Center()
    self:MakePopup()

    self.left = self:Add("DPanel")
    self.left:Dock(LEFT)
    self.left:DockMargin(8, 8, 8, 8)
    self.left:SetWide(ScrW() * .2)
    self.left.Paint = function(me, w, h) end

    self.plyInfo = self.left:Add("DPanel")
    self.plyInfo:Dock(BOTTOM)
    self.plyInfo:DockMargin(0, 8, 0, 0)
    self.plyInfo:SetTall(ScrH() * .16)
    self.plyInfo.Paint = function(me, w, h)
        surface.SetDrawColor(125, 125, 125, 255)
        surface.DrawOutlinedRect(0, 0, w, h, 2)

        draw.SimpleText(ply:Name(), "CreditStore.PlyInfo", 7, 8, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(ply.CS_Credits .. " Credits" or 0 .. " Credits", "CreditStore.PlyInfo", w - 7, 8, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        draw.SimpleText(DarkRP.formatMoney(ply:getDarkRPVar("money")), "CreditStore.PlyInfo", w - 7, 36, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end

    self.btns = self.plyInfo:Add("DPanel")
    self.btns:Dock(BOTTOM)
    self.btns:DockMargin(4, 16, 4, 16)
    self.btns:SetTall(ScrH() * .05)
    self.btns.Paint = function(me, w, h) end 

    self.donate = self.btns:Add("DButton")
    self.donate:Dock(LEFT)
    self.donate:SetText("")
    self.donate.Paint = function(me, w, h)
        draw.RoundedBox(h / 4, w / 8, 0, (w / 8) * 6, h, Color(35, 35, 35, 255))
        draw.SimpleText("Donate", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.donate.DoClick = function(me)
        local donateMenu = vgui.Create("CreditStore.DonateMenu")
    end

    self.exchange = self.btns:Add("DButton")
    self.exchange:Dock(RIGHT)
    self.exchange:SetText("")
    self.exchange.Paint = function(me, w, h)
        draw.RoundedBox(h / 4, w / 8, 0, (w / 8) * 6, h, Color(35, 35, 35, 255))
        draw.SimpleText("Değişim", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.exchange.DoClick = function(me)
        local exchangeMenu = vgui.Create("CreditStore.ExchangeMenu")
		exchangeMenu:SetPos(ScrW()*.1 + 15, ScrH() * .7 - 15)
    end

    self.btns.PerformLayout = function(me, w, h)
        self.donate:SetWide(w / 2 - 3)
        self.exchange:SetWide(w / 2 - 3)
    end

    self.sidebar = self.left:Add("DPanel")
    self.sidebar:Dock(FILL)
    self.sidebar.Paint = function(me, w, h)
        surface.SetDrawColor(125, 125, 125, 255)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end 

    for k, v in SortedPairsByMemberValue(CreditStore.Config.Categories, "order", false) do 
        local btn = self.sidebar:Add("DButton")
        btn:Dock(TOP)
        btn:DockMargin(2, 4, 2, 4)
        btn:SetTall(ScrH() * .05)
        btn:SetText("")
        btn.Alpha = 150
        btn.Paint = function(me, w, h)
            surface.SetDrawColor(ColorAlpha(v.color, me.Alpha))
            surface.DrawRect(0, 0, w, h)
            if me.Hovered then 
                surface.SetDrawColor(30, 30, 30, 100)
                surface.DrawRect(0, 0, w, h)
            end

            draw.SimpleText(k, "CreditStore.Sidebar", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        btn.DoClick = function(me, w, h)
            self.category = k 
            self:Build()
        end
    end
	

    self.leftbox = vgui.Create("DScrollPanel", self)
    self.leftbox:SetPos(self:GetWide() * .25+20, 37)
    self.leftbox:SetSize(self:GetWide() * .375 - 20, self:GetTall() - 50)
    self.leftbox.VBar:SetWide(0)
    self.leftbox.Paint = function(me, w, h)
        surface.SetDrawColor(125, 125, 125, 255)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end
    self.rightbox = vgui.Create("DScrollPanel", self)
    self.rightbox:SetPos(self:GetWide() * .25 +10 + (.374 * self:GetWide()), 37)
    self.rightbox:SetSize(self:GetWide() * .375 - 20, self:GetTall() - 50)
    self.rightbox.VBar:SetWide(0)
    self.rightbox.Paint = function(me, w, h)
        surface.SetDrawColor(125, 125, 125, 255)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end

    self.startTime = SysTime()
end 

function PANEL:Build()
    if not self.category then return end 
    self.rightbox:Clear()
    self.leftbox:Clear()
	
    for k, v in pairs(CreditStore.Config.Items[self.category]) do
		if v.box == 1 then
			local product = self.leftbox:Add("DButton")		
			product:Dock(TOP)
			product:DockMargin(4, 4, 4, 4)
			product:SetTall(ScrH() * .11)
			product:SetText("")
			if v.type == "job" or v.type == "perma_weapon" then 
				for key, value in pairs(LocalPlayer().CS_PermaWeapons) do
					if tonumber(value.class) == v.class then 
						product.Disabled = true
					end
				end
				for key, value in pairs(LocalPlayer().CS_PermaJobs or {}) do
					if tonumber(value.class) == v.class then 
						product.Disabled = true
					end
				end
			end
			product.Paint = function(me, w, h)
				surface.SetDrawColor(ColorAlpha(v.color, me.Disabled and 100 or 255) or Color(255, 0, 0, me.Disabled and 100 or 255))
				surface.DrawRect(0, 0, w, h)

				draw.SimpleText(v.name or "", "CreditStore.ItemTitle", 4, 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText(v.desc or "", "CreditStore.ItemDesc", 4, 8 + math.max(24 * (ScrH() / 1080), 1), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Cost " .. v.price .. " Credits" or 0 .. " Credits", "CreditStore.ItemDesc", 4, h - 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

				if v.display_path and v.notLoaded == false then 
					surface.SetDrawColor(color_white)
					surface.SetMaterial(v.mat)
					surface.DrawTexturedRect(w - h, 0, h, h)
				end
			end
			product.DoClick = function(me)
				if me.Disabled then return end 
				surface.SetFont("CreditStore.PlyInfo")
				local titleW, titleH = surface.GetTextSize("Are you sure?")

				surface.SetFont("CreditStore.ItemDesc")
				local descW, descH = surface.GetTextSize("Would you like to purchase")

				local youSure = vgui.Create("EditablePanel")
				youSure:SetSize(ScrW() * .35, ScrH() * .2)
				youSure:Center()
				youSure:MakePopup()
				youSure.Paint = function(me, w, h)
					draw.RoundedBox(8, 0, 0, w, h, Color(15, 15, 15))
					draw.SimpleText("Are you sure?", "CreditStore.PlyInfo", w / 2, 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
					draw.SimpleText("Would you like to purchase", "CreditStore.ItemDesc", w / 2, 8 + titleH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
					draw.SimpleText(v.name, "CreditStore.ItemDesc", w / 2, 12 + titleH + descH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end

				local btns = youSure:Add("DPanel")
				btns:Dock(BOTTOM)
				btns:SetTall(ScrH() * .08)
				btns:DockMargin(8, 8, 8, 8)
				btns.Paint = function(me, w, h) end

				local yes = btns:Add("DButton")
				yes:Dock(LEFT)
				yes:SetText("")
				yes.Paint = function(me, w, h)
					draw.RoundedBox(h / 4, (w / 5), 0, (w / 5) * 3, h, Color(55, 55, 55))

					draw.SimpleText("Yes", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				yes.DoClick = function(me)
					youSure:Remove()
					if (self.category) then
						net.Start("CreditStore.BuyPackage")
						net.WriteString(self.category)
						net.WriteInt(k, 32)
						net.SendToServer()
					end
				end

				local no = btns:Add("DButton")
				no:Dock(RIGHT)
				no:SetText("")
				no.Paint = function(me, w, h)
					draw.RoundedBox(h / 4, (w / 5), 0, (w / 5) * 3, h, Color(55, 55, 55))

					draw.SimpleText("No", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				no.DoClick = function(me)
					youSure:Remove()
				end

				youSure.PerformLayout = function(me, w, h)
					yes:SetWide(w / 2 - 20)
					no:SetWide(w / 2 - 20)
				end
			end

			if not v.display_path then 
				if v.type == "weapon" or v.type == "perma_weapon" or v.model then 
					local icon = product:Add("SpawnIcon")
					icon:Dock(RIGHT)
					icon:SetWide(ScrH() * .11)
					icon:SetModel((v.type == "weapon" or v.type == "perma_weapon") and weapons.Get(v.class).WorldModel or v.model)
				end
			end			
	else
			local product = self.rightbox:Add("DButton")		
			product:Dock(TOP)
			product:DockMargin(4, 4, 4, 4)
			product:SetTall(ScrH() * .11)
			product:SetText("")
			if v.type == "job" or v.type == "perma_weapon" then 
				for key, value in pairs(LocalPlayer().CS_PermaWeapons) do
					if tonumber(value.class) == v.class then 
						product.Disabled = true
					end
				end
				for key, value in pairs(LocalPlayer().CS_PermaJobs or {}) do
					if tonumber(value.class) == v.class then 
						product.Disabled = true
					end
				end
			end
			product.Paint = function(me, w, h)
				surface.SetDrawColor(ColorAlpha(v.color, me.Disabled and 100 or 255) or Color(255, 0, 0, me.Disabled and 100 or 255))
				surface.DrawRect(0, 0, w, h)

				draw.SimpleText(v.name or "", "CreditStore.ItemTitle", 4, 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText(v.desc or "", "CreditStore.ItemDesc", 4, 8 + math.max(24 * (ScrH() / 1080), 1), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Cost " .. v.price .. " Credits" or 0 .. " Credits", "CreditStore.ItemDesc", 4, h - 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

				if v.display_path and v.notLoaded == false then 
					surface.SetDrawColor(color_white)
					surface.SetMaterial(v.mat)
					surface.DrawTexturedRect(w - h, 0, h, h)
				end
			end
			product.DoClick = function(me)
				if me.Disabled then return end 
				surface.SetFont("CreditStore.PlyInfo")
				local titleW, titleH = surface.GetTextSize("Are you sure?")

				surface.SetFont("CreditStore.ItemDesc")
				local descW, descH = surface.GetTextSize("Would you like to purchase")

				local youSure = vgui.Create("EditablePanel")
				youSure:SetSize(ScrW() * .35, ScrH() * .2)
				youSure:Center()
				youSure:MakePopup()
				youSure.Paint = function(me, w, h)
					draw.RoundedBox(8, 0, 0, w, h, Color(15, 15, 15))
					draw.SimpleText("Are you sure?", "CreditStore.PlyInfo", w / 2, 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
					draw.SimpleText("Would you like to purchase", "CreditStore.ItemDesc", w / 2, 8 + titleH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
					draw.SimpleText(v.name, "CreditStore.ItemDesc", w / 2, 12 + titleH + descH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end

				local btns = youSure:Add("DPanel")
				btns:Dock(BOTTOM)
				btns:SetTall(ScrH() * .08)
				btns:DockMargin(8, 8, 8, 8)
				btns.Paint = function(me, w, h) end

				local yes = btns:Add("DButton")
				yes:Dock(LEFT)
				yes:SetText("")
				yes.Paint = function(me, w, h)
					draw.RoundedBox(h / 4, (w / 5), 0, (w / 5) * 3, h, Color(55, 55, 55))

					draw.SimpleText("Yes", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				yes.DoClick = function(me)
					youSure:Remove()
					net.Start("CreditStore.BuyPackage")
					net.WriteString(self.category)
					net.WriteInt(k, 32)
					net.SendToServer()
				end

				local no = btns:Add("DButton")
				no:Dock(RIGHT)
				no:SetText("")
				no.Paint = function(me, w, h)
					draw.RoundedBox(h / 4, (w / 5), 0, (w / 5) * 3, h, Color(55, 55, 55))

					draw.SimpleText("No", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				no.DoClick = function(me)
					youSure:Remove()
				end

				youSure.PerformLayout = function(me, w, h)
					yes:SetWide(w / 2 - 20)
					no:SetWide(w / 2 - 20)
				end
			end

			if not v.display_path then 
				if v.type == "weapon" or v.type == "perma_weapon" or v.model then 
					local icon = product:Add("SpawnIcon")
					icon:Dock(RIGHT)
					icon:SetWide(ScrH() * .11)
					icon:SetModel((v.type == "weapon" or v.type == "perma_weapon") and weapons.Get(v.class).WorldModel or v.model)
				end
			end			
	end
			

    end
end

function PANEL:Paint(w, h)
    Derma_DrawBackgroundBlur(self, self.startTime)

    draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 20, 250))
end

vgui.Register("CreditStore.Menu", PANEL, "DFrame")


concommand.Add("cs_menu", function(ply, cmd)
    local frame = vgui.Create("CreditStore.Menu")
end)