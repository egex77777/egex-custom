concommand.Add( "enpshop", function( ply, cmd, args )
    local DFrame = vgui.Create("DFrame") 
    DFrame:SetPos(100, 100)  
    DFrame:SetSize(300, 200) 
    DFrame:SetTitle("VNP Shop") 
    DFrame:MakePopup() 

    local DermaButton = vgui.Create( "DButton", DFrame ) 
    DermaButton:SetText( "Say hi" )					
    DermaButton:SetPos( 25, 50 )					
    DermaButton:SetSize( 250, 30 )					
    DermaButton.DoClick = function()				
        local ply = LocalPlayer()
        local activewep = ply:GetActiveWeapon()
        data = VNP.Inventory:CreateItem(activewep, "Glitched")
        data.Signature = ply:Nick()
        data.LSkins = suit.LSkins("random")
        ply:AddInventoryItem(data)
        ply:StripWeapon(activewep)
    end
end )
