U1RegisterAddon("Parrot", {
    title = "浮动战斗信息 Parrot",
    tags = { "TAG_COMBATINFO", },
    desc = "Parrot 浮动战斗信息",
    load = "LOGIN",
    defaultEnable = 0,
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    nopic = 1,
    conflicts = { "dct", "ShowMeMyHeal", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Parrot");
            InterfaceOptionsFrame_OpenToCategory("Parrot");
        end
    }
});
