local AddOnName, Engine = ...

local AceAddon = LibStub("AceAddon-3.0")
local AddOn = AceAddon:NewAddon(AddOnName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")

Engine[1] = AddOn
Engine[2] = {}
Engine[3] = {}
Engine[4] = {}

_G[AddOnName] = Engine
AddOn.cargBags = Engine.cargBags
AddOn.Base64 = LibStub("LibBase64-1.0")

AddOn.Title = GetAddOnMetadata(AddOnName, 'Title')
AddOn.Author = GetAddOnMetadata(AddOnName, 'Author')
AddOn.Version = GetAddOnMetadata(AddOnName, 'Version')
AddOn.Credits = GetAddOnMetadata(AddOnName, 'X-Credits')

ERR_NOT_IN_RAID = ''

AddOn.SetPerCharVariable = function(varName, value) _G [varName] = value end

AddOn.LocalizedClass, AddOn.Class, AddOn.ClassID = UnitClass("player")
AddOn.ScanTooltip = CreateFrame('GameTooltip', 'DuffedUI_ScanTooltip', _G.UIParent, 'GameTooltipTemplate')
AddOn.PriestColors = {r = 0.86, g = 0.92, b = 0.98, colorStr = "dbebfa"}
AddOn.Color = AddOn.Class == "PRIEST" and AddOn.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[AddOn.Class] or RAID_CLASS_COLORS[AddOn.Class])
AddOn.ClassColor = string.format("|cff%02x%02x%02x", AddOn.Color.r * 255, AddOn.Color.g * 255, AddOn.Color.b * 255)
AddOn.MyClassColor = string.format("|cff%02x%02x%02x", AddOn.Color.r * 255, AddOn.Color.g * 255, AddOn.Color.b * 255)
AddOn.WowPatch, AddOn.WowBuild, AddOn.WowRelease, AddOn.TocVersion = GetBuildInfo()
AddOn.WowBuild = tonumber(AddOn.WowBuild)
AddOn.InfoColor = "|cffC41F3B"
AddOn.SystemColor = "|cffffcc00"
AddOn.GUID = UnitGUID("player")

AddOn.QualityColors = {}
local qualityColors = BAG_ITEM_QUALITY_COLORS
for index, value in pairs(qualityColors) do AddOn.QualityColors[index] = {r = value.r, g = value.g, b = value.b} end
AddOn.QualityColors[-1] = {r = 0, g = 0, b = 0}
AddOn.QualityColors[Enum.ItemQuality.Poor] = {r = .61, g = .61, b = .61}
AddOn.QualityColors[Enum.ItemQuality.Common] = {r = 0, g = 0, b = 0}

AddOn.ClassList = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do AddOn.ClassList[v] = k end
AddOn.ClassColors = {}
local colors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
for class in pairs(colors) do
	AddOn.ClassColors[class] = {}
	AddOn.ClassColors[class].r = colors[class].r
	AddOn.ClassColors[class].g = colors[class].g
	AddOn.ClassColors[class].b = colors[class].b
	AddOn.ClassColors[class].colorStr = colors[class].colorStr
end
AddOn.r, AddOn.g, AddOn.b = AddOn.ClassColors[AddOn.Class].r, AddOn.ClassColors[AddOn.Class].g, AddOn.ClassColors[AddOn.Class].b

BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Poor] = {r = 0.62, g = 0.62, b = 0.62}
BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Common] = {r = 1, g = 1, b = 1}

AddOn.Noop = function() return end

AddOn.AddOns = {}
AddOn.AddOnVersion = {}
for i = 1, GetNumAddOns() do
	local Name = GetAddOnInfo(i)
	AddOn.AddOns[string.lower(Name)] = GetAddOnEnableState(AddOn.Name, Name) == 2 or false
	AddOn.AddOnVersion[string.lower(Name)] = GetAddOnMetadata(Name, 'Version')
end

do
	AddOn.AboutPanel = CreateFrame("Frame", nil, _G.InterfaceOptionsFramePanelContainer)
	AddOn.AboutPanel:Hide()
	AddOn.AboutPanel.name = AddOn.Title
	AddOn.AboutPanel:SetScript("OnShow", function(self)
		if self.show then return end

		local titleInfo = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		titleInfo:SetPoint("TOPLEFT", 16, -16)
		titleInfo:SetText("Info:")

		local subInfo = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subInfo:SetWidth(580)
		subInfo:SetPoint("TOPLEFT", titleInfo, "BOTTOMLEFT", 0, -8)
		subInfo:SetJustifyH("LEFT")
		subInfo:SetText(GetAddOnMetadata("DuffedUI", "Notes"))

		local titleCredits = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		titleCredits:SetPoint("TOPLEFT", subInfo, "BOTTOMLEFT", 0, -8)
		titleCredits:SetText("Credits:")

		local subCredits = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subCredits:SetWidth(580)
		subCredits:SetPoint("TOPLEFT", titleCredits, "BOTTOMLEFT", 0, -8)
		subCredits:SetJustifyH("LEFT")
		subCredits:SetText(GetAddOnMetadata("DuffedUI", "X-Credits"))

		local titleThanks = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		titleThanks:SetPoint("TOPLEFT", subCredits, "BOTTOMLEFT", 0, -16)
		titleThanks:SetText("Special Thanks:")

		local subThanks = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subThanks:SetWidth(580)
		subThanks:SetPoint("TOPLEFT", titleThanks, "BOTTOMLEFT", 0, -8)
		subThanks:SetJustifyH("LEFT")
		subThanks:SetText(GetAddOnMetadata("DuffedUI", "X-Tester"))

		local titleLocalizations = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		titleLocalizations:SetPoint("TOPLEFT", subThanks, "BOTTOMLEFT", 0, -16)
		titleLocalizations:SetText("Author:")

		local subLocalizations = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subLocalizations:SetWidth(580)
		subLocalizations:SetPoint("TOPLEFT", titleLocalizations, "BOTTOMLEFT", 0, -8)
		subLocalizations:SetJustifyH("LEFT")
		subLocalizations:SetText(GetAddOnMetadata("DuffedUI", "Author"))

		local titleButtons = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		titleButtons:SetPoint("TOPLEFT", subLocalizations, "BOTTOMLEFT", 0, -16)
		titleButtons:SetText("Download & Bugreport:")
		
		local buttonGitHub = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")
		buttonGitHub:SetSize(100, 22)
		buttonGitHub:SetPoint("TOPLEFT", titleButtons, "BOTTOMLEFT", 0, -8)
		buttonGitHub:SkinButton()
		buttonGitHub:SetScript("OnClick", function() StaticPopup_Show('DOWNLOAD') end)
		buttonGitHub.Text = buttonGitHub:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		buttonGitHub.Text:SetPoint("CENTER", buttonGitHub)
		buttonGitHub.Text:SetText("|cffffd100".."GitHub".."|r")

		local buttonBugReport = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")
		buttonBugReport:SetSize(100, 22)
		buttonBugReport:SetPoint("LEFT", buttonGitHub, "RIGHT", 6, 0)
		buttonBugReport:SkinButton()
		buttonBugReport:SetScript("OnClick", function() StaticPopup_Show('BUGREPORT') end)
		buttonBugReport.Text = buttonBugReport:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		buttonBugReport.Text:SetPoint("CENTER", buttonBugReport)
		buttonBugReport.Text:SetText("|cffffd100".."Bug Report".."|r")

		local interfaceVersion = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		interfaceVersion:SetPoint("BOTTOMRIGHT", -16, 16)
		interfaceVersion:SetText("Version: "..AddOn.Version)

		self.show = true
	end)

	AddOn.AboutPanel.Commands = CreateFrame( "Frame", nil, AddOn.AboutPanel)
	AddOn.AboutPanel.Commands.name = "Commands"
	AddOn.AboutPanel.Commands:Hide()
	AddOn.AboutPanel.Commands.parent = AddOn.AboutPanel.name

	AddOn.AboutPanel.Questions = CreateFrame( "Frame", nil, AddOn.AboutPanel)
	AddOn.AboutPanel.Questions.name = "Questions"
	AddOn.AboutPanel.Questions:Hide()
	AddOn.AboutPanel.Questions.parent = AddOn.AboutPanel.name
	
	_G.InterfaceOptions_AddCategory(AddOn.AboutPanel)
	_G.InterfaceOptions_AddCategory(AddOn.AboutPanel.Commands)
	_G.InterfaceOptions_AddCategory(AddOn.AboutPanel.Questions)
end

function AddOn.ScanTooltipTextures(clean, grabTextures)
	local textures
	for i = 1, 10 do
		local tex = _G["DuffedUI_ScanTooltipTexture"..i]
		local texture = tex and tex:GetTexture()
		if texture then
			if grabTextures then
				if not textures then textures = {} end
				textures[i] = texture
			end

			if clean then tex:SetTexture() end
		end
	end

	return textures
end

_G.StaticPopupDialogs['BUGREPORT'] = {
	text = "Bugreporting for DuffedUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...)
		self.editBox:SetFocus()
		self.editBox:SetText('https://github.com/liquidbase/DuffedUIv9/issues')
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

_G.StaticPopupDialogs['DOWNLOAD'] = {
	text = "Download latest DuffedUI version",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...)
		self.editBox:SetFocus()
		self.editBox:SetText('https://www.wowinterface.com/downloads/info23668-DuffedUIv9.html')
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

--[[

	The code below works around a issue of the WoD Beta Client 6.0.2 b18934
	on OS X 10.10 where data stored in 'SavedVariablesPerCharacter' variables
	is not reliably restored after exiting and reentering the game if the
	player's name contains 'umlauts'.

	The corresponding bug report can be found under:

		http://eu.battle.net/wow/en/forum/topic/12206010700

	To enable this workaround enter the followin commands into the chat window:

		/script DuffedUIData.usePerCharData = true
		/reload

	The code can be removed once the client issue has been fixed. Only the
	'SetPerCharVariable' part above should stay in for compatibility
	(otherwise all uses of the function must be replaced with an
	assignment statement again).

--]]

local DuffedUIOnVarsLoaded = CreateFrame('Frame')
DuffedUIOnVarsLoaded:RegisterEvent('VARIABLES_LOADED')
DuffedUIOnVarsLoaded:SetScript('OnEvent', function(self, event)
	self:UnregisterEvent('VARIABLES_LOADED')

	if DuffedUIData == nil then DuffedUIData = {} end

	if DuffedUIData.usePerCharData then
		local playerName = UnitName('player') .. '@' .. GetRealmName()

		if DuffedUIData.perCharData ~= nil and DuffedUIData.perCharData[playerName] ~= nil then
			local pcd = DuffedUIData.perCharData[playerName]

			if DuffedUIDataPerChar == nil then DuffedUIDataPerChar = pcd.DuffedUIDataPerChar end
			if ImprovedCurrency == nil then ImprovedCurrency = pcd.ImprovedCurrency end
		end

		local SetPerCharVariable = function(varName, value)
			if DuffedUIData.perCharData == nil then DuffedUIData.perCharData = {} end
			if DuffedUIData.perCharData[playerName] == nil then DuffedUIData.perCharData[playerName] = {} end

			local pcd = DuffedUIData.perCharData[playerName]

			_G [varName] = value
			pcd [varName] = value
		end

		DuffedUI[1].SetPerCharVariable = SetPerCharVariable
	end
end)
