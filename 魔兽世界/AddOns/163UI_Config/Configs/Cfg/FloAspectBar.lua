

U1RegisterAddon("FloAspectBar", {
    title = "猎人守护助手",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_HUNTER", },
    desc = "增加一个切换守护的动作条",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    toggle = function(name, info, enable, justload)
    end,

    {
        text = "重置",
        callback = function(cfg, v, loading)
            FLOASPECTBAR_OPTIONS = nil;
            FLOASPECTBAR_OPTIONS2 = nil;
            ReloadUI();
        end
    },

});
