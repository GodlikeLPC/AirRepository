RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 专业每日任务
#wotlk
#name 烹饪

step << Alliance
	.goto Dalaran,40.43,65.66
	.daily 13100,13101,13102,13103,13107 >>在客栈内与凯瑟琳·李交谈。她每天有五分之一的烹饪任务。接受任何可用的
	>>浸菌肉饼
	>>下水道炖肉
	>>芥末犬
	>>Legerdemain大会
	>>Glowergold奶酪
step << Horde
	.goto Dalaran,69.96,39.05
	.daily 13112,13113,13114,13115,13116 >>与客栈内的阿维洛·隆贡巴交谈。他每天有五分之一的烹饪任务。接受任何可用的
	>>浸菌肉饼
	>>下水道炖肉
	>>芥末犬
	>>Legerdemain大会
	>>Glowergold奶酪

-- Quest: Mustard Dogs!
step << Alliance
	>>在达拉然的草地上掠夺野生芥菜
	.goto Dalaran,35.78,51.51,15,0
	.goto Dalaran,33.94,58.63,15,0
	.goto Dalaran,37.05,47.56,15,0
	.goto Dalaran,31.88,32.70,15,0
	.goto Dalaran,49.95,43.88,15,0
	.goto Dalaran,52.04,46.39,15,0
	.goto Dalaran,67.71,39.70,15,0
	.goto Dalaran,68.90,48.77
	.collect 43143,4 --Wild Mustard (4)
	.isOnQuest 13107
step << Horde
	>>在达拉然的草地上掠夺野生芥菜
	.goto Dalaran,55.17,38.59,25,0
	.goto Dalaran,67.71,39.70,15,0
	.goto Dalaran,68.90,48.77,15,0
	.goto Dalaran,51.70,47.34,15,0
	.goto Dalaran,49.38,44.26,15,0
	.goto Dalaran,47.58,47.52,15,0
	.goto Dalaran,50.19,50.54,15,0
	.goto Dalaran,35.78,51.51,15,0
	.goto Dalaran,33.94,58.63,15,0
	.goto Dalaran,37.05,47.56,15,0
	.goto Dalaran,31.88,32.70
	.collect 43143,4 --Wild Mustard (4)
	.isOnQuest 13116
step
	#sticky
	>>为了犀牛肉，在风暴峰杀死犀牛。或者，你可以直接从达拉然拍卖行购买犀牛肉或犀牛狗
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43012,4,-1 -- Rhino Meat (4)
	.skill engineering,<350,1
	.goto Dalaran,38.65,25.13,0
	.isOnQuest 13107 << Alliance
	.isOnQuest 13116 << Horde
step << Alliance
	#sticky
	>>为了犀牛肉，在风暴峰杀死犀牛。或者，你可以直接从暴风城或铁炉堡的拍卖行购买犀牛肉或犀牛狗
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43012,4,-1 -- Rhino Meat (4)
	.goto Ironforge,24.83,73.83,0
	.goto Stormwind City,60.88,70.92,0
	.skill engineering,350,1
	.isOnQuest 13107
step << Horde
	#sticky
	>>为了犀牛肉，在风暴峰杀死犀牛。或者，你可以直接从奥格瑞玛拍卖行购买犀牛肉或犀牛狗
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43012,4,-1 -- Rhino Meat (4)
	.goto Orgrimmar,54.57,63.68,0
	.skill engineering,350,1
	.isOnQuest 13116
step << Alliance
	.goto Dalaran,40.20,66.98
	>>使用您的烹饪专业将4只犀牛肉烹饪成4只犀牛狗
	.collect 34752,4 -- Rhino Dogs (4)
	.isOnQuest 13107
step << Horde
	.goto Dalaran,70.44,39.80
	>>使用您的烹饪专业将4只犀牛肉烹饪成4只犀牛狗
	.collect 34752,4 -- Rhino Dogs (4)
	.isOnQuest 13116
step << Alliance
	.use 43142 >>用袋子里的空野餐篮将4只犀牛狗和4只野芥末组合在一起，形成一个芥末狗野餐篮
	.complete 13107,1 --Mustard Dog Basket! (1)
	.isOnQuest 13107
step << Horde
	.use 43142 >>用袋子里的空野餐篮将4只犀牛狗和4只野芥末组合在一起，形成一个芥末狗野餐篮
	.complete 13116,1 --Mustard Dog Basket! (1)
	.isOnQuest 13116
step
	>>着陆台上的大法师五角星
	.goto Dalaran,68.53,42.04
	.turnin 13107 >>交任务: 荠菜热狗！ << Alliance
	.isQuestComplete 13107 << Alliance
	.turnin 13116 >>交任务: 荠菜热狗！ << Horde
	.isQuestComplete 13116 << Horde

-- Quest: Infused Mushroom Meatloaf
step << Alliance
	>>下到达拉然下水道。掠夺散落在地上的蓝色蘑菇
	.goto Dalaran,35.31,45.28,10,0
	.goto 126,22.66,41.71,10,0
	.goto 126,36.30,43.97,10,0
	.goto 126,54.12,64.98,10,0
	.goto 126,57.12,49.90,10,0
	.goto 126,45.46,47.06,10,0
	.goto 126,47.29,33.14,10,0
	.goto 126,53.79,29.20,10,0
	.goto 126,59.73,44.33
	.collect 43100,4 --Infused Mushrooms
	.isOnQuest 13100
step << Horde
	>>把井倒进达拉然下水道。掠夺散落在地上的蓝色蘑菇
	.goto Dalaran,48.25,32.33,5,0
	.goto 126,36.30,43.97,10,0
	.goto 126,54.12,64.98,10,0
	.goto 126,57.12,49.90,10,0
	.goto 126,45.46,47.06,10,0
	.goto 126,47.29,33.14,10,0
	.goto 126,53.79,29.20,10,0
	.goto 126,59.73,44.33
	.collect 43100,4 --Infused Mushrooms (4)
	.isOnQuest 13112
step
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从达拉然拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,2 -- Chilled Meat (2)
	.skill engineering,<350,1
	.goto Dalaran,38.65,25.13,0
	.isOnQuest 13100 << Alliance
	.isOnQuest 13112 << Horde
step << Alliance
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从暴风城或铁炉堡的拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,2 -- Chilled Meat (2)
	.goto Ironforge,24.83,73.83,0
	.goto Stormwind City,60.88,70.92,0
	.skill engineering,350,1
	.isOnQuest 13100
step << Horde
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从奥格瑞玛拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,2 -- Chilled Meat (2)
	.goto Orgrimmar,54.57,63.68,0
	.skill engineering,350,1
	.isOnQuest 13112
step << Alliance
	.use 43101 >>用你袋子里的肉饼锅在火上混合4个浸入的蘑菇和2个冷冻肉
	.goto Dalaran,40.20,66.98
	.complete 13100,1 --Infused Mushroom Meatloaf (1)
	.isOnQuest 13100
step << Horde
	.use 43101 >>用你袋子里的肉饼锅在火上混合4个浸入的蘑菇和2个冷冻肉
	.goto Dalaran,59.46,31.33,60,0
	.goto Dalaran,70.44,39.80
	.complete 13112,1 --Infused Mushroom Meatloaf (1)
	.isOnQuest 13112
step
	>>与奥顿·班纳特(Orton Bennet)在好奇与摩尔大楼楼上交谈。
	.goto Dalaran,49.01,56.96,6,0
	.goto Dalaran,48.79,54.94,6,0
	.goto Dalaran,50.11,53.10,6,0
	.goto Dalaran,52.31,55.59
	.turnin 13100 >>交任务: 魔法蘑菇肉片 << Alliance
	.isQuestComplete 13100 << Alliance
	.turnin 13112 >>交任务: 魔法蘑菇肉片 << Horde
	.isQuestComplete 13112 << Horde

-- Quest: Sewer Stew
step
	.zone CrystalsongForest >>在达拉然，进入紫罗门大楼，点击紫罗兰链水晶传送到下方的水晶歌森林
	.goto Dalaran,57.32,46.55,6,0
	.goto Dalaran,55.91,46.77
	.isOnQuest 13102 << Alliance
	.isOnQuest 13114 << Horde
step
	>>掠夺水晶胡萝卜
	.goto CrystalsongForest,25.83,39.27,40,0
	.goto CrystalsongForest,28.74,42.89,40,0
	.goto CrystalsongForest,31.87,43.25,40,0
	.goto CrystalsongForest,30.69,37.48,40,0
	.goto CrystalsongForest,26.96,47.00
	.collect 43148,4 --Crystalsong Carrot (4)
	.isOnQuest 13102 << Alliance
	.isOnQuest 13114 << Horde
step
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从达拉然拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4 -- Chilled Meat (4)
	.skill engineering,<350,1
	.goto Dalaran,38.65,25.13,0
	.isOnQuest 13102 << Alliance
	.isOnQuest 13114 << Horde
step << Alliance
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从暴风城或铁炉堡的拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4 -- Chilled Meat (4)
	.goto Ironforge,24.83,73.83,0
	.goto Stormwind City,60.88,70.92,0
	.skill engineering,350,1
	.isOnQuest 13102
step << Horde
	#sticky
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从奥格瑞玛拍卖行购买冷却肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4 -- Chilled Meat (4)
	.goto Orgrimmar,54.57,63.68,0
	.skill engineering,350,1
	.isOnQuest 13114
step << Alliance
	.use 43147 >>用袋子里的炖锅在火上混合4个水晶胡萝卜和4个冷冻肉
	.goto Dalaran,40.20,66.98
	.complete 13102,1 --Vegetable Stew (1)
	.isOnQuest 13102
step << Horde
	.use 43101 >>用袋子里的炖锅在火上混合4个水晶胡萝卜和4个冷冻肉
	.goto Dalaran,59.46,31.33,57,0
	.goto Dalaran,70.44,39.80
	.complete 13114,1 --Vegetable Stew (1)
	.isOnQuest 13114
step << Alliance
	>>在达拉然下水道与阿杰·格林交谈
	.goto Dalaran,35.31,45.28,10,0
	.goto 126,22.66,41.71,10,0
	.goto 126,36.30,43.97,10,0
	.goto 126,35.47,57.55
	.turnin 13102 >>交任务: 下水道炖肉
	.isQuestComplete 13102
step << Horde
	>>把井倒进达拉然下水道。与Ajay Green交谈
	.goto Dalaran,48.25,32.33,5,0
	.goto 126,35.47,57.55
	.turnin 13114 >>交任务: 下水道炖肉
	.isQuestComplete 13114

-- Quest: Cheese for Glowergold
step << Alliance
	#completewith Cheese
	>>开始寻找半满的达拉然酒杯。这些分布在达拉然的建筑中。检查客栈内部和楼上
	.goto Dalaran,43.75,63.27
	.collect 43138,6 --Half Full Dalaran Wine Glass (6)
	.isOnQuest 13103
step << Horde
	#completewith Cheese
	>>开始寻找半满的达拉然酒杯。这些分布在达拉然的建筑中。检查客栈内部和楼上
	.goto Dalaran,69.42,31.39
	.collect 43138,6 --Half Full Dalaran Wine Glass (6)
	.isOnQuest 13115
step
	#label Cheese
	>>在达拉然，走进一个玻璃大楼。掠夺年迈的达拉兰·林伯格。它可以在表的内部或外部随机生成
	.goto Dalaran,54.70,31.57
	.collect 43137,1 --Aged Dalaran Limburger (1)
	.isOnQuest 13103 << Alliance
	.isOnQuest 13115 << Horde
step 
	>>开始寻找半满的达拉然酒杯。这些分布在达拉然的建筑中。检查客栈内部和楼上
	.goto Dalaran,54.70,31.57
	.collect 43138,6 --Half Full Dalaran Wine Glass (6)
    .isOnQuest 13103 << Alliance
	.isOnQuest 13115 << Horde
step << Alliance
	.use 43139 >>用袋子里的空奶酪服务拼盘将6个半满的达拉然酒杯和陈年达拉然林堡拼盘组合在一起，形成一个葡萄酒和奶酪拼盘
	.complete 13103,1 --Wine and Cheese Platter (1)
	.isOnQuest 13103
step << Horde
	.use 43139 >>用袋子里的空奶酪服务拼盘将6个半满的达拉然酒杯和陈年达拉然林堡拼盘组合在一起，形成一个葡萄酒和奶酪拼盘
	.complete 13115,1 --Wine and Cheese Platter (1)
	.isOnQuest 13115
step
	>>在达拉然与Ranid Glowergold交谈
	.goto Dalaran,36.42,29.64,10,0
	.goto Dalaran,36.62,27.88
	.turnin 13103 >>Glowergold奶酪 << Alliance
	.isQuestComplete 13103 << Alliance
	.turnin 13115 >>Glowergold奶酪 << Horde
	.isQuestComplete 13115 << Horde

-- Quest: Convention at the Legerdemain
step << Alliance
	>>在达拉然，去一个玻璃大楼。掠夺酒瓶。注意它随机繁殖，也可以在室外和楼上繁殖
	.goto Dalaran,54.00,32.26
	.complete 13101,2 --Jug of Wine (1)
	.isOnQuest 13101
step << Horde
	>>在达拉然，去一个玻璃大楼。掠夺酒瓶。注意它随机繁殖，也可以在室外和楼上繁殖
	.goto Dalaran,54.00,32.26
	.complete 13113,2 --Jug of Wine (1)
	.isOnQuest 13113
step
	#sticky
    #completewith stew
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从达拉然拍卖行购买冷却肉或北炖肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4,-1 -- Chilled Meat (4)
	.skill engineering,<350,1
	.goto Dalaran,38.65,25.13,0
	.isOnQuest 13101 << Alliance
	.isOnQuest 13113 << Horde
step << Alliance
	#sticky
    #completewith stew
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从暴风城或铁炉堡的拍卖行购买冷却肉或北炖肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4,-1 -- Chilled Meat (4)
	.goto Ironforge,24.83,73.83,0
	.goto Stormwind City,60.88,70.92,0
	.skill engineering,350,1
	.isOnQuest 13101
step << Horde
	#sticky
    #completewith stew
	>>在暴风峰杀死犀牛以获取冷冻肉。或者，你可以直接从奥格瑞玛拍卖行购买冷却肉或北炖肉
	.goto TheStormPeaks,43.26,59.11,70,0
	.goto TheStormPeaks,44.93,61.45,70,0
	.goto TheStormPeaks,45.77,57.91,70,0
	.goto TheStormPeaks,43.82,55.42,70,0
	.goto TheStormPeaks,41.79,53.43,70,0
	.goto TheStormPeaks,38.81,54.06,70,0
	.goto TheStormPeaks,38.58,59.45
	.collect 43013,4,-1 -- Chilled Meat (4)
	.goto Orgrimmar,54.57,63.68,0
	.skill engineering,350,1
	.isOnQuest 13113   
step << Alliance
	#completewith next
	.isQuestAvailable 13087
	.isOnQuest 13101
	>>要学习如何烹饪北方炖菜，你必须带4块冷却肉去嚎叫峡湾的Brom Brewbaster。或者，你可以直接从拍卖行购买北炖牛肉。如果您要从拍卖行购买北炖菜，请跳过此步骤
	>>如果你要完成这个任务，你总共需要8块冷却肉
	.collect 43013,4 -- Chilled Meat (4)
	.accept 13087 >>接任务: 诺森德的厨师
	.turnin 13087 >>交任务: 诺森德的厨师
	.goto HowlingFjord,58.21,62.06	
step << Horde
	#completewith next
	.isQuestAvailable 13089
	.isOnQuest 13113
	>>要学习如何烹饪北方炖菜，你必须带4块冷却肉到嚎叫峡湾的托马斯·科利乔那里。或者，你可以直接从拍卖行购买北炖牛肉。如果您要从拍卖行购买北炖菜，请跳过此步骤	
	>>如果你要完成这个任务，你总共需要8块冷却肉
	.collect 43013,4 -- Chilled Meat (4)
	.accept 13089 >>接任务: 诺森德的厨师
	.turnin 13089 >>交任务: 诺森德的厨师
	.goto HowlingFjord,78.61,29.48
step << Alliance
    #label stew
	.goto Dalaran,40.20,66.98
	>>利用您的烹饪专业知识将4块冷却肉烹饪成4块北炖
	.complete 13101,1 --Northern Stew (4)
	.isOnQuest 13101
step << Horde
    #label stew    
	.goto Dalaran,70.44,39.80
	>>利用您的烹饪专业知识将4块冷却肉烹饪成4块北炖
	.complete 13113,1 --Northern Stew (4)
	.isOnQuest 13113
step
	>>在达拉然与阿里尔·阿祖雷加交谈
	.goto Dalaran,48.37,37.47
	.turnin 13101 >>Legerdemain大会 << Alliance
	.isQuestComplete 13101 << Alliance
	.turnin 13113 >>Legerdemain大会 << Horde
	.isQuestComplete 13113 << Horde
step
	>>你已经完成了今天的烹饪每日任务
]])