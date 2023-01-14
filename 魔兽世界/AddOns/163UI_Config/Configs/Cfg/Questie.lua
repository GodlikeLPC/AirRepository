U1RegisterAddon("Questie", {
    title = "任务百科指引 Questie",
    desc = "Questie 任务百科指引",
    tags = { "TAG_QUEST", },
    load = "LOGIN",
    defaultEnable = 0,
    icon = [[Interface\Addons\Questie\Icons\available]],
    nopic = 1,
    conflicts = { "CodexLite", "ButterQuestTracker", },
    minimap = 'LibDBIcon10_MinimapIcon', 

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Questie");
            InterfaceOptionsFrame_OpenToCategory("Questie");
        end
    }
});
