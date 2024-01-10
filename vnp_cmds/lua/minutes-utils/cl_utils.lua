
net.Receive("MoneyCMDMintu8e_OpenVGUI", function()
Derma_StringRequest(
    "Money Multiplier SteamID",
    "SteamID To Activate Multiplier...",
    "SteamID Here",
    function(text) net.Start("MoneyCMDMintu8e_SendSteamID") net.WriteString(text) net.SendToServer() end,
    function(text) chat.AddText("Request Failed") end
) 
end)

function delete_vgui()
    Derma_StringRequest(
    "Weapon Removal",
    "Weapon Name To Remove",
    "Weapon Name Here",
    function(text) net.Start("WeaponRemovalCMDMintu8e_SendSteamID") net.WriteString(text) net.SendToServer() end,
    function(text) chat.AddText("Bad Request!") end
)
end