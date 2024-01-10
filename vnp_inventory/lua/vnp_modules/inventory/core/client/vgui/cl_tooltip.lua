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

hook.Add("InitPostEntity", "VNP.OverwriteTooltip", function()
    DTooltip.Paint = function(s,w,h)
        draw.RoundedBox(5,0,0,w,h,Color(30,30,34,255))
    
        if s:GetFGColor() ~= color_white then
            s:SetFGColor(color_white)
        end
    end
    
    DTooltip.Init = function(s)
        s:SetDrawOnTop( true )
        s.DeleteContentsOnClose = false
        s:SetText("")
        s:SetFont("VNP.Font.22")
    
    end
end)