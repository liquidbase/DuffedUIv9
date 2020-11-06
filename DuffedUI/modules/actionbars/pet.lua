local D, C, L = unpack(select(2, ...))

local ab = D['Actions']
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function ab:CreatePetBar()
	local pet = DuffedUIPetBar
	local PetSize = D['petbuttonsize']
	local Spacing = D['buttonspacing']
	local PetActionBarFrame = PetActionBarFrame
	local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns

	PetActionBarFrame:EnableMouse(0)
	PetActionBarFrame:ClearAllPoints()
	--PetActionBarFrame:SetParent(hide)

	for i = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G['PetActionButton'..i]
		Button:SetParent(pet)
		Button:ClearAllPoints()
		Button:SetSize(PetSize, PetSize)
		Button:SetNormalTexture('')
		Button:Show()
		local Icon = _G['PetActionButton'..i..'Icon']
		Icon:SetInside()

		if C['actionbar']['petbarhorizontal'] then
			if i == 1 then 
				Button:SetPoint('TOPLEFT', pet, Spacing, -Spacing) 
			else 
				Button:SetPoint('LEFT', _G['PetActionButton' .. (i - 1)], 'RIGHT', Spacing, 0)
			end
		else
			if (i == 1) then
				Button:SetPoint('TOPLEFT', pet, 'TOPLEFT', Spacing, -Spacing)
			else
				Button:SetPoint('TOP', _G['PetActionButton'..(i - 1)], 'BOTTOM', 0, -Spacing)
			end
		end
		
		if Button:IsEventRegistered('UPDATE_BINDINGS') then Button:UnregisterEvent('UPDATE_BINDINGS') end

		pet:SetAttribute('addchild', Button)
		pet['Button'..i] = Button
	end

	hooksecurefunc('PetActionBar_Update', ab.UpdatePetBar)
	ab:SkinPetButtons()
	RegisterStateDriver(pet, 'visibility', '[@pet,exists,nopossessbar]show;hide')
end