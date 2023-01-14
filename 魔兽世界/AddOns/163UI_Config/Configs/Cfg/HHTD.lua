U1RegisterAddon("HHTD", {
    title = "治疗必须死",
    defaultEnable = 0,

    tags = { "TAG_PVP", },
    desc = "在敌方治疗玩家的头上显示标记。",
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if SlashCmdList["ACECONSOLE_HHTD"] then
                SlashCmdList["ACECONSOLE_HHTD"]("ShowGUI");
            end
        end
    }

});

U1RegisterAddon("Healers-Have-To-Die", { hide = true, protected = true })