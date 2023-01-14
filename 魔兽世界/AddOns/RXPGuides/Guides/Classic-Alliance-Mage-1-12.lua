RXPGuides.RegisterGuide([[
#classic
<< Human Mage
#name 1-10 艾尔文森林 法师 AoE
#version 1
#group RestedXP 联盟 法师
#defaultfor Human
#next 10-12 洛克莫丹 法师 AoE
step
    #sticky
    #completewith next
    .goto Elwynn Forest,48.2,42.9
    +您已经选择了一个针对人类的指南。你应该选择与你开始时相同的起始区域 << Gnome
    +请注意，您已经选择了AoE指南。AoE通常比单目标法师困难得多，但速度快得多
step
    >>删除您的炉石
    .goto Elwynn Forest,48.2,42.9
    .accept 783 >>接任务: 身边的危机
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 783 >>交任务: 身边的危机
    .accept 7 >>接任务: 剿灭狗头人
step
    .goto Elwynn Forest,48.2,42.9
    .accept 5261 >>接任务: 伊根·派特斯金纳
step
    .goto Elwynn Forest,46.2,40.4
    .vendor >>杀死狼，直到你有价值50美分的小贩垃圾。供应商，然后从丹尼尔兄弟那里购买10 x10的水。
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step
    .xp 2 >>升级到2
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 5261 >>交任务: 伊根·派特斯金纳
    .accept 33 >>接任务: 林中的群狼
step
    .goto Elwynn Forest,46.1,40.7,40,0
    .goto Elwynn Forest,46.2,37.6,40,0
    .goto Elwynn Forest,47.6,37.2,40,0
    .goto Elwynn Forest,46.1,40.7,40,0
    .goto Elwynn Forest,46.2,37.6,40,0
    .goto Elwynn Forest,47.6,37.2,40,0
    >>杀死该地区的幼狼以获取肉食
    .complete 33,1 --Collect Tough Wolf Meat (x8)
step
    .goto Elwynn Forest,47.4,35.3,40,0
    .goto Elwynn Forest,49.7,36.2,40,0
    .goto Elwynn Forest,47.4,35.3,40,0
    .goto Elwynn Forest,49.7,36.2,40,0
    .goto Elwynn Forest,47.4,35.3,40,0
    .goto Elwynn Forest,49.7,36.2,40,0
    >>杀死该地区的科博尔德害虫
    .complete 7,1 --Kill Kobold Vermin (x10)
step
    .goto Elwynn Forest,48.9,40.2
    .turnin 33 >>交任务: 林中的群狼
step
    .goto Elwynn Forest,47.6,41.5
    .vendor >>小贩扔掉垃圾，然后从丹尼尔兄弟那里多买10瓶水
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 7 >>交任务: 剿灭狗头人
    .accept 15 >>接任务: 回音山调查行动
    .accept 3104 >>接任务: 雕文信件
step
    .xp 3 >>升级到3
step
    .goto Elwynn Forest,47.5,36.3,40,0
    .goto Elwynn Forest,46.6,32.2,40,0
    .goto Elwynn Forest,48.6,34.0,40,0
    .goto Elwynn Forest,47.5,36.3,40,0
    .goto Elwynn Forest,46.6,32.2,40,0
    .goto Elwynn Forest,48.6,34.0,40,0
    >>杀死Kobold工人
    .complete 15,1 --Kill Kobold Worker (x10)
step
    .goto Elwynn Forest,47.7,41.4
    .xp 3+1110>>在回镇的路上，提升经验到1110+/1400经验
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾
step
    .goto Elwynn Forest,48.9,41.6
    .turnin 15 >>交任务: 回音山调查行动
    .accept 21 >>接任务: 回音山清剿行动
step
    >>上楼去
    .goto Elwynn Forest,49.3,40.7,15,0
    .goto Elwynn Forest,49.5,40.0,15,0
    .goto Elwynn Forest,49.7,39.4
    .turnin 3104 >>交任务: 雕文信件
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,48.2,42.9
    .accept 18 >>接任务: 潜行者兄弟会
step
    .goto Elwynn Forest,53.7,52.2,60,0
    .goto Elwynn Forest,55.7,47.4,60,0
    .goto Elwynn Forest,54.7,41.9,60,0
    .goto Elwynn Forest,53.7,52.2,60,0
    .goto Elwynn Forest,55.7,47.4,60,0
    .goto Elwynn Forest,54.7,41.9,60,0
    >>杀死德菲亚斯暴徒。抢了他们的头巾
    .complete 18,1 --Collect Red Burlap Bandana (x12)
step
    .goto Elwynn Forest,48.2,42.9
    .turnin 18 >>交任务: 潜行者兄弟会
    .accept 6 >>接任务: 加瑞克·帕德弗特的赏金
    .accept 3903 >>接任务: 米莉·奥斯沃斯
step
    .goto Elwynn Forest,47.7,41.4
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,54.7,41.9,60,0
    .goto Elwynn Forest,47.7,31.7,60,0
    .goto Elwynn Forest,50.4,27.0,60,0
    .goto Elwynn Forest,47.7,31.7,60,0
    .goto Elwynn Forest,50.4,27.0,60,0
    .goto Elwynn Forest,47.7,31.7,60,0
    .goto Elwynn Forest,50.4,27.0,60,0
    .goto Elwynn Forest,47.7,31.7,60,0
    .goto Elwynn Forest,50.4,27.0,60,0
    >>杀死矿井中的工人
    .complete 21,1 --Kill Kobold Laborer (x12)
step
    .xp 5 >>升级到5
step
    #era/som
    .goto Elwynn Forest,50.7,39.2
    .turnin 3903 >>交任务: 米莉·奥斯沃斯
    .accept 3904 >>接任务: 米莉的葡萄
step
    #phase 3-6
    .goto Elwynn Forest,50.7,39.2
    .turnin 3903 >>交任务: 米莉·奥斯沃斯
step
    #era/som
    >>在田里掠夺葡萄桶
    .goto Elwynn Forest,54.5,49.4
    .complete 3904,1 --Collect Milly's Harvest (x8)
step
    .goto Elwynn Forest,57.5,48.2
    >>杀死加里克并抢走他的头
    .complete 6,1 --Collect Garrick's Head (x1)
step
    .xp 5+1175>>在返回1175+/2800xp的途中进行研磨
    .goto Elwynn Forest,50.7,39.2
step
    #era/som
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
step
     #era/som
     >>到主楼梯上去
    .goto Elwynn Forest,49.6,41.6,15,0
    .goto Elwynn Forest,48.9,41.3,15,0
    .goto Elwynn Forest,49.5,41.6
    .turnin 3905 >>交任务: 葡萄出货单
step
    .goto Elwynn Forest,45.6,47.7
    .accept 2158 >>接任务: 休息和放松
step
    #softcore
    #sticky
    #completewith next
    .goto Elwynn Forest,39.5,60.5,200 >>在精神疗养院死去并重生，或者逃到戈德郡
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,42.1,65.9
    .turnin 54 >>交任务: 去闪金镇报到
    .accept 62 >>接任务: 法戈第矿洞
step
    .goto Elwynn Forest,42.9,65.7,15,0
    >>在你进客栈的时候，靠近左边
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >>接任务: 狗头人的蜡烛
step
    .goto Elwynn Forest,43.8,65.8
    .turnin 2158 >>交任务: 休息和放松
    .home >>将您的炉石设置为Goldshire
step
    .xp 6 >>升级到6
step
    .goto Elwynn Forest,43.7,66.4,12,0
    .goto Elwynn Forest,43.2,66.2
    .trainer >>上楼去。训练你的职业咒语
step
    .goto Elwynn Forest,42.1,67.3
    .accept 47 >>接任务: 金砂交易
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
step
    #label Dust
    >>将暴徒从矿井外向东驱赶
    .goto Elwynn Forest,43.1,85.7
    .turnin 85 >>交任务: 丢失的项链
    .accept 86 >>接任务: 比利的馅饼
step
    #label BoarMeat1
    .goto Elwynn Forest,43.2,89.6
    .accept 106 >>接任务: 年轻的恋人
step
    .goto Elwynn Forest,42.4,89.4
    .vendor >>小贩，尽可能多买牛奶
step
    #sticky
    #completewith next
    >>杀死你看到的野猪肉
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
step
    >>为伯妮斯的项链杀死金牙
    .goto Elwynn Forest,41.7,78.1
    .complete 87,1 --Collect Bernice's Necklace  (x1)
step
    .xp 7+1600>>提升经验到1600+/4500xp
step
    #requires KoboldCandles
step
    #label Goldtooth
    #requires GoldDust
    .goto Elwynn Forest,34.5,84.3
    .turnin 87 >>交任务: 金牙
step
    >>把一些暴徒逼回戈德郡
    .xp 7+2690>>提升经验到2690+/4500xp
    .goto Elwynn Forest,42.1,67.3
step
    .goto Elwynn Forest,42.1,67.3
    .turnin 47 >>交任务: 金砂交易
    .accept 40 >>接任务: 鱼人的威胁
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,42.1,65.9
    .turnin 40 >>交任务: 鱼人的威胁
    .accept 35 >>接任务: 卫兵托马斯
    .turnin 62 >>交任务: 法戈第矿洞
    .accept 76 >>接任务: 玉石矿洞
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,43.3,65.7
    .turnin 60 >>交任务: 狗头人的蜡烛
    .accept 61 >>接任务: 送往暴风城的货物
    .turnin 107 >>交任务: 给威廉·匹斯特的信
    .accept 112 >>接任务: 收集海藻
step
    .xp 8 >>升级到8
step
    .money <0.1250
    .goto Elwynn Forest,44.0,65.9
    .vendor >>从Brog购买6槽包
step
    .goto Elwynn Forest,43.7,66.4,12,0
    .goto Elwynn Forest,43.2,66.2
    .trainer >>上楼去。训练你的职业咒语
step
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买5级水，最高40
step
    >>向东边碾碎莫洛克鱼，然后将其掠夺为海带蛙。如果你还需要的话，杀掉岛上的暴徒
    .goto Elwynn Forest,47.6,63.3,60,0
    .goto Elwynn Forest,51.4,64.6,50,0
    .goto Elwynn Forest,57.6,62.8,50,0
    .goto Elwynn Forest,56.4,66.6,50,0
    .goto Elwynn Forest,53.8,66.8,50,0
    .complete 112,1 --Collect Crystal Kelp Frond (x4)
step
    >>进入矿井，继续沿着中间的小路走
    .goto Elwynn Forest,61.8,54.0,60,0
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
step
    #sticky
    #completewith Bundles
    >>留心树下的一捆捆原木
    .collect 13872,8 --Collect Bundle of Wood (x8)
step
    #label Bundles
    .goto Elwynn Forest,79.8,55.5,60 >>走向守卫的尸体
step
    .goto Elwynn Forest,79.8,55.5
    >>杀死尸体周围的暴徒。把两个暴徒拉到小屋前，走开，一边放羊一边杀掉另一个，然后杀掉羊群暴徒。掠夺地上的尸体
    >>小心，因为这个任务可能很困难
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    >>开始后退，完成包裹
    .collect 13872,8 --Collect Bundle of Wood (x8)
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
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
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
    #completewith Princess
    >>留意德菲亚斯(Defias)的《威斯特福尔契约》(lucky drop)
    .collect 1972,1,184 --Collect Westfall Deed (x1)
    .accept 184 >>接任务: 法布隆的地契
step
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    >>开始围着农场转，杀掉德菲亚斯，然后掠夺他们的头巾
    .complete 83,1 --Collect Red Linen Bandana (x6)
step
    #label Princess
    .goto Elwynn Forest,69.4,79.2
    >>杀死公主。如果需要的话，使用之前的小治疗药剂。抢走她的衣领
    >>你也可以在农场边缘的篱笆之间来回跳跃，杀死公主和她的守卫
    .complete 88,1 --Collect Brass Collar (x1)
--N link
step
    #softcore
    #sticky
    #completewith next
    .goto Elwynn Forest,83.6,69.7,120 >>如果你的生命值低，在精神治疗者处死亡并重生，否则只需跑回并处理
step
    .goto Elwynn Forest,79.5,68.9
    .turnin 83 >>交任务: 红色亚麻布
step
    .goto Redridge Mountains,7.87,73.85
    .zone Redridge Mountains >>前往: 赤脊山
step
    #softcore
    #sticky
    #completewith next
    +死在这里的暴徒面前
    .goto Redridge Mountains,11.2,78.4
step
    #softcore
    >>在精神治疗者处重生
    .goto Redridge Mountains,20.8,56.6,100 >>在精神治疗者处重生
step
    #softcore
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step
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
step
    .goto Elwynn Forest,42.2,65.8
    .turnin 39 >>交任务: 托马斯的报告
    .turnin 76 >>交任务: 玉石矿洞
    .accept 239 >>接任务: 西泉要塞
step
    .goto Elwynn Forest,41.7,65.5
    .accept 1097 >>接任务: 艾尔默的任务
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,43.3,65.7
    .accept 114 >>接任务: 梅贝尔的隐形水
step
    >>跑出客栈往南走
    .goto Elwynn Forest,43.2,89.6
    .turnin 114 >>交任务: 梅贝尔的隐形水
step
    .goto Elwynn Forest,34.7,84.5
    .turnin 88 >>交任务: 公主必须死！
step
    .goto Elwynn Forest,24.2,74.5
    .turnin 239 >>交任务: 西泉要塞
step
    .isOnQuest 184
    .goto Westfall,60.0,19.4
    .turnin 184 >>交任务: 法布隆的地契
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
step
    .goto Westfall,57.0,47.2
    .vendor >>供应商垃圾
    .accept 6181 >>接任务: 快递消息
step
    #phase 3-6
    .goto Westfall,56.4,30.5
    .xp 11+3750>>提升经验到3750+/8800xp
step
    .goto Westfall,56.6,52.6
    .fp Sentinel Hill >>获取哨兵山飞行路线
    .turnin 6181 >>交任务: 快递消息
    .accept 6281 >>接任务: 赶赴暴风城
    .fly Stormwind >>飞到暴风城
step
    .goto StormwindClassic,56.2,64.6
    >>选择火箭。这些有很好的伤害，可以用来劈开
    .turnin 61 >>交任务: 送往暴风城的货物
step
    #era/som
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练1h剑
step
    .goto StormwindClassic,74.3,47.2
    .turnin 6281 >>交任务: 赶赴暴风城
    >>供应商和维修
step
    #completewith next
    .goto StormwindClassic,51.8,12.1
    .turnin 1097 >>交任务: 艾尔默的任务
step
    .goto StormwindClassic,51.8,12.1
    .accept 353 >>接任务: 雷矛的包裹
step
    #sticky
    #completewith next
    .goto StormwindClassic,63.9,8.3,20 >>进入Deeprun Tram
step
    >>有轨电车到了就乘，到了另一边就下车
    .accept 6661 >>接任务: 捕捉矿道老鼠
step
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >>交任务: 捕捉矿道老鼠
step
    .goto Ironforge,77.0,51.0,30 >>前往: 铁炉堡
step
    .goto Ironforge,55.5,47.7
    .fp Ironforge >>获得铁炉堡飞行路线
step
    #phase 3-6
    .goto Ironforge,27.17,8.57
     .trainer >>训练你的职业咒语
step
    #sticky
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
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
--N add video tutorial
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    >>途中磨碎一点
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买食物+水
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step
    .goto Dun Morogh,70.6,56.6,30,0
    .goto Dun Morogh,70.8,53.3,30,0
    .goto Dun Morogh,71.9,50.7,30,0
    .goto Dun Morogh,72.9,53.1,30,0
    .goto Dun Morogh,70.6,56.6,30,0
    .goto Dun Morogh,70.8,53.3,30,0
    .goto Dun Morogh,71.9,50.7,30,0
    .goto Dun Morogh,72.9,53.1,30,0
    >>在山洞里杀死Troggs
    .complete 432,1 --Kill Rockjaw Skullthumper (6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (10)
step
    #era/som
    .xp 10+6350>>提升经验到6350+/7600
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step
    #era/som
    .xp 11
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>小贩垃圾，从喀山购买x30 5级饮料
    .trainer >>Ghilm的火车烹饪。你需要这个来接2个额外任务
step
    .goto Dun Morogh,83.9,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >>交任务: 驾驶员的复仇
step
    .goto Dun Morogh,84.4,31.1,25 >>穿过隧道去莫丹湖
]])

RXPGuides.RegisterGuide([[
#classic
<< Gnome Mage
#name 1-10 丹莫罗 法师 AoE
#version 1
#group RestedXP 联盟 法师
#defaultfor Dwarf/Gnome
#next 10-12 洛克莫丹 法师 AoE
step
    #era/som
    #sticky
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域 << Human
    +请注意，您已经选择了AoE指南。AoE通常比单目标法师困难得多，但速度快得多
step
    #phase 3-6
    #sticky
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域 << Human
    +请注意，您已经选择了AoE指南。AoE通常比单目标法师困难得多，但随着最近100%任务xp的变化，速度也变慢了
step
    >>删除您的炉石
    .goto Dun Morogh,29.9,71.2
    .accept 179 >>接任务: 矮人的交易
step
    >>杀死狼。抢他们的肉
    .goto Dun Morogh,28.7,74.8
    .complete 179,1 --Collect Tough Wolf Meat (x8)
step
    .xp 2 >>升级到2
step
    .goto Dun Morogh,30.0,71.5
    >>供应商垃圾箱。购买15杯水。如果你没有足够的钱，就多磨几只狼
    .collect 159,15 --Collect Refreshing Spring Water (x15)
step
    .goto Dun Morogh,29.9,71.2
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3114 >>接任务: 雕文备忘录
step
    .goto Dun Morogh,29.7,71.2
    .accept 170 >>接任务: 新的威胁
step
    #sticky
    #completewith Rockjaw
    >>杀死你看到的普通岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    >>杀死Burly Rockjaw Troggs
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 233 >>交任务: 寒脊山谷的送信任务
    .accept 183 >>接任务: 猎杀野猪
    .accept 234 >>接任务: 寒脊山谷的送信任务
step
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>交任务: 猎杀野猪
step
    .xp 3+860>>提升经验到860+/1400经验
    .goto Dun Morogh,23.0,75.0,40,0
    .goto Dun Morogh,24.2,72.5,40,0
    .goto Dun Morogh,27.7,76.3,40,0
    .goto Dun Morogh,23.0,75.0,40,0
    .goto Dun Morogh,24.2,72.5,40,0
    .goto Dun Morogh,27.7,76.3,40,0
step
    #label Rockjaw
    .goto Dun Morogh,25.1,75.7
    .turnin 234 >>交任务: 寒脊山谷的送信任务
    .accept 182 >>接任务: 巨魔洞穴
step
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >>接任务: 热酒快递
    >>一旦接受，将启动5分钟计时器。放松并遵循指南
step
    .goto Dun Morogh,28.7,77.5
    >>如果你现在还没有处理完Troggs，就上去杀了他们
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
    #sticky
    #completewith Scalding1
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >>接任务: 热酒快递
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
step
    #label Scalding1
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
    .accept 3365 >>接任务: 归还酒杯
    .vendor >>供应商垃圾
step
    .goto Dun Morogh,28.7,66.4
    .turnin 3114 >>交任务: 雕文备忘录
    .trainer >>训练你的职业咒语
step
    >>跑出沙坑
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >>交任务: 新的威胁
step
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商，购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step
    .goto Dun Morogh,26.3,79.2,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
step
    #sticky
    #label Mug
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >>交任务: 归还酒杯
step
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >>交任务: 巨魔洞穴
    .accept 218 >>接任务: 被窃取的日记
step
    #requires Mug
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
    >>磨碎一点回到这里
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >>交任务: 被窃取的日记
    .accept 282 >>接任务: 森内尔的观察站
step
    >>把一些暴徒赶到这里
    .goto Dun Morogh,33.5,71.8
    .turnin 282 >>交任务: 森内尔的观察站
    .accept 420 >>接任务: 森内尔的观察站
step
    .goto Dun Morogh,33.9,72.2
    .accept 2160 >>接任务: 塔诺克的补给品
step
    .goto Dun Morogh,34.1,71.6,20,0
    .goto Dun Morogh,35.7,66.0,20 >>穿过隧道
step
    #sticky
    #completewith BoarMeat44
    >>杀死野猪，获得4块野猪肉供日后食用
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
step
    #sticky
    #completewith Ribs
    >>杀死野猪以获得6根野猪肋骨供日后使用
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step
    >>将野猪磨碎，东北至哈拉诺斯
    .goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2415>>提升经验到2415/+2800xp
step
    #softcore
    .goto Dun Morogh,47.0,55.1,120 >>在精神疗愈者处死亡并重生，或者跑向哈拉诺斯。确保你的分区不是Coldridge Pass
step
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >>交任务: 森内尔的观察站
step
    #completewith next
    .goto Dun Morogh,46.7,53.5
    .vendor >>供应商垃圾
step
    .goto Dun Morogh,46.8,52.4
    .accept 384 >>接任务: 啤酒烤猪排
step
    .goto Dun Morogh,48.3,57.0
    .xp 6 >>升级到6
step
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >>交任务: 塔诺克的补给品
step
    >>楼上的
    .goto Dun Morogh,47.5,52.1
    .trainer >>训练你的职业咒语
step
    .goto Dun Morogh,47.4,52.5
    .home >>将您的炉石设置为Thunderbrew酒厂
    .vendor >>尽可能多地购买5级饮料
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >>接任务: 贝尔丁的工具
step
    .goto Dun Morogh,49.4,48.4
    >>不要在途中杀死熊
    .accept 317 >>接任务: 贝尔丁的补给
step
    .goto Dun Morogh,49.6,48.6
    .accept 313 >>接任务: 灰色洞穴
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >>交任务: 贝尔丁的工具
step
    #label BoarMeat44
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >>接任务: 海格纳的弹药
step
    .goto Dun Morogh,52.0,50.1,40,0
    .goto Dun Morogh,51.5,53.9,40,0
    .goto Dun Morogh,50.1,53.9,40,0
    .goto Dun Morogh,49.9,50.9,40,0
    .goto Dun Morogh,48.0,49.5,40,0
    .goto Dun Morogh,48.2,46.9,40,0
    .goto Dun Morogh,43.5,52.5,40,0
    .goto Dun Morogh,52.0,50.1,40,0
    .goto Dun Morogh,51.5,53.9,40,0
    .goto Dun Morogh,50.1,53.9,40,0
    .goto Dun Morogh,49.9,50.9,40,0
    .goto Dun Morogh,48.0,49.5,40,0
    .goto Dun Morogh,48.2,46.9,40,0
    .goto Dun Morogh,43.5,52.5,40,0
    .goto Dun Morogh,52.0,50.1,40,0
    .goto Dun Morogh,51.5,53.9,40,0
    .goto Dun Morogh,50.1,53.9,40,0
    .goto Dun Morogh,49.9,50.9,40,0
    .goto Dun Morogh,48.0,49.5,40,0
    .goto Dun Morogh,48.2,46.9,40,0
    .goto Dun Morogh,43.5,52.5,40,0
    .goto Dun Morogh,52.0,50.1,40,0
    .goto Dun Morogh,51.5,53.9,40,0
    .goto Dun Morogh,50.1,53.9,40,0
    .goto Dun Morogh,49.9,50.9,40,0
    .goto Dun Morogh,48.0,49.5,40,0
    .goto Dun Morogh,48.2,46.9,40,0
    .goto Dun Morogh,43.5,52.5,40,0
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
    .complete 317,2 --Collect Thick Bear Fur (x2)
step
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >>交任务: 贝尔丁的补给
    .accept 318 >>接任务: 艾沃沙酒
step
    >>回客栈去
    .goto Dun Morogh,46.9,52.1,20,0
    .goto Dun Morogh,47.4,52.5
    .vendor >>尽可能多地购买5级饮料
    >>如果你想的话，你可以在客栈外面买一把剥皮刀，在你获得+属性武器之前，它比棍子更好
step
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    >>到洞里去。杀死Wendigos。掠夺他们的鬃毛
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    >>掠夺板条箱
    .goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Collect Rumbleshot's Ammo (x1)
step
    #label BearFur
    .goto Dun Morogh,40.6,62.6,30,0
    .goto Dun Morogh,40.7,65.1
    .turnin 5541 >>交任务: 海格纳的弹药
    .vendor >>供应商和维修
step
    .xp 7 >>升级到7
step
    >>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,50,0
    .goto Dun Morogh,36.0,52.0,50,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >>接任务: 马克格拉恩的干肉
step
    .goto Dun Morogh,30.5,46.0
    .vendor >>小贩购买最多20杯5级饮料
step
    #sticky
    #label Evershine
    .goto Dun Morogh,30.2,45.8
    .turnin 318 >>交任务: 艾沃沙酒
    .accept 319 >>接任务: 艾沃沙酒
    .accept 315 >>接任务: 完美烈酒
step
    .goto Dun Morogh,30.2,45.5
    .accept 310 >>接任务: 针锋相对
step
    #label Ribs
    #requires Evershine
    .goto Dun Morogh,31.5,38.9,60,0
    .goto Dun Morogh,28.3,39.9,60,0
    .goto Dun Morogh,28.7,43.7,60,0
    .goto Dun Morogh,25.8,47.2,60,0
    .goto Dun Morogh,25.8,47.2,60,0
    .goto Dun Morogh,30.0,51.8,60,0
    .goto Dun Morogh,31.5,38.9,60,0
    .goto Dun Morogh,28.3,39.9,60,0
    .goto Dun Morogh,28.7,43.7,60,0
    .goto Dun Morogh,25.8,47.2,60,0
    .goto Dun Morogh,25.8,47.2,60,0
    .goto Dun Morogh,30.0,51.8,60,0
    >>杀死熊、野猪和豹子。从北->西->南走
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    >>完成野猪肋
    .complete 384,1 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,30.2,45.7
    .turnin 319 >>交任务: 艾沃沙酒
    .accept 320 >>接任务: 艾沃沙酒
step
    .isQuestTurnedIn 384
    .xp 7+4360>>提升经验到4360+/4500xp
step
    .xp 7+3735>>提升经验到3735+/4500xp
step
    .hs >>赫斯到哈拉诺斯
step
    .goto Dun Morogh,47.4,52.5
    >>从Belm购买狂想曲麦芽和雷霆啤酒
    .complete 384,2 --Collect Rhapsody Malt (x1)
    .collect 2686,1 --Collect Thunder Ale (x1)
step
    .goto Dun Morogh,47.6,52.4,10,0
    .goto Dun Morogh,47.71,52.69
    >>下楼去，然后和贾文谈谈，给他雷霆啤酒
    >>等待木桶鼠标移到“无人看守”位置，然后handin
    .turnin 310 >>交任务: 针锋相对
    .accept 311 >>接任务: 向马莱斯回报
step
    .goto Dun Morogh,46.8,52.4
    .turnin 384 >>交任务: 啤酒烤猪排
     >>当你下一个供应商时出售配方
step
    .xp 8 >>升级到8
step
    .goto Dun Morogh,47.5,52.1
    .trainer >>训练你的职业咒语
    >>确保训练变形
step
    .goto Dun Morogh,47.4,52.5
    .vendor >>从客栈老板那里购买最多30杯5级饮料
step
    .goto Dun Morogh,46.7,53.8
    .accept 287 >>接任务: 霜鬃巨魔要塞
step
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >>交任务: 灰色洞穴
step
    .goto Dun Morogh,49.4,48.4
    .turnin 320 >>交任务: 艾沃沙酒
step
    #era/som
    >>建筑物内部
    .goto Dun Morogh,45.8,49.4
    .accept 412 >>接任务: 自动净化装置
step
    .goto Dun Morogh,43.1,45.0,25,0
    .goto Dun Morogh,42.1,45.4,25 >>跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,30,0
    .goto Dun Morogh,41.5,43.6,30,0
    .goto Dun Morogh,39.7,40.0,30,0
    .goto Dun Morogh,42.1,34.3,30,0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线(LoS)在小屋后面。如果你运气不好，就跑到另一个地方去
    >>地面上的掠夺箱
    .complete 315,1 --Collect Shimmerweed (x6)
step
    >>变形老冰胡子，然后洗劫肉
    .goto Dun Morogh,38.5,53.9
    .complete 312,1 --Collect MacGrann's Dried Meats (x1)
step
    .goto Dun Morogh,34.6,51.7
    .turnin 312 >>交任务: 马克格拉恩的干肉
step
    .goto Dun Morogh,30.4,45.8
    .vendor >>最多再购买20杯5级饮料
step
    #sticky
    #label Stout
    .goto Dun Morogh,30.2,45.7
    .turnin 315 >>交任务: 完美烈酒
    .accept 413 >>接任务: 微光酒
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交任务: 向马莱斯回报
step
    #era/som
    #requires Stout
    .goto Dun Morogh,27.2,43.0,40,0
    .goto Dun Morogh,24.8,39.3,40,0
    .goto Dun Morogh,25.6,43.4,40,0
    .goto Dun Morogh,24.3,44.0,40,0
    .goto Dun Morogh,25.4,45.4,40,0
    >>杀死麻风侏儒。掠夺他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step
    .xp 9 >>升级到9
step
    .goto Dun Morogh,24.5,50.8,35 >>进入洞穴
step
    .goto Dun Morogh,22.1,50.3,40,0
    .goto Dun Morogh,21.3,52.9,40,0
    >>杀死洞穴内的猎头
    .complete 287,1 --Kill Frostmane Headhunter (x5)
step
    #hardcore
    >>小心地磨进洞里的这个角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #softcore
    .goto Dun Morogh,23.4,51.5,15 >>返回洞穴
step
    #softcore
    >>跳下去，你死后
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #softcore
    .deathskip >>在精神治疗师处死亡并重生
step
    #hardcore
   .goto Dun Morogh,46.7,53.8,150 >>如果没问题的话，就把炉子烧了，否则就要碾回哈拉诺斯
step
    .goto Dun Morogh,46.7,53.8
    .turnin 287 >>交任务: 霜鬃巨魔要塞
    .accept 291 >>接任务: 森内尔的报告
step
    #era/som
    .goto Dun Morogh,45.8,49.4
    .turnin 412 >>交任务: 自动净化装置
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,14,0
    .goto Dun Morogh,62.2,49.4,10 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
    >>把他引到牧场南边的守卫那里。确保你对他造成51%+的伤害
    >>小心，因为这个任务可能很困难
    .goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (1)
--N Video tutorial needed
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    >>途中磨碎一点
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商垃圾箱。如果需要，购买一些食物/水
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step
    .goto Dun Morogh,70.6,56.6,30,0
    .goto Dun Morogh,70.8,53.3,30,0
    .goto Dun Morogh,71.9,50.7,30,0
    .goto Dun Morogh,72.9,53.1,30,0
    .goto Dun Morogh,70.6,56.6,30,0
    .goto Dun Morogh,70.8,53.3,30,0
    .goto Dun Morogh,71.9,50.7,30,0
    .goto Dun Morogh,72.9,53.1,30,0
    >>在山洞里杀死Troggs
    .complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step
    .goto Dun Morogh,67.1,59.7,40,0
    .goto Dun Morogh,70.7,58.2,40,0
    .goto Dun Morogh,71.0,53.9,40,0
    .xp 10 >>在拖架上升级到10
step
    .goto Dun Morogh,68.6,54.7
    .vendor >>小贩垃圾，从喀山购买最多30杯5级饮料
    .trainer >>Ghilm的火车烹饪。你需要这个来接2个额外任务
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>途中研磨
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >>交任务: 驾驶员的复仇
step
    >>从你来的地道回去
    .goto Dun Morogh,79.6,50.7,50,0
    .goto Dun Morogh,82.3,53.5,25,0
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >>交任务: 微光酒
    .accept 414 >>接任务: 卡德雷尔的酒
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance Mage
#name 10-12 洛克莫丹 法师 AoE
#version 1
#group RestedXP 联盟 法师
#defaultfor Human Mage/Gnome Mage
#next 12-18 黑海岸 法师 AoE
step
    #era/som
    #completewith next
    +当你在莫丹湖寻找时，保存你得到的所有大块野猪肉，不要出售。你以后需要它
step << Gnome
    .goto Loch Modan,22.1,73.1
    .accept 224 >>接任务: 保卫国王的领土
step << Gnome
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .accept 267 >>接任务: 穴居人的威胁
step << Gnome
    .goto Loch Modan,29.9,68.2,45 >>跑到Troggs入口
step << Gnome
    .goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    .goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    >>杀死石刺怪。抢走他们的牙齿
    >>小心，因为这个任务可能很困难。如果你一次误拉2个暴徒，就逃跑
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step << Gnome
    .goto Loch Modan,22.1,73.1
    .turnin 224 >>交任务: 保卫国王的领土
step << Gnome
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .turnin 267 >>交任务: 穴居人的威胁
step << Human
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step << Human
    .goto Loch Modan,24.8,18.4
    .turnin 353 >>交任务: 雷矛的包裹
    .accept 307 >>接任务: 肮脏的爪子
step << Human
    #sticky
    #completewith next
    >>在蜘蛛一角的区域内杀死蜘蛛
    .collect 3174,3 --Collect Spider Ichor (x3)
    >>在熊肉区杀死熊
    .collect 3173,3 --Collect Bear Meat (x3)
    >>在野猪肠道区域杀死野猪
    .collect 3172,3 --Collect Boar Intestines (x3)
step << Human
    .goto Loch Modan,35.1,47.8,130 >>在途中碾碎暴徒，以便稍后进行烹饪任务
step
    >>跑向塞尔斯马尔。不要放炉子 << Gnome
    .goto Loch Modan,34.8,49.3
    .accept 418 >>接任务: 塞尔萨玛血肠
step << Human
    #sticky
    .abandon 1338 >>放弃Stormpike的命令。这是为了解锁登山者Stormpike的任务
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买1-2个6槽袋，填充您的袋槽
step
    .goto Loch Modan,35.5,48.4
    .vendor >>购买食物/水(尝试喝40杯5级饮料，20杯5级食物)
step
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
step << Gnome
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step << Gnome
    .goto Loch Modan,24.8,18.4
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
    .accept 1338 >>接任务: 卡尔·雷矛的订单
    .accept 307 >>接任务: 肮脏的爪子
step << Gnome
    #label Thelsamar1
    .goto Loch Modan,33.71,17.20,130 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step << Human
    #label Thelsamar1
    .goto Loch Modan,39.3,27.0,130 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
    #sticky
    #completewith Gear
    >>杀死隧道老鼠。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
step
    .goto Loch Modan,35.5,18.2,45 >>去洞口杀老鼠
step
    #label Gear
    .goto Loch Modan,35.5,19.9,12,0
    .goto Loch Modan,36.4,20.7,12,0
    .goto Loch Modan,35.3,22.0,12,0
    .goto Loch Modan,35.9,22.1,12,0
    .goto Loch Modan,36.3,24.7,12,0
    .goto Loch Modan,35.7,24.3,12,0
    .goto Loch Modan,34.9,24.9,12,0
    .goto Loch Modan,35.7,24.3,12,0
    .goto Loch Modan,36.3,24.7,12,0
    .goto Loch Modan,35.9,22.1,12,0
    .goto Loch Modan,35.3,22.0,12,0
    .goto Loch Modan,36.4,20.7,12,0
    .goto Loch Modan,35.5,19.9,12,0
    >>收集你在山洞里找到的板条箱。小心，因为这在11级很难做到
    >>几秒钟后，当Geomangers施放火焰防护(Fire Immunity)时要小心
    .complete 307,1 --Collect Miners' Gear (x4)
step
    .goto Loch Modan,39.43,22.58
    >>杀死隧道老鼠。抢走他们的耳朵
    >>试着杀死害虫，而不是Kobolds/Geomangers
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
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
    .goto Loch Modan,23.3,17.9,60 >>跑回沙坑，途中碾磨
step
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.7,18.3
    .turnin 307 >>交任务: 肮脏的爪子
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务 << Human
    .accept 1338 >>接任务: 卡尔·雷矛的订单 << Human
step
    #sticky
    #label Meat9
    .goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
    .goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
    .goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #label Ichor9
    .goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
    .goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
    .goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
    .goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #requires Meat9
step
    #sticky
    #label RatCatching
    #requires Ichor9
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 416 >>交任务: 狗头人的耳朵
step
    #requires Ichor9
    .goto Loch Modan,34.8,49.3
    .turnin 418 >>交任务: 塞尔萨玛血肠
step
    #era/som
    .goto Loch Modan,34.76,48.62
    .vendor >>购买6个插槽，直到您的袋子装满。还需购买1块Flint and Tinder和2块Simple Wood
    .collect 4470,2 --Simple Wood (2)
    .collect 4471,1 --Flint and Tinder (1)
step
    .xp 12 >>升级到12
step << Gnome
    #completewith next
    #requires RatCatching
    .goto Loch Modan,64.82,66.04
    .vendor >>检查奥尔德伦的智者腰带。如果你买得起就买。保存以备以后使用
step << Gnome
    #requires RatCatching
    .goto Loch Modan,65.94,65.62
    .accept 298 >>接任务: 挖掘进度报告
step << Gnome
    #softcore
    .goto Loch Modan,68.12,62.98
    .deathskip >>死亡并重生回塞尔萨马尔
step << Gnome
    #hardcore
    >>跑回塞尔斯马尔。进入大楼
    .goto Loch Modan,37.16,46.89,20,0
    .goto Loch Modan,37.02,47.81
    .accept 6387 >>接任务: 荣誉学员
    .turnin 298 >>交任务: 挖掘进度报告
    .accept 301 >>接任务: 向铁炉堡报告
step << Gnome
    #softcore
    >>进入大楼
    .goto Loch Modan,37.16,46.89,20,0
    .goto Loch Modan,37.02,47.81
    .accept 6387 >>接任务: 荣誉学员
    .turnin 298 >>交任务: 挖掘进度报告
    .accept 301 >>接任务: 向铁炉堡报告
step
    #requires RatCatching
    .goto Loch Modan,33.94,50.96
    .fp Thelsamar >>获取Thelsamar飞行路线
    .turnin 6387 >>交任务: 荣誉学员 << Gnome
    .accept 6391 >>接任务: 飞往铁炉堡 << Gnome
    .fly Ironforge >>飞往铁炉堡
step << Human
    .goto Ironforge,27.15,8.57
    .trainer >>训练你的职业咒语
step << Human
    #completewith next
    +朝房间后面圣骑士训练师后面的楼梯走去。往上走一半，然后移动到楼梯边缘，直到看起来你在漂浮。注销，然后重新登录
    .link https://www.youtube.com/watch?v=E8b90bzJMSI >>单击此处以供参考
    >>注销跳转到铁炉堡前面
step << Human
    .goto Ironforge,12.24,89.17,120 >>退出铁炉堡
step << Gnome
    .goto Ironforge,74.65,11.74
    .turnin 301 >>交任务: 向铁炉堡报告
    .accept 302 >>接任务: 铁环的火药
step << Gnome
    >>返回大熔炉，然后向右拐，进入大楼
    .goto Ironforge,49.59,28.96,30,0
    .goto Ironforge,51.52,26.32
    .turnin 6391 >>交任务: 飞往铁炉堡
    .accept 6388 >>接任务: 格莱斯·瑟登
step << Gnome
    .goto Ironforge,39.55,57.49
    .turnin 291 >>交任务: 森内尔的报告
step << Gnome
    .goto Ironforge,55.50,47.74
    .turnin 6388 >>交任务: 格莱斯·瑟登
    .accept 6392 >>接任务: 向布洛克回复
    .fly Thelsamar >>飞往塞尔斯马尔
step << Gnome
    >>进入大楼
    .goto Loch Modan,37.16,46.89,20,0
    .goto Loch Modan,37.02,47.81
    .turnin 6392 >>交任务: 向布洛克回复
    .turnin 302 >>交任务: 铁环的火药
step << Gnome
    .hs >>赫斯到哈拉诺斯
step << Gnome
    .goto Dun Morogh,47.50,52.08
    .trainer >>训练你的职业咒语
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
    .goto Dun Morogh,30.3,37.5,50 >>跑到这里
step
    #softcore
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
    .deathskip >>继续向北奔跑，摔倒死亡，然后重生
step
    #softcore
    #completewith next
    .goto Wetlands,12.7,46.7,60 >>游到岸上
step
    .money <0.08
    .goto Wetlands,10.4,56.0,15,0
    .goto Wetlands,10.1,56.9,15,0
    .goto Wetlands,10.6,57.2,15,0
    .goto Wetlands,10.7,56.8
    .vendor >>如果你有8s，检查Neal Allen的铜管，如果有就买
step
    .money <0.04
    .goto Wetlands,8.1,56.3
    .vendor >>检查Dewin的治疗药剂，购买时间减至1秒
step
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >>获取Menethil Harbor航线
step
    #era/som
    #sticky
    #completewith Darkshore1
    +在这里等船。从你的魔法书中烧一堆野营火，开始煮你早先省下的大块野猪肉。你现在至少需要10项技能，以后需要50项技能(所以全部都要做)
    .goto Wetlands,4.7,57.3
step
    #era/som
    #label Darkshore1
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸, 等待时制造尽可能多的食物
step
    #som
    #phase 3-6
    #label Darkshore1
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸, 等待时制造尽可能多的食物
]])

