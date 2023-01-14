U1RegisterAddon("ButterQuestTracker", {
    title = "奶油任务增强",
    desc = "奶油任务增强。",
    tags = { "TAG_QUEST", },
    icon = [[Interface\Addons\ButterQuestTracker\Media\BQT_logo]],
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    conflicts = { "MonkeyLibrary", "MonkeyQuest", "MonkeyQuestLog", "Questie", },

    runBeforeLoad = function(info, name)
        if ButterQuestTrackerConfig == nil then
            ButterQuestTrackerConfig = {
                global = {
                    PositionX = -80,
                    PositionY = -220,
                },
            };
        end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("ButterQuestTracker");
            InterfaceOptionsFrame_OpenToCategory("ButterQuestTracker");
        end
    },

});
