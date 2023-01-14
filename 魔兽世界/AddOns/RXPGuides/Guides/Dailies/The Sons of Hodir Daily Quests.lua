RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 霍迪尔之子每日任务路线

step
	+要解锁霍迪尔之子每日任务，你必须首先在风暴峰完成他们的任务链。请使用Hodir之子解锁每日任务指南解锁每日任务
	.isQuestAvailable 13047
step
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmooth、Hodir-'s Spear和 贪婪的安格里姆 交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.daily 12994 >>接任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.daily 13003 >>接任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.daily 13046 >>接任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.reputation 1119,revered,<0,1 -- if you're 0 into revered it will display this step
	.isQuestTurnedIn 13047
step
	>>与Fjorn铁砧、Hodir之角、Hodir's Helm、Frostworg Denmother和Hodir's Spear交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.daily 12994 >>接任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.daily 13003 >>接任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.reputation 1119,honored,<0,1 -- if you're 0 into honored it will display this step
	.isQuestTurnedIn 13047
step
	>>与Fjorn铁砧、Hodir角和Hodir头盔交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.reputation 1119,friendly,<0,1 -- if you're 0 into friendly it will display this step
	.isQuestTurnedIn 13047
step
	.goto TheStormPeaks,70.00,58.00,60,0
    .goto TheStormPeaks,70.14,61.16
	>>杀死脆性叛徒。掠夺他们以获取冰的精华
	.collect 42246,6 --Essence of Ice (6)
	.isOnQuest 12981
step
	.goto TheStormPeaks,73.5,62.9,70,0
    .goto TheStormPeaks,76.2,63.4
	.use 42246 >>使用弗约恩铁砧周围阴燃残渣旁边的冰块精华。掠夺冷冻铁屑
    .complete 12981,1 --Frozen Iron Scrap (6)
	.isOnQuest 12981
step
    .goto TheStormPeaks,70.73,50.96,65,0
	.goto TheStormPeaks,73.00,49.05,65,0
    .goto TheStormPeaks,71.45,47.76
	.use 42164 >>杀死该地区的尼弗莱姆祖先和不安的弗罗斯特伯恩。用你袋子里的霍迪尔号角放在他们的尸体上解救他们
    .complete 12977,1 --Niffelem Forefather freed (5)
    .complete 12977,2 --Restless Frostborn freed (5)
	.isOnQuest 12977
step
	#completewith next
    .goto TheStormPeaks,57.23,64.02
	.use 42479 >>用你袋子里的虫牙放在堕落的虫子尸体上。跟随以太霜虫，直到它追踪到一个暴风渗透者，然后杀死它。
	.complete 12994,1 --Stormforged Infiltrators Slain (3)
	.isOnQuest 12994
step
	.goto TheStormPeaks,57.92,61.07,60,0
	.goto TheStormPeaks,57.83,63.59,60,0
	.goto TheStormPeaks,56.51,65.00
	.use 42774 >>在Roaming Jormungar上使用包中的Arngrim牙齿。伤害它30%或更少的生命值，但不要杀死它
	.complete 13046,1 --Arngrim's spirit fed (5)
	.isOnQuest 13046
step
    .goto TheStormPeaks,57.23,64.02
	.use 42479 >>用你袋子里的虫牙放在堕落的虫子尸体上。跟随以太霜虫，直到它追踪到一个暴风渗透者，然后杀死它。
	.complete 12994,1 --Stormforged Infiltrators Slain (3)
	.isOnQuest 12994
step
	.goto TheStormPeaks,55.84,63.94,50,0
    .goto TheStormPeaks,54.4,63.2
	>>在冬眠洞穴杀死粘性油。掠夺他们的石油
    .complete 13006,1 --Viscous Oil (5)
	.isOnQuest 13006
step
	.goto TheStormPeaks,58.67,60.64,60,0
	.goto TheStormPeaks,57.23,64.02,60,0
	.goto TheStormPeaks,55.94,65.69,60,0
	.goto TheStormPeaks,59.25,59.94
	.use 42769 >>用包里的霍迪尔之矛钩住一只野生蠕虫。在做这件事之前，确保你完全健康
	>>反复使用“抓握”(1)提高抓握力。当wyrm向你挥舞时，使用道奇爪(2)。冷却时使用推力矛(3)和复仇矛推力(4)
	>>请记住持续抓取(1)，否则如果您仅使用(3)和(4)垃圾邮件攻击，您将掉落！
	>>一旦野妖低于30%，你的攻击栏就会改变。使用撬开钳口(1)五次，然后使用致命一击(3)。如果致命一击失败，继续使用撬开钳口(1)，直到致命一击冷却就绪(3)
	.complete 13003,1 --Stormforged Infiltrators Slain (3)
	.isOnQuest 13003
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmooth、Hodir-'s Spear和 贪婪的安格里姆 交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.turnin 13003 >>交任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 12994
	.isQuestComplete 13003
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的号角、Hodir's Helm、Hodir-'s Spear和 贪婪的安格里姆 交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 13003 >>交任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 13003
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn铁砧、Hodir之角、Hodir's Helm、Frostworg Denmother和Hodir's Spear交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.turnin 13003 >>交任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.isQuestComplete 12994
	.isQuestComplete 13003
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmourt和 贪婪的安格里姆 交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 12994
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的号角、Hodir's Helm和Insatible的Arngrim交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,65.00,60.95
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn铁砧、Hodir角、Hodir's头盔和Hodir长矛对话
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 13003 >>交任务: 屠龙记
	.goto TheStormPeaks,65.00,60.95
	.isQuestComplete 13003
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm和Frostworg Denmother交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.isQuestComplete 12994
step
	>>返回Dun Niffelem
	>>与Fjorn铁砧、Hodir角和Hodir头盔交谈
    .turnin -12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin -12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin -13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
step
	+您已经完成了今天的所有霍迪尔之子每日任务：)记住，您可以将在该区域地面上发现的长霜碎片交给其他代表，以及阿尔都尔遗迹交给您！
]])
