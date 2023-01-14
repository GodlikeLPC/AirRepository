U1RegisterAddon("UnitFramesPlus", { 
    title = "UFP 头像增强",
    desc = "UnitFramesPlus 头像增强",
    load = "NORMAL",
    defaultEnable  = 0,
    tags = { "TAG_UNITFRAME", },
    icon = [[Interface\Addons\UnitFramesPlus\MinimapButton]],
    conflicts = { "ShadowedUnitFrames", "SimpleUnitFrames", "alaUnitFrame", "RealMobHealth" },
    minimap = 'UFP_MinimapButton', 

    toggle = function(name, info, enable, justload)
        if enable then
            EnableAddOn("UnitFramesPlus_Options");
            EnableAddOn("UnitFramesPlus_Cooldown");
            EnableAddOn("UnitFramesPlus_MobHealth");
        end
    end, --如果未开插件，则初始不会调用。
    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if UnitFramesPlus_SlashHandler then
                EnableAddOn("UnitFramesPlus_Options");
                UnitFramesPlus_SlashHandler("");
            end
        end
    }
});
U1RegisterAddon("UnitFramesPlus_Options", {
    parent = "UnitFramesPlus",
    defaultEnable  = 0,
});
U1RegisterAddon("UnitFramesPlus_Cooldown", {
    parent = "UnitFramesPlus",
    defaultEnable  = 0,
});
U1RegisterAddon("UnitFramesPlus_MobHealth", {
    parent = "UnitFramesPlus",
    defaultEnable  = 0,
});
