RXPGuides.RegisterGuide([[
#version 9
#wotlk
#group RestedXP 法师 AoE 68-80
<< Mage
#name 68-80 法师 AoE

step
#completewith WHFP << Horde
#completewith VKHS << Alliance
+欢迎使用RXPGuides AoE Mage 68-80指南！
.link https://discord.com/invite/ApNgbdQNQy >>由于这是Beta版，指南可能有一些错误。如果在玩游戏时遇到任何问题，请在此处报告！
step << Horde
#completewith BTZep1
.zone Orgrimmar >>前往: 奥格瑞玛
step << Horde
#level 68
.goto Orgrimmar,38.4,86.1
>>下楼去
.trainer >>训练你的职业咒语
step << Horde
#label BTZep1
.goto Durotar,41.6,18.2,30,0
.goto Durotar,41.4,17.6
.zone BoreanTundra >>把齐柏林飞艇从杜隆塔尔带到伯兰苔原
step << Horde
#completewith end
#label WHHS
.goto BoreanTundra,41.92,54.49
.home >>将您的炉石设置为战歌控制
step << Horde
#completewith end
#requires WHHS
#label WHFP
.goto BoreanTundra,40.72,52.54,20,0
.goto BoreanTundra,40.36,51.39
>>走楼梯，然后乘电梯到楼顶
.fp Warsong Hold >>获取战歌等待飞行路径
step << Alliance
#completewith Boat1
.zone Stormwind City >>前往: 暴风城
step << Alliance
#level 68
.goto Stormwind City,49.2,87.7
.trainer >>训练你的职业咒语
step << Alliance
#label Boat1
.goto Stormwind City,43.5,52.7,70,0
.goto Stormwind City,17.7,25.5
.zone BoreanTundra >>前往暴风港。船到了就上船。去北风苔原
step << Alliance
#completewith end
#label VKFP
.goto BoreanTundra,58.9,68.3
.fp Valiance Keep >>获取Valiance保持飞行路线
step << Alliance
#completewith end
#requires VKFP
#label VKHS
.goto BoreanTundra,58.5,68.3,15,0
.goto BoreanTundra,58.3,68.1
>>进入客栈
.home >>将您的炉石设置为Valiance Keep
step << skip
.loop 75,BoreanTundra,54.0,48.8,55.1,42.4,53.6,39.2,54.8,38.4,61.8,40.0,62.2,31.7,55.6,27.1,57.3,34.2
.xp 72 >>AoE将猛犸、狼、机器、鹰和驯鹿升级到72
step
#requires WHFP << Horde
#requires VKHS << Alliance
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 69 >>AoE将犀牛磨碎至69
step
#level 69
#completewith next
.zone Undercity >>前往: 幽暗城 << Horde
.zone Stormwind City >>前往: 暴风城 << Alliance
step
#level 69
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >>训练你的职业咒语
step
#completewith next
.hs >>心与心保持一致 << Alliance
.hs >>心脏到征服保持 << Horde
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 70 >>AoE将犀牛磨碎至70
step
#level 70
#completewith next
.zone Undercity >>前往: 幽暗城 << Horde
.zone Stormwind City >>前往: 暴风城 << Alliance
step
#level 70
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >>训练你的职业咒语
step
#completewith next
.hs >>心脏到征服保持 << Horde
.hs >>心与心保持一致 << Alliance
step << skip
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.line BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.xp 71 >>AoE将犀牛碾碎至71
step << skip
#level 71
#completewith next
.zone Undercity >>前往: 幽暗城 << Horde
.zone Stormwind City >>前往: 暴风城 << Alliance
step << skip
#level 71
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >>训练你的职业咒语
step << skip
#completewith next
.hs >>心脏到征服保持 << Horde
.hs >>心与心保持一致 << Alliance
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 72 >>AoE将犀牛升级到72
step << skip
#level 72
#completewith next
.zone Undercity >>前往: 幽暗城 << Horde
.zone Stormwind City >>前往: 暴风城 << Alliance
step << skip
#level 72
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >>训练你的职业咒语
step << skip
#completewith next
.hs >>心脏到征服保持 << Horde
.hs >>心与心保持一致 << Alliance
step << skip
#completewith end
#label ALFP
.goto BoreanTundra,45.33,34.62
>>前往琥珀色壁架
.fp Amber Ledge >>获取琥珀色Ledge飞行路径
step << Horde
#completewith end
#label TaunFP
.goto BoreanTundra,77.76,37.77
>>前往陶恩卡省
.fp Taunka'le Village >>获得Taunka'le村的飞行路线
step << Alliance
#completewith end
#label UnuFP
.goto BoreanTundra,78.54,51.53
>>前往Unu'pe
.fp Unu'pe >>获取Unu'pe飞行路线
step << Alliance
.goto BoreanTundra,82.17,46.41
>>与二等兵凯西交谈
.accept 12157 >>接任务: 失踪的信使
step
#completewith next
.goto Dragonblight,12.39,55.22
.zone Dragonblight >>前往: 龙骨荒野
step << Horde
#completewith end
#label AgmarFP
.goto Dragonblight,37.51,45.77
>>前往阿格玛锤子
.fp Agmar's Hammer >>获取Agmar的Hammer飞行路线
step << Horde
#completewith end
#requires WyrmFP
#label WyrmFP
.goto Dragonblight,60.32,51.55
>>前往Wyrmrest Temple
.fp Wyrmrest Temple >>获得Wyrmrest Temple飞行路线
step << Horde
#completewith end
#requires WyrmFP
#label VenomFP
.goto Dragonblight,76.48,62.20
.fp Venomspite >>获取Venomwhile飞行路径
step << Horde
#completewith end
#requires VenomFP
#label VenomHS
.goto Dragonblight,76.87,63.13
.home >>将你的心设为毒液怨恨
step << Alliance
#completewith end
#label StarsFP
.goto Dragonblight,29.15,55.32
>>星空之旅
.fp Stars' Rest >>获取星星的休息飞行路径
step << Alliance
.goto Dragonblight,28.84,56.16
>>与兰森交谈
.turnin 12157 >>交任务: 失踪的信使
.accept 12171 >>接任务: 叛徒的名单
step << Alliance
.goto Dragonblight,29.16,55.37
>>与Palena交谈
>>接受这个任务会让你飞到温特加德要塞
.turnin 12171 >>交任务: 叛徒的名单
.accept 12174 >>接任务: 高级指挥官哈尔弗·维姆班恩
step << Alliance
#completewith end
#label WinterFP
.goto Dragonblight,77.08,49.86
.fp Wintergarde Keep>>获取Wintergarde Keep飞行路线
step << Alliance
#requires WinterFP
.goto Dragonblight,78.59,48.18
>>与Halford Wyrmbane交谈
.turnin 12174 >>交任务: 高级指挥官哈尔弗·维姆班恩
.accept 12235 >>接任务: 纳克萨玛斯与暮冬城的陷落
step << Alliance
#completewith end
#label WinterHS
.goto Dragonblight,77.46,51.43
.home >>将您的炉石设置为Wintergarde Keep
step << Alliance
#requires WinterHS
.goto Dragonblight,77.18,50.09
>>返回到Flight Master。与Urik交谈
.turnin 12235 >>交任务: 纳克萨玛斯与暮冬城的陷落
.accept 12237 >>接任务: 拯救暮冬城平民
step << skip
#completewith next
.cast 48388 >>使用鹰头狮哨声来骑上一只温特加德鹰头狮。你可以用它在温特加德和腐肉场飞行
.use 37287
step << skip
#requires VenomHS
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 73 >>AoE将猩红打磨到73
step << skip
#level 73
#completewith next
.zone Undercity >>前往: 幽暗城 << Horde
.zone Stormwind City >>前往: 暴风城 << Alliance
step << skip
#level 73
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >>训练你的职业咒语
step << skip
#level 73
#label WinterHS1
#completewith next
.hs >>从心脏到毒液 << Horde
.hs >>温特加尔德要塞的壁炉 << Alliance
step << Alliance
#requires WinterHS1
#completewith next
.cast 48388 >>使用鹰头狮哨声来骑上一只温特加德鹰头狮。你可以用它在温特加德和腐肉场飞行
.use 37287
step
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 74 >>AoE将猩红碾碎至74
step
#label WinterHS2
#completewith next
.hs >>从心脏到毒液 << Horde
.hs >>温特加尔德要塞的壁炉 << Alliance
step
#completewith next
.goto Dragonblight,77.08,49.86 << Alliance
.fly Stars' Rest>>飞到星星的休息处 << Alliance
.goto Dragonblight,76.48,62.20 << Horde
.fly Agmar >>飞向阿格玛之锤 << Horde
.zoneskip Dalaran
.zoneskip SholazarBasin
step << Horde
.goto Dragonblight,38.05,46.22
>>与Aethas交谈
.accept 12791 >>接任务: 魔法王国达拉然
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Horde
.goto Dragonblight,38.05,46.22
.zone Dalaran >>前往: 达拉然
.zoneskip SholazarBasin
.skipgossip
step << Alliance
.goto Dragonblight,29.0,55.5
>>与Modera交谈
.accept 12794 >>接任务: 魔法王国达拉然
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Alliance
.goto Dragonblight,29.0,55.5
.zone Dalaran >>前往: 达拉然
.zoneskip SholazarBasin
.skipgossip
step
.abandon 12791 >>放弃达拉然魔法王国。不要把这个交进去 << Horde
.abandon 12794 >>放弃达拉然魔法王国。不要把这个交进去 << Alliance
step
.goto Dalaran,56.3,46.7
.trainer >>进入大楼。训练您的达拉然门户
step
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
#completewith end
#label DalaranFP
.goto Dalaran,72.18,45.77
.fp Dalaran >>获取达拉然飞行路线
step
#requires DalaranFP
#completewith next
.goto Dalaran,68.54,42.07
>>前往克拉苏斯登陆。与Pentarus交谈
.accept 12521 >>接任务: 赫米特·奈辛瓦里哪去了？
step
#requires DalaranFP
.goto Dalaran,68.54,42.07
.zone SholazarBasin >>叫彭塔鲁斯带你去肖拉扎尔盆地。这需要50秒
.skipgossip
step
.goto SholazarBasin,39.70,58.65
>>与挂在树上的蒙特交谈
.turnin 12521 >>交任务: 赫米特·奈辛瓦里哪去了？
.accept 12489 >>接任务: 欢迎来到索拉查盆地
step
#completewith end
#label Nesingwary
.goto SholazarBasin,26.8,59.3,0,0
.home >>将您的炉石设置为Nesingwarve大本营
>>如果需要，购买食物
step
>>前往Nesingwarve大本营。与Hemet、Debaar和Chad交谈
.turnin 12489 >>交任务: 欢迎来到索拉查盆地
.goto SholazarBasin,27.09,58.64
.accept 12524 >>接任务: 风险投资公司的风险
.goto SholazarBasin,27.25,59.90
.accept 12624 >>接任务: 不知所踪！
.goto SholazarBasin,26.86,58.94
step
#requires Nesingwary
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话
.accept 12522 >>接任务: 需要引擎
step
#completewith VentureCo2
>>杀死Sholazar的所有暴徒以获得黄金订婚戒指。根本不要关注这个任务
.complete 12624,1 
step
.goto SholazarBasin,38.69,56.72
>>在飞行机器旁边的水面上掠夺“引擎”
.complete 12522,1 
step
#completewith Helice
.goto SholazarBasin,36.8,47.3,0
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
.goto SholazarBasin,35.55,47.42
>>与工程师Helice交谈，开始护送
.accept 12688 >>接任务: 工程师的逃亡
step
#label Helice
.goto SholazarBasin,37.27,50.59
>>护送Helice
.complete 12688,1 
step
#completewith next
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 75 >>AoE创业公司至75
step
.goto SholazarBasin,37.35,45.78,50,0
.goto SholazarBasin,33.31,45.31,50,0
.goto SholazarBasin,33.13,47.90
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
#level 75
#completewith next
.zone Dalaran >>前往: 达拉然
step
#level 75
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
#completewith Debaar1
.hs >>Nesingwarve大本营之炉
step
>>返回Nesingwarve的大本营。与Hemet和Debaar交谈
.turnin 12688 >>交任务: 工程师的逃亡
.goto SholazarBasin,27.09,58.64
.turnin 12524 >>交任务: 风险投资公司的风险
.accept 12525 >>接任务: 工头斯温迪格林
.goto SholazarBasin,27.25,59.90
.isQuestComplete 12688
step
#requires EscortEnd
#label Debaar1
.goto SholazarBasin,27.25,59.90
>>与Debaar交谈
.turnin 12524 >>交任务: 风险投资公司的风险
.accept 12525 >>接任务: 工头斯温迪格林
step
.goto SholazarBasin,26.86,58.94
>>与乍得对话
.turnin 12624 >>交任务: 不知所踪！
.isQuestComplete 12624
step
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话
.turnin 12522 >>交任务: 需要引擎
.accept 12523 >>接任务: 借零件
step
#completewith VentureCo2
.goto SholazarBasin,33.2,45.7,0
>>掠夺在斯温德莱格林的地窖附近发现的各种备件
.complete 12523,1 
step
.goto SholazarBasin,35.49,50.00
>>杀死木平台上的Foreman Swindlegrin和Meatpie
.complete 12525,1 
.complete 12525,2 
step
#label VentureCo2
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 76 >>AoE创业公司至76
step
.goto SholazarBasin,33.2,45.7,50,0
.goto SholazarBasin,37.03,46.72
>>掠夺在斯温德莱格林的地窖附近发现的各种备件
.complete 12523,1 
step
>>杀死Sholazar的所有暴徒以获得黄金订婚戒指。根本不要关注这个任务
.complete 12624,1 
step
#level 76
#completewith next
.zone Dalaran >>前往: 达拉然
step
#level 76
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
#completewith Debaar1
.hs >>Nesingwarve大本营之炉
step
#completewith end
#label NesFP
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话，然后与飞行机器和卡尔弗特通话
.turnin 12523 >>交任务: 借零件
.fp Nesingwary Base Camp >>获得Nesingwarve大本营飞行路线
.goto SholazarBasin,25.27,58.45


step
#requires NesFP
>>先和Debaar谈谈，然后是Drostan
.turnin 12525 >>交任务: 工头斯温迪格林
.goto SholazarBasin,27.25,59.90
.accept 12589 >>接任务: 后坐力？什么后坐力？
.goto SholazarBasin,27.08,59.91
step
.goto SholazarBasin,27.08,59.91
.use 38573 >>用你包里的RJR步枪射击Lucky Wilhelm。这样做直到目标完成，然后重新装备你的魔杖
.complete 12589,1 
.turnin 12589 >>交任务: 后坐力？什么后坐力？

step
.goto SholazarBasin,26.86,58.94
>>与乍得对话
.turnin 12624 >>交任务: 不知所踪！
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 77 >>AoE创业公司至77
step
#completewith next
.zone Dalaran >>前往: 达拉然
step
#level 77
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
.goto Dalaran,69.81,45.45
.train 54197 >>从Hira训练寒冷天气飞行
step
#completewith next
>>如果你有295或更多的法术命中(和精准天赋)，跳过这一步
.hs >>Nesingwarve大本营之炉
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
>>如果你有295或更多的法术命中(和精准天赋)，跳过这一步
.xp 78 >>AoE创业公司至78
step
#completewith next
.zone Dalaran >>前往: 达拉然
step
#level 78
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >>前往: 冰冠冰川
step
.goto IcecrownGlacier,59.0,73.8
.xp 79 >>AoE亡灵到79
step
#level 79
#completewith next
.zone Dalaran >>前往: 达拉然
step
#level 79
.goto Dalaran,54.94,46.19
.trainer >>训练你的职业咒语
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >>前往: 冰冠冰川
step
.goto IcecrownGlacier,59.0,73.8
.xp 80 >>AoE亡灵到80
step
+恭喜您完成了RestedXP 68-80 AoE升级指南！感谢您使用RestedXP。
.link https://discord.com/invite/ApNgbdQNQy >>由于这是Beta版，指南可能有一些错误。如果您在玩游戏时遇到任何问题，请在此处报告！
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name !如何使用本指南
#hidewindow
step
#sticky
+欢迎使用RXP 70-71准备指南！
+从“收藏物品”和“启动准备指南”章节开始，因为它们将为您在启动时提交的所有任务做好准备。完整地完成它们，把它说要交的所有任务交上来。这些是您在开放世界中留下的任务线，而不是您保存在任务日志中的任务！
+接下来，做25个任务日志指南，这些是你在任务日志中留下的任务。建议您完成大约24个任务，而不是全部25个任务，以确保在发布日有足够的空间来完成准备好的任务。在上一步之前不要执行此指南，否则您需要回溯！
+然后查看“当日转弯速度助手”以加快路线转弯速度
+最后，您可以在发布日使用《入住指南》！
+目前，《入住指南》尚未发布，以防止意外使用，请密切关注我们社区的不和谐，以跟上时代的步伐
step << skip
+完成指南后，强烈建议您将角色复制到PTR，并在PTR上对《转入指南》进行测试，以便更好地了解路线！
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name 可收集项目
step
#completewith questdrops
#sticky
+指南的这一章是从开始任务的怪物身上掉落的所有物品。强烈建议您遵循它完成任务，即使这意味着要为精英任务找到一个团队。
step
#sticky
.reputation 1015,friendly >>与荷兰之翼友好相处。
step
.isQuestAvailable 10804
.goto Shadowmoon Valley,59.4,58.6
>>这个任务线会让你和荷兰之翼很友好，这会给你很多潜在的经验。
* The quest giver can be off fighting Rocknails or even die to them, you may need to wait for him to respawn.
.accept 10804 >>接任务: 友善
step
.isOnQuest 10804
.goto Shadowmoon Valley,62.4,58.6
.use 31372 >>杀死并掠夺该地区的Rocknail Flayers以获取他们的尸体。然后把它们的尸体放在地上喂给荷兰龙。
*Make sure to travel a bit when laying the meat, as the same drakes won't eat twice in a row
.complete 10804,1 
step
.isOnQuest 10804
.goto Shadowmoon Valley,59.4,58.6
>>任务给予者可能正在与岩石钉子战斗，甚至会被他们杀死，你可能需要等待他重生。
.turnin 10804 >>交任务: 友善
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.accept 10811 >>接任务: 寻找奈尔萨拉库
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0,80,0
.goto Shadowmoon Valley,66.2,60.4,80,0
.goto Shadowmoon Valley,61.8,60.0
>>她是一条幽灵般的巨龙，在荷兰飞翔，可能需要四处寻找她。
.unitscan Neltharaku
.turnin 10811 >>交任务: 寻找奈尔萨拉库
.accept 10814 >>接任务: 奈尔萨拉库的故事
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.skipgossip
>>与Neltharaku交谈
.turnin 10814 >>交任务: 奈尔萨拉库的故事
.accept 10836 >>接任务: 攻击龙喉要塞
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,60.0
>>杀死该地区所有的龙嘴兽，除了人以外，其他人都会加入任务
.complete 10836,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
>>找到并杀死渗透者Hameya。他在这个地区闲逛。抢走他的钥匙。
.unitscan Neltharaku
.turnin 10836 >>交任务: 攻击龙喉要塞
.accept 10837 >>接任务: 前往灵翼浮岛！
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,80.0,60,0
.goto Shadowmoon Valley,66.3,82.3,30,0
.goto Shadowmoon Valley,67.3,81.7,30,0
.goto Shadowmoon Valley,68.3,79.8,30,0
.goto Shadowmoon Valley,71.7,83.1,30,0
.goto Shadowmoon Valley,76.7,83.3,60,0
.goto Shadowmoon Valley,66.0,80.0
>>掠夺该地区的荷兰水晶。“寻找矿物”可以追踪它们，尽管它们看起来像植物。
.complete 10837,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>>找到尼特哈拉库在尼日翼原野上空飞行
.turnin 10837 >>交任务: 前往灵翼浮岛！
.accept 10854 >>接任务: 奈尔萨拉库之力
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,64.0 
.use 31652 >>在被奴役的龙兽身上使用水晶。不要站得太近，否则他们会攻击你而不是兽人。
*The drakes are very weak and will charge nearby orcs after freeing them, be quick to help them in combat or they will die.
.complete 10854,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>>找到尼特哈拉库在尼日翼原野上空飞行
.turnin 10854 >>交任务: 奈尔萨拉库之力
.accept 10858 >>接任务: 卡瑞纳库
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
>>在要塞的二楼找到Karynaku
.unitscan Karynaku
.turnin 10858 >>交任务: 卡瑞纳库
.accept 10872 >>接任务: 疲惫的祖鲁希德
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,62.2
>>这是一个精英任务，你可能需要帮助。杀死祖鲁希德，抢夺他的钥匙。
.complete 10872,2
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.use 31664 >>用Karynaku锁链上的钥匙来释放她。
.complete 10872,1
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.turnin 10872 >>交任务: 疲惫的祖鲁希德
.accept 10871 >>接任务: 灵翼之盟
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
>>任务给予者可能正在与岩石钉子战斗，甚至会被他们杀死，你可能需要等待他重生。
.turnin 10871 >>交任务: 灵翼之盟
.accept 11012 >>接任务: 灵翼血誓
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.turnin 11012 >>交任务: 灵翼血誓
.accept 11013 >>接任务: 为伊利达雷效力
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.2,85.6
.turnin 11013 >>交任务: 为伊利达雷效力
.accept 11014 >>接任务: 会见工头
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.turnin 11014 >>交任务: 会见工头
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
>>杀死贪婪的阿沃尔并掠夺他。他是精英，你可能需要一个团队。
* Note, sometimes only one person per kill can loot the item, you may need to kill him multiple times.
.unitscan Arvoar the Rapacious
.collect 32621,1,11041,1
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
.use 32621 >>使用包中的部分消化手接受任务
.accept 11041 >>接任务: 未完的工作......
step
.isOnQuest 11041
.goto Shadowmoon Valley,70.4,84.6
>>杀死该地区的Overmine Flayers和Den Mother Barash
.unitscan Barash the Den Mother
.complete 11041,1
.complete 11041,2
step
.isOnQuest 11041
.goto Shadowmoon Valley,66.2,85.6
.turnin 11041 >>交任务: 未完的工作......
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.accept 11019 >>接任务: 你的伙伴
.turnin 11019 >>交任务: 你的伙伴
step
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly >>通过做日报与荷兰派保持友好关系。不要提交任何一次任务，如羽翼蛋或上升，监督！
.accept 11020 >>接任务: 缓慢的死亡
.accept 11015 >>接任务: 灵翼水晶
.accept 11035 >>接任务: 危险的天空
>>这三个任务需要采集职业，每天只能完成一个。
.accept 11018 >>接任务: 虚空矿石
.accept 11017 >>接任务: 灵尘花粉
.accept 11016 >>接任务: 虚空矿洞剥石者的外皮
step
.goto Shadowmoon Valley,63.0,87.8
>>从矿井中德雷纳的黑血中收集25个污泥覆盖物
*Note: You can copy your character onto the PTR, turn in "Rise, Overseer!" and "The Netherwing Mines" on the PTR then start opening them until you find one that has Murkblood Escape Plans. You can delete the rest, as that same one will have it on live servers.
.collect 32724,25,11081,1
step
.goto Shadowmoon Valley,53.0,62.4,60,0
.goto Shadowmoon Valley,52.7,68.6,60,0
.goto Shadowmoon Valley,51.6,63.8,60,0
.goto Shadowmoon Valley,52.3,59.1,60,0
.goto Shadowmoon Valley,53.0,62.4
.unitscan Val'zareq the Conqueror
>>去杀了征服者瓦尔扎雷。这是一个精英任务，你可能需要分组。
.collect 31345,1,10793,1 >>获取Vel'zareq杂志
step << Horde
.goto Shadowmoon Valley,67.6,36.6
>>杀死Smith Gorlunk并掠夺他
.unitscan Smith Gorlunk
.collect 31241,1,10755,1
step << Alliance
>>杀死Smith Gorlunk并掠夺他
.unitscan Smith Gorlunk
.goto Shadowmoon Valley,67.6,36.6
.collect 31239,1,10754,1
step
.requires quest,11370
.goto Shattrath City,75.0,36.4
.daily 11369,11384,11382,11363,11362,11375,11354,11386,11373,11378,11374,11372,11368,11388,11370 >>每天接受英雄副本
step
.requires quest,11387
.goto Shattrath City,75.4,37.6
.daily 11389,11371,11376,11383,11364,11385,11387 >>每天接受副本
step
.goto Terokkar Forest,69.6,78.6
>>杀死并掠夺塔龙牧师伊沙尔。如果你还没有完成暗影世界的任务，你需要找到一个已经完成任务的人，和他们一起组队，如果没有任务中的长生不老药，他是看不见的。
>>他们可以为你杀死塔龙牧师，你可以为《华尔街日报》掠夺他。不要完成阴影世界来完成这个任务，阴影世界在发布日更有经验。
>>如果找不到人，请跳过此步骤。
.unitscan Talonpriest Ishaal
.collect 32523,1,11021,1
step
.goto Terokkar Forest,41.2,56.8
>>杀死并掠夺该地区的阴谋集团敌人，直到你获得任务物品
.collect 31707,1,10880,1
step
.goto Hellfire Peninsula,25.6,76.6
.unitscan Avruu
>>杀死并掠夺Avruu
.collect 23580,1,9418,1
step << Horde
.goto Hellfire Peninsula,65.6,30.0
>>杀死并掠夺剃须刀
.collect 29590,1,10393,1
step << Alliance
.goto Hellfire Peninsula,53.1,26.7
>>杀戮和掠夺战争使者阿里克斯·阿马尔
.collect 29588,1,10395,1
step
.goto Hellfire Peninsula,48.6,39.6
>>杀死并掠夺掠夺地壳爆破器，直到你获得任务物品
* You will need to run over the "Earthquakes" on the ground to spawn the enemies
.collect 23338,1,9373,1
step
.goto Hellfire Peninsula,17.8,40.6
>>杀死并掠夺愤怒的巨像
.collect 29476,1,10134,1
step << Alliance
.goto Zangarmarsh,80.2,41.0
>>杀死并掠夺枯萎巨人，直到你获得任务物品。
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24483,1,9827,1
step << Horde
.goto Zangarmarsh,80.2,41.0
>>杀死并掠夺枯萎巨人，直到你获得任务物品。
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24484,1,9828,1
step << skip
.goto Zangarmarsh,62.2,40.6
>>杀死并掠夺该地区的蒸汽泵监督人员和其他管理人员，直到你得到排水示意图
.collect 24330,1,9731,1
step
.goto Nagrand,73.6,59.2,40,0
.goto Nagrand,69.8,52.8,40,0
.goto Nagrand,72.8,44.6,40,0
.goto Nagrand,65.8,38.2,0
>>杀死并掠夺该地区的闪电元素，尘啸者拥有最好的下降率。
.collect 24504,1,9861,1
step << Alliance
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>>杀死并掠夺黑血侵略者，他们四处巡逻，所以你可能需要多圈。
.collect 24559,1,9871,1
.unitscan Murkblood Invader
step << Horde
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>>杀死并掠夺黑血侵略者，他们四处巡逻，所以你可能需要多圈。
.collect 24558,1,9872,1
.unitscan Murkblood Invader
step
.goto Zangarmarsh,32.9,59.6
>>杀死并掠夺“安古拉伯爵”
.collect 25459,1,9911,1
.unitscan "Count" Ungula
step
.goto Blade's Edge Mountains,75.8,23.6,40,0
.goto Blade's Edge Mountains,71.6,33.6,40,0
.goto Blade's Edge Mountains,70.6,44.8,0
>>杀死并掠夺一名邪恶的腐败者
.collect 31384,1,10810,1
.unitscan Fel Corrupter
step
.goto Blade's Edge Mountains,41.6,21.4
>>杀死并掠夺该地区的Grishna暴徒
.collect 31489,1,10825,1
step
.goto Netherstorm,59.8,86.8
>>杀死并掠夺科利安·弗罗斯特韦弗
.collect 29236,1,10307,1
.unitscan Cohlien Frostweaver
step
.goto Netherstorm,60.0,85.2
>>杀死并掠夺魔法师Luminrath
.collect 29235,1,10306,1
.unitscan Conjurer Luminrath
step
.goto Netherstorm,60.6,87.6
>>杀戮和掠夺战斗法师Dathric
.collect 29233,1,10182,1
.unitscan Battle-Mage Dathric
step
.goto Netherstorm,59.0,88.2
>>杀死并掠夺Abjurit Belmara
.collect 29234,1,10305,1
.unitscan Abjurist Belmara
step
.goto Netherstorm,55.0,43.4
>>杀死凝固的虚空恐怖并掠夺他。这是精英，你可能需要分组。这个暴徒有30分钟的重生时间。
.collect 29738,1,10413,1
.unitscan Congealed Void Horror
step << Horde
>>杀死地狱火堡垒的最后一个老板。
.collect 23892,1,9588,1
step << Alliance
>>杀死地狱火堡垒的最后一个老板。
.collect 23890,1,9587,1
step
>>杀死蒸汽堡的暴徒，直到瓦什女士的命令下达为止
.collect 24367,1,9764,1 >>从Vashj女士那里获得订单
step
#sticky
#label questdrops
#completewith BOEitems
+这些任务是从奇袭中获得的，如果可以的话，请将其获取，否则请跳过本章
step << Alliance
>>从马瑟里登的巢穴里找到马瑟里顿头
.collect 32385,1,11002,1
step << Horde
>>从马瑟里登的巢穴里找到马瑟里顿头
.collect 32386,1,11003,1
step
>>从风暴要塞获得凯尔萨斯和苍翠球体。
.collect 32405,1,11007,1
step
>>从祖勒曼那里获得军阀之血。这个任务需要一个召唤到幽灵之地的召唤是一个有效的回合，如果你在发射日无法进入，请跳过。
.collect 33102,1,11178,1
step
#sticky
#completewith BOPitemslist
#label BOEitems
+本章是所有可以在拍卖行购买的物品，将是免费送货任务。购买时请核对。
step << Horde
.collect 31670,3,10860,1
.collect 31671,3,10860,1
step
.collect 24368,1,9765,1 
step

.collect 23445,4,10763,1
.collect 22445,2,10763,1
.collect 22574,4,10763,1
step
.collect 24449,6,9806,1 
step
.collect 24246,5,9715,1 
step
.reputation 970,friendly,0,1
.collect 24245,10,9808,1 
step
#aldor
.collect 25744,8,10024,1 
step
#aldor
.collect 29740,1,10420,1 
step
#aldor
.collect 30809,10,10653,1 
step << Alliance
.goto Blasted Lands,63.5,17.0
>>前往尼德加德禁猎区(Blasted lands)。到马厩里去买一杯Nethergard Bitter
.collect 23848,1,9563,1 
step
#aldor
.collect 29425,10,10325,1 
step
#scryer
.collect 30810,10,10656,1 
step
#scryer
.collect 29426,10,10412,1 
step
#scryer
.collect 29739,1,10416,1 
step
.collect 25719,30,10917,1 
step
.collect 32388,6,11004,1 
step
>>这项任务要求您与联盟保持中立，我们将在稍后的指南中将我们的代表减少为中立。如果您不想这样做，请跳过此步骤。
.collect 25463,27,9914,1 
step
>>这项任务要求您与联盟保持中立，我们将在稍后的指南中将我们的代表减少为中立。如果您不想这样做，请跳过此步骤。
.collect 25416,10,9882,1 
step
.collect 32601,1,11061,1 
step
.collect 32598,1,11030,1 
step
.collect 32464,40
.skill mining,<350,1 >>如果你有两种采集职业，那么你每天只能提交一次荷兰之翼采集，请跳过下一步购买
step
.collect 32468,40
.skill herbalism,<350,1 >>如果你有两种采集职业，那么你每天只能提交一次荷兰之翼采集，请跳过下一步购买
step
.collect 32470,35
.skill skinning,<350,1
step
#completewith BOEitems
.collect 24401,10,9802,1 
step
#sticky
#label BOPitemslist
#completewith BOPitems
+这些道具是BOP道具，需要在你的角色身上种植，以获得自由周转。
step

>>为战珠杀死纳格兰的食人魔
.collect 25433,20,9893,1 
step << Alliance
.goto Nagrand,75.0,65.0
>>在纳格兰碾碎任何暴徒，获得奥舒贡水晶粉。请注意，它是唯一的，最多100个，包括您银行中的任何一个
.collect 26043,20,10076,1
step << Horde
#label BOPitems
.goto Nagrand,75.0,65.0
>>在你选择的纳格兰地区研磨任何暴徒，获得奥舒贡水晶粉。请注意，它是唯一的，最多100个，包括您银行中的任何一个。
.collect 26042,20,10074,1
step
.goto Blade's Edge Mountains,30.2,75.2

>>杀死奥格里拉周围的暴徒
.collect 32569,5 
step
.goto Netherstorm,30.6,75.2
>>在暴风雨中杀死并掠夺扎克西斯袭击者和跟踪者
.collect 29209,10,10262,1 
step
.goto Shadowmoon Valley,69.0,85.0
>>杀死该地区的暴徒，并将其掠夺为荷兰之翼水晶
.collect 32427,30,11015,1 
step
.goto Shadowmoon Valley,69.0,85.0
.reputation 1015,friendly,<0,1
>>可以通过在该地区放牧、采矿、杀死怪物或在世界上找到怪物来找到。它们看起来像巨大的发光柱，类似于荷兰风暴中的天岭上的蛋。
.collect 32506,1,11049,1 
step << Alliance
.goto Blade's Edge Mountains,46.8,78.6,30,0
.goto Blade's Edge Mountains,43.2,80.4
>>从地上的酿酒师或桶中收集11瓶布鲁特班血腥酒。
.collect 29443,11,10511,1
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name 25 任务日志指南
step
#sticky
+本指南将在您的任务日志中为您提供25个任务以供启动。在准备好所有其他向导后，准备最后10个任务。
+ Some quests may seem out of order, it was impossible to make a 100% effecient route with everyone having different quests. Sorry if you have to double back at all!
step
.requires quest,10667
>>去拍卖行买这些东西
.collect 23784,1,10664,1
.collect 23793,4,10664,1
step
.requires quest,9837
.goto Shattrath City,54.6,44.2
.accept 9836 >>接任务: 麦迪文的触摸

step
.requires quest,10297
.goto Tanaris,66.0,49.6
>>当你接受任务时，确保你站着不动，下车，以便飞下时间之穴。如果你没有成功，放弃并重新接受任务。
.skipgossip
.accept 10279 >>接任务: 主宰之巢
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10279 >>交任务: 主宰之巢
.accept 10277 >>接任务: 时光之穴
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.timer 540,Wait for the Custodian to show you around the Caverns of Time
>>只需在任务给予者处等待，您仍将获得积分。这个角色扮演需要9分钟，休息一下。
.complete 10277,1
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10277 >>交任务: 时光之穴
step
.requires quest,10445
.goto Tanaris,59.6,54.2
.accept 10445 >>接任务: 永恒水瓶
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.accept 10282 >>接任务: 往日的希尔斯布莱德
step
.requires quest,10297
>>去旧希尔斯布莱德丘陵地牢。
.turnin 10282 >>交任务: 往日的希尔斯布莱德
.accept 10283 >>接任务: 塔蕾莎的计谋
step
.requires quest,10297
+纵火焚烧建筑物。
complete 10283,1
step
.requires quest,10297
>>在地下室找到萨尔。
.turnin 10283 >>交任务: 塔蕾莎的计谋
.accept 10284 >>接任务: 逃离敦霍尔德
step
.requires quest,10297
>>当地牢完成后，在任务中回合。
.turnin 10284 >>交任务: 逃离敦霍尔德
.accept 10285 >>接任务: 返回安多尔姆身边
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10285 >>交任务: 返回安多尔姆身边
.accept 10296 >>接任务: 黑色沼泽
step
.requires quest,10297
>>进入黑沼泽并完成任务。
.turnin 10296 >>交任务: 黑色沼泽
.accept 10297 >>接任务: 开启黑暗之门
step
.requires quest,10297
>>完成黑暗之门的开启，但不要完成任务。
.complete 10297,1
step
.requires quest,9837
>>前往黑沼泽并完成地牢，然后返回任务
.turnin 9836 >>交任务: 麦迪文的触摸
.accept 9837 >>接任务: 返回卡德加身边, 不要交出这个任务
step
.requires quest,10445
>>去杀死SSC的瓦什女士。
.complete 10445,1
step
.requires quest,10445
>>去暴风雨要塞杀了凯尔萨斯阳光行者。
.complete 10445,2

step
.requires quest,9831
.zone Deadwind Pass >>前往: 逆风小径
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.7
>>与大法师阿尔图鲁斯交谈，他将开启调谐链。
.accept 9824 >>接任务: 奥术扰动
.accept 9825 >>接任务: 幽灵的活动
step
#completewith wellr
.requires quest,9831
.goto Deadwind Pass,48.6,78.7
+沿着地下室的入口往下走，朝鬼魂走去
step
#sticky
#completewith PondR
.requires quest,9831
>>杀死幽灵。掠夺他们的鬼魂精华
.complete 9825,1 
step
#label wellr
.requires quest,9831
.goto Deadwind Pass,54.7,81.8,30,0
.goto Deadwind Pass,53.3,90.2
.use 24474 >>在地窖尽头的井里使用库存中的紫罗兰水晶
* This quest is underground in the cellar, make sure you're below ground when following the arrow.
.complete 9824,1 
step
#completewith next
.requires quest,9831
.goto Deadwind Pass,48.6,78.1
+沿着另一个地窖的入口走
step
#label PondR
.requires quest,9831
.goto Deadwind Pass,47.0,74.2,30,0
.goto Deadwind Pass,44.5,74.0,20,0
.goto Deadwind Pass,42.8,78.1
.use 24474 >>在水中使用库存中的紫罗兰水晶
.complete 9824,2 
step
.requires quest,9831
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
>>完成对鬼魂的掠夺，获取精华。如果你愿意的话，把你的队伍分成几个小组，回到另一个地窖去产卵
.complete 9825,1 
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.6
>>离开地窖
.turnin 9825 >>交任务: 幽灵的活动
.turnin 9824 >>交任务: 奥术扰动
.accept 9826 >>接任务: 联络达拉然
step << Alliance
#completewith next
.requires quest,9831
>>骑马返回Darkhire << !Mage
>>创建通往铁炉堡的门户 << Mage
.goto Duskwood,77.5,44.3
.fly Southshore >>飞往南岸
step << Horde
#completewith next
.requires quest,9831
>>骑马返回斯托纳德 << !Mage
>>创建通往幽暗城的门户 << Mage
.goto Swamp of Sorrows,46.0,54.7
.fly Tarren Mill >>飞往塔伦磨坊
step
.requires quest,9831
>>骑马前往达拉然郊外，与大法师塞德里克交谈。
.goto Alterac Mountains,15.6,54.6
.turnin 9826 >>交任务: 联络达拉然
.accept 9829 >>接任务: 卡德加
step
.zone Shattrath City >>前往: 沙塔斯城
.goto Shattrath City,54.7,44.4
step
.requires quest,9831
.goto Shattrath City,54.7,44.4
>>乘车前往市中心。
.turnin 9829 >>交任务: 卡德加
.accept 9831 >>接任务: 卡拉赞的钥匙
step
#aldor
.requires quest,11492
.goto Shattrath City,30.6,34.4
.accept 11481 >>接任务: 太阳之井的危机
step
#scryer
.requires quest,11492
.goto Shattrath City,54.4,80.8
.accept 11482 >>接任务: 使命的召唤
step << skip
.requires quest,11000
.goto Shattrath City,56.4,49.0
.accept 10984 >>接任务: 援助食人魔
step << skip
.requires quest,11000
.goto Shattrath City,65.2,68.0
.turnin 10984 >>交任务: 援助食人魔
.accept 10983 >>接任务: 枯瘦的莫戈多格
step
.requires quest,11000
.goto Shattrath City,65.2,68.0
.accept 10983 >>接任务: 枯瘦的莫戈多格
step
.requires quest,10095
.goto Shattrath City,50.4,45.4
.accept 10177 >>接任务: 奥金顿的麻烦
step
.requires quest,11514
.goto Shattrath City,49.2,42.6
.accept 11514 >>接任务: 维持传送门
step
.requires quest,11877
.goto Shattrath City,62.7,36.2
.accept 11877 >>接任务: 日怒攻击计划
step << Alliance
>>这个任务需要71才能完成，如果你没有准备足够的XP到71，请跳过这个任务。
.goto Shattrath City,67.2,34.0
.daily 11337,11336,11335,11338 >>接受PvP Daily
step << Horde
>>这个任务需要71才能完成，如果你没有准备足够的XP到71，请跳过这个任务。
.goto Shattrath City,67.0,56.6
.daily 11341,11340,11339,11342 >>接受PvP Daily
step
.requires quest,10667
>>去沙塔斯买一个恶魔守卫图腾。
.goto Shattrath City,64.6,70.6
.collect 30823,1,10664,1

step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30756,1,10621,1 >>杀死监督者Ripsaw
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30579,1,10623,1 >>杀死监督者Ripsaw
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.use 30576
.turnin 10621 >>交任务: 伊利达雷斩除碎片
.accept 10626 >>接任务: 夺取武器
step << Horde
.requires quest,10667
.use 30579
.goto Shadowmoon Valley,29.8,31.2
.turnin 10623 >>交任务: 伊利达雷斩除碎片
.accept 10627 >>接任务: 夺取武器
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>>杀死Makazradon
.unitscan Makazradon
.complete 10626,1
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>>杀死Morgroron
.unitscan Morgroron
.complete 10626,2
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>>杀死Makazradon
.unitscan Makazradon
.complete 10627,1
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>>杀死Morgroron
.unitscan Morgroron
.complete 10627,2
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.turnin 10626 >>交任务: 夺取武器
.accept 10662 >>接任务: 隐居的铁匠
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,29.8,31.2
.turnin 10627 >>交任务: 夺取武器
.accept 10663 >>接任务: 隐居的铁匠
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.accept 10587 >>接任务: 卡拉波训练场
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>>杀死该地区的血精灵恶魔猎人，直到任务完成。
.complete 10587,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10587 >>交任务: 卡拉波训练场
.accept 10637 >>接任务: 必要的混乱
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >>将阿扎洛斯从驱逐他的术士手中解救出来。
.complete 10637,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10637 >>交任务: 必要的混乱
.accept 10640 >>接任务: 奥图里斯
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.accept 10568 >>接任务: 巴尔里石板
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10568,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10568 >>交任务: 巴尔里石板
.accept 10571 >>接任务: 长者奥洛努
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10571,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10571 >>交任务: 长者奥洛努
.accept 10574 >>接任务: 灰舌腐蚀者
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10574,3
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10574,4
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10574,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10574,2
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10574 >>交任务: 灰舌腐蚀者
.accept 10575 >>接任务: 守望者的牢笼
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.accept 10683 >>接任务: 巴尔里石板
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10683,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10683 >>交任务: 巴尔里石板
.accept 10684 >>接任务: 长者奥洛努
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10684,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10684 >>交任务: 长者奥洛努
.accept 10685 >>接任务: 灰舌腐蚀者
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10685,2
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10685,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10685,4
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10685,3
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10685 >>交任务: 灰舌腐蚀者
.accept 10686 >>接任务: 守望者的牢笼
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10575 >>交任务: 守望者的牢笼
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10686 >>交任务: 守望者的牢笼
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.accept 10622 >>接任务: 忠诚的证明
step
.requires quest,10707
>>杀死赞德拉，他在守卫墙的顶端。
.goto Shadowmoon Valley,58.0,48.8
.complete 10622,1
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10622 >>交任务: 忠诚的证明
.accept 10628 >>接任务: 阿卡玛
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
>>去和阿卡玛谈谈。他在楼下，潜到水下，在另一个隧道里上来。
.skipgossip
.turnin 10628 >>交任务: 阿卡玛
.accept 10705 >>接任务: 先知乌达鲁
step
.requires quest,10707
>>进入Arcatraz并完成任务。
.turnin 10705 >>交任务: 先知乌达鲁
.accept 10706 >>接任务: 神秘的征兆
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10706 >>交任务: 神秘的征兆
.accept 10707 >>接任务: 阿塔玛平台
step
.requires quest,10707
.goto Shadowmoon Valley,71.4,35.4
>>找一个小组，得到愤怒之心。这个任务不要交。
.complete 10707,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.accept 10687 >>接任务: 卡拉波训练场
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>>杀死血精灵直到任务完成。
.complete 10687,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10687 >>交任务: 卡拉波训练场
.accept 10688 >>接任务: 必要的混乱
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >>将阿扎洛斯从驱逐他的术士手中解救出来。
.complete 10688,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10688 >>交任务: 必要的混乱
.accept 10689 >>接任务: 奥图里斯
step
#aldor
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10640 >>交任务: 奥图里斯
step
#scryer
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10689 >>交任务: 奥图里斯
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10641 >>接任务: 对抗军团
.accept	10668 >>接任务: 对抗伊利丹
.accept 10669 >>接任务: 扫除余孽
step
.requires quest,10649
.goto Zangarmarsh,16.4,40.4
.use 30853 >>使用Imbued银矛召唤并杀死Xeleth
.complete 10669,1
step
.requires quest,10649
.goto Shadowmoon Valley,28.6,50.6
>>杀死Lothros
.complete 10668,1
step
#sticky
.requires quest,10649
#completewith next
.collect 30850,1,10641,1 >>杀死愤怒的女祭司
step
.goto Netherstorm,41.8,22.2
.requires quest,10649
.use 30850 >>使用鲜血召唤萨塔尔阿凡达并杀死她。
.complete 10641,1
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10641 >>交任务: 对抗军团
.turnin	10668 >>交任务: 对抗伊利丹
.turnin 10669 >>交任务: 扫除余孽
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
.accept 10646 >>接任务: 伊利丹的学生
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
>>听利特鲁斯的故事
.turnin 10646 >>交任务: 伊利丹的学生
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10649 >>接任务: 恶魔名册

step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
.accept 10178 >>接任务: 寻找间谍托古恩
step << Horde
.requires quest,11506
.goto Terokkar Forest,49.8,46.6
.accept 11506 >>接任务: 奥金顿的幽魂
step << Horde
.requires quest,11506
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11506,1
step << Alliance
.requires quest,11505
.goto Terokkar Forest,55.8,53.8
.accept 11505 >>接任务: 奥金顿的幽魂
step << Alliance
.requires quest,11505
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11505,1
step
.requires quest,10164
.goto Terokkar Forest,35.0,65.2
.accept 10164 >>接任务: 一切都会变好的
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10663 >>交任务: 隐居的铁匠 << Horde
.turnin 10662 >>交任务: 隐居的铁匠 << Alliance
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.accept 10664 >>接任务: 其它的材料
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10664 >>交任务: 其它的材料
.accept 10665 >>接任务: 能源舰的热源
.accept 10666 >>接任务: 魔语辞典
step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
>>进入阴影迷宫，找到间谍托根。他在走廊尽头的第二个房间里。
.turnin 10178 >>交任务: 寻找间谍托古恩
.accept 10091 >>接任务: 灵魂装置
step
>>去暗影迷宫干掉第三个老板，大师沃皮尔。然后掠夺他以完成任务。
.complete 10666,1
step
>>去做Mechanar并掠夺守门人铁手附近的粉色盒子来完成任务。
.complete 10665,1
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10665 >>交任务: 能源舰的热源
.turnin 10666 >>交任务: 魔语辞典
.accept 10670 >>接任务: 大地之母的眼泪
.accept 10667 >>接任务: 地下的土壤
step
.requires quest,10095
.goto Terokkar Forest,40.0,72.2
>>前往环南侧的奥欣登门户室，它在锁着的门后面。
* You get the key from the last boss in Sethekk Halls if nobody else can open it for you.
.turnin 10177 >>交任务: 奥金顿的麻烦
.accept 10094 >>接任务: 鲜血法典
step
.requires quest,10095
.goto Terokkar Forest,39.4,72.7
>>去做影子迷宫并完成任务。
.turnin 10094 >>交任务: 鲜血法典
.accept 10095 >>接任务: 深入迷宫
step
.requires quest,9831
.goto Terokkar Forest,39.4,72.7
>>去暗影迷宫获得第一个关键片段。不要交任务。
.complete 9831,1
step
.requires quest,10091
.goto Terokkar Forest,39.4,72.7
>>完成暗影迷宫内的任务。不要交任务。
.complete 10091,1
step
.requires quest,10649
.goto Terokkar Forest,39.4,72.7
>>完成暗影迷宫并掠夺恶魔之书。不要交付任务。
.complete 10649,1
step
.requires quest,10667
>>去做阴影迷宫，从漩涡大师那里抢夺恶魔词典
.complete 10665,1
step
.requires quest,10095
>>杀死暗影迷宫内的穆尔。不要交任务。
.complete 10095,1
step
.requires quest,10098
.goto Terokkar Forest,44.0,65.0
.accept 10098 >>接任务: 泰罗克的传说
.accept 10097 >>接任务: 兄弟反目
step
.requires quest,10098
>>完成Sethekk Halls。不要发送任务。
.complete 10098,1
.complete 10098,2
.complete 10098,3
.complete 10097,1
.complete 10097,2
step
.requires quest,10165
.goto Terokkar Forest,39.4,58.6
.accept 10165 >>接任务: 扫除竞争者
step
.requires quest,10218
.goto Terokkar Forest,39.4,58.6
>>去地牢外接受任务。
.accept 10216 >>接任务: 安全第一
step
.requires quest,10218
>>进入法力墓穴完成任务
.complete 10216,1
.complete 10216,2
.complete 10216,3
.complete 10216,4
step
.requires quest,10218
>>在地牢内传送任务。
.turnin 10216 >>交任务: 安全第一
step
.requires quest,10218
>>接受冷冻工程师Sha'heen的任务
.accept 10218 >>接任务: 别人的烂摊子
step
.requires quest,10218
>>完成地牢内的护送。不要交付任务。
.complete 10218,1
step
.requires quest,10165
>>在法力墓穴完成任务。不要交付任务。
.complete 10165,1
step
.requires quest,10164
>>去奥切奈地穴。不要交付任务。
.complete 10164,1

step << Alliance
.requires quest,9492
.goto Hellfire Peninsula,56.6,66.6
.accept 9492 >>接任务: 扭转战局
step << Horde
.requires quest,9495
.goto Hellfire Peninsula,55.0,36.0
.accept 9495 >>接任务: 酋长的意志
step << Alliance
.requires quest,9494
.goto Hellfire Peninsula,53.8,65.6
.accept 9494,1 >>接任务: 邪能灰烬
step << Alliance
.requires quest,9493
.goto Hellfire Peninsula,56.8,62.6
.accept 9493 >>接任务: 邪部落的荣耀
step << Horde
.requires quest,9496
.goto Hellfire Peninsula,55.0,36.2
.accept 9496 >>接任务: 邪部落的荣耀
step
.requires quest,9494
.use 23735 >>去破碎的大厅杀死大术士尼瑟库斯。然后使用大术士在王座附近掉落的护身符。不要交付任务。
.complete 9494,1
step
.requires quest,10667
>>去《破碎的大厅》，杀死战使奥姆洛格。不要交任务。
.complete 10670,1
step << Alliance
.requires quest,9492
>>在破碎的大厅中杀死Warcheif Kargath的拳头。不要交任务。
.complete 9492,1
step << Horde
.requires quest,9495
>>在破碎的大厅中杀死Warcheif Kargath的拳头。不要交任务。
.complete 9495,1
step << Alliance
.requires quest,9493
>>进入破碎大厅并完成任务。不要交付任务。
.complete 9493,1
.complete 9493,2
.complete 9493,3
step << Horde
.requires quest,9496
>>进入破碎大厅并完成任务。不要交付任务。
.complete 9496,1
.complete 9496,2
.complete 9496,3

step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.accept 10173 >>接任务: 大法师的法杖
step
.requires quest,10257
.goto Netherstorm,40.8,72.6
.use 29207
>>站在火盆旁边，用魔法粉召唤Ekkorash并杀死她。
.complete 10173,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10173 >>交任务: 大法师的法杖
.accept 10300 >>接任务: 修复法杖
step
.requires quest,10257
.goto Netherstorm,33.6,54.6
>>杀死并掠夺水晶的无身保护者和维护者。
.complete 10300,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10300 >>交任务: 修复法杖
.accept 10174 >>接任务: 紫罗兰之塔的诅咒
.use 28455 >>使用职员召唤任务上缴
.turnin 10174 >>交任务: 紫罗兰之塔的诅咒, 使用法杖后, 将任务物品交给大法师瓦格斯的影像
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >>使用大法师瓦尔哥特的杖接受任务
.accept 10188 >>接任务: 克拉苏斯的魔符
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
>>找到并杀死法术绑定者玛丽亚娜，然后掠夺她以换取克拉苏斯魔咒
.unitscan Spellbinder Maryana
.complete 10188,1
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >>使用大法师瓦戈特的杖
.turnin 10188 >>交任务: 克拉苏斯的魔符
.accept 10192 >>接任务: 克拉苏斯的魔法纲要
step
.requires quest,10257
.goto Netherstorm,58.6,89.2,-1
.goto Netherstorm,57.6,89.6,-1
.goto Netherstorm,58.8,88.0,-1
>>从一个房间的房子里收集简编章节。
.collect 28472,1,10192,1
.collect 28473,1,10192,1
.collect 28474,1,10192,1
step
.requires quest,10257
.goto Netherstorm,57.4,86.2
.use 28455 >>使用大法师瓦戈特的杖
.turnin 10192 >>交任务: 克拉苏斯的魔法纲要
.accept 10301 >>接任务: 魔法纲要的防护
step
.requires quest,10257
.goto Netherstorm,56.4,79.0
>>找到并杀死魔法师玛拉泰尔，然后为奥库卢斯掠夺她
.unitscan Spellreaver Marathelle
.complete 10301,1
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
.use 28455 >>使用大法师瓦戈特的杖
.turnin 10301 >>交任务: 魔法纲要的防护
.accept 10209 >>接任务: 召唤者坎西恩的战利品
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
>>找到并杀死召唤师坎丁，然后掠夺他以换取格拉希克斯之石
.unitscan Summoner Kanthin
.complete 10209,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28455 >>使用大法师瓦戈特的杖
.turnin 10209 >>交任务: 召唤者坎西恩的战利品
.accept 10176 >>接任务: 守护者阿尔凯洛斯
step
.requires quest,10257
.goto Netherstorm,58.0,86.0
>>进入Kirin'Var村中心的紫罗兰塔，击败Ar'kelos
.complete 10176,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10176 >>交任务: 守护者阿尔凯洛斯
.accept 10256 >>接任务: 钥匙的主人
step
.requires quest,10257
.goto Netherstorm,53.0,67.0
.unitscan Apex
>>找到并杀死Apex，然后掠夺他以获得焦点
.collect 28786,1,10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28786 >>使用水晶焦点找到钥匙主人的身份
.complete 10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10256 >>交任务: 钥匙的主人
.accept 10257 >>接任务: 夺回钥石
step
.requires quest,10257
+进入Botanica，从指挥官Sarannis手中抢走Keystone。不要一次性完成任务。
.complete 10257,1
step
.requires quest,11877
.goto Netherstorm,23.4,72.4
>>为计划杀死任何太阳怒派别的敌人
.complete 11877,1
step
.requires quest,10257
.goto Netherstorm,58.3,86.4
.turnin 10256 >>交任务: 钥匙的主人
.accept 10257 >>接任务: 夺回钥石
step
.requires quest,10257
>>去做植物学并完成任务。这个任务不要交。
.complete 10257,1
step
.requires quest,10667
>>去做麦加那，在麦加诺领主卡佩蒂斯面前掠夺紫色盒子
.complete 10665,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.accept 10437 >>接任务: 毁灭的材料
step
.requires quest,10439
.goto Netherstorm,61.2,43.6
>>杀死并掠夺该地区的虚空军团和虚空战士
.complete 10437,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10437 >>交任务: 毁灭的材料
.accept 10438 >>接任务: 虚空幼龙之翼
step
.requires quest,10439
.goto Netherstorm,62.6,41.0
>>在任务列表处跳上坐骑。
.use 29778
.complete 10438,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10438 >>交任务: 虚空幼龙之翼
.accept 10439 >>接任务: 诸界吞噬者迪门修斯
step
.requires quest,10439
.goto Netherstorm,62.4,40.8
>>找到一个小组并完成任务。不要交出这个任务
.complete 10439,1
.complete 10439,2
step
.requires quest,10408
.goto Netherstorm,59.4,32.4
.accept 10339 >>接任务: 复仇军
step
.requires quest,10408
.goto Netherstorm,57.0,37.4
.complete 10339,1
.complete 10339,2
.complete 10339,3
.complete 10339,4
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10339 >>交任务: 复仇军
.accept 10384 >>接任务: 复仇军的数据
step
.requires quest,10408
.goto Netherstorm,55.8,39.9
.complete 10384,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10384 >>交任务: 复仇军的数据
.accept 10385 >>接任务: 脑部损伤几率：高
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
.complete 10385,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10385 >>交任务: 脑部损伤几率：高
.accept 10405 >>接任务: 破坏行动
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
>>杀死以太坊执政官和霸王。
.complete 10405,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10405 >>交任务: 破坏行动
.accept 10406 >>接任务: 传达信息
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
>>确保你站在召唤任务给予者的平台上，否则任务可能会出错。
.complete 10406,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10406 >>交任务: 传达信息
.accept 10408 >>接任务: 节点之王萨哈达尔
step
.requires quest,10408
.goto Netherstorm,53.4,42.0
.use 29618 >>分组完成任务。使用Protectorate Disruptor释放他。这个任务不要交。
.complete 10408,1

step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,52.6,59.0
.accept 10718 >>接任务: 灵魂的声音
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10718 >>交任务: 灵魂的声音
.accept 10614 >>接任务: 风之细语
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,75.2,60.8
.turnin 10614 >>交任务: 风之细语
.accept 10709 >>接任务: 团圆
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10709 >>交任务: 团圆
.accept 10714 >>接任务: 斯比雷之翼
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,58.0,30.0
.use 31128 >>使用哨子同时监视血腥监工和占卜师
.complete 10714,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10714 >>交任务: 斯比雷之翼
.accept 10783 >>接任务: 萨博迈恩男爵
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,42.1
.turnin 10783 >>交任务: 萨博迈恩男爵
.accept 10715 >>接任务: 进入沸土峡谷
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,47.0,44.8
>>杀戮并掠夺外壳斗牛士的腺体
.complete 10715,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10715 >>交任务: 进入沸土峡谷
.accept 10749 >>接任务: 萨博迈恩男爵的毒药
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10749 >>交任务: 萨博迈恩男爵的毒药
.accept 10720 >>接任务: 最小的生物
step << Horde
#sticky
#completewith poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.5,29.3
+使用Kodohide滚筒控制土拨鼠。使用隐形能力，跑到酒桶里毒死他们。
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.4,28.1
.complete 10720,2 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.3,26.0
.complete 10720,1 
step << Horde
#label poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.0,23.2
.complete 10720,3 
step
.requires quest,11514
.goto Blade's Edge Mountains,53.0,18.8
>>从巴什尔登陆收集法力细胞
.complete 11514,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10720 >>交任务: 最小的生物
.accept 10721 >>接任务: 格鲁洛克和野猪
step << Horde
#completewith next
.requires quest,10742
.goto Blade's Edge Mountains,60.1,47.7
+使用Huffer的哨声，等待Huffer攻击Grulloc。当他逃跑时，抢走了格鲁洛克的口袋。
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,60.9,47.8
.complete 10721,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10721 >>交任务: 格鲁洛克和野猪
.accept 10785 >>接任务: 这是个陷阱！
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10785 >>交任务: 这是个陷阱！
.accept 10723 >>接任务: 食龙者高格鲁姆
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,30.6,22.2
>>点击Gorgrom祭坛召唤Misha。等待短RP，当Gorgrom死亡时，放置你的3个恐怖图腾。
.complete 10723,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10723 >>交任务: 食龙者高格鲁姆
.accept 10724 >>接任务: 刀塔的囚犯
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.2,23.4
>>找到一个小组并完成任务
.use 31144
.complete 10724,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10724 >>交任务: 刀塔的囚犯
.accept 10742 >>接任务: 摊牌
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.0,18.4
>>找一个小组来帮助你。不要交付任务。
.use 31146
.complete 10742,1
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,55.1,24.0
>>上楼，杀死并掠夺多尔戈克，然后点击你包里的物品
.complete 10795,1 
.collect 31363,1,10797,1 
.accept 10797 >>接任务: 戈隆的信物
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
>>点击包中的物品
.turnin 10797 >>交任务: 戈隆的信物
.accept 10798 >>接任务: 拜访男爵
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.3,41.2
.turnin 10798 >>交任务: 拜访男爵
.accept 10799 >>接任务: 进入沸土峡谷
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,48.4,43.7
.complete 10799,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10799 >>交任务: 进入沸土峡谷
.accept 10800 >>接任务: 晚安，戈隆
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,60.9,47.7
>>在格鲁洛克身上使用萨布曼男爵的安眠粉。小心，因为它可以抵抗(只需再次使用)
.complete 10800,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10800 >>交任务: 晚安，戈隆
.accept 10801 >>接任务: 这是个陷阱！
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.accept 10516 >>接任务: 守备官的困境
step << Alliance
.goto Blade's Edge Mountains,42.6,59.4,40,0
.goto Blade's Edge Mountains,39.0,52.6
>>杀死德罗加姆和莫格道格，并掠夺他们的任务物品
.complete 10516,2 
.complete 10516,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10516 >>交任务: 守备官的困境
.accept 10517 >>接任务: 高尔迪姆，你完蛋了......
step << Alliance
.goto Blade's Edge Mountains,39.4,49.2
>>杀死Gorr'dim
.complete 10517,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10517 >>交任务: 高尔迪姆，你完蛋了......
.accept 10518 >>接任务: 插旗子
step << Alliance
.goto Blade's Edge Mountains,39.2,58.6,40,0
.goto Blade's Edge Mountains,46.4,74.6
>>杀死一个剑锋战士并将其掠夺为旗帜
.unitscan Bladespire Champion
.collect 30416,1,10518,1
.use 30416 >>使用塔顶的横幅引诱格伦·格鲁布诺什。为了他的头盔杀了他。
.collect 30417,1,10518,1
step << Alliance
.goto Blade's Edge Mountains,36.2,66.2
.turnin 10518 >>交任务: 插旗子
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.1
.turnin 10801 >>交任务: 这是个陷阱！
.accept 10802 >>接任务: 食龙者高格鲁姆
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,30.5,22.2
>>点击中间的祭坛，将图腾放在巨人的尸体上
.complete 10802,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
.turnin 10802 >>交任务: 食龙者高格鲁姆
.accept 10818 >>接任务: 萨博迈恩男爵的邀请
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10818 >>交任务: 萨博迈恩男爵的邀请
.accept 10805 >>接任务: 扫荡格鲁尔的巢穴
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,63.0,20.2
.complete 10805,1
.complete 10805,2
.complete 10805,3
.complete 10805,4
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10805 >>交任务: 扫荡格鲁尔的巢穴
.accept 10806 >>接任务: 摊牌
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,64.0,18.4
>>找一个小组来帮助你。不要交付任务。
.use 31808
.complete 10806,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 10995 >>接任务: 格鲁洛克的巨龙颅骨
.accept 10996 >>接任务: 玛古克的宝箱
.accept 10997 >>接任务: 戈隆的军旗
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,47.6
>>杀死格鲁洛克
.complete 10995,1
step
.requires quest,11000
.goto Blade's Edge Mountains,66.0,55.5
>>找到麦戈克，杀死他，洗劫他的箱子。
.complete 10996,1
step
.requires quest,11000
.goto Terokkar Forest,20.5,17.7
>>杀戮杀手
.complete 10997,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.turnin 10995 >>交任务: 格鲁洛克的巨龙颅骨
.turnin 10996 >>交任务: 玛古克的宝箱
.turnin 10997 >>交任务: 戈隆的军旗
.accept 10998 >>接任务: 维姆高尔的魔典
step
.requires quest,11000
.goto Blade's Edge Mountains,77.4,31.2
>>找到一个小组，完成5人小组任务。
.complete 10998,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
>>在探索中把它转过来，接下来是笨重的一个。
.turnin 10998 >>交任务: 维姆高尔的魔典
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 11000 >>接任务: 磨魂者
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,25.6
>>再次找到一个团队，完成5人团队任务。这个任务不要交。
.complete 11000,1

step
.requires quest,9738
.goto Zangarmarsh,52.2,36.0
>>进入湖中央的水下水库
.accept 9738 >>接任务: 失踪的同伴
step
.requires quest,9763
.goto Zangarmarsh,52.2,36.0
>>进入湖中央的水下水库
.accept 9763 >>接任务: 督军的末日
step
.requires quest,9738
>>在“从笔”中完成这两个步骤
.complete 9738,3
.complete 9738,2
step
.requires quest,9738
>>在Underbog完成这两个步骤。不要交付任务。
.complete 9738,1
.complete 9738,4
step
.requires quest,9763
>>杀死Steamvaults的最后一个老板。不要交付任务。
.complete 9763,3
step
.requires quest,10667
>>去执行Steamfaults，杀死Hydromacer Thespia。不要交任务。
.complete 10667,1

step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.reputation 1015,exalted,<0,1
>>这个问题需要提升。
.accept 11107 >>接任务: 莫格霍尔大王
step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.turnin 11107 >>交任务: 莫格霍尔大王
.accept 11108 >>接任务: 伊利丹·怒风大人
step
.requires quest,11108
>>等待超长RP。不要在这个任务中交出。 
.complete 11108,1
step << Horde
.requires quest,9937
.goto Nagrand,55.7,37.9
.accept 9935 >>接任务: 通缉：巫婆吉塞尔达
.accept 9939 >>接任务: 通缉：顾问佐尔布
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.accept 9936 >>接任务: 通缉：巫婆吉塞尔达
.accept 9940 >>接任务: 通缉：顾问佐尔布
step << Horde
.requires quest,9937
.goto Nagrand,71.2,82.2
>>杀死该地区的克伦族吉塞尔达和15名基尔索洛特工
.complete 9935,1
.complete 9935,2
step << Alliance
.requires quest,9938
.goto Nagrand,71.2,82.2
>>杀死该地区的克伦族吉塞尔达和15名基尔索洛特工
.complete 9936,1
.complete 9936,2
step << Horde
.requires quest,9937
.goto Nagrand,46.0,19.0
>>杀死该地区的顾问佐尔布和战争食人魔
.complete 9939,1
.complete 9939,2
.complete 9939,3
step << Alliance
.requires quest,9938
.goto Nagrand,46.0,19.0
>>杀死该地区的顾问佐尔布和战争食人魔
.complete 9940,1
.complete 9940,2
.complete 9940,3
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.turnin 9936 >>交任务: 通缉：巫婆吉塞尔达
.turnin 9940 >>交任务: 通缉：顾问佐尔布
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.turnin 9935 >>交任务: 通缉：巫婆吉塞尔达
.turnin 9939 >>交任务: 通缉：顾问佐尔布
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.accept 9937 >>接任务: 通缉：饥饿者杜恩
step << Alliance
.requires quest,9938
.goto Nagrand,55.8,37.8
.accept 9938 >>接任务: 通缉：饥饿者杜恩
step << Horde
.requires quest,9937
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>>找到并杀死饥饿者杜伦，他在巨大的水晶周围巡逻。完成此任务后不要交上来。
.unitscan Durn the Hungerer
.complete 9937,1
step << Alliance
.requires quest,9938
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>>找到并杀死饥饿者杜伦，他在巨大的水晶周围巡逻。完成此任务后不要交上来。
.unitscan Durn the Hungerer
.complete 9938,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
>>这个任务链的末端是精英，你可能需要帮助。
.accept 9818 >>接任务: 地下的滋扰
step
.requires quest,9853
.goto Nagrand,61.0,22.0
>>与地球元素对话
.skipgossip
.complete 9818,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >>交任务: 地下的滋扰
.accept 9819 >>接任务: 被折磨的地灵
step
.requires quest,9853
.goto Nagrand,67.0,32.0
>>杀死该地区被扭曲的大地精灵
.complete 9819,1 
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >>交任务: 被折磨的地灵
.accept 9821 >>接任务: 吞食诅咒
step
.requires quest,9853
.goto Nagrand,56.0,52.0
>>杀死并掠夺愤怒的破碎者
.collect 24473,15,9821,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9821 >>交任务: 吞食诅咒
.accept 9849 >>接任务: 打碎外壳
step
.requires quest,9853
.goto Nagrand,29.0,67.4,40,0
.goto Nagrand,32.0,80.6,40,0
.goto Nagrand,41.0,82.6,40,0
.use 24501 >>在破碎的隆隆声上使用戈尔多格的巨石，然后杀死产卵的小黄人
.complete 9849,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9849 >>交任务: 打碎外壳
.accept 9853 >>接任务: 侵占者古罗克
step
.requires quest,9853
.goto Nagrand,29.0,24.8
>>杀死并掠夺侵略者古洛克。完成此任务后不要交上来。
.collect 24503,1,9853,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>这个任务链是精英，你可能需要帮助。
.accept 9962 >>接任务: 鲜血竞技场：断蹄
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场击败老板
.complete 9962,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9962 >>交任务: 鲜血竞技场：断蹄
.accept 9967 >>接任务: 鲜血竞技场：蓝色兄弟
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场击败老板
.complete 9967,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9967 >>交任务: 鲜血竞技场：蓝色兄弟
.accept 9970 >>接任务: 鲜血竞技场：裂石之王洛卡达尔
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场击败老板
.complete 9970,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9970 >>交任务: 鲜血竞技场：裂石之王洛卡达尔
.accept 9972 >>接任务: 鲜血竞技场：瑟克拉加斯
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场击败老板
.complete 9972,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9972 >>交任务: 鲜血竞技场：瑟克拉加斯
.accept 9973 >>接任务: 鲜血竞技场：战槌勇士
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场击败老板
.complete 9973,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9973 >>交任务: 鲜血竞技场：战槌勇士
.accept 9977 >>接任务: 鲜血竞技场：终极挑战
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>>进入竞技场，击败老板。完成任务后不要交任务！
.complete 9977,1
step
#sticky
+以下任务是每日任务。因为你在角色身上完成了很多普通任务。

step
.requires quest,11369
.isOnQuest 11369
>>进入《植物学》的英雄难度，击败《黑追踪者》。完成任务后不要提交。
.complete 11369,1
step
.requires quest,11384
.isOnQuest 11384
>>进入Underbog的英雄难度并击败曲分裂。完成任务后不要提交。
.complete 11384,1
step
.requires quest,11382
.isOnQuest 11382
>>进入英雄难度的黑色沼泽，击败埃昂纳斯。完成任务后不要提交。
.complete 11382,1
step
.requires quest,11363
.isOnQuest 11363
>>进入英雄难度的破碎大厅，击败酋长卡加特·刀锋拳。完成任务后不要提交。
.complete 11363,1
step
.requires quest,11362
.isOnQuest 11362
>>以英雄难度进入血炉，击败破坏者科利丹。完成任务后不要提交。
.complete 11362,1
step
.requires quest,11375
.isOnQuest 11375
>>在英雄难度上进入暗影迷宫并击败穆尔。完成任务后不要提交。
.complete 11375,1
step
.requires quest,11354
.isOnQuest 11354
>>进入地狱火堡垒，挑战英雄难度，击败纳桑。完成任务后不要提交。
.complete 11354,1
step
.requires quest,11386
.isOnQuest 11386
>>进入英雄难度的Mechanar，击败计算器上的Pathaleon。完成任务后不要提交。
.complete 11386,1
step
.requires quest,11373
.isOnQuest 11373
>>以英雄难度进入玛纳墓穴，击败纳克西斯王子沙法尔。完成任务后不要提交。
.complete 11373,1
step
.requires quest,11378
.isOnQuest 11378
>>以英雄难度进入旧希尔斯布莱德丘陵，击败时代猎人。完成任务后不要提交。
.complete 11378,1
step
.requires quest,11374
.isOnQuest 11374
>>进入奥切奈地穴，挑战英勇难度，击败马拉达尔酋长。完成任务后不要提交。
.complete 11374,1
step
.requires quest,11372
.isOnQuest 11372
>>进入塞塞克大厅(Sethekk Halls)，挑战英雄难度，击败塔龙国王艾吉斯(Talon King Ikiss)。完成任务后不要提交。
.complete 11372,1
step
.requires quest,11368
.isOnQuest 11368
>>进入《奴隶笔》的英雄难度，击败夸美兰。完成任务后不要提交。
.complete 11368,1
step
.requires quest,11388
.isOnQuest 11388
>>进入《魔兽世界》中的英雄难度，击败先驱者Skyriss。完成任务后不要提交。
.complete 11388,1
step
.requires quest,11370
.isOnQuest 11370
>>进入《蒸汽断层》，挑战英雄难度，击败军阀卡利思雷什。完成任务后不要提交。
.complete 11370,1

step
.requires quest,11377
.goto Shattrath City,61.6,15.8
.daily 11380,11377,11381,11379 >>每天接受烹饪
step
.requires quest,11377
.isOnQuest 11380
.goto Netherstorm,46.0,11.0
>>在荷兰风暴的生态穹顶收集法力浆果。完成任务后不要提交。
.complete 11380,1
step
.requires quest,11377
.isOnQuest 11377
>>从围绕斯凯蒂斯飞行的怪物卡里里那里收集一只巨大的卡里里翅膀
.goto Terokkar Forest,61.2,74.2,20,0
.goto Terokkar Forest,69.8,75.0,20,0
.goto Terokkar Forest,74.6,88.4,20,0
.collect 33838,1,11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>>烹饪3个曲汉堡，或从拍卖行购买。
.collect 27659,3,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>>烹饪3个曲汉堡，或从拍卖行购买。
.collect 27659,3,11377,1
step
.requires quest,11377
.isOnQuest 11377
.use 33837 >>使用您的烹饪锅，并在您的库存中添加配料。完成任务后不要提交。
.complete 11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11381
.goto Stormwind City,53.6,59.6
>>烹饪4个烤羊蹄，或从拍卖行购买。
.collect 27658,4,11381,1
step << Horde
.requires quest,11377
.isOnQuest 11381
.goto Orgrimmar,55.6,62.8
>>烹饪4个烤羊蹄，或从拍卖行购买。
.collect 27658,4,11381,1
step
.requires quest,11377
.isOnQuest 11381
.goto Nagrand,26.0,59.5
.use 33851 >>站在祖先的场地内，用你的烹饪锅和你库存中的配料。完成任务后不要提交。
.complete 11381,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>>煮2条莫克纳撒尔排骨和一条松脆的蛇，或者从拍卖行买下来。
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>>煮2条莫克纳撒尔排骨和一条松脆的蛇，或者从拍卖行买下来。
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step
.requires quest,11377
.isOnQuest 11377
.goto Blade's Edge Mountains,29.6,83.4
.use 33837 >>站在一个死了的深渊火焰枪上，用你的烹饪锅和你的库存中的配料。完成任务后不要提交。
.complete 11377,1

step
.requires quest,11387
.isOnQuest 11389
>>进入奥克拉兹，击败5名奥克拉兹哨兵。完成任务后不要提交。
.complete 11389,1
step
.requires quest,11387
.isOnQuest 11371
>>进入Steamvault，击败14名Coilfang Myrmidons。完成任务后不要提交。
.complete 11371,1
step
.requires quest,11387
.isOnQuest 11376
>>进入暗影迷宫，击败3名恶意教练。完成任务后不要提交。
.complete 11376,1
step
.requires quest,11387
.isOnQuest 11383
>>进入黑沼泽，击败4个裂谷领主。完成任务后不要提交。
.complete 11383,1
step
.requires quest,11387
.isOnQuest 11364
>>进入破碎大厅，击败4名破碎手百夫长。完成任务后不要提交。
.complete 11364,1
step
.requires quest,11387
.isOnQuest 11385
>>进入《植物学》，击败6名阳光卫士频道。完成任务后不要提交。
.complete 11385,1
step
.requires quest,11387
.isOnQuest 11387
>>进入Mechanar并击败5个风暴锻造毁灭者。完成任务后不要提交。
.complete 11387,1

step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.accept 11523 >>接任务: 激活结界！
step
.requires quest,11525
.goto Isle of Quel'Danas,47.2,30.6
.accept 11525 >>接任务: 转化更多奥术守卫
step
.requires quest,11521
.goto Isle of Quel'Danas,51.5,32.5
.accept 11521 >>接任务: 继续寻根
step
.requires quest,11546
.goto Isle of Quel'Danas,51.5,32.5
.accept 11546 >>接任务: 开始营业
step
.requires quest,11541
.goto Isle of Quel'Danas,53.8,34.2
.accept 11541 >>接任务: 解救绿鳃奴隶
step
.requires quest,11533
.goto Isle of Quel'Danas,47.6,35.2
.accept 11533 >>接任务: 继续空袭
step
.requires quest,11547
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >>接任务: 魔网能量线的读数
step
.requires quest,11536
.goto Isle of Quel'Danas,50.4,40.6
.accept 11536 >>接任务: 不要停下......
step
.requires quest,11544
.goto Isle of Quel'Danas,50.6,40.8
.accept 11544 >>接任务: 阿塔玛军备
step
.requires quest,11542
.goto Isle of Quel'Danas,50.6,39.0
.accept 11542 >>接任务: 拦截援军
step
.requires quest,11539
.goto Isle of Quel'Danas,49.4,40.2
.accept 11539 >>接任务: 占领港口
step
.requires quest,11536
.goto Isle of Quel'Danas,65.0,48.0
>>深松矿石的敞口箱子
.collect 34479,3
step
.requires quest,11541
.goto Isle of Quel'Danas,60.9,51.6
.use 34483 >>为穆洛克控制之球杀死黑松树警报器，并将其用于格林吉尔奴隶。完成任务后不要提交。
.complete 11541,1
step
.requires quest,11547
.goto Isle of Quel'Danas,61.2,62.5
.use 34533 >>使用神龛附近的星际漫游者水晶。完成任务后不要提交。
.complete 11547,2
step
.requires quest,11547
.goto Isle of Quel'Danas,48.4,45.5
.use 34533 >>使用入口附近的星际漫游者水晶。
.complete 11547,1
step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.use 34338 >>使用法力残留物为基地周围的任何守卫提供能量
.complete 11523,1
step
.requires quest,11539
.goto Isle of Quel'Danas,45.6,41.4
>>杀死该区域周围的Dawnblade敌人。完成任务后不要提交。
.complete 11539,1
.complete 11539,2
.complete 11539,3
step
.requires quest,11547
.goto Isle of Quel'Danas,42.0,35.2
.use 34533 >>使用血晶附近的星际魔术师水晶。
.complete 11547,3
step
.requires quest,11533
.goto Isle of Quel'Danas,48.4,25.2
.use 34475 >>与Ayren Cloudbreaker交谈，飞越亲爱的疤痕，使用奥术冲锋杀死敌人
.complete 11533,1
.complete 11533,2
.complete 11533,3
step
.requires quest,11542
.skipgossip
>>与Ayren Cloudbreaker交谈，进行飞越船只的飞行。
.goto Isle of Quel'Danas,48.4,25.2
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
.use 34489 >>在每艘船的船帆上洒上燃烧的油
.complete 11542,1
.complete 11542,2
.complete 11542,3
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
>>着陆时杀死道恩布拉德预备队。完成任务后不要提交。
.complete 11542,4
step
.requires quest,11546
.goto Isle of Quel'Danas,38.0,29.7
>>掠夺该地区的血莓。
.complete 11546,1
step
.requires quest,11523
.goto Isle of Quel'Danas,44.8,26.4,40,0
.goto Isle of Quel'Danas,40.6,30.4,40,0
.goto Isle of Quel'Danas,35.6,35.0
>>为法力残留物杀死穷凶极恶的敌人
.collect 34338,4,11523,1
step
.requires quest,11525
.goto Isle of Quel'Danas,43.8,26.6,40,0
.goto Isle of Quel'Danas,37.4,32.4,40,0
.goto Isle of Quel'Danas,34.6,38.8
.use 34368 >>击败反复无常的哨兵并替换其核心
.complete 11525,1
step
#aldor
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11481 >>交任务: 太阳之井的危机
.accept 11488 >>接任务: 魔导师平台
step
#scryer
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11482 >>交任务: 使命的召唤
.accept 11488 >>接任务: 魔导师平台
step
.requires quest,11492
>>进入魔术师露台
.turnin 11488 >>交任务: 魔导师平台
.accept 11490 >>接任务: 占星球
step
.requires quest,11492
>>在圣珠上的魔法师露台完成任务。
.complete 11490,1
step
.requires quest,11492
>>将任务交给实例内部。
.turnin 11490 >>交任务: 占星球
.accept 11492 >>接任务: 大难不死
step
.requires quest,11492
>>在实例内杀死Kael'thas。不要交任务。
.complete 11492,1
step
.requires quest,11544
.goto Shadowmoon Valley,69.5,39.6
>>在阿塔玛露台周围杀死兽人，获得5件阿塔玛武器。
.collect 34500,5,11544,1
step
.requires quest,11544
.goto Isle of Quel'Danas,50.1,40.5
.use 34500 >>站在Hauthaa铁砧旁边时，使用Ata'mal武器。完成任务后不要提交。
.complete 11544,1
step
.requires quest,11521
.goto Terokkar Forest,58.1,13.2
>>杀死Razorthorn Flayers获取腺体
.collect 34255,1,11521,1
step
.requires quest,11521
.use 34255 >>使用剃须刀掠夺者的腺体来控制它，并露出根部供你挖掘。完成任务后不要提交。
.complete 11521,1

step
.requires quest,11020
.goto Shadowmoon Valley,66.0,86.4
.accept 11020 >>接任务: 缓慢的死亡
step
.requires quest,11020
.goto Shadowmoon Valley,45.8,61.5,20
>>杀死附近的Felfire Diemetradon获取Fel腺体。
.collect 32502,12,11020,1
step
.requires quest,11020
.goto Shadowmoon Valley,66.0,82.1,30,0
.goto Shadowmoon Valley,76.3,85.4,30,0
.use 32503>>用龙嘴狮附近的亚齐尔羊肉毒死它们。完成任务后不要提交。
.complete 11020,1

step
.requires quest,11035
.goto Shadowmoon Valley,66.0,86.4
.accept 11035 >>接任务: 危险的天空
step
.requires quest,11035
.goto Shadowmoon Valley,72.3,64.3
>>为了荷兰之翼遗迹杀死龙嘴运输车。完成任务后不要提交。
.complete 11035,1

step
.requires quest,11515
.goto Hellfire Peninsula,58.2,17.6
.accept 11515 >>接任务: 血债血偿
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.accept 11516 >>接任务: 轰炸传送门
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.use 34253 >>召唤带着嘶嘶灰烬的活火炬，将其靠近火元素，为其供电。当它完成时，把它带到恶魔之门。
.complete 11516,1
step
.requires quest,11515
.use 34257 >>为恶魔之血杀死愤怒先驱，然后对恶魔之血提升者使用恶魔虹吸。完成任务后不要提交。
.complete 11515,1
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6
.accept 11502 >>接任务: 保卫哈兰
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6,20,0
>>杀死哈拉周围的敌人派系守卫或玩家。完成任务后不要提交。
.complete 11502,1

step << Horde
.requires quest,11503
.goto Nagrand,52.8,36.0
.accept 11503 >>接任务: 新仇旧怨
step << Horde
.requires quest,11503
.goto Nagrand,55.8,73.6,20,0
>>杀死哈拉周围的敌人派系守卫或玩家。完成任务后不要提交。
.complete 11503,1
step
.requires quest,11008
.goto Terokkar Forest,64.6,66.6
.accept 11008 >>接任务: 轰炸斯克提斯
step
.requires quest,11008
.goto Terokkar Forest,70.4,80.1,10,0
.goto Terokkar Forest,74.7,88.3,10,0
.goto Terokkar Forest,67.6,86.0,10,0
.goto Terokkar Forest,62.6,80.8,10,0
.use 32406 >>在您上山时，在您的库存中使用爆破费用来摧毁该区域结构顶部的鸡蛋。完成任务后不要提交。
.complete 11008,1
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name RestedXP 准备的 经验 总数
#hidewindow
step
>>到目前为止，您准备的经验是：
.showtotalxp
>>在角色可能的总数中：
.showtotalxp 1
>>对于任务日志任务，请将物品放入包中，以便所有任务都标记为“(完成)”。
>>-
.show25quests >>单击此处查看角色的25个最佳任务列表
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name 发布准备指南
step
#sticky
+这本指南是关于做任务链，可以很容易地拿起，并在启动时交给，而不需要将它们保存在您的任务日志中。如果指南的这一章说要交东西，那就交吧！没关系，你不会在实验中失败。只是不要交任何它没有告诉你的任务，这些是我们正在保存的任务。他们将按照“交车指南”交车。
step
.reputation 989,revered >>与时间守护者一起获得尊敬。
>>垃圾洞时间地牢直到被尊敬。这是一个必须做的步骤，除非你有一个术士可以在发射时召唤你去洞穴。
step << Horde
.reputation 729,exalted >>与霜狼氏族一起升华
.goto Alterac Mountains,62.2,58.9
>>这一步需要在发射日召唤奥特兰克山脉。如果没有，请跳过。我们正在提交AV小饰物升级任务。如果你已经提交了令人尊敬的升级任务，那么至少要达到令人尊敬或赞叹的程度。尊敬和崇高给予同样的经验。这一经验是由奥特兰克山谷的普华永道获得的。
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7161 >>接任务: 试炼场
.turnin 7161 >>交任务: 试炼场
step << Alliance
.reputation 730,exalted >>与风暴守卫一起升华
.goto Alterac Mountains,39.6,81.2
>>这一步需要在发射日召唤奥特兰克山脉。如果没有，请跳过。我们正在提交AV小饰物升级任务。如果你已经提交了令人尊敬的升级任务，那么至少要达到令人尊敬或赞叹的程度。尊敬和崇高给予同样的经验。这一经验是由奥特兰克山谷的普华永道获得的。
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7162 >>接任务: 试炼场
.turnin 7162 >>交任务: 试炼场
step
.reputation 967,exalted >>《紫罗兰之眼》让你神采飞扬。
>>我们正在进行卡拉环升级任务。至少获得荣誉，所有过去获得荣誉的营业额都是相同的经验。如果你已经提交了戒指升级任务，那么就提升一个代表级别。你可以累积多次重复奖励以获得更多经验！通过运行Karazhan获得此重复次数。
step
.reputation 990,exalted >>用沙子的尺度来提升自己。
>>我们正在进行Hyjal环升级任务。至少获得荣誉，所有过去获得荣誉的营业额都是相同的经验。如果你已经提交了戒指升级任务，那么就提升一个代表级别。通过运行Mount Hyjal获得此重复次数。
step << Horde
.goto Hellfire Peninsula,87.4,48.2
.accept 10289 >>接任务: 萨尔玛之旅
step << Horde
#completewith next
.goto Hellfire Peninsula,55.8,36.8
.fly Thrallmar >>再次与NPC对话，飞往萨尔玛
step << Horde
.goto Hellfire Peninsula,55.8,36.8
.turnin 10289 >>交任务: 萨尔玛之旅
.accept 10291 >>接任务: 向纳兹格雷尔报到
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10291 >>交任务: 向纳兹格雷尔报到
.accept 10121 >>接任务: 消灭燃烧军团
step << Horde
>>跑出城镇
.goto Hellfire Peninsula,58.0,41.2
.turnin 10121 >>交任务: 消灭燃烧军团
.accept 10123 >>接任务: 魔火峡谷
step << Horde
.goto Hellfire Peninsula,63.0,38.0
>>杀死该地区的火焰行者小鬼、地狱战警和恐怖召唤者
.complete 10123,1
.complete 10123,2
.complete 10123,3
step << Horde
.goto Hellfire Peninsula,58.0,41.2
.turnin 10123 >>交任务: 魔火峡谷
.accept 10124 >>接任务: 机甲残骸
step << Horde
.goto Hellfire Peninsula,65.8,43.6
.turnin 10124 >>交任务: 机甲残骸
.accept 10208 >>接任务: 阻断援军
step << Horde
#sticky
#label disrupttransp
.goto Hellfire Peninsula,70.8,45.1
>>一旦你得到4块符石，使用托阿奇的初级技能来禁用军团运输者。
.complete 10208,1 
step << Horde
#label disrupttransp
.goto Hellfire Peninsula,74.1,38.9
>>一旦你再收集4块符石，使用To'arch's Primers来禁用军团运输者。
.complete 10208,2 
step << Horde
#requires disrupttransp
.goto Hellfire Peninsula,65.9,43.6
.turnin 10208 >>交任务: 阻断援军
.accept 10129 >>接任务: 任务：穆尔凯斯和沙德拉兹之门
step << Horde
.goto Hellfire Peninsula,78.0,51.2
.complete 10129,2 
step << Horde
.goto Hellfire Peninsula,78.2,47.7
.complete 10129,1 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10129 >>交任务: 任务：穆尔凯斯和沙德拉兹之门
.accept 10162 >>接任务: 任务：地狱岩床
.accept 10388 >>接任务: 返回萨尔玛
step << Horde
>>当你飞越深渊大陆架时，使用52区特殊炸弹来完成这个任务。
.complete 10162,3 
.complete 10162,1 
.complete 10162,2 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10162 >>交任务: 任务：地狱岩床
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10388 >>交任务: 返回萨尔玛
.accept 9400 >>接任务: 刺客
step << Horde
.goto Hellfire Peninsula,33.6,43.6
>>飞向兽人尸体
.complete 9400,1
step << Horde
.goto Hellfire Peninsula,33.6,43.6
.turnin 9400 >>交任务: 刺客
step << Alliance
.goto Hellfire Peninsula,87.4,50.7
.accept 10288 >>接任务: 抵达外域
step << Alliance
.goto Hellfire Peninsula,87.4,52.4
.turnin 10288 >>交任务: 抵达外域
.accept 10140 >>接任务: 荣耀堡之旅
step << Alliance
.goto Hellfire Peninsula,54.7,62.8
>>要么再和飞行管理员谈谈，要么自己飞到荣誉舱
.skipgossip
.turnin 10140 >>交任务: 荣耀堡之旅
.accept 10254 >>接任务: 指挥官达纳斯
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10254 >>接任务: 指挥官达纳斯
.accept 10141 >>接任务: 重生的军团
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10141 >>交任务: 重生的军团
.accept 10142 >>接任务: 苦痛之路
step << Alliance
.goto Hellfire Peninsula,67.0,58.6
>>消灭该地区的恶魔
.complete 10142,1 
.complete 10142,2 
.complete 10142,3 
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10142 >>交任务: 苦痛之路
.accept 10143 >>接任务: 远征军岗哨
step << Alliance
.goto Hellfire Peninsula,56.6,66.5
.accept 10047 >>接任务: 荣耀之路
step << Alliance
.goto Hellfire Peninsula,64.5,49.6,10,0
.goto Hellfire Peninsula,54.6,50.4,10,0
.use 25889
>>在荣耀之路发现的被践踏的骷髅上使用德莱尼圣水。
.complete 10047,1
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10047 >>交任务: 荣耀之路
step << Alliance
.goto Hellfire Peninsula,23.0,40.4
>>前往Hellfire半岛西部
.accept 9390 >>接任务: 寻找瑟丹
step << Alliance
.goto Hellfire Peninsula,26.8,37.6
.turnin 9390 >>交任务: 寻找瑟丹
step << Alliance
.reputation 946,friendly >>与荣誉保持友好，这样您就可以在发布时提交获得米伦的信任。通过垃圾地牢做到这一点，以减少任务损失。
step << Horde
.goto Zangarmarsh,85.2,54.6
.accept 9774 >>接任务: 厚重多头蛇鳞片
step << Horde
.goto Zangarmarsh,84.1,39.0,80,0
.goto Zangarmarsh,85.2,54.6,80,0
.goto Zangarmarsh,80.1,34.3,80,0
.goto Zangarmarsh,81.0,41.3
>>杀死该地区的九头蛇并掠夺其鳞片。
*They do NOT share spawns with the Giants.
.complete 9774,1
step << Horde
.goto Zangarmarsh,85.2,54.6
.turnin 9774 >>交任务: 厚重多头蛇鳞片
step
.goto Zangarmarsh,78.4,62.0
.accept 9716 >>接任务: 暗泽湖的异常
step
.goto Zangarmarsh,70.8,81.3
.complete 9716,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9716 >>交任务: 暗泽湖的异常
.accept 9718 >>接任务: 乌鸦的飞翔
step
.goto Zangarmarsh,78.4,62.0
.use 25465 >>使用风暴护身符，等待任务完成。需要2分30秒，稍作伸展休息：)
.complete 9718,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9718 >>交任务: 乌鸦的飞翔
.accept 9720 >>接任务: 恢复平衡
step << skip
#label schemmy
.itemcount 24330,1
.use 24330 >>使用包中的排水示意图接受任务
.accept 9731 >>接任务: 抽水泵结构图
step
.goto Zangarmarsh,70.6,80.3
.use 24355 >>使用铁藤种子禁用Umbrafen Lake的控制台。
.complete 9720,1
step
.goto Zangarmarsh,25.2,43.6
.use 24355 >>使用铁藤种子禁用马歇尔莱克的控制台。
.complete 9720,2
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,50.4,40.9
>>探索足够深的排水沟以完成任务。
.complete 9731,1
step
.goto Zangarmarsh,62.0,40.8
.use 24355 >>使用铁藤种子在蛇湖禁用。
.complete 9720,3
step
.goto Zangarmarsh,63.1,64.1
.use 24355 >>使用铁藤种子在泻湖禁用。
.complete 9720,4
step
.goto Zangarmarsh,78.4,62.0
.turnin 9720 >>交任务: 恢复平衡
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,78.4,62.0
.turnin 9731 >>交任务: 抽水泵结构图
step
#label thickysticky
.goto Terokkar Forest,44.4,26.2 
.accept 9968 >>接任务: 奇怪的能量
.accept 9971 >>接任务: 树林中的线索
step
#sticky
#requires thickysticky
.goto Terokkar Forest,45.1,21.8,40,0
.goto Terokkar Forest,44.4,30.8,40,0
.goto Terokkar Forest,45.1,21.8
>>杀死Terromoth和Vicious Terromotth以获取样本。
*Terromoths spawn on the south side, Vicious Terrormoths spawn north in the village.
.complete 9968,2
.complete 9968,1
step
.goto Terokkar Forest,45.1,21.8
>>与客栈地板上的奇怪物体互动。
.complete 9971,1
step
#requires thickysticky
.goto Terokkar Forest,44.4,26.2 
.turnin 9968 >>交任务: 奇怪的能量
.turnin 9971 >>交任务: 树林中的线索

step
.goto Terokkar Forest,44.4,26.2 
.accept 9978 >>接任务: 不择手段
step
.goto Terokkar Forest,38.3,26.6,80,0
.goto Terokkar Forest,50.3,29.0,80,0
.goto Terokkar Forest,38.3,26.6
.line Terokkar Forest,38.3,26.6,40.6,25.5,47.2,27.0,50.3,29.0
.skipgossip
>>在路上找到Empoor，和他战斗，说服他告诉你他知道什么。
.unitscan Empoor
.turnin 9978 >>交任务: 不择手段
.accept 9979 >>接任务: 星界商人拉斯莱
step << Horde
.goto Terokkar Forest,48.8,45.6
.accept 10000 >>接任务: 不受欢迎者
step << Horde
.goto Terokkar Forest,67.4,51.8
>>杀死该地区的翘皮狮子
.complete 10000,1 
step << Horde
.goto Terokkar Forest,63.4,42.6
.turnin 10000 >>交任务: 不受欢迎者
step << Alliance
.goto Terokkar Forest,58.2,54.8
.accept 9998 >>接任务: 野蛮的邻居
step << Alliance
.goto Terokkar Forest,67.4,51.8
>>杀死该地区的翘皮狮子
.complete 9998,1 
step << Alliance
.goto Terokkar Forest,69.6,44.2
.turnin 9998 >>交任务: 野蛮的邻居
step
.goto Shattrath City,72.4,31.6
.turnin 9979 >>交任务: 星界商人拉斯莱
.accept 10112 >>接任务: 私人事务
step
.goto Terokkar Forest,31.6,42.6
>>杀死并掠夺斯基提亚暴徒的赃物。
.complete 10112,1
step
.goto Shattrath City,72.2,30.9
.turnin 10112 >>交任务: 私人事务
step
.goto Shattrath City,72.2,30.9
.accept 9990 >>接任务: 调查图雷姆
step
>>在废墟中收集密封的盒子。
.goto Terokkar Forest,54.0,30.0
.complete 9990,1
step << Horde
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >>交任务: 调查图雷姆
.accept 9995 >>接任务: 这些东西是什么？
step << Alliance
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >>交任务: 调查图雷姆
.accept 9994 >>接任务: 这些东西是什么？
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 9995 >>交任务: 这些东西是什么？
.accept 10448 >>接任务: 向裂石营地报到
step << Horde
.goto Terokkar Forest,50.0,44.8
.accept 9993 >>接任务: 奥雷巴油
step << Horde
#sticky
#completewith endofseedoil
#label seedoil
>>在特罗卡森林的树木周围收集木兰籽。
* They look like little blue crystals.
.complete 9993,1
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 10448 >>交任务: 向裂石营地报到
.accept 9997 >>接任务: 攻击火翼岗哨
step << Alliance
.goto Terokkar Forest,57.0,53.6
.turnin 9994 >>交任务: 这些东西是什么？
.accept 10444 >>接任务: 奥蕾莉亚岗哨
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 10444 >>交任务: 奥蕾莉亚岗哨
.accept 9996 >>接任务: 攻击火翼岗哨
step << Alliance
.goto Terokkar Forest,71.6,37.8
>>杀死火翼防御者、血矮人和术士。
.complete 9996,1
.complete 9996,2
.complete 9996,3
step << Horde
.goto Terokkar Forest,71.6,37.8
>>杀死火翼防御者、血矮人和术士。
.complete 9997,1
.complete 9997,2
.complete 9997,3
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 9996 >>交任务: 攻击火翼岗哨
.accept 10446 >>接任务: 终极密码
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 9997 >>交任务: 攻击火翼岗哨
.accept 10447 >>接任务: 终极密码
step
#sticky
#completewith endofseedoil
.goto Terokkar Forest,73.6,36.0
>>飞到塔顶
step << Alliance
.goto Terokkar Forest,73.8,35.8
>>杀掉莎斯·沃尔登以获得最终密码。
.collect 29912,1,10446,1
step << Horde
.goto Terokkar Forest,73.8,35.8
>>杀掉莎斯·沃尔登以获得最终密码。
.collect 29912,1,10447,1
step << Horde
.goto Terokkar Forest,71.3,37.4
.use 29912 >>点击Firewing Point中心的柱子
.complete 10447,1
step << Alliance
.goto Terokkar Forest,71.3,37.4
.use 29912 >>点击Firewing Point中心的柱子
.complete 10446,1
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 10447 >>交任务: 终极密码
step << Alliance
.goto Terokkar Forest,57.0,53.5
.turnin 10446 >>交任务: 终极密码
step << Horde
#requires seedoil
.goto Terokkar Forest,50.1,44.9
.turnin 9993 >>交任务: 奥雷巴油
step
#label endofseedoil
.goto Terokkar Forest,49.8,76.2
.accept 10920 >>接任务: 复仇之战
step
.goto Terokkar Forest,51.8,78.8,30,0
.goto Terokkar Forest,55.6,61.2
>>沿着骨废料的边缘杀死恐惧方寡妇。
.complete 10920,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10920 >>交任务: 复仇之战
.accept 10921 >>接任务: 泰罗卡狼蛛
step
.goto Terokkar Forest,54.0,81.6
>>杀死特洛克卡兰图拉。这是一个精英任务，你可能需要帮助。
.complete 10921,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10921 >>交任务: 泰罗卡狼蛛
step
.goto Terokkar Forest,35.0,65.2
>>在奥切奈地穴入口附近找到哈雷。
.accept 10227 >>接任务: 我看到了死德莱尼人
step
.goto Terokkar Forest,35.1,66.0
.turnin 10227 >>交任务: 我看到了死德莱尼人
.accept 10228 >>接任务: 伊瑟基尔
step << Horde
.goto Nagrand,55.6,37.6
>>前往: 纳格兰
.accept 9888 >>接任务: 落魄的领袖
step << Horde
.goto Terokkar Forest,19.8,60.8
.turnin 9888 >>交任务: 落魄的领袖
.accept 9889 >>接任务: 别杀那个胖家伙！
step << Horde
.goto Terokkar Forest,19.8,62.6
>>杀死10名巨石拳入侵者。不要和无情的乌克尔战斗。
.complete 9889,1
step << Horde
.goto Terokkar Forest,20.0,63.4
>>殴打Unkor直到他提交。
.complete 9889,2
.turnin 9889 >>交任务: 别杀那个胖家伙！
.accept 9890 >>接任务: 成功了！
step << Horde
.goto Terokkar Forest,19.6,60.8
.turnin 9890 >>交任务: 成功了！
.accept 9891 >>接任务: 吉尔拉斯这个懦夫！
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9891 >>交任务: 吉尔拉斯这个懦夫！
.accept 9906 >>接任务: 粗暴的信号
step << Horde
.goto Nagrand,76.4,61.6,20,0
.goto Nagrand,74.6,69.6
>>杀死巨石拳食人魔。
.complete 9906,1
.complete 9906,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9906 >>交任务: 粗暴的信号
.accept 9907 >>接任务: 大胆的攻势
step << Horde
.goto Nagrand,49.6,56.4
.goto Nagrand,40.8,31.6
>>杀死巨石拳食人魔。
.complete 9907,1
.complete 9907,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9907 >>交任务: 大胆的攻势
.accept 10107 >>接任务: 外交手段
step << Horde
.goto Nagrand,73.8,62.6
>>与Lantressor对话
.skipgossip
.turnin 10107 >>交任务: 外交手段
.accept 9928 >>接任务: 欺诈所需的军备
.accept 9927 >>接任务: 无情的计谋
step << Horde
.goto Nagrand,69.4,81.4
>>从堡垒周围的箱子里捡起基尔索洛武器。
.complete 9928,1
>>杀死基尔的敌人，在他们的尸体上贴上横幅。你不必瞄准尸体。
.use 25552
.complete 9927,1
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9928 >>交任务: 欺诈所需的军备
.turnin 9927 >>交任务: 无情的计谋
.accept 9931 >>接任务: 以牙还牙
.accept 9932 >>接任务: 尸证
step << Horde
.goto Nagrand,54.8,39.8
.accept 9864 >>接任务: 失踪的战斗小队
step << Horde
#sticky
.goto Nagrand,46.7,24.3
>>站在柴堆旁边时，使用湿羊毛毯。
* Boulderfist Saboteurs will spawn, protect them if any ogres aggro to them.
.use 25658
.complete 9932,1
step << Horde
.goto Nagrand,46.0,20.2
>>杀死Warmaul食人魔，在他们的尸体上贴上横幅。你不必瞄准尸体。
.use 25555
.complete 9931,1
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9864 >>交任务: 失踪的战斗小队
.accept 9865 >>接任务: 我们曾是战士
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9931 >>交任务: 以牙还牙
.turnin 9932 >>	Turn in Body of Evidence.
step << Horde
.goto Nagrand,32.6,42.6
>>杀死黑血清道夫和掠夺者。
.complete 9865,1
.complete 9865,2
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9865 >>交任务: 我们曾是战士
step << Alliance
.goto Nagrand,55.0,70.6
.accept 9917 >>接任务: 是我眼花了？
step << Alliance
.goto Nagrand,62.8,72.4
>>为计划杀死巨石拳猎人。
.complete 9917,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9917 >>交任务: 是我眼花了？
.accept 9918 >>接任务: 这是我的地盘！
step << Alliance
.goto Nagrand,62.6,71.6
>>殴打Lump直到他投降，然后和他说话。
.skipgossip
.complete 9918,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9918 >>交任务: 这是我的地盘！
.accept 9920 >>接任务: 击碎者姆摩尔
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9920 >>交任务: 击碎者姆摩尔
.accept 9921 >>接任务: 火刃废墟
step << Alliance
.goto Nagrand,74.6,68.6,40,0
>>杀死营地周围的巨石拳食人魔
.complete 9921,1
.complete 9921,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9921 >>交任务: 火刃废墟
.accept 9922 >>接任务: 纳格兰的峡谷
step << Alliance
.goto Nagrand,50.2,56.8,40,0
.goto Nagrand,40.8,31.6,40,0
>>杀死营地周围的巨石拳食人魔
.complete 9922,1
.complete 9922,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9922 >>交任务: 纳格兰的峡谷
.accept 10108 >>接任务: 外交手段
step << Alliance
.goto Nagrand,55.4,68.8
.accept 11044 >>接任务: 灾难的幻象
step << Alliance
.goto Nagrand,73.8,62.6
>>与Lantresor交谈。
.skipgossip
.complete 10108,1
.turnin 10108 >>交任务: 外交手段
.accept 9928 >>接任务: 欺诈所需的军备
.accept 9927 >>接任务: 无情的计谋
step << Alliance
.goto Nagrand,69.4,81.4
>>从堡垒周围的箱子里捡起基尔索洛武器。
.complete 9928,1
>>杀死基尔索洛的敌人并种植横幅。
.use 25552
.complete 9927,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9928 >>交任务: 欺诈所需的军备
.turnin 9927 >>交任务: 无情的计谋
.accept 9931 >>接任务: 以牙还牙
.accept 9932 >>接任务: 尸证
step << Alliance
#sticky
.goto Nagrand,46.7,24.3
>>站在柴堆旁边时，使用湿羊毛毯。一旦破坏者产卵，保护他们。
.use 25658
.complete 9932,1
step << Alliance
.goto Nagrand,46.0,20.2
>>杀死Warmaul食人魔并种植横幅。
.use 25555
.complete 9931,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9931 >>交任务: 以牙还牙
.turnin 9932 >>	Turn in Body of Evidence.
step
.goto Nagrand,27.4,43.0
>>确保您已下马。
.accept 9991 >>接任务: 侦查大地
step
>>飞行时侦察锻造营地。这大约需要2分钟，可以自由起身伸展：D
.complete 9991,1
.turnin 9991 >>交任务: 侦查大地
.accept 9999 >>接任务: 争取时间
step
.goto Nagrand,24.4,37.4,30,0
.goto Nagrand,19.6,51.4
>>杀死锻造营地周围的恶魔。这是一个精英任务，你可能需要帮助。
.complete 9999,1
.complete 9999,2
.complete 9999,3
step
.goto Nagrand,27.4,43.0
.turnin 9999 >>交任务: 争取时间
.accept 10001 >>接任务: 主规划师
step
.goto Nagrand,23.6,34.8
>>杀死莫阿尔格总规划师以获得蓝图。
.complete 10001,1
step
.goto Nagrand,27.4,43.0
.turnin 10001 >>交任务: 主规划师
.accept 10004 >>接任务: 耐心与理解
step
.goto Shattrath City,77.2,34.8
.skipgossip
>>前往沙塔斯。与萨尔萨拉宾谈谈，与他战斗。 << !Mage
>>传送到沙塔斯。与萨尔萨拉宾谈谈，与他战斗。 << Mage
.turnin 10004 >>交任务: 耐心与理解
.accept 10009 >>接任务: 大打出手
step
.goto Shattrath City,75.0,31.8
.skipgossip
>>向醉汉雷利克讨债。
.complete 10009,1
step
.goto Shattrath City,61.2,49.6
>>找到以西结，逆时针绕着建筑走。
.unitscan Ezekiel
.turnin 10228 >>交任务: 伊瑟基尔
.accept 10231 >>接任务: 什么书？我没见过什么书
step
.goto Shattrath City,43.6,29.4
.skipgossip
>>去打败肮脏的拉里。如果他死了，你可能需要等待他重生。
* He is an elite, you may need help.
.complete 10231,1
step
.goto Shattrath City,43.6,29.4
.turnin 10231 >>交任务: 什么书？我没见过什么书
step
.goto Zangarmarsh,81.0,91.6
.skipgossip
>>从库什库什那里得到债务。
.complete 10009,2
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 11044 >>交任务: 灾难的幻象
.accept 10562 >>接任务: 兵临城下！
step << Alliance
.goto Shadowmoon Valley,36.4,56.8
.accept 10680 >>接任务: 古尔丹之手
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.accept 10569 >>接任务: 斯克瑟隆废墟
step << Alliance
.goto Shadowmoon Valley,39.0,50.0
>>向北去杀了地狱，守卫周围的人并不总是值得称赞
.complete 10562,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10562 >>交任务: 兵临城下！
.accept 10563 >>接任务: 前往军团要塞
step << Alliance
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >>使用“诡计盒”在通信设备旁伪装自己。这个角色扮演大约需要一分钟。
.complete 10563,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10563 >>交任务: 前往军团要塞
.accept 10572 >>接任务: 制造炸弹
step << Alliance
.goto Shadowmoon Valley,26.2,41.1,40,-1
.goto Shadowmoon Valley,22.2,35.4,40,-1
>>从地面上掠夺恶魔收割者能量核心和装甲板。电源核心在水下。
.complete 10572,1 
.complete 10572,2 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10572 >>交任务: 制造炸弹
.accept 10564 >>接任务: 炸毁地狱火！
step << Alliance
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >>使用绿色圆圈中的炸弹。如果你没有马上看到它，它每5秒就会脉冲一次。
.complete 10564,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10564 >>交任务: 炸毁地狱火！
.accept 10573 >>接任务: 死亡熔炉
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
.turnin 10573 >>交任务: 死亡熔炉
.accept 10582 >>接任务: 暗影议会的爪牙
step << Alliance
.goto Shadowmoon Valley,40.0,39.0
>>冲进洞穴，杀死该地区的死亡堡敌人
.complete 10582,1 
.complete 10582,2 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>>返回塔楼
.turnin 10582 >>交任务: 暗影议会的爪牙
.accept 10583 >>接任务: 弗兰尼斯的命运
.accept 10585 >>接任务: 召唤之厅
step << Alliance
#sticky
#label elementald2
.goto Shadowmoon Valley,40.0,39.0
>>杀死死亡堡史密斯和修补匠。掠夺他们作为元素置换器
.collect 30672,1,10585,1
step << Alliance
.goto Shadowmoon Valley,40.0,38.0,60,0
.goto Shadowmoon Valley,34.0,39.0
>>返回下面的洞穴。继续穿过大桥，然后向右穿过地狱。与Flanis的尸体交谈
.unitscan Flanis
.skipgossip
.collect 30658,1,10583,1
step << Alliance
#requires elementald2
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >>前往低层，然后使用元素置换器扰乱召唤师斯卡塔克斯所在的仪式
.unitscan Summnoner Skartax
.complete 10585,1 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>>返回塔楼
.turnin 10583 >>交任务: 弗兰尼斯的命运
.turnin 10585 >>交任务: 召唤之厅
.accept 10586 >>接任务: 击败战争使者！
step << Alliance
.goto Shadowmoon Valley,39.0,46.0,20,0
.goto Shadowmoon Valley,37.4,42.6
.use 30688 >>返回上层洞穴，穿过大桥，然后用钥匙打开左侧的门廊。杀死房间后面的战使拉祖恩，并为他的命令洗劫他。
.unitscan Warbringer Razuun
.complete 10586,1 
.collect 30689,1,10586,1
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10586 >>交任务: 击败战争使者！
.accept 10589 >>接任务: 控制权
step << Alliance
.goto Shadowmoon Valley,42.2,45.0
.turnin 10680 >>交任务: 古尔丹之手
.accept 10458 >>接任务: 愤怒的火灵和地灵
step << Alliance
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>使用精灵图腾，杀死图腾旁边的火/土元素。
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Alliance
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >>交任务: 愤怒的火灵和地灵
.accept 10480 >>接任务: 愤怒的水灵
step << Alliance
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的水元素
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Alliance
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >>交任务: 愤怒的水灵
.accept 10481 >>接任务: 愤怒的气灵
step << Alliance
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的空气元素。一些元素也可以在北方的尼日翼原野产卵。
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Alliance
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >>交任务: 愤怒的气灵
.accept 10513 >>接任务: 欧鲁诺克-裂心
step << Alliance
.goto Shadowmoon Valley,22.4,33.4
>>杀死莫阿尔格兵器匠，并将其掠夺以控制军团的电信员
.collect 30695,1,10589,1
step << Alliance
.goto Shadowmoon Valley,37.4,30.4
>>杀死该地区的黑暗秘会暴徒并掠夺他们的日记页
.complete 10569,1 
.complete 10569,2 
.complete 10569,3 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10589 >>交任务: 控制权
.accept 10766 >>接任务: 登陆场：灾难
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.turnin 10569 >>交任务: 斯克瑟隆废墟
.accept 10759 >>接任务: 寻找逃亡者
step << Alliance
.goto Shadowmoon Valley,35.4,41.8
.turnin 10759 >>交任务: 寻找逃亡者
.accept 10777 >>接任务: 阿斯迦的图腾
step << Alliance
.goto Shadowmoon Valley,40.0,30.8
>>找到Asghar，杀掉并掠夺他的图腾
.unitscan Asghar
.complete 10777,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10766 >>交任务: 登陆场：灾难
.accept 10606 >>接任务: 魔能机甲维修窍门大全
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
>>杀死古特里克医生，抢走他的钥匙。
.unitscan Doctor Gutrick
.collect 30712,1,10606,1
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
.use 30712 >>使用钥匙打开医生保险箱，检索《收割者维护艺术》
.collect 30713,1,10606,1
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10606 >>交任务: 魔能机甲维修窍门大全
.accept 10612 >>接任务: 狂暴的魔能机甲
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
>>使用地狱收割者控制台摧毁60个死亡锻造地狱
.complete 10612,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10612 >>交任务: 狂暴的魔能机甲
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.accept 10595 >>接任务: 兵临城下！
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.accept 10624 >>接任务: 阴森的历史
step << Horde
.goto Shadowmoon Valley,31,29.8
.accept 10760 >>接任务: 斯克瑟隆废墟
step << Horde
#sticky
#completewith next
>>在杀死无间道袭击者的同时掠夺燃烧着的灰烬堆
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,32.0,32.0,80,0
.goto Shadowmoon Valley,30.7,36.2,60,0
.goto Shadowmoon Valley,32.0,32.0
>>杀死无间道攻击者
.complete 10595,1 
step << Horde
.goto Shadowmoon Valley,32.2,38.1,60,0
>>完成对不断燃烧的灰堆的掠夺
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,37.4,30.4
>>杀死该地区的黑暗秘会暴徒并掠夺他们的日记页
.complete 10760,1 
.complete 10760,2 
.complete 10760,3 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.turnin 10624 >>交任务: 阴森的历史
.accept 10625 >>接任务: 幽灵眼镜
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.use 30719 >>戴上护目镜，杀死镇上的幽灵
.complete 10625,1 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
>>确保重新装备您的普通头盔
.turnin 10625 >>交任务: 幽灵眼镜
step << Horde
.goto Shadowmoon Valley,31.0,29.8
.turnin 10760 >>交任务: 斯克瑟隆废墟
.accept 10761 >>接任务: 寻找逃亡者
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10595 >>交任务: 兵临城下！
.accept 10596 >>接任务: 前往军团要塞
step << Horde
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >>使用“诡计盒”在通信设备旁伪装自己。这个角色扮演大约需要一分钟。
.complete 10596,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10596 >>交任务: 前往军团要塞
.accept 10597 >>接任务: 制造炸弹
step << Horde
.goto Shadowmoon Valley,26.2,41.1,20,-1
.goto Shadowmoon Valley,22.2,35.4,20,-1
>>掠夺恶魔收割者能量核心和装甲板。电源核心在水下。
.complete 10597,1 
.complete 10597,2 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10597 >>交任务: 制造炸弹
.accept 10598 >>接任务: 炸毁地狱火！
step << Horde
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >>使用绿色圆圈中的fel炸弹。如果你没有马上看到它，它每5秒就会脉冲一次。
.complete 10598,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10598 >>交任务: 炸毁地狱火！
.accept 10599 >>接任务: 死亡熔炉
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>>向屋顶走去
.turnin 10599 >>交任务: 死亡熔炉
.accept 10600 >>接任务: 暗影议会的爪牙
step << Horde
.goto Shadowmoon Valley,40.0,39.0
>>冲进洞穴，杀死该地区的死亡堡敌人
.complete 10600,1 
.complete 10600,2 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
.turnin 10600 >>交任务: 暗影议会的爪牙
.accept 10601 >>接任务: 卡格罗什的命运
.accept 10602 >>接任务: 召唤之厅
step << Horde
#sticky
#label elementald
.goto Shadowmoon Valley,40.0,39.0
>>杀死死亡堡史密斯和修补匠。掠夺他们作为元素置换器
.collect 30672,1,10602,1
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,35.2,40.1
.unitscan Kagrosh
.skipgossip
>>返回下面的洞穴。继续穿过大桥，然后向右穿过地狱。与兽人的尸体对话并带走他的背包
.collect 30659,1,10601,1
step << Horde
#requires elementald
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >>前往低层，然后使用元素置换器扰乱召唤师斯卡塔克斯所在的仪式
.unitscan Summnoner Skartax
.complete 10602,1 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>>返回塔顶外侧
.turnin 10601 >>交任务: 卡格罗什的命运
.turnin 10602 >>交任务: 召唤之厅
.accept 10603 >>接任务: 击败战争使者！
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,38.9,46.7
.use 30688 >>回到你杀死史密斯和修补匠的洞穴。用钥匙打开房间左侧的门廊，然后杀死战使拉祖并为他的命令洗劫他。
.unitscan Warbringer Razuun
.complete 10603,1 
.collect 30689,1,10603,1
step << Horde
>>返回塔楼
.goto Shadowmoon Valley,30.4,32.4
.turnin 10603 >>交任务: 击败战争使者！
.accept 10604 >>接任务: 控制权
step << Horde
.goto Shadowmoon Valley,35.4,41.8
.turnin 10761 >>交任务: 寻找逃亡者
.unitscan Parshah
.accept 10777 >>接任务: 阿斯迦的图腾
step << Horde
.goto Shadowmoon Valley,40.0,30.8
>>找到Asghar，杀掉并掠夺他的图腾
.unitscan Asghar
.complete 10777,1 
step << Horde
.goto Shadowmoon Valley,28.4,26.6
.accept 10681 >>接任务: 古尔丹之手
step << Horde
.goto Shadowmoon Valley,42.2,45.0
.turnin 10681 >>交任务: 古尔丹之手
.accept 10458 >>接任务: 愤怒的火灵和地灵
step << Horde
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>使用精灵图腾，杀死图腾旁边的火/土元素。
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Horde
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >>交任务: 愤怒的火灵和地灵
.accept 10480 >>接任务: 愤怒的水灵
step << Horde
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的水元素
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Horde
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >>交任务: 愤怒的水灵
.accept 10481 >>接任务: 愤怒的气灵
step << Horde
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的空气元素。一些元素也可以在北方的尼日翼原野产卵。
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Horde
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >>交任务: 愤怒的气灵
.accept 10513 >>接任务: 欧鲁诺克-裂心
step << Horde
.goto Shadowmoon Valley,22.4,33.4
>>杀死莫阿尔格兵器匠，并将其掠夺以控制军团的电信员
.collect 30695,1,10604,1
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10604 >>交任务: 控制权
.accept 10767 >>接任务: 登陆场：灾难
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10767 >>交任务: 登陆场：灾难
.accept 10611 >>接任务: 魔能机甲维修窍门大全
step << Horde
.goto Shadowmoon Valley,28.9,20.6
>>杀死Maleficus医生，并掠夺他以获取医生的钥匙。
.unitscan Doctor Maleficus
.collect 30712,1,10611,1
step << Horde
.goto Shadowmoon Valley,38.9,20.5
.use 30712 >>使用钥匙打开医生保险箱，检索《收割者维护艺术》
.collect 30713,1,10611,1
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10611 >>交任务: 魔能机甲维修窍门大全
.accept 10613 >>接任务: 狂暴的魔能机甲
step << Horde
.goto Shadowmoon Valley,27.8,19.8
>>使用地狱收割者控制台摧毁60个死亡锻造地狱
* Using the first Fel Reaver ability destroys the Infernals, the rest of the buttons are rather irrelevant.
.complete 10613,1 
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10613 >>交任务: 狂暴的魔能机甲
step
.goto Shadowmoon Valley,54.0,23.6
.turnin 10513 >>交任务: 欧鲁诺克-裂心
.accept 10514 >>接任务: 历经沧桑......
step
.goto Shadowmoon Valley,54.0,16.0
.use 30462 >>站在地上的小植物上，用公猪的口哨让附近的公猪挖出块茎。然后单击它。
* You may need to kill Flayers in the area, so they stop killing the boars near tubers.
.complete 10514,1 
step
.goto Shadowmoon Valley,53.9,23.5
.turnin 10514 >>交任务: 历经沧桑......
.accept 10515 >>接任务: 严厉的教训
step
.goto Shadowmoon Valley,56.6,17.0
>>摧毁该区域周围的蛋，小心巡逻该区域的大型精英暴徒
.complete 10515,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10515 >>交任务: 严厉的教训
.accept 10519 >>接任务: 诅咒密码 - 真相和历史
>>与Oronok交谈
.skipgossip
.complete 10519,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10519 >>交任务: 诅咒密码 - 真相和历史
.accept 10521 >>接任务: 格洛姆托，欧鲁诺克之子
.accept 10527 >>接任务: 阿托尔，欧鲁诺克之子
.accept 10546 >>接任务: 伯拉克，欧鲁诺克之子
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10521 >>交任务: 格洛姆托，欧鲁诺克之子
.accept 10522 >>接任务: 诅咒密码 - 格洛姆托的命令
step
.goto Shadowmoon Valley,46.0,28.2
>>杀死Nagas以获得箱子钥匙，打开箱子直到你洗劫碎片
.complete 10522,1 
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10522 >>交任务: 诅咒密码 - 格洛姆托的命令
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10777 >>交任务: 阿斯迦的图腾
.accept 10778 >>接任务: 莉安丝魔棒
step
.goto Shadowmoon Valley,47.5,57.3
.turnin 10546 >>交任务: 伯拉克，欧鲁诺克之子
.accept 10547 >>接任务: 血蓟交易......
step
.goto Shadowmoon Valley,45.1,57.4
>>在地上寻找腐烂的鸡蛋，要小心，因为它们会在掠夺时对你造成伤害
.complete 10547,1 
step
.goto Shattrath City,64.1,69.8
>>前往沙塔斯。如果一切就绪，请起火，并设置为沙塔斯。
.turnin 10547 >>交任务: 血蓟交易......
.accept 10550 >>接任务: 一捆血蓟
step
.isOnQuest 10009
.goto Terokkar Forest,27.2,57.8
.skipgossip
>>从Floon那里获得债务。
.complete 10009,3
step
>>返回影月谷
.goto Shadowmoon Valley,29.6,50.3
.turnin 10527 >>交任务: 阿托尔，欧鲁诺克之子
.accept 10528 >>接任务: 恶魔的水晶牢笼
step
.goto Shadowmoon Valley,28.0,47.7
>>杀害痛苦女主人加布里萨
.complete 10528,1 
step
.goto Shadowmoon Valley,29.6,50.5
.turnin 10528 >>交任务: 恶魔的水晶牢笼
>>等阿托死了再和他的灵魂谈谈
.accept 10537 >>接任务: 洛恩戈鲁，裂心之弓
step
.goto Shadowmoon Valley,30.5,50.0
>>杀死并掠夺任务给予者周围的伊利达里暴徒。
* The drop rate is very low, just keep killing
.complete 10537,1 
step
.goto Shadowmoon Valley,29.5,50.5
.turnin 10537 >>交任务: 洛恩戈鲁，裂心之弓
.accept 10540 >>接任务: 诅咒密码 - 阿托尔的命令
step
.goto Shadowmoon Valley,29.5,57.5
>>当阿托尔的灵魂跟随你时，向东南方向走，在这一带走动，直到阿托尔召唤维尼拉图斯
.complete 10540,1 
>>准备好长期战斗，维尼拉斯的生命值是普通暴徒的3倍
step
.goto Shadowmoon Valley,29.5,50.6
.turnin 10540 >>交任务: 诅咒密码 - 阿托尔的命令
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10550 >>交任务: 一捆血蓟
.accept 10570 >>接任务: 血蓟瘾君子
step
.goto Shadowmoon Valley,48.9,57.4
>>在桥的尽头种上一束血丝。回到另一边，等博拉克对你低语后再去攻击。
.complete 10570,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10570 >>交任务: 血蓟瘾君子
.accept 10576 >>接任务: 影月谷的乔装者
step
#sticky
#label liantherod
.goto Shadowmoon Valley,47.2,67.0
>>杀死该地区的食蚀暴徒，直到他们丢下Lianthe的钥匙
.complete 10778,1 
step
.goto Shadowmoon Valley,49.6,62.2
>>杀死并掠夺该地区的日食暴徒
.complete 10576,1 
step
#requires liantherod
.goto Shadowmoon Valley,47.5,71.7
>>使用利安特堡垒上的钥匙，掠夺利安特的棍子
.complete 10778,2 
step
.goto Shadowmoon Valley,35.4,41.8
>>转弯处可以从这里沿着公路巡逻
.turnin 10778 >>交任务: 莉安丝魔棒
.accept 10780 >>接任务: 斯克瑟隆羽毛
step
.goto Shadowmoon Valley,43.7,57.5
>>在地上掠夺羽毛
.complete 10780,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10576 >>交任务: 影月谷的乔装者
.accept 10577 >>接任务: 伊利丹的信使......
step
.goto Shadowmoon Valley,46.5,71.9
.skipgossip
>>使用提供的伪装，与2个兽人守护的血精灵交谈
.complete 10577,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10577 >>交任务: 伊利丹的信使......
.accept 10578 >>接任务: 诅咒密码 - 伯拉克的命令
step
.goto Shadowmoon Valley,62.6,57.2
>>杀死并掠夺黑暗者鲁尔
* You will need to group for this quest, he is very difficult.
.unitscan Ruul the Darkener
.complete 10578,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10578 >>交任务: 诅咒密码 - 伯拉克的命令
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10780 >>交任务: 斯克瑟隆羽毛
step
>>返回沙塔斯。 << !Mage
>>传送回沙塔斯 << Mage
.goto Shattrath City,77.2,34.8
.turnin 10009 >>交任务: 大打出手

step
.goto Shattrath City,59.7,41.5
.accept 10210 >>接任务: 阿达尔
step
.goto Shattrath City,54.5,44.9
.turnin 10210 >>交任务: 阿达尔
step
.goto Shattrath City,54.5,44.9
>>与卡德加交谈
.accept 10211 >>接任务: 圣光之城
step
.goto Shattrath City,48.1,42.0
>>前往G'eras附近的二楼隧道等待。如果其他仆人在此期间到达，你可以瞄准它，它将为你完成任务。否则，您的仆人需要8分30秒才能到达。放松一下！
.complete 10211,1 
step
.goto Shattrath City,54.5,44.9
.turnin 10211 >>交任务: 圣光之城
step
#label choice
#completewith aldorOrScryer
.goto Shattrath City,54.5,44.1
+ Choose an Allegiance to the Aldor or Scryer. They both give the same amount of prep exp for Wrath, so choose whichever you prefer. Manually skip this step once you have chosen.
* If you do not see aldor or scryer specific quest steps after this, type "/reload" into your ingame chat box
step
#scryer
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10552 >>交任务: 为占星者效力
step
#aldor
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10551 >>交任务: 为奥尔多效力
step
#sticky
#requires choice
#completewith notofftoarea52
>>前往: 虚空风暴
* 5 other quests count as the same pre-requisite as Off to Area 52, if it's not here for you, it means you did a different pre-requisite, you can skip this step.
.goto Netherstorm,20.6,55.7
.accept 10183 >>接任务: 前往52区
step
#label notofftoarea52
.goto Netherstorm,32.7,64.9
.turnin 10183 >>交任务: 前往52区
step
.goto Netherstorm,32.7,64.9
.accept 10186 >>接任务: 你被雇了！
step
.goto Netherstorm,32.4,64.2
.accept 10265 >>接任务: 星界财团的水晶
step
.goto Netherstorm,31.4,66.2
.accept 10173 >>接任务: 大法师的法杖
step
#aldor
.goto Netherstorm,32.1,64.3
.accept 10241 >>接任务: 削弱法力熔炉：布纳尔
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10189 >>接任务: 法力熔炉：布纳尔
step
#aldor
.goto Netherstorm,26.6,68.4
>>杀死该地区的Sunfrew敌人
.complete 10241,1 
.complete 10241,2 
step
#scryer
.goto Netherstorm,28.0,65.6
>>杀死阿拉森上尉并为任务物品掠夺他。
.complete 10189,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10189 >>交任务: 法力熔炉：布纳尔
.accept 10193 >>接任务: 有价值的目标
step
#scryer
.goto Netherstorm,25.4,71.8,100,0
.goto Netherstorm,22.0,72.7,40,0
.goto Netherstorm,25.4,71.8
>>杀死该区域的Sunfrew敌人。
.complete 10193,1
.complete 10193,2
.complete 10193,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10193 >>交任务: 有价值的目标
.accept 10329 >>接任务: 关闭法力熔炉：布纳尔
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10241 >>交任务: 削弱法力熔炉：布纳尔
.accept 10313 >>接任务: 测量迁跃能量
.accept 10243 >>接任务: 纳鲁科技
step
#scryer
.goto Netherstorm,23.8,70.6
>>杀死并掠夺法力锻炉内的监督特蕾迪斯以获得B'naar Access水晶
.collect 29366,1,10329,1
step
#scryer
.goto Netherstorm,23.2,68.1
>>单击控制台并保护它免受技术人员的攻击。这需要2分钟。
.skipgossip
.complete 10329,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10329 >>交任务: 关闭法力熔炉：布纳尔
.accept 10194 >>接任务: 隐秘飞行
step
#scryer
.goto Netherstorm,33.8,64.2
.turnin 10194 >>交任务: 隐秘飞行
.accept 10652 >>接任务: 深入敌后
step
#aldor
.goto Netherstorm,25.4,60.3
>>当靠近管道时，使用包中的“扭曲调整球”
.complete 10313,1 
step
#aldor
.goto Netherstorm,20.7,67.5
>>站在脚手架顶部并使用球
.complete 10313,4 
step
#aldor
.goto Netherstorm,20.3,70.9
>>站在这根管子旁边时使用这个球体
.complete 10313,3 
step
#aldor
.goto Netherstorm,23.2,68.1
>>进入大楼，然后点击柱子
.turnin 10243 >>交任务: 纳鲁科技
.accept 10245 >>接任务: 布纳尔控制台拓文
step
#aldor
.goto Netherstorm,29.1,72.8
>>当靠近管道时，使用包中的“扭曲调整球”
.complete 10313,2 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10245 >>交任务: 布纳尔控制台拓文
.accept 10299 >>接任务: 关闭法力熔炉：布纳尔
.turnin 10313 >>交任务: 测量迁跃能量
step
#aldor
.goto Netherstorm,23.7,70.1
>>回到大楼里。杀死并掠夺监工
.complete 10299,2 
step
#aldor
.goto Netherstorm,23.2,68.1
.skipgossip
>>点击挂架启动关机定时器，杀死所有试图阻止它的暴徒。这需要2分钟。
.complete 10299,1 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10299 >>交任务: 关闭法力熔炉：布纳尔
.accept 10321 >>接任务: 关闭法力熔炉：库鲁恩
.accept 10246 >>接任务: 攻击法力熔炉：库鲁恩
step
.goto Netherstorm,42.6,72.6
>>为了水晶杀死并掠夺五角龙。
.complete 10265,1
step
.goto Netherstorm,40.8,72.6
.use 29207
>>站在火盆旁边，用魔法粉召唤Ekkorash并杀死她。
.complete 10173,1
step
.goto Netherstorm,32.4,64.2
.turnin 10265 >>交任务: 星界财团的水晶
.accept 10262 >>接任务: 叛徒的徽记
step
.goto Netherstorm,29.3,78.1
>>杀死该地区的扎克西斯暴徒并掠夺他们的徽章
.collect 29209,10,10262,1
step
.goto Netherstorm,32.4,64.2
.turnin 10262 >>交任务: 叛徒的徽记
.accept 10205 >>接任务: 星界强盗奈萨德
step
.goto Netherstorm,31.4,66.2
.turnin 10173 >>交任务: 大法师的法杖
.accept 10300 >>接任务: 修复法杖
step
.goto Netherstorm,28.3,79.9
>>杀死扭曲袭击者尼萨德
.unitscan Warp-Raider Nesaad
.complete 10205,1
step
.goto Netherstorm,32.4,64.2
.turnin 10205 >>交任务: 星界强盗奈萨德
.accept 10266 >>接任务: 寻求帮助
step
#sticky
#label crystalmatrixs
.goto Netherstorm,33.1,54.4
>>掠夺该地区地面上的红色水晶
* You can use your racial Find Treasure to track them on the minimap << Dwarf
.complete 10186,1 
step
.goto Netherstorm,33.6,54.6
>>杀死并掠夺水晶的无身保护者和维护者。
.complete 10300,1
step
#requires crystalmatrixs
.goto Netherstorm,32.7,64.9
.turnin 10186 >>交任务: 你被雇了！
step
.goto Netherstorm,31.4,66.2
.turnin 10300 >>交任务: 修复法杖
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10652 >>交任务: 深入敌后
.accept 10197 >>接任务: 以假乱真
step
#scryer
.goto Netherstorm,49.0,81.6
>>杀害和掠夺该地区的暴徒。收集部件以进行伪装。
* Researchers are inside, Guardsmen are found on the eastern side. Arcanists are on the west side.
.complete 10197,1
.complete 10197,2
.complete 10197,3
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10197 >>交任务: 以假乱真
.accept 10198 >>接任务: 收集情报
step
#scryer
>>乔装打扮，前往马纳福格·科鲁，找到指挥官道恩福格，站在他旁边，为这次任务获得荣誉。
* You may need to wait for the Arcane Annihilator to patrol away from the door
.use 28607
.goto Netherstorm,48.2,84.0
.complete 10198,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10198 >>交任务: 收集情报
.accept 10330 >>接任务: 关闭法力熔炉：库鲁恩
step
#scryer
.goto Netherstorm,49.0,81.6
>>点击你的伪装，然后为她的Access Crystal杀死Overseer Seylanna，并在控制台上使用它。
.complete 10330,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10330 >>交任务: 关闭法力熔炉：库鲁恩
step
#aldor
#sticky
#label researcherkills
.goto Netherstorm,48.7,82.2
>>杀死房间周围的研究人员
.complete 10246,1 
step
#aldor
.goto Netherstorm,49.0,81.5
>>杀死控制台旁边的监督员
.complete 10321,2 
step
#aldor
.goto Netherstorm,49.0,81.5
.skipgossip
>>点击挂架启动关机定时器，杀死所有试图阻止它的暴徒。在暴徒之间研磨百夫长。
* Kill Researchers in the area while waiting.
.complete 10321,1 
step
#aldor
#requires researcherkills
.goto Netherstorm,49.6,80.6
>>走出去，杀死奥术家
.complete 10246,2 
step
.goto Netherstorm,57.4,86.2
.accept 10184 >>接任务: 狂暴的幽灵
step
.goto Netherstorm,59.4,87.4
>>杀死麒麟湾周围的幽灵。
.complete 10184,1
step
.goto Netherstorm,57.4,86.2
.turnin 10184 >>交任务: 狂暴的幽灵
.accept 10312 >>接任务: 肯瑞瓦名册
step
.goto Netherstorm,60.6,87.6
>>杀死战斗法师达思里克并收集这本书。不要转动他的刀片。我们将在70-71转弯路线中使用它。
.complete 10312,1
step
.goto Netherstorm,57.4,86.2
.turnin 10312 >>交任务: 肯瑞瓦名册
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10321 >>交任务: 关闭法力熔炉：库鲁恩
.turnin 10246 >>交任务: 攻击法力熔炉：库鲁恩
.accept 10322 >>接任务: 关闭法力熔炉：杜隆
.accept 10328 >>接任务: 日怒简报
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10341 >>接任务: 乘胜追击
step
#scryer
.goto Netherstorm,59.0,66.8
>>杀死太阳怒的敌人。百夫长通常出现在法力锻造厂的入口处。
.complete 10341,1
.complete 10341,2
.complete 10341,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10341 >>交任务: 乘胜追击
.accept 10202 >>接任务: 叛徒
step
#scryer
.goto Netherstorm,26.2,41.6
.turnin 10202 >>交任务: 叛徒
.accept 10432 >>接任务: 可怕的证据
step
#scryer
.goto Netherstorm,26.4,44.0
>>前往法力锻炉下方的洞穴。为命令杀戮和掠夺恶魔。
.collect 29797,8,10432,1
step
#aldor
#sticky
#label militarymanaforge
.goto Netherstorm,58.5,63.6
>>杀死并掠夺Manaforge Duro内的Sunfrage百夫长
.complete 10328,1 
step
#aldor
.goto Netherstorm,60.0,68.5
>>杀死并掠夺法力锻造厂南翼内的监督员阿萨内尔
.complete 10322,2 
step
#aldor
.goto Netherstorm,59.1,66.6
.skipgossip
>>与铁塔对话，开始关闭。杀死任何试图阻止你的暴徒。
.complete 10322,1 
step
#aldor
#requires militarymanaforge
.goto Netherstorm,57.2,64.2
>>杀死并掠夺法力锻炉周围的太阳怒魔法师
.complete 10328,2 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10328 >>交任务: 日怒简报
.accept 10431 >>接任务: 外界的帮助
.turnin 10322 >>交任务: 关闭法力熔炉：杜隆
.accept 10323 >>接任务: 关闭法力熔炉：艾拉
step
#aldor
.goto Netherstorm,34.8,38.2
.turnin 10431 >>交任务: 外界的帮助
.accept 10380 >>接任务: 黑暗的契约
step
#aldor
.goto Netherstorm,26.4,43.5
>>杀死洞穴中的甘阿尔格和莫阿尔格恶魔
.complete 10380,1 
.complete 10380,3 
step
#aldor
.goto Netherstorm,26.4,43.5,40,0
.goto Netherstorm,28.5,39.9
>>离开洞穴，绕着马纳福格·阿拉飞翔，寻找命运之女
* The demons don't social aggro with the blood elves if you ranged pull them.
.unitscan Daughter of Destiny
.complete 10380,2 
step
#aldor
.goto Netherstorm,34.8,38.3
.turnin 10380 >>交任务: 黑暗的契约
.accept 10381 >>接任务: 退出奥尔多
step
#aldor
.goto Netherstorm,26.0,38.7
>>杀死监督员Azarad。抢他去拿通道水晶。然后与塔架对话，像以前那样保护它。
*This quest can be very overwhelming compared to the previous ones, be ready and you may need help. Clear a safe space in the room beforehand.
.skipgossip
.complete 10323,2 
.complete 10323,1 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10381 >>交任务: 退出奥尔多
.accept 10407 >>接任务: 索克雷萨之影
.turnin 10323 >>交任务: 关闭法力熔炉：艾拉
step
#aldor
.goto Netherstorm,36.2,26.4
>>杀死并掠夺锻造大师摩格。他是精英，你可能需要帮助。
.unitscan Forgemaster Morug
.complete 10407,1 
step
#aldor
.goto Netherstorm,40.8,19.5
>>杀死并掠夺西罗，他是精英，你可能需要帮助。
.unitscan Silroth
.complete 10407,2 
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10432 >>交任务: 可怕的证据
.accept 10508 >>接任务: 给沃雷塔尔的礼物
step
#scryer
>>从莫鲁和西罗那里获得索克塔尔石的一半。
.goto Netherstorm,36.8,27.6,10,0
.goto Netherstorm,40.8,19.4
.complete 10508,1
.complete 10508,2
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10407 >>交任务: 索克雷萨之影
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10508 >>交任务: 给沃雷塔尔的礼物
step << skip
#aldor
.goto Netherstorm,32.0,64.2
.accept 10263 >>接任务: 协助星界财团
step << skip
#scryer
.goto Netherstorm,32.0,64.2
.accept 10264 >>接任务: 协助星界财团
step << skip
#aldor
.goto Netherstorm,32.4,64.2
.turnin 10263 >>交任务: 协助星界财团
step << skip
#scryer
.goto Netherstorm,32.4,64.2
.turnin 10264 >>交任务: 协助星界财团
step
.goto Netherstorm,33.0,64.6
.accept 10206 >>接任务: 偷来偷去
step
.goto Netherstorm,28.9,77.6
>>该地区的掠夺以太技术，它在小盒子里
.complete 10206,1 
step
.goto Netherstorm,33.0,64.6
.turnin 10206 >>交任务: 偷来偷去
.accept 10333 >>接任务: 帮助维勒老妈
step
.goto Netherstorm,46.4,56.4
.accept 10417 >>接任务: 诊断报告
.accept 10433 >>接任务: 保持伪装
step
.goto Netherstorm,48.2,55.0
>>单击支柱收集诊断结果
.complete 10417,1
step
.goto Netherstorm,46.4,56.4
.turnin 10417 >>交任务: 诊断报告
.accept 10418 >>接任务: 解决破坏者
step
.goto Netherstorm,46.6,57.0
.turnin 10266 >>交任务: 寻求帮助
.accept 10267 >>接任务: 贸易终结
step
.goto Netherstorm,56.9,63.8
>>收集马纳福吉周围的研究设备。它们看起来像灰色的小板条箱。
.complete 10267,1
step
.goto Netherstorm,46.6,57.0
.turnin 10267 >>交任务: 贸易终结
.accept 10268 >>接任务: 与节点亲王会面
step
#sticky
#label croctimes
.goto Netherstorm,47.0,52.6
>>杀死附近的鳄鱼。
.complete 10418,1
step
.goto Netherstorm,44.0,49.4,20,0
.goto Netherstorm,44.8,57.2,20,0
.goto Netherstorm,44.0,49.4
>>在生态穹顶下杀死里普芳山猫，获取它们的毛皮。
.complete 10433,1
step
#requires croctimes
.goto Netherstorm,46.4,56.4
.turnin 10418 >>交任务: 解决破坏者
.turnin 10433 >>交任务: 保持伪装
step
.goto Netherstorm,46.6,56.6
.turnin 10333 >>交任务: 帮助维勒老妈
.accept 10234 >>接任务: 恶魔的垃圾......
step
.goto Netherstorm,50.4,58.9
>>收集该区域周围的Fel reaver部件。
.complete 10234,1
step
.goto Netherstorm,46.6,56.6
.turnin 10234 >>交任务: 恶魔的垃圾......
.accept 10235 >>接任务: 厄运之爪
step
.goto Netherstorm,50.8,57.6
>>杀死毁灭法则并收集任务物品。
.complete 10235,1
step
.goto Netherstorm,46.6,56.6
.turnin 10235 >>交任务: 厄运之爪
.accept 10237 >>接任务: 通知52区！
step
.goto Netherstorm,45.9,36.0
.turnin 10268 >>交任务: 与节点亲王会面
.accept 10269 >>接任务: 一号三角点
step
.goto Netherstorm,66.7,33.8
.use 28962 >>在该区域使用三角测量设备
.complete 10269,1
step
.goto Netherstorm,58.4,31.3
.turnin 10269 >>交任务: 一号三角点
.accept 10275 >>接任务: 二号三角点
step
.goto Netherstorm,28.9,41.3
.use 29018 >>在该区域使用三角测量设备
.complete 10275,1
step
.goto Netherstorm,34.6,37.9
.turnin 10275 >>交任务: 二号三角点
.accept 10276 >>接任务: 三角测量
step
.goto Netherstorm,53.5,21.4
>>杀死并掠夺Culuthas以获取水晶。如果你有困难，你可能需要帮助。
.complete 10276,1
step
.goto Netherstorm,45.8,36.0
.turnin 10276 >>交任务: 三角测量
step
.goto Netherstorm,32.6,64.8
.turnin 10237 >>交任务: 通知52区！
.accept 10247 >>接任务: 工程学博士沃米萨
step
.goto Netherstorm,37.2,63.8
.turnin 10247 >>交任务: 工程学博士沃米萨
.accept 10248 >>接任务: 你，机器人
step
.goto Netherstorm,37.2,63.8
>>使用您在废料回收器上的控制器并击败Negatron。确保在冷却时使用机器人的能力。
* Save the stun for when Negatron uses earthquake. Only use Smash if you start getting threat, otherwise heal Scrap Reaver and stun Negatron during earthquake.
* Scrap Reaver is buffable as well << Paladin/Priest/Druid
.use 28634
.complete 10248,1
step
.goto Netherstorm,37.2,63.8
.turnin 10248 >>交任务: 你，机器人
step
.goto Blade's Edge Mountains,55.4,44.9
.accept 10995 >>接任务: 格鲁洛克的巨龙颅骨
.accept 10996 >>接任务: 玛古克的宝箱
.accept 10997 >>接任务: 戈隆的军旗
step
#sticky
#completewith gronnsdone
.goto Blade's Edge Mountains,60.3,47.5
>>杀死格鲁洛克，在他死后在地上掠夺物品。
.complete 10995,1
step
#sticky
#completewith gronssdone
.goto Blade's Edge Mountains,58.5,60.8,40,0
.goto Blade's Edge Mountains,64.5,54.8,40,0
.goto Blade's Edge Mountains,68.3,74.8
>>找到麦戈克，他在缩放架周围巡逻。杀了他，抢走他扔在地上的东西
.unitscan Maggoc
.complete 10996,1
step
#sticky
#completewith gronssdone
.goto Terokkar Forest,20.3,15.9
>>杀死斯拉格，并将他扔在地上的物品洗劫一空
.complete 10997,1
step
#completewith next
#label gronnprep
+接下来的3个任务都是精英任务，需要一个团队，然而，它们的独特之处在于，老板会丢弃一个可以右击地面的项目，以获得任务奖励，即使你不在被杀的团队中。你可以按任何顺序来做，两个在刀刃边缘，一个在沙塔斯上面。
step
#label gronnsdone
#requires gronnprep
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10995 >>交任务: 格鲁洛克的巨龙颅骨
.turnin 10997 >>交任务: 戈隆的军旗
.turnin 10996 >>交任务: 玛古克的宝箱
.accept 10998 >>接任务: 维姆高尔的魔典
step
.goto Blade's Edge Mountains,77.4,31.2
>>为他的书杀死Vim'gol the Vile，再次在地上掠夺物品。你不需要加入杀害他的组织就可以掠夺。
.complete 10998,1
step
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10998 >>交任务: 维姆高尔的魔典
.accept 11000 >>接任务: 磨魂者
step
.goto Blade's Edge Mountains,60.0,24.1
.use 32467 >>踏上祭坛，用香灰开始战斗。在海浪中幸存下来，然后杀死老板，并洗劫他掉在地上的灵魂。
.complete 11000,1


step
.goto Deadwind Pass,47.0,75.6
.reputation 967,honored 
>>迎风传球
.accept 9630 >>接任务: 麦迪文的日记
step

>>进入Karazhan，在馆长老板之后，在房间里与Wravien交谈。
.turnin 9630 >>交任务: 麦迪文的日记
.accept 9638 >>接任务: 书呆子
step
>>Gradav距离Wravien稍远一点。
.turnin 9638 >>交任务: 书呆子
.accept 9639 >>接任务: 卡姆希丝
step
>>像以前一样，卡姆西斯比格拉达夫领先一点。
.turnin 9639 >>交任务: 卡姆希丝
.accept 9640 >>接任务: 埃兰之影
step
>>击败《阿兰阴影》获得《华尔街日报》。
.complete 9640,1
step
.turnin 9640 >>交任务: 埃兰之影
.accept 9645 >>接任务: 主宰的露台
step
>>去卡拉詹的主人露台读日记。
.use 23934
.complete 9645,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9645 >>交任务: 主宰的露台
.accept 9680 >>接任务: 挖掘历史
step
.goto Deadwind Pass,45.0,78.8
>>从地上收集烧焦的骨头碎片。
.complete 9680,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9680 >>交任务: 挖掘历史
step
#sticky
.goto Netherstorm,43.5,35.0
+由于复杂性，本指南中不包括职业任务，但由于经验缩放，它们在70时可能会有大量经验。如果你有任何低级任务可用，比如治疗德鲁伊毒药、圣骑士复活等，请准备好在启动时提交。有些10级任务由于缩放而放弃30公里经验。
step
.goto Netherstorm,43.5,35.0
+前往风暴精灵，攻击敌方玩家，攻击守卫。杀死守卫，直到你在联盟中处于0/3000中立。你每杀一次就损失125次。有一个敌对派别的朋友会加快这一进程。
>>在以下任务中需要中立的声誉：从小偷那里偷窃和满头象牙
*Skip this step if those 2 quests are already complete
step
.goto Shadowmoon Valley,66.0,84.6
.reputation 1015,exalted
+通过制作以下日报，达到与荷兰之翼的共鸣。不要提交任何一次任务！
.accept 11020 >>接任务: 缓慢的死亡
.accept 11015 >>接任务: 灵翼水晶
.accept 11035 >>接任务: 危险的天空
step
.goto Shadowmoon Valley,66.0,84.6
.accept 11018 >>接任务: 虚空矿石
.skill mining,<350,1
step
.goto Shadowmoon Valley,66.0,84.6
.skill herbalism,<350,1
.accept 11017 >>接任务: 灵尘花粉
step
.goto Shadowmoon Valley,66.0,84.6
.skill skinning,<350,1
.accept 11016 >>接任务: 虚空矿洞剥石者的外皮
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name 交车日速度助理
step << !Mage
#sticky
#completewith next
+如果你的任务日志中没有“了解你的莱伊线”作为你的任务之一，那么在发射前几个小时去做“知道你的莱尔线”，它会给你一个卷轴来传送到沙塔斯。当日报再次可用时，此项目将被删除。如果你是一个愿意转移/召唤你的术士或法师的朋友，也可以跳过这一步。
step << !Mage
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >>接任务: 魔网能量线的读数
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,42.0,34.9,-1
.goto Isle of Quel'Danas,48.4,44.4,-1
.goto Isle of Quel'Danas,61.0,62.1,-1
.use 34533 >>使用星际巫师的水晶读取传送门、神殿和血水晶。
.complete 11547,1
.complete 11547,2
.complete 11547,3
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
.turnin 11547 >>交任务: 魔网能量线的读数
step
>>可以提高你的转身速度的物品。
.collect 6372,1
.collect 7052,1
.collect 2459,5
.collect 25653,1
step
>>您还可以选择获得赞萨的迅捷。这将为您节省大量时间，因为在WOTLK的坐骑工程中(需要赞达拉部落的尊敬)
.reputation 270,revered
.collect 20081,1
step
>>火箭靴结合noggenfogger也可以为你节省很多时间。
*There is a cloth and leather version of the boots, pick whichever is best for your spec. << Druid/Shaman/Paladin
.skill engineering,<330,1
.collect 8529,40
.collect 35581,1 << Warlock/Mage/Priest/Shaman/Druid/Paladin
.collect 23824,1 << Warrior/Paladin/Rogue/Hunter/Shaman/Druid
.collect 30542,1
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP WLK的准备
#name 启动移交指南
#next RestedXP联盟70-80\70.5-71.5 北风苔原开始 << Alliance
#next RestedXP部落70-80\70.5-71.5 北风苔原开始 << Horde
step
#sticky
#completewith start1
+ This is the guide you use when WOTLK is out and you are turning in quests for exp. Please DO NOT turn in quests in this guide until launch day.
step
#sticky
#completewith start1
+ Add quest accept items from your inventory onto your hotbar and keybind them to accept them faster. This will save a lot of time looking for them later.
step
#sticky
#completewith start1
+由于卡拉赞的位置，如果你无法获得召唤，你需要启动卡拉赞，这意味着你只能有24个qlog任务，而不是25个。如果你可以获得卡拉赞召唤，那么从沙特开始，然后马上转移到卡拉赞。
step
.isQuestTurnedIn 9680
>>前往逆风山口
.goto Deadwind Pass,47.0,75.6
.accept 9631 >>接任务: 同事的帮助
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,friendly,<0,1
>>选择一条环形路径，选择一条后跳过此步骤。
.dailyturnin 10730,10732,10729,10731 >>在紫色空白的道路上转弯
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,honored,<0,1
.daily 10735,10736,10733,10734 >>接受荣誉戒指任务。如果您超越荣誉，请跳过此步骤
.dailyturnin 10735,10736,10733,10734 >>提交荣誉戒指任务。如果您超越荣誉，请跳过此步骤
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,revered,<0,1
.daily 10739,10740,10741,10738 >>接受尊敬的戒指任务。如果你不受尊敬，跳过这一步
.dailyturnin 10739,10740,10741,10738 >>交出尊敬的戒指任务。如果你不受尊敬，跳过这一步
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,exalted,<0,1
.daily 10725,10728,10727,10726 >>接受至尊戒指任务
.dailyturnin 10725,10728,10727,10726 >>提交至尊戒指任务
step
.zone Shattrath City >>前往: 沙塔斯城
step
#scryer
.itemcount 30810,10
.goto Shattrath City,45.5,81.4
.accept 10656 >>接任务: 日怒徽记
.turnin 10656 >>交任务: 日怒徽记
step
#scryer
.itemcount 29426,10
.goto Shattrath City,45.4,81.4
.accept 10412 >>接任务: 火翼徽记
.turnin 10412 >>交任务: 火翼徽记
step
#scryer
.itemcount 29739,1
.goto Shattrath City,42.6,91.4
.accept 10416 >>接任务: 能量的聚合
.turnin 10416 >>交任务: 能量的聚合
step
#aldor
.itemcount 30809,10
.goto Shattrath City,30.8,34.6
.accept 10653 >>接任务: 萨格拉斯印记
.turnin 10653 >>交任务: 萨格拉斯印记
step
#aldor
.itemcount 29425,10
.goto Shattrath City,30.8,34.6
.accept 10325 >>接任务: 基尔加丹印记
.turnin 10325 >>交任务: 基尔加丹印记
step
#aldor
.itemcount 29740,1
.goto Shattrath City,24.2,29.8
.accept 10420 >>接任务: 净化之光
.turnin 10420 >>交任务: 净化之光
step
.itemcount 32405,1
.goto Shattrath City,54.0,44.6
.use 32405
.accept 11007 >>接任务: 凯尔萨斯和翠绿的魔珠
.turnin 11007 >>交任务: 凯尔萨斯和翠绿的魔珠
step
.isOnQuest 9837
.goto Shattrath City,54.6,44.2
.turnin 9837 >>交任务: 返回卡德加身边
step
.isOnQuest 9831
.goto Shattrath City,54.6,44.2
.turnin 9831 >>交任务: 卡拉赞的钥匙
step
.isQuestAvailable 11550
.goto Shattrath City,53.4,43.6
.accept 11550 >>接任务: 欺诈者降临
step
.itemcount 27480,5
.goto Shattrath City,50.4,45.4
.turnin 10091 >>交任务: 灵魂装置
step
.isOnQuest 10095
.goto Shattrath City,50.4,45.4
.turnin 10095 >>交任务: 深入迷宫
step
.itemcount 34246,10
.goto Shattrath City,49.2,42.4
.turnin 11514 >>交任务: 维持传送门
step
.isOnQuest 11108
.goto Shattrath City,66.6,16.8
.turnin 11108 >>交任务: 伊利丹·怒风大人
step
.itemcount 35231,1
.goto Shattrath City,62.6,36.0
.turnin 11877 >>交任务: 日怒攻击计划
step << Alliance
>>你需要71岁才能完成这个任务，如果你不是71岁就跳过它。
.goto Shattrath City,67.2,34.0
.dailyturnin 11337,11336,11335,11338 >>交PvP Daily
step << Horde
>>你需要71岁才能完成这个任务，如果你不是71岁就跳过它。
.goto Shattrath City,67.0,56.6
.dailyturnin 11341,11340,11339,11342 >>交PvP Daily
step
.itemcount 25719,30
.goto Shattrath City,49.0,18.4
>>Vekax在该地区四处走动
.unitscan Vekax
.accept 10917 >>接任务: 流亡者的交易
.turnin 10917 >>交任务: 流亡者的交易
step
#aldor
.itemcount 25744,8
.goto Shattrath City,54.8,22.6
.accept 10024 >>接任务: 沃雷塔尔的预言
.turnin 10024 >>交任务: 沃雷塔尔的预言
step
.itemcount 33849,15
.goto Shattrath City,61.6,15.8
.turnin 11380 >>交任务: 魔法美味
step
.itemcount 33839,1
.goto Shattrath City,61.6,15.8
.turnin 11377 >>交任务: 甜美的复仇
step
.itemcount 33850,1
.goto Shattrath City,61.6,15.8
.turnin 11381 >>交任务: 灵魂之汤
step
.itemcount 33848,1
.goto Shattrath City,61.6,15.8
.turnin 11379 >>交任务: 超级美味烧烤
step
#scryer
.itemcount 25802,8
.goto Shattrath City,64.4,15.6
.accept 10017 >>接任务: 物资紧张
.turnin 10017 >>交任务: 物资紧张
step
.itemcount 33826,1
.goto Shattrath City,75.0,36.4
.turnin 11369 >>交任务: 悬赏：黑色阔步者的卵
step
.itemcount 33859,1
.goto Shattrath City,75.0,36.4
.turnin 11384 >>交任务: 悬赏：扭木碎片
step
.itemcount 33858,1
.goto Shattrath City,75.0,36.4
.turnin 11382 >>交任务: 悬赏：埃欧努斯的沙漏
step
.itemcount 11363,1
.goto Shattrath City,75.0,36.4
.turnin 11363 >>交任务: 悬赏：刃拳的印记
step
.itemcount 33840,1
.goto Shattrath City,75.0,36.4
.turnin 11375 >>交任务: 悬赏：摩摩尔的低语
step
.itemcount 33833,1
.goto Shattrath City,75.0,36.4
.turnin 11354 >>交任务: 悬赏：纳杉的骑鞭
step
.itemcount 33860,1
.goto Shattrath City,75.0,36.4
.turnin 11386 >>交任务: 悬赏：帕萨雷恩的投影仪
step
.itemcount 33835,1
.goto Shattrath City,75.0,36.4
.turnin 11373 >>交任务: 悬赏：沙法尔的精致饰物
step
.itemcount 33847,1
.goto Shattrath City,75.0,36.4
.turnin 11378 >>交任务: 悬赏：时空猎手的徽记
step
.itemcount 33836,1
.goto Shattrath City,75.0,36.4
.turnin 11374 >>交任务: 悬赏：主教的灵魂宝钻
step
.itemcount 33834,1
.goto Shattrath City,75.0,36.4
.turnin 11372 >>交任务: 悬赏：艾吉斯的冠羽
step
.itemcount 33821,1
.goto Shattrath City,75.0,36.4
.turnin 11368 >>交任务: 悬赏：夸格米拉之心
step
.itemcount 33861,1
.goto Shattrath City,75.0,36.4
.turnin 11388 >>交任务: 悬赏：斯克瑞斯的卷轴
step
.itemcount 33827,1
.goto Shattrath City,75.0,36.4
.turnin 11370 >>交任务: 悬赏：督军的论文
step << Horde
.isQuestTurnedIn 9993
.goto Terokkar Forest,50.0,44.8
.accept 10201 >>接任务: 真相大白
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,49.8,45.2
>>与Grek交谈
.skipgossip
.complete 10201,1
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,50.0,44.8
.turnin 10201 >>交任务: 真相大白
step << Horde
.isQuestTurnedIn 10447
.goto Terokkar Forest,50.0,45.8
.accept 10006 >>接任务: 告知缚地者塔弗格伦
step << Horde
.isOnQuest 10006
.goto Terokkar Forest,44.4,26.2 
.turnin 10006 >>交任务: 告知缚地者塔弗格伦
step << Horde
.isOnQuest 11506
.goto Terokkar Forest,49.8,45.6
.turnin 11506 >>交任务: 奥金顿的幽魂

step << Horde
.isQuestAvailable 10013
.goto Terokkar Forest,67.9,53.5
>>点击建筑物内的卷轴
.accept 10013 >>接任务: 幕后黑手
step << Alliance
.isQuestTurnedIn 10446
.goto Terokkar Forest,57.0,53.6
.accept 10005 >>接任务: 告知缚地者塔弗格伦
step << Alliance
.isOnQuest 11505
.goto Terokkar Forest,55.8,53.8
.turnin 11505 >>交任务: 奥金顿的幽魂
step << Alliance
.isQuestAvailable 10038
.goto Terokkar Forest,57.6,55.6
.accept 10038 >>接任务: 援助列兵维克斯
step << Alliance
.isQuestAvailable 10012
.goto Terokkar Forest,67.9,53.5
>>点击建筑物内的卷轴
.accept 10012 >>接任务: 邪兽人的计划
step
#label start1
.itemcount 30829,1
.goto Terokkar Forest,77.4,38.6
.turnin 10670 >>交任务: 大地之母的眼泪
step
.itemcount 30828,1
.goto Terokkar Forest,77.4,38.6
.turnin 10667 >>交任务: 地下的土壤
step
.goto Terokkar Forest,77.4,38.6
>>接受并交出任务，然后等待他制作剑。如果需要，请跳过此步骤。
.accept 10676 >>接任务: 伊利达雷的斩除者
step
>>需要30秒才能分娩。它有一个相当免费的后续任务。
.isOnQuest 10676
.goto Terokkar Forest,77.4,38.6
.turnin 10676 >>交任务: 伊利达雷的斩除者
step
.isQuestTurnedIn 10676
.goto Terokkar Forest,77.4,38.6
>>在他锻造完刀刃后，接受新的任务
.accept 10679 >>接任务: 淬火
step << Alliance
.isOnQuest 10005
.goto Terokkar Forest,44.4,26.2 
.turnin 10005 >>交任务: 告知缚地者塔弗格伦
step << Horde
.isOnQuest 10013
.goto Terokkar Forest,49.0,44.7
.turnin 10013 >>交任务: 幕后黑手
step << Horde
.isQuestAvailable 10847
.goto Terokkar Forest,49.0,44.7
.accept 10862 >>接任务: 向部落投降
step << Horde
.isQuestAvailable 10039
>>与血精灵对话
.goto Terokkar Forest,48.8,44.6
.accept 10039 >>接任务: 援助斥候奈弗蒂丝
step << Horde
.isOnQuest 10039
.goto Terokkar Forest,39.0,43.8
.turnin 10039 >>交任务: 援助斥候奈弗蒂丝
step << Alliance
.isOnQuest 10038
.goto Terokkar Forest,40.4,36.0
.turnin 10038 >>交任务: 援助列兵维克斯
step
.itemcount 31707,1
.goto Terokkar Forest,37.4,51.2
.use 31707,1 >>使用包中的阴谋命令接受任务
.accept 10880 >>接任务: 秘教的命令
.turnin 10880 >>交任务: 秘教的命令
step
.isOnQuest 10218
.goto Terokkar Forest,39.4,58.4
.turnin 10218 >>交任务: 别人的烂摊子
step
.isOnQuest 10165
.goto Terokkar Forest,39.4,58.4
.turnin 10165 >>交任务: 扫除竞争者
step
.isOnQuest 10097
.goto Terokkar Forest,44.0,65.0
.turnin 10097 >>交任务: 兄弟反目
step
.isOnQuest 10098
.goto Terokkar Forest,44.0,65.0
.turnin 10098 >>交任务: 泰罗克的传说
step
.isQuestTurnedIn 10921
.goto Terokkar Forest,49.8,76.2
.accept 10926 >>接任务: 返回沙塔尔营地
step
.isOnQuest 10926
.goto Terokkar Forest,31.4,75.6
.turnin 10926 >>交任务: 返回沙塔尔营地
step
.isOnQuest 10164
.goto Terokkar Forest,35.0,65.2
.turnin 10164 >>交任务: 一切都会变好的
step << Alliance
.isOnQuest 10012
.goto Terokkar Forest,58.2,54.8
.turnin 10012 >>交任务: 邪兽人的计划
step << Alliance
.isQuestAvailable 10847
.goto Terokkar Forest,57.6,56.0
.accept 10863 >>接任务: 鸦人的秘密
step
.itemcount 32523,1
.goto Terokkar Forest,64.0,66.8
.use 32523 >>使用包中的Ishaal年鉴接受任务
.accept 11021 >>接任务: 伊沙尔的历书
.turnin 11021 >>交任务: 伊沙尔的历书
step
.isQuestTurnedIn 11021
.goto Terokkar Forest,64.0,66.8
.accept 11024 >>接任务: 贫民窟的盟友
step
.itemcount 32388,6
.goto Terokkar Forest,64.0,66.8
.accept 11004 >>接任务: 阴影世界
.turnin 11004 >>交任务: 阴影世界
step
.isOnQuest 11008
.goto Terokkar Forest,64.6,66.6
.turnin 11008 >>交任务: 轰炸斯克提斯
step << Alliance
.isQuestTurnedIn 10612
.goto Shadowmoon Valley,40.8,22.2
.accept 10744 >>接任务: 胜利的消息
step << Alliance
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >>接任务: 诅咒密码 - 第一块碎片
step << Horde
.isQuestTurnedIn 10613
.goto Shadowmoon Valley,27.4,21.2
.accept 10745 >>接任务: 胜利的消息
step << Horde
.isOnQuest 10745
.goto Shadowmoon Valley,28.4,26.4
.turnin 10745 >>交任务: 胜利的消息
step << Horde
.isQuestAvailable 10750
.goto Shadowmoon Valley,28.4,26.4
.accept 10750 >>接任务: 征服之路
step << Horde
.isQuestTurnedIn 10625
.goto Shadowmoon Valley,29.8,27.8
.accept 10633 >>接任务: 塔隆-血魔的传说
step
.isQuestTurnedIn 10780
.goto Shadowmoon Valley,35.4,41.8
>>任务给予者帕沙在路上巡逻
.unitscan Parshah
.accept 10782 >>接任务: 为杖头充能
step
.isOnQuest 10782
.goto Shadowmoon Valley,43.1,44.9
.use 31360 >>立即装备饰品，因为它有CD，然后在祭坛附近使用
.complete 10782,1 
step
.isOnQuest 10782
.goto Shadowmoon Valley,35.4,41.8
>>重新装备你的普通饰品！
.turnin 10782 >>交任务: 为杖头充能
step
.isQuestTurnedIn 10540
.goto Shadowmoon Valley,29.5,50.6
.accept 10541 >>接任务: 诅咒密码 - 第二块碎片
step << Alliance
.isOnQuest 10744
.goto Shadowmoon Valley,35.8,57.6
>>走下大楼的楼梯。
.turnin 10744 >>交任务: 胜利的消息
step << Alliance
.isQuestAvailable 10772
.goto Shadowmoon Valley,36.2,57.0
.accept 10772 >>接任务: 征服之路
step
.isQuestTurnedIn 10578
.goto Shadowmoon Valley,47.5,57.2
.accept 10579 >>接任务: 诅咒密码 - 第三块碎片
step << Alliance
.isOnQuest 10772
.goto Shadowmoon Valley,51.8,61.0
.use 31310 >>一旦你发现路径，就用火炬召唤鹰头狮骑士。你必须在安全的地方接触地面。
.turnin 10772 >>交任务: 征服之路
step << Horde
.isOnQuest 10750
.goto Shadowmoon Valley,51.4,60.4
.use 31108 >>一旦你发现路径，就用火炬召唤飞龙骑士。你必须在安全的地方接触地面。
.turnin 10750 >>交任务: 征服之路
step
.itemcount 31345,1
.goto Shadowmoon Valley,51.4,72.7
.use 31345 >>使用包中的《瓦尔扎雷克日记》接受任务
.accept 10793 >>接任务: 瓦萨雷克的日记：战争的前奏
.turnin 10793 >>交任务: 瓦萨雷克的日记：战争的前奏
step << Horde
.isOnQuest 10633
.goto Shadowmoon Valley,58.2,70.8
.turnin 10633 >>交任务: 塔隆-血魔的传说
step
.itemcount 32427,30
.goto Shadowmoon Valley,66.0,86.4
.accept 11015 >>接任务: 灵翼水晶
.turnin 11015 >>交任务: 灵翼水晶
step
.isOnQuest 11020
.goto Shadowmoon Valley,66.0,86.4
.turnin 11020 >>交任务: 缓慢的死亡
step
.itemcount 32506,1
.goto Shadowmoon Valley,66.0,86.4
.accept 11049 >>接任务: 寻找灵翼龙卵
.turnin 11049 >>交任务: 寻找灵翼龙卵
step
.itemcount 32464,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill mining,<350,1
>>你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11018 >>接任务: 虚空矿石
.turnin 11018 >>交任务: 虚空矿石
step
.itemcount 32468,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill herbalism,<350,1
>>你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11017 >>接任务: 灵尘花粉
.turnin 11017 >>交任务: 灵尘花粉
step
.itemcount 32470,435
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill skinning,<350,1
>>你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11016 >>接任务: 虚空矿洞剥石者的外皮
.turnin 11016 >>交任务: 虚空矿洞剥石者的外皮
step
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly,<0,1
.accept 11053 >>接任务: 起立，督工！
step
.isOnQuest 11053
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,friendly,<0,1
.turnin 11053 >>交任务: 起立，督工！
step
.goto Shadowmoon Valley,66.2,86.4
.reputation 1015,friendly<0,1
.accept 11075 >>接任务: 灵翼矿洞
step
.isQuestAvailable 11084
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,honored,<0,1
.accept 11084 >>接任务: 立正，队长！
step
.isOnQuest 11084
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,honored,<0,1
.turnin 11084 >>交任务: 立正，队长！
step
.isQuestAvailable 11092
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,revered,<0,1
.accept 11092 >>接任务: 你好，指挥官！
step
.isOnQuest 11092
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.turnin 11092 >>交任务: 你好，指挥官！
step
#aldor
.isQuestAvailable 11099
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11099 >>接任务: 把他们都干掉！
step
#scryer
.isQuestAvailable 11094
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11094 >>接任务: 把他们都干掉！
step
.goto Shadowmoon Valley,66.0,86.4
.itemcount 32509,10
.turnin 11035 >>交任务: 危险的天空
step
.isOnQuest 11075
.goto Shadowmoon Valley,63.0,87.8
.turnin 11075 >>交任务: 灵翼矿洞
step
.itemcount 32724,1
>>打开你的污泥覆盖物，直到你得到一个黑血逃生计划
.collect 32726,1,11081,1
step
.itemcount 32726,1
.goto Shadowmoon Valley,63.0,87.8
.use 32726 >>使用包中的黑血逃生计划接受任务
.accept 11081 >>接任务: 暗血大逃亡
.turnin 11081 >>交任务: 暗血大逃亡
step
#scryer
.isOnQuest 11094
.goto Shadowmoon Valley,56.2,59.6
.reputation 1015,revered,<0,1
.turnin 11094 >>交任务: 把他们都干掉！
step
.isOnQuest 10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10707 >>交任务: 阿塔玛平台
step
.isOnQuest 10679
.goto Shadowmoon Valley,51.9,40.2
.use 30875 >>在熔岩池中使用锻造伊利达里诅咒之刃
.complete 10679,1
step << Horde
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >>接任务: 诅咒密码 - 第一块碎片
step
#aldor
.isOnQuest 11099
.goto Shadowmoon Valley,62.6,28.4
.reputation 1015,revered
.turnin 11099 >>交任务: 把他们都干掉！
step
.isOnQuest 10523
.goto Shadowmoon Valley,53.9,23.4
.turnin 10523 >>交任务: 诅咒密码 - 第一块碎片
step
.isOnQuest 10541
.goto Shadowmoon Valley,53.9,23.4
.turnin 10541 >>交任务: 诅咒密码 - 第二块碎片
step
.isOnQuest 10579
.goto Shadowmoon Valley,53.9,23.4
.turnin 10579 >>交任务: 诅咒密码 - 第三块碎片
step
.isOnQuest 10679
.goto Terokkar Forest,77.4,38.6
.turnin 10679 >>交任务: 淬火
step
.itemcount 23580,1
.goto Hellfire Peninsula,28.8,81.4
.use 23580 >>使用包中的Avruu's Orb接受任务
.accept 9418 >>接任务: 亚维鲁的宝珠
.turnin 9418 >>交任务: 亚维鲁的宝珠
step << Alliance
.itemcount 23848,1
.goto Hellfire Peninsula,24.0,72.2
.reputation 946,friendly,<0,1 >>这一步你至少需要友好地站着，保持荣誉。
.accept 9563 >>接任务: 米伦的信任
.turnin 9563 >>交任务: 米伦的信任
step << Horde
.isQuestTurnedIn 9400
.goto Hellfire Peninsula,33.6,43.6
.accept 9401 >>接任务: 奇怪的武器
step << Horde
.isOnQuest 9401
.goto Hellfire Peninsula,55.0,36.0
.turnin 9401 >>交任务: 奇怪的武器
step << Horde
.isQuestTurnedIn 9401
.goto Hellfire Peninsula,55.0,36.0
.accept 9405 >>接任务: 酋长的命令
step << Horde
.itemcount 29590,1
.goto Hellfire Peninsula,55.0,36.0
.use 29590 >>使用背包中的燃烧军团任务来接受任务
.accept 10393 >>接任务: 邪恶的计划
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10393 >>交任务: 邪恶的计划
step << Horde
.itemcount 23892,1
.goto Hellfire Peninsula,55.0,36.0
.use 23892 >>接受库存中不祥之信的任务
.accept 9588 >>接任务: 黑暗之潮
step
.isOnQuest 9588
.goto Hellfire Peninsula,55.0,36.0
.turnin 9588 >>交任务: 黑暗之潮
step << Horde
.itemcount 31241,1
.goto Hellfire Peninsula,55.0,36.0
.use 31241 >>接任务: 邪恶的无毛怪
.accept 10755 >>接任务: 堡垒的钥匙
step << Horde
.isOnQuest 10755
.goto Hellfire Peninsula,55.0,36.0
.turnin 10755 >>交任务: 堡垒的钥匙
step << Horde
.isQuestTurnedIn 10755
.goto Hellfire Peninsula,55.0,36.0
.accept 10756 >>接任务: 罗霍克大师
step << Horde
.itemcount 32386,1
.goto Hellfire Peninsula,55.0,36.0
.use 32386 >>使用Matheridon的头接受任务
.accept 11003 >>接任务: 玛瑟里顿之死
.turnin 11003 >>交任务: 玛瑟里顿之死
step << Horde
.itemcount 23723,1
.goto Hellfire Peninsula,55.0,36.0
.turnin 9495 >>交任务: 酋长的意志
step << Horde
.isOnQuest 9405
.goto Hellfire Peninsula,54.2,37.8
.turnin 9405 >>交任务: 酋长的命令
step << Horde
.isOnQuest 10756
.goto Hellfire Peninsula,53.2,38.2
.turnin 10756 >>交任务: 罗霍克大师
step << Horde
.isQuestTurnedIn 10756
.goto Hellfire Peninsula,53.2,38.2
.accept 10757 >>接任务: 罗霍克的要求
.turnin 10757 >>交任务: 罗霍克的要求
step << Alliance
.isOnQuest 9493
.goto Hellfire Peninsula,56.8,62.6
.turnin 9493 >>交任务: 邪部落的荣耀
step << Alliance
.isQuestTurnedIn 10047
.goto Hellfire Peninsula,56.6,66.6
.accept 10093 >>接任务: 塔哈玛特神殿
step << Alliance
.itemcount 29590,1
.goto Hellfire Peninsula,56.6,66.4
.use 29590 >>使用背包中的燃烧军团任务来接受任务
.accept 10395 >>接任务: 邪恶的信件
step << Alliance
.isOnQuest 10395
.goto Hellfire Peninsula,56.6,66.4
.turnin 10395 >>交任务: 邪恶的信件
step << Alliance
.itemcount 23890,1
.goto Hellfire Peninsula,56.6,66.4
.use 23890 >>使用包中的不祥信接受任务
.accept 9587 >>接任务: 黑暗之潮
step << Alliance
.isOnQuest 9587
.goto Hellfire Peninsula,56.6,66.4
.turnin 9587 >>交任务: 黑暗之潮
step << Alliance
.itemcount 32385,1
.goto Hellfire Peninsula,56.6,66.4
.use 32385 >>使用Matheridon的头接受任务
.accept 11002 >>接任务: 玛瑟里顿之死
.turnin 11002 >>交任务: 玛瑟里顿之死
step << Alliance
.itemcount 31239,1
.goto Hellfire Peninsula,56.6,66.6
.use 31239 >>接任务: 你叫什么名字名字？
.accept 10754 >>接任务: 堡垒的钥匙
step << Alliance
.isOnQuest 10754
.goto Hellfire Peninsula,56.6,66.6
.turnin 10754 >>交任务: 堡垒的钥匙
step << Alliance
.isQuestAvailable 10762
.goto Hellfire Peninsula,56.6,66.6
.accept 10762 >>接任务: 达姆菲大师
step << Alliance
.isOnQuest 9492
.goto Hellfire Peninsula,56.6,66.4
.turnin 9492 >>交任务: 扭转战局
step << Alliance
.isOnQuest 9494
.goto Hellfire Peninsula,53.8,65.6
.turnin 9494 >>交任务: 邪能灰烬
step << Alliance
.isOnQuest 10762
.goto Hellfire Peninsula,51.2,60.2
.turnin 10762 >>交任务: 达姆菲大师
step << Alliance
.isQuestTurnedIn 10762
.goto Hellfire Peninsula,51.2,60.2
.accept 10763 >>接任务: 达姆菲的要求
.turnin 10763 >>交任务: 达姆菲的要求
step
.isOnQuest 11515
.goto Hellfire Peninsula,58.2,17.6
.turnin 11515 >>交任务: 血债血偿
step
.isOnQuest 11516
.goto Hellfire Peninsula,58.2,17.6
.turnin 11516 >>交任务: 轰炸传送门
step << Alliance
.isQuestTurnedIn 9390
.goto Hellfire Peninsula,26.8,37.6
>>与尸体对话
.accept 9423 >>接任务: 返回欧巴迪身边
step << Alliance
.isOnQuest 10093
.goto Hellfire Peninsula,23.4,36.6
.turnin 10093 >>交任务: 塔哈玛特神殿
step << Alliance
.isQuestAvailable 9423
.goto Hellfire Peninsula,23.0,40.4
.turnin 9423 >>交任务: 返回欧巴迪身边
step
.itemcount 23338,1
.goto Hellfire Peninsula,15.6,52.2
.use 23338 >>使用包中的腐蚀皮套接受任务
.accept 9373 >>接任务: 遗失的信件
.turnin 9373 >>交任务: 遗失的信件
step
.itemcount 29476,1
.goto Hellfire Peninsula,15.6,52.2
.use 29476 >>使用包中的深红水晶碎片接受任务
.accept 10134 >>接任务: 火红水晶中的线索
.turnin 10134 >>交任务: 火红水晶中的线索
step << Horde
.isQuestTurnedIn 9774
.goto Zangarmarsh,85.2,54.6
.accept 9771 >>接任务: 寻找斥候尤尔巴
step << Horde
.isQuestAvailable 9775
.goto Zangarmarsh,85.2,54.6
.accept 9775 >>接任务: 向暗影猎手德恩加报到
step << Horde
.itemcount 24484,1
.goto Zangarmarsh,85.0,54.0
.use 24484 >>使用你的库存中的枯萎的Basidium来接受任务
.accept 9828 >>接任务: 枯萎的孢芽
.turnin 9828 >>交任务: 枯萎的孢芽
step << Horde
.isOnQuest 9771
.goto Zangarmarsh,80.8,36.2
.turnin 9771 >>交任务: 寻找斥候尤尔巴
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.accept 9724 >>接任务: 通知塞纳里奥议会
step
.itemcount 24367,1
.goto Zangarmarsh,78.4,62.0
.use 24367 >>用你包里的瓦什女士的命令接受任务
.accept 9764 >>接任务: 瓦丝琪的命令
.turnin 9764 >>交任务: 瓦丝琪的命令
step
.isQuestTurnedIn 9764
.goto Zangarmarsh,78.4,62.0
.accept 9765 >>接任务: 战争准备
.turnin 9765 >>交任务: 战争准备
step
.isQuestAvailable 9697
.goto Zangarmarsh,78.6,63.2
.reputation 942,friendly,<0,1 >>如果你对塞纳里奥探险队不够友好，请跳过这一步。
.accept 9697 >>接任务: 观察者莉萨奥
step
.itemcount 24401,10
.goto Zangarmarsh,80.2,64.2
.accept 9802 >>接任务: 赞加沼泽的植物
.turnin 9802 >>交任务: 赞加沼泽的植物
step
.isQuestAvailable 9785
.goto Zangarmarsh,80.4,64.6
.accept 9785 >>接任务: 古树的祝福
step
.isOnQuest 9785
.goto Zangarmarsh,81.0,64.0,20,0
.goto Zangarmarsh,79.8,64.4
.skipgossip
>>与古阿申和凯利斯交谈以获得他们的标记。
.unitscan Ashyen
.unitscan Keleth
.complete 9785,1
.complete 9785,2
step
.isOnQuest 9785
.goto Zangarmarsh,80.4,64.6
.turnin 9785 >>交任务: 古树的祝福
step << skip
.isQuestAvailable 9957
.goto Zangarmarsh,78.6,63.0
.accept 9957 >>接任务: 塞纳里奥树林出事了？
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.turnin 9724 >>交任务: 通知塞纳里奥议会
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.accept 9732 >>接任务: 返回沼泽
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.turnin 9732 >>交任务: 返回沼泽
step << Alliance
.itemcount 24483,1
.goto Zangarmarsh,68.6,48.8
.use 24483 >>使用你的库存中的枯萎的Basidium来接受任务
.accept 9827 >>接任务: 枯萎的孢芽
.turnin 9827 >>交任务: 枯萎的孢芽
step
.isQuestTurnedIn 10231
.goto Shattrath City,43.6,29.6
>>如果“肮脏的”拉里死了，跳过这一步。
.accept 10251 >>接任务: 主人的伟大设计？
step << Alliance
.isOnQuest 10863
.goto Shattrath City,52.6,20.8
.turnin 10863 >>交任务: 鸦人的秘密
step << Horde
.isOnQuest 10862
.goto Shattrath City,52.6,20.8
.turnin 10862 >>交任务: 向部落投降
step
.isQuestTurnedIn 10009
.goto Shattrath City,77.2,34.8
.accept 10010 >>接任务: 就这么简单？
step
#completewith isleofquel
.goto Shattrath City,48.7,42.2
.zone 122 >>从沙塔斯的门户到奎尔达纳斯岛
step
.isOnQuest 11521
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11521 >>交任务: 继续寻根
step
.isOnQuest 11546
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11546 >>交任务: 开始营业
step
.isOnQuest 11541
.goto Isle of Quel'Danas,51.4,32.6
.turnin 11541 >>交任务: 解救绿鳃奴隶
step
.isOnQuest 11550
.goto Isle of Quel'Danas,50.2,28.2
.turnin 11550 >>交任务: 欺诈者降临
step
.isOnQuest 11523
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11523 >>交任务: 激活结界！
step
.isOnQuest 11525
.goto Isle of Quel'Danas,47.2,30.6
.turnin 11525 >>交任务: 转化更多奥术守卫
step
.isOnQuest 11533
.goto Isle of Quel'Danas,47.6,35.2
.turnin 11533 >>交任务: 继续空袭
step
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
>>如果你不打算提交祖拉曼或奥特兰山谷任务，使用它给你的卷轴奖励返回沙塔斯。
.turnin 11547 >>交任务: 魔网能量线的读数
step
.isOnQuest 11536
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11536 >>交任务: 不要停下......
step
.itemcount 34501,5
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11544 >>交任务: 阿塔玛军备
step
.isOnQuest 11542
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11542 >>交任务: 拦截援军
step
.isOnQuest 11543
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11543 >>交任务: 拒敌港外
step
.isOnQuest 11539
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11539 >>交任务: 占领港口
step
#label isleofquel
.isOnQuest 11540
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11540 >>交任务: 击溃晨锋部队
step
.itemcount 33102,1
>>这一步需要召唤一个幽灵之地和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.goto Ghostlands,70.4,67.8
.use 33102 >>用祖金之血接受任务
.accept 11178 >>接任务: 督军之血
.turnin 11178 >>交任务: 督军之血
.accept 11163 >>接任务: 对不起，我是卧底
step
.isQuestTurnedIn 11178
.goto Ghostlands,70.6,68.2
.turnin 11163 >>交任务: 对不起，我是卧底
step << Alliance
.isOnQuest 7141
.goto Alterac Mountains,40.6,79.8
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7141 >>交任务: 奥特兰克的战斗
step << Alliance
.isQuestAvailable 8271
.goto Alterac Mountains,40.6,79.8
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 8271 >>交任务: 雷矛英雄
step << Alliance
.isQuestAvailable 7169
.goto Alterac Mountains,39.6,81.2
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7169 >>交任务: 卫兵的尊敬
step << Alliance
.isQuestAvailable 7170
.goto Alterac Mountains,39.6,81.2
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7170 >>交任务: 赢得尊敬
step << Alliance
.isQuestAvailable 7171
.goto Alterac Mountains,39.6,81.2
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7171 >>交任务: 传说的英雄
step << Alliance
.isQuestAvailable 7172
.goto Alterac Mountains,39.6,81.2
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7172 >>交任务: 命令之眼
step << Horde
.isOnQuest 7142
.goto Alterac Mountains,63.0,60.0
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7142 >>交任务: 为奥特兰克而战
step << Horde
.isQuestAvailable 8272
.goto Alterac Mountains,63.0,60.0
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 8272 >>交任务: 霜狼英雄
step << Horde
.isQuestAvailable 7164
.goto Alterac Mountains,62.2,58.9
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7164 >>交任务: 卫兵的尊敬
step << Horde
.isQuestAvailable 7165
.goto Alterac Mountains,62.2,58.9
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7165 >>交任务: 赢得尊敬
step << Horde
.isQuestAvailable 7166
.goto Alterac Mountains,62.2,58.9
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7166 >>交任务: 传说的英雄
step << Horde
.isQuestAvailable 7167
.goto Alterac Mountains,62.2,58.9
>>这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7167 >>交任务: 命令之眼
step
#completewith postav
.zoneskip Ghostlands,1
.zone Shattrath City >>前往: 沙塔斯城
>>港口至沙塔斯。请勿使用炉缸 << !Shaman
>>沙塔斯港口或港口 << Shaman
step
#completewith postav
.zoneskip Alterac Mountains,1
.zone Shattrath City >>前往: 沙塔斯城
>>港口至沙塔斯。请勿使用炉缸 << !Shaman
>>沙塔斯港口或港口 << Shaman
step
#completewith postav
.zoneskip Isle of Quel'Danas,1
.zone Shattrath City >>前往: 沙塔斯城
>>港口至沙塔斯。请勿使用炉缸 << !Shaman
>>沙塔斯港口或港口 << Shaman
step
#sticky
#label postav
.zone Shattrath City >>前往: 沙塔斯城, 如果您已经在外域，请手动跳过此步骤
step << Horde
.isQuestTurnedIn 9928
.goto Nagrand,73.8,62.6
.accept 9934 >>接任务: 回到加拉达尔
step << Alliance
.isQuestTurnedIn 9932
.goto Nagrand,73.8,62.6
.accept 9933 >>接任务: 回到塔拉
step
.isOnQuest 10251
.goto Nagrand,51.8,56.8
.turnin 10251 >>交任务: 主人的伟大设计？
step << Horde
.isOnQuest 9934
.goto Nagrand,55.4,37.6
.turnin 9934 >>交任务: 回到加拉达尔
step << Horde
.isOnQuest 9937
.goto Nagrand,55.8,37.8
.turnin 9937 >>交任务: 通缉：饥饿者杜恩
step << Alliance
.isOnQuest 11502
.goto Nagrand,55.8,73.6
.turnin 11502 >>交任务: 保卫哈兰
step << Alliance
.isOnQuest 9933
.goto Nagrand,55.4,68.8
.turnin 9933 >>交任务: 回到塔拉
step << Alliance
.isOnQuest 9938
.goto Nagrand,55.8,37.8
.turnin 9938 >>交任务: 通缉：饥饿者杜恩
step << Alliance
.itemcount 24559,1
.goto Nagrand,55.4,68.8
.use 24559 >>使用库存中的黑血入侵计划接受任务
.accept 9871 >>接任务: 暗血入侵者
.turnin 9871 >>交任务: 暗血入侵者
step << Alliance
.itemcount 25433,10
.goto Nagrand,54.8,70.8
.accept 10476 >>接任务: 强悍的敌人
.turnin 10476 >>交任务: 强悍的敌人
step << Horde
.goto Nagrand,57.0,34.8
>>在小屋周围找到Drakia夫人
.unitscan Matron Drakia
.accept 9944 >>接任务: 失踪的玛格汉车队
step
.goto Nagrand,31.4,57.6
.reputation 933,neutral,<0,1
.itemcount 25416,10
.accept 9882 >>接任务: 偷盗贼的东西......能算偷么？
.turnin 9882 >>交任务: 偷盗贼的东西......能算偷么？
step
.goto Nagrand,31.6,56.8
.reputation 933,neutral,<0,1
.itemcount 25463,3
>>交上一个装满象牙的脑袋，直到你友好为止。总共应该有9个营业额。
.accept 9914 >>接任务: 象牙生意
.turnin 9914 >>交任务: 象牙生意
step
.goto Nagrand,31.4,57.6
.reputation 933,friendly,<0,1
.itemcount 25433,10
.accept 9893 >>接任务: 黑曜石作战念珠
.turnin 9893 >>交任务: 黑曜石作战念珠
step << Horde
>>如果由联盟控制，请跳过此步骤。
.itemcount 26042,10
.goto Nagrand,41.2,44.3
.accept 10074 >>接任务: 沃舒古水晶尘
.turnin 10074 >>交任务: 沃舒古水晶尘
step << Horde
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >>交任务: 就这么简单？
step << Horde
.isOnQuest 10649
.goto Nagrand,27.4,43.0
.turnin 10649 >>交任务: 恶魔名册
step << Horde
.isOnQuest 9944
.goto Nagrand,32.2,36.2
.turnin 9944 >>交任务: 失踪的玛格汉车队
step << Horde
.isQuestTurnedIn 9865
.goto Nagrand,32.4,36.0
.accept 9866 >>接任务: 他要游历世界......
step << Horde
.isOnQuest 11503
.goto Nagrand,52.8,36.0
.turnin 11503 >>交任务: 新仇旧怨
step << Horde
.isOnQuest 9866
.goto Nagrand,54.8,39.8
.turnin 9866 >>交任务: 他要游历世界......
step << Horde
.itemcount 24558,1
.goto Nagrand,55.4,37.6
.use 24558 >>使用库存中的黑血入侵计划接受任务
.accept 9872 >>接任务: 暗血入侵者
.turnin 9872 >>交任务: 暗血入侵者
step << Horde
.isQuestAvailable 9870
.goto Nagrand,55.6,37.8
>>在镇上找到元素师Yal'hah
.unitscan Elementalist Yal'hah
.accept 9870 >>接任务: 元素王座
step << Horde
.itemcount 25433,10
.goto Nagrand,55.8,37.8
.accept 10479 >>接任务: 证明你的力量
.turnin 10479 >>交任务: 证明你的力量
step << Horde
.isOnQuest 9870
.goto Nagrand,60.6,22.2
.turnin 9870 >>交任务: 元素王座
step << Horde
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >>交任务: 侵占者古罗克
step << Horde
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >>使用库存中的啸风接受任务
.accept 9861 >>接任务: 呼嚎之风
.turnin 9861 >>交任务: 呼嚎之风
step << Alliance
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >>交任务: 就这么简单？
step << Alliance
.isOnQuest 10649
.goto Nagrand,24.7,43.0
.turnin 10649 >>交任务: 恶魔名册
step << Alliance
>>如果它被部落控制，跳过这一步。
.itemcount 26043,10
.goto Nagrand,41.2,44.2
.accept 10076 >>接任务: 沃舒古水晶尘
.turnin 10076 >>交任务: 沃舒古水晶尘
step << Alliance
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >>使用库存中的啸风接受任务
.accept 9861 >>接任务: 呼嚎之风
.turnin 9861 >>交任务: 呼嚎之风
step << Alliance
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >>交任务: 侵占者古罗克
step
.isOnQuest 9977
.goto Nagrand,42.8,20.6
.turnin 9977 >>交任务: 鲜血竞技场：终极挑战
step
.isOnQuest 9697
.goto Zangarmarsh,23.2,66.2
>>如果她不在这里，可能有人最近提交了一个任务，导致她消失。如果这个地方人满为患，不要等她，跳过这一步。
.turnin 9697 >>交任务: 观察者莉萨奥
step
.isQuestAvailable 9697
.goto Zangarmarsh,23.2,66.2
.accept 9701 >>接任务: 观察孢子人
step
.itemcount 24291,6
.goto Zangarmarsh,19.0,62.6
.accept 9743 >>接任务: 天敌
.turnin 9743 >>交任务: 天敌
step
.itemcount 24290,10
.goto Zangarmarsh,19.0,62.6
.accept 9739 >>接任务: 孢子人的困境
.turnin 9739 >>交任务: 孢子人的困境
step
.isQuestAvailable 9919
.goto Zangarmarsh,19.0,63.6
.reputation 970,neutral,<0,1 >>你必须对斯波雷加保持中立才能接受这个任务
.accept 9919 >>接任务: 孢子村
step
.isOnQuest 9701
.goto Zangarmarsh,15.3,61.9
>>探索该地区。
.complete 9701,1
.complete 9701,2
step
.isOnQuest 9919
.goto Zangarmarsh,19.6,52.0
.turnin 9919 >>交任务: 孢子村
step
#completewith next
.goto Zangarmarsh,19.0,62.6
.reputation 970,friendly >>完成转向沼泽主卷须或成熟孢子囊，直到你友好。
step
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.itemcount 24245,10
.accept 9808 >>接任务: 亮顶蘑菇
.turnin 9808 >>交任务: 亮顶蘑菇
step
.itemcount 24246,5
.goto Zangarmarsh,19.5,50.1
.reputation 970,friendly,<0,1
.accept 9715 >>接任务: 我要红色木槿！
.turnin 9715 >>交任务: 我要红色木槿！
step
.itemcount 24449,6
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.accept 9806 >>接任务: 成熟的孢子
.turnin 9806 >>交任务: 成熟的孢子
step
#label sporenomore
.itemcount 25459,1
.goto Zangarmarsh,23.2,66.2
.use 25459 >>使用库存中的“数”Ungula的下颌骨来接受任务
.accept 9911 >>接任务: 沼泽中的伯爵
.turnin 9911 >>交任务: 沼泽中的伯爵
step
.isOnQuest 9701
.goto Zangarmarsh,23.2,66.2
.turnin 9701 >>交任务: 观察孢子人
step << Horde
.isOnQuest 9775
.goto Zangarmarsh,30.6,50.8
>>他在小屋的二楼
.turnin 9775 >>交任务: 向暗影猎手德恩加报到
step << Horde
.isQuestAvailable 9795
.goto Zangarmarsh,30.6,50.8
.accept 9795 >>接任务: 食人魔的威胁
step << skip 
.isQuestTurnedIn 9968
.goto Terokkar Forest,44.4,26.2
.turnin 9957 >>交任务: 塞纳里奥树林出事了？
step << Alliance
.isQuestAvailable 9794
.goto Zangarmarsh,41.2,28.6
.accept 9794 >>接任务: 禁止拆阅
step
.isOnQuest 9738
.goto Zangarmarsh,52.2,36.0
>>进入湖中央的水下水库
.turnin 9738 >>交任务: 失踪的同伴
step
.isOnQuest 9763
.goto Zangarmarsh,52.2,36.0
.turnin 9763 >>交任务: 督军的末日
step << Alliance
.isOnQuest 9794
.goto Blade's Edge Mountains,36.0,67.8
.turnin 9794 >>交任务: 禁止拆阅
step << Alliance
.itemcount 29443,11
.goto Blade's Edge Mountains,37.4,64.6
.accept 10511 >>接任务: 奇怪的美酒
.turnin 10511 >>交任务: 奇怪的美酒
step << Alliance
.isQuestAvailable 10581
.goto Blade's Edge Mountains,36.6,66.4
.accept 10580 >>接任务: 侏儒都去哪里了？
step
.isOnQuest 11000
.goto Blade's Edge Mountains,55.4,44.9
.turnin 11000 >>交任务: 磨魂者
step
.isQuestTurnedIn 11000
.goto Blade's Edge Mountains,55.4,44.9
.accept 11009 >>接任务: 食人魔的天堂
step << Horde
.isOnQuest 10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10742 >>交任务: 摊牌
step << Alliance
.isOnQuest 10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10806 >>交任务: 摊牌
step << Horde
.isOnQuest 9795
.goto Blade's Edge Mountains,51.8,57.8
.turnin 9795 >>交任务: 食人魔的威胁
step
.isOnQuest 11009
.goto Blade's Edge Mountains,28.7,57.4
.turnin 11009 >>交任务: 食人魔的天堂
step
.itemcount 32569,5
.goto Blade's Edge Mountains,28.8,57.4
.accept 11025 >>接任务: 埃匹希斯水晶
.turnin 11025 >>交任务: 埃匹希斯水晶
step
.itemcount 32598,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11030 >>接任务: 未来的天空卫队游侠
.turnin 11030 >>交任务: 未来的天空卫队游侠
step
.itemcount 32601,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11061 >>接任务: 父亲的职责
.turnin 11061 >>交任务: 父亲的职责
step << Alliance
.isOnQuest 10580
.goto Blade's Edge Mountains,55.0,72.8
.turnin 10580 >>交任务: 侏儒都去哪里了？
step << Alliance
.isQuestTurnedIn 10580
.goto Blade's Edge Mountains,55.0,72.8
.accept 10581 >>接任务: 废话连篇
step << Alliance
.isOnQuest 10581
.goto Blade's Edge Mountains,60.4,69.0
.turnin 10581 >>交任务: 废话连篇
step
.itemcount 31384,1
.goto Blade's Edge Mountains,62.6,40.2
.use 31384
.accept 10810 >>接任务: 损坏的面具
.turnin 10810 >>交任务: 损坏的面具
.accept 10812 >>接任务: 神秘的面具
step
.itemcount 31489,1
.goto Blade's Edge Mountains,62.0,39.4
.use 31489 >>使用你库存中的狮鹫之珠接受任务
.accept 10825 >>接任务: 神秘的宝珠
.turnin 10825 >>交任务: 神秘的宝珠
step
.isQuestAvailable 10682
.goto Blade's Edge Mountains,62.0,39.4
.accept 10682 >>接任务: 该谈判了......
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.7,44.0,80,0
.goto Blade's Edge Mountains,58.5,39.4,80,0
.goto Blade's Edge Mountains,62.0,32.1
.line Blade's Edge Mountains,63.0,45.8,58.4,38.6,63.0,27.2
.unitscan Overseer Nuaar
>>上上下下找监督努尔，然后和他说话
.skipgossip
.complete 10682,1
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.0,39.4
.turnin 10682 >>交任务: 该谈判了......
step
.isOnQuest 10812
.goto Blade's Edge Mountains,61.6,38.4
>>任务给予者在城市里绕着我走了一圈。
.turnin 10812 >>交任务: 神秘的面具
step
.isQuestTurnedIn 10819
.goto Blade's Edge Mountains,61.6,38.4
.accept 10819 >>接任务: 魔誓防毒面具
step
.isOnQuest 10819
.goto Blade's Edge Mountains,73.3,40.1
.use 31366 >>戴上恶棍防毒面具。
.turnin 10819 >>交任务: 魔誓防毒面具
step << Horde
.itemcount 31670,3
.goto Blade's Edge Mountains,76.0,60.2
.accept 10860 >>接任务: 莫克纳萨的美味
.turnin 10860 >>交任务: 莫克纳萨的美味

step
.isQuestAvailable 10317
.goto Netherstorm,34.6,37.8
.accept 10317 >>接任务: 对付工头
step
.isOnQuest 10317
.goto Netherstorm,26.4,42.2
.turnin 10317 >>交任务: 对付工头
step
.isOnQuest 9631
.goto Netherstorm,32.2,63.6
.turnin 9631 >>交任务: 同事的帮助
step
.isQuestTurnedIn 10186
.goto Netherstorm,32.7,64.9
.accept 10225 >>接任务: 向主工程师汇报
step
.isOnQuest 10225
.goto Netherstorm,32.4,66.6
.turnin 10225 >>交任务: 向主工程师汇报
step
#aldor
.isQuestTurnedIn 10407
.goto Netherstorm,32.0,64.2
.accept 10410 >>接任务: 伊沙娜的帮助
step
#scryer
.isQuestTurnedIn 10508
.goto Netherstorm,32.0,64.0
.accept 10509 >>接任务: 无上的荣耀
step
.isQuestTurnedIn 10248
.goto Netherstorm,37.2,63.8
.accept 10249 >>接任务: 去找火箭主管！
step
.isOnQuest 10249
.goto Netherstorm,32.6,64.8
.turnin 10249 >>交任务: 去找火箭主管！
step
.isQuestTurnedIn 10312
.goto Netherstorm,57.4,86.2
.accept 10316 >>接任务: 寻找证据
step
>>进入塔内，到达塔顶。
.itemcount 28769,1
.goto Netherstorm,58.2,86.4
.turnin 10257 >>交任务: 夺回钥石
step
.isQuestAvailable 10334
.goto Netherstorm,57.6,85.0
.accept 10334 >>接任务: 贝希的铃铛
step
.itemcount 29233,1
.goto Netherstorm,56.9,86.8
.use 29233 >>使用Dathric之刃接受任务
.accept 10182 >>接任务: 战斗法师达斯利克
step
.itemcount 29235,1
.goto Netherstorm,56.4,87.8
.use 29235 >>使用Luminrath的斗篷接受任务
.accept 10306 >>接任务: 咒术师鲁米拉斯
step
.itemcount 29236,1
.goto Netherstorm,55.5,87.0
.use 29236 >>使用科林的帽子接受任务
.accept 10307 >>接任务: 考利恩·霜纹
step
.itemcount 29234,1
.goto Netherstorm,55.5,86.5
.use 29234 >>使用Belmara的Tome接受任务
.accept 10305 >>接任务: 防御法师贝尔玛拉
step
.isOnQuest 10182
.goto Netherstorm,56.9,86.8
.use 28351 >>使用任务物品将拿督之刃放置在市政厅内的武器架上
.complete 10182,1
step
.isOnQuest 10307
.goto Netherstorm,55.5,87.0
.use 28353 >>使用任务物品将科琳的帽子放在房间的搁脚柜内
.complete 10307,1
step
.isOnQuest 10305
.goto Netherstorm,55.5,86.5
.use 28336 >>使用任务物品将Belmara的Tome放在她家的书架上
.complete 10305,1
step
.isOnQuest 10306
.goto Netherstorm,56.4,87.8
.use 28352 >>使用任务物品将Luminrath的披风放置在他家的梳妆台上
.complete 10306,1
step
.isOnQuest 10307
.goto Netherstorm,57.4,86.2
.turnin 10307 >>交任务: 考利恩·霜纹
step
.isOnQuest 10182
.goto Netherstorm,57.4,86.2
.turnin 10182 >>交任务: 战斗法师达斯利克
step
.isOnQuest 10305
.goto Netherstorm,57.4,86.2
.turnin 10305 >>交任务: 防御法师贝尔玛拉
step
.isOnQuest 10306
.goto Netherstorm,57.4,86.2
.turnin 10306 >>交任务: 咒术师鲁米拉斯
step
.isOnQuest 10334
.goto Netherstorm,59.2,78.8
.turnin 10334 >>交任务: 贝希的铃铛
step
.isOnQuest 10316
.goto Netherstorm,60.3,78.0
.turnin 10316 >>交任务: 寻找证据
step
.isQuestTurnedIn 10418
.goto Netherstorm,46.4,56.4
.accept 10423 >>接任务: 前往风暴尖塔
step
.isQuestTurnedIn 10433
.goto Netherstorm,46.4,56.4
.accept 10434 >>接任务: 两个同伴
step
>>点击收发器吊舱
.isOnQuest 10408
.goto Netherstorm,56.8,38.6
.turnin 10408 >>交任务: 节点之王萨哈达尔
step
.itemcount 29738,1
.goto Netherstorm,59.2,32.4
.use 29738 >>使用库存中的虚空恐怖软泥小瓶接受任务
.accept 10413 >>接任务: 虚空的软泥
.turnin 10413 >>交任务: 虚空的软泥
step
.isOnQuest 10439
.goto Netherstorm,60.0,31.8
.turnin 10439 >>交任务: 诸界吞噬者迪门修斯
step
.isOnQuest 10423
.goto Netherstorm,43.6,35.0
.turnin 10423 >>交任务: 前往风暴尖塔
step
.isOnQuest 10434
.goto Netherstorm,44.8,36.6
.turnin 10434 >>交任务: 两个同伴
step
.isQuestTurnedIn 10276
.goto Netherstorm,45.8,36.0
>>接受任务后，穿过左边的紫色圆圈传送带传送到沙塔斯
.accept 10280 >>接任务: 送往沙塔斯的特殊货物
step
#completewith shat
.zone Shattrath City >>前往: 沙塔斯城,如果你有时间之穴任务要交出，不要使用炉石。如果你有到沙塔斯城的特别配送任务，请使用它提供给沙塔斯的门户。
step
.isOnQuest 10280
.goto Shattrath City,54.0,44.6
.turnin 102080 >>交任务: 送往沙塔斯的特殊货物
step
#aldor
.isOnQuest 10410
.goto Shattrath City,24.2,29.8
.turnin 10410 >>交任务: 伊沙娜的帮助
step
#scryer
.isOnQuest 10509
.goto Shattrath City,42.6,91.6
.turnin 10509 >>交任务: 无上的荣耀
step
#label shat
.isOnQuest 11024
.goto Shattrath City,52.6,20.8
.turnin 11024 >>交任务: 贫民窟的盟友
step
.goto Shattrath City,74.7,31.5
.reputation 989,revered,<0,1 >>前往: 塔纳利斯, 如果你的时间守护者声望已到达尊敬, 请与塞菲尔交谈,传送到时光之穴
.zone Tanaris >>前往: 塔纳利斯, 如果你的时间守护者声望已到达尊敬, 请与塞菲尔交谈,传送到时光之穴
step
.zoneskip Tanaris
.goto Tanaris,66.1,49.7
+ Get a summon to Caverns of Time. The guide is finished if you don't have one, it's not worth the time if you need to run there. Off to Northrend!
step
.isOnQuest 10445
.goto Tanaris,58.3,54.8
>>阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.turnin 10445 >>交任务: 永恒水瓶
step
.goto Tanaris,58.3,54.8
.reputation 989,friendly,<0,1
>>阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。接受你选择的戒指任务。这不是自动进行的，以防止拾取错误的戒指。如果没有友情戒指任务可用，请跳过此步骤。
.unitscan Soridomi
.dailyturnin 10462,10461,10460,10463 >>递交戒指誓言
step
.goto Tanaris,58.3,54.8
.reputation 989,honored,<0,1
>>阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10464,10465,10466,10467 >>接受誓言戒指任务
.dailyturnin 10464,10465,10466,10467 >>交出一个誓言戒指任务
step
.goto Tanaris,58.3,54.8
.reputation 989,revered,<0,1
>>阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10468,10469,10470,10471 >>接受誓言戒指任务
.dailyturnin 10468,10469,10470,10471 >>交出誓言戒指任务
step
.goto Tanaris,58.3,54.8
.reputation 989,exalted,<0,1
>>阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10472,10473,10474,10475 >>接受盟约戒指任务
.dailyturnin 10472,10473,10474,10475 >>交出盟约戒指任务
step
.isOnQuest 10297
.goto Tanaris,57.6,62.7
>>进入黑沼泽并完成任务
.turnin 10297 >>交任务: 开启黑暗之门
]]);