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

function ReturnMaterial(skin)
    for k, v in pairs(skins) do
        if skin == k then return v end
    end
end

hook.Add("PlayerDeath", "RipNotificaitons", function(victim, inflictor, attacker)
    if victim:GetSuit() then
        local suit = victim:GetSuit()

        if suit.LSkins then
            local y = suit.LSkins
            x = ReturnMaterial(y)
        else
            x = "No Skin"
        end

        x = x or "No Skin"

        if victim:Nick() == inflictor:Nick() then
            inmfweapon = "Pussy Suicided."
        else
            inmfweapon = inflictor:GetActiveWeapon():GetNick()
        end
        local msg = "**Name:** " .. victim:Nick() .. "\n**Suit:** " .. suit.Name .. "\n **Suit Rarity: **" .. suit.Rarity.Name .. "  \n**Skin**: " .. x .. " \n**Attacker:** " .. inflictor:Nick() .. " \n**Weapon:** " .. inmfweapon
        ripnotif(msg)
    end
end)