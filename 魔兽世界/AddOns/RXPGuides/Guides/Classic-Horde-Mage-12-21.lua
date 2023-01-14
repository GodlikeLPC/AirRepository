RXPGuides.RegisterGuide([[
#classic
<< Horde Mage
#name 12-17 The 贫瘠之地 AoE
#version 1
#group RestedXP 部落 法师 AoE
#defaultfor Horde Mage
#next 17-21 石爪山脉/贫瘠之地 AoE

step << Mage
	#era/som
    #completewith next
	+请注意，您已经选择了AoE指南。AoE通常比单目标法师困难得多，但速度快得多
step << Mage
	#som
	#phase 3-6
    #completewith next
	+请注意，您已经选择了AoE指南。AoE通常比单目标法师困难得多，而且由于SoM中最近的100%任务xp更改，速度也较慢
step
    .goto The Barrens,52.2,31.8
    .accept 870 >>接任务: 遗忘之池
step
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交任务: 十字路口征兵
    .accept 844 >>接任务: 平原陆行鸟的威胁
step << Troll Mage
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接任务: 送往奥格瑞玛的肉
step
    .goto The Barrens,51.9,30.3
    .accept 869 >>接任务: 偷钱的迅猛龙
step
    .goto The Barrens,51.5,30.8
    .accept 871 >>接任务: 野猪人的袭击
    .accept 5041 >>接任务: 十字路口的补给品
step
    .goto The Barrens,51.5,30.4
    .fp The Crossroads >>获得the Crossroads飞行路线
step << Troll Mage
    >>不要去奥格瑞玛
    .goto The Barrens,51.5,30.3
    .turnin 6365 >>交任务: 送往奥格瑞玛的肉
    .accept 6384 >>接任务: 飞往奥格瑞玛
step
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
step << !Undead
    #sticky
    #completewith next
    >>如果你袋子里的缺陷能量石还有不到10分钟的时间，放下它，然后回去再次掠夺阿克泽洛斯旁边的紫石
    .turnin 926 >>交任务: 有瑕疵的能量石
step << !Undead
    #sticky
    #completewith BeakCave
    >>如果你有时间在瑕疵能量石上杀死一些平原漫游者。抢走他们的喙
    .complete 844,1 --Plainstrider Beak (7)
step << !Undead
    .goto The Barrens,50.4,22.0,20 >>在这里跑上山
step << !Undead
    #label BeakCave
    .goto The Barrens,47.6,19.2,20 >>前往被燃烧之刃兽人包围的洞穴
step << !Undead
    >>右键单击祭坛
    .goto The Barrens,48.0,19.1
    .collect 4986,1,924 --Collect Flawed Power Stone
    .complete 924,1 --Destroy the Demon Seed (1)
step
    #sticky
    #completewith next
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头颅-稍后你会得到更多
    .complete 869,1 --Raptor Head (12)
step
    >>杀死平原漫游者。抢走他们的喙
    .goto The Barrens,50.8,32.1
    .complete 844,1 --Plainstrider Beak (7)
step
    >>塔顶
    .goto The Barrens,51.5,30.9
    .turnin 871 >>交任务: 野猪人的袭击
    .accept 872 >>接任务: 野猪人的头目
    .accept 867 >>接任务: 鹰身强盗
step
    .goto The Barrens,52.2,31.0
    .turnin 844 >>交任务: 平原陆行鸟的威胁
    .accept 845 >>接任务: 斑马的威胁
step
    #sticky
    #completewith Crates
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
    #label Crates
	.goto The Barrens,58.5,27.3,40,0
    .goto The Barrens,58.4,27.0,40,0
    .goto The Barrens,58.5,25.8,40,0
    .goto The Barrens,59.4,24.8,40,0
    >>掠夺在该地区发现的棕色盒子
    .complete 5041,1 --Crossroads' Supply Crates (1)
step
    .goto The Barrens,56.7,25.3
    >>杀死剃须刀
    .complete 872,1 --Razormane Geomancer (8)
    .complete 872,2 --Razormane Defender (8)
step << !Undead
    #sticky
    #completewith next
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄
    .complete 845,1 --Zhevra Hooves (4)
step << !Undead
    .goto The Barrens,62.3,20.1
    .turnin 924 >>交任务: 恶魔之种
step
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄。在进入棘轮之前，确保您有4个
    .goto The Barrens,58.03,19.76,150,0 << Undead
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
step
    .goto The Barrens,62.3,38.4
    .turnin 819 >>交任务: 老陈的空酒桶
    .accept 821 >>接任务: 老陈的空酒桶
step
    #sticky
    #label Southsea
    >>杀死该地区的南海暴徒
    .complete 887,1 --Southsea Brigand (12)
    .complete 887,2 --Southsea Cannoneer (6)
step
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    >>杀死男爵Longshore。抢他的头
    .complete 895,1 --Baron Longshore's Head (1)
step
    #requires Southsea
    .goto The Barrens,62.7,36.3
    .turnin 887 >>交任务: 南海海盗
    .accept 890 >>接任务: 丢失的货物
    .turnin 895 >>交任务: 通缉：巴隆·朗绍尔
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
step
    .goto The Barrens,63.08,37.16
    .fly Crossroads >>飞向十字路口
step
    .goto The Barrens,51.5,30.8
    .turnin 5041 >>交任务: 十字路口的补给品
    .turnin 872 >>交任务: 野猪人的头目
step
    .goto The Barrens,52.2,31.0
    .turnin 845 >>交任务: 斑马的威胁
    .accept 903 >>接任务: 草原上的徘徊者
step
    #sticky
    #completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    .goto The Barrens,45.4,28.4
    .accept 850 >>接任务: 科卡尔首领
step
    .goto The Barrens,45.4,28.4
    .accept 855 >>接任务: 半人马护腕
step
    #completewith next
    >>杀死半人马座。掠夺他们的护腕。你稍后会完成这个
    .complete 855,1 --Centaur Bracers (15)
step
    >>杀死科多班。抢他的头
    .goto The Barrens,42.8,23.5
    .complete 850,1 --Kodobane's Head (1)
step
    .isQuestComplete 855
    .goto The Barrens,45.39,28.44
    .turnin 850 >>交任务: 科卡尔首领
    .turnin 855 >>交任务: 半人马护腕
step
    .goto The Barrens,45.39,28.44
    .turnin 850 >>交任务: 科卡尔首领
step
    #sticky
    #completewith Claws
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头颅-稍后你会得到更多
    .complete 869,1 --Raptor Head (12)
step
    #sticky
    #completewith next
    .goto The Barrens,41.4,24.5,40,0
    .goto The Barrens,40.4,20.0,40,0
    .goto The Barrens,41.4,24.5,40,0
    .goto The Barrens,40.4,20.0,40,0
	>>现在不要把注意力集中在获取所有这些
    .complete 821,1 --Savannah Lion Tusk (5)
step
    #label Claws
    >>杀死游荡者。掠夺他们的爪牙
    .goto The Barrens,41.4,24.5
    .complete 903,1 --Prowler Claws (7)
step
    .goto The Barrens,40.2,18.9,40,0
    .goto The Barrens,40.7,14.6,40,0
    .goto The Barrens,42.6,15.1,40,0
    .goto The Barrens,40.2,18.9,40,0
    .goto The Barrens,40.7,14.6,40,0
    .goto The Barrens,42.6,15.1,40,0
    >>杀死哈比。掠夺他们的魔爪
    .complete 867,1 --Witchwing Talon (8)
step
    #completewith next
    .goto The Barrens,43.8,12.2
    >>如果你仍然没有得到重型钉锤，请考虑从BVrang Wildgore那里购买 << Druid/Warrior
    .vendor >>如果需要的话，去找这家伙
step
    #sticky
    #completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    .goto The Barrens,54.3,12.3,40,0
    .goto The Barrens,54.6,16.7,40,0
    .goto The Barrens,42.6,15.1,40,0
    .goto The Barrens,54.3,12.3,40,0
    .goto The Barrens,54.6,16.7,40,0
    .goto The Barrens,42.6,15.1,40,0
    >>杀死猛禽。抢他们的头
    .complete 869,1 --Raptor Head (12)
step
    >>单击控制台
    .goto The Barrens,52.4,11.6
    .turnin 894 >>交任务: 什么什么平衡器
    .accept 900 >>接任务: 什么什么平衡器
step
    >>点击阀门
    .goto The Barrens,52.4,11.4
    .complete 900,2 --Shut off Fuel Control Valve (1)
step
    >>单击“阀”。当你点击其中一个按钮时，暴徒就会出现
    .goto The Barrens,52.3,11.4
    .complete 900,3 --Shut off Regulator Valve (1)
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
    >>接受碎纸机点火
    .goto The Barrens,56.5,7.5
    .accept 858 >>接任务: 打火钥匙
step
    >>磨练到16级很重要，因为接下来的3个任务相当困难。
	.xp 16 >>升级到16
step
    >>杀死监督员Lugwizzle(他在整个塔上巡逻)。抢他取点火钥匙
	.goto The Barrens,56.3,8.6
    .complete 858,1 --Ignition Key (1)
step
    >>这将开始护送
    .goto The Barrens,56.5,7.5
    .turnin 858 >>交任务: 打火钥匙
    .accept 863 >>接任务: 梅贝尔的隐形水
step
    #label Slugs
    >>2个暴徒会在某个时候繁殖。杀死他们，然后等待他的RP事件结束
    .goto The Barrens,55.3,7.8
    .complete 863,1 --Escort Wizzlecrank out of the Venture Co. drill site (1)
step
    >>在该地区捣乱暴徒。掠夺他们直到猫眼祖母绿掉落
    .goto The Barrens,61.5,4.3
    .complete 896,1 -- Cats Eye Emerald (1)
step
    #completewith next
	.goto Orgrimmar,11.5,67.0,40 >>跑到奥格瑞玛的西入口
step
    .goto Orgrimmar,38.79,85.68
    .trainer >>训练你的职业咒语
step
    .goto Orgrimmar,54.2,68.6
    .turnin 6384 >>交任务: 飞往奥格瑞玛
    .accept 6385 >>接任务: 双足飞龙管理员多拉斯
step
    >>跑向飞行管理员。不要在任何地方飞行
    .goto Orgrimmar,45.2,63.8
    .fp Orgrimmar >>获取Orgrimmar飞行路线 << Undead
    .turnin 6385 >>交任务: 双足飞龙管理员多拉斯
    .accept 6386 >>接任务: 返回十字路口
step
    >>跑去Grommash Hold
    .goto Orgrimmar,39.1,38.1
    .accept 1061 >>接任务: 石爪之灵
step
    #completewith next
    .hs >>炉膛到十字路口
step
    .goto The Barrens,52.6,29.9
    .turnin 6386 >>交任务: 返回十字路口
step
    .goto The Barrens,51.9,30.3
    .turnin 869 >>交任务: 偷钱的迅猛龙
    .accept 3281 >>接任务: 被偷走的银币
step
    .goto The Barrens,52.3,31.0
    .turnin 903 >>交任务: 草原上的徘徊者
    .accept 881 >>接任务: 埃其亚基
step
    >>用你袋子里的Echeyakee之角召唤Echeyake。杀了他，抢走他的藏身之地
    .goto The Barrens,55.5,17.3
    .complete 881,1 --Echeyakee's Hide (1)
step
    .goto The Barrens,52.2,31.0
    .turnin 881 >>交任务: 埃其亚基
    .accept 905 >>接任务: 狂暴的镰爪龙
step
    .goto The Barrens,52.20,31.90
    .turnin 870 >>交任务: 遗忘之池
    .accept 877 >>接任务: 死水绿洲
step
    .goto The Barrens,52.00,31.60
    .accept 899 >>接任务: 复仇的怒火
    .accept 4921 >>接任务: 在战斗中失踪
step
    >>塔顶
    .goto The Barrens,51.6,30.9
    .turnin 867 >>交任务: 鹰身强盗
    .accept 875 >>接任务: 鹰身人首领
step
    .goto The Barrens,51.50,30.20
    .turnin 848 >>交任务: 菌类孢子
step
    .goto The Barrens,51.5,30.3
    .fly Ratchet >>飞到棘轮
step
    .goto The Barrens,63.0,37.2
    .turnin 902 >>交任务: 什么什么平衡器
    .turnin 863 >>交任务: 梅贝尔的隐形水
    .accept 1483 >>接任务: 菲兹克斯
step
    .goto The Barrens,63.30,38.40
    .turnin 896 >>交任务: 矿工的宝贝
step
    .goto The Barrens,62.40,37.70
    .accept 1069 >>接任务: 深苔蜘蛛的卵
step
    >>掠夺板条箱
    .goto The Barrens,63.6,49.2
    .complete 888,2 --Telescopic Lens (1)
step
    >>掠夺板条箱
    .goto The Barrens,62.6,49.6
step
    #sticky
    #completewith Nest
    >>杀死你看到的猛禽。掠夺他们的角和羽毛。当他们猛击时要小心
    .complete 865,1 --Intact Raptor Horn (5)
step
    >>抢走被盗的银子
    >>把你得到的Sunscale羽毛留到以后
    .goto The Barrens,57.4,52.4,90,0
    .goto The Barrens,58.0,53.9
    .complete 3281,1 --Stolen Silver (1)
step
    >>点击水下的气泡裂缝
    .goto The Barrens,55.6,42.7
    .complete 877,1 --Test the Dried Seeds (1)
step
    #sticky
	#completewith next
    >>杀死半人马座。抢走他们的护腕
    .complete 855,1 --Centaur Bracers (15)
step
    >>在湖边碾磨任何一个Centuar，直到它们产卵Verog(当它产卵时，你会在聊天中看到一声尖叫)
    .goto The Barrens,52.95,41.77
    .complete 851,1 --Verog's Head (1)
step
    >>单击鸡蛋。你需要猛禽身上的太阳羽毛
    .goto The Barrens,52.6,46.2
    .complete 905,1 --Visit Blue Raptor Nest (1)
step
    >>单击鸡蛋。你需要猛禽身上的太阳羽毛
    .goto The Barrens,52.5,46.6
    .complete 905,3 --Visit Red Raptor Nest (1)
step
    #label Nest
    >>单击鸡蛋。你需要猛禽身上的太阳羽毛
    .goto The Barrens,52.0,46.5
    .complete 905,2 --Visit Yellow Raptor Nest (1)
step
    .goto The Barrens,57.3,53.7,40,0
    .goto The Barrens,52.0,46.5,40,0
    .goto The Barrens,57.3,53.7,40,0
    .goto The Barrens,52.0,46.5,40,0
    .goto The Barrens,57.3,53.7,40,0
    .goto The Barrens,52.0,46.5,40,0
    .goto The Barrens,57.3,53.7,40,0
    .goto The Barrens,52.0,46.5,40,0
    >>杀死猛禽。抢走他们的角
    .complete 865,1 --Intact Raptor Horn (5)
step
    >>与Mankrik的妻子交谈
    .goto The Barrens,49.3,50.4
    .complete 4921,1 --Find Mankrik's Wife (1)
step
    .goto The Barrens,45.6,59.0
    .home >>将您的炉石设置为陶拉霍营地
step
    .goto The Barrens,44.5,59.2
    .accept 878 >>接任务: 野猪人的内战
step
    .goto The Barrens,44.5,59.2
    .fp Camp Taurajo >>获得Taurajo营地飞行路线
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
step
    #sticky
	#completewith next
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    .goto The Barrens,45.39,28.43
    .turnin 851 >>交任务: 狂热的维罗戈
    .accept 852 >>接任务: 赫兹鲁尔·血印
step
    .goto The Barrens,45.39,28.43
    .turnin 855 >>交任务: 半人马护腕
    .isQuestComplete 855
step
    .goto The Barrens,45.39,28.43
    .turnin 851 >>交任务: 狂热的维罗戈
    .accept 852 >>接任务: 赫兹鲁尔·血印
step
    #sticky
	#label CeBracers
    >>杀死半人马座。抢走他们的护腕
    .complete 855,1 --Centaur Bracers (15)
step
    .goto The Barrens,45.87,40.80
    >>赫兹鲁尔在大WC湖周围巡逻
    .complete 852,1 --Hezrul's Head (1)
step
	#requires CeBracers
	.goto The Barrens,45.37,28.43
    .turnin 852 >>交任务: 赫兹鲁尔·血印
    .turnin 855 >>交任务: 半人马护腕
step
    .goto The Barrens,45.37,28.43
    .accept 4021 >>接任务: 人马无双！
step
    >>这个任务可能很难单独完成，如果你没有人与你一起组队，可以考虑为它分组，或者在任务给予者的建筑附近放风筝。
    >>如果太难就跳过这个
    .goto The Barrens,44.33,28.14
    .complete 4021,1 --Piece of Krom'zar's Banner (1)
--N Link to safespot abuse
step
    .isQuestComplete 4021
    .goto The Barrens,45.39,28.44
    .turnin 4021 >>交任务: 人马无双！
step
    .goto The Barrens,39.8,17.3,80,0
    .goto The Barrens,37.4,15.8,80,0
    .goto The Barrens,40.3,15.2,80,0
    .goto The Barrens,39.8,17.3,80,0
    .goto The Barrens,37.4,15.8,80,0
    .goto The Barrens,40.3,15.2,80,0
    .goto The Barrens,39.8,17.3,80,0
    .goto The Barrens,37.4,15.8,80,0
    .goto The Barrens,40.3,15.2,80,0
    .goto The Barrens,39.8,17.3
    >>杀死巫师之翼杀戮者。掠夺他们以换取哈比中尉戒指
    .complete 875,1 --Harpy Lieutenant Ring (6)
step
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
<< Horde Mage
#name 17-21 石爪山脉/贫瘠之地 AoE
#version 1
#group RestedXP 部落 法师 AoE
#defaultfor Horde Mage
#next 21-30 银松森林/希尔斯布莱德丘陵 AoE

step
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0,50,0
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0,50,0
    >>杀死该地区的格里姆特姆斯
    .complete 6548,2 --Kill Grimtotem Mercenary (x6)
    .complete 6548,1 --Kill Grimtotem Ruffian (x8)
step
    .goto The Barrens,35.2,27.8
    .turnin 6548 >>交任务: 为我的村庄复仇
    .accept 6629 >>接任务: 杀死格鲁迪格·暗云
step
    >>从西边的小路进入村庄。在开始内部任务之前，确保杀死所有6只野兽。在主帐篷前杀死格隆迪希
    .goto Stonetalon Mountains,71.7,86.7,60,0
    .goto Stonetalon Mountains,74.0,86.2
    .complete 6629,1 --Kill Grundig Darkcloud (x1)
    .complete 6629,2 --Kill Grimtotem Brute (x6)
step
    >>启动卡亚护送
    .goto Stonetalon Mountains,73.5,85.8
    .accept 6523 >>接任务: 保护卡雅
step
     >>护送Kaya并靠近她。3灰熊会在篝火旁产卵。在她到达营地之前吃/喝
    .goto Stonetalon Mountains,75.8,91.4
    .complete 6523,1 --Kaya Escorted to Camp Aparaje
step
    .goto Stonetalon Mountains,71.4,95.1
    .accept 6461 >>接任务: 盗窃的蜘蛛
step
    #sticky
    #label deepmossegg
    >>点击树旁的蜘蛛蛋
    .complete 1069,1 --Collect Deepmoss Egg (x15)
step
    >>杀死该地区的深苔藓蜘蛛
    .goto Stonetalon Mountains,57.5,76.2,60,0
    .goto Stonetalon Mountains,54.7,71.9,60,0
    .goto Stonetalon Mountains,52.6,71.8,60,0
    .goto Stonetalon Mountains,52.2,75.6,60,0
    .goto Stonetalon Mountains,53.9,74.2,60,0
    .goto Stonetalon Mountains,54.7,71.9,60,0
    .goto Stonetalon Mountains,52.6,71.8,60,0
    .goto Stonetalon Mountains,52.2,75.6,60,0
    .goto Stonetalon Mountains,53.9,74.2,60,0
    .goto Stonetalon Mountains,54.7,71.9
    .complete 6461,1 --Kill Deepmoss Creeper (x10)
    .complete 6461,2 --Kill Deepmoss Venomspitter (x7)
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1483 >>交任务: 菲兹克斯
    .accept 1093 >>接任务: 超级收割机6000
step
    #sticky
    #requires deepmossegg
    #completewith next
    >>在搜索操作员以获取蓝图时杀死记录器
    .complete 1062,1 --Kill Venture Co. Logger (x15)
step
    #requires deepmossegg
    >>杀死Venture Co.Operators直到你拿到蓝图
    .goto Stonetalon Mountains,62.8,53.7,40,0
    .goto Stonetalon Mountains,61.7,51.5,40,0
    .goto Stonetalon Mountains,66.8,45.3,40,0
    .goto Stonetalon Mountains,71.7,49.9,40,0
    .goto Stonetalon Mountains,74.3,54.7,40,0
    .goto Stonetalon Mountains,62.8,53.7,40,0
    .complete 1093,1 --Collect Super Reaper 6000 Blueprints (x1)
step
    >>结束杀死记录器
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .complete 1062,1 --Kill Venture Co. Logger (x15)
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1093 >>交任务: 超级收割机6000
    .accept 1094 >>接任务: 新的指示
step
    .hs >>炉灶前往陶拉霍营地
step
    .goto The Barrens,44.9,59.1
    .turnin 3261 >>交任务: 乔恩·星眼
    .accept 882 >>接任务: 伊沙姆哈尔
step
    #sticky
    #label Lizard
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
    >>杀死大量的绒猪。掠夺他们的象牙。保存你得到的血块
	.goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,45.2,54.3,50,0
	.goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,45.2,54.3,50,0
	.goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,45.2,54.3,50,0
	.goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,45.2,54.3,50,0
	.complete 878,1 --Kill Bristleback Water Seeker (x6)
    .complete 878,2 --Kill Bristleback Thornweaver (x12)
    .complete 878,3 --Kill Bristleback Geomancer (x12)
    .complete 899,1 --Collect Bristleback Quilboar Tusk (x60)
step
    #sticky
    #completewith Ishamuhale
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    #requires Lizard
    >>环湖和AoE海龟。抢他们的壳
	.goto The Barrens,55.5,42.6
    .complete 880,1 --Altered Snapjaw Shell (8)
step
   #completewith next
	>>在该地区杀死一名哲夫拉。掠夺尸体
	.goto The Barrens,61.0,32.2
	.collect 10338,1 --Collect Fresh Zhevra Carcass
step
	#label Ishamuhale
    >>用枯树上的新鲜哲夫拉尸体召唤Ishamuhale。杀了他，抢了他的牙
	.goto The Barrens,59.9,30.4
    .complete 882,1 --Ishamuhale's Fang (1)
step
    >>杀死平原漫游者。掠夺他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
	.goto The Barrens,62.7,36.3
    >>跑回棘轮
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
    >>塔顶
    .goto The Barrens,51.60,30.90
    .turnin 875 >>交任务: 鹰身人首领
    .accept 876 >>接任务: 塞瑞娜·血羽
step
    >>这将启动定时任务
    .goto The Barrens,51.4,30.2
    .turnin 848 >>交任务: 菌类孢子
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
--N Different classes needing different buffs, e.g. need speed buff later for Mulgore run for classes that didnt get FP earlier
step
    .goto The Barrens,44.8,59.1
    .turnin 882 >>交任务: 伊沙姆哈尔
    .accept 907 >>接任务: 被激怒的雷霆蜥蜴
    .accept 1130 >>接任务: 梅洛的关注
step
    .goto The Barrens,44.8,59.1
    .isOnQuest 883
    .turnin 883 >>交任务: 拉克塔曼尼
step
    .goto The Barrens,44.8,59.1
    .turnin 882 >>交任务: 伊沙姆哈尔
    .accept 907 >>接任务: 被激怒的雷霆蜥蜴
    .accept 1130 >>接任务: 梅洛的关注
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
    .goto The Barrens,42.5,60.3,30,0
    .goto The Barrens,47.1,63.7,30,0
    .goto The Barrens,50.0,61.1,30,0
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
    .goto The Barrens,44.8,63.2,30,0
    .goto The Barrens,47.0,61.6,30,0
    .goto The Barrens,44.8,63.2,30,0
    .goto The Barrens,47.0,61.6,30,0
    .goto The Barrens,44.8,63.2,30,0
    .goto The Barrens,47.0,61.6,30,0
    >>杀死一只雷鹰。掠夺它的翅膀
    .complete 913,1 --Thunderhawk Wings (1)
step
    .goto The Barrens,44.8,59.1
    .turnin 913 >>交任务: 雷鹰的嘶鸣
--    .accept 874 >>接任务: 玛伦·星眼
step
    #completewith next
    .goto The Barrens,44.54,59.27
    >>将你的血碎片交给来自芒果的风之精灵buff。如果意外出售了任何碎片，请跳过此步骤
    .turnin 889 >>交任务: 风之魂
step
    .goto Thunder Bluff,32.0,66.9,60 >>跑向电梯，进入雷霆崖
step
    .goto Thunder Bluff,45.9,64.7
    .home >>将您的炉石设置为雷霆崖
step
    .goto Thunder Bluff,61.4,80.9
    .turnin 1130 >>交任务: 梅洛的关注
    .accept 1131 >>接任务: 钢齿土狼
step
 	>>走进视野之池
	.goto Thunder Bluff,30.1,30.0,30,0
	.goto Thunder Bluff,23.00,21.00
    .turnin 853 >>交任务: 药剂师扎玛
step
    .goto Thunder Bluff,25.16,20.95
    .trainer >>训练你的职业咒语
	>>还没有回复AoE(如果你已经达到消防规范)
step
    .goto Thunder Bluff,28.4,27.7
    .accept 264 >>接任务: 至死方休
step
	.goto Thunder Bluff,46.9,49.9
    .fp Thunder Bluff >>获得Thunder Bluff飞行路线
    .fly Crossroads >>飞向十字路口
step
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
--    .accept 1068 >>接任务: 伐木机
step
    .goto Stonetalon Mountains,71.3,95.1
    .turnin 6461 >>交任务: 盗窃的蜘蛛
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >>交任务: 新的指示
step
    .goto Stonetalon Mountains,47.5,58.4
    .turnin 6401 >>交任务: 卡雅还活着
step
    .goto Stonetalon Mountains,45.12,59.84
    .fp Sun Rock>>获取Sun Rock Retreat飞行路线
step
    #completewith next
    .hs >>炉底雷霆崖
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
step
    .goto Thunder Bluff,23.00,21.0
    .turnin 1064 >>交任务: 被遗忘者的援助
    .accept 1065 >>接任务: 塔伦米尔之旅
step
    .goto Thunder Bluff,25.16,20.95
    .trainer >>如果需要，训练你的职业法术
	>>如果你还没有，请尊重Frost AoE
step
    .goto Thunder Bluff,46.8,50.0
    .fly The Crossroads >>飞向十字路口
step
    .goto The Barrens,51.60,30.90
	>>上楼去
    .turnin 876 >>交任务: 塞瑞娜·血羽
step
    .goto The Barrens,51.50,30.34
    .fly Orgrimmar >>飞往奥格瑞玛
]])
