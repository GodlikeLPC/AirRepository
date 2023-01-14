U1RegisterAddon("TalentEmu", {
    title = "跨职业天赋模拟器",
    tags = { "TAG_INTERFACE", },
    desc = "天赋模拟器，可以模拟天赋、导出代码、导入代码、观察其他玩家天赋、应用模拟器天赋等。",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    minimap = 'LibDBIcon10_TalentEmu', 
    icon = [[Interface\AddOns\TalentEmu\Media\Textures\ICON]],

    {
        var = 'talents_in_tip',
        text = '鼠标提示中显示天赋',
        getvalue = false,
        getvalue = function() return __ala_meta__ and __ala_meta__.emu and __ala_meta__.emu.MT.GetConfig("talents_in_tip"); end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if __ala_meta__ and __ala_meta__.emu then
                __ala_meta__.emu.MT.SetConfig('talents_in_tip', v);
            end
        end,
        {
            var = "talents_in_tip_icon",
            text = "鼠标提示中以图片显示天赋",
            --tip = L["说明`这个值是修改"],
            default = true,
            getvalue = function() return __ala_meta__ and __ala_meta__.emu and __ala_meta__.emu.MT.GetConfig("talents_in_tip_icon"); end,
            callback = function(cfg, v, loading)
                if(loading) then return end
                if __ala_meta__ and __ala_meta__.emu then
                    __ala_meta__.emu.MT.SetConfig('talents_in_tip_icon', v);
                end
            end,
        },
    },

    {
        var = 'minimap',
        text = '小地图图标',
        getvalue = false,
        getvalue = function() return __ala_meta__ and __ala_meta__.emu and __ala_meta__.emu.MT.GetConfig("minimap"); end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if __ala_meta__ and __ala_meta__.emu then
                __ala_meta__.emu.MT.SetConfig('minimap', v);
            end
        end,
    },
});

U1RegisterAddon("alaTalentEmu", {
    title = "alaTalentEmu旧版本兼容",
    parent = "TalentEmu",
    defaultEnable = 1,
});


