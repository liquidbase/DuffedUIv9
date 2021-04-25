local D, C, L = unpack(select(2, ...))
if not C['cooldown']['rcdenable'] then return end

local anchor = 'TOPLEFT'
local x, y = 150, -150
local width, height = 200, 15
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local texture = C['media']['normTex']

local show = {
	raid = C['cooldown']['rcdraid'],
	party = C['cooldown']['rcdparty'],
}

local spells = {
	[633] = 600,		-- Lay on Hands
	[740] = 180,		-- Tranq
	[1022] = 300,		-- Hand of Protection
	[6940] = 120,		-- Hand of Sacrifice
	[20484] = 600,		-- Rebirth
	[20707] = 600,		-- Soulstone res
	[22812] = 60,		-- Barkskin
	[31821] = 180,		-- Aura Mastery
	[32182] = 300,		-- Heroism
	[33206] = 180,		-- Pain Supp
	[47788] = 180,		-- GS
	[51052] = 120,		-- Anti-Magic Zone
	[61999] = 600,		-- Raise Ally
	[62618] = 180,		-- Power Word:Barrier
	[64843] = 180,		-- Divine Hymn
	[76577] = 180,		-- Smoke Bomb
	[80353] = 300,		-- Time Warp
	[90355] = 360,		-- Ancient Hysteria
	[97462] = 180,		-- Rallying Cry
	[98008] = 180, 		-- Spirit Link
	[102342] = 60,		-- Ironbark
	[108280] = 180,		-- Healing Tide Totem
	[108281] = 120,		-- Ancestral Guidance
	[109964] = 60,		-- Spirit Shell
	[114028] = 30,		-- Mass Spell Reflection
	[114030] = 120,		-- Vigilance
	[115176] = 180, 	-- Zen Meditation
	[115310] = 180, 	-- Revival
	[124974] = 90,		-- Nature's Vigil
	[126393] = 600,		-- Eternal Guardian
	[152256] = 300, 	-- Storm Elemental Totem
	[159916] = 120,		-- Amplify Magic
	[172106] = 180, 	-- Aspect of the Fox
}

local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local band = bit.band
local sformat = string.format
local floor = math.floor
local timer = 0
local move = D['move']
local backdrop = {
	bgFile = C['media']['normTex'],
	edgeFile = C['media']['blank'], tile = false,
	tileSize = 0,
	edgeSize = 1,
	insets = {top = 0, left = 0, bottom = 0, right = 0},
}

local bars = {}

local rcda = CreateFrame('Frame', 'RaidCoolodownsMover', UIParent)
rcda:SetSize(width, height)
rcda:SetPoint(anchor, x, y)
move:RegisterFrame(rcda)

local FormatTime = function(time) 
	if time >= 60 then return sformat('%.2d:%.2d', floor(time / 60), time % 60) else return sformat('%.2d', time) end
end

local CreateFS = CreateFS or function(frame)
	local fstring = frame:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
	fstring:SetFont(f, fs, ff)
	fstring:SetShadowColor(0, 0, 0, 1)
	fstring:SetShadowOffset(0.5, -0.5)
	return fstring
end

local CreateBG = CreateBG or function(parent)
	local bg = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	bg:SetPoint('TOPLEFT', parent, 'TOPLEFT', -1, 1)
	bg:SetPoint('BOTTOMRIGHT', parent, 'BOTTOMRIGHT', 1, -1)
	bg:SetFrameStrata('LOW')
	bg:SetBackdrop(backdrop)
	bg:SetTemplate('Default')
	return bg
end

local UpdatePositions = function()
	for i = 1, #bars do
		bars[i]:ClearAllPoints()
		if i == 1 then bars[i]:SetPoint('TOPLEFT', rcda, 'TOPLEFT', 0, 0) else bars[i]:SetPoint('TOPLEFT', bars[i-1], 'BOTTOMLEFT', 0, -5) end
		bars[i].id = i
	end
end

local StopTimer = function(bar)
	bar:SetScript('OnUpdate', nil)
	bar:Hide()
	tremove(bars, bar.id)
	UpdatePositions()
end

local BarUpdate = function(self, elapsed)
	local curTime = GetTime()
	if self.endTime < curTime then
		StopTimer(self)
		return
	end
	self.status:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
	self.right:SetText(FormatTime(self.endTime - curTime))
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
	GameTooltip:AddLine(self.spell, self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function(self) GameTooltip:Hide() end

local OnMouseDown = function(self, button)
	if button == 'LeftButton' then
		if IsInRaid() then
			SendChatMessage(sformat('Cooldown - %s [%s] %s', self.left:GetText(), self.spell, self.right:GetText()), 'RAID')
		elseif IsInGroup() then
			SendChatMessage(sformat('Cooldown - %s [%s] %s', self.left:GetText(), self.spell, self.right:GetText()), 'PARTY')
		else
			SendChatMessage(sformat('Cooldown - %s [%s] %s', self.left:GetText(), self.spell, self.right:GetText()), 'SAY')
		end
	elseif button == 'RightButton' then
		StopTimer(self)
	end
end

local CreateBar = function()
	local bar = CreateFrame('Frame', nil, UIParent)
	bar:SetSize(width, height)
	bar.status = CreateFrame('Statusbar', nil, bar)
	bar.icon = CreateFrame('button', nil, bar)
	bar.icon:SetSize(15, 15)
	bar.icon:SetPoint('BOTTOMLEFT', 0, 0)
	bar.status:SetPoint('BOTTOMLEFT', bar.icon, 'BOTTOMRIGHT', 3, 0)
	bar.status:SetPoint('BOTTOMRIGHT', 0, 0)
	bar.status:SetHeight(height)
	bar.status:SetStatusBarTexture(texture)
	bar.status:SetMinMaxValues(0, 100)
	bar.status:SetFrameLevel(bar:GetFrameLevel()-1)

	bar.left = CreateFS(bar)
	bar.left:SetPoint('LEFT', bar.status, 2, 0)
	bar.left:SetJustifyH('LEFT')

	bar.right = CreateFS(bar)
	bar.right:SetPoint('RIGHT', bar.status, -2, 0)
	bar.right:SetJustifyH('RIGHT')

	CreateBG(bar.icon)
	CreateBG(bar.status)
	return bar
end	

local StartTimer = function(name, spellId)
	local spell, rank, icon = GetSpellInfo(spellId)
	for _, v in pairs(bars) do 
		if v.name == name and v.spell == spell then return end
	end
	local bar = CreateBar()
	bar.endTime = GetTime() + spells[spellId]
	bar.startTime = GetTime()
	bar.left:SetText(name)
	bar.name = name
	bar.right:SetText(FormatTime(spells[spellId]))
	if icon and bar.icon then
		bar.icon:SetNormalTexture(icon)
		bar.icon:GetNormalTexture():SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
	bar.spell = spell
	bar:Show()

	local color = RAID_CLASS_COLORS[select(2, UnitClass(name))]
	bar.status:SetStatusBarColor(color.r, color.g, color.b)
	bar:SetScript('OnUpdate', BarUpdate)
	bar:EnableMouse(true)
	bar:SetScript('OnEnter', OnEnter)
	bar:SetScript('OnLeave', OnLeave)
	bar:SetScript('OnMouseDown', OnMouseDown)
	tinsert(bars, bar)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == 'COMBAT_LOG_EVENT_UNFILTERED' then
		local timestamp, eventType, _, sourceGUID, sourceName, sourceFlags = ...
		if eventType == 'SPELL_RESURRECT' or eventType == 'SPELL_CAST_SUCCESS' or eventType == 'SPELL_AURA_APPLIED' then
			local spellId = select(12, ...)
			if spells[spellId] and show[select(2, IsInInstance())] then StartTimer(sourceName, spellId) end
		end
	end
end

local addon = CreateFrame('frame')
addon:SetScript('OnEvent', OnEvent)
addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
addon:RegisterEvent('ZONE_CHANGED_NEW_AREA')