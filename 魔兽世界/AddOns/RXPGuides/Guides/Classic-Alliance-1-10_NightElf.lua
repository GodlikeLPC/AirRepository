RXPGuides.RegisterGuide([[
#classic
<< Alliance
#name 1-6 幽影谷
#version 1
#group RestedXP 联盟 1-20
#defaultfor NightElf
#next 6-11 泰达希尔
step << !NightElf
    #sticky
    #completewith next
    +你选择了一个暗夜精灵的向导。你应该选择与你开始时相同的起始区域
step
    .goto Teldrassil,58.7,44.4
    .accept 456 >>接任务: 自然的平衡
step
    #sticky
    #label balance1
    .goto Teldrassil,62.0,42.6
    .complete 456,1 --Kill Young Nightsaber (x7)
    .complete 456,2 --Kill Young Thistle Boar (x4)
step
    .xp 2
step
    .accept 458 >>接任务: 森林守护者
	.goto Teldrassil,59.9,42.5
    .accept 4495 >>接任务: 好朋友
    .goto Teldrassil,60.9,42.0
step << Hunter
    #era
    .goto Teldrassil,59.8,34.1
    .xp 4-610 >>研磨直到距离4级610xp(790/1400)
step << Hunter
    #som
    .goto Teldrassil,59.8,34.1
    .xp 4-755 >>研磨直到距离4级755xp(645/1400)
step << Hunter
    .goto Teldrassil,54.6,33.0
    .turnin 4495 >>交任务: 好朋友
    .accept 3519 >>接任务: 需要帮助的朋友
step << Hunter
    #sticky
    #completewith next
    .hs >>炉底回到起跑区
step << Hunter
    .goto Teldrassil,57.9,45.1
    .turnin 458 >>交任务: 森林守护者
    .accept 459 >>接任务: 森林守护者
step
    #requires balance1
	.goto Teldrassil,58.7,44.2
    .turnin 456 >>交任务: 自然的平衡
    .accept 457 >>接任务: 自然的平衡
	.accept 3116 >>接任务: 简易符记 << Warrior
	.accept 3117 >>接任务: 风化符记 << Hunter
--	.accept 3118 >>接任务: 密文符记 << Rogue
	.accept 3119 >>接任务: 神圣符记 << Priest
	.accept 3120 >>接任务: 绿色符记 << Druid
step << Warrior
    .goto Teldrassil,59.3,41.1
	.vendor >>进屋和供应商垃圾箱
step << Warrior
	.goto Teldrassil,59.6,38.4
	.turnin 3116 >>交任务: 简易符记
	.trainer >>跑上供应商后面的楼梯。训练师的训练战斗口号
step << !Hunter
    .goto Teldrassil,59.8,34.1
    .complete 457,1 --Kill Mangy Nightsaber (x7)
    .complete 457,2 --Kill Thistle Boar (x7)
step << !Hunter
    .goto Teldrassil,54.6,33.0
    .turnin 4495 >>交任务: 好朋友
    .accept 3519 >>接任务: 需要帮助的朋友
step << !Hunter
    #sticky
    #completewith next
    .hs >>炉底回到起跑区
step << !Hunter
    .goto Teldrassil,57.9,45.1
    .turnin 458 >>交任务: 森林守护者
    .accept 459 >>接任务: 森林守护者
step << !Hunter
    .goto Teldrassil,58.6,44.3
    .turnin 457 >>交任务: 自然的平衡
step
    .goto Teldrassil,60.9,42.0
    .turnin 3519 >>交任务: 需要帮助的朋友
    .accept 3521 >>接任务: 埃沃隆的解药
step << Hunter
    #completewith htraining
    .goto Teldrassil,59.3,41.1
	.vendor >>进去，小贩垃圾箱，买三堆箭
step
    .goto Teldrassil,57.8,41.7
    .accept 916 >>接任务: 树林蜘蛛的毒囊
step << Hunter
    #era
    .xp 4-40
step << Hunter
    #som
    .xp 4-50
step << Hunter
    .goto Teldrassil,58.6,40.4
    >>爬上大树，与猎人训练师交谈
    .train 1978 >>火车蛇刺
    .turnin 3117 >>交任务: 风化符记
step
    .goto Teldrassil,58.1,36.7
	>>掠夺湖边的黄花
    .complete 3521,2 --Collect Moonpetal Lily (x4)
step
    .goto Teldrassil,56.8,31.7
	>>杀死蜘蛛。为了Ichor和Sacs掠夺他们
    .complete 3521,3 --Collect Webwood Ichor (x1)
    .complete 916,1 --Collect Webwood Venom Sac (x10)
step
    .goto Teldrassil,55.0,43.7
	>>杀死格雷金斯。抢走蘑菇和苔藓
    .complete 3521,1 --Collect Hyacinth Mushroom (x7)
    .complete 459,1 --Collect Fel Moss (x8)
step
    .goto Teldrassil,57.8,45.1
    .turnin 459 >>交任务: 森林守护者
step
    .goto Teldrassil,60.9,42.0
    .turnin 3521 >>交任务: 埃沃隆的解药
    .accept 3522 >>接任务: 埃沃隆的解药
step << !Priest
    .goto Teldrassil,59.3,41.1
	.vendor >>进屋和供应商垃圾箱 << !Hunter
	.vendor >>进去卖垃圾。确保下一段至少有3或4组箭头 << Hunter
step << Warrior
    .goto Teldrassil,59.6,38.4
	.trainer >>训练你的4级法术
step << Priest
    .goto Teldrassil,59.5,41.1
	.vendor >>进去，然后上楼，把小贩扔到垃圾桶里
step << Priest
	.goto Teldrassil,59.2,40.4
	.turnin 3119 >>交任务: 神圣符记
	.trainer >>训练你的4级法术
step
    .goto Teldrassil,57.8,41.7
    .turnin 916 >>交任务: 树林蜘蛛的毒囊
    .accept 917 >>接任务: 树林蜘蛛的卵
step << Druid
    .goto Teldrassil,58.6,40.3
	>>跑上大坡道，进入小房间
	.turnin 3120 >>交任务: 绿色符记
	.train 8921 >>火车月光
step
    .goto Teldrassil,54.6,33.0
    .turnin 3522 >>交任务: 埃沃隆的解药
step
    .goto Teldrassil,57.0,26.4
	>>在蜘蛛洞后面掠夺一个蜘蛛蛋
    .complete 917,1 --Collect Webwood Egg (x1)
step
	#softcore
	#completewith next
	.goto Teldrassil,57.8,41.7,150    >>故意死亡并在墓地重生
step
	#hardcore
	#completewith next
	+注销时跳过鸡蛋后面的壁架。移动角色，直到其看起来像是浮动的，然后注销，再重新登录。
	>>如果你摔倒了，就正常地跑出洞穴，去完成任务
	.link https://www.youtube.com/watch?v=TTZZT3jpv1s >>单击此处以供参考
step
	.goto Teldrassil,57.8,41.7
    .turnin 917 >>交任务: 树林蜘蛛的卵
    .accept 920 >>接任务: 特纳隆的召唤
step
    .goto Teldrassil,59.1,39.4
    >>向上走坡道，爬上大树
    .turnin 920 >>交任务: 特纳隆的召唤
    .accept 921 >>接任务: 大地之冠
step
    #sticky
    #label vial1
    .goto Teldrassil,59.9,33.0
	>>在月光井装满空瓶子
    .complete 921,1 --Collect Filled Crystal Phial (x1)
step << Hunter
    .goto Teldrassil,59.8,34.1
    .complete 457,1 --Kill Mangy Nightsaber (x7)
    .complete 457,2 --Kill Thistle Boar (x7)
step
    #requires vial1
    #sticky
    #completewith next
    .deathskip >>死后在墓地重生
step << Hunter
    #requires vial1
    .goto Teldrassil,58.6,44.3
    .turnin 457 >>交任务: 自然的平衡
step << Priest
    #requires vial1
    .goto Teldrassil,59.2,40.5
    .accept 5622 >>接任务: 月神的恩赐
step
    #requires vial1
    .goto Teldrassil,59.1,39.4
	>>向上走坡道，爬上大树
    .turnin 921 >>交任务: 大地之冠
    .accept 928 >>接任务: 大地之冠
step
    .goto Teldrassil,61.2,47.6
    .accept 2159 >>接任务: 多兰纳尔的货物
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance
#name 6-11 泰达希尔
#version 1
#group RestedXP 联盟 1-20
#defaultfor NightElf
#next 11-16 黑海岸
step
    .goto Teldrassil,60.5,56.3
    .accept 488 >>接任务: 赛恩的要求
step
    #sticky
    #completewith zenn
    >>在你的任务中杀死蜘蛛/猫/猫头鹰
    .complete 488,1 --Collect Nightsaber Fang (x3)
    .complete 488,2 --Collect Strigid Owl Feather (x3)
    .complete 488,3 --Collect Webwood Spider Silk (x3)
step
    #sticky
	#completewith spiderLegs
    >>收集7条小蜘蛛腿以备稍后任务
    .collect 5465,7,4161,1 --Collect Small Spider Leg (x7)
step
    .goto Teldrassil,56.1,57.8
    .accept 997 >>接任务: 德纳兰的泥土
step
    .goto Teldrassil,55.9,57.3
    .accept 475 >>接任务: 烦恼之风
step << Priest
    .goto Teldrassil,55.6,56.8
    .turnin 5622 >>交任务: 月神的恩赐
    .accept 5621 >>接任务: 月光之衣
	.trainer >>训练你的6级法术
step << Rogue
    .goto Teldrassil,55.51,57.14
	>>去树屋的二楼
    .vendor >>购买Aldia的3级投掷。装备它
step
    #era
    .goto Teldrassil,55.5,57.0
    >>去树屋的顶端
   .accept 932 >>接任务: 扭曲的仇恨
    .accept 2438 >>接任务: 翡翠摄梦符
step
    #som
    .goto Teldrassil,55.5,57.0
    >>去树屋的顶端
    .accept 932 >>接任务: 扭曲的仇恨 << !Hunter
    .accept 2438 >>接任务: 翡翠摄梦符
step << Hunter
    .goto Teldrassil,56.3,59.5
    >>修理你的武器。如果你有足够的钱(2s85c)，从Jeena那里买一个Hornwood Recurve Bow。否则，请跳过此步骤(稍后再回来)
    >>购买箭，直到你的Quiver满为止(1000支箭)
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Warrior
    .goto Teldrassil,56.2,59.2
	.trainer >>训练你的6级法术
step << Rogue
    .goto Teldrassil,56.4,60.1
	.trainer >>训练你的6级法术
step << Warrior
    .goto Teldrassil,56.3,59.5
    >>修理你的武器。如果你有足够的钱(5s36c)，从沙洛蒙买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1 --Collect Gladius
step << Rogue
    .goto Teldrassil,56.31,59.49
    >>修理你的武器。如果你有足够的钱(4s1c)，就从沙洛蒙买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1 --Stiletto (1)
step << Druid
    .goto Teldrassil,56.31,59.49
    >>修理你的武器。如果你有足够的钱(5s4c)，从沙洛蒙买一根拐杖。否则，请跳过此步骤(稍后再回来)
    .collect 2495,1 --Walking Stick (1)
step
    .goto Teldrassil,55.7,59.8
    .turnin 2159 >>交任务: 多兰纳尔的货物
step << Hunter
    .goto Teldrassil,56.7,59.5
	.train 3044>>火车奥术射击
step << Druid
    .goto Teldrassil,55.9,61.6
	.trainer >>训练你的6级法术
step
    .goto Teldrassil,56.2,61.7
    .turnin 928 >>交任务: 大地之冠
    .accept 929 >>接任务: 大地之冠
step << Druid
    .goto Teldrassil,57.6,60.6
    .train 2366 >>训练草药
    >>稍后你需要5个土拨鼠来完成任务。获得5个土生根后，你可以放弃草药
step << Druid
    #completewith end
    >>药草等级达到15级，稍后尝试寻找5个土拨鼠进行15级任务
    .collect 2449,5
step << Priest
    >>在哨兵沙亚身上使用较低治疗等级2，然后使用咒语：坚韧
    .goto Teldrassil,57.2,63.5
    .complete 5621,1 --Heal and fortify Sentinel Shaya
step
    .goto Teldrassil,60.9,68.5
    .turnin 997 >>交任务: 德纳兰的泥土
    .accept 918 >>接任务: 林精的种子
    .accept 919 >>接任务: 林精的新芽
step
    .goto Teldrassil,56.1,66.6
    >>在湖边跑来跑去，杀死伐木暴徒，掠夺地上的树苗
    .complete 918,1 --Collect Timberling Seed (x8)
    .complete 919,1 --Collect Timberling Sprout (x12)
step
    .goto Teldrassil,60.9,68.5
    .turnin 918 >>交任务: 林精的种子
    .accept 922 >>接任务: 雷利亚·绿树
    .turnin 919 >>交任务: 林精的新芽
step
    .goto Teldrassil,68.0,59.6
	>>掠夺房子里的梳妆台
    .complete 2438,1 --Collect Emerald Dreamcatcher (x1)
step
    .goto Teldrassil,66.3,58.6
	>>到楼上的房子里去
    .turnin 475 >>交任务: 烦恼之风
    .accept 476 >>接任务: 瘤背熊怪的堕落
step
    #label zenn
    .goto Teldrassil,63.4,58.1
	>>在月光井装满空瓶子
    .complete 929,1 --Collect Filled Jade Phial (x1)
step
    .goto Teldrassil,63.1,61.0
    >>完成Zenn的投标
    .complete 488,1 --Collect Nightsaber Fang (x3)
    .complete 488,2 --Collect Strigid Owl Feather (x3)
    .complete 488,3 --Collect Webwood Spider Silk (x3)
step
    #era
    .goto Teldrassil,60.7,54.4
	.xp 7+3500>>提升经验到7+3500xp级
step
    #som
    .goto Teldrassil,60.7,54.4
	.xp 7+2900>>提升经验到7+2900xp级
step
    .goto Teldrassil,60.5,56.3
    .turnin 488 >>交任务: 赛恩的要求
step
	.goto Teldrassil,56.1,57.7
    .accept 489 >>接任务: 寻求救赎！
step
    .goto Teldrassil,55.9,57.3
    .turnin 476 >>交任务: 瘤背熊怪的堕落
step << Priest
    .goto Teldrassil,55.5,56.7
    .turnin 5621 >>交任务: 月光之衣
	.trainer >>训练你的8级法术
step
    .goto Teldrassil,55.6,56.9
    .turnin 2438 >>交任务: 翡翠摄梦符
    .accept 2459 >>接任务: 噬梦者菲罗斯塔
step << Hunter
	#completewith next
    .goto Teldrassil,56.3,59.5
    >>修理你的武器。如果你有足够的钱(2s85c)，从Jeena那里买一个Hornwood Recurve Bow。否则，请跳过此步骤(稍后再回来)
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Hunter
    .goto Teldrassil,56.3,59.5
	.vendor >>总共购买800支箭
step << Hunter
    .goto Teldrassil,56.7,59.5
	.trainer >>训练你的8级法术
step << Warrior
    .goto Teldrassil,56.2,59.2
	.trainer >>训练你的8级法术
step << Rogue
    .goto Teldrassil,56.4,60.1
	.trainer >>训练你的8级法术
step << Warrior
    .goto Teldrassil,56.3,59.5
    >>修理你的武器。如果你有足够的钱(5s36c)，从沙洛蒙买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1 --Collect Gladius
step << Rogue
    .goto Teldrassil,56.31,59.49
    >>修理你的武器。如果你有足够的钱(4s1c)，就从沙洛蒙买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1 --Stiletto (1)
step << Druid
    .goto Teldrassil,56.31,59.49
    >>修理你的武器。如果你有足够的钱(5s4c)，从沙洛蒙买一根拐杖。否则，请跳过此步骤(稍后再回来)
    .collect 2495,1 --Walking Stick (1)
step << Druid
    .goto Teldrassil,56.2,61.7
    .turnin 929 >>交任务: 大地之冠
    .accept 933 >>接任务: 大地之冠
step << Druid
    .goto Teldrassil,55.9,61.6
	.trainer >>训练你的8级法术
step
    #sticky
	#completewith jewel
    >>寻找Fel Cones，通常位于树干旁边
    .complete 489,1 --Collect Fel Cone (x3)
step
    #label mystics
    #sticky
    .goto Teldrassil,69.2,53.3
    .complete 2459,1 --Kill Gnarlpine Mystic (x7)
	>>神秘人与侏儒勇士分享后代。你可能必须杀死他们才能让神秘主义者诞生
step
    #label jewel
	.goto Teldrassil,69.2,53.3
	>>杀死费罗西塔斯。抢走项链
    .collect 8049,1,2459,2 --Gnarlpine Necklace (1)
    >>右击项链拾取宝石
    .complete 2459,2 --Collect Tallonkai's Jewel (x1)
step
    #requires mystics
    .goto Teldrassil,58.7,55.7
    >>完成Seek Redemption！
    .complete 489,1 --Collect Fel Cone (x3)
step
    .goto Teldrassil,60.4,56.4
    .turnin 489 >>交任务: 寻求救赎！
step << Hunter
    #era
    .goto Teldrassil,51.2,50.6
    >>杀死梅勒纳斯勋爵。他可以位于洞穴的许多不同产卵点，而且很难找到
    .complete 932,1 --Collect Melenas' Head (x1)
step << !Hunter
    .goto Teldrassil,51.2,50.6
    >>杀死梅勒纳斯勋爵。他可以位于洞穴的许多不同产卵点，而且很难找到
    .complete 932,1 --Collect Melenas' Head (x1)
step
    #softcore
	#completewith next
	.deathskip >>故意死亡并在墓地重生
step << !Druid
    .goto Teldrassil,56.2,61.7
    .turnin 929 >>交任务: 大地之冠
step
	#era/som
    .goto Teldrassil,56.2,61.7
    .accept 933 >>接任务: 大地之冠
step
	#era/som
	.goto Teldrassil,42.54,76.08
	>>点击大紫色植物
	.accept 930 >>接任务: 发光的水果
step
	#era/som
	#label spiderLegs
	.goto Teldrassil,42.36,67.26
	>>在月光井装满空瓶子
	.complete 933,1
step
	#era/som
    >>完成收集7条小蜘蛛腿
    .collect 5465,7,4161,1 --Collect Small Spider Leg (x7)
step
	#era/som
    #softcore
	#completewith next
    .goto Teldrassil,43.50,68.42
    .deathskip >>故意死亡并在多拉那尔墓地重生，确保死亡在月光井以东，否则你可能会死在达纳苏斯
step
	#era/som
    .goto Teldrassil,56.2,61.7
    .turnin 933 >>交任务: 大地之冠
    .accept 7383 >>接任务: 大地之冠
step
	#era/som
    .goto Teldrassil,57.1,61.3
    .train 2550 >>火车烹饪
    .accept 4161 >>接任务: 卡多雷的菜谱
    .turnin 4161 >>交任务: 卡多雷的菜谱
step
    .goto Teldrassil,55.7,59.8
    .home >>将您的炉石设置为Dolanar
step << Warrior/Rogue
    .goto Teldrassil,55.2,56.8
    .train 3273 >>培训急救
step
    #som
    .goto Teldrassil,55.5,56.9
    .turnin 932 >>交任务: 扭曲的仇恨 << !Hunter
    .turnin 2459 >>交任务: 噬梦者菲罗斯塔
step
    #era
    .goto Teldrassil,55.5,56.9
    .turnin 932 >>交任务: 扭曲的仇恨
    .turnin 2459 >>交任务: 噬梦者菲罗斯塔
step
    .goto Teldrassil,51.9,56.4
    >>找到月亮女祭司阿玛拉，她在多拉纳尔以西的路上巡逻
    .accept 487 >>接任务: 达纳苏斯之路
step
    .goto Teldrassil,46.6,53.0
    .complete 487,1 --Kill Gnarlpine Ambusher (x6)
step << Druid
    .goto Teldrassil,51.9,56.4
    >>找到月亮女祭司阿玛拉，她在多拉纳尔以西的路上巡逻
    .turnin 487 >>交任务: 达纳苏斯之路
step
	#era/som
    .goto Teldrassil,38.3,34.3
    .accept 937 >>接任务: 神谕林地
step
	#era/som
    .goto Teldrassil,38.4,34.1
	>>在月光井装满空瓶子
    .complete 7383,1 --Collect Filled Amethyst Phial (x1)
step
	#era/som
    #completewith xp10
	#label harpies
    >>杀死哈比。小心母系氏族，因为他们会愈合并造成大量伤害。试着把它们炸开
    .complete 937,1 --Collect Bloodfeather Belt (x6)
step
	#era/som
    .goto Teldrassil,34.6,28.9
    .accept 931 >>接任务: 发光的树叶
step << Hunter
	#era/som
    #completewith xp10
    #label mist1
    .goto Teldrassil,31.6,31.7
    >>开始护送任务
    .accept 938 >>接任务: 密斯特
step << Hunter
    #era
    #sticky
    #label xp10
    .xp 10-2670 >>研磨，直到距离10级2670 xp(3830/6500)
    >>一旦你到达这个xp断点，跳过哈比/护卫任务，直接前往达纳苏斯，你将有另一个机会稍后完成这些任务
step << Hunter
    #era/som
    #sticky
    #label xp10
    .xp 10-3330 >>研磨直到距离10级3330 xp(3170/6500)
    >>一旦你到达这个xp断点，跳过哈比/护卫任务，直接前往达纳苏斯，你将有另一个机会稍后完成这些任务
step << Hunter
	#era/som
    #completewith xp10
    #requires mist1
    .goto Teldrassil,38.3,34.4
    .turnin 938 >>交任务: 密斯特
step << Hunter
	#era/som
    #completewith xp10
	#requires harpies
    .goto Teldrassil,38.3,34.4
    .turnin 937 >>交任务: 神谕林地
    .accept 940 >>接任务: 泰达希尔
step << !Hunter
	#era/som
    #label mist1
    .goto Teldrassil,31.6,31.7
    >>开始护送任务
    .accept 938 >>接任务: 密斯特
step << !Hunter
	#era/som
    .goto Teldrassil,38.3,34.4
    .turnin 937 >>交任务: 神谕林地
    .accept 940 >>接任务: 泰达希尔
    .turnin 938 >>交任务: 密斯特
step << !Hunter
    #era
    #label xp10
    .xp 10-750 << Druid
    .xp 10-3110 << !Druid
step << !Hunter
	#som
    #phase 1-2
	#label xp10
   .xp 10-930 << Druid
   .xp 10-3880 << !Druid
step
	#som
    #phase 3-6
	.goto Teldrassil,38.6,58.0
	>>完成收集7条小蜘蛛腿
    .collect 5465,7,4161,1 --Collect Small Spider Leg (x7)
step << Druid
	#som
	#phase 3-6
	#label xp10
	.xp 10-640
    .goto Teldrassil,38.3,34.4
	>>如果你在xp上还落后，那就向北执行harpy任务
step << !Druid
	#som
	#phase 3-6
	#label xp10
	.xp 10-3300
step << !Rogue
	#era/som
    #requires xp10
    #completewith next
    .deathskip >>故意死亡并在达纳苏斯墓地重生
step << !Rogue
    #requires xp10
	>>跑到达纳苏斯
    .goto Darnassus,38.3,21.4
    .turnin 922 >>交任务: 雷利亚·绿树
    .accept 923 >>接任务: 青苔之瘤
step << !Hunter !Rogue
	#era/som
    .goto Darnassus,34.7,9.0
    >>爬到树屋的顶部
    .turnin 940 >>交任务: 泰达希尔
	.isOnQuest 940
step << Druid
    .goto Darnassus,35.2,8.0
    >>前往树屋的中间层
    .accept 5921 >>接任务: 月光林地
	.trainer >>训练你的10级法术
step << !Rogue
    .goto Darnassus,36.5,86.0
    .accept 2518 >>接任务: 月神的泪水
step << Druid
    .goto Moonglade,56.2,30.8
    >>打开你的魔法书并传送到月光大陆
    .turnin 5921 >>交任务: 月光林地
    .accept 5929 >>接任务: 巨熊之灵
step << Druid
    .goto Moonglade,39.1,27.5
    >>与夜鹰城外的熊精灵交谈
    .complete 5929,1 --Seek out the Great Bear Spirit and learn what it has to share with you about the nature of the bear.
step << Druid
    .goto Moonglade,56.2,30.5
    >>使用你的心灵传送法术返回任务给予者
    .turnin 5929 >>交任务: 巨熊之灵
    .accept 5931 >>接任务: 返回达纳苏斯
step
    #requires xp10 << Rogue
    #completewith next << !Rogue
    .hs >>从赫斯到多拉纳尔
step << Hunter
    .goto Teldrassil,56.3,59.5
	.vendor >>购买4堆10级箭头。达到10级后立即装备它们
step
	#som
	#phase 3-6
    .goto Teldrassil,57.1,61.3
    .train 2550 >>火车烹饪
    .accept 4161 >>接任务: 卡多雷的菜谱
    .turnin 4161 >>交任务: 卡多雷的菜谱
step
	#som
	#phase 3-6
    .goto Teldrassil,51.9,56.4
    >>找到月亮女祭司阿玛拉，她在多拉纳尔以西的路上巡逻
    .turnin 487 >>交任务: 达纳苏斯之路
	.maxlevel 9
step << Hunter
    #completewith L10
    #level 10
    #label beast1
    .goto Teldrassil,56.7,59.6
    .accept 6063 >>接任务: 驯服野兽
	.train 13165 >>训练你的10级法术
step << Hunter
    #completewith L10
    #level 10
    #requires beast1
    #label beast2
    .goto Teldrassil,59.9,58.8
    .complete 6063,1 --Tame a Webwood Lurker
step << Hunter
    #completewith L10
    #level 10
    #requires beast2
    .goto Teldrassil,56.7,59.5
    .turnin 6063 >>交任务: 驯服野兽
    .accept 6101 >>接任务: 驯服野兽
step
	#era/som
    .goto Teldrassil,56.1,61.7
    .turnin 7383 >>交任务: 大地之冠
    .accept 935 >>接任务: 大地之冠
step
	#era/som
	.goto Teldrassil,60.9,68.4
    .turnin 931 >>交任务: 发光的树叶
    .turnin 930 >>交任务: 发光的水果
step
	#era/som
	.goto Teldrassil,60.9,68.4
	.turnin 927 >>交任务: 布满苔藓的心脏
    .isOnQuest 927
step
	#era/som
	.goto Teldrassil,60.9,68.4
	>>点击任务给予者旁边的植物花瓶
	.turnin 941 >>交任务: 培养心脏
	.isQuestTurnedIn 927
step << Hunter
	#era/som
    .goto Teldrassil,62.6,72.2
    .complete 6101,1 --Tame a Nightsaber Stalker
	.isOnQuest 6101
step
    #label L10
    .xp 10
step
	#era/som
    #softcore
	#sticky
    #completewith next
    .deathskip >>死后在墓地重生
step << Priest
    .goto Teldrassil,55.5,56.7
	.trainer >>训练你的10级法术
step << Warrior
    .goto Teldrassil,56.2,59.2
	.trainer >>训练你的10级法术
step << Rogue
    .goto Teldrassil,56.4,60.1
	.trainer >>训练你的10级法术
step << Hunter
    .goto Teldrassil,56.7,59.6
    .accept 6063 >>接任务: 驯服野兽
	.trainer >>训练你的10级法术
step << Hunter
    .goto Teldrassil,59.9,58.8
    .complete 6063,1 --Tame a Webwood Lurker
step << Hunter
    .goto Teldrassil,56.7,59.5
    .turnin 6063 >>交任务: 驯服野兽
    .accept 6101 >>接任务: 驯服野兽
step << Hunter
    .goto Teldrassil,62.6,72.2
    .complete 6101,1 --Tame a Nightsaber Stalker
step << Hunter
    .goto Teldrassil,56.7,59.5
    .turnin 6101 >>交任务: 驯服野兽
    .accept 6102 >>接任务: 驯服野兽
step << Hunter
    .goto Teldrassil,64.7,66.7
    .complete 6102,1 --Tame a Strigid Screecher
step << Hunter
    .goto Teldrassil,56.7,59.5
    .turnin 6102 >>交任务: 驯服野兽
    .accept 6103 >>接任务: 训练野兽
step << Warrior
    .goto Teldrassil,56.2,59.2
    .accept 1684 >>接任务: 艾兰娜瑞
step << Rogue
    .goto Teldrassil,56.2,60.0
    .accept 2241 >>接任务: 詹诺克的花
step << Hunter
    .goto Teldrassil,56.3,59.5
    .money <0.0504
    >>从供应商处购买员工，稍后您将装备它。
    >>如果你碰巧从暴徒那里找到一名工作人员，请跳过这一步
    .collect 2495,1
step << !Druid
    .goto Teldrassil,51.8,56.4
    .turnin 487 >>交任务: 达纳苏斯之路
step << Rogue
    #completewith next
    .goto Teldrassil,44.0,54.6
    .deathskip >>一旦你通过了起毛区，就故意死亡并在达纳苏斯墓地重生
step << Rogue
    .goto Darnassus,38.3,21.4
    .turnin 922 >>交任务: 雷利亚·绿树
    .accept 923 >>接任务: 青苔之瘤
step << Rogue
    .goto Darnassus,34.7,9.0
    >>爬到树屋的顶部
    .turnin 935 >>交任务: 大地之冠
    .turnin 940 >>交任务: 泰达希尔
    .accept 952 >>接任务: 古树之林
step << Rogue
    .goto Darnassus,36.8,21.8
    .turnin 2241 >>交任务: 詹诺克的花
    .accept 2242 >>接任务: 命运的召唤
step << Rogue
    .goto Darnassus,36.5,86.0
    .accept 2518 >>接任务: 月神的泪水
step << Hunter
    #sticky
	.goto Teldrassil,41.2,44.4,0
	.goto Teldrassil,44.2,39.8,0
	.goto Teldrassil,45.6,31.4,0
	.goto Teldrassil,37.6,28.8,0
    .train 2981 >>驯服猛击猎人并学习爪等级2
step
    .goto Teldrassil,43.1,32.9
    >>退出达纳苏斯 << Rogue
	>>杀死河流周围的伐木暴徒
    .complete 923,1 --Collect Mossy Tumor (x5)
step
    #label Spinnerets
	.goto Teldrassil,47.3,26.0
    .goto Teldrassil,37.9,25.1
    .goto Teldrassil,40.7,25.4
    >>杀死萨特拉夫人，她有3个可能的产卵地点
    .complete 2518,1 --Collect Silvery Spinnerets (x1)
step << Rogue
    .goto Teldrassil,38.0,25.2
    >>拾起口袋的古代塞希尔，他沿着大树枝走
    >>你必须鬼鬼祟祟，如果你打他，他会狠狠地打，还会叫上一堆加法
    .complete 2242,1
step
	#som << !Hunter
	#phase 3-6 << !Hunter
    .goto Teldrassil,38.3,34.3
    .accept 937 >>接任务: 神谕林地
step
	#som << !Hunter
	#phase 3-6 << !Hunter
    #sticky
	#label harpies2
    >>杀死哈比
    .complete 937,1 --Collect Bloodfeather Belt (x6)
step
	#som << !Hunter
	#phase 3-6 << !Hunter
    .goto Teldrassil,31.6,31.7
    >>开始护送任务
    .accept 938 >>接任务: 密斯特
step
	#som << !Hunter
	#phase 3-6 << !Hunter
    .goto Teldrassil,38.3,34.4
    .turnin 938 >>交任务: 密斯特
step
	#som << !Hunter
	#phase 3-6 << !Hunter
    #requires harpies2
    .goto Teldrassil,38.3,34.4
    .turnin 937 >>交任务: 神谕林地
    .accept 940 >>接任务: 泰达希尔
step
    #softcore
	#completewith next
    .deathskip >>在达纳苏斯墓地死亡并重生
step
    .goto Darnassus,70.6,45.3
    .accept 6344 >>接任务: 尼莎·影歌
step
	.abandon 927 >>抛弃苔藓缠绕的心。你永远没有机会交出
step << Warrior
    .goto Darnassus,57.4,34.8
    .turnin 1684 >>交任务: 艾兰娜瑞
    .accept 1683 >>接任务: 沃鲁斯·邪蹄
step << Warrior
    #sticky
    #completewith next
    .goto Teldrassil,48.7,62.2,18
    >>通往Vorlus Vilehoof的路从这里开始
step << Warrior
    .goto Teldrassil,47.2,63.7
    .complete 1683,1 --Collect Horn of Vorlus (x1)
step << Warrior
    #softcore
	#sticky
    #completewith next
    .goto Teldrassil,43.6,54.3
    .deathskip >>在你经过火山口地区并在达纳苏斯重生后，故意死亡
step << Warrior
    .goto Darnassus,57.4,34.5
    .turnin 1683 >>交任务: 沃鲁斯·邪蹄
--	.accept 1686 >>接任务: 艾鲁拉的阴影
step << Druid
    .goto Darnassus,35.1,8.6
    .turnin 5931 >>交任务: 返回达纳苏斯
    .accept 6001 >>接任务: 身心之力
step
    .goto Darnassus,34.8,9.2
    .turnin 935 >>交任务: 大地之冠
    .turnin 940 >>交任务: 泰达希尔 << Hunter
    .accept 952 >>接任务: 古树之林
step << Hunter
    .goto Darnassus,40.3,8.8
    .turnin 6103 >>交任务: 训练野兽
step << Rogue
    .goto Darnassus,36.8,21.8
    .turnin 2242 >>交任务: 命运的召唤
step
    .goto Darnassus,38.3,21.7
    .turnin 923 >>交任务: 青苔之瘤
step << Rogue
    .goto Darnassus,62.68,65.58
	>>去大楼的二楼
    .vendor >>购买从都灵投掷的11级。11级时装备它
step
    .goto Darnassus,36.9,85.8
    .turnin 2518 >>交任务: 月神的泪水
    .accept 2520 >>接任务: 萨丝拉的祭品
step
    .goto Darnassus,39.7,85.8
	>>在喷泉的袋子里放上萨特拉的祭品
    .complete 2520,1 --Offer the sacrifice at the fountain
step
    #label end
    .goto Darnassus,36.6,85.9
    .turnin 2520 >>交任务: 萨丝拉的祭品
step << Druid
    .goto Darnassus,48.0,68.6
    .train 2366 >>训练草药
    >>稍后你需要5个土拨鼠来完成任务，你可以在获得5个土拔鼠后放弃草药
step << Hunter/Warrior/Priest
    .goto Darnassus,57.8,46.6
    .train 227 >>火车杠
    >>如果您的包里有员工，请配备员工 << Hunter
step << Hunter
    .goto Darnassus,58.76,44.48
	.money <0.1751
	.vendor >>从Ariyell那里买一个层压递归弓，如果你有钱，也可以买10级箭。装备它
	.collect 2507,1
step << Warrior
    .goto Darnassus,58.76,44.48
	.money <0.3022
    >>如果你有钱，可以从Ariyell购买Quarter Staff。在11级装备
	.collect 854,1
step << Warrior
    .goto Darnassus,58.76,44.48
	.money <0.2023
    >>如果你有钱，又买不起季度员工，就从Ariyell那里买一把弯刀。装备它
	.collect 851,1
step
    #completewith next
    .goto Darnassus,30.41,41.40
    .goto Teldrassil,56.3,92.3,175 >>通过银行旁边的紫色门户前往鲁思特兰村
step
    .goto Teldrassil,56.3,92.3
    .turnin 6344 >>交任务: 尼莎·影歌
    .accept 6341 >>接任务: 泰达希尔的渔业
step
    .goto Teldrassil,58.4,94.0
    .turnin 6341 >>交任务: 泰达希尔的渔业
    .accept 6342 >>接任务: 飞往奥伯丁
step
    .fly Darkshore >>飞到黑海岸
]])
