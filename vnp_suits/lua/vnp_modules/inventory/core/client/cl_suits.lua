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

VNP:AddNetworkString("VNP.SyncSuit", function(ply, data)
    local suit = data.item

    if !suit then 
        ply:RemoveSuit()
        return 
    end

    ply:SetSuit(suit)
end)

VNP:AddNetworkString("VNP.UpdateSuit", function(ply, data)
    local key = data.key
    local value = data.value

    if !key or !value then return end

    ply:UpdateSuit(key, value)
end)

local heart = Material("icon16/heart.png")
local armor = Material("icon16/shield.png")

local sHealth = 0
local sArmor = 0

local Lerp = Lerp


hook.Add("HUDPaint", "VNP.Suits.DrawHud", function()
    local suit = LocalPlayer():GetSuit()

    if !suit then return end
    
    local sW,sH = ScrW(), ScrH()
    local w,h = VNP:resFormatW(300), VNP:resFormatH(110)


    draw.RoundedBox(7, sW/2-w/2, sH*.015, w,h, Color(0,0,0))

    local tW, tH = VNP:DrawText(suit.Name, 26, sW/2, sH*.015, Color(255,255,255))

    local barX,barY = sW/2-(w*3)/2,sH*.015+tH
    local barW,barH = w*3,h*.2

    local c = 2

    sHealth = Lerp(0.1, sHealth, suit["SuitHealth"])
    sArmor = Lerp(0.1, sArmor, suit["SuitArmor"])

    local suitHealth = math.Round(sHealth)
    local suitArmor = math.Round(sArmor)
    
    local suitMaxHealth = VNP.Inventory:CalculateMaxStat(suit, "SuitHealth")
    local suitMaxArmor = VNP.Inventory:CalculateMaxStat(suit, "SuitArmor")

    draw.RoundedBox(7, barX,barY,barW,barH, Color(0,0,0))
    
    local size = math.Round((suitMaxHealth/(suitMaxHealth+suitMaxArmor))*0.7, 2)

    local healthW =  math.min(suitHealth*(barW*size/suitMaxHealth), barW*size)
    local armorW = math.min(suitArmor*(barW*(1-size)/suitMaxArmor), barW*(1-size))

    draw.RoundedBoxEx(7, barX+c,barY+c, healthW-c*2,barH-c*2, Color(65,198,65),true,false,true,false)
    draw.RoundedBoxEx(7, barX+healthW-c,barY+c, armorW,barH-c*2, Color(1,156,254),false,true,false,true)

    local iconSize = VNP:resFormatH(15)

    VNP:DrawIcon(heart, sW/2-w/2.5,sH*.065,iconSize,iconSize)
    VNP:DrawIcon(armor, sW/2-w/2.5,sH*.09,iconSize,iconSize)

    VNP:DrawText(suitHealth.."/"..suitMaxHealth, 26, sW/2, sH*.06, Color(255,255,255))
    VNP:DrawText(suitArmor.."/"..suitMaxArmor, 26, sW/2, sH*.085, Color(255,255,255))

end)