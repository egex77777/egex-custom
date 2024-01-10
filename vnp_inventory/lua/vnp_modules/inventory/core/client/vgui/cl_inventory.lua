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

local scrapIcon = VNP:GetMaterial("https://i.imgur.com/dNEcfIb.png")

function PANEL:Init()

    local d = VNP:resFormatW(VNP.Inventory.SlotSize)
    local p = VNP:resFormatH(VNP.Inventory.SlotSize)

    local w,h = self:GetSize()

    self:SetDraggable(false)
    self:SetTitle("Inventory")
    self:SetTitleBarSize(15)

    self.btnClose:SetVisible(false)

    self._grid = vgui.Create("VNPGrid", self)
    self._grid:Dock(FILL)
    self._grid:SetColWide(d)
    self._grid:SetRowHeight(p)
    self._grid:SetCols(VNP.Inventory.SlotsX)
    self._grid:SetHorizontalSpacing( VNP:resFormatW(8) )
	self._grid:SetVerticalSpacing( VNP:resFormatH(8) )

    self._grid.Paint = function()end

    local pages = LocalPlayer():GetInventoryPages()

    local x,y = VNP:GetTextSize(self:GetTitle(), 22)

    local normalrec = function(s,p,b)
        if !b then return end

        local sender, receiver = p[1].Slot, LocalPlayer():GetAvailableSlot(self.page)

        if !p[1].Data and !s.Data then return end

        VNP.Inventory:MoveItem(sender, receiver)
    end
    
    if pages then
        
        self._pageButtons = {}

        for i=1,pages do
            self._pageButtons[i] = vgui.Create("DButton", self)
            self._pageButtons[i]:SetResSize(20,20)
            self._pageButtons[i]:SetText(i)
            self._pageButtons[i]:SetFont("VNP.Font.24")
            self._pageButtons[i]:SetColor(color_white)
            self._pageButtons[i].Paint = function(s,w,h)
                local color = self.selectedPage == s && Color(0,0,0,150) or Color(0,0,0,100)

                draw.RoundedBox(10,0,0,w,h,color) -- JUST USE A FUCKING CIRCLE U SPERGS
            end

            self._pageButtons[i]:SetResPos(x+(VNP:resFormatW(30)*i), self:GetTitleBarSize()/4)

            self._pageButtons[i].DoClick = function(s,w,h)
                self.selectedPage = s

                local slotsPerPage = VNP.Inventory.SlotsY*VNP.Inventory.SlotsX

                for _,pnl in ipairs(self._grid.Items) do
                    local slot = (slotsPerPage*i)-(slotsPerPage-_)

                    pnl:SetSlot(slot)

                    pnl.GetItemData = function(s)
                        return LocalPlayer()._vInventory[slot]        
                    end
                end
            end
            self._pageButtons[i]:Receiver("Swap Inventory Item", function(s,p,b)
                if !b then return end
        
                local sender, receiver = p[1].Slot, LocalPlayer():GetAvailableSlot(i)
        
                if !p[1].Data and !s.Data then return end
        
                VNP.Inventory:MoveItem(sender, receiver)
            end)
        end
        self.selectedPage = self._pageButtons[1]

        self.buyPage = vgui.Create("DButton", self)
        self.buyPage:SetResSize(20,20)
        self.buyPage:SetResPos(x+(30*(#VNP.Inventory.Pages+1)), y/2-(10/4))
        self.buyPage:SetText("+")
        self.buyPage:SetFont("VNP.Font.32")
        self.buyPage:SetColor(color_white)
        self.buyPage.Paint = function(s,w,h)
            local color = s:IsHovered() && Color(150,150,150) or color_white

            if color ~= s:GetFGColor() then
                s:SetFGColor(color)
            end
        end

        self.buyPage.DoClick = function(s)
            VNP:Broadcast("VNP.BuyPage", {})
            VNP.Inventory:OpenInventory()
        end
    end

    self.upgrades = vgui.Create("VNPButton", self)
    self.upgrades:SetText("Upgrades")
    self.upgrades:SetResSize(100,25)
    self.upgrades:SetResPos(0, self:GetTitleBarSize()/4)
    self.upgrades.toggled = false

    self.upgrades.DoClick = function(s)
        if !self.upgrades.toggled then
            for i,pnl in ipairs(self._pageButtons) do
                pnl:SetVisible(false)
            end
            self.buyPage:SetVisible(false)
            self:SetTitle("Upgrades")

            for d,pnl in ipairs(self._grid.Items) do
                pnl:SetSlot(d)

                pnl.IsUpgrade = true

                pnl.GetItemData = function(s)
                    return LocalPlayer()._vInventory["UPGRADES"][d]
                end
            end

            s:SetText("Back")
        else
            for i,pnl in ipairs(self._pageButtons) do
                pnl:SetVisible(true)
            end
            self.buyPage:SetVisible(true)
            self:SetTitle("Inventory")
            
            for _,pnl in ipairs(self._grid.Items) do
                pnl:SetSlot(_)
                
                pnl.IsUpgrade = false

                pnl.GetItemData = function(s)
                    return LocalPlayer()._vInventory[_]
                end
            end
            s:SetText("Upgrades")
        end

        self.upgrades.toggled = !self.upgrades.toggled
    end

    local amt = VNP.Inventory.Pages[pages+1] or nil

    if amt then
        self.buyPage:SetTooltip("Upgrade Inventory \n $"..VNP:FormatNumber(amt).." for +60 slots")
    end

    self:MakePopup()
end

function PANEL:AddPanel(pnl)
    if !IsValid(pnl) then return end

    self._grid:AddItem(pnl)
end

function PANEL:PerformLayout(w,h)
    local x,y = VNP:GetTextSize(self:GetTitle(), 22)

    local titlebarSize = self:GetTitleBarSize()

    if IsValid(self.upgrades) then
        self.upgrades:SetPos(w-VNP:resFormatW(105), titlebarSize/2-VNP:resFormatH(25)/2.5) -- I'm getting lazy...
    end

    if !IsValid(self.buyPage) then return end

    self.buyPage:SetPos(x+(VNP:resFormatW(30)*(#VNP.Inventory.Pages+1)), titlebarSize/2-VNP:resFormatH(20)/2)

    for i,pnl in ipairs(self._pageButtons) do
        self._pageButtons[i]:SetPos(w*.1+(VNP:resFormatW(30)*i), titlebarSize/2-VNP:resFormatH(20)/2)
    end
end

vgui.Register( "VNPInventory", PANEL, "VNPFrame")