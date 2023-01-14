RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 1-11 提瑞斯法林地
#version 1
#group RestedXP部落1-22
#defaultfor Undead
#next 11-14 银松森林
#next 12-17 贫瘠之地

step << !Scourge
    #sticky
    #completewith next
    .goto Tirisfal Glades,30.2,71.7
    +您选择了一个为亡灵准备的指南。建议您选择与开始时相同的起始区域
step
    >>放下你的炉石
	.destroy 6948
     >>跑出地窖
    .goto Tirisfal Glades,30.2,71.7
    .accept 363 >>接任务: 突然醒来
step << Warrior
    #sticky
    #completewith vendorWar
    +把暴徒赶到镇上，直到你有10美分的可卖品
    .goto Tirisfal Glades,31.5,69.8
step << Warlock
    #sticky
    #completewith vendorLock
    +把暴徒赶到镇上，直到你有10美分的可卖品
    .goto Tirisfal Glades,31.5,69.8
step << Priest/Mage
    #sticky
    #completewith vendorCaster
    +把暴徒赶到镇上，直到你有35美分的可卖品
    .goto Tirisfal Glades,31.5,69.8
step << Warrior
    #label vendorWar
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step << Warrior
    .goto Tirisfal Glades,32.7,65.6
    .train 6673 >>火车战斗呐喊
step << Priest/Mage
    #label vendorCaster
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商扔掉垃圾，然后购买10杯清凉泉水
	.collect 159,10 --Collect Refreshing Spring Water (x10)
step << Warlock
    #label vendorLock
    .goto Tirisfal Glades,30.8,66.4
    .vendor >>Demon Trainer的供应商垃圾
step << Warlock
    .goto Tirisfal Glades,30.9,66.3
    .train 348 >>火车献祭
step << Warlock
    .goto Tirisfal Glades,31.0,66.4
    .accept 1470 >>接任务: 控制小鬼
step << Warlock
    .goto Tirisfal Glades,30.8,66.2
    .turnin 363 >>交任务: 突然醒来
    .accept 364 >>接任务: 无脑的僵尸
step << Warlock
    .goto Tirisfal Glades,32.5,61.4
    >>在头骨区域杀死鼠笼骷髅
    .complete 1470,1 --Rattlecage Skull (3)
step << Warlock
    #completewith next
    .goto Tirisfal Glades,32.3,65.4,30 >>在回镇的路上磨碎，直到有25c+的可售物品
step << Warlock
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>小贩垃圾，从Joshua那里买5杯水
	.collect 159,5 --Collect Refreshing Spring Water (x5)
step << Warlock
    >>在你投降后召唤你的小鬼
    .goto Tirisfal Glades,31.0,66.4
    .turnin 1470 >>交任务: 控制小鬼
step << Warlock
    .xp 2 >>升级到2级
step << Mage
    .goto Tirisfal Glades,30.9,66.1
    .trainer >>训练你的职业咒语
step << Priest
    .goto Tirisfal Glades,31.1,66.0
    .trainer >>训练你的职业咒语
step << !Warlock
    .goto Tirisfal Glades,30.8,66.2
    .turnin 363 >>交任务: 突然醒来
    .accept 364 >>接任务: 无脑的僵尸
step
    >>杀死该地区的僵尸
    .goto Tirisfal Glades,32.4,62.8
    .complete 364,1 --Kill Mindless Zombie (x8)
    .complete 364,2 --Kill Wretched Zombie (x8)
step
	.goto Tirisfal Glades,32.4,62.8
	.xp 2 >>升级到2级
step << Mage/Warlock/Priest
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾，再购买10杯水
	.collect 159,10 --Collect Refreshing Spring Water (x10)
step << Warrior/Rogue
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step
    .goto Tirisfal Glades,30.8,66.2
    .turnin 364 >>交任务: 无脑的僵尸
step
    #era/som
    .goto Tirisfal Glades,30.8,66.2
    .accept 3095 >>接任务: 简易卷轴 << Warrior
    .accept 3096 >>接任务: 密文卷轴 << Rogue
    .accept 3097 >>接任务: 神圣卷轴 << Priest
    .accept 3098 >>接任务: 雕文卷轴 << Mage
    .accept 3099 >>接任务: 被污染的卷轴 << Warlock
    .accept 3901 >>接任务: 断骨骷髅
    .accept 376 >>接任务: 被诅咒者
step
    #som
    #phase 3-6
    .goto Tirisfal Glades,30.8,66.2
    .accept 3095 >>接任务: 简易卷轴 << Warrior
    .accept 3096 >>接任务: 密文卷轴 << Rogue
    .accept 3097 >>接任务: 神圣卷轴 << Priest
    .accept 3098 >>接任务: 雕文卷轴 << Mage
    .accept 3099 >>接任务: 被污染的卷轴 << Warlock
    .accept 376 >>接任务: 被诅咒者
step << Mage
    .goto Tirisfal Glades,30.9,66.1
    .turnin 3098 >>交任务: 雕文卷轴
step << Warlock
    .goto Tirisfal Glades,30.9,66.3
    .turnin 3099 >>交任务: 被污染的卷轴
step << Priest
    .goto Tirisfal Glades,31.1,66.0
    .turnin 3097 >>交任务: 神圣卷轴
step
    .goto Tirisfal Glades,29.5,67.2,40,0
    .goto Tirisfal Glades,29.6,61.3,50,0
    .goto Tirisfal Glades,32.5,56.7,50,0
    .goto Tirisfal Glades,35.2,57.0,50,0
    .goto Tirisfal Glades,29.5,67.2,40,0
    .goto Tirisfal Glades,29.6,61.3,50,0
    .goto Tirisfal Glades,32.5,56.7,50,0
    .goto Tirisfal Glades,35.2,57.0,50,0
    >>磨狼和黄昏
    .complete 376,1 --Collect Scavenger Paw (x6)
    .complete 376,2 --Collect Duskbat Wing (x6)
step
    #era/som
    .goto Tirisfal Glades,33.15,60.70
    >>杀死镇上的骷髅
    .complete 3901,1 --Kill Rattlecage Skeleton (12)
step
    .xp 3+980>>在返回城镇的路上碾碎暴徒，达到980+/1400经验
step << Mage/Warlock
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾，购买不低于95摄氏度的水
step << Priest
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾桶，购买不低于1s 90c的水
step
     #era/som
    .goto Tirisfal Glades,30.9,66.2
    .turnin 3901 >>交任务: 断骨骷髅
step
    #label BatsWolves
    .goto Tirisfal Glades,30.9,66.1
    .turnin 376 >>交任务: 被诅咒者
step
	.goto Tirisfal Glades,30.9,66.1
    .accept 6395 >>接任务: 玛拉的遗愿
step << Priest
    .goto Tirisfal Glades,31.1,66.0
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Tirisfal Glades,30.9,66.3
    .trainer >>训练你的职业咒语
step << Mage
    .goto Tirisfal Glades,30.9,66.1
    .trainer >>训练你的职业咒语
step
    .goto Tirisfal Glades,32.2,66.0
    .accept 380 >>接任务: 夜行蜘蛛洞穴
step << Rogue/Warrior
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step << Rogue
    .goto Tirisfal Glades,32.5,65.7
    .turnin 3096 >>交任务: 密文卷轴
step << Warrior
    .goto Tirisfal Glades,32.7,65.6
    .turnin 3095 >>交任务: 简易卷轴
    .trainer >>训练你的职业咒语
step
    .goto Tirisfal Glades,31.6,65.6
    .accept 3902 >>接任务: 捡破烂
step
    #sticky
    #label Goods
    >>收集成捆的棕色盒子，同时在途中碾磨2+级暴徒。你可以在外墙/建筑物内部找到这些
    .goto Tirisfal Glades,33.84,64.09
    .complete 3902,1 --Collect Scavenged Goods (x6)
step
	#hardcore
    #requires Goods
    .goto Tirisfal Glades,27.1,59.0,80,0
    .goto Tirisfal Glades,26.8,59.4,30,0
    .goto Tirisfal Glades,24.0,58.2,60,0
	.goto Tirisfal Glades,27.1,59.0
    >>杀死洞穴外的所有年轻蜘蛛(2-3只除外)，然后进入洞穴并杀死洞穴内的夜蛛。离开时杀死剩下的2-3个年轻蜘蛛。
    .complete 380,1 --Kill Young Night Web Spider (10)
	complete 380,2 --Kill Night Web Spider (x8)
step
	#softcore
    #requires Goods
    .goto Tirisfal Glades,27.1,59.0,80,0
    .goto Tirisfal Glades,26.8,59.4,30,0
    .goto Tirisfal Glades,24.0,58.2,60,0
	.goto Tirisfal Glades,27.1,59.0
    >>杀死洞穴外的年轻蜘蛛，然后进入洞穴，杀死洞穴内的夜蛛。我们在山洞里跳得死去活来，在你进去之前，一定要把年轻的蜘蛛都处理好。
    .complete 380,1 --Kill Young Night Web Spider (10)
	complete 380,2 --Kill Night Web Spider (x8)
step
    #softcore
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    #hardcore
    #completewith next
    .goto Tirisfal Glades,31.2,64.9,120 >>跑出洞穴，回到死亡丧钟
step
    .goto Tirisfal Glades,31.6,65.6
	>>恢复你的小鬼 << Warlock
    .turnin 3902 >>交任务: 捡破烂
step << Rogue/Warrior
    .goto Tirisfal Glades,32.41,65.66
    .vendor >>供应商垃圾。修理你的武器
step << Priest/Mage/Warlock
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾桶，最多可购买15杯水
	.collect 159,15 --Collect Refreshing Spring Water (x15)
step
    .goto Tirisfal Glades,32.2,66.0
    .turnin 380 >>交任务: 夜行蜘蛛洞穴
step
	.goto Tirisfal Glades,32.2,66.0
    .accept 381 >>接任务: 血色十字军
step
    .goto Tirisfal Glades,37.45,67.93
    >>为臂章杀死血腥暴徒
    .complete 381,1 --Collect Scarlet Armband (12)
step
    >>杀死塞缪尔·菲普斯，并掠夺他的遗体
    .goto Tirisfal Glades,36.7,61.6
    .collect 16333,1 --Collect Samuel's Remains
step
    #softcore
	.goto Tirisfal Glades,36.7,61.6
    .deathskip >>在精神治疗师处死亡并重生
step
    .goto Tirisfal Glades,31.2,65.1
	>>点击墓地中的坟墓埋葬塞缪尔的遗体
    .complete 6395,1 --Collect Samuel's Remains Buried (1)
step
    .goto Tirisfal Glades,30.9,66.1
    .turnin 6395 >>交任务: 玛拉的遗愿
step << Priest
    .goto Tirisfal Glades,31.11,66.03
    .accept 5651 >>接任务: 黑暗的恩赐
step
    #completewith next
    .goto Tirisfal Glades,32.4,65.6
    .vendor >>供应商垃圾和维修
step
    .goto Tirisfal Glades,32.1,66.0
    .turnin 381 >>交任务: 血色十字军
step
	.goto Tirisfal Glades,32.1,66.0
    .accept 382 >>接任务: 十字军信使
step
    >>杀死Meven并掠夺他的文件 << !Rogue !Warrior
    >>杀了梅文，同时把他放回镇上。抢他的文件 << Rogue/Warrior
    .goto Tirisfal Glades,36.5,68.8
    .complete 382,1 --Collect Scarlet Crusade Documents (1)
step
    .goto Tirisfal Glades,32.2,66.0
    .turnin 382 >>交任务: 十字军信使
    .accept 383 >>接任务: 重要情报
step
    .goto Tirisfal Glades,38.1,56.6
    .xp 5+2350>>途中提升经验到2350+/2800xp
step
    .goto Tirisfal Glades,38.2,56.8
    .accept 8 >>接任务: 潜行者的交易
step
    .goto Tirisfal Glades,40.91,54.17
    .accept 365 >>接任务: 悲伤之地
step
    #era/som
    .unitscan Gordo
    .goto Tirisfal Glades,40.79,54.47,40,0
    .goto Tirisfal Glades,42.67,54.97,40,0
    .goto Tirisfal Glades,43.75,54.29,40,0
    .goto Tirisfal Glades,45.27,56.45,40,0
    .goto Tirisfal Glades,49.19,58.07,40,0
    .goto Tirisfal Glades,50.87,59.01,60,0
    .goto Tirisfal Glades,51.84,55.31,40,0
    .goto Tirisfal Glades,54.20,52.72,40,0
    .goto Tirisfal Glades,55.67,52.46,40,0
    .goto Tirisfal Glades,54.20,52.72,40,0
    .goto Tirisfal Glades,51.84,55.31,40,0
    .goto Tirisfal Glades,50.87,59.01,60,0
    .goto Tirisfal Glades,49.19,58.07,40,0
    .goto Tirisfal Glades,45.27,56.45,40,0
    .goto Tirisfal Glades,43.75,54.29,40,0
    .goto Tirisfal Glades,42.67,54.97,40,0
    .goto Tirisfal Glades,40.79,54.47,40,0
    >>与戈多交谈。他是个可恶的家伙，在通往布里尔的路上巡逻
    .accept 5481 >>接任务: 葛尔多的任务
step << Priest
    #softcore
    .goto Tirisfal Glades,52.59,55.51
    .trainer >>列车定制。保留你的亚麻布以提高技能，然后再创造绿色，以驱除对魔杖的幻想
    >>如果你是alt/认为以后从AH购买会更容易，可以跳过这一步
step << Priest
    #hardcore
    .goto Tirisfal Glades,52.59,55.51
    .trainer >>列车定制。保留你的亚麻布以提高技能，然后再创造绿色，以驱除对魔杖的幻想
step
    #softcore
    #completewith next
    .deathskip >>如果你很早就找到戈多的话，就死在布里尔重生
step
    .goto Tirisfal Glades,60.6,51.8
    .turnin 383 >>交任务: 重要情报
    .accept 427 >>接任务: 与血色十字军的战争
step << Rogue
    .goto Tirisfal Glades,61.16,52.59
    .vendor >>买温特斯夫人扔的3级。装备它
step
    .goto Tirisfal Glades,61.7,52.0
    .turnin 8 >>交任务: 潜行者的交易
    .home >>将您的炉石设置为Brill
    .vendor >>供应商垃圾箱。购买一些5级食物 << !Mage !Priest !Warlock
    .vendor >>供应商垃圾。买一些5级水 << Mage/Priest/Warlock
    >>至少节省1.3银币用于培训 << Warrior
    >>至少为训练节省2银币 << Mage
    >>至少节省2.3银币用于培训 << Rogue
    >>至少节省3银币用于培训 << Warlock/Priest
step << Warrior
    .goto Tirisfal Glades,61.85,52.55
    .trainer >>训练你的职业咒语
step << Mage
    .goto Tirisfal Glades,61.97,52.48
    .trainer >>上楼训练你的课堂咒语
step << Warlock
    .goto Tirisfal Glades,61.59,52.39
    .trainer >>上楼训练你的课堂咒语
    .goto Tirisfal Glades,61.55,52.61
    .vendor >>如果你在训练后有钱，就买血盟书(否则以后再买)
step << Priest
    .goto Tirisfal Glades,61.77,51.56
    .trainer >>列车魅力。将你找到的绿色魔法驱散(或通过裁缝制作)，最终制成魔杖
    >>如果你是alt/认为以后从AH购买会更容易，可以跳过这一步
step << Priest
    .goto Tirisfal Glades,61.57,52.19
    .trainer >>上楼训练你的课堂咒语
    .turnin 5651 >>交任务: 黑暗的恩赐
    .accept 5650 >>接任务: 黑暗之衣
step << Rogue
    .goto Tirisfal Glades,61.75,52.00
    .trainer >>上楼训练你的课堂咒语
step << Priest
    .goto Tirisfal Glades,59.18,46.49
    >>对死亡守卫Kel使用次级治疗(等级2)。然后用金字招牌：坚韧
    .complete 5650,1 --Heal and fortify Deathguard Kel (1)
step << Rogue
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(4s1c)，就从奥利弗那里买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Warrior
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(5s36c)，从奥利弗那里买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step
    .goto Tirisfal Glades,59.45,52.40
    .accept 367 >>接任务: 新的瘟疫
step
    .goto Tirisfal Glades,58.20,51.45
    .accept 404 >>接任务: 腐烂的爪子
step
    #era/som
    #sticky
    #completewith next
    >>掠夺地上的紫色小杂草
    .complete 5481,1 --Gloom Weed (3)
step
    .goto Tirisfal Glades,52.14,52.39
    >>杀死该地区的僵尸。掠夺他们的爪子
    .complete 404,1 --Putrid Claw (7)
step
    #sticky
    #completewith Warriors
    >>杀死你看到的任何Decrepeti Darkhounds。抢他们的血
    .complete 367,1 --Darkhound Blood (5)
step
    #era/som
    .goto Tirisfal Glades,40.06,51.10
    >>完成对地上紫色小杂草的掠夺。它们在西边去田地的路上随处可见
    .complete 5481,1 --Gloom Weed (3)
step
    >>掠夺在田里找到的南瓜。试着把你从现在开始得到的小治疗药剂也保存起来，以便以后使用
    .goto Tirisfal Glades,35.92,50.61
    .complete 365,1 --Tirisfal Pumpkin (10)
step
    #label Warriors
    >>杀死血色勇士 << !Rogue !Warrior
    >>杀死血腥勇士。当他们完成防御姿态动画后，要小心，8秒内他们的招架次数增加了50% << Rogue/Warrior
    .goto Tirisfal Glades,30.26,50.70
    .complete 427,1 --Scarlet Warrior (10)
step
    #softcore
    #completewith next
     .deathskip >>在布里尔死亡并重生
step
    #hardcore
    #completewith next
     .hs >>从炉子到布里尔
step
    #era/som
    >>在初级药剂师那里交。他在墓地周围巡逻
    .goto Tirisfal Glades,57.68,48.96
    .turnin 5481 >>交任务: 葛尔多的任务
    .accept 5482 >>接任务: 末日草
step
    .goto Tirisfal Glades,58.20,51.45
    .turnin 404 >>交任务: 腐烂的爪子
    .accept 426 >>接任务: 磨坊告急
step
    .goto Tirisfal Glades,59.45,52.40
    .turnin 365 >>交任务: 悲伤之地
    .accept 407 >>接任务: 悲伤之地
step
    .goto Tirisfal Glades,59.45,52.40
    .isQuestComplete 367
    .turnin 367 >>交任务: 新的瘟疫
step
    .goto Tirisfal Glades,59.45,52.40
    .accept 368 >>接任务: 新的瘟疫
	.isQuestTurnedIn 367
step
    .goto Tirisfal Glades,59.45,52.40
    .turnin 365 >>交任务: 悲伤之地
    .accept 407 >>接任务: 悲伤之地
step
    .goto Tirisfal Glades,60.58,51.77
    .turnin 427 >>交任务: 与血色十字军的战争
    .accept 370 >>接任务: 与血色十字军的战争
step
    .goto Tirisfal Glades,60.73,51.52
    .accept 398 >>接任务: 悬赏：蛆眼
step
    >>进入大楼
    .goto Tirisfal Glades,61.26,50.84
    .accept 358 >>接任务: 盗墓贼
step
    .goto Tirisfal Glades,60.93,52.01
    .accept 374 >>接任务: 死亡证明
step
    .xp 7
    .goto Tirisfal Glades,59.47,56.40
step
    .goto Tirisfal Glades,61.72,52.29
    .accept 354 >>接任务: 阿加曼德家族
    .accept 362 >>接任务: 闹鬼的磨坊
step
    #completewith next
    .vendor >>如果需要，购买食物/水
step
    >>进客栈老板后面的房间，然后下楼
    .goto Tirisfal Glades,61.97,51.29
    .turnin 407 >>交任务: 悲伤之地
step
    #era/som
    >>上楼去
    .goto Tirisfal Glades,61.89,52.73
    .accept 375 >>接任务: 死亡之寒
step << Priest
    #level 8
    .goto Tirisfal Glades,61.57,52.19
    .turnin 5650 >>交任务: 黑暗之衣
    .trainer >>训练你的职业法术。
step << Priest
    .goto Tirisfal Glades,61.57,52.19
    .turnin 5650 >>交任务: 黑暗之衣
step << Warrior
    #level 8
    .goto Tirisfal Glades,61.85,52.55
    .trainer >>训练你的职业咒语
step << Mage
    #level 8
    .goto Tirisfal Glades,61.97,52.48
    .trainer >>训练你的职业咒语
step << Warlock
    #level 8
    .goto Tirisfal Glades,61.59,52.39
    .trainer >>训练你的职业咒语
    .goto Tirisfal Glades,61.55,52.61
    .vendor >>如果您在培训后有钱，请购买Firebolt书籍(否则请稍后购买)
step << Rogue
    #level 8
    .goto Tirisfal Glades,61.75,52.00
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(4s1c)，就从奥利弗那里买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Warrior
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(5s36c)，从奥利弗那里买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step
    #era/som
    #sticky
    #completewith NewPlague
    >>杀死你看到的夜猫。掠夺他们的皮毛
    .complete 375,1 --Duskbat Pelt (5)
step
    >>结束杀死黑暗势力并掠夺他们的鲜血
    .complete 367,1 --Darkhound Blood (5)
    .goto Tirisfal Glades,59.47,56.40,100,0
    .goto Tirisfal Glades,64.35,55.26,100,0
    .goto Tirisfal Glades,67.48,54.85,100,0
    .goto Tirisfal Glades,63.34,50.88,100,0
       .goto Tirisfal Glades,59.47,56.40
step
    #label NewPlague
    .goto Tirisfal Glades,59.45,52.40
    .turnin 367 >>交任务: 新的瘟疫
    .accept 368 >>接任务: 新的瘟疫
step
    #era/som
    >>杀死你看到的夜猫。掠夺他们的皮毛
    .goto Tirisfal Glades,58.60,57.13,100,0
    .goto Tirisfal Glades,66.16,53.62,100,0
    .goto Tirisfal Glades,62.17,35.64,100,0
       .goto Tirisfal Glades,58.60,57.13
    .complete 375,1 --Duskbat Pelt (5)
step << Rogue/Warrior
    #era/som
    .xp 7+3800>>提升经验到3800+/4500
step << Rogue/Warrior
    #era/som
    .goto Tirisfal Glades,61.03,52.38
    >>从Abigail购买粗线
    .complete 375,2 --Coarse Thread (1)
step << Rogue/Warrior
    #era/som
    >>上楼去
    .goto Tirisfal Glades,61.89,52.73
    .turnin 375 >>交任务: 死亡之寒
step << Warrior
    .goto Tirisfal Glades,61.85,52.55
    .trainer >>训练你的8级法术
step << Rogue
    .goto Tirisfal Glades,61.75,52.00
    .trainer >>训练你的8级法术
step
    #era/som
    #sticky
    #completewith Eye
    >>掠夺地上的紫色小杂草。他们在Gnoll地区的树附近被发现
    .complete 5482,1 --Doom Weed (10)
step
    #sticky
    #completewith Eye
    >>杀死任何类型的侏儒。为他们的爱而掠夺他们
    .complete 358,3 --Embalming Ichor (8)
step
    .goto Tirisfal Glades,55.15,42.26
    .complete 358,1 --Rot Hide Graverobber (8)
step
    .goto Tirisfal Glades,58.86,31.41
    .complete 358,2 --Rot Hide Mongrel (5)
step
    #label Eye
    >>杀死魔眼。小心点，因为他可能很难对付。如果你早些时候有健康药水，请在这里使用
    .goto Tirisfal Glades,58.66,30.76
    .complete 398,1 --Maggot Eye's Paw (1)
step
   #sticky
    #label IchorAndy
    .goto Tirisfal Glades,59.61,37.09
    >>杀死任何类型的侏儒。为他们的爱而掠夺他们
    .complete 358,3 --Embalming Ichor (8)
step
    #era/som
   .goto Tirisfal Glades,56.81,40.19
    >>完成对地上紫色小杂草的掠夺。他们在Gnoll地区的树附近被发现
    .complete 5482,1 --Doom Weed (10)
step
    #requires IchorAndy
    >>杀死穆洛克。掠夺他们的鳞片-小心这里，这些暴徒是半难对付的
       .goto Tirisfal Glades,58.68,27.35,0
    .goto Tirisfal Glades,58.68,27.35,100,0
    .goto Tirisfal Glades,64.25,29.66,100,0
       .goto Tirisfal Glades,58.68,27.35
    .complete 368,1 --Vile Fin Scale (5)
step
    #softcore
    #completewith next
     .deathskip >>在布里尔死亡并重生
step
    #hardcore
    #completewith next
    .goto Tirisfal Glades,58.40,47.76,250 >>跑回布里尔。如果它上升了，你会听到
step
    #era/som
    .goto Tirisfal Glades,58.40,47.76
    .turnin 5482 >>交任务: 末日草
step
    .goto Tirisfal Glades,59.45,52.40
    .turnin 368 >>交任务: 新的瘟疫
    .accept 369 >>接任务: 新的瘟疫
step
    .goto Tirisfal Glades,60.58,51.77
    .turnin 398 >>交任务: 悬赏：蛆眼
step
    .goto Tirisfal Glades,61.26,50.84
    .turnin 358 >>交任务: 盗墓贼
    .accept 405 >>接任务: 流浪的巫妖
    .accept 359 >>接任务: 亡灵卫兵的职责
step
    #era/som
    .goto Tirisfal Glades,61.03,52.38
    >>从Abigail购买粗线
    .complete 375,2 --Coarse Thread (1)
step << Warrior
    .goto Tirisfal Glades,61.85,52.55
    .trainer >>训练你的8级法术
step
    #era/som
    >>上楼去
    .goto Tirisfal Glades,61.89,52.73
    .turnin 375 >>交任务: 死亡之寒
step << !Warrior !Rogue
    #completewith next
    +如果需要，购买食物和水
step << Warrior/Rogue
    #completewith next
    +如果需要，购买食物
step << Priest
    .goto Tirisfal Glades,61.57,52.19
    .trainer >>训练你的8级法术
step << Mage
    .goto Tirisfal Glades,61.97,52.48
    .trainer >>训练你的8级法术
step << Warlock
    .goto Tirisfal Glades,61.59,52.39
    .trainer >>训练你的8级法术
    .goto Tirisfal Glades,61.55,52.61
    .vendor >>如果您在培训后有钱，请购买Firebolt书籍(否则请稍后购买)
step << Rogue
    .goto Tirisfal Glades,61.75,52.00
    .trainer >>训练你的职业咒语
step << Rogue/Warrior
    .goto Tirisfal Glades,61.82,52.82
    .trainer >>培训急救人员制作绷带。试着在你等待的时间点，比如齐柏林飞艇，做这些事情
step
    .goto Tirisfal Glades,61.7,52.0
    .vendor >>供应商垃圾箱。如果需要，购买食物/水
step << Rogue
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(4s1c)，就从奥利弗那里买一个细高跟鞋。否则，请跳过此步骤
    .collect 2494,1
step << Warrior
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(5s36c)，从奥利弗那里买一辆格拉迪斯。否则，请跳过此步骤
    .collect 2488,1
step
    #sticky
    #completewith Letter
    >>留意该地区暴徒罕见的任务开始掉落
    .collect 2839,1,361 --Collect A Letter to Yvette (1)
    .accept 361 >>接任务: 未寄出的信件
step
    #sticky
    #label RibSkull
    >>为肋骨杀死骷髅战士，为头骨杀死骷铐脚轮
    .complete 426,1 --Notched Rib (5)
    .complete 426,2 --Blackened Skull (3)
step
    >>升级到阿加曼德磨坊。杀死德夫林并掠夺他的遗体
    .complete 362,1 --Devlin's Remains (1)
    .goto Tirisfal Glades,47.34,40.78
step
    >>杀死尼萨。她可能在大楼里
    .goto Tirisfal Glades,49.34,36.02
    .complete 354,2 --Nissa's Remains (1)
step
   .unitscan Gregor Agamand
    >>杀死格雷戈(食尸鬼)。他可以在附近巡逻
    .goto Tirisfal Glades,45.85,29.23
    .complete 354,1 --Gregor's Remains (1)
step
    #label Letter
    .unitscan Thurman Agamand
    >>杀死瑟曼(僵尸)。他可以在附近巡逻
    .goto Tirisfal Glades,42.89,32.26
    .complete 354,3 --Thurman's Remains (1)
step
    .isOnQuest 361
    .xp 9+3765>>提升经验到9 3765+/6500xp
step
    .xp 9+4245>>提升经验到9 4245+/6500xp
--N needs fixing
step
    #requires RibSkull
    #softcore
     .deathskip >>在布里尔死亡并重生
step
    #hardcore
    #completewith next
    .goto Tirisfal Glades,58.20,51.44,250 >>跑回布里尔。如果它上升了，你会听到
step
    .goto Tirisfal Glades,58.20,51.44
    .turnin 426 >>交任务: 磨坊告急
step
    .isOnQuest 361
    .goto Tirisfal Glades,61.58,52.60
    .turnin 361 >>交任务: 未寄出的信件
step
    .goto Tirisfal Glades,61.72,52.29
    .turnin 354 >>交任务: 阿加曼德家族
    .turnin 362 >>交任务: 闹鬼的磨坊
    .accept 355 >>接任务: 与塞弗伦交谈
step
    .xp 10
step
    .goto Tirisfal Glades,61.7,52.0
    .vendor >>供应商垃圾箱。如果需要，购买食物/水
step << Warrior
    .goto Tirisfal Glades,61.85,52.55
    .trainer >>训练你的职业咒语
    .accept 1818 >>接任务: 迪林格尔
step << Warrior
    .goto Tirisfal Glades,58.20,51.44
    .turnin 1818 >>交任务: 迪林格尔
    .accept 1819 >>接任务: 切割者奥拉格
step << Warrior
    .goto Tirisfal Glades,59.16,48.51
    >>点击地面上的头骨。这将召唤乌拉格。杀了他
    .complete 1819,1 --Ulag the Cleaver (1)
step << Warrior
    .goto Tirisfal Glades,58.20,51.44
    .turnin 1819 >>交任务: 切割者奥拉格
    .accept 1820 >>接任务: 库勒曼
step << Mage
    .goto Tirisfal Glades,61.97,52.48
    .trainer >>上楼训练你的课堂咒语
    .accept 1881 >>接任务: 安娜斯塔西娅
step << Warlock
    .goto Tirisfal Glades,61.59,52.39
    .trainer >>上楼训练你的课堂咒语
     .goto Tirisfal Glades,61.62,52.68
    .accept 1478 >>接任务: 哈加尔的召唤
step << Priest
    .goto Tirisfal Glades,61.57,52.19
    .trainer >>上楼训练你的课堂咒语
step << Rogue
    .goto Tirisfal Glades,61.75,52.00
    .trainer >>上楼训练你的课堂咒语
    .accept 1885 >>接任务: 米奈特·卡加德
step << Rogue
    .goto Tirisfal Glades,60.12,53.39
    .vendor >>修理你的武器。如果你有足够的钱(4s1c)，从奥利弗那里再买一个细高跟鞋。
step << Warrior
    .goto Tirisfal Glades,60.12,53.39
    >>修理你的武器。如果你有足够的钱(5s36c)，从奥利弗那里买一辆格拉迪斯。否则，请跳过此步骤
    .collect 2488,1
step << !Warlock
    #sticky
    #completewith next
    >>该地区红色暴徒的掠夺戒指。你稍后会完成这个
    .complete 374,1 --Scarlet Insignia Ring (10)
step << !Warlock
    .goto Tirisfal Glades,51.13,67.80
    .complete 370,1 --Captain Perrine (1)
    .complete 370,2 --Scarlet Zealot (3)
    .complete 370,3 --Scarlet Missionary (3)
step
    .goto Undercity,15.06,32.86,50 >>通过下水道进入地下城
step
    >>乘一部电梯到幽暗城的主要部分
    .goto Undercity,67.72,37.88
    .home >>将您的炉石设置为幽暗城
step << Warlock
    .goto Undercity,85.07,25.99
    .turnin 1478 >>交任务: 哈加尔的召唤
    .accept 1473 >>接任务: 虚空中的生物
step << Rogue
    .goto Undercity,83.53,69.09
    .turnin 1885 >>交任务: 米奈特·卡加德
    .accept 1886 >>接任务: 亡灵哨兵
step << Rogue
    .goto Undercity,77.50,49.63
    .vendor >>从纳撒尼尔那里购买你的11级投掷。11级时装备它
step << Rogue
    .money <0.3200
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一把弯刀(20秒23分)。你很快就会训练剑。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 851,1 --Collect Cutlass (1)
step << Warrior
    .money <0.3950
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一辆克莱莫尔牌汽车(26s76c)。你很快就会训练2小时剑。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 1198,1 --Collect Claymore (1)
step << Warrior/Rogue
    .goto Undercity,60.18,29.10
    .trainer >>火车铁匠。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。
    >>如果你想从事自己的职业，跳过这一步
step << Warrior/Rogue
    .goto Undercity,61.41,30.06
     >>从塞缪尔那里买一把采矿镐
    .collect 2901,1 --Mining Pick (1)
    >>如果你想从事自己的职业，跳过这一步
step << Warrior
    .goto Undercity,57.32,32.77
    .trainer >>训练2h剑
step << Rogue
    .goto Undercity,57.32,32.77
    .trainer >>训练剑
step << Warrior/Rogue
    .goto Undercity,56.04,37.47
    .trainer >>训练采矿。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。
    >>如果你想从事自己的职业，跳过这一步
step << Mage
    .goto Undercity,85.13,10.03
    .turnin 1881 >>交任务: 安娜斯塔西娅
    .accept 1882 >>接任务: 巴尼尔农场
step
    >>如果您培训了采矿，请记住在每次死亡/注销后打开查找矿物 << Rogue/Warrior
    .goto Undercity,84.06,17.44
    .turnin 405 >>交任务: 流浪的巫妖
    .accept 357 >>接任务: 巫妖的身份
step
    #sticky
    #completewith next
    .goto Undercity,82.36,15.31
    +转到右侧的试剂供应商，执行“注销跳过”，将角色定位在最低楼梯的最高部分，直到看起来像漂浮在空中，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step << Rogue
    #sticky
    #completewith UnluckyRogue
    .unitscan Astor Hadren
    >>如果你看到阿斯特，跟他谈谈，然后杀了他。抢他的信。他在布里尔和坟墓之间的道路上巡逻
    .complete 1886,1 --Astor's Letter of Introduction (1)
step << Warlock
    #sticky
    #completewith next
    >>该地区红色暴徒的掠夺戒指。你稍后会完成这个
    .complete 374,1 --Scarlet Insignia Ring (10)
step << Warlock
    .goto Tirisfal Glades,51.13,67.80
    >>把箱子里面偷走。杀死血腥暴徒
    .complete 370,1 --Captain Perrine (1)
    .complete 370,2 --Scarlet Zealot (3)
    .complete 370,3 --Scarlet Missionary (3)
    .complete 1473,1 --Egalin's Grimoire (1)
step << Warlock
    >>回到幽暗城
    .goto Undercity,85.07,25.99
    .turnin 1473 >>交任务: 虚空中的生物
    .accept 1471 >>接任务: 誓缚
step << Warlock
    >>使用召唤符文在你的包中的召唤圈顶部。杀死虚空行者
    .goto Undercity,86.60,26.95
    .complete 1471,1 --Summoned Voidwalker (1)
step << Warlock
    >>建议在你得到魔术师之前使用虚空行者
    .goto Undercity,85.07,25.99
    .turnin 1471 >>交任务: 誓缚
step << Warlock
    #sticky
    #completewith next
    .goto Undercity,85.26,19.89
    +在Relic Vendor上方执行“注销跳过”，方法是定位角色，直到其看起来像是浮动的，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Warlock
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step
    .goto Tirisfal Glades,60.58,51.76
    .turnin 370 >>交任务: 与血色十字军的战争
    .accept 371 >>接任务: 与血色十字军的战争
step
    #completewith next
    .vendor >>如果你有多余的钱并且需要袋子，你可以从酒店门口旁边的温特斯夫人那里买6个座位。否则，请跳过此步骤
step
    .goto Tirisfal Glades,61.7,52.0
    .vendor 5688 >>如果需要，在客栈内购买食物/水
step
    #label UnluckyRogue
    .goto Tirisfal Glades,65.49,60.25
    .turnin 359 >>交任务: 亡灵卫兵的职责
    .accept 360 >>接任务: 向塞弗伦回报
    .accept 356 >>接任务: 巡查后方
step << Mage
    #sticky
    #label Snapdragon
    >>点击附近的任何植物
    .goto Tirisfal Glades,77.53,61.83
    .complete 1882,1 --Balnir Snapdragons (1)
step
    .goto Tirisfal Glades,75.88,60.90
    >>在野外杀死亡灵
    .complete 356,1 --Bleeding Horror (8)
    .complete 356,2 --Wandering Spirit (8)
step
    #sticky
    #completewith next
    >>该地区红色暴徒的掠夺戒指。你稍后会完成这个
    .complete 374,1 --Scarlet Insignia Ring (10)
step
    >>修士们痊愈时要小心。在里面杀了Vachon上尉
    .complete 371,1 --Captain Vachon (1)
    .complete 371,2 --Scarlet Friar (5)
    .goto Tirisfal Glades,79.47,55.92
step
    >>杀死蜘蛛。掠夺他们的毒液
    .complete 369,1 --Vicious Night Web Spider Venom (4)
    .goto Tirisfal Glades,86.19,52.00
step
    .complete 357,1 --The Lich's Spellbook (1)
    .goto Tirisfal Glades,67.97,42.09
step
    #softcore
    #completewith next
    .goto Tirisfal Glades,66.60,44.95
    .deathskip >>死在小岛上，在布里尔重生
step
    #softcore
    #era/som
    .goto Tirisfal Glades,59.45,52.39
    .turnin 369 >>交任务: 新的瘟疫
    .accept 492 >>接任务: 新的瘟疫
    .accept 445 >>接任务: 给银松森林送信
step
    #hardcore
    #era/som
    >>跑回布里尔
    .goto Tirisfal Glades,59.45,52.39
    .turnin 369 >>交任务: 新的瘟疫
    .accept 492 >>接任务: 新的瘟疫
    .accept 445 >>接任务: 给银松森林送信
step
    #softcore
    #som
    #phase 3-6
    .goto Tirisfal Glades,59.45,52.39
    .turnin 369 >>交任务: 新的瘟疫
    .accept 492 >>接任务: 新的瘟疫
--  .accept 445 >>接任务: 给银松森林送信
step
    #hardcore
    #som
    #phase 3-6
    >>跑回布里尔
    .goto Tirisfal Glades,59.45,52.39
    .turnin 369 >>交任务: 新的瘟疫
    .accept 492 >>接任务: 新的瘟疫
--   .accept 445 >>接任务: 给银松森林送信
step
    .goto Tirisfal Glades,60.58,51.77
    .turnin 371 >>交任务: 与血色十字军的战争
    .accept 372 >>接任务: 与血色十字军的战争
step
    .goto Tirisfal Glades,61.26,50.84
    .turnin 360 >>交任务: 向塞弗伦回报
    .turnin 355 >>交任务: 与塞弗伦交谈
step
    .isQuestComplete 374
    .goto Tirisfal Glades,60.93,52.01
    .turnin 374 >>交任务: 死亡证明
step
    #completewith next
    .vendor >>如果你有多余的钱并且需要袋子，你可以从酒店门口旁边的温特斯夫人那里买6个座位。否则，请跳过此步骤
step
    .goto Tirisfal Glades,61.7,52.0
    .vendor 5688 >>如果需要，在客栈内购买食物/水
step
    .goto Tirisfal Glades,61.94,51.40
    .turnin 492 >>交任务: 新的瘟疫
step
    .hs >>炉膛到地下城
step << Mage
    >>选择任何奖励。个人偏好
    .goto Undercity,85.15,10.04
    .turnin 1882 >>交任务: 巴尼尔农场
step << Rogue
    .isQuestComplete 1886
    .goto Undercity,84.06,17.46
    .turnin 357 >>交任务: 巫妖的身份
    .accept 366 >>接任务: 归还书籍
step << Rogue
    .money <0.2200
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一把弯刀(20秒23分)。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 851,1 --Collect Cutlass (1)
step << Warrior
    .money <0.2950
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一辆克莱莫尔牌汽车(26s76c)。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 1198,1 --Collect Claymore (1)
step << Rogue
    .goto Undercity,83.52,69.10
    .turnin 1886 >>交任务: 亡灵哨兵
    .isQuestComplete 1886
step
    .goto Undercity,83.52,69.10
    .accept 1898 >>接任务: 亡灵哨兵
    .isQuestTurnedIn 1886
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,54.84,76.31
    .turnin 1898 >>交任务: 亡灵哨兵
    .accept 1899 >>接任务: 亡灵哨兵
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,55.43,76.87
    >>在Andron身后掠夺书架
    .complete 1899,1
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,83.53,69.12
    .turnin 1899 >>交任务: 亡灵哨兵
    .accept 1978 >>接任务: 亡灵哨兵
step << Rogue
    .isQuestTurnedIn 1886
    .goto Tirisfal Glades,58.86,78.76,40,0
    .goto Tirisfal Glades,59.75,84.64
    .turnin 1978 >>交任务: 亡灵哨兵
    >>转到主平台的边缘，执行“注销跳过”，方法是定位角色，直到其看起来像是浮动的，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=jj85AXyF1XE >>当跑向转弯处时，打开此标签。单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Rogue
    .isQuestTurnedIn 1886
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step
    .goto Undercity,84.06,17.46
    .turnin 357 >>交任务: 巫妖的身份
    .accept 366 >>接任务: 归还书籍
step
    #sticky
    #completewith next
    .goto Undercity,82.36,15.31
    +转到右侧的试剂供应商，执行“注销跳过”，将角色定位在最低楼梯的最高部分，直到看起来像漂浮在空中，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step
    .goto Tirisfal Glades,65.49,60.25
    .turnin 356 >>交任务: 巡查后方
step
    #sticky
    #label Rings
    >>你看到的猩红暴徒的掠夺戒指
    .complete 374,1 --Scarlet Insignia Ring (10)
step
    .goto Tirisfal Glades,79.52,25.14
    >>杀死塔内的Mellache上尉和他的卫兵
    >>途中碾碎暴徒 << Warrior/Mage
    .complete 372,1 --Captain Melrache (1)
    .complete 372,2 --Scarlet Bodyguard (2)
step << Mage/Warrior
    .isOnQuest 374
    .xp 11+5300>>提升经验到5300+/8800xp
step << Mage/Warrior
    .isQuestTurnedIn 374
    .xp 11+5925>>提升经验到5925+/8800xp
step
    #requires Rings
    .goto Tirisfal Glades,68.19,41.92
    .turnin 366 >>交任务: 归还书籍
    .accept 409 >>接任务: 证明忠诚
step
    .goto Tirisfal Glades,68.16,42.01
    >>掠夺地上的那盒蜡烛
    .collect 3080,1 --Collect Candle of Beckoning (1)
step
    .goto Tirisfal Glades,66.64,44.89
    >>在岛中央的桌子上单击鼠标右键。在Nefara产卵时杀死她
    .turnin 410 >>交任务: 潜伏的阴影
    .complete 409,1 --Lillith Nefara (1)
step << Mage/Warrior
    .isOnQuest 374
    .xp 11+5900>>提升经验到5900+/8800xp
step << Mage/Warrior
    .isQuestTurnedIn 374
    .xp 11+6525>>提升经验到6525+/8800xp
step
    .goto Tirisfal Glades,68.20,41.92
    .turnin 409 >>交任务: 证明忠诚
    .accept 411 >>接任务: 巫妖归顺
step
    #softcore
    #completewith next
    .deathskip >>向西游，被暴徒杀死，在布里尔重生
    .goto Tirisfal Glades,64.40,42.65
step
    #softcore
    .goto Tirisfal Glades,60.58,51.77
    .turnin 372 >>交任务: 与血色十字军的战争
step
    #hardcore
    >>跑回布里尔
    .goto Tirisfal Glades,60.58,51.77
    .turnin 372 >>交任务: 与血色十字军的战争
step
    .goto Tirisfal Glades,60.93,52.01
    .turnin 374 >>交任务: 死亡证明
step << Rogue
    #sticky
    #completewith next
    .unitscan Astor Hadren
    >>如果你看到阿斯特，跟他谈谈，然后杀了他。抢他的信。他在布里尔和坟墓之间的道路上巡逻
    .complete 1886,1 --Astor's Letter of Introduction (1)
step
    .goto Undercity,66.36,0.36
    .zone Undercity >>前往: 幽暗城
step << Rogue/Warrior
    .isQuestComplete 1886 << Rogue
    .goto Undercity,84.06,17.46
    .turnin 411 >>交任务: 巫妖归顺
step << Rogue
    .money <0.2200
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一把弯刀(20秒23分)。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 851,1 --Collect Cutlass (1)
step << Warrior
    #level 12
    .goto Undercity,46.93,15.23
    .trainer >>训练你的职业咒语
step << Warrior
    .money <0.2950
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一辆克莱莫尔牌汽车(26s76c)。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 1198,1 --Collect Claymore (1)
step << Warrior
    #sticky
    #completewith next
    .goto Undercity,82.36,15.31
    +执行注销跳过，方法是定位角色，直到其看起来像漂浮在桥的边缘，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Warrior
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step << Rogue
    .goto Undercity,83.52,69.10
    .turnin 1886 >>交任务: 亡灵哨兵
    .isQuestComplete 1886
step << Rogue
    .goto Undercity,83.52,69.10
    .accept 1898 >>接任务: 亡灵哨兵
    .isQuestTurnedIn 1886
step << Rogue
    #level 12
    .goto Undercity,83.87,72.08
    .trainer >>训练你的职业咒语
step << Priest
     #level 12
    .goto Undercity,48.98,18.33
    .trainer >>训练你的职业咒语
    .turnin 5663 >>交任务: 虚弱之触
step << Priest
    .goto Undercity,48.98,18.33
    .turnin 5663 >>交任务: 虚弱之触
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,54.84,76.31
    .turnin 1898 >>交任务: 亡灵哨兵
    .accept 1899 >>接任务: 亡灵哨兵
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,55.43,76.87
    >>在Andron身后掠夺书架
    .complete 1899,1
step << Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,83.53,69.12
    .turnin 1899 >>交任务: 亡灵哨兵
    .accept 1978 >>接任务: 亡灵哨兵
step << Rogue
    .isQuestTurnedIn 1886
    .goto Tirisfal Glades,58.86,78.76,40,0
    .goto Tirisfal Glades,59.75,84.64
    .turnin 1978 >>交任务: 亡灵哨兵
    >>转到主平台的边缘，执行“注销跳过”，方法是定位角色，直到其看起来像是浮动的，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=jj85AXyF1XE >>当跑向转弯处时，打开此标签。单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Rogue
    .isQuestTurnedIn 1886
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step << !Warrior
    .goto Undercity,84.07,17.45
    .turnin 411 >>交任务: 巫妖归顺
step << Mage
    #level 12
    .goto Undercity,85.14,10.04
    .trainer >>训练你的职业咒语
step << Warlock
    #level 12
    .goto Undercity,86.20,15.92
    .trainer >>在建筑内训练你的职业法术
step << !Warrior
    #era/som
    .goto Undercity,46.16,43.97,50,0
    .goto Undercity,41.04,33.26,50,0
    .goto Undercity,23.86,35.90,50,0
    .goto Undercity,15.06,32.86,50 >>通过下水道退出地下城
step << !Warrior
    #som
    #phase 3-6
    #sticky
    #completewith next
    .goto Undercity,82.36,15.31
    +执行注销跳过，方法是定位角色，直到其看起来像漂浮在桥的边缘，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << !Warrior
    #som
    #phase 3-6
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step << Undead
    #som
    #phase 3-6
    #sticky
    #completewith next
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。在等待时制作磨砂石/绷带 << Warrior/Rogue
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。在等待时召唤食物/水 << Mage
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。 << !Warrior !Rogue !Mage
    .goto Tirisfal Glades,60.74,58.74
step << Undead
    #som
    #phase 3-6
    .goto Tirisfal Glades,60.89,59.06,30,0
    .goto Tirisfal Glades,60.73,58.76
    .zone Durotar >>前往: 杜隆塔尔
step << Undead
    #som
    #phase 3-6
    >>跑向Razor Hill
    .goto Durotar,50.85,43.59
    .accept 840 >>接任务: 部落的新兵
step << Undead
    #som
    #phase 3-6
    >>前往: 贫瘠之地
    .goto The Barrens,62.26,19.38
    .turnin 840 >>交任务: 部落的新兵
    .accept 842 >>接任务: 十字路口征兵
step << Undead
    #som
    #phase 3-6
    .goto The Barrens,52.23,31.01
    .turnin 842 >>交任务: 十字路口征兵
    .accept 844 >>接任务: 平原陆行鸟的威胁
step << Mage
    #som
    #phase 3-6
    +如果您计划通过AoE调平，请手动选择“荒地AoE指南”。否则，请完成此步骤
]])

RXPGuides.RegisterGuide([[
#group RestedXP部落1-22
<< Horde
#version 1
#defaultfor Undead/Troll Rogue/Orc Rogue
#classic
#era/som
#name 11-14 银松森林
#next 12-17 贫瘠之地

step << !Undead Rogue
    .goto Tirisfal Glades,61.87,65.02,40 >>前往: 幽暗城
step << !Undead Rogue
    .goto Tirisfal Glades,61.81,74.42,30 >>跑到电梯间
step << !Undead Rogue
    >>把其中一部电梯放下
    .goto Undercity,63.25,48.56
    .fp Undercity >>获取幽暗城飞行路线
step << !Undead Rogue
    .money <0.3023
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。从他那里买一把弯刀(20秒23分)。你很快就会训练剑。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .collect 851,1 --Collect Cutlass (1)
step << !Undead Rogue
    #softcore
    .goto Undercity,57.32,32.77
    .trainer >>训练剑。如果你之前没有足够的钱买一把弯刀，那么在买完之后，检查AH是否有武器
step << !Undead Rogue
    #hardcore
    .goto Undercity,57.32,32.77
    .trainer >>训练剑。如果你之前没有足够的钱买一把弯刀，那么从你看到的下一个小贩那里买一件便宜的武器，或者在任务中等待一件掉落
step << !Undead Rogue
    .goto Undercity,46.5,44.0,90 >>通过下水道退出地下城
step
    .goto Tirisfal Glades,54.90,72.42,120,0
    .zone Silverpine Forest >>前往: 银松森林
step
    #sticky
    #completewith Rane
    .goto Silverpine Forest,57.42,9.80
    >>杀死Worgs，掠夺他们的心。
    .collect 3164,6 --Collect Discolored Worg Heart (x6)
step
    .unitscan Gorefang
    >>与埃兰交谈，启动他的护航。全血/魔法值开始
    .goto Silverpine Forest,56.19,9.18
    .accept 435 >>接任务: 护送埃兰德
step
    >>小心，一次最多可以有2只狼拉。战斗结束后立即进食/饮水
    .goto Silverpine Forest,54.12,13.45
    .complete 435,1 --Erland must reach Rane Yorick (1)
step
    #label Rane
    .goto Silverpine Forest,53.46,13.43
    .turnin 435 >>交任务: 护送埃兰德
    .accept 429 >>接任务: 荒野之心
    .accept 449 >>接任务: 亡灵哨兵的报告
step
    >>杀死Worgs，掠夺他们的心。
    .goto Silverpine Forest,57.42,9.80
    .collect 3164,6 --Collect Discolored Worg Heart (6)
step
    #completewith next
    .goto Silverpine Forest,45.01,39.30
    .vendor >>供应商垃圾箱。修理
step
    #sticky
    #completewith next
    #softcore
    .deathskip >>在坟墓中死去并重生
step
    .goto Silverpine Forest,44.21,39.81
    .accept 421 >>接任务: 证明你的价值
    #softcore
step
    >>跑向坟墓
    .goto Silverpine Forest,44.21,39.81
    .accept 421 >>接任务: 证明你的价值
    #hardcore
step
    .goto Silverpine Forest,43.98,40.93
    .accept 477 >>接任务: 越境
step << Undead
    .goto Silverpine Forest,43.43,41.67
    .accept 6321 >>接任务: 瑟伯切尔的补给
step
    #sticky
    #completewith next
    .goto Silverpine Forest,43.17,41.28
    .vendor >>如果需要，购买食物/水
step
    >>下楼去地窖
    .goto Silverpine Forest,43.43,40.87
    .turnin 449 >>交任务: 亡灵哨兵的报告
    .accept 3221 >>接任务: 与伦弗利尔会面
    .accept 437 >>接任务: 亡者农场
step
    .goto Silverpine Forest,42.80,40.86
    .turnin 429 >>交任务: 荒野之心
    .turnin 445 >>交任务: 给银松森林送信
    .turnin 3221 >>交任务: 与伦弗利尔会面
    .accept 1359 >>接任务: 给金格的货物
    .accept 447 >>接任务: 致命的配方
    .accept 430 >>接任务: 回到奎恩身旁
step
    .goto Silverpine Forest,43.98,39.89
    .vendor >>用Edwin的6个插槽填充您的包插槽。如果你有多余的钱，就买药水
step << Warlock/Mage/Priest
    #completewith next
    .money <0.1400
    .goto Silverpine Forest,44.80,39.24
    .vendor >>与安德里亚交谈，检查智者腰带。如果价格上涨就买
step
    .unitscan Son of Arugal
    .goto Silverpine Forest,50.00,39.46,70,0
    .goto Silverpine Forest,49.19,34.42,70,0
    .goto Silverpine Forest,50.00,39.46
    >>杀死该地区的Moonrage Whitescalps。避开阿鲁加尔之子
    .complete 421,1 --Moonrage Whitescalp (5)
step
    .goto Silverpine Forest,44.19,39.78
    .turnin 421 >>交任务: 证明你的价值
    .accept 422 >>接任务: 阿鲁高的愚行
step
    #sticky
    #completewith Nightlash
    >>杀死熊。掠夺他们的心
    .complete 447,1 --Grizzled Bear Heart (6)
step
    >>进入瓦尔根庄园房子的二楼。掠夺地板上的书
    .goto Silverpine Forest,52.82,28.58
    .complete 422,1 --Remedy of Arugal (1)
step
    >>到楼上去
    .goto Silverpine Forest,53.43,12.59
    .turnin 430 >>交任务: 回到奎恩身旁
step
    >>回到外面去
    .goto Silverpine Forest,53.46,13.43
    .accept 425 >>接任务: 邪恶的伊瓦
step
    >>在谷仓杀死伊瓦尔。抢走他的头
    .goto Silverpine Forest,51.51,13.90
    .complete 425,1 --Ivar's Head (1)
step
    .goto Silverpine Forest,53.46,13.43
    .turnin 425 >>交任务: 邪恶的伊瓦
step
    #label Nightlash
    .unitscan Nightlash
    >>杀死死地周围的侏儒，直到夜鞭繁殖。为了她的精华而杀死并掠夺她
    .goto Silverpine Forest,45.44,21.01
    .complete 437,1 --Enter the Dead Fields (1)
    .complete 437,2 --Essence of Nightlash (1)
step
    .unitscan Son of Arugal
    >>杀死该地区的熊。掠夺他们的心。避开阿鲁加尔之子
    .goto Silverpine Forest,41.73,17.83
    .complete 447,1 --Grizzled Bear Heart (6)
step
    .unitscan Krethis Shadowspinner
    >>杀死该地区的蜘蛛。抢他们的血。
    >>小心这个地区的稀有物种，因为这不可能是困难的 << !Mage !Warlock
    >>小心这个地区的稀有物种，因为这很难但可行。她在15秒的冷却时间内拥有130点伤害的护盾，110点伤害的瞬间冲击能力 << Mage/Warlock
    .goto Silverpine Forest,35.81,14.44
    .complete 447,2 --Skittering Blood (6)
step
    #softcore
    .deathskip >>在坟墓中死去并重生
step
    #era
    #hardcore
    >>跑回坟墓
    .goto Silverpine Forest,44.20,39.75
    .turnin 422 >>交任务: 阿鲁高的愚行
    .accept 423 >>接任务: 阿鲁高的愚行
step
    #som
    #hardcore
    >>跑回坟墓
    .goto Silverpine Forest,44.20,39.75
    .turnin 422 >>交任务: 阿鲁高的愚行
step << Warlock/Mage/Priest
    #completewith next
    .money <0.1400
    .goto Silverpine Forest,44.80,39.24
    >>与安德里亚交谈，检查智者腰带。如果价格上涨就买
    .collect 4786,1
step
    #era
    #softcore
    .goto Silverpine Forest,44.20,39.75
    .turnin 422 >>交任务: 阿鲁高的愚行
    .accept 423 >>接任务: 阿鲁高的愚行
step
    #som
    #softcore
    .goto Silverpine Forest,44.20,39.75
    .turnin 422 >>交任务: 阿鲁高的愚行
step
    >>下到地穴
    .goto Silverpine Forest,43.43,40.87
    .turnin 437 >>交任务: 亡者农场
    .accept 438 >>接任务: 破旧渡口
step << Undead
    .goto Silverpine Forest,45.62,42.60
    >>还不要去地下城
    .turnin 6321 >>交任务: 瑟伯切尔的补给
    .accept 6323 >>接任务: 飞往幽暗城
    .fp Sepulcher >>获取墓穴飞行路线
step
    >>单击船
    .goto Silverpine Forest,58.39,34.79
    .turnin 438 >>交任务: 破旧渡口
    .accept 439 >>接任务: 线索
step
    #era
    #label Shackles
    >>杀死该地区的沃根。掠夺他们的镣铐
    .goto Silverpine Forest,56.24,46.61
    .complete 423,1 --Glutton Shackle (6)
    .complete 423,2 --Darksoul Shackle (3)
step
    #softcore
    .goto Silverpine Forest,49.89,60.33
    >>跑进营地，点击板条箱。进去，拿起任务，然后死去。当暴徒施放冰箭时要小心
    .turnin 477 >>交任务: 越境
    .accept 478 >>接任务: 地图与符记
    .deathskip >>在坟墓中死去并重生
step
    #hardcore
    .goto Silverpine Forest,49.89,60.33
    >>点击营地中的板条箱。小心杀死该区域的暴徒，因为他们会施放冰霜箭，很容易逃跑并攻击其他暴徒
    .turnin 477 >>交任务: 越境
    .accept 478 >>接任务: 地图与符记
step
    #softcore
    .goto Silverpine Forest,43.98,40.93
    .turnin 478 >>交任务: 地图与符记
    .accept 481 >>接任务: 达拉尔的推理
step
    #hardcore
    >>跑回坟墓
    .goto Silverpine Forest,43.98,40.93
    .turnin 478 >>交任务: 地图与符记
    .accept 481 >>接任务: 达拉尔的推理
step
    #era
    .goto Silverpine Forest,44.18,39.77
    .turnin 423 >>交任务: 阿鲁高的愚行
    .turnin 481 >>交任务: 达拉尔的推理
    .accept 482 >>接任务: 达拉然的意图
--    .accept 424 >>接任务: 阿鲁高的愚行
step
    #som
    .goto Silverpine Forest,44.18,39.77
    .turnin 481 >>交任务: 达拉尔的推理
    .accept 482 >>接任务: 达拉然的意图
--    .accept 424 >>接任务: 阿鲁高的愚行
step
    .goto Silverpine Forest,43.98,40.93
    .turnin 482 >>交任务: 达拉然的意图
--   .accept 479 >>接任务: 调查安伯米尔
step
    >>下楼到地下室
    .goto Silverpine Forest,43.43,40.87
    .turnin 439 >>交任务: 线索
    .accept 440 >>接任务: 黛丽娅的戒指 << Undead
--   .accept 443 >>接任务: 腐皮豺狼人的脓液
-- Engraved ring q line worth it depending on class?
step << Undead
    .xp 14
step << Undead
    .hs >>炉膛到地下城
step << !Undead Rogue
   .goto Silverpine Forest,45.62,42.60
    .fp Sepulcher >>获取墓穴飞行路线
    .fly Undercity >>飞到地下城
step << Undead
    .goto Undercity,61.48,41.81
    .turnin 6323 >>交任务: 飞往幽暗城
    .accept 6322 >>接任务: 迈克尔·加勒特
step << Undead
    .goto Undercity,63.27,48.55
    .turnin 6322 >>交任务: 迈克尔·加勒特
--    .accept 6324 >>接任务: 向博迪瑞格回报
step << Warrior
    .goto Undercity,46.93,15.23
    .trainer >>训练你的职业咒语
step << Undead Rogue
    .isQuestComplete 1886
    .goto Undercity,83.52,69.10
    .turnin 1886 >>交任务: 亡灵哨兵
step << Undead Rogue
    .goto Undercity,83.52,69.10
    .accept 1898 >>接任务: 亡灵哨兵
    .isQuestTurnedIn 1886
step << Rogue
    .goto Undercity,83.87,72.08
    .trainer >>训练你的职业咒语
step << Priest
    .goto Undercity,48.98,18.33
    .trainer >>训练你的职业咒语
step << Undead Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,54.84,76.31
    .turnin 1898 >>交任务: 亡灵哨兵
    .accept 1899 >>接任务: 亡灵哨兵
step << Undead Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,55.43,76.87
    >>在Andron身后掠夺书架
    .complete 1899,1
step << Undead Rogue
    .isQuestTurnedIn 1886
    .goto Undercity,83.53,69.12
    .turnin 1899 >>交任务: 亡灵哨兵
    .accept 1978 >>接任务: 亡灵哨兵
step << Mage
    .goto Undercity,85.15,10.04
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Undercity,86.20,15.92
    .trainer >>在建筑内训练你的职业法术
step
    .goto Undercity,52.86,77.72,40,0
    .goto Undercity,48.83,69.28
    .turnin 447 >>交任务: 致命的配方
step
    .goto Undercity,50.15,67.98
    .turnin 1359 >>交任务: 给金格的货物
    .accept 1358 >>接任务: 给赫布瑞姆的样本
step << Undead Rogue
    .isQuestTurnedIn 1886
    .goto Tirisfal Glades,58.86,78.76,40,0
    .goto Tirisfal Glades,59.75,84.64
    .turnin 1978 >>交任务: 亡灵哨兵
    >>转到主平台的边缘，执行“注销跳过”，方法是定位角色，直到其看起来像是浮动的，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=jj85AXyF1XE >>当跑向转弯处时，打开此标签。单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Undead Rogue
    .isOnQuest 1886
    >>放弃死亡追踪者，没有机会了
    .abandon 1886 >>抛弃死亡追踪者
step << Undead !Rogue
    #sticky
    #completewith next
    +执行注销跳过，跳到身后的书架上，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=c0DFOlRQrKs >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << !Undead Rogue
    .hs >>炉膛到十字路口
step << Undead
    .goto Tirisfal Glades,61.85,66.59,60 >>退出地下城
step << Undead
    .goto Tirisfal Glades,61.26,50.84
    .turnin 440 >>交任务: 黛丽娅的戒指
    .accept 441 >>接任务: 拉林夫与幽暗城
step << Undead
    #sticky
    #completewith next
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。在等待时制作磨砂石/绷带 << Warrior/Rogue
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。在等待时召唤食物/水 << Mage
    +登上齐柏林塔。把齐柏林飞艇带到奥格瑞玛。 << !Warrior !Rogue !Mage
    .goto Tirisfal Glades,60.74,58.74
step << Undead
    .zone Durotar >>前往: 杜隆塔尔
step << Undead
    .goto Durotar,50.85,43.59
    .accept 840 >>接任务: 部落的新兵
step << Undead
    .goto The Barrens,62.26,19.38
    .turnin 840 >>交任务: 部落的新兵
    .accept 842 >>接任务: 十字路口征兵
step << Undead
    >>途中碾碎暴徒 << Warrior/Rogue
    .goto The Barrens,52.23,31.01
    .turnin 842 >>交任务: 十字路口征兵
    .accept 844 >>接任务: 平原陆行鸟的威胁
step << Mage
    +如果您计划通过AoE调平，请手动选择“荒地AoE指南”。否则，请完成此步骤
]])
