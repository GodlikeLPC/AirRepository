U1RegisterAddon("alaChat", {
    title = "聊天增强",
    tags = { "TAG_CHAT", },
    desc = "提供聊天复制、职业着色、频道切换条、TAB切换频道、聊天表情等功能。\n按住CTRL拖动可以移动位置",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    minimap = 'LibDBIcon10_alaChat_Classic', 
    icon = [[Interface\Addons\alaChat\Media\Texture\emote_normal]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["ALACHAT"]();
        end
    },
    {
        text = "我看不到某个聊天了",
        callback = function(cfg, v, loading)
            local list = { EnumerateServerChannels() };
            for index = 1, NUM_CHAT_WINDOWS do
                if index ~= 2 then
                    local F = _G["ChatFrame" .. index];
                    if F ~= nil then
                        for _, channel in ipairs(list) do
                            ChatFrame_AddChannel(F, channel);
                        end
                    end
                end
            end
        end,
    },
    -- {
    --     text = "透明度",
    --     var = "alpha",
    --     default = 1,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("alpha"); end,
    --     type = "spin",
    --     range = { 0.10, 1.00, 0.05 },
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('alpha', v);
    --     end,
    -- },
    -- {
    --     text = "缩放比例",
    --     var = "scale",
    --     default = 1,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("scale"); end,
    --     type = "spin",
    --     range = { 0.00, 2.00, 0.05 },
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('scale', v);
    --     end,
    -- },
    -- {
    --     text = '位置',
    --     type = 'radio',
    --     var = 'position',
    --     default = 'BELOW_EDITBOX',
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("position"); end,
    --     options = {'输入框下方', 'BELOW_EDITBOX', '输入框上方', 'ABOVE_EDITOBX', "聊天框上方", "ABOVE_CHATFRAME"},
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('position', v);
    --     end
    -- },
    -- {
    --     text = '方向',
    --     type = 'radio',
    --     var = 'direction',
    --     default = 'HORIZONTAL',
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("direction"); end,
    --     options = {'水平', 'HORIZONTAL', '垂直', 'VERTICAL',},
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('direction', v);
    --     end
    -- },
    -- {
    --     var = 'shortChannelName',
    --     text = '短频道名',
    --     default = true,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("shortChannelName"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('shortChannelName', v);
    --     end,
    -- },
    -- {
    --     text = '短频道名格式',
    --     type = 'radio',
    --     var = 'shortChannelNameFormat',
    --     default = 'NW',
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("shortChannelNameFormat"); end,
    --     options = {'数字.中文', 'NW', '中文', 'W', "数字", "N"},
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('shortChannelNameFormat', v);
    --     end
    -- },
    -- {
    --     var = 'chatEmote',
    --     text = '聊天表情',
    --     default = false,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("chatEmote"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('chatEmote', v);
    --     end,
    -- },
    -- {
    --     var = 'channel_Ignore_Switch',
    --     text = '公共频道屏蔽按钮',
    --     default = true,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("channel_Ignore_Switch"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('channel_Ignore_Switch', v);
    --     end,
    -- },
    -- {
    --     var = 'bfWorld_Ignore_Switch',
    --     text = '世界频道屏蔽按钮',
    --     default = true,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("bfWorld_Ignore_Switch"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('bfWorld_Ignore_Switch', v);
    --     end,
    -- },
    -- {
    --     var = 'copy',
    --     text = '聊天复制',
    --     default = true,
    --     getvalue = function() return _163_ALACHAT_GETCONFIG("copy"); end,
    --     callback = function(cfg, v, loading)
    --         if(loading) then return end
    --         _163_ALACHAT_SETCONFIG('copy', v);
    --     end,
    -- },

});
U1RegisterAddon("alaChat_Classic", {
    title = "alaChat旧版本兼容",
    parent = "alaChat",
    defaultEnable = 1,
});
