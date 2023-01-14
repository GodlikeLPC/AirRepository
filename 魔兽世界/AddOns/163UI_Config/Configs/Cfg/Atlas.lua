U1RegisterAddon("Atlas", {
    title = "副本地图浏览器",
    defaultEnable = 1,
    secure = 1,
    load = "NORMAL",
    deps = { "Atlas_ClassicWoW", },
    minimap = "LibDBIcon10_Atlas",
  
    tags = { "TAG_MAP", },
    icon = [[Interface\WorldMap\worldmap-icon]],
    desc = "浏览观看副本内地图",

});
U1RegisterAddon("Atlas_ClassicWoW", {
    --parent = "Atlas",
    --load = "NORMAL",
    title = "经典旧世副本地图",
    --desc = "暂时不能更改权限, 如有需要请关闭该子插件",
    defaultEnable = 1,
    --hide = 1,
});
U1RegisterAddon("Atlas_BurningCrusade", {
    --parent = "Atlas",
    --load = "NORMAL",
    title = "TBC副本地图",
    --desc = "暂时不能更改权限, 如有需要请关闭该子插件",
    defaultEnable = 1,
    --hide = 1,
});
