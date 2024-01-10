local function PrintRainbowText(frequency, str)
    local text = {}

    for i = 1, #str do
        text[#text + 1] = HSVToColor(i * frequency % 360, 1, 1)
        text[#text + 1] = string.sub(str, i, i)
    end

    chat.AddText(unpack(text))
end

concommand.Add("duyuru", function(ply, _, args)
    if not ply:IsSuperAdmin() then
        return
    end

    local announcement = table.concat(args, " ")
    PrintRainbowText(10, announcement)
end)
