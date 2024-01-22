if CLIENT then
    net.Receive("SendPlayerWarns", function()
        local warns = net.ReadTable() or {}

        local warnFrame = vgui.Create("DFrame")
        warnFrame:SetSize(300, 200)
        warnFrame:Center()
        warnFrame:SetTitle("Oyuncu Uyarıları")
        warnFrame:SetVisible(true)
        warnFrame:SetDraggable(true)
        warnFrame:ShowCloseButton(true)
        warnFrame:MakePopup()

        local warnList = vgui.Create("DPanelList", warnFrame)
        warnList:SetPos(10, 30)
        warnList:SetSize(280, 160)
        warnList:EnableVerticalScrollbar(true)

        for _, warn in pairs(warns) do
            local warnPanel = vgui.Create("DPanel")
            warnPanel:SetTall(30)

            local warnIDLabel = vgui.Create("DLabel", warnPanel)
            warnIDLabel:SetPos(10, 0)
            warnIDLabel:SetText("ID: " .. warn.id)
            warnIDLabel:SizeToContents()

            local warnReasonLabel = vgui.Create("DLabel", warnPanel)
            warnReasonLabel:SetPos(50, 0)
            warnReasonLabel:SetText("     Sebep: " .. warn.reason)
            warnReasonLabel:SizeToContents()

            warnList:AddItem(warnPanel)
        end
    end)

    net.Receive("OpenWarnMenu", function()
        local frame = vgui.Create("DFrame")
        frame:SetSize(0, 0)
        frame:Center()
        frame:SetTitle("E-Warns Menu")
        frame:SetVisible(true)
        frame:SetDraggable(true)
        frame:ShowCloseButton(true)
        frame:MakePopup()

        frame:SizeTo(400, 300, 1, 0, -1, function()
            frame:MakePopup()
            frame:MoveTo((ScrW() - frame:GetWide()) / 2, (ScrH() - frame:GetTall()) / 2, 1, 0, -1, function()
                local label = vgui.Create("DLabel", frame)
                label:SetPos(10, 30)
                label:SetText("E-Warns Menu içeriği buraya eklenecek.")
                label:SizeToContents()

                local playerList = vgui.Create("DScrollPanel", frame)
                playerList:SetPos(10, 60)
                playerList:SetSize(200, 200)

                local players = player.GetAll()

                for _, player in pairs(players) do
                    local playerName = player:Nick()

                    local playerPanel = playerList:Add("DPanel")
                    playerPanel:SetTall(30)

                    local avatar = vgui.Create("AvatarImage", playerPanel)
                    avatar:SetPos(0, 0)
                    avatar:SetSize(30, 30)
                    avatar:SetPlayer(player, 64)

                    local playerNameLabel = vgui.Create("DLabel", playerPanel)
                    playerNameLabel:SetPos(40, 0)
                    playerNameLabel:SetText(playerName)
                    playerNameLabel:SizeToContents()

                    local panelWidth = playerNameLabel:GetWide() + 50
                    playerPanel:SetWide(math.max(panelWidth, 100))

                    local warnButton = vgui.Create("DButton", playerPanel)
                    warnButton:SetPos(panelWidth - 40, 0)
                    warnButton:SetText("Warns")
                    warnButton:SetSize(40, 30)

                    warnButton.DoClick = function()
                        net.Start("OpenPlayerWarnMenu")
                        net.WriteEntity(player)
                        net.SendToServer()
                    end
                end
            end)
        end)
    end)
end
