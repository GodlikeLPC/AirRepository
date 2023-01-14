U1RegisterAddon("OmniBar", { 
    title = "敌对技能冷却监控",
    desc = "OmniBar 敌对技能冷却监控",
    load = "NORMAL",
    defaultEnable  = 0,
    tags = { "TAG_PVP", "TAG_SPELL", },
    icon = [[Interface\Icons\Spell_ChargeNegative]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("OmniBar")
            InterfaceOptionsFrame_OpenToCategory("OmniBar")
        end
    }
});

