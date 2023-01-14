U1RegisterAddon("alaCalendar", {
    title = "日历",
    tags = { "TAG_INTERFACE", },
    desc = "显示副本重置事件、节日开始和结束时间，账号下所有角色的副本进度信息。",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    minimap = 'LibDBIcon10_alaCalendar', 
    icon = [[interface\AddOns\alaCalendar\ARTWORK\ICON]],

    {
        text = '首列星期几',
        type = 'radio',
        var = 'first_col_day',
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                return alaCalendarSV.set.first_col_day;
            end
        end,
        options = {
            '星期一', 1,
            '星期二', 2,
            '星期三', 3,
            '星期四', 4,
            '星期五', 5,
            '星期六', 6,
            '星期日', 0,
        },
        callback = function(cfg, v, loading)
            if(loading) then return end
            SlashCmdList["ALACALENDAR"]("setfirstcolday" .. v);
        end
    },
    {
        var = 'instance_icon',
        text = '在日历上显示副本小图标',
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                local val = alaCalendarSV.set.instance_icon;
                if val == false then
                    return false;
                else
                    return true;
                end
            end
        end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if v then
                SlashCmdList["ALACALENDAR"]("setinstanceicontrue");
            else
                SlashCmdList["ALACALENDAR"]("setinstanceiconfalse");
            end
        end,
    },
    {
        var = 'instance_icon',
        text = '在日历上显示副本名称',
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                local val = alaCalendarSV.set.instance_text;
                if val == false then
                    return false;
                else
                    return true;
                end
            end
        end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if v then
                SlashCmdList["ALACALENDAR"]("setinstancetexttrue");
            else
                SlashCmdList["ALACALENDAR"]("setinstancetextfalse");
            end
        end,
    },
    {
        var = 'dbIcon',
        text = '小地图图标',
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                local val = alaCalendarSV.set.showdbicon;
                if val == false then
                    return false;
                else
                    return true;
                end
            end
        end,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if v then
                SlashCmdList["ALACALENDAR"]("setshowdbicontrue");
            else
                SlashCmdList["ALACALENDAR"]("setshowdbiconfalse");
            end
        end,
    },
    {
        text = "缩放比例",
        var = "scale",
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                return alaCalendarSV.set.first_col_day;
            end
        end,
        type = "spin",
        range = { 0.00, 1.00, 0.05 },
        callback = function(cfg, v, loading)
            if(loading) then return end
            SlashCmdList["ALACALENDAR"]("setscale" .. v);
        end,
    },
    {
        text = "透明度",
        var = "alpha",
        getvalue = function()
            if alaCalendarSV and alaCalendarSV.set then
                return alaCalendarSV.set.first_col_day;
            end
        end,
        type = "spin",
        range = { 0.00, 1.00, 0.05 },
        callback = function(cfg, v, loading)
            if(loading) then return end
            SlashCmdList["ALACALENDAR"]("setalpha" .. v);
        end,
    },


});

