RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 1-6 提瑞斯法林地
#version 1
#group RestedXP部落1-30
#defaultfor Scourge
#next 6-10 永歌森林
step << !Scourge
    #sticky
    #completewith next
    .goto Tirisfal Glades,30.2,71.7
    +您选择了一个为亡灵准备的指南。建议您选择与开始时相同的起始区域
step
	.destroy 6948
    >>跑出地窖并删除您的炉石 << tbc
    .goto Tirisfal Glades,30.2,71.7 << tbc
    .goto Tirisfal Glades,29.99,71.86 << wotlk
    .accept 363 >>接任务: 突然醒来
step << Warrior
    #sticky
    #completewith vendorWar
    +把暴徒赶到镇上，直到你有价值10美分的商品
    .goto Tirisfal Glades,31.5,69.8
step << Warlock tbc
    #sticky
    #completewith vendorLock
    +把暴徒赶到镇上，直到你有价值10美分的商品
    .goto Tirisfal Glades,31.5,69.8
step << Priest/Mage
    #sticky
    #completewith vendorCaster
    +把暴徒赶到镇上，直到你有价值35美分的商品
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
    .vendor >>供应商扔掉垃圾，然后购买10杯清凉泉水 << tbc
    .vendor >>供应商垃圾箱 << wotlk	
	.collect 159,10 << tbc --Collect Refreshing Spring Water (x10)
step << Warlock tbc
    #label vendorLock
    .goto Tirisfal Glades,30.8,66.4
    .vendor >>Demon Trainer的供应商垃圾
step << Warlock tbc
    .goto Tirisfal Glades,30.9,66.3
    .train 348 >>火车献祭
step << Warlock tbc
    .goto Tirisfal Glades,31.0,66.4
    .accept 1470 >>接任务: 控制小鬼
step << Warlock
    .goto Tirisfal Glades,30.8,66.2
    .turnin 363 >>交任务: 突然醒来
    .accept 364 >>接任务: 无脑的僵尸
step << Warlock tbc
    .goto Tirisfal Glades,32.5,61.4
    >>在头骨区域杀死鼠笼骷髅
    .complete 1470,1 --Rattlecage Skull (3)
step << Warlock tbc
    #completewith next
    .goto Tirisfal Glades,32.3,65.4,30 >>在回镇的路上磨磨蹭蹭，直到你有25c+的可卖品
step << Warlock tbc
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商清理垃圾并从Joshua那里购买5杯水
	.collect 159,5 --Collect Refreshing Spring Water (x5)
step << Warlock tbc
    >>在你完成任务后召唤你的小鬼
    .goto Tirisfal Glades,31.0,66.4
    .turnin 1470 >>交任务: 控制小鬼
step << Warlock tbc
    .xp 2 >>升级到2级
step << Mage
    #completewith next
    .goto Tirisfal Glades,30.9,66.1
    .trainer >>训练你的职业咒语
step << Priest
    #completewith next
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
step !Warlock tbc
	.goto Tirisfal Glades,32.4,62.8
	.xp 2 >>升级到2级
step << Mage tbc/Warlock tbc/Priest tbc
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商扔掉垃圾，再购买10瓶水
	.collect 159,10 --Collect Refreshing Spring Water (x10)
step << Mage wotlk/Priest wotlk
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step << Warrior/Rogue
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step << Warlock wotlk
    .goto Tirisfal Glades,32.3,65.4
	.money >0.0054
	.vendor >>研磨暴徒，直到你得到总共54铜。(从卖完所有商品后的商品)
	*We will get 17c from a the next quest turn in and 12c from starting gear
--95c for imp
step
    .goto Tirisfal Glades,30.8,66.2
    .turnin 364 >>交任务: 无脑的僵尸
step
    .goto Tirisfal Glades,30.8,66.2
    .accept 3095 >>接任务: 简易卷轴 << Warrior
    .accept 3096 >>接任务: 密文卷轴 << Rogue
    .accept 3097 >>接任务: 神圣卷轴 << Priest
    .accept 3098 >>接任务: 雕文卷轴 << Mage
    .accept 3099 >>接任务: 被污染的卷轴 << Warlock
    .accept 3901 >>接任务: 断骨骷髅
    .accept 376 >>接任务: 被诅咒者
step << Mage
    .goto Tirisfal Glades,30.9,66.1
    .turnin 3098 >>交任务: 雕文卷轴
step << Warlock
    .goto Tirisfal Glades,30.9,66.3
    .turnin 3099 >>交任务: 被污染的卷轴
step << Warlock wotlk
	#completewith next
    .goto Tirisfal Glades,32.3,65.4
	.money >0.0095
	.vendor >>研磨暴徒，直到你得到总共95铜。如果有助于获得95铜，请尽可能提供任何产品。
--95c for imp	
step << Warlock wotlk
	#label impcheck
	.goto Tirisfal Glades,30.9,66.3
	.train 688 >>列车召唤小鬼
step << Priest
    .goto Tirisfal Glades,31.1,66.0
    .turnin 3097 >>交任务: 神圣卷轴
step << Warlock wotlk
	#completewith next
	.cast 688 >>召唤你的小鬼
step
    .goto Tirisfal Glades,29.5,67.2,40,0
    .goto Tirisfal Glades,29.6,61.3,50,0
    .goto Tirisfal Glades,32.5,56.7,50,0
    .goto Tirisfal Glades,35.2,57.0,50,0
    .goto Tirisfal Glades,29.5,67.2,40,0
    .goto Tirisfal Glades,29.6,61.3,50,0
    .goto Tirisfal Glades,32.5,56.7,50,0
    .goto Tirisfal Glades,35.2,57.0,50,0
    >>杀死和掠夺狼和夜猫
    .complete 376,1 --Collect Scavenger Paw (x6)
    .complete 376,2 --Collect Duskbat Wing (x6)
step
    .goto Tirisfal Glades,33.15,60.70
    >>杀死镇上的骷髅
    .complete 3901,1 --Kill Rattlecage Skeleton (12)
step
    .xp 3+980>>在返回城镇的路上碾碎暴徒，达到980+/1400经验
step << Mage tbc/Mage wotlk/Warlock tbc
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾和购买水的温度不低于95摄氏度
step << Warlock wotlk
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾
step << Priest
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾处理和购买水，温度不低于1s 90c
step
    .turnin 3901 >>交任务: 断骨骷髅
    .goto Tirisfal Glades,30.9,66.2	
    .turnin 376 >>交任务: 被诅咒者	
    .accept 6395 >>接任务: 玛拉的遗愿	
    .goto Tirisfal Glades,30.9,66.1	
step << Priest
    #completewith next
    .goto Tirisfal Glades,31.1,66.0
    .trainer >>训练你的职业咒语
step << Warlock
    #completewith next
    .goto Tirisfal Glades,30.9,66.3
    .trainer >>训练你的职业咒语
step << Mage
    #completewith next    
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
step << Warrior
    .goto Tirisfal Glades,32.7,65.6    
    #completewith next    
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
    #requires Goods
    .goto Tirisfal Glades,27.1,59.0,80,0
    .goto Tirisfal Glades,26.8,59.4,30,0
    .goto Tirisfal Glades,24.0,58.2,60,0
	.goto Tirisfal Glades,27.1,59.0
    >>杀死洞穴外的年轻蜘蛛，然后进入洞穴，杀死洞穴内的夜蛛。我们在山洞里跳得死去活来，在你进去之前，一定要把年轻的蜘蛛都处理好。
    .complete 380,1 --Kill Young Night Web Spider (10)
	.complete 380,2 --Kill Night Web Spider (x8)
step
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    .goto Tirisfal Glades,31.6,65.6
	.cast 688 >>恢复你的小鬼 << Warlock
    .turnin 3902 >>交任务: 捡破烂
step << Rogue/Warrior
    .goto Tirisfal Glades,32.41,65.66
    .vendor >>供应商丢弃并修复您的武器
step << Priest tbc/Mage tbc/Warlock tbc
    .goto Tirisfal Glades,32.3,65.4
    .vendor >>供应商垃圾处理和购买15水
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
    .unitscan Samuel Fipps
step
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
step << Warlock
	#completewith next
	.cast 688 >>恢复你的小鬼
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
    >>开始走出死亡丧钟
    .xp 5+2350>>途中提升经验到2350+/2800xp
step
    .goto Tirisfal Glades,38.2,56.8
    .accept 8 >>接任务: 潜行者的交易
step
	.goto Tirisfal Glades,42.59,51.30,50,0
	.goto Tirisfal Glades,42.59,51.30	
    .deathskip >>在布里尔的精神疗养院死亡并重生
step
    .goto Tirisfal Glades,60.6,51.8
    .turnin 383 >>交任务: 重要情报
step
    .goto Tirisfal Glades,61.7,52.0
    .turnin 8 >>交任务: 潜行者的交易
    .vendor >>供应商垃圾
step << Warrior
    .xp 6 >>升级到6
step << Warrior
    .goto Tirisfal Glades,61.9,52.5
    .trainer >>列车招架
step
    #completewith next
    .goto Undercity,66.2,1.1,25 >>前往幽暗城
step
    .goto Undercity,62.0,11.3,20 >>在这里上楼梯
step
    #completewith next
    .goto Undercity,54.9,11.3,20 >>使用易位球
step
    .zone Silvermoon City >>前往: 银月城
step
    #completewith next
    .goto Eversong Woods,56.7,49.6,20 >>用完银月城
step
    .goto Eversong Woods,54.4,50.7
    .fp Silvermoon City >>获取银月城飞行路线
step
    .goto Eversong Woods,50.3,50.8
    .accept 8475 >>接任务: 死亡之痕
step
    .goto Eversong Woods,46.5,49.2,35 >>跑向鹰翼广场
]])

