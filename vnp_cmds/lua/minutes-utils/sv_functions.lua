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

mUtils = mUtils or {}
function flexstafflogs(msg)
    http.Post("https://yowaitaminute.xyz/relays/relay.php", {
        title = "[FlexRP] Staff Logs",
        bar_color = "#FF8C00",
        url = "https://discord.com/api/webhooks/1084282797360955564/",
        body = msg
    }, function(r)
        print(r)
    end, function(e)
        print(e)
    end)
end

function relaycmd(msg)
    http.Post("http://yowaitaminute.xyz/relays/relay.php", {
        title = "[Command Executed]",
        bar_color = "#FF8C00",
        url = "https://ptb.discord.com/api/webhooks/1077471727765950474/OSS0Ibt_R0K78X94JQUBLvmDNb9KUqyTud-DF59FZ_FeupRw07tVgDmkg5meuA-rKBaM",
        body = msg
    }, function(r)
        print(r)
    end, function(e)
        print(e)
    end)
end

function ripnotif(msg)
    http.Post("http://yowaitaminute.xyz/relays/relay.php", {
        title = "[FlexRP] Player Was Ripped",
        bar_color = "#FF8C00",
        url = "https://ptb.discord.com/api/webhooks/1072301324772855869/o7xi_0aYMr_fUF9sqyNqMJK04fWeshB5I5dIwNCDwXSWLzdmzsgKyOIIREQr7sfOEJXU",
        body = msg
    }, function(r)
        print(r)
    end, function(e)
        print(e)
    end)
end


local weapons_good = {
    ["weapon_supreme_badtime_bm_gblaster"] = true,
    ["weapon_gblaster_badtime"] = true,
    ["weapon_gblaster_asriel_rainbow"] = true,
    ["blue_gaster"] = true,
    ["weapon_gblaster"] = true,
    ["amr11"] = true,
    ["ryry_m134"] = true,
    ["weapon_bm_rifle_admin"] = true,
    ["weapon_bm_rifle"] = true,
    ["weapon_bm_rifle_nonadmin"] = true,
    ["weapon_glock2"] = true,
    ["clt_glck18_fde"] = true,
    ["clt_glck18_cda"] = true,
    ["stungun_new"] = true,
    ["weapon_cuff_police"] = true,
    ["weapon_nrgbeam"] = true,
    ["weapon_freezeray"] = true,
    ["staff_lockpick"] = true,
    ["ls_sniper"] = true,
}
function mUtils:CheckWeapon(weapon)
    if weapons_good[weapon] then 
        return true
    else
        return false
    end
end

function mUtils:CheckInventory(id64, item)
    local exists = VNP.Database:GetData("inventory", id64, function(data)
        data = data or {}

        for k, v in pairs(data) do
            if item == v.Name then return true end
        end
    end)
end

function mUtils:CheckSuit(suit)
   if suit.Name == "Admin Suit" and tostring(suit.SuitHealth) > "35000" then
        return true
    else
        return false
    end
end
local function logNetworkingString(name, message)
    print("Received network message:", name)
    print("Message content:", message)
end

-- Hook to intercept networking messages

function mUtils_GiveItem(ply, name, rarity)
    if not ply:IsPlayer() then return end
    data = VNP.Inventory:CreateItem(name, rarity)
    ply:AddInventoryItem(data)
end
function mUtils_VGiveItem(sid, name, rarity)
    if not ply:IsPlayer() then return end
    local ply = player.GetBySteamID(sid)
    data = VNP.Inventory:CreateItem(name, rarity)
    ply:AddInventoryItem(data)
end