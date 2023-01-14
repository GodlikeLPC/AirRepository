U1RegisterAddon("FiveSecondRule", {
    title = "五秒回蓝助手",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_MAGE", "TAG_DRUID", "TAG_PRIEST", "TAG_WARLOCK", "TAG_PALADIN", "TAG_HUNTER", "TAG_SHAMAN", },
    desc = "显示五秒回蓝规则计时条。",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    runAfterLoad = function(info, name)
        if not FiveSecondRule_Options or 
        (FiveSecondRule_Options.barWidth == 117 and FiveSecondRule_Options.barHeight == 11 and FiveSecondRule_Options.barLeft == 90 and FiveSecondRule_Options.barTop == -68)
        then
            _G["Five Second Rule Statusbar"]:ClearAllPoints();
            _G["Five Second Rule Statusbar"]:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -3, -9);
        end
    end,
    classDisabled = { "WARRIOR", "ROGUE", },
    --frames = { "Five Second Rule Statusbar", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("FiveSecondRule");
            InterfaceOptionsFrame_OpenToCategory("FiveSecondRule");
        end
    }
});
