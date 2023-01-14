U1RegisterAddon("ShowMeMyHeal", {
    title = "治疗数值显示",
    tags = { "TAG_COMBATINFO", },
    minimap = "LibDBIcon10_ShowMeMyHealIcon",
    desc = "治疗数值显示",
    load = "LOGIN",
    defaultEnable = 1,
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    nopic = 1,
    conflicts = { "dct", "Parrot", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if ShowMeMyHealSlashFunction then
                ShowMeMyHealSlashFunction("show");
            end
        end
    }
});
