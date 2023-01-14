--[=[
	FIX
--]=]
--[====[
	--	function		-->		Internal method without parameters check
	--	implement
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__nsconfig;
local __addon = __private.__addon;

local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._5fix");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------

-->		upvalue
local hooksecurefunc = hooksecurefunc;
local min = math.min;
local strlower, strfind = string.lower, string.find;
local C_Timer_After = C_Timer.After;
local print = print;
local _G = _G;
--	ADDON_ACTION_FORBIDDEN
local StaticPopup_Hide = StaticPopup_Hide;
--	QuestLogFrame
local GetNumQuestLogEntries, GetQuestLogTitle, IsQuestWatched = GetNumQuestLogEntries, GetQuestLogTitle, IsQuestWatched;
local GetQuestLogTitle = GetQuestLogTitle;
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset;
local QuestLogListScrollFrame = QuestLogListScrollFrame;
--	MasterLooterFrame
local MasterLooterFrame = MasterLooterFrame;
--
local StackSplitFrame, OpenStackSplitFrame = StackSplitFrame, OpenStackSplitFrame;

if __core.__is_dev then
	__core._F_BuildEnv("config._5fix");
end

do	--	ADDON_ACTION_FORBIDDEN
	local F = _G.CreateFrame('FRAME');
	F:RegisterEvent("ADDON_ACTION_FORBIDDEN");
	local _addon = strlower("!BlizzardRaidFramesFix");
	F:SetScript("OnEvent", function(F, event, addon, msg)
		StaticPopup_Hide("ADDON_ACTION_FORBIDDEN");
		if strlower(addon) == _addon then
			print(">> " .. addon .. "是用来修复团队框架问题的。");
			print(">> |cffff0000但是有时会导致无法管理公会。|r");
			print(">> 可以在|cffff0000有爱插件|r中暂时关掉它，待公会管理完毕后重新打开。");
		end
		if __core.__is_dev or strfind(msg, "GuildControlSetRank") == nil then
			print(addon, "插件导致了一个小问题，重载插件或禁用该插件来解决（如果没有影响操作，无需处理该问题）");
			print("错误信息：", msg);
		end
	end);
end

do	--	QuestLogFrame
	local _isInSchedule = false;
	local _Titles = {  };
	local _top = 0;
	local function TickUpdate()
		if _isInSchedule then
			_isInSchedule = false;
			local QUESTS_DISPLAYED = _G.QUESTS_DISPLAYED;
			if QUESTS_DISPLAYED > _top then
				for index = _top + 1, QUESTS_DISPLAYED do
					_top = index;
					local Title = _G["QuestLogTitle".. index] or _G["QuestLogListScrollFrameButton" .. index];
					_Titles[index] = Title;
					Title.Check = _G["QuestLogTitle".. index .. "Check"] or _G["QuestLogListScrollFrameButton" .. index .. "Check"];
				end
			end
			local numEntries, numQuests = GetNumQuestLogEntries();
			local ofs = FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
			for index = 1, min(_top, numEntries - ofs) do
				local questIndex = index + ofs;
				local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex);
				if isHeader then
					_Titles[index].Check:Hide();
				elseif IsQuestWatched(questIndex) then
					_Titles[index].Check:Show();
				else
					_Titles[index].Check:Hide();
				end
			end
		end
	end
	hooksecurefunc("QuestLog_Update", function()
		if not _isInSchedule then
			_isInSchedule = true;
			C_Timer_After(0.1, TickUpdate);
		end
	end);	
end

do	--	MasterLooterFrame
	if MasterLooterFrame ~= nil then
		MasterLooterFrame:ClearAllPoints();
		MasterLooterFrame:HookScript("OnHide", function(self)
			self:ClearAllPoints();
		end);
	end
end

do	--	AddonList
	local Entry = {  };
	local Enabled = {  };
	local Security = {  };
	local Num = 1;
	while true do
		local L = _G["AddonListEntry" .. Num];
		local E = _G["AddonListEntry" .. Num .. "Enabled"];
		local S = _G["AddonListEntry" .. Num .. "Security"];
		if L == nil then
			Num = Num - 1;
			break;
		end
		Entry[Num] = L;
		Entry[L] = Num;
		Enabled[Num] = E;
		Enabled[E] = Num;
		Security[Num] = S;
		Security[S] = Num;
		E.__parent = L;
		S.__parent = S;
		Num = Num + 1;
	end
	-- hooksecurefunc("AddonList_Update", function()
	-- 	--	AddonListOkayButton:SetText(RELOADUI);
	-- 	--	AddonList.shouldReload = true;
	-- 	--	AddonListOkayButton:SetText(OKAY);
	-- 	--	AddonList.shouldReload = false;
	-- 	for index = 1, Num do
	-- 		local ID = Entry[index]:GetID();
	-- 		Enabled[index]:SetID(ID);
	-- 		Security[index]:SetID(ID);
	-- 	end
	-- end);
	local _AddonTooltip_Update = _G.AddonTooltip_Update;
	function _G.AddonTooltip_Update(owner)
		if Entry[owner] ~= nil then
		elseif Enabled[owner] ~= nil or Security[owner] ~= nil then
			owner:SetID(owner.__parent:GetID());
		else
			return;
		end
		return _AddonTooltip_Update(owner);
	end
end

do	--	BattlefieldFrame of WotLK
	-- BattlefieldFrame:SetParent(PVPParentFrame);
	-- local SettingPos = false;
	-- local function hook()
	-- 	if not SettingPos then
	-- 		SettingPos = true;
	-- 		BattlefieldFrame:ClearAllPoints();
	-- 		BattlefieldFrame:SetAllPoints(PVPParentFrame)
	-- 		SettingPos = false;
	-- 	end
	-- end
	-- hooksecurefunc(BattlefieldFrame, "ClearAllPoints", hook);
	-- hooksecurefunc(BattlefieldFrame, "SetPoint", hook);
	-- BattlefieldFrame:HookScript("OnShow", hook);
	-- hook();
end

do	--	InspectFrame
	local FS = UIParent:CreateFontString(nil, "ARTWORK");
	FS:SetFont(GameFontNormal:GetFont());
	_G.InspectTalentFrameSpentPoints = FS;
end

if StackSplitFrame ~= nil and OpenStackSplitFrame ~= nil then
	StackSplitFrame.OpenStackSplitFrame = StackSplitFrame.OpenStackSplitFrame or function(_, ...)
		return OpenStackSplitFrame(...);
	end;
end

-- if MiniMapWorldMapButton ~= nil then
-- 	-- MiniMapWorldMapButton:ClearAllPoints();
-- 	-- MiniMapWorldMapButton:SetPoint("LEFT", MinimapZoneTextButton, "LEFT", -16, -2);
-- 	MiniMapWorldMapButton:Hide();
-- end

--  Backdrop
-- local BackdropTemplateMixin = _G.BackdropTemplateMixin;
-- local __ala_meta__ = _G.__ala_meta__;
-- if BackdropTemplateMixin ~= nil and __ala_meta__ ~= nil and __ala_meta__.uireimp ~= nil then
-- 	local noop = function() end
-- 	local uireimp = __ala_meta__.uireimp;
-- 	for _meta, _ in next, __core._T_coreFrameMetaTable do
-- 		for key, val in next, BackdropTemplateMixin do
-- 			_meta[key] = _meta[key] or uireimp["_" .. key] or noop;
-- 		end
-- 	end
-- end
_G.TOOLTIP_BACKDROP_STYLE_DEFAULT = _G.TOOLTIP_BACKDROP_STYLE_DEFAULT or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};
_G.GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT = _G.GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};

_G.GAME_TOOLTIP_BACKDROP_STYLE_EMBEDDED = _G.GAME_TOOLTIP_BACKDROP_STYLE_EMBEDDED or {
	-- Nothing
};

_G.TOOLTIP_AZERITE_BACKGROUND_COLOR = _G.TOOLTIP_AZERITE_BACKGROUND_COLOR or CreateColor(1, 1, 1);
_G.GAME_TOOLTIP_BACKDROP_STYLE_AZERITE_ITEM = _G.GAME_TOOLTIP_BACKDROP_STYLE_AZERITE_ITEM or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background-Azerite",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border-Azerite",
	tile = true,
	tileEdge = false,
	tileSize = 16,
	edgeSize = 19,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_AZERITE_BACKGROUND_COLOR,

	overlayAtlasTop = "AzeriteTooltip-Topper";
	overlayAtlasTopScale = .75,
	overlayAtlasBottom = "AzeriteTooltip-Bottom";
};

_G.BACKDROP_TOOLTIP_16_16_5555 = _G.BACKDROP_TOOLTIP_16_16_5555 or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};

if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._5fix", __core._F_devDebugProfileTick("config._5fix"));
end
