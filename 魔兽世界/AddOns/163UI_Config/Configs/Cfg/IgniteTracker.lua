U1RegisterAddon("IgniteTracker", {
    title = "法师点燃助手",
    desc = "IgniteTracker 法师点燃助手",
    tags = { "TAG_SPELL", "TAG_CLASS", "TAG_MAGE", },
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "锁定/解锁",
        callback = function(cfg, v, loading)
            if lockStatus == 1 then
                SlashCmdList["IgniteTracker"]("unlock")
            else
                SlashCmdList["IgniteTracker"]("lock")
            end
        end
    }

});
