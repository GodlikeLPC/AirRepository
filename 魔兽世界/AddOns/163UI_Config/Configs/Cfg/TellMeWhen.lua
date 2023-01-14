U1RegisterAddon("TellMeWhen", {
    title = "TMW 法术监控",
    defaultEnable = 0,
    load = "NORMAL",

    tags = { "TAG_SPELL", },
    icon = [[Interface\Addons\TellMeWhen\Textures\LDB Icon]],
    nopic = 1,

    toggle = function(name, info, enable, justload)
        return true
    end,

    {
        text = "切换锁定/解锁",
        tip = "快捷命令:`/tmw",
        callback = function()
            TMW:SlashCommand("")
        end
    },

    {
        text = "TMW选项",
        tip = "快捷命令:`/tmw options",
        callback = function()
            TMW:SlashCommand("options")
        end
    },
});

U1RegisterAddon("TellMeWhen_Options", {
    parent = "TellMeWhen",
    title = "TMW设置界面",
    desc = "TMW设置界面",
    -- hide = 1,
    -- protected = 1
})