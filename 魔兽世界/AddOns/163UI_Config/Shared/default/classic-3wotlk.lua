--[=[
	DEFAULT
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __addon = __namespace.__private.__addon;

if __namespace.__client._Type ~= "classic" or __namespace.__client._Major ~= 3 then
	return;
end

local __private = __namespace.__nsconfig;
local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config.shared.default-2bcc");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local unpack = unpack;
local GetCVar, SetCVar = GetCVar, SetCVar;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared.default-2bcc");
end


local __default = {
	__Major = 2,
};

local _C_PLAYER_CLASS = __const._C_PLAYER_CLASS;


__default.blzOptions = {
	-- { "cvar", "useUIScale", },
	-- { "cvar", "uiscale", },
	-->		Controls
	{ "cvar", "deselectOnClick", "1", },
	-- { "cvar", "autoClearAFK", "1", },
	{ "cvar", "autoLootDefault", "1", },
	{ "set1", GetModifiedClick, SetModifiedClick, "AUTOLOOTTOGGLE", "SHIFT", },		--	GetModifiedClick("AUTOLOOTTOGGLE"),SetModifiedClick("AUTOLOOTTOGGLE", value)
	{ "cvar", "interactOnLeftClick", "0", },
	{ "cvar", "lootUnderMouse", "1", },
	-->		Combat
	{ "cvar", "showTargetOfTarget", "1", },
	-- { "cvar", "doNotFlashLowHealthWarning", "0", },
	-- { "set1", GetModifiedClick, SetModifiedClick, "SELFCAST", "ALT", },		--	GetModifiedClick("SELFCAST"), SetModifiedClick("SELFCAST", value)
	-- { "cvar", "enableFloatingCombatText", "0", },
	--...
	-->		Display
	{ "set0", ShowingHelm, ShowHelm, false, },
	{ "set0", ShowingCloak, ShowCloak, false, },
	{ "cvar", "instantQuestText", "1", },
	-- { "cvar", "autoQuestWatch", "1", },
	-- { "cvar", "hideOutdoorWorldState", "0", },
	-- { "cvar", "rotateMinimap", "0", },
	-- { "cvar", "showMinimapClock", "1", },
	{ "cvar", "showNewbieTips", "0", },
	-- { "cvar", "showLoadingScreenTips", "1", },
	-- { "cvar", "hideAdventureJournalAlerts", "0", },
	-- { "cvar", "showInGameNavigation", "1", },
	{ "cvar", "showTutorials", "0", },
		-- { "cvar", "closedInfoFrames", },						--	????
	-- { "cvar", "statusTextDisplay", "NUMERIC", },				--	not work in classic, use it instead:
		-- { "cvar", "statusText", "1", },
	-- { "set1", InterfaceOptionsDisplayPanelDisplayDropDown.GetValue, InterfaceOptionsDisplayPanelDisplayDropDown.SetValue, InterfaceOptionsDisplayPanelDisplayDropDown, "NUMERIC", },
	-- { "cvar", "chatBubbles", "1", },
		-- { "cvar", "chatBubblesParty", },
	-->		Social
	{ "cvar", "profanityFilter", "0", },
	{ "cvar", "spamFilter", "0", },
	-- { "cvar", "showLootSpam", "1", },
	-- { "cvar", "guildMemberNotify", "1", },
	-- { "cvar", "blockTrades", "0", },
	-- { "set0", GetAutoDeclineGuildInvites, SetAutoDeclineGuildInvites, false, },		--	GetAutoDeclineGuildInvites(), SetAutoDeclineGuildInvites(value)
	-- { "cvar", "blockChannelInvites", "0", },
	-- { "cvar", "showToastOnline", "1", },
	-- { "cvar", "showToastOffline", "1", },
	-- { "cvar", "showToastBroadcast", "0", },
	-- { "cvar", "showToastFriendRequest", "1", },
	-- { "cvar", "showToastWindow", "1", },
	-- { "cvar", "enableTwitter", },
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
	--[[]]{ "check", "InterfaceOptionsActionBarsPanelBottomLeft", true, },
	--[[]]{ "check", "InterfaceOptionsActionBarsPanelBottomRight", true, },
	--[[]]{ "check", "InterfaceOptionsActionBarsPanelRight", true, },
	--[[]]{ "check", "InterfaceOptionsActionBarsPanelRightTwo", true, },
	-- { "cvar", "multiBarRightVerticalLayout", "0", },
	{ "cvar", "lockActionBars", "1", },
	{ "set1", GetModifiedClick, SetModifiedClick, "PICKUPACTION", "SHIFT", },		--	GetModifiedClick("PICKUPACTION"), SetModifiedClick("PICKUPACTION", value)
	{ "cvar", "alwaysShowActionBars", "1", },
	{ "cvar", "countdownForCooldowns", "1", },
	-->		Names
	{ "cvar", "UnitNameOwn", "0", },
	{ "cvar", "UnitNameNPC", "1", },
	{ "cvar", "UnitNamePlayerGuild", "1", },
	{ "cvar", "UnitNamePlayerPVPTitle", "1", },
	{ "cvar", "UnitNameNonCombatCreatureName", "0", },
	{ "cvar", "UnitNameFriendlyPlayerName", "1", },
	{ "cvar", "UnitNameFriendlyMinionName", "1", },
	{ "cvar", "UnitNameEnemyPlayerName", "1", },
	{ "cvar", "UnitNameEnemyMinionName", "1", },
	{ "cvar", "nameplateShowAll", "1", },
	{ "cvar", "nameplateShowEnemies", "1", },
	{ "cvar", "nameplateShowEnemyMinions", "1", },
	{ "cvar", "nameplateShowEnemyMinus", "1", },
	{ "cvar", "nameplateShowFriends", "0", },
	{ "cvar", "nameplateShowFriendlyMinions", "0", },
	-- { "cvar", "nameplateMotion", "0", },
	-->		Camera
	{ "cvar", "cameraWaterCollision", "0", },
	{ "cvar", "cameraDistanceMaxZoomFactor", "2.0", },
	-- { "cvar", "cameraYawSmoothSpeed", "180", },
	{ "cvar", "cameraSmoothStyle", "0", },
	{ "cvar", "cameraTerrainTilt", "0", },
	{ "cvar", "cameraBobbing", "0", },
	{ "cvar", "cameraPivot", "1", },
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
	["163ui_buff"] = true,
	["163ui_chat"] = true,
	["163ui_chathistory"] = true,
	["163ui_combattimer"] = true,
	["163ui_config"] = true,
	["163ui_plugins"] = true,
	--
	["accountant_classic"] = false,
	["alacalendar"] = true,
	["alachat"] = true,
	["alagearman"] = true,
	["alamisc"] = true,
	["alatalentemu"] = true,
	["alatrade"] = false,
	["alatradeskill"] = true,
	["alaunitframe"] = true,
	["atlas"] = false,
	["atlaslootclassic"] = true,
	["auctionator"] = true,
	["bagbrother"] = true,
	["bagnon"] = true,
	["bagnon_guildbank"] = false,
	["battlegroundenemies"] = false,
	["battleinfo"] = true,
	["baudauction"] = false,
	["bigdebuffs"] = false,
	["bgdefender"] = true,
	["blinkhealthtext"] = false,
	["blizzmove"] = true,
	["butterquesttracker"] = true,
	["buyemallclassic"] = false,
	["castdelaybar"] = true,
	["characterstatstbc"] = true,
	["chocolatebar"] = true,
	["classicspellactivations"] = true,
	["clique"] = false,
	["codexlite"] = true,
	["combuctor"] = false,
	["dbm-core"] = true,
	["dbm_mods_vanilla"] = true,
	["dct"] = false,
	["decursive"] = false,
	["dejunk"] = false,
	["details"] = false,
	["dominos"] = false,
	["doom_cooldownpulse"] = true,
	["dugisguideviewerz"] = false,
	["exolink"] = true,
	["extraactionbar"] = false,
	["fizzle"] = true,
	["floaspectbar"] = _C_PLAYER_CLASS == "HUNTER",
	["gathermate2"] = false,
	["gfw_feedomatic_classic"] = _C_PLAYER_CLASS == "HUNTER",
	["gladdy"] = false,
	["grid2"] = false,
	["gtfo"] = false,
	["handynotes"] = true,
	["hhtd"] = false,
	["instanceachievementtracker"] = false,
	["leatrix_maps"] = true,
	["magebuttons"] = _C_PLAYER_CLASS == "MAGE",
	["masque"] = true,
	["meetinghorn"] = true,
	["merinspect"] = true,
	["missingtradeskillslist_tbc"] = false,
	["missingtradeskillslist_tbc_data"] = true,
	["mrt"] = false,
	["myslot"] = true,
	["neatplates"] = false,
	["novaworldbuffs"] = true,
	["nugcombobar"] = false,
	["nugrunning"] = true,
	["omnicc"] = true,
	["orbsellandrepair"] = true,
	["pallypower"] = true,
	["parrot"] = false,
	["postal"] = true,
	["quartz"] = false,
	["questannounce"] = true,
	["questie"] = false,
	["questxp"] = true,
	["raidledger"] = true,
	["rangedisplay"] = true,
	["ratingbuster"] = true,
	["recount"] = true,
	["restockertbc"] = true,
	["safequeue"] = true,
	["sexymap"] = false,
	["shadowedunitframes"] = false,
	["simpleraidtargeticons"] = true,
	["sinstats"] = false,
	["skada"] = false,
	["speedyautoloot"] = false,
	["spy"] = false,
	["talentemu"] = true,
	["targetnameplateindicator"] = true,
	["tdinspect"] = true,
	["tdpack2"] = true,
	["tellmewhen"] = false,
	["threatclassic2"] = true,
	["tidyplates_threatplates"] = false,
	["tinytooltip"] = false,
	["tiptac"] = true,
	["totemtimers"] = false,
	["tradelog"] = true,
	["trinketmenu"] = false,
	["tullarange"] = true,
	["weakauras"] = false,
	["weaponswingtimer"] = _C_PLAYER_CLASS == "WARRIOR" or _C_PLAYER_CLASS == "PALADIN" or _C_PLAYER_CLASS == "HUNTER" or _C_PLAYER_CLASS == "SHAMAN" or _C_PLAYER_CLASS == "ROGUE" or _C_PLAYER_CLASS == "DRUID",
	["whatstraining"] = true,
	["whisperpop"] = true,
	["WideQuestLog"] = true,
	["xloot"] = false,
};


__default.addons_protected = {
	["!!!163ui!!!"] = true,
	["!!!libs"] = true,
	["163ui_config"] = true,
	["bagbrother"] = true,
	["tdpack"] = select(2, GetAddOnInfo("!!!!MasterVersion")) == nil,
};
__default.addons_hidden = {
	["!!!libs"] = true,
	["bagbrother"] = true,
	["dbm-statusbartimers"] = true,
	["missingtradeskillslist_tbc_data"] = true,
};

__namespace.__default = __default;


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r.default", __core._F_devDebugProfileTick("config.shared.default-2bcc"));
end
