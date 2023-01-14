--[[
	@ALA / ALEX Edited
	Credit to [QuestFrameFixer] & [QuestIconDesaturation] of Sveng.
--]]
local _G = _G;
local gsub = gsub;
local GetNumQuestLogEntries = GetNumQuestLogEntries;
local GetQuestLogTitle = GetQuestLogTitle;
local IsQuestComplete = IsQuestComplete;
local MAX_NUM_QUESTS = MAX_NUM_QUESTS;
local NUMGOSSIPBUTTONS = NUMGOSSIPBUTTONS;

local QuestFrameLines, QuestFrameLineIcons = {  }, {  };
for index = 1, MAX_NUM_QUESTS do
	local name = "QuestTitleButton" .. index;
	QuestFrameLines[index] = _G[name];
	QuestFrameLineIcons[index] = _G[name .. "QuestIcon"];
end
local GossipFrameLines, GossipFrameLineIcons = {  }, {  };
for index = 1, NUMGOSSIPBUTTONS do
	local name = "GossipTitleButton" .. index;
	GossipFrameLines[index] = _G[name];
	GossipFrameLineIcons[index] = _G[name .. "GossipIcon"];
end

QuestFrameGreetingPanel:HookScript(
	"OnShow",
	function()
		local QuestsInLog = {  };
		for index = 1, GetNumQuestLogEntries() do
			local name, _, _, _, _, completed, _, id = GetQuestLogTitle(index);
			if completed == 1 or (id > 0 and IsQuestComplete(id)) then
				QuestsInLog[name] = true;
			end
		end
		--
		for index = 1, MAX_NUM_QUESTS do
			local line = QuestFrameLines[index];
			if line:IsVisible() then
				local icon = QuestFrameLineIcons[index];
				if line.isActive == 1 then
					icon:SetTexture([[Interface\GossipFrame\ActiveQuestIcon]]);
					local name = gsub(line:GetText(), "|c%x%x%x%x%x%x%x%x(.+)|r", "%1");
					if QuestsInLog[name] then
						icon:SetDesaturated(nil);
					else
						icon:SetDesaturated(1);
					end
				else
					icon:SetTexture([[Interface\GossipFrame\AvailableQuestIcon]]);
					icon:SetDesaturated(nil);
				end
			end
		end
	end
);
hooksecurefunc(
	"GossipFrameUpdate",
	function()
		local QuestsInLog = {  };
		for index = 1, GetNumQuestLogEntries() do
			local name, _, _, _, _, completed, _, id = GetQuestLogTitle(index);
			if completed == 1 or (id > 0 and IsQuestComplete(id)) then
				QuestsInLog[name] = true;
			end
		end
		--
		for index = 1, NUMGOSSIPBUTTONS do
			local line = GossipFrameLines[index];
			if line:IsVisible() then
				local icon = GossipFrameLineIcons[index];
				if line.type == "Active" then
					local name = gsub(line:GetText(), "|c%x%x%x%x%x%x%x%x(.+)|r", "%1");
					if QuestsInLog[name] then
						icon:SetDesaturated(nil);
					else
						icon:SetDesaturated(1);
					end
				else
					icon:SetDesaturated(nil);
				end
			end
		end
	end
);
