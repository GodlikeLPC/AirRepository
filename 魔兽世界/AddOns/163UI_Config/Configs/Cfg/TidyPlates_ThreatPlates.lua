U1RegisterAddon("TidyPlates_ThreatPlates", {
    title = "Threat Plates 姓名板",
    defaultEnable = 0,
    load = "NORMAL",
    tags = { "TAG_UNITFRAME", },
    -- icon = [[Interface\AddOns\NeatPlates\media\NeatPlatesIcon]],
    nopic = 1,
    conflicts = { "NeatPlates" },
    desc = "Threat Plates 姓名版",
    {
        type = 'button',
        text = '配置选项',
        callback = function()
            TidyPlatesThreat:ChatCommand("")
        end,
    },

});
