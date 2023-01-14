RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 黑檀之刃解锁每日任务

step
    +您已经完成了黑檀之刃骑士任务前链。请使用《黑檀之刃每日任务路线指南》完成每日任务。
	.isQuestTurnedIn 12814

step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>飞到破天荒号，联盟的大船，在高空盘旋
	>>与船左后角的Thassarian交谈
    .accept 12887 >>接任务: 乐趣十足
step << Horde
	.goto Icecrown,62.58,45.04
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船
	>>在船的前室与Koltira Deathweaver交谈
    .accept 12892 >>接任务: 乐趣十足
step
    .goto IcecrownGlacier,44.5,21.6
	.use 41265 >>飞到塔顶。在眼袋中使用Eyesoir Blaster，直到其死亡
    .complete 12887,1 << Alliance --The Ocular has been destroyed (1)
    .complete 12892,1 << Horde --The Ocular has been destroyed (1)
step
    .goto IcecrownGlacier,44.1,24.7
	>>一直飞到地面上的男爵西尔弗。跟他谈谈
    .turnin 12887 >>交任务: 乐趣十足 << Alliance
    .turnin 12892 >>交任务: 乐趣十足 << Horde
    .accept 12891 >>接任务: 我有一计……
step
	>>杀死艺人并掠夺他们的绳索，杀死憎恶者并掠夺其钩子，杀死邪教教徒并掠夺它们的棍子，杀死亡灵暴徒并掠夺她们的灵魂
    .complete 12891,1 --Cultist Rod (1)
    .goto IcecrownGlacier,43.8,24.2,40,0
    .goto IcecrownGlacier,43.6,25.1,40,0
    .goto IcecrownGlacier,43.7,25.4,40,0
    .goto IcecrownGlacier,42.5,25.1,40,0
    .goto IcecrownGlacier,42.3,26.1
    .complete 12891,3 --Geist Rope (1)
    .goto IcecrownGlacier,43.4,25.6,40,0
    .goto IcecrownGlacier,43.3,26.6,40,0
    .goto IcecrownGlacier,42.5,26.4,40,0
    .goto IcecrownGlacier,42.9,24.5
    .complete 12891,2 --Abomination Hook (1)
    .goto IcecrownGlacier,43.3,24.1,40,0
    .goto IcecrownGlacier,43.5,26.2,40,0
    .goto IcecrownGlacier,42.5,28.1,40,0
    .goto IcecrownGlacier,42.7,25.7
   .complete 12891,4 --Scourge Essence (5)
    .goto IcecrownGlacier,43.6,24.1,40,0
    .goto IcecrownGlacier,42.6,27.2,40,0
    .goto IcecrownGlacier,42.3,26.1
step
    .goto IcecrownGlacier,44.2,24.6
	>>返回银色
    .turnin 12891 >>交任务: 我有一计……
    .accept 12893 >>接任务: 解放你的思想
step
    .goto IcecrownGlacier,44.4,27.0
	.use 41366 >>杀死维尔。在他的尸体上使用主权杖
    .complete 12893,1 --Vile turned (1)
step
    .goto IcecrownGlacier,41.8,24.5
	.use 41366 >>杀死夜鹰女士。在她的尸体上使用主权杖
    .complete 12893,2 --Lady Nightswood turned (1)
step
    .goto IcecrownGlacier,43.0,23.5,70,0
    .goto IcecrownGlacier,44.8,24.3,70,0
    .goto IcecrownGlacier,46.2,21.9,70,0
    .goto IcecrownGlacier,45.7,19.7,70,0
    .goto IcecrownGlacier,43.7,19.0,70,0
    .goto IcecrownGlacier,42.6,21.1
	.use 41366 >>杀死Leaper。在他的尸体上使用主权杖。他在上层的主楼外面走动。
    .complete 12893,3 --The Leaper turned (1)
	.unitscan The Leaper
step
	#label Freemind
    .goto IcecrownGlacier,44.2,24.7
	>>返回银色
    .turnin 12893 >>交任务: 解放你的思想
    .accept 12896 >>接任务: 顽固的敌人 << Alliance
    .accept 12897 >>接任务: 顽固的敌人 << Horde
step
    .goto IcecrownGlacier,44.7,19.8
	>>进入大楼，点击将军的武器架。小心，因为这会产生精英。杀死Lightsbane将军
    .complete 12896,1 << Alliance --General Lightsbane (1)
    .complete 12897,1 << Horde --General Lightsbane (1)
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>飞回破天者。与船左后角的Thassarian交谈
    .turnin 12896 >>交任务: 顽固的敌人
    .accept 12898 >>接任务: 暗影拱顶
step << Horde
	>>飞回奥格里姆之锤。在船的前室与Koltira Deathweaver交谈
    .turnin 12897 >>交任务: 顽固的敌人
    .accept 12899 >>接任务: 暗影拱顶
step
    .goto IcecrownGlacier,42.8,24.9
	>>返回男爵西尔弗
	.turnin 12898 >>交任务: 暗影拱顶 << Alliance
    .turnin 12899 >>交任务: 暗影拱顶 << Horde
    .accept 12938 >>接任务: 公爵
step
	#completewith next
    .goto IcecrownGlacier,43.7,24.4
    .fp The Shadow Vault >>获取阴影保险库飞行路径
step
    .goto IcecrownGlacier,44.7,20.3
	>>进入大楼。与Lankral交谈
    .turnin 12938 >>交任务: 公爵
    .accept 12939 >>接任务: 荣耀的挑战
step
    .goto Icecrown,43.60,25.13
	>>与Leaper交谈，他绕着帐篷走
    .accept 12955 >>接任务: 消灭竞争者
step
    .goto IcecrownGlacier,37.5,24.7,0,0
	#sticky
	#label mjordincombat
	.use 41372 >>在远处的乔丹战斗人员身上使用挑战旗。你可以一次挑战多个战斗人员，只要你不参与战斗(但每两人一组只有一个怪物)
    .complete 12939,1 --Mjordin Combatants challenged and defeated (6)
step
	>>飞向野蛮人边缘
	>>在Savage Ledge与Tinky、Sigrid、Onu'zun和Efrem交谈。击败他们
    .complete 12955,4 --Tinky Wickwhistle defeated (1)
    .goto IcecrownGlacier,36.1,23.6
    .complete 12955,1 --Sigrid Iceborn defeated (1)
    .goto IcecrownGlacier,37.1,22.4
    .complete 12955,3 --Onu'zun defeated (1)
    .goto IcecrownGlacier,37.9,22.9
    .complete 12955,2 --Efrem the Faithful defeated (1)
    .goto IcecrownGlacier,37.9,25.1
	.skipgossip
step
    .goto IcecrownGlacier,43.5,25.0
	>>返回Leaper
    .turnin 12955 >>交任务: 消灭竞争者
step
    .goto IcecrownGlacier,44.7,20.3
	>>进入大楼。与Lankral交谈
    .turnin 12939 >>交任务: 荣耀的挑战
    .accept 12943 >>接任务: 暗影拱顶裁决令
step
	#completewith next
    .goto IcecrownGlacier,39.01,23.99,25 >>通往乌夫兰大厅的路从这里开始
step
    .goto IcecrownGlacier,41.0,23.9
	>>回到野人山崖，然后进入乌夫兰的大厅。和被锁在里面的维伦谈谈
    .accept 12949 >>接任务: 夺取钥匙
step
    .goto IcecrownGlacier,40.3,23.9
	.use 41776 >>在Thane前面的包中使用影子金库法令。杀了他。
    .complete 12943,1 --Thane Ufrang the Mighty (1)
step
    .goto IcecrownGlacier,37.7,23.9,70,0
    .goto IcecrownGlacier,36.7,23.7
	>>回到外面的野人山崖。杀死在附近巡逻的教官赫罗加。抢他的钥匙
    .complete 12949,1 --Key to Vaelen's Chains (1)
	.unitscan Instructor Hroegar
step
    .goto IcecrownGlacier,41.0,23.9
	>>回到乌夫兰的大厅。返回Vaelen
    .turnin 12949 >>交任务: 夺取钥匙
    .accept 12951 >>接任务: 通知男爵
step
    .goto IcecrownGlacier,39.01,23.99,25,0
    .goto IcecrownGlacier,42.9,24.9
	>>离开大厅。返回男爵西尔弗
    .turnin 12951 >>交任务: 通知男爵
    .daily 12995 >>接任务: 彰显军威
    .accept 13085 >>接任务: 维林回来了
step
    .goto IcecrownGlacier,43.6,24.1,60,0
    .goto IcecrownGlacier,42.7,26.8
	>>与沿着主要道路巡逻的Vile交谈
    .accept 12992 >>接任务: 干掉那些维库人！
step
    .goto IcecrownGlacier,43.8,23.3,30,0
    .goto IcecrownGlacier,43.1,21.1
	>>进入大楼。与左侧的Vaelen交谈
    .turnin 13085 >>交任务: 维林回来了
    .accept 12982 >>接任务: 黑锋囚犯
step
    .goto IcecrownGlacier,44.7,20.4
	>>与Lankral交谈
    .turnin 12943 >>交任务: 暗影拱顶裁决令
    .accept 13084 >>接任务: 破坏尤顿海姆
step
    .goto IcecrownGlacier,29.5,43.4,50,0
    .goto IcecrownGlacier,29.6,45.7,50,0
    .goto IcecrownGlacier,27.9,45.8,50,0
    .goto IcecrownGlacier,27.8,40.2,50,0
    .goto IcecrownGlacier,28.3,38.0,50,0
    .goto IcecrownGlacier,29.0,35.1,50,0
    .goto IcecrownGlacier,34.1,28.7,50,0
    .goto IcecrownGlacier,29.5,43.4
	.use 42480 >>杀死该地区的维库尔，并掠夺他们的笼子钥匙。在他们的尸体上使用你袋子里的黑檀刀锋横幅。点击在整个Jotenheim发现的笼子上掠夺的任何钥匙
	>>烧毁在约腾海姆发现的旗帜
	.collect 42422,8,12982,1,-1 --Jotunheim Cage Key (8)
    .complete 12982,1 --Ebon Blade Prisoners set free (8)
    .complete -12995,1 --Ebon Blade Banner planted near Vrykul corpse (0/15)
    .complete 12992,1 --Jotunheim Vrykul slain (0/15)
    .complete 13084,1 --Vrykul banners burned (10)
step
    .goto IcecrownGlacier,42.7,26.8,60,0
    .goto IcecrownGlacier,43.6,24.1
	>>返回阴影库。与沿着主要道路巡逻的Vile交谈
    .turnin 12992 >>交任务: 干掉那些维库人！
    .daily 13071 >>接任务: 维尔喜欢火焰！
step
    .goto IcecrownGlacier,43.8,23.3,30,0
    .goto IcecrownGlacier,43.1,21.1
	>>进入大楼。与左侧的Vaelen交谈
    .turnin 12982 >>交任务: 黑锋囚犯
step
    .goto IcecrownGlacier,44.7,20.4
	>>与Lankral交谈
    .turnin 13084 >>交任务: 破坏尤顿海姆
step
    .goto IcecrownGlacier,42.9,24.9
    >>返回银色
	.turnin 12995 >>交任务: 彰显军威
	.isQuestComplete 12995
step
    .goto IcecrownGlacier,42.9,24.9
	>>与Silver交谈
    .accept 12806 >>接任务: 全速赶往死亡高地！
step
    .goto IcecrownGlacier,43.5,25.0
	>>与Leaper交谈，他绕着帐篷走
    .daily 13069 >>接任务: 把它们打下来！
step
    .goto IcecrownGlacier,27.9,33.2
	>>进入位于中心位置的佐敦海姆快速消防鱼叉。
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
    .goto IcecrownGlacier,19.5,48.1
	>>下马，然后前往死亡之地。这是一个位于海平面和山顶之间的小平台。与阿雷特交谈
    .turnin 12806 >>交任务: 全速赶往死亡高地！
    .accept 12807 >>接任务: 迄今为止的故事……
step
    .goto IcecrownGlacier,19.5,48.1
	>>再和阿雷特少校谈谈
    .complete 12807,1 --Lord-Commander Arete's tale listened to. (1)
    .turnin 12807 >>交任务: 迄今为止的故事……
    .accept 12810 >>接任务: 水中之血
	.skipgossip
step
	#sticky
	#label DeathRise
    .goto IcecrownGlacier,19.3,47.8
    .fp Death's Rise >>获得死亡崛起飞行路径
step
	>>与Setaal交谈
    .daily 12813 >>接任务: 转化尸体
    .goto Icecrown,19.67,48.39
	>>与Aurochs交谈。他在中间的火周围巡逻
    .daily 12838 >>接任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
	>>可选择的你可以跳过或完成这两个每日任务
step
	#requires DeathRise
    #sticky
	#label transformedcorpse
    .goto IcecrownGlacier,9.5,44.8,50,0
    .goto IcecrownGlacier,9.5,44.8,0,0
	.use 40587 >>杀死该地区的暴徒。用你袋子里的黑曼德酊剂涂在他们的尸体上
    .complete 12813,1 --Scarlet Onslaught corpse transformed (10)
	.isOnQuest 12813
step
	#requires DeathRise
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
	#requires transformedcorpse
	.use 40551 >>到离海岸30-90码的海里去，杀死贪婪的大白鲨。在他们尸体上用你袋子里的戈尔膀胱
    .goto IcecrownGlacier,4.8,41.5,90,0
    .goto IcecrownGlacier,4.3,35.9,90,0
    .goto IcecrownGlacier,11.7,35.6,90,0
    .goto IcecrownGlacier,13.7,42.0,90,0
    .goto IcecrownGlacier,10.3,41.5,90,0
    .goto IcecrownGlacier,4.8,41.5,90,0
    .goto IcecrownGlacier,4.3,35.9,90,0
    .goto IcecrownGlacier,11.7,35.6,90,0
    .goto IcecrownGlacier,13.7,42.0,90,0
    .goto IcecrownGlacier,10.3,41.5
    .complete 12810,1 --Blood collected from Ravenous Jaws (10)
step
	>>回归死亡的崛起。与阿雷特交谈
    .turnin 12810 >>交任务: 水中之血
    .accept 12814 >>接任务: 你需要狮鹫
    .goto IcecrownGlacier,19.6,48.1
step
	>>与Aurochs交谈。他在中间的火周围巡逻
    .turnin -12838 >>交任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
	>>与Setaal交谈
    .turnin -12813 >>交任务: 转化尸体
    .goto IcecrownGlacier,19.7,48.4
step
    .goto IcecrownGlacier,10.4,44.1
	>>杀死该地区的Onslaught鹰头狮骑士。抢走他们的猎鹰缰绳
	.collect 40970,1,12814,1 --Onslaught Grpyhon Reins (1)
step
    .goto IcecrownGlacier,19.6,47.8
	>>在你的正常坐骑上返回死神复活。当你到达任务给予者处时，使用鹰头狮缰绳并使用“传送鹰头狮”(1)传送。
    .complete 12814,1 --Onslaught Gryphon delivered to Uzo Deathcaller (1)
	.use 40970
step
    .goto Icecrown,19.64,47.80
	>>与Uzo Deathcaller交谈
    .turnin 12814 >>交任务: 你需要狮鹫
    .daily 12815 >>接任务: 禁飞区
step
    .goto IcecrownGlacier,10.5,44.1,70,0
    .goto IcecrownGlacier,5.0,43.4,70,0
    .goto IcecrownGlacier,10.5,39.0,70,0
    .goto IcecrownGlacier,12.7,41.2,70,0
    .goto IcecrownGlacier,10.5,44.1
	>>杀死该地区的鹰头狮骑士。用远程技能击落它们，或将它们中的多个组合在空中，然后飞下来杀死它们。如果你聚集了很多人，不要让他们打你的背部，否则你会下马。
    .complete 12815,1 --Onslaught Gryphon Rider (10)
step
	.goto Icecrown,19.64,47.80
	>>回归死亡的崛起。与Uzo交谈
    .turnin 12815 >>交任务: 禁飞区
step
    >>返回阴影库。与Leaper和Vile交谈
    .turnin -13069 >>交任务: 把它们打下来！
	.goto IcecrownGlacier,43.5,25.0
    .turnin -13071 >>交任务: 维尔喜欢火焰！
    .goto IcecrownGlacier,43.6,24.1,60,0
    .goto IcecrownGlacier,42.7,26.8
step
    +您已经完成了黑檀之刃骑士任务前链。请使用《黑檀之刃每日任务路线指南》完成每日任务。请注意，由于已提前完成，有些可能今天无法提供
	.isQuestTurnedIn 12814
]])
