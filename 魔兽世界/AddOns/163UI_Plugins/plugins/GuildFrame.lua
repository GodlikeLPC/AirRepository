
local GUILDMEMBERS_TO_DISPLAY = GUILDMEMBERS_TO_DISPLAY;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

local GuildListScrollFrame = GuildListScrollFrame;
local GetRealZoneText = GetRealZoneText;
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset;
local GetGuildRosterInfo = GetGuildRosterInfo;
local GetQuestDifficultyColor = GetQuestDifficultyColor;

local GuildFrameButtons = {  };
local GuildFrameButtonsClass = {  };
local GuildFrameButtonsName = {  };
local GuildFrameButtonsZone = {  };
local GuildFrameButtonsLevel = {  };
local GuildFrameGuildStatusButtonsName = {  };
local GuildFrameGuildStatusButtonsOnline = {  };


-- /run for k,v in pairs(_G) do if type(v)=='table' and strfind(k,'^GuildFrameButton1[^0-9]') then print(k) end end
-- /run for k,v in pairs(_G) do if type(v)=='table' and strfind(k,'^GuildFrameGuildStatusButton1[^0-9]') then print(k) end end
for i = 1, 999 do
    if _G["GuildFrameButton" .. i] then
        --GuildFrameButtons[i] = _G["GuildFrameButton" .. i];
        GuildFrameButtonsClass[i] = _G["GuildFrameButton" .. i .. "Class"];
        GuildFrameButtonsName[i] = _G["GuildFrameButton" .. i .. "Name"];
        GuildFrameButtonsZone[i] = _G["GuildFrameButton" .. i .. "Zone"];
        GuildFrameButtonsLevel[i] = _G["GuildFrameButton" .. i .. "Level"];
        GuildFrameGuildStatusButtonsName[i] = _G["GuildFrameGuildStatusButton" .. i .. "Name"];
        GuildFrameGuildStatusButtonsOnline[i] = _G["GuildFrameGuildStatusButton" .. i .. "Online"];
    else
        break;
    end
end

local function Hook_GuildStatus_Update()
	local pZone = GetRealZoneText();

	local offset = FauxScrollFrame_GetOffset(GuildListScrollFrame);
	
	for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
		local index = offset + i;

		local name, rank, rankIndex, level, lClass, zone, note, officernote, online, afk, class = GetGuildRosterInfo(index);
		if not name then
			break;
		end

		if class then
			local color = RAID_CLASS_COLORS[class];
			if color then
				if online then
					GuildFrameButtonsClass[i]:SetTextColor(color.r, color.g, color.b);
					GuildFrameButtonsName[i]:SetTextColor(color.r, color.g, color.b);
					GuildFrameGuildStatusButtonsName[i]:SetTextColor(color.r, color.g, color.b)
				else
					GuildFrameButtonsClass[i]:SetTextColor(color.r / 2, color.g / 2, color.b / 2);
					GuildFrameButtonsName[i]:SetTextColor(color.r / 2, color.g / 2, color.b / 2);
					GuildFrameGuildStatusButtonsName[i]:SetTextColor(color.r / 2, color.g / 2, color.b / 2)
				end
			end
		end

		local color = GetQuestDifficultyColor(level);
		if online then
			GuildFrameButtonsLevel[i]:SetTextColor(color.r, color.g, color.b);
            if zone == pZone then
                GuildFrameButtonsZone[i]:SetTextColor(0, 1, 0);
			end
			if afk == 1 then
				GuildFrameGuildStatusButtonsOnline[i]:SetTextColor(1, 1, 0);
			else
				GuildFrameGuildStatusButtonsOnline[i]:SetTextColor(0, 1, 0);
			end
		else
			GuildFrameButtonsLevel[i]:SetTextColor(color.r / 2, color.g / 2, color.b / 2);
            if zone == pZone then
                GuildFrameButtonsZone[i]:SetTextColor(0, 0.5, 0);
            end
			GuildFrameGuildStatusButtonsOnline[i]:SetTextColor(0.5, 0.5, 0.5);
		end
	end
end

hooksecurefunc("GuildStatus_Update", Hook_GuildStatus_Update);
