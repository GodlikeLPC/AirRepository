--[=[
	FUNCTION
--]=]
--[====[
	--	function		-->		Internal method without parameters check
	--
							__core._F_metaSheduleSimpleTimerOnce					(period, func)							--	C_Timer.After
							__core._F_metaSheduleSimpleTimer						(period, func)							--
		timer			=	__core._F_metaSheduleTimerArgsv							(repeating, period, func, ...)			--	func(...)
		timer			=	__core._F_metaSheduleTimerArgsvOnce						(period, func, ...)						--	func(...)
							__core._F_metaCancelTimerArgsv							(timer)
		timer			=	__core._F_metaSheduleNamedTimerArgsv					(name, repeating, period, func, ...)	--	func(...)
		timer			=	__core._F_metaSheduleNamedTimerArgsvOnce				(name, period, func, ...)				--	func(...)
							__core._F_metaCancelNamedTimerArgsv						(name)

		func			=	__core._F_metaRunOnNextFrame							(func, mutex)							--	func()
							__core._F_metaRunOnNextFrameCancel						(func)
		call			=	__core._F_metaRunOnNextFrameArgsv						(func, ...)								--	func(...)
							__core._F_metaRunOnNextFrameArgsvCancel					(call)
		func			=	__core._F_metaRunOnNextFrameNamed						(name, func)							--	func()
							__core._F_metaRunOnNextFrameNamedCancel					(name)
		call			=	__core._F_metaRunOnNextFrameNamedArgsv					(name, func, ...)						--	func(...)
							__core._F_metaRunOnNextFrameNamedArgsvCancel			(name)

							__core._F_metaOnEvent									(event, func)							--	func(event, ...)
							__core._F_metaOnEventCancel								(event, func)
							__core._F_metaOnEventOnce								(event, func)							--	func(event, ...)
							__core._F_metaOnEventOnceCancel							(event, func)
		call			=	__core._F_metaLimittedOnEvent							(event, interval, func)					--	func(event, ...)
							__core._F_metaLimittedOnEventCancel						(event, call or func)
		call			=	__core._F_metaLimittedOnEventBucketNamed				(key, interval, func, override, events...)	--	func(event)
							__core._F_metaLimittedOnEventBucketNamedCancel			(key)
							__core._F_metaDependCall								(addon, func, ...)						--	func(...)
		call			=	__core._F_metaLeaveCombatCall							(func, ...)								--	func(...)
		call			=	__core._F_metaLeaveCombatCallImmediate					(func, ...)								--	func(...)
							__core._F_metaLeaveCombatCallCancel						(call)
		call			=	__core._F_metaLeaveCombatCallOnce						(func, ...)								--	func(...)
		call			=	__core._F_metaLeaveCombatCallOnceImmediate				(func, ...)								--	func(...)
							__core._F_metaLeaveCombatCallOnceCancel					(call)
		call			=	__core._F_metaEnterCombatCall							(func, ...)								--	func(...)
							__core._F_metaEnterCombatCallCancel						(call)
		call			=	__core._F_metaEnterCombatCallOnce						(func, ...)								--	func(...)
							__core._F_metaEnterCombatCallOnceCancel					(call)
							__core._F_metaHideOnPetBattle							(frame)									--		TOC > 60000

							__core._F_metaWithAllChatFrame							(func, ...)
							__core._F_metaWithAllChatFrameIgnore2					(func, ...)
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__nsconfig;
local __addon = __private.__addon;

local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._2function");
end

local _F_metaSafeCall = __core._F_metaSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------

-->		upvalue
local issecurevariable = issecurevariable;
local select = select;
local next, unpack = next, unpack;
local tremove = table.remove;
local strlower = string.lower;
local C_Timer_After = C_Timer.After;
local CreateFrame = CreateFrame;
local GetTime = GetTime;
local IsAddOnLoaded = IsAddOnLoaded;
local InCombatLockdown = InCombatLockdown;
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo;
local _G = _G;
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared._2function");
end


-->		Dispatcher
	--	Timer
		local _F_metaSheduleSimpleTimerOnce = C_Timer_After;
		local function _F_metaSheduleSimpleTimer(period, callback)
			local _func = nil;
			_func = function()
				callback();
				_F_metaSheduleTimerOnce(period, _func);
			end
			_F_metaSheduleTimerOnce(period, _func);
		end
		local function _F_metaSheduleTimerArgsv(repeating, period, func, ...)
			if func == nil then __core._F_devOutputDebugStack(); end
			if period < 0.01 then
				period = 0.01;
			end
			local _nargs = select('#', ...);
			local _timer = {
				_alive = true,
				...
			};
			if repeating then
				local _func = nil;
				_func = function()
					if _timer._alive then
						func(unpack(_timer, 1, _nargs));
						_F_metaSheduleSimpleTimerOnce(period, _func);
					end
				end
				_F_metaSheduleSimpleTimerOnce(period, _func);
				_timer._func = _func;
			else
				local function _func()
					if _timer._alive then
						func(unpack(_timer, 1, _nargs));
					end
				end
				_F_metaSheduleSimpleTimerOnce(period, _func);
				_timer._func = _func;
			end
			return _timer;
		end
		local function _F_metaSheduleTimerArgsvOnce(period, func, ...)
			return _F_metaSheduleTimerArgsv(false, period, func, ...);
		end
		local function _F_metaCancelTimerArgsv(_timer)
			_timer._alive = false;
		end
		__core._F_metaSheduleTimerArgsv = _F_metaSheduleTimerArgsv;
		__core._F_metaSheduleTimerArgsvOnce = _F_metaSheduleTimerArgsvOnce;
		__core._F_metaCancelTimerArgsv = _F_metaCancelTimerArgsv;
		local _LT_NamedTimers = {  };
		local function _F_metaSheduleNamedTimerArgsv(name, repeating, period, func, ...)
			local _timer = _LT_NamedTimers[name];
			if _timer ~= nil then
				_timer._alive = false;
			end
			_timer = _F_metaSheduleTimerArgsv(repeating, period, func, ...);
			_LT_NamedTimers[name] = _timer;
			return _timer;
		end
		local function _F_metaSheduleNamedTimerArgsvOnce(name, period, func, ...)
			return _F_metaSheduleNamedTimerArgsv(name, false, period, func, ...)
		end
		local function _F_metaCancelNamedTimerArgsv(name)
			local _timer = _LT_NamedTimers[name];
			if _timer ~= nil then
				_timer._alive = false;
			end
		end
		__core._F_metaSheduleNamedTimerArgsv = _F_metaSheduleNamedTimerArgsv;
		__core._F_metaSheduleNamedTimerArgsvOnce = _F_metaSheduleNamedTimerArgsvOnce;
		__core._F_metaCancelNamedTimerArgsv = _F_metaCancelNamedTimerArgsv;
	--
	local __EventHandler = CreateFrame('FRAME');
	--	OnUpdate
		local _LN_RunOnNextFrameCalls = 0;
		local _LT_RunOnNextFrameCalls = {  };
		local function _F_metaRunOnNextFrame(func, mutex)
			if mutex then
				for _index = 1, _LN_RunOnNextFrameCalls do
					if _LT_RunOnNextFrameCalls[_index] == func then
						return nil;
					end
				end
			end
			_LN_RunOnNextFrameCalls = _LN_RunOnNextFrameCalls + 1;
			_LT_RunOnNextFrameCalls[_LN_RunOnNextFrameCalls] = func;
			return func;
		end
		local function _F_metaRunOnNextFrameCancel(func)
			if _LT_RunOnNextFrameCalls[_LN_RunOnNextFrameCalls] == func then
				_LT_RunOnNextFrameCalls[_LN_RunOnNextFrameCalls] = nil;
				_LN_RunOnNextFrameCalls = _LN_RunOnNextFrameCalls - 1;
			elseif _LN_RunOnNextFrameCalls > 1 then
				for _index = _LN_RunOnNextFrameCalls - 1, 1, -1 do
					if _LT_RunOnNextFrameCalls[_index] == func then
						tremove(_LT_RunOnNextFrameCalls, _index);
						_LN_RunOnNextFrameCalls = _LN_RunOnNextFrameCalls - 1;
						break;
					end
				end
			end
		end
		__core._F_metaRunOnNextFrame = _F_metaRunOnNextFrame;
		__core._F_metaRunOnNextFrameCancel = _F_metaRunOnNextFrameCancel;
		--
		local _LN_RunOnNextFrameArgsvCalls = 0;
		local _LT_RunOnNextFrameArgsvCalls = {  };
		local function _F_metaRunOnNextFrameArgsv(func, ...)
			_LN_RunOnNextFrameArgsvCalls = _LN_RunOnNextFrameArgsvCalls + 1;
			local _call = { func, select('#', ...) + 2, ..., };
			_LT_RunOnNextFrameArgsvCalls[#_LT_RunOnNextFrameArgsvCalls + 1] = _call;
			return _call;
		end
		local function _F_metaRunOnNextFrameArgsvCancel(call)
			if _LT_RunOnNextFrameArgsvCalls[_LN_RunOnNextFrameArgsvCalls] == call then
				_LT_RunOnNextFrameArgsvCalls[_LN_RunOnNextFrameArgsvCalls] = nil;
				_LN_RunOnNextFrameArgsvCalls = _LN_RunOnNextFrameArgsvCalls - 1;
			elseif _LN_RunOnNextFrameArgsvCalls > 1 then
				for _index = _LN_RunOnNextFrameArgsvCalls - 1, 1, -1 do
					if _LT_RunOnNextFrameArgsvCalls[_index] == call then
						_LN_RunOnNextFrameArgsvCalls = _LN_RunOnNextFrameArgsvCalls - 1;
						tremove(_LT_RunOnNextFrameArgsvCalls, _index);
						break;
					end
				end
			end
		end
		__core._F_metaRunOnNextFrameArgsv = _F_metaRunOnNextFrameArgsv;
		__core._F_metaRunOnNextFrameArgsvCancel = _F_metaRunOnNextFrameArgsvCancel;
		--
		local _LN_RunOnNextFrameNamedCalls = 0;
		local _LT_RunOnNextFrameNamedCalls = {  };
		local function _F_metaRunOnNextFrameNamed(name, func)
			_LN_RunOnNextFrameNamedCalls = _LN_RunOnNextFrameNamedCalls + 1;
			_LT_RunOnNextFrameNamedCalls[name] = func;
			return func;
		end
		local function _F_metaRunOnNextFrameNamedCancel(name)
			if _LT_RunOnNextFrameNamedCalls[name] ~= nil then
				_LN_RunOnNextFrameNamedCalls = _LN_RunOnNextFrameNamedCalls - 1;
				_LT_RunOnNextFrameNamedCalls[name] = nil;
			end
		end
		__core._F_metaRunOnNextFrameNamed = _F_metaRunOnNextFrameNamed;
		__core._F_metaRunOnNextFrameNamedCancel = _F_metaRunOnNextFrameNamedCancel;
		--
		local _LN_RunOnNextFrameNamedArgsvCalls = 0;
		local _LT_RunOnNextFrameNamedArgsvCalls = {  };
		local function _F_metaRunOnNextFrameNamedArgsv(name, func, ...)
			_LN_RunOnNextFrameNamedArgsvCalls = _LN_RunOnNextFrameNamedArgsvCalls + 1;
			local _call = { func, select('#', ...) + 2, ..., };
			_LT_RunOnNextFrameNamedArgsvCalls[name] = _call;
			return _call;
		end
		local function _F_metaRunOnNextFrameNamedArgsvCancel(name)
			if _LT_RunOnNextFrameNamedArgsvCalls[name] ~= nil then
				_LN_RunOnNextFrameNamedArgsvCalls = _LN_RunOnNextFrameNamedArgsvCalls - 1;
				_LT_RunOnNextFrameNamedArgsvCalls[name] = nil;
			end
		end
		__core._F_metaRunOnNextFrameNamedArgsv = _F_metaRunOnNextFrameNamedArgsv;
		__core._F_metaRunOnNextFrameNamedArgsvCancel = _F_metaRunOnNextFrameNamedArgsvCancel;
		--
		local function _LF__EventHandler_OnUpdate(self, elasped)
			if _LN_RunOnNextFrameCalls > 0 then
				local _num = _LN_RunOnNextFrameCalls;
				local _calls = _LT_RunOnNextFrameCalls;
				_LN_RunOnNextFrameCalls = 0;
				_LT_RunOnNextFrameCalls = {  };
				for _index = 1, _num do
					_F_metaSafeCall(_calls[_index]);
				end
			end
			if _LN_RunOnNextFrameArgsvCalls > 0 then
				local _num = _LN_RunOnNextFrameArgsvCalls;
				local _calls = _LT_RunOnNextFrameArgsvCalls;
				_LN_RunOnNextFrameArgsvCalls = 0;
				_LT_RunOnNextFrameArgsvCalls = {  };
				for _index = 1, _num do
					local _call = _calls[_index];
					_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
				end
			end
			if _LN_RunOnNextFrameNamedCalls > 0 then
				local _calls = _LT_RunOnNextFrameNamedCalls;
				_LN_RunOnNextFrameNamedCalls = 0;
				_LT_RunOnNextFrameNamedCalls = {  };
				for _name, _call in next, _calls do
					_F_metaSafeCall(_call);
				end
			end
			if _LN_RunOnNextFrameNamedArgsvCalls > 0 then
				local _calls = _LT_RunOnNextFrameNamedArgsvCalls;
				_LN_RunOnNextFrameNamedArgsvCalls = 0;
				_LT_RunOnNextFrameNamedArgsvCalls = {  };
				for _name, _call in next, _calls do
					_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
				end
			end
		end
		__EventHandler:SetScript("OnUpdate", _LF__EventHandler_OnUpdate);
	--
	--	OnEvent
		local _LT_EventCalls = {  };
		local _LT_EventCallsOnce = {  };
		local function _F_metaOnEvent(event, func)
			local _cbs = _LT_EventCalls[event];
			if _cbs == nil then
				__EventHandler:RegisterEvent(event);
				_cbs = { func, };
				_LT_EventCalls[event] = _cbs;
			else
				local _num = #_cbs;
				for _index = 1, _num do
					if _cbs[_index] == func then
						return;
					end
				end
				_cbs[_num + 1] = func;
			end
		end
		local function _F_metaOnEventCancel(event, func)
			local _cbs = _LT_EventCalls[event];
			if _cbs ~= nil then
				local _num = #_cbs;
				if _cbs[_num] == func then
					if _num == 1 then
						__EventHandler:UnregisterEvent(event);
						_LT_EventCalls[event] = nil;
					else
						_cbs[_num] = nil;
					end
				elseif _num > 1 then
					for _index = _num - 1, 1, -1 do
						if _cbs[_index] == func then
							tremove(_cbs, _index);
							break;
						end
					end
				end
			end
		end
		local function _F_metaOnEventOnce(event, func)
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos == nil then
				__EventHandler:RegisterEvent(event);
				_cbos = { func, };
				_LT_EventCallsOnce[event] = _cbos;
			else
				local _num = #_cbos;
				for _index = 1, _num do
					if _cbos[_index] == func then
						return;
					end
				end
				_cbos[_num + 1] = func;
			end
		end
		local function _F_metaOnEventOnceCancel(event, func)
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos ~= nil then
				local _num = #_cbos;
				if _cbos[_num] == func then
					if _num == 1 then
						__EventHandler:UnregisterEvent(event);
						_LT_EventCallsOnce[event] = nil;
					else
						_cbos[_num] = nil;
					end
				elseif _num > 1 then
					for _index = _num - 1, 1, -1 do
						if _cbos[_index] == func then
							tremove(_cbos, _index);
							break;
						end
					end
				end
			end
		end
		__core._F_metaOnEvent = _F_metaOnEvent;
		__core._F_metaOnEventCancel = _F_metaOnEventCancel;
		__core._F_metaOnEventOnce = _F_metaOnEventOnce;
		__core._F_metaOnEventOnceCancel = _F_metaOnEventOnceCancel;
		--
		local _LN_EventLimittedCalls = 0;
		local _LT_EventLimittedCalls = {  };				--	{ func, interval, nextReadyTime, isReady, argv, }
		local function _F_metaLimittedOnEvent(event, interval, func)
			_LN_EventLimittedCalls = _LN_EventLimittedCalls + 1;
			local _call = { func, interval, GetTime() - 0.01, false, nil, };
			local _cbls = _LT_EventLimittedCalls[event];
			if _cbls == nil then
				__EventHandler:RegisterEvent(event);
				_cbls = { _call, };
				_LT_EventLimittedCalls[event] = _cbls;
			else
				_cbls[#_cbls + 1] = { _call, };
			end
			return _call;
		end
		local function _F_metaLimittedOnEventCancel(event, call)
			local _cbls = _LT_EventLimittedCalls[event];
			if _cbls ~= nil then
				if _cbls[_LN_EventLimittedCalls] == call then
					if _LN_EventLimittedCalls == 1 then
						__EventHandler:UnregisterEvent(event);
						_LN_EventLimittedCalls = _LN_EventLimittedCalls - 1;
						_LT_EventLimittedCalls[event] = nil;
					else
						_cbls[_LN_EventLimittedCalls] = nil;
					end
				elseif _LN_EventLimittedCalls > 1 then
					for _index = _LN_EventLimittedCalls - 1, 1, -1 do
						local _cbl = _cbls[_index];
						if _cbl == call or _cbl[1] == call then
							_LN_EventLimittedCalls = _LN_EventLimittedCalls - 1;
							tremove(_cbls, _index);
							break;
						end
					end
				end
			end
		end
		local _LF_metaLimittedLoopOnEvent = nil;
		_LF_metaLimittedLoopOnEvent = function()
			if _LN_EventLimittedCalls > 0 then
				local _now = GetTime();
				for _event, _cbls in next, _LT_EventLimittedCalls do
					for _index = 1, #_cbls do
						local _call = _cbls[_index];
						if _now >= _call[3] then
							local _argsv = _call[5];
							if _argsv ~= nil then
								_F_metaSafeCall(_call[1], event, unpack(_argsv, 2, _argsv[1]));
								_call[3] = _now + _call[2];
								_call[4] = false;
								_call[5] = nil;
							else
								_call[4] = true;
							end
						end
					end
				end
			end
			C_Timer_After(0.1, _LF_metaLimittedLoopOnEvent);
		end
		C_Timer_After(0.1, _LF_metaLimittedLoopOnEvent);
		__core._F_metaLimittedOnEvent = _F_metaLimittedOnEvent;
		__core._F_metaLimittedOnEventCancel = _F_metaLimittedOnEventCancel;
		--
		local _LN_EventLimittedBucketCalls = 0;
		local _LT_EventLimittedBucketCalls = {  };			--	{ func, interval, nextReadyTime, isReady, triggeredEvent, numEvents, events... }
		local function _F_metaLimittedOnEventBucketNamed(key, interval, func, override, ...)
			if override or _LT_EventLimittedBucketCalls[key] == nil then
				if _LT_EventLimittedBucketCalls[key] == nil then
					_LN_EventLimittedBucketCalls = _LN_EventLimittedBucketCalls + 1;
				end
				local _nevents = select('#', ...);
				local _call = { func, interval, GetTime() - 0.01, false, nil, _nevents, ... };
				for _index = 7, _nevents + 6 do
					local _event = _call[_index];
					if _event ~= nil then
						__EventHandler:RegisterEvent(_event);
						_call[_event] = true;
					end
				end
				_LT_EventLimittedBucketCalls[key] = _call;
				return _call;
			end
		end
		local function _F_metaLimittedOnEventBucketNamedCancel(key)
			if _LT_EventLimittedBucketCalls[key] ~= nil then
				_LN_EventLimittedBucketCalls = _LN_EventLimittedBucketCalls - 1;
				_LT_EventLimittedBucketCalls[key] = nil;
			end
		end
		local _LF_metaLimittedOnEventBucketNamedLoop = nil;
		_LF_metaLimittedOnEventBucketNamedLoop = function()
			if _LN_EventLimittedBucketCalls > 0 then
				local _now = GetTime();
				for _key, _call in next, _LT_EventLimittedBucketCalls do
					if _now >= _call[3] then
						if _call[5] ~= nil then
							_F_metaSafeCall(_call[1], _call[5], 1);
							_call[3] = _now + _call[2];
							_call[4] = false;
							_call[5] = nil;
						else
							_call[4] = true;
						end
					end
				end
			end
			C_Timer_After(0.1, _LF_metaLimittedOnEventBucketNamedLoop);
		end
		C_Timer_After(0.1, _LF_metaLimittedOnEventBucketNamedLoop);
		__core._F_metaLimittedOnEventBucketNamed = _F_metaLimittedOnEventBucketNamed;
		__core._F_metaLimittedOnEventBucketNamedCancel = _F_metaLimittedOnEventBucketNamedCancel;
		--
		local function _LF__EventHandler_OnEvent(self, event, ...)
			local _cbs = _LT_EventCalls[event];
			if _cbs ~= nil then
				for _index = 1, #_cbs do
					_F_metaSafeCall(_cbs[_index], event, ...);
				end
			end
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos ~= nil then
				_LT_EventCallsOnce[event] = nil;
				for _index = 1, #_cbos do
					_F_metaSafeCall(_cbos[_index], event, ...);
				end
			end
			local _cbls = _LT_EventLimittedCalls[event];
			if _cbls ~= nil then
				local _now = GetTime();
				for _index = 1, #_cbls do
					local _call = _cbls[_index];
					if _call[4] then
						_call[3] = _now + _call[2];
						_call[4] = false;
						_call[5] = nil;
						if event == "COMBAT_LOG_EVENT" or event == "COMBAT_LOG_EVENT_UNFILTERED" then
							_F_metaSafeCall(_call[1], event, CombatLogGetCurrentEventInfo());
						else
							_F_metaSafeCall(_call[1], event, ...);
						end
					elseif _call[5] == nil then
						if event == "COMBAT_LOG_EVENT" or event == "COMBAT_LOG_EVENT_UNFILTERED" then
							_call[5] = { 25, CombatLogGetCurrentEventInfo() };
						else
							_call[5] = { select('#', ...) + 1, ... };
						end
					end
				end
			end
			if _LN_EventLimittedBucketCalls > 0 then
				local _now = GetTime();
				for _key, _call in next, _LT_EventLimittedBucketCalls do
					if _call[event] then
						if _call[4] then
							_call[3] = _now + _call[2];
							_call[4] = false;
							_call[5] = nil;
							_F_metaSafeCall(_call[1], event, 0);
						elseif _call[5] == nil then
							_call[5] = event;
						end
					end
				end
			end
		end
		__EventHandler:SetScript("OnEvent", _LF__EventHandler_OnEvent);
		-->		Implementation of OnEvent
			--		DependCall			--	Call Once Only
			local _LT_DependCalls = {  };
			local function _F_metaDependCall(addon, func, ...)
				local _loaded, _finished = IsAddOnLoaded(addon);
				if _loaded == true and _finished ~= false then
					_F_metaSafeCall(func, ...);
				else
					addon = strlower(addon);
					local _calls = _LT_DependCalls[addon];
					if _calls == nil then
						_calls = { { func, select('#', ...) + 2, ..., }, };
						_LT_DependCalls[addon] = _calls;
					else
						_calls[#_calls + 1] = { func, select('#', ...) + 2, ..., };
					end
				end
			end
			__core._F_metaDependCall = _F_metaDependCall;
			_F_metaOnEvent("ADDON_LOADED", function(event, arg1)
				local _addon = strlower(arg1);
				local _calls = _LT_DependCalls[_addon];
				if _calls ~= nil then
					_LT_DependCalls[_addon] = nil;
					for _index = 1, #_calls do
						local _call = _calls[_index];
						_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
					end
				end
			end);
			--		LeaveCombatCall
			local _LN_LeaveCombatCalls = 0;
			local _LT_LeaveCombatCalls = {  };
			local _LN_LeaveCombatOnceCalls = 0;
			local _LT_LeaveCombatOnceCalls = {  };
			local function _F_metaLeaveCombatCall(func, ...)
				local _call = { func, select('#', ...) + 2, ..., };
				_LN_LeaveCombatCalls = _LN_LeaveCombatCalls + 1;
				_LT_LeaveCombatCalls[_LN_LeaveCombatCalls] = _call;
				return _call;
			end
			local function _F_metaLeaveCombatCallImmediate(func, ...)
				local _call = { func, select('#', ...) + 2, ..., };
				_LN_LeaveCombatCalls = _LN_LeaveCombatCalls + 1;
				_LT_LeaveCombatCalls[_LN_LeaveCombatCalls] = _call;
				if not InCombatLockdown() then
					_F_metaSafeCall(func, ...);
				end
				return _call;
			end
			local function _F_metaLeaveCombatCallCancel(call)
				if _LT_LeaveCombatCalls[_LN_LeaveCombatCalls] == call then
					_LT_LeaveCombatCalls[_LN_LeaveCombatCalls] = nil;
					_LN_LeaveCombatCalls = _LN_LeaveCombatCalls - 1;
				elseif _LN_LeaveCombatCalls > 1 then
					for _index = _LN_LeaveCombatCalls - 1, 1, -1 do
						if _LT_LeaveCombatCalls[_index] == call then
							_LN_LeaveCombatCalls = _LN_LeaveCombatCalls - 1;
							tremove(_LT_LeaveCombatCalls, _index);
							break;
						end
					end
				end
			end
			local function _F_metaLeaveCombatCallOnce(func, ...)
				if InCombatLockdown() then
					_LN_LeaveCombatOnceCalls = _LN_LeaveCombatOnceCalls + 1;
					local _call = { func, select('#', ...) + 2, ..., };
					_LT_LeaveCombatOnceCalls[_LN_LeaveCombatOnceCalls] = _call;
					return _call;
				else
					_F_metaSafeCall(func, ...);
				end
			end
			local function _F_metaLeaveCombatCallOnceImmediate(func, ...)
				if InCombatLockdown() then
					_LN_LeaveCombatOnceCalls = _LN_LeaveCombatOnceCalls + 1;
					local _call = { func, select('#', ...) + 2, ..., };
					_LT_LeaveCombatOnceCalls[_LN_LeaveCombatOnceCalls] = _call;
					return _call;
				else
					_F_metaSafeCall(func, ...);
				end
			end
			local function _F_metaLeaveCombatCallOnceCancel(call)
				if _LT_LeaveCombatOnceCalls[_LN_LeaveCombatOnceCalls] == call then
					_LT_LeaveCombatOnceCalls[_LN_LeaveCombatOnceCalls] = nil;
					_LN_LeaveCombatOnceCalls = _LN_LeaveCombatOnceCalls - 1;
				elseif _LN_LeaveCombatOnceCalls > 1 then
					for _index = _LN_LeaveCombatOnceCalls - 1, 1, -1 do
						_LN_LeaveCombatOnceCalls = _LN_LeaveCombatOnceCalls - 1;
						tremove(_LT_LeaveCombatOnceCalls, _index);
						break;
					end
				end
			end
			__core._F_metaLeaveCombatCall = _F_metaLeaveCombatCall;
			__core._F_metaLeaveCombatCallImmediate = _F_metaLeaveCombatCallImmediate;
			__core._F_metaLeaveCombatCallCancel = _F_metaLeaveCombatCallCancel;
			__core._F_metaLeaveCombatCallOnce = _F_metaLeaveCombatCallOnce;
			__core._F_metaLeaveCombatCallOnceImmediate = _F_metaLeaveCombatCallOnceImmediate;
			__core._F_metaLeaveCombatCallOnceCancel = _F_metaLeaveCombatCallOnceCancel;
			_F_metaOnEvent("PLAYER_REGEN_ENABLED", function(event)
				for _index = 1, _LN_LeaveCombatCalls do
					local _call = _LT_LeaveCombatCalls[_index];
					_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
				end
				if _LN_LeaveCombatOnceCalls > 0 then
					local _num = _LN_LeaveCombatOnceCalls;
					local _calls = _LT_LeaveCombatOnceCalls;
					_LN_LeaveCombatOnceCalls = 0;
					_LT_LeaveCombatOnceCalls = {  };
					for _index = 1, _num do
						local _call = _calls[_index];
						_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
					end
				end
			end);
			--		EnterCombatCall
			local _LN_EnterCombatCalls = 0;
			local _LT_EnterCombatCalls = {  };
			local _LN_EnterCombatOnceCalls = 0;
			local _LT_EnterCombatOnceCalls = {  };
			local function _F_metaEnterCombatCall(func, ...)
				local _call = { func, select('#', ...) + 2, ..., };
				_LN_EnterCombatCalls = _LN_EnterCombatCalls + 1;
				_LT_EnterCombatCalls[_LN_EnterCombatCalls] = _call;
				if InCombatLockdown() then
					_F_metaSafeCall(func, ...);
				end
				return _call;
			end
			local function _F_metaEnterCombatCallCancel(call)
				if _LT_EnterCombatCalls[_LN_EnterCombatCalls] == call then
					_LT_EnterCombatCalls[_LN_EnterCombatCalls] = nil;
					_LN_EnterCombatCalls = _LN_EnterCombatCalls - 1;
				elseif _LN_EnterCombatCalls > 1 then
					for _index = _LN_EnterCombatCalls - 1, 1, -1  do
						if _LT_EnterCombatCalls[_index] == call then
							_LN_EnterCombatCalls = _LN_EnterCombatCalls - 1;
							tremove(_LT_EnterCombatCalls, _index);
							break;
						end
					end
				end
			end
			local function _F_metaEnterCombatCallOnce(func, ...)
				if InCombatLockdown() then
					_F_metaSafeCall(func, ...);
				else
					_LN_EnterCombatOnceCalls = _LN_EnterCombatOnceCalls + 1;
					local _call = { func, select('#', ...) + 2, ..., };
					_LT_EnterCombatOnceCalls[_LN_EnterCombatOnceCalls] = _call;
					return _call;
				end
			end
			local function _F_metaEnterCombatCallOnceCancel(call)
				if _LT_EnterCombatOnceCalls[_LN_EnterCombatOnceCalls] == call then
					_LT_EnterCombatOnceCalls[_LN_EnterCombatOnceCalls] = nil;
					_LN_EnterCombatOnceCalls = _LN_EnterCombatOnceCalls - 1;
				elseif _LN_EnterCombatOnceCalls > 1 then
					for _index = _LN_EnterCombatOnceCalls - 1, 1, -1 do
						if _LT_EnterCombatOnceCalls[_index] == call then
							_LN_EnterCombatOnceCalls = _LN_EnterCombatOnceCalls - 1;
							tremove(_LT_EnterCombatOnceCalls, _index);
							break;
						end
					end
				end
			end
			__core._F_metaEnterCombatCall = _F_metaEnterCombatCall;
			__core._F_metaEnterCombatCallCancel = _F_metaEnterCombatCallCancel;
			__core._F_metaEnterCombatCallOnce = _F_metaEnterCombatCallOnce;
			__core._F_metaEnterCombatCallOnceCancel = _F_metaEnterCombatCallOnceCancel;
			_F_metaOnEvent("PLAYER_REGEN_DISABLED", function(event)
				for _index = 1, _LN_EnterCombatCalls do
					local _call = _LT_EnterCombatCalls[_index];
					_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
				end
				if _LN_EnterCombatOnceCalls > 0 then
					local _num = _LN_EnterCombatOnceCalls;
					local _calls = _LT_EnterCombatOnceCalls;
					_LN_EnterCombatOnceCalls = 0;
					_LT_EnterCombatOnceCalls = {  };
					for _index = 1, _num do
						local _call = _calls[_index];
						_F_metaSafeCall(_call[1], unpack(_call, 3, _call[2]));
					end
				end
			end);
			--		HideOnPetBattle
			if __namespace.__client._TocVersion >= 60000 then
				local _LT_HideOnPetBattleFrames = {  };
				local function _F_metaHideOnPetBattle(frame)
					_LT_HideOnPetBattleFrames[frame] = true;
				end
				__core._F_metaHideOnPetBattle = _F_metaHideOnPetBattle;
				_F_metaOnEvent("PET_BATTLE_OPENING_START", function()
					for _frame in next, _LT_HideOnPetBattleFrames do
						_frame._prev_state = _frame:IsShown();
						if not issecurevariable(_frame, "Show") and _frame._originShow == nil then
							_frame._originShow = _frame.Show;
							_frame.Show = _F_noop
						end
						_frame:Hide();
					end
				end);
				_F_metaOnEvent("PET_BATTLE_CLOSE", function()
					for _frame in next, _LT_HideOnPetBattleFrames do
						if _frame._originShow ~= nil then
							_frame.Show = _frame._originShow;
							_frame._originShow = nil;
						end
						if _frame._prev_state then
							_frame:Show();
							_frame._prev_state = nil;
						end
					end
				end);
			end
			--
		-->
	--
-->

-->		ChatFrame
	local _ChatFrames = {  };
	for _index = 1, NUM_CHAT_WINDOWS do
		_ChatFrames[_index] = _G["ChatFrame" .. _index];
	end
	function __core._F_metaWithAllChatFrame(func, ...)
		for _index = 1, NUM_CHAT_WINDOWS do
			if _ChatFrames[_index] ~= nil then
				func(_ChatFrames[_index], ...);
			end
		end
	end
	function __core._F_metaWithAllChatFrameIgnore2(func, ...)
		if _ChatFrames[1] ~= nil then
			func(_ChatFrames[1], ...);
		end
		for _index = 2, NUM_CHAT_WINDOWS do
			if _ChatFrames[_index] ~= nil then
				func(_ChatFrames[_index], ...);
			end
		end
	end
-->


if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._2function", __core._F_devDebugProfileTick("config._2function"));
end
