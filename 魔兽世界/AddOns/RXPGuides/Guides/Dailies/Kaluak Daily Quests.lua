RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 卡鲁亚克每日任务

step
	>>前往龙骨荒野的莫亚基港口。与猎手莫伊交谈
    .daily 11960 >>接任务: 未来的种子
    .goto Dragonblight,48.25,74.35
step
    .goto Dragonblight,47.4,64.3,40,0
    .goto Dragonblight,47.2,61.5,40,0
    .goto Dragonblight,45.2,61.6
	>>右击小屋附近的小沃尔瓦小狗
    .complete 11960,1 --Snowfall Glade Pup (12)
	.isOnQuest 11960
step
	>>返回莫亚基港口。与猎手莫伊交谈
    .turnin 11960 >>交任务: 未来的种子
    .goto Dragonblight,48.25,74.35
	.isQuestComplete 11960
step
	>>前往北风苔原的乌泰尔。与尤泰克交谈
    .daily 11945 >>接任务: 做最坏的打算
    .goto BoreanTundra,63.95,45.72
step
    .goto BoreanTundra,66.2,45.9,60,0
    .goto BoreanTundra,63.7,52.2
	>>掠夺村庄周围的小篮子
	.complete 11945,1 --Kaskala Supplies (8)
    .isOnQuest 11945
step
	>>返回卡斯卡拉
    .turnin 11945 >>交任务: 做最坏的打算
    .goto BoreanTundra,63.95,45.72
    .isQuestComplete 11945
step
	>>前往嚎风峡湾的卡玛古。与Anunia交谈
    .daily 11472 >>接任务: 心心相印……
	.goto HowlingFjord,24.59,58.87
step
    .goto HowlingFjord,31.2,74.8,30,0
    .goto HowlingFjord,30.96,71.85
	.use 40946 >>在该地区的美味礁鱼群上，用你袋子里的Anuniaq网钓大约7-8条美味礁鱼。你应该在大约2次发网中看到这个
	.use 34127 >>将美味礁鱼以最大射程投掷到礁牛，它现在会到达你站的地方
	>>把它带到海岸线另一边的一头礁牛上面
	>>如果鱼用完了，再拿7-8块，再试一次
    .complete 11472,1 --Reef Bull led to a Reef Cow (1)
	.isOnQuest 11472
step
    .goto HowlingFjord,24.59,58.87
	>>与Anuniaq交谈
    .turnin 11472 >>交任务: 心心相印……
	.isQuestComplete 11472
]])
