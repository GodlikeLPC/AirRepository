local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();
if _toc_version >= 90000 then
	return;
end

local __addon, __ns = ...;

local _GUIDE_DATA = __ns._GUIDE_DATA;
setmetatable(_GUIDE_DATA, { __index = function(tbl, key) return {  }; end, });

local GetQuestLogSelection = GetQuestLogSelection;
local GetQuestLogTitle = GetQuestLogTitle;
------------------------------
local function _LF_OpenBrowser(Type, Name, ID)
	-- Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器");
	-- ThreeDimensionsCode_Send("innerbrowser", "http://www.baidu.com/s?wd=" .. Type .. "?id=" .. ID .. "?name=" .. Name);
	-- _163ClientOpenURL("http://www.baidu.com/s?wd=" .. Type .. "?id=" .. ID .. "?name=" .. Name);
	_163ClientOpenURL(_GUIDE_DATA[Type][ID]);
	-- print(Type, Name, ID);
end
local _fadein_alpha = 1.0;
local _fadeout_alpha = 0.75;
local function _LF_OnUpdate_Extern(_E, elasped)
	if _E.__action == 'fade-in' then
		local __alpha = _E.__alpha + elasped;
		if __alpha >= _fadein_alpha then
			_E:SetScript("OnUpdate", nil);
			__alpha = _fadein_alpha;
		end
		_E.__alpha = __alpha;
		_E:SetAlpha(__alpha);
	else
		local __alpha = _E.__alpha - elasped * 0.5;
		if __alpha <= _fadeout_alpha then
			_E:SetScript("OnUpdate", nil);
			__alpha = _fadeout_alpha;
		end
		_E.__alpha = __alpha;
		_E:SetAlpha(__alpha);
	end
end
local function _LF_OnEnter_Extern(_E)
	-- _E.__action = 'fade-in';
	-- _E:SetScript("OnUpdate", _LF_OnUpdate_Extern);
	GameTooltip:SetOwner(_E, "ANCHOR_TOP");
	GameTooltip:SetText("需要开启有爱客户端");
	GameTooltip:Show();
end
local function _LF_OnLeave_Extern(_E)
	-- _E.__action = 'fade-out';
	-- _E:SetScript("OnUpdate", _LF_OnUpdate_Extern);
	GameTooltip:Hide();
end
local function _LF_OnClick_Extern(_E, button)
	local selected = GetQuestLogSelection();
	local name, level, tag, isHeader, isCollapsed, isComplete, frequency, id, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(selected);
	if id ~= nil then
		_LF_OpenBrowser('quest', name, id);
	end
end

local Extern = CreateFrame('BUTTON', nil, QuestLogDetailScrollChildFrame, "UIPanelButtonTemplate");
Extern:SetSize(85, 21);
Extern:SetPoint("RIGHT", QuestLogQuestTitle, "RIGHT", -2, 0);
Extern:SetText("查询攻略");

-- Extern:SetFrameLevel(9999);
Extern:SetScript("OnClick", _LF_OnClick_Extern);
Extern:SetScript("OnEnter", _LF_OnEnter_Extern);
Extern:SetScript("OnLeave", _LF_OnLeave_Extern);
-- Extern:SetAlpha(_fadeout_alpha);
-- Extern.__alpha = _fadeout_alpha;

hooksecurefunc("QuestLog_UpdateQuestDetails", function(doNotScrolls)
	local selected = GetQuestLogSelection();
	if selected ~= nil and selected ~= 0 then
		local name, level, tag, isHeader, isCollapsed, isComplete, frequency, id, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(selected);
		if id ~= nil and _GUIDE_DATA['quest'][id] ~= nil then
			return Extern:Show();
		end
	end
	return Extern:Hide();
end);

