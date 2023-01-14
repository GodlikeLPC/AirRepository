U1RegisterAddon("InstanceAchievementTracker", {
    title = "副本成就 InstanceAchievementTracker",
    desc = "",
    tags = { "TAG_QUEST", },
    load = "LOGIN",
    defaultEnable = 0,
    icon = [[Interface\Addons\InstanceAchievementTracker\Images\icon]],
    nopic = 1,
    minimap = 'LibDBIcon10_InstanceAchievementTracker', 

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            return SlashCmdList["IAT"] and SlashCmdList["IAT"]("");
        end
    }
});
