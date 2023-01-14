U1RegisterAddon("DBM_Mods_Vanilla", {
    title = "DBM经典旧世",
    desc = "DBM首领模块, 1.0经典旧世",
    icon = [[Interface\Icons\INV_Helmet_06]],
    nopic = 1,
    tags = { "TAG_RAID", },
    defaultEnable = 1,
    nolodbutton = 1,
    dummy = 1,
    children = {
        "DBM-AQ20",
        "DBM-AQ40",
        "DBM-Azeroth",
        "DBM-BWL",
        "DBM-MC",
        -- "DBM-Naxx",
        "DBM-Onyxia",
        "DBM-Party-Vanilla",
        "DBM-ZG",
    },
    toggle = function(name, info, enable, justload)
    end,
});

U1RegisterAddon("DBM-AQ20", {title = '安其拉废墟', parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-AQ40", {title = "安其拉", parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-Azeroth", {title = "艾泽拉斯", parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-BWL", {title = "黑翼之巢", parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-MC", {title = "熔火之心", parent = "DBM_Mods_Vanilla", protected = 1, });
-- U1RegisterAddon("DBM-Naxx", {title = "纳克萨玛斯", parent = "DBM_Mods_Vanilla", protected = 1, });   --  移到WotLk
U1RegisterAddon("DBM-Onyxia", {title = "奥妮克希亚的巢穴", parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-Party-Vanilla", {title = "经典旧世5人副本", parent = "DBM_Mods_Vanilla", protected = 1, });
U1RegisterAddon("DBM-ZG", {title = "祖尔格拉布", parent = "DBM_Mods_Vanilla", protected = 1, });
