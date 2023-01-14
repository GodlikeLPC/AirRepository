
U1RegisterAddon("AdvancedInterfaceOptions", {
    title = "高级界面设置",
    defaultEnable = 0,
    load = "NORMAL",

    tags = { "TAG_MANAGEMENT", },
    --icon = [[Interface\Icons\Ability_Rogue_FindWeakness]],
    desc = "提供一些高级界面设置、CVar设置，普通玩家不建议开启。",
    nopic = 1,
    runBeforeLoad = function(info, name)
        -- if AdvancedInterfaceOptionsSaved and AdvancedInterfaceOptionsSaved.AccountVars and AdvancedInterfaceOptionsSaved.AccountVars.scriptErrors then
        --     AdvancedInterfaceOptionsSaved.AccountVars.scriptErrors = "0";
        -- end
    end,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("AdvancedInterfaceOptions")
            InterfaceOptionsFrame_OpenToCategory("AdvancedInterfaceOptions")
        end,
    },
});
