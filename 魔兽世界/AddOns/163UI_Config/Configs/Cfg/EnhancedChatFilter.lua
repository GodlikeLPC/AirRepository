U1RegisterAddon("EnhancedChatFilter", {
    title = "聊天过滤",
    tags = { "TAG_CHAT", },
    desc = "关键字过滤和重复信息过滤",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    --minimap = 'LibDBIcon10_alaChat_Classic', 
    icon = [[Interface\chatframe\ui-chaticon-share]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("EnhancedChatFilter");
            InterfaceOptionsFrame_OpenToCategory("EnhancedChatFilter");
        end
    }
});
