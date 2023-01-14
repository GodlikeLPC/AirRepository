U1RegisterAddon("BigDebuffs", {
    title = "控制技能提示",
    load = "NORMAL",
    defaultEnable = 0,

    tags = { "TAG_PVP", },
    -- icon = [[Interface\Icons\Spell_Nature_HeavyPolymorph2]],
    desc = "在头像上提示控制技能图标及其剩余时间。",
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("BigDebuffs")
            InterfaceOptionsFrame_OpenToCategory("BigDebuffs")
        end
    }
});
