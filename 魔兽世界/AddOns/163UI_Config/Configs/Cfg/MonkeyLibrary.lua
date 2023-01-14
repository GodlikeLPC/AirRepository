U1RegisterAddon("MonkeyLibrary", {
    title = "任务增强",
    desc = "任务增强。",
    tags = { "TAG_QUEST", },
    icon = [[Interface\Addons\MonkeyLibrary\Textures\MonkeyBuddyIcon]],
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    conflicts = { "QuestGuru", },
    minimap = 'LibDBIcon10_monkey_show', 
    runBeforeLoad = function(info, name)
        SetCVar("autoQuestProgress", "0");
        SetCVar("autoQuestWatch", "0");
        if LibStub then
            local icon = LibStub("LibDBIcon-1.0", true);
            if icon then
                icon:Register("monkey_show",
                {
                    icon = "Interface\\Addons\\MonkeyLibrary\\Textures\\MonkeyBuddyIcon",
                    OnClick = function(self, button)
                        if button == "LeftButton" then
                            if MonkeyQuestSlash_CmdOpen then
                                MonkeyQuestSlash_CmdOpen(not MonkeyQuestFrame:IsShown());
                            end
                        else
                            if MonkeyBuddy_ToggleDisplay then
                                MonkeyBuddy_ToggleDisplay();
                            end
                        end
                    end,
                    text = nil,
                    OnTooltipShow = function(tt)
                            tt:AddLine("MonkeyQuest");
                            tt:AddLine(" ");
                            tt:AddLine("左键打开关闭任务追踪窗口");
                            tt:AddLine("右键打开关闭设置界面");
                        end
                },
                {
                    minimapPos = 0,
                }
                );
            end
        end
        MonkeyBuddyConfig = MonkeyBuddyConfig or { ["Global"] = {  }, };
        MonkeyBuddyConfig["Global"]["m_bDismissed"] = true;
        MonkeyQuestConfig = MonkeyQuestConfig or {  };
        MonkeyQuestConfig["Global"] = MonkeyQuestConfig["Global"] or {
            ["m_bItemsEnabled"] = true,
            ["m_iFont"] = 2,
            ["m_strHeaderClosedColour"] = "|cffff d 0",
            ["m_strSpecialObjectiveColour"] = "|cFFFFFF00",
            ["m_iFrameAlpha"] = 0.799999952316284,
            ["m_bColourTitle"] = true,
            ["m_strAnchor"] = "ANCHOR_TOPLEFT",
            ["m_bAllowRightClick"] = false,
            ["m_strZoneHighlightColour"] = "|cff494961",
            ["m_strFinishObjectiveColour"] = "|cFF33DDFF",
            ["m_bShowHidden"] = true,
            ["m_bItemsOnLeft"] = true,
            ["m_bShowNoobTips"] = false,
            ["m_bHideCompletedObjectives"] = false,
            ["m_bShowZoneHighlight"] = true,
            ["m_strCompleteObjectiveColour"] = "|cFF00FF19",
            ["m_bAlwaysHeaders"] = true,
            ["m_bDisplay"] = true,
            ["m_bMinimized"] = false,
            ["m_bDefaultAnchor"] = false,
            ["m_strInitialObjectiveColour"] = "|cFFD82619",
            ["m_iHighlightAlpha"] = 1,
            ["m_bShowQuestLevel"] = true,
            ["m_bShowDailyNumQuests"] = false,
            ["m_iFrameBottom"] = 440.416961669922,
            ["m_bHideTitleButtons"] = true,
            ["m_iFrameLeft"] = 1184.00122070313,
            ["m_bColourDoneOrFailed"] = false,
            ["m_bLocked"] = false,
            ["m_bNoBorder"] = true,
            ["m_bNoHeaders"] = false,
            ["m_bShowTooltipObjectives"] = true,
            ["m_strOverviewColour"] = "|cFF7F7F7F",
            ["m_iQuestPadding"] = 0,
            ["m_bColourSubObjectivesByProgress"] = true,
            ["m_iFrameWidth"] = 256,
            ["m_iFontHeight"] = 15,
            ["m_strQuestTitleColour"] = "|cFFFFFFFF",
            ["m_bWorkComplete"] = true,
            ["m_bHideQuestsEnabled"] = true,
            ["m_strMidObjectiveColour"] = "|cFFFFFF00",
            ["m_bCrashBorder"] = false,
            ["m_strHeaderOpenColour"] = "|cffff 0 6",
            ["m_iFrameTop"] = 606.683654785156,
            ["m_bObjectives"] = true,
            ["m_bHideHeader"] = true,
            ["m_bShowNumQuests"] = true,
            ["m_iAlpha"] = 0,
            ["m_bShowQuestTextTooltip"] = false,
            ["m_bHideTitle"] = true,
            ["m_bHideCompletedQuests"] = false,
            ["m_bGrowUp"] = false,
        };
end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if MONKEYBUDDY_TITLE and type(MONKEYBUDDY_TITLE) == "string" then
                InterfaceOptionsFrame_Show();
                InterfaceOptionsFrame_OpenToCategory(MONKEYBUDDY_TITLE);
                InterfaceOptionsFrame_OpenToCategory(MONKEYBUDDY_TITLE);
            end
        end
    },

    {
        text = "使用预设",
        callback = function(cfg, v, loading)
            if MonkeyQuestConfig and type(MonkeyQuestConfig) == "table" then
                MonkeyQuestConfig["Global"] = {
                    ["m_bItemsEnabled"] = true,
                    ["m_iFont"] = 2,
                    ["m_strHeaderClosedColour"] = "|cffff d 0",
                    ["m_strSpecialObjectiveColour"] = "|cFFFFFF00",
                    ["m_iFrameAlpha"] = 0.799999952316284,
                    ["m_bColourTitle"] = true,
                    ["m_strAnchor"] = "ANCHOR_TOPLEFT",
                    ["m_bAllowRightClick"] = false,
                    ["m_strZoneHighlightColour"] = "|cff494961",
                    ["m_strFinishObjectiveColour"] = "|cFF33DDFF",
                    ["m_bShowHidden"] = true,
                    ["m_bItemsOnLeft"] = true,
                    ["m_bShowNoobTips"] = false,
                    ["m_bHideCompletedObjectives"] = false,
                    ["m_bShowZoneHighlight"] = true,
                    ["m_strCompleteObjectiveColour"] = "|cFF00FF19",
                    ["m_bAlwaysHeaders"] = true,
                    ["m_bDisplay"] = true,
                    ["m_bMinimized"] = false,
                    ["m_bDefaultAnchor"] = false,
                    ["m_strInitialObjectiveColour"] = "|cFFD82619",
                    ["m_iHighlightAlpha"] = 1,
                    ["m_bShowQuestLevel"] = true,
                    ["m_bShowDailyNumQuests"] = false,
                    ["m_iFrameBottom"] = 440.416961669922,
                    ["m_bHideTitleButtons"] = true,
                    ["m_iFrameLeft"] = 1184.00122070313,
                    ["m_bColourDoneOrFailed"] = false,
                    ["m_bLocked"] = false,
                    ["m_bNoBorder"] = true,
                    ["m_bNoHeaders"] = false,
                    ["m_bShowTooltipObjectives"] = true,
                    ["m_strOverviewColour"] = "|cFF7F7F7F",
                    ["m_iQuestPadding"] = 0,
                    ["m_bColourSubObjectivesByProgress"] = true,
                    ["m_iFrameWidth"] = 256,
                    ["m_iFontHeight"] = 15,
                    ["m_strQuestTitleColour"] = "|cFFFFFFFF",
                    ["m_bWorkComplete"] = true,
                    ["m_bHideQuestsEnabled"] = true,
                    ["m_strMidObjectiveColour"] = "|cFFFFFF00",
                    ["m_bCrashBorder"] = false,
                    ["m_strHeaderOpenColour"] = "|cffff 0 6",
                    ["m_iFrameTop"] = 606.683654785156,
                    ["m_bObjectives"] = true,
                    ["m_bHideHeader"] = true,
                    ["m_bShowNumQuests"] = true,
                    ["m_iAlpha"] = 0,
                    ["m_bShowQuestTextTooltip"] = false,
                    ["m_bHideTitle"] = true,
                    ["m_bHideCompletedQuests"] = false,
                    ["m_bGrowUp"] = false,
                };
                if MonkeyQuestSlash_CmdHideBorder then
                    MonkeyQuestSlash_CmdHideBorder(true);
                end
                if MonkeyQuestSlash_CmdHideTitleButtons then
                    MonkeyQuestSlash_CmdHideTitleButtons(true);
                end
                if MonkeyQuest_Refresh then
                    MonkeyQuest_Refresh();
                end
                if MonkeyBuddyQuestFrame_Refresh then
                    MonkeyBuddyQuestFrame_Refresh();
                end
            end
        end
    }
});
U1RegisterAddon("MonkeyQuest", {
    parent = "MonkeyLibrary",
    title = "任务窗口",
    --protected = 1,
    --hide = 1,
});
U1RegisterAddon("MonkeyQuestLog", {
    parent = "MonkeyLibrary",
    title = "任务日志窗口",
    --protected = 1,
    --hide = 1,
});
U1RegisterAddon("MonkeyBuddy", {
    parent = "MonkeyLibrary",
    title = "设置模块",
    --protected = 1,
    --hide = 1,
});
