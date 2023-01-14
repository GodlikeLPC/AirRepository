RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 冰冠炮舰解锁日常任务

step
	+注意：在冰冠中，许多每日任务都有5个玩家组任务作为先决条件。你必须完成它们才能解锁正在进行的每日任务。按照向导的指示完成所有团队任务
	>>如果无法完成，请稍后返回给他们
step
    .goto IcecrownGlacier,87.8,78.1
    .fp The Argent Vanguard >>获得银色先锋飞行路线
step
    .goto IcecrownGlacier,87.5,75.8
	>>飞到银色先锋。与提里奥交谈
    .accept 13036 >>接任务: 无上的荣耀
step
    .goto IcecrownGlacier,87.1,75.8
	>>与你下面的Entari交谈
    .turnin 13036 >>交任务: 无上的荣耀
    .accept 13008 >>接任务: 天灾的战术
step
    .goto IcecrownGlacier,86.8,76.6
	>>与古斯塔夫交谈
    .accept 13040 >>接任务: 致命的剧毒
step
    .goto IcecrownGlacier,86.1,75.8
	>>与Dalfors交谈
    .accept 13039 >>接任务: 保卫前线基地
step
	#sticky
	#label webbedfreed
    .goto IcecrownGlacier,83.5,75.1,0,0
	>>杀死该地区的网状十字军茧以释放它们。他们也会给你增色和治愈 << !Paladin
	>>杀死该地区的网状十字军茧以释放它们。确保你给自己加了除国王以外的东西，因为npc会用它来加你(并治疗你) << Paladin
    .complete 13008,1 --Webbed Crusader Freed (8)
step
    .goto IcecrownGlacier,84.7,78.8,80,0
    .goto IcecrownGlacier,83.5,75.1,80,0
    .goto IcecrownGlacier,83.1,72.6,80,0
    .goto IcecrownGlacier,84.8,73.0,80,0
    .goto IcecrownGlacier,83.5,75.1
	>>杀死该地区的Nerubians和Spiders。掠夺他们的毒液袋
    .complete 13039,1 --Forgotten Depths Nerubians (15)
    .complete 13040,1 --Forgotten Depths Venom Sac (10)
step
	#requires webbedfreed
    .goto IcecrownGlacier,86.1,75.8
	>>返回Dalfors
    .turnin 13039 >>交任务: 保卫前线基地
step
    .goto IcecrownGlacier,86.8,76.6
	>>返回古斯塔夫
    .turnin 13040 >>交任务: 致命的剧毒
step
    .goto IcecrownGlacier,87.1,75.8
	>>返回Entari
    .turnin 13008 >>交任务: 天灾的战术
    .accept 13044 >>接任务: 如果还有幸存者……
step
    .goto IcecrownGlacier,87.0,79.0
	>>与Penumbrius交谈
    .turnin 13044 >>交任务: 如果还有幸存者……
    .accept 13045 >>接任务: 空中救兵
step
	#completewith next
    .goto IcecrownGlacier,87.1,79.2
	.vehicle 30228 >>右击一个银色天爪来安装它
step
	>>飞去天灾之城。使用“俘虏十字军”(1)营救十字军(一次只能抓到一个)，然后飞回银色先锋的古斯塔夫，使用“缴获十字军的掉落”(2)让他们掉落。冷却时使用“飞翔”(3)加快速度。
	.pin Icecrown,78.7,67.0
    .waypoint IcecrownGlacier,78.7,67.0,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
	.goto Icecrown,86.68,76.83
    .complete 13045,1 --Captured Crusader Rescued (3)
step
    .goto IcecrownGlacier,87.5,75.8
	>>飞回提里奥
    .turnin 13045 >>交任务: 空中救兵
    .accept 13070 >>接任务: 冷锋逼近
step
    .goto IcecrownGlacier,85.6,76.0
	>>在小房子里和Fezzik交谈
    .turnin 13070 >>交任务: 冷锋逼近
    .accept 13086 >>接任务: 最后一道防线
step
	#completewith next
    .goto IcecrownGlacier,85.3,75.8
	.vehicle >>飞到位于墙壁顶部的一个炮塔内
step
    .goto IcecrownGlacier,84.8,75.8
	--vehicle id 30236
	>>垃圾邮件使用“银色加农炮”(1)杀死一个小范围内的怪物并产生法力。使用“清算炸弹”(2)在一个大范围内杀死怪物，消耗法力。
    .complete 13086,1 --Scourge Attackers (100)
    .complete 13086,2 --Frostbrood Destroyer (3)
step
    .goto IcecrownGlacier,85.6,76.0
	>>退出大炮。返回Fezzik
    .turnin 13086 >>交任务: 最后一道防线
step
    .goto IcecrownGlacier,86.0,75.8
	>>与身后的提里奥交谈
    .accept 13104 >>接任务: 再次前往突破口吧，英雄 << !DK
    .accept 13105 >>接任务: 再次前往突破口吧，英雄 << DK
step
	>>西北旅行。与Ebon Watcher、Silas、Spitzpatrick和屋内的Gustav交谈
    .turnin 13104 >>交任务: 再次前往突破口吧，英雄 << !DK
    .turnin 13105 >>交任务: 再次前往突破口吧，英雄 << DK
    .accept 13118 >>接任务: 净化天灾城
    .accept 13122 >>接任务: 天灾石
    .goto IcecrownGlacier,83.0,73.0
    .accept 13130 >>接任务: 公正堡的基石
    .accept 13135 >>接任务: 危险的能量
    .goto IcecrownGlacier,83.0,73.1
    .accept 13110 >>接任务: 永不安息的亡者
    .goto IcecrownGlacier,82.9,72.8
step
	#completewith Crusaders
	>>杀死天灾之城的天灾。掠夺他们的天灾之石
    .complete 13122,1 --Scourgestone (15)
step
	#completewith Kings
	.use 43153 >>在天灾谷杀死复活十字军。在他们的尸体上用你袋子里的圣水来解放他们的灵魂
    .goto IcecrownGlacier,78.6,69.7,0
    .goto IcecrownGlacier,77.9,66.2,0
    .goto IcecrownGlacier,78.5,64.6,0
    .goto IcecrownGlacier,80.2,65.7,0
    .complete 13110,1 --Restless Soul Freed (10)
    .complete 13118,3 --Reanimated Crusader (8)
step
	#completewith next
    .goto IcecrownGlacier,79.5,68.6,0
    .goto IcecrownGlacier,80.8,64.5,0
    .goto IcecrownGlacier,77.7,63.2,0
    .goto IcecrownGlacier,78.4,65.7,0
	>>在天灾之城杀死被遗忘的潜行者
    .complete 13118,2 --Forgotten Depths Underking (3)
step
    .goto IcecrownGlacier,79.2,64.0,20,0
    .goto IcecrownGlacier,79.6,64.1,15,0
    .goto IcecrownGlacier,77.8,65.1,50,0
    .goto IcecrownGlacier,77.3,68.2,20,0
    .goto IcecrownGlacier,77.6,68.7,15,0
    .goto IcecrownGlacier,79.2,64.0,20,0
    .goto IcecrownGlacier,79.6,64.1,15,0
    .goto IcecrownGlacier,77.8,65.1,50,0
    .goto IcecrownGlacier,77.3,68.2,20,0
    .goto IcecrownGlacier,77.6,68.7
	>>杀死主要位于该地区Ziggurats内的被遗忘的高级祭司
    .complete 13118,1 --Forgotten Depths High Priest (3)
step
	#label Kings
    .goto IcecrownGlacier,79.5,68.6,80,0
    .goto IcecrownGlacier,80.8,64.5,80,0
    .goto IcecrownGlacier,77.7,63.2,80,0
    .goto IcecrownGlacier,78.4,65.7
	>>杀死该地区被遗忘的潜行者
    .complete 13118,2 --Forgotten Depths Underking (3)
step
	#label Crusaders
    .goto IcecrownGlacier,78.6,69.7,80,0
    .goto IcecrownGlacier,77.9,66.2,80,0
    .goto IcecrownGlacier,78.5,64.6,80,0
    .goto IcecrownGlacier,80.2,65.7,80,0
    .goto IcecrownGlacier,78.6,69.7,80,0
    .goto IcecrownGlacier,77.9,66.2,80,0
    .goto IcecrownGlacier,78.5,64.6,80,0
    .goto IcecrownGlacier,80.2,65.7
	.use 43153 >>在天灾谷杀死复活十字军。在他们的尸体上用你袋子里的圣水来解放他们的灵魂
    .complete 13110,1 --Restless Soul Freed (10)
    .complete 13118,3 --Reanimated Crusader (8)
step
    .goto IcecrownGlacier,78.6,69.7,80,0
    .goto IcecrownGlacier,77.9,66.2,80,0
    .goto IcecrownGlacier,78.5,64.6,80,0
    .goto IcecrownGlacier,80.2,65.7,80,0
    .goto IcecrownGlacier,78.6,69.7,80,0
    .goto IcecrownGlacier,77.9,66.2,80,0
    .goto IcecrownGlacier,78.5,64.6,80,0
    .goto IcecrownGlacier,80.2,65.7
	>>杀死天灾之城的天灾。掠夺他们的天灾之石
    .complete 13122,1 --Scourgestone (15)
step
	#completewith next
    .goto CrystalsongForest,61.1,52.4,0
    .goto CrystalsongForest,58.9,62.8,0
    .goto CrystalsongForest,81.1,72.4,0
    .goto CrystalsongForest,89.2,55.7,0
    .goto CrystalsongForest,61.1,52.4,0
	>>杀死该区域的人形/亡灵/元素怪物。掠夺他们的能量
    .complete 13135,1 --Crystallized Energy (8)
step
	>>掠夺该地区地面上的紫色树桩
    .complete 13130,1 --Crystalline Heartwood (10)
    .goto CrystalsongForest,65.0,53.5,80,0
    .goto CrystalsongForest,70.6,56.1,80,0
    .goto CrystalsongForest,71.4,67.6,80,0
    .goto CrystalsongForest,63.9,69.0,80,0
    .goto CrystalsongForest,65.0,53.5,80,0
    .goto CrystalsongForest,70.6,56.1,80,0
    .goto CrystalsongForest,71.4,67.6,80,0
    .goto CrystalsongForest,63.9,69.0
    .complete 13130,2 --Ancient Elven Masonry (10)
    .goto CrystalsongForest,73.7,65.4,80,0
    .goto CrystalsongForest,82.6,64.5,80,0
    .goto CrystalsongForest,86.5,59.1,80,0
    .goto CrystalsongForest,73.4,56.9,80,0
    .goto CrystalsongForest,73.7,65.4,80,0
    .goto CrystalsongForest,82.6,64.5,80,0
    .goto CrystalsongForest,86.5,59.1,80,0
    .goto CrystalsongForest,73.4,56.9
	>>在被摧毁的精灵建筑周围掠夺小片蓝色大理石
step
    .goto CrystalsongForest,61.1,52.4,80,0
    .goto CrystalsongForest,58.9,62.8,80,0
    .goto CrystalsongForest,81.1,72.4,80,0
    .goto CrystalsongForest,89.2,55.7,80,0
    .goto CrystalsongForest,61.1,52.4
	>>杀死该区域的人形/亡灵/元素怪物。掠夺他们的能量
    .complete 13135,1 --Crystallized Energy (8)
step
	>>返回黑檀守望者
    .turnin 13130 >>交任务: 公正堡的基石
    .turnin 13135 >>交任务: 危险的能量
    .goto IcecrownGlacier,83.0,73.1
    .turnin 13118 >>交任务: 净化天灾城
    .turnin 13122 >>交任务: 天灾石
    .accept 13125 >>接任务: 凝固的空气
    .goto IcecrownGlacier,83.1,73.0
step
    .goto IcecrownGlacier,82.9,72.8
	>>到小屋里去
    .turnin 13110 >>交任务: 永不安息的亡者
step
    .goto IcecrownGlacier,77.3,61.9
	.use 43206 >>进入大楼。使用阿喀琉斯之角召唤NPC协助你杀死萨拉纳克斯
    .complete 13125,1 --Salranax the Flesh Render (1)
step
    .goto IcecrownGlacier,80.1,61.2
	.use 43206 >>进入大楼。使用阿喀琉斯之角召唤NPC协助你杀死亚瑟阿蒙
    .complete 13125,3 --High Priest Yath'amon (1)
step
    .goto IcecrownGlacier,76.5,53.2
	.use 43206 >>使用阿喀琉斯之角召唤NPC协助你杀死塔洛诺斯
    .complete 13125,2 --Underking Talonox (1)
step
    .goto IcecrownGlacier,83.0,72.9
	>>返回黑檀守望者
    .turnin 13125 >>交任务: 凝固的空气
step
    .goto IcecrownGlacier,82.9,72.8
	>>到小屋里去
    .accept 13139 >>接任务: 进入诺森德的冰冷腹地
step
    .goto IcecrownGlacier,86.0,75.8
	>>返回提里奥
    .turnin 13139 >>交任务: 进入诺森德的冰冷腹地
    .accept 13141 >>接任务: 北伐军之峰的战斗
step
    .goto IcecrownGlacier,80.04,71.94
	.use 43243 >>把十字军的祝福旗帜放在你的袋子里，放在一堆骷髅头上，抵御来袭的海浪。当死亡使者哈洛夫产卵时，集中精力杀死他
    .complete 13141,1 --Battle for Crusaders' Pinnacle (1)
step
    .goto IcecrownGlacier,82.9,72.8
	>>到小屋里去
    .turnin 13141 >>交任务: 北伐军之峰的战斗
    .accept 13157 >>接任务: 北伐军之峰
step
    .goto IcecrownGlacier,79.8,71.8
	>>回到你防守旗帜的地方。与提里奥交谈
    .turnin 13157 >>交任务: 北伐军之峰
    .accept 13068 >>接任务: 勇气的传说
step
    .goto IcecrownGlacier,79.4,72.3
    .fp Crusaders' Pinnacle >>获取十字军的Pinnacle飞行路线
step << Horde
    .goto IcecrownGlacier,79.5,72.7
	>>进入塔楼。与床上底层的Strongbrow交谈
    .accept 13224 >>接任务: 奥格瑞姆之锤
step << Alliance
    .goto Icecrown,79.44,72.84
	>>进入塔楼。与床上底层的伊瓦利乌斯交谈
    .accept 13225 >>接任务: 破天号
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。走进马拉德对面的大房间，和贾斯汀谈谈
    .turnin 13225 >>交任务: 破天号
    .accept 13231 >>接任务: 破碎前线
step << Alliance
	#label slaves1
	#sticky
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>找到虔诚的押沙兰。他绕着船尾走，上下左右楼梯
    .daily 13300 >>接任务: 萨隆邪铁的奴隶
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>爬上船尾的楼梯，和骑士队长德罗西通话
    .daily 13336 >>接任务: 伊米亚之血
    .accept 13341 >>接任务: 协助突袭
step << Alliance
	#requires slaves1
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .accept 13296 >>接任务: 前往伊米海姆！
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Sky Reaver Korm Blackscar交谈
    .turnin 13224 >>交任务: 奥格瑞姆之锤
    .accept 13228 >>接任务: 破碎前线
step << Horde
	>>接受战争使者达沃斯·里奥特和凯尔坦兄弟的任务。他们在楼梯和下层甲板附近走动
    .daily 13302 >>接任务: 萨隆邪铁的奴隶
    .daily 13330 >>接任务: 伊米亚之血
    .accept 13340 >>接任务: 协助突袭
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .accept 13293 >>接任务: 前往伊米海姆！
step << Alliance
    .goto IcecrownGlacier,62.6,51.3
	>>飞到地面指挥官库普(在地面上)
    .turnin 13341 >>交任务: 协助突袭
    .daily 13309 >>接任务: 空中突袭
	>>如果你愿意，你可以跳过每日任务
step << Alliance
    #completewith next
    .goto Icecrown,62.55,50.67
    .vehicle 32227 >>右击飞行机器顶部的炮塔开始任务
	.isOnQuest 13309
step << Alliance
	-- completionist
	>>当你飞来飞去时，射击建筑物上的所有长矛枪
    .goto Icecrown,52.65,56.93
    .complete 13309,1 --4/4 Skybreaker Infiltrators dropped
	.isOnQuest 13309
step << Alliance
    .goto Icecrown,62.55,51.29
	>>返回库普
    .turnin 13309 >>交任务: 空中突袭
	.isQuestComplete 13309
step << Alliance
    .goto IcecrownGlacier,62.5,51.1,15,0
    .goto IcecrownGlacier,62.8,51.6
	>>与班组长交谈。如果其他人开始任务，并且有大约6分钟的重生时间，并且在库普右侧约10码处重生，他可能不会在这里
	>>你可以跳过这个任务。这只是一个与其他人紧密联系的日常任务
    .daily 13284 >>接任务: 地面突袭
step << Alliance
    .goto IcecrownGlacier,58.2,55.9,0
    .goto IcecrownGlacier,59.6,59.3,0
    .goto IcecrownGlacier,57.8,62.6,0
	#completewith Mineslave
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13336,1 --Ymirheim Vrykul Slain (20)
step << Alliance
    .goto Icecrown,59.89,53.50
	>>护送部队。如果需要，让一些部队坦克暴徒
    .complete 13284,1 --4/4 Alliance troops escorted to Ymirheim
	.isOnQuest 13284
step << Alliance
	#label Mineslave
    .goto IcecrownGlacier,55.7,57.3,40,0
    .goto IcecrownGlacier,56.2,58.9,40,0
    .goto IcecrownGlacier,55.6,59.7,40,0
    .goto IcecrownGlacier,54.5,60.0,40,0
    .goto IcecrownGlacier,55.7,57.3
	>>进入沙龙矿。与奴隶交谈以营救他们(有时他们可能会攻击你)。
    .complete 13300,1 --Saronite Mine Slave rescued (10)
	.skipgossip
	.isOnQuest 13300
step << Alliance
    .goto IcecrownGlacier,58.2,55.9,70,0
    .goto IcecrownGlacier,59.6,59.3,70,0
    .goto IcecrownGlacier,57.8,62.6
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13336,1 --Ymirheim Vrykul Slain (20)
	.isOnQuest 13336
step << Alliance
	#completewith next
    .goto Icecrown,57.01,62.53
	>>飞到地面上的Frazzle
    .turnin 13296 >>交任务: 前往伊米海姆！
step << Alliance
    .goto Icecrown,57.01,62.53
	>>注意：这个任务为你标记PVP。然而，这很容易。
    .daily 13280 >>接任务: 占山为王
step << Alliance
    #completewith next
    .goto Icecrown,56.99,62.60
    .vehicle 31784 >>右键单击看起来像侏儒的机器人
	.isOnQuest 13280
step << Alliance
    .goto Icecrown,54.89,60.12
	>>垃圾邮件使用“Jump Jets”(3)快速攀登悬崖(没有冷却时间)。到达山顶后，使用“植物联盟战斗标准”(1)种植旗帜。然后，离开车辆
    .complete 13280,1 --1/1 Alliance Battle Standard planted
	.isOnQuest 13280
step << Alliance
    .goto Icecrown,56.97,62.55
	>>单击离开车辆按钮
    .turnin 13280 >>交任务: 占山为王
	.isQuestComplete 13280
step << Horde
	>>飞向地面指挥官Xutjja(他在地面上，而不是在船上)
    .goto IcecrownGlacier,58.3,46.0
    .turnin 13340 >>交任务: 协助突袭
step << Horde
    .goto IcecrownGlacier,58.3,46.0
    .daily 13310 >>接任务: 空中突袭
	>>如果你愿意，你可以跳过每日任务
step << Horde
	#completewith next
	.vehicle >>跑到Kor'kron压制炮塔并点击它。
    .goto IcecrownGlacier,59.5,45.94
	.isOnQuest 13310
step << Horde
	>>当你飞来飞去时，射击建筑物上的所有长矛枪。当你这样做时，渗透者会掉落。
    .goto IcecrownGlacier,56.8,64.3
    .complete 13310,1 --Kor'kron Infiltrators dropped (4)
	.isOnQuest 13310
step << Horde
    .goto IcecrownGlacier,58.3,46.0
    .turnin 13310 >>交任务: 空中突袭
	.isQuestComplete 13310
step << Horde
    .goto IcecrownGlacier,58.3,46.0
	>>与班组长交谈。如果其他人开始任务并且有大约6分钟的重生时间，他可能不会在这里
    .daily 13301 >>接任务: 地面突袭
	>>你可以跳过这个任务。这只是一个与其他人紧密联系的日常任务
step << Horde
	#sticky
	#label ymirheimslain
    .goto IcecrownGlacier,58.2,55.9,0
    .goto IcecrownGlacier,59.6,59.3,0
    .goto IcecrownGlacier,57.8,62.6,0
	#completewith Mineslave
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13330,1 --Ymirheim Vrykul Slain (20)
	.isOnQuest 13330
step << Horde
	>>护送部队。
    .goto IcecrownGlacier,59.4,52.8
    .complete 13301,1 --Horde troops escorted to Ymirheim (4)
	.isOnQuest 13301
step << Horde
	#label Mineslave
    .goto IcecrownGlacier,55.7,57.3,40,0
    .goto IcecrownGlacier,56.2,58.9,40,0
    .goto IcecrownGlacier,55.6,59.7,40,0
    .goto IcecrownGlacier,54.5,60.0,40,0
    .goto IcecrownGlacier,55.7,57.3
	>>进入沙龙矿。与奴隶交谈以营救他们(有时他们可能会攻击你)。
    .complete 13302,1 --Saronite Mine Slave rescued (10)
	.skipgossip
	.isOnQuest 13302
step << Horde
	#requires ymirheimslain
    .goto IcecrownGlacier,51.9,57.6
    .turnin 13293 >>交任务: 前往伊米海姆！
    .daily 13283 >>接任务: 占山为王
step << Horde
    #completewith next
    .goto Icecrown,51.95,57.62
    .vehicle >>右键单击看起来像侏儒的机器人
	.isOnQuest 13283
step << Horde
    .goto Icecrown,54.89,60.12
	>>垃圾邮件使用“Jump Jets”(3)快速攀登悬崖(没有冷却时间)。到达山顶后，使用“植物部落战斗标准”(1)种植旗帜。然后，离开车辆
    .complete 13283,1 --1/1 Horde Battle Standard planted
	.isOnQuest 13283
step << Horde
    .goto Icecrown,51.9,57.6
	>>单击离开车辆按钮
    .turnin 13283 >>交任务: 占山为王
	.isQuestComplete 13283
step << Alliance
    .goto IcecrownGlacier,66.4,66.5
	>>在破碎的战线周围找到一名垂死的士兵并与之交谈
    .complete 13231,1 --Dying Soldier Questioned (1)
    .accept 13232 >>接任务: 让我解脱吧！
	.skipgossip
step << Alliance
    .goto IcecrownGlacier,69.1,62.1
	>>在该地区附近找到更多垂死的士兵并干掉他们
	.complete 13232,1
	.skipgossip
step << Horde
    .goto IcecrownGlacier,67.7,68.4
	>>在破碎的前线找到一个垂死的狂暴者并与之交谈
    .complete 13228,1 --Dying Berserker Questioned (1)
    .accept 13230 >>接任务: 为我复仇！
step << Horde
    .goto IcecrownGlacier,68.7,64.2
	>>在该地区附近找到更多垂死的士兵并干掉他们
	.complete 13230,1 --Dying Alliance Soldiers Slain (5)
	.skipgossip
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到破天荒号，这是一艘在高空飞行的大型联盟飞船(你可以在地图上看到它)。走进马拉德对面的大房间，和贾斯汀谈谈
    .turnin 13231 >>交任务: 破碎前线
    .turnin 13232 >>交任务: 让我解脱吧！
    .accept 13286 >>接任务: ……所有可能的帮助
    .accept 13290 >>接任务: 请留意一下……
step << Alliance
	#label slaves2
	#sticky
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>找到虔诚的押沙兰。他绕着船尾走，上下左右楼梯
    .turnin 13300 >>交任务: 萨隆邪铁的奴隶
	.isQuestComplete 13300
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>爬上船尾的楼梯，和骑士队长德罗西通话
    .turnin 13336 >>交任务: 伊米亚之血
	.isQuestComplete 13336
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>与船左后角的Thassarian通话
    .turnin 13286 >>交任务: ……所有可能的帮助
    .accept 13287 >>接任务: 知己知彼
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .turnin 13290 >>交任务: 请留意一下……
    .accept 13291 >>接任务: “借来”的技术
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格里姆之锤，一艘在高空盘旋的部落大船。在前室与Sky Reaver Korm Blackscar交谈
    .turnin 13228 >>交任务: 破碎前线
    .turnin 13230 >>交任务: 为我复仇！
    .accept 13238 >>接任务: 有价值的帮手？
    .accept 13260 >>接任务: 知根知底
step << Horde
	>>和你旁边的科尔蒂拉谈谈
    .turnin 13260 >>交任务: 知根知底
    .accept 13237 >>接任务: 知己知彼
step << Horde
	>>与在楼梯附近走动的克尔坦兄弟交谈
    .turnin 13302 >>交任务: 萨隆邪铁的奴隶
	.isQuestComplete 13302
step
	>>与战争使者达沃斯·里奥特交谈。他也在底层甲板巡逻
    .turnin 13330 >>交任务: 伊米亚之血
	.isQuestComplete 13330
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .turnin 13238 >>交任务: 有价值的帮手？
    .accept 13239 >>接任务: 爆炸油
step << Alliance
	>>返回地面指挥官库普
    .goto Icecrown,62.60,51.35
    .turnin 13284 >>交任务: 地面突袭
	.isQuestComplete 13284
step << Horde
	>>返回地面指挥官Xutjja
    .goto IcecrownGlacier,58.3,46.2
    .turnin 13301 >>交任务: 地面突袭
	.isQuestComplete 13301
step << Alliance
	#completewith next
    .goto IcecrownGlacier,67.2,68.3,70,0
    .goto IcecrownGlacier,68.0,70.9,70,0
    .goto IcecrownGlacier,71.6,61.3,70,0
    .goto IcecrownGlacier,67.2,68.3
	.use 44048 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当您拥有每件设备中的一件时，请在您的包中使用走私解决方案(您不需要等待RP)
	.collect 43609,3,13291,1,-1 --Pile of Bones (3)
	.collect 43610,3,13291,1,-1 --Abandoned Helm (3)
	.collect 43616,3,13291,1,-1 --Abandoned Armor (3)
    .complete 13291,1 --Field Tests Conducted (3)
step << Horde
	#completewith next
    .goto IcecrownGlacier,67.2,68.3,70,0
    .goto IcecrownGlacier,68.0,70.9,70,0
    .goto IcecrownGlacier,71.6,61.3,70,0
    .goto IcecrownGlacier,67.2,68.3
	.use 43608 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当你有每一件设备时，在你的袋子里放上科珀克劳挥发性油(你不需要等待RP)
	.collect 43609,3,13239,1,-1 --Pile of Bones (3)
	.collect 43610,3,13239,1,-1 --Abandoned Helm (3)
	.collect 43616,3,13239,1,-1 --Abandoned Armor (3)
    .complete 13239,1 --Field Tests Conducted (3)
step << Alliance
    .goto IcecrownGlacier,67.0,63.3,70,0
    .goto IcecrownGlacier,67.4,70.2,70,0
    .goto IcecrownGlacier,71.6,61.3
	>>杀死该地区的憎恶者、专家和亡灵法师
    .complete 13287,1 --Hulking Abominations Slain (5)
    .complete 13287,3 --Shadow Adepts Slain (5)
    .complete 13287,2 --Malefic Necromancers Slain (5)
step << Horde
    .goto IcecrownGlacier,67.0,63.3,70,0
    .goto IcecrownGlacier,67.4,70.2,70,0
    .goto IcecrownGlacier,71.6,61.3
	>>杀死该地区的憎恶者、专家和亡灵法师
    .complete 13237,1 --Hulking Abominations Slain (5)
    .complete 13237,3 --Shadow Adepts Slain (5)
    .complete 13237,2 --Malefic Necromancers Slain (5)
step << Alliance
    .goto IcecrownGlacier,67.2,68.3,70,0
    .goto IcecrownGlacier,68.0,70.9,70,0
    .goto IcecrownGlacier,71.6,61.3,70,0
    .goto IcecrownGlacier,67.2,68.3
	.use 44048 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当您拥有每件设备中的一件时，请在您的包中使用走私解决方案(您不需要等待RP)
	.collect 43609,3,13291,1,-1 --Pile of Bones (3)
	.collect 43610,3,13291,1,-1 --Abandoned Helm (3)
	.collect 43616,3,13291,1,-1 --Abandoned Armor (3)
    .complete 13291,1 --Field Tests Conducted (3)
step << Horde
    .goto IcecrownGlacier,67.2,68.3,70,0
    .goto IcecrownGlacier,68.0,70.9,70,0
    .goto IcecrownGlacier,71.6,61.3,70,0
    .goto IcecrownGlacier,67.2,68.3
	.use 43608 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当你有每一件设备时，在你的袋子里放上科珀克劳挥发性油(你不需要等待RP)
	.collect 43609,3,13239,1,-1 --Pile of Bones (3)
	.collect 43610,3,13239,1,-1 --Abandoned Helm (3)
	.collect 43616,3,13239,1,-1 --Abandoned Armor (3)
    .complete 13239,1 --Field Tests Conducted (3)
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
    .turnin 13287 >>交任务: 知己知彼
    .accept 13288 >>接任务: 你的憎恶伙伴
    .accept 13294 >>接任务: 对抗巨人
step << Alliance
	#requires notdead
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .turnin 13291 >>交任务: “借来”的技术
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。在船的前室和科尔蒂拉通话
    .turnin 13237 >>交任务: 知己知彼
    .accept 13264 >>接任务: 你的憎恶伙伴
	.accept 13277 >>接任务: 对抗巨人
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .turnin 13239 >>交任务: 爆炸油
step
    .goto IcecrownGlacier,68.3,61.5
	>>杀死该地区的绿巨人憎恶者，并掠夺他们的寒冷憎恶肠
	.use 43968 >>使用袋子里有肠子的憎恶复活套件来召唤一个你可以控制的憎恶。通过让憎恶者攻击尽可能多的暴徒，并使其仇恨，然后使用“在接缝处爆发”杀死憎恶者附近的所有暴徒(暴徒必须战斗才能获得荣誉)
	>>如果你的肠子用完了，去杀死更多的怪物憎恶。你一次只能有一个胆量。
	.collect 43966,1,13288,-1,1 << Alliance --Chilled Abomination Guts (3)
    .complete 13288,1 << Alliance  --Icy Ghouls Exploded (15)
    .complete 13288,2 << Alliance  --Vicious Geists Exploded (15)
    .complete 13288,3 << Alliance  --Risen Alliance Soldiers Exploded (15)
	.collect 43966,1,13264,-1,1 << Horde  --Chilled Abomination Guts (3)
    .complete 13264,1 << Horde --Icy Ghouls Exploded (15)
    .complete 13264,2 << Horde --Vicious Geists Exploded (15)
    .complete 13264,3 << Horde --Risen Alliance Soldiers Exploded (15)
	.isOnQuest 13288 << Alliance
	.isOnQuest 13264 << Horde
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>返回奥格里姆之锤。与科尔蒂拉交谈
    .turnin 13264 >>交任务: 你的憎恶伙伴
    .accept 13351 >>接任务: 预览
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>返回破天者。与Thassarian交谈
    .turnin 13288 >>交任务: 你的憎恶伙伴
    .accept 13315 >>接任务: 预览
step << Alliance
	>>在大墙上方平台上的航路点上方飞行
    .complete 13315,1 --1/1 Aldur'thar South Visited
    .goto Icecrown,55.64,46.73
    .complete 13315,2 --1/1 Aldur'thar Central Visited
    .goto Icecrown,54.10,43.43
    .complete 13315,3 --1/1 Aldur'thar North Visited
    .goto Icecrown,54.09,35.33
    .complete 13315,4 --1/1 Aldur'thar Northwest Visited
    .goto Icecrown,52.06,34.21
step << Horde
	>>在大墙上方平台上的航路点上方飞行
    .complete 13351,1 --Aldur'thar South Visited (1)
    .goto IcecrownGlacier,55.3,43.9
    .complete 13351,2 --Aldur'thar Central Visited (1)
    .goto IcecrownGlacier,55.1,41.6
    .complete 13351,3 --Aldur'thar North Visited (1)
    .goto IcecrownGlacier,53.7,35.5
    .complete 13351,4 --Aldur'thar Northwest Visited (1)
    .goto IcecrownGlacier,51.9,34.8
step << Alliance
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7,70,0
    .goto IcecrownGlacier,66.8,58.4,70,0
    .goto IcecrownGlacier,69.5,57.3,70,0
    .goto IcecrownGlacier,72.5,59.0,70,0
    .goto IcecrownGlacier,70.1,57.2,70,0
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7
	>>杀死该地区的瞳孔恐怖。掠夺他们的脊椎。这个任务非常困难，如果需要，可以分组完成。
    .complete 13294,1 --Pustulant Spine (5)
step << Horde
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7,70,0
    .goto IcecrownGlacier,66.8,58.4,70,0
    .goto IcecrownGlacier,69.5,57.3,70,0
    .goto IcecrownGlacier,72.5,59.0,70,0
    .goto IcecrownGlacier,70.1,57.2,70,0
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7
	>>杀死该地区的瞳孔恐怖。掠夺他们的脊椎。这个任务非常困难，如果需要，可以分组完成。
    .complete 13277,1 --Pustulant Spine (5)
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。在船的前室和科尔蒂拉通话
    .turnin 13351 >>交任务: 预览
	.turnin 13277 >>交任务: 对抗巨人
    .accept 13355 >>接任务: 无法复制
    .accept 13354 >>接任务: 指挥体系
    .accept 13352 >>接任务: 从天而“降”
	.accept 13279 >>接任务: 化学常识
    .accept 13278 >>接任务: 污染者科普洛斯
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .accept 13379 >>接任务: 绿色科技
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
    .turnin 13315 >>交任务: 预览
    .turnin 13294 >>交任务: 对抗巨人
    .accept 13318 >>接任务: 从天而“降”
    .accept 13319 >>接任务: 指挥体系
    .accept 13320 >>接任务: 无法复制
    .accept 13295 >>接任务: 化学常识
    .accept 13298 >>接任务: 污染者科普洛斯
step << Alliance
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .accept 13383 >>接任务: “借来”的技术
step
	#completewith next
    .goto IcecrownGlacier,63.3,62.1,25 >>进入Mord’rethar内部的大门。它在二级，由瘟疫恶魔守卫
	.isOnQuest 13295 << Alliance
	.isOnQuest 13279 << Horde
step
    .goto IcecrownGlacier,62.3,63.4
	.use 44010 >>在冒着气泡的绿色大锅上使用袋子里的脓疱性脊髓液。杀死繁殖的怪物，并在提示“很快添加流体”时再次使用脊椎流体。这个任务非常困难，如果需要，可以分组完成。
    .complete 13295,1 << Alliance --Batch of Plague Neutralized (1)
    .complete 13279,1 << Horde --Batch of Plague Neutralized (1)
step
    .goto IcecrownGlacier,60.8,62.2
	>>杀死莫德雷萨内部的亵渎者科普鲁斯。这个任务非常困难，所以如果需要，可以分组完成。
    .complete 13298,1 << Alliance --Coprous the Defiler Slain (1)
    .complete 13278,1 << Horde --Coprous the Defiler Slain (1)
step
	#sticky
	#label darksub
	>>前往墙壁上方的平台，杀死该区域内的苦战元凶。掠夺他们的幻想之球
	.use 44246 >>当你不在战斗中时，在该区域使用幻影之珠。
	.collect 44246,3,13352,1,-1 << Horde --Orb of Illusion (3 -1)
	.collect 44246,3,13318,1,-1 << Alliance --Orb of Illusion (3 -1)
    .goto IcecrownGlacier,53.7,46.1
    .complete 13352,1 << Horde --Dark Subjugator dragged and dropped (3)
    .complete 13318,1 << Alliance --Dark Subjugator dragged and dropped (3)
    .goto IcecrownGlacier,54.7,45.9,60,0
    .goto IcecrownGlacier,54.0,46.3,60,0
    .goto IcecrownGlacier,52.2,45.7,60,0
    .goto IcecrownGlacier,54.0,46.3
--	.unitscan Dark Subjugator
--X too many in the area, unitscan would be awkward
step
    .goto IcecrownGlacier,53.9,46.1
	>>在大帐篷里杀死监督员费德里斯
    .complete 13354,1 << Horde --Overseer Faedris Killed (1)
	.complete 13319,1 << Alliance --Overseer Faedris Killed (1)
step
	#requires darksub
	.use 44251 >>使用Aldur'star外面大锅上的隔断烧瓶
    .complete 13355,3 << Horde --Dark Sample Collected (1)
	.complete 13320,3 << Alliance --Dark Sample Collected (1)
    .goto IcecrownGlacier,49.7,34.4
    .complete 13355,2 << Horde --Green Sample Collected (1)
	.complete 13320,2 << Alliance --Green Sample Collected (1)
    .goto IcecrownGlacier,49.1,34.2
    .complete 13355,1 << Horde --Blue Sample Collected (1)
    .complete 13320,1 << Alliance --Blue Sample Collected (1)
    .goto IcecrownGlacier,48.9,33.2
step
	>>在大帐篷下杀死监督员萨林和杰肯。然后飞到Veraj(大帐篷下)并杀了他
    .complete 13354,4 << Horde --Overseer Savryn Killed (1)
	.complete 13319,4 << Alliance --Overseer Savryn Killed (1)
    .goto IcecrownGlacier,49.4,31.2
    .complete 13354,2 << Horde --Overseer Jhaeqon Killed (1)
	.complete 13319,2 << Alliance --Overseer Jhaeqon Killed (1)
    .goto IcecrownGlacier,54.7,32.6
    .complete 13354,3 << Horde --Overseer Veraj Killed (1)
	.complete 13319,3 << Alliance --Overseer Veraj Killed (1)
    .goto IcecrownGlacier,53.7,29.2
step << Alliance
	>>飞向空中的小平台。与Killohertz交谈
	.goto IcecrownGlacier,53.96,42.93
	.turnin 13383 >>交任务: 吉普利·基罗赫斯
	.accept 13380 >>接任务: 委以重任
step << Alliance
	.goto IcecrownGlacier,53.96,43.11
	>>和凯伦谈谈，让她坐上轰炸机。使用冲锋盾牌(1)获得100个盾牌，然后切换到轰炸机湾(5)，开始轰炸下方的天灾，直到所有步兵和上尉被杀死。切换到防空炮塔(4)，开始使用防空火箭(1)在空中射击石像鬼。完成后，按下离开车辆按钮，您将返回平台
	.complete 13380,1 -- Bombardment Infantry slain (40)
	.complete 13380,2 -- Bombardment Captain slain (8)
	.complete 13380,3 -- Gargoyle Ambusher slain (15)
	.skipgossip
step << Alliance
	>>与Killohertz交谈
    .goto IcecrownGlacier,53.96,42.93
    .turnin 13380 >>交任务: 委以重任
step << Horde
	>>飞向空中的小平台。与Tezzla交谈
    .goto IcecrownGlacier,53.99,36.87
    .turnin 13379 >>交任务: 绿色科技
    .accept 13373 >>接任务: 边缘科学的益处
step << Horde
	.goto IcecrownGlacier,53.96,43.11
	>>与Rizzy交谈，让他登上轰炸机。使用冲锋盾牌(1)获得100个盾牌，然后切换到轰炸机湾(5)，开始轰炸下方的天灾，直到所有步兵和上尉被杀死。切换到防空炮塔(4)，开始使用防空火箭(1)在空中射击石像鬼。完成后，按下离开车辆按钮，您将返回平台
	.complete 13373,1 -- Bombardment Infantry slain (40)
	.complete 13373,2 -- Bombardment Captain slain (8)
	.complete 13373,3 -- Gargoyle Ambusher slain (15)
	.skipgossip
step << Horde
	>>与Tezzla交谈
    .goto IcecrownGlacier,54.00,36.94
    .turnin 13373 >>交任务: 边缘科学的益处
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
    .turnin 13318 >>交任务: 从天而“降”
    .turnin 13319 >>交任务: 指挥体系
    .turnin 13295 >>交任务: 化学常识
    .turnin 13298 >>交任务: 污染者科普洛斯
    .accept 13342 >>接任务: 活动窃听器
    .accept 13345 >>接任务: 需要更多情报
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .turnin 13320 >>交任务: 无法复制
    .accept 13321 >>接任务: 重新考验
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Kolitra交谈
	.turnin 13352 >>交任务: 从天而“降”
    .turnin 13354 >>交任务: 指挥体系
    .turnin 13279 >>交任务: 化学常识
    .turnin 13278 >>交任务: 污染者科普洛斯
    .accept 13358 >>接任务: 活动窃听器
    .accept 13366 >>接任务: 需要更多情报
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .turnin 13355 >>交任务: 无法复制
    .accept 13356 >>接任务: 重新考验
step
	#label taintedessence
	#sticky
    .goto IcecrownGlacier,49.7,34.4,0,0
	.use 44307 >>使用袋子里的稀释邪教补品获得“黑暗辨识”Buff。这允许你从你在该地区杀死的所有人形生物中掠夺被污染的精华
	.collect 44301,10,13356,1 << Horde
	.collect 44301,10,13321,1 << Alliance
step
    .goto IcecrownGlacier,54.1,31.4,70,0
    .goto IcecrownGlacier,54.7,28.0,70,0
    .goto IcecrownGlacier,57.0,28.8,70,0
    .goto IcecrownGlacier,54.1,31.4
	.use 44433 >>杀死5个奴役的小黄人(虚空行走者)。用吸吮棒在他们的尸体上寻找暗物质
	.collect 44434,5,13342,1 << Alliance --Dark Matter (5)
	.collect 44434,5,13358,1 << Horde --Dark Matter (5)
step
    .goto IcecrownGlacier,53.8,33.6
	>>点击召唤石
	.complete 13342,1 << Alliance  --Dark Messenger Summoned (1)
    .complete 13358,1 << Horde --Dark Messenger Summoned (1)
step
	#completewith next
    .goto IcecrownGlacier,51.9,32.5,30 >>进入Aldur'star的内部
	.isOnQuest 13366 << Horde
	.isOnQuest 13345 << Alliance
step
    .goto IcecrownGlacier,53.1,31.1,60,0
    .goto IcecrownGlacier,53.1,29.2,60,0
    .goto IcecrownGlacier,50.9,29.0,60,0
    .goto IcecrownGlacier,50.9,30.4,60,0
    .goto IcecrownGlacier,53.1,31.1
	>>杀死该地区的邪教研究人员。抢走他们的研究页面
	.collect 44459,1 --Cult of the Damned Research - Page 1 (1)
	.collect 44460,1 --Cult of the Damned Research - Page 2 (1)
	.collect 44461,1 --Cult of the Damned Research - Page 3 (1)
	.isOnQuest 13366 << Horde
	.isOnQuest 13345 << Alliance
step
	#sticky
	#label Thesis
    .goto IcecrownGlacier,49.7,34.4
	.use 44459 >>单击包中的一个研究页面，将其合并到论文中
    .complete 13366,1 << Horde --Cult of the Damned Thesis (1)
	.complete 13345,1 << Alliance --Cult of the Damned Thesis (1)
step
	#requires taintedessence
    .goto IcecrownGlacier,49.7,34.4
	.use 44301
	.use 44304 >>右击你袋子里的被污染的精华，将它们变成旋转的弥撒。扔进大锅
	.complete 13321,1 << Alliance
	.complete 13356,1 << Horde
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
    .turnin 13342 >>交任务: 活动窃听器
    .turnin 13345 >>交任务: 需要更多情报
    .accept 13346 >>接任务: 片刻不得安宁
    .accept 13332 >>接任务: 构建路障
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>走船中央的楼梯(在马拉德后面)，然后走第一个楼梯两侧的楼梯，进入机舱。与总工程师Boltwrench交谈
    .turnin 13321 >>交任务: 重新考验
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Kolitra交谈
    .turnin 13358 >>交任务: 活动窃听器
	.turnin 13366 >>交任务: 需要更多情报
    .accept 13367 >>接任务: 片刻不得安宁
    .accept 13306 >>接任务: 构建路障
step << Horde
	>>去船的下甲板。与Cheif Engineer Copperclaw交谈
    .turnin 13356 >>交任务: 重新考验
step
    .goto IcecrownGlacier,52.5,42.0,70,0
    .goto IcecrownGlacier,51.3,37.1,70,0
    .goto IcecrownGlacier,47.1,37.4,70,0
    .goto IcecrownGlacier,50.0,44.9,70,0
    .goto IcecrownGlacier,52.5,42.0
	.use 44127 >>在“堕落英雄谷”(the Valley of Fallen Heroes)，在出现的紫色光环上使用包中的路障建造工具
    .complete 13332,1 << Alliance --Barricades constructed (8)
	.complete 13306,1 << Horde --Barricades constructed (8)
step
	>>这个任务非常困难，如果需要，请分组完成
	>>打开Aldur'star里面的箱子，抢走Alumeth的头骨、心脏、权杖和长袍
	.collect 44476,1 --Alumeth's Skull (1)
    .goto IcecrownGlacier,50.5,30.0
	.collect 44477,1 --Alumeth's Heart (1)
    .goto IcecrownGlacier,52.8,30.7
	.collect 44478,1 --Alumeth's Scepter (1)
    .goto IcecrownGlacier,52.8,29.8
	.collect 44479,1 --Alumeth's Robes (1)
    .goto IcecrownGlacier,53.0,29.0
	.isOnQuest 13346 << Alliance
	.isOnQuest 13367 << Horde
step
    .goto IcecrownGlacier,51.9,29.0
	>>这个任务非常困难，如果需要，请分组完成
	.use 44476 >>点击包中的任何物品，将其组合成Alueth遗骸
	.collect 44480,1 --Alumeth's Remains (1)
	.isOnQuest 13346 << Alliance
	.isOnQuest 13367 << Horde
step
    .goto IcecrownGlacier,51.9,29.0
	>>这个任务非常困难，如果需要，请分组完成
	.use 44480 >>使用发光水晶前的Alueth遗骸召唤他。杀了他
    .complete 13346,1 << Alliance --Alumeth the Ascended Defeated (1)
    .complete 13367,1 << Horde --Alumeth the Ascended Defeated (1)
	.isOnQuest 13346 << Alliance
	.isOnQuest 13367 << Horde
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
    .turnin 13346 >>交任务: 片刻不得安宁
    .turnin 13332 >>交任务: 构建路障
	.accept 13337 >>接任务: 铁墙壁垒
	.accept 13334 >>接任务: 溅血的旗帜
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Kolitra交谈
    .turnin 13367 >>交任务: 片刻不得安宁
    .turnin 13306 >>交任务: 构建路障
	.accept 13312 >>接任务: 铁墙壁垒
	.accept 13307 >>接任务: 溅血的旗帜
step
    .goto IcecrownGlacier,51.3,40.3,70,0
    .goto IcecrownGlacier,49.1,43.8
	>>杀死该地区的天灾转化者
    .complete 13334,3 << Alliance --Scourge Converter (5)
    .complete 13307,3 << Horde --Scourge Converter (5)
step
    .goto IcecrownGlacier,45.5,46.5
	>>这个任务非常困难，如果需要，请分组完成
	.use 44186 >>飞到阳台上，然后在格里姆科球馆用你袋子里的变形符文。杀死恶棍格里姆科尔
    .complete 13337,1 << Alliance --Grimkor the Wicked (1)
    .complete 13312,1 << Horde --Grimkor the Wicked (1)
step
    .goto IcecrownGlacier,47.1,48.5,70,0
    .goto IcecrownGlacier,41.9,48.4,70,0
    .goto IcecrownGlacier,41.9,54.3,70,0
    .goto IcecrownGlacier,46.1,53.1
	>>杀死该地区的天灾旗手和转化英雄
    .complete 13334,1 << Alliance --Scourge Banner-Bearer (5)
    .complete 13334,2 << Alliance --Converted Hero (20)
    .complete 13307,1 << Horde --Scourge Banner-Bearer (5)
    .complete 13307,2 << Horde --Converted Hero (20)
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>飞到“破天者”号上，这是一艘在高空飞行的大型联盟飞船。与船左后角的Thassarian通话
	.turnin 13334 >>交任务: 溅血的旗帜
	.turnin 13337 >>交任务: 铁墙壁垒
	>>走进《破天荒》中马拉德面对的大房间，和贾斯汀谈谈
	.accept 13314 >>接任务: 获取情报
step << Alliance
    .goto IcecrownGlacier,46.2,52.1,70,0
    .goto IcecrownGlacier,42.4,59.4,0,0
	.use 44222 >>在Orgrim’s Hammer Scouts的背包中使用飞镖枪(你可以在飞行坐骑上使用)。抢走他们的尸体
    .complete 13314,1 --Orgrim's Hammer Dispatch (6)
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
    .goto IcecrownGlacier,54.7,35.3,200,0
    .goto IcecrownGlacier,65.1,57.2,200,0
    .goto IcecrownGlacier,54.7,35.3
	>>走进《破天荒》中马拉德面对的大房间，和贾斯汀谈谈
	.turnin 13314 >>交任务: 获取情报
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Kolitra交谈
	.turnin 13312 >>交任务: 铁墙壁垒
	.turnin 13307 >>交任务: 溅血的旗帜
step << Horde
	>>与你旁边的Krom Blackscar交谈
	.accept 13313 >>接任务: 遮挡天空
step << Horde
	.goto IcecrownGlacier,48.85,40.44
	.use 44212 >>在空中破天荒侦察机上使用你包里的SGM-3
	.complete 13313,1 --Skybreaker Recon Fighters shot down (6)
step << Horde
	>>飞到奥格瑞姆之锤，一艘在高空盘旋的部落大船。走进前面的大房间。与Krom Blackscar交谈
	.turnin 13313 >>交任务: 遮挡天空
step
	+如果您跳过或未完成本指南中的任何任务，请重新启动指南并完成它们。要做到这一点，请点击齿轮并导航回冰冠炮舰解锁每日任务指南
	>>如果你已经完成了所有的任务，你可以开始使用冰冠炮舰每日任务路线。请注意，有些任务今天可能不可用，因为您可能已经完成了一些日常任务
]])
