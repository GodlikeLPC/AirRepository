--[=[
	DEFAULT
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __addon = __namespace.__private.__addon;

if __namespace.__client._Type ~= "retail" or __namespace.__client._Major ~= 9 then
	return;
end

local __private = __namespace.__nsconfig;
local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config.shared.default-9sl");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local unpack = unpack;
local GetCVar, SetCVar = GetCVar, SetCVar;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared.default-9sl");
end


local __default = {
	__Major = 9,
};

local _C_PLAYER_CLASS = __const._C_PLAYER_CLASS;


__default.blzOptions = {
	-- { "cvar", "useUIScale", },
	-- { "cvar", "uiscale", },
	-->		Controls
	{ "cvar", "deselectOnClick", "1", },
	{ "cvar", "autoDismountFlying", "0", },
	-- { "cvar", "autoClearAFK", "1", },
	{ "cvar", "autoLootDefault", "1", },
	{ "set1", GetModifiedClick, SetModifiedClick, "AUTOLOOTTOGGLE", "SHIFT", },		--	GetModifiedClick("AUTOLOOTTOGGLE"),SetModifiedClick("AUTOLOOTTOGGLE", value)
	{ "cvar", "interactOnLeftClick", "0", },
	{ "cvar", "lootUnderMouse", "1", },
	-->		Combat
	{ "cvar", "showTargetOfTarget", "1", },
	-- { "cvar", "doNotFlashLowHealthWarning", "0", },
	-- { "set1", GetModifiedClick, SetModifiedClick, "FOCUSCAST", "NONE", },		--	GetModifiedClick("FOCUSCAST"), SetModifiedClick("FOCUSCAST", value)
	-- { "set1", GetModifiedClick, SetModifiedClick, "SELFCAST", "ALT", },		--	GetModifiedClick("SELFCAST"), SetModifiedClick("SELFCAST", value)
	-- { "cvar", "lossOfControl", "1", },
	-- { "cvar", "enableFloatingCombatText", "0", },
	-- { "cvar", "spellActivationOverlayOpacity", "0.65", },
		{ "cvar", "displaySpellActivationOverlays", },
	-->		Display
	-- { "cvar", "Outline", "2", },
		-- { "cvar", "OutlineEngineMode", "0", },
		-- { "cvar", "RaidOutlineEngineMode", "1", },
	-- { "cvar", "findYourselfMode", "0", },
	-- { "cvar", "rotateMinimap", "0", },
	-- { "cvar", "hideAdventureJournalAlerts", "0", },
	-- { "cvar", "showInGameNavigation", "1", },
	{ "cvar", "showTutorials", "0", },
		-- { "cvar", "closedInfoFrames", },						--	????
		-- { "cvar", "closedInfoFramesAccountWide", },			--	????
		{ "cvar", "showNPETutorials", "0", },
	{ "cvar", "statusTextDisplay", "NUMERIC", },
		{ "cvar", "statusText", "1", },
	-- { "cvar", "chatBubbles", "1", },
		{ "cvar", "chatBubblesParty", },
	-->		Social
	{ "cvar", "profanityFilter", "0", },
	{ "cvar", "spamFilter", "0", },
	-- { "cvar", "guildMemberNotify", "1", },
	-- { "cvar", "blockTrades", "0", },
	-- { "set0", GetAutoDeclineGuildInvites, SetAutoDeclineGuildInvites, false, },		--	GetAutoDeclineGuildInvites(), SetAutoDeclineGuildInvites(value)
	-- { "cvar", "blockChannelInvites", "0", },
	-- { "set0", AreAccountAchievementsHidden, ShowAccountAchievements, false, },	--	AreAccountAchievementsHidden(), ShowAccountAchievements(value)
	-- { "cvar", "showToastOnline", "1", },
	-- { "cvar", "showToastOffline", "1", },
	-- { "cvar", "showToastBroadcast", "0", },
	-- { "cvar", "autoAcceptQuickJoinRequests", "0", },
	-- { "cvar", "showToastFriendRequest", "1", },
	-- { "cvar", "showToastWindow", "1", },
	--	{ "cvar", "enableTwitter", },
	-- { "cvar", "chatStyle", "im", },
	{ "cvar", "showTimestamps", "%H:%M:%S", },
	{ "cvar", "whisperMode", "inline", },
	-->		ActionBars
	{ "gvar", "SHOW_MULTI_ACTIONBAR_1", "1", },
	{ "gvar", "SHOW_MULTI_ACTIONBAR_2", "1", },
	{ "gvar", "SHOW_MULTI_ACTIONBAR_3", "1", },
	{ "gvar", "SHOW_MULTI_ACTIONBAR_4", "1", },
	{ "gvar", "ALWAYS_SHOW_MULTIBARS", "1", },
	{ "set0", GetActionBarToggles, SetActionBarToggles, true, true, true, true, true, },			--	GetActionBarToggles(), SetActionBarToggles(show1, show2, show3, show4 [, alwaysShow])
	--[-[]]{ "check", "InterfaceOptionsActionBarsPanelBottomLeft", true, },
	--[-[]]{ "check", "InterfaceOptionsActionBarsPanelBottomRight", true, },
	--[-[]]{ "check", "InterfaceOptionsActionBarsPanelRight", true, },
	--[-[]]{ "check", "InterfaceOptionsActionBarsPanelRightTwo", true, },
	-- { "cvar", "multiBarRightVerticalLayout", "0", },
	{ "cvar", "lockActionBars", "1", },
	{ "set1", GetModifiedClick, SetModifiedClick, "PICKUPACTION", "SHIFT", },		--	GetModifiedClick("PICKUPACTION"), SetModifiedClick("PICKUPACTION", value)
	{ "cvar", "alwaysShowActionBars", "1", },
	{ "cvar", "countdownForCooldowns", "1", },
	-->		Names
	{ "cvar", "UnitNameOwn", "0", },
	{ "cvar", "UnitNameNPC", "1", },
	-- { "cvar", "UnitNameFriendlySpecialNPCName", "0", },
	{ "cvar", "UnitNameHostleNPC", "1", },
	-- { "cvar", "UnitNameInteractiveNPC", "0", },
	{ "cvar", "ShowQuestUnitCircles", "1", },
	{ "cvar", "UnitNameNonCombatCreatureName", "0", },
	{ "cvar", "UnitNameFriendlyPlayerName", "1", },
	{ "cvar", "UnitNameFriendlyMinionName", "1", },
	{ "cvar", "UnitNameEnemyPlayerName", "1", },
	{ "cvar", "UnitNameEnemyMinionName", "1", },
	{ "cvar", "nameplateShowSelf", "0", },
	{ "cvar", "nameplateResourceOnTarget", "0", },
	{ "cvar", "NamePlateHorizontalScale", "1.4", },
	{ "cvar", "NamePlateVerticalScale", "2.7", },
	{ "cvar", "NamePlateClassificationScale", "1.25", },
	{ "cvar", "ShowNamePlateLoseAggroFlash", "1", },
	{ "cvar", "nameplateShowAll", "1", },
	{ "cvar", "nameplateShowEnemies", "1", },
	{ "cvar", "nameplateShowEnemyMinions", "1", },
	{ "cvar", "nameplateShowEnemyMinus", "1", },
	{ "cvar", "nameplateShowFriends", "0", },
	{ "cvar", "nameplateShowFriendlyMinions", "0", },
	-- { "cvar", "nameplateMotion", "0", },
	-->		Camera
	{ "cvar", "cameraWaterCollision", "0", },
	-- { "cvar", "cameraYawSmoothSpeed", "180", },
	{ "cvar", "cameraSmoothStyle", "0", },
	-->		Mouse
	-- { "cvar", "mouseInvertPitch", "0", },
	-- { "cvar", "cameraYawMoveSpeed", "180", },
	-- { "cvar", "enableMouseSpeed", "0", },
	-- { "cvar", "mouseSpeed", "1", },
	-- { "cvar", "ClipCursor", "0", },
	-- { "cvar", "autointeract", "0", },
	-- { "cvar", "cameraSmoothTrackingStyle", "4", },
	-->		Accessibility
	-- { "cvar", "enableMovePad", "0", },
	-- { "cvar", "movieSubtitle", "1", },
	-- { "cvar", "overrideScreenFlash", "0", },
	-- { "cvar", "CameraKeepCharacterCentered", "1", },
	-- { "cvar", "CameraReduceUnexpectedMovement", "0", },
	-- { "cvar", "ShakeStrengthCamera", "1", },
	-- { "cvar", "ShakeStrengthUI", "1", },
	-- { "cvar", "colorblindMode", "0", },
	-- { "cvar", "colorblindSimulator", },
	-- { "cvar", "colorblindWeaknessFactor", "0.5", },
	--		RaidFrame
	--	interface\addons\blizzard_cufprofiles\blizzard_compactunitframeprofiles
};
__default.addons_state = {
	["!!!163ui!!!"] = true,
	["!!!libs"] = true,
	["!bauderrorframe"] = true,
	["!tddropdown"] = true,
	["!kalielstracker"] = false,
	["!worldflightmaploader"] = true,
	["163ui_buff"] = true,
	["163ui_chat"] = true,
	["163ui_chathistory"] = true,
	["163ui_combattimer"] = true,
	["163ui_config"] = true,
	["163ui_encounterlootplus"] = true,
	["163ui_moreoptions"] = true,
	["163ui_plugins"] = true,
	["163ui_teamstats"] = true,
	--
	["accountant_classic"] = true,
	["achievementsreminder"] = true,
	["advancedinterfaceoptions"] = true,
	["angrykeystones"] = true,
	["atlasloot"] = true,
	["auctionator"] = true,
	["autoturnin"] = true,
	["bagbrother"] = true,
	["bagnon"] = true,
	["battlegroundenemies"] = true,
	["bfainvasiontimer"] = false,
	["bgdefender"] = false,
	["bigdebuffs"] = false,
	["blinkhealthtext"] = false,
	["blizzbuffsfacade"] = true,
	["blizzmove"] = true,
	["buyemall"] = false,
	["canimogit"] = true,
	["capping"] = false,
	["castdelaybar"] = true,
	["chocolatebar"] = false,
	["combuctor"] = false,
	["comergy_redux"] = false,
	["compactraid"] = false,
	["covenantforge"] = true,
	["dbm-core"] = true,
	["dbm_mods_bfa"] = true,
	["dbm_mods_cataclysm"] = true,
	["dbm_mods_legion"] = true,
	["dbm_mods_mop"] = true,
	["dbm_mods_old"] = true,
	["dbm_mods_wod"] = true,
	["dbm_mods_wotlk"] = true,
	["deathannounce"] = true,
	["decursive"] = false,
	["dejacharacterstats"] = false,
	["details"] = false,
	["dominos"] = true,
	["dresser"] = true,
	["duowanchat"] = false,
	["ellipsis"] = false,
	["en_unitframes"] = true,
	["errorfilter"] = false,
	["eventalertmod"] = false,
	["exrt"] = false,
	["extraactionbar"] = false,
	["fizzle"] = true,
	["friendsmenuxp"] = false,
	["garrisonmissionmanager"] = true,
	["gathermate2"] = false,
	["gearhud"] = false,
	["gearmanagerex"] = true,
	["gearstatssummary"] = false,
	["gladiatorlossa2"] = false,
	["gladius"] = false,
	["glowfosho"] = true,
	["grid"] = false,
	["gridclicksets"] = false,
	["gtfo"] = false,
	["handynotes"] = true,
	["hhtd"] = false,
	["hpetbattleany"] = true,
	["kayrcovenantmissions"] = false,
	["kib_questmobs"] = false,
	["leatrix_plus"] = false,
	["litebuff"] = false,
	["mapster"] = true,
	["masque"] = true,
	["masterplan"] = true,
	["masterplana"] = true,
	["meetingstone"] = false,
	["merchantex"] = true,
	["mists_of_tirna_solved"] = false,
	["myslot"] = true,
	["mythicdungeontools"] = true,
	["neatplates"] = false,
	["nomicakes"] = true,
	["npcscan"] = false,
	["oglow"] = true,
	["omnibar"] = false,
	["omnicc"] = false,
	["omnicd"] = false,
	["paku_totems"] = true,
	["parrot"] = false,
	["postal"] = true,
	["quakeassist"] = true,
	["quartz"] = false,
	["questannounce"] = false,
	["raidachievement"] = true,
	["rangedisplay"] = false,
	["rarescanner"] = false,
	["rematch"] = true,
	["savedinstances"] = true,
	["sexymap"] = false,
	["shadowedunitframes"] = false,
	["shadowlandsjourney"] = false,
	["simpleraidtargeticons"] = false,
	["simulationcraft"] = true,
	["skada"] = true,
	["skadaexplosiveorbs"] = true,
	["swingbar"] = false,
	["targetnameplateindicator"] = true,
	["tellmewhen"] = false,
	["theburningtrade"] = true,
	["tidyplates_threatplates"] = false,
	["tinyinspect"] = true,
	["tiptac"] = true,
	["tiptacitemref"] = true,
	["tiptacoptions"] = true,
	["tiptactalents"] = true,
	["tomtom"] = false,
	["toyplus"] = false,
	["tradelog"] = true,
	["tradeskillinfo"] = false,
	["trinketmenu"] = false,
	["trufigcd"] = false,
	["tullarange"] = false,
	["vbar"] = false,
	["weakauras"] = false,
	["whisperpop"] = true,
	["wholly"] = false,
	["wmarker"] = false,
	["worldflightmap"] = false,
	["worldquestslist"] = false,
	["worldquesttracker"] = false,
	["xloot"] = false,
};


__default.addons_protected = {
	["!!!163ui!!!"] = true,
	["!!!libs"] = true,
	["163ui_config"] = true,
	["bagbrother"] = true,
};
__default.addons_hidden = {
	["!!!libs"] = true,
	["bagbrother"] = true,
	["dbm-statusbartimers"] = true,
};

__namespace.__default = __default;


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r.default", __core._F_devDebugProfileTick("config.shared.default-9sl"));
end
