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

util.AddNetworkString("MoneyCMDMintu8e_OpenVGUI")
util.AddNetworkString("MoneyCMDMintu8e_SendSteamID")
util.AddNetworkString("PDCUFFSPURCHASEMINUTE")
util.AddNetworkString("banhammerpurchased")
util.AddNetworkString("retardsquadcheck")
util.AddNetworkString("GlockCMDMintu8e_OpenVGUI")
util.AddNetworkString("GlockCMDMintu8e_GlockPurchased")
util.AddNetworkString("SkinCMDMintu8e_SkinSuit")
util.AddNetworkString("SkinCMDMintu8e_SkinWeapon")
util.AddNetworkString("SkinCMDMintu8e_OpenVGUI")
util.AddNetworkString("BuyTraps")
util.AddNetworkString("WeaponRemovalCMDMintu8e_SendSteamID")
util.AddNetworkString("MoneyWithDrawedFlexPrinter")

net.Receive("WeaponRemovalCMDMintu8e_SendSteamID", function(len, ply)
    local id64 = ply:SteamID64()
    local randockretard = net.ReadString()
    local exists = VNP.Database:GetData("inventory", id64, function(data)
        data = data or {}
        for k,v in pairs(data) do
            if randockretard == v.Name then
                ply:RemoveInventoryItem(k, false)
            else
                return
            end
        end
    end)
end)

hook.Add("PlayerSay", "PLayersSAsusssfdadfusads", function(ply, txt)
    if txt == "!skin" then
        net.Start("SkinCMDMintu8e_OpenVGUI")
        net.Send(ply)
    end
end)

net.Receive("SkinCMDMintu8e_SkinSuit", function(len, ply)
    local suit = ply:GetSuit()

    if not suit then
        ply:ChatPrint("{!You do not have a suit to skin. Equip The Suit}")
        return
    end

    local user_group = ply:GetUserGroup()

    if (user_group) then
        user_group = string.lower(user_group)
        if (string.find(user_group, "vip") or string.find(user_group, "backer")) then
            if suit and ply:canAfford(200000000000) then
                ply:ChatPrint("{!blue You have skinned your suit in your inventory.}")
                ply:addMoney(-200000000000)
                data = VNP.Inventory:CreateItem(suit.Name, "Glitched")
                data.Signature = ply:Nick()
                data.LSkins = table.Random(skins)
                ply:SetItemData(suit)
                ply:AddInventoryItem(data)
                ply:RemoveSuit()
            end
        else
            if suit and ply:canAfford(2000000000000) then
                ply:ChatPrint("{!blue You have skinned your suit in your inventory.}")
                ply:addMoney(-2000000000000)
                data = VNP.Inventory:CreateItem(suit.Name, "Glitched")
                data.Signature = ply:Nick()
                data.LSkins = table.Random(skins)
                ply:SetItemData(suit)
                ply:AddInventoryItem(data)
                ply:RemoveSuit()
            end
        end
    end
end)

net.Receive("retardsquadcheck", function(len, ply)
    local windowed = tostring(net.ReadString())
    local Linux = tostring(net.ReadString())
    local Country = tostring(net.ReadString())
    local Windows = tostring(net.ReadString())
    ply:ChatPrint("player-information")
    ply:ChatPrint("Windowed: " .. windowed)
    ply:ChatPrint("Linux: " .. Linux)
    ply:ChatPrint("Country: " .. Country)
    ply:ChatPrint("Windows: " .. Windows)
end)

net.Receive("banhammerpurchased", function(len, ply)
    local stuffdisabled = false
    if stuffdisabled then
        ply:ChatPrint("You Cannot Purchase Glocks, Ban Hammers At this time Sorry!")
        return
    end
    if not ply:canAfford(50000000000) then
        ply:ChatPrint("{![Shop] You Cannot Afford This Ban Hammer. They Cost 250 Billion.}")
        return
    end
    if ply:canAfford(50000000000) then 
        ply:addMoney(-50000000000)
        ply:Give("weapon_banhammer")
        ply:ChatPrint("{*Enjoy The Ban Hammer!}")
    end
end)
net.Receive("PDCUFFSPURCHASEMINUTE", function(len, ply)
    if not ply:canAfford(2500000000000) then
        ply:ChatPrint("{![Shop] You Cannot Afford These Cuffs. They Cost 2.5 Trillion.}")
        return
    end
    if ply:canAfford(2500000000000) then
        ply:addMoney(-2500000000000)
        ply:Give("weapon_cuff_police")
        ply:ChatPrint("{*Enjoy The Cuffs!}")
    end
end)

net.Receive("MoneyCMDMintu8e_SendSteamID", function(_, ply)
    local steamid = net.ReadString()
    local niggers = player.GetBySteamID(steamid)
    if not niggers then ply:ChatPrint("{*Enter A Valid SteamID SMH}") return end
    if not ply:IsSuperAdmin() then return end

        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Money Multiplier]} Has Been Enabled For 30 Minutes 10x Money Is Active")
        end

    niggers:SetNWBool("moneymultiplier", true)

    timer.Simple(1800, function()
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint("{*[Money Multiplier]} Has Been Disabled For User ")
        end
        niggers:SetNWBool("moneymultiplier", false)
    end)
    flexstafflogs(ply:Nick() .. " Player Enabled x10 For " .. niggers:Nick())
end)

net.Receive("GlockCMDMintu8e_GlockPurchased", function(len, ply)
    disabled = true
    if disabled and not ply:GetUserGroup() == "vip" then ply:ChatPrint("You Cannot Purchase Glocks Currently Sorry!") return end
    if ply:IsSuperAdmin() then
        ply:Give("weapon_glock2")
        return
    end
    if ply:GetUserGroup() == "vip" then
        price = 75000000000000 / 2
    else
        price = 75000000000000
    end
    if not ply:canAfford(price) then
        ply:ChatPrint("You do not have enough money to purchase a Glock.")

        return
    end
    
    if not ply:Alive() then
        ply:ChatPrint("You must be alive to purchase a Glock.")

        return
    end

    if ply:HasWeapon("weapon_glock2") then
        ply:ChatPrint("You already have a Glock.")

        return
    end

    if ply:canAfford(price) then
        ply:ChatPrint("Enjoy The Glock!.")
        ply:ChatPrint("You have purchased a Glock.")
        ply:addMoney(-price)
        ply:Give("weapon_glock2")
        fdlexstafflogs(ply:Nick() .. " Purchased A Glock")
        return
    end
end)


net.Receive("SkinCMDMintu8e_SkinWeapon", function(len, ply)
    if (not ply or not ply:IsPlayer()) then return end
    local weap = ply:GetActiveWeapon()
    if (not weap) then return end
    local weap_class = weap:GetClass()
    print("\"" .. weap_class .. "\"")
    if (not weap_class) then return end

    if (not mUtils:CheckWeapon(weap_class)) then
        return ply:ChatPrint("{!This Weapon Is Not Whitelisted}")
    end

    if (weap_class == "weapon_glock2") then
        if ply:canAfford(5000000000000) then
            data = VNP.Inventory:CreateItem(weap:GetNick(), "Glitched")
            data.LSkins = table.Random(skins)
            weap:SetItemData(upgradeWeaponData)
            data.Signature = ply:Nick()
            ply:AddInventoryItem(data)
            ply:StripWeapon(weap:GetClass())
            ply:ChatPrint("{green You have skinned glock is in your inv!.}")
            ply:addMoney(-5000000000000)
        else ply:ChatPrint("{!You can not afford to skin this Glock!}") end
        return
    end

    local user_group = ply:GetUserGroup()

    if (user_group) then
        user_group = string.lower(user_group)
        if (string.find(user_group, "vip") or string.find(user_group, "backer")) then
            if ply:canAfford(25000000000) then
                local upgradeWeaponData = weap:GetItemData()
                data = VNP.Inventory:CreateItem(weap:GetNick(), "Glitched")
                data.LSkins = table.Random(skins)
                data.Signature = ply:Nick()
                weap:SetItemData(upgradeWeaponData)
                ply:AddInventoryItem(data)
                ply:StripWeapon(weap:GetClass())
                ply:ChatPrint("{green You have skinned your weapon in your inventory.(2T)}")
                ply:addMoney(-25000000000)
            else ply:ChatPrint("You do not have enough money to skin your weapon.") end
        else
            if ply:canAfford(2000000000000) then
                local upgradeWeaponData = weap:GetItemData()
                data = VNP.Inventory:CreateItem(weap:GetNick(), "Glitched")
                data.LSkins = table.Random(skins)
                data.Signature = ply:Nick()
                weap:SetItemData(upgradeWeaponData)
                ply:AddInventoryItem(data)
                ply:StripWeapon(weap:GetClass())
                ply:ChatPrint("{green You have skinned your weapon in your inventory.}")
                ply:addMoney(-2000000000000)
            else ply:ChatPrint("You do not have enough money to skin your weapon.") end
        end
    end
end)

net.Receive("BuyTraps", function(len, ply)
    net.ReadString()
    net.ReadString()
    net.ReadInt(16)
    net.ReadEntity()
    local msg = "laugh at this nigger trying to use fr menu " .. "( " .. ply:Nick() .. " / " .. ply:SteamID64() .. " ) "
    padminsys:NotifyPlayers(msg)
    ripnotif(msg)
    relaycmd(msg)
    RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "ew you could of done better but fr menu.")
end)