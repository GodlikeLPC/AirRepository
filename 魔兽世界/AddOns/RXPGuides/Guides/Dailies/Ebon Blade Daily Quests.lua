RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 黑檀之刃每日任务路线

step
	+要解锁黑檀之刃骑士每日任务，你必须首先在冰冠完成他们的任务链。请使用Ebon Blade解锁每日任务指南解锁每日任务
	.isQuestAvailable 12814

-- 3 Quests from The Shadow Vault
step
	>>从暗影库接受3个每日任务
    >>与Silver交谈
	.daily 12995 >>接任务: 彰显军威
	.goto Icecrown,42.84,24.92
	>>与Leaper交谈。他绕着帐篷走
	.daily 13069 >>接任务: 把它们打下来！
	.goto IcecrownGlacier,43.5,25.0
	>>跟维尔谈谈，他是个讨厌的家伙，在入口和主楼之间的小路上巡逻
    .daily 13071 >>接任务: 维尔喜欢火焰！
    .goto IcecrownGlacier,42.7,26.8,60,0
    .goto IcecrownGlacier,43.6,24.1
step
    .goto IcecrownGlacier,29.5,43.4,50,0
    .goto IcecrownGlacier,29.6,45.7,50,0
    .goto IcecrownGlacier,27.9,45.8,50,0
    .goto IcecrownGlacier,27.8,40.2,50,0
    .goto IcecrownGlacier,28.3,38.0,50,0
    .goto IcecrownGlacier,29.0,35.1,50,0
    .goto IcecrownGlacier,34.1,28.7,50,0
    .goto IcecrownGlacier,29.5,43.4
	.use 42480 >>杀死该地区的维库尔。在他们的尸体上使用你袋子里的黑檀刀锋横幅
    .complete 12995,1--Ebon Blade Banner planted near Vrykul corpse (15)
	.isOnQuest 12995
step
    .goto IcecrownGlacier,27.9,33.2
	>>在鱼叉内部，垃圾邮件使用“速射鱼叉”(3)击落龙
	.complete 13069,1 --Jotunheim Proto-Drakes & their riders shot down
	.isOnQuest 13069
step
	#completewith next
    .goto IcecrownGlacier,28.0,37.7
    .vehicle 30564 >>右击Njorndar Proto Drake以安装它
	.isOnQuest 13071
step
    .goto IcecrownGlacier,27.7,41.1,70,0
    .goto IcecrownGlacier,29.2,41.0,70,0
    .goto IcecrownGlacier,29.6,39.7,70,0
    .goto IcecrownGlacier,31.5,36.9,70,0
    .goto IcecrownGlacier,32.0,39.1,70,0
    .goto IcecrownGlacier,30.8,40.2,70,0
    .goto IcecrownGlacier,32.4,40.7,70,0
    .goto IcecrownGlacier,31.5,43.9,70,0
    .goto IcecrownGlacier,30.1,43.1,70,0
    .goto IcecrownGlacier,27.7,41.1
	>>冷却时使用“速度爆发”(1)加快移动速度。使用“Strafe Jotunheim Building”(3)点燃建筑物
    .complete 13071,1 --Vrykul buildings set ablaze (8)
	.isOnQuest 13071
step
    >>返回阴影库。与西尔弗、Leaper和Vile交谈
	.turnin 12995 >>交任务: 彰显军威
	.goto Icecrown,42.84,24.92
    .turnin 13069 >>交任务: 把它们打下来！
	.goto IcecrownGlacier,43.5,25.0
    .turnin 13071 >>交任务: 维尔喜欢火焰！
    .goto IcecrownGlacier,43.6,24.1,60,0
    .goto IcecrownGlacier,42.7,26.8

-- 3 Quests from Death's Rise
step
	>>从死亡复活开始接受3个每日任务
	>>与Setaal交谈
	.daily 12813 >>接任务: 转化尸体
	.goto Icecrown,19.67,48.39
	>>与Aurochs交谈。他在中间的火周围巡逻
    .daily 12838 >>接任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
	>>与Uzo交谈
    .daily 12815 >>接任务: 禁飞区
	.goto Icecrown,19.64,47.80
step
	#sticky
	#label Gryphon
	.goto IcecrownGlacier,10.5,44.1,70,0
    .goto IcecrownGlacier,5.0,43.4,70,0
    .goto IcecrownGlacier,10.5,39.0,70,0
    .goto IcecrownGlacier,12.7,41.2,70,0
    .goto IcecrownGlacier,10.5,44.1
	>>杀死该地区的鹰头狮骑士。用远程技能击落他们，或将他们中的多个组合在空中，然后飞下来杀死他们
    .complete 12815,1 --Onslaught Gryphon Rider (10)
	.isOnQuest 12815
step
    #completewith next
	.goto IcecrownGlacier,9.5,44.8,50,0
    .goto IcecrownGlacier,9.5,44.8,0,0
	.use 40587 >>杀死该地区的暴徒。用你袋子里的黑曼德酊剂涂在他们的尸体上
    .complete 12813,1 --Scarlet Onslaught corpse transformed (10)
	.isOnQuest 12813
step
	>>杀死暴徒，然后掠夺他们的钥匙。用它们在Onslaught Harbor周围打开箱子存放文件
	>>文件箱没有100%下降率
    .goto IcecrownGlacier,10.7,45.6,40,0
    .goto IcecrownGlacier,10.3,46.4,40,0
    .goto IcecrownGlacier,8.8,46.7,40,0
    .goto IcecrownGlacier,8.8,42.2,40,0
    .goto IcecrownGlacier,10.6,42.9,40,0
    .goto IcecrownGlacier,9.6,40.6,40,0
    .goto IcecrownGlacier,9.3,37.5,40,0
    .goto IcecrownGlacier,10.1,36.2,40,0
    .goto IcecrownGlacier,9.1,36.3,40,0
    .goto IcecrownGlacier,8.5,36.4,40,0
    .goto IcecrownGlacier,10.7,45.6,40,0
    .goto IcecrownGlacier,10.3,46.4,40,0
    .goto IcecrownGlacier,8.8,46.7,40,0
    .goto IcecrownGlacier,8.8,42.2,40,0
    .goto IcecrownGlacier,10.6,42.9,40,0
    .goto IcecrownGlacier,9.6,40.6,40,0
    .goto IcecrownGlacier,9.3,37.5,40,0
    .goto IcecrownGlacier,10.1,36.2,40,0
    .goto IcecrownGlacier,9.1,36.3,40,0
    .goto IcecrownGlacier,8.5,36.4
	.collect 40652,6,12838,-1
    .complete 12838,1 --Onslaught Intel Documents (5)
	.isOnQuest 12838
step
	.goto IcecrownGlacier,9.5,44.8,50,0
    .goto IcecrownGlacier,9.5,44.8,0,0
	.use 40587 >>杀死该地区的暴徒。用你袋子里的黑曼德酊剂涂在他们的尸体上
    .complete 12813,1 --Scarlet Onslaught corpse transformed (10)
	.isOnQuest 12813
step
	#requires Gryphon
	>>回归死亡的崛起。与Uzo、Setaal和Aurochs交谈
    .turnin 12815 >>交任务: 禁飞区
    .goto Icecrown,19.64,47.80
    .turnin 12813 >>交任务: 转化尸体
    .goto Icecrown,19.67,48.39
    .turnin 12838 >>交任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
step
	+你已经完成了今天的所有黑檀之刃骑士每日任务：)记住，你可以在进行WotLK地牢时穿上他们的塔巴，以获得额外的重复！
]])
