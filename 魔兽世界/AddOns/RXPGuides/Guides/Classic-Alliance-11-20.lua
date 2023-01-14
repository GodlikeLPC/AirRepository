RXPGuides.RegisterGuide([[
#classic
<< Alliance Hunter/NightElf
#name 11-16 黑海岸
#version 1
#group RestedXP 联盟 1-20
#next 16-19 黑海岸

step <<  NightElf
    .goto Teldrassil,56.25,92.44
    .turnin 6344 >>交任务: 尼莎·影歌
    .accept 6341 >>接任务: 泰达希尔的渔业
step <<  NightElf
    .goto Teldrassil,58.39,94.01
    .turnin 6341 >>交任务: 泰达希尔的渔业
    .accept 6342 >>接任务: 飞往奥伯丁
step <<  NightElf
     #completewith next
    .fly Auberdine >>飞到黑海岸
step <<  !NightElf
    .goto Felwood,19.10,20.63
    .fp Auberdine >>获取奥伯丁飞行路线
step
    .goto Felwood,19.10,20.63
    .accept 3524 >>接任务: 搁浅的巨兽
step <<  NightElf
    .goto Felwood,19.27,19.14
    .turnin 6342 >>交任务: 飞往奥伯丁
    >>跳过跟进
step
    .goto Darkshore,37.0,44.0
    .home >>将您的炉石设置为Auberdine
step
    .goto Felwood,19.51,18.97
    >>上楼去
    .accept 983 >>接任务: 传声盒827号
step
    .accept 2118 >>接任务: 瘟疫蔓延
    .goto Felwood,21.63,18.15
step
    .goto Felwood,22.24,18.22
    .accept 984 >>接任务: 熊怪的威胁
step <<  Dwarf Hunter
    #sticky
    .tame 2163 >>驯服一只蓟熊，他们可以打晕你，让你的宠物攻击他们，当他们对你的宠物使用眩晕时，抛弃你现在的宠物并开始驯服它
step
    #label crab1
    #sticky
     >>沿着海岸杀死螃蟹。
    .complete 983,1
step
    .goto Felwood,18.81,26.69
     >>掠夺海洋生物遗骸
    .complete 3524,1
step << Druid
    #completewith end
    >>将草药等级提升至15，并收集5个土生根供稍后任务使用
    .collect 2449,5
step
    .goto Felwood,22.39,29.45
     >>前往弗尔博格营地
     .complete 984,1
step
    >>找到一只狂犬病蓟熊。Aggro一号，在你的包里使用塔纳瑞恩的希望(紫色球体)
    .goto Darkshore,38.47,57.92
    .complete 2118,1
    .unitscan Rabid Thistle Bear
step
     .xp 12-1500 >>研磨怪物直到你离12级1500 xp
step
    #requires crab1
    .goto Felwood,19.13,21.39
    >>单击Buzzbox
    .turnin 983 >>交任务: 传声盒827号
step
	#era/som
	.goto Felwood,19.13,21.39
    .accept 1001 >>接任务: 传声盒411号
step
    .goto Felwood,19.10,20.63
    .turnin 3524 >>交任务: 搁浅的巨兽
    .accept 4681 >>接任务: 搁浅的巨兽
step
    .goto Felwood,18.10,18.48
    .accept 963 >>接任务: 永志不渝
step
	#era/som
    #sticky
    #completewith washed1
    .goto Darkshore,33.59,40.36,0
    .goto Darkshore,30.94,45.79,0
    .goto Darkshore,33.03,48.13,0
     >>开始研究Darkshore Threshers。
    .complete 1001,1
step
    #completewith next
    .goto Darkshore,33.70,42.45,60 >>跑到码头，然后在十字路口跳入水中
step
    .goto Felwood,13.63,21.44
    >>点击海龟遗骸
    .complete 4681,1
step
    #label washed1
    .goto Felwood,19.10,20.63
    .turnin 4681 >>交任务: 搁浅的巨兽
step
    .goto Felwood,19.90,18.40
    .accept 947 >>接任务: 洞中的蘑菇
step
    .goto Felwood,20.34,18.12
    .accept 4811 >>接任务: 红色水晶
step
    .goto Felwood,21.63,18.15
    .turnin 2118 >>交任务: 瘟疫蔓延
    .accept 2138 >>接任务: 清除疫病
step
    .goto Felwood,22.24,18.22
    .turnin 984 >>交任务: 熊怪的威胁
    .accept 985 >>接任务: 熊怪的威胁
    .accept 4761 >>接任务: 桑迪斯·织风
step <<  Dwarf/Gnome/Human
    .goto Felwood,20.80,15.58
    .accept 982 >>接任务: 深不可测的海洋
step
    #completewith next
    .goto Felwood,19.98,14.40
    .vendor >>如果需要，购买6个老虎袋
    >>用弹药填充你的箭袋/弹药袋。你还有很长的磨合期 << Hunter
step
    .goto Felwood,19.98,14.40
    .turnin 4761 >>交任务: 桑迪斯·织风
    .accept 4762 >>接任务: 壁泉河
    .accept 958 >>接任务: 上层精灵的工具
    .accept 954 >>接任务: 巴莎兰
step
	#era/som
    #sticky
    #label threshers
    .goto Darkshore,35.44,35.83,55,0
    .goto Darkshore,35.71,32.27,55,0
    .goto Darkshore,35.44,35.83,0
    .goto Darkshore,35.71,32.27,0
    .goto Darkshore,36.70,30.00,0
    .goto Darkshore,38.73,28.25,0
    .goto Darkshore,40.17,28.76,0
     >>杀死海里的黑暗海岸脱粒鸟
    .complete 1001,1
step << !NightElf
    .goto Felwood,20.94,1.49
    >>从船体上的洞进入第一艘船，在船底的水下洗劫箱子
    >>小心，因为这个任务可能很困难
    .complete 982,1
step << !NightElf
    .goto Darkshore,39.63,27.45
    >>通过船体上的孔进入第二艘飞船，在你发现第一个箱子的确切位置掠夺位于飞船上的箱子
    >>小心，因为这个任务可能很困难
    .complete 982,2
step
	#era/som
    #requires threshers
    .goto Felwood,25.19,1.29
    >>手伸进脱粒机的眼睛
    .turnin 1001 >>交任务: 传声盒411号
    .accept 1002 >>接任务: 传声盒323号
step
    .goto Felwood,25.15,4.61
    .accept 4723 >>接任务: 搁浅的海洋生物
step
    #completewith mbox
     >>杀死漫游者。掠夺他们以获取“漫游者肉”
    .collect 5469,5,2178,1
step
	#era/som
    #sticky
    #completewith mbox
     >>杀死任何类型的登月者
    .complete 1002,1
    .unitscan Moonstalker,Moonstalker Runt
step
    .goto Felwood,27.70,10.03
    .turnin 954 >>交任务: 巴莎兰
    .accept 955 >>接任务: 巴莎兰
step
    .goto Felwood,29.13,12.34
     >>杀死格雷金斯
    .complete 955,1
step
    .goto Felwood,27.70,10.03
    .turnin 955 >>交任务: 巴莎兰
    .accept 956 >>接任务: 巴莎兰
step
    .goto Felwood,29.60,12.52
     >>杀死萨提尔
    .complete 956,1
step
    .goto Felwood,27.70,10.03
    .turnin 956 >>交任务: 巴莎兰
    .accept 957 >>接任务: 巴莎兰
step
    .xp 13 >>升级到13级
step
    #completewith darn1 << Druid
     #completewith mbox << !Druid
     + Start collecting 9 small eggs for leveling cooking later
    >>你需要10点烹饪才能接受任务。如果你已经有10分了，跳过这一步
step
    .goto Felwood,31.29,24.14
     >>跑到山上的红水晶
     .complete 4811,1
step << Druid
    .goto Darkshore,43.5,45.9
    >>使用洞穴内的塞纳里奥月光石，击败卢纳克劳，并在之后与他的灵魂对话
    .complete 6001,1 --Defeat Lunaclaw (x1)
step << !Druid
	#era/som
     #completewith next
    .hs >>奥伯丁之炉
step
    .goto Felwood,20.34,18.12
    .turnin 4811 >>交任务: 红色水晶
    .accept 4812 >>接任务: 清洗水晶
step
    .goto Darkshore,37.78,44.06
     >>给月球井的空水管注满水
    .complete 4812,1
step <<  Hunter/Druid
    .goto Felwood,31.29,24.14
     >>点击红色水晶
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step <<  Hunter/Druid
    .goto Felwood,20.34,18.12
    .turnin 4813 >>交任务: 水晶中的碎骨
step << Druid
    #label darn1
    .goto Felwood,19.27,19.14
    .accept 6343 >>接任务: 飞回泰达希尔
step << Druid
    #era
    .goto Felwood,22.39,29.45
    .xp 14-1890 >>研磨直到距离14级1890xp
step << Druid
    #som
    .goto Felwood,22.39,29.45
    .xp 14-2645 >>研磨直到距离14级2645xp
step << Druid
    .fly Teldrassil>>飞往Teldrassil
step << Druid
    .goto Teldrassil,56.25,92.44
     >>返回Nessa
    .turnin 6343 >>交任务: 飞回泰达希尔
step << Druid
    .goto Darnassus,35.4,8.4
    .turnin 6001 >>交任务: 身心之力
    .accept 6121 >>接任务: 新的课程
    .trainer >>训练你的职业咒语
step << Druid
    .goto Moonglade,56.1,30.7
    >>前往: 月光林地
    .turnin 6121 >>交任务: 新的课程
    .accept 6122 >>接任务: 毒水之源
step << Druid
    .hs >>炉灶到Darkshore


step << !Hunter
     >>杀死分叉
    .goto Felwood,22.39,29.45
    .complete 985,1
    .complete 985,2
step
    .goto Darkshore,40.30,59.70
    .accept 953 >>接任务: 亚米萨兰的毁灭
step
    .goto Felwood,19.64,39.52
    .accept 4722 >>接任务: 搁浅的海龟
step
    #sticky
    #label anaya
     >>杀死Anaya Dawnrunner，她在Ameth’Aran巡逻
    .complete 963,1
    .unitscan ANAYA DAWNRUNNER
step
    #label ghosts
    #sticky
    .goto Darkshore,42.66,61.90,0
     >>杀死鬼魂
    .complete 958,1
step
    .goto Felwood,25.98,40.62
     >>点击地面上的平板电脑
    .complete 953,2
step
    .goto Felwood,25.66,39.11
     >>点击露台上的火炬
    .complete 957,1
step
    .goto Felwood,26.71,35.53
     >>点击地面上的平板电脑
    .complete 953,1
step
    #requires anaya
    .goto Felwood,23.29,36.73
    .turnin 953 >>交任务: 亚米萨兰的毁灭
step << Hunter
    #requires ghosts
     >>杀死分叉
    .goto Felwood,22.39,29.45
    .complete 985,1
    .complete 985,2
step << !Hunter
    #era
    #label xp15
    #requires ghosts
    .goto Felwood,22.39,29.45
    .xp 15 >>升级到15级
step <<  Hunter
    #label xp15
    #era
    .goto Felwood,22.39,29.45
    .xp 15.75 >>升级到15+75%
step
    #label xp15
    #som
    .goto Felwood,22.39,29.45
    .xp 15-3245 >>研磨，直到距离15级3245xp
step <<  !Hunter !Druid
    .goto Felwood,31.29,24.14
     >>点击红色水晶
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step
    .goto Felwood,22.24,18.22
    .turnin 985 >>交任务: 熊怪的威胁
    .accept 986 >>接任务: 丢失的主人
step
    .goto Felwood,21.86,18.30
     >>跑上楼去
    .accept 965 >>接任务: 奥萨拉克斯之塔
step <<  !Druid !Hunter
    .goto Darkshore,37.70,43.39
    .turnin 4813 >>交任务: 水晶中的碎骨
step << Druid
    .goto Felwood,19.27,19.14
    .accept 6343 >>接任务: 飞回泰达希尔
step
    .goto Felwood,18.10,18.48
    .turnin 963 >>交任务: 永志不渝
step << !Hunter
    .goto Felwood,19.10,20.63
    .turnin 4722 >>交任务: 搁浅的海龟
step
    .goto Felwood,18.50,19.87
    .accept 1138 >>接任务: 海中的水果
    >>如果你还未达到15级，请在飞行大师旁边提交海滩海龟任务 << Hunter
---?
step << NightElf
    .goto Felwood,20.80,15.58
    .accept 982 >>接任务: 深不可测的海洋
step << !NightElf
    .goto Felwood,20.80,15.58
    .turnin 982 >>交任务: 深不可测的海洋
step
    #completewith next
    .goto Felwood,20.80,15.58
    .vendor 6301 >>如果你在烹饪方面没有10分的话，买温和的香料，煮香草烤鸡蛋
step <<  NightElf
    .goto Felwood,19.98,14.40
    .turnin 958 >>交任务: 上层精灵的工具
step << !Druid !Hunter
    .goto Felwood,31.29,24.14
     >>点击红色水晶
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step << !Druid !Hunter
    .goto Felwood,27.70,10.03
    .turnin 957 >>交任务: 巴莎兰
step << NightElf
    .goto Felwood,20.94,1.49
    >>从船体上的洞进入第一艘船，在船底的水下洗劫箱子
    >>小心，因为这个任务可能很困难
    .complete 982,1
step << NightElf
    .goto Darkshore,39.63,27.45
    >>通过船体上的孔进入第二艘飞船，在你发现第一个箱子的确切位置掠夺位于飞船上的箱子
    >>小心，因为这个任务可能很困难
    .complete 982,2
step
    #sticky
    #completewith end1
    #label bears
     >>在穿越黑暗之城时杀死熊
    .complete 2138,1
step
    .goto Darkshore,44.18,20.60
    .accept 4725 >>接任务: 搁浅的海龟
step
    #sticky
    #completewith mbox
     >>杀死沿海的珊瑚虫，不要特意完成这个任务
    .complete 1138,1
step
    .goto Darkshore,50.81,25.50
     >>使用瀑布底部的空采样管
    .complete 4762,1
step
	#era/som
    #label mbox
    .goto Winterspring,1.42,26.89
     >>如果你没有足够的潜月者毒牙，跳过这一步
    .turnin 1002 >>交任务: 传声盒323号
    .accept 1003 >>接任务: 传声盒525号
step << NightElf Hunter/Druid
    .goto Winterspring,4.82,27.18
    .turnin 965 >>交任务: 奥萨拉克斯之塔
    .accept 966 >>接任务: 奥萨拉克斯之塔
step << NightElf Hunter/Druid
    .goto Winterspring,6.06,28.81
     >>杀死信徒
    .complete 966,1
step << NightElf Hunter/Druid
    .goto Winterspring,4.82,27.18
    .turnin 966 >>交任务: 奥萨拉克斯之塔
    .accept 967 >>接任务: 奥萨拉克斯之塔
step
    .goto Darkshore,50.72,30.35
    >>完成获得5块漫游者肉
    .collect 5469,5,2178,1
step
    #completewith next
    .goto Winterspring,5.49,36.64,35 >>前往瀑布上方的洞穴
step << Druid
    >>在洞口的水中使用悬崖泉瀑布采样器
    .goto Darkshore,54.80,33.16
    .complete 6122,1 --Filled Cliffspring Falls Sampler (1)
step
    #label end1
    .goto Darkshore,55.66,34.89
     >>停留在洞穴的上部。如果顶部末端没有死亡帽，则从下面放下并取一个
     >>当你洗劫死亡帽时，洞口的第一个蓝色的应该已经复活了
    .complete 947,1 --Scaber Stalk (5)
    .complete 947,2 --Death Cap (1)
step <<  NightElf !Druid
    #softcore
    #completewith next
     .deathskip >>研磨直到你的高速冷却时间<6分钟，然后死亡扭曲到奥伯丁
step <<  NightElf !Druid
    #hardcore
    #completewith next
     +研磨直到你的HS冷却时间<9分钟，然后跑回奥伯丁
step <<  !NightElf
     #completewith next
    .hs >>赫斯回到奥伯丁
step <<  !NightElf
    .goto Felwood,20.04,16.35
    .accept 729 >>接任务: 健忘的勘察员
step <<  !NightElf
    .goto Felwood,19.98,14.40
    .turnin 958 >>交任务: 上层精灵的工具
step
    .goto Darkshore,37.70,40.70
    .accept 2178 >>接任务: 炖陆行鸟
    .turnin 2178 >>交任务: 炖陆行鸟
    >>这个任务需要烹饪10分
step
    .goto Felwood,19.98,14.40
    .turnin 4762 >>交任务: 壁泉河
    .accept 4763 >>接任务: 黑木熊怪的堕落
step << Druid
    .goto Darkshore,37.7,40.7
    .turnin 6122 >>交任务: 毒水之源
    .accept 6123 >>接任务: 收集解药
step
    .goto Felwood,20.80,15.58
    .turnin 982 >>交任务: 深不可测的海洋
step
    .goto Felwood,20.34,18.12
    .turnin 4813 >>交任务: 水晶中的碎骨
step
    .goto Felwood,19.90,18.40
    .turnin 947 >>交任务: 洞中的蘑菇
    .accept 948 >>接任务: 安努
step
    .goto Felwood,19.78,19.07
     >>点击酒店外的通缉海报
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
    #sticky
    #label bowl
    .goto Darkshore,37.78,44.06
     >>在月光井装满空碗
    .collect 12347,1,4763,1
step <<  NightElf !Druid
    .goto Felwood,19.27,19.14
    .accept 6343 >>接任务: 飞回泰达希尔
step
    #label end
    #requires bowl
    .goto Felwood,19.10,20.63
    .turnin 4723 >>交任务: 搁浅的海洋生物
    .turnin 4725 >>交任务: 搁浅的海龟
    .turnin 4722 >>交任务: 搁浅的海龟 << Hunter
step <<  Druid
    .goto Felwood,22.39,29.45
    .xp 16
step << Druid
    .fly Teldrassil>>飞往Teldrassil
step << Druid
    .goto Darnassus,35.4,8.4
    .accept 26 >>接任务: 必修的课程
    .trainer >>训练你的职业咒语
step << Druid
    .goto Darnassus,66.0,60.6
    >>购买15级员工升级，如果您没有足够的钱购买，请跳过此步骤(56秒)
    .collect 2030,1
    .money <0.56
step << Druid
    .goto Teldrassil,23.70,64.51
    .accept 730 >>接任务: 黑海岸的麻烦事
step << Druid
    .goto Moonglade,56.1,30.7
    >>前往: 月光林地
    .turnin 26 >>交任务: 必修的课程
    .accept 29 >>接任务: 湖中试炼
step << Druid
    .goto Moonglade,52.6,51.6
    >>潜入湖中，寻找Shrine Bauble，它看起来像一个红色的小罐子
    .complete 29,1 --Complete the Trial of the Lake.
step << Druid
    .goto Moonglade,36.5,40.1
    .turnin 29 >>交任务: 湖中试炼
    .accept 272 >>接任务: 海狮试炼
step << Druid
    .hs >>炉灶到Darkshore
]])

RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance
#name 13-15 西部荒野
#version 1
#group RestedXP 联盟 1-20
#defaultfor !NightElf !Hunter
#next 14-19 黑海岸

step
    #sticky
    .zone Westfall >>前往: 西部荒野
step
    .goto Westfall,59.95,19.35
    .accept 64 >>接任务: 遗失的怀表
step
    .goto Westfall,59.91,19.41
    .accept 36 >>接任务: 杂味炖肉
    .accept 151 >>接任务: 老马布兰契
step
    .goto Westfall,56.10,31.30
    .accept 9 >>接任务: 清理荒野
step
    .goto Westfall,56.40,30.50
    .turnin 36 >>交任务: 杂味炖肉
    .accept 38 >>接任务: 杂味炖肉
    .accept 22 >>接任务: 猪肝馅饼
step << Human
    #sticky
    #label Lewis
    .goto Westfall,56.80,47.20
    .turnin 6285 >>交任务: 返回西部荒野
step << Gnome/Dwarf
    #completewith next
    .goto Westfall,56.40,47.60
    .turnin 109 >>交任务: 向格里安·斯托曼报到
    .isOnQuest 109
step
    .goto Westfall,56.40,47.60
    .accept 12 >>接任务: 西部荒野人民军
step
    #era
    .goto Westfall,56.40,47.60
    .accept 102 >>接任务: 西部荒野的豺狼人
step << Human
    #requires Lewis
    .goto Westfall,54.00,53.00
    .accept 153 >>接任务: 红色皮质面罩
step << !Human
    .goto Westfall,54.00,53.00
    .accept 153 >>接任务: 红色皮质面罩
step
    .goto Westfall,52.86,53.71
    .vendor >>从希瑟那里买食物。如果你有钱的话，买些15级的食物。记住这里的五级食物非常便宜 << Warrior/Rogue
    .vendor >>从希瑟那里买食物/水。如果你有钱的话，买些15级的食物/水。记住这里的五级食物非常便宜 << !Warrior !Rogue
step
    #sticky
    #label Oats
     >>收集分散在威斯特福尔的燕麦小包
    .complete 151,1 --Handful of Oats (8)
step
    #sticky
    #label Goretusks
    >>杀死你看到的秃鹫/野猪。掠夺他们以获取任务物品
    .complete 38,1 --Stringy Vulture Meat (3)
    .complete 38,3 --Goretusk Snout (3)
    .complete 22,1 --Goretusk Liver (8)
step
     >>杀死德菲亚斯。抢他们的头巾
    .goto Westfall,48.21,46.70,60,0
    .goto Westfall,46.74,52.87,60,0
    .goto Westfall,50.74,40.07,60,0
    .goto Westfall,46.21,38.26,60,0
    .goto Westfall,41.21,40.75,60,0
    .goto Westfall,44.57,26.09,60,0
    .goto Westfall,48.21,46.70
    .goto Westfall,41.21,40.75
    .complete 12,1
    .complete 12,2
    .complete 153,1
step
    .goto Westfall,49.30,19.20
    >>你可以从外面洗劫壁橱(如果你的相机角度正确的话)。小心Benny
    .complete 64,1 --Furlbrow's Pocket Watch
step
    #era
     #sticky
     #label Pawbs
    .goto Westfall,56.40,13.50,80,0
    .goto Westfall,42.82,14.70,80,0
    .goto Westfall,45.83,13.75,80,0
    .goto Westfall,52.36,14.82,80,0
    .goto Westfall,56.86,13.53,80,0
    .goto Westfall,56.86,13.53
    .goto Westfall,42.82,14.70
    .goto Westfall,52.36,14.82
    .goto Westfall,45.83,13.75
    >>杀死侏儒。掠夺他们的爪子。如果你运气不好，你可能需要在等待重生的同时杀死穆洛克斯
    .complete 102,1 --Gnoll Paw (8)
step
    #requires Oats
    .goto Westfall,56.40,9.40
    >>杀死穆洛克。抢走他们的眼睛
    .complete 38,2 --Murloc Eye (3)
step
    #era
    #requires Pawbs
    .goto Westfall,59.91,19.41
    .turnin 151 >>交任务: 老马布兰契
    .turnin 64 >>交任务: 遗失的怀表
step
    #som
    #requires Pawbs
    .goto Westfall,59.91,19.41
    .turnin 151 >>交任务: 老马布兰契
    .turnin 64 >>交任务: 遗失的怀表
step
    .goto Westfall,53.84,32.00,80,0
    .goto Westfall,50.80,21.76,80,0
    .goto Westfall,44.47,35.35,80,0
    .goto Westfall,53.84,32.00,80,0
    .goto Westfall,50.80,21.76,80,0
    .goto Westfall,44.47,35.35,80,0
    .goto Westfall,53.84,32.00
    .goto Westfall,44.47,35.35
    .goto Westfall,50.80,21.76
    >>杀死收成观察者。为秋葵抢走他们
    .complete 9,1 --Harvest Watcher (20)
    .complete 38,4 --Okra (3)
step
    #requires Goretusks
    .goto Westfall,56.00,31.30
    .turnin 9 >>交任务: 清理荒野
step
    .goto Westfall,56.40,30.50
    .turnin 38 >>交任务: 杂味炖肉
    .turnin 22 >>交任务: 猪肝馅饼
step
    .goto Westfall,56.30,47.50
    .turnin 12 >>交任务: 西部荒野人民军
step
    #completewith end
    .goto Westfall,56.30,47.50
    .accept 65 >>接任务: 迪菲亚兄弟会
    >>如果您尚未达到15级，请跳过此步骤
step
    #era
    .goto Westfall,56.30,47.50
    .turnin 102 >>交任务: 西部荒野的豺狼人
step
    .goto Westfall,54.00,52.90
    .turnin 153 >>交任务: 红色皮质面罩
step << Dwarf !Paladin/Gnome
    #label end
     #completewith next
    .hs >>炉灶回到Thelsamar
step << Dwarf !Paladin/Gnome
    #softcore
    .goto Loch Modan,33.94,50.95
    .fly Wetlands >>飞到湿地
step << Dwarf !Paladin/Gnome
    #hardcore
    #completewith next
    .goto Dun Morogh,59.5,42.8,150 >>前往跳跃点
step << Dwarf !Paladin/Gnome
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
    +打开此链接并在另一个屏幕上进行跟踪。
    >>邓莫罗不死->湿地跳过
    .link https://www.youtube.com/watch?v=9afQTimaiZQ >>单击此处以供参考
    .goto Wetlands,12.1,60.3,80 >>前往: 湿地
step << Human/Dwarf Paladin
    #label end
    .goto Westfall,56.6,52.6
    .fly Ironforge >>飞往铁炉堡
step << Human Warrior
    .goto Ironforge,62.0,89.6
    .train 176 >>火车抛锚
step << Dwarf Paladin
    .goto Ironforge,23.12,6.14
    .trainer >>训练你的职业咒语
step << Dwarf Paladin
    .goto Ironforge,23.6,8.5
    >>和楼上的缪尔登谈谈
    .turnin 1784 >>交任务: 圣洁之书
    .accept 1785 >>接任务: 圣洁之书
step << Dwarf Paladin
    .goto Ironforge,27.4,11.9
    .turnin 1785 >>交任务: 圣洁之书
step << Dwarf Paladin
    #softcore
    .goto Ironforge,55.5,47.7
    .fly Wetlands>>飞到湿地
step << Dwarf Paladin
    #hardcore
    .goto Dun Morogh,53.5,34.9
    .zone Dun Morogh>>退出铁炉堡
step << Human
    .goto Dun Morogh,53.5,34.9
    .zone Dun Morogh>>退出铁炉堡
--N add training before?
step << Human/Dwarf Paladin
    #hardcore
    #completewith next
    .goto Dun Morogh,59.43,42.85,150 >>前往跳跃点
step << Human/Dwarf Paladin
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
step << Human
    #softcore
    #completewith next
    .goto Dun Morogh,30.9,33.1,20 >>向北跑上山
step << Human
    #softcore
    .goto Dun Morogh,32.4,29.1,20 >>继续到这里
step << Human
    #softcore
    .goto Dun Morogh,33.0,27.2,20,0
    .goto Dun Morogh,33.0,25.2,20,0
    .goto Wetlands,11.6,43.4,60,0
    .deathskip >>继续向北奔跑，摔倒死亡，然后重生
step << Human
    #softcore
    .goto Wetlands,12.7,46.7,80 >>游到岸上
step
    .money <0.08
    .goto Wetlands,10.4,56.0,15,0
    .goto Wetlands,10.1,56.9,15,0
    .goto Wetlands,10.6,57.2,15,0
    .goto Wetlands,10.7,56.8
    .vendor >>如果你有8s，检查Neal Allen的铜管，如果有就买
step << Human/Dwarf Paladin
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >>获取Menethil Harbor航线
step
    .money <0.04
    .goto Wetlands,8.1,56.3
    .vendor >>在大楼里，查看Dewin是否有治疗药剂，购买时间减至1秒
step
    #completewith next
    +在这里等船。从你的魔法书中生一堆篝火，开始烹饪你早先保存下来的大块野猪肉。你现在最好需要10项技能
    .goto Wetlands,4.7,57.3
step
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸
    >>在等待船只的同时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance
#name 16-19 黑海岸
#version 1
#group RestedXP 联盟 1-20
#defaultfor Hunter/NightElf
#next 19-20 赤脊山 << !Hunter
#next 19-21 黑海岸/灰谷 << Hunter

step <<  NightElf !Druid
    #completewith next
    .goto Felwood,19.10,20.63
    .fly Teldrassil >>飞往Teldrassil
step <<  NightElf !Druid
    .goto Teldrassil,56.25,92.44
     >>返回Nessa
    .turnin 6343 >>交任务: 飞回泰达希尔
step << NightElf Warrior
    .goto Darnassus,58.72,34.92
    .trainer >>训练你的职业咒语
step << NightElf Warrior
    .goto Darnassus,57.6,46.6
    .train 176 >>火车抛锚
step <<  NightElf Hunter
    #completewith start
    .goto Darnassus,36.60,13.60
    .trainer  >>培训技能
step <<  NightElf Hunter
     #completewith start
    .goto Darnassus,63.30,66.30
    >>补充库存/再补给
    >>优先购买20级弓
    .collect 3027,1
    *Buy a level 16 bow if you have money to spare
step <<  NightElf !Druid
    .goto Teldrassil,23.70,64.51
    .accept 730 >>接任务: 黑海岸的麻烦事
step << NightElf Priest
    .goto Darnassus,37.88,82.73
    .trainer >>训练你的职业咒语
step << NightElf Rogue
    >>去塞纳里奥飞地
    .goto Darnassus,31.84,16.69,30,0
    .goto Darnassus,37.00,21.92
    .trainer >>训练你的职业咒语
step <<  NightElf !Druid
    #label start
    .hs >>赫斯回到奥伯丁
step
    .goto Felwood,19.78,19.07
     >>点击酒店外的通缉海报
    .accept 4740 >>接任务: 通缉：莫克迪普！
step << NightElf
     #completewith next
    .goto Felwood,20.04,16.35
    .turnin 730 >>交任务: 黑海岸的麻烦事
step
    .goto Felwood,20.04,16.35
     >>心不在焉的探矿者
    .accept 729 >>接任务: 健忘的勘察员
step
    .goto Felwood,19.98,14.40
    .turnin 4762 >>交任务: 壁泉河
    .accept 4763 >>接任务: 黑木熊怪的堕落
step
    #completewith xabraxxis
    .goto Darkshore,37.78,44.06
     >>在月光井装满空碗
    .collect 12347,1,4763,1
step
    .goto Felwood,18.50,19.87
    .accept 1138 >>接任务: 海中的水果
step
	#era/som
    #sticky
     >>完成Buzzbox 323
    .complete 1002,1
step << Druid
    #sticky
    #label earthroot
    >>在你的探索中收集土根
    .complete 6123,1
step << Druid
    .goto Darkshore,43.4,45.9,90,0
    .goto Darkshore,43.3,49.1,90,0
    .goto Darkshore,42.4,52.6,90,0
    .goto Darkshore,45.7,50.3,90,0
    .goto Darkshore,45.3,53.3
    .goto Darkshore,43.4,45.9,0
    .goto Darkshore,43.3,49.1,0
    .goto Darkshore,42.4,52.6,0
    .goto Darkshore,45.7,50.3,0
    >>在黑海岸中部的月牙洞里寻找蘑菇
    .complete 6123,2
step
    .goto Darkshore,39.99,78.46
     >>南行时杀死狂犬病蓟熊
    .complete 2138,1
step
     #completewith south1
     >>杀死你找到的任何登月者陛下，他们与灰熊共享产卵，不要想方设法完成它
    .complete 986,1
    .unitscan Moonstalker Sire
step
	#era/som
     #completewith south1
    .goto Darkshore,38.60,80.50,0
     >>杀死灰蓟熊
    .complete 1003,1
    .isOnQuest 1003
step
    .goto Felwood,27.00,55.59
    .turnin 952 >>交任务: 古树之林 << NightElf
    .turnin 948 >>交任务: 安努
    .accept 944 >>接任务: 主宰之剑
step
    .goto Ashenvale,22.36,3.98
     >>进入大师的Glaive，清除中间祭坛周围的暴徒
    .complete 944,1
step
    #sticky
    .goto Ashenvale,22.36,3.98
    .accept 945 >>接任务: 护送瑟瑞露尼
step
     >>把烤鸡蛋的碗扔在地上
    .turnin 944 >>交任务: 主宰之剑
    .accept 949 >>接任务: 暮光之锤的营地
step
    .goto Ashenvale,22.24,2.52
     >>点击底座顶部的书籍
    .turnin 949 >>交任务: 暮光之锤的营地
    .accept 950 >>接任务: 向安努回复
step
    >>完成护送任务
    .complete 945,1
step
	#era/som
    .goto Felwood,24.53,60.46
    .turnin 1003 >>交任务: 传声盒525号
    .isOnQuest 1003
step
    .goto Felwood,27.00,55.59
    .turnin 950 >>交任务: 向安努回复
    .accept 951 >>接任务: 玛塞斯特拉遗物
step << Hunter
    .xp 17
step << Hunter
    #sticky
    #label prospector
    .goto Felwood,18.08,64.03
    .turnin 729 >>交任务: 健忘的勘察员
step <<  Hunter
    .goto Darkshore,35.72,83.69
     >>开始护送任务
     >>这个任务非常困难，你可以跳过这一步，稍后在19级时再回来
    .accept 731 >>接任务: 健忘的勘察员
    .link https://www.twitch.tv/videos/1182180918 >>点击此处查看视频参考
step <<  Hunter
    #requires prospector
     >>护送探矿者返程
     .complete 731,1
     .isOnQuest 731
     *This quest is VERY hard, you can skip this step and come back later at level 19
    .link https://www.twitch.tv/videos/1182180918 >>点击此处查看视频参考
step << Hunter
	#era/som << Dwarf
    .goto Ashenvale,13.97,4.10
    .accept 4733 >>接任务: 搁浅的海洋生物
    >>这个任务可能有点难，试着把墨洛克一个接一个地拉过来，否则你可能会惹恼整个阵营
    .link https://www.twitch.tv/videos/992307825?t=05h48m36s >>点击此处查看视频参考
step << Hunter
	#era/som << Dwarf
    .goto Ashenvale,13.93,2.01
    .accept 4732 >>接任务: 搁浅的海龟
step << Hunter
	#era/som << Dwarf
    .goto Felwood,13.47,64.01
    .accept 4731 >>接任务: 搁浅的海龟
step << Hunter
	#era/som << Dwarf
    .goto Felwood,14.62,60.72
    .accept 4730 >>接任务: 搁浅的海洋生物
step
    #completewith south2
     >>在海岸杀死15级以上的螃蟹，获得优质螃蟹块，如果该区域过于拥挤，请跳过此步骤
    .complete 1138,1
step
    .goto Darkshore,36.64,76.53
     >>清除穆洛克营地，远离中心的篝火
    >>当你清理完所有东西后，移动到营地中心召唤默克迪普
    .complete 4740,1
step
    #label south1
    .goto Felwood,18.41,49.43
    .accept 4728 >>接任务: 搁浅的海洋生物
step << !Druid
    .goto Felwood,19.64,39.52
    .accept 4722 >>接任务: 搁浅的海龟
step << Druid
    #requires earthroot
    >>前往: 月光林地
    .goto Moonglade,52.4,40.6
    .trainer >>火车咒语
step << Druid
    .goto Moonglade,48.1,67.2
    .fly Auberdine>>飞到黑海岸
step
    .goto Darkshore,36.62,45.59
    .turnin 4722 >>交任务: 搁浅的海龟 << !Druid
    .turnin 4728 >>交任务: 搁浅的海洋生物
step << Hunter
	#era/som << Dwarf
    .goto Darkshore,36.62,45.59
    .turnin 4730 >>交任务: 搁浅的海洋生物
    .turnin 4731 >>交任务: 搁浅的海龟
    .turnin 4732 >>交任务: 搁浅的海龟
    .turnin 4733 >>交任务: 搁浅的海洋生物
step
    #label south2
    .goto Felwood,18.50,19.87
    .turnin 1138 >>交任务: 海中的水果
    >>如果您尚未收集全部6项，请跳过此步骤
    .isQuestComplete 1138
step
    .goto Felwood,20.34,18.12
    .turnin 4740 >>交任务: 通缉：莫克迪普！
step
    .goto Felwood,21.63,18.15
    .turnin 2138 >>交任务: 清除疫病
    .accept 2139 >>接任务: 萨纳瑞恩的希望
step << Hunter
    .goto Felwood,20.04,16.35
    .turnin 731 >>交任务: 健忘的勘察员
    .isQuestComplete 731
step << Hunter
    .goto Felwood,20.04,16.35
    .accept 741 >>接任务: 健忘的勘察员
    .isQuestTurnedIn 731
step << Druid
    .goto Darkshore,37.7,40.7
    .turnin 6123 >>交任务: 收集解药
    .accept 6124 >>接任务: 消除疾病
step
    .goto Felwood,27.70,10.03
    .turnin 957 >>交任务: 巴莎兰
step << Druid
    #label deers
    #sticky
    >>寻找病鹿，然后在它们身上涂抹动物药膏
    .complete 6124,1
step
     #completewith xabraxxis
    .goto Darkshore,50.74,34.68
     >>从木桶中掠夺黑木谷物样本，然后向东南方向奔向巢穴母亲，掠夺木桶将导致2个暴徒繁殖，小心
    .collect 12342,1
step
    .goto Darkshore,52.60,36.65,45,0
    >>杀死丹妈。小心，因为她的幼崽会把你打倒2秒钟
    .goto Darkshore,51.48,38.26
    .complete 2139,1 --Den Mother (1)
step
    #label xabraxxis
    .goto Darkshore,52.6,33.6
    >>掠夺北部营地的坚果/水果店，并使用篝火旁的碗召唤Xabraxxis
    .complete 4763,1
step <<  !Hunter
    .goto Darkshore,52.6,33.6
    .xp 18 >>升级到18级
step << Hunter
    .goto Darkshore,52.6,33.6
    .xp 18.75 >>升级到18+75%
    >>确保HS冷却时间<10分钟
    >>如果该区域过于拥挤，请跳过此步骤
step
	#era/som
    .goto Winterspring,1.42,26.89
    .turnin 1002 >>交任务: 传声盒323号
    .accept 1003 >>接任务: 传声盒525号
step
    .goto Winterspring,4.82,27.18
    .turnin 965 >>交任务: 奥萨拉克斯之塔
    .accept 966 >>接任务: 奥萨拉克斯之塔
step
    .goto Winterspring,6.06,28.81
     >>杀死信徒。抢他们的羊皮纸
    .complete 966,1
step
    .goto Winterspring,4.82,27.18
    .turnin 966 >>交任务: 奥萨拉克斯之塔
    .accept 967 >>接任务: 奥萨拉克斯之塔
step
    .goto Winterspring,7.52,23.26
     >>寻找地面上的小遗迹
    .complete 951,1
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,6.37,16.66
    .accept 2098 >>接任务: 基尔卡克的钥匙
step  << !Warrior !Paladin !Rogue !Druid
    #sticky
    #completewith MoonstalkerP
    .goto Darkshore,56.10,16.88,0
     >>杀死海岸边的愤怒的暗礁爬行动物。小心，因为他们猛击，一次最多可以造成200点伤害。抢走钥匙的底部
    .complete 2098,3
step  << !Warrior !Paladin !Rogue !Druid
    .goto Darkshore,55.59,12.90
     >>杀死Murlocs
    .complete 2098,2
step  << !Warrior !Paladin !Rogue !Druid
    #sticky
    #label foreststriders
    .goto Darkshore,61.40,9.40
     >>杀死林蛙
    .complete 2098,1
step
    #label MoonstalkerP
    .goto Darkshore,61.40,9.40
     >>杀死登月者陛下/女族长。抢他们的皮毛
    .complete 986,1
step  << !Warrior !Paladin !Rogue !Druid
     .goto Darkshore,56.10,16.88
     >>杀死海岸边的愤怒的暗礁爬行动物。小心，因为他们猛击，一次最多可以造成200点伤害。抢走钥匙的底部
    .complete 2098,3
step  << !Warrior !Paladin !Rogue !Druid
    #requires foreststriders
    .goto Winterspring,6.37,16.66
    .turnin 2098 >>交任务: 基尔卡克的钥匙
    .accept 2078 >>接任务: 基尔卡克的报复
step << !Druid
    .goto Winterspring,3.10,20.90
    .accept 4727 >>接任务: 搁浅的海龟
step << !Druid
    .goto Darkshore,51.50,22.26
     >>吃完海果
    .complete 1138,1
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,5.59,21.09
     >>与Threshwackonator 4100交谈
    >>护送它回Gyromast并杀死它
    >>小心，因为这个任务非常困难
    .complete 2078,1
    .link https://clips.twitch.tv/VainAmorphousMacaroniPRChase-iGvhTnz0ked6LO0A >>点击此处查看视频参考
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,6.37,16.66
    .turnin 2078 >>交任务: 基尔卡克的报复
    .isQuestComplete 2078
step  << !Warrior !Paladin !Rogue !Druid
    #sticky
    .destroy 7442 >>摧毁: 基尔卡克的钥匙
step << Druid
    .goto Winterspring,3.10,20.90
    .accept 4727 >>接任务: 搁浅的海龟
step << Druid
    .goto Darkshore,51.50,22.26
     >>吃完海果
    .complete 1138,1
step << Druid
    #requires deers
    .goto Darkshore,48.9,11.3
    >>在水下掠夺位于两块大石头之间的小锁盒
    .collect 15883,1,5061,1 --Collect Half Pendant of Aquatic Agility (x1)
step <<  Dwarf Hunter
     #softcore
    #completewith next
    .deathskip >>研磨直到你的高速冷却时间<6分钟，然后死亡扭曲到奥伯丁
step <<  Dwarf Hunter
     #hardcore
    #completewith next
    +研磨直到你的HS冷却时间<9分钟，然后跑回奥伯丁
step <<  Dwarf Hunter
    .goto Felwood,19.98,14.40
    .turnin 4763 >>交任务: 黑木熊怪的堕落
step <<  Dwarf Hunter
    .goto Felwood,21.63,18.15
    .turnin 2139 >>交任务: 萨纳瑞恩的希望
step << Dwarf Hunter
     .goto Darkshore,33.17,40.17,40,0
     .goto Darkshore,33.17,40.17,0
    .zone Teldrassil >>前往: 泰达希尔
    .zoneskip Darnassus
step <<  Dwarf Hunter
    .goto Teldrassil,58.40,94.02
    .fp Teldrassil >>获取Teldrassil飞行路径
step << Dwarf Hunter
    #completewith next
    .goto Teldrassil,55.95,89.88
    .zone Darnassus >>前往: 达纳苏斯
step <<  Dwarf Hunter
    .goto Darnassus,40.2,8.8
    .trainer  >>火车咒语
step <<  Dwarf Hunter
    #sticky
    .goto Darnassus,57.55,46.73
    .train 264 >>火车弓
    .train 227 >>火车杆
step <<  Dwarf Hunter
    #sticky
    .goto Darnassus,63.30,66.30
     >>购买20级弓和10槽箭袋
    .collect 3027,1
    .collect 11362,1
step <<  Dwarf Hunter
    .goto Teldrassil,23.70,64.51
    .turnin 741 >>交任务: 健忘的勘察员
    .accept 942 >>接任务: 健忘的勘察员
step << Druid
    .goto Moonglade,56.2,30.4
    >>前往: 月光林地
    .turnin 6124 >>交任务: 消除疾病
    .accept 6125 >>接任务: 解毒之术
step << Druid
    .goto Moonglade,52.53,40.56
    .trainer >>训练你的职业咒语
step
     #completewith next
    .hs >>赫斯回到奥伯丁
step
    .goto Felwood,19.10,20.63
    .turnin 4727 >>交任务: 搁浅的海龟
step
    .goto Felwood,18.50,19.87
    .turnin 1138 >>交任务: 海中的水果
step
    .goto Felwood,19.98,14.40
    .turnin 4763 >>交任务: 黑木熊怪的堕落
step <<  NightElf Hunter
    .vendor  >>购买额外的箭头/补给
step
    .goto Felwood,21.63,18.15
    .turnin 2139 >>交任务: 萨纳瑞恩的希望
step
    .goto Darkshore,39.37,43.48
    .turnin 986 >>交任务: 丢失的主人
    .accept 993 >>接任务: 丢失的主人
 step <<  !Hunter
    .goto Darkshore,33.70,42.45
     >>在等待Menethil船时进行水平急救/烹饪
    .zone Wetlands >>前往: 湿地
step <<  !Hunter
    .goto Wetlands,9.49,59.69
    .fp Wetlands>>获取湿地飞行路径
step <<  !Hunter
    .goto Wetlands,49.91,39.36
    >>沿着这条路往东走
    .accept 469 >>接任务: 日常供货
step <<  !Hunter
    #completewith next
    .goto Wetlands,53.7,72.3,75 >>通往莫丹湖的路从这里开始
step <<  !Hunter
    .goto Loch Modan,25.4,10.6
    .zone Loch Modan >>前往: 洛克莫丹
step << !Hunter
    .goto Loch Modan,46.0,13.3
    .accept 250 >>接任务: 水坝危机
step << !Hunter
    .goto Loch Modan,56.1,13.3
    >>点击小炸药桶
    .turnin 250 >>交任务: 水坝危机
    .accept 199 >>接任务: 水坝危机
step << !Hunter
    .goto Loch Modan,46.0,13.3
    .turnin 199 >>交任务: 水坝危机
step <<  !Hunter
    #completewith next
    .deathskip >>在塞尔萨马尔死亡并重生
step <<  !Hunter
    .goto Loch Modan,33.9,50.9
    .fp Thelsamar >>获取Thelsamar飞行路线
step <<  !Hunter
    .goto Loch Modan,21.30,68.60,40 >>跑到邓莫罗
step <<  !Hunter
     #completewith next
    .deathskip >>一旦区域文字变为Dun Morogh，故意死亡并在Kharanos重生
step <<  !Hunter
    .goto Ironforge,14.90,87.10
    .zone Ironforge >>前往: 铁炉堡
step << !Hunter
    .goto Ironforge,55.51,47.75
    .fp Ironforge >>获得铁炉堡飞行路线
step <<  !Hunter
    #completewith next
    .goto Ironforge,67.84,42.50
    .vendor >>如果你还没有，就买一个铜管
    >>这是一个限量供应项目，如果npc没有，请跳过此步骤
--    >>稍后的任务需要2个青铜管 << Rogue
    .bronzetube
step <<  !Hunter
    .goto Ironforge,76.03,50.98,30,0
    .zone Stormwind City >>前往: 暴风城
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance !Hunter !NightElf
#name 14-19 黑海岸
#version 1
#group RestedXP 联盟 1-20
#defaultfor !Hunter !NightElf
#next 19-20 赤脊山

step
    .goto Felwood,19.10,20.63
    >>前往奥伯丁
    .accept 3524 >>接任务: 搁浅的巨兽
step <<  !NightElf
    .goto Felwood,19.10,20.63
    .fp Auberdine >>获取奥伯丁飞行路线
step <<  NightElf
    .goto Felwood,19.27,19.14
    .turnin 6342 >>交任务: 飞往奥伯丁
    .accept 6343 >>接任务: 飞回泰达希尔
step
    .goto Darkshore,37.0,44.0
    .home >>将Hearthstone设置为Auberdine
step
    >>上楼到顶层
    .goto Felwood,19.51,18.97
    .accept 983 >>接任务: 传声盒827号
step
    .goto Felwood,21.63,18.15
    .accept 2118 >>接任务: 瘟疫蔓延
    .accept 984 >>接任务: 熊怪的威胁
step
    #sticky
    #completewith crabs1
     >>沿着海岸杀死螃蟹。抢走他们的腿
    .complete 983,1
step
    .goto Felwood,18.81,26.69
     >>掠夺海洋生物遗骸
    .complete 3524,1
step
    .goto Felwood,22.39,29.45
     >>前往弗尔博格营地
     .complete 984,1
step
    #label crabs1
    >>找到一只狂犬病蓟熊。Aggro一号，在你的包里使用塔纳瑞恩的希望(紫色球体)
    .goto Darkshore,38.47,57.92
    .complete 2118,1
    .unitscan Rabid Thistle Bear
step
    .goto Felwood,19.13,21.39
     >>完成沿海螃蟹的捕杀和腿的掠夺
    .complete 983,1
step
    .goto Felwood,19.13,21.39
    >>单击Buzzbox
    .turnin 983 >>交任务: 传声盒827号
step
	#era/som
    .goto Felwood,19.13,21.39
    .accept 1001 >>接任务: 传声盒411号
step
    .goto Felwood,19.10,20.63
    .turnin 3524 >>交任务: 搁浅的巨兽
    .accept 4681 >>接任务: 搁浅的巨兽
step
    >>在码头上
    .goto Felwood,18.10,18.48
    .accept 963 >>接任务: 永志不渝
step
	#era/som
    #sticky
    #completewith washed1
    .goto Darkshore,33.59,40.36,0
    .goto Darkshore,30.94,45.79,0
    .goto Darkshore,33.03,48.13,0
     >>开始研究Darkshore Threshers。
    .complete 1001,1
step
    #completewith next
    .goto Darkshore,33.70,42.45,40 >>跑到码头，然后在十字路口跳入水中
step
    .goto Felwood,13.63,21.44
    >>点击海龟遗骸
    .complete 4681,1
step
    #label washed1
    .goto Felwood,19.10,20.63
    .turnin 4681 >>交任务: 搁浅的巨兽
step
    .goto Felwood,19.90,18.40
    .accept 947 >>接任务: 洞中的蘑菇
step
    .goto Felwood,20.34,18.12
    .accept 4811 >>接任务: 红色水晶
step
    .goto Felwood,21.63,18.15
    .turnin 2118 >>交任务: 瘟疫蔓延
    .accept 2138 >>接任务: 清除疫病
step
    .goto Felwood,22.24,18.22
    .turnin 984 >>交任务: 熊怪的威胁
    .accept 985 >>接任务: 熊怪的威胁
    .accept 4761 >>接任务: 桑迪斯·织风
step
    .goto Felwood,20.80,15.58
    .accept 982 >>接任务: 深不可测的海洋
step
    .goto Felwood,19.98,14.40
    .turnin 4761 >>交任务: 桑迪斯·织风
    .accept 4762 >>接任务: 壁泉河
    .accept 958 >>接任务: 上层精灵的工具
    .accept 954 >>接任务: 巴莎兰
step
	#era/som
    #sticky
    #label threshers
    .goto Darkshore,35.44,35.83,55,0
    .goto Darkshore,35.71,32.27,55,0
    .goto Darkshore,35.44,35.83,0
    .goto Darkshore,35.71,32.27,0
    .goto Darkshore,36.70,30.00,0
    .goto Darkshore,38.73,28.25,0
    .goto Darkshore,40.17,28.76,0
     >>在海岸外杀死黑海岸脱粒鸟。抢走他们的眼睛
    .complete 1001,1
step
    .goto Felwood,20.94,1.49
    >>从船体上的洞进入第一艘船，在船底的水下洗劫箱子
    >>小心，因为这个任务可能很困难
    .complete 982,1
step
    .goto Darkshore,39.63,27.45
    >>通过船体上的孔进入第二艘飞船，在你发现第一个箱子的确切位置掠夺位于飞船上的箱子
    >>小心，因为这个任务可能很困难
    .complete 982,2
step
	#era/som
    #requires threshers
    #label mbox1
    .goto Felwood,25.19,1.29
    .turnin 1001 >>交任务: 传声盒411号
    .accept 1002 >>接任务: 传声盒323号
step
    .goto Felwood,25.15,4.61
    .accept 4723 >>接任务: 搁浅的海洋生物
step
    #completewith Ameth
     >>杀死漫游者。掠夺他们以获取“漫游者肉”
    .collect 5469,5,2178,1
step
	#era/som
    #completewith Ameth
     >>杀死任何类型的登月者
    .complete 1002,1
--N mushrooms
step
    #completewith bears1
     >>在穿越黑暗海岸时杀死狂犬病蓟熊
    .complete 2138,1
--N bears
step
    .goto Darkshore,44.18,20.60
    .accept 4725 >>接任务: 搁浅的海龟
step
    .goto Darkshore,50.81,25.50
     >>使用瀑布底部的空采样管
    .complete 4762,1
step
    #label bears1
    .goto Felwood,27.70,10.03
    .turnin 954 >>交任务: 巴莎兰
    .accept 955 >>接任务: 巴莎兰
step
    .goto Felwood,29.13,12.34
     >>杀死格雷金斯。掠夺他们的耳环
    .complete 955,1
step
    .goto Felwood,27.70,10.03
    .turnin 955 >>交任务: 巴莎兰
    .accept 956 >>接任务: 巴莎兰
step
    .goto Felwood,29.60,12.52
     >>杀死萨特尔斯。掠夺他们以换取封印
    .complete 956,1
step
    .goto Felwood,27.70,10.03
    .turnin 956 >>交任务: 巴莎兰
    .accept 957 >>接任务: 巴莎兰
step
    #completewith next
    >>杀死猫头鹰并收集小鸡蛋，以便稍后进行平地烹饪。
    .collect 6889,9,2178
step
    .goto Felwood,31.29,24.14
     >>跑到山上的红水晶
     .complete 4811,1
step
    .goto Darkshore,44.4,51.2
    >>杀死猫头鹰，确保你至少有9个小鸡蛋来烹饪
    >>如果你在烹饪方面已经掌握了10分，请跳过这一步。
    .collect 6889,9,2178
step
    #label Ameth
    .goto Darkshore,40.30,59.70
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
     >>杀死和掠夺鬼魂
    .complete 958,1
step
    .goto Felwood,26.71,35.53
     >>点击地面上的平板电脑
    .complete 953,1
step
    .goto Felwood,25.66,39.11
     >>点击露台上的绿色火炬
    .complete 957,1
step
    .goto Felwood,25.98,40.62
     >>点击地面上的平板电脑
    .complete 953,2
step
    #requires anaya
    .goto Felwood,23.29,36.73
    .turnin 953 >>交任务: 亚米萨兰的毁灭
step
    #requires ghosts
    #completewith Bears
     >>杀死漫游者。掠夺他们以获取“漫游者肉”
    .collect 5469,5,2178,1
--N Bears
step
	#era/som
    #completewith Mushrooms
     >>杀死任何类型的登月者
    .complete 1002,1
--N mushrooms
step
    #completewith Bears
     >>在穿越黑暗海岸时杀死狂犬病蓟熊
    .complete 2138,1
--N bears
step
    #requires ghosts
    .goto Felwood,18.41,49.43
    .accept 4728 >>接任务: 搁浅的海洋生物
step
    #label Bears
    .goto Felwood,19.64,39.52
    .accept 4722 >>接任务: 搁浅的海龟
step
    .goto Darkshore,38.83,60.82
    >>完成杀死狂犬病蓟熊并获得漫游者肉
    .complete 2138,1 --Rabid Thistle Bear (20)
    .collect 5469,5,2178,1
step
    .goto Felwood,22.39,29.45
     >>杀死Furbolgs。当风语家施放“阵风”以躲避时，请远离风语家约10码
     >>像探路者猛击一样小心(每10秒左右一次攻击3次)。
    .complete 985,1
    .complete 985,2
step
    .goto Felwood,18.50,19.87
    .accept 1138 >>接任务: 海中的水果
step
    .goto Felwood,19.10,20.63
    .turnin 4723 >>交任务: 搁浅的海洋生物
    .turnin 4728 >>交任务: 搁浅的海洋生物
    .turnin 4722 >>交任务: 搁浅的海龟
    .turnin 4725 >>交任务: 搁浅的海龟
step
    >>在码头上
    .goto Felwood,18.10,18.48
    .turnin 963 >>交任务: 永志不渝
step
    .goto Felwood,20.04,16.35
    .accept 729 >>接任务: 健忘的勘察员
step
    #completewith ezstrider
    .goto Felwood,20.80,15.58
    .vendor 6301 >>如果你在烹饪方面没有10分的话，买温和的香料，煮香草烤鸡蛋
step
    .goto Felwood,20.80,15.58
    .turnin 982 >>交任务: 深不可测的海洋
step
    #label ezstrider
    .goto Darkshore,37.70,40.70
    .accept 2178 >>接任务: 炖陆行鸟
    .turnin 2178 >>交任务: 炖陆行鸟
    >>这个任务需要烹饪10分
step
    .goto Felwood,19.98,14.40
    .turnin 958 >>交任务: 上层精灵的工具
    .turnin 4762 >>交任务: 壁泉河
    .accept 4763 >>接任务: 黑木熊怪的堕落
step
    .goto Felwood,20.34,18.12
    .turnin 4811 >>交任务: 红色水晶
    .accept 4812 >>接任务: 清洗水晶
step
    .goto Darkshore,37.78,44.06
     >>在月光井处填充空水管/空碗
    .complete 4812,1
    .collect 12347,1,4763,1
step
    .goto Felwood,21.63,18.15
    .turnin 2138 >>交任务: 清除疫病
    .accept 2139 >>接任务: 萨纳瑞恩的希望
step
    .goto Felwood,22.24,18.22
    .turnin 985 >>交任务: 熊怪的威胁
    .accept 986 >>接任务: 丢失的主人
step
    .goto Felwood,21.86,18.30
     >>跑上楼去
    .accept 965 >>接任务: 奥萨拉克斯之塔
step
    .goto Felwood,31.29,24.14
     >>点击红色水晶
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step
    .goto Felwood,27.70,10.03
    .turnin 957 >>交任务: 巴莎兰
step << Paladin
	#completewith next
    .goto Darkshore,50.74,34.68,0
	>>开始保存从Furbolgs区域掠夺的亚麻布。
	.collect 2589,10,1,1644 --Linen Cloth (10)
step
    .goto Darkshore,50.74,34.68
    >>从木桶中掠夺黑木谷物样本，然后向东南方向奔向巢穴母亲，掠夺木桶将导致2个暴徒繁殖，小心
    .collect 12342,1,4763,1 --Blackwood Grain Sample (1)
step
    .goto Darkshore,52.60,36.65,45,0
    >>杀死丹妈。小心，因为她的幼崽会把你打倒2秒钟
    .goto Darkshore,51.48,38.26
    .complete 2139,1 --Den Mother (1)
step << Paladin
	#completewith Fruit
    .goto Darkshore,50.74,34.68,0
	>>开始保存从Furbolgs区域掠夺的亚麻布。
	.collect 2589,10,1,1644 --Linen Cloth (10)
step
    >>从桶里偷走黑木坚果样本
    .goto Darkshore,51.80,33.51
    .collect 12343,1 --Blackwood Nut Sample (1)
step
	#label Fruit
    >>从桶里偷走黑木果样本。一群暴徒会在你面前，以及在西部的小屋之间滋生，你可能不得不逃跑
    .goto Darkshore,52.85,33.42
    .collect 12341,1 --Blackwood Fruit Sample (1)
step
    #label xabraxxis
    .goto Darkshore,52.6,33.6
     >>使用篝火旁库存中的碗召唤Xabraxxis。杀了他
     >>小心，因为这个任务可能很困难，因为他对低血量感到愤怒，并造成大量伤害。但他确实死得很快
    .complete 4763,1
step
    #completewith next
    .goto Winterspring,5.49,36.64,45 >>前往瀑布上方的洞穴
step
    #label Mushrooms
    .goto Darkshore,55.66,34.89
     >>停留在洞穴的上部。如果顶部末端没有死亡帽，则从下面放下并取一个
     >>当你洗劫死亡帽时，洞口的第一个蓝色的应该已经复活了
    .complete 947,1 --Scaber Stalk (5)
    .complete 947,2 --Death Cap (1)
step
    .goto Winterspring,4.82,27.18
    .turnin 965 >>交任务: 奥萨拉克斯之塔
    .accept 966 >>接任务: 奥萨拉克斯之塔
step << Paladin
	#completewith next
    .goto Darkshore,55.36,26.84
	>>杀死黑股狂热分子。抢他们10块亚麻布
	.collect 2589,10,1,1644 --Linen Cloth (10)
step
    >>杀死黑股狂热分子。抢他们的羊皮纸
    .goto Darkshore,55.36,26.84
    .complete 966,1 --Worn Parchment (4)
step << Paladin
    .goto Darkshore,55.36,26.84
	>>杀死黑股狂热分子。抢他们10块亚麻布
	.collect 2589,10,1,1644 --Linen Cloth (10)
step
    .goto Winterspring,4.82,27.18
    .turnin 966 >>交任务: 奥萨拉克斯之塔
    .accept 967 >>接任务: 奥萨拉克斯之塔
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,6.37,16.66
    .accept 2098 >>接任务: 基尔卡克的钥匙
step  << !Warrior !Paladin !Rogue !Druid
    .goto Darkshore,56.33,14.97
    >>杀死海岸边的愤怒的暗礁爬行动物。小心，因为他们猛击，一次最多可以造成200点伤害。抢走钥匙的底部
    .complete 2098,3
step  << !Warrior !Paladin !Rogue !Druid
    .goto Darkshore,55.36,12.70
     >>在水中杀死穆洛克。当甲壳虫受到重击(80点闪电伤害)并且可以完全恢复时，请小心。抢走钥匙的中间部分
    >>如果需要的话，你可以把神谕放在船头周围
    .complete 2098,2
step  << !Warrior !Paladin !Rogue !Druid
    #sticky
    #label ForestKey
    .goto Darkshore,60.50,12.19,0
     >>杀死林蛙。抢走钥匙的顶部
    .complete 2098,1
step
	#era/som
    .goto Darkshore,61.40,9.40
     >>打磨登月者陛下/母兽的皮毛和毒牙
    .complete 986,1
    .complete 1002,1
step
	#som
	#phase 3-6
    .goto Darkshore,61.40,9.40
     >>打磨登月者陛下/母兽的皮毛和毒牙
    .complete 986,1
step  << !Warrior !Paladin !Rogue !Druid
    #requires ForestKey
    .goto Winterspring,6.37,16.66
    .turnin 2098 >>交任务: 基尔卡克的钥匙
    .accept 2078 >>接任务: 基尔卡克的报复 << !Warrior !Paladin !Rogue
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,5.59,21.09
    >>与Threshwackonator 4100交谈
    >>护送它回Gyromast并杀死它
    >>这个精英任务很难，如果你做不到，跳过这一步
    .complete 2078,1
    .link https://clips.twitch.tv/VainAmorphousMacaroniPRChase-iGvhTnz0ked6LO0A >>点击此处查看视频参考
step  << !Warrior !Paladin !Rogue !Druid
    .goto Winterspring,6.37,16.66
    .turnin 2078 >>交任务: 基尔卡克的报复
    .isQuestComplete 2078
step   << !Warrior !Paladin !Rogue !Druid
    #sticky
    .destroy 7442>>扔掉陀螺仪的钥匙
step
    .goto Winterspring,3.10,20.90
    .accept 4727 >>接任务: 搁浅的海龟
step
	#era/som
    #completewith next
    .goto Darkshore,53.0,18.4,0
    .goto Darkshore,50.4,22.6,0
     >>杀死沿岸的珊瑚虫/结壳潮汐虫。抢走螃蟹块
    .complete 1138,1
step
	#era/som
    .goto Winterspring,1.42,26.89
    .turnin 1002 >>交任务: 传声盒323号
    .accept 1003 >>接任务: 传声盒525号
step
    .goto Darkshore,51.50,22.26,100,0
    .goto Darkshore,53.0,18.4,0
    .goto Darkshore,50.4,22.6,0
    .goto Darkshore,44.8,21.6,0
     >>杀死珊瑚虫/结壳潮汐虫。抢走螃蟹块
    .complete 1138,1
step <<  NightElf
     #softcore
    #completewith next
    .deathskip >>研磨直到你的炉石冷却时间<6分钟，然后死亡扭曲到奥伯丁
step <<  NightElf
     #hardcore
    #completewith next
    +研磨直到你的炉石冷却时间<9分钟，然后跑回奥伯丁
step
     #completewith next
    .hs >>赫斯回到奥伯丁
step
    .goto Felwood,19.10,20.63
    .turnin 4727 >>交任务: 搁浅的海龟
step
    .goto Felwood,18.50,19.87
    .turnin 1138 >>交任务: 海中的水果
step
    .goto Felwood,19.78,19.07
     >>点击酒店外的通缉海报
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
    .goto Felwood,20.34,18.12
    .turnin 4813 >>交任务: 水晶中的碎骨
step
    .goto Felwood,19.90,18.40
    .turnin 947 >>交任务: 洞中的蘑菇
    .accept 948 >>接任务: 安努
step
    .goto Felwood,21.63,18.15
    .turnin 2139 >>交任务: 萨纳瑞恩的希望
step
    .goto Darkshore,39.37,43.48
    .turnin 986 >>交任务: 丢失的主人
    .accept 993 >>接任务: 丢失的主人
step
    .goto Darkshore,37.70,40.70
    .accept 2178 >>接任务: 炖陆行鸟
    .turnin 2178 >>交任务: 炖陆行鸟
    >>这个任务需要烹饪10分
step
    .goto Felwood,19.98,14.40
    .turnin 4763 >>交任务: 黑木熊怪的堕落
step
    #softcore
    .goto Elwynn Forest,26.29,38.50
    .zone Stormwind City >>乘船到米奈希尔港, 然后飞往铁炉堡, 最后搭乘地铁前往暴风城
    >>或
    >>使用网站解卡自助服务传送回暴风城(更快)
step
    #hardcore
    .goto Darkshore,32.42,43.75,50,0
    .goto Darkshore,32.42,43.75,0
    .zone Wetlands >>前往: 湿地
step
    #hardcore
    #completewith next
    .money <0.08
    .goto Wetlands,10.4,56.0,25,0
    .goto Wetlands,10.1,56.9,25,0
    .goto Wetlands,10.6,57.2,25,0
    .goto Wetlands,10.7,56.8
    .vendor >>如果你有8s，检查Neal Allen的青铜管，如果有就买。否则，请跳过此步骤
    .bronzetube
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
    .goto Ironforge,77.0,51.0,60 >>跑到Deeprun Tram
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
step
    #hardcore
    .goto Elwynn Forest,26.29,38.50
    .zone Stormwind City >>前往: 暴风城
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance Hunter
#name 19-21 黑海岸/灰谷
#version 1
#group RestedXP 联盟 1-20
#next RestedXP联盟20-30\21-23灰谷/石爪

step
    #sticky
    #label prospector
    .goto Felwood,18.08,64.03
    .turnin 729 >>交任务: 健忘的勘察员
step <<  Hunter
    .goto Darkshore,35.72,83.69
     >>开始护送任务
    >>这个任务很难，小心进行
    .accept 731 >>接任务: 健忘的勘察员
    .link https://www.twitch.tv/videos/1182180918 >>点击此处查看视频参考
step <<  Hunter
    #requires prospector
     >>护送探矿者返程
     .complete 731,1
    .link https://www.twitch.tv/videos/1182180918 >>点击此处查看视频参考
step
    #completewith next
    .goto Ashenvale,22.36,3.98
    >>开始护送任务
    .accept 945 >>接任务: 护送瑟瑞露尼
step
    .goto Ashenvale,22.36,3.98
    >>护送Therylune
    .complete 945,1
step
	#era/som
    .goto Ashenvale,13.97,4.10
    .accept 4733 >>接任务: 搁浅的海洋生物
    >>这个任务可能有点难，试着把墨洛克一个接一个地拉过来，否则你可能会惹恼整个阵营
    .link https://www.twitch.tv/videos/992307825?t=05h48m36s >>点击此处查看视频参考
step
	#era/som
    .goto Ashenvale,13.93,2.01
    .accept 4732 >>接任务: 搁浅的海龟
step
	#era/som
    .goto Felwood,13.47,64.01
    .accept 4731 >>接任务: 搁浅的海龟
step
	#era/som
    .goto Felwood,14.62,60.72
    .accept 4730 >>接任务: 搁浅的海洋生物
step
	#era/som
    >>杀死灰蓟熊
    .complete 1003,1
step
	#era/som
    .goto Felwood,24.53,60.46
    .turnin 1003 >>交任务: 传声盒525号
step
    #label lostmaster1
    #completewith lostmaster2
    #sticky
    .goto Ashenvale,29.58,1.67
    .turnin 993 >>交任务: 丢失的主人
step
	#era/som
     >>在接受这个任务之前，清除洞穴附近的裂谷
    .accept 994 >>接任务: 杀出重围
step
	#som
	#phase 3-6
     >>接受请求并等待RP序列完成
    .accept 995 >>接任务: 偷偷溜走
step
	#era/som
    #requires lostmaster1
    #label lostmaster2
     >>护送Volcor
     .complete 994,1
step
	#som
	#phase 3-6
    #requires lostmaster1
    #label lostmaster2
     >>等待RP对话结束
     .complete 995,1
step
    .goto Felwood,27.00,55.59
    .turnin 951 >>交任务: 玛塞斯特拉遗物
step
    .goto Felwood,27.96,55.76
    >>与科隆尼安对话，开始护送任务
    >>如果他不在，你可以跳过这个任务(根据其他玩家的不同，重生最多需要25分钟)
    .accept 5321 >>接任务: 昏昏欲睡
step
    .isOnQuest 5321
    .goto Darkshore,44.38,76.30
     >>掠夺任务给予者旁边的箱子
    .complete 5321,1
step
     #completewith tower
     .zone Ashenvale >>前往: 灰谷
     .goto Ashenvale,29.7,13.6
step
    .goto Ashenvale,27.26,35.58
    >>在执行护送任务时，避免走在主要道路上
     .complete 5321,2
     .isOnQuest 5321
step
    .goto Ashenvale,27.26,35.58
    .turnin 5321 >>交任务: 昏昏欲睡
    .isQuestComplete 5321
step
    #label tower
    .goto Ashenvale,26.19,38.69
    .turnin 967 >>交任务: 奥萨拉克斯之塔
step
	#era/som
    .goto Ashenvale,26.19,38.69
    .accept 970 >>接任务: 奥萨拉克斯之塔
step
	#era/som
     #completewith next
    .goto Ashenvale,31.41,30.66
     >>杀死信徒
    .complete 970,1
step
	#era/som
     #completewith next
    .goto Ashenvale,26.19,38.69
    .turnin 970 >>交任务: 奥萨拉克斯之塔
step
    .xp 20 >>升级到20级
step
    .goto Ashenvale,26.43,38.59
    .accept 1010 >>接任务: 巴斯兰的头发
step
    .goto Ashenvale,31.63,22.33
     >>当心地上的药草袋
    .complete 1010,1
step
	#era/som
    .goto Ashenvale,31.41,30.66
     >>杀死信徒
    .complete 970,1
step
    #sticky
    #label hair
    .goto Ashenvale,26.43,38.59
    .turnin 1010 >>交任务: 巴斯兰的头发
    .accept 1020 >>接任务: 奥雷迪尔的药剂
step
	#era/som
    .goto Ashenvale,26.43,38.59
    .turnin 970 >>交任务: 奥萨拉克斯之塔
    .accept 973 >>接任务: 奥萨拉克斯之塔
step
    #requires hair
    .goto Ashenvale,22.64,51.91
    .turnin 945 >>交任务: 护送瑟瑞露尼
    .isQuestComplete 945
step
    #completewith end
     +最多保存6条从该区域的蜘蛛身上掠夺的Gooey Spider Legs，以备日后使用
step <<  Hunter
    .goto Ashenvale,18.00,59.80
    >>前往灰谷的猎人训练师
    .train 5118 >>与猎人训练师交谈，学习猎豹的特性
    .train 15147 >>训练宠物技能
step
    .goto Ashenvale,34.40,48.00
    .fp Astranaar>>获取Astranaar飞行路线
step
    .goto Ashenvale,34.67,48.83
    .accept 1008 >>接任务: 佐拉姆海岸
step
    .goto Ashenvale,34.89,49.79
    .accept 1070 >>接任务: 守卫石爪山
step
    .goto Ashenvale,35.76,49.10
    .accept 1056 >>接任务: 石爪峰之旅
step
    .goto Ashenvale,36.61,49.58
    .accept 991 >>接任务: 莱恩的净化
    .accept 1054 >>接任务: 解除威胁
step <<  !Dwarf/!Hunter
    .home >>将HS设置为Astranaar
step
    .goto Ashenvale,37.36,51.79
    .turnin 1020 >>交任务: 奥雷迪尔的药剂
    .timer 26,Orendil's Cure RP
step
    .goto Ashenvale,37.36,51.79
     >>等待RP序列结束
    .accept 1033 >>接任务: 月神之泪
step
    .goto Ashenvale,46.37,46.38
     >>掠夺珍珠状物品
    >>小心潜入水下的暴徒
    .complete 1033,1
step
    .goto Ashenvale,37.36,51.79
     >>等待RP序列结束
    .turnin 1033 >>交任务: 月神之泪
    .accept 1034 >>接任务: 星尘废墟
step
    .goto Ashenvale,33.30,67.79
     >>掠夺湖岛上的灌木丛
    .complete 1034,1
step
    #completewith next
    .goto Ashenvale,31.67,64.24,15 >>前往山脚
    .goto Ashenvale,31.21,61.60,15 >>爬山时笔直向北跑
step
    #completewith next
    .goto Ashenvale,27.50,60.76,8 >>爬上火疤神殿入口右侧大树旁的小山
    >>跳过树根，拥抱右侧，以避免暴徒的攻击
step
	#era/som
    .goto Ashenvale,25.27,60.68
    >>杀死伊尔克鲁德·马格索尔
    >>这个任务很难，你可以现在跳过这个，稍后在23级完成
    .complete 973,1
    .link https://www.twitch.tv/videos/1182187763 >>点击此处查看视频参考
	.isOnQuest 973
step
	#era/som
    .isQuestComplete 973
    .goto Ashenvale,26.19,38.69
    .turnin 973 >>交任务: 奥萨拉克斯之塔
step
    .goto Ashenvale,14.79,31.29
    .accept 1007 >>接任务: 远古雕像
step
    #sticky
    #label nagas
    .goto Ashenvale,7.00,15.20,0
     >>杀死海岸附近的纳加人
    .complete 1008,1
step
    .goto Ashenvale,14.20,20.64
     >>掠夺古代雕像
    .complete 1007,1
step
    .goto Ashenvale,14.79,31.29
     >>等待RP序列
    .turnin 1007 >>交任务: 远古雕像
    .timer 25,The Ancient Statuette RP
    .accept 1009 >>接任务: 卢泽尔
step
    .goto Ashenvale,7.40,13.40
     >>杀死鲁泽尔
    >>维斯皮亚女士(罕见)也会掉落戒指
    .complete 1009,1
    .unitscan Lady Vespia
step
    .goto Ashenvale,14.79,31.29
    .turnin 1009 >>交任务: 卢泽尔
step
    #requires nagas
    .goto Ashenvale,20.31,42.33
    .turnin 991 >>交任务: 莱恩的净化
    .accept 1023 >>接任务: 莱恩的净化
step
    .goto Ashenvale,20.41,43.82
    >>杀死Murlocs直到发光宝石掉落
    >>保存Murloc翅片供以后使用
    >>小心，因为神谕可以治愈，每隔几秒就有90点伤害的瞬发冲击法术
    .complete 1023,1
step <<  Dwarf Hunter
    .hs >>赫斯回到奥伯丁
step <<  !Dwarf/!Hunter
    #softcore
    #completewith next
    .deathskip >>死在湖的东侧，在阿斯特拉纳州的精神疗养院
step <<  !Dwarf/!Hunter
    #hardcore
    #completewith next
    .goto Ashenvale,34.40,48.00,200 >>跑回阿斯特拉纳
step <<  Hunter
    #completewith end
    .stable  >>稳定您的宠物
step <<  !Dwarf/!Hunter
    .goto Ashenvale,34.40,48.00
    .fly Darkshore>>飞到黑海岸
step
    .goto Felwood,20.04,16.35
    .turnin 731 >>交任务: 健忘的勘察员
    .accept 741 >>接任务: 健忘的勘察员
step
    #completewith end
    .vendor >>补充库存/再补给
step
    .goto Felwood,22.24,18.22
    .turnin 995 >>交任务: 偷偷溜走
    .isOnQuest 995
step
    .goto Felwood,22.24,18.22
    .turnin 994 >>交任务: 杀出重围
    .isOnQuest 994
step
	#era/som
    .goto Darkshore,36.62,45.59
    .turnin 4730 >>交任务: 搁浅的海洋生物
    .turnin 4731 >>交任务: 搁浅的海龟
    .turnin 4732 >>交任务: 搁浅的海龟
    .turnin 4733 >>交任务: 搁浅的海洋生物
step
    #completewith next
    .fly Teldrassil>>飞往Teldrassil
step
    .goto Teldrassil,23.70,64.51
    .turnin 741 >>交任务: 健忘的勘察员
    .accept 942 >>接任务: 健忘的勘察员
step <<  !Dwarf/!Hunter
    #label end
    .hs >>赫斯返回阿斯特拉纳
step <<  Dwarf Hunter
    #label end
    .fly Ashenvale >>飞到灰谷
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance !Hunter
#name 19-20 赤脊山
#version 1
#group RestedXP 联盟 1-20
#next 20-21 黑海岸/灰谷
step
    #completewith start
    .goto StormwindClassic,55.21,7.04
    .vendor >>如果你没有，就买一个铜管
    >>这是一个限量供应项目，如果npc没有，请跳过此步骤
--    >>稍后的任务需要2个青铜管 << Rogue
    .bronzetube
step << !NightElf
	.isOnQuest 1338
    .goto StormwindClassic,58.08,16.52
    .turnin 1338 >>交任务: 卡尔·雷矛的订单
step << Warlock/Priest
     >>进入大楼。如果是升级版，请购买燃烧魔杖
     >>买一根非阴影魔杖很重要，你以后必须对付抵抗阴影伤害的怪物
    .goto StormwindClassic,42.65,67.16,14,0
    .goto StormwindClassic,42.84,65.14
    .collect 5210,1
step << Warlock
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,26.11,77.20
    .trainer >>训练你的职业咒语
step << Mage
    .goto StormwindClassic,37.69,82.09,10 >>爬上塔楼，然后穿过入口
    .trainer >>训练你的职业咒语
step << Paladin
    >>为Duthorian Rall执行任务。确保您拥有之前的10块亚麻布
    .goto StormwindClassic,39.80,29.77
    .turnin 1641 >>交任务: 圣洁之书
    .collect 6775,1,1642 --Tome of Divinity (1)
    .accept 1642 >>接任务: 圣洁之书
    .turnin 1642 >>交任务: 圣洁之书
    .accept 1643 >>接任务: 圣洁之书
step << Paladin
    .goto StormwindClassic,38.68,32.85
    .trainer >>训练你的职业咒语
step << Priest !NightElf
    .goto StormwindClassic,38.54,26.86
    .trainer >>训练你的职业咒语
step << Rogue !NightElf
    .goto StormwindClassic,74.64,52.82
    .trainer >>训练你的职业咒语
step << Warrior !NightElf
    >>进入指挥中心
    .goto StormwindClassic,74.91,51.55,20,0
    .goto StormwindClassic,78.67,45.80
    .trainer >>上楼去。训练你的职业咒语
step
    .goto StormwindClassic,57.0,57.6
     .train 201 >>与吴平交谈。训练1h剑 << Mage/Rogue/Warlock
     .train 1180 >>与吴平交谈。火车匕首 << Mage/Druid
     .train 202 >>与吴平交谈。训练2h剑 << Warrior/Paladin
step << Paladin
    .goto StormwindClassic,57.08,61.74
    .turnin 1643 >>交任务: 圣洁之书
    .accept 1644 >>接任务: 圣洁之书
    .turnin 1644 >>交任务: 圣洁之书
--  .accept 1780 >>接任务: 圣洁之书
step << Rogue
    .goto StormwindClassic,57.38,56.77
    >>与玛尔达交谈。为你的主手买把长剑，为你的副手买把克里斯。
    .collect 923,1 --Longsword
    .collect 2209,1 --Kris
step << !Human !Warlock
    #som
    #phase 3-6
     #completewith start
     .goto StormwindClassic,66.2,62.4
    .fp Stormwind >>获取暴风城飞行路线
step << !Human
    #era/som
     #completewith start
     .goto StormwindClassic,66.2,62.4
    .fp Stormwind >>获取暴风城飞行路线
step << NightElf
    .goto StormwindClassic,73.2,92.1
    .zone Elwynn Forest >>前往: 艾尔文森林
step << NightElf Warrior
    .goto Elwynn Forest,41.09,65.77
    .trainer >>训练你的职业咒语
step << NightElf Rogue/NightElf Priest
    >>进客栈，然后上楼
    .goto Elwynn Forest,43.17,65.70,20,0
    .goto Elwynn Forest,43.80,66.47,20,0
    .goto Elwynn Forest,43.28,65.72 << Priest
    .goto Elwynn Forest,43.87,65.94 << Rogue
    .trainer >>训练你的职业咒语
step << !Human !Warlock
    #som
    #phase 3-6
    #level 20
    >>跑向阿佐拉塔
    .goto Elwynn Forest,65.20,69.80
    .accept 94 >>接任务: 法师的眼线
step << NightElf
    #era/som
    #level 20
    >>跑向阿佐拉塔
    .goto Elwynn Forest,65.20,69.80
    .accept 94 >>接任务: 法师的眼线
step << Human/Warlock
    #som
    #phase 3-6
    .goto StormwindClassic,66.27,62.13
    .fly Redridge >>飞到雷德里奇山脉
step << !NightElf
    #era/som
    .goto StormwindClassic,66.27,62.13
    .fly Redridge >>飞到雷德里奇山脉
step << !Human !Warlock
    #som
    #phase 3-6
    #label start
    .goto Redridge Mountains,15.27,71.45
    .zone Redridge Mountains >>前往: 赤脊山
step << !Human
    #era/som
    #label start
    .goto Redridge Mountains,15.27,71.45
    .zone Redridge Mountains >>前往: 赤脊山
step << NightElf
    #era/som
    .goto Redridge Mountains,15.27,71.45
     >>前往Redridge/Elwynn边境
    .accept 244 >>接任务: 豺狼人的入侵
step << !Human !Warlock
    #som
    #phase 3-6
    .goto Redridge Mountains,15.27,71.45
     >>前往Redridge/Elwynn边境
    .accept 244 >>接任务: 豺狼人的入侵
step
    #som
    #phase 3-6
    .goto Redridge Mountains,30.73,59.99
    .turnin 244 >>交任务: 豺狼人的入侵 << !Human !Warlock
    .accept 246 >>接任务: 审时度势 << !Human !Warlock
step << NightElf
    #era/som
    .goto Redridge Mountains,30.73,59.99
    .turnin 244 >>交任务: 豺狼人的入侵
    .accept 246 >>接任务: 审时度势
step
    .goto Redridge Mountains,33.50,48.90
    .accept 20 >>接任务: 黑石氏族的威胁
step
    .goto Redridge Mountains,32.20,48.60
    .accept 125 >>接任务: 丢失的工具
step
    .goto Redridge Mountains,31.00,47.50
    .accept 118 >>接任务: 马掌
step
    .goto Redridge Mountains,29.80,44.50
    >>进入大楼
    .accept 120 >>接任务: 送往暴风城的信
step
    .goto Redridge Mountains,27.70,47.40
    .accept 127 >>接任务: 卖鱼
step
    .goto Redridge Mountains,26.80,44.40
    >>进入客栈
    .accept 129 >>接任务: 免费的午餐
step
    .goto Redridge Mountains,26.6,45.2
    >>上楼去
    .turnin 65 >>交任务: 迪菲亚兄弟会
    .isOnQuest 65
step
    #era/som
    .goto Redridge Mountains,22.70,44.00
    >>离开客栈。向西走，然后进入大楼
    .accept 92 >>接任务: 赤脊山炖肉
step
    .goto Redridge Mountains,21.85,46.32
    .accept 34 >>接任务: 不速之客
step << Warlock
     #completewith next
    .goto Redridge Mountains,15.68,49.30
     >>用风筝把Bellygrub引向湖郡守卫，杀死他
    .complete 34,1
    .link https://youtu.be/6JE967OG3CU?t=1845 >>点击此处查看视频参考
step << Warlock
    .goto Redridge Mountains,21.85,46.32
     >>这是一个很难在这个级别独奏的任务，如果你不能独奏《贝利格鲁布》，跳过这一步，你将有另一个机会稍后完成它
    .turnin 34 >>交任务: 不速之客
step
    .goto Redridge Mountains,29.30,53.60
    .accept 3741 >>接任务: 希拉里的项链
step
    >>在水下寻找希拉里的项链。它在一片褐色的泥土里
    .goto Redridge Mountains,27.80,56.05,0
    .goto Redridge Mountains,26.56,50.63,0
    .goto Redridge Mountains,23.96,55.17,0
    .goto Redridge Mountains,19.16,51.75,0
    .goto Redridge Mountains,31.12,54.21,0
    .goto Redridge Mountains,34.03,55.34,0
    .goto Redridge Mountains,38.09,54.49,0
    .goto Redridge Mountains,19.16,51.75,70,0
    .goto Redridge Mountains,38.09,54.49,70,0
    .complete 3741,1 --Hilary's Necklace (1)
step
    #softcore
    >>潜水。掠夺灰色盒子
    .goto Redridge Mountains,41.52,54.68
    .complete 125,1 --Oslow's Toolbox (1)
step
    #era
    #sticky
    #completewith orcs
    >>杀死野猪换5个大猩猩鼻子，秃鹫换5块硬秃鹫肉，蜘蛛换5块脆蜘蛛肉
    >>专注于这个任务。在交出任务之前，不要出售任何物品
    >>也保存你得到的任何大块野猪肉。你想在到达Darkhire之前得到50份烹饪
    .collect 2296,5,92,1
    .collect 1080,5,92,1
    .collect 1081,5,92,1
step
    #som
    #phase 1-2
    #sticky
    #completewith orcs
    >>杀死野猪换5个大猩猩鼻子，秃鹫换5块硬秃鹫肉，蜘蛛换5块脆蜘蛛肉
    >>专注于这个任务。在交出任务之前，不要出售任何物品
    .collect 2296,5,92,1
    .collect 1080,5,92,1
    .collect 1081,5,92,1
step
    .goto Redridge Mountains,15.30,71.50
    .accept 244 >>接任务: 豺狼人的入侵
step
    .goto Redridge Mountains,30.70,60.00
    .turnin 244 >>交任务: 豺狼人的入侵
    .accept 246 >>接任务: 审时度势
step
    .goto Redridge Mountains,15.27,71.45
    .turnin 129 >>交任务: 免费的午餐
    .accept 130 >>接任务: 寻访草药师
step
    #era/som
    .goto Redridge Mountains,9.35,78.96
    >>杀死蜘蛛。抢了他们来买脆蜘蛛肉
    .collect 1081,5,92,1
step
    .goto Redridge Mountains,31.65,82.56
    .complete 246,1 --Redridge Mongrel (10)
    .complete 246,2 --Redridge Poacher (6)
step
    .goto Redridge Mountains,49.0,70.0
    >>杀死穆洛克。抢走它们来换取鱼翅和太阳鱼
    .complete 127,1
    .collect 1468,8,150,1
step
    #era/som
    .goto Redridge Mountains,61.37,77.10
    >>杀死秃鹰。抢走他们的秃鹰肉
    >>如果周围没有秃鹰，跳过这一步
    .collect 1080,5,92,1
step
    #label orcs
    >>杀死兽人。掠夺他们以获取斧头
    .goto Redridge Mountains,74.00,79.00
    .complete 20,1 --Battleworn Axe (10)
step
    #era/som
    .goto Redridge Mountains,61.37,77.10
    >>杀死秃鹰。抢了他们来买脆秃鹰肉
    .collect 1080,5,92,1
step
    #hardcore
    >>潜水。掠夺灰色盒子
    .goto Redridge Mountains,41.52,54.68
    .complete 125,1 --Oslow's Toolbox (1)
step
    #era
    .xp 20-6300 >>研磨直到距离20级6300 xp
step
    #som
    .xp 20-8800 >>研磨，直到距离20级8800 xp
step << skip
     #softcore
     #completewith next
     .deathskip >>故意死在墓地
step
    #hardcore
    #completewith next
    .goto Redridge Mountains,30.73,59.99,150 >>跑回莱克郡
step
    .goto Redridge Mountains,30.73,59.99
    .turnin 246 >>交任务: 审时度势
step
    .xp 20 >>如果你还未达到20级，请交出你所有的Redridge任务，交出的任务应该足够了
step
    .goto Redridge Mountains,30.59,59.42
    .fp Redridge Mountains >>获得Redridge Mountains飞行路线 << !Human !Warlock
    .fly Stormwind >>飞往暴风城
step << Rogue
    .goto StormwindClassic,57.55,57.07
    >>如果你有足够的钱，就买一把长剑。21点装备
    >>如果便宜/更好，就从AH那里买东西
    >>如果您有更好的选择，请跳过此步骤
    .collect 923,1 --Longsword (1)
step << Warrior/Paladin
    #softcore
    .goto StormwindClassic,57.55,57.07
    >>如果你有足够的钱，就买一辆Dacian Falx。21点装备
    >>如果便宜/更好，就从AH那里买东西
    >>如果您有更好的选择，请跳过此步骤
    .collect 922,1 --Dacian Falx (1)
step << Warrior/Paladin
    #hardcore
    .goto StormwindClassic,57.55,57.07
    >>如果你有足够的钱，就买一辆Dacian Falx。21点装备
    >>如果您有更好的选择，请跳过此步骤
    .collect 922,1 --Dacian Falx (1)
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >>走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,26.11,77.20
    .trainer >>训练你的职业咒语
    .goto StormwindClassic,25.30,78.50
    .accept 1716 >>接任务: 噬魂者
step << Mage
    .goto StormwindClassic,37.69,82.09,10 >>爬上塔楼，然后穿过入口
    .trainer >>训练你的职业咒语
step << Mage
    .goto StormwindClassic,39.83,79.46
    .trainer >>从拉里曼(Larimaine)到暴风门(Stormwind Portal)的列车
step
    .goto StormwindClassic,21.40,55.80
    .accept 3765 >>接任务: 遥远的旅途
step << Druid
    .goto StormwindClassic,21.0,55.6
    .trainer >>训练你的职业法术(确保你得到猫形态)
step << Paladin
    .goto StormwindClassic,42.66,33.75,30,0
    .goto StormwindClassic,40.1,30.0
    >>与Duthorian Rall对话，右键单击提供的Tome of Valor
    .collect 6776,1,1649 --Tome of Valor (1)
    .accept 1649 >>接任务: 勇气之书
    .turnin 1649 >>交任务: 勇气之书
    .accept 1650 >>接任务: 勇气之书
step << Paladin
    .goto StormwindClassic,38.68,32.85
    .trainer >>训练你的职业咒语
step << Priest
    .goto StormwindClassic,42.66,33.75,30,0
    .goto StormwindClassic,38.54,26.86
    .trainer >>训练你的职业咒语
step << Rogue
    .goto StormwindClassic,74.90,54.00,20,0
    .goto StormwindClassic,78.67,59.48,20,0
    .goto StormwindClassic,75.75,60.36
    .trainer >>训练你的职业法术。确保列车开锁
    .accept 2281 >>接任务: 赤脊山的联络员
    .accept 2360 >>接任务: 马迪亚斯和迪菲亚潜行者
step << Warrior
    >>进入指挥中心
    .goto StormwindClassic,74.91,51.55,20,0
    .goto StormwindClassic,78.67,45.80
    .trainer >>上楼去。训练你的职业咒语
step
    .goto StormwindClassic,64.20,75.20
    .turnin 120 >>交任务: 送往暴风城的信
    .accept 121 >>接任务: 送往暴风城的信
step
    .goto Elwynn Forest,41.80,65.60
    >>离开暴风城前往金郡
    .turnin 118 >>交任务: 马掌
    .accept 119 >>接任务: 回复弗纳
step
    >>跑向阿佐拉塔
    .goto Elwynn Forest,65.20,69.80
    .accept 94 >>接任务: 法师的眼线
step
    #completewith RunR
    #label FlyR
    .goto StormwindClassic,66.30,62.30
    >>如果你在Goldshire，就回暴风城，然后飞往Redridge
    .fly Redridge >>飞到雷德里奇
step
    #completewith FlyR
    #label RunR
    .goto Redridge Mountains,15.27,71.45
    >>如果你在阿佐拉塔，跑去雷德里奇
    .zone Redridge Mountains >>前往: 赤脊山
step
    .goto Redridge Mountains,33.40,48.90
    .turnin 20 >>交任务: 黑石氏族的威胁
step
    .goto Redridge Mountains,32.00,48.80
    .turnin 125 >>交任务: 丢失的工具
    .accept 89 >>接任务: 止水湖上的桥
step
    .goto Redridge Mountains,31.00,47.20
    .turnin 119 >>交任务: 回复弗纳
    .accept 124 >>接任务: 豺狼人的乱吠
step
    #era
    .goto Redridge Mountains,31.00,47.20
    .accept 122 >>接任务: 雏龙的鳞片
step
    .goto Redridge Mountains,29.98,44.45
    .turnin 121 >>交任务: 送往暴风城的信
step
    .goto Redridge Mountains,29.20,53.60
     .turnin 3741 >>交任务: 希拉里的项链
step << Rogue
    .goto Redridge Mountains,28.07,52.02
    .turnin 2281 >>交任务: 赤脊山的联络员
    .accept 2282 >>接任务: 奥瑟尔伐木场
step
    .goto Redridge Mountains,27.72,47.38
    .turnin 127 >>交任务: 卖鱼
    .accept 150 >>接任务: 鱼人偷猎者
    .turnin 150 >>交任务: 鱼人偷猎者
step
    #era/som
    .isQuestComplete 92
    .goto Redridge Mountains,22.67,43.83
    .turnin 92 >>交任务: 赤脊山炖肉
step
    .goto Redridge Mountains,21.90,46.20
    .turnin 130 >>交任务: 寻访草药师
    .accept 131 >>接任务: 水仙诉衷情
step
    #era/som
    >>杀死野猪。为了大猩猩的鼻子而掠夺它们
    .goto Redridge Mountains,16.23,48.35,100,0
    .goto Redridge Mountains,32.25,70.20,100,0
    .goto Redridge Mountains,16.23,48.35
    .goto Redridge Mountains,32.25,70.20,0
    .collect 2296,5,92,1
step
    #era/som
    .goto Redridge Mountains,22.67,43.83
    .turnin 92 >>交任务: 赤脊山炖肉
step
    .goto Redridge Mountains,21.23,36.17,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,39.61,31.46,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,21.23,36.17,60,0
    .goto Redridge Mountains,34.20,39.70,60,0
    .goto Redridge Mountains,39.61,31.46,60,0
    .goto Redridge Mountains,22.5,35.7,0
    >>杀死侏儒。掠夺他们的长矛和铆钉
    .complete 89,1 --Iron Pike (5)
    .complete 89,2 --Iron Rivet (5)
    .complete 124,1 --Redridge Brute (10)
    .complete 124,2 --Redridge Mystic (8)
step
    #era
    #sticky
    #label scales
    .goto Redridge Mountains,35.0,69.0,0
    .goto Redridge Mountains,58.34,76.16,0
    .goto Redridge Mountains,24.0,35.0,0
    .complete 122,1 --Underbelly Whelp Scale (6)
step << Rogue
    >>解锁该区域的锁箱，直到你达到80技能
    >>达到80技能后打开卢修斯的锁箱
    .goto Redridge Mountains,52.05,44.69
    .complete 2282,1 --Token of Thievery
step
    .goto Redridge Mountains,26.80,44.30
    .turnin 131 >>交任务: 水仙诉衷情
step
    #era
    .goto Redridge Mountains,26.52,44.95
    #completewith next
    +在你之前收集的客栈里的火上煮大块野猪肉。确保你有50道菜
    >>如果你不想吃50个菜，那就去西边多养些野猪吧
    >>如果你在烹饪完所有东西后将烹饪到40岁或以下，跳过这一步
step
    #era
    .goto Redridge Mountains,31.00,47.30
    .turnin 124 >>交任务: 豺狼人的乱吠
    .turnin 122 >>交任务: 雏龙的鳞片
step
    #som
    .goto Redridge Mountains,30.97,47.27
    .turnin 124 >>交任务: 豺狼人的乱吠
step << Rogue
    .goto Redridge Mountains,28.07,52.02
    .turnin 2282 >>交任务: 奥瑟尔伐木场
step
    .goto Redridge Mountains,32.10,48.70
    .turnin 89 >>交任务: 止水湖上的桥
step << Rogue
    --#softcore
    .goto Westfall,68.5,70.0
    >>这是在威斯特福尔执行毒药任务的好时机，这个任务在20/21级很难完成，这一步是可选的，稍后在24级你还有机会执行
    .turnin 2360 >>交任务: 马迪亚斯和迪菲亚潜行者
    .link https://www.youtube.com/watch?v=t05Ux5Qis9k >>点击此处查看视频参考
step << Rogue
    --#softcore
    .goto Westfall,68.5,70.0
    .accept 2359 >>接任务: 克拉文之塔
    .isQuestTurnedIn 2360
step << Rogue
    --#softcore
    .goto Westfall,70.6,72.8
    >>盗取一个Defias Drones并抢夺塔钥匙
    .complete 2359,2 --Collect Defias Tower Key (x1)
    .link https://www.youtube.com/watch?v=t05Ux5Qis9k >>点击此处查看视频参考
    .isOnQuest 2359
step << Rogue
    --#softcore
    .goto Westfall,70.4,74.0
    >>爬到塔顶，从地板上的小箱子里抢东西
    .complete 2359,1 --Collect Klaven Mortwake's Journal (x1)
    .link https://www.youtube.com/watch?v=t05Ux5Qis9k >>点击此处查看视频参考
    .isOnQuest 2359
step << Rogue !Dwarf
    --#softcore
    .goto Duskwood,10.69,59.86,90,0
    .goto Duskwood,8.82,38.44
    >>在黄昏杀死蜘蛛
    >>为以后保存Gooey Spider Legs
    >>你需要一个毒液囊来制作抗毒液并清除桑齐毒液 << Rogue !Dwarf
    >>如果你有圣骑士或德鲁伊的朋友，你可以跳过这一步，让他们帮你删除它
    .collect 1475,1,2359,1 << Rogue !Dwarf
    .isOnQuest 2359
step << Rogue
    --#softcore
    #completewith next
    .goto Westfall,56.55,52.65
    .fly Stormwind >>飞到暴风城
step << Rogue
    --#softcore
    .goto StormwindClassic,74.90,54.00,20,0
    .goto StormwindClassic,78.67,59.48,20,0
     .goto StormwindClassic,75.9,59.9
    .turnin 2359 >>交任务: 克拉文之塔
    .isQuestComplete 2359
step << Rogue
    --#softcore
     .goto StormwindClassic,75.9,59.9
    .accept 2607 >>接任务: 赞吉尔之触
    .isQuestTurnedIn 2359
step << Rogue
    --#softcore
    .goto StormwindClassic,78.1,59.0
    >>去地下室
    .turnin 2607 >>交任务: 赞吉尔之触
    .isQuestTurnedIn 2359
step <<  NightElf
    .fp Ironforge>>飞往暴风城，乘坐电车前往铁炉堡，然后到达铁炉堡飞行路线
    >>如果您已经拥有铁炉堡飞行路线，请跳过此步骤
]])

RXPGuides.RegisterGuide([[
#classic
<< Alliance !Hunter
#name 20-21 黑海岸/灰谷
#version 1
#group RestedXP 联盟 1-20
#next RestedXP联盟20-30\21-23 Stonetalon/Ashenvale

step << Druid
    >>前往: 月光林地
    .goto Moonglade,52.53,40.56
    .trainer >>训练你的职业咒语
step
    .hs >>赫斯回到奥伯丁
step
    .goto Darkshore,37.44,41.83
    .accept 729 >>接任务: 健忘的勘察员
step
    .goto Darkshore,37.32,43.64
    .accept 948 >>接任务: 安努
step
    .goto Darkshore,37.21,44.22
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
    .goto Darkshore,39.37,43.48
    .accept 993 >>接任务: 丢失的主人
step
	#era/som
    #completewith Murkdeep
    .goto Darkshore,40.23,81.28,0
     >>杀死灰蓟熊。抢他们的头皮
    .complete 1003,1
    .isOnQuest 1003
step <<  NightElf
     #completewith next
    .goto Felwood,27.00,55.59
    .turnin 952 >>交任务: 古树之林
step
    .goto Felwood,27.00,55.59
    .turnin 948 >>交任务: 安努
    .accept 944 >>接任务: 主宰之剑
step
    .goto Ashenvale,22.36,3.98
     >>进入大师的Glaive，清除中间祭坛周围的暴徒
    .complete 944,1
step
    #sticky
    #label TheryluneE
     >>开始护送任务
    .accept 945 >>接任务: 护送瑟瑞露尼
step
    .goto Ashenvale,22.36,3.98
     >>把烤鸡蛋的碗扔在地上
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
    .complete 945,1 --Escort Therylune away from the Master's Glaive (1)
step
    #completewith next
    .goto Felwood,18.08,64.03
    .turnin 729 >>交任务: 健忘的勘察员
step
    .goto Darkshore,35.72,83.69
     >>开始护送任务
    .accept 731 >>接任务: 健忘的勘察员
step
     >>护送探矿者返程。确保他先攻击暴徒，否则他不会帮你杀了他们
    .complete 731,1
step
    >>掠夺残骸。要小心，因为甲壳虫会对闪电造成90点伤害，当它们的生命低于55%时，可以将电波完全治愈。
    .goto Ashenvale,13.97,4.10
    .accept 4733 >>接任务: 搁浅的海洋生物
step
    .goto Ashenvale,13.93,2.01
    .accept 4732 >>接任务: 搁浅的海龟
step
    .goto Felwood,13.47,64.01
    .accept 4731 >>接任务: 搁浅的海龟
step
    .goto Felwood,14.62,60.72
    .accept 4730 >>接任务: 搁浅的海洋生物
step
    #label Murkdeep
    .goto Darkshore,36.64,76.53
    >>清理穆洛克营地，保持安全距离
    >>靠近营地中的篝火召唤3波穆洛克：杀死1波和2波，然后在3波中杀死穆克迪普
    >>检查西边的海岸，看看Murkdeep是否已经活着。如果是，杀了他
    .unitscan Murkdeep
    .complete 4740,1
step
	#era/som
    .goto Darkshore,40.23,81.28
     >>杀死灰蓟熊。抢他们的头皮
    .complete 1003,1
    .isOnQuest 1003
step
	#era/som
    .goto Felwood,24.53,60.46
    .turnin 1003 >>交任务: 传声盒525号
    .isOnQuest 1003
step
    .goto Darkshore,45.00,85.30
    .turnin 993 >>交任务: 丢失的主人
    .accept 995 >>接任务: 偷偷溜走
step
     >>等待RP序列结束
    .complete 995,1
step
    .goto Felwood,27.00,55.59
    .turnin 951 >>交任务: 玛塞斯特拉遗物
    .isQuestComplete 951
step
    .goto Felwood,27.00,55.59
    .turnin 950 >>交任务: 向安努回复
step
    .goto Felwood,27.96,55.76
    >>与科隆尼安对话，开始护送任务
    >>如果他不在，你可以跳过这个任务(根据其他玩家的不同，重生最多需要25分钟)
    .accept 5321 >>接任务: 昏昏欲睡
step
    .isOnQuest 5321
    .goto Darkshore,44.38,76.30
     >>掠夺任务给予者旁边的箱子
    .complete 5321,1
step
     #completewith tower
     .zone Ashenvale >>前往: 灰谷
     .goto Ashenvale,29.7,13.6
step
    .goto Ashenvale,27.26,35.58
    >>在执行护送任务时，避免走在主要道路上
     .complete 5321,2
     .isOnQuest 5321
step
    .goto Ashenvale,27.26,35.58
    .turnin 5321 >>交任务: 昏昏欲睡
    .isQuestComplete 5321
step
    #label tower
    .goto Ashenvale,26.19,38.69
    .turnin 967 >>交任务: 奥萨拉克斯之塔
step
	#era/som
    .goto Ashenvale,26.19,38.69
    .accept 970 >>接任务: 奥萨拉克斯之塔
step
	#era/som
     #completewith next
    .goto Ashenvale,31.41,30.66
     >>杀死信徒。掠夺他们以获取发光的灵魂宝石
    .complete 970,1
step
	#era/som
     #completewith next
    .goto Ashenvale,26.19,38.69
    .turnin 970 >>交任务: 奥萨拉克斯之塔
step
    .xp 20 >>升级到20级
step
    .goto Ashenvale,26.43,38.59
    .accept 1010 >>接任务: 巴斯兰的头发
step
    .goto Ashenvale,31.63,22.33
     >>当心地上的药草袋
    .complete 1010,1
step
	#era/som
    .goto Ashenvale,31.41,30.66
     >>杀死信徒。掠夺他们以获取发光的灵魂宝石
    .complete 970,1
step
    #sticky
    #label hair
    .goto Ashenvale,26.43,38.59
    .turnin 1010 >>交任务: 巴斯兰的头发
    .accept 1020 >>接任务: 奥雷迪尔的药剂
step
	#era/som
    .goto Ashenvale,26.43,38.59
    .turnin 970 >>交任务: 奥萨拉克斯之塔
    .accept 973 >>接任务: 奥萨拉克斯之塔
step
    #requires hair
    >>跑向阿斯特拉纳
    .goto Ashenvale,34.40,48.00
    .fp Astranaar>>获取Astranaar飞行路线
step
    .goto Ashenvale,34.67,48.83
    .accept 1008 >>接任务: 佐拉姆海岸
step
    .goto Ashenvale,34.89,49.79
    .accept 1070 >>接任务: 守卫石爪山
step
    .goto Ashenvale,35.76,49.10
    .accept 1056 >>接任务: 石爪峰之旅
step
    .goto Ashenvale,36.61,49.58
    .accept 991 >>接任务: 莱恩的净化
    .accept 1054 >>接任务: 解除威胁
step << !Warlock
    #som
    .goto Ashenvale,36.99,49.22
    .home >>将您的炉石设置为Astranaar
step
    #timer Orendil's Cure RP
    .goto Ashenvale,37.36,51.79
    .turnin 1020 >>交任务: 奥雷迪尔的药剂
    .timer 26,Orendil's Cure RP
    .accept 1033 >>接任务: 月神之泪
]])
