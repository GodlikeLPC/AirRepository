U1RegisterAddon("MarkMe", {
    title = "团队标记助手",
    desc = "MarkMe 团队标记助手",
    tags = { "TAG_RAID", },
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    runBeforeLoad = function(info, name)
        Use_Fade_Num:SetAutoFocus(false);
        Announce_Skull_Msg:SetAutoFocus(false);
        Announce_Cross_Msg:SetAutoFocus(false);
        Announce_Square_Msg:SetAutoFocus(false);
        Announce_Moon_Msg:SetAutoFocus(false);
        Announce_Triangle_Msg:SetAutoFocus(false);
        Announce_Diamond_Msg:SetAutoFocus(false);
        Announce_Circle_Msg:SetAutoFocus(false);
        Announce_Star_Msg:SetAutoFocus(false);
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Mark Me");
            InterfaceOptionsFrame_OpenToCategory("Mark Me");
        end
    }
});
