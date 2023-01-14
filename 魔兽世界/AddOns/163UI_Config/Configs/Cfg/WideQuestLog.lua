U1RegisterAddon("WideQuestLog", {
    title = "任务界面增强",
    desc = "轻量专注的任务界面增强插件，将任务窗口拓展至原来的双倍宽度，任务列表和任务描述各占一列。配合子插件和QuestXP一同使用。",
    tags = { "TAG_QUEST", },
    -- icon = [[Interface\Addons\QuestLogEx\images\EQL3_BookIcon]],
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    conflicts = { "QuestGuru", "Classic Quest Log", "QuestLogEx", },
});
U1RegisterAddon("WideQuestLogLevels", {
    parent = "WideQuestLog",
    title = "WideQuestLog任务等级模块",
    desc = "为任务界面增强 WideQuestLog提供任务等级显示。",
    -- protected = 1,
    -- hide = 1,
});
