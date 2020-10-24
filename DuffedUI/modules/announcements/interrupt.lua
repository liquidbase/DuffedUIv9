local D, C, L = unpack(select(2, ...))
local AnnounceInterrupt = D:NewModule("Interrupt", "AceEvent-3.0")

local _G = _G
local string_format = string.format

local IsInGroup = _G.IsInGroup
local IsInRaid = _G.IsInRaid
local IsPartyLFG = _G.IsPartyLFG
local IsInInstance = _G.IsInInstance
local IsArenaSkirmish = _G.IsArenaSkirmish
local IsActiveBattlefieldArena = _G.IsActiveBattlefieldArena
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local UnitGUID = _G.UnitGUID
local SendChatMessage = _G.SendChatMessage

local InterruptMessage = INTERRUPTED.." %s's \124cff71d5ff\124Hspell:%d:0\124h[%s]\124h\124r!"

function AnnounceInterrupt:COMBAT_LOG_EVENT_UNFILTERED()
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
	if C["announcements"]['Interrupt']['Value'] == "NONE" then return	end

	if not (event == "SPELL_INTERRUPT" and (sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet"))) then return	end

	local inGroup, inRaid, inPartyLFG = IsInGroup(), IsInRaid(), IsPartyLFG()
	if not inGroup then	return end

	local _, instanceType = IsInInstance()
	if instanceType and instanceType == "arena" then
		local skirmish = IsArenaSkirmish()
		local _, isRegistered = IsActiveBattlefieldArena()
		if skirmish or not isRegistered then inPartyLFG = true end
		inRaid = false
	end

	if C["announcements"]['Interrupt']['Value'] == "PARTY" then
		SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), inPartyLFG and "INSTANCE_CHAT" or "PARTY")
	elseif C["announcements"]['Interrupt']['Value'] == "RAID" then
		if inRaid then
			SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), inPartyLFG and "INSTANCE_CHAT" or "RAID")
		else
			SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), inPartyLFG and "INSTANCE_CHAT" or "PARTY")
		end
	elseif C["announcements"]['Interrupt']['Value'] == "RAID_ONLY" then
		if inRaid then
			SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), inPartyLFG and "INSTANCE_CHAT" or "RAID")
		end
	elseif C["announcements"]['Interrupt']['Value'] == "SAY" then
		SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), "SAY")
	elseif C["announcements"]['Interrupt']['Value'] == "EMOTE" then
		SendChatMessage(string_format(InterruptMessage, destName, spellID, spellName), "EMOTE")
	end
end

function AnnounceInterrupt:OnEnable() self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end
function AnnounceInterrupt:OnDisable() self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end