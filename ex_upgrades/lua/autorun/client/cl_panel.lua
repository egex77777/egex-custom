concommand.Add( "upgrades", function( ply, cmd, args )
    local DFrame = vgui.Create("DFrame") 
    DFrame:SetPos(100, 100) 
    DFrame:SetSize(300, 200) 
    DFrame:SetTitle("Derma Frame") 
    DFrame:MakePopup() 

    local DermaButton = vgui.Create( "DButton", DFrame ) // Create the button and parent it to the frame
    DermaButton:SetText( "Elindeki Silahını Yükselt" )					// Set the text on the button
    DermaButton:SetPos( 25, 50 )					// Set the position on the frame
    DermaButton:SetSize( 250, 30 )					// Set the size
    DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
	RunConsoleCommand( "upgrade" )			// Run the console command "say hi" when you click it ( command, args )
    end
end )

local DermaButton = vgui.Create("DButton") 
DermaButton:SetText("Silahını Yükselt") 
DermaButton:SetPos(25, 50) 
DermaButton:SetSize(250, 30) 
DermaButton.DoClick = function() 
    RunConsoleCommand("upgrades") 
end 

local DermaButton = vgui.Create("DButton") 
DermaButton:SetText("Admin Menü") 
DermaButton:SetPos(25, 80) 
DermaButton:SetSize(250, 30) 
DermaButton.DoClick = function() 
    RunConsoleCommand("sam", "menu") 
end 

local function DrawRainbowBox(x, y, width, height)
    local corners = {
        { x = x, y = y },
        { x = x + width, y = y },
        { x = x + width, y = y + height },
        { x = x, y = y + height }
    }

    for i = 1, #corners do
        local startAngle = (SysTime() * 100 + i * 90) % 360
        local endAngle = startAngle + 90

        local gradient = i * 90 / 360
        local color = HSVToColor(startAngle, 1, 1)

        surface.SetDrawColor(color)
        surface.DrawPoly({
            { x = corners[i].x, y = corners[i].y },
            { x = corners[i % #corners + 1].x, y = corners[i % #corners + 1].y },
            { x = corners[(i % #corners + 2) % #corners + 1].x, y = corners[(i % #corners + 2) % #corners + 1].y },
            { x = corners[(i % #corners + 3) % #corners + 1].x, y = corners[(i % #corners + 3) % #corners + 1].y }
        })
    end
end

hook.Add("HUDPaint", "HUDPaint_DrawRainbowBox", function()
    local x, y, width, height = 25, 45, 250, 250
    DrawRainbowBox(x, y, width, height)
    local text = "Side Roleplay"
    surface.SetFont("DermaDefault")
    local textWidth, textHeight = surface.GetTextSize(text)
    draw.DrawText(text, "DermaDefault", x + width / 2 - textWidth / 2, y + height / 2 - textHeight / 2, color_white, TEXT_ALIGN_LEFT)
end)



