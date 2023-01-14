--[=[
	ADDON
--]=]
--[====[
	int					__core._N_addonCoreIndex
	--	value			-->
		table							__core._T_addonDefaultCollectedMinimapButton
	--	function		-->		Internal method without parameters check
		enabled, reason, extra		=	__core._F_addonEnable						(addon:lower(), ignoreConflict, silent)
		localed, reason, extra		=	__core._F_addonLoad							(addon:lower(), ignoreConflict, silent, loadOptDeps, ignoreFlash)
										__core._F_addonDisable						(addon:lower(), disableDeps, disableOptDeps)
										__core._F_addonRegister						(name, infoReg)

		num							=	__core._F_addonGetNum						()
		index						=	__core._F_addonGetIndex						(addon:lower())
		info						=	__core._F_addonGetInfo						(addon:lower())
		info						=	__core._F_addonGetInfoByIndex				(index)
		bool						=	__core._F_addonIsLoaded						(addon:lower())
		bool						=	__core._F_addonIsLoadedByIndex				(index)

		list, num, refresh, hash	=	__core._F_addonGetTagList					(vendor, third)
		list, num, refresh			=	__core._F_addonGetList						(vendor, tag, str)

										__core._F_addonTimerLoadAddOns				(delay, list, precallback, postcallback)
										__core._F_addonTimerLoadAllUIAddOns			(speed)
										__core._F_addonTimerDisableAllUIAddOns		()

										__core._F_addonGetConfig					(key, info, addon)
										__core._F_addonSetConfig					(key, value)
										__core._F_addonIsConfigEnabled				(info)
										__core._F_addonConfigCallback				(addon, info, value, loading)
										__core._F_addonConfigFindChild				(info, key)
										__core._F_addonLoadConfig					(info, addon)
										__core._F_addonConfigFindChildByName		(addon, key)
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
	__core._F_devDebugProfileStart("core._4addon");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_coreTime = __core._F_coreTime;
local _F_noop = __core._F_noop;
----------------------------------------------------------------
local _F_coreSimulatorStartCapturing = __core._F_coreSimulatorStartCapturing;
local _F_coreSimulatorStopCapturing = __core._F_coreSimulatorStopCapturing;
-- local _F_coreSimulatorResumeCapturing = __core._F_coreSimulatorResumeCapturing;
-- local _F_coreSimulatorPauseCapturing = __core._F_coreSimulatorPauseCapturing;
local _F_coreSimulatorLoadingEvents = __core._F_coreSimulatorLoadingEvents;

-->		upvalue
local hooksecurefunc = hooksecurefunc;
local type, select = type, select;
local setmetatable, getmetatable, rawget, rawset = setmetatable, getmetatable, rawget, rawset;
local next, unpack = next, unpack;
local tinsert, tremove, sort = table.insert, table.remove, table.sort;
local strlower, strsub, strsplit, strfind, gsub = string.lower, string.sub, string.split, string.find, string.gsub;
local loadstring = loadstring;
local C_Timer_After = C_Timer.After;
local GetNumAddOns, GetAddOnInfo, GetAddOnMetadata, IsAddOnLoadOnDemand, GetAddOnEnableState, GetAddOnDependencies, GetAddOnOptionalDependencies
	= GetNumAddOns, GetAddOnInfo, GetAddOnMetadata, IsAddOnLoadOnDemand, GetAddOnEnableState, GetAddOnDependencies, GetAddOnOptionalDependencies;
local IsAddOnLoaded, ResetAddOns, SaveAddOns = IsAddOnLoaded, ResetAddOns, SaveAddOns;
local _G = _G;

local texinsertdifferent = table.exinsertdifferent;
local texcontain = table.excontain;
local strexnocasepattern = string.exnocasepattern;

local LUIPanel = LibStub:GetLibrary("LibShowUIPanel-1.0");

local _T_addonList = __core._T_addonList;
local _T_addonInfo = __core._T_addonInfo;
local _LN_AddOnLoadedSeq = 0;
local _LT_AddOnLoadedSeq = {  };

local _DB_AddOnsState = {  };	--	Store data before executing "init" method. Merged to and replaced by __db.addons_state when executing "init" method.
local _DB_AddOnsConfig = {  };
local _DB_AddOnsFrame = {  };

local _EnableAddOn, _DisableAddOn, _LoadAddOn = EnableAddOn, DisableAddOn, LoadAddOn;

if __core.__is_dev then
	__core._F_BuildEnv("core._4addon");
end


--[=[
	Loading Sequence:
	ADDON_LOADED			--	of all enabled addons
	PLAYER_LOGIN
	PLAYER_ENTERING_WORLD
	--
	VARIABLES_LOADED		--	not reliable, maybe before PLAYER_LOGIN, between PLAYER_LOGIN and PLAYER_ENTERING_WORLD, or after PLAYER_ENTERING_WORLD
]=]
-->		Core Event Handler
	local _LT_GameLoadEventState = {
		CORE_INITIALIZED = true,
		VARIABLES_LOADED = true,
		PLAYER_LOGIN = true,
		PLAYER_ENTERING_WORLD = true,
		LOADING_SCREEN_DISABLED = true,	--	(__namespace.__client._Type ~= "retail" or __namespace.__client._TocVersion >= 50200) and true or nil,
	};
	local _LF_GameLoadEvent = nil;
	_LF_GameLoadEvent = function(event)
		_LT_GameLoadEventState[event] = nil;
		_F_coreDebug("|cffff7f00GLoad|r", event);
		if next(_LT_GameLoadEventState) == nil then
			_LF_GameLoadEvent = _F_noop;
			__core:FireEvent("CORE_GAME_LOADED");
			__core:EventDone("CORE_GAME_LOADED");
			for _index = 1, _LN_AddOnLoadedSeq do
				__core:FireEvent("CORE_POST_ADDON_LOADED", _LT_AddOnLoadedSeq[_index]);
			end
		end
	end
	function __private.__F:ADDON_LOADED(event, addon)
		local _key = strlower(addon);
		local _info = _T_addonInfo[_key];
		if _info ~= nil then
			_info.loaded = true;
			--
			-- if addon ~= __addon then
				-- if _info.manualLoad ~= true then
					__core:FireEvent("CORE_PRE_ADDON_LOADED", _key);		--	not loaded in '_F_addonLoad'
				-- end
				-->		Trigger "runBeforeLoad" Here.
				local _runBeforeLoad = _info.runBeforeLoad;
				if _runBeforeLoad ~= nil then
					_F_privateSafeCall(_runBeforeLoad, _info, _key);
				end
				_LN_AddOnLoadedSeq = _LN_AddOnLoadedSeq + 1;
				_LT_AddOnLoadedSeq[_LN_AddOnLoadedSeq] = _key;
			-- end
		end
	end
	__core:AddCallback(
		"CORE_INITIALIZED",
		function(core, event)
			_LF_GameLoadEvent(event);
		end
	);
	function __private.__F:VARIABLES_LOADED(event)
		__private.__F:UnregisterEvent("VARIABLES_LOADED");
		local _flag = _LT_GameLoadEventState.PLAYER_LOGIN ~= true;
		for _index = 1, _LN_AddOnLoadedSeq do
			local _addon = _LT_AddOnLoadedSeq[_index];
			local _info = _T_addonInfo[_addon];
			if (_flag and not _info.optionsAfterVar and not _info.optionsAfterLogin) or (not _flag and _info.optionsAfterVar) then
				if _info.toggle ~= nil then
					_F_privateSafeCall(_info.toggle, _addon, _info, true, true);
				end
				if _info.runAfterLoad ~= nil then
					_F_privateSafeCall(_info.runAfterLoad, _info, _addon);
				end
				_F_privateSafeCall(__core._F_addonLoadConfig, _info, _addon);
			end
		end
		_LF_GameLoadEvent(event);
	end
	function __private.__F:PLAYER_LOGIN(event)
		__private.__F:UnregisterEvent("PLAYER_LOGIN");
		local _flag = _LT_GameLoadEventState.VARIABLES_LOADED ~= true;
		for _index = 1, _LN_AddOnLoadedSeq do
			local _addon = _LT_AddOnLoadedSeq[_index];
			local _info = _T_addonInfo[_addon];
			if (_flag and not _info.optionsAfterVar and not _info.optionsAfterLogin) or (not _flag and _info.optionsAfterVar) then
				if _info.toggle ~= nil then
					_F_privateSafeCall(_info.toggle, _addon, _info, true, true);
				end
				if _info.runAfterLoad ~= nil then
					_F_privateSafeCall(_info.runAfterLoad, _info, _addon);
				end
				_F_privateSafeCall(__core._F_addonLoadConfig, _info, _addon);
			end
		end
		_LF_GameLoadEvent(event);
	end
	function __private.__F:PLAYER_ENTERING_WORLD(event)
		__private.__F:UnregisterEvent("PLAYER_ENTERING_WORLD");
		for _index = 1, _LN_AddOnLoadedSeq do
			local _addon = _LT_AddOnLoadedSeq[_index];
			local _info = _T_addonInfo[_addon];
			if _info.optionsAfterLogin then
				if _info.toggle ~= nil then
					_F_privateSafeCall(_info.toggle, _addon, _info, true, true);
				end
				if _info.runAfterLoad ~= nil then
					_F_privateSafeCall(_info.runAfterLoad, _info, _addon);
				end
				_F_privateSafeCall(__core._F_addonLoadConfig, _info, _addon);
			end
		end
		_LF_GameLoadEvent(event);
	end
	function __private.__F:PLAYER_LOGOUT(event)
	end
	--
	local _B_LoadingScreen = true;
	function __private.__F:LOADING_SCREEN_DISABLED(event)
		_B_LoadingScreen = false;
		_LF_GameLoadEvent(event);
	end
	function __private.__F:LOADING_SCREEN_ENABLED(event)
		_B_LoadingScreen = true;
	end
	function __core._F_coreIsLoadingScreen()
		return _B_LoadingScreen;
	end
	--
	__core:AddCallback(
		"CORE_PRE_ADDON_LOADED",
		function(core, event, addon)
			local _info = _T_addonInfo[strlower(addon)];
			if _info ~= nil then
				_info.loadTime = _F_coreTime();
			end
			-- _F_coreDebug("CORE_PRE_ADDON_LOADED", addon);
		end
	);
	__core:AddCallback(
		"CORE_POST_ADDON_LOADED",
		function(core, event, addon)
			local _info = _T_addonInfo[strlower(addon)];
			-- _F_coreDebug("CORE_POST_ADDON_LOADED", addon);
		end
	);
-->

-->		AddOn Main
	--[=[
		--	strlower	parent				--	the upper visual field in UI.	--	Using the first value of @_deps, overwritten by user registered value
		--	strlower	_realDeps			--	original toc
		--	strlower	_blzDeps
		--	strlower	_deps				--	real depends when loading
		--	strlower	_realOptDeps		--	original toc
		--	strlower	_optDeps
		--	strlower	_children			--	real children by _deps
		--
		--	strlower	deps				--	User registered deps.			--	Not terminate when loading process of @deps occuring error
		--	strlower	optDeps				--	User registered optDeps.		--	Mix _optDeps into optDeps
		--	strlower	children			--	Used in Config Children List
		--
		--	Remove members of _deps from deps.
		--	Mix _optDeps into optDeps
	--]=]
--		Enable, Disable, Load
	hooksecurefunc("EnableAddOn", function(addon, name)
		local _key = GetAddOnInfo(addon);
		if _key ~= nil then
			_key = strlower(_key);
			local _info = _T_addonInfo[_key];
			if _info ~= nil then
				_info.enabled = true;
			end
			if _DB_AddOnsState[_key] == false then
				_DB_AddOnsState[_key] = "manual";
			end
		end
	end);
	hooksecurefunc("DisableAddOn", function(addon, name)
		local _key = GetAddOnInfo(addon);
		if _key ~= nil then
			_key = strlower(_key);
			local _info = _T_addonInfo[_key];
			if _info ~= nil then
				_info.enabled = false;
			end
			if _DB_AddOnsState[_key] == true then
				_DB_AddOnsState[_key] = "manual";
			end
		end
	end);
	hooksecurefunc("LoadAddOn", function(addon)
		local _key = strlower(addon);
		local _info = _T_addonInfo[_key];
		if _info ~= nil then
			if _info.loaded and _info.manualLoad ~= true then
				__core:FireEvent("CORE_POST_ADDON_LOADED", _key);		--	not loaded in '_F_addonLoad'
			end
		end
	end);
	local EnableAddOn, DisableAddOn, LoadAddOn = _G.EnableAddOn, _G.DisableAddOn, _G.LoadAddOn;
	--
	local _LF_CoreEnableAddOn = nil;
	local _LF_CoreLoadAddOn = nil;
	local _LF_CoreDisableAddOn = nil;
	local _T_AddOnsNeedReload = {  };
	local _LT_TempTryEnablingAddOns = {  };		--	1 = before enabling, 127 = enabled by "_LF_CoreEnableAddOn", 0 = origin-enabled, -127 = missing or corrupt
	local _LT_TempTryLoadingAddOns = {  };		--	true = loaded, false = before loading
	local _LT_TempTryDisablingAddOns = {  };
	local _LT_TempJustLoadedAddOns = {  };
	_LF_CoreEnableAddOn = function(addon, ignoreConfig, ignoreConflict, enableOptDeps)			--	enable all deps and children for full loading
		if _DB_AddOnsState[addon] == false and not ignoreConfig then
			return false, "SETTING_DISABLED", addon;
		end
		if _LT_TempTryEnablingAddOns[addon] == -127 then
			return false, "FAILED", addon;
		elseif _LT_TempTryEnablingAddOns[addon] ~= nil then
			return true;
		end
		local _info = _T_addonInfo[addon];
		if _info == nil then
			return false, "MISSING", addon;
		end

		local _conflicts = _info.conflicts;
		if _conflicts ~= nil then
			if ignoreConflict then
				for _index = 1, #_conflicts do
					local _c = _conflicts[_index];
					local _cinfo = _T_addonInfo[_c];
					if _cinfo ~= nil and _cinfo.loaded then
						_LF_CoreDisableAddOn(_c);
						_T_AddOnsNeedReload[_c] = true;
					end
				end
			else
				for _index = 1, #_conflicts do
					local _c = _conflicts[_index];
					local _cinfo = _T_addonInfo[_c];
					if _cinfo ~= nil and _cinfo.loaded then
						DisableAddOn(addon);
						return false, "CONFLICT", _conflicts;
					end
				end
			end
		end

		_LT_TempTryEnablingAddOns[addon] = 1;
		local __deps = _info._deps;
		if __deps ~= nil then
			for _index = 1, #__deps do
				local _dep = __deps[_index];
				if _LT_TempTryEnablingAddOns[_dep] == nil then
					local _dinfo = _T_addonInfo[_dep];
					if _dinfo ~= nil then
						if _dinfo.enabled then
							_LT_TempTryEnablingAddOns[_dep] = 0;
						else
							if _LF_CoreEnableAddOn(_dep, ignoreConfig, ignoreConflict) then
								_LT_TempTryEnablingAddOns[_dep] = 127;
							else
								_LT_TempTryEnablingAddOns[_dep] = -127;
								return false, "DEP_FAILED", _dep;
							end
						end
					else
						return false, "DEP_CORRUPT", _dep;
					end
				elseif _LT_TempTryEnablingAddOns[_dep] == -127 then
					return false, "DEP_FAILED", _dep;
				end
			end
		end
		local _deps = _info.deps;
		if _deps ~= nil then
			for _index = 1, #_deps do
				local _dep = _deps[_index];
				if _LT_TempTryEnablingAddOns[_dep] == nil then
					local _dinfo = _T_addonInfo[_dep];
					if _dinfo ~= nil then
						if _dinfo.loaded or _dinfo.dummy then
							_LT_TempTryEnablingAddOns[_dep] = 0;
						else
							if _LF_CoreEnableAddOn(_dep, ignoreConfig, ignoreConflict) then
								_LT_TempTryEnablingAddOns[_dep] = 127;
							else
								_LT_TempTryEnablingAddOns[_dep] = -127;
							end
						end
					end
				end
			end
		end
		if enableOptDeps then
			local _optDeps = _info.optDeps;
			if _optDeps ~= nil then
				for _index = 1, #_optDeps do
					local _dep = _optDeps[_index];
					if _LT_TempTryEnablingAddOns[_dep] == nil then
						local _dinfo = _T_addonInfo[_dep];
						if _dinfo ~= nil then
							if _dinfo.loaded or _dinfo.dummy then
								_LT_TempTryEnablingAddOns[_dep] = 0;
							else
								if _LF_CoreEnableAddOn(_dep, false, ignoreConflict) then
									_LT_TempTryEnablingAddOns[_dep] = 127;
								else
									_LT_TempTryEnablingAddOns[_dep] = -127;
								end
							end
						end
					end
				end
			end
		end

		if _info.dummy or _info.enabled then
			_LT_TempTryEnablingAddOns[addon] = 0;
			_info.enabled = true;
		else
			_LT_TempTryEnablingAddOns[addon] = 127;
			EnableAddOn(addon);
		end

		local _children = _info.children;
		if _children ~= nil then
			for _index = 1, #_children do
				local _child = _children[_index];
				if _LT_TempTryEnablingAddOns[_child] == nil then
					_LF_CoreEnableAddOn(_child, false);
				end
			end
		end

		return true;
	end
	_LF_CoreLoadAddOn = function(addon, ignoreConfig, ignoreConflict, loadOptDeps)
		if _DB_AddOnsState[addon] == false and not ignoreConfig then
			return false, "SETTING_DISABLED", addon;
		end
		if _LT_TempTryLoadingAddOns[addon] == true then
			return true;
		end
		local _info = _T_addonInfo[addon];
		if _info == nil then
			return false, "MISSING", addon;
		end
		if _info.dummy or _info.loaded then
			return true;
		end
		_LT_TempTryLoadingAddOns[addon] = false;
		local __deps = _info._deps;
		if __deps ~= nil then
			for _index = 1, #__deps do
				local _dep = __deps[_index];
				if _LT_TempTryLoadingAddOns[_dep] == nil then
					local _dinfo = _T_addonInfo[_dep];
					if _dinfo ~= nil then
						if _dinfo.loaded then
							_LT_TempTryLoadingAddOns[_dep] = true;
						else
							local _loaded, _reason, _extra = _LF_CoreLoadAddOn(_dep, ignoreConfig, ignoreConflict);
							if _loaded then
								_LT_TempTryLoadingAddOns[_dep] = true;
							else
								_LT_TempTryLoadingAddOns[_dep] = _reason;
								return false, "DEP_CORRUPT", _dep;
							end
						end
					else
						return false, "DEP_MISSING", _dep;
					end
				elseif _LT_TempTryLoadingAddOns[_dep] ~= true then
					return false, "DEP_CORRUPT", _dep;
				end
			end
		end
		local _deps = _info.deps;
		if _deps ~= nil then
			for _index = 1, #_deps do
				local _dep = _deps[_index];
				if _LT_TempTryLoadingAddOns[_dep] == nil then
					local _dinfo = _T_addonInfo[_dep];
					if _dinfo ~= nil then
						if _dinfo.loaded then
							_LT_TempTryLoadingAddOns[_dep] = true;
						else
							local _loaded, _reason, _extra, _isLod = _LF_CoreLoadAddOn(_dep, ignoreConfig, ignoreConflict);
							_LT_TempTryLoadingAddOns[_dep] = _loaded or _reason;
						end
					else
					end
				end
			end
		end

		if loadOptDeps then
			local _optDeps = _info.optDeps;
			if _optDeps ~= nil then
				for _index = 1, #_optDeps do
					local _dep = _optDeps[_index];
					if _LT_TempTryLoadingAddOns[_dep] == nil then
						local _dinfo = _T_addonInfo[_dep];
						if _dinfo ~= nil then
							if _dinfo.loaded then
								_LT_TempTryLoadingAddOns[_dep] = true;
							else
								local _loaded, _reason, _extra = _LF_CoreLoadAddOn(_dep, false, ignoreConflict);
								_LT_TempTryLoadingAddOns[_dep] = _loaded or _reason;
							end
						else
						end
					end
				end
			end
		end

		local _status, _loaded, _reason = nil, nil, nil;
		if _info._realLOD then
			_loaded = true;
			_LT_TempTryLoadingAddOns[addon] = true;
		elseif _info.loaded then
			_loaded = true;
			_LT_TempTryLoadingAddOns[addon] = true;
		else
			_info.manualLoad = true;
			-- _F_coreSimulatorResumeCapturing();
			_status, _loaded, _reason = _F_privateSafeCall(LoadAddOn, addon);
			-- _F_coreSimulatorPauseCapturing();

			if not _status or not _loaded then
				if _reason == "DEP_DISABLED" then
					if _info._deps ~= nil then
					end
				end
			else
			end

			if _loaded then
				_LT_TempTryLoadingAddOns[addon] = true;
				_LT_TempJustLoadedAddOns[#_LT_TempJustLoadedAddOns + 1] = addon;
				local _children = _info.children;
				if _children ~= nil then
					for _index = 1, #_children do
						local _child = _children[_index];
						if _LT_TempTryLoadingAddOns[_child] == nil then
							local _loaded2, _reason2 = _LF_CoreLoadAddOn(_child, false, ignoreConflict, loadOptDeps);
						end
					end
				end
			else
				_info.manualLoad = false;
				_LT_TempTryLoadingAddOns[addon] = _reason or "_FAILED";
			end
		end

		return _loaded, _reason, addon;
	end
	local function _F_addonEnable(addon, ignoreConflict, silent)
		addon = strlower(addon);
		if not ignoreConflict then
			local _info = _T_addonInfo[addon];
			if _info == nil then
				return false, "MISSING", addon;
			end
			local _conflicts = _info.conflicts;
			if _conflicts ~= nil then
				if silent then
					for _index = 1, #_conflicts do
						local _c = _conflicts[_index];
						local _cinfo = _T_addonInfo[_c];
						if _cinfo ~= nil and _cinfo.loaded then
							return false, "CONFLICT", _conflicts;
						end
					end
				else
					local _msg = "";
					for _index = 1, #_conflicts do
						local _c = _conflicts[_index];
						local _cinfo = _T_addonInfo[_c];
						if _cinfo ~= nil and _cinfo.loaded then
							if _cinfo.icon ~= nil then
								_msg = _msg .. "|T" .. _cinfo.icon .. ":20:20|t |cff33ff33" .. (_cinfo.title or _cinfo.name) .. "|r";
							else
								_msg = _msg .. " |cff33ff33" .. (_cinfo.title or _cinfo.name) .. "|r";
							end
						end
					end
					if _msg ~= "" then
						local _this = nil;
						if _info.icon ~= nil then
							_this = "|T" .. _info.icon .. ":20:20|t |cff33ff33" .. (_info.title or _info.name) .. "|r";
						else
							_this = "|cff33ff33" .. (_info.title or _info.name) .. "|r";
						end
						__ui._W_POPUP:_F_Show("_ADDON_CONFLICT_CONFIRM", _this, _msg, addon);
						return false, "CONFLICT", _conflicts;
					end
				end
			end
		end
		_LT_TempTryEnablingAddOns = {  };
		local _enabled, _reason, _extra = _LF_CoreEnableAddOn(addon, true, ignoreConflict);
		if _enabled then
			_DB_AddOnsState[addon] = true;
			SaveAddOns();
			__core:FireEvent("CORE_ADDON_TOGGLE", addon, true);
		else
			for _addon, _val in next, _LT_TempTryEnablingAddOns do
				if _val == 127 then
					_DisableAddOn(_addon);
					_DB_AddOnsState[addon] = nil;
				end
			end
			ResetAddOns();
		end
		return _enabled, _reason, _extra;
	end
	local function _F_addonLoad(addon, ignoreConflict, silent, loadOptDeps, ignoreFlash)
		addon = strlower(addon);
		local _enabled, _reason, _extra = _F_addonEnable(addon, ignoreConflict, silent);
		if _enabled then
			local _info = _T_addonInfo[addon];
			if _info.loaded then
				_T_AddOnsNeedReload[addon] = nil;
				if not ignoreFlash and next(_T_AddOnsNeedReload) == nil then
					__ui._W_MainUI:StopReloadFlash();
				end
				if _info.toggle ~= nil then
					_F_privateSafeCall(_info.toggle, addon, _info, true, false);
				end
				if _info.runAfterLoad ~= nil then
					_F_privateSafeCall(_info.runAfterLoad, _info, addon);
				end
				return true;
			end
			_LT_TempTryLoadingAddOns = {  };
			_LT_TempJustLoadedAddOns = {  };
			_F_coreSimulatorStartCapturing();
			local _loaded, _reason, _extra = _LF_CoreLoadAddOn(addon, true, ignoreConflict, loadOptDeps);
			_F_coreSimulatorStopCapturing();
			if _loaded then
				_F_coreSimulatorLoadingEvents(false);
				SaveAddOns();
				_F_privateSafeCall(__core._F_addonLoadConfig, _info, addon);
				_T_AddOnsNeedReload[addon] = nil;
				if not ignoreFlash and next(_T_AddOnsNeedReload) == nil then
					__ui._W_MainUI:StopReloadFlash();
				end
			else
				for _addon, _val in next, _LT_TempTryEnablingAddOns do
					if _val == 127 then
						_DisableAddOn(_addon);
						_DB_AddOnsState[addon] = nil;
					end
				end
				ResetAddOns();
			end

			for _index = 1, #_LT_TempJustLoadedAddOns do
				local _addon = _LT_TempJustLoadedAddOns[_index];
				local _info = _T_addonInfo[_addon];
				if _info ~= nil then
					__core:FireEvent("CORE_POST_ADDON_LOADED", _addon);
					if _info.toggle ~= nil then
						_F_privateSafeCall(_info.toggle, _addon, _info, true, true);
					end
					if _info.runAfterLoad ~= nil then
						_F_privateSafeCall(_info.runAfterLoad, _info, _addon);
					end
				end
			end

			return _loaded, _reason, _extra;
		end

		return false, _reason, _extra;
	end
	__core._F_addonEnable = _F_addonEnable;
	__core._F_addonLoad = _F_addonLoad;
	_LF_CoreDisableAddOn = function(addon, disableDeps, disableOptDeps, donotFireToggle)
		if _LT_TempTryDisablingAddOns[addon] ~= nil then
			return true;
		end
		local _info = _T_addonInfo[addon];
		if _info == nil then
			_LT_TempTryDisablingAddOns[addon] = false;
			return false, "MISSING", addon;
		end
		_LT_TempTryDisablingAddOns[addon] = true;
		if _info.enabled then
			DisableAddOn(addon);
		end
		if _info.loaded then
			if not donotFireToggle and _info.toggle ~= nil then
				_F_privateSafeCall(_info.toggle, addon, _info, false, false);
			end
		end
		local _children = _info.children;
		if _children ~= nil then
			for _index = 1, #_children do
				_LF_CoreDisableAddOn(_children[_index]);
			end
		end
		if disableDeps then
		end
		if disableOptDeps then
		end
		return true;
	end
	local function _F_addonDisable(addon, disableDeps, disableOptDeps, donotFireToggle, ignoreFlash)
		addon = strlower(addon);
		local _info = _T_addonInfo[addon];
		if _info == nil then
			return true;
		end
		if not ignoreFlash and _info ~= nil and _info.loaded and _info.toggle == nil then
			__ui._W_MainUI:NotifyReloadFlash();
			_T_AddOnsNeedReload[addon] = true;
		end
		_LT_TempTryDisablingAddOns = {  };
		local _disabled, _reason, _extra = _LF_CoreDisableAddOn(addon, disableDeps, disableOptDeps, donotFireToggle);
		_DB_AddOnsState[addon] = false;
		SaveAddOns();
		if _info.loaded then
			__core:FireEvent("CORE_ADDON_TOGGLE", addon, false);
		else
			__core:FireEvent("UI_CONFIG_UPDATE");
		end
		return _disabled, _reason, _extra;
	end
	__core._F_addonDisable = _F_addonDisable;
	__core._T_AddOnsNeedReload = _T_AddOnsNeedReload;
--		AddOn Info
	local _LT_TempKnownAddOnPacks = {
		["!!!163ui!!!"] = true,
		["elvui"] = true,
		["duowan"] = true,
		["bigfoot"] = true,
		["mogu"] = true,
		["ace2"] = true,
		["ace3"] = true,
		["fish!!!"] = true,
	};
	local _T_addonInfoProtectedValue = {
		installed = true,
		_realLOD = true,
		_deps = true,
		_realDeps = true,
		_blzDeps = true,
		_realOptDeps = true,
		originEnabled = true,
		enabled = true,
	};
	local function _LF_InitAddOnInfo()
		local _NumAddOns = GetNumAddOns();
		for _index = 1, _NumAddOns do
			local _name, _title, _notes, _loadable, _reason, _security = GetAddOnInfo(_index);
			if _name == __addon then
				__core._N_addonCoreIndex = _index;
			end
			local _key = strlower(_name);
			_title = _title:gsub("%|cff880303%[网易有爱%]%|r ", ""):gsub("%|cff880303%[有爱%]%|r ", "");

			_T_addonList[_index] = _key;
			_T_addonList[_key] = _index;
			_T_addonInfo[_key] = {
				key = _key,
				installed = _index,
				name = _name,
				title = _title or _name,
				author = GetAddOnMetadata(_index, "Author"),
				desc = _notes ~= "" and _notes or nil,
				modifier = GetAddOnMetadata(_index, "X-Modifier"),
				--	parent				--	the upper visual field in UI.	--	Using the first value of @_deps, overwritten by user registered value
				-- --	_realDeps			--	original toc
				-- --	_blzDeps
				--	_deps				--	real depends when loading
				-- --	_realOptDeps		--	original toc
				--	_optDeps
				--	_children			--	real children by _deps
				--	deps				--	User registered deps.			--	Errors in the process of loading deps won't result in termination
				--	optDeps				--	User registered optDeps.		--	Mix _optDeps into optDeps

				_realLOD = IsAddOnLoadOnDemand(_index),
				lod = IsAddOnLoadOnDemand(_index),
				vendor = GetAddOnMetadata(_index, "X-Vendor") == "NetEase" or GetAddOnMetadata(_index, "X-163UI-Version") ~= nil,
				version = GetAddOnMetadata(_index, "Version"),
				xcategories = _G.UI163_USE_X_CATEGORIES and GetAddOnMetadata(_index, "X-Category"),

				originEnabled = GetAddOnEnableState(__const._C_PLAYER_NAME, _index) >= 2,
				enabled = GetAddOnEnableState(__const._C_PLAYER_NAME, _index) >= 2,
			};
		end
		__core._T_addonNum = _NumAddOns;
		for _key, _info in next, _T_addonInfo do
			if _info.SECURE == nil then
				local _index = _info.installed;
				local _realDeps = { GetAddOnDependencies(_index) };
				if _realDeps[1] ~= nil then
					for _k = 1, #_realDeps do
						_realDeps[_k] = strlower(_realDeps[_k]);
					end
					-- _info._realDeps = _realDeps;
					-- local _blzDeps = {  };
					local _deps = {  };
					for _k = 1, #_realDeps do
						local _val = _realDeps[_k];
						if _LT_TempKnownAddOnPacks[_val] == nil then
							if strsub(_val, 1, 9) == "blizzard_" and select(6, GetAddOnInfo(_val)) == "SECURE" then
								-- _blzDeps[#_blzDeps + 1] = _val;
							else
								_deps[#_deps + 1] = _val;
							end
						end
					end
					_info._deps = _deps;
					_info.parent = _deps[1];
					-- if _blzDeps[1] ~= nil then
					-- 	_info._blzDeps = _blzDeps;
					-- end
				end
				local _realOptDeps = { GetAddOnOptionalDependencies(_index) };
				if _realOptDeps[1] ~= nil then
					for _k = 1, #_realOptDeps do
						_realOptDeps[_k] = strlower(_realOptDeps[_k]);
					end
					-- _info._realOptDeps = _realOptDeps;
					local _optDeps = {  };
					for _k = 1, #_realOptDeps do
						local _val = _realOptDeps[_k];
						if _LT_TempKnownAddOnPacks[_val] == nil and (strsub(_val, 1, 9) ~= "blizzard_" or select(6, GetAddOnInfo(_val)) == "SECURE") then
							_optDeps[#_optDeps + 1] = _val;
						end
					end
					if _optDeps[1] ~= nil then
						_info._optDeps = _optDeps;
					end
				end
			end
		end
		for _addon, _info in next, _T_addonInfo do
			local __deps = _info._deps;
			if __deps ~= nil then
				for _index = 1, #__deps do
					local _dep = __deps[_index];
					local _dinfo = _T_addonInfo[_dep];
					if _dinfo ~= nil then
						local __dchildren = _dinfo._children;
						if __dchildren == nil then
							__dchildren = { _addon, };
							_dinfo._children = __dchildren;
						else
							__dchildren[#__dchildren + 1] = _addon;
						end
					end
				end
			end
		end
	end
	_LF_InitAddOnInfo();
	--
	local _T_TagHash = {  };
	local _LB_NewInsertedTagList = true;
	local _LB_NewInsertedAddOnList = true;
	local _LN_TempOrder = 1;
	local _LT_ParentTags = {  };
	local _T_addonDefaultCollectedMinimapButton = {  };
	local _T_addonSavedFramesName = {  };
	function __core._F_addonRegister(name, infoReg)
		local _tags = infoReg.tags;
		if _tags ~= nil and _tags[1] ~= nil then
			for _index = 1, #_tags do
				local _tag = _tags[_index];
				if _T_TagHash[_tag] == nil then
					_T_TagHash[_tag] = true;
					_LB_NewInsertedTagList = true;
				end
			end
		end
		local _addon = strlower(name);

		local _children = infoReg.children;
		if _children ~= nil then
			for _index = 1, #_children do
				_children[_index] = strlower(_children[_index]);
			end
		end

		local _infoRaw = _T_addonInfo[_addon];
		if _infoRaw == nil and not infoReg.dummy then
			_LT_ParentTags[_addon] = infoReg.tags;
			return;
		end

		--	Hide empty dummy pack
		if infoReg.dummy then
			local _hasOne = false;
			if _children ~= nil then
				for _index = 1, #_children do
					local v = _children[_index];
					if _T_addonInfo[v] ~= nil then
						_hasOne = true;
						break;
					end
				end
			end
			if not _hasOne then
				return;
			end
			infoReg.vendor = true;
			if infoReg.defaultEnable == nil then
				infoReg.defaultEnable = 1;
			end
			if _infoRaw == nil then
				_T_addonList[#_T_addonList + 1] = _addon;
			end
			local _enableOne = false;
			for _index = #_children, 1, -1 do
				local _cinfo = _T_addonInfo[_children[_index]];
				if _cinfo == nil then
					tremove(_children, _index);
				elseif _cinfo.enabled then
					_enableOne = true;
				end
			end
			infoReg.enabled = _enableOne;
		end

		if _tags ~= nil and _tags[1] ~= nil then
			local _IsClass = false;
			for _index = #_tags, 1, -1 do
				if _tags[_index] == "TAG_CLASS" then
					_IsClass = true;
					tremove(_tags, _index);
				end
			end
			if _IsClass then
				for _index = 1, #_tags do
					local _tag = _tags[_index];
					local _class = __const._T_TagClass[_tag];
					if _class ~= nil then
						_tags[_class] = true;
					end
				end
				for _tag, _class in next, __const._T_TagClass do
					if _tags[_class] ~= true then
						_tags[_class] = false;
					end
				end
			end
		else
			infoReg.tags = { "TAG_UNK", };
		end

		local _conflicts = infoReg.conflicts;
		if _conflicts ~= nil then
			for _index = 1, #_conflicts do
				_conflicts[_index] = strlower(_conflicts[_index]);
			end
		end

		_T_addonInfo[_addon] = infoReg;

		infoReg.name = name;
		infoReg.RegOrder = _LN_TempOrder;
		_LN_TempOrder = _LN_TempOrder + 1;
		if infoReg.registered ~= false then
			infoReg.registered = true;
		end

		infoReg.ldbIcon = nil;
		-- if infoReg.ldbIcon == 1 or infoReg.ldbIcon == nil then
		-- 	infoReg.ldbIcon = infoReg.icon;
		-- end

		local _minimap = infoReg.minimap;
		if _minimap ~= nil then
			if type(_minimap) == 'table' then
				for _, _val in next, _minimap do
					_T_addonDefaultCollectedMinimapButton[_val] = true;
				end
			else
				_T_addonDefaultCollectedMinimapButton[_minimap] = true;
			end
		end
		local _frameNames = infoReg.frames;
		if _frameNames ~= nil then
            for _, _name in next, _frameNames do
                _T_addonSavedFramesName[_name] = true;
            end
		end

		if _infoRaw ~= nil then
			if not _infoRaw._realLOD and infoReg.load == nil then
				infoReg.load = (_G.UI163_USER_MODE and not _infoRaw.vendor and "NORMAL" or "LATER");
			end
			if _infoRaw._realLOD or infoReg.load == "DEMAND" then
				_infoRaw.lod = true;
			else
				_infoRaw.lod = false;
			end

			local _parent = infoReg.parent;
			if _parent ~= nil then
				_infoRaw.parent = nil;
				if _parent == false or _parent == 0 or _parent == "" then
					infoReg.parent = nil;
				else
					infoReg.parent = strlower(_parent);
				end
			end

			for _key, _val in next, _infoRaw do
				if _key == "_deps" then
					local _deps = infoReg.deps;
					if _deps ~= nil then
						for _index = 1, #_deps do
							_deps[_index] = strlower(_deps[_index]);
						end
						for _index = 1, #_val do
							_F_table_remove_valalue(_deps, _val[_index]);
						end
					end
					infoReg[_key] = _val;
				elseif _key == "_optDeps" then
					local _optDeps = infoReg.optDeps;
					if _optDeps ~= nil then
						for _index = 1, #_val do
							local _opt = strlower(_val[_index]);
							if _T_addonInfo[_opt] ~= nil then
								texinsertdifferent(_optDeps, _opt);
							end
						end
					else
						infoReg.optDeps = _val;
					end
				elseif _T_addonInfoProtectedValue[_key] then
					infoReg[_key] = _val;
				elseif infoReg[_key] == nil then
					infoReg[_key] = _val;
				end
			end
		else
			local _parent = infoReg.parent;
			if _parent ~= nil then
				if _parent == false or _parent == 0 or _parent == "" then
					infoReg.parent = nil;
				else
					infoReg.parent = strlower(_parent);
				end
			end
		end
		if infoReg.desc == "" then
			infoReg.desc = nil;
		end
		if infoReg.desc ~= nil then
			infoReg.desc2 = gsub("    " .. infoReg.desc, "([`]+)", "\n   ");
		end

		_LB_NewInsertedAddOnList = true;
		if _tags ~= nil and _tags[1] ~= nil then
			__ui._F_uiToggleTagList(true);
		end
	end
	__core._T_addonDefaultCollectedMinimapButton = _T_addonDefaultCollectedMinimapButton;
	__core._T_addonSavedFramesName = _T_addonSavedFramesName;
--		Query AddOn Info
	function __core._F_addonGetNum()
		return __core._T_addonNum;
	end
	function __core._F_addonGetIndex(addon)
		return _T_addonList[addon];
	end
	function __core._F_addonGetInfo(addon)
		return _T_addonInfo[addon];
	end
	function __core._F_addonGetInfoByIndex(index)
		local _addon = _T_addonList[index];
		if _addon ~= nil then
			return _T_addonInfo[_addon];
		end
	end
	function __core._F_addonIsLoaded(addon)
		local _info = _T_addonInfo[addon];
		return _info ~= nil and _info.loaded or false;
	end
	function __core._F_addonIsLoadedByIndex(index)
		local _addon = _T_addonList[index];
		local _info = _T_addonInfo[_addon];
		return _info ~= nil and _info.loaded or false;
	end
--		Tag List
	local _C_TAG_PLAYER_CLASS = "TAG_" .. __const._C_PLAYER_CLASS;
	local function _LF_SortTag(v1, v2)
		if v1 == _C_TAG_PLAYER_CLASS then
			return true;
		elseif v2 == _C_TAG_PLAYER_CLASS then
			return false;
		end
		local o1, o2 = __const._T_TagSeq[v1], __const._T_TagSeq[v2];
		if o1 == o2 then
			return v1 < v2;
		elseif o1 == nil then
			return false;
		elseif o2 == nil then
			return true;
		else
			return o1 < o2;
		end
	end
	local _N_TagList = 0;
	local _T_TagList = {  };
	function __core._F_addonGetTagList()
		if _LB_NewInsertedTagList then
			_LB_NewInsertedTagList = false;
			_N_TagList = 0;
			_T_TagList = {  };
			_T_TagHash = {  };
			for _addon, _info in next, _T_addonInfo do
				if _info.parent == nil and not _info.hide then
					local _tags = _info.tags;
					if _tags ~= nil then
						for _index = 1, #_tags do
							local _tag = _tags[_index];
							if _T_TagHash[_tag] == nil then
								_T_TagHash[_tag] = true;
								local _class = __const._T_TagClass[_tag];
								if _class == nil or _class == __const._C_PLAYER_CLASS then
									_N_TagList = _N_TagList + 1;
									_T_TagList[_N_TagList] = _tag;
								end
							end
						end
					end
				end
			end
			--
			_T_TagList[0] = __const._C_TAG_VENDOR;
			_T_TagList[-1] = __const._C_TAG_THIRD;
			sort(_T_TagList, _LF_SortTag);
			return _T_TagList, _N_TagList, true;
		else
			return _T_TagList, _N_TagList, false;
		end
	end
--		AddOn List
	local _N_addonSetList = 0;
	local _T_addonSetList = {  };
	local _LT_Filter = { "always-update-here", };
	local _N_UIAddonSetList = 0;
	local _T_UIAddonSetList = {  };
	local _LF_StringFindInAddOnInfo = nil;
	_LF_StringFindInAddOnInfo = function(info, str, skipChildren)
		if info.name ~= nil and strfind(info.name, str) then
			return true;
		end
		if info.title ~= nil and strfind(info.title, str) then
			return true;
		end
		-- if info.desc ~= nil and strfind(info.desc, str) then
		-- 	return true;
		-- end
		for _index = 1, #info do
			local _cfg = info[_index];
			if _cfg.text ~= nil and strfind(_cfg.text, str) then
				return true;
			end
			if _LF_StringFindInAddOnInfo(_cfg, str, true) then
				return true;
			end
		end
		if skipChildren then
			return false;
		end
		local _children = info.children;
		if _children ~= nil then
			for _index = 1, #_children do
				local _child = _children[_index];
				if strfind(_child, str) then
					return true;
				end
				local _cinfo = _T_addonInfo[_child];
				if _cinfo ~= nil and _LF_StringFindInAddOnInfo(_cinfo, str, true) then
					return true;
				end
			end
		end
		return false;
	end
	function __core._F_addonGetList(vendor, tag, str, state, nofilter)
		local _isAddOnListChanged = _LB_NewInsertedAddOnList;
		if _isAddOnListChanged then
			_LB_NewInsertedAddOnList = false;
			_N_addonSetList = 0;
			_T_addonSetList = {  };
			for _index = 1, #_T_addonList do
				local _addon = _T_addonList[_index];
				local _info = _T_addonInfo[_addon];
				if _info.parent == nil then
					_N_addonSetList = _N_addonSetList + 1;
					_T_addonSetList[_N_addonSetList] = _addon;
					_T_addonSetList[_addon] = _N_addonSetList;
				end
			end
		end
		if nofilter then
			-- _LT_Filter[1] = vendor;
			-- _LT_Filter[2] = tag;
			-- _LT_Filter[3] = str;
			-- _LT_Filter[4] = state;
			__ui:_F_uiSetHighlightString(nil);
			return  _T_addonSetList, _N_addonSetList, false;
		end
		if _isAddOnListChanged or _LT_Filter[1] ~= vendor or _LT_Filter[2] ~= tag or _LT_Filter[3] ~= str or _LT_Filter[4] ~= state then
			_LT_Filter[1] = vendor;
			_LT_Filter[2] = tag;
			_LT_Filter[3] = str;
			_LT_Filter[4] = state;
			_T_UIAddonSetList = {  };
			_N_UIAddonSetList = 0;
			if str ~= nil then
				str = strexnocasepattern(str);
			end
			for _index = 1, _N_addonSetList do
				local _addon = _T_addonSetList[_index];
				local _info = _T_addonInfo[_addon];
				-- local _isVendor = _info.vendor and _info.RegOrder ~= nil;
				local _isVendor = _info.RegOrder ~= nil;
				--[[
					if (vendor == nil or (vendor and _isVendor) or (not vendor and not _isVendor))
						and (tag == nil or (_info.tags ~= nil and texcontain(_info.tags, tag)))
						and (str == nil or strfind(_addon, str) or _LF_StringFindInAddOnInfo(_info, str))
					then
						_N_UIAddonSetList = _N_UIAddonSetList + 1;
						_T_UIAddonSetList[_N_UIAddonSetList] = _addon;
					end
				--]]
				--[[
					if not _info.hide
						and (
							vendor == nil or (vendor and _isVendor) or (not vendor and not _isVendor)
						) and (
							_info.tags == nil or _info.tags[__const._C_PLAYER_CLASS] ~= false
						) and (
							(str == nil and (tag == nil or (_info.tags ~= nil and texcontain(_info.tags, tag))) and ((state >= 0 and _info.enabled) or (state <= 0 and not _info.enabled))) or
							(str ~= nil and (strfind(_addon, str) or _LF_StringFindInAddOnInfo(_info, str)) and ((state >= 0 and _info.enabled) or (state <= 0 and not _info.enabled)))
						)
					then
						_N_UIAddonSetList = _N_UIAddonSetList + 1;
						_T_UIAddonSetList[_N_UIAddonSetList] = _addon;
					end
				--]]
					if not _info.hide
						and (
							_info.tags == nil or _info.tags[__const._C_PLAYER_CLASS] ~= false
						) and (
							(
								str == nil
								and (vendor == nil or (not vendor == not _isVendor))
								and (tag == nil or (_info.tags ~= nil and texcontain(_info.tags, tag)))
								and ((state >= 0 and _info.enabled) or (state <= 0 and not _info.enabled))
							) or (
								str ~= nil
								and (strfind(_addon, str) or _LF_StringFindInAddOnInfo(_info, str))
								-- and ((state >= 0 and _info.enabled) or (state <= 0 and not _info.enabled))
							)
						)
					then
						_N_UIAddonSetList = _N_UIAddonSetList + 1;
						_T_UIAddonSetList[_N_UIAddonSetList] = _addon;
					end
			end
			__ui:_F_uiSetHighlightString(str);
			return _T_UIAddonSetList, _N_UIAddonSetList, true;
		else
			__ui:_F_uiSetHighlightString(str);
			return _T_UIAddonSetList, _N_UIAddonSetList, false;
		end
	end
-->
function __core._F_addonResetEnableState(state, config)
	if state then
		local _def = __namespace.__default.addons_state;
		for _addon, _enabled in next, _def do
			if _enabled then
				EnableAddOn(_addon);
			else
				DisableAddOn(_addon);
			end
		end
		__namespace.__db.addons_state = _def;
	end
	if config then
		__namespace.__db.addons_config = {  };
	end
	ReloadUI();
end
local _LT_ConfigKeyToInfo = {  };
local function _LF_ProcAddOnInfoTable()
	for _addon, _info in next, _T_addonInfo do
		_info.hide = __namespace.__default.addons_hidden[_addon] and true or nil;
		_info.protected = __namespace.__default.addons_protected[_addon] and true or nil;
		_info.optionsAfterVar = _info.optionsAfterVar == 1 or _info.optionsAfterVar == true;
		_info.optionsAfterLogin = _info.optionsAfterLogin == 1 or _info.optionsAfterLogin == true;
		_info.secure = _info.secure == 1 or _info.secure == true;
		-- _info.hide = _info.hide == 1 or _info.hide == true;
		-- _info.protected = _info.protected == 1 or _info.protected == true;
		_info.loaded = IsAddOnLoaded(_addon);
	end
	for _addon, _info in next, _T_addonInfo do		--	_dep = Real Dep, dep = User Defined Dep, parent is included by _dep or dep. Del unexisted dep.
		local _parent = _info.parent;
		local _deps = _info.deps;
		if _deps ~= nil then
			for _index = #_deps, 1, -1 do
				if _T_addonInfo[_deps[_index]] == nil then
					tremove(_deps, _index);
				end
			end
			if #_deps == 0 then
				if _parent == nil then
					_info.deps = nil;
				elseif _T_addonInfo[_parent] == nil then
					_info.tags = _info.tags or _LT_ParentTags[_parent];
					_info.deps = nil;
					_info.parent = nil;
				elseif _info._deps ~= nil and texcontain(_info._deps, _parent) then
					_info.deps = nil;
				else
					_deps[1] = _parent;
				end
			else
				if _parent == nil then
					--	Manual set nil by cfg
				elseif _T_addonInfo[_parent] == nil then
					_info.parent = _deps[1];
				else
					if _info._deps == nil or not texcontain(_info._deps, _parent) then
						texinsertdifferent(_deps, _parent);
					end
				end
			end
		else
			if _parent == nil then
			elseif _T_addonInfo[_parent] == nil then
				_info.tags = _info.tags or _LT_ParentTags[_parent];
				_info.parent = nil;
			elseif _info._deps == nil or not texcontain(_info._deps, _parent) then
				_info.deps = { _parent, };
			end
		end
	end
	_LT_ParentTags = nil;
	for _addon, _info in next, _T_addonInfo do		--	Del unexisted child.
		local _children = _info.children;
		if _children ~= nil then
			for _index = #_children, 1, -1 do
				if _T_addonInfo[_children[_index]] == nil then
					tremove(_children, _index);
				end
			end
			-- for _addon2, _info2 in next, _T_addonInfo do
			-- 	if _addon2 ~= _addon and (not _info2.registered or _info2.parent == nil) then
			-- 		for _index = 1, #_children do
			-- 			local _child = _children[_index];
			-- 			if strfind(_addon2, _child) then
			-- 				local _parent = _info2.parent;
			-- 				if _parent ~= nil and _parent ~= _addon then
			-- 					if _info2._deps == nil or not texcontain(_info2._deps, _parent) then
			-- 						if _info2.deps ~= nil then
			-- 							texinsertdifferent(_info2.deps, _parent);
			-- 						else
			-- 							_info2.deps = { _parent, };
			-- 						end
			-- 					end
			-- 				end
			-- 				_info2.parent = _addon;
			-- 				break;
			-- 			end
			-- 		end
			-- 	end
			-- end
		end
	end
	for _addon, _info in next, _T_addonInfo do		--	Mix _children to children
		local __children = _info._children;
		if __children ~= nil then
			local _children = _info.children;
			if _children ~= nil then
				for _index = 1, #__children do
					local _child = __children[_index];
					local _cinfo = _T_addonInfo[_child];
					if _cinfo ~= nil and (_cinfo.registered ~= true or _cinfo.parent == nil) then
						texinsertdifferent(_children, _child);
					end
				end
			else
				_children = {  };
				for _index = 1, #__children do
					local _child = __children[_index];
					local _cinfo = _T_addonInfo[_child];
					if _cinfo ~= nil and (_cinfo.registered ~= true or _cinfo.parent == nil) then
						_children[#_children + 1] = _child;
					end
				end
				_info.children = _children;
			end
		end
	end
	for _addon, _info in next, _T_addonInfo do
		local _parent = _info.parent;
		if __namespace.__subfolder[_addon] == nil and _info.lod and _parent == nil and not _info.nolodbutton then
			tinsert(
				_info,
				1,
				{
					text = LOC["ConfigPanel.LoadLODAddOn"],
					enableOnNotLoad = 1,
					disableOnLoad = 1,
					tip = "",
					param = _addon,
					callback = function(cfg, v, loading)
						local _addon = cfg.param;
						if not IsAddOnLoaded(_addon) then
							local _loaded, _reason = LoadAddOn(_addon);
						end
					end,
				}
			);
		end
		if _parent ~= nil then
			local _pinfo = _T_addonInfo[_parent];
			if _pinfo ~= nil then
				if _info.registered ~= true and _pinfo.registered == true then
					_info.load = _pinfo.load;
					_info.registered = true;
				end
				if _pinfo.hide and not _info.hide then
					_info.parent = nil;
					_parent = nil;
					_info.tags = _info.tags or _pinfo.tags;
				end
				if _pinfo.secure then
					_info.secure = 1;
				end
			end
		end

		local _parent = _info.parent;
		if _parent ~= nil then
			local _pinfo = _T_addonInfo[_parent];
			if _pinfo ~= nil then
				local _pchildren = _pinfo.children;
				if _pchildren == nil then
					_pinfo.children = { _addon, };
				else
					texinsertdifferent(_pchildren, _addon);
				end
			end
		end
		local _deps = _info.deps;
		if _deps ~= nil then
			for _index = 1, #_deps do
				local _dep = _deps[_index];
				local _dinfo = _T_addonInfo[_dep];
				if _dinfo ~= nil then
					local _dchildren = _dinfo.children;
					if _dchildren == nil then
						_dchildren = { _addon, };
						_dinfo.children = _dchildren;
					else
						texinsertdifferent(_dchildren, _addon);
					end
				end
			end
		end
	end
	--	config
	local _proc = nil;
	_proc = function(key, info, min, max)
		info.reload = info.reload == 1 or info.reload == true;
		local _default = info.default;
		if _default == 1 or _default == "1" or _default == true or _default == "true" then
			info.default = true;
		elseif _default == 0 or _default == "0" or _default == false or _default == "false" then
			info.default = false;
		end
		for _index = max, min, -1 do
			local _info2 = info[_index];
			if _info2.visible == false then
				tremove(info, _index);
			else
				_info2.__parent = info;
				if _info2.type == 'checkbox' then
					_info2.type = 'check';
				elseif _info2.type == nil then
					if _info2.var ~= nil then
						_info2.type = 'check';
					else
						_info2.type = 'button';
					end
				end
				local _key2 = nil;
				if _info2.var ~= nil then
					_key2 = key .. "/" .. _info2.var;
					_info2.__key = _key2;
					_LT_ConfigKeyToInfo[_key2] = _info2;
				else
					_key2 = key;
				end
				local _num2 = #_info2;
				if _num2 > 0 then
					_proc(_key2, _info2, 1, _num2);
				end
			end
		end
	end
	for _addon, _info in next, _T_addonInfo do
		local _num = #_info;
		if _num > 0 then
			_proc(_addon, _info, 1, _num);
		end
	end
	local _Temp = nil;
	local _GenChildList = nil;
	function _GenChildList(_CLIST)
		for _index = 1, #_CLIST do
			local _addon = _CLIST[_index];
			local _info = _T_addonInfo[_addon];
			local _clist = {
				type = "addon",
				addon = _addon,
				text = _info.title or _info.name or _addon,
			};
			local _children = _info.children;
			if _children ~= nil then
				for _index = 1, #_children do
					local _c = _children[_index];
					if _Temp[_c] == nil then
						_clist[#_clist + 1] = _c;
						_Temp[_c] = true;
					end
				end
				_GenChildList(_clist);
			end
			_CLIST[_index] = _clist;
		end
	end
	for _addon, _info in next, _T_addonInfo do		--	Children List on setting panel.
		local _children = _info.children;
		if _children ~= nil then
			local _clist = {  };
			_Temp = { [_addon] = true, };
			for _index = 1, #_children do
				local _c = _children[_index];
				_clist[_index] = _c;
				_Temp[_c] = true;
			end
			_clist.type = "text";
			_clist.text = LOC["ConfigPanel.ChildrenModesSeparator"];
			_GenChildList(_clist);
			_info._childrenList = _clist;
		end
	end
end
local function _LF_ApplyDB()
	if __namespace.____fixeraaddon then
		for _index = 1, _N_addonSetList do
			local _addon = _T_addonSetList[_index];
			local _info = _T_addonInfo[_addon];
			if _info.vendor and _info.registered ~= true then
				_DB_AddOnsState[_addon] = false;
			end
		end
	end
	local _BNotDelayLoad = not _DB_AddOnsConfig["!!!!coreconfig!!!!/laterLoading"];
	local _delayLoadList = {  };
	ResetAddOns();
	for _index = 1, _N_addonSetList do
		local _addon = _T_addonSetList[_index];
		local _info = _T_addonInfo[_addon];
		local _state = _DB_AddOnsState[_addon];
		local _FitMyClass = (_info.tags == nil or _info.tags[__const._C_PLAYER_CLASS] ~= false);
		if (_state == true or _info.protected) and _FitMyClass then
			if _BNotDelayLoad or _info.load == "NORMAL" or _info.load == nil then
				_F_addonEnable(_addon, false, true);
			else
				_info.enabled = false;
				_DisableAddOn(_addon);
				_delayLoadList[#_delayLoadList + 1] = _addon;
			end
		elseif _state == false then
			_F_addonDisable(_addon, false, false, true, true);
		elseif _FitMyClass == false then
			_DisableAddOn(_addon);
		end
	end
	for _addon, _state in next, _DB_AddOnsState do
		if _T_addonSetList[_addon] == nil and _state == false then
			_F_addonDisable(_addon, false, false, true, true);
		end
	end
	SaveAddOns();
	if _delayLoadList[1] ~= nil then
		__core:AddCallback(
			"CORE_GAME_LOADED",
			function(core, event)
				__core._F_addonTimerLoadAddOns(
					1.0,
					_delayLoadList,
					function(addon, cur, len)
						_F_corePrint(format(LOC["AddOn.DelayLoad.PreEcho"], addon, cur, len));
					end,
					nil,
					function()
						__core:FireEvent("ADDON_STATE_INITIALIZED");
						__core:EventDone("ADDON_STATE_INITIALIZED");
					end
				);
			end
		);
	else
		__core:FireEvent("ADDON_STATE_INITIALIZED");
		__core:EventDone("ADDON_STATE_INITIALIZED");
	end
	--
	local _proc = nil;
	_proc = function()
		local _hasOne = false;
		for _name, _todo in next, _T_addonSavedFramesName do
			if _todo then
				local _pos = _DB_AddOnsFrame[_name];
				if _pos ~= nil then
					local _Frame = _G[_name];
					if _Frame ~= nil then
						_T_addonSavedFramesName[_name] = false;
						_Frame:ClearAllPoints();
						_Frame:SetPoint(unpack(_pos));
					else
						_hasOne = true;
					end
				end
			end
		end
		if _hasOne then
			C_Timer_After(1.0, _proc);
		end
	end
	_proc();
end
__private.__oninit["_4addon"] = function()
	if __core.__is_dev then
		__core._F_devDebugProfileStart("core.init._4addon");
	end
	local __db = __namespace.__db;
	if __db ~= nil then
		local _addons_state = __db.addons_state;
		if _addons_state == nil then
			_addons_state = __namespace.__default.addons_state;
			__db.addons_state = _addons_state;
		else
			for _addon, _state in next, __namespace.__default.addons_state do
				if _addons_state[_addon] == nil then
					_addons_state[_addon] = _state;
				end
			end
		end
		for _addon, _state in next, _DB_AddOnsState do
			_addons_state[_addon] = _state;
		end
		_DB_AddOnsState = _addons_state;
		--
		local _addons_config = __db.addons_config;
		if _addons_config == nil then
			__db.addons_config = _DB_AddOnsConfig;
		else
			_DB_AddOnsConfig = _addons_config;
		end
		--
		local _addons_frames = __db.addons_frames;
		if _addons_frames == nil then
			__db.addons_frames = _DB_AddOnsFrame;
		else
			_DB_AddOnsFrame = _addons_frames;
		end
	end
	--
	_LF_ProcAddOnInfoTable();
	--
	__core._F_addonGetTagList();
	__core._F_addonGetList(nil, nil, nil, nil, true);
	--
	_LF_ApplyDB();
	--
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init._4addon", __core._F_devDebugProfileTick("core.init._4addon"));
	end
end
local _LF_SaveAddOnsConfig = nil;
_LF_SaveAddOnsConfig = function(info, min, max)
	for _index = max, min, -1 do
		local _info2 = info[_index];
		local _key = _info2.__key;
		if _key ~= nil and _info2.getvalue ~= nil then
			local _success, _val = _F_privateSafeCall(_info2.getvalue);
			if _success and (_DB_AddOnsConfig[_key] ~= nil or _info2.default ~= _val) then
				_DB_AddOnsConfig[_key] = _val == nil and __const._C_DECODE_NIL or _val;
			end
		end
		local _max2 = #_info2;
		if _max2 > 0 then
			_LF_SaveAddOnsConfig(_info2, 1, _max2);
		end
	end
end
__private.__onquit["_4addon"] = function()
	for _name, _todo in next, _T_addonSavedFramesName do
		local _Frame = _G[_name];
		if _Frame ~= nil then
			local _pos = { _Frame:GetPoint() };
			local _relto = _pos[2];
			if _relto ~= nil then
				local _rname = _relto:GetName();
				if _rname ~= nil then
					_pos[2] =_rname;
				elseif _relto == _Frame:GetParent() and _pos[1] == _pos[3] then
					_pos = { _pos[1], _pos[4], _pos[5], };
				else
					_pos = nil;
				end
			end
			_DB_AddOnsFrame[_name] = _pos;
		end
	end
	for _addon, _info in next, _T_addonInfo do
		if _DB_AddOnsState[_addon] == true then
			local _max = #_info;
			if _max > 0 then
				_LF_SaveAddOnsConfig(_info, 1, _max);
			end
		end
	end
end

-->		Timer Load/Disable AddOns
	local _LT_AddOnLoadingInfo = {  };
	local _LF_addonTimerLoadAddOnsAction = nil;
	_LF_addonTimerLoadAddOnsAction = function()
		_F_coreDebug("Delay Loading");
		if InCombatLockdown() then
			__private._F_privateOnEventOnce("PLAYER_REGEN_ENABLED", _LF_addonTimerLoadAddOnsAction);
			_F_corePrint(format(LOC["AddOn.DelayLoad.WaitForCombatEnd"], _LT_AddOnLoadingInfo[3]));
			return;
		end
		local _list = _LT_AddOnLoadingInfo[1];
		local _index = _LT_AddOnLoadingInfo[2];
		local _max = _LT_AddOnLoadingInfo[3];
		local _endTime = __core._F_coreTime() + 0.1;
		repeat
			local _addon = _list[_index];
			local _info = _T_addonInfo[_addon];
			if _LT_AddOnLoadingInfo[4] ~= nil then
				_F_privateSafeCall(_LT_AddOnLoadingInfo[4], _addon, _index, _max);
			end
			if _info.loaded ~= true then
				_F_addonLoad(_addon, false, true);
			elseif _info.enabled ~= true then
				_F_addonEnable(_addon, false, true);
			end
			_index = _index + 1;
			if _LT_AddOnLoadingInfo[5] ~= nil then
				_F_privateSafeCall(_LT_AddOnLoadingInfo[5], _addon);
			end
		until __core._F_coreTime() >= _endTime or _index > _max;
		_F_corePrint(_index, "of", _max);
		if _index <= _max then
			_LT_AddOnLoadingInfo[2] = _index;
			C_Timer_After(0.25, _LF_addonTimerLoadAddOnsAction);
		elseif _LT_AddOnLoadingInfo[6] ~= nil then
			_F_privateSafeCall(_LT_AddOnLoadingInfo[6]);
		end
		local _F = __ui._W_MainUI._AddOnListScrollFrame;
		_F:__RefreshUIFunc();
	end
	local function _F_addonTimerLoadAddOns(delay, list, precallback, postcallback, onfinish)
		local _now = _F_coreTime();
		_LT_AddOnLoadingInfo[1] = list;
		_LT_AddOnLoadingInfo[2] = 1;
		_LT_AddOnLoadingInfo[3] = #list;
		_LT_AddOnLoadingInfo[4] = precallback;
		_LT_AddOnLoadingInfo[5] = postcallback;
		_LT_AddOnLoadingInfo[6] = onfinish;
		_LT_AddOnLoadingInfo[7] = _now + delay;
		_F_coreDebug("Delay Waiting", delay);
		if delay > 0.01 then
			C_Timer_After(delay, _LF_addonTimerLoadAddOnsAction);
		else
			_LF_addonTimerLoadAddOnsAction();
		end
	end
	local function _LF_addonTimerLoadAddOns_Checker()
		local _diff = _LT_AddOnLoadingInfo[7] - _F_coreTime();
		if _diff > 0.01 then
			C_Timer_After(_diff, _LF_addonTimerLoadAddOns_Checker);
		else
			_LF_addonTimerLoadAddOnsAction();
		end
	end
	local function _F_addonTimerLoadAddOns_CheckDelay(delay, list, precallback, postcallback, onfinish)
		local _now = _F_coreTime();
		_LT_AddOnLoadingInfo[1] = list;
		_LT_AddOnLoadingInfo[2] = 1;
		_LT_AddOnLoadingInfo[3] = #list;
		_LT_AddOnLoadingInfo[4] = precallback;
		_LT_AddOnLoadingInfo[5] = postcallback;
		_LT_AddOnLoadingInfo[6] = onfinish;
		_LT_AddOnLoadingInfo[7] = _now + delay;
		_F_coreDebug("Delay Waiting", delay);
		if delay > 0.01 then
			C_Timer_After(delay, _LF_addonTimerLoadAddOns_Checker);
		else
			_LF_addonTimerLoadAddOnsAction();
		end
	end
	local function _F_addonTimerLoadAllUIAddOns()
		local _num = 0;
		local _list = {  };
		for _index = 1, _N_UIAddonSetList do
			local _addon = _T_UIAddonSetList[_index];
			local _info = _T_addonInfo[_addon];
			if _info.loaded ~= true or _info.enabled ~= true then
				_num = _num + 1;
				_list[_num] = _addon;
			end
		end
		if _num > 0 then
			_F_addonTimerLoadAddOns(0.0, _list);
		end
	end
	__core._F_addonTimerLoadAddOns = _F_addonTimerLoadAddOns;
	__core._F_addonTimerLoadAddOns_CheckDelay = _F_addonTimerLoadAddOns_CheckDelay;
	__core._F_addonTimerLoadAllUIAddOns = _F_addonTimerLoadAllUIAddOns;
	local function _F_addonTimerDisableAllUIAddOns()
		for _index = 1, _N_UIAddonSetList do
			local _addon = _T_UIAddonSetList[_index];
			local _info = _T_addonInfo[_addon];
			if _info.enabled == true and not _info.protected then
				_F_addonDisable(_addon);
			end
		end
		local _F = __ui._W_MainUI._AddOnListScrollFrame;
		_F:__RefreshUIFunc();
	end
	__core._F_addonTimerDisableAllUIAddOns = _F_addonTimerDisableAllUIAddOns;
-->

-->		Config
	--
	local _LF_FoundCfgInfo = nil;
	_LF_FoundCfgInfo = function(key, info, min, max)
		for _index = min, max do
			local _info2 = info[_index];
			if _info2.__key == key then
				return _info2;
			else
				local _value = _LF_FoundCfgInfo(key, _info2, 1, #_info2);
				if _value ~= nil then
					return _value;
				end
			end
		end
	end
	local function _F_addonGetConfig(key, info, addon, donotgetvalue)
		if addon == nil then
			addon = strsplit("/", key);
		end
		if info == nil then
			info = _LT_ConfigKeyToInfo[key];
		end
		if info ~= nil then
			if donotgetvalue ~= true and addon ~= nil and info.getvalue ~= nil then
				local _ainfo = _T_addonInfo[addon];
				if _ainfo ~= nil and _ainfo.loaded then
					return info.getvalue();
				end
			end
			local _value = _DB_AddOnsConfig[key];
			if _value == nil then
				if info.default ~= nil then
					if type(info.default) == 'function' then
						_value = info.default();
					else
						_value = info.default;
					end
				end
			end
			if _value == __const._C_DECODE_NIL then
				return nil;
			end
			return _value;
		end
		return nil;
		--[[local _value = _DB_AddOnsConfig[key];
		if _value == nil then
			if info == nil then
				if addon == nil then
					addon = strsplit("/", key);
				end
				local _info2 = _T_addonInfo[addon];
				if _info2 ~= nil then
					info = _LF_FoundCfgInfo(key, _info2, 1, #_info2);
				else
					for _, _info2 in next, _T_addonInfo do
						info = _LF_FoundCfgInfo(key, _info2, 1, #_info2);
						if info ~= nil then
							break;
						end
					end
				end
			end
			if info ~= nil then
				if donotgetvalue ~= true and _value == nil and addon ~= nil and info.getvalue ~= nil then
					local _ainfo = _T_addonInfo[addon];
					if _ainfo ~= nil and _ainfo.loaded then
						_value = info.getvalue();
					end
				elseif info.default ~= nil then
					if type(info.default) == 'function' then
						_value = info.default();
					else
						_value = info.default;
					end
				end
			end
		end
		return _value;--]]
	end
	local function _F_addonSetConfig(key, value)
		_DB_AddOnsConfig[key] = value;
	end
	__core._F_addonGetConfig = _F_addonGetConfig;
	__core._F_addonSetConfig = _F_addonSetConfig;
	--
	local function _F_addonIsConfigEnabled(info)
		local _pinfo = info.__parent;
		while _pinfo ~= nil do
			if _pinfo.__key ~= nil and _pinfo.type == 'check' and not _F_addonGetConfig(_pinfo.__key, _pinfo) then
				return false;
			end
			_pinfo = _pinfo.__parent;
		end
		return true;
	end
	local function _LF_addonConfigCallback(info, value, loading)
		if info.__key ~= nil then
			_DB_AddOnsConfig[info.__key] = value;
		end
		if info.callback ~= nil then
			info.callback(info, value, loading);
		end
		if info.reload then
			__ui._W_MainUI:NotifyReloadFlash();
			_T_AddOnsNeedReload["*config.callback.reload"] = true;
		end
	end
	local function _F_addonConfigCallback(addon, info, value, loading)
		local _info = _T_addonInfo[addon];
		if _info ~= nil and _info.loaded and _F_addonIsConfigEnabled(info) then
			if info.confirm ~= nil and not loading then
				__ui._W_POPUP:_F_Show("_ADDON_CONFIG_CONFIRM", info.confirm, info.text, { _LF_addonConfigCallback, info, value, loading, });
			else
				_LF_addonConfigCallback(info, value, loading);
			end
		else
			if info.__key ~= nil then
				_DB_AddOnsConfig[info.__key] = value;
			end
		end
	end
	local _F_addonConfigFindChild = nil;
	_F_addonConfigFindChild = function(info, key)
		for _index = 1, #info do
			local _info2 = info[_index];
			if _info2.var == key then
				return _info2;
			end
		end
		for _index = 1, #info do
			local _info2 = info[_index];
			if _info2.type == 'text' then
				local _info3 = _F_addonConfigFindChild(_info2, key);
				if _info3 ~= nil then
					return _info3;
				end
			end
		end
	end
	local function _F_addonConfigFindChildByName(addon, key)
		local _info = _T_addonInfo[addon];
		if _info ~= nil then
			return _F_addonConfigFindChild(_info, key);
		end
	end
	__core._F_addonIsConfigEnabled = _F_addonIsConfigEnabled;
	__core._F_addonConfigCallback = _F_addonConfigCallback;
	__core._F_addonConfigFindChild = _F_addonConfigFindChild;
	__core._F_addonConfigFindChildByName = _F_addonConfigFindChildByName;
	--
	local _F_addonLoadConfig = nil;
	_F_addonLoadConfig = function(info, addon)
		if info.var ~= nil then
			local _val = _F_addonGetConfig(info.__key, info, addon, true);
			if info.callback ~= nil then
				_F_privateSafeCall(info.callback, info, _val, true);
			end
			if info.type == 'check' and not _val then
				return;
			end
		end
		for _index = 1, #info do
			_F_addonLoadConfig(info[_index], addon);
		end
	end
	__core._F_addonLoadConfig = _F_addonLoadConfig;
	--
-->

-->		AddonList
	--
	local _LB_LoadAll = false;
	local _LB_DisableAll = false;
	local _LT_Enabled = {  };
	local _LT_Disabled = {  };
	--
	local AddonList = _G.AddonList;
	local AddonListOkayButton = _G.AddonListOkayButton;
	local AddonListEnableAllButton = _G.AddonListEnableAllButton;
	local AddonListScrollFrame = _G.AddonListScrollFrame;
	local _ReloadUI = _G.CreateFrame('BUTTON', "AddonList_ReloadUIButton", AddonList, "MagicButtonTemplate");
	_ReloadUI:SetPoint("TOPRIGHT", AddonListOkayButton, "TOPLEFT", 0, 0);
	_ReloadUI:SetText(_G.RELOADUI);
	_ReloadUI:SetScript("OnClick", _G.ReloadUI);
	_ReloadUI:Hide();
	_ReloadUI.__reason = {  };
	--
	local function _AddonList_Update()
		if next(_LT_Enabled) == nil and next(_LT_Disabled) == nil then
			AddonListOkayButton:SetText(OKAY);
		else
			AddonListOkayButton:SetText(APPLY);
		end
		--
		if next(_LT_Disabled) == nil then
			_ReloadUI:Hide();
		else
			_ReloadUI:Show();
			return;
		end
		for _addon, _ in next, _ReloadUI.__reason do
			if _LT_Enabled[_addon] == nil then
				_ReloadUI:Show();
				return;
			end
		end
	end
	--
	AddonList:HookScript("OnShow", _AddonList_Update);
	AddonListScrollFrame:HookScript("OnVerticalScroll", _AddonList_Update);
	--
	local function AddonListEntry_Enabled_OnClick(self)
		local addon, enabled = self.__parent:GetID(), self:GetChecked();
		if enabled then
			if _LT_Disabled[addon] ~= nil then
				_LT_Disabled[addon] = nil;
			else
				_LT_Enabled[addon] = true;
			end
		else
			if _LT_Enabled[addon] ~= nil then
				_LT_Enabled[addon] = nil;
			else
				_LT_Disabled[addon] = true;
			end
		end
		_AddonList_Update();
	end
	-- hooksecurefunc("AddonList_Enable", function(addon, enabled)
	-- end);
	local Num = 1;
	while true do
		local L = _G["AddonListEntry" .. Num];
		local E = _G["AddonListEntry" .. Num .. "Enabled"];
		if L == nil then
			break;
		end
		E.__parent = L;
		E:HookScript("OnClick", AddonListEntry_Enabled_OnClick);
		Num = Num + 1;
	end
	--
	--	AddonListCancelButton		AddonList_OnCancel
	hooksecurefunc("AddonList_OnCancel", function()
		_LB_LoadAll = false;
		_LB_DisableAll = false;
		_LT_Enabled = {  };
		_LT_Disabled = {  };
	end);
	--	AddonListOkayButton			AddonList_OnOkay
	AddonListOkayButton:SetScript("OnClick", function()
		for _addon, _state in next, _LT_Disabled do
			local _key = GetAddOnInfo(_addon);
			if _key ~= nil then
				_key = strlower(_key);
				_F_addonDisable(_key);
			end
		end
		for _addon, _ in next, _LT_Disabled do
			_ReloadUI.__reason[_addon] = true;
		end
		_LT_Disabled = {  };
		if _LB_LoadAll then
			_F_addonTimerLoadAllUIAddOns();
			_ReloadUI.__reason = {  };
		elseif _LB_DisableAll then
			SaveAddOns();
			ReloadUI();
		else
			for _addon, _state in next, _LT_Enabled do
				local _key = GetAddOnInfo(_addon);
				if _key ~= nil then
					_key = strlower(_key);
					_F_addonLoad(_key, true);
				end
			end
			for _addon, _ in next, _LT_Enabled do
				_ReloadUI.__reason[_addon] = nil;
			end
		end
		_LT_Enabled = {  };
		LUIPanel.Hide(AddonList);
	end);
	--	AddonListEnableAllButton	*AddonList_EnableAll
	AddonListEnableAllButton:HookScript("OnClick", function()
		_LB_LoadAll = true;
		_LT_Enabled = {  };
		_LT_Disabled = {  };
		_AddonList_Update();
	end);
	AddonListDisableAllButton:HookScript("OnClick", function()
		_LB_DisableAll = true;
	end);
	--	AddonListDisableAllButton	*AddonList_DisableAll
	--
	-- hooksecurefunc("AddonList_Update", function()
	-- 	--	AddonListOkayButton:SetText(RELOADUI);
	-- 	--	AddonList.shouldReload = true;
	-- 	--	AddonListOkayButton:SetText(OKAY);
	-- 	--	AddonList.shouldReload = false;
	-- 	_AddonList_Update();
	-- end);
	__core:AddCallback(
		"CORE_POST_ADDON_LOADED",
		function(core, event, addon)
			local _index = _T_addonList[addon];
			if _index ~= nil then
				AddonList.startStatus[_index] = true;
			end
		end
	);
-->


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._4addon", __core._F_devDebugProfileTick("core._4addon"));
end
