local addonName, private = ...
private.__plugins = private;
private.__meta = {  };
private.__env = setmetatable(
    {  },
    {
        __index = _G,
        __newindex = function(tbl, key, value)
            rawset(tbl, key, value);
            _F_corePrint("Plugin Assign Global ", key, value);
            _F_OutputDebugStack();
            return value;
        end,
    }
);
private.__is_dev = false;
local _PatchVersion, _BuildNumber, _BuildDate, _TocVersion = GetBuildInfo();
private.__client = {
    _PatchVersion = _PatchVersion,
    _BuildNumber = _BuildNumber,
    _BuildDate = _BuildDate,
    _TocVersion = _TocVersion,
};
private.__const = {  };
private.__const._C_PLAYER_GUID = UnitGUID('player');

local __meta = private.__meta;
__meta._F_metaSafeCall = pcall;
__meta._F_corePrint = print;
__meta._F_coreDebug = function() end;

local _F_metaSafeCall = __meta._F_metaSafeCall;
-->		Dispatcher
	local __EventHandler = CreateFrame('FRAME');
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
		__meta._F_metaOnEvent = _F_metaOnEvent;
		__meta._F_metaOnEventCancel = _F_metaOnEventCancel;
		__meta._F_metaOnEventOnce = _F_metaOnEventOnce;
		__meta._F_metaOnEventOnceCancel = _F_metaOnEventOnceCancel;
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
		end
		__EventHandler:SetScript("OnEvent", _LF__EventHandler_OnEvent);
		-->		Implementation of OnEvent
			--		DependCall			--	Call Once Only
			local _LT_DependCalls = {  };
			local function _F_metaDependCall(addon, func, ...)
				local _, finished = IsAddOnLoaded(addon);
				if finished then
					_F_metaSafeCall(func, ...);
				else
					addon = strlower(addon);
					local _calls = _LT_DependCalls[addon];
					if _call == nil then
						_calls = { { func, select('#', ...) + 2, ..., }, };
						_LT_DependCalls[addon] = _calls;
					else
						_calls[#_calls + 1] = { func, select('#', ...) + 2, ..., };
					end
				end
			end
			__meta._F_metaDependCall = _F_metaDependCall;
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
			__meta._F_metaLeaveCombatCall = _F_metaLeaveCombatCall;
			__meta._F_metaLeaveCombatCallImmediate = _F_metaLeaveCombatCallImmediate;
			__meta._F_metaLeaveCombatCallCancel = _F_metaLeaveCombatCallCancel;
			__meta._F_metaLeaveCombatCallOnce = _F_metaLeaveCombatCallOnce;
			__meta._F_metaLeaveCombatCallOnceImmediate = _F_metaLeaveCombatCallOnceImmediate;
			__meta._F_metaLeaveCombatCallOnceCancel = _F_metaLeaveCombatCallOnceCancel;
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
			__meta._F_metaEnterCombatCall = _F_metaEnterCombatCall;
			__meta._F_metaEnterCombatCallCancel = _F_metaEnterCombatCallCancel;
			__meta._F_metaEnterCombatCallOnce = _F_metaEnterCombatCallOnce;
			__meta._F_metaEnterCombatCallOnceCancel = _F_metaEnterCombatCallOnceCancel;
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
		-->
	--
-->


local function _InitDB()
    if _G._163UIPluginsDB == nil then
        _G._163UIPluginsDB = {  };
    end
    private.__db = _G._163UIPluginsDB;
end
_F_metaDependCall(addonName, _InitDB);


_G._163UIPlugin = private;
_G.__core_public = _G.__core_public or {  };
_G.__core_public.__ns_plugins = private;


--[[------------------------------------------------------------
默认银行界面打开全部银行背包
---------------------------------------------------------------]]
U1PLUG["OpenBags"] = function()
    CoreOnEvent("BANKFRAME_OPENED", function()
        if BankFrame:IsVisible() then
            for i = NUM_BAG_SLOTS+1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) do
                OpenBag(i)
            end
        end
    end)
end

--[[------------------------------------------------------------
ctrl点击游戏菜单按钮回收内存，无选项
---------------------------------------------------------------]]
do
    local gc = function()
        UpdateAddOnMemoryUsage();
        local beforeMem = 0;
        for i = 1, GetNumAddOns(), 1 do
            local mem = GetAddOnMemoryUsage(i);
            beforeMem = beforeMem + mem;
        end
        local beforeLua = collectgarbage("count")
        collectgarbage("collect")
        UpdateAddOnMemoryUsage();
        local afterMem = 0;
        for i = 1, GetNumAddOns(), 1 do
            local mem = GetAddOnMemoryUsage(i);
            afterMem = afterMem + mem;
        end
        local afterLua = collectgarbage("count")
        U1Message(format("内存已回收，插件占用：%.1fM -> %.1fM, LUA占用：%.1fM -> %.1fM", beforeMem / 1024, afterMem / 1024, beforeLua / 1024, afterLua / 1024))
    end
    MainMenuMicroButton:HookScript("OnClick", function()
        if IsControlKeyDown() then
            if GameMenuFrame:IsVisible() then HideUIPanel(GameMenuFrame) end
            CoreScheduleBucket("gc", 0.2, gc)
        end
    end)
end

--[[------------------------------------------------------------
/align 显示网格
---------------------------------------------------------------]]
do
    SLASH_EALIGN_UPDATED1 = "/align"
    SLASH_EALIGN_UPDATED2 = "/wangge"
    local DEFAULT_SQUARE = 30
    local f, square
    SlashCmdList["EALIGN_UPDATED"] = function(msg)
        square = tonumber(msg) or DEFAULT_SQUARE
        if f and f:IsVisible() then
            f:Hide()
        else
            if not f then
              f = CreateFrame('Frame', "ALIGN163FRAME", UIParent)
              f:SetAllPoints(UIParent)
              f.verticals = {}
              f.horizons = {}
            end
            f:Show()

            for i=1, GetScreenHeight()/square do
              local t = f.verticals[i]
              if not t then
                t = f:CreateTexture(nil, 'BACKGROUND', nil, -8)
                f.verticals[i] = t
              end
              t:Show()
              t:SetColorTexture(i == 1 and 1 or 0, 0, 0, 0.5)
              t:SetPoint('TOPLEFT', f, 'LEFT', 0, math.floor(i/2)*(1-i%2*2)*square-1)
              t:SetPoint('BOTTOMRIGHT', f, 'RIGHT', 0, math.floor(i/2)*(1-i%2*2)*square)
            end
            for i=math.floor(GetScreenHeight()/square)+1, #f.verticals do f.verticals[i]:Hide() end

            for i=1, GetScreenWidth()/square do
              local t = f.horizons[i]
              if not t then
                t = f:CreateTexture(nil, 'BACKGROUND', nil, -8)
                f.horizons[i] = t
              end
              t:Show()
              t:SetColorTexture(i == 1 and 1 or 0, 0, 0, 0.5)
              t:SetPoint('TOPLEFT', f, 'TOP', math.floor(i/2)*(1-i%2*2)*square-1, 0)
              t:SetPoint('BOTTOMRIGHT', f, 'BOTTOM', math.floor(i/2)*(1-i%2*2)*square, 0)
            end
            for i=math.floor(GetScreenWidth()/square)+1, #f.horizons do f.horizons[i]:Hide() end
        end
    end

    --[[
    hooksecurefunc(getmetatable(CreateFrame("Frame")).__index, "StopMovingOrSizing", function(self)
        if Align163StopMovingOrSizing then Align163StopMovingOrSizing(self) end
    end)
    Align163StopMovingOrSizing = function(self)
        --print(self:GetNumPoints(), select(2, self:GetPoint()))
        if self:GetNumPoints() ~= 1 then return end
        local p1, rel, p2, x, y = self:GetPoint()
        if rel ~= nil and rel ~= UIParent then return end
        print(p1, p2, x, y, self:GetLeft())
        if
    end
    --]]
end

--[[------------------------------------------------------------
转团提醒
---------------------------------------------------------------]]
function U1IsDoingWorldQuest()
    if not WORLD_QUEST_TRACKER_MODULE or not WORLD_QUEST_TRACKER_MODULE.usedBlocks then return end
    local count = 0
    for k,v in pairs(WORLD_QUEST_TRACKER_MODULE.usedBlocks) do
        count = count + 1
    end
    if count > GetNumWorldQuestWatches() then
        return true
    end
end

--[[------------------------------------------------------------
公会新闻手工加载
---------------------------------------------------------------]]
U1PLUG["FixBlizGuild"] = function()
    U1QueryGuildNews = QueryGuildNews
    QueryGuildNews = function() end
    local createLoadButton = function(parent)
        local btn = WW:Button("$parentGetNewsButton", parent, "UIMenuButtonStretchTemplate"):SetTextFont(ChatFontNormal, 13, ""):SetAlpha(0.8):SetText("加载新闻"):Size(100, 30):CENTER(0, 0):AddFrameLevel(3, parent):SetScript("OnClick", function(self)
            U1QueryGuildNews()
            QueryGuildNews = U1QueryGuildNews
            --self:Hide()
            self:ClearAllPoints() self:SetPoint("TOPRIGHT", -1, 33) self:SetSize(80, 30) self:SetText("加载新闻")
        end):un()
        CoreUIEnableTooltip(btn, '有爱', '手工加载公会新闻，减少卡顿，可以在"有爱设置-小功能集合"里关闭此功能')
    end
    CoreDependCall("Blizzard_GuildUI", function() createLoadButton(GuildNewsFrame) end)
    CoreDependCall("Blizzard_Communities", function() createLoadButton(CommunitiesFrameGuildDetailsFrameNews) end)
end

