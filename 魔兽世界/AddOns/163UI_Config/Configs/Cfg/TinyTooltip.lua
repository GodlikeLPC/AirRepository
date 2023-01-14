U1RegisterAddon("TinyTooltip", {
    title = "鼠标提示增强TinyTooltip",
    defaultEnable = 1,
    load = "NORMAL",

    tags = { "TAG_INTERFACE", },
    --icon = [[Interface\Icons\INV_Misc_Toy_08]],
    desc = "高度可定制的提示信息增强插件。",
    nopic = 1,
    conflicts = { "TipTac", },

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["TinyTooltip"]("")
        end,
    },

    -- {
    --     var="disableMouseFollowWhenCombat",
    --     text="战斗时禁止鼠标跟随",
    --     tip="说明`在战斗时禁止提示框跟随鼠标，以避免造成视觉干扰，提示框会固定显示在屏幕的右下角（和魔兽原生机制一致）。",
    --     default=true,
    -- },

});
