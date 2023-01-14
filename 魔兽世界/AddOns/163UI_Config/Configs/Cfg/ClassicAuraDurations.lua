U1RegisterAddon("ClassicAuraDurations", { 
    title = "目标Buff计时",
    desc = "显示目标Buff持续时间",
    load = "NORMAL",
    defaultEnable  = 1,
    tags = { "TAG_SPELL", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("ClassicAuraDurations")
            InterfaceOptionsFrame_OpenToCategory("ClassicAuraDurations")
        end
    }
});
