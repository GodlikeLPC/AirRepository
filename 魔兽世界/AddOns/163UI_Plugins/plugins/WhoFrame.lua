--[[--
	PLUGIN: WhoFrame
--]]--

local __namespace = _G.__core_namespace;
local _, __private = ...;

local __core = __namespace.__core;
local __plugins = __private.__plugins;

if __core.__is_dev then
	setfenv(1, __private.__env);
end

----------------------------------------------------------------

-->	upvalue
local GetRealZoneText = GetRealZoneText;
local GetGuildInfo = GetGuildInfo;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local GetWhoInfo = C_FriendList and C_FriendList.GetWhoInfo or GetWhoInfo or function() end
local GetQuestDifficultyColor = GetQuestDifficultyColor;
local UIDropDownMenu_GetSelectedID = UIDropDownMenu_GetSelectedID;
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset;
local ListScrollFrameButtonNameParse = nil;
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    ListScrollFrameButtonNameParse = "WhoListScrollFrameButton";
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    ListScrollFrameButtonNameParse = "WhoFrameButton";
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    ListScrollFrameButtonNameParse = "WhoFrameButton";
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
    ListScrollFrameButtonNameParse = "WhoFrameButton";
else
    ListScrollFrameButtonNameParse = "WhoFrameButton";
end


do
	local _enabled = true;

	local _Button_Names = {  };
	local _Button_Levels = {  };
	local _Button_Classes = {  };
	local _Button_Variables = {  };
	local _PLAYER_RACE = UnitRace('player');

	local function main()
		if _enabled then
			local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame);

			local playerZone = GetRealZoneText();
			local playerGuild = GetGuildInfo('player');
			local var = UIDropDownMenu_GetSelectedID(WhoFrameDropDown);

			for i = 1, WHOS_TO_DISPLAY, 1 do
				local index = whoOffset + i;

				local info = GetWhoInfo(index);
				if not info then return end
				local name, guild, level, race, class, zone, classFileName = info.fullName, info.fullGuildName, info.level, info.raceStr, info.classStr, info.area, info.filename;
				if name then
					local color = RAID_CLASS_COLORS[classFileName];
					_Button_Names[i]:SetTextColor(color.r, color.g, color.b);
					_Button_Classes[i]:SetTextColor(color.r, color.g, color.b);
					local color = GetQuestDifficultyColor(level);
					_Button_Levels[i]:SetTextColor(color.r, color.g, color.b);
					if var == 1 then
						_Button_Variables[i]:SetText(zone == playerZone and ('|cff00ff00' .. zone .. '|r') or zone);
					elseif var == 2 then
						_Button_Variables[i]:SetText(guild == playerGuild and ('|cff00ff00' .. guild .. '|r') or guild);
					elseif var == 3 then
						_Button_Variables[i]:SetText(race == _PLAYER_RACE and ('|cff00ff00' .. race .. '|r') or race);
					end
				end
			end
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		_isInitialized = true;
		local index = 1;
		while true do
			local n = ListScrollFrameButtonNameParse .. index;
			local b = _G[n];
			if b then
				_Button_Names[index] = b.Name or _G[n .. "Name"];
				_Button_Levels[index] = b.Level or _G[n .. "Level"];
				_Button_Classes[index] = b.Class or _G[n .. "Class"];
				_Button_Variables[index] = b.Variable or _G[n .. "Variable"];
			else
				break;
			end
			index = index + 1;
		end
		hooksecurefunc('WhoList_Update', main);
		if __namespace.__client._TocVersion >= 90000 then
			hooksecurefunc(WhoListScrollFrame, "update", main);
		end
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and WhoListScrollFrame:IsShown() then
			main();
		end
	end
	local function _Disable(loading)
		_enabled = false;
	end

	__plugins['WhoFrameListColor'] = { _Enable, _Disable, };
end
