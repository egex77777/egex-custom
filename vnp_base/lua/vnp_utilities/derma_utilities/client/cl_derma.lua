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

VNP.Images = VNP.Images or {}
VNP.PreCacheStarted = {}
local surface_CreateFont = surface.CreateFont
local draw_RoundedBox, FindMetaTable, Material, render_UpdateScreenEffectTexture, ScrW, ScrH, surface_DrawTexturedRect, surface_SetDrawColor, surface_SetMaterial, isbool, vgui_GetControlTable, istable, func, pairs, print, IsValid, Color, SysTime = draw.RoundedBox, FindMetaTable, Material, render.UpdateScreenEffectTexture, ScrW, ScrH, surface.DrawTexturedRect, surface.SetDrawColor, surface.SetMaterial, isbool, vgui.GetControlTable, istable, func, pairs, print, IsValid, Color, SysTime

local math_min, math_max = math.min, math.max

function VNP:resFormatW(v)
	return v/1920*ScrW()
end

function VNP:resFormatH(v)
	return v/1080*ScrH()
end

function VNP:FormatNumber(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
  

function VNP:GlowColor(col1, col2, mod)
    local newr = col1.r + ((col2.r - col1.r) * (mod))
    local newg = col1.g + ((col2.g - col1.g) * (mod))
    local newb = col1.b + ((col2.b - col1.b) * (mod))

    return Color(newr, newg, newb)
end

function VNP:RandomChoice(...)
	local args = {...}

	return args[math.random(#args)]
end

for i = 12, 46, 2 do
	surface_CreateFont( "VNP.Font." .. i, {size = VNP:resFormatW(i), weight = 600, font = "Roboto Medium"} )
	surface_CreateFont( "VNP.Font." .. i ..".Shadow", {size = VNP:resFormatW(i), weight = 600, antialias = true, extended = true, blursize = 2,  font = "Roboto Medium"} )
end

hook.Add("OnScreenSizeChanged", "VNP.UpdateFonts", function()
	for i = 12, 46, 2 do
		surface_CreateFont( "VNP.Font." .. i, {size = VNP:resFormatW(i), weight = 600, font = "Roboto Medium"} )
		surface_CreateFont( "VNP.Font." .. i ..".Shadow", {size = VNP:resFormatW(i), weight = 600, antialias = true, extended = true, blursize = 2,  font = "Roboto Medium"} )
	end
end)

local PANEL = FindMetaTable("Panel")
local blur = Material("pp/blurscreen")

function PANEL:DrawBlur( amount )
	local x, y = self:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface_SetDrawColor( 255, 255, 255 )
	surface_SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
		blur:Recompute()
		render_UpdateScreenEffectTexture()
		surface_DrawTexturedRect(x * -1,y * -1, scrW, scrH)
	end
end

function PANEL:SetResSize(w,h)
	self:SetSize(VNP:resFormatW(w),VNP:resFormatH(h))
end

function PANEL:SetResPos(x,y)
	self:SetPos(VNP:resFormatW(x),VNP:resFormatH(y))
end

function PANEL:GetChildrenRecursive()
	local children = {}
	for _, pnl in ipairs(self:GetChildren()) do
		table.insert(children, pnl)

		local cChildren = pnl:GetChildrenRecursive()

		if #cChildren > 0 then
			for _,pl in ipairs(cChildren) do
				table.insert(children, pl)
			end
		end
	end

	return children
end

function PANEL:IsHoveredRecursive()
	if self:IsHovered() then return true end

	for _,pnl in ipairs(self:GetChildrenRecursive()) do
		if pnl:IsHovered() then return true end
	end
	return false
end

function PANEL:DrawLine(x1, y1, x2, y2, col)
	col = col or Color(255,255,255,150)
	surface_SetDrawColor(col)
	surface.DrawLine( x1, y1, x2, y2 )
end

function PANEL:ShouldDrawBlur(bool)
	self.m_bShouldDrawBlur = bool == true
end

function PANEL:SetRainbowText(bool)
	if bool and !self.olPaint then
		self.olPaint = self.Paint
		self.Paint = function(s,w,h)
			s.olPaint(s,w,h)

			local colour = HSVToColor(RealTime() * 20 % 360, 1, 1)

			self:SetFGColor(colour.r, colour.g, colour.b, colour.a)
		end
	elseif self.olPaint then
		self.Paint = self.olPaint
		self.olPaint = nil
	end
end

function PANEL:SetFadeText(bool, col1, col2)
	if bool and !self.olPaint then
		self.olPaint = self.Paint
		
		self.m_col1 = col1
		self.m_col2 = col2

		self.Paint = function(s,w,h)
			s.olPaint(s,w,h)

			local colour = VNP:GlowColor(s.m_col1, s.m_col2, math.abs(math.sin((RealTime() - 0.08) * 2)))

			self:SetFGColor(colour.r, colour.g, colour.b, colour.a)
		end
	elseif self.olPaint then
		self.Paint = self.olPaint
		self.olPaint = nil
		s.m_col1 = nil 
		s.m_col2 = nil
	end
end

function PANEL:SetBackground(bool, mat)
	if bool and !self.olPaint then
		if !mat then return end

		self.BGMaterial = mat

		self._OWPaint = true

		self.olPaint = self.Paint
		
		self.Paint = function(s,w,h)
			if IsValid(s.BGMaterial) then
				VNP:DrawIcon(s.BGMaterial,0,0,w,h)
			end

			s.olPaint(s,w,h)
		end
	elseif self.olPaint then
		self.Paint = self.olPaint

		self.olPaint = nil
	end
end

function VNP:ScaleRes(aW, aH, bW, bH) -- Scaling the resolution of an image... to fit within any dimensions perfectly
	local nW, nH

	local r = math_min((math_min(aW, bW)/math_max(aW,bW)), (math_min(aH, bH)/math_max(aH,bH)))

	nW, nH = aW*r, aH*r

	local posX, posY = (bW-nW)/2, (bH-nH)/2

	return nW, nH, posX, posY, r
end

function VNP:DrawIcon(Material, posX, posY, sizeW, sizeH)
	surface_SetDrawColor( 255, 255, 255 )
	surface_SetMaterial(Material)
	surface_DrawTexturedRect(posX, posY, sizeW, sizeH)
end

function VNP:GetMaterial( url )
	local crc = util.CRC( url ) .. ".png"
	if self.Images[crc] then return self.Images[crc] end	

	if file.Exists("vnp_imgs/" .. crc, "DATA") then
		self.Images[crc] = Material("data/vnp_imgs/" .. crc, "smooth noclamp")
		return self.Images[crc]
	else
		return self:PreCacheMaterial(url, crc)
	end
end
	
function VNP:PreCacheMaterial( url, crc )
	if not crc then
		crc = util.CRC(url) .. ".png"
	end

	if not file.Exists("vnp_imgs", "DATA") then
		file.CreateDir("vnp_imgs")
	end

	if not self.PreCacheStarted[crc] then
		self.PreCacheStarted[crc] = true	
		http.Fetch(url, function(body, size, headers, code)
			if body:find( "^.PNG" ) then
				file.Write("vnp_imgs/" .. crc, body)
				self.Images[crc] = Material( "data/vnp_imgs/" .. crc, "smooth noclamp" )	
				return self.Images[crc]
			end
		end)
	end	

	return nil
end

function VNP:DrawGradient(mat, x, y, w, h, color)
	surface.SetDrawColor(Color(color.r,color.g,color.b,color.a))
	surface.SetMaterial(mat)
	surface.DrawTexturedRect( x, y, w, h )
end

function VNP:GetTextSize(text, size)
	surface.SetFont("VNP.Font."..size)
	return surface.GetTextSize(text)
end

function VNP:DrawText(text, size, posX, posY, Colour, t)

	t = t or 1

	local Colour = Colour or Color(255,255,255)
	draw.DrawText(text, "VNP.Font."..size..".Shadow", posX-1, posY-1, Color(0,0,0), t)
	draw.DrawText(text, "VNP.Font."..size..".Shadow", posX+1, posY+1, Color(0,0,0), t)
	draw.DrawText(text, "VNP.Font."..size, posX, posY, Colour, t)
	
	return self:GetTextSize(text, size)
end

function VNP:Darken(color, amount)

	local r,g,b,a = math.Clamp(color.r-amount, 0, 255), math.Clamp(color.g-amount, 0, 255), math.Clamp(color.b-amount, 0, 255), color.a

	return IsColor(color) and Color(r,g,b,a) or color
end