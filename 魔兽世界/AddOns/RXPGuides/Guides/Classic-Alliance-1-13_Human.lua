RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance
#name 1-11 艾尔文森林
#version 1
#group RestedXP 联盟 1-20
#defaultfor Human
#next 11-13 洛克莫丹
step << !Human
    #sticky
    #completewith next
    .goto Elwynn Forest,48.2,42.9
    +您已经选择了一个针对人类的指南。你应该选择与你开始时相同的起始区域
step << Mage
    #completewith next
    +请注意，您已经选择了单目标法师指南。单目标比AoE Mage安全得多，但速度慢得多
step << Warlock
    #sticky
    #completewith next
    +杀死狼群10美分以上的小贩垃圾
    .goto Elwynn Forest,49.4,45.6,60,0
step << Warlock
    .goto Elwynn Forest,50.1,42.7
    .vendor >>供应商垃圾
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .accept 1598 >>接任务: 失窃的典籍
    .trainer >>火车献祭
step << Warlock
    #hardcore
    .goto Elwynn Forest,52.9,44.3,60,0
    >>在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=_-KEke9Yeik >>单击此处
    >>当你洗劫时，使用营地内的炉石
    .goto Elwynn Forest,56.7,44.0
    .complete 1598,1 --Collect Powers of the Void (x1)
step << Warlock
    #softcore
    .goto Elwynn Forest,52.9,44.3,60,0
    >>在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=_-KEke9Yeik >>单击此处
    .goto Elwynn Forest,56.7,44.0
    .complete 1598,1 --Collect Powers of the Void (x1)
step << Warlock
    #softcore
    .deathskip >>在精神治疗师处死亡并重生
step << Warlock
    #hardcore
    #completewith next
    >>确保你在帐篷的深处，这样你就不会重新聚集
    .hs >>炉灶返回Northshire Valley
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .turnin 1598 >>交任务: 失窃的典籍
step
    >>召唤小鬼，拒绝恶魔皮肤 << Warlock
    >>删除您的炉石
    .goto Elwynn Forest,48.2,42.9
    .accept 783 >>接任务: 身边的危机
step << Warrior
    #sticky
    #completewith next
    +杀死狼群10美分以上的小贩垃圾
    .goto Elwynn Forest,46.4,40.3,60,0
step << Warrior
    .goto Elwynn Forest,47.5,41.6
    .vendor >>供应商垃圾
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 783 >>交任务: 身边的危机
    .accept 7 >>接任务: 剿灭狗头人
step << Warrior
    .goto Elwynn Forest,50.2,42.3
    .trainer >>火车战斗呐喊
step
    >>跑回室外 << Warrior
    .goto Elwynn Forest,48.2,42.9
    .accept 5261 >>接任务: 伊根·派特斯金纳
step << Priest/Mage/Warlock
    .goto Elwynn Forest,46.2,40.4
    .vendor >>杀死狼，直到价值50美分的小贩垃圾。供应商，然后从丹尼尔兄弟那里购买10 x10的水。
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Priest/Mage
    .xp 2 >>升级到2
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 5261 >>交任务: 伊根·派特斯金纳
    .accept 33 >>接任务: 林中的群狼
step
    .goto Elwynn Forest,46.70,37.78
    >>杀死幼狼。抢他们的肉
    .complete 33,1 --Collect Tough Wolf Meat (x8)
step
    .goto Elwynn Forest,49.05,35.33
    >>杀死科博尔德害虫
    .complete 7,1 --Kill Kobold Vermin (x10)
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 33 >>交任务: 林中的群狼
step << Priest/Mage/Warlock
    .goto Elwynn Forest,47.6,41.5
    .vendor >>小贩扔掉垃圾，然后从丹尼尔兄弟那里多买10瓶水
step << !Priest !Mage !Warlock
    .goto Elwynn Forest,47.6,41.5
    .vendor >>供应商垃圾
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 7 >>交任务: 剿灭狗头人
    .accept 15 >>接任务: 回音山调查行动
    .accept 3100 >>接任务: 简要的信件 << Warrior
    .accept 3101 >>接任务: 圣洁信件 << Paladin
    .accept 3102 >>接任务: 密文信件 << Rogue
    .accept 3103 >>接任务: 神圣信件 << Priest
    .accept 3104 >>接任务: 雕文信件 << Mage
    .accept 3105 >>接任务: 被污染的信件 << Warlock
step
    .xp 3 >>升级到3
step
    .goto Elwynn Forest,47.42,32.68
    >>杀死Kobold工人
    .complete 15,1 --Kill Kobold Worker (x10)
step
    #sticky
    #label xp3
    .xp 3+1110>>在回来的路上提升经验到1110+/1400经验
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾
--N need SoM xp note
step
    #requires xp3
    .goto Elwynn Forest,48.9,41.6
    .turnin 15 >>交任务: 回音山调查行动
    .accept 21 >>接任务: 回音山清剿行动
step << Priest/Mage
    #sticky
    #completewith next
    .goto Elwynn Forest,49.3,40.7,15 >>到这里来
step << Mage
    #sticky
    #completewith next
    .goto Elwynn Forest,49.5,40.0,15 >>上楼去
step << Mage
    .goto Elwynn Forest,49.7,39.4
    .turnin 3104 >>交任务: 雕文信件
    .trainer >>训练你的职业咒语
step << Priest
    #sticky
    #completewith next
    .goto Elwynn Forest,49.8,40.2,15 >>穿过门口
step << Priest
    .goto Elwynn Forest,49.8,39.5
    .turnin 3103 >>交任务: 神圣信件
    .trainer >>训练你的职业咒语
step << Warrior/Paladin
    #sticky
    #completewith next
    .goto Elwynn Forest,49.6,41.8,15 >>呆在楼下
step << Warrior
    .goto Elwynn Forest,50.2,42.3
    .turnin 3100 >>交任务: 简要的信件
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,50.4,42.1
    .turnin 3101 >>交任务: 圣洁信件
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,48.2,42.9
    .accept 18 >>接任务: 潜行者兄弟会
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .turnin 3105 >>交任务: 被污染的信件
    .xp 4 >>升级到4
    .trainer >>培训腐败
step
    .goto Elwynn Forest,54.57,49.03
    >>杀死德菲亚斯暴徒。抢了他们的头巾
    .complete 18,1 --Collect Red Burlap Bandana (x12)
step << Rogue
    .xp 4 >>升级到4
step
    .goto Elwynn Forest,48.2,42.9
    .turnin 18 >>交任务: 潜行者兄弟会
    .accept 6 >>接任务: 加瑞克·帕德弗特的赏金
    .accept 3903 >>接任务: 米莉·奥斯沃斯
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,47.66,31.88,40,0
    .goto Elwynn Forest,48.61,27.63
    >>杀死矿井中的工人
    .complete 21,1 --Kill Kobold Laborer (x12)
step
    .xp 5 >>升级到5
step << !Priest !Mage
    .goto Elwynn Forest,50.7,39.2
    .turnin 3903 >>交任务: 米莉·奥斯沃斯
step << Priest/Mage
    .goto Elwynn Forest,50.7,39.2
    .turnin 3903 >>交任务: 米莉·奥斯沃斯
    .accept 3904 >>接任务: 米莉的葡萄
step << Rogue
    .goto Elwynn Forest,50.3,39.9
    >>你不需要训练
    .turnin 3102 >>交任务: 密文信件
step << Priest/Mage
    >>在田里掠夺葡萄桶
    .goto Elwynn Forest,54.5,49.4
    .complete 3904,1 --Collect Milly's Harvest (x8)
step
    .goto Elwynn Forest,57.5,48.2
    >>途中研磨。杀死加里克并抢走他的头
    .complete 6,1 --Collect Garrick's Head (x1)
step << !Priest !Mage
    #sticky
    .abandon 3904 >>放弃米莉的收获
step << !Priest !Mage
    .xp 5+1715>>返回1715+/2800xp的途中研磨
    .goto Elwynn Forest,48.2,42.9
--N SoM xp values
step << Priest/Mage
    .xp 5+1175>>在返回1175+/2800xp的途中进行研磨
    .goto Elwynn Forest,50.7,39.2
step << Priest/Mage
    .goto Elwynn Forest,50.7,39.2
    .turnin 3904 >>交任务: 米莉的葡萄
    .accept 3905 >>接任务: 葡萄出货单
step
    .goto Elwynn Forest,48.2,42.9
    .turnin 6 >>交任务: 加瑞克·帕德弗特的赏金
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 21 >>交任务: 回音山清剿行动
    .accept 54 >>接任务: 去闪金镇报到
step << Priest/Mage
    #sticky
    #completewith next
    .goto Elwynn Forest,49.6,41.6,15,0
    .goto Elwynn Forest,48.9,41.3,10 >>上楼去
step << Priest/Mage
    .goto Elwynn Forest,49.5,41.6
    .turnin 3905 >>交任务: 葡萄出货单
step << Priest
    .goto Elwynn Forest,49.8,39.5
    .accept 5623 >>接任务: 圣光的恩赐
step
    .goto Elwynn Forest,45.6,47.7
    .accept 2158 >>接任务: 休息和放松
step
    #hardcore
    .goto Elwynn Forest,42.1,65.9
    .turnin 54 >>交任务: 去闪金镇报到
    .accept 62 >>接任务: 法戈第矿洞
step
    #softcore
    #sticky
    #completewith Goldshire
    .goto Elwynn Forest,39.5,60.5,200 >>在精神疗养院死去并重生，或者逃到戈德郡
step << Warrior/Paladin/Rogue
    .goto Elwynn Forest,41.7,65.5
    .trainer >>从阿格斯培训铁匠。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。 << Warrior/Rogue
    .trainer >>从阿格斯培训铁匠。这将允许你为你的武器制造+2点非常强大的伤害重石。 << Paladin
step << Warrior
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(5s36c)，从科瑞纳买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step << Rogue
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(4s1c)，就从科里纳买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Paladin
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(7s 1c)，从Corina买一把木制锤子。否则，请跳过此步骤(稍后再回来)
    .collect 2493,1 --Collect Wooden Mallet
step << Mage/Priest/Warlock
    #completewith next
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    #label Goldshire
    .goto Elwynn Forest,42.1,65.9
    .turnin 54 >>交任务: 去闪金镇报到
    .accept 62 >>接任务: 法戈第矿洞
step
    >>在你进客栈的时候，靠近左边
    .goto Elwynn Forest,42.9,65.7,15,0
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >>接任务: 狗头人的蜡烛
step
    .goto Elwynn Forest,43.8,65.8
    >>请勿在此购买任何食物/饮料 << Warlock
    .turnin 2158 >>交任务: 休息和放松
    .home >>将您的炉石设置为Goldshire
step
    .xp 6 >>升级到6
step << Rogue
    .goto Elwynn Forest,43.96,65.92
    .vendor 151 >>购买布罗格的3级投掷。装备它
step << Warlock
    #sticky
    #completewith next
    .goto Elwynn Forest,44.1,66.0,10 >>去客栈老板后面的房间，然后下楼。
step << Warlock
    .goto Elwynn Forest,44.4,66.2
    .trainer >>训练你的职业咒语
    .goto Elwynn Forest,44.4,66.0
    .vendor >>如果你在训练后有钱，就买血盟书(否则以后再买)
step << Mage/Priest/Rogue
    #sticky
    #completewith next
    .goto Elwynn Forest,43.7,66.4,12 >>上楼去
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .turnin 5623 >>交任务: 圣光的恩赐
    .accept 5624 >>接任务: 圣光之衣
    .trainer >>训练你的职业咒语
step << Rogue
    .money <0.01
    .goto Elwynn Forest,43.9,65.9
    .trainer >>训练你的职业咒语
step << Rogue/Warrior
    .money <0.01
    .goto Elwynn Forest,43.4,65.5
    .train 3273 >>训练急救-不要一次包扎好所有绷带，最好稍后再包扎
step << Warrior
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买5级食物至1银
step << Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买最多20种5级食物
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,42.1,67.3
    .accept 47 >>接任务: 金砂交易
step << Priest
    >>使用较低治疗等级2，然后使用金字招牌：对守卫罗伯茨的坚韧
    .goto Elwynn Forest,48.2,68.0
    .complete 5624,1 --Heal and fortify Guard Roberts
step
    #sticky
    #completewith BoarMeat1
    >>开始杀掉你看到的野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,34.5,84.3
    .accept 85 >>接任务: 丢失的项链
    .goto Elwynn Forest,34.7,84.5
    .accept 88 >>接任务: 公主必须死！
step
    #sticky
    #completewith Candles
    >>从附近的Kobolds买些蜡烛
    .complete 60,1 --Collect Kobold Candle (x8)
step
    #sticky
    #label Candles
    #completewith next
    >>从附近的Kobolds那里获得一些金粉
    .complete 47,1 --Collect Gold Dust (x10)
step << Priest/Mage/Warlock
    #label Dust
    >>将暴徒从矿井外向东驱赶
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Warrior
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将它变成一块锋利的石头，并将其应用到你的剑上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Rogue
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将其变成一块锋利的石头，并将其应用到你的匕首上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Paladin
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将其制成一块重石，并将其应用到你的狼牙棒上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step
    #label BoarMeat1
    .goto Elwynn Forest,43.2,89.6
    .accept 106 >>接任务: 年轻的恋人
step << Mage/Priest/Warlock
    .goto Elwynn Forest,42.4,89.4
    .vendor >>小贩，尽可能多买牛奶
step << !Mage !Priest !Warlock
    .goto Elwynn Forest,42.4,89.4
    .vendor >>供应商垃圾
step
    #completewith next
    >>途中磨碎野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,29.8,86.0
    .turnin 106 >>交任务: 年轻的恋人
    .accept 111 >>接任务: 托米的祖母
step
    .goto Elwynn Forest,32.5,85.5
    >>吃完野猪肉
    .complete 86,1 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,34.5,84.3
    .turnin 86 >>交任务: 比利的馅饼
    .accept 84 >>接任务: 比利的馅饼
step
    .goto Elwynn Forest,34.9,83.9
    .turnin 111 >>交任务: 托米的祖母
    .accept 107 >>接任务: 给威廉·匹斯特的信
step
    #sticky
    #label KoboldCandles
    >>从附近的Kobolds买些蜡烛
    .complete 60,1 --Collect Kobold Candle (x8)
step
    #sticky
    #label GoldDust
    >>从附近的Kobolds那里获得一些金粉
    .complete 47,1 --Collect Gold Dust (x10)
step
    >>将暴徒从矿井外向东驱赶
    .goto Elwynn Forest,43.1,85.7
    .turnin 84 >>交任务: 比利的馅饼
    .accept 87 >>接任务: 金牙
step
    >>进入矿井
    .goto Elwynn Forest,40.5,82.3
    .complete 62,1 --Scout Through the Fargodeep Mine
step << Warrior
    >>尽可能多地招惹怒气(磨掉其他暴徒的怒气)，然后为伯妮斯的项链杀死戈登斯
    .goto Elwynn Forest,41.7,78.1
    .complete 87,1 --Collect Bernice's Necklace  (x1)
step << !Warrior
    >>为伯妮斯的项链杀死金牙
    .goto Elwynn Forest,41.7,78.1
    .complete 87,1 --Collect Bernice's Necklace  (x1)
step << Warrior
    #sticky
    #completewith Goldtooth
    +试着从现在开始保存一种治疗药剂，因为稍后你会需要它来治疗罗尔夫的尸体
step << Warrior/Rogue
    >>如果你捡到一块粗糙的石头，记得要做磨石
    .xp 7+1600>>提升经验到1600+/4500xp
step << Paladin
    >>如果你捡到一块粗糙的石头，记得要做砝码
    .xp 7+1600>>提升经验到1600+/4500xp
step << !Priest !Paladin !Warrior !Rogue
    .xp 7+1600>>提升经验到1600+/4500xp
step << Priest
    .xp 7+1260>>提升经验到1260+/4500xp
--N SoM xp values
step
    #requires KoboldCandles
step
    #label Goldtooth
    #requires GoldDust
    .goto Elwynn Forest,34.5,84.3
    .turnin 87 >>交任务: 金牙
step
    >>把一些暴徒逼回戈德郡
    .xp 7+2690>>提升经验到2690+/4500xp << !Priest
    .xp 7+2350>>提升经验到2350+/4500xp << Priest
    .goto Elwynn Forest,42.1,67.3
step
    .goto Elwynn Forest,42.1,67.3
    .turnin 47 >>交任务: 金砂交易
    .accept 40 >>接任务: 鱼人的威胁
step
    .goto Elwynn Forest,42.1,65.9
    .turnin 40 >>交任务: 鱼人的威胁
    .accept 35 >>接任务: 卫兵托马斯
    .turnin 62 >>交任务: 法戈第矿洞
    .accept 76 >>接任务: 玉石矿洞
step
    #completewith next
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step << Warrior
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(5s36c)，从科瑞纳买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step << Rogue
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(4s1c)，就从科里纳买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Paladin
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(7s 1c)，从Corina买一把木制锤子。否则，请跳过此步骤(稍后再回来)
    .collect 2493,1 --Collect Wooden Mallet
step
    .goto Elwynn Forest,43.3,65.7
    .turnin 60 >>交任务: 狗头人的蜡烛
    .accept 61 >>接任务: 送往暴风城的货物
    .turnin 107 >>交任务: 给威廉·匹斯特的信
    .accept 112 >>接任务: 收集海藻
step
    .xp 8 >>升级到8
step << Warlock
    >>回到地下室
    .goto Elwynn Forest,44.4,66.2
    .trainer >>训练你的职业咒语
    .goto Elwynn Forest,44.4,66.0
    .vendor >>如果您在培训后有钱，请购买Firebolt书籍(否则请稍后购买)
step
    .money <0.1250
    .goto Elwynn Forest,44.0,65.9
    .vendor >>从Brog购买6槽包
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step << Mage/Priest/Rogue/Warrior
    #completewith next
    .goto Elwynn Forest,43.7,66.4,15 >>上楼去
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .turnin 5624 >>交任务: 圣光之衣
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.9,65.9
    .trainer >>训练你的职业咒语
step << Rogue/Warrior/Paladin
    .money <0.01
    .goto Elwynn Forest,43.4,65.5
    .trainer >>训练急救-不要一次包扎好所有绷带，最好稍后再包扎
step << !Warrior !Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买5级水，最高40
step << Warrior/Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor 295 >>购买5级食物最多40个
step
    >>向东边碾碎莫洛克鱼，然后将其掠夺为海带蛙。如果你还需要的话，杀掉岛上的暴徒
    .goto Elwynn Forest,47.6,63.3,100,0
    .goto Elwynn Forest,51.4,64.6,100,0
    .goto Elwynn Forest,57.6,62.8,100,0
    .goto Elwynn Forest,56.4,66.6,100,0
    .goto Elwynn Forest,53.8,66.8,100,0
    .goto Elwynn Forest,57.6,62.8
    .complete 112,1 --Collect Crystal Kelp Frond (x4)
step
    >>进入矿井，继续沿着中间的小路走
    >>途中碾碎暴徒
    .goto Elwynn Forest,61.8,54.0,70,0
    .goto Elwynn Forest,60.4,50.2
    .complete 76,1 --Scout through the Jasperlode Mine
step
    .goto Elwynn Forest,74.0,72.2
    .turnin 35 >>交任务: 卫兵托马斯
    .accept 37 >>接任务: 失踪的卫兵
    .accept 52 >>接任务: 保卫边境
step
    #sticky
    #completewith Prowlers
    >>在执行其他任务时杀死潜行者
    .complete 52,1 --Kill Prowler (x8)
step
    #sticky
    #completewith Bears
    >>在执行其他任务时杀死熊。杀死你看到的任何人
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    .goto Elwynn Forest,72.7,60.3
    .turnin 37 >>交任务: 失踪的卫兵
    .accept 45 >>接任务: 罗尔夫的下落
step
    .goto Elwynn Forest,81.4,66.1
    .accept 5545 >>接任务: 木材危机
step
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾，修理
step << Paladin
    #softcore
    .goto Elwynn Forest,76.8,62.4,100,0
    .goto Elwynn Forest,83.7,59.4,100,0
    .goto Elwynn Forest,76.8,62.4,100,0
    .goto Elwynn Forest,83.7,59.4,100,0
    .goto Elwynn Forest,76.8,62.4
    >>在树的底部找一捆捆木头
    .complete 5545,1 --Collect Bundle of Wood (x8)
step << Paladin
    #hardcore
    #completewith Bundles
    >>留心树下的一捆捆原木
    .complete 5545,1 --Collect Bundle of Wood (x8)
step << !Paladin
    #sticky
    #completewith next
    >>留心树下的一捆捆原木
    .complete 5545,1 --Collect Bundle of Wood (x8)
step
    #label Bundles
    .goto Elwynn Forest,79.8,55.5,90 >>走向守卫的尸体
step << Priest
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。预制更新和盾牌，获得全部法力，然后将2个怪物拉到小屋前，移开，然后核弹一个。杀了一个就跑，然后杀了另一个。掠夺地上的尸体
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << !Paladin
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，一边放羊一边杀掉另一个，然后杀掉羊群暴徒。掠夺地上的尸体 << Mage
    >>池怒，然后杀死尸体周围的2名暴徒。将2名暴徒拉到小屋前，移开，保持一条腿筋，同时杀死另一条。杀了一个就逃跑(用弹珠在上面)，然后拉杀另一个。掠夺地上的尸体 << Warrior
    >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，用核弹袭击一个暴徒。使用回避。杀了一个就跑，然后杀了另一个。掠夺地上的尸体 << Rogue
     >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，然后让其中一个保持恐惧，并试着在两个上面都留下点。然后在地上洗劫尸体 << Warlock
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #softcore
    .goto Elwynn Forest,79.8,55.5
    >>在尸体上奔跑，然后使用神圣保护，立即洗劫尸体，处理并接受任务。你会死的
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #hardcore
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。将2名暴徒拉到小屋前，走开，用核弹袭击其中一名小屋暴徒。泡泡，治疗/必要时逃跑，然后回来杀死其他暴徒
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #softcore
    #sticky
    #completewith Bundles2
    .goto Elwynn Forest,83.6,69.7,120 >>在精神治疗者处死亡并重生，或者在有人清理尸体之前开始逃跑
step
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4
    >>开始后退，完成包裹
    .complete 5545,1 --Collect Bundle of Wood (x8)
step
    #label Bundles2
    .goto Elwynn Forest,81.4,66.1
    .turnin 5545 >>交任务: 木材危机
step
    #label Prowlers
    .xp 9 >>升级到9
step
    #label Bears
    .goto Elwynn Forest,79.5,68.8
    .accept 83 >>接任务: 红色亚麻布
step
    .goto Elwynn Forest,76.7,75.6,100,0
    .goto Elwynn Forest,79.7,83.7,100,0
    .goto Elwynn Forest,82.0,76.8,100,0
    .goto Elwynn Forest,76.7,75.6,100,0
    .goto Elwynn Forest,79.7,83.7,100,0
    .goto Elwynn Forest,82.0,76.8,100,0
    .goto Elwynn Forest,76.7,75.6
    >>杀死最后一批暴徒保护边境
    .complete 52,1 --Kill Prowler (x8)
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    .goto Elwynn Forest,74.0,72.2
    .turnin 52 >>交任务: 保卫边境
    .turnin 71 >>交任务: 回复托马斯
    .accept 39 >>接任务: 托马斯的报告
    .accept 109 >>接任务: 向格里安·斯托曼报到
step
    #sticky
    #completewith Deed
    >>留意德菲亚斯(Defias)的《威斯特福尔契约》(lucky drop)
    .collect 1972,1,184 --Collect Westfall Deed (x1)
    .accept 184 >>接任务: 法布隆的地契
step
    .goto Elwynn Forest,69.53,79.47
    >>开始围着农场转，杀掉德菲亚斯，然后掠夺他们的头巾
    .complete 83,1 --Collect Red Linen Bandana (x6)
step << Warrior
    .goto Elwynn Forest,69.4,79.2
    >>池怒，然后杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    .complete 88,1 --Collect Brass Collar (x1)
step << Rogue
    .goto Elwynn Forest,69.4,79.2
    >>确保躲避行动成功，然后杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    .complete 88,1 --Collect Brass Collar (x1)
step << !Rogue !Warrior
    .goto Elwynn Forest,69.4,79.2
    >>杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    >>如果你在挣扎，你可以用篱笆来滥用路径和争取时间
    .complete 88,1 --Collect Brass Collar (x1)
    .link https://www.youtube.com/watch?v=GRrXOV-UvD4 >>如果遇到困难，请单击此处
step
    .xp 9+3400>>提升经验到3400+/6500xp
step
    #softcore
    #sticky
    #completewith next
    .goto Elwynn Forest,83.6,69.7,120 >>如果你的生命值低，在精神治疗者处死亡并重生，否则只需跑回并处理
step
    #label Deed
    .goto Elwynn Forest,79.5,68.9
    .turnin 83 >>交任务: 红色亚麻布
step << !Warlock
    #softcore
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾，修理
step << !Warlock
    .goto Redridge Mountains,8.5,72.0
    .xp 9+4475>>提升经验到4475+/6500xp
step << !Warlock
    .goto Redridge Mountains,8.5,72.0
    .zone Redridge Mountains >>前往: 赤脊山
step << !Warlock
    #softcore
    #sticky
    #completewith next
    +死在这里的暴徒面前
    .goto Redridge Mountains,11.2,78.4
step << !Warlock
    #softcore
    .goto Redridge Mountains,20.8,56.6,100 >>在精神治疗者处重生
step << !Warlock
    #softcore
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step << !Warlock
    #hardcore
    >>朝飞行路线跑去。要格外小心，不要在途中对任何暴徒进行攻击或死亡。试着紧贴道路，保持警惕
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step
    .hs >>赫斯到戈德郡
step
    .goto Elwynn Forest,43.3,65.7
    >>不要等待他的rp活动
    .turnin 112 >>交任务: 收集海藻
step << Warrior/Rogue
    .goto Elwynn Forest,43.4,65.6
    >>与楼上的急救教练交谈
    .train 3273 >>培训急救
step
    .goto Elwynn Forest,42.2,65.8
    .turnin 39 >>交任务: 托马斯的报告
    .turnin 76 >>交任务: 玉石矿洞
    .accept 239 >>接任务: 西泉要塞
    .accept 59 >>接任务: 布甲和皮甲 << Warlock
step
    .goto Elwynn Forest,41.7,65.5
    .accept 1097 >>接任务: 艾尔默的任务
step
    .xp 10 >>升级到10
step
    #softcore
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .accept 1638 >>接任务: 战士的训练
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,43.3,65.7
    .accept 114 >>接任务: 梅贝尔的隐形水
step << Warlock
    >>回到地下室
    .goto Elwynn Forest,44.4,66.2
    .accept 1685 >>接任务: 加科因的召唤
    .trainer >>训练你的职业咒语
step << Mage/Priest/Rogue
    #sticky
    #completewith next
    .goto Elwynn Forest,43.7,66.4,10 >>上楼去
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .accept 5635 >>接任务: 绝望祷言
    .trainer >>训练你的职业咒语
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.9,65.9
    >>别担心没有两件武器，我们很快就会有另一件
    >>在这里培训时，要非常小心你的钱。但要确保你训练了Dual Wield和Sprint
    .trainer >>训练你的职业咒语
step << Rogue
    #som
    .goto Elwynn Forest,41.7,65.9
    .money >0.3197
    .vendor >>你没有足够的钱，所以为你的副手买细高跟鞋
step << Rogue
    #era
    .goto Elwynn Forest,41.7,65.9
    .money >0.3152
    .vendor >>你没有足够的钱，所以为你的副手买细高跟鞋
step
    >>跑出客栈往南走
    .goto Elwynn Forest,43.2,89.6
    .turnin 114 >>交任务: 梅贝尔的隐形水
step
    .goto Elwynn Forest,34.7,84.5
    .turnin 88 >>交任务: 公主必须死！
step << Warlock
    >>点击周围任何通缉海报
    .goto Elwynn Forest,24.6,74.7
    .accept 176 >>接任务: 通缉：霍格
step
    .goto Elwynn Forest,24.2,74.5
    .turnin 239 >>交任务: 西泉要塞
    .accept 11 >>接任务: 悬赏河爪豺狼人 << Warlock
step << Warrior
    .money >0.3174
    #som
    >>磨碎一点，直到你有31秒74c以上的可供出售物品/钱
    >>这是用于投掷、2小时锤击和2小时剑训练的。它也适用于11级投掷，并飞往暴风城
    .goto Elwynn Forest,27.6,93.0
step << Warrior
    .money >0.3129
    #era
    >>磨碎一点，直到你有31秒29c以上的可供出售物品/钱
    >>这是用于投掷、2小时锤击和2小时剑训练的。这也是3级投掷，并飞往暴风城
    .goto Elwynn Forest,27.6,93.0
step << Warlock
    #sticky
    #completewith Armbands
    >>请留意取金时间表(幸运滴)，或Gruff Swiftbite的100%滴(罕见)。额外210xp
    .collect 1307,1,123 --Collect Gold Pickup Schedule (x1)
    .accept 123 >>接任务: 收货人
step << Warlock
    #label Hogger
    .unitscan Hogger
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,24.24,80.67,0
    >>Hogger可以出现在该地区的多个地点。让他恐惧重重，和/或在24,80时以<60%的马力将他风筝到塔上。抢走他的爪子
    >>小心，因为他可能会被其他暴徒吓到，受到重击，并且会被打昏
    .complete 176,1 --Collect Huge Gnoll Claw (1)
step << Warlock
    #label Armbands
    .goto Elwynn Forest,27.0,93.9
    >>杀死侏儒。掠夺他们作为臂章
    .complete 11,1 --Collect Painted Gnoll Armband (8)
step << Rogue
    #era
    #label Armbands
    .money >0.3152
    .goto Elwynn Forest,24.2,74.5
    .accept 11 >>接任务: 悬赏河爪豺狼人
step << Rogue
    #som
    #label Armbands
    .money >0.3197
    .goto Elwynn Forest,24.2,74.5
    .accept 11 >>接任务: 悬赏河爪豺狼人
step << Rogue
    .goto Elwynn Forest,27.0,93.9
    >>杀死侏儒。掠夺他们作为臂章
    .complete 11,1 --Collect Painted Gnoll Armband (x8)
    .isOnQuest 11
step << Warlock/Rogue
    .goto Elwynn Forest,24.2,74.5
    .turnin 11 >>交任务: 悬赏河爪豺狼人
    .isOnQuest 11
step << Rogue
    .abandon 123 >>放弃催收员
step
    .goto Westfall,60.0,19.4
    .turnin 184 >>交任务: 法布隆的地契
    .isOnQuest 184
step
    .goto Westfall,59.95,19.36
    .accept 64 >>接任务: 遗失的怀表
step
    .goto Westfall,59.9,19.4
    .accept 36 >>接任务: 杂味炖肉
    .accept 151 >>接任务: 老马布兰契
step
    .goto Westfall,56.04,31.22
    .accept 9 >>接任务: 清理荒野
step
    .goto Westfall,56.4,30.5
    .turnin 36 >>交任务: 杂味炖肉
    .accept 38 >>接任务: 杂味炖肉
    .accept 22 >>接任务: 猪肝馅饼
step
    #softcore
    #sticky
    #completewith next
    .goto Westfall,51.7,49.4,150 >>在精神疗愈者处死亡并重生，或跑到哨兵山
step
    .goto Westfall,56.3,47.5
    .turnin 109 >>交任务: 向格里安·斯托曼报到
    .accept 12 >>接任务: 西部荒野人民军
step
    #era
    .goto Westfall,56.3,47.5
    .accept 102 >>接任务: 西部荒野的豺狼人
step << Human
    .goto Westfall,57.0,47.2
    .vendor >>供应商垃圾
    .accept 6181 >>接任务: 快递消息
step << Rogue
    #era
    .money >0.3152
    +研磨，直到你有31秒52美分的可售物品/钱
step << Rogue
    #som
    .money >0.3197
    +研磨，直到你有31秒97c的可售物品/钱
--Not taking into account Shipment q turnin money so its insurance money
step
    .goto Westfall,56.6,52.6
    .turnin 6181 >>交任务: 快递消息 << Human
    .accept 6281 >>接任务: 赶赴暴风城 << Human
step
    .goto Westfall,56.6,52.6
    .fly Stormwind >>飞到暴风城
step << Rogue
    #som
    >>进入大楼
    .goto StormwindClassic,57.32,62.08,20,0
    .goto StormwindClassic,58.37,61.69
    .vendor >>购买瑟曼的11级投掷。11级时装备它
step << Rogue
    #era
    >>进入大楼
    .goto StormwindClassic,57.32,62.08,20,0
    .goto StormwindClassic,58.37,61.69
    .vendor >>购买瑟曼的3级投掷。装备它
step
    .goto StormwindClassic,56.2,64.6
    >>选择火箭队作为奖励。这些有很好的伤害，可以用来劈开
    .turnin 61 >>交任务: 送往暴风城的货物
step << !Warlock
    .goto StormwindClassic,52.61,65.71
    .home >>将您的炉石设置为暴风城
step << Warrior
    .goto StormwindClassic,57.1,57.7
    .trainer >>如果你有足够的钱，训练2小时剑。您必须保存20秒以备稍后使用
step << Priest
    .goto StormwindClassic,57.1,57.7
    .trainer >>火车杆
step << Mage/Warlock
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练棍，如果你还有钱的话，1小时剑
step << Rogue
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练1h剑
step << Rogue
    .goto StormwindClassic,57.6,57.1
    .vendor >>从Gunther处购买一把弯刀并装备它，副手细高跟鞋
step << Paladin
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练2h剑
step << Warlock
    .goto StormwindClassic,52.61,65.71
    .home >>将您的炉石设置为暴风城
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .turnin 1685 >>交任务: 加科因的召唤
    .accept 1688 >>接任务: 苏伦娜·凯尔东
step << Warlock
    #softcore
    .deathskip >>使用生命水龙头并站在你旁边的篝火上，在精神治疗者处死亡并重生
step << Warlock
    .goto Elwynn Forest,42.1,65.9
    .zone Elwynn Forest >>前往: 艾尔文森林
step << Warlock
    .isOnQuest 123
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >>交任务: 通缉：霍格
    .turnin 123 >>交任务: 收货人
step << Warlock
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >>交任务: 通缉：霍格
step << Warlock
    .xp 11 >>升级到11
step << Warlock
    >>在途中磨练，试着为以后提高你的击球技能
    >>杀死房子里的暴徒，让摩根保持恐惧(他凿伤并杀死宠物)，核弹袭击苏雷纳。为她的喉咙掠夺她
    .goto Elwynn Forest,71.0,80.8
    .complete 1688,1 --Collect Surena's Choker (x1)
step << Warlock
    .goto Elwynn Forest,79.5,68.8
    .turnin 59 >>交任务: 布甲和皮甲
step << Warlock
    #sticky
    #completewith next
    .goto Redridge Mountains,17.4,69.6
    .zone Redridge Mountains >>前往: 赤脊山, 在途中吸取灵魂碎片.
    .collect 6265,2 --Soul Shard (2)
step << Warlock
    .goto Redridge Mountains,17.4,69.6
    .accept 244 >>接任务: 豺狼人的入侵
step << Warlock
    >>小心路上的暴徒
    .goto Redridge Mountains,30.7,60.0
    .turnin 244 >>交任务: 豺狼人的入侵
step << Warlock
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
    .fly Stormwind >>飞到暴风城
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .turnin 1688 >>交任务: 苏伦娜·凯尔东
    .accept 1689 >>接任务: 誓缚
step << Warlock
    .goto StormwindClassic,25.2,80.7,14,0
    .goto StormwindClassic,23.2,79.5,14,0
    .goto StormwindClassic,26.3,79.5,14,0
    .goto StormwindClassic,25.5,78.1
    >>去地下室的底部。用血石窒息器召唤虚空行者并杀死它
    .complete 1689,1 --Kill Summoned Voidwalker (x1)
step << Warlock
    .goto StormwindClassic,25.2,78.5
    >>一旦你学会了，就不要召唤你的虚空行者
    .turnin 1689 >>交任务: 誓缚
step << Human
    .goto StormwindClassic,74.3,47.2
    .turnin 6281 >>交任务: 赶赴暴风城
    .accept 6261 >>接任务: 杜加尔·朗德瑞克
step << Warrior
     >>进入客栈
    .goto StormwindClassic,71.7,39.9,20,0
    .goto StormwindClassic,74.3,37.3
    .turnin 1638 >>交任务: 战士的训练
    .accept 1639 >>接任务: 醉鬼巴特莱比
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1639 >>交任务: 醉鬼巴特莱比
    .accept 1640 >>接任务: 击败巴特莱比
    .complete 1640,1 --Beat Bartleby
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1640 >>交任务: 击败巴特莱比
    .accept 1665 >>接任务: 巴特莱比的酒杯
step << Warrior
    >>你现在将学习防御姿态和破甲
    .goto StormwindClassic,74.3,37.3
    .turnin 1665 >>交任务: 巴特莱比的酒杯
step << Priest
    #completewith next
    .goto StormwindClassic,38.8,26.4
    .turnin 5635 >>交任务: 绝望祷言
step << Priest
    .goto StormwindClassic,38.62,26.10
    .train 13908 >>训练绝望祈祷
step
    #completewith next
    .goto StormwindClassic,51.8,12.1
    .turnin 1097 >>交任务: 艾尔默的任务
step
    .goto StormwindClassic,51.8,12.1
    .accept 353 >>接任务: 雷矛的包裹
step << Warrior/Paladin/Rogue
    >>把破甲放在你的栏上(它的伤害比英勇打击好) << Warrior
    .goto StormwindClassic,56.3,17.0
    .vendor >>购买采矿镐。你稍后将训练采矿
step
    #sticky
    #completewith next
    .goto StormwindClassic,63.9,8.3,20 >>进入Deeprun Tram
step
    >>有轨电车到了就乘，到了另一边就下车 << !Rogue !Warrior !Paladin !Warlock
    >>当电车到达时，乘电车。在等电车和上车时，要做绷带。当你到达另一边时接受q << Rogue/Warrior/Paladin
    >>当电车到达时，乘电车。施放召唤虚空行者并创造健康石。在另一边下车 << Warlock
    .accept 6661 >>接任务: 捕捉矿道老鼠
step
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >>交任务: 捕捉矿道老鼠
step
    .goto Ironforge,77.0,51.0
    .zone Ironforge >>前往: 铁炉堡
step
    .goto Ironforge,55.5,47.7
    .fp Ironforge >>获得铁炉堡飞行路线
step << Warrior
    .goto Ironforge,61.2,89.5
    .trainer >>训练2小时梅斯和投掷
step
    #sticky
    #som
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
    >>装备你的11级投掷 << Warrior
step
    #sticky
    #era
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
    >>装备你的3级投掷 << Warrior
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,14,0
    .goto Dun Morogh,62.2,49.4,12 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
    >>把他引到牧场南边的守卫那里。确保你对他造成51%+的伤害
    >>小心，因为这个任务可能很困难
    .goto Dun Morogh,62.6,46.1
    .goto Dun Morogh,62.78,54.60,0
    .complete 314,1 --Collect Fang of Vagash (1)
    .link https://www.youtube.com/watch?v=ZJX6sCkm5JY >>单击此处了解如何独奏瓦加什
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    #sticky
    #label Cooking
    .goto Dun Morogh,68.4,54.5
    .trainer >>Ghilm的火车烹饪
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买食物+水 << !Rogue !Warrior
    .vendor >>供应商，购买食物 << Rogue/Warrior
step
    #requires Cooking
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,69.3,55.5
    .train 2575 >>训练采矿，铸造寻找矿物
step
    .goto Dun Morogh,70.7,56.4,40,0
    .goto Dun Morogh,70.62,52.39
    >>在山洞里杀死Troggs
    >>注意节点，以获得更多粗糙的石头。 << Rogue/Warrior/Paladin
    .complete 432,1 --Kill Rockjaw Skullthumper (6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (10)
step << !Warlock
    .xp 10+6350>>提升经验到6350+/7600
step << Warlock
    .xp 12
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step << !Warlock
    .xp 11
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买x30 5级饮料 << Mage/Warlock/Priest
step
    .goto Dun Morogh,81.2,42.7,45,0
    .goto Dun Morogh,83.9,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>点击矮人尸体
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,78.9,37.0
    .complete 417,1 --Collect Mangy Claw (x1)
step
    #som
    .goto Dun Morogh,83.9,39.2
    >>选择匕首，用它作为你的副手，直到你得到一把小贩的剑 << Rogue
    .turnin 417 >>交任务: 驾驶员的复仇
step
    #era
    .goto Dun Morogh,83.9,39.2
    >>选择匕首，作为你的副手 << Rogue
    .turnin 417 >>交任务: 驾驶员的复仇
step
    .goto Dun Morogh,84.4,31.1,25 >>穿过隧道去莫丹湖
]])

RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance
#name 11-13 洛克莫丹
#version 1
#group RestedXP 联盟 1-20
#defaultfor Human
#next 13-15 西部荒野

step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.8,18.4
    .turnin 353 >>交任务: 雷矛的包裹
    .accept 307 >>接任务: 肮脏的爪子
step
    #sticky
    #completewith next
    >>在蜘蛛一角的区域内杀死蜘蛛
    .collect 3174,3 --Collect Spider Ichor (x3)
    >>在熊肉区杀死熊
    .collect 3173,3 --Collect Bear Meat (x3)
    >>在野猪肠道区域杀死野猪。把你得到的所有大块野猪肉都存起来
    .collect 3172,3 --Collect Boar Intestines (x3)
step
    .goto Loch Modan,35.1,47.8,130 >>在途中碾碎暴徒，以便稍后进行烹饪任务
step
    .goto Loch Modan,34.8,49.3
    .accept 418 >>接任务: 塞尔萨玛血肠
step
    #sticky
    #label StormpikeO
    .abandon 1338 >>放弃Stormpike的命令。这是为了解锁登山者Stormpike的任务
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买1-2个6槽包
step
    .goto Loch Modan,35.5,48.4
    .vendor >>购买食物/水(尝试喝40杯5级饮料，20杯5级食物) << Priest/Mage/Warlock/Paladin
    .vendor >>购买食物，尝试吃大约40种5级食物 << Rogue/Warrior
step
    #requires StormpikeO
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .accept 416 >>接任务: 狗头人的耳朵
    .accept 1339 >>接任务: 巡山人卡尔·雷矛的任务
step
    #sticky
    #completewith Thelsamar1
    >>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
    .complete 418,3 --Collect Spider Ichor (x3)
step
    #sticky
    #completewith Thelsamar1
    >>在Thelsamar鲜血香肠区杀死熊
    .complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #completewith Thelsamar1
    >>在赛尔萨马尔血肠区杀死野猪
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #label Thelsamar1
    .goto Loch Modan,39.3,27.0,130 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
    .goto Loch Modan,35.5,18.2,45 >>去洞口杀老鼠
step
    .goto Loch Modan,36.3,24.7
    >>收集你在山洞里找到的板条箱。小心，因为这在11级很难做到
    >>几秒钟后，当Geomangers施放火焰防护(Fire immunity)时要小心 << Mage/Warlock
    >>你可以在洞穴里再掠夺一次后返回，因为板条箱可以在你身后重生
    .complete 307,1 --Collect Miners' Gear (x4)
step << Paladin/Warrior
    #sticky
    #label Mace
    .goto Loch Modan,42.9,9.9
    .vendor >>向销售商查询他可以销售的绿色2小时狼牙棒。如果你有足够的钱，买了它。否则，就在这里从科波德斯那里磨钱，直到你有足够的钱 << Paladin/Warrior
    >>如果你有80银币时武器还没有，跳过这一步
step
    >>杀死科波德斯。抢走他们的耳朵
    >>确保为以后保存10块亚麻布。不要出售它 << Paladin
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
    .collect 2589,10 << Paladin
step << Paladin/Warrior
    #requires Mace
step
    #sticky
    #completewith Thelsamar2
    >>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
    .complete 418,3 --Collect Spider Ichor (x3)
step
    #sticky
    #completewith Thelsamar2
    >>在Thelsamar鲜血香肠区杀死熊
    .complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #completewith Thelsamar2
    >>在赛尔萨马尔血肠区杀死野猪
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #label Thelsamar2
    .goto Loch Modan,23.3,17.9,45 >>跑回沙坑，途中碾磨
step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.7,18.3
    .turnin 307 >>交任务: 肮脏的爪子
    .accept 1338 >>接任务: 卡尔·雷矛的订单
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
step
    #sticky
    #label Meat9
    .goto Loch Modan,26.9,10.7,100,0
    .goto Loch Modan,30.9,10.6,100,0
    .goto Loch Modan,28.6,15.4,100,0
    .goto Loch Modan,30.5,26.6,100,0
    .goto Loch Modan,33.4,30.3,100,0
    .goto Loch Modan,39.4,33.3,100,0
    .goto Loch Modan,26.9,10.7,100,0
    .goto Loch Modan,30.9,10.6,100,0
    .goto Loch Modan,28.6,15.4,100,0
    .goto Loch Modan,30.5,26.6,100,0
    .goto Loch Modan,33.4,30.3,100,0
    .goto Loch Modan,39.4,33.3,100,0
    .goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #label Ichor9
    .goto Loch Modan,31.9,16.4,100,0
    .goto Loch Modan,28.0,20.6,100,0
    .goto Loch Modan,33.8,40.5,100,0
    .goto Loch Modan,36.2,30.9,100,0
    .goto Loch Modan,39.0,32.1,100,0
    .goto Loch Modan,31.9,16.4,100,0
    .goto Loch Modan,28.0,20.6,100,0
    .goto Loch Modan,33.8,40.5,100,0
    .goto Loch Modan,36.2,30.9,100,0
    .goto Loch Modan,39.0,32.1,100,0
    .goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step
    .goto Loch Modan,38.0,34.9,100,0
    .goto Loch Modan,37.1,39.8,100,0
    .goto Loch Modan,29.8,35.9,100,0
    .goto Loch Modan,27.7,25.3,100,0
    .goto Loch Modan,28.6,22.6,100,0
    .goto Loch Modan,38.0,34.9,100,0
    .goto Loch Modan,37.1,39.8,100,0
    .goto Loch Modan,29.8,35.9,100,0
    .goto Loch Modan,27.7,25.3,100,0
    .goto Loch Modan,28.6,22.6,100,0
    .goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #requires Meat9
step
    #label RatCatching
    #requires Ichor9
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 416 >>交任务: 狗头人的耳朵
step
    .goto Loch Modan,34.8,49.3
    .turnin 418 >>交任务: 塞尔萨玛血肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买1块燧石和火药，以及1块简单木材。如果需要，购买更多6个插槽
    .collect 4470,1 --Simple Wood (1)
    .collect 4471,1 --Flint and Tinder (1)
step
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
step
    .goto Loch Modan,22.1,73.1
    .accept 224 >>接任务: 保卫国王的领土
step
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .accept 267 >>接任务: 穴居人的威胁
step
    .goto Loch Modan,29.9,68.2,45 >>跑到Troggs入口
step
    .goto Loch Modan,30.0,72.4,100,0
    .goto Loch Modan,34.7,71.6,100,0
    .goto Loch Modan,30.9,81.1,100,0
    .goto Loch Modan,30.0,72.4,100,0
    .goto Loch Modan,34.7,71.6,100,0
    .goto Loch Modan,30.9,81.1,100,0
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step << Warlock
    #sticky
    #completewith TroggT
    .money >0.7579
    .goto Loch Modan,32.7,76.5,0
    +在这里磨碎，直到你有75美分79美分的可售物品+钱，然后交上来
step << Warlock
    #era
    .goto Loch Modan,32.7,76.5,0
    .xp 13+9600>>提升经验到9600+/11400xp
step << Warlock
    #som
    .xp 14-2520 >>研磨，直到达到8880xp，进入13级
step
    .goto Loch Modan,22.2,73.3
    .turnin 224 >>交任务: 保卫国王的领土
step
    #label TroggT
    .goto Loch Modan,23.2,73.7
    .turnin 267 >>交任务: 穴居人的威胁
step << Warlock
    .xp 14 >>升级到14
step
    .hs >>霍斯到暴风城
    .vendor >>供应商垃圾 << !Paladin
    .vendor >>供应商垃圾箱。确保节省10件亚麻布 << Paladin
step << Warlock/Priest
    #softcore
    #label Wand1
    #completewith Wand2
     >>或者，如果价格<33秒40美分，从AH购买一个更大的魔杖
    .goto StormwindClassic,53.60,59.77
    .collect 11288,1 --Greater Magic Wand (1)
step << Warlock/Priest
    #softcore
    #label Wand2
    #completewith Wand1
     >>进入大楼。购买阴燃魔杖
    .goto StormwindClassic,42.65,67.16,14,0
    .goto StormwindClassic,42.84,65.14
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock/Priest
    #hardcore
     >>进入大楼。购买阴燃魔杖
    .goto StormwindClassic,42.65,67.16,14,0
    .goto StormwindClassic,42.84,65.14
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,26.11,77.20
    .trainer >>训练你的职业咒语
    .goto StormwindClassic,25.65,77.63
    .vendor >>购买消耗阴影r1，然后牺牲r1书籍(如果你有钱)
step << Mage
    .goto StormwindClassic,37.69,82.09,10 >>爬上塔楼，然后穿过入口
    .trainer >>训练你的职业咒语
step << Paladin
    >>为Duthorian Rall执行任务
    .goto StormwindClassic,39.80,29.77
    .turnin 1641 >>交任务: 圣洁之书
    .collect 6775,1,1642 --Tome of Divinity (1)
    .accept 1642 >>接任务: 圣洁之书
    .turnin 1642 >>交任务: 圣洁之书
    .accept 1643 >>接任务: 圣洁之书
step << Paladin
    .goto StormwindClassic,38.68,32.85
    .trainer >>训练你的职业咒语
step << Priest
    .goto StormwindClassic,38.54,26.86
    .trainer >>训练你的职业咒语
step
    .goto StormwindClassic,58.08,16.52
    .turnin 1338 >>交任务: 卡尔·雷矛的订单
step << Rogue
   .goto StormwindClassic,74.65,52.83
    .trainer >>训练你的职业咒语
step << Warrior
    #completewith next
    .goto StormwindClassic,74.91,51.55,20 >>进入指挥中心
step << Warrior
    .goto StormwindClassic,78.67,45.80
    .trainer >>上楼去。训练你的职业咒语
step << Paladin
    .goto StormwindClassic,57.08,61.74
    .turnin 1643 >>交任务: 圣洁之书
    .accept 1644 >>接任务: 圣洁之书
    .turnin 1644 >>交任务: 圣洁之书
    .accept 1780 >>接任务: 圣洁之书
step
    .goto StormwindClassic,66.28,62.13
    .turnin 6261 >>交任务: 杜加尔·朗德瑞克
    .accept 6285 >>接任务: 返回西部荒野
step
    .goto StormwindClassic,66.28,62.13
    .fly Westfall >>飞往威斯特福尔
]])

RXPGuides.RegisterGuide([[
#som
#phase 3-6
#classic
<< Alliance
#name 1-13 艾尔文森林
#version 1
#group RestedXP 联盟 1-20
#defaultfor Human
#next 13-14 洛克莫丹
step << !Human
    #sticky
    #completewith next
    .goto Elwynn Forest,48.2,42.9
    +您已经选择了一个针对人类的指南。你应该选择与你开始时相同的起始区域
step << Mage
    #completewith next
    +请注意，您已经选择了单目标法师指南。单目标比AoE Mage安全得多，并且随着SoM中最近100%的任务xp变化，通常也更快
step << Warlock
    #sticky
    #completewith next
    +杀死狼群10美分以上的小贩垃圾
    .goto Elwynn Forest,49.4,45.6,60,0
step << Warlock
    .goto Elwynn Forest,50.1,42.7
    .vendor >>供应商垃圾
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .accept 1598 >>接任务: 失窃的典籍
    .trainer >>火车献祭
step << Warlock
    #hardcore
    .goto Elwynn Forest,52.9,44.3,60,0
    >>在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=_-KEke9Yeik >>单击此处
    >>当你洗劫时，使用营地内的炉石
    .goto Elwynn Forest,56.7,44.0
    .complete 1598,1 --Collect Powers of the Void (x1)
step << Warlock
    #softcore
    .goto Elwynn Forest,52.9,44.3,60,0
    >>在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=_-KEke9Yeik >>单击此处
    .goto Elwynn Forest,56.7,44.0
    .complete 1598,1 --Collect Powers of the Void (x1)
step << Warlock
    #softcore
    .deathskip >>在精神治疗师处死亡并重生
step << Warlock
    #hardcore
    #completewith next
    >>确保你在帐篷的深处，这样你就不会重新聚集
    .hs >>炉灶返回Northshire Valley
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .turnin 1598 >>交任务: 失窃的典籍
step
    >>召唤小鬼，拒绝恶魔皮肤 << Warlock
    >>删除您的炉石
    .goto Elwynn Forest,48.2,42.9
    .accept 783 >>接任务: 身边的危机
step << Warrior
    #sticky
    #completewith next
    +杀死狼群10美分以上的小贩垃圾
    .goto Elwynn Forest,46.4,40.3,60,0
step << Warrior
    .goto Elwynn Forest,47.5,41.6
    .vendor >>供应商垃圾
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 783 >>交任务: 身边的危机
    .accept 7 >>接任务: 剿灭狗头人
step << Warrior
    .goto Elwynn Forest,50.2,42.3
    .trainer >>火车战斗呐喊
step
    >>跑回室外 << Warrior
    .goto Elwynn Forest,48.2,42.9
    .accept 5261 >>接任务: 伊根·派特斯金纳
step << Priest/Mage/Warlock
    .goto Elwynn Forest,46.2,40.4
    .vendor >>杀死狼，直到价值50美分的小贩垃圾。供应商，然后从丹尼尔兄弟那里购买10 x10的水。
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Priest/Mage
    .xp 2 >>升级到2
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 5261 >>交任务: 伊根·派特斯金纳
    .accept 33 >>接任务: 林中的群狼
step
    .goto Elwynn Forest,46.70,37.78
    >>杀死幼狼。抢他们的肉
    .complete 33,1 --Collect Tough Wolf Meat (x8)
step
    .goto Elwynn Forest,49.05,35.33
    >>杀死科博尔德害虫
    .complete 7,1 --Kill Kobold Vermin (x10)
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 33 >>交任务: 林中的群狼
step << Priest/Mage/Warlock
    .goto Elwynn Forest,47.6,41.5
    .vendor >>小贩扔掉垃圾，然后从丹尼尔兄弟那里多买10瓶水
step << !Priest !Mage !Warlock
    .goto Elwynn Forest,47.6,41.5
    .vendor >>供应商垃圾
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 7 >>交任务: 剿灭狗头人
    .accept 15 >>接任务: 回音山调查行动
    .accept 3100 >>接任务: 简要的信件 << Warrior
    .accept 3101 >>接任务: 圣洁信件 << Paladin
    .accept 3102 >>接任务: 密文信件 << Rogue
    .accept 3103 >>接任务: 神圣信件 << Priest
    .accept 3104 >>接任务: 雕文信件 << Mage
    .accept 3105 >>接任务: 被污染的信件 << Warlock
step
    .xp 3 >>升级到3
step
    .goto Elwynn Forest,47.42,32.68
    >>杀死Kobold工人
    .complete 15,1 --Kill Kobold Worker (x10)
step << !Rogue
    #sticky
    #label xp3
    .xp 3+820>>在回来的路上研磨到820+/1400经验
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾
step
    #requires xp3
    .goto Elwynn Forest,48.9,41.6
    .turnin 15 >>交任务: 回音山调查行动
    .accept 21 >>接任务: 回音山清剿行动
step << Priest/Mage
    #sticky
    #completewith next
    .goto Elwynn Forest,49.3,40.7,15 >>到这里来
step << Mage
    #sticky
    #completewith next
    .goto Elwynn Forest,49.5,40.0,15 >>上楼去
step << Mage
    .goto Elwynn Forest,49.7,39.4
    .turnin 3104 >>交任务: 雕文信件
    .trainer >>训练你的职业咒语
step << Priest
    #sticky
    #completewith next
    .goto Elwynn Forest,49.8,40.2,15 >>穿过门口
step << Priest
    .goto Elwynn Forest,49.8,39.5
    .turnin 3103 >>交任务: 神圣信件
    .trainer >>训练你的职业咒语
step << Warrior/Paladin
    #sticky
    #completewith next
    .goto Elwynn Forest,49.6,41.8,15 >>呆在楼下
step << Warrior
    .goto Elwynn Forest,50.2,42.3
    .turnin 3100 >>交任务: 简要的信件
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,50.4,42.1
    .turnin 3101 >>交任务: 圣洁信件
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,48.2,42.9
    .accept 18 >>接任务: 潜行者兄弟会
step << Warlock
    .goto Elwynn Forest,49.9,42.6
    .turnin 3105 >>交任务: 被污染的信件
    .xp 4 >>升级到4
    .trainer >>培训腐败
step
    .goto Elwynn Forest,54.57,49.03
    >>杀死德菲亚斯暴徒。抢了他们的头巾
    .complete 18,1 --Collect Red Burlap Bandana (x12)
step << Rogue
    .xp 4 >>升级到4
step
    .goto Elwynn Forest,48.2,42.9
    .turnin 18 >>交任务: 潜行者兄弟会
    .accept 6 >>接任务: 加瑞克·帕德弗特的赏金
    .accept 3903 >>接任务: 米莉·奥斯沃斯
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,47.66,31.88,40,0
    .goto Elwynn Forest,48.61,27.63
    >>杀死矿井中的工人
    .complete 21,1 --Kill Kobold Laborer (x12)
step
    .xp 5 >>升级到5
step
    .goto Elwynn Forest,50.7,39.2
    .turnin 3903 >>交任务: 米莉·奥斯沃斯
step << Rogue
    .goto Elwynn Forest,50.3,39.9
    >>你不需要训练
    .turnin 3102 >>交任务: 密文信件
step
    .goto Elwynn Forest,57.5,48.2
    >>途中研磨。杀死加里克并抢走他的头
    .complete 6,1 --Collect Garrick's Head (x1)
step
    #sticky
    .abandon 3904 >>放弃米莉的收获
step
    .xp 5+1220>>返回1220+/2800xp的路上
    .goto Elwynn Forest,48.2,42.9
step
    .goto Elwynn Forest,48.2,42.9
    .turnin 6 >>交任务: 加瑞克·帕德弗特的赏金
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 21 >>交任务: 回音山清剿行动
    .accept 54 >>接任务: 去闪金镇报到
step << Priest
    .goto Elwynn Forest,49.8,39.5
    .accept 5623 >>接任务: 圣光的恩赐
step
    .goto Elwynn Forest,45.6,47.7
    .accept 2158 >>接任务: 休息和放松
step
    #hardcore
    .goto Elwynn Forest,42.1,65.9
    .turnin 54 >>交任务: 去闪金镇报到
    .accept 62 >>接任务: 法戈第矿洞
step
    #softcore
    #sticky
    #completewith Goldshire
    .goto Elwynn Forest,39.5,60.5,200 >>在精神疗养院死去并重生，或者逃到戈德郡
step << Warrior/Paladin/Rogue
    .goto Elwynn Forest,41.7,65.5
    .trainer >>从阿格斯培训铁匠。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。 << Warrior/Rogue
    .trainer >>从阿格斯培训铁匠。这将允许你为你的武器制造+2点非常强大的伤害重石。 << Paladin
step << Warrior
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(5s36c)，从科瑞纳买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step << Rogue
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(4s1c)，就从科里纳买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Paladin
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(7s 1c)，从Corina买一把木制锤子。否则，请跳过此步骤(稍后再回来)
    .collect 2493,1 --Collect Wooden Mallet
step << Mage/Priest/Warlock
    #completewith next
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    #label Goldshire
    .goto Elwynn Forest,42.1,65.9
    .turnin 54 >>交任务: 去闪金镇报到
    .accept 62 >>接任务: 法戈第矿洞
step
    >>在你进客栈的时候，靠近左边
    .goto Elwynn Forest,42.9,65.7,15,0
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >>接任务: 狗头人的蜡烛
step
    .goto Elwynn Forest,43.8,65.8
    >>请勿在此购买任何食物/饮料 << Warlock
    .turnin 2158 >>交任务: 休息和放松
    .home >>将您的炉石设置为Goldshire
step
    .xp 6 >>升级到6
step << Rogue
    .goto Elwynn Forest,43.96,65.92
    .vendor 151 >>购买布罗格的3级投掷。装备它
step << Warlock
    #completewith next
    .goto Elwynn Forest,44.1,66.0,10 >>去客栈老板后面的房间，然后下楼。
step << Warlock
    .goto Elwynn Forest,44.4,66.2
    .trainer >>训练你的职业咒语
    .goto Elwynn Forest,44.4,66.0
    .vendor >>如果你在训练后有钱，就买血盟书(否则以后再买)
step << Mage/Priest/Rogue
    #sticky
    #completewith next
    .goto Elwynn Forest,43.7,66.4,12 >>上楼去
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .turnin 5623 >>交任务: 圣光的恩赐
    .accept 5624 >>接任务: 圣光之衣
    .trainer >>训练你的职业咒语
step << Rogue
    .money <0.01
    .goto Elwynn Forest,43.9,65.9
    .trainer >>训练你的职业咒语
step << Rogue/Warrior
    .money <0.01
    .goto Elwynn Forest,43.4,65.5
    .train 3273 >>训练急救-不要一次包扎好所有绷带，最好稍后再包扎
step << Warrior
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买5级食物至1银
step << Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买最多20种5级食物
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,42.1,67.3
    .accept 47 >>接任务: 金砂交易
step << Priest
    >>使用较低治疗等级2，然后使用金字招牌：对守卫罗伯茨的坚韧
    .goto Elwynn Forest,48.2,68.0
    .complete 5624,1 --Heal and fortify Guard Roberts
step
    #sticky
    #completewith BoarMeat1
    >>开始杀掉你看到的野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,34.5,84.3
    .accept 85 >>接任务: 丢失的项链
    .goto Elwynn Forest,34.7,84.5
    .accept 88 >>接任务: 公主必须死！
step
    #sticky
    #completewith Candles
    >>从附近的Kobolds买些蜡烛
    .complete 60,1 --Collect Kobold Candle (x8)
step
    #sticky
    #label Candles
    #completewith next
    >>从附近的Kobolds那里获得一些金粉
    .complete 47,1 --Collect Gold Dust (x10)
step << Priest/Mage/Warlock
    #label Dust
    >>将暴徒从矿井外向东驱赶
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Warrior
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将它变成一块锋利的石头，并将其应用到你的剑上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Rogue
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将其变成一块锋利的石头，并将其应用到你的匕首上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step << Paladin
    #label Dust
    >>将暴徒从矿井外向东碾碎。如果你在任何时候得到一块粗糙的石头，通过锻造将其制成一块重石，并将其应用到你的狼牙棒上
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step
    #label BoarMeat1
    .goto Elwynn Forest,43.2,89.6
    .accept 106 >>接任务: 年轻的恋人
step << Mage/Priest/Warlock
    .goto Elwynn Forest,42.4,89.4
    .vendor >>小贩，尽可能多买牛奶
step << !Mage !Priest !Warlock
    .goto Elwynn Forest,42.4,89.4
    .vendor >>供应商垃圾
step
    #completewith next
    >>途中磨碎野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,29.8,86.0
    .turnin 106 >>交任务: 年轻的恋人
    .accept 111 >>接任务: 托米的祖母
step
    .goto Elwynn Forest,32.5,85.5
    >>吃完野猪肉
    .complete 86,1 --Collect Chunk of Boar Meat (x4)
step
    .goto Elwynn Forest,34.5,84.3
    .turnin 86 >>交任务: 比利的馅饼
    .accept 84 >>接任务: 比利的馅饼
step
    .goto Elwynn Forest,34.9,83.9
    .turnin 111 >>交任务: 托米的祖母
    .accept 107 >>接任务: 给威廉·匹斯特的信
step
    #sticky
    #label KoboldCandles
    >>从附近的Kobolds买些蜡烛
    .complete 60,1 --Collect Kobold Candle (x8)
step
    #sticky
    #label GoldDust
    >>从附近的Kobolds那里获得一些金粉
    .complete 47,1 --Collect Gold Dust (x10)
step
    >>将暴徒从矿井外向东驱赶
    .goto Elwynn Forest,43.1,85.7
    .turnin 84 >>交任务: 比利的馅饼
    .accept 87 >>接任务: 金牙
step
    >>进入矿井
    .goto Elwynn Forest,40.5,82.3
    .complete 62,1 --Scout Through the Fargodeep Mine
step << Warrior
    >>尽可能多地招惹怒气(磨掉其他暴徒的怒气)，然后为伯妮斯的项链杀死戈登斯
    .goto Elwynn Forest,41.7,78.1
    .complete 87,1 --Collect Bernice's Necklace  (x1)
step << !Warrior
    >>为伯妮斯的项链杀死金牙
    .goto Elwynn Forest,41.7,78.1
    .complete 87,1 --Collect Bernice's Necklace  (x1)
step << Warrior
    #sticky
    #completewith Goldtooth
    +试着从现在开始保存一种治疗药剂，因为稍后你会需要它来治疗罗尔夫的尸体
step << Warrior/Rogue
    >>如果你捡到一块粗糙的石头，记得要做磨石
    .xp 7+880>>提升经验到880+/4500xp
step << Paladin
    >>如果你捡到一块粗糙的石头，记得要做砝码
    .xp 7+880>>提升经验到880+/4500xp
step << !Priest !Paladin !Warrior !Rogue
    .xp 7+880>>提升经验到880+/4500xp
step << Priest
    .xp 7+200>>提升经验到200+/4500xp
step
    #requires KoboldCandles
step
    #softcore
    #requires GoldDust
    #completewith next
    .deathskip >>在Goldshire死亡并重生
step
    #requires GoldDust
    #label Goldtooth
    .goto Elwynn Forest,42.1,67.3
    .turnin 47 >>交任务: 金砂交易
    .accept 40 >>接任务: 鱼人的威胁
step
    .goto Elwynn Forest,42.1,65.9
    .turnin 40 >>交任务: 鱼人的威胁
    .accept 35 >>接任务: 卫兵托马斯
    .turnin 62 >>交任务: 法戈第矿洞
    .accept 76 >>接任务: 玉石矿洞
step
    #completewith next
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step << Warrior
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(5s36c)，从科瑞纳买一辆格拉迪斯。否则，请跳过此步骤(稍后再回来)
    .collect 2488,1
step << Rogue
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(4s1c)，就从科里纳买一个细高跟鞋。否则，请跳过此步骤(稍后再回来)
    .collect 2494,1
step << Paladin
    .goto Elwynn Forest,41.5,65.9
    >>修理你的武器。如果你有足够的钱(7s 1c)，从Corina买一把木制锤子。否则，请跳过此步骤(稍后再回来)
    .collect 2493,1 --Collect Wooden Mallet
step
    .goto Elwynn Forest,43.3,65.7
    .turnin 60 >>交任务: 狗头人的蜡烛
    .accept 61 >>接任务: 送往暴风城的货物
    .turnin 107 >>交任务: 给威廉·匹斯特的信
    .accept 112 >>接任务: 收集海藻
step
    .xp 8 >>升级到8
step << Warlock
    >>回到地下室
    .goto Elwynn Forest,44.4,66.2
    .trainer >>训练你的职业咒语
    .goto Elwynn Forest,44.4,66.0
    .vendor >>如果您在培训后有钱，请购买Firebolt书籍(否则请稍后购买)
step
    .money <0.1250
    .goto Elwynn Forest,44.0,65.9
    .vendor >>从Brog购买6槽包
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step << Mage/Priest/Rogue/Warrior
    #completewith next
    .goto Elwynn Forest,43.7,66.4,15 >>上楼去
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .turnin 5624 >>交任务: 圣光之衣
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.9,65.9
    .trainer >>训练你的职业咒语
step << Rogue/Warrior/Paladin
    .money <0.01
    .goto Elwynn Forest,43.4,65.5
    .trainer >>训练急救-不要一次包扎好所有绷带，最好稍后再包扎
step << !Warrior !Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买5级水，最高40
step << Warrior/Rogue
    .goto Elwynn Forest,43.8,65.8
    .vendor 295 >>购买5级食物最多40个
step
    >>向东边碾碎莫洛克鱼，然后将其掠夺为海带蛙。如果你还需要的话，杀掉岛上的暴徒
    .goto Elwynn Forest,47.6,63.3,100,0
    .goto Elwynn Forest,51.4,64.6,100,0
    .goto Elwynn Forest,57.6,62.8,100,0
    .goto Elwynn Forest,56.4,66.6,100,0
    .goto Elwynn Forest,53.8,66.8,100,0
    .goto Elwynn Forest,57.6,62.8
    .complete 112,1 --Collect Crystal Kelp Frond (x4)
step
    >>进入矿井，继续沿着中间的小路走
    .goto Elwynn Forest,61.8,54.0,70,0
    .goto Elwynn Forest,60.4,50.2
    .complete 76,1 --Scout through the Jasperlode Mine
step
    .goto Elwynn Forest,74.0,72.2
    .turnin 35 >>交任务: 卫兵托马斯
    .accept 37 >>接任务: 失踪的卫兵
    .accept 52 >>接任务: 保卫边境
step
    #sticky
    #completewith Prowlers
    >>在执行其他任务时杀死潜行者
    .complete 52,1 --Kill Prowler (x8)
step
    #sticky
    #completewith Bears
    >>在执行其他任务时杀死熊。杀死你看到的任何人
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    .goto Elwynn Forest,72.7,60.3
    .turnin 37 >>交任务: 失踪的卫兵
    .accept 45 >>接任务: 罗尔夫的下落
step
    .goto Elwynn Forest,81.4,66.1
    .accept 5545 >>接任务: 木材危机
step
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾，修理
step << Paladin
    #softcore
    .goto Elwynn Forest,76.8,62.4,100,0
    .goto Elwynn Forest,83.7,59.4,100,0
    .goto Elwynn Forest,76.8,62.4,100,0
    .goto Elwynn Forest,83.7,59.4,100,0
    .goto Elwynn Forest,76.8,62.4
    >>在树的底部找一捆捆木头
    .complete 5545,1 --Collect Bundle of Wood (x8)
step << Paladin
    #hardcore
    #completewith Bundles
    >>留心树下的一捆捆原木
    .complete 5545,1 --Collect Bundle of Wood (x8)
step << !Paladin
    #sticky
    #completewith next
    >>留心树下的一捆捆原木
    .complete 5545,1 --Collect Bundle of Wood (x8)
step
    #label Bundles
    .goto Elwynn Forest,79.8,55.5,90 >>走向守卫的尸体
step << Priest
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。预制更新和盾牌，获得全部法力，然后将2个怪物拉到小屋前，移开，然后核弹一个。杀了一个就跑，然后杀了另一个。掠夺地上的尸体
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << !Paladin
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，一边放羊一边杀掉另一个，然后杀掉羊群暴徒。掠夺地上的尸体 << Mage
    >>池怒，然后杀死尸体周围的2名暴徒。将2名暴徒拉到小屋前，移开，保持一条腿筋，同时杀死另一条。杀了一个就逃跑(用弹珠在上面)，然后拉杀另一个。掠夺地上的尸体 << Warrior
    >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，用核弹袭击一个暴徒。使用回避。杀了一个就跑，然后杀了另一个。掠夺地上的尸体 << Rogue
     >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，然后让其中一个保持恐惧，并试着在两个上面都留下点。然后在地上洗劫尸体 << Warlock
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #softcore
    .goto Elwynn Forest,79.8,55.5
    >>在尸体上奔跑，然后使用神圣保护，立即洗劫尸体，处理并接受任务。你会死的
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #hardcore
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。将2名暴徒拉到小屋前，走开，用核弹袭击其中一名小屋暴徒。泡泡，治疗/必要时逃跑，然后回来杀死其他暴徒
    >>小心，因为这个任务很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << Paladin
    #softcore
    #sticky
    #completewith Bundles2
    .goto Elwynn Forest,83.6,69.7,120 >>在精神治疗者处死亡并重生，或者在有人清理尸体之前开始逃跑
step
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4,90,0
    .goto Elwynn Forest,83.7,59.4,90,0
    .goto Elwynn Forest,76.8,62.4
    >>开始后退，完成包裹
    .complete 5545,1 --Collect Bundle of Wood (x8)
step
    #label Bundles2
    .goto Elwynn Forest,81.4,66.1
    .turnin 5545 >>交任务: 木材危机
step
    #label Prowlers
    .xp 9 >>升级到9
step
    #label Bears
    .goto Elwynn Forest,79.5,68.8
    .accept 83 >>接任务: 红色亚麻布
step
    .goto Elwynn Forest,76.7,75.6,100,0
    .goto Elwynn Forest,79.7,83.7,100,0
    .goto Elwynn Forest,82.0,76.8,100,0
    .goto Elwynn Forest,76.7,75.6,100,0
    .goto Elwynn Forest,79.7,83.7,100,0
    .goto Elwynn Forest,82.0,76.8,100,0
    .goto Elwynn Forest,76.7,75.6
    >>杀死最后一批暴徒保护边境
    .complete 52,1 --Kill Prowler (x8)
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    .goto Elwynn Forest,74.0,72.2
    .turnin 52 >>交任务: 保卫边境
    .turnin 71 >>交任务: 回复托马斯
    .accept 39 >>接任务: 托马斯的报告
    .accept 109 >>接任务: 向格里安·斯托曼报到
step
    #sticky
    #completewith Deed
    >>留意德菲亚斯(Defias)的《威斯特福尔契约》(lucky drop)
    .collect 1972,1,184 --Collect Westfall Deed (x1)
    .accept 184 >>接任务: 法布隆的地契
step
    .goto Elwynn Forest,69.53,79.47
    >>开始围着农场转，杀掉德菲亚斯，然后掠夺他们的头巾
    .complete 83,1 --Collect Red Linen Bandana (x6)
step << Warrior
    .goto Elwynn Forest,69.4,79.2
    >>池怒，然后杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    .complete 88,1 --Collect Brass Collar (x1)
step << Rogue
    .goto Elwynn Forest,69.4,79.2
    >>确保躲避行动成功，然后杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    .complete 88,1 --Collect Brass Collar (x1)
step << !Rogue !Warrior
    .goto Elwynn Forest,69.4,79.2
    >>杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    >>如果你在挣扎，你可以用篱笆来滥用路径和争取时间
    .complete 88,1 --Collect Brass Collar (x1)
    .link https://www.youtube.com/watch?v=GRrXOV-UvD4 >>如果遇到困难，请单击此处
step << !Warlock !Warrior
    .goto Elwynn Forest,69.4,79.2
    .xp 10+200>>提升经验到200+/7600xp至10级
step
    #softcore
    #sticky
    #completewith next
    .goto Elwynn Forest,83.6,69.7,120 >>如果你的生命值低，在精神治疗者处死亡并重生，否则只需跑回并处理
step
    #label Deed
    .goto Elwynn Forest,79.5,68.9
    .turnin 83 >>交任务: 红色亚麻布
step << !Warlock
    #softcore
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾，修理
step << !Warlock !Warrior
    .goto Redridge Mountains,8.5,72.0
    .xp 10+1800>>提升经验到1800+/7600xp至10级
step << !Warlock
    .goto Redridge Mountains,8.5,72.0
    .zone Redridge Mountains >>前往: 赤脊山
step << !Warlock
    #softcore
    #sticky
    #completewith next
    +死在这里的暴徒面前
    .goto Redridge Mountains,11.2,78.4
step << !Warlock
    #softcore
    .goto Redridge Mountains,20.8,56.6,100 >>在精神治疗者处重生
step << !Warlock
    #softcore
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step << !Warlock
    #hardcore
    >>朝飞行路线跑去。要格外小心，不要在途中对任何暴徒进行攻击或死亡。试着紧贴道路，保持警惕
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step
    .hs >>赫斯到戈德郡
step
    .goto Elwynn Forest,43.3,65.7
    >>不要等待他的rp活动
    .turnin 112 >>交任务: 收集海藻
step << Warrior/Rogue
    .goto Elwynn Forest,43.4,65.6
    >>与楼上的急救教练交谈
    .train 3273 >>培训急救
step
    .goto Elwynn Forest,42.2,65.8
    .turnin 39 >>交任务: 托马斯的报告
    .turnin 76 >>交任务: 玉石矿洞
    .accept 239 >>接任务: 西泉要塞
    .accept 59 >>接任务: 布甲和皮甲 << Warlock
step
    .goto Elwynn Forest,41.7,65.5
    .accept 1097 >>接任务: 艾尔默的任务
step
    #softcore
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .accept 1638 >>接任务: 战士的训练
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Elwynn Forest,41.1,66.0
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,43.3,65.7
    .accept 114 >>接任务: 梅贝尔的隐形水
step << Warlock
    >>回到地下室
    .goto Elwynn Forest,44.4,66.2
    .accept 1685 >>接任务: 加科因的召唤
    .trainer >>训练你的职业咒语
step << Mage/Priest/Rogue
    #sticky
    #completewith next
    .goto Elwynn Forest,43.7,66.4,10 >>上楼去
step << Priest
    .goto Elwynn Forest,43.3,65.7
    .accept 5635 >>接任务: 绝望祷言
    .trainer >>训练你的职业咒语
step << Mage
    .goto Elwynn Forest,43.2,66.2
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.9,65.9
    >>别担心没有两件武器，我们很快就会有另一件
    >>在这里培训时，要非常小心你的钱。确保你训练了Dual Wield和Sprint，跳过其他
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,41.7,65.9
    .vendor >>为您的业余爱好购买细高跟鞋
step
    >>跑出客栈往南走
    .goto Elwynn Forest,43.2,89.6
    .turnin 114 >>交任务: 梅贝尔的隐形水
step
    .goto Elwynn Forest,34.7,84.5
    .turnin 88 >>交任务: 公主必须死！
step
    .goto Elwynn Forest,34.5,84.3
    .turnin 87 >>交任务: 金牙
step << Warlock
    >>点击周围任何通缉海报
    .goto Elwynn Forest,24.6,74.7
    .accept 176 >>接任务: 通缉：霍格
step
    .goto Elwynn Forest,24.2,74.5
    .turnin 239 >>交任务: 西泉要塞
    .accept 11 >>接任务: 悬赏河爪豺狼人 << Warlock/Warrior
step << Warrior
    >>如果你有31秒74c以上的可出售物品/金钱，跳过绘制侏儒臂章任务
    >>如果你有更少，跳过这一步
    >>这是用于投掷、2小时锤击和2小时剑训练的。它也适用于11级投掷，并飞往暴风城
    .abandon 11 >>放弃Riverpaw Gnoll Bounty
    .goto Elwynn Forest,27.6,93.0
step << Warlock/Warrior
    #sticky
    #completewith Armbands
    >>请留意取金时间表(幸运滴)，或Gruff Swiftbite的100%滴(罕见)。额外210xp
    .collect 1307,1,123 --Collect Gold Pickup Schedule (x1)
    .accept 123 >>接任务: 收货人
step << Warlock
    #label Hogger
    .unitscan Hogger
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,27.0,86.7,80,0
    .goto Elwynn Forest,26.1,89.9,80,0
    .goto Elwynn Forest,25.2,92.7,80,0
    .goto Elwynn Forest,27.0,93.9,80,0
    .goto Elwynn Forest,24.24,80.67,0
    >>Hogger可以出现在该地区的多个地点。让他恐惧重重，和/或在24,80时以<60%的马力将他风筝到塔上。抢走他的爪子
    >>小心，因为他可能会被其他暴徒吓到，受到重击，并且会被打昏
    .complete 176,1 --Collect Huge Gnoll Claw (1)
step << Warlock/Warrior
    #label Armbands
    .goto Elwynn Forest,27.0,93.9
    >>杀死侏儒。掠夺他们作为臂章
    .complete 11,1 --Collect Painted Gnoll Armband (8)
    .isOnQuest 11
step << Warrior
    .money >0.3174
    >>磨碎一点，直到你有31秒74c以上的可供出售物品/钱
    >>这是用于投掷、2小时锤击和2小时剑训练的。它也适用于11级投掷，并飞往暴风城
    .goto Elwynn Forest,27.6,93.0
step << Warlock/Warrior
    .goto Elwynn Forest,24.2,74.5
    .turnin 11 >>交任务: 悬赏河爪豺狼人
    .isOnQuest 11
step
    .goto Westfall,60.0,19.4
    .turnin 184 >>交任务: 法布隆的地契
    .isOnQuest 184
step
    .goto Westfall,59.9,19.4
    .accept 36 >>接任务: 杂味炖肉
step
    .goto Westfall,56.4,30.5
    .turnin 36 >>交任务: 杂味炖肉
step
    #softcore
    #sticky
    #completewith next
    .goto Westfall,51.7,49.4,150 >>在精神疗愈者处死亡并重生，或跑到哨兵山
step
    .goto Westfall,56.3,47.5
    .turnin 109 >>交任务: 向格里安·斯托曼报到
step << Human
    .goto Westfall,57.0,47.2
    .vendor >>供应商垃圾
    .accept 6181 >>接任务: 快递消息
step
    .goto Westfall,56.6,52.6
    .turnin 6181 >>交任务: 快递消息 << Human
    .accept 6281 >>接任务: 赶赴暴风城 << Human
step
    .goto Westfall,56.6,52.6
    .fly Stormwind >>飞到暴风城
step << Rogue/Warrior
    >>进入大楼
    .goto StormwindClassic,57.32,62.08,20,0
    .goto StormwindClassic,58.37,61.69
    .vendor >>购买瑟曼的11级投掷。装备它 << Rogue
    .vendor >>购买瑟曼的11级投掷。你稍后会装备它 << Warrior
step
    .goto StormwindClassic,56.2,64.6
    >>选择火箭队作为奖励。这些有很好的伤害，可以用来劈开
    .turnin 61 >>交任务: 送往暴风城的货物
step << Warrior
    .goto StormwindClassic,57.1,57.7
    .trainer >>如果你有闲钱，训练2小时剑。您必须保存20秒以备稍后使用
step << Priest/Mage/Warlock
    .goto StormwindClassic,57.1,57.7
    .trainer >>火车杆
step << Rogue
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练1h剑
step << Rogue
    .goto StormwindClassic,57.6,57.1
    .vendor >>从Gunther处购买一把弯刀并装备它，副手细高跟鞋
    >>如果你没有足够的钱，跳过这一步
step << Paladin
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练2h剑
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .turnin 1685 >>交任务: 加科因的召唤
    .accept 1688 >>接任务: 苏伦娜·凯尔东
step << Warlock
    .goto StormwindClassic,26.44,78.66
     .trainer >>训练你的职业咒语 << Warlock
step << Warlock
    #softcore
    .deathskip >>使用生命水龙头并站在你旁边的篝火上，在精神治疗者处死亡并重生
step << Warlock
    .goto Elwynn Forest,42.1,65.9
    .zone Elwynn Forest >>前往: 艾尔文森林
step << Warlock
    .isOnQuest 123
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >>交任务: 通缉：霍格
    .turnin 123 >>交任务: 收货人
step << Warlock
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >>交任务: 通缉：霍格
step << Warlock
    .xp 11 >>升级到11
step << Warlock
    >>在途中磨练，试着为以后提高你的击球技能
    >>杀死房子里的暴徒，让摩根保持恐惧(他凿伤并杀死宠物)，核弹袭击苏雷纳。为她的喉咙掠夺她
    .goto Elwynn Forest,71.0,80.8
    .complete 1688,1 --Collect Surena's Choker (x1)
step << Warlock
    .goto Elwynn Forest,79.5,68.8
    .turnin 59 >>交任务: 布甲和皮甲
step << Warlock
    #sticky
    #completewith next
    .goto Redridge Mountains,17.4,69.6
    .zone Redridge Mountains >>前往: 赤脊山, 在途中吸取灵魂碎片.
    .collect 6265,2 --Soul Shard (2)
step << Warlock
    .goto Redridge Mountains,17.4,69.6
    .accept 244 >>接任务: 豺狼人的入侵
step << Warlock
    >>小心路上的暴徒
    .goto Redridge Mountains,30.7,60.0
    .turnin 244 >>交任务: 豺狼人的入侵
step << Warlock
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
    .fly Stormwind >>飞到暴风城
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .turnin 1688 >>交任务: 苏伦娜·凯尔东
    .accept 1689 >>接任务: 誓缚
step << Warlock
    .goto StormwindClassic,25.2,80.7,14,0
    .goto StormwindClassic,23.2,79.5,14,0
    .goto StormwindClassic,26.3,79.5,14,0
    .goto StormwindClassic,25.5,78.1
    >>去地下室的底部。用血石窒息器召唤虚空行者并杀死它
    .complete 1689,1 --Kill Summoned Voidwalker (x1)
step << Warlock
    .goto StormwindClassic,25.2,78.5
    >>一旦你学会了，就不要召唤你的虚空行者
    .turnin 1689 >>交任务: 誓缚
step << Human
    .goto StormwindClassic,74.3,47.2
    .turnin 6281 >>交任务: 赶赴暴风城
step << !Mage !Warlock
    .goto StormwindClassic,42.66,33.75,30,0 << Paladin/Priest
     .goto StormwindClassic,38.68,32.85 << Paladin
    .goto StormwindClassic,38.54,26.86 << Priest
    .goto StormwindClassic,74.91,51.55,20,0 << Warrior
    .goto StormwindClassic,78.67,45.80 << Warrior
    .goto StormwindClassic,74.64,52.82 << Rogue
    .trainer >>训练你的职业咒语
step << Warrior
     >>进入客栈
    .goto StormwindClassic,71.7,39.9,20,0
    .goto StormwindClassic,74.3,37.3
    .turnin 1638 >>交任务: 战士的训练
    .accept 1639 >>接任务: 醉鬼巴特莱比
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1639 >>交任务: 醉鬼巴特莱比
    .accept 1640 >>接任务: 击败巴特莱比
    .complete 1640,1 --Beat Bartleby
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1640 >>交任务: 击败巴特莱比
    .accept 1665 >>接任务: 巴特莱比的酒杯
step << Warrior
    >>你现在将学习防御姿态和破甲
    .goto StormwindClassic,74.3,37.3
    .turnin 1665 >>交任务: 巴特莱比的酒杯
step << Priest
    #completewith next
    .goto StormwindClassic,38.8,26.4
    .turnin 5635 >>交任务: 绝望祷言
step << Priest
    .goto StormwindClassic,38.62,26.10
    .train 13908 >>训练绝望祈祷
step
    #completewith next
    .goto StormwindClassic,51.8,12.1
    .turnin 1097 >>交任务: 艾尔默的任务
step
    .goto StormwindClassic,51.8,12.1
    .accept 353 >>接任务: 雷矛的包裹
step << Warrior/Paladin/Rogue
    >>把破甲放在你的栏上(它的伤害比英勇打击好) << Warrior
    .goto StormwindClassic,56.3,17.0
    .vendor >>购买采矿镐。你稍后将训练采矿
step
    #sticky
    #completewith next
    .goto StormwindClassic,63.9,8.3,20 >>进入Deeprun Tram
step
    >>有轨电车到了就乘，到了另一边就下车 << !Rogue !Warrior !Paladin !Warlock
    >>当电车到达时，乘电车。在等电车和上车时，要做绷带。当你到达另一边时接受q << Rogue/Warrior/Paladin
    >>当电车到达时，乘电车。施放召唤虚空行者并创造健康石。在另一边下车 << Warlock
    .accept 6661 >>接任务: 捕捉矿道老鼠
step
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >>交任务: 捕捉矿道老鼠
step
    .goto Ironforge,77.0,51.0
    .zone Ironforge >>前往: 铁炉堡
step
    .goto Ironforge,55.5,47.7
    .fp Ironforge >>获得铁炉堡飞行路线
step << Mage
    .goto Ironforge,27.17,8.57
    .trainer >>训练你的职业咒语
step << Warrior
    .goto Ironforge,61.2,89.5
    .trainer >>训练2小时梅斯和投掷
step
    .goto Ironforge,18.22,51.44
    .home >>将您的炉石设置为铁炉堡
step
    #sticky
    #som
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
    >>装备你的11级投掷 << Warrior
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,14,0
    .goto Dun Morogh,62.2,49.4,12 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
    >>把他引到牧场南边的守卫那里。确保你对他造成51%+的伤害
    >>小心，因为这个任务可能很困难
    .goto Dun Morogh,62.6,46.1
    .goto Dun Morogh,62.78,54.60,0
    .complete 314,1 --Collect Fang of Vagash (1)
    .link https://www.youtube.com/watch?v=ZJX6sCkm5JY >>单击此处了解如何独奏瓦加什
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买食物+水 << !Rogue !Warrior
    .vendor >>供应商，购买食物 << Rogue/Warrior
step
    #requires Cooking
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,69.3,55.5
    .train 2575 >>训练采矿，铸造寻找矿物
step
    .goto Dun Morogh,70.7,56.4,40,0
    .goto Dun Morogh,70.62,52.39
    >>在山洞里杀死Troggs
    >>注意节点，以获得更多粗糙的石头。 << Rogue/Warrior/Paladin
    .complete 432,1 --Kill Rockjaw Skullthumper (6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买x30 5级饮料 << Mage/Warlock/Priest
step
    .goto Dun Morogh,81.2,42.7,45,0
    .goto Dun Morogh,83.9,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>点击矮人尸体
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,78.9,37.0
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    >>选择匕首，用它作为你的副手，直到你得到一把小贩的剑 << Rogue
    .turnin 417 >>交任务: 驾驶员的复仇
step
    .goto Dun Morogh,84.4,31.1,25 >>穿过隧道去莫丹湖
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance
#name 13-14 洛克莫丹
#version 1
#group RestedXP 联盟 1-20
#defaultfor Human
#next 14-19 黑海岸
step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.8,18.4
    .turnin 353 >>交任务: 雷矛的包裹
    .accept 307 >>接任务: 肮脏的爪子
step
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
step
    #sticky
    #label StormpikeO
    .abandon 1338 >>放弃Stormpike的命令。这是为了解锁登山者Stormpike的任务
step
    .goto Loch Modan,34.8,48.6
    >>跑到塞尔斯马尔的客栈
    .vendor >>购买1-2个6槽包
step
    .goto Loch Modan,35.5,48.4
    .vendor >>购买食物/水(尝试喝20杯5级饮料，10杯5级食物) << Priest/Mage/Warlock/Paladin
    .vendor >>购买食物，尝试吃大约20种5级食物 << Rogue/Warrior
step
    #requires StormpikeO
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .accept 416 >>接任务: 狗头人的耳朵
    .accept 1339 >>接任务: 巡山人卡尔·雷矛的任务
step
    #completewith Gearbois
    .goto Loch Modan,38.66,18.72,0
    >>杀死科波德斯。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
    .collect 2589,10 << Paladin
step
    .goto Loch Modan,35.5,18.2,45 >>去洞口杀老鼠
step
    #label Gearbois
    .goto Loch Modan,36.3,24.7
    >>收集你在山洞里找到的板条箱。小心，因为这在11级很难做到
    >>几秒钟后，当Geomangers施放火焰防护(Fire immunity)时要小心 << Mage/Warlock
    >>你可以在洞穴里再掠夺一次后返回，因为板条箱可以在你身后重生
    .complete 307,1 --Collect Miners' Gear (x4)
step
    .goto Loch Modan,38.66,18.72
    >>杀死科波德斯。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
    .collect 2589,10 << Paladin
step
    .goto Loch Modan,38.66,18.72
    .xp 13+5850>>将Kobolds提升经验到5850+/11400xp
step
    .goto Loch Modan,23.3,17.9,45 >>跑回沙坑
step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.7,18.3
    .turnin 307 >>交任务: 肮脏的爪子
    .accept 1338 >>接任务: 卡尔·雷矛的订单
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
step
    #softcore
    #completewith next
    .deathskip >>死后重生在塞尔萨马尔
step
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 416 >>交任务: 狗头人的耳朵
step
    .hs >>炉到铁炉
    .vendor >>供应商垃圾
step << Warlock/Priest
    #softcore
    #label Wand1
    #completewith Wand2
     >>或者，如果价格<33秒40美分，从AH购买一个更大的魔杖
    .goto Ironforge,25.77,75.43
    .collect 11288,1 --Greater Magic Wand (1)
step << Warlock/Priest
    #softcore
    #label Wand2
    #completewith Wand1
     >>进入大楼。购买阴燃魔杖
    >>如果你没有至少33秒40摄氏度，并且买不起大魔杖，请跳过这一步
    .goto Ironforge,23.32,17.62,20,0
    .goto Ironforge,23.12,15.93
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock/Priest
    #hardcore
    .money <0.3340
     >>进入大楼。购买阴燃魔杖
    .goto Ironforge,23.32,17.62,20,0
    .goto Ironforge,23.12,15.93
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock
    .goto Ironforge,51.1,8.7,18 >>进入大楼
    .goto Ironforge,50.4,6.3
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Ironforge,53.2,7.8,18 >>进入大楼
    .goto Ironforge,53.0,6.4
    .vendor >>购买消耗阴影r1，然后牺牲r1
step << !Druid
    .goto Ironforge,69.88,82.90 << Hunter
    .goto Ironforge,65.90,88.41 << Warrior
    .goto Ironforge,50.34,5.67 << Warlock
    .goto Ironforge,51.50,15.34 << Rogue
    .goto Ironforge,25.21,10.75 << Priest
    .goto Ironforge,27.17,8.57 << Mage
    .goto Ironforge,24.55,4.46 << Paladin
     .trainer >>训练你的职业咒语
step
    .goto Dun Morogh,53.5,34.9
    .zone Dun Morogh>>退出铁炉堡
step
    #hardcore
    #completewith next
    .goto Dun Morogh,59.43,42.85,150 >>前往跳跃点
step
    #hardcore
    .goto Dun Morogh,59.5,42.8,40,0
    .goto Dun Morogh,60.4,44.1,40,0
    .goto Dun Morogh,61.1,44.1,40,0
    .goto Dun Morogh,61.2,42.3,40,0
    .goto Dun Morogh,60.8,40.9,40,0
    .goto Dun Morogh,59.0,39.5,40,0
    .goto Dun Morogh,60.3,38.6,40,0
    .goto Dun Morogh,61.7,38.7,40,0
    .goto Dun Morogh,65.7,21.6,40,0
    .goto Dun Morogh,65.8,12.5,40,0
    .goto Dun Morogh,65.6,10.8,40,0
    .goto Dun Morogh,66.5,10.0,40,0
    .goto Dun Morogh,66.9,8.5,40,0
    .goto Wetlands,20.6,67.2,50,0
    .goto Wetlands,17.7,67.7,40,0
    .goto Wetlands,16.8,65.3,40,0
    .goto Wetlands,15.1,64.0,40,0
    .goto Wetlands,12.1,60.3,40,0
    >>打开此链接并在另一个屏幕上进行跟踪。
    >>邓莫罗不死->湿地跳过
    >>横渡大海时要避开鳄鱼
    .link https://www.youtube.com/watch?v=9afQTimaiZQ >>单击此处以供参考
    .goto Wetlands,12.1,60.3,80 >>前往: 湿地
step
    #softcore
    #completewith next
    .goto Dun Morogh,30.9,33.1,20 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,20 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,20,0
    .goto Dun Morogh,33.0,25.2,20,0
    .goto Wetlands,11.6,43.4,60,0
    .deathskip >>继续向北奔跑，摔倒死亡，然后重生
step
    #softcore
    .goto Wetlands,12.7,46.7,80 >>游到岸上
step
    .money <0.08
    .goto Wetlands,10.4,56.0,15,0
    .goto Wetlands,10.1,56.9,15,0
    .goto Wetlands,10.6,57.2,15,0
    .goto Wetlands,10.7,56.8
    .vendor >>如果你有8s，检查Neal Allen的铜管，如果有就买
step
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >>获取Menethil Harbor航线
step
    .money <0.04
    .goto Wetlands,8.1,56.3
    .vendor >>在大楼里，查看Dewin是否有治疗药剂，购买时间减至1秒
step
    .goto Wetlands,4.7,57.3
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸
    >>如果你有亚麻布，在等待船只时进行急救训练，你需要80分的急救才能完成24级任务 << Rogue
]])

