U1RegisterAddon("GTFO", {
    title = "站位提醒",
    defaultEnable = 0,
    load = "NORMAL",

    tags = { "TAG_COMBATINFO", },
    -- icon = [[Interface\Icons\inv_misc_pyriumgrenade]],
    desc = "自动声音提示站位危险插件.``修改部分：已修改为中文语音版``设置口令：/GTFO",
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            GTFO_Command_Options();
        end
    },
});
