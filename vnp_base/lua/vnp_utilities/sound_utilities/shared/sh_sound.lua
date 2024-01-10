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

VNP.Sounds = VNP.Sounds or {}

local PLAYER = FindMetaTable("Player")

local function soundTimer(crc, ply)
    
    if timer.Exists("VNP.Sound."..crc) then return end

    timer.Create("VNP.Sound."..crc, 0.1, 0, function()
        if !VNP.Sounds[crc] then timer.Remove("VNP.Sound."..crc) return end
        
        if !IsValid(ply) then
            VNP.Sounds[crc]:Stop()
            VNP.Sounds[crc] = nil 
            return 
        end

        if VNP.Sounds[crc]:GetState() == 0 then timer.Remove("VNP.Sound."..crc) end
        
        VNP.Sounds[crc]:SetPos(ply:GetPos())
    end)
end

function PLAYER:EmitSoundURL(...)
    local args = {...}
    
    if string.find(args[1], ".mp3") or string.find(args[1], ".wav") then

        local url = args[1]

        local crc = util.CRC(url)

        if !VNP.Sounds[crc] then
            sound.PlayURL ( url, "3d noblock", function(station)
                if ( IsValid( station ) ) then
            
                    station:SetPos(self:GetPos())
                    station:Play()
                    VNP.Sounds[crc] = station
                    
                    soundTimer(crc, self)
                end
            end)
        else
            VNP.Sounds[crc]:SetPos(self:GetPos())
            VNP.Sounds[crc]:SetTime(0)
            VNP.Sounds[crc]:Play()

            soundTimer(crc, self)
        end
    end
end

concommand.Add("EmitSoundTest", function(ply,cmd,args)
    if !IsValid(ply) then return end

    ply:EmitSoundURL("https://www.myinstants.com/media/sounds/nooo.swf.mp3")
end)