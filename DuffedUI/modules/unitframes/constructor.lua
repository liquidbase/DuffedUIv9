local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local layout = C['unitframes'].style.Value
local width = C['raid']['framewidth']
local height = C['raid']['frameheight']
local move = D['move']
local frameScale = C['general']['uiscale']

D['ConstructUF'] = function(self, unit)
	if not unit then return end
	local parent = self:GetParent():GetName()

	if unit == 'player' then
		D['ConstructUFPlayer'](self)
	elseif unit == 'target' then
		D['ConstructUFTarget'](self)
	elseif unit == 'targettarget' then
		D['ConstructUFToT'](self)
	elseif unit == 'pet' then
		D['ConstructUFPet'](self)
	elseif unit == 'focus' then
		D['ConstructUFFocus'](self)
	elseif unit == 'focustarget' then
		D['ConstructUFFocusTarget'](self)
	elseif unit:find('arena%d') then
		D['ConstructUFArena'](self)
	elseif unit:find('boss%d') then
		D['ConstructUFBoss'](self)
	elseif (unit:find('raid') or unit:find('raidpet%d')) then
		if parent:match('Party') then D['ConstructUFParty'](self) else D['ConstructUFRaid'](self) end
	elseif (self:GetParent():GetName():match'oUF_MainTank' or self:GetParent():GetName():match'oUF_MainAssist') then
		D['ConstructUFMaintank'](self)
	elseif unit:match('nameplate') then
		D['ConstructNameplates'](self)
	end
end

D['SpawnUF'] = function(self)
	local player = oUF:Spawn('player', 'oUF_Player')
	player:SetParent(oUFDuffedUI_PetBattleFrameHider)
	player:Point('BOTTOM', UIParent, 'BOTTOM', -340, 245)
	player:Size(218, 44)
	move:RegisterFrame(player)

	local target = oUF:Spawn('target', 'oUF_Target')
	target:SetParent(oUFDuffedUI_PetBattleFrameHider)
	target:Point('BOTTOM', UIParent, 'BOTTOM', 340, 245)
	target:Size(218, 44)
	move:RegisterFrame(target)

	local tot = oUF:Spawn('targettarget', 'oUF_TargetTarget')
	if layout == 1 then
		if C['raid']['center'] then tot:Point('TOPRIGHT', oUF_Target, 'BOTTOMLEFT', 129, -2) else tot:Point('TOPRIGHT', oUF_Target, 'BOTTOMLEFT', 0, -2) end
		tot:Size(129, 23)
	elseif layout == 2 then
		tot:Point('TOPLEFT', oUF_Target, 'BOTTOMLEFT', -3, -16)
		tot:Size(142, 16)
	elseif layout == 3 then
		tot:Point('TOPRIGHT', oUF_Target, 'BOTTOMRIGHT', 1, -5)
		tot:Size(129, 20)
	elseif layout == 4 then
		tot:Point('TOPRIGHT', oUF_Target, 'BOTTOMRIGHT', 2, -5)
		tot:Size(100, 25)
	end
	move:RegisterFrame(tot)

	local pet = oUF:Spawn('pet', 'oUF_Pet')
	pet:SetParent(oUFDuffedUI_PetBattleFrameHider)
	if layout == 1 then
		if C['raid'].center then pet:Point('TOPLEFT', oUF_Player, 'BOTTOMRIGHT', -129, -2) else pet:Point('TOPLEFT', oUF_Player, 'BOTTOMRIGHT', 0, -2) end
		pet:Size(129, 23)
	elseif layout == 2 then
		pet:Point('TOPRIGHT', oUF_Player, 'BOTTOMRIGHT', 3, -16)
		pet:Size(142, 16)
	elseif layout == 3 then
		pet:Point('TOPLEFT', oUF_Player, 'BOTTOMLEFT', -1, -5)
		pet:Size(129, 20)
	elseif layout == 4 then
		pet:Point('TOPLEFT', oUF_Player, 'BOTTOMLEFT', -2, -5)
		pet:Size(100, 25)
	end
	move:RegisterFrame(pet)

	local focus = oUF:Spawn('focus', 'oUF_Focus')
	focus:SetParent(oUFDuffedUI_PetBattleFrameHider)
	focus:Point('BOTTOMLEFT', InvDuffedUIActionBarBackground, 'BOTTOM', 275, 500)
	focus:Size(200, 30)
	move:RegisterFrame(focus)

	local focustarget = oUF:Spawn('focustarget', 'oUF_FocusTarget')
	focustarget:SetParent(oUFDuffedUI_PetBattleFrameHider)
	focustarget:Point('TOPRIGHT', focus, 'BOTTOMLEFT', 0, -2)
	focustarget:Size(75, 10)
	move:RegisterFrame(focustarget)

	if C['raid']['showboss'] then
		for i = 1, MAX_BOSS_FRAMES do
			local t_boss = _G['Boss' .. i .. 'TargetFrame']
			t_boss:UnregisterAllEvents()
			t_boss.Show = D['Dummy']
			t_boss:Hide()
			_G['Boss' .. i .. 'TargetFrame' .. 'HealthBar']:UnregisterAllEvents()
			_G['Boss' .. i .. 'TargetFrame' .. 'ManaBar']:UnregisterAllEvents()
		end

		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = oUF:Spawn('boss' .. i, 'oUF_Boss' .. i)
			boss[i]:SetParent(oUFDuffedUI_PetBattleFrameHider)
			if i == 1 then boss[i]:Point('RIGHT', UIParent, 'RIGHT', -163, -250) else boss[i]:Point('BOTTOM', boss[i - 1], 'TOP', 0, 35) end
			boss[i]:Size(200, 27)
			move:RegisterFrame(boss[i])
		end
	end

	if C['raid']['arena'] then
		local arena = {}
		for i = 1, 5 do
			arena[i] = oUF:Spawn('arena' .. i, 'oUF_Arena' .. i)
			arena[i]:SetParent(oUFDuffedUI_PetBattleFrameHider)
			if i == 1 then arena[i]:Point('RIGHT', UIParent, 'RIGHT', -163, -250) else arena[i]:Point('BOTTOM', arena[i - 1], 'TOP', 0, 35) end
			arena[i]:Size(200, 27)
			move:RegisterFrame(arena[i])
		end

		local oUF_PrepArena = {}
		local backdrop = {
			bgFile = C['media']['blank'],
			insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
		}

		for i = 1, 5 do
			--local arena = _G['oUF_Arena'..i]

			oUF_PrepArena[i] = CreateFrame('Frame', 'oUF_PrepArena' .. i, UIParent, 'BackdropTemplate')
			if i == 1 then oUF_PrepArena[i]:SetPoint('RIGHT', UIParent, 'RIGHT', -163, -250) else oUF_PrepArena[i]:SetPoint('BOTTOM', oUF_PrepArena[i - 1], 'TOP', 0, 35) end
			oUF_PrepArena[i]:SetBackdrop(backdrop)
			oUF_PrepArena[i]:SetBackdropColor(0, 0, 0)
			oUF_PrepArena[i].Health = CreateFrame('StatusBar', nil, oUF_PrepArena[i])
			oUF_PrepArena[i].Health:SetAllPoints()
			oUF_PrepArena[i].Health:SetStatusBarTexture(C['media']['normTex'])
			oUF_PrepArena[i].Health:SetStatusBarColor(.3, .3, .3, 1)
			oUF_PrepArena[i].SpecClass = oUF_PrepArena[i].Health:CreateFontString(nil, 'OVERLAY')
			oUF_PrepArena[i].SpecClass:SetFont(f, fs, ff)
			oUF_PrepArena[i].SpecClass:Point('CENTER', oUF_PrepArena[i].Health)
			oUF_PrepArena[i]:Hide()
		end

		function Prep()
			if event == 'ARENA_OPPONENT_UPDATE' then
				for i = 1, 5 do
					local f = _G['oUF_PrepArena' .. i]
					f:Hide()
				end
			else
				local numOpps = GetNumArenaOpponentSpecs()

				for i = 1, 5 do
					local f = _G['oUF_PrepArena' .. i]
					
					if (i <= numOpps) then
						local specID = GetArenaOpponentSpec(i)
						if (specID and specID > 0) then 
							local _, spec, _, _, _, class = GetSpecializationInfoByID(specID)
							if class and spec then
								f.SpecClass:SetText(spec .. '  -  ' .. LOCALIZED_CLASS_NAMES_MALE[class])
								if not C['unitframes']['unicolor'] then
									local color = arena[i].colors.class[class]
									f.Health:SetStatusBarColor(unpack(color))
								end
								f:Show()
							end
						else
							f:Hide()
						end
					end
				end
			end
		end

		local ArenaListener = CreateFrame('Frame', 'oUF_UIArenaListener', UIParent)
		ArenaListener:RegisterEvent('PLAYER_ENTERING_WORLD')
		ArenaListener:RegisterEvent('ARENA_PREP_OPPONENT_SPECIALIZATIONS')
		ArenaListener:RegisterEvent('ARENA_OPPONENT_UPDATE')
		ArenaListener:SetScript('OnEvent', Prep)
	end

	local assisttank_width = 90
	local assisttank_height  = 20
	if C['raid']['maintank'] then
		local tank = oUF:SpawnHeader('oUF_MainTank', nil, 'raid',
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(assisttank_width, assisttank_height),
			'showRaid', true,
			'groupFilter', 'MAINTANK',
			'yOffset', 7,
			'point' , 'BOTTOM',
			'template', 'oUF_DuffedUIMtt'
		)
		tank:SetParent(oUFDuffedUI_PetBattleFrameHider)
		if C['chat']['rbackground'] then tank:Point('TOPLEFT', DuffedUIChatBackgroundRight, 'TOPLEFT', 2, 57) else tank:Point('TOPLEFT', ChatFrame4, 'TOPLEFT', 2, 62) end
		move:RegisterFrame(oUF_MainTank)
	end

	if C['raid']['mainassist'] then
		local assist = oUF:SpawnHeader('oUF_MainAssist', nil, 'raid',
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(assisttank_width, assisttank_height),
			'showRaid', true,
			'groupFilter', 'MAINASSIST',
			'yOffset', 7,
			'point' , 'BOTTOM',
			'template', 'oUF_DuffedUIMtt'
		)
		assist:SetParent(oUFDuffedUI_PetBattleFrameHider)
		if C['raid']['maintank'] then assist:Point('TOPLEFT', oUF_MainTank, 'BOTTOMLEFT', 2, -50) else assist:Point('CENTER', UIParent, 'CENTER', 0, 0) end
		move:RegisterFrame(oUF_MainAssist)
	end

	if C['raid']['enable'] then
		local layout = C['raid']['raidlayout']['Value']

		if layout == 'heal' then
			local ra = CreateFrame('Frame', 'RaidAnchor', UIParent)
			ra:SetSize(D['Scale'](D['InfoLeftRightWidth']), 15)
			local raid = oUF:SpawnHeader('oUF_Heal', nil, 'solo,raid,party',
				'oUF-initialConfigFunction', [[
					local header = self:GetParent()
					self:SetWidth(header:GetAttribute('initial-width'))
					self:SetHeight(header:GetAttribute('initial-height'))
				]],
				'initial-width', D['Scale'](width),
				'initial-height', D['Scale'](height),
				'showPlayer', C['raid']['showplayerinparty'],
				'showSolo', C['unitframes']['showsolo'],
				'showParty', true,
				'showRaid', true, 
				'xoffset', D['Scale'](8),
				'yOffset', D['Scale'](1),
				'groupFilter', '1,2,3,4,5,6,7,8',
				'groupingOrder', '1,2,3,4,5,6,7,8',
				'groupBy', 'GROUP',
				'maxColumns', 8,
				'unitsPerColumn', 5,
				'columnSpacing', D['Scale'](12), -- -3
				'point', 'LEFT',
				'columnAnchorPoint', 'BOTTOM'
			)
			raid:SetParent(oUFDuffedUI_PetBattleFrameHider)
			raid:SetPoint('BOTTOMLEFT', ra, 'BOTTOMLEFT', 0, 0)
			if DuffedUIChatBackgroundLeft then ra:Point('BOTTOMLEFT', DuffedUIChatBackgroundLeft, 'TOPLEFT', 2, 8) else ra:Point('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', 2, 33) end
			move:RegisterFrame(RaidAnchor)

			if C['raid']['showraidpets'] then
				local rpet = oUF:SpawnHeader('oUF_RaidPet', 'SecureGroupPetHeaderTemplate', 'solo,raid,party',
					'oUF-initialConfigFunction', [[
						local header = self:GetParent()
						self:SetWidth(header:GetAttribute('initial-width'))
						self:SetHeight(header:GetAttribute('initial-height'))
					]],
					'initial-width', D['Scale'](C['raid']['framewidth']),
					'initial-height', D['Scale'](C['raid']['frameheight']),
					'showRaid', C['raid']['showraidpets'],
					'showParty', C['raid']['showraidpets'],
					'xOffset', D['Scale'](8),
					'yOffset', D['Scale'](1),
					'maxColumns', 8,
					'point', 'TOP',
					'unitsPerColumn', 5,
					'columnSpacing', D['Scale'](-3),
					'point', 'LEFT',
					'columnAnchorPoint', 'BOTTOM'
				)
				rpet:SetParent(oUFDuffedUI_PetBattleFrameHider)
				rpet:Point('BOTTOM', oUF_Heal, 'TOP', 0, 3)
				move:RegisterFrame(oUF_RaidPet)
			end
		else
			local raid = oUF:SpawnHeader('oUF_DPS', nil, 'solo,raid,party',
				'oUF-initialConfigFunction', [[
					local header = self:GetParent()
					self:SetWidth(header:GetAttribute('initial-width'))
					self:SetHeight(header:GetAttribute('initial-height'))
				]],
				'initial-width', D['Scale'](140),
				'initial-height', D['Scale'](14),
				'initial-anchor', 'BOTTOM',
				'showPlayer', C['raid']['showplayerinparty'],
				'showSolo', C['unitframes']['showsolo'],
				'showParty', true,
				'showRaid', true,
				'groupFilter', '1,2,3,4,5,6,7,8', 
				'groupingOrder', '1,2,3,4,5,6,7,8', 
				'groupBy', 'GROUP', 
				'yOffset', D['Scale'](8),
				'point', 'BOTTOM'
			)
			raid:SetParent(oUFDuffedUI_PetBattleFrameHider)
			if DuffedUIChatBackgroundLeft then raid:Point('BOTTOMLEFT', DuffedUIChatBackgroundLeft, 'TOPLEFT', 2, 26) else raid:Point('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', 2, 33) end
			move:RegisterFrame(oUF_DPS)
		end
	end
end

local cvars = {
	-- important, strongly recommend to set these to 1
	nameplateGlobalScale = 1,
	NamePlateHorizontalScale = 1,
	NamePlateVerticalScale = 1,
	-- optional, you may use any values
	nameplateLargerScale = 1,
	nameplateMaxScale = 1,
	nameplateMinScale = 1,
	nameplateSelectedScale = 1,
	nameplateSelfScale = 1,
	nameplateOccludedAlphaMult = C['nameplate']['oosvisibilty'],
}

D['LoadUF'] = function()
	if C['unitframes']['enable'] then
		oUF:RegisterStyle('DuffedUI', D['ConstructUF'])
		D['SpawnUF']()
	end
	if C['nameplate']['active'] then oUF:SpawnNamePlates(nil, nil, cvars) end
end

local LoadUF = CreateFrame('Frame')
LoadUF:RegisterEvent('PLAYER_LOGIN')
LoadUF:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
function LoadUF:PLAYER_LOGIN()
	D['LoadUF']()
end