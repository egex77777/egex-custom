local x = Vector(5, 5, 5)
local hue = 0 -- Başlangıç rengi

hook.Add("PostDrawTranslucentRenderables", "RainbowBox", function()
    local activeWeapon = LocalPlayer():GetActiveWeapon()
    if not IsValid(activeWeapon) or activeWeapon:GetClass() ~= "weapon_ak472" then
        return -- Eğer oyuncunun elinde "weapon_ak472" yoksa işlevden çık
    end

    local pos = LocalPlayer():GetEyeTrace().HitPos -- Kutunun çizileceği konum

    hue = (hue + 1) % 360 -- Renk döngüsü için renk tonunu güncelle

    local rainbowColor = HSVToColor(hue, 1, 1) -- HSV renk uzayını kullanarak renk oluştur

    render.SetColorMaterial()

    cam.IgnoreZ(true)
    render.DrawBox(pos, angle_zero, x, -x, rainbowColor) -- Gökkuşağı renklerinde kutu çiz
    cam.IgnoreZ(false)
end)
