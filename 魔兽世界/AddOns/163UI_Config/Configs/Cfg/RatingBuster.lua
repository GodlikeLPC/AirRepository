U1RegisterAddon("RatingBuster", {
    title = "装备属性转换",
    defaultEnable = 0,
    tags = { "TAG_INTERFACE", },
    icon = [[Interface\AddOns\RatingBuster\images\Sigma]],
    desc = "在鼠标提示中，将装备的副属性等级转换为百分比",
    nopic = 1,

    minimap = "LibDBIcon10_RatingBuster!",

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if SlashCmdList.ACECONSOLE_RATINGBUSTER then
                return SlashCmdList.ACECONSOLE_RATINGBUSTER("win");
            elseif SlashCmdList.RATINGBUSTER then
                return SlashCmdList.RATINGBUSTER();
            end
        end
    },
});

