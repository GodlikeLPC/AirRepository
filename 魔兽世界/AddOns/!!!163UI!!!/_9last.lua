--[=[
	LAST
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;
local LOC = __namespace.__locale;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core._9last");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local pcall = pcall;
local time = time;
local type = type;
local next, unpack = next, unpack;
local tinsert, tremove, wipe = table.insert, table.remove, table.wipe;
local strlower, strsplit, format = strlower, string.split, string.format;
local loadstring = loadstring;
local tostring = tostring;
local C_Timer_After = C_Timer.After;
local CreateFrame = CreateFrame;
local EnableAddOn, LoadAddOn = EnableAddOn, LoadAddOn;
local ReloadUI = ReloadUI;
local _G = _G;
local SlashCmdList = SlashCmdList;

local texdeepcopy = table.exdeepcopy;

local __DB = nil;
local __db = nil;
local __scriptglobal, __scriptcharacter = nil, nil;

local _C_CharKey = __const._C_PLAYER_NAME .. " - " .. __const._C_REALM;

if __core.__is_dev then
	__core._F_BuildEnv("core._9last");
end

-->		Script
	--[[
		"global.general.*", "character.general.*"
			"beforeinit"
			"afterinit"
			"gameloaded"
		"global.addon.*", "character.addon.*"
			"beforeinit"
			"afterinit"
		--
		script = {
			["general.beforeinit"] = "",
			["general.afterinit"] = "",
			["general.gameloaded"] = "",
			["addon.beforeinit"] = { [addon] = "", ... },
			["addon.afterinit"] = { [addon] = "", ... },
		};
	--]]
	local function _LF_NewScriptTable()
		return {
			["general.beforeinit"] = {  },
			["general.afterinit"] = {  },
			["general.gameloaded"] = {  },
			["general.logout"] = {  },
			["addon.beforeinit"] = {  },
			["addon.afterinit"] = {  },
		};
	end
	local function _LF_ExcuteScriptError(isGlobal, Category, Key, Script, Error)
		if isGlobal then
			if Error == nil then
				error("|cffff7f00Custom Script Error.|r Category [|cff00ff00" .. LOC["globa." .. Category] .. "|r] Key [|cff00ff7f" .. Key .. "|r]");
			else
				error("|cffff7f00Custom Script Error.|r Category [|cff00ff00" .. LOC["globa." .. Category] .. "|r] Key [|cff00ff7f" .. Key .. "|r]\n" .. Error);
			end
		else
			if Error == nil then
				error("|cffff7f00Custom Script Error.|r Category [|cff00ff00" .. LOC["character." .. Category] .. "|r] Key [|cff00ff7f" .. Key .. "|r]");
			else
				error("|cffff7f00Custom Script Error.|r Category [|cff00ff00" .. LOC["character." .. Category] .. "|r] Key [|cff00ff7f" .. Key .. "|r]\n" .. Error);
			end
		end
	end
	local function _F_coreExcuteScript(isGlobal, Category, Key)
		local _db = isGlobal and __DB.script or __db.script;
		local _Script = _db[Category][Key];
		if _Script ~= nil then
			local _func, _err = loadstring(_Script);
			if _func ~= nil then
				local _success, _ret = pcall(_func);
				if not _success then
					_LF_ExcuteScriptError(isGlobal, Category, Key, _Script, _ret);
				end
			else
				_LF_ExcuteScriptError(isGlobal, Category, Key, _Script, _err);
			end
		end
	end
	function __core._F_coreAddScript(isGlobal, Category, Key, Script, OverwiteKey)
		if Key ~= nil and type(Key) == 'string' then
			local _db = isGlobal and __DB.script or __db.script;
			local _ScriptList = _db[Category];
			if _ScriptList ~= nil then
				Key = strlower(Key);
				if _ScriptList[Key] == nil then
					if OverwiteKey ~= nil and OverwiteKey ~= Key and _ScriptList[OverwiteKey] ~= nil then
						for _index = 1, #_ScriptList do
							if _ScriptList[_index] == OverwiteKey then
								_ScriptList[_index] = Key;
								_ScriptList[OverwiteKey] = nil;
								break;
							end
						end
					else
						_ScriptList[#_ScriptList + 1] = Key;
					end
				end
				_ScriptList[Key] = Script;
				__core:FireEvent("SCRIPT_LIST", isGlobal, Category);
			end
		end
	end
	function __core._F_coreSubScript(isGlobal, Category, Key)
		if Key ~= nil and type(Key) == 'string' then
			local _db = isGlobal and __DB.script or __db.script;
			local _ScriptList = _db[Category];
			if _ScriptList ~= nil then
				Key = strlower(Key);
				if _ScriptList[Key] ~= nil then
					for _index = 1, #_ScriptList do
						if _ScriptList[_index] == Key then
							tremove(_ScriptList, _index);
							break;
						end
					end
					_ScriptList[Key] = nil;
					__core:FireEvent("SCRIPT_LIST", isGlobal, Category);
				end
			end
		end
	end
	function __core._F_coreGetScript(isGlobal, Category, Key)
		if Key ~= nil and type(Key) == 'string' then
			local _db = isGlobal and __DB.script or __db.script;
			local _ScriptList = _db[Category];
			if _ScriptList ~= nil then
				Key = strlower(Key);
				local _Script = _ScriptList[Key];
				if _Script ~= nil then
					return _Script, true;
				else
					return nil, true;
				end
			end
		end
		return nil, false;
	end
	function __core._F_coreHasScript(isGlobal, Category, Key)
		if Key ~= nil and type(Key) == 'string' then
			local _db = isGlobal and __DB.script or __db.script;
			local _ScriptList = _db[Category];
			if _ScriptList ~= nil then
				Key = strlower(Key);
				if _ScriptList[Key] ~= nil then
					return true;
				else
					return false, true;
				end
			end
		end
		return false, false;
	end
	__core._F_coreExcuteScript = _F_coreExcuteScript;
	local function _F_coreExcuteCategoryScripts(isGlobal, Category)
		local _db = isGlobal and __DB.script or __db.script;
		local _ScriptList = _db[Category];
		if _ScriptList ~= nil then
			for _index = 1, #_ScriptList do
				_F_coreExcuteScript(isGlobal, Category, _ScriptList[_index]);
			end
		end
	end
-->


-->		Profile
	local function _F_coreNewProfile(key, SaveState, SaveConfig, SaveMisc, SaveScript)
		if key ~= "__default" then
			local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
			local _db = {
				__time = time(),
				__char = __const._C_PLAYER_GUID,
				__name = __const._C_PLAYER_NAME,
				__class = __const._C_PLAYER_CLASS,
				__realm = __const._C_REALM,
			};
			if __db ~= nil then
				_db.ui_variables = texdeepcopy(__db.ui_variables);
				if SaveState ~= false then
					_db.addons_state = texdeepcopy(__db.addons_state);
				end
				if SaveConfig ~= false then
					_db.addons_config = texdeepcopy(__db.addons_config);
				end
				if SaveMisc ~= false then
					_db.mmb_collected = texdeepcopy(__db.mmb_collected);
					_db.mmb_variables = texdeepcopy(__db.mmb_variables);
					_db.addons_frames = texdeepcopy(__db.addons_frames, {  });
				end
				if SaveScript ~= false then
					_db.script = texdeepcopy(__db.script);
				end
			end
			if __profiles[key] == nil then
				__profileList[#__profileList + 1] = key;
			end
			__profiles[key] = _db;
			__core:FireEvent("PROFILE_LIST", 'profile');
			return _db;
		else
			local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
			if __profiles.__default == nil then
				tinsert(__profileList, 1, "__default");
				local _db = {
					__time = time(),
					__char = __const._C_PLAYER_GUID,
					__name = __const._C_PLAYER_NAME,
					__class = __const._C_PLAYER_CLASS,
					__realm = __const._C_REALM,
					--	ui_variables	--	_6ui.lua		def _DB_UIVariables
					--	addons_state	--	_4addon.lua		def __namespace.__default.addons_state;
					--	addons_config	--	_4addon.lua		def _DB_AddOnsConfig
					--	mmb_collected	--	_6ui.lua		def {}
					--	mmb_variables	--	_6ui.lua		def { minimapPos = 200, };
					--	addons_frames	--	_addon.lua		def _DB_AddOnsFrame
					script = _LF_NewScriptTable(),
				};
				__profiles.__default = _db;
				__core:FireEvent("PROFILE_LIST", 'profile');
				return _db;
			end
		end
	end
	local function _F_coreDelProfile(key)
		if key ~= "__default" then
			local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
			if __profiles[key] ~= nil then
				__profiles[key] = nil;
				for _index = 1, #__profileList do
					if __profileList[_index] == key then
						tremove(__profileList, _index);
						break;
					end
				end
				__core:FireEvent("PROFILE_LIST", 'profile');
			end
			for GUID, profileKey in next, __profileKeys do
				if profileKey == key then
					__profileKeys[GUID] = __DB.__useglobalprofile and "__default" or nil;
				end
			end
		end
	end
	local function _F_coreRenProfile(key, to)
		if key ~= "__default" then
			local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
			if __profiles[key] ~= nil then
				__profiles[to] = __profiles[key];
				__profiles[key] = nil;
				for _index = 1, #__profileList do
					if __profileList[_index] == key then
						__profileList[_index] = to;
					end
				end
				for GUID, profileKey in next, __profileKeys do
					if profileKey == key then
						__profileKeys[GUID] = to;
					end
				end
				__core:FireEvent("PROFILE_LIST", 'profile');
			end
		end
	end
	local function _F_coreManualProfile(key, SaveState, SaveConfig, SaveMisc, SaveScript)
		local _db = __DB.auto[index];
		if _db ~= nil then
			if __db ~= nil and __db ~= _db then
				if SaveState ~= false then
					_db.addons_state = texdeepcopy(__db.addons_state, {  });
				end
				if SaveConfig ~= false then
					_db.addons_config = texdeepcopy(__db.addons_config, {  });
				end
				if SaveMisc ~= false then
					_db.mmb_collected = texdeepcopy(__db.mmb_collected);
					_db.mmb_variables = texdeepcopy(__db.mmb_variables);
					_db.addons_frames = texdeepcopy(__db.addons_frames, {  });
				end
				if SaveScript ~= false then
					_db.script = texdeepcopy(__db.script);
				end
			end
		end
		return _db;
	end
	local function _F_coreSetProfileKey(GUID, key)
		local __profileKeys, __profiles = __DB.profileKeys, __DB.profiles;
		if __profiles[key] ~= nil then
			__profileKeys[GUID] = key;
		end
	end
	local function _F_coreGetCharProfile(GUID)
		local __profileKeys, __profiles = __DB.profileKeys, __DB.profiles;
		local _key = __profileKeys[GUID];
		if _key == nil then
			_key = __DB.__useglobalprofile and "__default" or __const._C_PLAYER_NAME .. "-" .. __const._C_REALM;
			__profileKeys[GUID] = _key;
		end
		local __db = __profiles[_key];
		if __db == nil then
			__db = _F_coreNewProfile(_key);
			__db.__first_time = true;
		end
		return __db;
	end
	local function _F_coreNewAuto(flag, SaveState, SaveConfig, SaveMisc, SaveScript)
		flag = flag or "LOGIN";		--	"LOGIN", "LOGOUT"
		local _auto = __DB.auto;
		for _index = 1, #_auto do
			if _auto[_index].__char == __const._C_PLAYER_GUID and _auto[_index].__key == flag then
				tremove(_auto, _index);
				break;
			end
		end
		local _db = {
			__type = 'auto',
			__key = flag,
			__time = time(),
			__char = __const._C_PLAYER_GUID,
			__name = __const._C_PLAYER_NAME,
			__class = __const._C_PLAYER_CLASS,
			__realm = __const._C_REALM,
		};
		if __db ~= nil then
			_db.ui_variables = texdeepcopy(__db.ui_variables);
			if SaveState ~= false then
				_db.addons_state = texdeepcopy(__db.addons_state);
			end
			if SaveConfig ~= false then
				_db.addons_config = texdeepcopy(__db.addons_config);
			end
			if SaveMisc ~= false then
				_db.mmb_collected = texdeepcopy(__db.mmb_collected);
				_db.mmb_variables = texdeepcopy(__db.mmb_variables);
				_db.addons_frames = texdeepcopy(__db.addons_frames);
			end
			if SaveScript ~= false then
				_db.script = texdeepcopy(__db.script);
			end
		end
		tinsert(_auto, 1, _db);
		__core:FireEvent("PROFILE_LIST", 'auto');
	end
	local function _F_coreDelAuto(index)
		if __DB.auto[index] ~= nil then
			tremove(__DB.auto, index);
			__core:FireEvent("PROFILE_LIST", 'auto');
		end
	end
	local function _F_coreRenAuto(index, to)
		local _db = __DB.auto[index];
		if _db ~= nil then
			_db.__key = to;
			__core:FireEvent("PROFILE_LIST", 'auto');
		end
	end
	local function _F_coreManualAuto(index, SaveState, SaveConfig, SaveMisc, SaveScript)
		local _db = __DB.auto[index];
		if _db ~= nil then
			if __db ~= nil then
				if SaveState ~= false then
					_db.addons_state = texdeepcopy(__db.addons_state, {  });
				end
				if SaveConfig ~= false then
					_db.addons_config = texdeepcopy(__db.addons_config, {  });
				end
				if SaveMisc ~= false then
					_db.mmb_collected = texdeepcopy(__db.mmb_collected);
					_db.mmb_variables = texdeepcopy(__db.mmb_variables);
					_db.addons_frames = texdeepcopy(__db.addons_frames, {  });
				end
				if SaveScript ~= false then
					_db.script = texdeepcopy(__db.script);
				end
			end
		end
		return _db;
	end
	local function _F_coreLoadAuto(index)
		local _auto = __DB.auto[index];
		if _auto ~= nil then
			__DB.profiles[__DB.profileKeys[__const._C_PLAYER_GUID]] = {
				ui_variables = texdeepcopy(_auto.ui_variables),
				addons_state = texdeepcopy(_auto.addons_state),
				addons_config = texdeepcopy(_auto.addons_config),
				mmb_collected = texdeepcopy(_auto.mmb_collected),
				mmb_variables = texdeepcopy(_auto.mmb_variables),
				addons_frames = texdeepcopy(_auto.addons_frames),
			};
		end
	end
	local function _F_coreLoadProfile(key)
		__DB.profileKeys[__const._C_PLAYER_GUID] = key;
	end
	__core._F_coreNewProfile = _F_coreNewProfile;
	__core._F_coreDelProfile = _F_coreDelProfile;
	__core._F_coreRenProfile = _F_coreRenProfile;
	__core._F_coreManualProfile = _F_coreManualProfile;
	__core._F_coreSetProfileKey = _F_coreSetProfileKey;
	__core._F_coreGetCharProfile = _F_coreGetCharProfile;
	__core._F_coreNewAuto = _F_coreNewAuto;
	__core._F_coreDelAuto = _F_coreDelAuto;
	__core._F_coreRenAuto = _F_coreRenAuto;
	__core._F_coreManualAuto = _F_coreManualAuto;
	__core._F_coreLoadAuto = _F_coreLoadAuto;
	__core._F_coreLoadProfile = _F_coreLoadProfile;
	function __core._F_coreMakeGlobalProfile()
		__DB.__useglobalprofile = true;
		local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
		local __charInfo = __DB.charInfos;
		if __db ~= nil then
			if __profiles["__default"] == nil then
				tinsert(__profileList, 1, "__default");
			end
			__profiles["__default"] = __db;
		elseif __profiles["__default"] == nil then
			_F_coreNewProfile("__default", true, true, true);
		end
		for GUID, _ in next, __profileKeys do
			local _info = __charInfo[GUID];
			if _info ~= nil then
				_info.prevdef = __profileKeys[GUID];
			end
			__profileKeys[GUID] = "__default";
		end
		ReloadUI();
	end
	function __core._F_coreMakeCharacterProfile()
		__DB.__useglobalprofile = false;
		local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
		local __charInfo = __DB.charInfos;
		for GUID, profileKey in next, __profileKeys do
			if profileKey == "__default" then
				local _info = __charInfo[GUID];
				if _info ~= nil then
					if _info.prevdef ~= nil and __profiles[_info.prevdef] ~= nil then
						__profileKeys[GUID] = _info.prevdef;
					elseif _info.defkey ~= nil and __profiles[_info.defkey] ~= nil then
						__profileKeys[GUID] = _info.defkey;
					end
				end
			end
		end
		ReloadUI();
	end
	function __core._F_coreValidateProfiles()
		local __profileKeys, __profiles, __profileList = __DB.profileKeys, __DB.profiles, __DB.profileList;
		local _KeyHash = {  };
		for _index = #__profileList, 1, -1 do
			local _key = __profileList[_index];
			if __profiles[_key] == nil then
				tremove(__profileList, _index);
			else
				_KeyHash[_key] = _index;
			end
		end
		for _key, _db in next, __profiles do
			if _KeyHash[_key] == nil then
				__profiles[_key] = nil;
			end
		end
	end
-->
__private.__oninit["_9last-Profile"] = function()
	_F_coreNewAuto("LOGIN");
end
__private.__onquit["_9last-Profile"] = function()
	_F_coreNewAuto("LOGOUT");
end

function __core._F_uiOpenExternProfile()
	local _ep = __namespace.__module.__u1externprofile;
	if _ep ~= nil then
		_ep:ShowExtern();
	end
end

local _LF_Init = nil;
_LF_Init = function()
	__core._F_devDebugProfileStart("core.init");
	--
	__const._C_PLAYER_GUID = __const._C_PLAYER_GUID or UnitGUID('player');
	if __const._C_PLAYER_GUID == nil then
		C_Timer_After(0.1, _LF_Init);
		_F_coreDebug("ReQuest GUID");
		return;
	end
	--	db
	__DB = _G.GLOBAL_CORE_SAVED;
	if __DB == nil or __DB.__version == nil or __DB.__version < 20210515.01 then
		__DB = {
			__useglobalprofile = false,
			profileKeys = {  },
			profiles = {  },
			profileList = {  },
			auto = {  },
			script = _LF_NewScriptTable(),
			charInfos = {  },
		};
		_F_coreNewProfile("__default", true, true, true);
		_G.GLOBAL_CORE_SAVED = __DB;
		__core._F_addonDisable("Aptechka");
	else
		if __DB.__version < 20210603.01 then
			__DB.script = _LF_NewScriptTable();
			for _key, _db in next, __DB.profiles do
				_db.script = nil;
			end
			for _key, _db in next, __DB.auto do
				_db.script = nil;
			end
		end
		if __DB.__version < 20211001.01 then
			for _, db in next, __DB.profiles do
				db.ui_definition = nil;
			end
			__DB.ui_definition = nil;
		end
		if __DB.__version < 20220912.01 then
			__core._F_addonDisable("Aptechka");
		end
		-- if __DB.__version < 99991231.99 then	--	alyways reset
		-- 	for _, db in next, __DB.profiles do
		-- 		db.ui_definition = nil;
		-- 	end
		-- 	__DB.ui_definition = nil;
		-- end
	end
	__DB.__version = 20220912.01;
	__namespace.__DB = __DB;
	__core._F_MergeGlobal(__DB);
	--
	__core._F_coreValidateProfiles();
	--
	local _charInfo = {
		name = __const._C_PLAYER_NAME,
		realm = __const._C_REALM,
		defkey = __const._C_PLAYER_NAME .. "-" .. __const._C_REALM,
		class = __const._C_PLAYER_CLASS,
		gender = __const._C_PLAYER_GENDER,
	};
	--	{ [raceName], [clientFileString], [raceID], } = C_CreatureInfo.GetRaceInfo(raceID)
	--	{ [name], [groupTag], } = C_CreatureInfo.GetFactionInfo(raceID)
	_charInfo.raceName, _charInfo.raceFile, _charInfo.raceID = __const._C_PLAYER_RACE, __const._C_PLAYER_RACEFILE, __const._C_PLAYER_RACEID;
	_charInfo.factionFile, _charInfo.faction = __const._C_PLAYER_FACTIONGROUP;
	__DB.charInfos[__const._C_PLAYER_GUID] = _charInfo;
	__db = _F_coreGetCharProfile(__const._C_PLAYER_GUID);
	__namespace.__db = __db;
	if __db.__version == nil or __db.__version < 20210521.01 then
		__db.__version = 20210521.01;
		__namespace.____fixeraaddon = true;
	end
	--
	EnableAddOn("163UI_Config");
	LoadAddOn("163UI_Config");
	--
	__scriptglobal = __DB.script;
	__scriptcharacter = __db.script;
	if __scriptcharacter == nil then
		__scriptcharacter = _LF_NewScriptTable();
		__db.script = __scriptcharacter;
	end
	--
	_F_coreExcuteCategoryScripts(true, "general.beforeinit");
	_F_coreExcuteCategoryScripts(false, "general.beforeinit");
	--
	local __oninit = __private.__oninit;
	__oninit.__loaded = true;
	for _index, _key, _init in __oninit.__next, __oninit do
		if type(_init) == 'function' then
			_F_privateSafeCall(_init);
		end
	end
	__oninit:__wipe();
	if __db.__first_time then
		_F_privateSafeCall(__namespace.__default._F_ApplyBlzOptions);
		__db.__first_time = nil;
	end
	--
	__core:FireEvent("CORE_INITIALIZED");
	__core:EventDone("CORE_INITIALIZED");
	--
	_F_coreExcuteCategoryScripts(true, "general.afterinit");
	_F_coreExcuteCategoryScripts(false, "general.afterinit");
	__core:AddCallback(
		"CORE_GAME_LOADED",
		function(core, event)
			_F_coreExcuteCategoryScripts(true, "general.gameloaded");
			_F_coreExcuteCategoryScripts(false, "general.gameloaded");
		end
	);
	__private._F_privateOnEvent(
		"PLAYER_LOGOUT",
		function(event)
			_F_coreExcuteCategoryScripts(true, "general.logout");
			_F_coreExcuteCategoryScripts(false, "general.logout");
		end
	);
	__core:AddCallback(
		"CORE_PRE_ADDON_LOADED",
		function(core, event, addon)
			__core._F_coreExcuteScript(true, "addon.beforeinit", addon);
			__core._F_coreExcuteScript(false, "addon.beforeinit", addon);
		end
	);
	__core:AddCallback(
		"CORE_POST_ADDON_LOADED",
		function(core, event, addon)
			__core._F_coreExcuteScript(true, "addon.afterinit", addon);
			__core._F_coreExcuteScript(false, "addon.afterinit", addon);
		end
	);
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init", __core._F_devDebugProfileTick("core.init"));
	end
end
__private._F_privateDependCall(
	__addon,
	_LF_Init
);
__private._F_privateOnEvent(
	"PLAYER_LOGOUT",
	function(event)
		local __onquit = __private.__onquit;
		for _index, _key, _quit in __onquit.__next, __onquit do
			if type(_quit) == 'function' then
				_F_privateSafeCall(_quit);
			end
		end
	end
);


-->		Theme
	local __theme = {  };
	__namespace.__theme = __theme;

	function __core._F_themeRegisterTheme(Key, Theme)
		Key = tostring(Key);
		if __theme[Key] == nil and __theme[Theme] == nil then
			__theme[Key] = Theme;
			__theme[Theme] = Key;
			__theme[#__theme + 1] = Key;
			return true;
		end
		return false;
	end

	local __onuidef = __namespace.__onuidef;
	function __core._F_themeApplyTheme(which)
		__core._F_coreDebug("--------------------------------");
		if __theme[which] == nil then
			which = "__default";
		end
		__DB.ui_definition = which;
		--
		local _isShown = __ui._W_MainUI:IsShown();
		local Theme = __theme[which];
		for _index, _key, _method in __onuidef.__next, __onuidef do
			_method(Theme, __onuidef.__prev);
		end
		__ui._W_MainUI:SetShown(_isShown);
	end
-->


function __core._F_MakeAce3DBSingleProfile(name, UseSingleProfile, profile)
	local _db = _G[name];
	_db = _db or {  };
	_G[name] = _db;
	_db.profileKeys = _db.profileKeys or {  };
	_db.profiles = _db.profiles or {  };
	local _PKey = _db.profileKeys[_C_CharKey];
	if _PKey == nil or _db.profiles[_PKey] == nil then
		if UseSingleProfile == false then
			_db.profileKeys[_C_CharKey] = _C_CharKey;
			if _db.profiles[_C_CharKey] == nil then
				_db.profiles[_C_CharKey] = profile or {  };
				return true, _db.profiles[_C_CharKey];
			end
			return false, _db.profiles[_C_CharKey];
		else
			_db.profileKeys[_C_CharKey] = "Default";
			if _db.profiles.Default == nil then
				_db.profiles.Default = profile or {  };
				return true, _db.profiles.Default;
			end
			return false, _db.profiles.Default;
		end
	end
	return false, _db.profiles[_PKey];
end

local _LT_ShellCmd = {
	addon = {
		enable = function(addon)
		end,
		disable = function(addon)
		end,
		set = function(addon, key, val)
		end,
	},
	profile = {
		new = function()
		end,
		del = function()
		end,
		save = function()
		end,
	},
	script = {
		add = function()
		end,
		del = function()
		end,
		edit = function()
			__namespace.__module.__u1scripteditor.ShowScript();
		end,
		ui = function()
			__namespace.__module.__u1scripteditor.ShowScript();
		end,
		test = function()
		end,
	},
};
local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]";
SlashCmdList["CORESHELL"] = function(input)
	if input ~= "" then
		local _stream = { strsplit(SEPARATOR, input) };
		local _len = #_stream;
		for _index = _len, 1, -1 do
			if _stream[_index] == "" then
				tremove(_stream, _index);
			end
		end
		local _S1 = strlower(_stream[1]);
		local _T1 = _LT_ShellCmd[_S1];
		if _T1 ~= nil then
			local _S2 = _stream[2];
			if _S2 ~= nil then
				_S2 = strlower(_S2);
				local _T2 = _T1[_S2];
				if _T2 ~= nil then
					_T2();
				else
					_F_corePrint(format(LOC["Shell.Invalid.Arg2"], _S1, _S2));
				end
			else
				_F_corePrint(format(LOC["Shell.Invalid.Arg2.Missing"], _S1));
			end
		else
			_F_corePrint(format(LOC["Shell.Invalid.Arg1"], _S1));
		end
	else
		local _MainUI = __ui._W_MainUI;
		if _MainUI:IsShown() then
			_MainUI:Hide();
		else
			_MainUI:Show();
		end
	end
end
_G.SLASH_CORESHELL1 = "/coreshell";
_G.SLASH_CORESHELL2 = "/core";
_G.SLASH_CORESHELL3 = "/163";

SlashCmdList["PRINT"] = function(input)
	local func, err = loadstring("return " .. input);
	if func ~= nil then
		_F_corePrint(func());
	else
		_F_corePrint(err);
	end
end;
_G.SLASH_PRINT1 = "/print";

SlashCmdList["RL"] = ReloadUI;
_G.SLASH_RL1 = "/rl";
_G.SLASH_RL2 = "/reload";


if false and __core.__is_dev then
	local _B = {
		ITEM_DATA_LOAD_RESULT = true,
		SPELL_DATA_LOAD_RESULT = true,
		GET_ITEM_INFO_RECEIVED = true,
	};
	local _D = {  };
	local _E = CreateFrame('FRAME');
	_E:RegisterAllEvents();
	_E:SetScript("OnEvent", function(self, event, ...)
		if _B[event] == nil then
			_D[#_D + 1] = { format("%.4f", __core._F_coreTime()), event, ... };
		end
	end);
	__core:AddCallback("CORE_LOAD_FINISHED", function()
		C_Timer_After(30.0, function()
			_E:UnregisterAllEvents();
			_E:SetScript("OnEvent", nil);
			_F_corePrint("|cff00ff00core|r.event_stack", __core._F_devDebugProfileTick("core._9last"));
		end);
	end);
	__private.__oninit["_9last-Profile-LoadingSequenceEventsStack"] = function()
		if _G.GLOBAL_EXTRA_SAVED ~= nil then
			_G.GLOBAL_EXTRA_SAVED._LoadingSequenceEventsStack = _D;
		end
	end	
end

if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._9last", __core._F_devDebugProfileTick("core._9last"));
end
