CreditStore.Config.ChatCommands = {
    ["!shop"] = true,
    ["/shop"] = true, 
    ["/market"] = true, 
    ["!kredimarket"] = true, 
    ["/kredimarket"] = true,
    ["!kredi"] = true, 
    ["/kredi"] = true
}

CreditStore.Config.Colors = {
    weapon = Color(55, 55, 55),
    special = Color(75, 75, 75),
    super = Color(199, 172, 40),
}

CreditStore.Config.Categories = {
    ["Kalıcı Silahlar"] = {
		order = 1,	
        color = CreditStore.Config.Colors.special,
    },
    ["Silahlar"] = {
		order = 2,	
        color = CreditStore.Config.Colors.special,
    },
    ["Meslekler"] = {
		order = 3,	
        color = CreditStore.Config.Colors.special,
    },
    ["Eşyalar"] = {
		order = 4,		 
        color = CreditStore.Config.Colors.special,
    },
}

hook.Add("loadCustomDarkRPItems", "CreditStore.LoadConfigItems", function()
    CreditStore.Config.Items = {
        ["Kalıcı Silahlar"] = {
            {
                name = "Glock",
                type = "perma_weapon",
                desc = "Sana Perma Glock Verir",
                price = 300,
				box = 1,
                color = CreditStore.Config.Colors.weapon,
                class = "weapon_glock2" 
            },
        },
        ["Silahlar"] = { -- Category name
            {
                name = "AK-47",
                type = "weapon",
                desc = "Sana AK-27 verir",
                price = 200,
				box = 2,				
                color = CreditStore.Config.Colors.weapon,
                class = "weapon_ar2",
                display_path = "https://i.imgur.com/BEFXydL.png"
            }
        },
        ["Meslekler"] = {
            {
                name = "Meslek Adı",
                type = "job",
                desc = "Sana meslek için izin verir",
                price = 500,
				box = 1,								
                color = CreditStore.Config.Colors.weapon,
                class = TEAM_PTHIEF, -- buraya mesleğin Teamını yazın örnek: TEAM_HIRSIZ
                model ="models/player/monk.mdl"
            },
        },
        ["Eşyalar"] = {
            {
                name = "Rocket Boots",
                type = "entity",
                desc = "Senin için entity spawnlar",
                price = 1,
				box = 2,								
                color = CreditStore.Config.Colors.weapon,
                class = "wt_rocketboots"
            },
        },
    }
end)

CreditStore.Config.ExchangePrice = 20000 -- bu her bir kredi için değişim fiyatı