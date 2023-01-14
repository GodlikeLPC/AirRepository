U1RegisterAddon("alaMisc", {
    title = "实用小功能",
    tags = { "TAG_MANAGEMENT", },
    desc = "提供副本爆本时间、怪物目标是玩家的提示",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    -- minimap = 'LibDBIcon10_alaChat_Classic', 
    -- icon = [[Interface\Addons\alaChat_Classic\icon\emote_nor]],

    runBeforeLoad = function(info, name)
        if __ala_meta__ and __ala_meta__.wa then
            __ala_meta__.wa.WA_WrapSetSubPath("alaMisc");
        end
        _G.SLASH_ALAWA3 = "/163wa";
    end,

    -- {
    --     text = "管理内置WA代码",
    --     callback = function(cfg, v, loading)
    --         if __ala_meta__ and __ala_meta__.wa then
    --             __ala_meta__.wa.toggleUI();
    --         end
    --     end
    -- },

    {
        var = 'instance_timer',
        text = '爆本时间',
        default = true,
        getvalue = function() return _163_ALAMISC_GETCONFIG("instance_timer", "enabled"); end,
        callback = function(cfg, v, loading)
            if loading then return end
            if v then
                SlashCmdList["ALAINSTANCETIMER"]("enable");
            else
                SlashCmdList["ALAINSTANCETIMER"]("disable");
            end
        end,
        {
            type = 'button',
            text = '重置位置',
            callback = function()
                if loading then return end
                SlashCmdList["ALAINSTANCETIMER"]("reset_pos");
            end,
        },
        {
            type = 'button',
            text = '锁定/解锁',
            callback = function()
                if loading then return end
                SlashCmdList["ALAINSTANCETIMER"]("toggle_lock");
            end,
        },
        -- {
        --     var = 'key_tip',
        --     text = '在鼠标提示中显示按键ALT/SHIFT提示',
        --     getvalue = function() return not _163_ALAMISC_GETCONFIG("instance_timer", "hide_key_tip"); end,
        --     callback = function(cfg, v, loading)
        --         if(loading) then return end
        --         if v then
        --             SlashCmdList["ALAINSTANCETIMER"]("show_key_tip");
        --         else
        --             SlashCmdList["ALAINSTANCETIMER"]("hide_key_tip");
        --         end
        --     end,
        -- },
        -- {
        --     var = 'notice',
        --     text = '在鼠标提示中显示额外提示，\124cff00ff00关闭前请确认已经阅读并知晓提示内容\124r',
        --     getvalue = function() return not _163_ALAMISC_GETCONFIG("instance_timer", "hide_notice"); end,
        --     callback = function(cfg, v, loading)
        --         if loading then return end
        --         if v then
        --             SlashCmdList["ALAINSTANCETIMER"]("show_notice");
        --         else
        --             SlashCmdList["ALAINSTANCETIMER"]("hide_notice");
        --         end
        --     end
        -- },
    },
    {
        var = 'target_warn',
        text = '怪物目标提示',
        default = false,
        getvalue = function() return _163_ALAMISC_GETCONFIG("target_warn", "enabled"); end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if v then
                SlashCmdList["ALAUNITWARN"]("on");
            else
                SlashCmdList["ALAUNITWARN"]("off");
            end
        end,
        {
            type = 'button',
            text = '锁定/解锁',
            callback = function()
                SlashCmdList["ALAUNITWARN"]("toggle_lock");
            end,
        },
        {
            type = 'button',
            text = '重置位置',
            callback = function()
                SlashCmdList["ALAUNITWARN"]("reset_pos");
            end,
        },
    },
    -- {
    --     var = 'honorKillColorName',
    --     text = '荣誉击杀职业染色',
    --     getvalue = function() return _163_ALAMISC_GETCONFIG("honor", "honorKillColorName"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         alaMiscSV.honor_sv.honorKillColorName = v;
    --     end,
    -- },
    -- {
    --     var = 'honorKillDetail',
    --     text = '荣誉击杀详细信息',
    --     getvalue = function() return _163_ALAMISC_GETCONFIG("honor", "honorKillDetail"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         alaMiscSV.honor_sv.honorKillDetail = v;
    --     end,
    -- },
});
