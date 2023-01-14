U1RegisterAddon("!!!163UI.3dcodecmd!!!", {
    title = "有爱客户端通讯",
    defaultEnable = 1,

    tags = { "TAG_MANAGEMENT", },
    icon = [[Interface\AddOns\163UI_Buff\Achievement_Reputation_KirinTor]],

    author = "alee",
    modifier = "|cffcd1a1c[网易]|r",

    desc = "为有爱客户端高级功能提供支持``在任务界面增加一个查询攻略按钮，开启有爱客户端时，点击按钮将弹出任务攻略。",

    -- {
    --     text = "在座骑列表中查看攻略",
    --     callback = function(cfg, v, loading)
    --         if not IsAddOnLoaded("Blizzard_Collections") then
    --             CollectionsJournal_LoadUI();
    --         end
    --         if not InCombatLockdown() then
    --             if not CollectionsJournal:IsVisible() then
    --                 ToggleFrame(CollectionsJournal);
    --             end
    --             CollectionsJournal_SetTab(CollectionsJournal, 1);
    --         end
    --     end
    -- },
});
