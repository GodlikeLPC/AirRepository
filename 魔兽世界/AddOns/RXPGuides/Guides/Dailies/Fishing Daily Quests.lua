RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 专业每日任务
#wotlk
#name 钓鱼

step
	.goto Dalaran,53.04,64.95
	.daily 13830,13832,13833,13834,13836, >>与达拉然的马西娅·蔡斯交谈。她每天有五分之一的钓鱼任务。接受任何可用的
	>>幽灵鱼--13830
	>>下水道宝石--13832
	>>血越来越浓--13833
	>>危险美味--13834
	>>解除武装！--13836

-- Quest: Dangerously Delicious -- 13834
step << Alliance
	#completewith next
	>>记得买些小玩意儿用在你的鱼竿上
	.fly Valiance Landing Camp >>与Aludane交谈，飞往Wintergrasp——autofly不在达拉到勇士登陆营地工作(wg)
	.goto Dalaran,72.18,45.78,20,0
	.isOnQuest 13834
step << Horde
	#completewith next
	>>记得买些小玩意儿用在你的鱼竿上
	.fly Warsong Camp, Wintergrasp>>与Aludane交谈，飞往Wintergrasp——autofly不在达拉到战歌营地工作(wg)
	.goto Dalaran,72.18,45.78,20,0
	.isOnQuest 13834
step
	.goto Wintergrasp,79.57,46.92,-1
	.goto Wintergrasp,79.88,41.38,-1
	.zone Wintergrasp >>前往: 冬拥湖
	.isOnQuest 13834
step << Alliance
	>>在冬抓岛的任何地方捕鱼以防恐怖
	.goto Wintergrasp,71.05,36.85,-1
	.goto Wintergrasp,79.57,46.92,-1
	.goto Wintergrasp,79.88,41.38,-1
	.complete 13834,1 --Terrorfish (10)
	.isOnQuest 13834
step << Horde
	>>在冬抓岛的任何地方捕鱼以防恐怖
	.goto Wintergrasp,22.62,37.33,-1
	.goto Wintergrasp,79.57,46.92,-1
	.goto Wintergrasp,79.88,41.38,-1
	.complete 13834,1 --Terrorfish (10)
	.isOnQuest 13834
step << Alliance
	#completewith next
	.fly Dalaran >>飞往达拉然
	.goto Wintergrasp,71.98,30.95
	.isOnQuest 13834
step << Horde
	#completewith next
	.fly Dalaran >>飞往达拉然
	.goto Wintergrasp,21.62,34.96
	.isOnQuest 13834
step
	>>在达拉然与玛西娅·蔡斯交谈
	.goto Dalaran,53.04,64.95
	.turnin 13834 >>交任务: 危险的美食
	.isQuestComplete 13834

-- Quest: The Ghostfish -- 13830
step
	#completewith next
	>>记得买些小玩意儿用在你的鱼竿上
	.fly River's Heart >>与Aludane商谈飞往Sholazar盆地
	.goto Dalaran,72.18,45.78,15,0
	.isOnQuest 13830
step
	.goto SholazarBasin,49.40,62.13
	.zone SholazarBasin >>前往Sholazar盆地
	.isOnQuest 13830
step
	#completewith next
	>>河心幽灵鱼
	.goto SholazarBasin,49.40,62.13
	.collect 45902,1 --Phantom Ghostfish (1)
	.isOnQuest 13830
step
	.use 45902 >>吃你袋子里的幽灵鱼
	.complete 13830,1 --Discover the Ghostfish mystery (1)
	.isOnQuest 13830
step
	#completewith next
	.fly Dalaran >>飞往达拉然
	.goto SholazarBasin,50.13,61.36
	.isOnQuest 13830
step
	>>在达拉然与玛西娅·蔡斯交谈
	.goto Dalaran,53.04,64.95
	.turnin 13834 >>交任务: 危险的美食
	.isQuestComplete 13830

-- Quest: Jewel Of The Sewers -- 13832
step
	>>记得买些小玩意儿用在你的鱼竿上
	>>下到达拉然下水道。腐蚀珠宝鱼
	.goto Dalaran,35.31,45.28,10,0
	.goto 126,22.66,41.71,10,0
	.goto 126,37.06,48.02
	.complete 13832,1 --Corroded Jewelry (1)
	.isOnQuest 13832
step
	>>在达拉然与玛西娅·蔡斯交谈
	.goto 126,22.66,41.71,10,0
	.goto Dalaran,35.31,45.28,10,0
	.goto Dalaran,53.04,64.95
	.turnin 13832 >>交任务: 下水道中的珍宝
	.isQuestComplete 13832

-- Quest: Disarmed! -- 13836
step
	>>记得买些小玩意儿用在你的鱼竿上
	>>达拉然紫罗兰湾外的浮肿滑鳗鱼
	.goto Dalaran,62.16,67.18
	.collect 45328,1 -- Bloated Slippery Eel (1)
	.isOnQuest 13836
step
	.use 45328 >>打开包里的肿滑鳗鱼，抢走断臂
	.complete 13836,1 --Severed Arm (1)
	.isOnQuest 13836
step
	>>与达拉然的奥利萨拉交谈
	.goto Dalaran,36.58,37.33
	.turnin 13836 >>交任务: 胳膊丢了！
	.isQuestComplete 13836

-- Quest: Blood Is Thicker -- 13833
step << Alliance
	#completewith next
	>>记得买些小玩意儿用在你的鱼竿上
	.fly Une'pe >>与Aludane交谈，飞往Une’pe，Borean Tundra
	.goto Dalaran,72.18,45.78,20,0
	.isOnQuest 13833
step << Horde
	#completewith next
	>>记得买些小玩意儿用在你的鱼竿上
	.fly Taunka'le >>与Aludane交谈，飞往Borean Tundra的Taunka'le
	.goto Dalaran,72.18,45.78,20,0
	.isOnQuest 13833
step
	.goto BoreanTundra,75.56,42.01
	.zone BoreanTundra >>前往Borean Tundra
	.isOnQuest 13833
step -- WIP. Currently no check for debuff. If they get debuff @ first WP then it will point to the next 2 WP's before pointing to the sea to start fishing
	>>杀死北风苔原的任何动物，以获得动物血减毒效果
	>>跳入水中去除去毛刺，这将形成一个血池
	.goto BoreanTundra,75.56,42.01,60,0
	>>血泊中的鱼血牙法国人
	.complete 13833,1 --Bloodtooth Frenzy (5)
	.goto BoreanTundra,82.28,49.62,-1
	.goto BoreanTundra,79.22,51.61,-1
	.isOnQuest 13833
step
	#completewith next
	.fly Dalaran >>飞往达拉然
	.goto BoreanTundra,78.54,51.53
	.isOnQuest 13833
step
	>>在达拉然与玛西娅·蔡斯交谈
	.goto Dalaran,53.04,64.95
	.turnin 13834 >>交任务: 危险的美食
	.isQuestComplete 13833
step
	+你已完成今天的钓鱼每日任务
]])
