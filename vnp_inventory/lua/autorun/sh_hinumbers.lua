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

--some shit nigger made this "Victorious Networks" takes to part inn this addon
if SERVER then
    util.AddNetworkString("Snx:HitMarkers:Send")

    hook.Add("EntityTakeDamage", "Snx:Hitmarker:OnTakeDamage", function(target, dmginfo)
        target.infoHit = target.infoHit or {}
        local hits = {}
        hits.p = dmginfo:GetReportedPosition() + target:GetPos() + Vector(math.random(40) - 20, math.random(40) - 20, math.random(20) + 80)
        hits.s = target.infoHit.status
        hits.n = math.floor(dmginfo:GetDamage())
        hits.c = target.infoHit.color

        if dmginfo:GetAttacker() and dmginfo:GetAttacker():IsPlayer() then
            net.Start("Snx:HitMarkers:Send")
            net.WriteTable(hits)
            net.Send(dmginfo:GetAttacker())
        end

        target.infoHit = {}
    end)
end

Snx = Snx or {}
Snx.Config = Snx.Config or {}

Snx.Config = {
    Time = 3.5, -- Seconds that the damage is displayed
    Font = "Roboto Medium",
    FontSize = 36,
    FontWeight = 500
}