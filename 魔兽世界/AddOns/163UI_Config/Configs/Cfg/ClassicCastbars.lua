U1RegisterAddon("ClassicCastbars", { 
    title = "目标和姓名版施法条",
    desc = "ClassicCastbars 模拟显示目标施法条",
    load = "NORMAL",
    defaultEnable  = 1,
    tags = { "TAG_ACTIONBUTTONCASTBAR", },
    icon = [[Interface\Icons\Spell_ChargeNegative]],

    toggle = function(name, info, enable, justload)
        if enable then
            EnableAddOn("ClassicCastbars_Options")
            LoadAddOn("ClassicCastbars_Options")
        end
        return true
    end,
    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("ClassicCastbars")
        end
    }
});

U1RegisterAddon("ClassicCastbars_Options", {
    parent = "ClassicCastbars",
    hide = 1,
});
