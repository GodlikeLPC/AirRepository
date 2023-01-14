

U1RegisterAddon("TotemTimers", {
    title = "萨满图腾助手",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_SHAMAN", },
    desc = "萨满图腾助手",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    toggle = function(name, info, enable, justload)
    end,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("TotemTimers")
            InterfaceOptionsFrame_OpenToCategory("TotemTimers")
        end,
    },
});
