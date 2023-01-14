RXPGuides.RegisterGuide([[
#classic
<< Alliance Mage
#name 12-18 黑海岸 法师 AoE
#version 1
#group RestedXP 联盟 法师
#defaultfor Alliance Mage
#next 18-21 赤脊山 法师 AoE

step
    #completewith next
    .goto Darkshore,36.77,44.28
    .vendor >>你可以从Laird(鱼贩)那里购买极便宜的5级食物
step
    >>上楼到顶层
    .goto Darkshore,36.98,44.14
    .accept 983 >>接任务: 传声盒827号
step
    >>跳到一楼
    .goto Darkshore,37.04,44.13
    .home >>将您的炉石设置为Auberdine
step
    .goto Darkshore,37.32,43.64
    .accept 947 >>接任务: 洞中的蘑菇
step
    .goto Darkshore,37.68,43.38
    .accept 4811 >>接任务: 红色水晶
step
    .goto Darkshore,38.84,43.41
    .accept 2118 >>接任务: 瘟疫蔓延
step
    .goto Darkshore,39.37,43.49
    .accept 984 >>接任务: 熊怪的威胁
step
    .goto Darkshore,36.62,45.59
    .accept 3524 >>接任务: 搁浅的巨兽
step
    .goto Darkshore,36.34,45.58
    .fp Auberdine >>获取奥伯丁飞行路线
step
    #completewith Bear
     >>杀死沿海的爬虫
    .complete 983,1 --Crawler Leg (6)
step
    .goto Darkshore,36.38,50.88
     >>掠夺海洋生物
    .complete 3524,1 --Sea Creature Bones (1)
step
    #sticky
    #completewith next
    >>找到一只狂犬病蓟熊。Aggro一号，在你的包里使用塔纳瑞恩的希望(紫色球体)
    .complete 2118,1 --Rabid Thistle Bear Captured (1)
step
    .goto Darkshore,39.01,53.70
     >>前往附近的弗堡营地
    .complete 984,1 --Find a corrupt furbolg camp (1)
step
    #label Bear
    >>找到一只狂犬病蓟熊。Aggro一号，在你的包里使用塔纳瑞恩的希望(紫色球体)
    .goto Darkshore,38.47,57.92
    .complete 2118,1 --Rabid Thistle Bear Captured (1)
step
    .goto Darkshore,36.61,54.29,150,0
    .goto Darkshore,36.10,44.42
    >>杀死沿海的爬虫
    .complete 983,1 --Crawler Leg (6)
step
    #sticky
    #completewith ReadAndy
     >>节省漫游者肉x5供日后食用
    .collect 5469,5,2178,1
step
    .goto Darkshore,36.66,46.26
    .turnin 983 >>交任务: 传声盒827号
    .accept 1001 >>接任务: 传声盒411号
step
    .goto Darkshore,36.62,45.59
    .turnin 3524 >>交任务: 搁浅的巨兽
    .accept 4681 >>接任务: 搁浅的巨兽
step
    .goto Darkshore,36.73,44.06,40,0
    >>跑到码头
    .goto Darkshore,35.74,43.70
    .accept 963 >>接任务: 永志不渝
step
    #sticky
    #completewith Thundris
     >>杀死海里的黑暗海岸脱粒鸟
    .complete 1001,1 --Thresher Eye (3)
step
    #completewith next
    .goto Darkshore,33.70,42.45,60 >>跑到码头，然后在十字路口跳入水中
step
    .goto Darkshore,31.86,46.33
    >>点击水下的海龟头
    .complete 4681,1 --Sea Turtle Remains (1)
step
    .goto Darkshore,36.62,45.59
    >>在返回海岸的途中杀死脱粒者
    .turnin 4681 >>交任务: 搁浅的巨兽
step
    .goto Darkshore,38.84,43.41
    .turnin 2118 >>交任务: 瘟疫蔓延
    .accept 2138 >>接任务: 清除疫病
step
    .goto Darkshore,39.37,43.49
    .turnin 984 >>交任务: 熊怪的威胁
    .accept 985 >>接任务: 熊怪的威胁
    .accept 4761 >>接任务: 桑迪斯·织风
step
    >>杀死分叉
    .goto Darkshore,39.83,56.11
    .goto Darkshore,39.74,53.76,0
    .complete 985,1 --Blackwood Pathfinder (8)
    .complete 985,2 --Blackwood Windtalker (5)
step
    .goto Darkshore,39.37,43.48
    .turnin 985 >>交任务: 熊怪的威胁
    .accept 986 >>接任务: 丢失的主人
step
    >>上楼去
    .goto Darkshore,39.04,43.55
    .accept 965 >>接任务: 奥萨拉克斯之塔
step
    .goto Darkshore,38.11,41.16
    .accept 982 >>接任务: 深不可测的海洋
step
    #label Thundris
    .goto Darkshore,37.39,40.13
    .turnin 4761 >>交任务: 桑迪斯·织风
    .accept 4762 >>接任务: 壁泉河
    .accept 954 >>接任务: 巴莎兰
    .accept 958 >>接任务: 上层精灵的工具
step
     #label Threshers
     #sticky
     >>沿着海岸游泳，杀死脱粒鱼
    .complete 1001,1 --Thresher Eye (3)
step
    .goto Darkshore,38.93,29.33,40,0
    .goto Darkshore,38.23,28.79
     >>通过船体上的孔进入第一艘船，然后到船的最底层的后面
    .complete 982,1 --Silver Dawning's Lockbox (1)
step
    #requires Threshers
    .goto Darkshore,40.30,27.69,40,0
    .goto Darkshore,39.63,27.45
     >>通过船体上的孔进入第二艘船，然后到船的最底层的后面
    .complete 982,2 --Mist Veil's Lockbox (1)
step
    .goto Darkshore,41.96,28.64
    .turnin 1001 >>交任务: 传声盒411号
    .accept 1002 >>接任务: 传声盒323号
step
    .goto Darkshore,41.94,31.47
    .accept 4723 >>接任务: 搁浅的海洋生物
step
    .goto Felwood,27.70,10.03
    .turnin 954 >>交任务: 巴莎兰
    .accept 955 >>接任务: 巴莎兰
step
    .goto Felwood,29.13,12.34
     >>杀死格雷金斯。抢走他们的耳环
    .complete 955,1 --Grell Earring (8)
step
    .goto Felwood,27.70,10.03
    .turnin 955 >>交任务: 巴莎兰
    .accept 956 >>接任务: 巴莎兰
step
    .goto Felwood,29.60,12.52
     >>杀死萨特尔斯。掠夺他们以换取封印
    .complete 956,1 --Ancient Moonstone Seal (1)
step
    .goto Felwood,27.70,10.03
    .turnin 956 >>交任务: 巴莎兰
    .accept 957 >>接任务: 巴莎兰
step
    #sticky
    #completewith ReadAndy
     >>杀死任何类型的登月者。掠夺他们的毒牙
    .complete 1002,1 --Moonstalker Fang (6)
--N don't think unitscan is needed
step
    #sticky
    #completewith ReadAndy
    >>杀死你看到的狂犬病蓟熊。在他们给你狂犬病(debuff)之前，至少有50%的法力值并用核弹攻击他们
    .complete 2138,1 --Rabid Thistle Bear (20)
step
    .goto Darkshore,50.77,25.43
    >>使用袋子中的空采样管
    .complete 4762,1 --Cliffspring River Sample (1)
step
    #sticky
    #completewith ReadAndy
    +把你抢来的小鸡蛋存起来，以便以后烹饪更上一层楼。把你得到的所有轻羽毛留到以后
step
    .goto Darkshore,47.11,48.63
     >>跑到山上的红水晶
    .complete 4811,1 --Locate the large, red crystal on Darkshore's eastern mountain range (1)
step
    #label ReadAndy
    .goto Darkshore,40.30,59.73
    .accept 953 >>接任务: 亚米萨兰的毁灭
step
    #sticky
    #label anaya
    .goto Darkshore,42.29,60.46,0
     >>杀死Anaya Dawnrunner。她在Ameth’Aran市中心巡逻
    .complete 963,1
    .unitscan ANAYA DAWNRUNNER
step
    #label ghosts
    #sticky
    .goto Darkshore,42.66,61.90,0
     >>杀死鬼魂。掠夺他们的文物
    .complete 958,1 --Highborne Relic (7)
step
    .goto Felwood,25.98,40.62
     >>点击地面上的平板电脑
    .complete 953,2 --Read the Fall of Ameth'Aran (1)
step
    .goto Felwood,25.66,39.11
     >>点击露台上的绿色火炬
    .complete 957,1 --Destroy the seal at the ancient flame (1)
step
    .goto Felwood,26.71,35.53
     >>点击地面上的平板电脑
    .complete 953,1 --Read the Lay of Ameth'Aran (1)
step
    #requires ghosts
step
    #requires anaya
    .goto Darkshore,40.30,59.73
    .turnin 953 >>交任务: 亚米萨兰的毁灭
step
    .goto Darkshore,38.83,60.82
    >>完成杀死狂犬病蓟熊并获得漫游者肉
    .complete 2138,1 --Rabid Thistle Bear (20)
    .collect 5469,5,2178,1
step
    >>掠夺海龟
    .goto Darkshore,37.14,62.12
    .accept 4722 >>接任务: 搁浅的海龟
step
    >>掠夺海龟
    .goto Darkshore,36.02,70.79
    .accept 4728 >>接任务: 搁浅的海洋生物
step
    .hs >>奥伯丁之炉
step
    .goto Darkshore,38.84,43.42
    .turnin 2138 >>交任务: 清除疫病
    .accept 2139 >>接任务: 萨纳瑞恩的希望
step
    .goto Darkshore,38.11,41.17
    .turnin 982 >>交任务: 深不可测的海洋
    .vendor >>从Gorbold那里买一些温和的香料，直到你有足够的食物来煮你所有的鸡蛋
step
    .goto Darkshore,37.69,40.66
    >>确保你在烹饪方面有10分，否则你无法接受/提交任务
    .accept 2178 >>接任务: 炖陆行鸟
    .turnin 2178 >>交任务: 炖陆行鸟
step
    .goto Darkshore,37.40,40.13
    .turnin 958 >>交任务: 上层精灵的工具
    .turnin 4762 >>交任务: 壁泉河
    .accept 4763 >>接任务: 黑木熊怪的堕落
step
    .goto Darkshore,37.44,41.84
    .accept 729 >>接任务: 健忘的勘察员
step
    .goto Darkshore,37.71,43.36
    .turnin 4811 >>交任务: 红色水晶
    .accept 4812 >>接任务: 清洗水晶
step
    .goto Darkshore,37.78,44.06
     >>给月球井的空水管注满水
    .complete 4812,1
     >>在月光井装满空碗
    .collect 12347,1,4763,1
step
    #completewith next
    .goto Darkshore,36.83,43.91
    .vendor >>向Taldan购买15级饮料
step
    >>回到码头
    .goto Felwood,18.10,18.48
    .turnin 963 >>交任务: 永志不渝
step
    .goto Darkshore,36.09,44.93
    .accept 1138 >>接任务: 海中的水果
step
    .goto Darkshore,36.62,45.59
    .turnin 4722 >>交任务: 搁浅的海龟
    .turnin 4723 >>交任务: 搁浅的海洋生物
    .turnin 4728 >>交任务: 搁浅的海洋生物 << Gnome
step
    .goto Darkshore,47.32,48.70
     >>点击红色水晶
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step
    #sticky
    #label MoonstalkersF
     >>杀死任何类型的登月者。掠夺他们的毒牙
    .complete 1002,1 --Moonstalker Fang (6)
    .unitscan Moonstalker,Moonstalker Runt
step
    .goto Darkshore,44.18,36.29
    .turnin 957 >>交任务: 巴莎兰
step
    .goto Darkshore,50.66,34.98
    >>装备你的新魔杖
    >>从桶里抢了黑木谷物样本，然后向东南方向跑向邓母(不要与暴徒搏斗)
    .collect 12342,1 --Blackwood Grain Sample (1)
step
    .goto Darkshore,52.60,36.65,45,0
    >>杀死丹妈。小心，因为她的幼崽会把你打倒2秒钟
    >>升级到16，如果你在挣扎，请再试一次
    .goto Darkshore,51.48,38.26
    .complete 2139,1 --Den Mother (1)
step
    >>从桶里偷走黑木坚果样本
    .goto Darkshore,51.80,33.51
    .collect 12343,1 --Blackwood Nut Sample (1)
step
    >>从桶里偷走黑木果样本。一群暴徒会在你面前，以及在西部的小屋之间滋生，你可能不得不逃跑
    .goto Darkshore,52.85,33.42
    .collect 12341,1 --Blackwood Fruit Sample (1)
step
    >>使用篝火附近库存的填充清洁碗。这将使附近的所有熊变得友好。
    >>杀死在营地之间产卵的萨蒂尔，然后绕着火跑。从最大射程开始，因为他可能很难。掠夺杀死他后掉在地上的篮子
    .goto Darkshore,52.38,33.29
    .complete 4763,1 --Talisman of Corruption (1)
step
    #completewith next
    .goto Darkshore,54.98,32.79,35 >>前往瀑布上方的洞穴
step
    .goto Darkshore,55.66,34.89
     >>停留在洞穴的上部。如果顶部末端没有死亡帽，则从下面放下并取一个
     >>当你洗劫死亡帽时，洞口的第一个蓝色的应该已经复活了
    .complete 947,1 --Scaber Stalk (5)
    .complete 947,2 --Death Cap (1)
step
    .goto Darkshore,54.97,24.89
    .turnin 965 >>交任务: 奥萨拉克斯之塔
    .accept 966 >>接任务: 奥萨拉克斯之塔
step
    >>杀死黑股狂热分子。抢他们的羊皮纸
    .goto Darkshore,55.36,26.84
    .complete 966,1 --Worn Parchment (4)
step
    .goto Darkshore,54.97,24.89
    .turnin 966 >>交任务: 奥萨拉克斯之塔
    .accept 967 >>接任务: 奥萨拉克斯之塔
step
    #requires MoonstalkersF
    .goto Darkshore,53.11,18.16
    .accept 4727 >>接任务: 搁浅的海龟
step
    #sticky
    #completewith Turtles
     >>杀死沿海的珊瑚虫，不要特意完成这个任务-不要杀死4级以上的怪物
    .complete 1138,1 --Fine Crab Chunks (6)
step
    .goto Darkshore,51.38,24.19,25,0
    .goto Darkshore,51.29,24.53
    .turnin 1002 >>交任务: 传声盒323号
    .accept 1003 >>接任务: 传声盒525号
step
    #softcore
    #label Turtles
    >>让附近的一些墨洛克人活着，你接受这个任务后会死的
    .goto Darkshore,44.18,20.60
    .accept 4725 >>接任务: 搁浅的海龟
step
    #hardcore
    #label Turtles
    .goto Darkshore,44.18,20.60
    .accept 4725 >>接任务: 搁浅的海龟
step
    #softcore
    .deathskip >>在奥伯丁死亡并重生
step
    .goto Darkshore,37.40,40.13
    >>装备你的新魔杖
    .turnin 4763 >>交任务: 黑木熊怪的堕落
step
    .goto Darkshore,38.84,43.42
    .turnin 2139 >>交任务: 萨纳瑞恩的希望
step
    .goto Darkshore,37.71,43.36
    .turnin 4813 >>交任务: 水晶中的碎骨
step
    .goto Darkshore,37.32,43.64
    .turnin 947 >>交任务: 洞中的蘑菇
    .accept 948 >>接任务: 安努
step
    .goto Darkshore,37.23,44.23
     >>点击酒店外的通缉海报
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
    .isQuestComplete 1138
    .goto Darkshore,36.09,44.93
    .turnin 1138 >>交任务: 海中的水果
step
    #label end
    #requires bowl
    .goto Felwood,19.10,20.63
    .turnin 4727 >>交任务: 搁浅的海洋生物
    .turnin 4725 >>交任务: 搁浅的海龟
step
     #completewith Murkdeep
     >>杀死你找到的任何一个登月者陛下，如果你觉得舒服的话杀死所有的女族长。抢走他们的毛皮。它们与灰熊共享产卵。
    .complete 986,1 --Fine Moonstalker Pelt (5)
    .unitscan Moonstalker Sire,Moonstalker Matriarch
step
     #completewith Murkdeep
    .goto Darkshore,38.60,80.50,0
     >>杀死灰蓟熊。掠夺头皮
    .complete 1003,1 --Grizzled Scalp (4)
step
    .goto Darkshore,43.55,76.29
    .turnin 948 >>交任务: 安努
    .accept 944 >>接任务: 主宰之剑
step
    #completewith next
    .goto Darkshore,43.69,76.64
    .vendor >>从Tiyani购买15级水
step << Human
    >>掠夺残骸
    .goto Darkshore,35.97,70.90
    .accept 4728 >>接任务: 搁浅的海洋生物
step
    #label Murkdeep
    .goto Darkshore,36.52,76.55
    >>清除穆洛克营地，远离中心的篝火
    >>当你清理完所有东西后，移动到营地中心召唤默克迪普
    >>如果你幸运的话，Murkdeep可能已经在离海岸30码的西边了(如果之前有人死于他的话)。
    .complete 4740,1 --Murkdeep (1)
step
     >>杀死海岸上的螃蟹以获得优质螃蟹块
    .complete 1138,1 --Fine Crab Chunks (6)
step
    >>掠夺残骸
    .goto Darkshore,32.70,80.73
    .accept 4730 >>接任务: 搁浅的海洋生物
step
    >>掠夺残骸。要小心，因为甲壳虫会对闪电造成90点伤害，当它们的生命低于55%时，可以将电波完全治愈。这里的乌龟头有LoS
    >>始终给自己留一条逃生路线。潮汐计数器还不错，但要注意它们的低伤害中毒能力
    >>试着把你的治疗药水留到以后，尤其是你的大药水
    .goto Darkshore,31.70,83.72
    .accept 4731 >>接任务: 搁浅的海龟
step
    >>岛上的龟壳有LoS
    .goto Darkshore,31.22,85.56
    .accept 4732 >>接任务: 搁浅的海龟
step
    >>在它的颈部掠夺，小心隐藏在地形中的2个怪物(你只需要杀死3个怪物就可以掠夺这一个)
    .goto Darkshore,31.28,87.39
    .accept 4733 >>接任务: 搁浅的海洋生物
step
    .goto Darkshore,35.72,83.69
    .turnin 729 >>交任务: 健忘的勘察员
step
    .goto Darkshore,35.72,83.69
     >>这个任务非常困难。如果可以的话，可以和其他玩家一起玩。
     >>开始护送任务
    .accept 731 >>接任务: 健忘的勘察员
step
     >>护送探矿者返程
     >>让Remtravel攻击一切(因为暴徒需要攻击他才能攻击他)，然后用火球向暴徒射击
     >>Remtravel真的很软弱，所以试着把他从其他暴徒那里除掉
     >>当流浪汉产卵时，变形他没有攻击的那只，然后当它击中另一只时用核武器攻击它。在法师向探矿者发射火球后，首先变形法师，并在接近尾声时繁殖
     >>如果你第一次不能完成这个任务，就跳过它吧——这是一个技能密集型任务，也是一个非常幸运的任务。
     .complete 731,1 --Escort Prospector Remtravel (1)
step
     #completewith Glaive
     >>杀死你找到的任何一个登月者陛下，如果你觉得舒服的话杀死所有的女族长。抢走他们的毛皮。它们与灰熊共享产卵。
    .complete 986,1 --Fine Moonstalker Pelt (5)
    .unitscan Moonstalker Sire,Moonstalker Matriarch
step
    >>杀死平原漫游者。确保以后至少有一根轻羽毛
    .collect 17056,1 --Light Feather (1)
step
     #completewith next
    .goto Darkshore,38.60,80.50,0
     >>杀死灰蓟熊。掠夺头皮
    .complete 1003,1 --Grizzled Scalp (4)
step
    #sticky
    #completewith Therylune
    >>留心下面的力量。这是一个低下降率的免费任务
    .collect 5352,1,968 --Book: The Powers Below (1)
    .accept 968 >>接任务: 深渊之神
step
    #label Glaive
    .goto Darkshore,38.30,87.12
     >>进入大师的Glaive，清除中间祭坛周围的暴徒
    .complete 944,1
step
    #sticky
    #label TheryluneE
    .goto Darkshore,38.65,87.34
    .accept 945 >>接任务: 护送瑟瑞露尼
step
     >>把你库存的烤面包碗扔在地上
    .turnin 944 >>交任务: 主宰之剑
    .accept 949 >>接任务: 暮光之锤的营地
step
    .goto Darkshore,38.55,86.03
     >>点击底座顶部的书。小心，如果你已经开始，Therylune就不会跑掉
    .turnin 949 >>交任务: 暮光之锤的营地
    .accept 950 >>接任务: 向安努回复
step
    #label Therylune
    #requires TheryluneE
    >>完成护送任务
    >>当你杀死最后一个从冰川中出来的暴徒时，生一堆篝火，煮所有的肉/蛋，你仍然需要提高你的烹饪技能
    >>你需要50种烹饪技能才能在黑暗郡进行免费任务
    .complete 945,1 --Escort Therylune away from the Master's Glaive (1)
step
     #sticky
    #label MoonstalkerP
    .goto Darkshore,37.38,91.87,100,0
    .goto Darkshore,38.96,80.07,100,0
    .goto Darkshore,43.82,82.08,100,0
    .goto Darkshore,38.96,80.07,0
     >>杀死你找到的任何一个登月者陛下，如果你觉得舒服的话杀死所有的女族长。抢走他们的毛皮。它们与灰熊共享产卵
     >>如果你在产卵和堕落方面非常不幸，你可以跳过这个任务
    .complete 986,1 --Fine Moonstalker Pelt (5)
    .unitscan Moonstalker Sire,Moonstalker Matriarch
step
    .goto Darkshore,38.60,80.50
     >>杀死黑海岸南部周围的灰熊。掠夺头皮
    .complete 1003,1 --Grizzled Scalp (4)
step
    .goto Darkshore,41.40,80.56
    .turnin 1003 >>交任务: 传声盒525号
step
    #requires MoonstalkerP
    .goto Darkshore,43.55,76.29
    .turnin 950 >>交任务: 向安努回复
step
    #completewith next
    .goto Darkshore,43.69,76.63
    .vendor >>如果需要，从Tiyani购买食物/饮料
step
    >>接受Kerlonian护送任务。如果他不在，跳过这一步
    .goto Darkshore,44.40,76.42
    .accept 5321 >>接任务: 昏昏欲睡
step
    .isOnQuest 5321
    >>掠夺Kerlonian旁边的灰色小箱子
    .goto Darkshore,44.40,76.42
    .complete 5321,2 --Horn of Awakening (1)
step
    .isOnQuest 5321
    .goto Ashenvale,26.84,36.74
    >>向南跑到灰谷。把觉醒之角绑在你的酒吧里，当科隆尼安开始原地行走并睡着时使用它
    .complete 5321,1 --Escort Kerlonian Evershade to Maestra's Post (1)
step
    .isOnQuest 5321
    .goto Ashenvale,27.26,35.58
    .turnin 5321 >>交任务: 昏昏欲睡
step
    .goto Ashenvale,26.19,38.70
    .turnin 967 >>交任务: 奥萨拉克斯之塔
step
    #softcore
    >>沿着这条路向南跑。前往伊塞纳神社
    >>当你这样做的时候，开始打开网站解压缩工具，并选择你的角色。但目前还不能确认
    .goto Ashenvale,22.64,51.91
    .turnin 945 >>交任务: 护送瑟瑞露尼
step
    #hardcore
    >>沿着这条路向南跑。前往伊塞纳神社
    .goto Ashenvale,22.64,51.91
    .turnin 945 >>交任务: 护送瑟瑞露尼
step
    .hs >>奥伯丁之炉
step
    .goto Darkshore,36.09,44.93
    .turnin 1138 >>交任务: 海中的水果
step
    .goto Darkshore,36.62,45.60
    .turnin 4730 >>交任务: 搁浅的海洋生物
    .turnin 4731 >>交任务: 搁浅的海龟
    .turnin 4732 >>交任务: 搁浅的海龟
    .turnin 4733 >>交任务: 搁浅的海洋生物
step
    .goto Darkshore,37.73,43.38
    .turnin 4740 >>交任务: 通缉：莫克迪普！
step
    .isQuestComplete 986
    >>将任务的下一部分保留在任务日志中，以获得+3耐力斗篷。当你不再需要斗篷时，放弃任务
    .goto Darkshore,39.37,43.48
    .turnin 986 >>交任务: 丢失的主人
    .accept 993 >>接任务: 丢失的主人
step
    .goto Darkshore,37.44,41.84
    .turnin 731 >>交任务: 健忘的勘察员
    .isQuestComplete 731
step
    .goto Darkshore,37.44,41.84
    .accept 741 >>接任务: 健忘的勘察员
    .isQuestTurnedIn 731
step
    #completewith next
    .isOnQuest 741
    >>跑回码头。等待前往达纳苏斯的船到达
    .goto Darkshore,36.43,43.84,30,0
    .goto Darkshore,33.17,40.17,40
step
    .isOnQuest 741
    .zone Teldrassil >>前往: 泰达希尔
step
    .isOnQuest 741
    .goto Teldrassil,55.95,89.86,30 >>穿过紫色大门
step
    .isOnQuest 741
    .goto Darnassus,31.24,84.49
    .turnin 741 >>交任务: 健忘的勘察员
    .accept 942 >>接任务: 健忘的勘察员
step
    #softcore
    #completewith next
    +登出后，网站将离开埃尔文森林(就在暴风城外)。否则，乘船去米奈希尔，检查一下青铜管，然后一路飞到暴风城 << Human
    +登出后，网站将离开埃尔文森林(就在暴风城外)。否则，乘船去米奈希尔，检查一下青铜管，飞往铁炉堡，然后乘电车去暴风城 << Gnome
step
    #hardcore
    .goto Teldrassil,58.40,94.02
    .fp Teldrassil >>获取Teldrassil飞行路径
    .fly Auberdine >>飞往奥伯丁
step
    #hardcore
    .goto Darkshore,32.42,43.75,50,0
    .zone Wetlands >>前往: 湿地
step
    #hardcore
    #completewith next
    .money <0.08
    .goto Wetlands,10.4,56.0,15,0
    .goto Wetlands,10.1,56.9,15,0
    .goto Wetlands,10.6,57.2,15,0
    .goto Wetlands,10.7,56.8
    >>如果你有8s，检查Neal Allen的青铜管，如果有就买。否则，请跳过此步骤
    .collect 4371,1,175,1
step
    #hardcore
    .goto Wetlands,9.49,59.69
    .fly Ironforge >>飞往铁炉堡
step
    #hardcore
    #completewith next
    .goto Ironforge,56.23,46.83,0
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >>单击此处
step
    #hardcore
    .zone Stormwind City >>前往: 暴风城
step
    #completewith FlyAndy
    .goto StormwindClassic,55.21,7.04
    .vendor >>如果你没有，就买一个铜管
    >>这是一个限量供应项目，如果npc没有，请跳过此步骤
    .bronzetube
step << Human
    #label FlyAndy
    .goto Elwynn Forest,32.45,50.16
    .zone Elwynn Forest >>前往: 艾尔文森林
step << Gnome
    .goto Elwynn Forest,26.29,38.50
    .zone Stormwind City >>前往: 暴风城
step << Gnome
    #label FlyAndy
    >>跑进暴风城，找到飞行路线
    .goto StormwindClassic,57.62,59.48,50,0
    .goto StormwindClassic,66.27,62.13
    .fp Stormwind City >>获得暴风城飞行路线
step << Gnome
    .goto StormwindClassic,66.05,65.64,12,0
    .goto StormwindClassic,64.97,67.69,18 >>跑进白墙，跌落到小窗台上。小心。沿着它向暴风城的出口跑去
step
    >>跑进Goldshire Inn的楼上
    .goto Elwynn Forest,42.97,65.65,15,0
    .goto Elwynn Forest,43.81,66.46,15,0
    .goto Elwynn Forest,43.25,66.19
    .trainer >>训练你的职业咒语
step
    .goto Elwynn Forest,91.42,73.59,125,0
    .zone Redridge Mountains >>一路向东跑, 前往: 赤脊山, 在途中整理您的钥匙包, 确保您可以舒适地使用法术
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance Mage
#name 18-21 赤脊山 法师 AoE
#version 1
#group RestedXP 联盟 法师
#defaultfor Alliance Mage
#next 21-22 暮色森林 法师 AoE

step
    #sticky
    #completewith Gnolls
    +启动AoEing所需的任务怪物，按你看到的3+分组。
    >>如果需要，请在Redridge AoE部分的另一个选项卡中保持此教程打开：
    .link https://youtu.be/SxMc2GoP33c?t=56 >>单击此处
step
    >>与守卫帕克交谈。他在十字路口巡逻了一会儿
    .goto Elwynn Forest,99.05,72.15
    .accept 244 >>接任务: 豺狼人的入侵
step
    #sticky
    #label Gnolls
    .goto Redridge Mountains,30.74,59.99
    .turnin 244 >>交任务: 豺狼人的入侵
    .accept 246 >>接任务: 审时度势
step
    .goto Redridge Mountains,30.59,59.40
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线
step
    #requires Gnolls
    .goto Redridge Mountains,33.51,48.96
    .accept 20 >>接任务: 黑石氏族的威胁
step
    .goto Redridge Mountains,32.14,48.64
    .accept 125 >>接任务: 丢失的工具
step
    .goto Redridge Mountains,30.94,47.24
    .accept 118 >>接任务: 马掌
step
    >>市政厅内
    .goto Redridge Mountains,29.72,44.26
    .accept 91 >>接任务: 所罗门的律法
step
    .goto Redridge Mountains,29.99,44.45
    >>进入大楼
    .accept 120 >>接任务: 送往暴风城的信
step
    .goto Redridge Mountains,27.72,47.38
    .accept 127 >>接任务: 卖鱼
step
    .goto Redridge Mountains,26.75,46.42
    .accept 180 >>接任务: 通缉：范高雷中尉
step
    >>客栈内部
    .goto Redridge Mountains,27.09,45.65
    .accept 129 >>接任务: 免费的午餐
step
    .goto Redridge Mountains,27.01,44.82
    .home >>把你的炉子搬到莱克郡
step
    .goto Redridge Mountains,29.32,53.64
    .accept 3741 >>接任务: 希拉里的项链
step
    >>在水下寻找希拉里的项链。它在一片褐色的泥土里
    .goto Redridge Mountains,27.80,56.05,90,0
    .goto Redridge Mountains,26.56,50.63,90,0
    .goto Redridge Mountains,23.96,55.17,90,0
    .goto Redridge Mountains,19.16,51.75,90,0
    .goto Redridge Mountains,31.12,54.21,90,0
    .goto Redridge Mountains,34.03,55.34,90,0
    .goto Redridge Mountains,38.09,54.49,90,0
    .complete 3741,1 --Hilary's Necklace (1)
step
    #completewith next
    .goto Redridge Mountains,15.47,62.40,0
    +营地里的侏儒
step
    .goto Redridge Mountains,15.28,71.47
    .turnin 129 >>交任务: 免费的午餐
    .accept 130 >>接任务: 寻访草药师
step
    .goto Redridge Mountains,30.59,59.41
    .fly Stormwind >>飞到暴风城
step
    >>进入暴风城。去武器培训师那里
   .goto StormwindClassic,57.13,57.71
   .trainer >>训练1小时剑刃
step
    #softcore
    .goto StormwindClassic,53.62,59.76,30,0
    .goto StormwindClassic,55.25,7.08
    +去拍卖行。如果价格合理，请购买铜管
    >>如果这里没有或者它们太贵，你也可以潜在地从矮人区的Billibub买一个
    >>如果找不到，请跳过此步骤
    .bronzetube
step
    #hardcore
    .goto StormwindClassic,53.62,59.76,30,0
    .goto StormwindClassic,55.25,7.08
    .vendor >>查看矮人区的Billibub是否有铜管。如果有，就买一个
    .bronzetube
step
    .goto StormwindClassic,63.99,75.34
    .turnin 120 >>交任务: 送往暴风城的信
    .accept 121 >>接任务: 送往暴风城的信
step
    >>跑去Goldshire
    .goto Elwynn Forest,41.71,65.55
    .turnin 118 >>交任务: 马掌
    .accept 119 >>接任务: 回复弗纳
step
    >>跑到哨兵山
    .goto Westfall,56.33,47.52
    .accept 65 >>接任务: 迪菲亚兄弟会
step
    #completewith next
    #label hsLakeshire
    .hs Lakeshire >>如果一切都结束了，那就去莱克郡吧
step
    #completewith hsLakeshire
    #label WFFP
    .goto Westfall,56.55,52.65
    .fp Westfall >>获取Westfall飞行路线 << Gnome
    .fly Redridge >>飞到雷德里奇
step
    #requires WFFP
    .goto Redridge Mountains,30.97,47.27
    .turnin 119 >>交任务: 回复弗纳
    .accept 122 >>接任务: 雏龙的鳞片
    .accept 124 >>接任务: 豺狼人的乱吠
step
    >>进入要塞
    .goto Redridge Mountains,29.93,44.46
    .turnin 121 >>交任务: 送往暴风城的信
    .accept 143 >>接任务: 送往西部荒野的信
    .accept 91 >>接任务: 所罗门的律法
step
    >>进入客栈的顶层
    .goto Redridge Mountains,26.47,45.35
    .turnin 65 >>交任务: 迪菲亚兄弟会
    .accept 132 >>接任务: 迪菲亚兄弟会
step
    .goto Redridge Mountains,29.24,53.63
    .turnin 3741 >>交任务: 希拉里的项链
step
    #era/som
    #completewith Murlocs
    >>像你做其他任务一样，为Redridge Goulash研磨前3项。还可以得到足够的大块野猪肉来烹饪50道菜
    >>尽量把注意力集中在Goretusks上，不要真的担心蜘蛛肉
    .complete 92,1 --Great Goretusk Snout (5)
    .complete 92,2 --Tough Condor Meat (5)
    .complete 92,3 --Crisp Spider Meat (5)
step
    #completewith Murlocs
    >>杀死小龙。掠夺他们的鳞片
    .complete 122,1 --Underbelly Whelp Scale (6)
step
    >>AoE该地区的侏儒。如果需要，请参阅AoE视频
    >>在AoE拉绳过程中阻挡偷猎者，这样你就不会被射中
    .goto Redridge Mountains,29.51,84.17,50,0
    .goto Redridge Mountains,34.60,82.99,50,0
    .goto Redridge Mountains,43.44,71.11,50,0
    .goto Redridge Mountains,29.51,84.17,50,0
    .goto Redridge Mountains,34.60,82.99,50,0
    .goto Redridge Mountains,43.44,71.11,50,0
    .complete 246,1 --Redridge Mongrel (10)
    .complete 246,2 --Redridge Poacher (6)
step
    #label Murlocs
    >>AoE该地区的墨洛克人。你必须单目标瞄准潮汐骑士(闪电+治疗波)
    >>你可以攻击Shorestickers(冲锋)和Flesheaters(攻击几率造成25点即时生命偷窃)。创造性地拉动
    >>保存8个Fin供以后使用
    .goto Redridge Mountains,48.82,69.49
    .complete 127,1 --Spotted Sunfish (10)
    .complete 150,1 --Murloc Fin (8)
step
    #era/som
    >>从这一带买秃鹰肉和幼虾鳞。如果你在等待重生，那么向东去拿一些斧头，然后再回来
    .goto Redridge Mountains,61.04,77.55
    .complete 92,2 --Tough Condor Meat (5)
    .complete 122,1 --Underbelly Whelp Scale (6)
step
    #som
    #phase 3-6
    >>从这一带买幼崽秤。如果你在等待重生，那么向东去拿一些斧头，然后再回来
    .goto Redridge Mountains,61.04,77.55
    .complete 122,1 --Underbelly Whelp Scale (6)
step
    >>该地区的AoE兽人。掠夺他们的斧头。当领先者网和叛徒盾牌攻击时要小心。
    >>尽量避免杀死叛徒，因为他们的水平很高。一次最多拉动3个。这里的风险很高，回报中等
    >>还没有拿到所有的斧头，你以后有更好的机会完成它
    .goto Redridge Mountains,76.28,83.88,50,0
    .goto Redridge Mountains,75.53,73.36,50,0
    .goto Redridge Mountains,76.28,83.88,50,0
    .goto Redridge Mountains,75.53,73.36,50,0
    .collect 3014,8 --Battleworn Axe (8)
step
    >>潜水。掠夺灰色盒子
    .goto Redridge Mountains,41.52,54.68
    .complete 125,1 --Oslow's Toolbox (1)
step
    #era/som
    >>在这里干掉Goretusk鼻涕
    .goto Redridge Mountains,32.07,70.54
    .complete 92,1 --Great Goretusk Snout (5)
step
    .goto Redridge Mountains,30.74,60.00
    .turnin 246 >>交任务: 审时度势
step
    .isQuestComplete 20
    .goto Redridge Mountains,33.50,48.96
    .turnin 20 >>交任务: 黑石氏族的威胁
step
    .goto Redridge Mountains,32.14,48.63
    .turnin 125 >>交任务: 丢失的工具
    .accept 89 >>接任务: 止水湖上的桥
step
    .goto Redridge Mountains,30.98,47.27
    .turnin 122 >>交任务: 雏龙的鳞片
step
    #level 20
    .goto Redridge Mountains,27.72,47.38
    .turnin 127 >>交任务: 卖鱼
    .accept 150 >>接任务: 鱼人偷猎者
    .turnin 150 >>交任务: 鱼人偷猎者
step
    .goto Redridge Mountains,27.72,47.38
    .turnin 127 >>交任务: 卖鱼
step
    .goto Redridge Mountains,21.86,46.33
    .turnin 130 >>交任务: 寻访草药师
    .accept 131 >>接任务: 水仙诉衷情
    .accept 34 >>接任务: 不速之客
step
    >>杀死Bellygrub。风筝把她带回镇上的卫队亚当斯
    >>小心她颤抖(瞬间80度伤害)，并冲锋(如果可能的话，让她减速并保持新星状态)
    >>确保你造成大部分伤害(51%+)
    >>这个任务非常困难
    .goto Redridge Mountains,15.66,49.31
    .complete 34,1 --Bellygrub's Tusk (1)
--N Add link
step
    .goto Redridge Mountains,21.85,46.32
    .turnin 34 >>交任务: 不速之客
step
    .goto Redridge Mountains,21.23,36.17,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,39.61,31.46,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,21.23,36.17,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,39.61,31.46,60,0
    >>杀死侏儒。掠夺他们的长矛和铆钉
    .complete 89,1 --Iron Pike (5)
    .complete 89,2 --Iron Rivet (5)
    .complete 124,1 --Redridge Brute (10)
    .complete 124,2 --Redridge Mystic (8)
step
    #completewith next
    >>杀死堆叠整齐的兽人。掠夺他们以完成斧头
    >>如果你在清除接近的组后运气不好，你以后还有机会
    .goto Redridge Mountains,37.05,45.15,50,0
    .goto Redridge Mountains,38.28,41.85,50,0
    .goto Redridge Mountains,40.46,40.52,50,0
    .complete 20,1 --Blackrock Axe (10)
step
    #era/som
    #completewith next
    .goto Redridge Mountains,49.25,39.66,150 >>跑向蜘蛛
step
    #era/som
    >>杀死蜘蛛。抢他们的肉
    >>小心，他们的毒药会造成一些伤害
    >>小心Chatter(罕见)，因为他有8秒长的眩晕
    .goto Redridge Mountains,57.23,45.24
    .complete 92,3 --Crisp Spider Meat (5)
step
    >>为斧头杀死兽人
    .goto Redridge Mountains,61.74,42.82
    .complete 20,1 --Blackrock Axe (10)
step
    .goto Redridge Mountains,33.50,48.96
    .turnin 20 >>交任务: 黑石氏族的威胁
step
    .goto Redridge Mountains,32.15,48.64
    .turnin 89 >>交任务: 止水湖上的桥
step
    .goto Redridge Mountains,30.98,47.28
    .turnin 124 >>交任务: 豺狼人的乱吠
    .accept 126 >>接任务: 群山中的嚎叫
step
    .goto Redridge Mountains,27.09,45.65
    .turnin 131 >>交任务: 水仙诉衷情
step
    .goto Redridge Mountains,27.01,44.81
    .vendor >>购买15级饮料
step
    #era/som
    .goto Redridge Mountains,22.70,44.00
    >>离开客栈。向西走，然后进入大楼
    .accept 92 >>接任务: 赤脊山炖肉
    .turnin 92 >>交任务: 赤脊山炖肉
step
    #era/som
    #completewith next
    .goto Redridge Mountains,26.54,44.90
    +将所有野猪肉烹调至50种烹饪技巧
    >>如果你没有足够的肉，就在去达克郡的路上磨碎一些野猪
step
    .goto Redridge Mountains,6.50,91.18,90,0
    .zone Duskwood >>前往: 暮色森林
]])
