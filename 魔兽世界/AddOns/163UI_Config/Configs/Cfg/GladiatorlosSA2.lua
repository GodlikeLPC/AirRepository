U1RegisterAddon("GladiatorlosSA2", {
    title = "PVP语音提示",
    defaultEnable = 0,
    optionsAfterLogin = 1,
    load = "NORMAL",

    tags = { "TAG_PVP", },
    icon = [[Interface\Icons\Achievement_General_StayClassy]],
    desc = "语音提示所有与PVP相关的地方玩家技能，例如控制、打断之类。默认仅在竞技场启用，请使用/gsa命令打开配置界面进行修改。`也可以详细选择要警报的技能列表，同样在配置界面中修改。",

    runBeforeLoad = function(info, name)
        EnableAddOn("GladiatorlosSA_zhCN");
        LoadAddOn("GladiatorlosSA_zhCN");
    end,
    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。

    {
        text = "配置选项",
        -- tip = "快捷命令`/gsa",
        callback = function(cfg, v, loading)
            -- GladiatorlosSA:ShowConfig2()
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("GladiatorlosSA");
            InterfaceOptionsFrame_OpenToCategory("GladiatorlosSA");
        end,
    },
    {
        text = "选择性启用语音警报",
        var = "notall",
        default = 1,
        getvalue = function() return not GladiatorlosSA.db1.profile.all end,
        callback = function(cfg, v, loading) GladiatorlosSA.db1.profile.all = not v end,
        {
            text = "在竞技场中启用",
            var = "arena",
            default = 1,
            getvalue = function() return GladiatorlosSA.db1.profile.arena end,
            callback = function(cfg, v, loading) GladiatorlosSA.db1.profile.arena = not not v end,
        },
        {
            text = "在战场中启用",
            var = "battleground",
            getvalue = function() return GladiatorlosSA.db1.profile.battleground end,
            callback = function(cfg, v, loading) GladiatorlosSA.db1.profile.battleground = not not v end,
        },
        {
            text = "在野外启用",
            var = "field",
            getvalue = function() return GladiatorlosSA.db1.profile.field end,
            callback = function(cfg, v, loading) GladiatorlosSA.db1.profile.field = not not v end,
        },
    },
});

U1RegisterAddon("GladiatorlosSA2_zhCN", {title = "vv语音包", parent = "GladiatorlosSA2", protected = nil, });
