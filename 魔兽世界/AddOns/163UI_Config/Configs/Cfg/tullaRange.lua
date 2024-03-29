
U1RegisterAddon("tullaRange", {
    title = "技能超距提示",
    defaultEnable = 1,
    load = "NORMAL",

    tags = { "TAG_SPELL", },
    -- icon = [[Interface\Icons\Ability_Rogue_FindWeakness]],
    desc = "动作条技能距离提示插件，当你的法术或技能超出距离或者没有足够的法力值时，将该动作条按钮着色，颜色可以修改为你想要的任意颜色，在界面选项的插件里进行设置。",
    nopic = 1,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("tullaRange")
            InterfaceOptionsFrame_OpenToCategory("tullaRange")
        end,
    },
});
U1RegisterAddon("tullaRange_Config", {
    parent = "tullaRange",
    title = "tullaRange设置界面",
    -- desc = "tullaRange设置界面",
});
