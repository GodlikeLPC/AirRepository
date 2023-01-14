
U1RegisterAddon("SimpleUnitFrames", { 
    title = "Simple 头像增强",
    desc = "SimpleUnitFrames 头像增强",
    load = "NORMAL",
    defaultEnable  = 0,
    tags = { "TAG_UNITFRAME", },
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    conflicts = { "ShadowedUnitFrames", "UnitFramesPlus", "RealMobHealth", "alaUnitFrame", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("SimpleUnitFrames")
            InterfaceOptionsFrame_OpenToCategory("SimpleUnitFrames")
        end
    }
});

