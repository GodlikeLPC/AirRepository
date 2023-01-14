
U1RegisterAddon("BattleGroundEnemies", {
    title = "战场目标",
    tags = { "TAG_PVP", },
    desc = "显示战场玩家列表",
    load = "LOGIN",
    defaultEnable = 0,
    -- icon = [[Interface\Addons\VanasKoS\Artwork\tie]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            return SlashCmdList["BattleGroundEnemies"] and SlashCmdList["BattleGroundEnemies"]("");
        end
    }

});
