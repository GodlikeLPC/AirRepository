RXPGuides.RegisterGuide([[
#version 1
#wotlk
#group +RestedXP诺森德每日任务
#name 每日任务最佳路线

--20 daily quests total
--5(rep depending) quests from Hodir (didnt include dragon flying one. its terrible) may not be 5 quests for everyone. should be at least 3 though
--6 from icecrown. quests from Ebon Blade
--9 from icecrown. quests from gunship/surroundings
--all of these quests require pre quests to be completed/unlocked. each section has checks to see if they have completed pre quests or not. if they havnt they're told to do pre quest guide
--gives the player still room to do daily heroic+普通和jc/烹饪/钓鱼日常任务


--5 Quest section for The Sons of Hodir Daily Quests. Didn't include slaying dragon quest because its really bad/slow

step
	+要解锁霍迪尔之子每日任务，你必须首先在风暴峰完成他们的任务链。请使用Hodir之子解锁每日任务指南解锁每日任务
	.isQuestAvailable 13047
step
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmourt和 贪婪的安格里姆 交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.daily 12994 >>接任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.daily 13046 >>接任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.reputation 1119,revered,<0,1 -- if you're 0 into revered it will display this step
	.isQuestTurnedIn 13047
step
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm和Frostworg Denmother交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.daily 12994 >>接任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.reputation 1119,honored,<0,1 -- if you're 0 into honored it will display this step
	.isQuestTurnedIn 13047
step
	>>与Fjorn铁砧、Hodir角和Hodir头盔交谈
    .daily 12981 >>接任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.daily 13006 >>接任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.reputation 1119,friendly,<0,1 -- if you're 0 into friendly it will display this step
	.isQuestTurnedIn 13047
step
	.goto TheStormPeaks,70.00,58.00,60,0
    .goto TheStormPeaks,70.14,61.16
	>>杀死脆性叛徒。掠夺他们以获取冰的精华
	.collect 42246,6 --Essence of Ice (6)
	.isOnQuest 12981
step
	.goto TheStormPeaks,73.5,62.9,70,0
    .goto TheStormPeaks,76.2,63.4
	.use 42246 >>使用弗约恩铁砧周围阴燃残渣旁边的冰块精华。掠夺冷冻铁屑
    .complete 12981,1 --Frozen Iron Scrap (6)
	.isOnQuest 12981
step
    .goto TheStormPeaks,70.73,50.96,65,0
	.goto TheStormPeaks,73.00,49.05,65,0
    .goto TheStormPeaks,71.45,47.76
	.use 42164 >>杀死该地区的尼弗莱姆祖先和不安的弗罗斯特伯恩。用你袋子里的霍迪尔号角放在他们的尸体上解救他们
    .complete 12977,1 --Niffelem Forefather freed (5)
    .complete 12977,2 --Restless Frostborn freed (5)
	.isOnQuest 12977
step
	#completewith next
    .goto TheStormPeaks,57.23,64.02
	.use 42479 >>用你袋子里的虫牙放在堕落的虫子尸体上。跟随以太霜虫，直到它追踪到一个暴风渗透者，然后杀死它。
	.complete 12994,1 --Stormforged Infiltrators Slain (3)
	.isOnQuest 12994
step
	.goto TheStormPeaks,57.92,61.07,60,0
	.goto TheStormPeaks,57.83,63.59,60,0
	.goto TheStormPeaks,56.51,65.00
	.use 42774 >>在Roaming Jormungar上使用包中的Arngrim牙齿。伤害它30%或更少的生命值，但不要杀死它
	.complete 13046,1 --Arngrim's spirit fed (5)
	.isOnQuest 13046
step
    .goto TheStormPeaks,57.23,64.02
	.use 42479 >>用你袋子里的虫牙放在堕落的虫子尸体上。跟随以太霜虫，直到它追踪到一个暴风渗透者，然后杀死它。
	.complete 12994,1 --Stormforged Infiltrators Slain (3)
	.isOnQuest 12994
step
	.goto TheStormPeaks,55.84,63.94,50,0
    .goto TheStormPeaks,54.4,63.2
	>>在冬眠洞穴杀死粘性油。掠夺他们的石油
    .complete 13006,1 --Viscous Oil (5)
	.isOnQuest 13006
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmourt和 贪婪的安格里姆 交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 12994
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的号角、Hodir's Helm和Insatible的Arngrim交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm和Frostworg Denmother交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.isQuestComplete 12994
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm、Frostworg Denmourt和 贪婪的安格里姆 交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 12994
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的号角、Hodir's Helm和Insatible的Arngrim交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,65.00,60.95
	.turnin 13046 >>交任务: 喂饱安格里姆
	.goto TheStormPeaks,67.61,59.95
	.isQuestComplete 13046
step
	>>返回Dun Niffelem
	>>与Fjorn的铁砧、Hodir的角、Hodir's Helm和Frostworg Denmother交谈
    .turnin 12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin 12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin 13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
	.turnin 12994 >>交任务: 猎杀间谍
	.goto TheStormPeaks,63.49,59.73
	.isQuestComplete 12994
step
	>>返回Dun Niffelem
	>>与Fjorn铁砧、Hodir角和Hodir头盔交谈
    .turnin -12981 >>交任务: 热与冷
    .goto TheStormPeaks,63.13,62.94
    .turnin -12977 >>交任务: 霍迪尔的呼唤
    .goto TheStormPeaks,64.17,65.01
	.turnin -13006 >>交任务: 粘滞清洁
	.goto TheStormPeaks,64.24,59.23
step << Mage
	#completewith next
	.zone Dalaran >>前往: 达拉然
	>>前往: 冰冠冰川
step << !Mage
	#completewith next
    .hs >>如果你的炉子设在那里或冰冠附近，请向达拉然祈祷。
	>>前往: 冰冠冰川

--9 Quest section from Icecrown Gunship and close surroundings section. 6 Quests from the gunship, other 3 from on the ground/in Ymirheim

step << Alliance
	+要解锁所有冰冠炮舰每日任务，你必须先完成任务链。请使用冰冠炮舰解锁每日任务指南解锁所有每日任务
	.isQuestAvailable 13314,13342,13321,13318
--	13314  Get the Message
-- 	13342  Not a Bug
--	13321  Retest Now
--	13318  Drag and Drop

step << Horde
	+要解锁所有冰冠炮舰每日任务，你必须先完成任务链。请使用冰冠炮舰任务前指南解锁所有日常任务
	.isQuestAvailable 13313,13356,13352,13358
--	13313  Blinding the Eyes in the Sky
--	13356  Retest Now
--	13352  Drag and Drop
--	13358  Not a Bug

step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>在冰冠，飞往联盟炮舰，破天荒号
	>>与骑士队长Drosche、虔诚的Absalan、高级队长Justin Bartlett、总工程师Boltwrench和Thassarian交谈
	>>它们分别位于船的左后方、上层甲板、主中央舱和下层甲板上
    .daily 13336 >>接任务: 伊米亚之血
    .daily 13300 >>接任务: 萨隆邪铁的奴隶
    .daily 13322 >>接任务: 重新考验
    .daily 13323 >>接任务: 从天而“降”
	.daily 13344 >>接任务: 活动窃听器
    .daily 13333 >>接任务: 抢夺急件
step << Horde
	.goto IcecrownGlacier,67.00,38,0
	>>在冰冠，飞往部落炮舰，奥格瑞姆之锤
	>>与战争使者达沃斯·里奥特、凯尔坦兄弟、天空收割者科姆·布莱克斯卡、首席工程师科珀克劳和科尔蒂拉·戴斯韦弗交谈
	>>它们分别位于主前舱，巡视上层甲板和下层甲板
    .daily 13330 >>接任务: 伊米亚之血
    .daily 13302 >>接任务: 萨隆邪铁的奴隶
    .daily 13357 >>接任务: 重新考验
    .daily 13353 >>接任务: 从天而“降”
	.daily 13365 >>接任务: 活动窃听器
    .daily 13331 >>接任务: 盲目的联盟
step << Alliance
    .goto IcecrownGlacier,62.6,51.3
	>>飞到地面指挥官库普(在地面上，而不是在船上)
    .daily 13309 >>接任务: 空中突袭
step << Alliance
    #completewith next
    .goto Icecrown,62.55,50.67
    .vehicle 32227 >>右击飞行机器顶部的炮塔开始任务
	.isOnQuest 13309
step << Alliance
	>>射击你在飞行时看到的所有长矛枪，使其失效。当你这样做的时候，渗透者会掉下来
    .goto Icecrown,52.65,56.93
    .complete 13309,1 --4/4 Skybreaker Infiltrators dropped
	.isOnQuest 13309
step << Alliance
    .goto Icecrown,62.55,51.29
	>>退出飞行机器。你会收到一个降落伞。返回库普
    .turnin 13309 >>交任务: 空中突袭
	.isQuestComplete 13309
step << Horde
	>>飞到地面指挥官Xutjja(在地面，而不是在船上)
    .goto IcecrownGlacier,58.3,46.0
    .daily 13310 >>接任务: 空中突袭
step << Horde
	#completewith next
	.vehicle >>右击飞行机器顶部的炮塔开始任务
    .goto IcecrownGlacier,59.60,45.84
	.isOnQuest 13310
step << Horde
	>>射击你在飞行时看到的所有长矛枪，使其失效。当你这样做的时候，渗透者会掉下来
    .goto IcecrownGlacier,56.8,64.3
    .complete 13310,1 --Kor'kron Infiltrators dropped (4)
	.isOnQuest 13310
step << Horde
    .goto IcecrownGlacier,58.3,46.0
	>>退出飞行机器。你会收到一个降落伞。返回Xutjja
    .turnin 13310 >>交任务: 空中突袭
	.isQuestComplete 13310
step << Alliance
    .goto IcecrownGlacier,62.5,51.1,15,0
    .goto IcecrownGlacier,62.8,51.6
	>>与班组长交谈。如果其他人开始任务，并且有大约6分钟的重生时间，并且在库普右侧约10码处重生，他可能不会在这里。如果您不想等待或稍后检查，可以跳过此步骤
    .daily 13284 >>接任务: 地面突袭
step << Alliance
    .goto IcecrownGlacier,58.2,55.9,0
    .goto IcecrownGlacier,59.6,59.3,0
    .goto IcecrownGlacier,57.8,62.6,0
	#completewith Mineslave
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13336,1 --Ymirheim Vrykul Slain (20)
	.isOnQuest 13336
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
    .turnin 13280 >>交任务: 占山为王
	.isQuestComplete 13280
step << Alliance
	>>返回地面指挥官库普
    .goto Icecrown,62.60,51.35
    .turnin 13284 >>交任务: 地面突袭
	.isQuestComplete 13284
step << Horde
    .goto IcecrownGlacier,58.3,46.0
	>>与班组长交谈。如果其他人开始任务，并且有大约6分钟的重生时间，他可能不会在这里。如果您不想等待或稍后检查，可以跳过此步骤
    .daily 13301 >>接任务: 地面突袭
step << Horde
    .goto IcecrownGlacier,58.2,55.9,0
    .goto IcecrownGlacier,59.6,59.3,0
    .goto IcecrownGlacier,57.8,62.6,0
	#completewith Mineslave
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13330,1 --Ymirheim Vrykul Slain (20)
	.isOnQuest 13330
step << Horde
	>>护送部队。如果需要，让一些部队坦克暴徒
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
    .goto IcecrownGlacier,58.2,55.9,70,0
    .goto IcecrownGlacier,59.6,59.3,70,0
    .goto IcecrownGlacier,57.8,62.6
	>>杀死整个伊米尔海姆的维库尔人
	.complete 13330,1 --Ymirheim Vrykul Slain (20)
	.isOnQuest 13330
step << Horde
    .goto IcecrownGlacier,51.9,57.6
	>>注意：这个任务为你标记PvP。然而，这很容易。
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
    .turnin 13283 >>交任务: 占山为王
	.isQuestComplete 13283
step << Horde
	>>返回地面指挥官Xutjja
    .goto Icecrown,58.3,46.0
    .turnin 13301 >>交任务: 地面突袭
	.isQuestComplete 13301
step
	>>前往平台，杀死该区域内的苦涩元凶。掠夺他们的幻想之球
	.use 44246 >>当你不在战斗中时，在该区域使用幻影之珠。
	.collect 44246,3,13353,1,-1 << Horde--Orb of Illusion (3 -1)
	.collect 44246,3,13323,1,-1 << Alliance--Orb of Illusion (3 -1)
    .goto IcecrownGlacier,53.7,46.1
    .complete 13323,1 << Alliance --Dark Subjugator dragged and dropped (3)
    .complete 13353,1 << Horde --Dark Subjugator dragged and dropped (3)
    .goto IcecrownGlacier,54.7,45.9,60,0
    .goto IcecrownGlacier,54.0,46.3,60,0
    .goto IcecrownGlacier,52.2,45.7,60,0
    .goto IcecrownGlacier,54.0,46.3
	.isOnQuest 13323 << Alliance
	.isOnQuest 13353 << Horde
step
    .goto IcecrownGlacier,49.7,34.4
	.use 44307 >>使用袋子里的稀释邪教补品获得“黑暗辨识”Buff。这允许你从你在该地区杀死的所有人形生物中掠夺被污染的精华
	.collect 44301,10,13322,1 << Alliance
	.collect 44301,10,13357,1 << Horde
	.isOnQuest 13322 << Alliance
	.isOnQuest 13357 << Horde
step
    .goto IcecrownGlacier,49.7,34.4
	.use 44301 -- to combine the 10 tainted essences into a writhing mass
	.use 44304 >>右击你袋子里的被污染的精华，将它们变成旋转的弥撒。扔进大锅
	.complete 13322,1 << Alliance
	.complete 13357,1 << Horde
	.isOnQuest 13322 << Alliance
	.isOnQuest 13357 << Horde
step
    .goto IcecrownGlacier,54.1,31.4,70,0
    .goto IcecrownGlacier,54.7,28.0,70,0
    .goto IcecrownGlacier,57.0,28.8,70,0
    .goto IcecrownGlacier,54.1,31.4
	.use 44433 >>杀死5个奴役的小黄人(虚空行走者)。用吸吮棒在他们的尸体上寻找暗物质
	.collect 44434,5,13344,1 << Alliance --Dark Matter (5)
	.collect 44434,5,13365,1 << Horde --Dark Matter (5)
	.isOnQuest 13344 << Alliance
	.isOnQuest 13365 << Horde
step
    .goto IcecrownGlacier,53.8,33.6
	>>点击召唤石
	.complete 13344,1 << Alliance  --Dark Messenger Summoned (1)
    .complete 13365,1 << Horde --Dark Messenger Summoned (1)
	.isOnQuest 13344 << Alliance
	.isOnQuest 13365 << Horde
step << Alliance
    .goto IcecrownGlacier,46.2,52.1,70,0
    .goto IcecrownGlacier,42.4,59.4,0,0
	.use 44222 >>在Orgrim’s Hammer Scouts的背包中使用飞镖枪(你可以在飞行坐骑上使用)。抢走他们的尸体
    .complete 13333,1 --Orgrim's Hammer Dispatch (6)
	.isOnQuest 13333
step << Horde
	.goto IcecrownGlacier,48.85,40.44
	.use 44212 >>在空中破天荒侦察机上使用你包里的SGM-3
	.complete 13331,1 --Skybreaker Recon Fighters shot down (6)
	.isOnQuest 13331
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>返回破天者。与骑士队长Drosche、虔诚的Absalan、高级队长Justin Bartlett、总工程师Boltwrench和Thassarian交谈
    .turnin -13336 >>交任务: 伊米亚之血
    .turnin -13300 >>交任务: 萨隆邪铁的奴隶
    .turnin -13322 >>交任务: 重新考验
    .turnin -13323 >>交任务: 从天而“降”
	.turnin -13344 >>交任务: 活动窃听器
    .turnin -13333 >>交任务: 抢夺急件
step << Horde
	.goto IcecrownGlacier,67.00,38.00
	>>返回奥格里姆之锤。与战争使者达沃斯·里奥特、凯尔坦兄弟、天空收割者科姆·布莱克斯卡、首席工程师科珀克劳和科尔蒂拉·戴斯韦弗交谈
    .turnin -13330 >>接任务: 伊米亚之血
    .turnin -13302 >>接任务: 萨隆邪铁的奴隶
    .turnin -13357 >>接任务: 重新考验
    .turnin -13353 >>接任务: 从天而“降”
	.turnin -13365 >>接任务: 活动窃听器
    .turnin -13331 >>接任务: 盲目的联盟

--6 Quest section from Knights of the Ebon Blade. 3 come from The Shadow Vault, other 3 from Death's Rise

step
	+要解锁黑檀之刃骑士每日任务，你必须首先在冰冠完成他们的任务链。请使用Ebon Blade解锁每日任务指南解锁每日任务
	.isQuestAvailable 12814

-- 3 Quests from The Shadow Vault
step
	>>从暗影库接受3个每日任务
    >>与Silver交谈
	.daily 12995 >>接任务: 彰显军威
	.goto Icecrown,42.84,24.92
	>>与Leaper交谈。他绕着帐篷走
	.daily 13069 >>接任务: 把它们打下来！
	.goto IcecrownGlacier,43.5,25.0
	>>跟维尔谈谈，他是个讨厌的家伙，在入口和主楼之间的小路上巡逻
    .daily 13071 >>接任务: 维尔喜欢火焰！
    .goto IcecrownGlacier,42.7,26.8,60,0
    .goto IcecrownGlacier,43.6,24.1
step
    .goto IcecrownGlacier,29.5,43.4,50,0
    .goto IcecrownGlacier,29.6,45.7,50,0
    .goto IcecrownGlacier,27.9,45.8,50,0
    .goto IcecrownGlacier,27.8,40.2,50,0
    .goto IcecrownGlacier,28.3,38.0,50,0
    .goto IcecrownGlacier,29.0,35.1,50,0
    .goto IcecrownGlacier,34.1,28.7,50,0
    .goto IcecrownGlacier,29.5,43.4
	.use 42480 >>杀死该地区的维库尔。在他们的尸体上使用你袋子里的黑檀刀锋横幅
    .complete 12995,1--Ebon Blade Banner planted near Vrykul corpse (15)
	.isOnQuest 12995
step
    .goto IcecrownGlacier,27.9,33.2
	>>在鱼叉内部，垃圾邮件使用“速射鱼叉”(3)击落龙
	.complete 13069,1 --Jotunheim Proto-Drakes & their riders shot down
	.isOnQuest 13069
step
	#completewith next
    .goto IcecrownGlacier,28.0,37.7
    .vehicle 30564 >>右击Njorndar Proto Drake以安装它
	.isOnQuest 13071
step
    .goto IcecrownGlacier,27.7,41.1,70,0
    .goto IcecrownGlacier,29.2,41.0,70,0
    .goto IcecrownGlacier,29.6,39.7,70,0
    .goto IcecrownGlacier,31.5,36.9,70,0
    .goto IcecrownGlacier,32.0,39.1,70,0
    .goto IcecrownGlacier,30.8,40.2,70,0
    .goto IcecrownGlacier,32.4,40.7,70,0
    .goto IcecrownGlacier,31.5,43.9,70,0
    .goto IcecrownGlacier,30.1,43.1,70,0
    .goto IcecrownGlacier,27.7,41.1
	>>冷却时使用“速度爆发”(1)加快移动速度。使用“Strafe Jotunheim Building”(3)点燃建筑物
    .complete 13071,1 --Vrykul buildings set ablaze (8)
	.isOnQuest 13071
step
    >>返回阴影库。与西尔弗、Leaper和Vile交谈
	.turnin 12995 >>交任务: 彰显军威
	.goto Icecrown,42.84,24.92
    .turnin 13069 >>交任务: 把它们打下来！
	.goto IcecrownGlacier,43.5,25.0
    .turnin 13071 >>交任务: 维尔喜欢火焰！
    .goto IcecrownGlacier,43.6,24.1,60,0
    .goto IcecrownGlacier,42.7,26.8

-- 3 Quests from Death's Rise
step
	>>从死亡复活开始接受3个每日任务
	>>与Setaal交谈
	.daily 12813 >>接任务: 转化尸体
	.goto Icecrown,19.67,48.39
	>>与Aurochs交谈。他在中间的火周围巡逻
    .daily 12838 >>接任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
	>>与Uzo交谈
    .daily 12815 >>接任务: 禁飞区
	.goto Icecrown,19.64,47.80
step
	#sticky
	#label Gryphon
	.goto IcecrownGlacier,10.5,44.1,70,0
    .goto IcecrownGlacier,5.0,43.4,70,0
    .goto IcecrownGlacier,10.5,39.0,70,0
    .goto IcecrownGlacier,12.7,41.2,70,0
    .goto IcecrownGlacier,10.5,44.1
	>>杀死该地区的鹰头狮骑士。用远程技能击落他们，或将他们中的多个组合在空中，然后飞下来杀死他们
    .complete 12815,1 --Onslaught Gryphon Rider (10)
	.isOnQuest 12815
step
    #completewith next
	.goto IcecrownGlacier,9.5,44.8,50,0
    .goto IcecrownGlacier,9.5,44.8,0,0
	.use 40587 >>杀死该地区的暴徒。用你袋子里的黑曼德酊剂涂在他们的尸体上
    .complete 12813,1 --Scarlet Onslaught corpse transformed (10)
	.isOnQuest 12813
step
	>>杀死暴徒，然后掠夺他们的钥匙。用它们在Onslaught Harbor周围打开箱子存放文件
	>>文件箱没有100%下降率
    .goto IcecrownGlacier,10.7,45.6,40,0
    .goto IcecrownGlacier,10.3,46.4,40,0
    .goto IcecrownGlacier,8.8,46.7,40,0
    .goto IcecrownGlacier,8.8,42.2,40,0
    .goto IcecrownGlacier,10.6,42.9,40,0
    .goto IcecrownGlacier,9.6,40.6,40,0
    .goto IcecrownGlacier,9.3,37.5,40,0
    .goto IcecrownGlacier,10.1,36.2,40,0
    .goto IcecrownGlacier,9.1,36.3,40,0
    .goto IcecrownGlacier,8.5,36.4,40,0
    .goto IcecrownGlacier,10.7,45.6,40,0
    .goto IcecrownGlacier,10.3,46.4,40,0
    .goto IcecrownGlacier,8.8,46.7,40,0
    .goto IcecrownGlacier,8.8,42.2,40,0
    .goto IcecrownGlacier,10.6,42.9,40,0
    .goto IcecrownGlacier,9.6,40.6,40,0
    .goto IcecrownGlacier,9.3,37.5,40,0
    .goto IcecrownGlacier,10.1,36.2,40,0
    .goto IcecrownGlacier,9.1,36.3,40,0
    .goto IcecrownGlacier,8.5,36.4
	.collect 40652,6,12838,-1
    .complete 12838,1 --Onslaught Intel Documents (5)
	.isOnQuest 12838
step
	.goto IcecrownGlacier,9.5,44.8,50,0
    .goto IcecrownGlacier,9.5,44.8,0,0
	.use 40587 >>杀死该地区的暴徒。用你袋子里的黑曼德酊剂涂在他们的尸体上
    .complete 12813,1 --Scarlet Onslaught corpse transformed (10)
	.isOnQuest 12813
step
	#requires Gryphon
	>>回归死亡的崛起。与Uzo、Setaal和Aurochs交谈
    .turnin 12815 >>交任务: 禁飞区
    .goto Icecrown,19.64,47.80
    .turnin 12813 >>交任务: 转化尸体
    .goto Icecrown,19.67,48.39
    .turnin 12838 >>交任务: 收集情报
    .goto IcecrownGlacier,20.1,47.5,20,0
    .goto IcecrownGlacier,20.4,47.9,20,0
    .goto IcecrownGlacier,20.1,48.4,20,0
    .goto IcecrownGlacier,19.7,47.9
]])
