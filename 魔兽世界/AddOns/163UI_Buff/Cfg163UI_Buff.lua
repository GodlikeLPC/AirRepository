U1RegisterAddon("163UI_Buff", {
    title = "增益设置",
    defaultEnable = 1,

    tags = { "TAG_SPELL", },
    icon = [[Interface\AddOns\163UI_Buff\Achievement_Reputation_KirinTor]],

    author = "SonicBuff",
    modifier = "|cffcd1a1c[网易]|r",

    desc = "玩家的增益效果和负面效果显示精确到秒，无持续时间的状态可以显示'N/A'。``鼠标移动到状态图标上可以显示此效果的施法者",

    -------- Options --------
    {
        text = "重置以下选项为默认值",
        confirm = "恢复默认设置并重新加载界面？",
        callback = function(cfg, v, loading)
            SetCVar("buffDurations", 1)
            SetCVar("noBuffDebuffFilterOnTarget", 0)
            U1CfgResetAddOn("163UI_Buff")
        end,
    },
    {
        var = "spellID",
        default = 1,
        text = "显示法术ID",
        callback = function(cfg, v, loading)
            if v then
                _G["163UI_Buff"].SpellID[1]();
            else
                _G["163UI_Buff"].SpellID[2]();
            end
        end,
    },
    {
        var = "caster",
        default = 1,
        text = "显示BUFF的施放者",
        callback = function(cfg, v, loading)
            if v then
                _G["163UI_Buff"].CastBy[1]();
            else
                _G["163UI_Buff"].CastBy[2]();
            end
        end,
    },
    {
        var = "mount",
        default = 1,
        text = "显示座骑来源",
        visible = select(4, GetBuildInfo()) >= 70000,
        callback = function(cfg, v, loading)
            if v then
                _G["163UI_Buff"].MountTip[1]();
            else
                _G["163UI_Buff"].MountTip[2]();
            end
        end,
    },
    {
        text = "玩家增益时间设置", type = "text",
        U1CfgMakeCVarOption("显示BUFF持续时间", "buffDurations", {
            tip = "说明`请通过默认的设置界面进行设置",
            default = 1,
            reload = 1,
            {
                var = "na",
                default = 1,
                text = "无时间的显示为N/A",
                callback = function(cfg, v, loading)
                    if v then
                        _G["163UI_Buff"]['BuffFrame-NA'][1](loading);
                    else
                        _G["163UI_Buff"]['BuffFrame-NA'][2](loading);
                    end
                end,
            },
            {
                var = "time",
                default = 1,
                text = "BUFF时间精确到秒",
                callback = function(cfg, v, loading)
                    if v then
                        _G["163UI_Buff"]['BuffFrame-Seconds'][1](loading);
                    else
                        _G["163UI_Buff"]['BuffFrame-Seconds'][2](loading);
                    end
                end,
                {
                    var = 'time10',
                    default = nil,
                    text = '十分钟以上不显示秒',
                    callback = function(cfg, v, loading)
                        if not v then
                            _G["163UI_Buff"]['BuffFrame-SecondsGE10'][1](loading);
                        else
                            _G["163UI_Buff"]['BuffFrame-SecondsGE10'][2](loading);
                        end
                    end,
                },
            },
            {
                var = "buffSize",
                default = 11,
                type = "spin",
                tip = "说明`调整美化后的增益减益下面的计时文字尺寸。",
                range = { 1, 32, 1, },
                text = "BUFF时间文字大小",
                callback = function(cfg, v, loading)
                    _G["163UI_Buff"]['BuffFrame-FontSize'][3](cfg, v, loading);
                end,
            },
        }),
    },

    {
        text = "目标增益减益设置",
        type = "text",
        U1CfgMakeCVarOption("显示目标所有BUFF/DEBUFF", "noBuffDebuffFilterOnTarget", {
            tip = "说明`显示所有状态而不仅仅是你施放的。",
            reload = false,
        }),
        {
            var = "targetBuffCooldownCount",
            text = "显示目标BUFF计时数字",
            default = 1,
            tip = "说明`显示计时数字需要开启OmniCC，而且如果图标设置过小会自动隐藏计时数字。",
            callback = function(cfg, v, loading)
                if v then
                    _G['163UI_Buff']['Cooldown-Buff'][1](loading);
                    if not loading and not IsAddOnLoaded("OmniCC") then
                        U1Message("显示计时数字需要开启OmniCC【技能冷却计时】");
                    end
                else
                    _G['163UI_Buff']['Cooldown-Buff'][2](loading);
                end
            end
        },
        {
            var = "BuffSize",
            text = "调整系统默认的Buff大小",
            default = 1,
            callback = function(cfg, v, loading)
                if v then
                    _G['163UI_Buff']['LargeAura-Buff'][1](loading);
                else
                    _G['163UI_Buff']['LargeAura-Buff'][2](loading);
                end
            end,
            {
                var = "largeBuffSize",
                type = "spin",
                range = { 15, 36, 1, },
                text = "玩家施放的BUFF大小",
                tip = "说明`玩家释放在目标上的负面效果的图标大小，注意不会根据新值调整换行，所以调整过大可能会影响布局效果。`默认值21",
                default = 21,
                callback = function(cfg, value, loading)
                    _G['163UI_Buff']['LargeAura-BuffLargeSize'][3](cfg, value, loading);
                end
            },
            {
                var = "smallBuffSize",
                type = "spin",
                range = { 12, 24, 1, },
                text = "其他人施放的BUFF大小",
                tip = "说明`默认值17",
                default = 17,
                callback = function(cfg, value, loading)
                    _G['163UI_Buff']['LargeAura-BuffSmallSize'][3](cfg, value, loading);
                end
            },
        },
        {
            var = "targetDebuffCooldownCount",
            text = "显示目标DEBUFF计时数字",
            default = 1,
            tip = "说明`显示计时数字需要开启OmniCC，而且如果图标设置过小会自动隐藏计时数字。",
            callback = function(cfg, v, loading)
                if v then
                    if not loading and not IsAddOnLoaded("OmniCC") then
                        U1Message("显示计时数字需要开启OmniCC【技能冷却计时】");
                    end
                    _G['163UI_Buff']['Cooldown-Debuff'][1](loading);
                else
                    _G['163UI_Buff']['Cooldown-Debuff'][2](loading);
                end
            end
        },
        {
            var = "DebuffSize",
            text = "调整系统默认的Debuff大小",
            default = 1,
            callback = function(cfg, v, loading)
                if v then
                    _G['163UI_Buff']['LargeAura-Debuff'][1](loading);
                else
                    _G['163UI_Buff']['LargeAura-Debuff'][2](loading);
                end
            end,
            {
                var = "largeDebuffSize",
                type = "spin",
                range = { 15, 36, 1, },
                text = "玩家施放的DEBUFF大小",
                tip = "说明`玩家释放在目标上的负面效果的图标大小，注意不会根据新值调整换行，所以调整过大可能会影响布局效果。`默认值21",
                default = 21,
                callback = function(cfg, value, loading)
                    _G['163UI_Buff']['LargeAura-DebuffLargeSize'][3](cfg, value, loading);
                end
            },
            {
                var = "smallDebuffSize",
                type = "spin",
                range = { 12, 24, 1, },
                text = "其他人施放的DEBUFF大小",
                tip = "说明`默认值17",
                default = 17,
                callback = function(cfg, value, loading)
                    _G['163UI_Buff']['LargeAura-DebuffSmallSize'][3](cfg, value, loading);
                end
            },
        },
    },

    {
        text = "其他增益相关设置", type = "text",
        -- {
        --     text = "隐藏姓名板DEBUFF图标",
        --     tip = "说明`隐藏怪物血条上方的DEBUFF图标",
        --     var = "hideNameplateDebuff",
        --     default = false,
        --     callback = function(cfg, v, loading)
        --         if v and Buff163_StartHookNamePlates then
        --             Buff163_StartHookNamePlates()
        --             Buff163_StartHookNamePlates = nil
        --         end
        --     end
        -- },
        {
            text = "显示TOT状态层数",
            tip = "说明`开启此选项则显示目标的目标的Debuff状态层数，不开启则显示剩余时间。",
            var = "totdebuffcount",
            reload = 1,
            callback = function(cfg, v, loading)
                if v then
                    _G['163UI_Buff'].ToTDebuffCount[1]();
                elseif not loading then
                    _G['163UI_Buff'].ToTDebuffCount[2]();
                end
            end
        },
    }
});
