U1RegisterAddon("TradeLog", {
    title = "交易记录及交易界面增强",
    desc = "交易后显示交易的详细情况，也可选择发送到频道中。另外，在交易窗口旁边可以列出与此人近期的交易，防止重复交易。`通过小地图按钮还可打开详细的交易历史记录界面。",
    tags = { "TAG_TRADING", },
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Coin_01]],
    -- minimap = "LibDBIcon10_TradeLog",
    nopic = 1,

    runBeforeLoad = function(info, name)
        if TradeListFrame ~= nil then
            _163_PreventOutOfScreen(TradeListFrame, { "TOPLEFT", 0, -104, });
        end
    end,

    {
        text = '选择通知发送方式',
        type = 'radio',
        var = 'direction',
        default = 'WHISPER',
        getvalue = function() return TradeLog_Announce_Checked and TradeLog_AnnounceChannel or 'NONE'; end,
        options = {
            '不发送', 'NONE',
            '密语', 'WHISPER',
            '团队', 'RAID',
            '小队', 'PARTY',
            '说', 'SAY',
            '喊', 'YELL',
        },
        callback = function(cfg, v, loading)
            if(loading) then return end
            if v == 'NONE' then
                TBT_AnnounceCB:SetChecked(false);
                TradeLog_Announce_Checked = false;
            else
                TBT_AnnounceCB:SetChecked(true);
                TradeLog_Announce_Checked = true;
                TBT_AnnounceChannelDropDown_OnClick({ value = v, });
            end
        end
    },
});
