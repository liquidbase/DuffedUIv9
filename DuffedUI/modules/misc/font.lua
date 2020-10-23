local D, C, L = unpack(select(2, ...)) 
local DuffedUIFonts = CreateFrame('Frame')

local SetFont = function(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	if not obj then return end
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end

DuffedUIFonts:RegisterEvent('ADDON_LOADED')
DuffedUIFonts:SetScript('OnEvent', function(self, event, addon)
	if addon ~= 'DuffedUI' then return end

	local NORMAL = C['media']['font']
	local COMBAT = C['media']['font']
	local NUMBER = C['media']['font']

	if (D['ScreenWidth'] > 3840) then
		InterfaceOptionsCombatTextPanelTargetDamage:Hide()
		InterfaceOptionsCombatTextPanelPeriodicDamage:Hide()
		InterfaceOptionsCombatTextPanelPetDamage:Hide()
		InterfaceOptionsCombatTextPanelHealing:Hide()
		SetCVar('CombatLogPeriodicSpells', 0)
		SetCVar('PetMeleeDamage', 0)
		SetCVar('CombatDamage', 0)
		SetCVar('CombatHealing', 0)

		local INVISIBLE = [=[Interface\Addons\DuffedUI\media\fonts\invisible_font.ttf]=]
		COMBAT = INVISIBLE
		DAMAGE_TEXT_FONT = INVISIBLE
	end

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 11
	CHAT_FONT_HEIGHTS = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

	UNIT_NAME_FONT     = NORMAL
	NAMEPLATE_FONT     = NORMAL
	DAMAGE_TEXT_FONT   = COMBAT
	STANDARD_TEXT_FONT = NORMAL

	SetFont(GameTooltipHeader,                  NORMAL, 11)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, 11, 'OUTLINE')
	SetFont(NumberFont_Outline_Huge,            NUMBER, 28, 'THICKOUTLINE', 28)
	SetFont(NumberFont_Outline_Large,           NUMBER, 15, 'OUTLINE')
	SetFont(NumberFont_Outline_Med,             NUMBER, 13, 'OUTLINE')
	SetFont(NumberFont_Shadow_Med,              NORMAL, 11)
	SetFont(NumberFont_Shadow_Small,            NORMAL, 11)
	SetFont(QuestFont,                          NORMAL, 12)
	SetFont(QuestFont_Large,                    NORMAL, 14)
	SetFont(SystemFont_Large,                   NORMAL, 15)
	SetFont(SystemFont_Med1,                    NORMAL, 11)
	SetFont(SystemFont_Med3,                    NORMAL, 13)
	SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 20, 'THICKOUTLINE')
	SetFont(SystemFont_Outline_Small,           NUMBER, 11, 'OUTLINE')
	SetFont(SystemFont_Shadow_Large,            NORMAL, 16)
	SetFont(SystemFont_Shadow_Med1,             NORMAL, 11)
	SetFont(SystemFont_Shadow_Med3,             NORMAL, 13)
	SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 22, 'OUTLINE')
	SetFont(SystemFont_Shadow_Small,            NORMAL, 11)
	SetFont(SystemFont_Small,                   NORMAL, 11)
	SetFont(SystemFont_Tiny,                    NORMAL, 11)
	SetFont(Tooltip_Med,                        NORMAL, 11)
	SetFont(Tooltip_Small,                      NORMAL, 11)
	SetFont(CombatTextFont,                     COMBAT, 200, 'THINOUTLINE') -- number here just increase the font quality.
	SetFont(SystemFont_Shadow_Huge1,            NORMAL, 20, 'THINOUTLINE')
	SetFont(ZoneTextString,                     NORMAL, 32, 'OUTLINE')
	SetFont(SubZoneTextString,                  NORMAL, 25, 'OUTLINE')
	SetFont(PVPInfoTextString,                  NORMAL, 22, 'THINOUTLINE')
	SetFont(PVPArenaTextString,                 NORMAL, 22, 'THINOUTLINE')
	SetFont(FriendsFont_Normal,                 NORMAL, 11)
	SetFont(FriendsFont_Small,                  NORMAL, 11)
	SetFont(FriendsFont_Large,                  NORMAL, 14)
	SetFont(FriendsFont_UserText,               NORMAL, 11)

	SetFont = nil
	self:SetScript('OnEvent', nil)
	self:UnregisterAllEvents()
	self = nil
end)