--[=[
	CORE
--]=]
--[====[
--]====]
local __namespace = _G.__core_namespace;
local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core.ExternProfile");
end

local _F_corePrint = __core._F_corePrint;
local _T_addonInfo = __core._T_addonInfo;
----------------------------------------------------------------
local _C_CORE_PATH_TEXTURE = __namespace.__const._C_CORE_PATH_TEXTURE;

local WExtern = CreateFrame('FRAME');
WExtern:SetScript("OnEvent", function(self, event, ...)
	local f = self[event];
	if f ~= nil then
		f(self, event, ...);
	end
end);

-->		upvalue
local pcall = pcall;
local debugprofilestart, debugprofilestop = debugprofilestart, debugprofilestop;
local type, select = type, select;
local next, unpack = next, unpack;
local strsplit, gsub, format = string.split, string.gsub, string.format;
local GetCVar, SetCVar = GetCVar, SetCVar;
local EnableAddOn, DisableAddOn, IsAddOnLoaded, LoadAddOn, GetNumAddOns, GetAddOnInfo, GetAddOnEnableState, IsAddOnLoadOnDemand
	 = EnableAddOn, DisableAddOn, IsAddOnLoaded, LoadAddOn, GetNumAddOns, GetAddOnInfo, GetAddOnEnableState, IsAddOnLoadOnDemand;
local CreateFrame = CreateFrame;
local GetLocale = GetLocale;
local GetRealmName = GetRealmName;
local UnitGUID = UnitGUID;
local UnitName = UnitName;
local SetAutoDeclineGuildInvites, GetAutoDeclineGuildInvites = SetAutoDeclineGuildInvites, GetAutoDeclineGuildInvites;
local SetActionBarToggles, GetActionBarToggles = SetActionBarToggles, GetActionBarToggles;
local GetModifiedClick, SetModifiedClick = GetModifiedClick, SetModifiedClick;
local AreAccountAchievementsHidden, ShowAccountAchievements = AreAccountAchievementsHidden, ShowAccountAchievements;
local _G = _G;

if __core.__is_dev then
	__core._F_BuildEnv("core.ExternProfile");
end


-->		Const
local CPREFIXLIST = {
	zhCN = "导入-",
	zhTW = "導入-",
	['*'] = "Imp-",
};
local CIGNORECHANNEL = {
	ShadowlandsBetaDiscussion = true,
	ShadowlandsPTRDiscussion = true,
	ShadowlandsTestDiscussion = true,
};
local CLOCLALE = GetLocale();
local CGUID, CPLAYER, CREALM = UnitGUID('player'), UnitName('player'), GetRealmName();
local CAceDBKey = CPLAYER .. " - " .. CREALM;
local CKeyAdditionalData = '____163ui_WExtern_AdditionalData';
local CPREFIX = CPREFIXLIST[CLOCLALE] or CPREFIXLIST['*'];
local CENCODENIL = "__163ui_WExtern_nil";


-->		Dev Purpose Field
local is_dev = __core.__is_dev;
local pcall = is_dev and function(func, ...) return true, func(...); end or pcall;
local FDebug = is_dev and _F_corePrint or function() end;
local _SetModifiedClick = SetModifiedClick;
local function SetModifiedClick(action, key)
	_SetModifiedClick(action, key);
	SaveBindings(GetCurrentBindingSet());
end


-->		Meta
local TOptions = {
	blz_variable = true,
	blz_layout = true,
	-- addon_enabled = true,
	addon_variable = true,
};
--	blizzard option, blizzard layout, addon state, addon variable

local TBlzOptionKeys = {
	"useUIScale",
	"uiscale",
	-->		Controls
	"deselectOnClick",		--	目标锁定
	"autoDismountFlying",	--	自动取消飞行
	"autoClearAFK",
	"autoLootDefault",
	{ GetModifiedClick, SetModifiedClick, "AUTOLOOTTOGGLE", },		--	GetModifiedClick("AUTOLOOTTOGGLE"),SetModifiedClick("AUTOLOOTTOGGLE", value)
	"interactOnLeftClick",
	"lootUnderMouse",
	-->		Combat
	"showTargetOfTarget",
	"doNotFlashLowHealthWarning",
	{ GetModifiedClick, SetModifiedClick, "FOCUSCAST", },		--	GetModifiedClick("FOCUSCAST"), SetModifiedClick("FOCUSCAST", value)
	{ GetModifiedClick, SetModifiedClick, "SELFCAST", },		--	GetModifiedClick("SELFCAST"), SetModifiedClick("SELFCAST", value)
	"lossOfControl",
	"enableFloatingCombatText",
	"spellActivationOverlayOpacity",
		"displaySpellActivationOverlays",	--	switcher, not in panel
	-->		Display
	"Outline",
		"OutlineEngineMode",
		"RaidOutlineEngineMode",
	"findYourselfMode",
	"rotateMinimap",
	"hideAdventureJournalAlerts",
	"showInGameNavigation",
	"showTutorials",
		"closedInfoFrames",
		"closedInfoFramesAccountWide",
		"showNPETutorials",
	"statusTextDisplay",
		"statusText",
	"chatBubbles",
		"chatBubblesParty",
	-->		Social
	"profanityFilter",
	"spamFilter",
	"guildMemberNotify",
	"blockTrades",
	{ GetAutoDeclineGuildInvites, SetAutoDeclineGuildInvites, },		--	GetAutoDeclineGuildInvites(), SetAutoDeclineGuildInvites(value)
	"blockChannelInvites",
	{ AreAccountAchievementsHidden, ShowAccountAchievements, },	--	AreAccountAchievementsHidden(), ShowAccountAchievements(value)
	"showToastOnline",
	"showToastOffline",
	"showToastBroadcast",
	"autoAcceptQuickJoinRequests",
	"showToastFriendRequest",
	"showToastWindow",
	--	"enableTwitter",			--	GFW, emmm
	"chatStyle",
	"showTimestamps",
	"whisperMode",
	-->		ActionBars
	{ GetActionBarToggles, SetActionBarToggles, },			--	GetActionBarToggles(), SetActionBarToggles(show1, show2, show3, show4 [, alwaysShow])
	"multiBarRightVerticalLayout",
	"lockActionBars",
	{ GetModifiedClick, SetModifiedClick, "PICKUPACTION", },		--	GetModifiedClick("PICKUPACTION"), SetModifiedClick("PICKUPACTION", value)
	"alwaysShowActionBars",
	"countdownForCooldowns",
	-->		Names
	"UnitNameOwn",
	"UnitNameNPC",
	"UnitNameFriendlySpecialNPCName",
	"UnitNameHostleNPC",
	"UnitNameInteractiveNPC",
	"ShowQuestUnitCircles",
	"UnitNameNonCombatCreatureName",
	"UnitNameFriendlyPlayerName",
	"UnitNameFriendlyMinionName",
	"UnitNameEnemyPlayerName",
	"UnitNameEnemyMinionName",
	"nameplateShowSelf",
	"nameplateResourceOnTarget",
	"NamePlateHorizontalScale",
	"NamePlateVerticalScale",
	"NamePlateClassificationScale",
	"ShowNamePlateLoseAggroFlash",
	"nameplateShowAll",
	"nameplateShowEnemies",
	"nameplateShowEnemyMinions",
	"nameplateShowEnemyMinus",
	"nameplateShowFriends",
	"nameplateShowFriendlyMinions",
	"nameplateMotion",
	-->		Camera
	"cameraWaterCollision",
	"cameraYawSmoothSpeed",
	"cameraSmoothStyle",
	-->		Mouse
	"mouseInvertPitch",
	"cameraYawMoveSpeed",
	"enableMouseSpeed",
	"mouseSpeed",
	"ClipCursor",
	"autointeract",
	"cameraSmoothTrackingStyle",
	-->		Accessibility
	"enableMovePad",
	"movieSubtitle",
	"overrideScreenFlash",
	"CameraKeepCharacterCentered",
	"CameraReduceUnexpectedMovement",
	"ShakeStrengthCamera",
	"ShakeStrengthUI",
	"colorblindMode",
	"colorblindSimulator",
	"colorblindWeaknessFactor",
	--		RaidFrame
	--	interface\addons\blizzard_cufprofiles\blizzard_compactunitframeprofiles
};
local TBlzLayoutMeta = {
	['chatframe'] = {
		FGet = function()
			local tbl = {  };
			for id = 1, 10 do
				local val = {  };
				tbl[id] = val;
				val.info = { GetChatWindowInfo(id) };				--
				--	name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable
				--[=[
					1	name,			--	SetChatWindowName(id, name)
					2	fontSize,		--	SetChatWindowSize(id, size)
					3	r, g, b,		--	SetChatWindowColor(id, r, g, b)
					6	alpha,			--	SetChatWindowAlpha(id, alpha)
					7	shown,			--	SetChatWindowShown(id, shown)
					8	locked,			--	SetChatWindowLocked(id, locked)
					9	docked,			--	SetChatWindowDocked(id, docked)
					10	uninteractable	--	SetChatWindowUninteractable(id, isUninteractable)
				]=]
				local chatTypeList = { GetChatWindowMessages(id) };
				local chatTypeHash = {  };
				for index, type in next, chatTypeList do
					chatTypeHash[type] = 1;
				end
				val.chatTypeHash = chatTypeHash;								--
				local channelList = { GetChatWindowChannels(id) };
				local channelHash = {  };
				for index = 1, #channelList, 2 do
					if CIGNORECHANNEL[channelList[index]] == nil then
						channelHash[channelList[index]] = channelList[index + 1];
					end
				end
				val.channelHash = channelHash;									--
				local w, h = GetChatWindowSavedDimensions(id);
				if w ~= nil and h ~= nil then
					val.Dimensions = { w, h, };									--
				end
				local point, x, y = GetChatWindowSavedPosition(id);
				if point ~= nil and x ~= nil and y ~= nil then
					val.Position = { point, x, y, };							--
				end
			end
			-- tbl.ChatTypeInfo = _G.ChatTypeInfo;		--	not reliable
			local chatColor = {  };
			for _, v in next, { CHAT_CONFIG_CHAT_LEFT, CHAT_CONFIG_OTHER_COMBAT, CHAT_CONFIG_OTHER_PVP, CHAT_CONFIG_OTHER_SYSTEM, CHAT_CONFIG_CHAT_CREATURE_LEFT, } do
				for _, val in next, v do
					local r, g, b = GetMessageTypeColor(val.type);
					chatColor[val.type] = { r, g, b, };
				end
			end
			tbl.chatColor = chatColor;
			--[[		--	included in GetChatWindowInfo
			--	GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES	[dockIndex] = frame
			if GENERAL_CHAT_DOCK ~= nil and GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES ~= nil then
				local dock = {  };
				for index = 1, #GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES do
					dock[index] = GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES[index]:GetID();
				end
				tbl.dock = dock;
			end]]
			return tbl;
		end,
		FSet = function(tbl)
			FDebug('ChatFrame FSet');
			-- local ChatTypeInfo = tbl.ChatTypeInfo;
			-- if ChatTypeInfo ~= nil then
			-- 	for c, color in next, ChatTypeInfo do
			-- 		pcall(ChangeChatColor, color.r, color.g, color.b);
			-- 	end
			-- 	tbl.ChatTypeInfo = nil;
			-- end
			local chatColor = tbl.chatColor;
			if chatColor ~= nil then
				for type, color in next, chatColor do
					pcall(ChangeChatColor, type, color[1], color[2], color[3]);
				end
				FDebug('chatColor');
			end
			for id = 1, 10 do
				local val = tbl[id];
				if val ~= nil then
					FDebug(id, 1);
					local info = val.info;
					if info ~= nil then
						pcall(SetChatWindowShown, id, info[7]);
						pcall(SetChatWindowName, id, info[1]);
						pcall(SetChatWindowDocked, id, info[9]);
						pcall(SetChatWindowSize, id, info[2]);
						pcall(SetChatWindowColor, id, info[3], info[4], info[5]);
						pcall(SetChatWindowAlpha, id, info[6]);
						pcall(SetChatWindowLocked, id, info[8]);
						pcall(SetChatWindowUninteractable, id, info[10]);
						FDebug(unpack(info));
					end
					FDebug(id, 2);
					local chatTypeHash = val.chatTypeHash;
					if chatTypeHash ~= nil then
						local old = { GetChatWindowMessages(id) };
						for index, type in next, old do
							if chatTypeHash[type] == nil then
								pcall(RemoveChatWindowMessages, id, type);
							end
						end
						for type, _ in next, chatTypeHash do
							pcall(AddChatWindowMessages, id, type);
						end
					end
					FDebug(id, 3);
					local channelHash = val.channelHash;
					if channelHash ~= nil then
						local old = { GetChatWindowChannels(id) };
						for index = 1, #old, 2 do
							if channelHash[old[index]] == nil then
								pcall(RemoveChatWindowChannel, id, old[index]);
							end
						end
						for channel, _ in next, channelHash do
							if CIGNORECHANNEL[channel] == nil then
								pcall(JoinPermanentChannel, channel);
								pcall(AddChatWindowChannel, id, channel);
							end
						end
					end
					FDebug(id, 4);
					local Dimensions = val.Dimensions;
					if Dimensions ~= nil and Dimensions[1] ~= nil and Dimensions[2] ~= nil then
						pcall(SetChatWindowSavedDimensions, id, Dimensions[1], Dimensions[2]);
					end
					FDebug(id, 5);
					local Position = val.Position;
					if Position ~= nil and Position[1] ~= nil and Position[2] ~= nil and Position[3] ~= nil then
						pcall(SetChatWindowSavedPosition, id, Position[1], Position[2], Position[3]);
					end
					FDebug(id, 6);
				end
			end
			FDebug('ChatFrame FSet Finished');
		end,
	},
	['unitframe'] = {
		FGet = function()
			local pp = { PlayerFrame:GetPoint() };
			local pt = { TargetFrame:GetPoint() };
			if pp[2] == nil then
				pp[2] = CENCODENIL;
			else
				pp[2] = pp[2]:GetName();
			end
			if pt[2] == nil then
				pt[2] = CENCODENIL;
			else
				pt[2] = pt[2]:GetName();
			end
			return {
				PlayerFrame = pp,
				TargetFrame = pt,
			};
		end,
		FSet = function(tbl)
			for frame, val in next, tbl do
				frame = _G[frame];
				if frame ~= nil and type(frame) == 'table' and frame.SetPoint ~= nil and type(frame.SetPoint) == 'function' then
					if frame.SetUserPlaced ~= nil and type(frame.SetUserPlaced) == 'function' then
						frame:SetUserPlaced(true);
					end
					if frame.ClearAllPoints ~= nil and type(frame.ClearAllPoints) == 'function' then
						frame:ClearAllPoints(true);
					end
					if val[4] == nil then
						frame:SetPoint(val[1], val[2] ~= CENCODENIL and val[2] or nil, val[3]);
					else
						frame:SetPoint(val[1], val[2] ~= CENCODENIL and val[2] or nil, val[3], val[4], val[5]);
					end
				end
			end
		end,
	},
};
--	AceDB:	name-key @profileKeys, CGUID, db @profiles
local TAddonVariableTypeMethod = {
	AceDB = {
		FGet = function(var)
			local db = _G[var];
			if db ~= nil and db.profileKeys ~= nil and db.profiles ~= nil then
				local key = db.profileKeys[CAceDBKey];
				local p = db.profiles[key];
				if p ~= nil then
					for _, pat in next, CPREFIXLIST do
						key = gsub(key, gsub(pat, "%-", "%%%-"), "");
					end
					p[CKeyAdditionalData] = key;
					return p;
				end
			end
		end,
		FSet = function(var, val)
			local db = _G[var];
			if db == nil then
				db = { profileKeys = {}, profiles = {}, };
				_G[var] = db;
			else
				db.profileKeys = db.profileKeys or {};
				db.profiles = db.profiles or {};
			end
			local key = CPREFIX .. val[CKeyAdditionalData];
			db.profileKeys[CAceDBKey] = key;
			val[CKeyAdditionalData] = nil;
			db.profiles[key] = val;
		end,
	},
	simple = {
		FGet = function(var)
			return _G[var];
		end,
		FSet = function(var, val)
			_G[var] = val;
		end,
	},
};
local TAddonVariableMeta = {
	['!!!163ui!!!'] = {
		FGet = function(var)
			return __namespace.__db;
		end,
		FSet = function(var, val)
			local __DB = GLOBAL_CORE_SAVED;
			if __DB ~= nil then
				__DB.profiles[__DB.profileKeys[UnitGUID('player')]] = val;
			end
		end,
	},
	['bagnon'] = {
		type = "simple",
		var = "Bagnon_Sets",
	},
	['bigdebuffs'] = {
		type = "AceDB",
		var = "BigDebuffsDB",
	},
	['blizzmove'] = {
		type = "simple",
		var = "BlizzMoveDB",
	},
	['chocalatebr'] = {
		type = "AceDB",
		var = "ChocolateBarDB",
	},
	['details'] = {
		ignore = true,
		var = "",
	},
	['dominos'] = {
		type = "AceDB",
		var = "DominosDB",
	},
	['duowanchat'] = {
		type = "AceDB",
		var = "DuowanChatDB",
	},
	['gladius'] = {
		type = "AceDB",
		var = "Gladius2DB",
	},
	['masque'] = {
		type = "AceDB",
		var = "MasqueDB",
		mod = function(db)
			local Groups = db.Groups;
			if Groups == nil then
				return db;
			end
			local SkinID = Groups.Masque and Groups.Masque.SkinID or nil;
			if SkinID == nil then
				return db;
			end
			local db2 = table.excopy(db);
			local NewGroups = {
				Masque = Groups.Masque,
			};
			for k, v in next, Groups do
				if k ~= "Masque" and not v.Upgraded then
					if v.SkinID ~= nil and v.SkinID ~= SkinID then
						local p = strsplit("_", k);
						if p ~= k then
							local vp = Groups[p];
							if vp == nil or vp.SkinID ~= SkinID then
								NewGroups[k] = v;
							end
						else
							NewGroups[k] = v;
						end
					end
				end
			end
			db2.Groups = NewGroups;
			return db2;
		end,
	},
	['leatrix_plus'] = {
		type = "simple",
		var = "LeaPlusDB",
	},
	['neatplates'] = {
		ignore = true,
		var = "",
	},
	['quartz'] = {
		type = "AceDB",
		var = "Quartz3DB",
	},
	['sexmap'] = {
		var = "SexyMap2DB",
		FGet = function(var)
			local db = _G[var];
			local key = CPLAYER .. "-" .. CREALM;
			if db ~= nil and db[key] ~= nil then
				local p = db[key];
				if type(p) == 'string' then
					p = db[p];
				end
				if p ~= nil then
					return p;
				end
			end
		end,
		FSet = function(var, val)
			local key = CPLAYER .. "-" .. CREALM;
			local db = _G[var];
			if db == nil then
				db = {  };
				_G[var] = db;
			end
			if db[key] == "global" then
				db["global"] = val;
			else
				db[key] = val;
			end
		end,
	},
	['shadowedunitframes'] = {
		type = "AceDB",
		var = "ShadowedUFDB",
	},
	['skada'] = {
		type = "AceDB",
		var = "SkadaDB",
	},
	['tinyinspect'] = {
		type = "simple",
		var = "TinyInspectDB",
	},
	['tiptac'] = {
		type = "simple",
		var = "TipTac_Config",
	},
	['worldquestslist'] = {
		ignore = true,
		var = "VWQL",
	},
	['worldquesttracker'] = {
		type = "AceDB",
		var = "WQTrackerDB",
	},
	['xloot'] = {
		type = "AceDB",
		var = "XLootADB",
	},
};



-->		Get
local function FHandlePcallReturn(ok, ...)
	FDebug(ok, ...);
	if ok then
		return ok, { select("#", ...) + 1, ... };
	else
		return ok;
	end
end
function WExtern:FGet()
	local TData = {};
	--	1 = addon_enabled
	--[=[
	local addon_enabled = {};
	for index = 1, GetNumAddOns() do
		local name = GetAddOnInfo(index);
		addon_enabled[strlower(name)] = GetAddOnEnableState(nil, index) > 0;
	end
	TData.addon_enabled = addon_enabled;
	FDebug("done addon_enabled");
	--]=]
	--	2 = blz_variable
	local blz_variable = {  };
	for index = 1, #TBlzOptionKeys do
		local key = TBlzOptionKeys[index];
		if type(key) == 'string' then
			local value = GetCVar(key);
			blz_variable[index] = value;
		elseif type(key) == 'table' then
			if key[1] ~= nil then
				local ok, val = FHandlePcallReturn(pcall(key[1], unpack(key, 3)))
				FDebug(index, key[3], val[1], val[2], val[3])
				if ok then
					blz_variable[index] = val;
				end
			end
		else
			_F_corePrint("|124cffff0000Invalid Option Key ", index, key);
		end
	end
	TData.blz_variable = blz_variable;
	FDebug("done blz_variable");
	--	3 = blz_layout
	local blzlayout = {};
	for key, meta in next, TBlzLayoutMeta do
		if meta.FGet ~= nil then
			local ok, tbl = pcall(meta.FGet);
			if ok then
				blzlayout[key] = tbl;
			else
				FDebug('gbl', key);
			end
		end
	end
	TData.blzlayout = blzlayout;
	FDebug("done blzlayout");
	--	4 = addon_variableiable
	local addon_variable = {};
	for addon, meta in next, TAddonVariableMeta do
		if not meta.ignore then
			local type = meta.type;
			local var = meta.var;
			local mod = meta.mod;
			local FGet = nil;
			if type ~= nil and TAddonVariableTypeMethod[type] ~= nil then
				FGet = TAddonVariableTypeMethod[type].FGet or meta.FGet;
			else
				FGet = meta.FGet;
			end
			if FGet ~= nil then
				local ok, variable = pcall(FGet, var);
				if ok and variable ~= nil then
					if mod ~= nil then
						addon_variable[addon] = mod(variable);
					else
						addon_variable[addon] = variable;
					end
				else
					FDebug('gav', addon);
				end
			end
		end
	end
	TData.addon_variable = addon_variable;
	FDebug("done addon_variable");
	--
	-- return self:Serialize(TData);
	return __core._F_coreSerializer(false, TData);
end


-->		Set
local TBlackAddOnVariable = {  };
do
	local TData = nil;
	local AddonIndex = 0;
	local NumAddons = GetNumAddOns();
	local FOnUpdate, FApply1, FApply23, FApply4 = nil, nil, nil;
	--	Step 1: Load & Disable AddOns	--	Costs up to 25% CPU time.
	local prevCost = 0.0;
	FOnUpdate = function(self, elapsed)
		elapsed = elapsed - prevCost;
		debugprofilestart();
		local addon_enabled = TData.addon_enabled;
		local addon_variable = TData.addon_variable or {  };
		for index = AddonIndex + 1, NumAddons do
			local namelower = strlower(GetAddOnInfo(index));
			if addon_enabled[namelower] == true and not IsAddOnLoaded(index) and not IsAddOnLoadOnDemand(index) then
				LoadAddOn(index);
			end
			prevCost = debugprofilestop() * 0.001;
			if prevCost / elapsed > 0.25 then
				AddonIndex = index;
				WExtern:Progress(index / NumAddons);
				return;
			end
		end
		--	Step here after finishing loading Addons
		WExtern:Progress(1.0);
		if BaudErrorFrameConfig ~= nil and type(BaudErrorFrameConfig) == 'table' and BaudErrorFrameConfig.ErrorList ~= nil and type(BaudErrorFrameConfig.ErrorList) == 'table' then
			-- wipe(BaudErrorFrameConfig.ErrorList);
		end
		self:SetScript("OnUpdate", nil);
		TData.addon_enabled = nil;
		FApply23();
	end
	FApply1 = function()
		local addon_enabled = TData.addon_enabled;
		for index = 1, NumAddons do
			local namelower = strlower(GetAddOnInfo(index));
			if addon_enabled[namelower] == true then
				EnableAddOn(index);
			else
				DisableAddOn(index);
			end
		end
		SaveAddOns();
		WExtern:SetScript("OnUpdate", FOnUpdate);
	end
	--	Step 2: Load CVar & Other Blizzard variables.
	--	Step 3: Apply layout of Blizzard's frames. ChatFrame, PlayerFrame, TargetFrame, eg.
	FApply23 = function()
		--	2 = blz_option
		if TOptions.blz_variable then
			local blz_variable = TData.blz_variable;
			if blz_variable ~= nil then
				for index = 1, #blz_variable do
					local key = TBlzOptionKeys[index];
					local val = blz_variable[index];
					if type(key) == 'string' then
						if val ~= nil then
							SetCVar(key, val);
						end
					elseif type(key) == 'table' then
						if key[2] ~= nil then
							if (key[3] ~= nil and not pcall(key[2], key[3], unpack(val, 2, val[1]))) or (key[3] == nil and not pcall(key[2], unpack(val, 2, val[1]))) then
								FDebug('sbv', index, key[3]);
							end
						end
					else
						_F_corePrint("|124cffff0000Invalid Option Key ", index, key);
					end
				end
			end
		end
		TData.blz_variable = nil;
		--	3 = blz_layout
		if TOptions.blz_layout then
			local blzlayout = TData.blzlayout;
			if blzlayout ~= nil then
				for key, meta in next, TBlzLayoutMeta do
					local val = blzlayout[key];
					if val ~= nil and meta.FSet ~= nil then
						if not pcall(meta.FSet, val) then
							FDebug('sbl', key);
						end
					end
				end
			end
		end
		TData.blzlayout = nil;
		C_Timer.After(0.2, FApply4);
	end
	--	Step 4: Apply AddOns' variable at PLAYER_LOGOUT
	function WExtern:PLAYER_LOGOUT()
		--	4 = addon_variableiable
		if TOptions.addon_variable then
			local addon_variable = TData.addon_variable;
			for addon, meta in next, TAddonVariableMeta do
				local val = addon_variable[addon];
				if val ~= nil and TBlackAddOnVariable[addon:lower()] ~= false then
					local var = meta.var;
					local type = meta.type;
					local FSet = nil;
					if type ~= nil and TAddonVariableTypeMethod[type] ~= nil then
						FSet = TAddonVariableTypeMethod[type].FSet or meta.FSet;
					else
						FSet = meta.FSet;
					end
					if FSet ~= nil then
						if not pcall(FSet, var, val) then
							FDebug('sav', addon);
						end
					end
				end
			end
		end
		TData.addon_variable = nil;
	end
	FApply4 = function()
		WExtern.WProgress.ReloadUI:Show();
	end
	--
	function WExtern:FApply()
		TData = self.TData;
		if TData ~= nil then
			self.TData = nil;
			--	1 = addon_enabled
			if TOptions.addon_enabled then
				WExtern:Progress(0);
				FApply1();
			else
				WExtern:Progress(1.0);
				FApply23();
			end
		end
	end
end

function WExtern:FPut(CStr)
	-- local ok, TData = self:Deserialize(CStr);
	local ok, TData = __core._F_coreDeserializer(CStr);
	if ok and TData ~= nil then
		self:FConfirmApply(TData);
		return true;
	end
end




-->		GUI
local TempTBlackAddOnVariable = {  };

local function FMakeMovable(frame)
	frame:EnableMouse(true);
	frame:RegisterForDrag("LeftButton");
	frame:SetMovable(true);
	frame:SetScript("OnDragStart", frame.StartMoving);
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
end

local function FMakeBackground(parent, r, g, b, a, bdr, bdg, bdb, bda)
	r, g, b, a = r or 0.0, g or 0.0, b or 0.0, a or 0.75;
	local bg = parent:CreateTexture(nil, "BACKGROUND");
	bg:SetAllPoints();
	bg:SetColorTexture(r, g, b, a);
	bdr, bdg, bdb, bda = bdr or 0.5, bdg or 0.5, bdb or 0.5, bda or 0.9;
	local w = 1;
	local l = parent:CreateTexture(nil, "BACKGROUND");
	l:SetWidth(w);
	l:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", 0, 0);
	l:SetPoint("TOPRIGHT", parent, "TOPLEFT", 0, w);
	l:SetColorTexture(bdr, bdg, bdb, bda);
	local t = parent:CreateTexture(nil, "BACKGROUND");
	t:SetHeight(w);
	t:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 0);
	t:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", w, 0);
	t:SetColorTexture(bdr, bdg, bdb, bda);
	local r = parent:CreateTexture(nil, "BACKGROUND");
	r:SetWidth(w);
	r:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0);
	r:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 0, -w);
	r:SetColorTexture(bdr, bdg, bdb, bda);
	local b = parent:CreateTexture(nil, "BACKGROUND");
	b:SetHeight(w);
	b:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, 0);
	b:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", -w, 0);
	b:SetColorTexture(bdr, bdg, bdb, bda);
	return bg, { l, t, r, b, };
end
local function FMakeLabel(parent, text, ...)
	local label = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	label:SetPoint(...);
	label:SetText(text);
	return label;
end
local function FMakeButton(parent, OnClick, var, text, width, height, fontSize, ...)
	width = width or 60;
	height = height or 20;
	fontSize = fontSize or 15;
	local button = CreateFrame('BUTTON', nil, parent);
	button:SetSize(width, height);
	button:SetPoint(...);
	button.var = var;
	--
	local nt = button:CreateTexture(nil, "ARTWORK");
	nt:SetColorTexture(0.1, 0.1, 0.1, 1.0);
	nt:SetAllPoints();
	button:SetNormalTexture(nt);
	local pt = button:CreateTexture(nil, "ARTWORK");
	pt:SetColorTexture(0.25, 0.25, 0.25, 1.0);
	pt:SetAllPoints();
	button:SetPushedTexture(pt);
	local dt = button:CreateTexture(nil, "ARTWORK");
	dt:SetColorTexture(0.0, 0.0, 0.0, 1.0);
	dt:SetAllPoints();
	button:SetDisabledTexture(dt);
	local ht = button:CreateTexture(nil, "HIGHLIGHT");
	ht:SetColorTexture(0.0, 0.25, 0.25, 0.5);
	ht:SetAllPoints();
	button:SetHighlightTexture(ht);
	local Text = button:CreateFontString(nil, "ARTWORK");
	Text:SetPoint("CENTER");
	Text:SetFontObject(GameFontNormal);
	Text:SetText(text);
	button.Text = Text;
	--
	button:SetScript("OnClick", OnClick);
	parent[var] = button;
	return button;
end
local function FMakeCheckButton(parent, OnClick, var, text, size, fontSize, ...)
	size = size or 16;
	fontSize = fontSize or 15;
	local check = CreateFrame('CHECKBUTTON', nil, parent);
	check:SetSize(size, size);
	check:SetPoint(...);
	check.var = var;
	--
	check:SetNormalTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonBorder]]);
	check:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 0.25);
	check:SetPushedTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonBorder]]);
	check:GetPushedTexture():SetVertexColor(0.5, 0.5, 1.0, 0.25);
	check:SetDisabledTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonBorder]]);
	check:GetDisabledTexture():SetVertexColor(0.5, 0.5, 1.0, 0.5);
	check:SetHighlightTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonBorder]]);
	check:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 0.15);
	check:SetCheckedTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonCenter]]);
	check:GetCheckedTexture():SetVertexColor(0.2, 0.75, 0.5, 0.5);
	check:SetDisabledCheckedTexture(_C_CORE_PATH_TEXTURE .. [[CheckButtonCenter]]);
	check:GetDisabledCheckedTexture():SetVertexColor(0.2, 1.0, 0.5, 0.15);
	local Text = check:CreateFontString(nil, "ARTWORK");
	Text:SetPoint("LEFT", check, "RIGHT", 4, 0);
	Text:SetFontObject(GameFontNormal);
	Text:SetText(text);
	check.Text = Text;
	--
	check:SetHitRectInsets(0, 0, 0, 0);
	check:SetScript("OnClick", OnClick);
	parent[var] = check;
	return check;
end


local function FVariableBlackButtonOnClick(self, button)
	if self.var == 'cancel' then
		WExtern.WVariableBlack:Hide();
	elseif self.var == 'okay' then
		WExtern.WVariableBlack:Hide();
		TBlackAddOnVariable = TempTBlackAddOnVariable;
	elseif self.var == 'close' then
		WExtern.WVariableBlack:Hide();
	end
end
local function FVariableBlackCheckButtonOnClick(self, button)
	TempTBlackAddOnVariable[self.var] = self:GetChecked();
end
function WExtern:FVariableBlack(TData)
	TempTBlackAddOnVariable = {  };
	local WVariableBlack = self.WVariableBlack;
	if WVariableBlack == nil then
		WVariableBlack = CreateFrame('FRAME', nil, UIParent);
		WVariableBlack:SetFrameLevel(2);
		WVariableBlack:SetSize(240, 180);
		WVariableBlack:SetPoint("LEFT", self.WConfirm, "RIGHT", 8, 0);
		WVariableBlack:SetFrameStrata("DIALOG");
		FMakeBackground(WVariableBlack, 0.0, 0.0, 0.0, 1.0);
		FMakeLabel(WVariableBlack, "选择要应用的插件设置", "TOP", 0, -16);
		FMakeButton(WVariableBlack, FVariableBlackButtonOnClick, 'cancel', "取消", nil, nil, nil, "BOTTOM", -75, 16);
		FMakeButton(WVariableBlack, FVariableBlackButtonOnClick, 'okay', "确定", nil, nil, nil, "BOTTOM", 0, 16);
		FMakeButton(WVariableBlack, FVariableBlackButtonOnClick, 'close', "关闭", nil, nil, nil, "BOTTOM", 75, 16);
		WVariableBlack.WLVarCheck = {  };
		self.WVariableBlack = WVariableBlack;
	end
	local addon_variable = TData.addon_variable;
	local WLVarCheck = WVariableBlack.WLVarCheck;
	local index = 1;
	for var, _ in next, addon_variable do
		var = var:lower();
		local info = _T_addonInfo[var];
		local check = WLVarCheck[index];
		local title = info.title and (info.title .. "(" .. (info.name or var) .. ")") or info.name or var;
		if check ~= nil then
			check.Text:SetText(title);
			check.var = var;
		else
			check = FMakeCheckButton(WVariableBlack, FVariableBlackCheckButtonOnClick, var, title, nil, nil, "LEFT", WVariableBlack, "TOPLEFT", 24, -24 - index * 24);
			WLVarCheck[index] = check;
		end
		check:SetChecked(TBlackAddOnVariable[var] ~= false);
		index = index + 1;
	end
	self.TData = TData;
	WVariableBlack:SetHeight(56 + index * 24);
	WVariableBlack:Show();
end

local function FConfirmButtonOnClick(self, button)
	if self.var == 'cancel' then
		WExtern.WConfirm:Hide();
		WExtern.TData = nil;
		WExtern.WGUI:Show();
	elseif self.var == 'okay' then
		if InCombatLockdown() then
			_F_corePrint("|cffff0000战斗状态中，请脱离战斗后继续|r")
		else
			WExtern.WConfirm:Hide();
			WExtern:FApply();
		end
	elseif self.var == 'close' then
		WExtern.WConfirm:Hide();
	elseif self.var == 'black' then
		WExtern:FVariableBlack(WExtern.TData)
	end
end
local function FConfirmCheckButtonOnClick(self, button)
	TOptions[self.var] = self:GetChecked();
end
function WExtern:FConfirmApply(TData)
	TBlackAddOnVariable = {  };
	local WConfirm = self.WConfirm;
	if WConfirm == nil then
		WConfirm = CreateFrame('FRAME', nil, UIParent);
		WConfirm:SetFrameLevel(2);
		WConfirm:SetSize(240, 180);
		WConfirm:SetPoint("CENTER");
		WConfirm:SetFrameStrata("DIALOG");
		FMakeBackground(WConfirm, 0.0, 0.0, 0.0, 1.0);
		FMakeLabel(WConfirm, "确定应用以下设置并重载吗？", "TOP", 0, -16);
		FMakeCheckButton(WConfirm, FConfirmCheckButtonOnClick, 'blz_variable', "暴雪界面设置", nil, nil, "LEFT", WConfirm, "TOPLEFT", 24, -48);
		FMakeCheckButton(WConfirm, FConfirmCheckButtonOnClick, 'blz_layout', "暴雪界面布局", nil, nil, "LEFT", WConfirm, "TOPLEFT", 24, -72);
		-- FMakeCheckButton(WConfirm, FConfirmCheckButtonOnClick, 'addon_enabled', "插件开启状态", nil, nil, "LEFT", WConfirm, "TOPLEFT", 24, -96);
		FMakeCheckButton(WConfirm, FConfirmCheckButtonOnClick, 'addon_variable', "插件设置", nil, nil, "LEFT", WConfirm, "TOPLEFT", 24, -96);
		FMakeButton(WConfirm, FConfirmButtonOnClick, 'black', "选择插件", 90, nil, nil, "LEFT", WConfirm, "TOPLEFT", 126, -96);
		FMakeButton(WConfirm, FConfirmButtonOnClick, 'cancel', "取消", nil, nil, nil, "BOTTOM", -75, 16);
		FMakeButton(WConfirm, FConfirmButtonOnClick, 'okay', "确定", nil, nil, nil, "BOTTOM", 0, 16);
		FMakeButton(WConfirm, FConfirmButtonOnClick, 'close', "关闭", nil, nil, nil, "BOTTOM", 75, 16);
		self.WConfirm = WConfirm;
	end
	for key, checked in next, TOptions do
		WConfirm[key]:SetChecked(checked);
	end
	if TData.addon_variable ~= nil then
		WConfirm.black:Show();
	else
		WConfirm.black:Hide();
	end
	self.TData = TData;
	WConfirm:Show();
end

local function FMakeScrollableEdit(parent, width, height, ...)
	local scroll = CreateFrame('ScrollFrame', nil, parent, "UIPanelScrollFrameTemplate");
	scroll:SetSize(width, height);
	scroll:SetPoint(...);
	FMakeBackground(scroll, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.9);
	local edit = CreateFrame('EDITBOX', nil, scroll);
	edit:SetWidth(width - 4);
	edit:SetMultiLine(true);
	edit:SetAutoFocus(false);
	edit:SetFontObject(GameFontNormal);
	edit:SetScript("OnEnterPressed", edit.ClearFocus);
	edit:SetScript("OnEscapePressed", edit.ClearFocus);
	edit:SetScript("OnTextSet", edit.HighlightText);
	edit:SetScript("OnMouseUp", edit.HighlightText);
	scroll.cursorOffset = 0;
	scroll:SetScrollChild(edit);
	scroll:SetScript("OnMouseDown", function() edit:SetFocus(); end);
	return edit;
end
local function FGUIButtonOnClick(self, button)
	if self.var == 'close' then
		self:GetParent():Hide();
	elseif self.var == 'export' then
		local str = WExtern:FGet();
		if str ~= nil and str ~= "" then
			local edit = self.edit;
			edit:SetText(str);
			edit:SetFocus();
		end
	elseif self.var == 'import' then
		local str = self:GetParent().edit:GetText();
		if WExtern:FPut(str) then
			WExtern.WGUI:Hide();
			WExtern.WGUI.MSG:SetText("");
		else
			WExtern.WGUI.MSG:SetText("不是正确的字符串");
		end
	end
end
function WExtern:FShowGUI(shown)
	if self.WGUI == nil then
		local WGUI = CreateFrame('FRAME', nil, UIParent);
		WGUI:SetFrameLevel(1);
		WGUI:SetSize(540, 740);
		WGUI:SetPoint("CENTER");
		WGUI:SetFrameStrata("HIGH");
		FMakeMovable(WGUI);
		FMakeBackground(WGUI);
		FMakeLabel(WGUI, "|cff880303【网易有爱】|r · 导入/导出", "TOP", 0, -12);
		FMakeButton(WGUI, FGUIButtonOnClick, 'close', "关闭", nil, nil, 16, "TOPRIGHT", -4, -4);
		WGUI.edit = FMakeScrollableEdit(WGUI, 480, 600, "TOP", 0, -36);
		FMakeButton(WGUI, FGUIButtonOnClick, 'export', "导出", nil, nil, nil, "BOTTOM", -60, 74).edit = WGUI.edit;
		FMakeButton(WGUI, FGUIButtonOnClick, 'import', "导入", nil, nil, nil, "BOTTOM", 60, 74).edit = WGUI.edit;
		WGUI.MSG = FMakeLabel(WGUI, "", "BOTTOM", 0, 44);
		WGUI.MSG:SetVertexColor(1.0, 0.0, 0.0, 1.0);
		FMakeLabel(WGUI, "可以导入导出的设置包括：ESC-界面里除了团队界面配置之外的所有设置、", "BOTTOM", 0, 24);
		FMakeLabel(WGUI, "玩家和目标头像位置、聊天框所有设置、插件开启状态、主要插件变量", "BOTTOM", 0, 8);
		self.WGUI = WGUI;
	end
	WExtern.WGUI.MSG:SetText("");
	self.WGUI:Show();
end

local function FProgressButtonOnClick()
	WExtern:RegisterEvent("PLAYER_LOGOUT");
	ConsoleExec("ReloadUI");
end
function WExtern:Progress(val)
	local WProgress = self.WProgress;
	if WProgress == nil then
		WProgress = CreateFrame('FRAME', nil, UIParent);
		WProgress:SetSize(328, 32);
		WProgress:SetPoint("TOP", 0, -160);
		WProgress:SetFrameStrata("FULLSCREEN");
		FMakeBackground(WProgress, 0.0, 0.0, 0.0, 1.0, 0.5, 0.5, 0.5, 1.0);
		local B = WProgress:CreateTexture(nil, "OVERLAY", 0);
		B:SetSize(320, 24);
		B:SetPoint("CENTER");
		B:SetColorTexture(1.0, 0.5, 0.0, 0.5);
		local T = WProgress:CreateTexture(nil, "OVERLAY", 0);
		T:SetHeight(24);
		T:SetPoint("LEFT", B, "LEFT", 0, 0);
		T:SetColorTexture(1.0, 0.5, 0.0, 1.0);
		local V = WProgress:CreateFontString(nil, "OVERLAY", 1);
		V:SetFontObject(GameFontNormal);
		V:SetScale(2.0);
		V:SetPoint("CENTER");
		WProgress.WT = T;
		WProgress.WV = V;
		local ReloadUI = FMakeButton(WProgress, FProgressButtonOnClick, 'ReloadUI', "重载界面", 120, 40, 20, "TOP", WProgress, "BOTTOM", 0, -32);
		ReloadUI:Hide();
		ReloadUI.timer = 0.0;
		local mask = ReloadUI:CreateTexture(nil, "OVERLAY", 7);
		mask:SetPoint("BOTTOMLEFT", 4, 4);
		mask:SetPoint("TOPRIGHT", -4, -4);
		mask:SetBlendMode("ADD");
		mask:SetColorTexture(0.0, 0.0, 0.0, 0.5);
		ReloadUI.mask = mask;
		ReloadUI:SetScript("OnUpdate", function(self, elapsed)
			local timer = self.timer + elapsed;
			if timer > 1.0 then
				timer = timer % 1.0;
				self.reverse = not self.reverse;
			end
			local c = timer * timer;
			if self.reverse then
				mask:SetColorTexture(1 - c, 1 - c, 1 - c, 0.5);
			else
				mask:SetColorTexture(c, c, c, 0.5);
			end
			self.timer = timer;
		end);
		self.WProgress = WProgress;
	end
	WProgress:Show();
	WProgress.WT:SetWidth(320 * val);
	WProgress.WV:SetText(format("%.2f%%", val * 100));
end


-->		External
WExtern.ShowExtern = function()
	WExtern:FShowGUI();
	local U1Frame = _G.U1Frame or __namespace.__ui._W_MainUI;
	if U1Frame ~= nil then
		U1Frame:Hide();
	end
end
WExtern.ToggleExtern = function()
	if WExtern.WGUI ~= nil and WExtern.WGUI:IsShown() then
		WExtern.WGUI:Hide();
	else
		WExtern.ShowExtern();
	end
end
WExtern.devGetExtern = function()
	return WExtern.TData;
end

__namespace.__module.__u1externprofile = WExtern;
