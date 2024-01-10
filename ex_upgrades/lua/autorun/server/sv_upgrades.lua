include("autorun/config.lua")

local function ChangeWeaponDamage(ply, cmd, args)
    if IsValid(ply) and ply:IsPlayer() then
        local weapon = ply:GetActiveWeapon() 
        if IsValid(weapon) and weapon:IsWeapon() then
            local currentDamage = ply:GetNWInt("CustomWeaponDamage") or 0
            local additionalDamage = tonumber(args[1]) or 25
            
            if currentDamage < 75 then
                local newDamage = math.min(currentDamage + additionalDamage, 75)
                ply:SetNWInt("CustomWeaponDamage", newDamage)
                ply:addMoney(-money_cost)
                ply:ChatPrint("Weapon damage has been successfully UPDATED. new damage: " .. newDamage)
            else
                ply:ChatPrint("The weapon has already reached maximum damage.")
            end
        else
            ply:ChatPrint("You do not have an active weapon or it is not a weapon.")
        end
    end
end


concommand.Add("upgrade", ChangeWeaponDamage)


