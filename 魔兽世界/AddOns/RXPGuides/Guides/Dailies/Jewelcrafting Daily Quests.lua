RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 专业每日任务
#wotlk
#name 珠宝加工

step
	.goto Dalaran,40.67,35.35
	>>要开始每日的珠宝制作任务，你必须首先完成任务。完成运送任务，这需要你给达拉然的蒂莫西·琼斯带来玉髓
	.collect 36923,1 --Chalcedony (1)
	.isQuestAvailable 13041
step
	>>与蒂莫西·琼斯交谈
    .goto Dalaran,40.67,35.35
    .accept 13041 >>接任务: 完成订单
	.complete 13041,1 --Chalcedony (1)
    .turnin 13041 >>交任务: 完成订单
	.isQuestAvailable 13041
step
	.goto Dalaran,40.67,35.35
	.daily 12958,12959,12960,12961,12962,12963 >>在达拉然与蒂莫西·琼斯交谈。他每天有6个珠宝制作任务中的1个。接受任何可用的
	>>装运：血玉护身符--12958
	>>装运：发光象牙雕像--12959
	>>装运：邪恶太阳兄弟--12960
	>>装运：复杂的骨雕--12961
	>>装运：亮甲遗迹--12962
	>>装运：转移太阳古玩--12963

-- Quest: Shipment: Blood Jade Amulet -- 12958
step
	#completewith Amulet
	>>收集一块黑玉和一块血石，然后与维库尔护身符结合
	.collect 36932,1 --Dark Jade (1)
	.collect 36917,1 --Bloodstone (1)
	.isOnQuest 12958
step
	.goto TheStormPeaks,22.50,59.67,60,0
	.goto TheStormPeaks,23.46,59.89,60,0
	.goto TheStormPeaks,25.31,59.98,60,0
	.goto TheStormPeaks,26.29,59.11,60,0
	.goto TheStormPeaks,27.57,60.98,60,0
	.goto TheStormPeaks,26.10,62.50
	>>为了维库尔护身符，在风暴峰杀死瓦尔基里昂野心家
	.collect 41989,1 --Vrykul Amulet (1)
	.isOnQuest 12958
step
	#label Amulet
	.use 41989 >>使用包中的维库尔护身符，将黑玉和血石结合在一起，打造出血玉护身符
	.complete 12958,1 --Blood Jade Amulet (1)
	.isOnQuest 12958
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12958 >>交任务: 货单：血玉护符
	.isQuestComplete 12958

-- Quest: Shipment: Glowing Ivory Figurine -- 12959
step
	#completewith Ivory
	>>收集玉髓和暗影水晶，然后与北象牙结合
	.collect 36923,1 --Chalcedony (1)
	.collect 36926,1 --Shadow Crystal (1)
	.isOnQuest 12959
step
	.goto Dragonblight,67.00,31.04,60,0
	.goto Dragonblight,65.94,36.65,60,0
	.goto Dragonblight,65.00,45.69,60,0
	.goto Dragonblight,56.41,48.12
	>>为北象牙群岛杀死龙骨荒野中被遗弃的猛犸
	.collect 42104,1 --Northern Ivory (1)
	.isOnQuest 12959
step
	#label Ivory
	.use 42104 >>用包里的北象牙组合玉髓和影水晶，打造出一个发光象牙雕像
	.complete 12959,1 --Glowing Ivory Figurine (1)
	.isOnQuest 12959
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12959 >>交任务: 货单：炽热鹿牙雕像
	.isQuestComplete 12959

-- Quest: Shipment: Wicked Sun Brooch -- 12960
step
	#completewith Brooch
	>>收集一个巨大的黄水晶和一个太阳水晶，然后与一把铁矮人胸针结合
	.collect 36929,1 --Huge Citrine (1)
	.collect 36920,1 --Sun Crystal (1)
	.isOnQuest 12960
step
	.goto TheStormPeaks,26.82,66.90,40,0
	.goto TheStormPeaks,26.13,66.93,30,0
	.goto TheStormPeaks,26.00,67.60,20,0
	.goto TheStormPeaks,26.82,66.90
	>>在这个位置进入暴风峰的博尔呼吸洞穴。为铁矮人胸针杀死暴风矮人
	.collect 42105,1 --Iron Dwarf Brooch (1)
	.isOnQuest 12960
step
	#label Brooch
	.use 42105 >>使用包中的铁矮人胸针将巨大的柠檬色和太阳水晶相结合，打造出邪恶的太阳胸针
	.complete 12960,1 --Wicked Sun Brooch (1)
	.isOnQuest 12960
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12960 >>交任务: 货单：邪恶太阳胸针
	.isQuestComplete 12960

-- Quest: Shipment: Intricate Bone Figurine -- 12961
step
	#completewith Figurine
	>>收集一块太阳水晶和一块黑玉，然后与一块神龙骨结合
	.collect 36920,1 --Sun Crystal (1)
	.collect 36932,1 --Dark Jade (1)
	.isOnQuest 12961
step
	.goto TheStormPeaks,45.77,67.09,60,0
	.goto TheStormPeaks,43.80,64.03,70,0
	.goto TheStormPeaks,45.80,62.52
	>>为了神龙骨在风暴峰杀死Stormpeak神龙
	.collect 42106,1 --Proto Dragon Bone (1)
	.isOnQuest 12961
step
	#label Figurine
	.use 42106 >>使用包里的原始龙骨将太阳水晶和黑玉结合起来，打造出一个复杂的骨骼塑像
	.complete 12961,1 --Intricate Bone Figurine (1)
	.isOnQuest 12961
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12961 >>交任务: 货单：精致龙骨雕像
	.isQuestComplete 12961

-- Quest: Shipment: Bright Armor Relic -- 12962
step
	#completewith Relic
	>>收集一块血石和一块巨大的柠檬石，然后与元素护甲碎片结合
	.collect 36917,1 --Bloodstone (1)
	.collect 36929,1 --Huge Citrine (1)
	.isOnQuest 12962
step
	.goto Dragonblight,57.83,14.22,50,0
	.goto Dragonblight,58.62,16.39,50,0
	.goto Dragonblight,54.77,19.10
	>>杀死龙骨荒野中的冰晶元素以获得元素护甲碎片
	.collect 42107,1 --Elemental Armor Scrap (1)
	.isOnQuest 12962
step
	#label Relic
	.use 42107 >>使用包里的元素护甲碎片将血石和巨大的柠檬石结合起来，创造出一个明亮的护甲遗迹
	.complete 12962,1 --Bright Armor Relic (1)
	.isOnQuest 12962
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12962 >>交任务: 货单：光芒护甲圣物
	.isQuestComplete 12962

-- Quest: Shipment: Shifting Sun Curio -- 12963
step
	#completewith Curio
	>>收集太阳水晶和阴影水晶，然后与天灾古玩结合
	.collect 36920,1 --Sun Crystal (1)
	.collect 36926,1 --Shadow Crystal (1)
	.isOnQuest 12963
step
	.goto Icecrown,70.77,68.13,50,0
	.goto Icecrown,68.66,68.07
	>>为天灾古玩杀死冰冠上的怪物憎恶者或邪恶的亡灵巫师
	.collect 42108,1 --Scourge Curio (1)
	.isOnQuest 12963
step
	#label Curio
	.use 42108 >>用你包里的天灾古玩将太阳水晶和阴影水晶结合起来，创造出一个移动的太阳古玩
	.complete 12963,1 --Shifting Sun Curio (1)
	.isOnQuest 12963
step << Mage
	.zone Dalaran >>前往: 达拉然
step
	>>在达拉然与蒂莫西·琼斯交谈
	.goto Dalaran,40.67,35.35
	.turnin 12963 >>交任务: 货单：光芒护甲圣物
	.isQuestComplete 12963
step
	>>您已完成今天的珠宝制作每日任务
]])
