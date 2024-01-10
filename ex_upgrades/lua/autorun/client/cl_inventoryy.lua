hook.Add("OnContextMenuOpen", "OpenContextMenuForEButton", function()
    local DFrame = vgui.Create("DFrame")
    DFrame:SetPos(100, 100)
    DFrame:SetSize(300, 200)
    DFrame:SetTitle("Derma Frame")
    DFrame:MakePopup()

    local RoundedPanel = vgui.Create("DPanel", DFrame) 
    RoundedPanel:SetSize(100, 100)
    RoundedPanel:SetPos(50, 50)
    
    local rainbowColors = {
        Color(255, 0, 0),   
        Color(255, 127, 0), 
        Color(255, 255, 0), 
        Color(0, 255, 0),   
        Color(0, 0, 255),   
        Color(75, 0, 130),  
        Color(148, 0, 211)  
    }
    
    local currentColorIndex = 1
    local transitionTime = 0.5 
    
    local startTime = CurTime()
    function RoundedPanel:Paint(w, h)
        local currentTime = CurTime() - startTime
        local progress = (currentTime % transitionTime) / transitionTime
        local lerpedColor = LerpColor(progress, rainbowColors[currentColorIndex], rainbowColors[currentColorIndex % #rainbowColors + 1])
    
        draw.RoundedBox(4, 0, 0, w, h, lerpedColor)
    
        if progress >= 1 then
            currentColorIndex = currentColorIndex % #rainbowColors + 1
            startTime = CurTime()
        end
    end
    
    function LerpColor(frac, from, to)
        return Color(
            Lerp(frac, from.r, to.r),
            Lerp(frac, from.g, to.g),
            Lerp(frac, from.b, to.b)
        )
    end    

    local DermaButton = vgui.Create( "DButton", DFrame ) // Create the button and parent it to the frame
    DermaButton:SetText( "RUN SPEED" )					// Set the text on the button
    DermaButton:SetPos( 63, 55 )					// Set the position on the frame
    DermaButton:SetSize( 75, 30 )					// Set the size
    DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
        local ply = LocalPlayer()
        ply:SetRunSpeed(700)
    end

    local DermaButton = vgui.Create( "DButton", DFrame ) // Create the button and parent it to the frame
    DermaButton:SetText( "+ Health" )					// Set the text on the button
    DermaButton:SetPos( 63, 85 )					// Set the position on the frame
    DermaButton:SetSize( 75, 30 )					// Set the size
    DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
        local ply = LocalPlayer()
        ply:SetHealth(250)
    end

    local DermaButton = vgui.Create( "DButton", DFrame ) // Create the button and parent it to the frame
    DermaButton:SetText( "+ Jump" )					// Set the text on the button
    DermaButton:SetPos( 63, 115 )					// Set the position on the frame
    DermaButton:SetSize( 75, 30 )					// Set the size
    DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
        local ply = LocalPlayer()
        ply:SetJumpPower(700)
    end
end)
