local D, C, L = unpack(select(2, ...))

local DataTexts = D['DataTexts']

local MenuFrame = CreateFrame('Frame', 'DataTextToggleDropDown', UIParent, 'UIDropDownMenuTemplate')
local Anchors = DataTexts.Anchors
local Menu = DataTexts.Menu
local Active = false
local CurrentFrame

DataTexts.Toggle = function(self, object) CurrentFrame:SetData(object) end
DataTexts.Remove = function() CurrentFrame:RemoveData() end

local function OnMouseDown(self)
	CurrentFrame = self
	
	EasyMenu(Menu, MenuFrame, 'cursor', 0, 0, 'MENU', 2)
end

function DataTexts:ToggleDataPositions()
	if Active then
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]

			Frame:EnableMouse(false)
			Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0)
		end

		Active = false
	else
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]

			Frame:EnableMouse(true)
			Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0.2)
			Frame:SetScript('OnMouseDown', OnMouseDown)
		end

		Active = true
	end
end

tinsert(Menu, {text = '|cffFF0000'..REMOVE..'|r', notCheckable = true, func = DataTexts.Remove})
tinsert(Menu, {text = '', notCheckable = true})

SlashCmdList.DATATEXT = function(msg)
	local DataText = D['DataTexts']

	if msg == 'reset' then 
		DataText:Reset()
		ReloadUI()
	elseif msg == 'toggle' then
		DataText:ToggleDataPositions()
	end
end

if D['IsAddOnEnabled']('Details') then SLASH_DATATEXT1 = '/datatext' else SLASH_DATATEXT1 = '/dt' end