
U1RegisterAddon("alaUnitFrame", {
    title = "简易头像增强",
    defaultEnable = 1,
    load = "NORMAL",

    tags = { "TAG_UNITFRAME", },
    --icon = [[Interface\Icons\Ability_Rogue_FindWeakness]],
    desc = "简易头像增强，根据生命值给血条染色、显示职业图标、生命值百分比、移动头像位置等。",
    nopic = 1,
    conflicts = { "UnitFramesPlus", "SimpleUnitFrames", "ShadowedUnitFrames", "RealMobHealth", "LunaUnitFrames", },

    runBeforeLoad = function(info, name)
        if (alaUnitFrameSV == nil or alaUnitFrameSV.__seen == nil or alaUnitFrameSV.__seen[UnitGUID('player')] == nil) and TargetFrame ~= nil and not TargetFrame:IsUserPlaced() then
            TargetFrame:SetUserPlaced(true);
            TargetFrame:ClearAllPoints();
            TargetFrame:SetPoint("LEFT", PlayerFrame, "RIGHT", 100, 0);
        end
    end,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("alaUnitFrame")
            InterfaceOptionsFrame_OpenToCategory("alaUnitFrame")
        end,
    },
});
