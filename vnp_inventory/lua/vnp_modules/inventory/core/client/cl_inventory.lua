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

VNP.Inventory = VNP.Inventory or {}

function VNP.Inventory:OpenInventory()
    
    if !IsValid(g_ContextMenu) then return end
    if IsValid(self.Menu) then self.Menu:Remove() end
    if IsValid(self.EnhanceMenu) then self.EnhanceMenu:Remove() end
    if IsValid(self.ItemUpgrades) then self.ItemUpgrades:Remove()end

    LocalPlayer()._vInventory = LocalPlayer()._vInventory or {}

    local width, height = self.SlotsX*self.SlotSize, self.SlotsY*self.SlotSize

    local totalSlots = self.SlotsX*self.SlotsY

    height = height+((self.SlotsY-1)*10)

    self.Menu = vgui.Create("VNPInventory", g_ContextMenu)
    self.Menu:SetResSize(width,height)
    self.Menu:SetResPos((1920/2)-(width/2), 1080-(height*1.1))

    for i=1,totalSlots do
        local slot = vgui.Create("VNPInvSlot",self.Menu)
        //slot:SetText(i)
        slot:SetResSize(self.SlotSize,self.SlotSize)
        slot:SetVisible(false)

        slot:Receiver("Swap Inventory Item", function(s,p,b)
            if !b then return end

			local sender, receiver = p[1].Slot, s.Slot

			if !p[1].Data and !s.Data then return end
            
            local IsUpgrade = p[1].IsUpgrade or s.IsUpgrade or false

            VNP.Inventory:MoveItem(sender, receiver, IsUpgrade)
        end)
        slot:Droppable("Swap Inventory Item")

        slot:SetSlot(i)

        slot.GetItemData = function(s)
            return LocalPlayer()._vInventory[i]        
        end

        self.Menu:AddPanel(slot)
    end
end

//VNP.Inventory.ItemNotification:Remove()

function VNP.Inventory:CreateItemNotification(item)

    self.ItemNotifications = self.ItemNotifications or {}
    table.insert(self.ItemNotifications, item)

    if IsValid(self.ItemNotification) then
        self.ItemNotification.AnimShit(self.ItemNotification)
        return 
    end

    self.ItemNotification = vgui.Create("DPanel")
    self.ItemNotification:SetResSize(400,100)
    self.ItemNotification:SetResPos(1920,200)
    self.ItemNotification.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0))

        local item = self.ItemNotifications[1]

        if !item then return end

        local idata = VNP.Inventory:GetItemData(item.Name)

        local name = item.Label or item.Name
        local signature = item.Signature
        local rarity = item.Rarity.Name

        local rcolor = VNP.Inventory:GetRarityValue(rarity, "Color")
        rcolor = IsColor(rcolor) && rcolor or rcolor == "rainbow" && HSVToColor(RealTime() * 20 % 360, 1, 1) or color_white

        if idata && idata.Class then
            name = VNP.Inventory:GetLanguageLabel(idata.Class) or name
        end

        local x,y = VNP:resFormatW(105), VNP:resFormatH(5)

        local tW,tH = VNP:DrawText(name,22,x,y, color_white, 0)

        y = y + tH

        VNP:DrawText(rarity,22,x,y,rcolor,0)
        if signature then
            tW,tH = VNP:GetTextSize(signature, 22)

            VNP:DrawText(signature,22,x,h-tH*1.5,color_white,0)
        end
    end

    self.ItemNotification.AnimShit = function(s)
        if #self.ItemNotifications < 1 then return end

        local x,y = self.ItemNotification:GetPos()
        local w,h = self.ItemNotification:GetSize()

        s:MoveTo(x-w,y,0.8,0,-1,function()
            s:MoveTo(x,y,0.8,3,-1,function()
                if !self.ItemNotifications[1] then return end

                table.remove(self.ItemNotifications, 1)

                s.AnimShit(s)
            end)
        end)
    end

    local sW,sH = VNP:resFormatW(5),VNP:resFormatH(5)

    local invSlot = vgui.Create("VNPInvSlot", self.ItemNotification)
    invSlot:SetResSize(95,95)
    invSlot:Dock(LEFT)
    invSlot:DockMargin(sW,sH,sW,sH)
    invSlot.GetItemData = function(s)
        return self.ItemNotifications[1]
    end

    self.ItemNotification.AnimShit(self.ItemNotification)
end

function VNP.Inventory:OpenEnhanceMenu()

    if !IsValid(g_ContextMenu) then return end

    if IsValid(self.EnhanceMenu) then self.EnhanceMenu:Remove() end

    self.EnhanceMenu = vgui.Create("VNPEnhance", g_ContextMenu)


end

function VNP.Inventory:OpenAdminMenu()

    if IsValid(self.AdminMenu) then self.AdminMenu:Remove() end

    self.AdminMenu = vgui.Create("VNPAdminMenu")

end

function VNP.Inventory:CreateConfirm(title, confirmTitle, declineTitle,func,onClose)
    self.Confirm = vgui.Create("VNPFrame")
    self.Confirm:SetTitle(title)

    local w,h = VNP:resFormatW(300), VNP:resFormatH(75)

    self.Confirm:SetSize(w+w*.045,h)
    self.Confirm:Center()

    confirmTitle = confirmTitle or "Confirm"
    declineTitle = declineTitle or "Decline"

    local confirm = vgui.Create("VNPButton", self.Confirm)
    confirm:SetText(confirmTitle)
    confirm:SetSize(w*.45, h*.5)
    confirm:SetPos(w*.045, h-(h*.55))
    confirm.DoClick = function()
        func()

        self.Confirm:Remove()
    end

    local decline = vgui.Create("VNPButton", self.Confirm)
    decline:SetText(declineTitle)
    decline:SetSize(w*.45, h*.5)
    decline:SetPos(w/2+w*.045, h-(h*.55))
    decline.DoClick = function(s)
        self.Confirm:Remove()       
    end
    
    if onClose then
        self.Confirm.OnRemove = function(s)
            onClose(s)
        end
    end

end

hook.Add("ContextMenuOpened", "VNP.OpenInventory", function()
    VNP.Inventory:OpenInventory()
end)

hook.Add("ContextMenuClosed", "VNP.CloseInventory", function()
    local menuValid = false
    
    if IsValid(VNP.Inventory.EnhanceMenu) then
        VNP.Inventory.EnhanceMenu:SetParent(nil)
        VNP.Inventory.EnhanceMenu.OnRemove = function(s)
            if IsValid(VNP.Inventory.Menu) then VNP.Inventory.Menu:Remove() end
        end
        menuValid = true 
    end
    if IsValid(VNP.Inventory.ItemUpgrades) then
        VNP.Inventory.ItemUpgrades:SetParent(nil)
        VNP.Inventory.ItemUpgrades.OnRemove = function(s)
            if IsValid(VNP.Inventory.Menu) then VNP.Inventory.Menu:Remove() end
        end
        menuValid = true 
    end
    if IsValid(VNP.Inventory.Confirm) then
        VNP.Inventory.Confirm:SetParent(nil)
        VNP.Inventory.Confirm.OnRemove = function(s)
            if IsValid(VNP.Inventory.Menu) then VNP.Inventory.Menu:Remove() end
        end
        menuValid = true
    end

    if IsValid(VNP.Inventory.Menu) && !menuValid then 
        VNP.Inventory.Menu:Remove() 
    elseif menuValid then
        VNP.Inventory.Menu:SetParent(nil)
    end
end)

concommand.Add("inv_adminmenu", function(ply, cmd, args)
    if !ply:IsAdmin() then return end

    VNP.Inventory:OpenAdminMenu()
end)

concommand.Add("inv_testweapons", function(ply, cmd, args)
    if !ply:IsAdmin() then return end

    for k,pl in pairs(player.GetAll()) do
        local wep = pl:GetActiveWeapon()

        if !IsValid(wep) then continue end

        local data = wep:GetItemData()

        if !data then continue end

        PrintTable(data)
    end
end)