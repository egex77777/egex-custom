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

function PANEL:Init()
    self:SetDrawOnTop(true)
    self:SetAutoDelete(true)
    self:SetResSize(550,300)
    
end

function PANEL:Paint(w,h) -- Welp this is where the code starts to become spaghetti but its aight
    draw.RoundedBox(5,0,0,w,h,Color(15,15,17,255))

    if !self._itemData then return end
    if !self.rData then return end

    local altDown = input.IsKeyDown(KEY_LALT)

    local spacer = VNP:resFormatH(10)

    local name = self._itemData.Label or self._itemData.Name
    local kills = self._itemData.Kills or 0
    local amount = self._itemData.Amount or 1
    local uid = self._itemData.UID or math.random(9999)
    local sig = self._itemData.Signature
    local rarity = self._itemData.Rarity.Name
    local rColor = IsColor(self.rData.Color) && self.rData.Color or self.rData.Color == "rainbow" && HSVToColor(RealTime() * 20 % 360, 1, 1) or color_white
    local x,y = 0,spacer
    local tW,tH = 0,0

    if self.iData.Class then
        name = VNP.Inventory:GetLanguageLabel(self.iData.Class) or name
    end
    
    if altDown && sig then name = name.." / "..sig end

    if amount > 1 then name = amount.."x "..name end

    tW,tH = VNP:DrawText(name, 26, w/2, y, color_white, 1)
    y=y+tH
    
    if self._itemData.UID then
        VNP:DrawText(uid, 30, w*.1, y, color_white, 0)
    else
        local color = HSVToColor(RealTime() * 20 % 360, 1, 1)
        VNP:DrawText(uid, 30, w*.1, y, color, 0)
    end

    if self.HasKillCounter then
        tW,tH = VNP:GetTextSize(kills.." kills", 30)
        VNP:DrawText(kills.." kills", 30, w*.9-tW, y, color_white, 3)
    end

    local lskintext = ""
    if self._itemData.LSkins and self._itemData.LSkins ~= "" then
        lskintext = " - "..string.Replace(self._itemData.LSkins, "models/skins/")
        lskintext = " - "..string.Replace(self._itemData.LSkins, "models/skins/", " ")
        lskintext = string.upper(lskintext)
    end
    tW,tH = VNP:DrawText(rarity..lskintext, 26, w/2, y*1.1, rColor, 1)
    y=y+tH+spacer*0.5

    if self.iData.Description then
        local str = self.iData.Description

        tW,tH = VNP:DrawText(str, 18, w/2, y, color_white, 1)
        y=y+tH
    end


    --if self._itemData.Type ~= "GEM" then
        for stat,val in SortedPairsByValue(self.Stats, true) do
            local label = VNP.Inventory:GetLanguageLabel(stat) or stat
            local suffix = VNP.Inventory:GetLanguageSuffix(stat) or "%"
            local prefix = VNP.Inventory:GetLanguagePrefix(stat) or "+"
            local col = self._itemData.Type == "UPGRADEGEM" && Color(0,200,0) or Color(255,50,50)
            
            if !label then continue end

            tW,tH = VNP:DrawText(label, 22, w*.1, y+spacer*1.5, color_white, 0)


            if self._itemData.Type ~= "SUIT" then
                VNP:DrawText(prefix..val..suffix, 26, w*.9, y+spacer*1.5, col, 2)
            end
            
            if self._itemData.Type == "WEAPON" && self.iData.Modifiers[stat] then
                local v = self.iData.Modifiers[stat] > 0.99 and self.iData.Modifiers[stat] or 1
                VNP:DrawText(v, 26, w*.6, y+spacer*1.5, color_white, 2)
            end

            if self._itemData.Type == "SUIT" && self.iData.BaseModifiers[stat] then
                local v = (istable(self.iData.BaseModifiers[stat]) && self.iData.BaseModifiers[stat].val) or (isnumber(self.iData.BaseModifiers[stat]) && self.iData.BaseModifiers[stat])

                if v then
                    v = v * (1+val/100)
                    VNP:DrawText(v, 26, w*.9, y+spacer*1.5, color_white, 2)
                else
                    VNP:DrawText(val..suffix, 26, w*.9, y+spacer*1.5, color_white, 2)
                end
            end

            y=y+tH+(spacer*0.5)
        end
    --else
    --end

    if self._itemData.Sockets && #self._itemData.Sockets > 0 && (self._itemData.Type == "WEAPON" or self._itemData.Type == "SUIT") then
        local hasGems = false
        for s,g in ipairs(self._itemData.Sockets) do
            if g then hasGems = true break end
        end

        if hasGems then
            tW,tH = VNP:DrawText("Equipped Gems", 24, w/2, y+spacer*2.5, color_white, 1)
            VNP:DrawText("Info - Hold Alt", 18, w*.9, y+spacer*2.5+(tH/4), Color(120,120,120), 2)
            y=y+tH+(spacer*.5)

            local swap = true

            for socket, gem in ipairs(self._itemData.Sockets) do
                if !gem then continue end

                local color = VNP.Inventory:GetRarityValue(gem.Rarity.Name, "Color") or Color(120,120,120)
                color = IsColor(color) && color or color == "rainbow" && HSVToColor(RealTime() * 20 % 360, 1, 1) or Color(120,120,120)
                
                swap = !swap
                tW,tH = VNP:GetTextSize(gem.Name, 20)
                VNP:DrawText(gem.Name, 20, swap && w*.65+tW or w*.1+tW, y+spacer*2.5, color, 2)

                
                if altDown then
                    local mods = VNP.Inventory:GetItemData(gem.Name, "Modifiers")
                    
                    if mods[self._itemData.Rarity.Name] then
                        mods = mods[self._itemData.Rarity.Name]
                    end

                    local tPos = swap && w*.65+tW+spacer or w*.1+tW+spacer

                    if gem.Modifiers then
                        for stat,mod in pairs(gem.Modifiers) do
                            local t = VNP.Inventory:GetLanguageType(stat)

                            if t && t ~= self._itemData.Type then continue end

                            VNP:DrawText("("..mod.."%)", 20, tPos, y+spacer*2.5, Color(255,50,50), 0)

                            break
                        end
                    end
                end
                if swap then
                    y=y+tH+(spacer*0.25)
                end
            end
            y = y + spacer*0.45 + tH
        end
    end

    if y ~= self:GetTall() then
        self:SetTall(y*1.15)
    end
    
end

function PANEL:SetItemData(data)
    self._itemData = data

    self.Stats = {}

    if self._itemData.Rarity.Modifiers then
        for stat,val in pairs(self._itemData.Rarity.Modifiers) do
            self.Stats[stat] = val
        end
    end
    
    if self._itemData.Sockets then
        self.GemCount = 0
        for socket,gem in pairs(self._itemData.Sockets) do
            if !gem then continue end

            self.GemCount = self.GemCount+1

            if gem.Name == "Kill Counter" then self.HasKillCounter = true end

            if !gem.Modifiers then continue end

            for stat,val in pairs(gem.Modifiers) do
                if !self.Stats[stat] then continue end

                local rVal = gem.Modifiers[stat]

                if rVal then
                    local mod = val*(1+rVal/100)
                    self.Stats[stat] = self.Stats[stat]+mod
                end
            end
        end
    end

    if self._itemData.Modifiers then
        for stat,val in pairs(self._itemData.Modifiers) do
            self.Stats[stat] = val
        end
    end
    self.iData = VNP.Inventory:GetItemData(self._itemData.Name)
    self.rData = VNP.Inventory:GetRarity(self._itemData.Rarity.Name)
end

function PANEL:Think()

    local x,y = self:GetPos()
    local height = self:GetTall()

    if y+height > ScrH() then self:SetPos(x,ScrH()-height-5) end

    if !IsValid(self._parent) then self:Remove() end

    if !ispanel(self._parent) then return end

    if self._parent && !self._itemData then self:Remove() end
    if !vgui.CursorVisible() then self:Remove() end
    if !self._parent:IsVisible() then self:Remove() end
end

vgui.Register( "VNPItemInfo", PANEL, "DPanel")