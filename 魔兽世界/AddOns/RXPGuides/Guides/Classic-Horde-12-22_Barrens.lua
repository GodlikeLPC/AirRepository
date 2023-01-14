RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 12-17 贫瘠之地
#version 1
#group RestedXP部落1-22
#next 17-22 石爪山脉/贫瘠之地/灰谷

step << Tauren Shaman
    .goto Durotar,50.8,43.6
    .accept 840 >>接任务: 部落的新兵
step << Tauren Shaman
    #completewith next
    .goto Durotar,52.8,28.7,20 >>到这里的洞穴里去
step << Tauren Shaman
    >>为了袋子杀死燃烧之刃信徒
    .goto Durotar,52.5,26.7
    .complete 1525,2 --Reagent Pouch (1)
step << Tauren Shaman
    .goto Durotar,52.8,28.7,20 >>离开洞穴
step << Tauren Shaman
    .goto The Barrens,62.2,19.4
    .turnin 840 >>交任务: 部落的新兵
    .accept 842 >>接任务: 十字路口征兵
step << Warrior
    #completewith next
	.goto The Barrens,54.7,28.0,30 >>在这里跑上山
step << Warrior
    >>去山顶
    .goto The Barrens,57.2,30.3
    .turnin 1502 >>交任务: 索恩格瑞姆·火眼
    .accept 1503 >>接任务: 锻造好的钢锭
step << Warrior
    >>掠夺灰色箱子以获得锻钢棒
	.goto The Barrens,55.0,26.7
    .complete 1503,1 --Forged Steel Bars (1)
step << Warrior
    #completewith next
    .goto The Barrens,54.7,28.0,30 >>在这里跑上山
step << Warrior
    .goto The Barrens,57.2,30.3
    .turnin 1503 >>交任务: 锻造好的钢锭
step << Shaman
    #sticky
    >>杀死并掠夺剃须刀以获取火油
    .complete 1525,1 --Fire Tar (1)
step << !Shaman !Warrior/Undead
    .goto The Barrens,52.0,30.5,150 >>跑到十字路口
step << !Shaman !Warrior/Undead
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交任务: 十字路口征兵 << !Druid
    .accept 844 >>接任务: 平原陆行鸟的威胁
step << !Shaman !Warrior/Undead
    .goto The Barrens,52.2,31.8
    .accept 870 >>接任务: 遗忘之池
step << Orc !Warrior !Shaman/Troll !Warrior !Shaman
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接任务: 送往奥格瑞玛的肉
step << Shaman Troll/Shaman Orc/Warrior Orc/Warrior Troll/Rogue Orc/Rogue Troll
    .goto The Barrens,52.62,29.84
    .turnin 6386 >>交任务: 返回十字路口
step << Undead
    .goto The Barrens,51.99,29.89
	.home >>把炉子放在十字路口
step << !Shaman !Warrior/Undead
    .goto The Barrens,51.9,30.3
    .accept 869 >>接任务: 偷钱的迅猛龙
step << !Shaman !Warrior/Undead
    .goto The Barrens,51.5,30.8
    .accept 871 >>接任务: 野猪人的袭击
    .accept 5041 >>接任务: 十字路口的补给品
step << !Shaman !Warrior/Undead
	#completewith next
    .goto The Barrens,51.5,30.4
    .fp Crossroads >>获取十字路口飞行路线
step << Orc !Warrior !Shaman/Troll !Warrior !Shaman
    >>不要去奥格瑞玛
    .goto The Barrens,51.5,30.3
    .turnin 6365 >>交任务: 送往奥格瑞玛的肉
    .accept 6384 >>接任务: 飞往奥格瑞玛 << !Rogue
step << !Shaman
	#era/som
    .goto The Barrens,51.5,30.1
    .accept 848 >>接任务: 菌类孢子
    .accept 1492 >>接任务: 码头管理员迪兹维格
	.turnin 1358 >>交任务: 给赫布瑞姆的样本 << Undead/Rogue
step << !Shaman
	#som
	#phase 3-6
    .goto The Barrens,51.5,30.1
    .accept 848 >>接任务: 菌类孢子
    .accept 1492 >>接任务: 码头管理员迪兹维格
step
    #sticky
    #completewith next
    >>检查陈氏空桶的位置。抢走它并开始任务，否则你稍后会得到它
    .goto The Barrens,55.7,27.3
    .collect 4926,1,819 --Collect Chen's Empty Keg
    .accept 819 >>接任务: 老陈的空酒桶
step
    .goto The Barrens,55.6,26.6
    >>杀死该地区的Quillboars
    .complete 871,2 --Razormane Thornweaver (8)
    .complete 871,1 --Razormane Water Seeker (8)
    .complete 871,3 --Razormane Hunter (3)
step << !Tauren !Undead
    #sticky
    #completewith next
    .goto The Barrens,62.3,20.0,0
    >>如果你袋子里的缺陷能量石还有不到10分钟的时间，放下它，然后回去再次掠夺阿克泽洛斯旁边的紫石
    .turnin 926 >>交任务: 有瑕疵的能量石
step << !Tauren !Undead !Rogue
    #sticky
    #completewith BeakCave
    >>如果你有时间在瑕疵能量石上杀死一些平原漫游者。抢走他们的喙
    .complete 844,1 --Plainstrider Beak (7)
step << !Tauren !Undead !Rogue
    #label BeakCave
    .goto The Barrens,50.4,22.0,40,0
    .goto The Barrens,47.6,19.2,40 >>跑上山，然后去山顶的洞穴
step << !Tauren !Undead !Rogue
    >>右键单击祭坛。确保你身上有一块能量石
    .goto The Barrens,48.0,19.1
    .goto The Barrens,62.3,20.0,0
    .collect 4986,1,924 --Collect Flawed Power Stone
    .complete 924,1 --Destroy the Demon Seed (1)
step
    #sticky
    #completewith next
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头颅-稍后你会得到更多
    .complete 869,1 --Raptor Head (12)
step << !Tauren
    >>杀死平原漫游者。抢走他们的喙
    .goto The Barrens,50.25,27.78
    .complete 844,1 --Plainstrider Beak (7)
step << Tauren
    .goto The Barrens,55.7,24.0,80,0
    .goto The Barrens,53.8,23.1,80,0
        .goto The Barrens,52.1,21.1,80,0
    .goto The Barrens,51.3,22.9,80,0
    .goto The Barrens,48.3,23.5,80,0
    .goto The Barrens,49.8,31.2,80,0
    .goto The Barrens,55.7,24.0
    >>杀死平原漫游者。抢走他们的喙
    .complete 844,1 --Plainstrider Beak (7)
step << !Tauren Warrior/!Tauren Shaman
    >>跑回十字路口
    .goto The Barrens,52.62,29.84
    .turnin 6386 >>交任务: 返回十字路口
step
    >>跑回十字路口 << !Tauren Warrior/!Tauren Shaman
    .goto The Barrens,51.50,30.87
    .turnin 871 >>交任务: 野猪人的袭击
    .accept 872 >>接任务: 野猪人的头目
step
#era/som
    .goto The Barrens,51.62,30.90
    >>跑到塔顶
    .accept 867 >>接任务: 鹰身强盗
step
    .goto The Barrens,52.2,31.0
    .turnin 844 >>交任务: 平原陆行鸟的威胁
    .accept 845 >>接任务: 斑马的威胁
step << Tauren Shaman
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交任务: 十字路口征兵
step << Warrior
     #sticky
    #completewith next
    +检查利扎里克(哥布林)是否在十字路口，如果他在，并且你有足够的钱，买罐子和重型钉锤。
    .goto The Barrens,52.5,30.7,0
	.unitscan Lizzarik
step << Warrior
    #sticky
    #completewith next
    .collect 4778,1 --Collect Heavy Spiked Mace
step << Warrior
	.goto The Barrens,57.1,25.3,250 >>跑到这里
step
    >>检查陈氏空桶的位置。抢走它，开始任务
    .goto The Barrens,55.78,20.00
    .collect 4926,1,819 --Collect Chen's Empty Keg
    .accept 819 >>接任务: 老陈的空酒桶
step
    #sticky
    #completewith Supplycrate
    >>在得到板条箱和杀死克雷尼格的同时杀死剃刀人
    .complete 872,1 --Razormane Geomancer (8)
    .complete 872,2 --Razormane Defender (8)
step
    #sticky
    #completewith next
    >>掠夺在该地区发现的棕色盒子
    .complete 5041,1 --Crossroads' Supply Crates (1)
step
    #label Kreenig
    >>杀死Krenig Snarlsnout。抢他的牙
    .goto The Barrens,58.6,27.1
    .complete 872,3 --Kreenig Snarlsnout's Tusk (1)
step
    #label Supplycrate
	.goto The Barrens,58.5,27.3,40,0
    .goto The Barrens,58.4,27.0,40,0
    .goto The Barrens,58.5,25.8,40,0
    .goto The Barrens,59.4,24.8,40,0
    .goto The Barrens,58.4,27.0,0
    >>掠夺在该地区发现的棕色盒子
    .complete 5041,1 --Crossroads' Supply Crates (1)
step
    .goto The Barrens,56.7,25.3
    >>杀死剃须刀
    .complete 872,1 --Razormane Geomancer (8)
    .complete 872,2 --Razormane Defender (8)
step << Warrior
    >>在这里掠夺酒桶。如果还没有结束，等待重生
    .goto The Barrens,55.8,20.0
    .collect 4926,1,819 --Collect Chen's Empty Keg
    .accept 819 >>接任务: 老陈的空酒桶
step << !Tauren !Undead
    #sticky
    #completewith next
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄
    .complete 845,1 --Zhevra Hooves (4)
step << !Tauren !Undead
    .goto The Barrens,62.3,20.1
    .turnin 924 >>交任务: 恶魔之种
step << Shaman
    .goto Durotar,38.5,58.9
    .turnin 1525 >>交任务: 火焰的召唤
    .accept 1526 >>接任务: 火焰的召唤
step << Shaman
    >>跑到山顶。单击钎焊器
    .goto Durotar,39.0,58.2
    .complete 1526,1 --Glowing Ember (1)
step << Shaman
    .goto Durotar,38.9,58.2
    .turnin 1526 >>交任务: 火焰的召唤
    .accept 1527 >>接任务: 火焰的召唤
step << Shaman
    #sticky
    #completewith next
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄
    .complete 845,1 --Zhevra Hooves (4)
step << Shaman
    .goto The Barrens,55.9,19.9
    .turnin 1527 >>交任务: 火焰的召唤
step << Shaman
     >>在这里掠夺酒桶。如果还没有结束，等待重生
    .goto The Barrens,55.8,20.0
    .collect 4926,1,819 --Collect Chen's Empty Keg
    .accept 819 >>接任务: 老陈的空酒桶
step << !Shaman
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄。在进入棘轮之前，确保您有4个
    .goto The Barrens,63.9,35.8
    .complete 845,1 --Zhevra Hooves (4)
step
    >>建筑物顶层
    .goto The Barrens,62.7,36.3
    .accept 887 >>接任务: 南海海盗
step
    .goto The Barrens,63.1,37.1
    .fp Ratchet >>获取棘轮飞行路径
step
    .goto The Barrens,63.0,37.2
    .accept 894 >>接任务: 什么什么平衡器
step
    >>单击通缉海报。如果你想，也可以在这里存款
    .goto The Barrens,62.6,37.5
    .accept 895 >>接任务: 通缉：巴隆·朗绍尔
step
    .goto The Barrens,62.4,37.7
    .accept 865 >>接任务: 迅猛龙角
step << Rogue
    .goto The Barrens,62.2,37.4
	.vendor	>>去Ironzar买1-2把弯刀(如果它们比你现在的武器好的话)
step
    .goto The Barrens,62.3,38.4
    .turnin 819 >>交任务: 老陈的空酒桶
    .accept 821 >>接任务: 老陈的空酒桶
step
    #sticky
    #label Southsea
    >>杀死该地区的南海暴徒
    .goto The Barrens,62.59,43.99,0
    .complete 887,1 --Southsea Brigand (12)
    .complete 887,2 --Southsea Cannoneer (6)
step << !Undead Rogue
	#sticky
	#completewith next
	>>杀死塔赞。抢他的背包
    .goto The Barrens,62.59,43.99,0
    .goto The Barrens,63.56,44.35,0
	.unitscan Tazan
	.complete 1963,1 --Tazan's Satchel (1)
step
    .unitscan Baron Longshore
    .goto The Barrens,62.70,49.79
    >>杀死男爵Longshore。在任何营地都能找到他。抢他的头
    .complete 895,1 --Baron Longshore's Head (1)
step << !Undead Rogue
	>>杀死塔赞。抢他的背包
    .goto The Barrens,62.59,43.99,60,0
    .goto The Barrens,63.56,44.35
	.unitscan Tazan
	.complete 1963,1 --Tazan's Satchel (1)
step
    #requires Southsea
    .goto The Barrens,62.7,36.3
    .turnin 887 >>交任务: 南海海盗
    .accept 890 >>接任务: 丢失的货物
    .turnin 895 >>交任务: 通缉：巴隆·朗绍尔
step << Rogue
	.goto The Barrens,62.2,37.4
	.vendor	>>去Ironzar买1-2把弯刀(如果它们比你现在的武器好的话)
step << Shaman
	.goto The Barrens,62.2,37.4
	.vendor	>>如果比你现在的武器更好，就从Ironzar那里买一根Gnarled Staff
step
    .goto The Barrens,63.3,38.4
    .turnin 1492 >>交任务: 码头管理员迪兹维格
    .turnin 890 >>交任务: 丢失的货物
    .accept 892 >>接任务: 丢失的货物
    .accept 896 >>接任务: 矿工的宝贝
step
    .goto The Barrens,62.7,36.3
    .turnin 892 >>交任务: 丢失的货物
    .accept 888 >>接任务: 被窃的货物
step << !Warrior
    .goto The Barrens,63.08,37.16
    .fly Crossroads >>飞向十字路口
step << Warrior
    #completewith next
    .goto The Barrens,61.6,37.9,30,0
    .goto The Barrens,52.5,30.7,150 >>沿着这条路走到十字路口，留心利扎里克(Lizzarik)买一把重型钉锤(Heavy Spiked Mace)。如果他没有，就飞到十字路口
step << Warrior
    #completewith next
	#label HeavySMace
    .collect 4778,1 --Collect Heavy Spiked Mace
	.unitscan Lizzarik
step << Warrior
	#completewith next
	#requires HeavySMace
	.goto The Barrens,52.5,30.7,150 >>如果你在棘轮里，就飞到十字路口；如果你在十字路口的半路上，就跑
step
    .goto The Barrens,51.99,29.89
	.vendor >>从客栈老板那里购买15级食物/水
step
    .goto The Barrens,52.2,31.0
    .turnin 845 >>交任务: 斑马的威胁
    .accept 903 >>接任务: 草原上的徘徊者
step
    .goto The Barrens,51.5,30.8
    .turnin 5041 >>交任务: 十字路口的补给品
    .turnin 872 >>交任务: 野猪人的头目
step << Hunter
    .goto The Barrens,51.0,29.0
	.vendor	>>去乌思罗克买一个精致的长弓，有时商店里没有。如果不是，请购买加固长弓
	>>买箭直到你的箭袋装满
step
    #sticky
    #completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step << !Undead !Rogue
	#era
    .goto The Barrens,45.4,28.4
    .accept 850 >>接任务: 科卡尔首领
    .accept 855 >>接任务: 半人马护腕
step << !Undead !Rogue
	#som
    .goto The Barrens,45.4,28.4
    .accept 850 >>接任务: 科卡尔首领
step << Undead/Rogue
    .goto The Barrens,45.4,28.4
    .accept 850 >>接任务: 科卡尔首领
step << !Shaman !Warrior/Undead
    #completewith next
    >>收集遗忘池周围的白蘑菇
    .complete 848,1 --Collect Fungal Spores (x4)
step << !Shaman !Warrior/Undead
    >>潜水至气泡裂缝
    .goto The Barrens,45.1,22.5
    .complete 870,1 --Explore the waters of the Forgotten Pools
step << !Shaman !Warrior/Undead
    >>收集遗忘池周围的白蘑菇
    .goto The Barrens,45.2,23.3,60,0
    .goto The Barrens,45.2,22.0,60,0
    .goto The Barrens,44.6,22.5,60,0
    .goto The Barrens,43.9,24.4,60,0
    .goto The Barrens,45.2,23.3
    .complete 848,1 --Collect Fungal Spores (x4)
step << !Undead !Rogue
	#era
    #completewith Leaders
    >>杀死半人马座。掠夺他们的护腕。你稍后会完成这个
    .complete 855,1 --Centaur Bracers (15)
step
	>>杀死科多班。在他射门、入网(然后射门)和重击时要小心。抢他的头
    .goto The Barrens,42.8,23.5
    .complete 850,1 --Kodobane's Head (1)
step << !Undead !Rogue
	#era
    .goto The Barrens,45.39,28.44
   .turnin 850 >>交任务: 科卡尔首领
    .accept 851 >>接任务: 狂热的维罗戈
step << !Undead !Rogue
	#era
	.isQuestComplete 855
    .goto The Barrens,45.39,28.44
    .turnin 855 >>交任务: 半人马护腕
step
	#era
	#label Leaders
    .goto The Barrens,45.39,28.44
   .turnin 850 >>交任务: 科卡尔首领
    .accept 851 >>接任务: 狂热的维罗戈 << !Undead !Rogue
step
    #sticky
    #completewith Claws
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头颅-稍后你会得到更多
    .complete 869,1 --Raptor Head (12)
step
    #sticky
    #completewith Claws
    .complete 821,1 --Savannah Lion Tusk (5)
step
#som
#phase 3-6
    #label Claws
    >>杀死游荡者。掠夺他们的爪牙
    .goto The Barrens,53.00,16.00
    .complete 903,1 --Prowler Claws (7)
step
#era/som
    #label Claws
    >>杀死游荡者。掠夺他们的爪牙
    .goto The Barrens,41.4,24.5,100,0
    .goto The Barrens,40.48,20.36
    .complete 903,1 --Prowler Claws (7)
step
#era/som
    .goto The Barrens,40.2,18.9,90,0
    .goto The Barrens,40.7,14.6,90,0
    .goto The Barrens,42.6,15.1,90,0
    .goto The Barrens,40.2,18.9
    >>杀死哈比。掠夺他们的魔爪
    .complete 867,1 --Witchwing Talon (8)
step
    #sticky
    #completewith Samophlange
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step << Warrior
#era/som
	#completewith next
    .goto The Barrens,43.8,12.2
	>>如果有重型钉锤，请从Vrang购买 << Warrior
    .collect 4778,1 --Collect Heavy Spiked Mace << Warrior
step
#era/som
    .goto The Barrens,43.8,12.2
	.vendor	>>供应商垃圾、修理
step
	#label Samophlange
    >>单击控制台
    .goto The Barrens,52.4,11.6
    .turnin 894 >>交任务: 什么什么平衡器
    .accept 900 >>接任务: 什么什么平衡器
step
    >>点击阀门
    .goto The Barrens,52.4,11.4
    .complete 900,2 --Shut off Fuel Control Valve (1)
step
    >>单击“阀”。暴徒会滋生
    .goto The Barrens,52.3,11.4
    .complete 900,3 --Shut off Regulator Valve (1)
step
    >>单击“阀”。暴徒会滋生
    .goto The Barrens,52.3,11.6
    .complete 900,1 --Shut off Main Control Valve (1)
step
    >>单击控制台
    .goto The Barrens,52.4,11.6
    .turnin 900 >>交任务: 什么什么平衡器
    .accept 901 >>接任务: 什么什么平衡器
step
    >>杀死大楼里的小精灵补锅匠。抢他拿控制台钥匙
    .goto The Barrens,52.8,10.4
    .complete 901,1 --Console Key (1)
step
    .goto The Barrens,52.4,11.6
    .turnin 901 >>交任务: 什么什么平衡器
    .accept 902 >>接任务: 什么什么平衡器
step
    #sticky
    #completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    .goto The Barrens,54.3,12.3,90,0
    .goto The Barrens,54.6,16.7,90,0
    .goto The Barrens,42.6,15.1,90,0
    .goto The Barrens,54.3,12.3
    >>杀死猛禽。抢他们的头
    .complete 869,1 --Raptor Head (12)
step
    .goto The Barrens,56.5,7.5
    >>磨练到16级很重要，因为接下来的3个任务相当困难。
	.xp 16
step
    .goto The Barrens,56.5,7.5
    .accept 858 >>接任务: 打火钥匙
step
    #sticky
	#hardcore
    #completewith next
    +接下来的3个任务可能很难，要格外小心

step
    >>杀死监督员Lugwizzle(他在整个塔上巡逻)。抢他取点火钥匙
.goto The Barrens,56.3,8.6
    .complete 858,1 --Ignition Key (1)
step
    >>这将开始护送。确保你完全健康
    .goto The Barrens,56.5,7.5
    .turnin 858 >>交任务: 打火钥匙
    .accept 863 >>接任务: 梅贝尔的隐形水
step
    #label Slugs
    >>当碎纸机移动到较高的地面上时，会产生2个暴徒。杀死他们，然后等待他的RP事件结束
    .goto The Barrens,55.3,7.8
    .complete 863,1 --Escort Wizzlecrank out of the Venture Co. drill site (1)
step
    #sticky
    #completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    >>在该地区捣乱暴徒。杀死大约25个暴徒，如果翡翠没有掉落，跳过这个任务。
    .goto The Barrens,61.5,4.3
    .complete 896,1 -- Cats Eye Emerald (1)
step
	#completewith next
    .goto Orgrimmar,11.5,67.0,50 >>跑到奥格瑞玛的西入口
step << Mage
    .goto Orgrimmar,38.79,85.68
    .trainer >>训练你的职业咒语
step << Priest
    .goto Orgrimmar,35.59,87.83
    .trainer >>训练你的职业咒语
step << Tauren/Undead
    >>跑到Flight Master塔台。获取飞行路径。不要飞到任何地方
    .goto Orgrimmar,45.2,63.8
    .fp Orgrimmar >>获取Orgrimmar飞行路线
step
    >>跑去Grommash Hold
    .goto Orgrimmar,39.1,38.1
    .accept 1061 >>接任务: 石爪之灵
step << Druid
    .goto Orgrimmar,54.2,68.4
	.fly Thunder Bluff >>飞向雷霆崖
step << !Rogue !Undead !Tauren !Shaman !Warrior
    .goto Orgrimmar,54.2,68.4
    .turnin 6384 >>交任务: 飞往奥格瑞玛
    .accept 6385 >>接任务: 双足飞龙管理员多拉斯
step << !Rogue !Undead !Tauren !Shaman !Warrior
    .goto Orgrimmar,45.2,63.8
    .turnin 6385 >>交任务: 双足飞龙管理员多拉斯
    .accept 6386 >>接任务: 返回十字路口
step << Rogue
    .goto Orgrimmar,43.05,53.73
    .trainer >>训练你的职业咒语
	>>确保你已经训练过拾取锁定
    .accept 2379 >>接任务: 赞杜沙
	.turnin 1963 >>交任务: 碎手氏族 << !Undead
--	.accept 1858 >>接任务: 碎手氏族
--N ..Make sure you train Pick Pocket
step << Rogue
    .goto Orgrimmar,42.72,52.95
    .turnin 2379 >>交任务: 赞杜沙
    .accept 2382 >>接任务: 棘齿城的维尼克斯
step << skip
    >>客栈里的扒手游戏。打开你包里的泰山背包
	.goto Orgrimmar,53.99,68.05
	.collect 7208,1,1858,1 --Tazan's Key
	.complete 1858,1 --Tazan's Logbook (1)
--N Rogue class q
step << skip
    .goto Orgrimmar,43.05,53.73
	.turnin 1858 >>交任务: 碎手氏族
--N Rogue class q
step << Warlock
    .goto Orgrimmar,47.99,45.94
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Orgrimmar,47.52,46.70
    .vendor >>购买消耗阴影r1，然后牺牲r1书籍(如果你有钱)
step << Shaman
    .goto Orgrimmar,38.79,36.37
    .trainer >>训练你的职业咒语
step << Warrior
    .goto Orgrimmar,80.39,32.39
    .trainer >>训练你的职业咒语
step << Hunter
    .goto Orgrimmar,66.04,18.52
    .trainer >>训练你的职业咒语
step << Hunter
    .goto Orgrimmar,66.31,14.80
    .trainer >>训练你的宠物法术
step << Hunter
    .goto Orgrimmar,81.52,19.64
	.train 227 >>列车从河岸出发
step << Druid
	.goto Thunder Bluff,76.4,27.6
	.accept 27 >>接任务: 必修的课程
step << Druid
    .zone Moonglade >>前往: 月光林地
step << Druid
    >>楼上的
    .goto Moonglade,56.21,30.64
	.turnin 27 >>交任务: 必修的课程
    .accept 28 >>接任务: 湖中试炼
step << Druid
    .goto Moonglade,52.53,40.56
    .trainer >>训练你的职业咒语
step << Druid
    .goto Moonglade,36.52,40.10
    .turnin 28 >>交任务: 湖中试炼
--    .accept 30 >>接任务: 海狮试炼
step
    #completewith next
    .hs >>炉膛到十字路口
step
    .goto The Barrens,51.9,30.3
    .turnin 869 >>交任务: 偷钱的迅猛龙
    .accept 3281 >>接任务: 被偷走的银币
step
    .goto The Barrens,52.3,31.0
    .turnin 903 >>交任务: 草原上的徘徊者
    .accept 881 >>接任务: 埃其亚基
step << !Rogue !Undead !Tauren !Shaman !Warrior
    .goto The Barrens,52.62,29.84
    .turnin 6386 >>交任务: 返回十字路口
step
    >>在你包里的骨头要召唤埃希亚基的地方使用埃希亚基之角。杀了他，抢走他的藏身之地
    .goto The Barrens,55.80,17.03
    .complete 881,1 --Echeyakee's Hide (1)
step
    .goto The Barrens,52.2,31.0
    .turnin 881 >>交任务: 埃其亚基
    .accept 905 >>接任务: 狂暴的镰爪龙
step << !Warrior !Shaman
    .goto The Barrens,52.20,31.90
    .turnin 870 >>交任务: 遗忘之池
    .accept 877 >>接任务: 死水绿洲
step
    .goto The Barrens,52.00,31.60
    .accept 899 >>接任务: 复仇的怒火
    .accept 4921 >>接任务: 在战斗中失踪
step
#era/som
    >>跑到塔顶
    .goto The Barrens,51.6,30.9
    .turnin 867 >>交任务: 鹰身强盗
    .accept 875 >>接任务: 鹰身人首领
step << !Shaman !Warrior/Undead
    .goto The Barrens,51.50,30.20
    .turnin 848 >>交任务: 菌类孢子
step
    .goto The Barrens,51.5,30.3
    .fly Ratchet >>飞到棘轮
step << Rogue
    .goto The Barrens,63.07,36.31
    .turnin 2382 >>交任务: 棘齿城的维尼克斯
    .accept 2381 >>接任务: 抢劫海盗
step << Rogue
    .goto The Barrens,63.12,36.32
    >>与Wrenix的Giztronic仪器交谈。获取E.C.A.C和窃贼工具
    .collect 7970,1 --E.C.A.C. (1)
    .collect 5060,1 --Thieves' Tools (1)
step
    .goto The Barrens,63.0,37.2
    .turnin 902 >>交任务: 什么什么平衡器
    .turnin 863 >>交任务: 梅贝尔的隐形水
    .accept 1483 >>接任务: 菲兹克斯
step << Hunter
    .goto The Barrens,63.0,37.2
    .accept 3921 >>接任务: 维妮·布特巴克
step
    .isQuestComplete 896
	.goto The Barrens,63.30,38.40
    .turnin 896 >>交任务: 矿工的宝贝
step
    .abandon 896 >>如果你现在还没有放弃矿工的财富
step
    .goto The Barrens,62.40,37.70
    .accept 1069 >>接任务: 深苔蜘蛛的卵
step << Hunter
	#completewith next
	.goto The Barrens,61.92,38.80
	.vendor >>从Jazzik买箭，直到你的箭袋装满为止
step << Rogue
	#completewith next
    .goto The Barrens,65.04,45.44
    +跳上船，下楼到二楼，把你的开锁机调平至80
step << Rogue
    .goto The Barrens,64.95,45.44
    >>将E.C.A.C.拖到您的栏上。当你的开锁时间达到80时，去船的底层打开“南海之珠”
    >>当波利从楼梯上产卵时，使用E.C.A.C
    .complete 2381,1 --Southsea Treasure (1)
step
    >>掠夺板条箱
    .goto The Barrens,63.6,49.2
    .complete 888,2 --Telescopic Lens (1)
step
    >>掠夺板条箱
    .goto The Barrens,62.6,49.6
    .complete 888,1 --Shipment of Boots (1)
step
    #completewith CampTa
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    #sticky
    #completewith Nest
    >>杀死你看到的猛禽。掠夺他们的角和羽毛。当他们猛击时要小心
    .complete 865,1 --Intact Raptor Horn (5)
step
    >>抢走被盗的银子
    >>把你得到的Sunscale羽毛留到以后
    .goto The Barrens,57.4,52.4,60,0
    .goto The Barrens,58.0,53.9
    .complete 3281,1 --Stolen Silver (1)
step
    >>在湖中，潜到水下，点击气泡裂缝。
    .goto The Barrens,55.6,42.7
    .complete 877,1 --Test the Dried Seeds (1)
step << !Undead !Rogue
	#era
    >>在湖边碾磨任何一个Centuar，直到它们产卵Verog
    .goto The Barrens,52.95,41.77
    .complete 851,1 --Verog's Head (1)
step
    >>杀死周围的猛禽，直到你得到一个日晷羽毛。当你有蓝蛋的时候，就把它抢走。
    .goto The Barrens,52.6,46.2
    .complete 905,1 --Visit Blue Raptor Nest (1)
step
    >>杀死周围的猛禽，直到你得到一个日晷羽毛。当你有红鸡蛋的时候，就把它抢走。
    .goto The Barrens,52.5,46.6
    .complete 905,3 --Visit Red Raptor Nest (1)
step
    #label Nest
    >>杀死周围的猛禽，直到你得到一个日晷羽毛。当你有一个黄鸡蛋时，就把它抢走。
    .goto The Barrens,52.0,46.5
    .complete 905,2 --Visit Yellow Raptor Nest (1)
step
    .goto The Barrens,57.3,53.7,90,0
    .goto The Barrens,52.0,46.5,90,0
    .goto The Barrens,57.3,53.7
    >>杀死猛禽。抢走他们的角
    .complete 865,1 --Intact Raptor Horn (5)
step
    >>与Mankrik的妻子交谈
    .goto The Barrens,49.3,50.4
    .complete 4921,1 --Find Mankrik's Wife (1)
step
    #label CampTa
    .goto The Barrens,45.6,59.0
    .home >>将您的炉石设置为陶拉霍营地
step
    .goto The Barrens,44.5,59.2
    .accept 878 >>接任务: 野猪人的内战
step
    .goto The Barrens,44.5,59.2
    .fp Camp Taurajo >>获得Taurajo营地飞行路线 << !Shaman !Warrior !Tauren
    .fly Crossroads >>飞向十字路口
step
    .goto The Barrens,51.9,30.3
    .turnin 3281 >>交任务: 被偷走的银币
step
    .goto The Barrens,52.2,31.0
    .turnin 905 >>交任务: 狂暴的镰爪龙
    .accept 3261 >>接任务: 乔恩·星眼
step
    .goto The Barrens,52.2,31.9
    .turnin 877 >>交任务: 死水绿洲
    .accept 880 >>接任务: 变异的生物
step
    .goto The Barrens,52.0,31.6
    .turnin 4921 >>交任务: 在战斗中失踪
step << Hunter
    .goto The Barrens,51.11,29.07
    .vendor >>从Uthrok购买10格箭袋。
	>>用箭头填充10格箭袋，然后额外购买400个
step
    #sticky
    #completewith LionT
    .goto The Barrens,47.48,26.02,0
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
	#som
	#label Leaders
    .goto The Barrens,45.39,28.44
   .turnin 850 >>交任务: 科卡尔首领
step << !Undead !Rogue
	#era
    .goto The Barrens,45.39,28.43
    .turnin 851 >>交任务: 狂热的维罗戈
    .accept 852 >>接任务: 赫兹鲁尔·血印
step << Undead/Rogue
	#era
    .goto The Barrens,45.39,28.44
   .turnin 850 >>交任务: 科卡尔首领
step << !Undead !Rogue
	#era
	.isOnQuest 852
    .goto The Barrens,45.87,40.80
    >>找到并杀死真主党血腥标记。他在哀嚎洞穴湖边巡逻
    .complete 852,1 --Hezrul's Head (1)
	.unitscan Hezrul Bloodmark
step << !Undead !Rogue
	#era
    #sticky
    #completewith next
    +下一个任务可能很难，要格外小心
    #hardcore
step << !Undead !Rogue
	#era
	.isQuestComplete 852
    .goto The Barrens,45.37,28.43
    .turnin 852 >>交任务: 赫兹鲁尔·血印
step << !Undead !Rogue
	#era
	.isQuestTurnedIn 852
    .goto The Barrens,45.37,28.43
    .accept 4021 >>接任务: 人马无双！
step << !Undead !Rogue
	#era
    #softcore
	.isOnQuest 4021
	>>这个任务非常困难，建议分组。你可以使用任务给予者所在的建筑来风筝军阀克罗姆扎尔。
	>>如果你做不到，跳过这个任务
    .goto The Barrens,44.33,28.14
    .complete 4021,1 --Piece of Krom'zar's Banner (1)
--N need link of this
step << !Undead !Rogue
	#era
    #hardcore
	.isOnQuest 4021
	>>这个任务很艰巨。你可以使用任务给予者所在的建筑来风筝军阀克罗姆扎尔。
	>>如果你做不到，跳过这个任务
    .goto The Barrens,44.33,28.14
    .complete 4021,1 --Piece of Krom'zar's Banner (1)
--N need link of this
step << !Undead !Rogue
	#era
    .isQuestComplete 4021
    .goto The Barrens,45.39,28.44
    .turnin 4021 >>交任务: 人马无双！
step
#era/som
    #sticky
    #completewith next
    +杀戮者已经被处决了，要格外小心
    #hardcore
step
#era/som
    .goto The Barrens,40.3,15.2
    >>杀死巫师之翼杀戮者。掠夺他们以换取哈比中尉戒指
    .complete 875,1 --Harpy Lieutenant Ring (6)
step
    #label LionT
    .goto The Barrens,40.48,20.36,100,0
    .goto The Barrens,41.4,24.5
    >>杀死该地区的萨凡纳游荡者。抢他们的牙
    .complete 821,1 --Savannah Lion Tusk (5)
step
	.goto The Barrens,35.3,27.9
    .turnin 1061 >>交任务: 石爪之灵
    .accept 1062 >>接任务: 地精侵略者
    .accept 6548 >>接任务: 为我的村庄复仇
]])

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 17-22 石爪山脉/贫瘠之地/灰谷
#version 1
#group RestedXP部落1-22
#next RestedXP部落22-30\22-24 Hillsbrad

step
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0,50,0
    .goto Stonetalon Mountains,80.7,89.2
    >>杀死该地区的格里姆特姆斯
    .complete 6548,2 --Kill Grimtotem Mercenary (x6)
    .complete 6548,1 --Kill Grimtotem Ruffian (x8)
step
    .goto The Barrens,35.2,27.8
    .turnin 6548 >>交任务: 为我的村庄复仇
    .accept 6629 >>接任务: 杀死格鲁迪格·暗云
step
    #sticky
    #completewith next
    .goto Stonetalon Mountains,75.89,87.49,30 >>沿着这条路跑到篝火旁。尽量避开暴徒
step
    >>在开始内部任务之前，确保杀死所有6只野兽。在主帐篷前杀死格隆迪希
    .goto Stonetalon Mountains,74.0,86.2
    .complete 6629,1 --Kill Grundig Darkcloud (x1)
    .complete 6629,2 --Kill Grimtotem Brute (x6)
step
    >>启动卡亚护送
    .goto Stonetalon Mountains,73.5,85.8
    .accept 6523 >>接任务: 保护卡雅
step
    #sticky
    #completewith next
    +3名暴徒在最后繁殖，小心
    #hardcore
step
     >>护送Kaya并靠近她。3灰熊会在篝火旁产卵。在她到达营地之前吃/喝
    .goto Stonetalon Mountains,75.8,91.4
    .complete 6523,1 --Kaya Escorted to Camp Aparaje
step
    .goto Stonetalon Mountains,71.4,95.1
    .accept 6461 >>接任务: 盗窃的蜘蛛
step << Warlock
    >>点击通缉海报
    .goto Stonetalon Mountains,59.0,75.7
    .accept 6284 >>接任务: 贝瑟莱斯
step << Warlock
    .goto Stonetalon Mountains,57.5,76.2,30 >>沿着这条小路跑到西希尔峡谷
step  << Warlock
    #sticky
    #completewith Ziz
    >>点击树旁的蜘蛛蛋
    .complete 1069,1 --Collect Deepmoss Egg (x15)
step  << Warlock
    >>杀死该地区的深苔藓蜘蛛
    .goto Stonetalon Mountains,54.7,71.9,40,0
    .goto Stonetalon Mountains,52.6,71.8,40,0
    .goto Stonetalon Mountains,52.2,75.6,40,0
    .goto Stonetalon Mountains,53.9,74.2,40,0
    .goto Stonetalon Mountains,54.7,71.9
    .complete 6461,1 --Kill Deepmoss Creeper (x10)
    .complete 6461,2 --Kill Deepmoss Venomspitter (x7)
step  << !Warlock
    >>杀死该地区的深苔藓蜘蛛
    .goto Stonetalon Mountains,62.40,61.46
    .complete 6461,1 --Kill Deepmoss Creeper (x10)
    .complete 6461,2 --Kill Deepmoss Venomspitter (x7)
step << Warlock
    >>清理贝塞莱斯周围的区域。他给你织网时要小心。用点让他永远害怕
    >>这个任务是可选的。如果你做不到，跳过这个任务。你可以稍后再试
    .complete 6284,1 --Collect Besseleth's Fang (x1)
step
    #label Ziz
	.goto Stonetalon Mountains,59.0,62.6
    .turnin 1483 >>交任务: 菲兹克斯
    .accept 1093 >>接任务: 超级收割机6000
step
    #sticky
    #completewith next
    +下一个任务可能很难，要格外小心。14级蜘蛛可以繁殖22级蜘蛛。
    #hardcore
step
    .goto Stonetalon Mountains,62.40,61.46
    >>点击树旁的蜘蛛蛋
    .complete 1069,1 --Collect Deepmoss Egg (x15)
step
    #sticky
    #completewith next
    >>在搜索操作员以获取蓝图时杀死记录器
    .complete 1062,1 --Kill Venture Co. Logger (x15)
step
    #requires deepmossegg
    >>杀死Venture Co.Operators直到你拿到蓝图
    .goto Stonetalon Mountains,62.8,53.7,100,0
    .goto Stonetalon Mountains,61.7,51.5,100,0
    .goto Stonetalon Mountains,66.8,45.3,100,0
    .goto Stonetalon Mountains,71.7,49.9,100,0
    .goto Stonetalon Mountains,74.3,54.7,100,0
    .goto Stonetalon Mountains,62.8,53.7
    .complete 1093,1 --Collect Super Reaper 6000 Blueprints (x1)
step
    >>结束杀死记录器
    .goto Stonetalon Mountains,64.1,56.7,100,0
    .goto Stonetalon Mountains,73.4,54.3
    .complete 1062,1 --Kill Venture Co. Logger (x15)
step
   	 .goto Stonetalon Mountains,58.2,51.6
	>>去Veenix买一个Kris << Rogue
	.collect 2209,1 << Rogue
--N other weapons for other classes?
step
	#completewith next
	+如果你有超过15个深苔藓蛋，分割所有额外的堆叠(按住shift键并单击)，然后删除它们
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1093 >>交任务: 超级收割机6000
    .accept 1094 >>接任务: 新的指示
step << Druid
	>>使用“传送到月光”法术
   	 .goto Moonglade,52.5,40.5
	.trainer >>去训练你的职业咒语
step
    .hs >>炉灶前往陶拉霍营地
	.vendor >>如果需要，购买食物/水
step
    .goto The Barrens,44.9,59.1
    .turnin 3261 >>交任务: 乔恩·星眼
    .accept 882 >>接任务: 伊沙姆哈尔
step
	#completewith QuillboarAndy
    .goto The Barrens,44.84,47.69,0
    >>杀死风暴吹牛。抢他们的角
    .complete 821,3 --Thunder Lizard Horn (1)
step
	#sticky
	#label Lakota1
	#completewith next
	.goto The Barrens,50.0,53.1,0
    .goto The Barrens,46.0,49.2,0
    .goto The Barrens,45.3,52.5,0
    .goto The Barrens,45.0,51.8,0
	>>找到并杀死该地区的拉科塔·马尼(格雷·科多)。抢走他的蹄子。如果你找不到他，跳过这个任务。
	.collect 5099,1,883 --Collect Hoof of Lakota'Mani
	.accept 883 >>接任务: 拉克塔曼尼
step
	#label QuillboarAndy
    >>杀死大量的绒猪。掠夺他们的象牙。保存你得到的血块
	.goto The Barrens,44.3,52.3,100,0
    .goto The Barrens,47.1,53.3,100,0
    .goto The Barrens,45.2,54.3,100,0
	.goto The Barrens,44.3,52.3,100,0
    .goto The Barrens,47.1,53.3,100,0
    .goto The Barrens,45.2,54.3,100,0
	.goto The Barrens,44.3,52.3,100,0
    .goto The Barrens,47.1,53.3,100,0
    .goto The Barrens,45.2,54.3,100,0
	.goto The Barrens,44.3,52.3,100,0
    .goto The Barrens,47.1,53.3,100,0
    .goto The Barrens,45.2,54.3,100,0
    .goto The Barrens,52.90,53.53
	.complete 878,1 --Kill Bristleback Water Seeker (x6)
    .complete 878,2 --Kill Bristleback Thornweaver (x12)
    .complete 878,3 --Kill Bristleback Geomancer (x12)
    .complete 899,1 --Collect Bristleback Quilboar Tusk (x60)
step
    .goto The Barrens,44.84,47.69
    >>杀死风暴吹牛。抢他们的角
    .complete 821,3 --Thunder Lizard Horn (1)
step
    .goto The Barrens,53.48,48.23
    >>完成从平原漫游者那里获得肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    >>绕着湖去杀海龟。抢他们的壳
.goto The Barrens,55.5,42.6
    .complete 880,1 --Altered Snapjaw Shell (8)
step
    >>在该地区杀死一名哲夫拉。掠夺尸体
	.goto The Barrens,61.0,32.2
	.collect 10338,1 --Collect Fresh Zhevra Carcass
step
    >>用枯树上的新鲜哲夫拉尸体召唤Ishamuhale。杀了他，抢了他的牙
.goto The Barrens,59.9,30.4
    .complete 882,1 --Ishamuhale's Fang (1)
step << Rogue
   >>跑回棘轮
    .goto The Barrens,63.07,36.31
    .turnin 2381 >>交任务: 抢劫海盗
step
.goto The Barrens,62.7,36.3
    >>跑回棘轮 << !Rogue
    .turnin 888 >>交任务: 被窃的货物
step
    .goto The Barrens,63.0,37.2
    .turnin 1094 >>交任务: 新的指示
    .accept 1095 >>接任务: 新的指示
step
    .goto The Barrens,62.4,37.6
    .turnin 865 >>交任务: 迅猛龙角
    .turnin 1069 >>交任务: 深苔蜘蛛的卵
step
    .goto The Barrens,62.3,38.4
    .turnin 821 >>交任务: 老陈的空酒桶
step << Warrior
    .goto The Barrens,62.2,38.4
    .vendor >>检查Grazlix的强力链裤。有钱就买
step << Rogue/Hunter/Warrior/Shaman/Druid
    .goto The Barrens,62.2,38.5
    .vendor >>检查Vexspindle的Wolf Bracers。有钱就买
step
    .goto The Barrens,63.1,37.1
    .fly Crossroads >>飞向十字路口
step
    .goto The Barrens,52.2,31.9
    .turnin 880 >>交任务: 变异的生物
    .accept 1489 >>接任务: 哈缪尔·符文图腾
    .accept 3301 >>接任务: 茉拉·符文图腾
step
    .goto The Barrens,52.0,31.6
    .turnin 899 >>交任务: 复仇的怒火
step
#era/som
    >>跑到塔顶
    .goto The Barrens,51.60,30.90
    .turnin 875 >>交任务: 鹰身人首领
    .accept 876 >>接任务: 塞瑞娜·血羽
step << !Tauren !Shaman !Warrior
    >>这将启动定时任务
    .goto The Barrens,51.4,30.2
    .accept 853 >>接任务: 药剂师扎玛
step
    .goto The Barrens,51.5,30.3
    .fly Camp Taurajo >>飞往陶拉霍营地
step
    .goto The Barrens,53.0,52.1
    >>为了血块杀死公毛猪
    .collect 5075 --Blood Shard (1)
step
    .goto The Barrens,44.6,59.2
    .turnin 878 >>交任务: 野猪人的内战
    .accept 5052 >>接任务: 阿迦玛甘的血岩碎片
    .turnin 5052 >>交任务: 阿迦玛甘的血岩碎片
step << Tauren/Warrior/Shaman
    +在芒果的任何抛光上使用血碎片
--N Different classes needing different buffs, e.g. need speed buff later for Mulgore run for classes that didnt get FP earlier
step
    .goto The Barrens,44.8,59.1
    .turnin 883 >>交任务: 拉克塔曼尼
    .isOnQuest 883
step
	.goto The Barrens,44.8,59.1
    .turnin 882 >>交任务: 伊沙姆哈尔
    .accept 907 >>接任务: 被激怒的雷霆蜥蜴
    .accept 1130 >>接任务: 梅洛的关注
    .accept 6382 >>接任务: 灰谷狩猎
step
    #sticky
    #label Owatanka2
    #completewith next
    .goto The Barrens,44.2,62.1,0
    .goto The Barrens,49.2,62.6,0
    .goto The Barrens,49.6,60.0,0
    >>在该区域周围搜索Owatanka(蓝雷蜥蜴)。如果你找到他，抢走他的尾钉并开始任务。如果你找不到他，跳过这个任务
    .collect 5102,1,884 --Collect Owatanka's Tailspike
    .accept 884 >>接任务: 奥瓦坦卡
step
    #label BloodShard
	.goto The Barrens,42.5,60.3,100,0
    .goto The Barrens,47.1,63.7,100,0
    .goto The Barrens,50.0,61.1,100,0
	.goto The Barrens,42.5,60.3
    >>杀死雷霆蜥蜴。抢他们的血
    .complete 907,1 --Thunder Lizard Blood (3)
step
    .goto The Barrens,44.9,59.1
    .turnin 907 >>交任务: 被激怒的雷霆蜥蜴
    .accept 913 >>接任务: 雷鹰的嘶鸣
step
    .goto The Barrens,44.9,59.1
    .turnin 884 >>交任务: 奥瓦坦卡
    .isOnQuest 884
step
    .goto The Barrens,44.9,59.1
    .turnin 907 >>交任务: 被激怒的雷霆蜥蜴
    .accept 913 >>接任务: 雷鹰的嘶鸣
step
    .goto The Barrens,44.8,63.2,100,0
    .goto The Barrens,47.0,61.6
    >>杀死一只雷鹰。掠夺它的翅膀
    .complete 913,1 --Thunderhawk Wings (1)
step
    .goto The Barrens,44.8,59.1
    .turnin 913 >>交任务: 雷鹰的嘶鸣
    .accept 874 >>接任务: 玛伦·星眼
step << !Tauren !Warrior !Shaman
    #completewith next
    .goto The Barrens,44.54,59.27
    >>将你的血碎片交给来自芒果的风之精灵buff。如果意外出售了任何碎片，请跳过此步骤
    .turnin 889 >>交任务: 风之魂
step << !Tauren !Warrior !Shaman
    .goto Thunder Bluff,32.0,66.9,40 >>跑向电梯，进入雷霆崖
step << Tauren/Warrior/Shaman
    .goto The Barrens,44.5,59.1
    .fly Thunder Bluff >>飞向雷霆崖
step << Warlock/Priest
    .goto Thunder Bluff,41.2,61.4
	.trainer >>训练员工技能
step << Rogue
    .goto Thunder Bluff,41.2,61.4
	.trainer >>训练锤技能
step
    .goto Thunder Bluff,45.9,64.7
    .home >>将您的炉石设置为雷霆崖
step << Shaman/Warrior
	#softcore
    #sticky
    #completewith next
    +如果更便宜的话，可以从拍卖行买一个绿色的2小时锤
step << Shaman/Warrior
    .goto Thunder Bluff,53.2,58.2
    >>如果是升级版，请从Etu购买一个Maul
    .collect 924,1
step << Rogue
    .goto Thunder Bluff,53.2,56.8
     >>如果是升级，请从卡德购买长剑
    .collect 923,1
step << skip
    .goto Thunder Bluff,61.4,80.9
    .turnin 1130 >>交任务: 梅洛的关注
    .accept 1131 >>接任务: 钢齿土狼
step << Hunter
	#era
    .goto Thunder Bluff,59.15,86.88
    .trainer >>训练你的职业咒语
step << Hunter
	#era
    .goto Thunder Bluff,54.10,83.97
    .trainer >>训练您的宠物技能
step << Warrior
	#era
    .goto Thunder Bluff,57.2,87.4
    .accept 1823 >>接任务: 和鲁迦交谈
    .trainer >>训练你的职业咒语
step << Druid
	#era
    .goto Thunder Bluff,77.0,29.9
	.trainer >>去训练你的职业咒语
step << !Tauren !Warrior !Shaman
    #completewith next
    .goto Thunder Bluff,30.1,30.0,15 >>走进视野之池
step << !Tauren !Warrior !Shaman
    #sticky
	#label UntilD
    .goto Thunder Bluff,28.4,27.7
    .accept 264 >>接任务: 至死方休
step << !Tauren !Warrior !Shaman
    .goto Thunder Bluff,23.00,21.00
    .turnin 853 >>交任务: 药剂师扎玛
step << Priest
	#era
    .goto Thunder Bluff,24.56,22.60
    .trainer >>训练你的职业咒语
step << Mage
	#era
    .goto Thunder Bluff,25.16,20.95
    .trainer >>训练你的职业咒语
step << Shaman
	#era
    .goto Thunder Bluff,25.1,20.6
    .trainer >>训练你的职业咒语
step << Hunter
    .goto Thunder Bluff,46.8,45.8
     >>如果是升级版，请从Kuna购买重型递归弓。还要买箭来填充你的箭袋
    .collect 3027,1
step << !Tauren !Shaman !Warrior
	#requires UntilD
    .goto Thunder Bluff,46.9,49.9
    .fp Thunder Bluff >>获得Thunder Bluff飞行路线
step << !Warlock/!Shaman
	#som
    .goto The Barrens,51.50,30.34
	.fly Orgrimmar >>飞向十字路口
step << Warlock/Shaman
	#som
    .goto The Barrens,51.50,30.34
	.fly Orgrimmar >>飞往奥格瑞玛
step << Shaman
	#som
    .goto Orgrimmar,38.6,36.0
.trainer >>去训练你的职业咒语
step << Shaman
	#som
    .goto Orgrimmar,37.95,37.73
	.accept 1528 >>接任务: 水之召唤
step << Warlock
	#som
    .goto Orgrimmar,48.15,45.28
    .accept 1507 >>接任务: 噬魂者
	.trainer >>训练你的职业咒语
step << Warlock
	#som
    .goto Orgrimmar,47.5,46.7
	.vendor >>如果你有钱，买你的宠物法术升级。
step << Warlock
	#som
    .goto Orgrimmar,47.20,46.61
    .turnin 1507 >>交任务: 噬魂者
    .accept 1508 >>接任务: 盲眼卡祖尔
step << Warlock
	#som
    .goto Orgrimmar,37.26,59.63
    .turnin 1508 >>交任务: 盲眼卡祖尔
    .accept 1509 >>接任务: 多格兰的消息
step << Warlock
	#som
    .goto Orgrimmar,44.4,48.6
    .collect 5211,1 >>如果你有钱买黄昏魔杖。
step << Warlock/Shaman
	#som
    .goto Orgrimmar,45.13,63.88
	.fly Crossroads >>飞向十字路口
step << Warlock
	#som
    .goto The Barrens,51.9,30.3
    .turnin 1509 >>交任务: 多格兰的消息
    .accept 1510 >>接任务: 多格兰的消息
step
#era/som
    >>杀死Serena Bloodfeather。抢她的头
	.goto The Barrens,39.2,12.2
    .complete 876,1 --Serena's Head (1)
step
    .goto The Barrens,35.3,27.9
    .turnin 1062 >>交任务: 地精侵略者
    .turnin 6629 >>交任务: 杀死格鲁迪格·暗云
    .turnin 6523 >>交任务: 保护卡雅
    .accept 6401 >>接任务: 卡雅还活着
    .accept 1063 >>接任务: 长者
    .accept 1068 >>接任务: 伐木机
step << Warlock
	>>沿着左边的小路跑
    .goto Stonetalon Mountains,82.19,98.62,60,0
    .goto Stonetalon Mountains,75.77,97.32,60,0
    .goto Stonetalon Mountains,73.2,95.1
    .turnin 1510 >>交任务: 多格兰的消息
    .accept 1511 >>接任务: 肯兹格拉的伤药
step
	>>沿着左边的小路跑，然后进入洞穴 << !Warlock
    .goto Stonetalon Mountains,82.19,98.62,60,0 << !Warlock
    .goto Stonetalon Mountains,75.77,97.32,60,0 << !Warlock
    .goto Stonetalon Mountains,74.21,97.10,50,0
    .goto Stonetalon Mountains,74.53,97.94
    .accept 1058 >>接任务: 金吉尔的森林魔法
	#era
step
    .goto Stonetalon Mountains,71.3,95.1
    .turnin 6461 >>交任务: 盗窃的蜘蛛
step << Hunter
    >>点击通缉海报
    .goto Stonetalon Mountains,59.0,75.7
    .accept 6284 >>接任务: 贝瑟莱斯
step << Hunter
    .goto Stonetalon Mountains,52.61,71.85
    >>清理贝塞莱斯周围的区域。小心点，因为他会上网
    >>这个任务是可选的。如果你做不到，跳过这个任务
    .complete 6284,1 --Collect Besseleth's Fang (x1)
	.unitscan Besseleth
step
	>>沿着左边的小路跑
    .goto Stonetalon Mountains,49.08,62.44,40,0
    .goto Stonetalon Mountains,48.61,63.22,40,0
    .goto Stonetalon Mountains,47.3,64.2
    .accept 6562 >>接任务: 帮助耶努萨克雷
    .accept 6393 >>接任务: 元素战争
step << Hunter
	.isQuestComplete 6284
    .goto Stonetalon Mountains,47.20,61.16
	.turnin 6284 >>交任务: 贝瑟莱斯
step
    .goto Stonetalon Mountains,45.12,59.84
    .fp Sun Rock>>获取Sun Rock Retreat飞行路线
step
    .goto Stonetalon Mountains,47.5,58.4
--    .accept 6301 >>接任务: 生生不息
    .turnin 6401 >>交任务: 卡雅还活着
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >>交任务: 新的指示
step
	#era
    .unitscan XT:9
    >>杀死XT:9。它在河的南侧巡逻
    .goto Stonetalon Mountains,60.23,53.04,90,0
    .goto Stonetalon Mountains,71.04,57.76
    .complete 1068,2 --XT:9 (1)
step
	#era
    .unitscan XT:4
    >>杀死XT:4。它在河的北侧巡逻
    .goto Stonetalon Mountains,71.30,44.12,90,0
    .goto Stonetalon Mountains,63.96,47.37
    .complete 1068,1 --XT:4 (1)
step
	.goto Stonetalon Mountains,78.2,42.8,40,0
	.goto Ashenvale,42.3,71.0,20    >>前往Talondep Path。穿过洞穴跑到灰谷
step
	#completewith next
	.goto Ashenvale,16.3,29.8,90 >>前往Zoram'gar前哨。途中一定要避开阿斯特拉纳卫队
step
     #completewith next
    .goto Ashenvale,12.20,33.80
    .fp Zoram'gar Outpost >>获取Zoram'gar前哨飞行路线
step
	#sticky
	#label VorshaL
    .goto Ashenvale,12.06,34.63
     >>开始护送任务。小心，因为这很难，并且快速完成接下来的两个步骤
    .accept 6641 >>接任务: 鞭笞者沃尔沙
step
	>>在Zoram'gar完成所有任务
    .goto Ashenvale,11.60,34.30
    .turnin 6562 >>交任务: 帮助耶努萨克雷
    .accept 6442 >>接任务: 佐拉姆海岸的纳迦
    .accept 216 >>接任务: 蓟皮熊怪的麻烦
    .accept 6462 >>接任务: 巨魔符咒
--N might need to be changed back to accepting later depending on no. of quests in log
step
    #sticky
    #completewith next
    +下一个任务可能很难，要格外小心。老板造成了很大的损失。
    #hardcore
step
	#requires VorshaL
    >>到达后，单击“钎焊器”。
    >>会有纳加海浪产卵。一旦沃沙出来，让莫格拉什在与他战斗之前先发脾气。
    .goto Ashenvale,9.8,27.4
    .complete 6641,1 --Defeat Vorsha the Lasher
step
    .goto Ashenvale,15.00,20.67
    >>杀死Nagas。抢他们的头
    .complete 6442,1 --Wraithtail Head (20)
step << !Druid
    .goto Ashenvale,7.00,15.20
.xp 21+18070>>提升经验到18070+/25200 xp
step << Druid
    .goto Ashenvale,7.00,15.20
.xp 21+18070>>提升经验到21450+/25200 xp
step
    #sticky
	#label Vorsha
    .goto Ashenvale,12.20,34.30
    .turnin 6641 >>交任务: 鞭笞者沃尔沙
step
    .goto Ashenvale,11.70,34.80
    .turnin 6442 >>交任务: 佐拉姆海岸的纳迦
step << Druid
	#requires Vorsha
	>>使用“传送到月光”法术
    .goto Moonglade,52.5,40.5
.trainer >>去训练你的职业咒语
step
	#requires Vorsha
    #completewith next
    .hs >>炉底雷霆崖
step
    .goto Thunder Bluff,54.60,51.40
	#requires Vorsha
	.accept 1195 >>接任务: 神圣之火
step
    .goto Thunder Bluff,70.00,30.90
    .turnin 1063 >>交任务: 长者
    .accept 1064 >>接任务: 被遗忘者的援助
step
    .goto Thunder Bluff,78.62,28.56
    .turnin 1489 >>交任务: 哈缪尔·符文图腾
    .accept 1490 >>接任务: 纳拉·蛮鬃
step
    .goto Thunder Bluff,75.65,31.62
    .turnin 1490 >>交任务: 纳拉·蛮鬃
step << Tauren/Warrior/Shaman
	>>走进视野之池
    .goto Thunder Bluff,30.1,30.0,25,0
    .goto Thunder Bluff,28.4,27.7
    .accept 264 >>接任务: 至死方休
step
    .goto Thunder Bluff,23.00,21.0
   .turnin 1064 >>交任务: 被遗忘者的援助
   .accept 1065 >>接任务: 塔伦米尔之旅
step << Priest
    .goto Thunder Bluff,25.4,15.0
	.accept 5644 >>接任务: 噬灵瘟疫
step << Shaman
    .goto Thunder Bluff,25.1,20.6
	.accept 1529 >>接任务: 水之召唤
step
    .goto Thunder Bluff,54.70,51.30
    .accept 1195 >>接任务: 神圣之火
step << Warlock
    .goto Thunder Bluff,46.8,50.0
    .fly Camp Taurajo >>飞往陶拉霍营地
step << Warlock
    .goto The Barrens,44.6,59.3
    .turnin 1511 >>交任务: 肯兹格拉的伤药
    .accept 1515 >>接任务: 多格兰之囚
step << Warlock
	.goto The Barrens,43.3,47.9
    .turnin 1515 >>交任务: 多格兰之囚
    .accept 1512 >>接任务: 爱的礼物
step << Warlock
	.goto The Barrens,44.4,59.0
    .fly Crossroads >>飞向十字路口
step << !Warlock
    .goto Thunder Bluff,46.8,50.0
    .fly Crossroads >>飞向十字路口
step
#era/som
    .goto The Barrens,51.60,30.90
    .turnin 876 >>交任务: 塞瑞娜·血羽
    .accept 1060 >>接任务: 写给金吉尔的信
step
    .goto The Barrens,51.10,29.60
    .accept 868 >>接任务: 蝎卵
step
    .goto The Barrens,51.50,30.87
    .accept 6541 >>接任务: 向卡德拉克报到
step << Hunter
    .goto The Barrens,49.00,11.20
    .turnin 3921 >>交任务: 维妮·布特巴克
step
	>>去塔的二楼
    .goto The Barrens,48.12,5.42
    .turnin 6541 >>交任务: 向卡德拉克报到
--    .accept 6543 >>接任务: 战歌报告
step << Hunter
    .goto Ashenvale,68.30,75.30
     >>开始护送任务
    .accept 6544 >>接任务: 托雷克的突袭
step << Hunter
     .goto Ashenvale,64.74,75.35,0
     >>护送Torek。当你杀死里面的怪物4时，跑到最后一个平台(因为会有更多的怪物产生)，让兽人反抗
     >>杀死对托雷克有仇恨的暴徒，然后杀死其他人。
    .complete 6544,1 --Take Silverwing Outpost. (1)
step << Hunter
    .goto Ashenvale,73.00,62.50
    .turnin 6544 >>交任务: 托雷克的突袭
step << Hunter
    .goto Ashenvale,73.78,61.46
    .turnin 6382 >>交任务: 灰谷狩猎
    .turnin 6383 >>交任务: 灰谷狩猎
step << Hunter
    .goto Ashenvale,73.13,61.54
    .fly Orgrimmar >>飞往奥格瑞玛
	.maxlevel 24
step << Shaman
    .goto The Barrens,51.5,30.4
    .fly Ratchet >>飞到棘轮
step << Shaman
	#completewith call
    .goto The Barrens,65.8,43.8
    .turnin 1528 >>交任务: 水之召唤
step << Shaman
	#completewith next
    .goto The Barrens,65.8,43.8
    .turnin 1529 >>交任务: 水之召唤
step << Shaman
	#label call
    .goto The Barrens,65.8,43.8
    .accept 1530 >>接任务: 水之召唤
    .turnin 874 >>交任务: 玛伦·星眼
step << Shaman
    .goto The Barrens,63.1,37.1
    .fly Camp Taurajo >>飞往陶拉霍营地
step << Shaman
    .goto The Barrens,45.6,59.0
    .home >>将您的炉石设置为陶拉霍营地
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1530 >>交任务: 水之召唤
    .accept 1535 >>接任务: 水之召唤
step << Shaman
    .goto The Barrens,44.1,76.9
    .complete 1535,1 --Filled Brown Waterskin (1)
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1535 >>交任务: 水之召唤
    .accept 1536 >>接任务: 水之召唤
step << !Hunter !Mage
	#era/som
    .goto The Barrens,51.5,30.3 << !Shaman
    .goto The Barrens,44.5,59.1 << Shaman
    .fly Orgrimmar >>飞往奥格瑞玛
step << !Hunter !Mage !Shaman !Rogue !Warlock
	#som
	#phase 3-6
    .goto The Barrens,51.5,30.3 << !Shaman
    .goto The Barrens,44.5,59.1 << Shaman
    .fly Orgrimmar >>飞往奥格瑞玛
	.maxlevel 24
step << Shaman/Rogue/Warlock
    .goto The Barrens,51.5,30.3
    .fly Orgrimmar >>飞往奥格瑞玛
step << Mage
	#som
	.zone Orgrimmar >>前往: 奥格瑞玛
	.maxlevel 24
]])
