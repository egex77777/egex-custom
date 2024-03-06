concommand.Add("cs_givecredits", function(ply, cmd, args)
    local user = args[1]
    local amt = args[2]
    if not user then return print("You have to specify player") end
    if amt and not tonumber(amt) then return print("Amount has to be a number") end
    amt = tonumber(amt) or 0

    for _, ply in ipairs(player.GetAll()) do
        if string.find(ply:Nick(), user) then
            user = ply
            break
        end
    end

    print(amt)
    print(type(amt))
    CreditStore.AddPlayerCredits(user, amt)
end)