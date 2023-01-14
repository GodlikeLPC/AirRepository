U1RegisterAddon("dct", {
    title = "伤害显示 DCT",
    tags = { "TAG_COMBATINFO", },
    desc = "伤害显示 DCT",
    load = "LOGIN",
    defaultEnable = 0,
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    nopic = 1,
    conflicts = { "ShowMeMyHeal", "Parrot", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if DCT_showMenu then
                DCT_showMenu();
            end
        end
    }
});
U1RegisterAddon("dct_damage", {
    parent = "dct",
    title = "DCT伤害模块",
    desc = "DCT伤害模块",
    --protected = 1,
    --hide = 1,
});
U1RegisterAddon("dct_options", {
    parent = "dct",
    title = "DCT设置模块",
    desc = "DCT设置模块",
    -- protected = 1,
    -- hide = 1,
});
U1RegisterAddon("dct_spellAlert", {
    parent = "dct",
    title = "DCT法术预警模块",
    desc = "DCT法术预警模块",
    -- protected = 1,
    -- hide = 1,
});
