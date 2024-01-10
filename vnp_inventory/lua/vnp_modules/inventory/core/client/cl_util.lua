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

VNP.Inventory = VNP.Inventory or {}

function VNP.Inventory:MoveItem(itemSlot, toSlot, isUpgrade)
	if IsValid(self.EnhanceMenu) then return end
	if IsValid(self.ItemUpgrades) then return end
	isUpgrade = isUpgrade or false
	VNP:Broadcast("VNP.MoveItem", {slot1 = itemSlot, slot2 = toSlot, isUpgrade = isUpgrade})
end

local function GenerateView(Panel) -- Credits to Portalgod
	local PrevMins, PrevMaxs = Panel.Entity:GetRenderBounds()
	Panel:SetCamPos(PrevMins:Distance(PrevMaxs)*Vector(0.75, 0.75, 0.5))
	Panel:SetLookAt((PrevMaxs + PrevMins)/2)
end

VNP.IconCache = VNP.IconCache or {}
hook.Add("InitPostEntity", "LordSugar:BestDev", function()
	if file.Exists("materials/invitems/", "GAME") then
		local files, directories = file.Find("materials/invitems/*", "GAME")
		for k, v in ipairs(files) do
			local class = string.StripExtension(v)
			VNP.IconCache[class] = v
		end
	end
end)

local function Icon(class, x, y, w, h, parent, model, col, mat, bone)
    parent.itemModel = vgui.Create("DImage", parent)
	parent.itemModel:SetSize(w, h)
	parent.itemModel:SetPos(x, y)
	parent.itemModel:SetImage("invitems/"..VNP.IconCache[class])
	return parent.itemModel
end

local function ModelPanel(class, x, y, w, h, parent, model, col, mat, bone)
	parent.itemModel = vgui.Create("DModelPanel", parent)
	parent.itemModel:SetSize(w, h)
	parent.itemModel:SetPos(x, y)
	parent.itemModel:SetModel(model)

	if !parent.itemModel.Entity then
		parent.itemModel:Remove()
	    return false
    end

	parent.itemModel.Think = function()
		if !parent.itemModel.Entity then return end
		local color = parent.itemModel.Entity:GetColor()
		parent.itemModel:SetColor(Color(color.r,color.g,color.b, 255))
		parent.itemModel.Entity:SetRenderMode(RENDERMODE_TRANSALPHA)
	end

	if mat then
		parent.itemModel.Entity:SetMaterial(mat)
	end

	if col then
		parent.itemModel.Entity:SetColor(col)
	end
	parent.itemModel:SetMouseInputEnabled(false)

	local mn, mx = parent.itemModel.Entity:GetRenderBounds()
	local size = h
	size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
	parent.itemModel:SetFOV(bone and 52 or 67)

	if bone and parent.itemModel then
		centre = parent.itemModel.Entity:GetBonePosition(parent.itemModel.Entity:LookupBone(bone))
		local PrevMins, PrevMaxs = parent.itemModel.Entity:GetRenderBounds()
		parent.itemModel:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.75, 0, 0.5))
		parent.itemModel:SetLookAt(centre)
		parent.itemModel.Entity:SetEyeTarget(PrevMins:Distance(PrevMaxs) * Vector(0.75, 0, 0.5))
	else
		GenerateView(parent.itemModel)
	end

	parent.itemModel.LayoutEntity = function(ent) end
	return parent.itemModel
end

function VNP.Inventory:CreateModel(class, x, y, w, h, parent, model, col, mat, bone)
    if VNP.IconCache[class] then
        Icon(class, x, y, w, h, parent, model, col, mat, bone)
    else
        ModelPanel(class, x, y, w, h, parent, model, col, mat, bone)
    end
    return parent.itemModel
end