net.Receive("CreditStore.SyncCredits", function(len)
    local ply = LocalPlayer()
    local perma_weps = net.ReadTable()
    local perma_jobs = net.ReadTable()
    local credits = net.ReadInt(32)

    ply.CS_PermaWeapons = perma_weps or {}
    ply.CS_PermaJobs = perma_jobs or {}
    ply.CS_Credits = credits
end)

net.Receive("CreditStore.NotifyPurchase", function()
    local itemName = net.ReadString()

    surface.SetFont("CreditStore.PlyInfo")
    local titleW, titleH = surface.GetTextSize("Item Bought!")

    surface.SetFont("CreditStore.ItemDesc")
    local descW, descH = surface.GetTextSize("You successfully purchased")

    local youSure = vgui.Create("EditablePanel")
    youSure:SetSize(ScrW() * .35, ScrH() * .2)
    youSure:Center()
    youSure:MakePopup()
    youSure.Paint = function(me, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(15, 15, 15))
        draw.SimpleText("Item bought!", "CreditStore.PlyInfo", w / 2, 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("You successfully purchased", "CreditStore.ItemDesc", w / 2, 8 + titleH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText(itemName, "CreditStore.ItemDesc", w / 2, 12 + titleH + descH, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local ok = youSure:Add("DButton")
    ok:Dock(BOTTOM)
    ok:SetText("")
    ok:SetTall(ScrH() * .08)
    ok:DockMargin(8, 8, 8, 8)
    ok.Paint = function(me, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 0, 0))

        draw.SimpleText("OK", "CreditStore.PlyInfo", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    ok.DoClick = function(me)
        youSure:Remove()
    end
end)

net.Receive("CreditStore.OpenMenu", function()
    local frame = vgui.Create("CreditStore.Menu")
end)