--[=[
	CORE
--]=]
--[====[
	table			__namespace.__client
	table			__namespace.__private
	table			__namespace.__core
	table			__namespace.__const
	table			__namespace.__ui
	table			__namespace.__onuidef
	table			__namespace.__module
	--	value			-->
		frame				__private.__F
		string				__private.__addon
		table				__private.__oninit										--	run on CORE_GAME_LOADED
		table				__private.__onquit										--	run on PLAYER_LOGOUT
		bool				__core.__is_dev
		bool				__core.__is_capturingAllEvents
		table				__core._T_coreFrameSample								[type] = frame
		table				__core._T_coreFrameMetaTable							[metatable] = true
		table				__core._T_coreLayerSample								[type] = region
		table				__core._T_coreLayerMetaTable							[metatable] = true
		table				__core._T_coreOtherSample								[type] = region
		table				__core._T_coreOtherMetatable							[metatable] = true
		string				__client._PatchVersion									--
		string				__client._BuildNumber									--
		string				__client._BuildDate										--
		int					__client._TocVersion									--	13005, 90002
		string				__client._Type											--	"classic60", "retail"
		int					__client._Expansion										--
	--	function		-->		Internal method without parameters check
		success, ...	=	__private._F_privateSafeCall							(func, ...)								--	func(...)
							__core._F_noop											()
		time			=	__core._F_coreTime										()
							__core._F_corePrint										(...)
							__core._F_coreDebug										(...)
							__core._F_coreSetDefaultMessageFrame					(frame)
							__core._F_devGetDebugStack								(prefix, print_blz_call)
							__core._F_devOutputDebugStack							(prefix, print_blz_call)
							__core._F_devCheckChildrenSecure						(tbl, level, path)
							__core._F_devDebugProfileStart							(key)
							__core._F_devDebugProfileTick							(key)
							__core._F_BuildEnv(category)
							__core._F_MergeGlobal(DB)

							__core:RegisterEvent									(event, func)							--	func(self, event, ...)
							__core:UnregisterEvent									(event)
							__core:RegisterCallback									(event, callonce)
							__core:AddCallback										(event, func, noimmediate)				--	func(event, ...)
							__core:RemoveCallback									(event, func)
							__core:FireEvent										(event, ...)

							__core._F_coreSimulatorOnLibraryCallbackRegistered		(libframe, event, ~func, ~arg)
							__core._F_coreSimulatorMonitorLibrary					(libname, handler)						--	handler(libname, version)
		justhook		=	__core._F_coreSimulatorHookLibraryFrame					(libname, libframe)

							__core._F_coreSimulatorStartCapturing					()
							__core._F_coreSimulatorStopCapturing					()
							__core._F_coreSimulatorResumeCapturing					()
							__core._F_coreSimulatorPauseCapturing					()
							__core._F_coreSimulatorLoadingEvents					()

		locale_table	=	__core._F_coreLocaleNew									()

	--
--]====]

_G.__core_namespace = {  };		--	Global

local __namespace = _G.__core_namespace;
local __addon, __private = ...;
__addon = __addon or "!!!!core!!!!";
__private = __private or {  };
__private.__addon = __addon;

__namespace.__client = {  };
__namespace.__private = __private;
__namespace.__core = { _F_noop = function(self, event) end, };
__namespace.__ui = {  };
__namespace.__const = {  };
__namespace.__onuidef = setmetatable(
	{
		__list = {  },
		__next = function(tbl, prev)
			local __list = tbl.__list;
			prev = prev == nil and 1 or (prev + 1);
			if prev <= #__list then
				local _key = __list[prev];
				return prev, _key, tbl[_key];
			else
				return nil;
			end
		end,
		__wipe = function(tbl)
			local __list = tbl.__list;
			for _index = #__list, 1, -1 do
				tbl[__list[_index]] = nil;
				__list[_index] = nil;
			end
		end,
	},
	{
		__newindex = function(tbl, key, val)
			local __list = tbl.__list;
			__list[#__list + 1] = key;
			rawset(tbl, key, val);
		end,
	}
);
__namespace.__subfolder = {  };
__namespace.__module = {  };

local __core = __namespace.__core;
__private.__F = CreateFrame('FRAME');
__core.__is_dev = select(2, GetAddOnInfo("!!!!!DebugMe")) ~= nil;

local debugprofilestart, debugprofilestop = debugprofilestart, debugprofilestop;
local _AccurateTime = _G.AccurateTime;
if _AccurateTime ~= nil then
	debugprofilestart = _AccurateTime._debugprofilestart or debugprofilestart;
	debugprofilestop = _AccurateTime._debugprofilestop or debugprofilestop;
end
--
if __core.__is_dev then
	debugprofilestart();
end

-->		upvalue
local setfenv = setfenv;
local pcall, xpcall, hooksecurefunc, debugstack, issecurevariable = pcall, xpcall, hooksecurefunc, debugstack, issecurevariable;
local type, select = type, select;
local setmetatable, getmetatable, rawget, rawset = setmetatable, getmetatable, rawget, rawset;
local next = next;
local table_concat = table.concat;
local strlower, format, strmatch, gmatch = string.lower, string.format, string.match, string.gmatch;
local loadstring, tostring = loadstring, tostring;
local GetTimePreciseSec = GetTimePreciseSec;
local CreateFrame = CreateFrame;
local _G = _G;

local inext = ipairs(__namespace);
local _F_noop = __core._F_noop;

-->		Client
	local _PatchVersion, _BuildNumber, _BuildDate, _TocVersion = GetBuildInfo();
	__namespace.__client._PatchVersion = _PatchVersion;
	__namespace.__client._BuildNumber = _BuildNumber;
	__namespace.__client._BuildDate = _BuildDate;
	__namespace.__client._TocVersion = _TocVersion;
	for _Major, _Toc in inext, { 11300, 20500, 30400, 40400, 50500, 60300, 70400, 80400, 99999, }, 0 do
		if _TocVersion < _Toc then
			__namespace.__client._Type = "retail";
			__namespace.__client._Major = _Major;
			__namespace.__client._Expansion = _Major - 1;
			break;
		elseif _TocVersion < (_Major + 1) * 10000 then
			__namespace.__client._Type = "classic";
			__namespace.__client._Major = _Major;
			__namespace.__client._Expansion = _Major - 1;
			break;
		end
	end
-->
-->		SafeCall
	__private.__ErrorHandler = geterrorhandler();
	hooksecurefunc("seterrorhandler", function(handler)
		__private.__ErrorHandler = handler;
	end);
	if __namespace.__client._Type == "retail" and __namespace.__client._Expansion < 8 then
		local function _Proc(success, ret1, ...)
			if success then
				return success, ret1, ...;
			else
				__ErrorHandler(ret1);
				return false, nil;
			end
		end
		function __private._F_privateSafeCall(func, ...)
			return _Proc(pcall(func, ...));
		end
	else
		function __private._F_privateSafeCall(func, ...)
			return xpcall(func, __private.__ErrorHandler, ...);
		end
	end
-->
-->		Time
	local _debugprofilestart, _debugprofilestop = debugprofilestart, debugprofilestop;
	local _LT_DebugProfilePoint = {
		["*"] = 0,
	};
	local function _F_devDebugProfileStart(key)
		_LT_DebugProfilePoint[key] = debugprofilestop();
	end
	local function _F_devDebugProfileTick(key)
		local _val = _LT_DebugProfilePoint[key];
		if _val ~= nil then
			_val = _debugprofilestop() - _val;
			_val = _val - _val % 0.0001;
			return _val;
		end
	end
	__core._F_devDebugProfileStart = _F_devDebugProfileStart;
	__core._F_devDebugProfileTick = _F_devDebugProfileTick;
	local _LN_LastDebugProfilePoint = _debugprofilestop();
	function _G.debugprofilestart()
		_LN_LastDebugProfilePoint = _debugprofilestop();
	end
	function _G.debugprofilestop()
		return _debugprofilestop() - _LN_LastDebugProfilePoint;
	end
	-->		Time
	if GetTimePreciseSec == nil then
		_F_devDebugProfileStart("_sys._1core.time.alternative");
		 GetTimePreciseSec = function()
			return _F_devDebugProfileTick("_sys._1core.time.alternative");
		 end
	end
	local _LN_coreBaseTime = GetTimePreciseSec();
	function __core._F_coreTime()
		local _now = GetTimePreciseSec() - _LN_coreBaseTime + 0.00005;
		return _now - _now % 0.0001;
	end
-->
local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_coreTime = __core._F_coreTime;

__private.__oninit = setmetatable(
	{
		__list = {  },
		__next = function(tbl, prev)
			local __list = tbl.__list;
			prev = prev == nil and 1 or (prev + 1);
			if prev <= #__list then
				local _key = __list[prev];
				return prev, _key, tbl[_key];
			else
				return nil;
			end
		end,
		__wipe = function(tbl)
			local __list = tbl.__list;
			for _index = #__list, 1, -1 do
				tbl[__list[_index]] = nil;
				__list[_index] = nil;
			end
		end,
	},
	{
		__newindex = function(tbl, key, val)
			if tbl.__loaded then
				if type(val) == 'function' then
					_F_privateSafeCall(val);
				end
			else
				local __list = tbl.__list;
				__list[#__list + 1] = key;
				rawset(tbl, key, val);
			end
		end,
	}
);
__private.__onquit = setmetatable(
	{
		__list = {  },
		__next = function(tbl, prev)
			local __list = tbl.__list;
			prev = prev == nil and 1 or (prev + 1);
			if prev <= #__list then
				local _key = __list[prev];
				return prev, _key, tbl[_key];
			else
				return nil;
			end
		end,
	},
	{
		__newindex = function(tbl, key, val)
			local __list = tbl.__list;
			__list[#__list + 1] = key;
			rawset(tbl, key, val);
		end,
	}
);

-->		CorePrint
	local _LT_CorePrint_Method_Env = {
		select = select,
		tostring = tostring,
		format = format,
		table_concat = table_concat,
		__DefaultMessageFrame = _G.DEFAULT_CHAT_FRAME,
	};
	local _LT_CorePrint_Method = setmetatable(
		{
			["*"] = setfenv(
				function(...)
					local _nargs = select("#", ...);
					local _argsv = { ... };
					for _index = _nargs, 1, -1 do
						if _argsv[_index] ~= nil then
							_nargs = _index;
							break;
						end
					end
					for _index = 1, _nargs do
						_argsv[_index] = tostring(_argsv[_index]);
					end
					__DefaultMessageFrame:AddMessage("|cff00ff00>|r " .. table_concat(_argsv, " "));
				end,
				_LT_CorePrint_Method_Env
			),
			[0] = setfenv(
				function()
					__DefaultMessageFrame:AddMessage("|cff00ff00>|r nil");
				end,
				_LT_CorePrint_Method_Env
			),
		},
		{
			__index = function(tbl, nargs)
				if nargs > 0 and nargs < 8 then
					local _head = [[local tostring = tostring;\nreturn function(arg1]];
					local _body = [[) __DefaultMessageFrame:AddMessage("|cff00ff00>|r " .. tostring(arg1)]];
					local _tail = [[); end]];
					for _index = 2, nargs do
						_head = _head .. [[, arg]] .. _index;
						_body = _body .. [[ .. " " .. tostring(arg]] .. _index .. [[)]];
					end
					local _func0, _err = loadstring(_head .. _body .. _tail);
					-- local _head = "local tostring = tostring;\nreturn function(arg1";
					-- local _body = ") __DefaultMessageFrame:AddMessage(format(\"|cff00ff00>|r %s";
					-- local _body2 = "\", tostring(arg1)";
					-- local _tail = ")); end";
					-- for _index = 2, nargs do
					-- 	_head = _head .. ", arg" .. _index;
					-- 	_body = _body .. " %s";
					-- 	_body2 = _body2 .. ", tostring(arg" .. _index .. ")";
					-- end
					-- local _func0, _err = loadstring(_head .. _body .. _body2 .. _tail);
					if _func0 == nil then
						local _func = tbl["*"];
						tbl[nargs] = _func;
						return _func;
					else
						local _, _func = _F_privateSafeCall(_func0);
						if _func == nil then
							_func = tbl["*"];
						else
							setfenv(_func, _LT_CorePrint_Method_Env);
						end
						tbl[nargs] = _func;
						return _func;
					end
				else
					local _func = tbl["*"];
					tbl[nargs] = _func;
					return _func;
				end
			end,
		}
	);
	for _index = 1, 8 do
		local _func = _LT_CorePrint_Method[_index];
	end
	function __core._F_corePrint(...)
		local _func = _LT_CorePrint_Method[select("#", ...)];
		if _func ~= nil then
			_func(...);
		end
	end
	function __core._F_coreSetDefaultMessageFrame(Frame)
		if Frame ~= nil then
			_LT_CorePrint_Method_Env.__DefaultMessageFrame = Frame;
		end
	end
	__core._F_coreSetDefaultMessageFrame(_G.DEFAULT_CHAT_FRAME);
-->
local _F_corePrint = __core._F_corePrint;
-->		Dev
	-->		BREAK POINT
	local __thisFile = [[AddOns\]] .. __addon .. [[\_1core.lua]];
	local __strMatch = [[Interface\([^:]+%.lua)"%]:([0-9]+):]];
	if __namespace.__client._Type == "classic" and __namespace.__client._Expansion == 0 then
		__strMatch = [[Interface\([^:]+%.lua):([0-9]+):]];
	end
	local function _F_devGetDebugStack(prefix, print_blz_call, maxLinesSkipThisFile)
		maxLinesSkipThisFile = maxLinesSkipThisFile or 4294967295;
		local _str = nil;
		if prefix ~= nil then
			_str = prefix;
		else
			_str = "";
		end
		local _first = true;
		for _file, _line in gmatch(debugstack(0), __strMatch) do
			if _first and _file == __thisFile and maxLinesSkipThisFile > 0 then
				maxLinesSkipThisFile = maxLinesSkipThisFile - 1;
			else
				_first = false;
				_str = _str .. " #" .. _file .. ":" .. _line;
				if strmatch(_file, [[\AceAddon]]) ~= nil or strmatch(_file, [[\AceEvent]]) ~= nil or strmatch(_file, [[\LibCallback]]) ~= nil then
					break;
				end
				if not print_blz_call then
					if strmatch(_file, "^Blizzard_") ~= nil or strmatch(_file, "^FrameXML") ~= nil or strmatch(_file, "^SharedXML") ~= nil then
						break;
					end
				end
			end
		end
		return _str;
	end
	local function _F_devOutputDebugStack(prefix, print_blz_call, maxLinesSkipThisFile)
		_F_corePrint(_F_devGetDebugStack(prefix, print_blz_call, maxLinesSkipThisFile));
	end
	__core._F_devGetDebugStack = _F_devGetDebugStack;
	__core._F_devOutputDebugStack = _F_devOutputDebugStack;
	local _F_devCheckChildrenSecure = nil;
	_F_devCheckChildrenSecure = function(tbl, level, path)
		tbl = tbl or GetMouseFocus();
		level = level or 1;
		for _key, _val in next, tbl do
			local path2 = path ~= nil and (path .. "\[" .. _key .. "\]") or "\[" .. _key .. "\]";
			if issecurevariable(tbl, _key) then
				if level < 4 and type(_val) == 'table' then
					_F_devCheckChildrenSecure(_val, level + 1, path2);
				end
			else
				_F_corePrint("insec", path2);
			end
		end
	end
	__core._F_devCheckChildrenSecure = _F_devCheckChildrenSecure;
	-->
	local _LT_coreDeprecatedBackup = nil;
	local function DisableScriptErrors()
		if _LT_coreDeprecatedBackup == nil then
			if ScriptErrorsFrame ~= nil then
				_LT_coreDeprecatedBackup = {  };
				_LT_coreDeprecatedBackup.ScriptErrorsFrame_Show = ScriptErrorsFrame.Show;
				_LT_coreDeprecatedBackup.ScriptErrorsFrame_DisplayMessage = ScriptErrorsFrame.DisplayMessage;
				_LT_coreDeprecatedBackup.ScriptErrorsFrame_DisplayMessageInternal = ScriptErrorsFrame.DisplayMessageInternal;
			end
			_LT_coreDeprecatedBackup.HandleLuaError = HandleLuaError;
			_LT_coreDeprecatedBackup.HandleLuaWarning = HandleLuaWarning;
		end
		SetCVar("scriptErrors", 0);
		if ScriptErrorsFrame ~= nil then
			ScriptErrorsFrame:SetAlpha(0.0);
			ScriptErrorsFrame:EnableMouse(false);
			ScriptErrorsFrame.Show = _F_noop;
			ScriptErrorsFrame.DisplayMessage = _F_noop;
			ScriptErrorsFrame.DisplayMessageInternal = _F_noop;
		end
		_G.HandleLuaError = _F_noop;
		_G.HandleLuaWarning = _F_noop;
	end
	local function EnableScriptErrors()
		SetCVar("scriptErrors", 1);
		if _LT_coreDeprecatedBackup ~= nil then
			if ScriptErrorsFrame ~= nil then
				ScriptErrorsFrame:SetAlpha(1.0);
				ScriptErrorsFrame:EnableMouse(true);
				ScriptErrorsFrame.Show = _LT_coreDeprecatedBackup.ScriptErrorsFrame_Show;
				ScriptErrorsFrame.DisplayMessage = _LT_coreDeprecatedBackup.ScriptErrorsFrame_DisplayMessage;
				ScriptErrorsFrame.DisplayMessageInternal = _LT_coreDeprecatedBackup.ScriptErrorsFrame_DisplayMessageInternal;
			end
			_G.HandleLuaError = _LT_coreDeprecatedBackup.HandleLuaError;
			_G.HandleLuaWarning = _LT_coreDeprecatedBackup.HandleLuaWarning;
			_LT_coreDeprecatedBackup = nil;
		end
	end
	if __core.__is_dev then
		__core._F_coreDebug = function(...)
			_F_corePrint(_F_coreTime(), ...);
		end
		EnableScriptErrors();
	else
		__core._F_coreDebug = _F_noop;
		DisableScriptErrors();
	end
	local _GlobalRef = {  };
	local _GlobalAssign = {  };
	function __core._F_BuildEnv(category)
		_GlobalRef[category] = _GlobalRef[category] or {  };
		_GlobalAssign[category] = _GlobalAssign[category] or {  };
		local Ref = _GlobalRef[category];
		local Assign = _GlobalAssign[category];
		setfenv(2, setmetatable(
			{  },
			{
				__index = function(tbl, key, val)
					Ref[key] = (Ref[key] or 0) + 1;
					return _G[key];
				end,
				__newindex = function(tbl, key, value)
					rawset(tbl, key, value);
					_F_corePrint("Core Assign Global ", category, key, value);
					_F_devOutputDebugStack(nil, nil, 3);
					Assign[key] = (Assign[key] or 0) + 1;
					return value;
				end,
			}
		));
	end
	function __core._F_MergeGlobal(DB)
		local _Ref = DB._GlobalRef;
		if _Ref ~= nil then
			for category, db in next, _Ref do
				local to = _GlobalRef[category];
				if to == nil then
					_GlobalRef[category] = db;
				else
					for key, val in next, db do
						to[key] = (to[key] or 0) + val;
					end
				end
			end
		end
		DB._GlobalRef = _GlobalRef;
		local _Assign = DB._GlobalAssign;
		if _Assign ~= nil then
			for category, db in next, _Assign do
				local to = _GlobalAssign[category];
				if to == nil then
					_GlobalAssign[category] = db;
				else
					for key, val in next, db do
						to[key] = (to[key] or 0) + val;
					end
				end
			end
		end
		DB._GlobalAssign = _GlobalAssign;
	end
-->

local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local tremove = table.remove;
local InCombatLockdown = InCombatLockdown;
local GetNumGroupMembers = GetNumGroupMembers;
local UnitIsDeadOrGhost = UnitIsDeadOrGhost;
local UnitExists = UnitExists;
local CreateFont = CreateFont;
local C_NamePlate_GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit;

if GetNumGroupMembers == nil then
	local GetNumPartyMembers = GetNumPartyMembers;
	local GetNumRaidMembers = GetNumRaidMembers;
	if GetNumRaidMembers ~= nil and GetNumPartyMembers ~= nil then
		GetNumGroupMembers = function()
			local _r = GetNumRaidMembers();
			if _r ~= nil and _r > 0 then
				return _r;
			end
			local _p = GetNumPartyMembers();
			if _p ~= nil and _p > 0 then
				return _p;
			end
			return 0;
		end
	elseif GetNumRaidMembers ~= nil then
		GetNumGroupMembers = GetNumRaidMembers;
	elseif GetNumPartyMembers ~= nil then
		GetNumGroupMembers = GetNumPartyMembers;
	else
		GetNumGroupMembers = function()
			return 0;
		end
	end
end

local LibStub = LibStub;

if __core.__is_dev then
	__core._F_BuildEnv("core._1core");
end


-->		Core Internal			--		Register Events at the very earliest start. Triggered before any other.
	local __F = __private.__F;
	local _LF_CoreRegisterEvent = __F.RegisterEvent;
	function __core:RegisterEvent(event, func)
		_LF_CoreRegisterEvent(__F, event);
		if func ~= nil then
			__F[event] = func;
		elseif __F[event] == nil then
			__F[event] = _F_noop;
		end
	end
	function __core:UnregisterEvent(event)
		__F:UnregisterEvent(event);
	end
	--	Triggered Sequence on load:	ADDON_LOADED, VARIABLES_LOADED, PLAYER_LOGIN, PLAYER_ENTERING_WORLD, LOADING_SCREEN_DISABLED
	__core:RegisterEvent("ADDON_LOADED");
	__core:RegisterEvent("VARIABLES_LOADED");
	__core:RegisterEvent("PLAYER_LOGIN");
	__core:RegisterEvent("PLAYER_ENTERING_WORLD");
	__core:RegisterEvent("PLAYER_LOGOUT");
	__core:RegisterEvent("LOADING_SCREEN_DISABLED");
	__core:RegisterEvent("LOADING_SCREEN_ENABLED");
	-- f:RegisterEvent("CVAR_UPDATE");
	local function _LF__core_OnEvent(self, event, ...)
		self[event](__core, event, ...);
	end
	__F:SetScript("OnEvent", _LF__core_OnEvent);
	local _LT_CoreCallbackRegistration = {  };
	local _LT_CoreEventDone = {  };
	function __core:RegisterCallback(event, callonce)
		if __F[event] == nil then
			if callonce == true then
				local _meta = { __callonce = true, };
				_LT_CoreCallbackRegistration[event] = _meta;
				__F[event] = function(self, event, ...)
					for _index = 1, #_meta do
						_F_privateSafeCall(_meta[_index], __core, event, ...);
					end
					_LT_CoreCallbackRegistration[event] = {  };
				end
			else
				local _meta = {  };
				_LT_CoreCallbackRegistration[event] = _meta;
				__F[event] = function(self, event, ...)
					for _index = 1, #_meta do
						_F_privateSafeCall(_meta[_index], __core, event, ...);
					end
				end
			end
		end
	end
	function __core:AliasCallback(event, alias)
		__F[alias] = __F[event];
		_LT_CoreCallbackRegistration[alias] = _LT_CoreCallbackRegistration[event];
	end
	function __core:AddCallback(event, func, noimmediate)
		local _meta = _LT_CoreCallbackRegistration[event];
		if _meta ~= nil then
			if noimmediate ~= false and _LT_CoreEventDone[event] == true then
				_F_privateSafeCall(func, __core, event, "...immediate call");
				if _meta.__callonce then
					return;
				end
			end
			local _num = #_meta;
			for _index = 1, _num do
				if _meta[_index] == func then
					return;
				end
			end
			_meta[_num + 1] = func;
		end
	end
	function __core:RemoveCallback(event, func)
		local _meta = _LT_CoreCallbackRegistration[event];
		if _meta ~= nil then
			for _index = #_meta, 1, -1 do
				if _meta[_index] == func then
					tremove(_meta, _index);
					break;
				end
			end
		end
	end
	function __core:FireEvent(event, ...)
		local _func = __F[event];
		if _func ~= nil then
			_F_privateSafeCall(_func, __core, event, ...);
		else
			_F_coreDebug("|cffff0000Unkown event :|r", event);
			_F_devOutputDebugStack();
		end
	end
	function __core:EventDone(event)
		_LT_CoreEventDone[event] = true;
		_F_coreDebug("|cffff7f00EDone|r", event);
	end
	function __core:IsDone(event)
		return _LT_CoreEventDone[event] == true;
	end
	--	Keep Shown
	__F.Hide = _F_noop;
	__F.SetShown = _F_noop;
	__F.SetParent = _F_noop;
	__F:Show();
	--	OnKey
	if __F.SetPropagateKeyboardInput ~= nil then
		__F:EnableKeyboard(true);
		__F:SetPropagateKeyboardInput(true);
	end
	__F:SetScript("OnKeyDown", function(self, key)
		local _func = __F["CORE_KEYDOWN"];
		if _func ~= nil then
			_F_privateSafeCall(_func, __core, "CORE_KEYDOWN", true);
		end
		if key == "ESCAPE" then
			local _func = __F["CORE_ESCAPEDOWN"];
			if _func ~= nil then
				_F_privateSafeCall(_func, __core, "CORE_ESCAPEDOWN", true);
			end
		end
	end);
	__F:SetScript("OnKeyUp", function(self, key)
		local _func = __F["CORE_KEYUP"];
		if _func ~= nil then
			_F_privateSafeCall(_func, __core, "CORE_KEYUP", false);
		end
		if key == "ESCAPE" then
			local _func = __F["CORE_ESCAPEUP"];
			if _func ~= nil then
				_F_privateSafeCall(_func, __core, "CORE_ESCAPEUP", false);
			end
		end
	end);
-->

-->		Widget Sample
	--	Frame
	local _LT_AllFrameTypes = {
		'FRAME',
			-- 'BROWSER',
			'BUTTON',
				'CHECKBUTTON',
				-- 'ITEMBUTTON',				--	XML defined.
			-- 'CHECKOUT',
			'COLORSELECT',
			'COOLDOWN',
			'EDITBOX',
			-- 'FOGOFWARFRAME',					--	no method Hide	for classic
			'GAMETOOLTIP',
			'MESSAGEFRAME',
			-- 'MINIMAP',
			'MODEL',
				'PLAYERMODEL',
					-- 'CINEMATICMODEL',
					'DRESSUPMODEL',
					'TABARDMODEL',
			-- 'MODELSCENE',
			-- 'MODELSCENEACTOR',
			'MOVIEFRAME',
			-- 'OFFSCREENFRAME',
			-- 'POIFARME',
				-- 'ARCHAEOLOGYDIGSITEFRAME',
				-- 'QUESTPOIFRAME',
				-- 'SCENARIOPOIFRAME',
			'SCROLLFRAME',
			'SCROLLINGMESSAGEFRAME',
			'SIMPLEHTML',
			'SLIDER',
			'STATUSBAR',
			-- 'UNITPOSITIONFRAME',
			-- 'WORLDFRAME'
	};
	if __namespace.__client._Type == "retail" then
		if __namespace.__client._Expansion >= 6 then
			for _, _Type in inext, {
				'BROWSER',
				'CHECKOUT',
				-- 'FOGOFWARFRAME',
				'CINEMATICMODEL',
				'MODELSCENE',
				'OFFSCREENFRAME',
				'ARCHAEOLOGYDIGSITEFRAME',
				'QUESTPOIFRAME',
				'SCENARIOPOIFRAME',
				'UNITPOSITIONFRAME',
			}, 0 do
				_LT_AllFrameTypes[#_LT_AllFrameTypes + 1] = _Type;
			end
		end
	else
		for _, _Type in inext, {
			'BROWSER',
			'CHECKOUT',
			-- 'FOGOFWARFRAME',
			'CINEMATICMODEL',
			'MODELSCENE',
			'OFFSCREENFRAME',
			'UNITPOSITIONFRAME',
		}, 0 do
			_LT_AllFrameTypes[#_LT_AllFrameTypes + 1] = _Type;
		end
	end
	local _T_coreFrameSample = {  };
	local _T_coreFrameMetaTable = {  };
	for _, _Type in next, _LT_AllFrameTypes do
		local _success, _Frame = _F_privateSafeCall(CreateFrame, _Type);
		if _success then
			if _Frame.Hide ~= nil then
				_Frame:Hide();
			end
			local _MetaTable = getmetatable(_Frame);
			if _MetaTable ~= nil and type(_MetaTable) == 'table' then
				_MetaTable = _MetaTable.__index;
				if _MetaTable ~= nil and type(_MetaTable) == 'table' then
					_T_coreFrameSample[_Type] = _Frame;
					_T_coreFrameMetaTable[_MetaTable] = true;
				end
			end
		end
	end
	__core._T_coreFrameSample = _T_coreFrameSample;
	__core._T_coreFrameMetaTable = _T_coreFrameMetaTable;
	--	Layer
	local _T_coreLayerSample = {  };
	local _T_coreLayerMetaTable = {  };
	local _Frame = __core._T_coreFrameSample['FRAME'];
	for _, _Type in next, { 'CreateFontString', 'CreateTexture', 'CreateMaskTexture', 'CreateLine', } do
		local _success, _Layer = _F_privateSafeCall(_Frame[_Type], _Frame, nil, "BACKGROUND");
		if _success then
			if _Layer.Hide ~= nil then
				_Layer:Hide();
			end
			local _MetaTable = getmetatable(_Layer);
			if _MetaTable ~= nil and type(_MetaTable) == 'table' then
				_MetaTable = _MetaTable.__index;
				if _MetaTable ~= nil and type(_MetaTable) == 'table' then
					_T_coreLayerSample[_Type] = _Layer;
					_T_coreLayerMetaTable[_MetaTable] = true;
				end
			end
		end
	end
	__core._T_coreLayerSample = _T_coreLayerSample;
	__core._T_coreLayerMetaTable = _T_coreLayerMetaTable;
	--	Other
	local _T_coreOtherSample = {  };
	local _T_coreOtherMetatable = {  };
	local _Font = CreateFont("__CORE_FONT_SAMPLE");
	local _MetaTable = getmetatable(_Font);
	if _MetaTable ~= nil and type(_MetaTable) == 'table' then
		_MetaTable = _MetaTable.__index;
		if _MetaTable ~= nil and type(_MetaTable) == 'table' then
			_T_coreOtherSample['FONT'] = _Font;
			_T_coreOtherMetatable[_MetaTable] = true;
		end
	end
	if _Frame.CreateAnimationGroup ~= nil then
		local _success, _AnimGroup = _F_privateSafeCall(_Frame.CreateAnimationGroup, _Frame);
		if _success then
			if _AnimGroup.Hide ~= nil then
				_AnimGroup:Hide();
			end
			local _MetaTable = getmetatable(_AnimGroup);
			if _MetaTable ~= nil and type(_MetaTable) == 'table' then
				_MetaTable = _MetaTable.__index;
				if _MetaTable ~= nil and type(_MetaTable) == 'table' then
					_T_coreOtherSample.CreateAnimationGroup = _AnimGroup;
					_T_coreOtherMetatable[_MetaTable] = true;
				end
			end
			for _, _Type in next, { 'Animation', 'Translation', 'Rotation', 'Alpha', 'Scale', 'ControlPoints', 'Path', } do
				local _success, _Obj = _F_privateSafeCall(_AnimGroup.CreateAnimation, _AnimGroup, _Type);
				if _success then
					local _MetaTable = getmetatable(_Obj);
					if _MetaTable ~= nil and type(_MetaTable) == 'table' then
						_MetaTable = _MetaTable.__index;
						if _MetaTable ~= nil and type(_MetaTable) == 'table' then
							_T_coreOtherSample['CreateAnimation_' .. _Type] = _Obj;
							_T_coreOtherMetatable[_MetaTable] = true;
						end
					end
				end
			end
			local _Path = _T_coreOtherSample['CreateAnimation_Path'];
			if _Path ~= nil then
				local _success, _ControlPoint = _F_privateSafeCall(_Path.CreateControlPoint, _Path);
				if _success then
					local _MetaTable = getmetatable(_ControlPoint);
					if _MetaTable ~= nil and type(_MetaTable) == 'table' then
						_MetaTable = _MetaTable.__index;
						if _MetaTable ~= nil and type(_MetaTable) == 'table' then
							_T_coreOtherSample['CreateControlPoint'] = _ControlPoint;
							_T_coreOtherMetatable[_MetaTable] = true;
						end
					end
				end
			end
		end
	end
	__core._T_coreOtherSample = _T_coreOtherSample;
	__core._T_coreOtherMetatable = _T_coreOtherMetatable;
	--	MODELSCENE:CreateActor()
-->

local __is_capturingAllEvents = false;
-->		Hook Event Register		--		Events Simulator.
	--
	local _LB_Capturing = false;
	local _LB_Simulating = false;
	local function _LF_UnsafeTriggerOnScript(frame, scriptType, ...)
		local handler = frame:GetScript(scriptType);
		if handler ~= nil then
			return handler(frame, ...);
		end
	end
	local function _LF_SafeTriggerOnScript(frame, scriptType, ...)
		local handler = frame:GetScript(scriptType);
		if handler ~= nil then
			return _F_privateSafeCall(handler, frame, ...);
		end
	end
	-->		All Events	--	Disabled By Default
		local _LT_AllRegistered_FramesEvents = {  };
		local _LT_AllRegistered_EventsFrames = {  };
		local function _LF_EventRegistered(self, event)
			local _events = _LT_AllRegistered_FramesEvents[self];
			if _events == nil then
				_events = { event, [event] = true, };
				_LT_AllRegistered_FramesEvents[self] = _events;
			elseif _events[event] ~= true then
				_events[#_events + 1] = event;
				_events[event] = true;
			end
			local _monitored = _LT_AllRegistered_EventsFrames[event];
			if _monitored == nil then
				_monitored = { self, [self] = true, };
				_LT_AllRegistered_EventsFrames[event] = _monitored;
			elseif _monitored[self] ~= true then
				_monitored[#_monitored + 1] = self;
				_monitored[self] = true;
			end
		end
		local function _LF_EventUnregistered(self, event)
			local _events = _LT_AllRegistered_FramesEvents[self];
			if _events ~= nil and _events[event] == true then
				for _index = #_events, 1, -1 do
					if _events[_index] == event then
						tremove(_events, _index);
						break;
					end
				end
				if #_events == 0 then
					_LT_AllRegistered_FramesEvents[self] = nil;
				else
					_events[event] = nil;
				end
			end
			local _monitored = _LT_AllRegistered_EventsFrames[event];
			if _monitored ~= nil and _monitored[self] == true then
				for _index = #_monitored, 1, -1 do
					if _monitored[_index] == self then
						tremove(_monitored, _index);
						break;
					end
				end
				if #_monitored == 0 then
					_LT_AllRegistered_EventsFrames[event] = nil;
				else
					_monitored[self] = nil;
				end
			end
		end
		local function _LF_AllEventsUnregistered(event)
			_LT_AllRegistered_FramesEvents[self] = nil;
			for _event, _monitored in next, _LT_AllRegistered_EventsFrames do
				if _monitored[self] == true then
					for _index = #_monitored, 1, -1 do
						if _monitored[_index] == self then
							tremove(_monitored, _index);
							break;
						end
					end
					if #_monitored == 0 then
						_LT_AllRegistered_EventsFrames[_event] = nil;
					else
						_monitored[self] = nil;
					end
				end
			end
		end
	-->
	local _LT_MonitoredEvents = {
		-- "ADDON_LOADED",
		"VARIABLES_LOADED",
		"PLAYER_LOGIN",
		"PLAYER_ENTERING_WORLD",
		"SPELLS_CHANGED",
		-- "PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
		"GROUP_ROSTER_UPDATE",
		-- "PLAYER_ALIVE",
		"PLAYER_DEAD",
		"WORLD_MAP_UPDATE",
		"QUEST_LOG_UPDATE",
		"UPDATE_FACTION",
		"LOADING_SCREEN_DISABLED",
		"NAME_PLATE_CREATED",
		"NAME_PLATE_UNIT_ADDED",
		"BAG_UPDATE",
		"BAG_UPDATE_DELAYED",
	};
	-->		Hook basic object
		local _LT_RegisteredToTrigger_FramesEvents = {  };
		for _index = 1, #_LT_MonitoredEvents do
			_LT_RegisteredToTrigger_FramesEvents[_LT_MonitoredEvents[_index]] = {  };
		end
		--
		local function _LF_OnFrameEventRegistered(self, event)
			if __is_capturingAllEvents then
				_LF_EventRegistered(self, event);
			end
			if _LB_Capturing then
				local _monitored = _LT_RegisteredToTrigger_FramesEvents[event];
				if _monitored ~= nil and _monitored[self] ~= true then
					_monitored[#_monitored + 1] = self;
					_monitored[self] = true;
				end
			end
		end
		local function _LF_OnFrameEventUnregistered(self, event)
			if __is_capturingAllEvents then
				_LF_EventUnregistered(self, event);
			end
			if _LB_Capturing then
				local _monitored = _LT_RegisteredToTrigger_FramesEvents[event];
				if _monitored ~= nil and _monitored[self] == true then
					for _index = #_monitored, 1, -1 do
						if _monitored[_index] == self then
							tremove(_monitored, _index);
							break;
						end
					end
					_monitored[self] = nil;
				end
			end
		end
		local function _LF_OnFrameAllEventsUnregistered(self)
			if __is_capturingAllEvents then
				_LF_AllEventsUnregistered(self);
			end
			if _LB_Capturing then
				for _event, _monitored in next, _LT_RegisteredToTrigger_FramesEvents do
					if _monitored[self] == true then
						for _index = #_monitored, 1, -1 do
							if _monitored[_index] == self then
								tremove(_monitored, _index);
								break;
							end
						end
						_monitored[self] = nil;
					end
				end
			end
		end
		--
		for _MetaTable, _ in next, __core._T_coreFrameMetaTable do
			if _MetaTable.RegisterEvent ~= nil and _MetaTable.IsEventRegistered ~= nil then
				_MetaTable._F_RegisterEvent = _MetaTable.RegisterEvent;
				_MetaTable._F_UnregisterEvent = _MetaTable.UnregisterEvent;
				_MetaTable._F_UnregisterAllEvents = _MetaTable.UnregisterAllEvents;
				_MetaTable._F_IsEventRegistered = _MetaTable.IsEventRegistered;
				hooksecurefunc(_MetaTable, "RegisterEvent", _LF_OnFrameEventRegistered);
				if _MetaTable.UnregisterEvent ~= nil then
					hooksecurefunc(_MetaTable, "UnregisterEvent", _LF_OnFrameEventUnregistered);
				end
				if _MetaTable.UnregisterAllEvents ~= nil then
					hooksecurefunc(_MetaTable, "UnregisterAllEvents", _LF_OnFrameAllEventsUnregistered);
				end
			end
		end
		--
		local function _LF_FlushFrameCaptureCache()
			for _event, _monitored in next, _LT_RegisteredToTrigger_FramesEvents do
				_LT_RegisteredToTrigger_FramesEvents[_event] = {  };
			end
		end
		local function _LF_SimulateBasicObjectEvent(event, ...)			--	Triger in order of "frame:Register"
			--	Donot flush. Cuz some events are triggered multiple times.
			local _monitored = _LT_RegisteredToTrigger_FramesEvents[event];
			if _monitored ~= nil then
				for _index = 1, #_monitored do
					local _Frame = _monitored[_index];
					_F_privateSafeCall(_LF_UnsafeTriggerOnScript, _Frame, "OnEvent", event, ...);
				end
			end
		end
	-->		Hook User-Defined Library
		local _LT_RegisteredToTrigger_LibraryFramesEvents = {  };	--	list and hash in one table
		local _LT_CallbackFlag_LibraryFramesEvents = {  };
		for _index = 1, #_LT_MonitoredEvents do
			_LT_RegisteredToTrigger_LibraryFramesEvents[_LT_MonitoredEvents[_index]] = {  };
		end
		--
		local function _F_coreSimulatorOnLibraryCallbackRegistered(libframe, event, func, arg)
			_LT_CallbackFlag_LibraryFramesEvents[libframe][event] = true;
		end
		__core._F_coreSimulatorOnLibraryCallbackRegistered = _F_coreSimulatorOnLibraryCallbackRegistered;
		--
		local function _LF_OnLibraryFrameEventRegistered(self, event)
			if __is_capturingAllEvents then
				_LF_EventRegistered(self, event);
			end
			local _monitored = _LT_RegisteredToTrigger_LibraryFramesEvents[event];
			if _monitored ~= nil and _monitored[self] ~= true then
				_monitored[#_monitored + 1] = self;
				_monitored[self] = true;
			end
		end
		local function _LF_OnLibraryFrameEventUnregistered(self, event)
			if __is_capturingAllEvents then
				_LF_EventUnregistered(self, event);
			end
			local _monitored = _LT_RegisteredToTrigger_LibraryFramesEvents[event];
			if _monitored ~= nil and _monitored[self] == true then
				for _index = #_monitored, 1, -1 do
					if _monitored[_index] == self then
						tremove(_monitored, _index);
						break;
					end
				end
				_monitored[self] = nil;
			end
		end
		local function _LF_OnLibraryFrameAllEventsUnregistered(self)
			if __is_capturingAllEvents then
				_LF_AllEventsUnregistered(self);
			end
			for _event, _monitored in next, _LT_RegisteredToTrigger_LibraryFramesEvents do
				if _monitored[self] == true then
					for _index = #_monitored, 1, -1 do
						if _monitored[_index] == self then
							tremove(_monitored, _index);
							break;
						end
					end
					_monitored[self] = nil;
				end
			end
		end
		--
		local _LT_HandlerOnNewLibrary = {  };
		local _LT_LibraryHookingStore = {  };
		local _orig_LibStubNewLibrary = LibStub.NewLibrary;
		function LibStub:NewLibrary(major, minor)
			local _lib, _oldminor = _orig_LibStubNewLibrary(LibStub, major, minor);
			if _LT_HandlerOnNewLibrary[major] ~= nil then
				_F_privateSafeCall(_LT_HandlerOnNewLibrary[major], major, minor, _lib, _LT_LibraryHookingStore);
			end
			return _lib, _oldminor;
		end
		local function _F_coreSimulatorMonitorLibrary(libname, handler)
			_LT_HandlerOnNewLibrary[libname] = handler;
		end
		__core._F_coreSimulatorMonitorLibrary = _F_coreSimulatorMonitorLibrary;
		--
		local _LT_FramesOfAllLibraries = {  };						--	nouse, just save a copy of pointer
		local _LT_LibraryFramesHooked = {  };
		local function _F_coreSimulatorHookLibraryFrame(libname, libframe)
			if _LT_LibraryFramesHooked[libframe] == nil and libframe.RegisterEvent ~= nil then
				_LT_LibraryFramesHooked[libframe] = libname;
				if libframe._F_RegisterEvent ~= nil then
					libframe.RegisterEvent = libframe._F_RegisterEvent;
				end
				if libframe._F_UnregisterEvent ~= nil then
					libframe.UnregisterEvent = libframe._F_UnregisterEvent;
				end
				if libframe.UnregisterAllEvents ~= nil then
					libframe.UnregisterAllEvents = libframe._F_UnregisterAllEvents;
				end
				if libframe.IsEventRegistered ~= nil then
					libframe.IsEventRegistered = libframe._F_IsEventRegistered;
				end
				_LT_FramesOfAllLibraries[libname] = libframe;
				_LT_CallbackFlag_LibraryFramesEvents[libframe] = {  };
				hooksecurefunc(libframe, "RegisterEvent", _LF_OnLibraryFrameEventRegistered);
				if libframe.UnregisterEvent ~= nil then
					hooksecurefunc(libframe, "UnregisterEvent", _LF_OnLibraryFrameEventUnregistered);
				end
				if libframe.UnregisterAllEvents ~= nil then
					hooksecurefunc(libframe, "UnregisterAllEvents", _LF_OnLibraryFrameAllEventsUnregistered);
				end
				return true;
			end
			return false;
		end
		__core._F_coreSimulatorHookLibraryFrame = _F_coreSimulatorHookLibraryFrame;
		--
		local function _LF_FlushLibraryFrameCaptureCache()
			for _libframe, _monitored in next, _LT_CallbackFlag_LibraryFramesEvents do
				_monitored[_libframe] = {  };
			end
		end
		local function _LF_SimulateLibraryEvent(event, ...)				--	Triger in order of "frame:Register"
			local _monitored = _LT_RegisteredToTrigger_LibraryFramesEvents[event];
			if _monitored ~= nil then
				for _index = 1, #_monitored do
					local _libframe = _monitored[_index];
					local _libTable = _LT_CallbackFlag_LibraryFramesEvents[_libframe];
					if _libTable ~= nil and _libTable[event] == true then
						_F_privateSafeCall(_LF_UnsafeTriggerOnScript, _libframe, "OnEvent", event, ...);
						_libTable[event] = nil;
					end
				end
			end
		end
	-->
		local function _F_SimulateEvent(event, ...)
			_LF_SimulateLibraryEvent(event, ...);
			_LF_SimulateBasicObjectEvent(event, ...);
		end
		__core._F_SimulateEvent = _F_SimulateEvent;
		function __core._F_coreSimulatorStartCapturing()
			_LF_FlushFrameCaptureCache();
			_LF_FlushLibraryFrameCaptureCache();
			_LB_Capturing = true;
		end
		function __core._F_coreSimulatorStopCapturing()
			_LB_Capturing = false;
		end
		function __core._F_coreSimulatorResumeCapturing()
			_LB_Capturing = true;
		end
		function __core._F_coreSimulatorPauseCapturing()
			_LB_Capturing = false;
		end
		function __core._F_coreSimulatorLoadingEvents(beforeLogin)
			_LB_Simulating = true;
			_F_SimulateEvent("VARIABLES_LOADED");
			_F_SimulateEvent("PLAYER_LOGIN");
			if not beforeLogin then
				_F_SimulateEvent("PLAYER_ENTERING_WORLD", true, false);
				_F_SimulateEvent("LOADING_SCREEN_DISABLED");
				_F_SimulateEvent("UPDATE_FACTION");
				_F_SimulateEvent("SPELLS_CHANGED");
				_F_SimulateEvent("WORLD_MAP_UPDATE");
				_F_SimulateEvent("QUEST_LOG_UPDATE");
				if UnitIsDeadOrGhost('player') then
					_F_SimulateEvent("PLAYER_DEAD");
				end
				if not InCombatLockdown() then
					_F_SimulateEvent("PLAYER_REGEN_ENABLED");
				end
				if GetNumGroupMembers() > 0 then
					_F_SimulateEvent("GROUP_ROSTER_UPDATE");
				end
				local _index = 1;
				while true do
					local _frame = _G["NamePlate" .. _index];
					if _frame == nil then
						break;
					end
					_index = _index + 1;
					_F_SimulateEvent("NAME_PLATE_CREATED", _frame);
				end
				for _index2 = 1, _index do
					local _unit = 'nameplate' .. _index2;
					if UnitExists(_unit) and C_NamePlate_GetNamePlateForUnit(_unit) ~= nil then
						_F_SimulateEvent("NAME_PLATE_UNIT_ADDED", _unit);
					end
				end
				_F_SimulateEvent("BAG_UPDATE", 1);
				_F_SimulateEvent("BAG_UPDATE", 2);
				_F_SimulateEvent("BAG_UPDATE", 3);
				_F_SimulateEvent("BAG_UPDATE", 4);
				_F_SimulateEvent("BAG_UPDATE", 5);
				_F_SimulateEvent("BAG_UPDATE", 6);
				_F_SimulateEvent("BAG_UPDATE", 7);
				_F_SimulateEvent("BAG_UPDATE", 8);
				_F_SimulateEvent("BAG_UPDATE", 9);
				_F_SimulateEvent("BAG_UPDATE", 10);
				_F_SimulateEvent("BAG_UPDATE", 11);
				_F_SimulateEvent("BAG_UPDATE", 0);
				_F_SimulateEvent("BAG_UPDATE", -2);
				_F_SimulateEvent("BAG_UPDATE_DELAYED");
			end
			_LB_Simulating = false;
		end
	-->
-->

-->		Register Known Libs
	--	AceAddon-3.0
	__core._F_coreSimulatorMonitorLibrary(
		"AceAddon-3.0",
		function(libname, version, _Lib, Store)
			if _Lib == nil then
				return;
			end
			local _store = Store["AceAddon-3.0"];
			if _store == nil then
				_store = {  };
				Store["AceAddon-3.0"] = _store;
			end
			local _Frame = _Lib.frame;
			if _Frame == nil then
				_Frame = CreateFrame('FRAME', "AceAddon30Frame");
				_Lib.frame = _Frame;
			end
			local _SetScript = _Frame.SetScript;
			-- print("|cff00ff00AceAddon-3.0-SetScript-0|r", _SetScript, _store.SetScript2);
			if _SetScript ~= nil and _SetScript ~= _store.SetScript2 then
				-- print("|cff00ff00AceAddon-3.0-SetScript-1|r", _Frame.SetScript);
				function _Frame:SetScript(method, func)
					-- print(method);
					if method == "OnEvent" then
						_F_coreSimulatorHookLibraryFrame(libname, _Frame);
						_LF_OnLibraryFrameEventRegistered(_Frame, "ADDON_LOADED");
						_LF_OnLibraryFrameEventRegistered(_Frame, "PLAYER_LOGIN");
						local _NewAddon = _Lib.NewAddon;
						-- print("|cff007fffAceAddon-3.0-NewAddon-0|r", _Lib.NewAddon, _store.NewAddon2);
						if _NewAddon ~= nil and _NewAddon ~= _store.NewAddon2 then
							-- print("|cff007fffAceAddon-3.0-NewAddon-1|r", _Lib.NewAddon);
							hooksecurefunc(_Lib, "NewAddon", function(arg1)
								-- print("AceAddon-3.0-NewAddon", arg1); _F_devOutputDebugStack();
								if _LB_Capturing or _LB_Simulating then
									_F_coreSimulatorOnLibraryCallbackRegistered(_Frame, "PLAYER_LOGIN");
								end
							end);
							_store.NewAddon2 = _Lib.NewAddon;
							-- print("|cff007fffAceAddon-3.0-NewAddon-2|r", _Lib.NewAddon);
						end
						local _enablequeue = {  };
						local _EnableAddon = _Lib.EnableAddon;
						-- print("|cffff7f00AceAddon-3.0-EnableAddon-0|r", _Lib.EnableAddon, _store.EnableAddon2);
						if _EnableAddon ~= nil and _EnableAddon ~= _store.EnableAddon2 then
							-- print("|cffff7f00AceAddon-3.0-EnableAddon-1|r", _Lib.EnableAddon);
							function _Lib:EnableAddon(addon)
								-- print(_LB_Capturing, "AceAddon-3.0:EnableAddon", addon);
								if _LB_Capturing then
									if _enablequeue[addon] == nil then
										_enablequeue[#_enablequeue + 1] = addon;
									end
								else
									_EnableAddon(_Lib, addon);
								end
							end
							_store.EnableAddon2 = _Lib.EnableAddon;
							-- print("|cffff7f00AceAddon-3.0-EnableAddon-2|r", _Lib.EnableAddon);
						end
						_SetScript(_Frame, "OnEvent", function(self, event, ...)
							if event == "PLAYER_LOGIN" and _enablequeue[1] ~= nil then
								local __enablequeue = _Lib.enablequeue;
								if __enablequeue ~= nil and __enablequeue[1] ~= nil then
									for _index = 1, #__enablequeue do
										local _addon = __enablequeue[_index];
										if _enablequeue[_addon] == nil then
											_enablequeue[#_enablequeue + 1] = _addon;
										end
									end
								end
								_Lib.enablequeue = _enablequeue;
								_enablequeue = {  };
							end
							func(self, event, ...);
						end);
					else
						_SetScript(_Frame, method, func);
					end
				end
				_store.SetScript2 = _Frame.SetScript;
				-- print("|cff00ff00AceAddon-3.0-SetScript-2|r", _Frame.SetScript);
			end
		end
	);
	--	AceEvent-3.0
	__core._F_coreSimulatorMonitorLibrary(
		"AceEvent-3.0",
		function(libname, version, _Lib, Store)
			if _Lib == nil then
				return;
			end
			local _store = Store["AceEvent-3.0"];
			if _store == nil then
				_store = {  };
				Store["AceEvent-3.0"] = _store;
			end
			local _Frame = _Lib.frame;
			if _Frame == nil then
				_Frame = CreateFrame('FRAME', "AceEvent30Frame");
				_Lib.frame = _Frame;
			end
			local _SetScript = _Frame.SetScript;
			-- print("|cff00ff00AceEvent-3.0-SetScript-0|r", _SetScript, _store.SetScript2);
			if _SetScript ~= nil and _SetScript ~= _store.SetScript2 then
				-- print("|cff00ff00AceEvent-3.0-SetScript-1|r", _Frame.SetScript);
				function _Frame:SetScript(method, func)
					if method == "OnEvent" then
						_F_coreSimulatorHookLibraryFrame(libname, _Frame);
						local _registry = _Lib.events;
						if _registry ~= nil then
							local _events = _registry.events;
							if _events ~= nil then
								local _RegisterEvent = _Lib.RegisterEvent;
								-- print("|cffff007fAceEvent-3.0-RegisterEvent-0|r", _RegisterEvent, _store.RegisterEvent2);
								if _RegisterEvent ~= nil and _RegisterEvent ~= _store.RegisterEvent2 then
									-- print("|cffff007fAceEvent-3.0-RegisterEvent-1|r", _Lib.RegisterEvent);
									hooksecurefunc(_Lib, "RegisterEvent", function(self, event, func, arg)
										if _LB_Capturing or _LB_Simulating then
											local _tbl = rawget(_events, event);
											if _tbl ~= nil and _tbl[self] ~= nil then
												_F_coreSimulatorOnLibraryCallbackRegistered(_Frame, event, func);
											end
										end
									end);
									_store.RegisterEvent2 = _Lib.RegisterEvent;
									-- print("|cffff007fAceEvent-3.0-RegisterEvent-2|r", _Lib.RegisterEvent);
								end
							end
						end
					end
					_SetScript(_Frame, method, func);
				end
				_store.SetScript2 = _Frame.SetScript;
				-- print("|cff00ff00SetScript-2|r", _Frame.SetScript);
			end
		end
	);
	--	LibEvent.7000
	__core._F_coreSimulatorMonitorLibrary(
		"LibEvent.7000",
		function(libname, version, _Lib, Store)
			local _new = _Lib ~= nil;
			_Lib = _Lib or LibStub:GetLibrary("LibEvent.7000", true);
			if _Lib == nil then
				return;
			end
			local _store = Store["LibEvent.7000"];
			if _store == nil then
				_store = {  };
				Store["LibEvent.7000"] = _store;
			end
			local _Frame = _store.FakeFrame;
			if _Frame == nil then
				local _Frame = {
					_FakeTo = "LibEvent.7000",
					GetScript = function()
						return _Lib.event;
					end
				};
				_LT_CallbackFlag_LibraryFramesEvents[_Frame] = {  };
				_store.FakeFrame = _Frame;
				if _new then
					-- print("|cffff007fLibEvent.7000-New|r")
					for _index = 1, #_LT_MonitoredEvents do
						_F_coreSimulatorOnLibraryCallbackRegistered(_Frame, _LT_MonitoredEvents[_index]);
					end
				end
			end
			local _addEventListener = _Lib.addEventListener;
			-- print("|cffff007fLibEvent.7000-addEventListener-0|r", _addEventListener, _store.addEventListener2);
			if _addEventListener ~= nil and _addEventListener ~= _store.addEventListener2 then
				-- print("|cffff007fLibEvent.7000-addEventListener-1|r", _Lib.addEventListener);
				hooksecurefunc(_Lib, "addEventListener", function(self, eventslist, func)
					if _LB_Capturing or _LB_Simulating then
						for event in gmatch(eventslist, "([^,%s]+)") do
							_LF_OnLibraryFrameEventRegistered(_Frame, event);
							_F_coreSimulatorOnLibraryCallbackRegistered(_Frame, event, func);
							-- print(event)
						end
					end
				end);
				_Lib.attachEvent = _Lib.addEventListener;
				_store.addEventListener2 = _Lib.addEventListener;
				-- print("|cffff007fLibEvent.7000-addEventListener-2|r", _Lib.addEventListener);
			end
		end
	);
-->

-->		Locale Builder
	local _LT_LocaleMetatable = {
		__newindex = function(tbl, key, val)
			if val == true then
				rawset(tbl, key, key);
			else
				rawset(tbl, key, val);
			end
		end,
		__index = function(tbl, key)
			return key;
		end,
		__call = function(tbl, key)
			return rawget(tbl, key) or key;
		end,
	};
	function __core._F_coreLocaleNew()
		return setmetatable(
			{
				IsObjectType = false,
				GetName = false,
				GetDebugName = false,
				GetParent = false,
				GetChildren = false,
				GetRegions = false,
				GetPoint = false,
				SetShown = false,
				Show = false,
				Hide = false,
				IsShown = false,
			},			--	/tinspect
			_LT_LocaleMetatable
		);
	end
-->

if __namespace.__client._Type == "retail" and __namespace.__client._Expansion < 4 then
	seterrorhandler(__core._F_devOutputDebugStack);
end

__core:RegisterCallback("CORE_INITIALIZED", true);			--	func(core, event)					--	ADDON_LOADED(__addon);	after __oninit
__core:RegisterCallback("CORE_GAME_LOADED", true);			--	func(core, event)					--	after CORE_INITIALIZED, VARIABLES_LOADED, PLAYER_LOGIN, PLAYER_ENTERING_WORLD and LOADING_SCREEN_DISABLED
__core:RegisterCallback("ADDON_STATE_INITIALIZED", true);	--	func(core, event)					--	after CORE_INITIALIZED and setting state of all addons
__core:RegisterCallback("CORE_LOAD_FINISHED", true);		--	func(core, event)					--	after CORE_GAME_LOADED and ADDON_STATE_INITIALIZED
__core:RegisterCallback("CORE_PRE_ADDON_LOADED");			--	func(core, event, addon:lower())	--	before any other ADDON_LOADED
__core:RegisterCallback("CORE_POST_ADDON_LOADED");			--	func(core, event, addon:lower())	--	if loaded by core, fired after simulating events. otherwise fired after LoadAddOn
__core:RegisterCallback("CORE_ADDON_TOGGLE");				--	func(core, event, addon, enabled)	--	
__core:RegisterCallback("CORE_KEYDOWN");					--	func(core, event, key, pressed)		--	
__core:RegisterCallback("CORE_KEYUP");						--	func(core, event, key, pressed)		--	
__core:RegisterCallback("CORE_ESCAPEDOWN");					--	func(core, event, pressed)			--	
__core:RegisterCallback("CORE_ESCAPEUP");					--	func(core, event, pressed)			--	
__core:RegisterCallback("UI_TAG_SELECTED");					--	func(core, event, tag)				--	
__core:RegisterCallback("UI_ADDON_SELECTED");				--	func(core, event, addon[, index])	--	
__core:RegisterCallback("UI_REFRESH_TAG_LIST");				--	func(core, event[, param])			--	只刷新标签列表，不做数据更新
__core:RegisterCallback("UI_REFRESH_ADDON_LIST");			--	func(core, event[, param])			--	只刷新插件列表，不做数据更新
__core:RegisterCallback("UI_CONFIG_UPDATE");				--	func(core, event)					--	
__core:RegisterCallback("PROFILE_LIST");					--	func(core, event, flag)				--	
__core:RegisterCallback("SCRIPT_LIST");						--	func(core, event, isGlobal, category)	--	

__core._T_addonList = {  };
__core._T_addonInfo = {  };

__core:AddCallback(
	"CORE_GAME_LOADED",
	function(core, event)
		_F_coreDebug("CORE_GAME_LOADED", __core:IsDone("ADDON_STATE_INITIALIZED"));
		if __core:IsDone("ADDON_STATE_INITIALIZED") then
			__core:FireEvent("CORE_LOAD_FINISHED");
			__core:EventDone("CORE_LOAD_FINISHED");
			_F_coreDebug("|cff00ff00CORE_LOAD_FINISHED|r ~1");
		end
	end
);
__core:AddCallback(
	"ADDON_STATE_INITIALIZED",
	function(core, event)
		_F_coreDebug("ADDON_STATE_INITIALIZED", __core:IsDone("CORE_GAME_LOADED"));
		if __core:IsDone("CORE_GAME_LOADED") then
			__core:FireEvent("CORE_LOAD_FINISHED");
			__core:EventDone("CORE_LOAD_FINISHED");
			_F_coreDebug("|cff00ff00CORE_LOAD_FINISHED|r ~2");
		end
	end
);

__namespace.__subfolder[strlower(__addon)] = true;

if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._1core", __core._F_devDebugProfileTick("*"));
end
