RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 冰冠炮舰每日任务路线

step << Alliance -- Checking that the actual pre quests that have been completed, not dailies
	+要解锁所有冰冠炮舰每日任务，你必须先完成任务前链。请使用冰冠炮舰解锁每日任务指南解锁所有每日任务
	.isQuestAvailable 13314,13346,13342,13318,13321,13295,13288,13380,13291,13231,13296

--	 13314  Get the Message
--	 13346  No Rest For The Wicked
--	 13342  Not a Bug
--	 13318  Drag and Drop
--	 13321  Retest Now
--	 13295  Basic Chemistry
--	 13288  That's Abominable!
--	 13380  Leading the Charge
--	 13291  Borrowed Technology
--	 13231  The Broken Front
--	 13296  Get to Ymirheim!

step << Horde -- Checking that the actual quests that have been completed, not dailies
	+要解锁所有冰冠炮舰每日任务，你必须先完成任务前链。请使用冰冠炮舰解锁每日任务指南解锁所有每日任务
	.isQuestAvailable 13313,13228,13293,13239,13373,13279,13356,13352,13358,13367,13264

--	 13313  Blinding the Eyes in the Sky
--	 13228  The Broken Front
--	 13293  Get to Ymirheim!
--	 13239  Volatility
--	 13279  Basic Chemistry
--	 13356  Retest Now
--	 13352  Drag and Drop
--	 13358  Not a Bug
--	 13367  No Rest For The Wicked
--	 13264  That's Abominable!

--Alliance Skybreaker Quests (11)
--	Blood of the Chosen, 13336
--	Slaves to Saronite, 13300
--	No Mercy!, 13233
--	The Solution Solution, 13292
--	That's Abominable!, 13289
--	Neutralizing the Plague, 13297
--	Retest Now, 13322
--	Drag and Drop, 13323
--	Not a Bug, 13344
--	No Rest For The Wicked, 13350
--	Capture More Dispatches, 13333

--Alliance other misc quests nearby included with gunship quest chain (5)
--  King of the Mountain, 13280
--  Assault by Air, 13309
--  Assault by Ground, 13284
--  Static Shock Troops: the Bombardment, 13404
--  Putting the Hertz: The Valley of Lost Hope, 13382 -- not implimented by blizzard

--Horde Orgrim's Hammer Quests (11)
--	Blood of the Chosen, 13330
--	Slaves to Saronite, 13302
--	Make Them Pay!, 13234
--	Volatility, 13261
--	That's Abominable!, 13276
--	Neutralizing the Plague, 13281
--	Retest Now, 13357
--	Drag and Drop, 13353
--	Not a Bug, 13365
--	No Rest For The Wicked, 13368
--	Keeping the Alliance Blind, 13331

--Horde other misc quests nearby included with gunship quest chain (5)
--  King of the Mountain, 13283  -- DONE
--  Assault by Air, 13310 -- DONE
--  Assault by Ground, 13301 -- DONE
--  Riding the Wavelength: The Bombardment, 13406
--  Total Ohmage: The Valley of Lost Hope!, 13376 -- not implimented by blizzard

step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>飞到联盟炮舰，破天荒号
	>>与骑士队长Drosche、虔诚的Absalan、高级队长Justin Bartlett、总工程师Boltwrench和Thassarian交谈
	>>注意，任务没有怜悯！是一个PvP任务，需要你在冰冠中杀死15名部落玩家。如果你愿意，你可以放弃/跳过这一天
    .daily 13336 >>接任务: 伊米亚之血
    .daily 13300 >>接任务: 萨隆邪铁的奴隶
	.daily 13233 >>接任务: 决不留情！
    .daily 13292 >>接任务: 偷来的解决方案
    .daily 13289 >>接任务: 你的憎恶伙伴
	.daily 13297 >>接任务: 中和瘟疫
    .daily 13322 >>接任务: 重新考验
    .daily 13323 >>接任务: 从天而“降”
	.daily 13344 >>接任务: 活动窃听器
    .daily 13350 >>接任务: 片刻不得安宁
    .daily 13333 >>接任务: 抢夺急件
step << Horde
	.goto IcecrownGlacier,67.00,38.00,0
	>>飞向部落炮舰，奥格里姆之锤
	>>与战争使者达沃斯·里奥特、凯尔坦兄弟、天空收割者科姆·布莱克斯卡、首席工程师科珀克劳和科尔蒂拉·戴斯韦弗交谈
	>>注意，任务让他们付出代价！是一个PvP任务，需要你在冰冠杀死15名联盟玩家。如果你愿意，你可以放弃/跳过这一天
    .daily 13330 >>接任务: 伊米亚之血
    .daily 13302 >>接任务: 萨隆邪铁的奴隶
	.daily 13234 >>接任务: 血的代价！
    .daily 13261 >>接任务: 爆炸油
    .daily 13276 >>接任务: 你的憎恶伙伴
	.daily 13281 >>接任务: 中和瘟疫
    .daily 13357 >>接任务: 重新考验
    .daily 13353 >>接任务: 从天而“降”
	.daily 13365 >>接任务: 活动窃听器
    .daily 13368 >>接任务: 片刻不得安宁
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
	>>当你飞来飞去时，射击建筑物上的所有长矛枪
    .goto Icecrown,52.65,56.93
    .complete 13309,1 --4/4 Skybreaker Infiltrators dropped
	.isOnQuest 13309
step << Alliance
    .goto Icecrown,62.55,51.29
	>>返回库普
    .turnin 13309 >>交任务: 空中突袭
	.isQuestComplete 13309
step << Horde
	>>飞到地面指挥官Xutjja(在地面，而不是在船上)
    .goto IcecrownGlacier,58.3,46.0
    .daily 13310 >>接任务: 空中突袭
step << Horde
	#completewith next
	.vehicle >>跑到船上的Kor'kron抑制塔并点击它。
    .goto IcecrownGlacier,59.60,45.84
	.isOnQuest 13310
step << Horde
	>>射击所有炮塔，使你在飞行时看到的炮塔失效。当你这样做时，渗透者会掉落。
    .goto IcecrownGlacier,56.8,64.3
    .complete 13310,1 --Kor'kron Infiltrators dropped (4)
	.isOnQuest 13310
step << Horde
    .goto IcecrownGlacier,58.3,46.0
    .turnin 13310 >>交任务: 空中突袭
	.isQuestComplete 13310
step << Alliance
    .goto IcecrownGlacier,62.5,51.1,15,0
    .goto IcecrownGlacier,62.8,51.6
	>>与班组长交谈。如果其他人开始任务并且有大约6分钟的重生时间，他可能不会在这里
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
	>>与班组长交谈。如果其他人开始任务并且有大约6分钟的重生时间，他可能不会在这里
    .daily 13301 >>接任务: 地面突袭
step << Horde
    .goto IcecrownGlacier,54.9,52.8,0,0
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
    .goto IcecrownGlacier,67.2,68.3,70,0
    .goto IcecrownGlacier,68.0,70.9,70,0
    .goto IcecrownGlacier,71.6,61.3,70,0
    .goto IcecrownGlacier,67.2,68.3
	.use 44048 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当您拥有每件设备中的一件时，请在您的包中使用走私解决方案(您不需要等待RP) << Alliance
	.collect 43609,3,13292,1,-1 << Alliance --Pile of Bones (3)
	.collect 43610,3,13292,1,-1 << Alliance --Abandoned Helm (3)
	.collect 43616,3,13292,1,-1  << Alliance --Abandoned Armor (3)
    .complete 13292,1 << Alliance --Field Tests Conducted (3)
	.use 43608 >>掠夺散落在破碎战线周围地面上的废弃装备碎片。当你有每一件设备时，在你的袋子里放上科珀克劳挥发性油(你不需要等待RP) << Horde
	.collect 43609,3,13261,1,-1  << Horde --Pile of Bones (3)
	.collect 43610,3,13261,1,-1 << Horde --Abandoned Helm (3)
	.collect 43616,3,13261,1,-1 << Horde --Abandoned Armor (3)
    .complete 13261,1 << Horde --Field Tests Conducted (3)
	.isOnQuest 13292 << Alliance
	.isOnQuest 13261 << Horde
step
    .goto IcecrownGlacier,68.3,61.5
	>>杀死该地区的绿巨人憎恶者，并掠夺他们的寒冷憎恶肠
	.use 43968 >>使用袋子里有肠子的憎恶复活套件来召唤一个你可以控制的憎恶。通过让憎恶者攻击尽可能多的暴徒，并使其仇恨，然后使用“在接缝处爆发”杀死憎恶者附近的所有暴徒(暴徒必须战斗才能获得荣誉)
	>>如果你的肠子用完了，去杀死更多的怪物憎恶。你一次只能有一个胆量。
	.collect 43966,1,13289,-1,1 << Alliance --Chilled Abomination Guts (3)
    .complete 13289,1 << Alliance  --Icy Ghouls Exploded (15)
    .complete 13289,2 << Alliance  --Vicious Geists Exploded (15)
    .complete 13289,3 << Alliance  --Risen Alliance Soldiers Exploded (15)
	.collect 43966,1,13276,-1,1 << Horde  --Chilled Abomination Guts (3)
    .complete 13276,1 << Horde --Icy Ghouls Exploded (15)
    .complete 13276,2 << Horde --Vicious Geists Exploded (15)
    .complete 13276,3 << Horde --Risen Alliance Soldiers Exploded (15)
	.isOnQuest 13289 << Alliance
	.isOnQuest 13276 << Horde
step
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7,70,0
    .goto IcecrownGlacier,66.8,58.4,70,0
    .goto IcecrownGlacier,69.5,57.3,70,0
    .goto IcecrownGlacier,72.5,59.0,70,0
    .goto IcecrownGlacier,70.1,57.2,70,0
    .goto IcecrownGlacier,65.7,63.0,70,0
    .goto IcecrownGlacier,63.4,56.7
	>>杀死该地区的瞳孔恐怖。掠夺他们以换取一个肉质巨刺。这个任务非常困难。如果需要，可以分组，或者如果愿意，可以放弃/跳过这一天
	.collect 44009,1 -- Flesh Giant Spine (1)
	.isOnQuest 13297 << Alliance
	.isOnQuest 13281 << Horde
step
	.goto IcecrownGlacier,62.3,63.4
	.use 44009 >>用你袋子里的肉巨人脊椎来制造脓疱性脊椎液
	.collect 44010,1 -- Pustulant Spinal Fluid (1)
	.isOnQuest 13297 << Alliance
	.isOnQuest 13281 << Horde
step
    .goto IcecrownGlacier,62.3,63.4
	.use 44010 >>在冒着气泡的绿色大锅上使用袋子里的脓疱性脊髓液。杀死繁殖的怪物，并在提示“很快添加液体”时再次使用脊椎液体。这个任务非常困难。如果需要，可以分组，或者如果愿意，可以放弃/跳过这一天
    .complete 13297,1 << Alliance --Batch of Plague Neutralized (1)
    .complete 13281,1 << Horde --Batch of Plague Neutralized (1)
	.isOnQuest 13297 << Alliance
	.isOnQuest 13281 << Horde
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
step
	#completewith next
    .goto IcecrownGlacier,51.9,32.5,30 >>进入Aldur'star
	.isOnQuest 13350 << Alliance
	.isOnQuest 13368 << Horde
step
	>>这个任务非常困难。如果需要，可以分组，或者放弃/跳过这一天
	>>打开Aldur'star里面的箱子，抢走Alumeth的头骨、心脏、权杖和长袍
	.collect 44476,1 --Alumeth's Skull (1)
    .goto IcecrownGlacier,50.5,30.0
	.collect 44477,1 --Alumeth's Heart (1)
    .goto IcecrownGlacier,52.8,30.7
	.collect 44478,1 --Alumeth's Scepter (1)
    .goto IcecrownGlacier,52.8,29.8
	.collect 44479,1 --Alumeth's Robes (1)
    .goto IcecrownGlacier,53.0,29.0
	.isOnQuest 13350 << Alliance
	.isOnQuest 13368 << Horde
step
    .goto IcecrownGlacier,51.9,29.0
	>>这个任务非常困难。如果需要，可以分组，或者放弃/跳过这一天
	.use 44476 >>点击包中的任何物品，将其组合成Alueth遗骸
	.collect 44480,1 --Alumeth's Remains (1)
	.isOnQuest 13350 << Alliance
	.isOnQuest 13368 << Horde
step
    .goto IcecrownGlacier,51.9,29.0
	>>这个任务非常困难。如果需要，可以分组，或者放弃/跳过这一天
	.use 44480 >>使用发光水晶前的Alueth遗骸召唤他。杀了他
    .complete 13350,1 << Alliance --Alumeth the Ascended Defeated (1)
    .complete 13368,1 << Horde --Alumeth the Ascended Defeated (1)
	.isOnQuest 13350 << Alliance
	.isOnQuest 13368 << Horde
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
	>>飞向空中的小平台。与Killohertz交谈
	.goto IcecrownGlacier,53.96,42.93
	.daily 13404 >>接任务: 短程行动：轰炸场
step << Alliance
	.goto IcecrownGlacier,53.96,43.11
	>>和凯伦谈谈，让她坐上轰炸机。使用冲锋盾牌(1)获得100个盾牌，然后切换到轰炸机湾(5)，开始轰炸下方的天灾，直到所有步兵和上尉被杀死。切换到防空炮塔(4)，开始使用防空火箭(1)在空中射击石像鬼。完成后，按下离开车辆按钮，您将返回平台
	.complete 13404,1 -- Bombardment Infantry slain (50)
	.complete 13404,2 -- Bombardment Captain slain (10)
	.complete 13404,3 -- Gargoyle Ambusher slain (20)
	.skipgossip
step << Alliance
	>>与Killohertz交谈
    .goto IcecrownGlacier,53.96,42.93
    .turnin 13404 >>交任务: 短程行动：轰炸场
	.isQuestComplete 13404
step << Horde
	>>飞向空中的小平台。与Tezzla交谈
    .goto IcecrownGlacier,53.99,36.87
    .daily 13406 >>接任务: 短程行动：轰炸场
step << Horde
	.goto IcecrownGlacier,53.96,43.11
	>>与Rizzy交谈，让他登上轰炸机。使用冲锋盾牌(1)获得100个盾牌，然后切换到轰炸机湾(5)，开始轰炸下方的天灾，直到所有步兵和上尉被杀死。切换到防空炮塔(4)，开始使用防空火箭(1)在空中射击石像鬼。完成后，按下离开车辆按钮，您将返回平台
	.complete 13406,1 -- Bombardment Infantry slain (50)
	.complete 13406,2 -- Bombardment Captain slain (10)
	.complete 13406,3 -- Gargoyle Ambusher slain (20)
	.skipgossip
step << Horde
	>>与Tezzla交谈
    .goto IcecrownGlacier,54.00,36.94
    .turnin 13406 >>交任务: 短程行动：轰炸场
	.isQuestComplete 13406
step << Alliance
    .goto IcecrownGlacier,65.1,57.2,0
    .goto IcecrownGlacier,64.7,52.4,0
    .goto IcecrownGlacier,62.1,45.9,0
    .goto IcecrownGlacier,57.5,39.1,0
    .goto IcecrownGlacier,54.7,35.3,0
	>>返回破天者。与骑士队长Drosche、虔诚的Absalan、高级队长Justin Bartlett、总工程师Boltwrench和Thassarian交谈
    .turnin -13336 >>交任务: 伊米亚之血
    .turnin -13300 >>交任务: 萨隆邪铁的奴隶
	.turnin -13233 >>交任务: 决不留情！
    .turnin -13292 >>交任务: 偷来的解决方案
    .turnin -13289 >>交任务: 你的憎恶伙伴
	.turnin -13297 >>交任务: 中和瘟疫
    .turnin -13322 >>交任务: 重新考验
    .turnin -13323 >>交任务: 从天而“降”
	.turnin -13344 >>交任务: 活动窃听器
    .turnin -13350 >>交任务: 片刻不得安宁
    .turnin -13333 >>交任务: 抢夺急件
step << Horde
	.goto IcecrownGlacier,67.00,38.00,0
	>>返回奥格里姆之锤。与战争使者达沃斯·里奥特、凯尔坦兄弟、天空收割者科姆·布莱克斯卡、首席工程师科珀克劳和科尔蒂拉·戴斯韦弗交谈
    .turnin -13330 >>交任务: 伊米亚之血
    .turnin -13302 >>交任务: 萨隆邪铁的奴隶
	.turnin -13234 >>交任务: 血的代价！
    .turnin -13261 >>交任务: 爆炸油
    .turnin -13276 >>交任务: 你的憎恶伙伴
	.turnin -13281 >>交任务: 中和瘟疫
    .turnin -13357 >>交任务: 重新考验
    .turnin -13353 >>交任务: 从天而“降”
	.turnin -13365 >>交任务: 活动窃听器
    .turnin -13368 >>交任务: 片刻不得安宁
    .turnin -13331 >>交任务: 盲目的联盟
step << Alliance
	+您已经完成了今天的所有破天者每日任务：)如果愿意，请记住尝试完成您放弃/跳过的任何团队任务！
step << Horde
	+您已经完成了今天的所有Orgrim Hammer每日任务：)如果愿意，请记住尝试完成您放弃/跳过的任何团队任务！
]])
