local D, C, L = unpack(select(2, ...))
local Module = D:NewModule("Dispell", "AceEvent-3.0", "AceHook-3.0")

local _G = _G
local string_format = _G.string.format

local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local GetInstanceInfo = _G.GetInstanceInfo
local IsActiveBattlefieldArena = _G.IsActiveBattlefieldArena
local IsArenaSkirmish = _G.IsArenaSkirmish
local IsInGroup = _G.IsInGroup
local IsInRaid = _G.IsInRaid
local IsPartyLFG = _G.IsPartyLFG
local UnitGUID = _G.UnitGUID
local SendChatMessage = _G.SendChatMessage

local DISPELL_MSG = "Dispelled %s's \124cff71d5ff\124Hspell:%d:0\124h[%s]\124h\124r!"
function Module:SetupDispellAnnounce()
	local inGroup, inRaid, inPartyLFG = IsInGroup(), IsInRaid(), IsPartyLFG()
	if not inGroup then return end

	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()

	if not (event == "SPELL_DISPEL" and (sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet"))) then return end

	local _, instanceType = GetInstanceInfo()
	if instanceType == "arena" then
		local skirmish = IsArenaSkirmish()
		local _, isRegistered = IsActiveBattlefieldArena()
		if skirmish or not isRegistered then inPartyLFG = true end

		inRaid = false
	end

	local interruptAnnounce, msg = C["announcements"]['Dispell']['Value'], string_format(DISPELL_MSG, destName, spellID, spellName)
	if interruptAnnounce == "PARTY" then
		SendChatMessage(msg, inPartyLFG and "INSTANCE_CHAT" or "PARTY")
	elseif interruptAnnounce == "RAID" then
		SendChatMessage(msg, inPartyLFG and "INSTANCE_CHAT" or (inRaid and "RAID" or "PARTY"))
	elseif interruptAnnounce == "RAID_ONLY" and inRaid then
		SendChatMessage(msg, inPartyLFG and "INSTANCE_CHAT" or "RAID")
	elseif interruptAnnounce == "SAY" and instanceType ~= "none" then
		SendChatMessage(msg, "SAY")
	elseif interruptAnnounce == "YELL" and instanceType ~= "none" then
		SendChatMessage(msg, "YELL")
	elseif interruptAnnounce == "EMOTE" then
		SendChatMessage(msg, "EMOTE")
	end
end

function Module:OnEnable()
	if C["announcements"]['Dispell']['Value'] == "NONE" then return end
	D:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.SetupDispellAnnounce)
end