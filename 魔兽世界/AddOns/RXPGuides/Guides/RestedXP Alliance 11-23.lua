RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 11-14 黑海岸
#version 1
#group RestedXP 联盟 1-20
#defaultfor !Draenei
#next 14-20 秘血岛
#xprate <1.5 << Warlock
step << !NightElf !Draenei wotlk
    #sticky
    .goto StormwindNew,21.8,56.2,20,0
    .goto StormwindNew,21.8,56.2,0
    .zone Darkshore >>乘船前往: 黑海岸
step
    >>与平台的Gwennyth ontop对话
    .goto Darkshore,36.6,45.6
    .accept 3524 >>接任务: 搁浅的巨兽
step << !NightElf
	.goto Darkshore,36.3,45.6
    .fp Auberdine >>获取奥伯丁飞行路线
step << NightElf
    .goto Darkshore,36.8,44.3
    .turnin 6342 >>交任务: 飞往奥伯丁
step << !Warlock/!Rogue
	.goto Darkshore,37.0,44.1
    .home >>将您的炉石设置为Auberdine
step
    >>上楼去
    .goto Darkshore,37.0,44.1
    .accept 983 >>接任务: 传声盒827号
step
    >>接受奥伯丁周围的任务
    .accept 2118 >>接任务: 瘟疫蔓延
    .goto Darkshore,38.8,43.4
    .accept 984 >>接任务: 熊怪的威胁
    .goto Darkshore,39.3,43.4
step << Dwarf Hunter tbc
    #sticky
    .train 2981 >>驯服蓟熊并学习爪2
    *Thistle Bears can stun, you have to use a dummy pet to tank the stun, abandon the pet and then tame the bear
step
	#sticky
	#label Crawlers
    .isOnQuest 983
    .waypoint Darkshore,36.7,52.4,40,0
	.waypoint Darkshore,35.6,47.6,40,0
	.waypoint Darkshore,36.2,44.5,40,0
	.waypoint Darkshore,36.7,52.4,40,0
	.waypoint Darkshore,35.6,47.6,40,0
	.waypoint Darkshore,36.2,44.5,40,0
	>>杀死沿海的螃蟹，并掠夺它们的腿
    .complete 983,1 --Collect Crawler Leg (x6)
step
    .isOnQuest 3524
    .goto Darkshore,36.4,50.8
	>>掠夺海滩生物
    .complete 3524,1 --Collect Sea Creature Bones (x1)
step
    .isOnQuest 2118
    .goto Darkshore,38.3,52.7,30,0
    .goto Darkshore,38.9,62.0,30,0
    .goto Darkshore,38.3,52.7,30,0
    .goto Darkshore,38.9,62.0,30,0
    .goto Darkshore,38.3,52.7
    >>继续向南走，直到你找到一只狂犬病熊，当你攻击一只时，用你袋子里的塔纳瑞恩希望
    .complete 2118,1 --Rabid Thistle Bear Captured
step
   #label Crawlers
    .goto Darkshore,38.9,53.0
    >>跑到弗波格营地的郊区，尽量不要激怒任何暴徒。
    .complete 984,1 --Find a corrupt furbolg camp
step
    #requires Crawlers
    .isOnQuest 983
    .goto Darkshore,36.6,46.3
    >>单击山上的机器
    .turnin 983 >>交任务: 传声盒827号
step
    .isOnQuest 3524
    .goto Darkshore,36.6,45.6
    >>返回站台上的格温尼思
    .turnin 3524 >>交任务: 搁浅的巨兽
    .accept 4681 >>接任务: 搁浅的巨兽
step
    #xprate <1.5
    .maxlevel 13
    .goto Darkshore,35.8,43.7
    .accept 963 >>接任务: 永志不渝
step
    .isOnQuest 4681
    .goto Darkshore,31.9,46.4
	>>在水下掠夺海龟骨头
    * You can run along the docks to get their faster than just swimming!
    .complete 4681,1 --Collect Sea Turtle Remains (x1)
step
    .isOnQuest 4681
    >>返回Gwennyth
    .goto Darkshore,36.6,45.6
    .turnin 4681,2 >>交任务: 搁浅的巨兽 << Druid/Paladin/Hunter
    .turnin 4681 >>交任务: 搁浅的巨兽 << !Druid !Paladin !Hunter
step << !Dwarf/!Hunter
    .xp 12 >>升级到12级
step << !Dwarf/!Hunter
    >>与哨兵Glynda和Tharnariun交谈
    .accept 4811 >>接任务: 红色水晶
    .goto Darkshore,37.7,43.4
    .turnin -2118 >>交任务: 瘟疫蔓延
    .goto Darkshore,38.8,43.4
step
#xprate <1.5
    .maxlevel 13
    .goto Darkshore,38.8,43.4
    .accept 2138 >>接任务: 清除疫病
step
    #xprate <1.5
    >>与大楼内的特伦蒂斯交谈
    .goto Darkshore,39.3,43.5
    .turnin 984 >>交任务: 熊怪的威胁
    .accept 985 >>接任务: 熊怪的威胁
    .accept 4761 >>接任务: 桑迪斯·织风
step
    #xprate >1.499
    >>与大楼内的特伦蒂斯交谈
    .goto Darkshore,39.3,43.5
    .turnin 984 >>交任务: 熊怪的威胁
    .accept 4761 >>接任务: 桑迪斯·织风
step << Druid
    .goto Darkshore,43.5,45.9
    .use 15208 >>使用洞穴内的塞纳里奥月光石，击败卢纳克劳，并在之后与他的灵魂对话
    .complete 6001,1 --Defeat Lunaclaw (x1)
step << !Dwarf/!Hunter
    .goto Darkshore,47.2,48.6
    >>当心，该地区的Moonkin愤怒地呼救，非常致命！
    .complete 4811,1 --Locate the large, red crystal on Darkshore's eastern mountain range
step << wotlk !Dwarf/!Hunter
    .deathskip >>死于附近的猫头鹰野兽并在奥伯丁产卵
step << !Dwarf/!Hunter
    .goto Darkshore,37.7,43.4
    .turnin 4811 >>交任务: 红色水晶
    .accept 4812 >>接任务: 清洗水晶
step << !Dwarf/!Hunter
    .goto Darkshore,37.8,44.0
	>>在月光井处注满水管
    .complete 4812,1 --Collect Moonwell Water Tube (x1)
step
    .goto Darkshore,37.4,40.2
    >>在市政厅大楼与桑德利斯交谈
    .turnin 4761 >>交任务: 桑迪斯·织风
    .accept 4762 >>接任务: 壁泉河 << !Warlock/!Rogue
    .accept 954 >>接任务: 巴莎兰
step
    #xprate <1.5
    .maxlevel 13
    .goto Darkshore,37.4,40.2
    .accept 958 >>接任务: 上层精灵的工具
step
    .goto Darkshore,44.1,36.3
    >>前往城东的废墟
    .turnin 954 >>交任务: 巴莎兰
    .accept 955 >>接任务: 巴莎兰
step << !Dwarf !Warlock/!Hunter !Warlock
    .goto Darkshore,47.3,48.6
    >>当你向东南方向转弯时，碾碎格雷尔。我们将在之后回来。
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step
    .goto Darkshore,44.8,37.2
	>>收集Grell耳环
    .complete 955,1 --Collect Grell Earring (x8)
step
    .goto Darkshore,44.2,36.3
    >>回到神殿
    .turnin 955 >>交任务: 巴莎兰
    .accept 956 >>接任务: 巴莎兰
step
    .goto Darkshore,45.6,36.9
	>>杀戮和掠夺巴沙拉兰的萨提尔人
    .complete 956,1 --Collect Ancient Moonstone Seal (x1)
step
    .goto Darkshore,44.2,36.3
    >>回到神殿
    .turnin 956 >>交任务: 巴莎兰
step
#xprate <1.5
    .maxlevel 14
    .goto Darkshore,44.2,36.3
    .accept 957 >>接任务: 巴莎兰
step << Warlock
    .goto Darkshore,47.3,48.6
    .turnin 4812 >>交任务: 清洗水晶
    .accept 4813 >>接任务: 水晶中的碎骨
step
#xprate <1.5
	#sticky
	#label bears
    #title Secondary Objective
    .maxlevel 14
    .goto Darkshore,42.3,66.9,0,0
	>>在你的任务中杀死狂犬病蓟熊
    .complete 2138,1 --Kill Rabid Thistle Bear (x20)
step << !Warlock/!Rogue
    #xprate >1.499
    .goto Darkshore,41.94,31.47
    .accept 4723 >>接任务: 搁浅的海洋生物
step << !Warlock/!Rogue
    #xprate >1.499
    .goto Darkshore,44.18,20.60
    .accept 4725 >>接任务: 搁浅的海龟
step << !Warlock/!Rogue
    .isOnQuest 4762
    .goto Darkshore,50.8,25.6
	.use 15844 >>使用瀑布底部的空采样管
    * Grind mobs en route if your hearthstone is less than 3 minutes from being off cooldown
    .complete 4762,1 --Collect Cliffspring River Sample (x1)
step << Druid
    #sticky
    #completewith next
    .goto Moonglade,44.1,45.2
    >>前往: 月光林地
    .fly Teldrassil>>飞往Teldrassil
step << Druid
    .goto Darnassus,35.4,8.4
    .turnin 6001 >>交任务: 身心之力
step << !Warlock/!Rogue
    #sticky
    #completewith next
    .hs >>奥伯丁之炉
step << !Dwarf/!Hunter
    >>与哨兵Glynda交谈
    .goto Darkshore,37.7,43.4
    .turnin 4813 >>交任务: 水晶中的碎骨
step << Dwarf Hunter
#xprate <1.5
    .maxlevel 14
    .goto Darkshore,37.7,43.4
    .accept 4811 >>接任务: 红色水晶
step << Dwarf Hunter
#xprate <1.5
    .isOnQuest 4811
    .goto Darkshore,47.2,48.6
    .complete 4811,1 --Locate the large, red crystal on Darkshore's eastern mountain range
step << !Dwarf/!Hunter
    #xprate <1.5
    .goto Darkshore,39.9,54.9
    >>向南前往弗堡营地
    .complete 985,1 --Kill Blackwood Pathfinder (x8)
    .complete 985,2 --Kill Blackwood Windtalker (x5)
step
    .maxlevel 14
    .goto Darkshore,40.3,59.7
    .accept 953 >>接任务: 亚米萨兰的毁灭
    #xprate <1.5
step
    .maxlevel 14
    .goto Darkshore,37.1,62.1
    .accept 4722 >>接任务: 搁浅的海龟
    #xprate <1.5
step
    #requires bears
	#sticky
	#label anaya
    .isOnQuest 963
	>>杀死Anaya Dawnrunner，她在Ameth’Aran附近巡逻
    .goto Darkshore,43.3,58.8,0
    .complete 963,1 --Collect Anaya's Pendant (x1)
    #xprate <1.5
step
    #requires bears
	#sticky
	#label relics1
    .goto Darkshore,42.0,59.3,0
	>>杀死幽灵。掠夺他们的文物
    .isOnQuest 958
    .complete 958,1 --Collect Highborne Relic (x7)
    #xprate <1.5
step
    #requires bears
	>>点击区域中的平板电脑阅读(您不必滚动页面)
    .complete 953,2 --Collect Read the Fall of Ameth'Aran (x1)
    .goto Darkshore,42.7,63.1,-1
    .complete 953,1 --Collect Read the Lay of Ameth'Aran (x1)
    .goto Darkshore,43.3,58.8,-1
	>>点击露台下的绿色火焰
    .complete 957,1 --Destroy the seal at the ancient flame (x1)
    .goto Darkshore,42.4,61.8,-1
    #xprate <1.5
step
#xprate <1.5
    #requires anaya
    .isOnQuest 953
    .goto Darkshore,40.3,59.7
    .turnin 953 >>交任务: 亚米萨兰的毁灭
step << Dwarf Hunter
    #requires relics1
    .isOnQuest 985
    .goto Darkshore,39.9,54.9
    .complete 985,1 --Kill Blackwood Pathfinder (x8)
    .complete 985,2 --Kill Blackwood Windtalker (x5)
step
#xprate <1.5
    #requires relics1
    #sticky
    #completewith next
    .goto Darkshore,42.0,58.3
    .isOnQuest 957
    .deathskip >>死在阿梅斯阿兰的北侧，死在北部墓地的灵雷兹
step
#xprate <1.5
    #requires relics1
    .isOnQuest 957
    .goto Darkshore,44.2,36.3
    .turnin 957 >>交任务: 巴莎兰
step
#xprate <1.5
    .isOnQuest 958
    .goto Darkshore,37.4,40.1
    .turnin 958 >>交任务: 上层精灵的工具
step << !Warlock/!Rogue
    >>回镇上去
    .turnin -4762 >>交任务: 壁泉河
    .goto Darkshore,37.4,40.1,-1
    .turnin -985 >>交任务: 熊怪的威胁
    .goto Darkshore,39.3,43.5,-1
    .isQuestComplete 4762
step << !Warlock/!Rogue
    #xprate >1.499
    .goto Darkshore,36.6,45.5
    .turnin 4725 >>交任务: 搁浅的海龟
    .turnin 4727 >>交任务: 搁浅的海龟
    .turnin -4723 >>交任务: 搁浅的海洋生物
step
#xprate <1.5
    .goto Darkshore,38.8,43.4
    .turnin 2138 >>交任务: 清除疫病
    .isQuestComplete 2138
step << Dwarf Hunter
    .goto Darkshore,37.7,43.4
    .turnin 4811 >>交任务: 红色水晶
    .isQuestComplete 4811
step
#xprate <1.5
    .isOnQuest 4722
    .goto Darkshore,36.6,45.6
    .turnin 4722 >>交任务: 搁浅的海龟
    .turnin -4723 >>交任务: 搁浅的海洋生物
step
#xprate <1.5
    .isQuestComplete 963
    .goto Darkshore,35.7,43.7
    .turnin 963 >>交任务: 永志不渝
step << Druid tbc
    #completewith next
    >>前往: 月光林地
    .goto Moonglade,52.4,40.6
    .trainer 12042 >>火车咒语
step << Druid tbc
    .goto Moonglade,48.1,67.2
    .fly Auberdine>>飞到黑海岸
step << Warlock wotlk/Rogue wotlk
    .xp >>升级到14级
step << Warlock wotlk/wotlk Gnome Rogue/wotlk Human Rogue/wotlk Dwarf Rogue
    .hs >>从火炉到暴风
step << wotlk Night Elf Rogue
    .hs >>达纳苏斯之赫斯
step << wotlk Night Elf Rogue
    .goto Teldrassil,56.4,60.1
	.trainer >>去训练你的法术吧
step << wotlk Night Elf Rogue
    .zone Darkshore >>前往: 黑海岸, 带着两只野猪前往蔚蓝岛
    .zoneskip Azuremyst Isle
step << Warlock wotlk
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,15,0
    .goto StormwindClassic,27.2,78.1,10 >>走进屠宰羔羊
step << Warlock wotlk
    .goto StormwindClassic,25.2,78.5
    .train 6222 >>培训腐败r2
    >>如果你有多余的现金，培训会耗尽生命
step << Warlock wotlk
    >>进入大楼。如果你有钱买个阴燃魔杖
    .goto StormwindClassic,42.65,67.16,14,0
    .goto StormwindClassic,42.84,65.14
    .collect 5208,1 --Smoldering Wand (1)
    .money >0.3174
step << Rogue wotlk
	.goto StormwindClassic,74.6,52.8
	.trainer >>训练你的职业咒语
step << Warlock wotlk/wotlk Gnome Rogue/wotlk Human Rogue/wotlk Dwarf Rogue
    .goto StormwindNew,21.8,56.2
    .zone Darkshore >>乘船前往: 黑海岸
    .zoneskip Azuremyst Isle
step
	#label DarkshoreEnd
    .goto Darkshore,30.8,41.0
    .zone Azuremyst Isle >>前往: 秘蓝岛
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 14-20 秘血岛
#version 1
#group RestedXP 联盟 1-20
#defaultfor !Draenei
#next RestedXP联盟20-32\20-21 Darkshore << !Warlock
#next RestedXP联盟20-32\20-23 Darkshore/Ashenvale << Warlock
step
    .goto The Exodar,68.3,63.5
    .fp Exodar >>获取the Exodar飞行路线
step << Shaman
	.goto The Exodar,49.5,36.9,70,0
	.goto The Exodar,33.2,24.6
	.trainer >>《异国他乡》中的火车咒语
step << Mage
	.goto The Exodar,51.0,46.8,80,0
	.goto The Exodar,47.2,62.3
    .trainer >>《异国他乡》中的火车咒语
step << Hunter
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,47.6,88.3
	.trainer >>《异国他乡》中的火车咒语
step << Warrior
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,55.6,82.3
	.trainer >>《异国他乡》中的火车咒语
step << Hunter/Warrior tbc/Paladin
	>>进入《外族人》，与交易层顶层的武器大师交谈
    .goto The Exodar,53.3,85.7
    .train 202 >>训练2h剑 << Hunter/Warrior tbc/Paladin
	.train 5011 >>火车十字弓 << Hunter
step
    .goto Bloodmyst Isle,63.4,88.7
	.zone Bloodmyst Isle >>前往: 秘血岛
step
	#sticky
	#completewith monunment
    #title Secondary Objective
	>>收集血晶岛上任何暴徒的辐照水晶碎片。不要把这些扔掉。
	.collect 23984,10 -- Collect Irradiated Crystal Shard (x10)
step
    >>与牧场的德雷尼族人交谈
    .accept 9624 >>接任务: 美味的点心
    .goto Bloodmyst Isle,63.5,88.8
    .accept 9634 >>接任务: 大战异型掠夺者
    .goto Bloodmyst Isle,63.1,88.0
    .maxlevel 14
step
	#label pears
    #sticky
    #completewith kesselstart
    .goto Bloodmyst Isle,59.3,89.1,0,0
	>>确定此任务的优先级。收集地上的小梨子。它们可能很难被发现，在树周围检查一下。一次只能产生有限数量的它们，如果你看不到任何，请尝试区域的另一边。
    .complete 9624,1 --Collect Sand Pear (x10)
    .isOnQuest 9624
step
    .goto Bloodmyst Isle,59.3,89.1,40,0
    .goto Bloodmyst Isle,59.2,81.9,40,0
    .goto Bloodmyst Isle,59.3,89.1
    .complete 9634,1 --Kill Bloodmyst Hatchling (x10)
    .isOnQuest 9634
step
    #requires pears
    >>回到牧场
    .goto Bloodmyst Isle,63.4,88.7
    .turnin 9624,3 >>交任务: 美味的点心 << Warrior/Paladin
    .turnin 9624 >>交任务: 美味的点心 << !Warrior !Paladin
    .isQuestComplete 9624
step
    .goto Bloodmyst Isle,63.1,87.9
    .turnin 9634,1 >>交任务: 大战异型掠夺者 << Paladin
    .turnin 9634 >>交任务: 大战异型掠夺者 << !Paladin
    .isQuestComplete 9634
step
    #label kesselstart
    >>与Kessel交谈
    .goto Bloodmyst Isle,63.0,87.5
    .accept 9663 >>接任务: 凯希尔的信使
step
    #sticky
    #completewith next
    >>使用坐骑buff跑向血腥守卫，如果你向右跳过河绕过大桥，你就不会下车
    .abandon 9663 >>失去坐骑buff后放弃Kessel Run
step
    .goto Bloodmyst Isle,53.3,57.7
    .accept 9629 >>接任务: 研究鱼人
step
    #sticky
    #completewith next
    .goto Bloodmyst Isle,55.7,59.7
    .home >>将您的炉石设置为血液观察
step
    >>接受血液观察周围的任务。
    >>与通缉海报和辩护人Aalesia交谈
    .accept 9646 >>接任务: 通缉：死爪
    .goto Bloodmyst Isle,55.2,59.2
    .accept 9567 >>接任务: 知己知彼
    .goto Bloodmyst Isle,55.0,58.0
    >>与Tracker和Maatparm交谈
    .accept 9580 >>接任务: 猎熊
    .goto Bloodmyst Isle,55.9,56.9
    .accept 9643 >>接任务: 荆棘巨藤
    .goto Bloodmyst Isle,56.4,56.8
    .accept 9648 >>接任务: 玛特帕尔姆蘑菇展
    .goto Bloodmyst Isle,56.4,56.8
step << Paladin
	.goto Bloodmyst Isle,55.6,55.4
	.trainer >>维护者伊索的火车课咒语
step
    >>与维护者Boros交谈
    .goto Bloodmyst Isle,55.4,55.4
    .accept 9641 >>接任务: 辐射水晶碎片
step
	.goto Bloodmyst Isle,55.4,55.4
	.itemcount 23984,10
	.turnin 9641,3 >>交任务: 辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9641,2 >>交任务: 辐射水晶碎片 << Mage/Priest/Warlock
    .turnin 9641 >>交任务: 辐射水晶碎片 << Druid
step << Human Warrior/Human Paladin/Human Rogue
    .goto Bloodmyst Isle,56.2,54.2
    .train 2580 >>与熔炉旁的侏儒交谈。训练采矿，铸造寻找矿物
step
    >>与山上建筑中的德雷尼人交谈
    .goto Bloodmyst Isle,52.7,53.3
    .accept 9693 >>接任务: 阿古斯的意义
    .accept 9581 >>接任务: 研究水晶
step << Dwarf Hunter
    .goto Bloodmyst Isle,55.4,55.4
    .turnin 9693 >>交任务: 阿古斯的意义
    .accept 9694 >>接任务: 秘血岗哨
step << Dwarf Hunter
    >>杀死该地区的血精灵
    .goto Bloodmyst Isle,48.5,46.8
    .complete 9694,1 --Kill Sunhawk Spy (x10)
step << Dwarf Hunter
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9694 >>交任务: 秘血岗哨
    .accept 9779 >>接任务: 拦截情报
step
	#sticky
    #label bloodmushroom
    .goto Bloodmyst Isle,42.9,71.3,0
	>>在血囊中寻找小的红色蘑菇
    .complete 9648,2 --Collect Blood Mushroom (x1)
step
	#sticky
	#label monument
    .goto Bloodmyst Isle,36.5,71.5
	>>点击纪念碑上的小标志
    .complete 9567,1 --Collect Nazzivus Monument Glyph (x1)
step
    .goto Bloodmyst Isle,38.2,81.7,60,0
	.goto Bloodmyst Isle,36.5,71.5,60,0
	.goto Bloodmyst Isle,38.2,81.7
    .use 23900 >>杀死在该地区游荡的恶魔守卫泽拉克。
    >>抢走他的装甲牌，然后在你的包里点击它。
    *He walks from the summoning sigil to the monument and then despawn, a full spawn/despawn cycle takes about 6 minutes.
	.collect 23900,1,9594 --Tzerak's Armor Plate
    .accept 9594 >>接任务: 军团的徽记
	.unitscan Tzerak
step
    #requires monument
    #sticky
    #completewith mtag1
    .goto Bloodmyst Isle,37.0,78.7
	>>在萨提尔地区附近寻找小的绿色蘑菇
    .complete 9648,4 --Collect Fel Cone Fungus (x1)
step
	#requires monument
    .goto Bloodmyst Isle,37.0,78.7
	>>杀死该地区的萨特尔斯和费卢瓦。你可能必须杀死盗贼才能迫使你所需要的萨提尔重生。
    .complete 9594,1 --Kill Nazzivus Satyr (x8)
    .complete 9594,2 --Kill Nazzivus Felsworn (x8)
    .isOnQuest 9594
step
	#label mtag1
    #sticky
    .goto Bloodmyst Isle,35.6,94.2,0,0
    .goto Bloodmyst Isle,51.3,93.9,0,0
	.use 23995 >>用你包里的黑淤泥标记器标记侦察兵。这将使他们对你没有敌意。
    .complete 9629,1 --Blacksilt Scouts Tagged (x6)
step
    .goto Bloodmyst Isle,51.1,93.1,70,0
    .goto Bloodmyst Isle,43.0,94.4,70,0
    .goto Bloodmyst Isle,35.1,93.7
	.line Bloodmyst Isle,51.1,93.1,43.0,94.4,35.1,93.7
	.use 23870 >>杀死在穆洛克营地周围巡逻的名为“残忍”的穆洛克。抢他去拿吊坠。在您的包中点击它
	.collect 23870,1,9576 --Red Crystal Pendant (1)
    .accept 9576 >>接任务: 克鲁芬的项链
	.unitscan Cruelfin
step
    #requires mtag1
    .goto Bloodmyst Isle,58.2,83.4
	.use 23875 >>用包里的镐来收集红色小水晶
    .complete 9581,1 --Collect Impact Site Crystal Sample (x1)
step
    .goto Bloodmyst Isle,57.8,73.4
	>>在水下掠夺一个大的红色蘑菇，它们也可以从鱼身上掉下来
    .complete 9648,1 --Collect Aquatic Stinkhorn (x1)
step
    .goto Bloodmyst Isle,53.3,57.9
	>>途中碾碎暴徒
    .turnin 9576 >>交任务: 克鲁芬的项链
    .turnin 9629,1 >>交任务: 研究鱼人 << Warrior/Paladin
    .turnin 9629 >>交任务: 研究鱼人 << !Warrior !Paladin
    .accept 9574 >>接任务: 腐蚀的牺牲品
step
    #completewith next
    .goto Bloodmyst Isle,53.3,56.6
    .vendor >>供应商垃圾和维修
step
    .goto Bloodmyst Isle,51.3,75.7
	>>杀死该区域周围的树人，并掠夺树皮。在途中碾碎暴徒。
    .complete 9574,1 --Collect Crystallized Bark (x6)
step << Rogue/Warlock
    #completewith next
    .hs >>炉灶回到Blood Watch
step
    #requires bloodmushroom
    >>返回城镇
    .goto Bloodmyst Isle,53.3,57.8
    .turnin 9574 >>交任务: 腐蚀的牺牲品
    .accept 9578 >>接任务: 搜寻加莱恩
step
    >>与维护者Aalesia交谈
    .goto Bloodmyst Isle,55.0,58.1
    .turnin 9594 >>交任务: 军团的徽记
	.isQuestComplete 9594
step
    .goto Bloodmyst Isle,54.9,58.0
    .turnin 9567 >>交任务: 知己知彼
step << !Dwarf/!Hunter
    >>与维护者Boros交谈
    .goto Bloodmyst Isle,55.4,55.4
    .turnin 9693 >>交任务: 阿古斯的意义
    .accept 9694 >>接任务: 秘血岗哨
step
	.goto Bloodmyst Isle,55.4,55.4
	.itemcount 23984,10
	.turnin 9641,3 >>交任务: 辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9641,2 >>交任务: 辐射水晶碎片 << Mage/Priest/Warlock
    .turnin 9641 >>交任务: 辐射水晶碎片 << Druid
step
    >>进入山上的建筑物
    .goto Bloodmyst Isle,52.6,53.3
    .turnin 9581,2 >>交任务: 研究水晶 << Warrior/Paladin
    .turnin 9581 >>交任务: 研究水晶 << !Warrior !Paladin
    .accept 9620 >>接任务: 失踪的测量小组
step << !Dwarf/!Hunter
    >>杀死该地区的血精灵。尽量在南边结束，我们将在之后返回城镇。
    .goto Bloodmyst Isle,48.5,46.8
    .complete 9694,1 --Kill Sunhawk Spy (x10)
step << !Dwarf/!Hunter
    >>与维护者Boros交谈
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9694,3 >>交任务: 秘血岗哨 << Hunter
    .turnin 9694 >>交任务: 秘血岗哨 << !Hunter
    .accept 9779 >>接任务: 拦截情报
step
    .goto Bloodmyst Isle,47.7,46.6
	>>杀死Sunhawk间谍并为他们的信件洗劫他们。
    .complete 9779,1 --Collect Sunhawk Missive (x1)
step
    >>往东走，和那加废墟中的尸体交谈
    .goto Bloodmyst Isle,61.3,48.6
    .turnin 9620 >>交任务: 失踪的测量小组
    .accept 9628 >>接任务: 夺回数据
step
	#sticky
	#label bluemushroom
    .goto Bloodmyst Isle,60.7,49.1
	>>在那加废墟周围掠夺一只蓝色小蘑菇
    .complete 9648,3 --Collect Ruinous Polyspore (x1)
step
    .goto Bloodmyst Isle,64.4,41.8
	>>杀死这个地区周围的纳加人，然后将他们洗劫一空
    .complete 9628,1 --Collect Survey Data Crystal (x1)
step
    #requires bluemushroom
    >>横渡大洋去岛上
    .goto Bloodmyst Isle,74.3,33.4
    .accept 9687 >>接任务: 找回尊严
step
	#sticky
	#completewith next
	.deathskip >>在血液观察站死去并重生
step
    >>与Maatparm交谈
    .goto Bloodmyst Isle,56.4,56.8
    .turnin 9648,3 >>交任务: 玛特帕尔姆蘑菇展 << Warrior/Paladin
    .turnin 9648 >>交任务: 玛特帕尔姆蘑菇展 << !Warrior !Paladin
    .accept 9649 >>接任务: 伊瑟拉之泪
step
    .goto Bloodmyst Isle,55.4,55.4
    >>与维护者Boros交谈
    .turnin 9779 >>交任务: 拦截情报
    .accept 9696 >>接任务: 翻译......
step << !Rogue !Warlock
    >>在笼子旁与爱丽西亚交谈
    .goto Bloodmyst Isle,54.5,54.5
    .turnin 9696 >>交任务: 翻译......
    .accept 9698 >>接任务: 会见先知
step << Rogue/Warlock
    >>在笼子旁与爱丽西亚交谈
    .goto Bloodmyst Isle,54.5,54.5
    .turnin 9696 >>交任务: 翻译......
step
    >>到山上的房子里
    .goto Bloodmyst Isle,52.6,53.3
    .turnin 9628 >>交任务: 夺回数据
    .accept 9584 >>接任务: 第二份样本
step
    >>与树边的侏儒交谈
    .goto Bloodmyst Isle,56.3,54.3
    .accept 10063 >>接任务: 探险者协会要为侏儒服务吗？
step << !Rogue !Warlock
	.goto Bloodmyst Isle,57.9,53.5
    .fly Exodar>>飞到外族人
step << !Rogue !Warlock
    #completewith audience
	.goto The Exodar,75.0,54.8,80,0
	.goto The Exodar,64.4,42.4,80,0
    .goto The Exodar,56.9,50.2,100 >>头撞到外族人
step << Mage/Priest
    #completewith hs1
    .goto The Exodar,46.6,61.2
    .vendor 16632>>如果你还没有魔杖，请购买一个阴燃魔杖(13 dps)
    >>你可以试着从拍卖行买一根更好的魔杖
    .collect 5208,1,0,1,1 --Smoldering Wand (1)
step << Shaman
	.goto The Exodar,49.5,36.9,70,0
	.goto The Exodar,33.2,24.6
	.trainer >>《异国他乡》中的火车咒语
step << Mage
	.goto The Exodar,51.0,46.8,80,0
	.goto The Exodar,47.2,62.3,20,0
	    .goto The Exodar,46.0,62.7
    .trainer >>《异国他乡》中的火车咒语
step << Hunter
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,47.6,88.3
	.trainer >>《异国他乡》中的火车咒语
step << Warrior
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,55.6,82.3
	.trainer >>《异国他乡》中的火车咒语
step << Priest
    >>进入外族人并训练你的法术
    .trainer >>训练你的职业咒语
    .goto The Exodar,39.2,51.3
step << !Rogue !Warlock
    #label audience
    .goto The Exodar,32.8,54.4
    >>与Velen交谈
    .turnin 9698 >>交任务: 会见先知
    .accept 9699 >>接任务: 真相还是谎言
step << Druid
    >>前往: 月光林地
    .goto Moonglade,52.4,40.6
    .trainer 12042 >>火车咒语
step << !Warlock !Rogue
    #label hs1
    .hs >>炉灶回到Blood Watch
    .zoneskip Bloodmyst Isle
step
    >>与维护者Aalesia交谈
    .accept 9569 >>接任务: 化解危机
    .goto Bloodmyst Isle,55.0,58.0
    >>与米堡交谈
    .turnin -9699 >>交任务: 真相还是谎言
    .goto Bloodmyst Isle,55.4,55.4
    .accept 9700 >>接任务: 黑暗中的魔法
step
    .itemcount 23984,10
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9642,3 >>交任务: 更多辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9642,2 >>交任务: 更多辐射水晶碎片 << Warlock/Priest/Mage
    .turnin 9642 >>交任务: 更多辐射水晶碎片 << Druid
step
    .goto Bloodmyst Isle,45.7,47.9
	.use 23875 >>用你袋子里的镐来收集水晶样品
    .complete 9584,1 --Collect Altered Crystal Sample (x1)
step
	#sticky
	#completewith gnomeyboi
	#label constrictors
    >>杀死变异收缩肌。抢走他们的葡萄藤
    .complete 9643,1 --Collect Thorny Constrictor Vine (x6)
step
	#sticky
	#completewith next
	>>杀死熊。抢他们的熊侧翼
	.complete 9580,1 --Elder Brown Bear Flank (8)
step
    #label gnomeyboi
    .goto Bloodmyst Isle,42.0,21.2
    >>与龟壳里的侏儒交谈
    .turnin 10063 >>交任务: 探险者协会要为侏儒服务吗？
    .accept 9548 >>接任务: 被偷走的设备
    .accept 9549 >>接任务: 黑沙神器
step
	.goto Bloodmyst Isle,42.0,21.2
	.vendor >>从Clopper Wizbang(限量供应)处购买青铜管，如果他没有，请跳过此步骤
	.collect 4371,1,175,1,1
	.bronzetube
step
    #sticky
    #label crate
        .goto Bloodmyst Isle,40.4,20.4,60,0
	.goto Bloodmyst Isle,38.5,22.5,30,0
	.goto Bloodmyst Isle,36.0,25.8,30,0
	.goto Bloodmyst Isle,40.4,20.4,30,0
	.goto Bloodmyst Isle,43.8,22.4,30,0
	.goto Bloodmyst Isle,46.4,20.5,30,0
	.goto Bloodmyst Isle,40.4,20.4
    >>掠夺可以在任何一个穆洛克营地产卵的板条箱
    .complete 9548,1 --Collect Clopper's Equipment (x1)
step
    .goto Bloodmyst Isle,39.5,20.7
	>>杀戮和掠夺墨洛克人
    .complete 9549,1 --Collect Crude Murloc Idol (x3)
    .complete 9549,2 --Collect Crude Murloc Knife (x6)
step
    #requires crate
	#label bloodmyst1
    .goto Bloodmyst Isle,42.1,21.2
    .turnin 9548 >>交任务: 被偷走的设备
    .turnin 9549 >>交任务: 黑沙神器
step
    .goto Bloodmyst Isle,42.1,21.2
	.vendor >>从Clopper Wizbang(限量供应)处购买青铜管，如果他没有或你已经有了，请跳过此步骤
	.collect 4371,1,175,1,1
	.bronzetube
step
	#sticky
	#completewith gnome
    >>杀死变异收缩肌。抢走他们的葡萄藤
    .complete 9643,1 --Collect Thorny Constrictor Vine (x6)
step
	#sticky
	#completewith vinesdoneboss
	>>杀死熊。抢他们的熊侧翼
	.complete 9580,1 --Elder Brown Bear Flank (8)
step
    .goto Bloodmyst Isle,53.1,20.3
    .use 23837 >>点击你袋子里的黑色淤泥任务的人工制品中的风化藏宝图
	.collect 23837,1,9550 --Collect Weathered Treasure Map (x1)
    .accept 9550 >>接任务: 一张地图？
step
	#sticky
	#label SunPortalSite
    .goto Bloodmyst Isle,53.1,20.3
	>>靠近飞船般的建筑
	.complete 9700,1 --Sun Portal Site Confirmed (1)
step
    #label gnome
    .goto Bloodmyst Isle,52.5,25.2
	>>消灭该区域的虚空异常
    .complete 9700,2 --Kill Void Anomaly (x5)
step
    #requires SunPortalSite
    #label vinesdoneboss
	.goto Bloodmyst Isle,47.6,24.9,60,0
	.goto Bloodmyst Isle,44.9,26.4,100,0
	.goto Bloodmyst Isle,48.3,33.4,100,0
	.goto Bloodmyst Isle,45.1,37.4,100,0
	.goto Bloodmyst Isle,40.8,41.9,100,0
	.goto Bloodmyst Isle,34.0,44.3,100,0
	.goto Bloodmyst Isle,39.0,48.1,120,0
	.goto Bloodmyst Isle,42.5,49.3,100,0
	.goto Bloodmyst Isle,47.6,24.9
    >>杀死变异的Constrictors并掠夺他们的葡萄藤
	.complete 9643,1 --Collect Thorny Constrictor Vine (x6)
step
    .goto Bloodmyst Isle,54.0,30.9,60,0
    .goto Bloodmyst Isle,53.9,35.4,60,0
    .goto Bloodmyst Isle,57.0,34.3,60,0
    .goto Bloodmyst Isle,56.1,40.2
	>>在树营地的地上掠夺龙骨。尽量朝东南方向结束。
    .complete 9687,1 --Collect Dragon Bone (x8)
step
    .goto Bloodmyst Isle,61.1,41.9
    >>与废墟中的书交谈
    .turnin 9550 >>交任务: 一张地图？
    .accept 9557 >>接任务: 破译书籍
step
    .hs >>听到或跑回镇上与安克丽特·帕修斯交谈。不要等待他的角色扮演序列。
    .goto Bloodmyst Isle,54.7,54.1
    .turnin 9557 >>交任务: 破译书籍
step
    >>向山上的大楼走去
    .goto Bloodmyst Isle,52.6,53.3
    .turnin 9584 >>交任务: 第二份样本
    .accept 9585 >>接任务: 最终的样本
    .accept 10064 >>接任务: 阿古斯之手
step
    >>返回安克雷特
    .goto Bloodmyst Isle,54.7,54.0
    .accept 9561 >>接任务: 诺尔凯的日记
step
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9700,3 >>交任务: 黑暗中的魔法 << Warrior/Paladin
    .turnin 9700 >>交任务: 黑暗中的魔法 << !Warrior !Paladin
    .accept 9703 >>接任务: 冷却核心
step
    .itemcount 23984,10
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9642,3 >>交任务: 更多辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9642,2 >>交任务: 更多辐射水晶碎片 << Warlock/Priest/Mage
    .turnin 9642 >>交任务: 更多辐射水晶碎片 << Druid
step
	#label flutterers
    >>与Tracker Lyceon交谈
    .goto Bloodmyst Isle,55.9,56.9
    .turnin 9643 >>交任务: 荆棘巨藤
    .accept 9647 >>接任务: 消灭巨蛾
step
	.goto Bloodmyst Isle,55.9,56.9
	.isQuestComplete 9580
	.turnin 9580 >>交任务: 猎熊
step
	#requires flutterers
	#sticky
	#completewith bloodmyst2
	>>在你的任务中杀死飞翔者
    .complete 9647,1 --Kill Royal Blue Flutterer (x10)
step
    .goto Bloodmyst Isle,37.5,61.3
    >>优先处理任务中的转向，不要研磨精灵。
    .turnin 9578 >>交任务: 搜寻加莱恩
    .accept 9579 >>接任务: 加莱恩的命运
    .accept 9706 >>接任务: 加莱恩的日记 - 守备官撒鲁安的命运
step
    .goto Bloodmyst Isle,37.8,58.9
	>>杀戮和掠夺附近的血精灵
    .complete 9579,1 --Collect Galaen's Amulet (x1)
    .complete 9703,1 --Collect Medical Supplies (x12)
step
    .isQuestComplete 9579
    >>返回城镇
    .goto Bloodmyst Isle,53.3,57.7
    .turnin 9579 >>交任务: 加莱恩的命运
step
    >>与Achelus交谈
    .goto Bloodmyst Isle,53.3,57.2
    .accept 9669 >>接任务: 覆灭的远征队
step
    #completewith next
    .goto Bloodmyst Isle,53.3,56.7
    .vendor >>供应商和维修
step
    >>与维护者Kuros交谈
    .goto Bloodmyst Isle,55.6,55.1
    .turnin 9703,1 >>交任务: 冷却核心 << Paladin
    .turnin 9703 >>交任务: 冷却核心 << !Paladin
    .turnin 9706 >>交任务: 加莱恩的日记 - 守备官撒鲁安的命运
    .accept 9711 >>接任务: 残忍的玛提斯
    .accept 9748 >>接任务: 毒水
step
	#sticky
	#completewith bearend
    .isOnQuest 9580
	>>杀死熊。抢他们的熊侧翼
	.complete 9580,1 --Elder Brown Bear Flank (8)
step
    .goto Bloodmyst Isle,41.3,30.6
	.use 23875 >>用你袋子里的镐来收集水晶样品
    .complete 9585,1 --Collect Axxarien Crystal Sample (x1)
step
    .goto Bloodmyst Isle,41.9,29.6
	>>杀死萨蒂尔，在营地周围收集水晶
    .complete 9569,1 --Kill Zevrax (x1)
    .complete 9569,2 --Kill Axxarien Shadowstalker (x5)
    .complete 9569,3 --Kill Axxarien Hellcaller (x5)
    .complete 9569,4 --Collect Corrupted Crystal (x5)
step
	#completewith AliveM
    .goto Bloodmyst Isle,43.9,43.7,40,0
    .goto Bloodmyst Isle,30.1,51.7,40,0
    .goto Bloodmyst Isle,22.4,54.3,40,0
    .goto Bloodmyst Isle,43.9,43.7
	.line Bloodmyst Isle,43.1,43.7,36.5,47.2,33.5,47.1,29.9,51.8,27.7,51.8,25.1,54.1,22.0,54.3
    .use 24278 >>寻找残忍的马蒂斯，他在维护者休息处旁边的主要道路上巡逻
    .complete 9711,1 --Capture Matis the Cruel
	*Once you find him, use the flare in your bags to summon a Draenei NPC to assist you
	*The flare gun only have 1 charge, if you fail this quest, you will have to abandon it
	.unitscan Matis the Cruel
step
    .goto Bloodmyst Isle,30.3,45.8
    >>与维护者休息处的侦察员交谈
    .turnin 10064 >>交任务: 阿古斯之手
    .accept 10065 >>接任务: 披荆斩棘
    .accept 9741 >>接任务: 虚空幼体
step
    >>与维护者Corin交谈
    .goto Bloodmyst Isle,30.8,46.8
    .accept 10066 >>接任务: 纠结之网
    .accept 10067 >>接任务: 污秽的水之魂
step
    #sticky
    #completewith next
    #label ravager3
    >>在你的任务中杀死掠夺者和探戈者
    .goto Bloodmyst Isle,30.3,57.2,0
    .complete 10066,1 --Kill Mutated Tangler (x8)
    .complete 10065,1 --Kill Enraged Ravager (x10)
step
    .goto Bloodmyst Isle,19.6,63.2
    >>你必须杀死水中的异常才能最终繁殖出怪物
    .complete 9741,1 --Kill Void Critter (x12)
step
    #label ravager4
    >>消灭掠夺者和探戈者
    .goto Bloodmyst Isle,30.3,57.2
    .complete 10066,1 --Kill Mutated Tangler (x8)
    .complete 10065,1 --Kill Enraged Ravager (x10)
step
    #requires ravager4
	#label bloodmyst2
    >>返回维护者的休息
    .turnin 10066 >>交任务: 纠结之网
    .goto Bloodmyst Isle,30.7,46.9
    .turnin 10065 >>交任务: 披荆斩棘
    .goto Bloodmyst Isle,30.3,46.0
step
    .goto Bloodmyst Isle,38.4,47
	>>完成熊和飞舞者的杀戮和掠夺。颤振器通常可以在Cyro Core附近找到。在通往Axxarien的道路北侧。尽量在北侧结束。
    .complete 9647,1 --Kill Royal Blue Flutterer (10)
	.complete 9580,1 --Elder Brown Bear Flank (8)
step
    .goto Bloodmyst Isle,29.6,39.5
	>>杀死该地区的污水灵
    .complete 10067,1 --Kill Fouled Water Spirit (x6)
step
    .goto Bloodmyst Isle,30.7,46.8
    >>快速返回并返回任务
    .turnin 10067 >>交任务: 污秽的水之魂
step
    .goto Bloodmyst Isle,24.9,34.3
    >>返回北方，经过水元素，与科尼利厄斯研究员交谈
    .accept 9670 >>接任务: 他们还活着！也许......
step
	#sticky
	#label Researchers
	>>破坏这个区域周围的卵囊。如果可能的话，在射程内杀死他们，以免激怒潜在的暴徒
    .goto Bloodmyst Isle,18.2,38.0,0,0
    .complete 9670,1 --Expedition Researcher Freed (5)
step
    .goto Bloodmyst Isle,21.4,36.0,70,0
    .goto Bloodmyst Isle,17.2,28.4,40,0
    .goto Bloodmyst Isle,18.2,38.0
	>>杀死该地区的神秘水蛭和纺纱者，然后在山顶杀死扎拉克
    .complete 9669,1 --Kill Myst Leecher (x8)
    .complete 9669,2 --Kill Myst Spinner (x8)
    .complete 9669,3 --Kill Zarakh (x1)
step
	#requires Researchers
	#label AliveM
    >>返回研究员
    .goto Bloodmyst Isle,24.9,34.4
    .turnin 9670 >>交任务: 他们还活着！也许......
step
    .goto Bloodmyst Isle,43.9,43.7,70,0
    .goto Bloodmyst Isle,30.1,51.7,70,0
    .goto Bloodmyst Isle,22.4,54.3,70,0
    .goto Bloodmyst Isle,30.1,51.7,70,0
    .goto Bloodmyst Isle,43.9,43.7,70,0
    .goto Bloodmyst Isle,22.4,54.3,70,0
    .goto Bloodmyst Isle,30.1,51.7
	.line Bloodmyst Isle,43.1,43.7,36.5,47.2,33.5,47.1,29.9,51.8,27.7,51.8,25.1,54.1,22.0,54.3
    .use 24278 >>寻找残忍的马蒂斯，他在维护者休息处旁边的主要道路上巡逻
    .complete 9711,1 --Capture Matis the Cruel
	*Once you find him, use the flare in your bags to summon a Draenei NPC to assist you
	*The flare gun only have 1 charge, if you fail this quest, you will have to abandon it
	.unitscan Matis the Cruel
step
    .goto Bloodmyst Isle,34.3,33.6
	.use 24318 >>使用瀑布底部袋子中的取样瓶
    .complete 9748,1 --Collect Bloodmyst Water Sample (x1)
step
    .goto Bloodmyst Isle,37.4,30.1
	>>杀死指定的熊。抢他的爪子
    .complete 9646,1 --Collect Deathclaw's Paw (x1)
step << Druid
    #sticky
    #completewith next
    .goto Moonglade,44.1,45.2
    >>前往: 月光林地
    .fly Teldrassil>>飞往Teldrassil
step << Druid
    .goto Darnassus,35.3,8.5
    .accept 26 >>接任务: 必修的课程 << tbc
    .accept 6121 >>接任务: 新的课程
step << Druid
    .goto Moonglade,56.1,30.7
    >>前往: 月光林地
    .turnin 6121 >>交任务: 新的课程
    .accept 6122 >>接任务: 毒水之源
    .turnin 26 >>交任务: 必修的课程 << tbc
    .accept 29 >>接任务: 湖中试炼 << tbc
step << Druid tbc
    .goto Moonglade,52.6,51.6
    >>潜入湖中，寻找Shrine Bauble，它看起来像一个红色的小罐子
    .complete 29,1 --Complete the Trial of the Lake.
step << Druid tbc
    .goto Moonglade,36.5,40.1
    .turnin 29 >>交任务: 湖中试炼
    .accept 272 >>接任务: 海狮试炼
step
	#completewith next
    .hs >>心脏到血液观察
step
    .goto Bloodmyst Isle,55.0,58.1
    >>与维护者Aalesia交谈
    .turnin 9569,1 >>交任务: 化解危机 << Hunter
    .turnin 9569,2 >>交任务: 化解危机 << Warlock/Mage/Priest
    .turnin 9569 >>交任务: 化解危机 << !Warlock !Hunter !Mage !Priest
step
    >>与Achelus交谈
    .goto Bloodmyst Isle,53.4,57.1
    .turnin 9669 >>交任务: 覆灭的远征队
step
    #completewith next
    .vendor >>供应商和维修
step
    >>到山上的大楼里去
    .goto Bloodmyst Isle,52.7,53.3
    .turnin 9585 >>交任务: 最终的样本
    .turnin 9646 >>交任务: 通缉：死爪
step
    >>与安克丽特·帕修斯交谈
    .goto Bloodmyst Isle,54.7,54.1
    .accept 9632 >>接任务: 新的盟友
step
	>>与维护者交谈
    .goto Bloodmyst Isle,55.6,55.3
    .turnin 9741 >>交任务: 虚空幼体
    .turnin 9748 >>交任务: 毒水
    .turnin 9711,3 >>交任务: 残忍的玛提斯 << Warrior/Paladin
    .turnin 9711 >>交任务: 残忍的玛提斯 << !Warrior !Paladin
	.trainer >>维护者埃索的火车课咒语。 << Paladin
step
    .itemcount 23984,10
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9642,3 >>交任务: 更多辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9642,2 >>交任务: 更多辐射水晶碎片 << Warlock/Priest/Mage
    .turnin 9642 >>交任务: 更多辐射水晶碎片 << Druid
step
	#label bearend
    >>与Tracker Lyceon交谈
    .goto Bloodmyst Isle,55.9,56.9
    .turnin 9647,3 >>交任务: 消灭巨蛾 << Warrior/Paladin
    .turnin 9647 >>交任务: 消灭巨蛾 << !Warrior !Paladin
    .turnin 9580 >>交任务: 猎熊
step << Paladin wotlk
    .xp <20,1
    .goto Bloodmyst Isle,55.6,55.3
    .train 13819 >>训练你的坐骑法术，它将在你角色面板的“宠物”标签下
step
    >>前往那加废墟
    .goto Bloodmyst Isle,61.4,49.6
    .turnin 9561 >>交任务: 诺尔凯的日记
step
    >>游到岛上
    .goto Bloodmyst Isle,74.6,33.6
    .turnin 9687 >>交任务: 找回尊严
    .accept 9688 >>接任务: 进入梦境
step
	#sticky
    .goto Bloodmyst Isle,70.6,25.7,0
	>>收集地上的小蘑菇
    .complete 9649,1 --Collect Ysera's Tear (x2)
step
    .goto Bloodmyst Isle,71.5,27.8
	>>杀死幼崽
    .complete 9688,1 --Kill Veridian Whelp (x5)
    .complete 9688,2 --Kill Veridian Broodling (x5)
step
    >>回到王子身边
    .goto Bloodmyst Isle,74.3,33.4
    .turnin 9688 >>交任务: 进入梦境
    .accept 9689 >>接任务: 刺喉
step
    .goto Bloodmyst Isle,73.0,21.0
	>>爬到山顶，点击篝火召唤剃须刀(精英)。他可以花一些时间来产卵。
    *Note: He can fear
    .complete 9689,1 --Kill Razormaw (x1)
    *This quest can be tough, skip this step if you can't find a group or solo this quest
step
    >>回到王子身边
    .goto Bloodmyst Isle,74.3,33.4
    .turnin 9689,2 >>交任务: 刺喉 << Warrior/Paladin
    .turnin 9689,3 >>交任务: 刺喉 << Rogue/Hunter
    .turnin 9689,1 >>交任务: 刺喉 << Mage/Warlock/Priest
    .turnin 9689 >>交任务: 刺喉 << Druid/Shaman
step << Hunter/Warlock/Mage
    #completewith next
    .goto Bloodmyst Isle,24.8,51.3
    >>如果你仍然需要XP，那么做体力消耗的极限
    .complete 9746,1 --Kill Sunhawk Pyromancer (x10)
    .complete 9746,2 --Kill Sunhawk Defender (x10)
    >>如果您已经通过XP检查点，请跳过此任务
step << Hunter/Warlock/Mage
	.xp 20-1350
    >>你需要达到20级才能离开血腥结晶
step
    #completewith next
    .deathskip >>在血液观察站死去并重生
step
    .goto Bloodmyst Isle,56.4,56.7
    .turnin 9649 >>交任务: 伊瑟拉之泪
step
    .itemcount 23984,10
    .goto Bloodmyst Isle,55.4,55.2
    .turnin 9642,3 >>交任务: 更多辐射水晶碎片 << Warrior/Paladin/Hunter/Rogue/Shaman
    .turnin 9642,2 >>交任务: 更多辐射水晶碎片 << Warlock/Priest/Mage
    .turnin 9642 >>交任务: 更多辐射水晶碎片 << Druid
step << Paladin
	#completewith next
	#level20
	.goto Bloodmyst Isle,55.6,55.3
	>>Vindicator Esom培训
step
	#sticky
	#completewith next
	.goto Bloodmyst Isle,57.5,54.2
    >>在离开血腥结晶之前，确保你已经20级了 << Hunter/Warlock/Mage
    .fly Exodar>>飞到外族人那里
step << Shaman
	.goto The Exodar,49.5,36.9,70,0
	.goto The Exodar,33.2,24.6
	.trainer >>《异国他乡》中的火车咒语
step << Mage
	.goto The Exodar,51.0,46.8,80,0
	.goto The Exodar,47.2,62.3,20,0
	    .goto The Exodar,46.0,62.7
    .trainer >>在《异国他乡》中训练魔法和传送
step << Mage
    >>购买1个传送符文
    .collect 17031,1
    .goto The Exodar,44.8,63.2
step << Hunter
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,47.6,88.3
	.trainer >>《异国他乡》中的火车咒语
step << Warrior
	.goto The Exodar,42,71.4,60,0
	.goto The Exodar,54.5,85.6,60,0
	.goto The Exodar,55.6,82.3
	.trainer >>《异国他乡》中的火车咒语
step << Priest
    >>进入The Exodar并从供应商处购买燃烧魔杖
    .collect 5210,1
    .goto The Exodar,46.4,61.4
    .trainer >>训练你的职业咒语
    .goto The Exodar,39.2,51.3
step
    .goto Azuremyst Isle,24.2,54.3
	>>在外族人后门外面与暗夜精灵交谈
    .turnin 9632 >>交任务: 新的盟友
    .accept 9633 >>接任务: 前往奥伯丁
step << !Druid
    >>前往你刚刚与之交谈的夜精灵旁边的码头。等待时进行水平急救。
    .goto Azuremyst Isle,20.4,54.2
    .zone Darkshore >>前往: 黑海岸
step << Druid
    #completewith next
    >>前往: 月光林地
    .goto Moonglade,52.4,40.6
    .trainer 12042 >>火车咒语
step << Druid
    .goto Moonglade,48.1,67.2
    .fly Auberdine>>飞到黑海岸

]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance !Warlock
#name 20-21 黑海岸
#version 1
#group RestedXP 联盟 20-32
#defaultfor !Draenei
#next 21-23 灰谷
step << NightElf wotlk
    .goto Darnassus,38.6,15.6
    >>乘船或飞往达纳苏斯
    .skill riding,1 >>训练骑术并购买坐骑
    .money <4.60
step
#xprate <1.5
    .maxlevel 21
    .goto Darkshore,36.1,44.9
    .accept 1138 >>接任务: 海中的水果
step
    >>与客栈外的通缉海报交谈
    .goto Darkshore,37.2,44.2
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
#xprate <1.5 << !Druid
    .maxlevel 21
    .goto Darkshore,37.3,43.7
    .accept 947 >>接任务: 洞中的蘑菇
step
    >>在市政厅旁与侏儒交谈
    .goto Darkshore,37.5,41.8
    .accept 729 >>接任务: 健忘的勘察员
step
#xprate <1.5
    .maxlevel 21
    .isQuestComplete 4762
    .goto Darkshore,37.4,40.1
    .accept 4763 >>接任务: 黑木熊怪的堕落
step
#xprate >1.5
    .isOnQuest 9633
    .goto Darkshore,37.4,40.2
    .turnin 9633 >>交任务: 前往奥伯丁
    .accept 10752 >>接任务: 前往灰谷
step
#xprate <1.5
    .maxlevel 21
    .goto Darkshore,38.1,41.2
    .accept 982 >>接任务: 深不可测的海洋
step
    >>在神殿里与格沙拉交谈
    .goto Darkshore,38.37,43.05
    .accept 1275 >>接任务: 研究堕落
step
#xprate <1.5
    .maxlevel 21
    .goto Darkshore,38.8,43.5
    .accept 2139 >>接任务: 萨纳瑞恩的希望
	.isQuestTurnedIn 2138
step
#xprate <1.5
    .goto Darkshore,39.3,43.5
    .accept 986 >>接任务: 丢失的主人
    .isQuestTurnedIn 985
step
#xprate <1.5 << !Druid
    .maxlevel 21
    .goto Darkshore,39.1,43.5
    .accept 965 >>接任务: 奥萨拉克斯之塔
step
#xprate <1.5
    .goto Darkshore,37.8,44.0
    .use 12346 >>把月亮井的空碗装满
    .collect 12347,1,4763,1 --Collect Filled Cleansing Bowl (x1)
    .isOnQuest 4763
step
    .isOnQuest 9633
    .goto Darkshore,37.4,40.2
	.turnin 9633 >>交任务: 前往奥伯丁
    .accept 10752 >>接任务: 前往灰谷
step
#xprate <1.5
    .isOnQuest 982
    .goto Darkshore,38.2,28.8
	>>通过船体上的洞进入沉船，并在底层掠夺箱子
    .complete 982,1 --Collect Silver Dawning's Lockbox (x1)
step
#xprate <1.5
    .isOnQuest 982
    .goto Darkshore,39.6,27.5
	>>通过船体上的洞进入沉船，并在底层掠夺箱子
    .complete 982,2 --Collect Mist Veil's Lockbox (x1)
step
#xprate <1.5
	#sticky
    #completewith crabraveboys
	>>杀死沿岸的珊瑚虫和结壳潮汐虫
    .complete 1138,1 --Collect Fine Crab Chunks (x6)
step--murlocs
#xprate <1.5 << !Druid
    .maxlevel 21
    .goto Darkshore,44.2,20.7
    .accept 4725 >>接任务: 搁浅的海龟
    .isQuestTurnedIn 4681
step << Druid tbc
    .goto Darkshore,48.9,11.3
    >>在水下掠夺位于两块大石头之间的小锁盒
    .collect 15883,1 --Collect Half Pendant of Aquatic Agility (x1)
step--encrusted crawlers
#xprate <1.5
    .maxlevel 21
    .goto Darkshore,53.1,18.2
    .accept 4727 >>接任务: 搁浅的海龟
    .isQuestTurnedIn 4681
step
#xprate <1.5
    .isOnQuest 2098
	>>开始向北行驶，同时沿着海岸磨螃蟹
    .goto Darkshore,56.7,13.5
    .accept 2098 >>接任务: 基尔卡克的钥匙
step
#xprate <1.5
	#label foreststriders
	#sticky
    .isOnQuest 2098
    .goto Darkshore,59.5,12.6
	>>杀死巨型森林蜘蛛
    .complete 2098,1 --Collect Top of Gelkak's Key (x1)
step
#xprate <1.5
    .isOnQuest 986
    .goto Darkshore,61.1,10.4
	>>杀死登月者陛下/女族长。抢走他们的皮毛
	>>父辈与熊分享其产卵，母系氏族与林蛙共享其产卵
	>>如果你找不到任何探月者，跳过这个任务
    .complete 986,1 --Collect Fine Moonstalker Pelt (x5)
step
#xprate <1.5
	#requires foreststriders
	#sticky
    #label bottomkeyman
    .isOnQuest 2098
    >>杀死愤怒的珊瑚虫
    .complete 2098,3 --Collect Bottom of Gelkak's Key (x1)
step
#xprate <1.5
    .isOnQuest 2098
    .goto Darkshore,55.4,12.6
	>>杀死沉船旁边的墨洛克人
    .complete 2098,2 --Collect Middle of Gelkak's Key (x1)
step
#xprate <1.5
    #requires bottomkeyman
    .isOnQuest 2098
    .goto Darkshore,56.7,13.5
    .turnin 2098 >>交任务: 基尔卡克的钥匙
    .accept 2078 >>接任务: 基尔卡克的报复
step
    #requires crabraveboys
    .isOnQuest 1138
step
#xprate <1.5
    .isOnQuest 2078
    .goto Darkshore,55.8,18.2
	>>与大机器人对话，护送他回到任务给予者那里，然后在它变得敌对时杀死它
    .complete 2078,1 --Gelkak's First Mate
step
#xprate <1.5
    .isOnQuest 2078
    .goto Darkshore,56.7,13.5
    .turnin 2078 >>交任务: 基尔卡克的报复
step << !Druid
#xprate <1.5
	#sticky
	#completewith end
    .isQuestTurnedIn 2078
	+确保保存好你的吸水药剂，稍后你需要它们来处理30-40之间的几个水下部分
step
#xprate <1.5 << !Druid
    .isOnQuest 965
    .goto Darkshore,55.0,24.9
    .turnin 965 >>交任务: 奥萨拉克斯之塔
    .accept 966 >>接任务: 奥萨拉克斯之塔
step
#xprate <1.5 << !Druid
    .isOnQuest 966
    .goto Darkshore,55.3,26.7
	>>杀死黑股狂热分子并掠夺他们的羊皮纸
    .complete 966,1 --Collect Worn Parchment (x4)
step
#xprate <1.5 << !Druid
    .isOnQuest 966
    .goto Darkshore,55.0,24.9
    .turnin 966 >>交任务: 奥萨拉克斯之塔
    .accept 967 >>接任务: 奥萨拉克斯之塔
step << Druid
    .goto Darkshore,55.0,33.4
    .use 15844 >>使用洞口的空采样器
    .complete 6122,1 --Collect Filled Cliffspring Falls Sampler (x1)
step
#xprate <1.5 << !Druid
    .isOnQuest 947
    .goto Darkshore,55.3,34.0
	>>在洞穴周围掠夺蘑菇，向右拥抱，检查上层是否有死亡帽。如果你没有看到一个，你需要往下看。
    .complete 947,1 --Collect Scaber Stalk (x5)
    .complete 947,2 --Collect Death Cap (x1)

step
#xprate <1.5
	#sticky
	#completewith next
    .isOnQuest 4763
	>>掠夺弗尔博格营地周围的粮食商店
	.collect 12342,1
	.goto Darkshore,50.74,34.68
	.collect 12341,1
	.collect 12343,1
step
#xprate <1.5
    #label blackwood
	.use 12347 >>使用篝火上的清洁碗，在命名的萨提尔产卵后杀死他，然后掠夺他尸体旁边的小篮子
    .goto Darkshore,52.4,33.5
    .complete 4763,1 --Collect Talisman of Corruption (x1)
    .isOnQuest 4763
step
#xprate <1.5
    .goto Darkshore,51.5,38.2
    .complete 2139,1 --Kill Den Mother (x1)
    .isOnQuest 2139
step << Dwarf Hunter/Rogue
	#sticky
	#completewith next
	.deathskip >>死亡跳到奥伯丁
step
#xprate <1.5
    .goto Darkshore,37.4,40.1
    .turnin 4763 >>交任务: 黑木熊怪的堕落
    .isOnQuest 4763
step << Druid
    .goto Darkshore,37.7,40.7
    .turnin 6122 >>交任务: 毒水之源
step
    .goto Darkshore,38.1,41.3
    .turnin 982 >>交任务: 深不可测的海洋
    .isQuestComplete 982
step
    .goto Darkshore,37.5,41.9
    .accept 729 >>接任务: 健忘的勘察员
step
#xprate <1.5
    .goto Darkshore,38.8,43.4
    .turnin 2139 >>交任务: 萨纳瑞恩的希望
    .isQuestComplete 2139
step
#xprate <1.5
    .goto Darkshore,39.3,43.4
    .turnin 986 >>交任务: 丢失的主人
    .isQuestComplete 986
step
#xprate <1.5
.goto Darkshore,39.3,43.4
    .accept 993 >>接任务: 丢失的主人
    .isQuestTurnedIn 986
step
#xprate <1.5 << !Druid
    .isOnQuest 947
    .goto Darkshore,37.4,43.7
    .turnin 947 >>交任务: 洞中的蘑菇
    .accept 948 >>接任务: 安努
step
#xprate <1.5 << !Druid
    .goto Darkshore,36.6,45.5
    .turnin 4725 >>交任务: 搁浅的海龟
    .turnin 4727 >>交任务: 搁浅的海龟
    .isQuestTurnedIn 4681
step
#xprate <1.5
    .isOnQuest 1138
    .goto Darkshore,36.1,44.9
    .turnin 1138 >>交任务: 海中的水果
step << Dwarf Hunter/!NightElf Rogue
    .goto Darkshore,33.1,39.9
    .zone Teldrassil>>前往: 泰达希尔
step << NightElf Rogue
    #completewith next
    .fly Teldrassil>>飞往Teldrassil
step << Rogue
    .goto Teldrassil,56.0,90.0,30,0
    .goto Darnassus,58.7,44.6
    >>购买21级武器升级
    .collect 923,1
step << Dwarf Hunter
	#sticky
	#completewith next
    .goto Teldrassil,56.0,90.0,30,0
	.goto Darnassus,63.3,66.3
	Buy the level 20 weapon upgrade
	.collect 3027,1
step << Dwarf Hunter
	.goto Teldrassil,29.2,56.7
	.train 264 >>火车弓
    .train 227 >>火车杆
step << Rogue
    .goto Darnassus,32.7,16.3
    >>往树上走
    .trainer >>训练你的20级法术
step << Dwarf Hunter/!NightElf Rogue
    .goto Darnassus,31.0,41.5,30,0
    .goto Teldrassil,58.4,94.0
    >>从紫色大门离开达纳苏斯
    .fp Rut'theran >>获得Rut'theran Village航线
step << Dwarf Hunter/Rogue
    .goto Teldrassil,58.4,94.0
    .fly Auberdine >>飞回奥伯丁
step
#xprate <1.5 << !Druid
    .isOnQuest 948
    .goto Darkshore,43.5,76.2
    .turnin 948 >>交任务: 安努
    .accept 944 >>接任务: 主宰之剑
step
    .isOnQuest 4740
   >>清理营地，但要小心，靠近篝火会引发3波暴徒。一定要远离篝火，这样你就不会一直伤害他们，并且每次波浪过后都可以吃/喝。潜水网，所以要小心
	.goto Darkshore,36.6,76.6
    .complete 4740,1 --Kill Murkdeep (x1)
step
    .isOnQuest 729
    .goto Darkshore,35.7,83.7
    .turnin 729 >>交任务: 健忘的勘察员
step
    .isQuestTurnedIn 729
    .goto Darkshore,35.7,83.7
    >>开始护送任务
    .accept 731,1 >>接任务: 健忘的勘察员
step
    .isOnQuest 731
    .complete 731,1 --Escort Prospector Remtravel
step
#xprate <1.5 << !Druid
    .isQuestTurnedIn 947
    .goto Darkshore,39.0,86.4
    .turnin 944 >>交任务: 主宰之剑
    .accept 949 >>接任务: 暮光之锤的营地
step
#xprate <1.5 << !Druid
    .isQuestTurnedIn 947
    .goto Darkshore,39.0,86.4
    .use 5251 >>使用袋子里的烤面包碗，右击它
    .turnin 944 >>交任务: 主宰之剑
    .accept 949 >>接任务: 暮光之锤的营地
step
    .goto Darkshore,38.7,87.3
	>>与营地后面的树妖对话。如果她不在这里，其他人可能会护送她，如果她不在场，跳过这一步。
    .accept 945 >>接任务: 护送瑟瑞露尼
step
    #sticky
    #label escort
    .complete 945,1 --Escort Therylune
    .isOnQuest 945
step
#xprate <1.5 << !Druid
    .isOnQuest 949
    .goto Darkshore,38.6,86.1
    >>点击底座顶部的大部头
    .turnin 949 >>交任务: 暮光之锤的营地
step
    #requires escort
    .goto Darkshore,45.0,85.3
    .turnin -993 >>交任务: 丢失的主人
step
    .goto Darkshore,45.0,85.3
    .accept 994,1 >>接任务: 杀出重围
    .isQuestTurnedIn 986
step
	#label end
    >>带领Volcor上路
    .complete 994,1 --Escort Volcor
    .isQuestTurnedIn 986
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance !Warlock
#name 21-23 灰谷
#version 1
#group RestedXP 联盟 20-32
#defaultfor !Draenei
#next 23-24 湿地;24-27 赤脊山/暮色森林
step
#xprate <1.5 << !Druid
    .goto Ashenvale,26.2,38.6
    .turnin 967 >>交任务: 奥萨拉克斯之塔
    .isOnQuest 967
step
#xprate <1.5
    .isQuestTurnedIn 967
    .goto Ashenvale,26.2,38.6
    .accept 970 >>接任务: 奥萨拉克斯之塔
    .maxlevel 21
step
    .goto Ashenvale,26.4,38.6
    .accept 1010 >>接任务: 巴斯兰的头发
step
    .goto Ashenvale,31.3,23.2
	>>掠夺该地区的棕色麻袋，它们可能很难被发现。
    .complete 1010,1 --Collect Bathran's Hair (x5)
step
#xprate <1.5
    .isOnQuest 970
    .goto Ashenvale,31.4,31.0
	>>下降率非常非常低，继续杀戮暴徒。
    .complete 970,1 --Collect Glowing Soul Gem (x1)
    .maxlevel 21
step
    .goto Ashenvale,26.4,38.6
    .turnin 1010 >>交任务: 巴斯兰的头发
    .accept 1020 >>接任务: 奥雷迪尔的药剂
step
#xprate <1.5
    .isQuestComplete 970
    .goto Ashenvale,26.2,38.6
    .turnin 970 >>交任务: 奥萨拉克斯之塔
step
    #xprate <1.5
    .isQuestTurnedIn 970
    .goto Ashenvale,26.2,38.6
    .accept 973 >>接任务: 奥萨拉克斯之塔
step
    .goto Ashenvale,34.40,48.00
    .fp Astranaar>>获取Astranaar飞行路线
step
    .goto Ashenvale,34.7,48.8
    .accept 1008 >>接任务: 佐拉姆海岸
step
    .goto Ashenvale,36.6,49.6
    .accept 1054 >>接任务: 解除威胁
    .turnin 10752 >>交任务: 前往灰谷
    .accept 991 >>接任务: 莱恩的净化
step
    .goto Ashenvale,37.0,49.3
    .home >>将您的炉石设置为Astranaar
step
    #timer Orendil's Cure roleplay
    .goto Ashenvale,37.3,51.8
    >>等待角色扮演，需要26秒。
    .turnin 1020 >>交任务: 奥雷迪尔的药剂
    .timer 26,Orendil's Cure roleplay
    .accept 1033 >>接任务: 月神之泪
step
    .goto Ashenvale,46.2,45.9
	>>点击地面上的蓝色小种子。
    .complete 1033,1 --Collect Elune's Tear (x1)
step
    .goto Ashenvale,37.8,34.7
	>>杀死达尔·布洛德克劳，并洗劫他的头骨。他在营地周围巡逻。
	.unitscan Dal Bloodclaw
    .complete 1054,1 --Collect Dal Bloodclaw's Skull (x1)
step
    .goto Ashenvale,36.6,49.6
    .turnin 1054 >>交任务: 解除威胁
step
    .goto Ashenvale,37.3,51.8
    >>等待角色扮演，需要10秒钟
    .turnin 1033 >>交任务: 月神之泪
    .timer 10,Elune's tear roleplay
    .accept 1034 >>接任务: 星尘废墟
step
    .goto Ashenvale,33.3,67.4
	>>掠夺该地区的星尘
    .complete 1034,1 --Collect Handful of Stardust (x5)
step
#xprate <1.5
    .isOnQuest 973
    .goto Ashenvale,25.3,60.8
	>>杀了伊尔克鲁德，抢走他的魔法书，你可以打晕他，阻止他寻求帮助。
    .complete 973,1 --Collect Ilkrud Magthrull's Tome (x1)
step
    .goto Ashenvale,22.7,51.9
    >>跑上山，翻过山头，然后转入Therylune的逃亡
    .turnin 945 >>交任务: 护送瑟瑞露尼
    .isQuestComplete 945
step
    .goto Ashenvale,22.7,51.9
    .abandon 945 >>如果你还没有完成，就放弃Therylune的逃亡
step
#xprate <1.5
    .isOnQuest 973
    .goto Ashenvale,26.2,38.7
    .turnin 973 >>交任务: 奥萨拉克斯之塔
step <<  NightElf Hunter wotlk/NightElf Rogue wotlk
    .goto Ashenvale,20.3,42.4
    .turnin 991 >>交任务: 莱恩的净化
    .accept 1023 >>接任务: 莱恩的净化
step << Hunter wotlk/NightElf Rogue wotlk
    .goto Ashenvale,20.3,42.4
	>>为宝石杀死墨洛克人，掉落率可能很低。
    .complete 1023,1 --Collect Glowing Gem (x1)
step
    .goto Ashenvale,14.7,31.3
    .accept 1007 >>接任务: 远古雕像
step
    #label nagas
    #sticky
    .goto Ashenvale,13.8,29.1,0,0
	>>杀死海岸附近的纳加人，洗劫他们的头
    .complete 1008,1 --Collect Wrathtail Head (x20)
step
    .goto Ashenvale,14.2,20.6
	>>前往古雕像，将其从地上洗劫一空。在途中杀死纳加，但不要为他们让路，你有足够的机会杀掉他们。
    .complete 1007,1 --Collect Ancient Statuette (x1)
step
    .goto Ashenvale,14.8,31.3
	>>在途中杀死纳加，但不要为他们让路。
    .turnin 1007 >>交任务: 远古雕像
    .timer 25,The Ancient Statuette RP
    .accept 1009 >>接任务: 卢泽尔
step
    .goto Ashenvale,7.0,13.4
	>>前往北岛，杀死鲁泽尔
	>>这场战斗可能很艰难，专注于她的一两个添加，然后在需要时重置。
    .complete 1009,1 --Collect Ring of Zoram (x1)
step
    .goto 1414,43.97,35.31,20,0
    .goto 1414,43.80,35.18,20,0
	.goto 1414,43.94,34.89,20,0
	.goto 1414,43.91,34.58,20,0
	.goto 1414,44.02,34.58,20,0
	.goto 1414,44.16,34.85
    >>进入寺庙般的建筑进入BFD洞穴，杀死纳迦/萨提尔
    .complete 1275,1
step
    #requires nagas
    .goto Ashenvale,14.8,31.3
    .turnin 1009 >>交任务: 卢泽尔
step << Druid
    #completewith next
    >>前往: 月光林地
    .goto Moonglade,52.4,40.6
    .trainer >>训练你的法术
step << wotlk Hunter/wotlk NightElf Rogue
    .goto Ashenvale,36.6,49.6
    .hs >>赫斯到阿斯特拉纳
step << !Hunter !NightElf !Rogue tbc
    .goto Ashenvale,20.3,42.4
    .turnin 991 >>交任务: 莱恩的净化
    .accept 1023 >>接任务: 莱恩的净化
step << !Hunter !NightElf !Rogue tbc
    .goto Ashenvale,20.3,42.4
	>>为了宝石杀死murlocs，掉落率很低。
    .complete 1023,1 --Collect Glowing Gem (x1)
step << !Hunter !NightElf !Rogue tbc
    #sticky
    #completewith next
    .deathskip >>前往湖的东侧，故意死亡并在阿斯特拉纳重生
step
    .isOnQuest 1023
    .goto Ashenvale,36.6,49.6
    .turnin 1023 >>交任务: 莱恩的净化
step
#xprate <1.5 << tbc
    .goto Ashenvale,36.6,49.6
    .accept 1025 >>接任务: 先发制人
step
    .goto Ashenvale,37.3,51.8
    .turnin 1034 >>交任务: 星尘废墟
step
    .goto Ashenvale,34.7,48.9
    .turnin 1008 >>交任务: 佐拉姆海岸
step
#xprate <1.5 << tbc
    >>杀死暴徒进行侵略性防御
    .goto Ashenvale,49.9,60.8,40,0
    .goto Ashenvale,56.9,63.7,40,0
    .goto Ashenvale,49.9,60.8
    .complete 1025,1 --Kill Foulweald Den Watcher (x1)
    .complete 1025,2 --Kill Foulweald Ursa (x2)
    .complete 1025,3 --Kill Foulweald Totemic (x10)
    .complete 1025,4 --Kill Foulweald Warrior (x12)
step
#xprate <1.5 << tbc
    .goto Ashenvale,49.8,67.2
    .accept 1016 >>接任务: 元素护腕
step
#xprate <1.5 << tbc
    >>杀死岛上/水中的所有水元素以获得完整元素护腕。当你有5个时，右击占卜卷轴
    .goto Ashenvale,48.0,69.9
    .complete 1016,1 --Collect Divined Scroll (x1)
step
#xprate <1.5 << tbc
    .goto Ashenvale,49.8,67.2
    .turnin 1016 >>交任务: 元素护腕
step
#xprate <1.5 << tbc
    .goto Ashenvale,36.6,49.6
    .turnin 1025 >>交任务: 先发制人
    .isQuestComplete 1025
step
    .goto Ashenvale,34.7,48.9
    .turnin 1008 >>交任务: 佐拉姆海岸
step
    .goto Ashenvale,34.40,48.00
    .fp Astranaar>>获取Astranaar飞行路线
    .fly Auberdine>>飞往奥伯丁
step
    .goto Darkshore,37.7,43.4
    .turnin 4740 >>交任务: 通缉：莫克迪普！
step
    .goto Darkshore,38.36,43.07
    .turnin 1275 >>交任务: 研究堕落
step
    .goto Darkshore,39.3,43.4
    .turnin -994 >>交任务: 杀出重围
step
    .goto Darkshore,37.5,41.9
    .turnin 731 >>交任务: 健忘的勘察员
	.accept 741 >>接任务: 健忘的勘察员 << !Hunter !NightElf !Rogue/NightElf wotlk
step << !Hunter !NightElf !Rogue
    .goto Darkshore,33.1,39.9
    .zone Teldrassil>>前往: 泰达希尔
step << NightElf wotlk
    .isOnQuest 741
    .goto Darkshore,36.3,45.6
    .fly Teldrassil >>飞往Teldrassil
step << !Hunter !NightElf !Rogue/NightElf wotlk
	.goto Teldrassil,23.7,64.5
    .isOnQuest 741
	.turnin 741 >>交任务: 健忘的勘察员
	.accept 942 >>接任务: 健忘的勘察员
step << NightElf wotlk
    .goto Darnassus,38.6,15.6
    >>乘飞机或乘船去达纳苏斯
    .skill riding,1 >>训练骑术并购买坐骑
    .money <4.60
step << Warrior tbc/Mage/Priest/Warlock
	.goto Teldrassil,29.2,56.7
    .train 227 >>火车杆
step << !Hunter !NightElf !Rogue
    .goto Darnassus,31.0,41.5,30,0
    .goto Teldrassil,58.4,94.0
    >>从紫色大门离开达纳苏斯
    .fp Rut'theran >>获得Rut'theran Village航线
step << !Hunter !NightElf !Rogue
    .goto Teldrassil,58.4,94.0
    .fly Auberdine >>飞回奥伯丁
step << Draenei !Paladin wotlk
    .goto Darkshore,30.8,41.0,40,0
	.goto The Exodar,81.18,52.56
    .money <4.60
    >>乘最西边的船去Azuremyst岛
    .skill riding,75 >>前往Exodar，购买并训练您的坐骑
step << tbc
    .goto Darkshore,32.4,43.8,30,0
    .goto Darkshore,32.4,43.8,0
    .zone Wetlands >>前往: 湿地
step << Draenei tbc/NightElf tbc
#xprate >1.499
    .goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
step << Draenei tbc/NightElf tbc
#xprate >1.499
    .zone Stormwind City >>前往: 暴风城
    .link https://us.battle.net/support/en/help/product/wow/197/834/solution >>单击此处并将链接复制粘贴到浏览器中以获取更多信息
    .zoneskip Elwynn Forest


step << Draenei tbc/NightElf tbc
#xprate >1.499
   #completewith next
   .goto Wetlands,63.9,78.6
   .zone Loch Modan >>前往: 洛克莫丹, 跳到洞穴尽头的蘑菇上, 当你重新登录后将被传送
   >>确保登出时尽可能靠近洞穴后部。如果你在靠近洞口的蘑菇边缘登出，这个技巧就行不通了。
   .link https://www.youtube.com/watch?v=21CuGto26Mk >>单击此处获取参考
   .zoneskip Elwynn Forest
   .zoneskip Stormwind City
step << NightElf tbc/Draenei tbc
#xprate >1.499
    .goto Loch Modan,33.9,50.9
    .fp Thelsamar >>获取Thelsamar飞行路线
    .zoneskip Elwynn Forest
    .zoneskip Stormwind City
step << NightElf tbc/Draenei tbc
#xprate >1.499
    #completewith next
    .goto Loch Modan,21.30,68.60,40,0
    .zone Dun Morogh>>跑到邓莫罗
step << NightElf tbc/Draenei tbc
#xprate >1.499
	>>进入东南特罗格洞穴。执行注销跳过
    .goto Dun Morogh,70.63,56.70,60,0
    .goto Dun Morogh,70.60,54.86
	.link https://www.youtube.com/watch?v=yQBW3KyguCM >>单击此处
	.zone Ironforge >>前往: 铁炉堡
step << NightElf tbc/Draenei tbc
#xprate >1.499
    .goto Ironforge,76.03,50.98,30,0
    .zone Stormwind City >>前往: 暴风城
step << wotlk
    .goto Darkshore,32.4,43.8,30,0
    .goto Darkshore,32.4,43.8,0
    .zone Stormwind City >>前往: 暴风城
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance Warlock
#name 20-23 黑海岸/灰谷
#version 1
#group RestedXP 联盟 20-32
#next 23-24 湿地;24-27 赤脊山/暮色森林
step
    .goto Darkshore,37.0,44.1
    .home >>将您的炉石设置为Auberdine
step << wotlk
    #completewith next
    .goto Darkshore,32.4,43.8
    .zone Stormwind City >>前往: 暴风城
step << tbc
    #completewith next
    .goto Darkshore,32.4,43.8
    .zone Wetlands >>前往: 湿地
step << tbc
    #completewith next
    .goto Wetlands,9.5,59.7
    .fly Stormwind>>飞到暴风城
step << Warlock wotlk
    .goto StormwindNew,36.35,67.49
    .accept 3765>>接任务: 遥远的旅途
step << Warlock
    .goto StormwindClassic,25.3,78.7
	.trainer >>训练你的职业咒语
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .accept 1716 >>接任务: 噬魂者
step << Warlock tbc
    .goto StormwindNew,36.35,67.49
    .accept 3765>>接任务: 遥远的旅途
step << tbc
    #label exit
    .goto StormwindClassic,39.9,54.4
    .zone Darkshore>>进入栅栏和犹太区壁炉，前往奥伯丁
    >>当你在寨子里时，邀请一些随机的人离开小组，这样你就可以传送回奥伯丁
    .link /run InviteUnit("a");C_Timer.After(1,function() LeaveParty() end) >>单击此处查看邀请/离开宏
step << wotlk
    .goto StormwindNew,21.8,56.2,20,0
    .goto StormwindNew,21.8,56.2,0
    .zone Darkshore >>乘船前往: 黑海岸
step
    .goto Darkshore,37.2,44.2
    .accept 4740 >>接任务: 通缉：莫克迪普！
step
    .goto Darkshore,37.5,41.8
    .accept 729 >>接任务: 健忘的勘察员
step
    #completewith next
    .goto Darkshore,38.37,43.05
    .turnin -3765>>交任务: 遥远的旅途
step
    .goto Darkshore,38.37,43.05
    .accept 1275 >>接任务: 研究堕落
step
    .goto Darkshore,37.4,40.2
    .turnin 9633 >>交任务: 前往奥伯丁
    .accept 10752 >>接任务: 前往灰谷
step
    .goto Darkshore,36.6,76.6
    >>清理营地，但要小心，靠近篝火会引发3波暴徒。一定要远离篝火，这样你就不会一直伤害他们，并且每次波浪过后都可以吃/喝。潜水网，所以要小心
    .complete 4740,1 --Kill Murkdeep (x1)
step
    .goto Darkshore,35.7,83.7
    .turnin 729 >>交任务: 健忘的勘察员
step
    .goto Darkshore,35.7,83.7
    .accept 731 >>接任务: 健忘的勘察员
step
    >>小心，因为傀儡可以在你身上重生，并确保在最后一波中优先考虑风水师
.complete 731,1 --Escort Prospector Remtravel
step
    .goto Darkshore,38.7,87.3
	>>如果她不在那里，就在这段时间内在该地区捣乱。
    .accept 945 >>接任务: 护送瑟瑞露尼
step
    .complete 945,1 --Escort Therylune
step
    .goto Ashenvale,26.4,38.6
    >>向东南方向驶往灰谷
    .accept 1010 >>接任务: 巴斯兰的头发
step
    >>注意头发。它们看起来像地上的小干草块。在图形设置中调低地面杂乱的程度，因为这可能会有所帮助(有些杂乱的东西半埋在地上)。
.goto Ashenvale,31.3,23.2
    .complete 1010,1 --Collect Bathran's Hair (x5)
step
    .goto Ashenvale,26.4,38.6
    .turnin 1010 >>交任务: 巴斯兰的头发
    .accept 1020 >>接任务: 奥雷迪尔的药剂
step
    .goto Ashenvale,34.40,48.00
    .fp Astranaar>>获取Astranaar飞行路线
step
    .goto Ashenvale,34.7,48.8
    .accept 1008 >>接任务: 佐拉姆海岸
step
    .goto Ashenvale,36.6,49.6
    .accept 1054 >>接任务: 解除威胁
    .turnin 10752 >>交任务: 前往灰谷
    .accept 991 >>接任务: 莱恩的净化
step
    .goto Ashenvale,37.0,49.3
    .home >>将您的炉石设置为Astranaar
step
    #timer Orendil's Cure RP
    .goto Ashenvale,37.3,51.8
    .turnin 1020 >>交任务: 奥雷迪尔的药剂
    .timer 26,Orendil's Cure RP
    .accept 1033 >>接任务: 月神之泪
step
    .goto Ashenvale,46.2,45.9
	>>掠夺地上的蓝色小种子
    .complete 1033,1 --Collect Elune's Tear (x1)
step
    #timer Elune's tear roleplay
    .goto Ashenvale,37.3,51.8
    .turnin 1033 >>交任务: 月神之泪
    .timer 10,Elune's tear roleplay
    .accept 1034 >>接任务: 星尘废墟
step
    .goto Ashenvale,33.3,67.4
    .complete 1034,1 --Collect Handful of Stardust (x5)
step
    .isOnQuest 945
    .goto Ashenvale,22.7,51.9
    .turnin 945 >>交任务: 护送瑟瑞露尼
step
    .goto Ashenvale,20.3,42.4
    .turnin 991 >>交任务: 莱恩的净化
    .accept 1023 >>接任务: 莱恩的净化
step
    >>小心附近的甲骨文，因为它们都可以愈合，并且有很大的伤害冲击能力
.goto Ashenvale,20.3,42.4
    .complete 1023,1 --Collect Glowing Gem (x1)
step
    .goto Ashenvale,14.7,31.3
    .accept 1007 >>接任务: 远古雕像
step
    #sticky
    #label nagas
    >Kill Nagas for Wrathtail Heads en route to next quests
.goto Ashenvale,13.8,29.1,0,0
    .complete 1008,1 --Collect Wrathtail Head (x20)
step
    .goto Ashenvale,14.2,20.6
    .complete 1007,1 --Collect Ancient Statuette (x1)
step
    .goto Ashenvale,14.8,31.3
    .turnin 1007 >>交任务: 远古雕像
    .timer 25,The Ancient Statuette RP
    .accept 1009 >>接任务: 卢泽尔
step
	>>前往北岛，杀死鲁泽尔
	>>这场战斗可能很艰难，专注于她的一两个添加，然后在需要时重置。
    .goto Ashenvale,7.0,13.4
    .complete 1009,1 --Collect Ring of Zoram (x1)
step
    .goto 1414,43.97,35.31,20,0
    .goto 1414,43.80,35.18,20,0
	.goto 1414,43.94,34.89,20,0
	.goto 1414,43.91,34.58,20,0
	.goto 1414,44.02,34.58,20,0
	.goto 1414,44.16,34.85
    >>进入寺庙般的建筑进入BFD洞穴，杀死纳迦/萨提尔
    .complete 1275,1
step
    #requires nagas
    .goto Ashenvale,14.8,31.3
    .turnin 1009 >>交任务: 卢泽尔
step
    .hs >>赫斯到阿斯特拉纳
step << wotlk
    .goto Ashenvale,39.0,35.9
    .goto Ashenvale,35.9,32.0
    >>开始寻找Dal Bloodclaw，他在furbolg营地附近走动
	.unitscan Dal Bloodclaw
    .complete 1054,1 --Collect Dal Bloodclaw's Skull (x1)
step
    .goto Ashenvale,36.6,49.6
    .turnin 1023 >>交任务: 莱恩的净化
step
#xprate <1.5
    .goto Ashenvale,36.6,49.6
    .accept 1025 >>接任务: 先发制人
step
#xprate <1.5 << tbc
    .goto Ashenvale,36.6,49.6
    .accept 1025 >>接任务: 先发制人
step
    .goto Ashenvale,37.3,51.8
    .turnin 1034 >>交任务: 星尘废墟
step
    .goto Ashenvale,34.7,48.9
    .turnin 1008 >>交任务: 佐拉姆海岸
step
#xprate <1.5 << tbc
    >>杀死暴徒进行侵略性防御
    .goto Ashenvale,49.9,60.8
    .goto Ashenvale,56.9,63.7
    .complete 1025,1 --Kill Foulweald Den Watcher (x1)
    .complete 1025,2 --Kill Foulweald Ursa (x2)
    .complete 1025,3 --Kill Foulweald Totemic (x10)
    .complete 1025,4 --Kill Foulweald Warrior (x12)
step
#xprate <1.5 << tbc
    .goto Ashenvale,49.8,67.2
    .accept 1016 >>接任务: 元素护腕
step
#xprate <1.5 << tbc
    >>杀死岛上/水中的所有水元素以获得完整元素护腕。当你有5个时，右击占卜卷轴
    .goto Ashenvale,48.0,69.9
    .complete 1016,1 --Collect Divined Scroll (x1)
step
#xprate <1.5 << tbc
    .goto Ashenvale,49.8,67.2
    .turnin 1016 >>交任务: 元素护腕
step
#xprate <1.5 << tbc
    .goto Ashenvale,36.6,49.6
    .turnin 1025 >>交任务: 先发制人
        .isQuestComplete 1025
step
    .goto Ashenvale,34.7,48.9
    .turnin 1008 >>交任务: 佐拉姆海岸
step
#xprate <1.5
    >>杀死暴徒进行侵略性防御
    .goto Ashenvale,49.9,60.8
    .goto Ashenvale,56.9,63.7
    .complete 1025,1 --Kill Foulweald Den Watcher (x1)
    .complete 1025,2 --Kill Foulweald Ursa (x2)
    .complete 1025,3 --Kill Foulweald Totemic (x10)
    .complete 1025,4 --Kill Foulweald Warrior (x12)
step
#xprate <1.5
    .goto Ashenvale,49.8,67.2
    .accept 1016 >>接任务: 元素护腕
step
#xprate <1.5
    >>杀死岛上/水中的所有水元素以获得完整元素护腕。当你有5个时，右击占卜卷轴
    .goto Ashenvale,48.0,69.9
    .complete 1016,1 --Collect Divined Scroll (x1)
step
#xprate <1.5
    .goto Ashenvale,49.8,67.2
    .turnin 1016 >>交任务: 元素护腕
    .accept 1017 >>接任务: 召唤者 << tbc
step << tbc
    .goto The Barrens,49.0,5.3,80,0
    .goto The Barrens,49.0,5.3,0
    .zone The Barrens>>穿过破墙进入荒地。小心大路围墙附近的警卫
step << tbc
#xprate <1.5
    .goto The Barrens,48.2,19.1
    >>爬上山杀死萨里卢斯·福伯恩
    .complete 1017,1 --Collect Sarilus Foulborne's Head (x1)
step << tbc
    #completewith next
    .goto The Barrens,50.8,32.6,0
    .deathskip >>在精神治疗师处死亡并重生
step << tbc
    .goto The Barrens,49.3,57.1
    .turnin 1716 >>交任务: 噬魂者
    .accept 1738 >>接任务: 同心树
step << tbc
    >>跑向棘轮
    .goto The Barrens,63.1,37.2
    .fp Ratchet >>获取棘轮飞行路径
    .fly Astranaar>>飞往阿斯特拉纳
step << tbc
    .goto Ashenvale,39.0,35.9
    .goto Ashenvale,35.9,32.0
    >>开始寻找Dal Bloodclaw，他在furbolg营地附近走动
	.unitscan Dal Bloodclaw
    .complete 1054,1 --Collect Dal Bloodclaw's Skull (x1)
step << Warlock tbc
    >>掠夺那棵大树
    .goto Ashenvale,31.6,31.6
    .complete 1738,1 --Collect Heartswood (x1)
step << tbc
    .goto Ashenvale,40.1,53.1,0
    .deathskip >>前往穆洛克湖，死在山脚旁，湖的东侧，然后在精神治疗者重生
step << tbc
#xprate <1.5
    .goto Ashenvale,49.8,67.2
    .turnin 1017 >>交任务: 召唤者
step
#xprate <1.5 << tbc
    #completewith next
    .deathskip >>在阿斯特拉纳的精神治疗师那里死去并重生
step << wotlk !Paladin !Warlock
    #completewith next
    *If you have money on this server, mail yourself 5g, we'll be buying our mounts soon
step
    .goto Ashenvale,36.6,49.6
    .turnin 1054 >>交任务: 解除威胁
    .isQuestComplete 1054
step
    .goto Ashenvale,36.6,49.6
    .turnin 1025 >>交任务: 先发制人
    .isQuestComplete 1025
step
    .goto Ashenvale,34.40,48.00
    .fly Auberdine>>飞往奥伯丁
step
    .goto Darkshore,37.7,43.4
    .turnin 4740 >>交任务: 通缉：莫克迪普！
step
    .goto Darkshore,38.36,43.07
    .turnin 1275 >>交任务: 研究堕落
    .isQuestComplete 1275
step
    .goto Darkshore,37.5,41.9
    .turnin 731 >>交任务: 健忘的勘察员
    .accept 741 >>接任务: 健忘的勘察员
step
    #completewith next
    .goto Darkshore,33.2,40.2,25,0
    .goto Darkshore,33.2,40.2,0
    .zone Teldrassil>>前往: 泰达希尔
step
    #completewith next
    .goto Teldrassil,55.9,89.8
    .zone Darnassus >>前往: 达纳苏斯
step << NightElf wotlk
	.goto Darnassus,38.7,15.8
    .money <4.6
	.skill riding,75 >>坐火车，买你的坐骑
step << Warrior/Rogue
    .goto Darnassus,64.6,53.0
    .collect 29009,1 >>从艾兰德里斯购买一把重型飞刀
step
    .goto Darnassus,31.2,84.5
    .turnin 741 >>交任务: 健忘的勘察员
    .accept 942 >>接任务: 健忘的勘察员
step
    .goto Darnassus,31.0,41.5,30,0
    .goto Teldrassil,58.4,94.0
    >>从紫色大门离开达纳苏斯
    .fp Rut'theran >>获得Rut'theran Village航线
    .fly Auberdine>>飞往奥伯丁
step << Draenei !Paladin wotlk
    .goto Darkshore,30.8,41.0,40,0
	.goto The Exodar,81.18,52.56
    .money <4.60
    >>乘最西边的船去Azuremyst岛
    .skill riding,75 >>前往Exodar，购买并训练您的坐骑
step << tbc
    .goto Darkshore,32.4,43.8,30,0
    .goto Darkshore,32.4,43.8,0
    .zone Wetlands >>前往: 湿地
step << Draenei tbc/NightElf tbc
#xprate >1.499
    .goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
step << Draenei tbc/NightElf tbc
#xprate >1.499
    .zone Stormwind City >>前往: 暴风城
    .link https://us.battle.net/support/en/help/product/wow/197/834/solution >>单击此处并将链接复制粘贴到浏览器中以获取更多信息
    .zoneskip Elwynn Forest


step << Draenei tbc/NightElf tbc
#xprate >1.499
   #completewith next
   .goto Wetlands,63.9,78.6
   .zone Loch Modan >>前往: 洛克莫丹, 跳到洞穴尽头的蘑菇上, 当你重新登录后将被传送
   >>确保登出时尽可能靠近洞穴后部。如果你在靠近洞口的蘑菇边缘登出，这个技巧就行不通了。
   .link https://www.youtube.com/watch?v=21CuGto26Mk >>单击此处获取参考
   .zoneskip Elwynn Forest
   .zoneskip Stormwind City
step << NightElf tbc/Draenei tbc
#xprate >1.499
    .goto Loch Modan,33.9,50.9
    .fp Thelsamar >>获取Thelsamar飞行路线
    .zoneskip Elwynn Forest
    .zoneskip Stormwind City
step << NightElf tbc/Draenei tbc
#xprate >1.499
    #completewith next
    .goto Loch Modan,21.30,68.60,40,0
    .zone Dun Morogh>>跑到邓莫罗
step << NightElf tbc/Draenei tbc
#xprate >1.499
	>>进入东南特罗格洞穴。执行注销跳过
    .goto Dun Morogh,70.63,56.70,60,0
    .goto Dun Morogh,70.60,54.86
	.link https://www.youtube.com/watch?v=yQBW3KyguCM >>单击此处
	.zone Ironforge >>前往: 铁炉堡
step << NightElf tbc/Draenei tbc
#xprate >1.499
    .goto Ironforge,76.03,50.98,30,0
    .zone Stormwind City >>前往: 暴风城
step << wotlk
    .zoneskip Darnassus,1
    .goto Teldrassil,58.4,94.0
    >>从紫色大门离开达纳苏斯
step << wotlk
    .goto Darkshore,32.4,43.8,30,0
    .goto Darkshore,32.4,43.8,0
    .zone Stormwind City >>前往: 暴风城
]])
