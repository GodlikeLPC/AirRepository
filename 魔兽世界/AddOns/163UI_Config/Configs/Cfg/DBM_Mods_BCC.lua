U1RegisterAddon("DBM_Mods_BCC", {
    title = "DBM燃烧的远征",
    desc = "DBM首领模块, 2.0燃烧的远征",
    icon = [[Interface\Icons\INV_Helmet_06]],
    nopic = 1,
    tags = { "TAG_RAID", },
    defaultEnable = 1,
    nolodbutton = 1,
    dummy = 1,
    children = {
        "DBM-BlackTemple",
        "DBM-Hyjal",
        "DBM-Karazhan",
        "DBM-Outlands",
        "DBM-Party-BC",
        "DBM-Serpentshrine",
        "DBM-ZulAman",
        "DBM-Sunwell",
        "DBM-TheEye",
    },
    toggle = function(name, info, enable, justload)
    end,
});

U1RegisterAddon("DBM-BlackTemple", { title = '黑暗神殿', parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Hyjal", { title = "海加尔山之战", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Karazhan", { title = "卡拉赞", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Outlands", { title = "外域", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Party-BC", { title = "燃烧的远征5人副本", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Serpentshrine", { title = "毒蛇神殿", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-ZulAman", { title = "祖阿曼", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-Sunwell", { title = "太阳井高地", parent = "DBM_Mods_BCC", });
U1RegisterAddon("DBM-TheEye", { title = "风暴要塞", parent = "DBM_Mods_BCC", });

