--	tainting issue
do return end
--[[--
	alex/ALA @ 163UI
--]]--
local _G = _G;

local L = {  };
do
	if GetLocale() == "zhCN" or GetLocale == "zhTW" then
		L["RANK_IN_NUMBER"] = "显示数字PVP军衔等级";
	else
		L["RANK_IN_NUMBER"] = "Show rank number instead of icon";
	end
end

local GetNumBattlefieldScores = GetNumBattlefieldScores;
local GetBattlefieldScore = GetBattlefieldScore;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

local WorldStateScoreFrame = WorldStateScoreFrame;
local WorldStateScoreScrollFrameScrollBar = WorldStateScoreScrollFrameScrollBar;

local MAX_SCORE_BUTTONS = 0;
local lines = {  };
local titleRegion = nil;
local indicator = nil;
local function hook_WorldStateScoreFrame()
	local index = 1;
	while true do
		local line = _G["WorldStateScoreButton" .. index];
		if line ~= nil then
			MAX_SCORE_BUTTONS = index;
			lines[index] = line;
		else
			break;
		end
		index = index + 1;
	end

	WorldStateScoreFrame:SetMovable(true);

	titleRegion = CreateFrame("FRAME", nil, WorldStateScoreFrame);
	titleRegion:SetPoint("TOP", 0, -14);
	titleRegion:SetPoint("LEFT", 0);
	titleRegion:SetPoint("RIGHT", WorldStateScoreFrameCloseButton, "LEFT");
	titleRegion:SetHeight(24);
	-- titleRegion:SetAlpha(1.0);
	titleRegion:SetMovable(true);
	titleRegion:EnableMouse(true);
	titleRegion:Show();
	titleRegion:RegisterForDrag("LeftButton")
	titleRegion:SetScript("OnDragStart", function()
		WorldStateScoreFrame:StartMoving();
	end);
	titleRegion:SetScript("OnDragStop", function()
		WorldStateScoreFrame:StopMovingOrSizing();
	end);

	indicator = WorldStateScoreFrame:CreateTexture(nil, "OVERLAY");
	indicator:SetSize(32, 16);
	indicator:SetTexture("interface\\vehicles\\arrow");
	indicator:SetBlendMode("ADD");
	indicator:Hide();

	hooksecurefunc("WorldStateScoreFrame_Update", function()
		local ofs = WorldStateScoreScrollFrameScrollBar:GetValue() / WorldStateScoreScrollFrameScrollBar:GetValueStep();
		local num = GetNumBattlefieldScores();
		local player_shown = false;
		for index = 1, min(MAX_SCORE_BUTTONS, num - ofs) do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, locale_class, class
					= GetBattlefieldScore(index + ofs);
			local line = lines[index];
			local color = RAID_CLASS_COLORS[class];
			if color then
				line.name.text:SetVertexColor(color.r, color.g, color.b, 1.0);
			else
				line.name.text:SetVertexColor(1.0, 0.82, 0.0, 1.0);
			end
			if name == UnitName("player") then
				player_shown = true;
				indicator:SetPoint("RIGHT", line, "LEFT", - 4, 0);
			end
		end
		if player_shown then
			indicator:Show();
		else
			indicator:Hide();
		end
	end);
end
hook_WorldStateScoreFrame();
