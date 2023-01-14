RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 1-6 永歌森林
#version 1
#group RestedXP部落1-30
#defaultfor BloodElf
#next 6-10 永歌森林
step << !BloodElf
    #completewith next
    .goto Eversong Woods,38.2,20.8
    +你选择了一个为血精灵准备的向导。我们不建议做1-6区域，因为没有非血精灵的任务。你应该选择与你开始时相同的起始区域
step
    >>与Magistrix Erona交谈
    .goto Eversong Woods,38.2,20.8 << tbc
	.goto Eversong Woods,38.02,21.01 << wotlk
    .accept 8325 >>接任务: 夺回逐日岛
step
    >>杀死该地区的玛娜·怀尔斯
	>>杀死该地区的玛娜·怀尔斯。研磨怪物，直到你拥有价值65铜的供应商物品。你也可以以13c的价格出售你的装备 << Warlock wotlk
    .goto Eversong Woods,37.5,23.2
    .complete 8325,1 --Kill Mana Wyrm (x8)
step
    .goto Eversong Woods,38.2,20.8 << tbc
	.goto Eversong Woods,38.02,21.01 << wotlk
	>>继续研磨怪物，直到你有65铜价值的卖家物品，然后交给这个任务。 << Warlock wotlk
    .turnin 8325,1 >>交任务: 夺回逐日岛 << Paladin
    .turnin 8325 >>交任务: 夺回逐日岛 << !Paladin
step
    .goto Eversong Woods,38.2,20.8 << tbc
	.goto Eversong Woods,38.02,21.01 << wotlk	
    .accept 8326 >>接任务: 令人遗憾的措施
	.accept 9393 >>接任务: 猎人训练 << Hunter
	.accept 9392 >>接任务: 潜行者训练 << Rogue
    .accept 8563 >>接任务: 术士训练 << Warlock
    .accept 8564 >>接任务: 牧师训练 << Priest
    .accept 8328 >>接任务: 法师训练 << Mage
    .accept 9676 >>接任务: 圣骑士训练 << Paladin
step << Paladin/Rogue
    #completewith next
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商垃圾
step << Hunter
    .goto Eversong Woods,38.7,20.3
    .vendor >>到大楼里去，把小贩的垃圾扔掉，把箭装满你的箭袋
step << Mage tbc/Priest tbc/Warlock tbc
    .goto Eversong Woods,38.7,20.3
    .vendor >>进去，小贩垃圾箱，买10杯水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Mage wotlk/Priest wotlk/Warlock wotlk 
    .goto Eversong Woods,38.7,20.3
	>>确保您有价值65c的供应商商品。如果没有，就种植更多的暴徒。 << Warlock
    .vendor >>进去卖垃圾。
step << Paladin
    .goto Eversong Woods,39.5,20.6
    .turnin 9676 >>交任务: 圣骑士训练
    .accept 10069 >>接任务: 护井者索兰尼亚
step << Mage
    .goto Eversong Woods,39.2,21.5
    .turnin 8328 >>交任务: 法师训练
    .accept 10068 >>接任务: 护井者索兰尼亚
    .trainer >>训练你的职业咒语
step << Priest
    .goto Eversong Woods,39.4,20.4
    .turnin 8564 >>交任务: 牧师训练
    .accept 10072 >>接任务: 护井者索兰尼亚
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Eversong Woods,38.9,20.0
    .turnin 9392 >>交任务: 潜行者训练
    .accept 10071 >>接任务: 护井者索兰尼亚
step << Hunter
    >>与底层的护林员Sallina交谈
    .goto Eversong Woods,39.0,20.0
    .turnin 9393 >>交任务: 猎人训练
    .accept 10070 >>接任务: 护井者索兰尼亚
step << Warlock
    .goto Eversong Woods,38.9,21.4
    .turnin 8563 >>交任务: 术士训练
    .accept 10073 >>接任务: 护井者索兰尼亚
    .accept 8344 >>接任务: 力量之源 << tbc
    .trainer >>训练你的职业咒语
step
    .goto Eversong Woods,38.8,19.4
    >>上楼去
    .turnin 10073 >>交任务: 护井者索兰尼亚 << Warlock
    .turnin 10072 >>交任务: 护井者索兰尼亚 << Priest
    .turnin 10071 >>交任务: 护井者索兰尼亚 << Rogue
    .turnin 10070 >>交任务: 护井者索兰尼亚 << Hunter
    .turnin 10068 >>交任务: 护井者索兰尼亚 << Mage
    .turnin 10069 >>交任务: 护井者索兰尼亚 << Paladin
    .accept 8330 >>接任务: 索兰尼亚的物品
    .accept 8345 >>接任务: 达斯雷玛的神龛
step
    .goto Eversong Woods,38.3,19.1
    .accept 8336 >>接任务: 奥术薄片
step
    >>装备你的新包
    .goto Eversong Woods,37.2,18.9
    .accept 8346 >>接任务: 无尽的渴求
step << Warlock tbc
    #completewith next
    >>途中磨碎春爪山猫和小熊。抢夺他们的衣领。你现在不必完成这个任务。
    .complete 8326,1 --Lynx Collar (8)
step << Warlock tbc
    #completewith next
    .goto Eversong Woods,32.6,25.5,30 >>跑上坡道。在这里跑步时，尽可能多地获得法力值。
step << Warlock tbc
    #completewith ArcaneSliver
    >>在你的任务中使用法力研磨和奥术激流生物。一定要抢他们的奥术银条
    .complete 8346,1 --Mana Tap creature (x6)
    .complete 8336,1 --Collect Arcane Sliver (x6)
step << Warlock tbc
    >>掠夺神秘幽灵以获取幽灵精华。如果它们紧邻在一起，请小心拉在一起
    .goto Eversong Woods,32.3,28.1
    .complete 8344,1 --Wraith Essence (4)
step << Warlock tbc
	#label ArcaneSliver
    .use 20483 >>杀死一个被污染的神秘幽灵。掠夺它以获取精华和染色的奥术银。点击包中的银条接受任务
    .goto Eversong Woods,31.6,29.3
    .unitscan Tainted Arcane Wraith
    .complete 8344,2 --Tainted Wraith Essence (1)
    .collect 20483,1,8338 --Tainted Arcane Sliver (1)
    .accept 8338 >>接任务: 被污染的奥术薄片
step << Warlock tbc
    .goto Eversong Woods,37.5,23.2
    >>完成法力攻丝生物并获得剩余的奥术碎片
    .complete 8346,1 --Mana Tap creature (x6)
    .complete 8336,1 --Collect Arcane Sliver (x6)
step << Warlock tbc
    .xp 3+200>>提升经验到3级+200xp
step << Warlock tbc
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step << BloodElf Warlock tbc
    .goto Eversong Woods,37.2,18.9
    .turnin 8346 >>交任务: 无尽的渴求
    .turnin 8338 >>交任务: 被污染的奥术薄片
step << Warlock tbc
    .goto Eversong Woods,38.3,19.1
    .turnin 8336 >>交任务: 奥术薄片
step << Warlock tbc
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商垃圾和购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Warlock tbc
    .goto Eversong Woods,38.9,21.4
    .turnin 8344 >>交任务: 力量之源
step << Warlock tbc
    .goto Eversong Woods,34.9,19.6
    .xp 4 >>升级到4	
step << Warlock tbc
    .goto Eversong Woods,38.9,21.4
    .collect 16321 >>去亚斯明买血盟书。召唤小鬼后使用
    .trainer >>训练你的职业咒语
	.use 16321
	.cast 20397 >>使用血腥纹章
step << Warlock wotlk
	#completewith next
	.cast 688 >>召唤你的小鬼
step
    >>为山猫项圈杀死山猫
    .goto Eversong Woods,40.4,16.7,40,0
    .goto Eversong Woods,40.0,22.1,40,0
    .goto Eversong Woods,40.4,16.7,40,0
    .goto Eversong Woods,40.0,22.1,40,0
    .goto Eversong Woods,40.6,16.2
    .complete 8326,1 --Collect Lynx Collar (x8)
step
    .goto Eversong Woods,38.2,20.8 << tbc
	.goto Eversong Woods,38.02,21.01 << wotlk
    >>返回Magistrix Erona
    .turnin 8326,1 >>交任务: 令人遗憾的措施 << Paladin
    .turnin 8326 >>交任务: 令人遗憾的措施 << !Paladin
    .accept 8327 >>接任务: 向兰萨恩·派雷隆报到
step << !Warlock tbc
    #completewith arcaneend
    #label manaarcane
    .goto Eversong Woods,37.7,24.9,0
    >>在你的任务中，对法力使用者使用法力分流法术。它在你的魔法书的“常规”选项卡中。
    >>在寻找银条时杀死法力用户。不要特意杀死他们，因为你只需要在你的法力输出冷却结束时杀死他们。
    .complete 8346,1 --Mana Tap creature (x6)
    .complete 8336,1 --Collect Arcane Sliver (x6)
step << wotlk
    #completewith arcaneend
    .goto Eversong Woods,37.7,24.9,0
    >>对法力妖精或野性温柔使用法术“奥术激流”。它在你的魔法书的“常规”选项卡中
    .complete 8346,1 --Mana Tap creature (1)
step << wotlk
    #completewith arcaneend
    .goto Eversong Woods,37.7,24.9,0
    >>杀死玛娜·怀姆斯和野性投标者。掠夺他们的银条
    .complete 8336,1 --Collect Arcane Sliver (x6)
step
    #label Report
    .goto Eversong Woods,35.4,22.5
    >>在长椅旁与兰山佩里隆交谈
    .turnin 8327 >>交任务: 向兰萨恩·派雷隆报到
    .accept 8334 >>接任务: 攻势
step
    >>在地板上掠夺杂志
.goto Eversong Woods,37.7,24.9
    .complete 8330,3 --Collect Solanian's Journal (x1)
step
    #completewith RedOrb
    >>杀死该地区的投标者
    .complete 8334,1 --Kill Tender (x7)
    .complete 8334,2 --Kill Feral Tender (x7)
step
    #label RedOrb
    >>掠夺红球
    .goto Eversong Woods,35.1,28.9
    .complete 8330,1 --Collect Solanian's Scrying Orb (x1)
step
    >>结束该区域内的投标。尽量在北侧结束，我们要在之后回到兰山佩里隆。
    .goto Eversong Woods,35.3,28.5
    .complete 8334,1 --Kill Tender (x7)
    .complete 8334,2 --Kill Feral Tender (x7)
step
    #label arcaneend
    .goto Eversong Woods,35.4,22.5
    >>返回兰山佩里隆
    .turnin 8334,5 >>交任务: 攻势 << Paladin
    .turnin 8334 >>交任务: 攻势 << !Paladin
    .accept 8335 >>接任务: 放逐者菲伦德雷
step << wotlk
    #completewith next
    .goto Eversong Woods,37.7,24.9
    >>对法力妖精或野性温柔使用法术“奥术激流”。它在你的魔法书的“常规”选项卡中
    .complete 8346,1 --Mana Tap creature (1)
step << wotlk
    .goto Eversong Woods,37.7,24.9
    >>杀死玛娜·怀姆斯和野性投标者。掠夺他们的银条
    .complete 8336,1 --Collect Arcane Sliver (x6)
step << wotlk
    .goto Eversong Woods,37.7,24.9
    >>对法力妖精或野性温柔使用法术“奥术激流”。它在你的魔法书的“常规”选项卡中
    .complete 8346,1 --Mana Tap creature (1)
step << !Warlock tbc
    .goto Eversong Woods,35.3,28.5
    .xp 4-360 >>研磨，直到你从4级开始360经验。
step << wotlk
    .goto Eversong Woods,35.3,28.5
    .xp 4-610 >>研磨直到你从4级开始达到610经验。
step << wotlk
    #completewith pepegavendor
    .goto Eversong Woods,37.2,18.9
    .vendor >>提供垃圾 << !Mage !Priest !Warlock
step << wotlk
    .goto Eversong Woods,37.2,18.9
    >>返回奥秘赫利翁
    .turnin 8346,1 >>交任务: 无尽的渴求 << Paladin
    .turnin 8346 >>交任务: 无尽的渴求 << !Paladin
step << !Warlock tbc
    #label arcaneend
    #requires manaarcane
    >>与神秘主义者伊萨纳斯交谈
    .goto Eversong Woods,38.3,19.1
    .turnin 8336 >>交任务: 奥术薄片
step << wotlk
	.isQuestComplete 8336
    .goto Eversong Woods,38.3,19.1
    .turnin 8336 >>交任务: 奥术薄片
step << Mage tbc/Priest tbc
    #completewith pepegavendor
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商扔掉垃圾，买10杯水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Mage wotlk/Priest wotlk/Warlock wotlk
    #completewith pepegavendor
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商垃圾
step << Rogue tbc/Paladin tbc/Hunter tbc
    #completewith pepegavendor
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商垃圾
step << Hunter
    >>进入大楼
    .goto Eversong Woods,39.0,20.0
    .trainer >>训练你的职业咒语
step << Priest
    .goto Eversong Woods,39.4,20.4
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Eversong Woods,39.5,20.6
    .trainer >>训练你的职业咒语
step << Mage
    .goto Eversong Woods,39.2,21.5
    .trainer >>训练你的职业咒语
step << Warlock wotlk
    .goto Eversong Woods,38.9,21.4
    .trainer >>训练你的职业咒语
step
    #label pepegavendor
    >>点击墙上的匾额
    .goto Eversong Woods,29.6,19.4
    .complete 8345,1 --Collect Shrine of Dath'Remar Read (x1)
step
    >>在地板上掠夺卷轴
    .goto Eversong Woods,31.3,22.7
    .complete 8330,2 --Collect Scroll of Scourge Magic (x1)
step
    #completewith next
    .goto Eversong Woods,32.6,25.5,30 >>跑上坡道
step << !Warlock tbc
    #completewith silverhstbc
	#label sliveracctbc
    .goto Eversong Woods,30.7,27.5,0
    .use 20483 >>杀死一个被污染的神秘幽灵。掠夺它以换取一条被污染的神秘银条。点击包中的银条
    .collect 20483,1,8338 --Tainted Arcane Sliver (1)
    .accept 8338 >>接任务: 被污染的奥术薄片
step << wotlk
    #completewith sliverhs
	#label sliveracc
    .goto Eversong Woods,30.7,27.5,0
    .use 20483 >>杀死一个被污染的神秘幽灵。掠夺它以换取一条被污染的神秘银条。点击包中的银条
    .collect 20483,1,8338 --Tainted Arcane Sliver (1)
    .accept 8338 >>接任务: 被污染的奥术薄片
step 
    .goto Eversong Woods,30.7,27.5
    >>前往塔顶，杀死途中的暴徒。在顶端杀死费伦德伦，并掠夺他的头
    .complete 8335,1 --Kill Arcane Wraith (x8)
    .complete 8335,2 --Kill Tainted Arcane Wraith (x2)
    .complete 8335,3 --Collect Felendren's Head (x1)
step
	#requires sliveracc << wotlk
	#requires sliveracctbc << !Warlock tbc
step
	#label sliverhs << wotlk
	#label silverhstbc << tbc
    #completewith next
    .goto Eversong Woods,38.7,20.3
    .hs >>炉灶到Sunstrider岛
step
    #completewith next
    .goto Eversong Woods,38.7,20.3
    .vendor >>供应商垃圾
step
    >>到楼上去
    .goto Eversong Woods,38.7,19.4
    .turnin 8330,1 >>交任务: 索兰尼亚的物品 << Paladin/Rogue/Hunter
    .turnin 8330 >>交任务: 索兰尼亚的物品 << !Paladin !Rogue !Hunter
    .turnin 8345 >>交任务: 达斯雷玛的神龛
step << !Warlock tbc
    .goto Eversong Woods,37.2,18.9
    .turnin 8346 >>交任务: 无尽的渴求
    .turnin 8338 >>交任务: 被污染的奥术薄片
step << wotlk
    >>与奥秘师Helion交谈
    .goto Eversong Woods,37.2,18.9
    .turnin 8346 >>交任务: 无尽的渴求
    .turnin 8338 >>交任务: 被污染的奥术薄片	
step
    >>坐板凳回到兰山佩里隆
    .goto Eversong Woods,35.4,22.5
    .turnin 8335,1 >>交任务: 放逐者菲伦德雷 << Hunter
    .turnin 8335,2 >>交任务: 放逐者菲伦德雷 << Paladin
    .turnin 8335 >>交任务: 放逐者菲伦德雷 << !Hunter !Paladin
step
    .goto Eversong Woods,35.4,22.5
    .accept 8347 >>接任务: 帮助信使
step
    .goto Eversong Woods,35.3,28.5
    .xp 5+1800>>提升经验到1800+/2800xp
step
    >>沿着向南的道路离开阳光岛。与领先者Alarion交谈
    .goto Eversong Woods,40.4,32.2
    .turnin 8347 >>交任务: 帮助信使
    .accept 9704 >>接任务: 失心者的牺牲品
step
    >>走上路，和尸体说话
    .goto Eversong Woods,42.0,35.7
    .turnin 9704 >>交任务: 失心者的牺牲品
    .accept 9705 >>接任务: 找回包裹
step
    .goto Eversong Woods,40.4,32.2
    >>返回领先者Alarion
    .turnin 9705 >>交任务: 找回包裹
    .accept 8350 >>接任务: 送信
step
    >>杀死你在去猎鹰广场的路上看到的暴徒
    .goto Eversong Woods,45.4,40.8
    .xp 5+2690>>提升经验到2690+/2800xp
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 6-10 永歌森林
#version 1
#group RestedXP部落1-30
#next 10-20 永歌森林 / 幽魂之地 << !Warrior
#next 10-13 杜隆塔尔 << Warrior
step
    >>与Jaronis魔法师交谈
    .goto Eversong Woods,47.3,46.3
    .accept 8472 >>接任务: 失效的傀儡
step
    #completewith AeldonS
    .goto Eversong Woods,48.2,47.7
    .home >>把你的炉石放在鹰翼广场
step << BloodElf
    >>与旅店老板Delaniel交谈
    .goto Eversong Woods,47.7,47.2,10,0
    .goto Eversong Woods,48.2,47.7
    .turnin 8350 >>交任务: 送信
step << Priest/Mage/Warlock/Warrior/Rogue
    .goto Eversong Woods,48.3,47.0,8,0
step << Priest
    .goto Eversong Woods,48.3,47.0,8,0
    .goto Eversong Woods,47.9,48.0
    >>上楼去
    .accept 9489 >>清洁疤痕 << BloodElf
    .trainer >>训练你的职业咒语
step << Mage
    .goto Eversong Woods,48.0,48.1
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Eversong Woods,48.2,47.9
    .trainer >>训练你的职业咒语
step << Warrior/Rogue
    .goto Eversong Woods,48.6,47.6
    .train 3273 >>培训急救
step
    #completewith next
    .goto Eversong Woods,48.2,47.7
    .vendor >>尽可能多地购买5级饮料 << Mage/Warlock/Priest
step
    #label AeldonS
    .goto Eversong Woods,47.7,47.2,10,0
    .goto Eversong Woods,48.1,46.2
    >>与通缉海报和Aeldon Sunbrand交谈
    .accept 8468 >>接任务: 通缉：饥饿者泰里斯
    .accept 8463 >>接任务: 不稳定的法力水晶
step << Paladin
    >>进去吧
    .goto Eversong Woods,48.4,46.5
    .trainer >>训练你的职业咒语
step << Rogue
    >>上楼去
    .goto Eversong Woods,48.5,45.9
    .trainer >>训练你的职业咒语
step << Hunter
    >>进去吧
    .goto Eversong Woods,48.3,46.1
    .trainer >>训练你的职业咒语
step << Warrior tbc/Paladin tbc
    .goto Eversong Woods,48.5,45.9
    .vendor >>供应商垃圾。如果能给你足够的钱买格拉迪斯(5s9c)，就卖掉你的武器。如果你还不够，你会回来的
step << Warrior tbc/Paladin tbc
    .goto Eversong Woods,48.5,45.9
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Warrior wotlk/Paladin wotlk
    .goto Eversong Woods,48.5,45.9
    .vendor >>供应商垃圾。如果能给你足够的钱买一把木槌，就卖掉你的武器(6s66c)。如果你还不够，你会回来的
step << Warrior wotlk/Paladin wotlk
    .goto Eversong Woods,48.5,45.9
    .money <0.0666
    >>购买木槌并装备
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Rogue
    .goto Eversong Woods,48.5,45.9
    .vendor >>供应商垃圾。如果你的武器能给你足够的钱买斯蒂莱托(3s82c)，就把它卖掉。如果你还不够，你会回来的
step << Rogue
    .money <0.0382
    .goto Eversong Woods,48.5,45.9
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step
    #sticky
    #label thaelishead
    >>在主楼杀死饥饿者泰利斯
    .goto Eversong Woods,45.0,37.7
    .complete 8468,1 --Collect Thaelis's Head (x1)
step
    >>从奥术巡逻者那里掠夺奥术核心。从该区域地面上的箱子中盗取不稳定的法力水晶
    .goto Eversong Woods,46.8,41.1,40,0
    .goto Eversong Woods,46.7,34.9,40,0
    .goto Eversong Woods,40.6,37.9,40,0
    .goto Eversong Woods,44.4,45.8,40,0
    .goto Eversong Woods,46.8,39.5
    .complete 8472,1 --Collect Arcane Core (x6)
    .complete 8463,1 --Collect Unstable Mana Crystal (x6)
step
    #requires thaelishead
    .goto Eversong Woods,47.3,46.3
    >>与Maigster Jaronis交谈
    .turnin 8472 >>交任务: 失效的傀儡
    .accept 8895 >>接任务: 送往北部圣殿的信
step
    >>与Kan'ren中士交谈
    .goto Eversong Woods,47.8,46.6
    .turnin 8468 >>交任务: 通缉：饥饿者泰里斯
step
    .goto Eversong Woods,48.2,46.0
    >>与Aeldon Sunbrand交谈
    .turnin 8463 >>交任务: 不稳定的法力水晶
    .accept 9352 >>接任务: 达纳苏斯的侵扰
step << Warrior/Paladin tbc
    .goto Eversong Woods,48.5,45.9
    .vendor >>供应商垃圾。如果能给你足够的钱买格拉迪斯(5s9c)，就卖掉你的武器。如果你还不够，你会回来的
step << Warrior/Paladin tbc
    .goto Eversong Woods,48.5,45.9
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Paladin wotlk
    .goto Eversong Woods,48.5,45.9
    .vendor >>供应商垃圾。如果能给你足够的钱买一把木槌，就卖掉你的武器(6s66c)。如果你还不够，你会回来的
step << Paladin wotlk
    .goto Eversong Woods,48.5,45.9
    .money <0.0666
    >>购买木槌并装备
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Rogue
    .money <0.0382
    .goto Eversong Woods,48.5,45.9
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step
    >>离开Falconwing广场，与Ley Keeper Caidanis交谈
    .goto Eversong Woods,44.6,53.1
    .turnin 8895 >>交任务: 送往北部圣殿的信
    .accept 9119 >>接任务: 西部圣殿的麻烦
step
    .goto Eversong Woods,45.2,56.4
    >>与车旁的学徒雷伦交谈
    .accept 9035 >>接任务: 打探匪情
step
    >>与河边的学徒梅勒多交谈
    .goto Eversong Woods,44.9,61.0
    .turnin 9035 >>交任务: 打探匪情
    .accept 9062 >>接任务: 浸水的书页
step
    .goto Eversong Woods,44.3,62.0
    >>格里莫尔号在桥下的水中。
    .complete 9062,1 --Collect Antheol's Elemental Grimoire (x1)
step
    >>返回学徒梅勒多
    .goto Eversong Woods,44.9,61.0
    .turnin 9062 >>交任务: 浸水的书页
    .accept 9064 >>接任务: 学徒的欺瞒
step
    >>在死亡疤痕处与游骑兵杰拉交谈
    .goto Eversong Woods,50.3,50.8
    .accept 8475 >>接任务: 死亡之痕
step << BloodElf Priest
    .spell 1243 >>使用真言术：对Eversong Rangers的坚韧
    .goto Eversong Woods,50.3,51.0
    .complete 9489,1 --Eversong Ranger Blessed (6)
    .unitscan Eversong Ranger
step
    #completewith next
    .goto Eversong Woods,55.7,54.5
     >>杀死瘟疫骨柱(骷髅)
    .complete 8475,1 --Kill Plaguebone Pillager (x8)
step
    .goto Eversong Woods,55.7,54.5
    >>与讲师Antheol交谈
    .turnin 9064 >>交任务: 学徒的欺瞒
    .accept 9066 >>接任务: 导师的训诫
step
    >>杀死死亡伤疤中的皮拉杰(骷髅)
    .goto Eversong Woods,50.3,57.5,60,0
    .goto Eversong Woods,50.2,51.8,60,0
    .goto Eversong Woods,50.3,57.5,60,0
    .goto Eversong Woods,50.2,51.8,60,0
    .goto Eversong Woods,50.3,57.5,60,0
    .goto Eversong Woods,50.2,51.8,60,0
    .goto Eversong Woods,50.3,57.5,60,0
    .goto Eversong Woods,50.2,51.8
    .complete 8475,1 --Kill Plaguebone Pillager (x8)
step
    >>返回Ranger Jaela
    .goto Eversong Woods,50.3,50.8
    .turnin 8475,2 >>交任务: 死亡之痕 << Paladin
    .turnin 8475 >>交任务: 死亡之痕 << !Paladin
step << Paladin/Priest/Mage
    .use 22473 >>在Ralen上使用包中的纪律棒
    .goto Eversong Woods,45.2,57.0
    .complete 9066,2 --Apprentice Ralen Disciplined
step << Paladin/Priest/Mage
    .use 22473 >>在Meledor上使用包中的纪律棒
    .goto Eversong Woods,44.9,61.0
    .complete 9066,1 --Apprentice Meledor Disciplined
step
    .goto Eversong Woods,36.7,57.4
    >>与Ley Keeper Valania交谈
    .turnin 9119 >>交任务: 西部圣殿的麻烦
    .accept 8486 >>接任务: 不稳定的奥术
step
    #completewith next
    .use 20765 >>在该地区杀死一名达纳西亚侦察兵。抢走他们的犯罪文件。在您的包中点击它
    .goto Eversong Woods,36.8,60.8,30,0
    .goto Eversong Woods,34.6,62.0,30,0
    .goto Eversong Woods,34.0,60.8,30,0
    .goto Eversong Woods,34.2,58.5,30,0
    .goto Eversong Woods,36.8,60.8
    .complete 9352,1 --Intruder Defeated
    .collect 20765,1,8482 --Incriminating Documents (1)
    .accept 8482 >>接任务: 秘密文件
    .unitscan Darnassian Scout
step
    .goto Eversong Woods,36.0,59.3
    >>杀死法师和法师追踪者
    .complete 8486,1 --Kill Manawraith (x5)
    .complete 8486,2 --Kill Mana Stalker (x5)
step
    >>在该地区杀死一名达纳西亚侦察兵。抢走他们的犯罪文件。在您的包中点击它
    .goto Eversong Woods,36.8,60.8,20,0
    .goto Eversong Woods,34.6,62.0,20,0
    .goto Eversong Woods,34.0,60.8,20,0
    .goto Eversong Woods,34.2,58.5,20,0
    .goto Eversong Woods,36.8,60.8
       .complete 9352,1 --Intruder Defeated
           .collect 20765,1,8482 --Incriminating Documents (1)
    .accept 8482 >>接任务: 秘密文件
    .unitscan Darnassian Scout
step
    >>返回Ley Keeper Velania
    .goto Eversong Woods,36.7,57.4
    .turnin 8486,1 >>交任务: 不稳定的奥术 << Paladin
    .turnin 8486 >>交任务: 不稳定的奥术 << !Paladin
    .turnin 9352 >>交任务: 达纳苏斯的侵扰
step
    >>与哈什维利昂·日喀则交谈
    .goto Eversong Woods,30.2,58.4
    .accept 8884 >>接任务: 鱼头......
step
    #sticky
    #completewith murlocend3
        #label CaptainKelisendra
    >>杀死穆洛克斯，直到你洗劫凯里森德拉上尉丢失的车辙机
    .goto Eversong Woods,28.1,60.1
        .collect 21776,1,8887 --Captain Kelisendra's Lost Rutters
    .use 21776
    .accept 8887 >>接任务: 凯莉森德拉船长的航海图
step
    >>为Murloc头杀死Murlocs
    .goto Eversong Woods,28.1,60.1
.complete 8884,1 --Collect Grimscale Murloc Head (x8)
step << Warrior/Warlock/Hunter/Rogue
    .goto Eversong Woods,30.2,58.4
    .xp 7+3195>>提升经验到3195+/4500xp
step
    #label murlocend3
        #requires CaptainKelisendra
    .goto Eversong Woods,30.2,58.4
    >>返回哈什维利翁日喀则
    .turnin 8884 >>交任务: 鱼头......
    .accept 8885 >>接任务: 呜啦哇啦的戒指
step << Warrior/Warlock/Hunter/Rogue
    .goto Eversong Woods,35.4,55.2
    .deathskip >>到这里，然后在精神治疗者那里死去并重生(确保你的分区是Eversong Woods，而不是West Sanctum)。
step << Paladin/Priest/Mage
    #completewith next
    .goto Eversong Woods,28.1,61.0
    .deathskip >>在精神治疗师处死亡并重生
step << Warrior/Warlock/Hunter/Rogue
    .isOnQuest 8482
    .goto Eversong Woods,48.2,46.0
    .turnin 8482 >>交任务: 秘密文件
    .accept 8483 >>接任务: 矮人间谍
step << Warrior
    .goto Eversong Woods,48.3,45.9
    .train 202 >>训练2h剑
step << Rogue
    .goto Eversong Woods,48.3,45.9
    .train 201 >>训练1h剑
step << Rogue
    .goto Eversong Woods,48.5,45.9
    .trainer >>训练你的职业咒语
step << Hunter
    .goto Eversong Woods,48.3,46.1
    .trainer >>训练你的职业咒语
step << Warlock tbc
    .trainer >>训练你的职业咒语
    .goto Eversong Woods,48.2,47.9
    .cast 20270 >>购买Firebolt r2书籍。在您的包中点击它
    .goto Eversong Woods,48.3,47.9
    .use 16302 
step << Warlock wotlk
    .trainer >>训练你的职业咒语
    .goto Eversong Woods,48.2,47.9
step << Warrior/Warlock/Hunter/Rogue
    .goto Eversong Woods,44.8,53.1
    >>与Prospector Anvilward交谈，等待角色扮演活动结束。杀了他，然后洗劫他。
    .complete 8483,1 --Collect Prospector Anvilward's Head (x1)
    .skipgossip
    .timer 28,Prospector Anvilward RP
step << Warrior/Warlock/Hunter/Rogue
    .use 22473 >>在Ralen上使用包中的纪律棒
    .goto Eversong Woods,45.2,57.0
    .complete 9066,2 --Apprentice Ralen Disciplined
step << Warrior/Warlock/Hunter/Rogue
    .use 22473 >>在Meledor上使用包中的纪律棒
    .goto Eversong Woods,44.9,61.0
    .complete 9066,1 --Apprentice Meledor Disciplined
step << !Hunter
    >>与Magistrix Landra Dawnstrider交谈
    .goto Eversong Woods,44.0,70.8
    .accept 9395 >>接任务: 萨瑟利尔庄园
    .accept 9254 >>接任务: 外出的学徒
step << Hunter
    >>与Magistrix Landra Dawnstrider交谈
    .goto Eversong Woods,44.0,70.8
    .accept 9254 >>接任务: 外出的学徒
step << Hunter
    .goto Eversong Woods,43.7,71.3
    .accept 9358 >>接任务: 游侠萨蕾恩
step << Hunter
    #completewith Sunsail
    .goto Eversong Woods,43.7,71.3
    .home >>将您的炉石放在Fairwindow村
step << !Hunter
    >>与Marniel Amberlight交谈
    .goto Eversong Woods,43.7,71.3
    .accept 9358 >>接任务: 游侠萨蕾恩
step
    >>与Ardeyn Riverwind交谈
    .goto Eversong Woods,43.6,71.2
    .accept 9258 >>接任务: 焦痕谷
step
    >>上楼去
    .goto Eversong Woods,43.3,70.8
    .accept 8892 >>接任务: 阳帆港
step
    #completewith next
    .goto Eversong Woods,44.0,70.4,0,0
    .vendor >>供应商垃圾。如果你愿意的话，你可以从哈利斯那里买6个老虎袋
step
    >>与Velan Brightoak交谈
    .goto Eversong Woods,44.7,69.6
    .accept 8491 >>接任务: 收集豹皮
step
    >>与游侠萨琳交谈
    .goto Eversong Woods,46.9,71.8
    .turnin 9358 >>交任务: 游侠萨蕾恩
    .accept 9252 >>接任务: 保卫晴风村
step
    #completewith Sunsail
    >>杀死斯普林帕·林克斯。掠夺他们的皮毛
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step << !BloodElf/!Hunter
    >>与萨尔瑟尔勋爵交谈
    .goto Eversong Woods,38.1,73.6
    .turnin 9395 >>交任务: 萨瑟利尔庄园
    .accept 9067 >>接任务: 无尽的宴会
step
    #label Sunsail
    >>与Kelisendra上尉和Velendris Whitemorn通话
    .goto Eversong Woods,36.4,66.7
    .turnin 8887 >>交任务: 凯莉森德拉船长的航海图
    .accept 8886 >>接任务: 暗鳞强盗！
    .accept 8480 >>接任务: 失落的军备
step
    #completewith Thugs
    >>掠夺箱子时杀死恶棍和流氓
    .complete 8892,1 --Kill Wretched Thug (x5)
    .complete 8892,2 --Kill Wretched Hooligan (x5)
step
    .goto Eversong Woods,32.7,69.1
    >>在地上掠夺武器箱。主楼的前两层有很多，还有一些在码头和船只附近
    .complete 8480,1 --Collect Sin'dorei Armaments (x8)
step
    >>返回队长营地
    .goto Eversong Woods,36.4,66.8
    .turnin 8480 >>交任务: 失落的军备
    .accept 9076 >>接任务: 失心者的领袖
step
    #label Thugs
    .goto Eversong Woods,32.8,69.4
    >>爬到楼顶，杀死阿尔达隆。抢他的头
    .complete 9076,1 --Collect Aldaron's Head (x1)
step
    >>结束残暴暴徒的杀戮
    .goto Eversong Woods,32.8,69.4
    .complete 8892,1 --Kill Wretched Thug (x5)
    .complete 8892,2 --Kill Wretched Hooligan (x5)
step
    #completewith pelttyyy
    >>在前往墨洛克的途中，请留意斯普林帕夫的毛皮
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step
    #completewith next
    >>杀死穆洛克。掠夺他们的货物。或者，为货物洗劫小屋附近的桶
    >>使用你的奥术激流法术来打断神谕的治疗 << BloodElf
    .complete 8886,1 --Collect Captain Kelisendra's Cargo (x6)
step
    >>Mmmrrggglll沿着海岸巡逻。杀死并掠夺他。
    *Use Arcane Torrent when he starts to heal himself << BloodElf
    .goto Eversong Woods,24.3,74.1,50,0
    .goto Eversong Woods,26.0,65.9,50,0
    .goto Eversong Woods,24.3,74.1,50,0
    .goto Eversong Woods,26.0,65.9,50,0
    .goto Eversong Woods,24.3,74.1,50,0
    .goto Eversong Woods,26.0,65.9
    .complete 8885,1 --Collect Ring of Mmmrrrggglll (x1)
    .unitscan Mmmrrrggglll
step
    .goto Eversong Woods,24.5,69.9
    >>杀死穆洛克。掠夺他们的货物。或者，为货物洗劫小屋附近的桶
    >>使用你的奥术激流法术来打断神谕的治疗 << BloodElf
    .complete 8886,1 --Collect Captain Kelisendra's Cargo (x6)
step
    >>返回哈什维利翁日喀则山顶
    .goto Eversong Woods,30.2,58.4
    .turnin 8885,1 >>交任务: 呜啦哇啦的戒指 << Hunter
    .turnin 8885,4 >>交任务: 呜啦哇啦的戒指 << Paladin
    .turnin 8885 >>交任务: 呜啦哇啦的戒指 << !Hunter !Paladin
step
    #label pelttyyy
    .goto Eversong Woods,36.4,66.7
    >>返回队长营地
    .turnin 8886 >>交任务: 暗鳞强盗！
    .turnin 9076,1 >>交任务: 失心者的领袖 << Paladin
    .turnin 9076 >>交任务: 失心者的领袖 << !Paladin
step << Hunter
    .goto Eversong Woods,34.1,80.0
    .turnin 9258 >>交任务: 焦痕谷
    .accept 8473 >>接任务: 痛苦的抉择
step << Hunter
    #label oldwhitebark
    #completewith barktimeover
    .goto Eversong Woods,35.0,84.2
    .use 8474 >>杀死老怀特巴克。抢他的吊坠。点击包中的挂件
        .collect 23228,1,8474 --Collect Old Whitebark's Pendant (x1)
    .accept 8474 >>接任务: 怀特巴克的坠饰
    .unitscan Old Whitebark
step << Hunter
    >>小心，因为绿色守卫有双重伤害英雄打击法术
    .complete 8473,1 --Kill Withered Green Keeper (x10)
step << Hunter
    #label barktimeover
    #requires oldwhitebark
    .goto Eversong Woods,34.1,80.0
    .turnin 8473 >>交任务: 痛苦的抉择
    .turnin 8474 >>交任务: 怀特巴克的坠饰
    .accept 10166 >>接任务: 怀特巴克的记忆
step << Hunter
    .use 28209 >>使用吊坠召唤老白树皮。一定要从他那里开始最大射程。杀了他然后交出任务
    .goto Eversong Woods,37.6,86.2
    .turnin 10166 >>交任务: 怀特巴克的记忆
step
    #completewith next
    >>杀死斯普林帕斯。掠夺他们的皮毛
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step << !Hunter
    >>上楼去，和游骑兵德戈利恩通话
    .goto Eversong Woods,43.3,70.8
    .turnin 8892 >>交任务: 阳帆港
    .accept 9359 >>接任务: 远行者居所
step << !Hunter
    .goto Eversong Woods,43.7,71.3
    .vendor >>供应商在楼下垃圾和维修
step << !Hunter
    >>与Velan Brightoak交谈
    .goto Eversong Woods,44.7,69.7
    .turnin 8491,2 >>交任务: 收集豹皮 << Paladin
    .turnin 8491 >>交任务: 收集豹皮 << !Paladin
    .isQuestComplete 8491
step
    >>请注意，Darkwraiths对健康状况不佳感到愤怒。Rotlem掠夺者也有一个瞬发15点伤害法术
    .goto Eversong Woods,50.9,80.7,60,0
    .goto Eversong Woods,51.3,75.3,60,0
    .goto Eversong Woods,52.9,71.7,60,0
    .goto Eversong Woods,50.9,80.7,60,0
    .goto Eversong Woods,51.3,75.3,60,0
    .goto Eversong Woods,52.9,71.7
    .complete 9252,2 --Kill Darkwraith (x4)
    .complete 9252,1 --Kill Rotlimb Marauder (x4)
step
    >>与学徒米尔维达交谈
    .goto Eversong Woods,54.3,71.0
    .turnin 9254 >>交任务: 外出的学徒
    .accept 8487 >>接任务: 被腐蚀的土地
step
    .goto Eversong Woods,52.0,69.1
    >>掠夺散布在疤痕上的绿色污染土壤
    .complete 8487,1 --Collect Tainted Soil Sample (x8)
step
    >>与学徒米尔维达交谈
    .goto Eversong Woods,54.3,71.0
    .turnin 8487 >>交任务: 被腐蚀的土地
    >>等待角色扮演事件
    .accept 8488 >>接任务: 出人意料的结果
step
    .goto Eversong Woods,54.3,71.0
    >>将产生3个暴徒。让他们先攻击米尔维达，这样他们就会攻击她，然后杀死他们来保护米尔维德。
    .complete 8488,1 --Protect Apprentice Mirveda
step
    .goto Eversong Woods,54.3,71.0
    .turnin 8488 >>交任务: 出人意料的结果
    .accept 9255 >>接任务: 研究笔记
step << Paladin/Priest/Mage
     .goto Eversong Woods,52.0,69.1
    .xp 9+5875>>提升经验到5875+/6500xp
step << Warrior/Warlock/Rogue !Undead/!Warlock !Paladin !Priest !Mage
     .goto Eversong Woods,52.0,69.1
    .xp 9+5700>>提升经验到5700+/6500xp
step << Undead Warlock
     .goto Eversong Woods,52.0,69.1
    .xp 9+5950>>提升经验到5950+/6500xp
step << !Hunter !Warlock/!Scourge !Hunter
    #completewith next
    .goto Eversong Woods,48.2,47.7
    .hs >>壁炉到猎鹰广场
step << Undead Warlock
    .goto Eversong Woods,55.7,54.5
    .turnin 9066 >>交任务: 导师的训诫
step << Undead Warlock
    #completewith next
    .goto Eversong Woods,56.7,49.6,25 >>进入Silvermoon
step << Undead Warlock
    .goto Silvermoon City,63.4,31.9,20,0
    .goto Silvermoon City,49.47,15.03
    .cast 25649 >>将易位之珠带到地下
step << Undead Warlock
    #completewith next
    .goto Undercity,66.0,44.0,15 >>乘电梯到幽暗城
step << Undead Warlock
    .goto Undercity,85.1,26.0
    >>与卡伦丁交谈
    .accept 1473 >>接任务: 虚空中的生物
step << Undead Warlock
    #completewith next
    .goto Undercity,82.36,15.31
    .goto Undercity,67.88,14.97,30 >>转到右侧的试剂供应商，执行“注销跳过”，将角色定位在最低楼梯的最高部分，直到看起来像漂浮在空中，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=-Bi95bCN8dM >>单击此处查看示例
    >>如果你做不到这一点，就正常离开幽暗城
step << Undead Warlock
    #completewith next
    .goto Tirisfal Glades,61.85,66.59,40 >>退出地下城
step << Undead Warlock
    >>掠夺塔内的箱子
    .goto Tirisfal Glades,51.1,67.6
    .complete 1473,1 --Creature of the Void (1)
step << Undead Warlock
    >>返回幽暗城。与卡伦丁交谈
    .goto Undercity,85.1,26.0
    .turnin 1473 >>交任务: 虚空中的生物
    .accept 1471 >>接任务: 誓缚
step << Undead Warlock
    .use 6284 >>在召唤圈使用你袋子里的召唤符文。杀死产卵的虚空行者
    .goto Undercity,86.6,27.1
    .complete 1471,1 --Kill Summoned Voidwalker (1)
step << Undead Warlock
    .goto Undercity,85.1,26.0
    >>与卡伦丁交谈
    .turnin 1471 >>交任务: 誓缚
step << Undead Warlock
    #completewith next
    .hs >>壁炉到猎鹰广场
step << Paladin/Priest/Mage
    >>与Aeldon Sunbrand交谈
    .goto Eversong Woods,48.2,46.0
    .turnin 8482 >>交任务: 秘密文件
    .accept 8483 >>接任务: 矮人间谍
step << Paladin/Priest/Mage
    .goto Eversong Woods,44.8,53.1
    >>与Prospector Anvilward交谈，等待角色扮演活动结束。杀了他，然后洗劫他。
    .complete 8483,1 --Collect Prospector Anvilward's Head (x1)
    .skipgossip
    .timer 28,Prospector Anvilward RP
step << !Hunter
    >>返回Aeldon Sunbrand
    .goto Eversong Woods,48.2,46.0
    .turnin 8483,1 >>交任务: 矮人间谍 << Paladin
    .turnin 8483 >>交任务: 矮人间谍 << !Paladin
step << !Hunter
     .goto Eversong Woods,47.7,47.2
    .xp 10 >>升级到10级
step << Warlock
    #completewith next
    .goto Eversong Woods,56.7,49.6,20,0
    .goto Silvermoon City,75.3,44.5,20 >>前往银月城。进去，然后下楼
step << Warlock
    .goto Silvermoon City,74.4,47.2
    .accept 9529 >>接任务: 虚空石 << BloodElf
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Silvermoon City,79.5,58.5
    >>从Suntouch酿酒师处购买Suntouth特别储备酒
    .collect 22775,1 --Collect Suntouched Special Reserve
step << Warlock
    .goto Eversong Woods,56.7,49.6
    .zone Eversong Woods >>前往: 永歌森林
step << Mage
    .goto Eversong Woods,48.0,48.1
    .trainer >>训练你的职业咒语
step << Priest
    .goto Eversong Woods,47.9,48.0
    .turnin 9489 >>清洁疤痕 << BloodElf
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Eversong Woods,48.5,45.9
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Eversong Woods,47.1,47.5
    .vendor >>购买Gladius并装备它
step << Paladin
    .goto Eversong Woods,48.4,46.5
    .trainer >>训练你的职业咒语
step << !Hunter
    >>装备你早先买的Gladius << Rogue
    >>与讲师Antheol交谈
    .goto Eversong Woods,55.7,54.5
    .turnin 9066 >>交任务: 导师的训诫
    .accept 9402 >>接任务: 捞瓶子 << Mage
step << Mage
    >>潜入水中，寻找底部的蓝色瓶子
    .goto Eversong Woods,54.9,56.4
    .complete 9402,1 --Azure Phial (1)
step << Mage
    .goto Eversong Woods,55.7,54.5
    .turnin 9402 >>交任务: 捞瓶子
    .accept 9403 >>接任务: 最纯净的水
step << Warrior
    .goto Eversong Woods,56.7,49.6,25,0
    .goto Silvermoon City,63.4,31.9,20,0
    .goto Silvermoon City,49.47,15.03
    .cast 25649 >>进入Silvermoon。将易位之珠带到地下
step << Warrior
    >>去布里尔客栈
    .goto Tirisfal Glades,61.9,52.5
    .trainer >>训练你的职业咒语
step << Warrior
    #completewith next
    .goto Tirisfal Glades,60.7,58.8
    .zone Durotar >>乘坐飞艇前往: 杜隆塔尔
step << Warrior
    .isOnQuest 1818
    .abandon 1818 >>放弃与迪林杰交谈
step << Warrior
    .goto Durotar,46.4,22.9
    .accept 834 >>接任务: 沙漠之风
step << Warrior
    >>掠夺地上的小麻袋
    .goto Durotar,51.7,27.7
    .complete 834,1 --Sack of Supplies (5)
step
    .destroy 23500 >>摧毁: 萨瑟利尔庄园的宴会邀请函
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 10-20 永歌森林 / 幽魂之地
#version 1
#group RestedXP部落1-30
#next 20-23 石爪山脉 / 贫瘠之地
step << Orc Hunter/Troll Hunter
    .money <0.1000
    >>前往Farstreders广场，与Ileda交谈
    .goto Silvermoon City,91.2,38.7
    .train 202 >>训练2h剑
step << Orc/Troll/Tauren
    #completewith next
    .goto Eversong Woods,56.7,49.6,20,0
    .goto Eversong Woods,54.4,50.7
    >>用完银月城
    .fp Silvermoon >>获取银月城飞行路线
step << Undead/BloodElf !Hunter
    .goto Eversong Woods,60.4,62.5
    .vendor >>从Zalene购买Springpaw开胃菜
    .collect 22776,1 --Collect Springpaw Appetizers
step << !Hunter
    >>与Dawnrunner中尉交谈
    .goto Eversong Woods,60.3,62.8
    .turnin -9359 >>交任务: 远行者居所
    .accept 8476 >>接任务: 阿曼尼的进犯
step << BloodElf Hunter
    >>与Dawnrunner中尉交谈
    .goto Eversong Woods,60.3,62.8
    .accept 8476 >>接任务: 阿曼尼的进犯
step << !BloodElf
    >>与Dawnrunner中尉交谈
    .goto Eversong Woods,60.3,62.8
    .turnin -9359 >>交任务: 远行者居所
    .accept 8476 >>接任务: 阿曼尼的进犯
step << BloodElf Hunter
    .accept 9484 >>接任务: 驯服野兽
step << BloodElf Hunter
    .use 23702 >>点击你袋子里的驯龙鹰棒。尝试在最大射程(30码)进行
    .goto Eversong Woods,60.1,58.9,40,0
    .goto Eversong Woods,62.1,59.8,40,0
    .goto Eversong Woods,61.4,65.8,40,0
    .goto Eversong Woods,60.1,58.9,40,0
    .goto Eversong Woods,62.1,59.8,40,0
    .goto Eversong Woods,61.4,65.8
    .complete 9484,1 --Tame a Crazed Dragonhawk
step << Paladin/Rogue
    .train 2018 >>火车铁匠。稍后你将获得采矿，这将允许你制造磨石(1小时+2武器伤害)。如果你愿意，可以跳过铁匠
    .goto Eversong Woods,59.5,62.6
    .accept 8477 >>接任务: 制矛师之锤
step << !Paladin !Rogue
    >>与Arathel Sunforge交谈
    .goto Eversong Woods,59.5,62.6
    .accept 8477 >>接任务: 制矛师之锤
step << BloodElf Hunter
    .goto Eversong Woods,60.3,62.8
    .turnin 9484 >>交任务: 驯服野兽
    .accept 9486 >>接任务: 驯服野兽
step << BloodElf Hunter
    .use 23702 >>单击弹簧爪上包中的驯服棒。尝试在最大射程(30码)进行
    .goto Eversong Woods,63.2,64.7,30,0
    .goto Eversong Woods,63.2,63.5,30,0
    .goto Eversong Woods,64.0,63.8,30,0
    .goto Eversong Woods,62.8,61.6,30,0
    .goto Eversong Woods,65.3,59.5,30,0
    .goto Eversong Woods,66.2,57.5,30,0
    .complete 9486,1 --Tame an Elder Springpaw
    .unitscan Elder springpaw
step << BloodElf Hunter
    .goto Eversong Woods,60.3,62.8
    .turnin 9486 >>交任务: 驯服野兽
    .accept 9485 >>接任务: 驯服野兽
step << BloodElf Mage
    .use 23566 >>当你在瀑布下时，点击包里的Phial
    .goto Eversong Woods,64.2,72.6
    .complete 9403,1 --Filled Azure Phial (1)
step
    #completewith Marosh
    >>杀死阿曼尼狂暴者和斧头投掷者。当心狂暴者对低血量的愤怒
    .complete 8476,1 --Kill Amani Berserker (x5)
    .complete 8476,2 --Kill Amani Axe Thrower (x5)
step << Orc Hunter wotlk / Troll Hunter wotlk
    #completewith next
    .tame 15652 >>在前往任务区的途中驯服一名长老斯普林帕夫
    .unitscan Elder Springpaw
step
     .goto Eversong Woods,70.1,72.3
    >>杀死奥滕贝。抢他的锤子
    >>Otembe有机会丢掉白色或绿色的物品。如果你想的话，可以再杀他一次，换个更好的武器，他可以很快重生 << Paladin/Rogue/Warrior
    .complete 8477,1 --Collect Otembe's Hammer (x1)
step
    .goto Eversong Woods,70.5,72.3
    >>与笼子里的文加西交谈
    .accept 8479 >>接任务: 祖玛洛什
step
    >>杀死小屋顶上的Zul'Marosh。掠夺他的头和计划。点击包中的计划
    *Zul'Marosh also has a guaranteed chance to drop a white or green item but a longer respawn << Paladin/Rogue/Warrior
    .goto Eversong Woods,62.5,79.7
    .complete 8479,1 --Collect Chieftain Zul'Marosh's Head (x1)
    .collect 23249,1,9360 --Collect Amani Invasion Plans (x1)
    .accept 9360 >>接任务: 阿曼尼的入侵
    .use 23249
step
    #label Marosh
    .goto Eversong Woods,70.5,72.4
    >>如果你还没有得到好的绿色武器，再杀一次奥滕贝 << Paladin/Rogue/Warrior
    >>与笼子里的文加西交谈
    .turnin 8479,1 >>交任务: 祖玛洛什 << Hunter
    .turnin 8479,2 >>交任务: 祖玛洛什 << Priest/Warlock/Mage
    .turnin 8479 >>交任务: 祖玛洛什 << !Hunter !Priest !Warlock !Mage
step
    >>完成区域内巨魔的杀死，同时执行其他任务。小心狂暴者在低血量时激怒
    .goto Eversong Woods,71.1,77.3
    .complete 8476,1 --Kill Amani Berserker (x5)
    .complete 8476,2 --Kill Amani Axe Thrower (x5)
step << BloodElf Hunter
    .use 30105 
    .goto Ghostlands,45.6,21.1
    .complete 9485,1 --Tame a Mistbat
step << BloodElf Hunter
    .goto Ghostlands,46.3,28.8
    .accept 9327 >>接任务: 被遗忘者
step << BloodElf Hunter
    .goto Ghostlands,44.8,32.5
    .turnin 9327 >>交任务: 被遗忘者
    .accept 9758 >>接任务: 返回奥术师范迪瑞尔身边
step << BloodElf Hunter
    .goto Ghostlands,47.3,28.9
    .accept 9130 >>接任务: 银月城的货物
step << BloodElf Hunter
    .goto Ghostlands,47.0,28.5
    .accept 9152 >>接任务: 托博尔的补给品
step << BloodElf Hunter
    .goto Ghostlands,46.3,28.4
    .turnin 9758 >>交任务: 返回奥术师范迪瑞尔身边
step << BloodElf Hunter
    .goto Ghostlands,46.3,28.6
    .accept 9138 >>接任务: 日冕村
step << BloodElf Hunter
    #completewith next
    .goto Ghostlands,45.5,30.5
    .fp Tranquillien >>获取宁静的飞行路线
step << BloodElf Hunter
    >>不要飞往银月城
    .goto Ghostlands,45.5,30.6
    .turnin 9130 >>交任务: 银月城的货物
    .accept 9133 >>接任务: 飞往银月城
step << BloodElf Hunter
    #completewith next
    .goto Eversong Woods,44.0,70.7
    .hs >>炉灶 to Fairwindow村
step << BloodElf Hunter
    .goto Eversong Woods,44.0,70.7
    .turnin 9255 >>交任务: 研究笔记
    .accept 9144 >>接任务: 迷失在幽魂之地
step << BloodElf Hunter
    .goto Eversong Woods,44.7,69.7
    .turnin 8491 >>交任务: 收集豹皮
step << BloodElf Hunter
    .goto Eversong Woods,46.9,71.8
    .turnin 9252 >>交任务: 保卫晴风村
step << BloodElf Hunter
    .goto Eversong Woods,46.9,71.6
    .accept 9253 >>接任务: 符文看守者德尔雅
step << BloodElf Hunter
    .use 22473 >>在Meledor上使用包中的纪律棒
.goto Eversong Woods,44.9,61.0
    .complete 9066,1 --Apprentice Meledor Disciplined
step << BloodElf Hunter
    .use 22473 >>在Ralen上使用包中的纪律棒
.goto Eversong Woods,45.2,57.0
    .complete 9066,2 --Apprentice Ralen Disciplined
step << BloodElf Hunter
    .goto Eversong Woods,48.2,46.0
    .turnin 8482 >>交任务: 秘密文件
    .accept 8483 >>接任务: 矮人间谍
step << BloodElf Hunter
    .goto Eversong Woods,48.3,46.1
    .trainer >>训练你的职业咒语
step << BloodElf Hunter
    .goto Eversong Woods,44.8,53.1
    >>与Prospector Anvilward交谈，等待角色扮演活动结束。杀了他，然后洗劫他。
    .complete 8483,1 --Collect Prospector Anvilward's Head (x1)
    .skipgossip
    .timer 28,Prospector Anvilward RP
step << BloodElf Hunter
    .goto Eversong Woods,48.2,46.0
    .turnin 8483 >>交任务: 矮人间谍
step << BloodElf Hunter
    .goto Eversong Woods,55.7,54.5
    .turnin 9066 >>交任务: 导师的训诫
step << Undead/BloodElf !Hunter
    #completewith next
    >>杀死斯普林帕·林克斯。掠夺他们的皮毛
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step
    >>回到Dawnrunner中尉那里
    .goto Eversong Woods,60.3,62.8
    .turnin 8476 >>交任务: 阿曼尼的进犯
    .turnin 9360 >>交任务: 阿曼尼的入侵
    .accept 9363 >>接任务: 警告晴风村
step << BloodElf Hunter
    .turnin 9485 >>交任务: 驯服野兽
    .accept 9673 >>接任务: 野兽训练
step << Undead/BloodElf !Hunter
    #completewith next
    +记住不要出售你的食物任务物品
step
    >>与Arathel Sunforge交谈
    .goto Eversong Woods,59.5,62.6
    .turnin 8477,1 >>交任务: 制矛师之锤 << Paladin
    .turnin 8477 >>交任务: 制矛师之锤 << !Paladin
step
    .goto Eversong Woods,60.4,61.3
    >>上楼向右走。与黄昏魔法师交谈
    .accept 8888 >>接任务: 魔导师的学徒
step << BloodElf/Undead
    #completewith next
    >>杀死斯普林帕·林克斯。掠夺他们的皮毛
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step
    >>与学徒洛拉塔利斯交谈
    .goto Eversong Woods,67.8,56.5
    .turnin 8888 >>交任务: 魔导师的学徒
    .accept 8889 >>接任务: 关闭高塔
    .accept 9394 >>接任务: 维林森去哪了？
step
    >>与Groundskeeper Wyllithen交谈
    .goto Eversong Woods,68.7,46.9
    .tame 15652 >>驯服9级长老春爪 << Hunter tbc
    .turnin 9394 >>交任务: 维林森去哪了？
    .accept 8894 >>接任务: 清理广场
step
    >>杀死该地区的暴徒
    .goto Eversong Woods,68.5,46.0
    .complete 8894,1 --Kill Mana Serpent (x6)
    .complete 8894,2 --Kill Ether Fiend (x6)
step
    >>返回Groundskeeper Wyllithen
    .goto Eversong Woods,68.7,47.0
    .turnin 8894 >>交任务: 清理广场
step
    #completewith next
    .goto Eversong Woods,68.92,51.97
    .cast 26566 >>点击楼梯上的易位珠传送到平台
step
    >>点击绿色水晶
    .goto Eversong Woods,68.96,51.95
    .complete 8889,1 --First Power Source Deactivated (x1)
step
    >>上楼去。点击绿色水晶和蓝色杂志
    .complete 8889,2 --Second Power Source Deactivated (x1)
    .goto Eversong Woods,68.97,51.95
    .accept 8891 >>接任务: 被放弃的研究
    .goto Eversong Woods,69.25,52.11
step
    >>单击绿色水晶。确保你点击的是水晶而不是球体
    .goto Eversong Woods,69.85,52.28,20,0
    .goto Eversong Woods,69.64,53.35
    .complete 8889,3 --Third Power Source Deactivated (x1)
step
    .goto Eversong Woods,69.61,53.47 
    .cast 26572 >>点击绿色水晶后面的易位之珠以传送回来
step << !BloodElf/!Warlock
    .goto Eversong Woods,68.6,47.0
    >>在该地区捣乱暴徒
    .xp 11+6375>>提升经验到6375+/8700xp
step
    >>与路旁的学徒洛拉塔利斯交谈
    .goto Eversong Woods,67.8,56.5
    .turnin 8889 >>交任务: 关闭高塔
    .accept 8890 >>接任务: 塔中的消息
step << Undead/BloodElf !Hunter
    #sticky
    #completewith next
    +记住不要出售你的食物任务物品
step
    >>跑回Farstrender Retreat，然后上楼。
    .goto Eversong Woods,60.3,61.4
    .turnin 8890 >>交任务: 塔中的消息
    .turnin 8891 >>交任务: 被放弃的研究
step << BloodElf Mage
    .goto Eversong Woods,55.7,54.5
    .turnin 9403 >>交任务: 最纯净的水
    .accept 9404 >>接任务: 活动的树木
step << !Warlock
    #completewith next
    .goto Eversong Woods,56.7,49.6,30 >>前往银月城 << !Priest !Mage 
    .goto Eversong Woods,56.7,49.6,30,0 << Priest/Mage
    .goto Silvermoon City,63.5,32.0,20 >>前往银月城。跑上坡道 << Priest/Mage
step << Priest
    .goto Silvermoon City,55.4,26.8
    .trainer >>训练你的职业咒语
step << Mage
    .goto Silvermoon City,57.2,18.9
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Silvermoon City,79.7,52.1
    .accept 9532 >>接任务: 找到克尔图斯·暗叶 << BloodElf
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Silvermoon City,49.47,15.03
    .cast 25649 >>将易位之珠带到地下
    .money <0.1922
step << Rogue
    #completewith next
    .goto Undercity,66.0,44.0,35 >>乘电梯到幽暗城
    .money <0.1922
step << Rogue
    .goto Undercity,61.1,40.9
    .vendor >>从路易斯·沃伦那里买一把弯刀。装备它。或者，从AH那里以更低的价格找到一把更好的剑并装备它，然后再回到银月城
    .money <0.1922
step << Rogue
    #completewith miningr
    .goto Undercity,60.16,11.32,20,0
    .goto Undercity,54.67,11.25
    .cast 35730 >>把易位球带回银月城
    .zoneskip Silvermoon City
    .zoneskip Eversong Woods
step << Druid
    .goto Silvermoon City,71.5,55.8
    .trainer >>训练你的职业咒语
step << BloodElf Hunter
    .goto Silvermoon City,83.4,30.1,20,0
    .goto Silvermoon City,82.2,28.1
    >>进入大楼
    .turnin 9673 >>交任务: 野兽训练
    .trainer >>训练你的宠物法术 << tbc
step << BloodElf Hunter
    >>在酒吧里放上“野兽训练”。记得稍后教你的宠物技能 << tbc
    .goto Silvermoon City,82.4,26.0
    .trainer >>训练你的职业咒语
step << Orc Hunter/Troll Hunter
    .goto Silvermoon City,82.4,26.0
    .trainer >>训练你的职业咒语
step << Paladin
    .goto Silvermoon City,89.3,35.2
    .accept 9678 >>接任务: 第一项试炼
step << Paladin
    .goto Silvermoon City,91.2,36.9
    .trainer >>训练你的职业咒语
step << BloodElf Hunter
    .goto Silvermoon City,54.0,71.0
    >>建筑物内部
    .turnin 9133 >>交任务: 飞往银月城
    .accept 9134 >>接任务: 葛拉米
step << Hunter
    .money <0.3621
    .goto Silvermoon City,85.9,35.4
    .collect 3026,1 >>从Celana购买加固弓
step << BloodElf Hunter
    .goto Eversong Woods,54.4,50.8
    >>前往: 永歌森林
    .turnin 9134 >>交任务: 葛拉米
    .accept 9135 >>接任务: 返回军需官雷米尔身边
step << BloodElf Hunter
    #completewith next
    .goto Eversong Woods,54.4,50.8
    .fly Tranquillien >>飞往宁静
step << BloodElf Hunter
    .goto Ghostlands,47.3,29.1
    .turnin 9135 >>交任务: 返回军需官雷米尔身边
step << Paladin/Rogue
    #label miningr
    .goto Silvermoon City,78.9,43.3
    .train 2580 >>训练采矿可以挖掘粗糙石头的节点，允许你制造锐化石头(1小时+2武器伤害)。
    .cast 2580 >>铸造发现矿物
step << Paladin/Rogue
    .goto Silvermoon City,78.4,42.5
    .vendor >>购买采矿镐
    .collect 2901,1 --Mining Pick (1)
step << Undead/BloodElf !Hunter
    .goto Silvermoon City,79.5,58.5
    .vendor >>从Suntouch酿酒师处购买Suntouth特别储备酒
    .collect 22775,1 --Collect Suntouched Special Reserve
step << Undead/BloodElf !Hunter
    #completewith next
    .hs Hearth to Falconwing
    .cooldown item,6948,>0
step << !BloodElf/!Hunter !Warlock/!BloodElf
    #completewith springpawhs
    .goto Eversong Woods,56.7,49.6,30 >>退出Silvermoon
step << BloodElf/Undead
    #label springpawhs
    #completewith next
    >>杀死斯普林帕·林克斯。抢走他们的皮毛
    .complete 8491,1 --Collect Springpaw Pelt (x6)
step << Orc Warlock/Undead Warlock
    #completewith next
    .hs >>壁炉到猎鹰广场
    .cooldown item,6948,>0
step << Orc Warlock/Undead Warlock
    .goto Eversong Woods,48.2,47.9
    .trainer >>训练你的职业咒语
step << Undead/BloodElf !Hunter 
    #completewith next
    .hs >>壁炉到鹰翼
    .cooldown item,6948,>0
step << Undead/BloodElf !Hunter
    >>返回鹰翼广场。与游侠萨琳交谈
    .goto Eversong Woods,46.9,71.8
    .turnin 9252 >>交任务: 保卫晴风村
    .accept 9253 >>接任务: 符文看守者德尔雅
step << Undead/BloodElf !Hunter
    .goto Eversong Woods,44.7,69.7
    .turnin 8491 >>交任务: 收集豹皮
step << Undead/BloodElf !Hunter
    .goto Eversong Woods,44.0,70.4
    .vendor >>从Halis那里买一束烟花
    .collect 22777,1 --Bundle of Fireworks (1)
step << Undead/BloodElf !Hunter
    >>与Magistrix Landra Dawnstrider交谈
    .goto Eversong Woods,44.0,70.8
    .turnin 9255 >>交任务: 研究笔记
step << !BloodElf/!Hunter
    >>与Magistrix Landra交谈，然后进入客栈与Ardeyn Riverwind交谈
    .accept 9144 >>接任务: 迷失在幽魂之地
    .goto Eversong Woods,44.0,70.8
    .accept 9258 >>接任务: 焦痕谷
    .goto Eversong Woods,43.6,71.2
step << !BloodElf/!Hunter
    >>与楼上的游骑兵德戈利恩通话
    .goto Eversong Woods,43.3,70.8
    .turnin 9363 >>交任务: 警告晴风村
step
    #completewith next
    .abandon 9363 >>放弃警告Fairwindow村
step << Undead/BloodElf !Hunter
    >>与萨尔瑟尔勋爵交谈
    .goto Eversong Woods,38.1,73.6
    .turnin 9067 >>交任务: 无尽的宴会
step << !BloodElf/!Hunter
    >>与西边的拉里安纳河风对话
    .goto Eversong Woods,34.1,80.0
    .turnin 9258 >>交任务: 焦痕谷
    .accept 8473 >>接任务: 痛苦的抉择
step << !BloodElf/!Hunter
    #completewith next
    .goto Eversong Woods,35.0,84.2
    .use 23228 >>杀死老怀特巴克。抢他的吊坠。点击包中的挂件
    .collect 23228,1,8474 --Collect Old Whitebark's Pendant (x1)
    .accept 8474 >>接任务: 怀特巴克的坠饰
    .unitscan Old Whitebark
step << !BloodElf/!Hunter
    .goto Eversong Woods,35.0,84.2
    >>小心，因为绿色守卫有双倍伤害英雄打击能力
    .complete 8473,1 --Kill Withered Green Keeper (x10)
step << !BloodElf/!Hunter
    .goto Eversong Woods,35.0,84.2
    .use 23228 >>杀死老怀特巴克。抢他的吊坠。点击包中的挂件
    .collect 23228,1,8474 --Collect Old Whitebark's Pendant (x1)
    .accept 8474 >>接任务: 怀特巴克的坠饰
    .unitscan Old Whitebark
step << !BloodElf/!Hunter
    .goto Eversong Woods,34.1,80.0
    >>返回Larianna Riverwind
    .turnin 8473 >>交任务: 痛苦的抉择
    .turnin 8474 >>交任务: 怀特巴克的坠饰
    .accept 10166 >>接任务: 怀特巴克的记忆
step << !BloodElf/!Hunter
   .use 28209 >>使用吊坠召唤老白树皮。杀了他，然后把任务交给他。
    >>一定要从他那里开始最大射程。 << Hunter
    .goto Eversong Woods,37.6,86.2
    .turnin 10166 >>交任务: 怀特巴克的记忆
step << BloodElf !Hunter
    >>与Runewarden Deryan交谈
    .goto Eversong Woods,44.2,85.5
    .turnin 9253 >>交任务: 符文看守者德尔雅
step << BloodElf Mage
    >>杀死该区域的叛徒。为分支机构掠夺他们
    .goto Eversong Woods,53.9,80.6
    .collect 23553,1 --Collect Living Branch (x1)
step << !BloodElf/!Hunter
    .isOnQuest 8490
    .abandon 8490 >>放弃防御力量
step
    >>与Courier Dawnstrider交谈
    .goto Eversong Woods,49.0,89.0
    .turnin 9144 >>交任务: 迷失在幽魂之地
step
    >>与药剂师Thedra交谈
    .goto Eversong Woods,49.0,89.2
    .accept 9147 >>接任务: 倒下的信使
step << BloodElf Warlock
    >>掠夺地上的一块紫色石头
    .goto Ghostlands,43.7,16.0
    .turnin 9529 >>交任务: 虚空石
    .accept 9619 >>接任务: 召唤符文
step << BloodElf Warlock
    .goto Ghostlands,27.2,16.0,40 >>进入这座大楼。去顶层
step << BloodElf Warlock
    .use 23732 >>使用虚空之石召唤虚空行者。杀了它
    .goto Ghostlands,27.0,15.2
    .complete 9619,1 --Summoned Voidwalker (1)
step
    .goto Ghostlands,46.6,14.0,50,0
    .goto Ghostlands,47.7,19.8,50,0
    .goto Ghostlands,54.9,15.3,50,0
    .goto Ghostlands,46.6,14.0,50,0
    .goto Ghostlands,47.7,19.8,50,0
    .goto Ghostlands,54.9,15.3
    >>杀死迷雾蝙蝠和鬼爪。你过了桥就往回走，所以不要走得太远。
    .goto Ghostlands,51.6,15.5
    .complete 9147,1 --Collect Plagued Blood Sample (x4)
step
    >>与药剂师Thedra交谈
    .goto Eversong Woods,49.1,89.0
    .turnin 9147 >>交任务: 倒下的信使
step
    >>与Courier Dawnstrider交谈
    .goto Eversong Woods,49.0,89.3
    .accept 9148 >>接任务: 送往塔奎林的信件
step << BloodElf !Hunter
    >>与奥秘大师范德里尔交谈
    .goto Ghostlands,46.5,28.4
    .turnin 9148,3 >>交任务: 送往塔奎林的信件 << Paladin
    .turnin 9148 >>交任务: 送往塔奎林的信件 << !Paladin
    .accept 9327 >>接任务: 被遗忘者
step << !BloodElf
    >>与奥秘大师范德里尔交谈
    .goto Ghostlands,46.5,28.4
    .turnin 9148 >>交任务: 送往塔奎林的信件
    .accept 9329 >>接任务: 被遗忘者
step << !BloodElf/!Hunter
    .goto Ghostlands,45.5,30.5
    .fp Tranquillien >>获取宁静的飞行路线
step << BloodElf !Hunter
    >>与高级执行官马夫伦对话，然后跑出去与军需官莱梅尔和拉特希斯·汤伯对话。最后再和奥秘大师范德里尔谈谈
    .turnin 9327 >>交任务: 被遗忘者
    .goto Ghostlands,44.8,32.5
    .accept 9758 >>接任务: 返回奥术师范迪瑞尔身边
    .accept 9130 >>接任务: 银月城的货物
    .goto Ghostlands,47.3,28.9
    .accept 9152 >>接任务: 托博尔的补给品
    .goto Ghostlands,47.0,28.5
    .turnin 9758 >>交任务: 返回奥术师范迪瑞尔身边
    .goto Ghostlands,46.3,28.4
    .accept 9138 >>接任务: 日冕村
step << !BloodElf
    >>与高级执行官马夫伦对话，然后跑出去与军需官莱梅尔和拉特希斯·汤伯对话。最后再和奥秘大师范德里尔谈谈
    .turnin 9329 >>交任务: 被遗忘者
    .goto Ghostlands,44.8,32.5
    .accept 9758 >>接任务: 返回奥术师范迪瑞尔身边
    .goto Ghostlands,47.3,28.9
    .accept 9152 >>接任务: 托博尔的补给品
    .goto Ghostlands,47.0,28.5
    .turnin 9758 >>交任务: 返回奥术师范迪瑞尔身边
    .goto Ghostlands,46.3,28.4
    .accept 9138 >>接任务: 日冕村
step << Warlock
    #completewith next
    .goto Ghostlands,48.9,32.4
    .home >>将您的炉石设置为宁静 
step << BloodElf !Hunter !Warlock
    >>不要飞往银月城。与飞行管理员交谈。
    .goto Ghostlands,45.5,30.6
    .turnin 9130 >>交任务: 银月城的货物
    .accept 9133 >>接任务: 飞往银月城
step << BloodElf Warlock
    >>与飞行管理员交谈
    .goto Ghostlands,45.5,30.6
    .turnin 9130 >>交任务: 银月城的货物
    .accept 9133 >>接任务: 飞往银月城
step << BloodElf Warlock
    #completewith next
    .goto Ghostlands,45.5,30.6
    .fly Silvermoon >>飞往银月城
step << BloodElf Warlock
    .goto Silvermoon City,72.4,85.7,40,0
    .goto Silvermoon City,54.0,71.0
    .turnin 9133 >>交任务: 飞往银月城
    .accept 9134 >>接任务: 葛拉米
step << BloodElf Warlock
    .goto Silvermoon City,75.3,44.5,20,0
    .goto Silvermoon City,74.4,47.2
    >>进入大楼并下楼。从现在开始使用你的虚空行者
    .turnin 9619 >>交任务: 召唤符文
    .trainer >>训练你的职业咒语
step << BloodElf Warlock
    #completewith next
    .hs >>安宁之心
step
    >>在路上与垂死的血精灵交谈
    .goto Ghostlands,57.6,14.9
    .accept 9315 >>接任务: 阿诺克苏塔
step
    #completewith Nerubis
    >>Anok’steen可能需要一个团队。如果你不能杀死他或找到一个团队，跳过这个任务。他顺时针在镇上的小路上巡逻，并以50%的速度向附近的暴徒(约60码)求助
    .complete 9315,1 --Kill Anok'suten (x1)
    .unitscan Anok'suten
step << Paladin
    >>游到岛上杀死途中的Nerubis Guards，然后进入洞穴。点燃火盆，杀死滋生的暴徒
    .goto Ghostlands,68.4,7.5
    .complete 9678,1 --Undergo the First Trial
step
     .goto Ghostlands,61.3,11.9
    >>杀死尼鲁比斯的敌人。尽量在该地区的东侧结束
    .complete 9138,1 --Kill Nerubis Guard (x10)
step
    #label Nerubis
    >>与流浪者瓦兰纳交谈
    .goto Ghostlands,69.5,15.0
    .accept 9143 >>接任务: 塞布索雷的巨魔
step
    >>与幽灵杰拉尼斯·怀特莫恩交谈
    .goto Ghostlands,72.5,19.1
    .accept 9157 >>接任务: 被遗忘的仪祭
step
    >>杀死该地区的巨魔。抢走他们的耳朵
    .goto Ghostlands,76.8,12.3
    .complete 9143,1 --Collect Zeb'Sora Troll Ear (x6)
step
    >>与Farstreder Enclave中的Farstrever Sedina交谈
    .goto Ghostlands,72.5,32.1
    .accept 9158 >>接任务: 瘟疫的使者
step
    .goto Ghostlands,72.2,31.2
    >>点击通缉海报
    .accept 9215 >>接任务: 克尔加什的徽记！
step
    #completewith next
    .goto Ghostlands,72.3,32.3
    .vendor >>如果需要，购买食物/饮料。请务必购买5级鱼，因为它非常便宜
step
    >>杀死你看到的任何鬼爪山猫
    .goto Ghostlands,68.5,33.1,40,0
    .goto Ghostlands,67.3,38.0,40,0
    .goto Ghostlands,68.5,46.3,40,0
    .goto Ghostlands,76.2,35.2,40,0
    .goto Ghostlands,68.5,33.1,40,0
    .goto Ghostlands,67.3,38.0,40,0
    .goto Ghostlands,68.5,46.3,40,0
    .goto Ghostlands,76.2,35.2,40,0
    .goto Ghostlands,68.6,45.3
    .complete 9158,1 --Kill Ghostclaw Lynx (x10)
step
    >>返回Farstreder Enclave并与Sedina通话
    .goto Ghostlands,72.5,32.0
    .turnin 9158 >>交任务: 瘟疫的使者
    .accept 9159 >>接任务: 控制瘟疫
step
    >>与游侠Krennan交谈
    .goto Ghostlands,72.2,29.8
    .accept 9274 >>接任务: 水中鬼魂
step
    #completewith Aquantion
    >>杀死湖周围的幻影
    .complete 9274,2 --Kill Vengeful Apparition (x8)
    .complete 9274,1 --Kill Ravening Apparition (x8)
step
    >>从湖底的泥堆中掠夺奖章
    .goto Ghostlands,72.2,28.2,30,0
    .goto Ghostlands,73.1,23.5,30,0
    .goto Ghostlands,73.6,18.3,30,0
    .goto Ghostlands,71.4,15.5,30,0
    .goto Ghostlands,70.1,19.0,30,0
    .goto Ghostlands,70.6,22.0
    .complete 9157,1 --Collect Wavefront Medallion (x8)
step
    .goto Ghostlands,72.3,19.0
    >>与岛上的杰拉尼斯·怀特莫恩交谈
    .turnin 9157 >>交任务: 被遗忘的仪祭
    .accept 9174 >>接任务: 消灭阿奎艾森
step
    >>点击神龛召唤水神。他很难相处。他不受人群控制能力(昏迷和沉默)的影响，拥有比正常人更高的生命值，并且受到了相对较重的冰霜伤害
    .goto Ghostlands,71.3,15.0
    .complete 9174,1 --Kill Aquantion (x1)
step
    #label Aquantion
    .goto Ghostlands,72.3,19.1
    >>与岛上的杰拉尼斯·怀特莫恩交谈
    .turnin 9174 >>交任务: 消灭阿奎艾森
step
    >>杀死湖周围的幻影
    .goto Ghostlands,72.2,28.2,30,0
    .goto Ghostlands,73.1,23.5,30,0
    .goto Ghostlands,73.6,18.3,30,0
    .goto Ghostlands,71.4,15.5,30,0
    .goto Ghostlands,70.1,19.0,30,0
    .goto Ghostlands,70.6,22.0
    .complete 9274,2 --Kill Vengeful Apparition (x8)
    .complete 9274,1 --Kill Ravening Apparition (x8)
step
    .goto Ghostlands,69.4,15.1
    >>与游侠瓦兰娜交谈
    .turnin 9143 >>交任务: 塞布索雷的巨魔
    .accept 9146 >>接任务: 向赫里奥斯中尉报到
step
    >>研磨Nerubians
    .goto Ghostlands,61.2,12.0
    .xp 13+10150>>提升经验到10150+/11000xp
step << Priest/Mage/Warlock/Rogue/Druid
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    .goto Ghostlands,46.3,28.4
    >>跑回宁静。与奥秘大师范德里尔交谈 << !Priest !Mage !Warlock !Rogue !Druid
    >>返回奥秘大师范德里尔
    .turnin -9315 >>交任务: 阿诺克苏塔
    .turnin 9138 >>交任务: 日冕村
    .accept 9139 >>接任务: 金雾村
step
    #label Poster3
    >>与主厨模具师交谈
    .accept 9171 >>接任务: 松脆蜘蛛腿
    .goto Ghostlands,48.4,30.9
    >>点击通缉海报
    .accept 9156 >>接任务: 通缉：纳克雷洛特和卢兹兰
    .goto Ghostlands,48.2,31.6
step << !Warlock
    .goto Ghostlands,48.9,32.4
    .home >>将您的炉石设置为宁静
step << Mage/Priest/Warlock
    .goto Ghostlands,47.7,32.3
    .vendor >>从Vredigar购买学徒靴并装备
    .collect 22991,1 --Collect Apprentice Boots (1)
step << Rogue/Shaman
    .goto Ghostlands,47.7,32.3
    .vendor >>从Vredigar购买Bogwalker靴子并装备
    .collect 22992,1 --Collect Bogwalker Boots (1)
step << Orc Hunter/Troll Hunter
    #sticky
    #completewith Poster13
    .money <0.1300
    >>如果你之前负担不起2小时的剑训练，那就飞往银月城接受武器训练
    .goto Silvermoon City,91.2,38.7
    .train 202 >>训练2h剑
step << Hunter
    .goto Ghostlands,47.7,32.3
    .vendor >>购买博格沃克靴子。给他们装备 << wotlk
    .vendor >>购买Bogwalker靴子和Flameberge。给他们装备 << tbc
    .collect 22992,1 --Collect Bogwalker Boots (1)
    .collect 28164,1 --Collect Tranquillien Flamberge (1) << tbc
step << Paladin
    .goto Ghostlands,47.7,32.3
    .vendor >>购买志愿者润滑脂和宁静火焰杯。给他们装备
    .collect 22993,1 --Collect Volunteer's Greaves (1)
    .collect 28164,1 --Collect Tranquillien Flamberge (1)
step
    #label Poster13
    #completewith next
    .isOnQuest 9315
    .abandon 9315 >>放弃Anok’steen
step
    >>与达雷尼斯魔法师谈谈，如果他不在这里，请稍后再回来。在某个任务完成后，他绝望了。
    .accept 9150 >>接任务: 重建历史
    .goto Ghostlands,46.0,32.0
    >>与Auricia女士、顾问Valwyn和死亡追踪者Maltendis交谈
    .accept 9160 >>接任务: 调查安达洛斯
    .goto Ghostlands,44.9,32.5
    .accept 9193 >>接任务: 调查阿曼尼墓穴
    .goto Ghostlands,44.8,32.8
    .accept 9192 >>接任务: 幽光矿洞的麻烦
    .goto Ghostlands,44.7,32.3
step
    >>与井边的死亡追踪者Rathiel交谈
    .accept 9155 >>接任务: 前往死亡之痕
    .goto Ghostlands,46.0,33.6
    >>与药师仁慈珍交谈
    .accept 9149 >>接任务: 瘟疫海岸
    .goto Ghostlands,47.5,34.9
step << Druid
    >>前往: 月光林地
    .goto Moonglade,52.5,40.6
    .trainer >>训练你的职业咒语
    --Add Poison q. Add earthroot purchase from AH
step << Priest/Mage/Warlock
    #completewith next
    .goto Ghostlands,45.4,30.5
    .fly Silvermoon >>飞往银月城
step << BloodElf Mage
    .goto Eversong Woods,55.7,54.5
    .turnin 9404 >>交任务: 活动的树木
step << BloodElf Priest/BloodElf Mage
    .goto Silvermoon City,72.4,85.7,40,0
    .goto Silvermoon City,54.0,71.0
    .turnin 9133 >>交任务: 飞往银月城
    .accept 9134 >>接任务: 葛拉米
step << BloodElf Warlock
    .goto Eversong Woods,54.4,50.7
    .turnin 9134 >>交任务: 葛拉米
    .accept 9135 >>接任务: 返回军需官雷米尔身边
step << Priest
    >>如果你愿意的话，你也可以在训练后从AH那里查看一个更大的魔杖
    .goto Silvermoon City,55.4,26.8
    .trainer >>训练你的职业咒语
step << Mage
    .goto Silvermoon City,57.2,18.9
    .trainer >>训练你的职业咒语
step << !BloodElf Warlock
    .goto Silvermoon City,74.4,47.2
    >>进入大楼，然后下楼
    .trainer >>训练你的职业咒语
step << Priest/Mage/Warlock/Druid
    #completewith next
    .hs >>安宁之心
step << BloodElf Warlock
    .goto Ghostlands,47.3,29.3
    .turnin 9135 >>交任务: 返回军需官雷米尔身边
step
    >>杀死奥术暴徒并掠夺他们的法力精华
    .goto Ghostlands,35.7,33.5,40,0
    .goto Ghostlands,31.4,35.9,40,0
    .goto Ghostlands,32.4,29.0,40,0
    .goto Ghostlands,35.7,33.5,40,0
    .goto Ghostlands,31.4,35.9,40,0
    .goto Ghostlands,32.4,29.0
    .complete 9150,1 --Collect Crystallized Mana Essence (x8)
step
    >>掠夺被食尸鬼包围的商队中的箱子
    .goto Ghostlands,33.6,26.6
    .complete 9152,1 --Collect Rathis Tomber's Supplies (x1)
step
    #completewith next
    .goto Ghostlands,37.8,20.6,70,0
    >>杀死蜘蛛。掠夺他们松脆的蜘蛛腿
    .complete 9171,1 --Collect Crunchy Spider Leg (x5)
step << BloodElf Rogue
    >>不要在途中杀死哨兵首领
    .goto Ghostlands,33.0,11.2
    .turnin 9532 >>交任务: 找到克尔图斯·暗叶
    .accept 9460 >>接任务: 窃取情报
step << BloodElf Rogue
    #completewith elftimeover
    #label Handkerchief
    .cast 921 >>潜行，然后扒窃花边手帕的哨兵首领。她在营地周围巡逻-如果你拉她，就跑开，让她复位
    .goto Ghostlands,33.0,11.2
    .collect 23686 --Collect Lacy Handkerchief (x1)
step
    .goto Ghostlands,36.9,15.7
    >>杀死哨兵间谍
    .complete 9160,1 --Kill Sentinel Spy (x12)
    >>走到营地中央的巨大神龛10码以内
    .complete 9160,2 --Investigate An'daroth
step
    .goto Ghostlands,36.9,15.7
    .xp 14+5200>>提升经验到5200+/12300xp
step << BloodElf Rogue
    #label elftimeover
    .goto Ghostlands,33.0,11.2
    .turnin 9460 >>交任务: 窃取情报
    .accept 9618 >>接任务: 交回报告
step
    .goto Ghostlands,25.3,15.8
    >>杀死该地区的幽灵。尝试结束该地区西北侧的任务。
    .complete 9139,2 --Kill Quel'dorei Wraith (x4)
    .complete 9139,1 --Kill Quel'dorei Ghost (x6)
step
    >>杀死穆洛克。掠夺他们的脊柱
    .goto Ghostlands,19.2,13.6,150,0
    .goto Ghostlands,20.7,23.1
    .complete 9149,1 --Collect Plagued Murloc Spine (x6)
step
    #completewith stopspiderlegs
    >>杀死蜘蛛。掠夺他们松脆的蜘蛛腿
    .complete 9171,1 --Collect Crunchy Spider Leg (x5)
step
    #completewith next
    >>杀死吸血鬼妖怪
    .complete 9159,1 --Kill Vampiric Mistbat (x10)
step
    .goto Ghostlands,34.3,40.1
    >>杀死蜘蛛网潜伏者。小心他们的毒药
    .complete 9159,2 --Kill Spindleweb Lurker (x8)
step
    >>与学徒Shatharia交谈
    .goto Ghostlands,31.4,48.5
    .accept 9207 >>接任务: 幽光矿石样本
step
    >>杀死该地区的侏儒。掠夺他们以获取暗色矿石
    >>如果你进行采矿，你也可以从该区域的节点处开采一些暗色矿石 << Warrior/Paladin/Rogue
    .goto Ghostlands,29.0,47.8
    .complete 9192,3 --Kill Blackpaw Shaman (x4)
    .complete 9192,1 --Kill Blackpaw Gnoll (x8)
    .complete 9192,2 --Kill Blackpaw Scavenger (x6)
    .complete 9207,1 --Collect Underlight Ore (x6)
step
        >>保存你掠夺的腐烂的心。不要出售它们。杀死死亡疤痕中的亡灵暴徒
    .goto Ghostlands,37.9,47.2,60,0
    .goto Ghostlands,39.4,30.1,60,0
    .goto Ghostlands,37.9,47.2,60,0
    .goto Ghostlands,39.4,30.1,60,0
    .goto Ghostlands,37.9,47.2,60,0
    .goto Ghostlands,39.4,30.1,60,0
    .goto Ghostlands,37.9,47.2,60,0
    .goto Ghostlands,39.4,30.1
.complete 9155,2 --Kill Gangled Cannibal (x10)
    .complete 9155,1 --Kill Risen Hungerer (x10)
step
    #label stopspiderlegs
    >>与药剂师仁慈镇和死亡追踪者拉希尔交谈
    .turnin 9149 >>交任务: 瘟疫海岸
    .goto Ghostlands,47.6,34.7
    .turnin 9155 >>交任务: 前往死亡之痕
    .goto Ghostlands,46.1,33.6
step
    >>交出并接受建筑中的所有任务
    .goto Ghostlands,44.8,32.5
    .turnin 9160 >>交任务: 调查安达洛斯
    .accept 9163 >>接任务: 深入敌境
    .turnin 9192 >>交任务: 幽光矿洞的麻烦
    .accept 9199 >>接任务: 巨魔的邪符
    .accept 9173 >>接任务: 夺回风行者之塔
step
    >>与Magister Darenis、Arcanist Vandril和Rathis Tomber交谈
    .turnin 9150 >>交任务: 重建历史
    .goto Ghostlands,46.1,31.8
    .turnin 9139 >>交任务: 金雾村
    .goto Ghostlands,46.4,28.4
    .accept 9140 >>接任务: 风行村
    .turnin 9152 >>交任务: 托博尔的补给品
    .goto Ghostlands,47.3,28.6
step << Paladin
    .goto Ghostlands,47.7,32.3
    .vendor >>购买宁静卫士腰带。装备它
    .collect 28162,1 --Collect Tranquillien Defender's Girdle (1)
step << Rogue/Hunter/Druid/Shaman
    .goto Ghostlands,47.7,32.3
    .vendor >>买一条蝙蝠皮腰带。装备它
    .collect 28158,1 --Collect Batskin Belt (1)
step
    .goto Ghostlands,48.9,32.4
    .vendor >>购买食物和饮料。接下来的一些任务很困难。
step
    >>完成杀死吸血鬼迷雾蝙蝠
    .goto Ghostlands,42.1,39.2,50,0
    .goto Ghostlands,50.8,50.3,50,0
    .goto Ghostlands,43.8,49.6,50,0
    .goto Ghostlands,42.1,39.2,50,0
    .goto Ghostlands,50.8,50.3,50,0
    .goto Ghostlands,43.8,49.6
    .complete 9159,1 --Kill Vampiric Mistbat (x10)
step
    >>与学徒Vor'el交谈
    .goto Ghostlands,46.2,56.4
    .accept 9281 >>接任务: 清理道路
step
    #completewith next
    .goto Ghostlands,13.2,56.8
    >>在途中杀死幽灵爪掠夺者和蜘蛛网，不要担心完成这个任务。
    .complete 9281,2 --Kill Ghostclaw Ravager (x10)
    .complete 9281,1 --Kill Greater Spindleweb (x10)
step
        >>杀死堕落游骑兵和死神侍从。抢了他们来换取女士的项链。在你的包里点击它。这些暴徒可能很难对付，尽量不要一次拉多个。
    .goto Ghostlands,13.2,56.8
    .complete 9173,1 --Deatholme Acolyte (8)
    .complete 9173,2 --Fallen Ranger (10)
    .collect 22597,1,9175 --Collect The Lady's Necklace (x1)
    .accept 9175 >>接任务: 女王的项链  
    .use 22597
step
    #completewith next
    >>为松脆的蜘蛛腿掠夺蜘蛛
    .complete 9171,1 --Collect Crunchy Spider Leg (x5)
step
    >>完成杀死幽灵爪掠夺者和蜘蛛网
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,30,0
    .goto Ghostlands,16.5,62.5,30,0
    .complete 9281,2 --Kill Ghostclaw Ravager (x10)
    .complete 9281,1 --Kill Greater Spindleweb (x10)
step
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,0
    .goto Ghostlands,16.5,62.5,0
    .goto Ghostlands,44.1,57.6,30,0
    .goto Ghostlands,16.5,62.5,30,0    
    >>如果你现在还没有5条腿的话，完成对蜘蛛的掠夺。
    .complete 9171,1 --Collect Crunchy Spider Leg (x5)
step
    >>杀死并掠夺幻影以获取物质，并掠夺石像以获取该区域的碎片。
    .goto Ghostlands,20.4,48.7,30,0
    .goto Ghostlands,19.6,45.2,30,0
    .goto Ghostlands,20.3,42.3,30,0
    .goto Ghostlands,17.3,43.4,30,0
    .goto Ghostlands,20.4,48.7,30,0
    .goto Ghostlands,19.6,45.2,30,0
    .goto Ghostlands,20.3,42.3,30,0
    .goto Ghostlands,17.3,43.4
    .complete 9140,1 --Collect Phantasmal Substance (x6)
    .complete 9140,2 --Collect Gargoyle Fragment (x4)
step
    #completewith next
    .cast 7840 >>使用包里的游泳速度药剂更快地过河
    .use 6372
    .itemcount 6372,1
step
    >>掠夺在地上滚动。他们可以在该地区的任何帐篷中拥有多个繁殖点。
    .goto Ghostlands,12.7,25.3
    .complete 9163,2 --Collect Night Elf Plans: An'owyn (x1)
    .goto Ghostlands,12.5,26.4
    .complete 9163,1 --Collect Night Elf Plans: An'daroth (x1)
step << Priest/Druid/Rogue/Paladin
    .xp 15+10600>>提升经验到10600/13600
step
    >>跑到船上。抢夺顶部的计划
    .goto Ghostlands,10.5,22.6
    .complete 9163,3 --Collect Night Elf Plans: Scrying on the Sin'dorei (x1)
step
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    #label spiderz2
    >>与奥秘大师范德里尔交谈
    .turnin 9140,2 >>交任务: 风行村 << Paladin
    .turnin 9140,4 >>交任务: 风行村 << Warlock/Mage/Priest
    .turnin 9140 >>交任务: 风行村 << !Paladin !Warlock !Mage !Priest
    .goto Ghostlands,46.3,28.5
step
    >>与厨师长交谈
    .goto Ghostlands,48.5,30.7
    .turnin 9171 >>交任务: 松脆蜘蛛腿
    .isQuestComplete 9171
step
    >>交出并接受建筑中的所有任务
    .goto Ghostlands,44.8,32.5
    .turnin 9163 >>交任务: 深入敌境
    .accept 9166 >>接任务: 返回安泰拉斯
    .turnin -9175 >>交任务: 女王的项链
    .turnin 9173 >>交任务: 夺回风行者之塔
step << BloodElf
    .goto Ghostlands,44.8,32.5
    .accept 9180 >>接任务: 幽暗城之旅
step << !BloodElf
    .goto Ghostlands,44.8,32.5
    .accept 9177 >>接任务: 幽暗城之旅
step << Druid
    >>前往: 月光林地
    .goto Moonglade,52.5,40.6
    .trainer >>训练你的职业咒语
    --Aquatic Form q
step << Priest/Rogue/Paladin
    #completewith next
    .goto Ghostlands,45.4,30.5
    .fly Silvermoon >>飞往银月城
step << BloodElf Paladin/BloodElf Rogue
    >>前往银月城
    .goto Silvermoon City,72.4,85.7,40,0
    .goto Silvermoon City,54.0,71.0
    .turnin 9133 >>交任务: 飞往银月城
step << BloodElf Paladin/BloodElf Rogue
    #xprate <1.5
    .goto Silvermoon City,54.0,71.0
    .accept 9134 >>接任务: 葛拉米
step << BloodElf Priest/BloodElf Rogue/BloodElf Paladin
    .isOnQuest 9134
    >>不要离开飞行管理员飞到任何地方。返回银月城外。
    .goto Eversong Woods,54.4,50.7
    .turnin 9134 >>交任务: 葛拉米
    .accept 9135 >>接任务: 返回军需官雷米尔身边
step << Priest
    >>如果你愿意的话，你也可以在培训后从拍卖行购买一个更大的魔杖(如果你之前没有得到的话)
    .goto Silvermoon City,55.4,26.8
    .trainer >>训练你的职业咒语
step << Rogue
    .goto Silvermoon City,79.7,52.1
    .turnin 9618 >>交任务: 交回报告 << BloodElf
    .accept 10372 >>接任务: 谨慎的询问
    .trainer >>训练你的职业咒语
step << Rogue
    .money <0.3625
    .goto Silvermoon City,49.47,15.03
    .cast 25649 >>将易位之珠带到地下
step << Rogue
    #completewith next
    .money <0.3625
    .goto Undercity,66.0,44.0,35 >>乘电梯到幽暗城
step << Rogue
    .money <0.3625
    .goto Undercity,61.1,40.9
    .vendor >>从路易斯·沃伦那里买一把弯刀。装备它。或者，从AH那里找到一把价格更便宜的更好的剑，并装备它
step << Paladin
    .goto Silvermoon City,89.3,35.2
    .turnin 9678 >>交任务: 第一项试炼
    .accept 9681 >>接任务: 掌握力量
step << Paladin
    .goto Silvermoon City,92.2,37.5
    .trainer >>训练你的职业咒语
step << Paladin
    >>跳下教练身后的洞
    .goto Silvermoon City,92.1,36.2
    .turnin 9681 >>交任务: 掌握力量
    .accept 9684 >>接任务: 驾驭圣光 << tbc
    .accept 63866 >>接任务: 驾驭圣光 << wotlk
-- This changes in sunwell plataeu, but im not sure if we'd have a phase system instead of just tbc
step << Paladin tbc
    .use 24157 >>站在光束中，使用闪光容器
    .goto Silvermoon City,92.6,36.8
    .complete 9684,1 --Collect Filled Shimmering Vessel
step << Paladin wotlk
    .use 185956 >>在血精灵法师身上使用闪耀的血管
    .goto Silvermoon City,92.6,36.8
    .complete 63866,1 --Collect Filled Shimmering Vessel
step << Paladin
    >>回到楼上的教练那里
    .goto Silvermoon City,89.3,35.2
    .turnin 9684 >>交任务: 驾驭圣光 << tbc
    .turnin 63866 >>交任务: 驾驭圣光 << wotlk
    .accept 9685 >>接任务: 救赎死者
step << Paladin
    .goto Silvermoon City,82.3,58.3,12,0
    .goto Silvermoon City,79.5,56.3,10,0
    .goto Silvermoon City,80.1,60.3
    .use 24184 >>进客栈，然后上楼。在尸体上使用闪光容器
    .complete 9685,1 --Resurrect Sangrias Stillblade (1)
step << Priest/Druid/Rogue/Paladin
    .goto Ghostlands,55.0,48.5
    .hs >>安宁之心
    .zoneskip Ghostlands
step << BloodElf Priest/BloodElf Rogue/BloodElf Paladin
    .goto Ghostlands,47.3,29.3
    .turnin -9135 >>交任务: 返回军需官雷米尔身边
step << Rogue
    .goto Ghostlands,47.2,34.3
    .turnin 10372 >>交任务: 谨慎的询问
    .accept 9491 >>接任务: 贪婪
    .vendor >>检查埃拉兰是否有邪恶的弯刀或喉咙穿孔。如果他们涨了就买
step
    >>在太阳庇护所与卡恩德里斯和奎列斯蒂斯博士交谈
    .goto Ghostlands,55.0,48.5
    .accept 9282 >>接任务: 远行者营地
    .turnin 9207 >>交任务: 幽光矿石样本
step
    >>在山上的营地里与西拉斯特魔法师交谈
    .goto Ghostlands,60.4,35.5
    .turnin 9166 >>交任务: 返回安泰拉斯
    .accept 9169 >>接任务: 关闭安欧维恩
step
    >>在Farstider Enclave与Farstide Sedina交谈
    .turnin 9159,3 >>交任务: 控制瘟疫 << Paladin
    .turnin 9159 >>交任务: 控制瘟疫 << !Paladin
    .goto Ghostlands,72.4,32.0
step << Hunter
    #sticky
    #completewith next
    .vendor >>如果您还没有，请在这里购买加固弓
    .goto Ghostlands,72.1,32.0
    .collect 3026,1 --Collect Reinforced Bow
step << Hunter
    .goto Ghostlands,72.1,32.0
    .vendor >>出售垃圾并在箭头上重新填充
step
    >>与Farstreder Solanna交谈
    .goto Ghostlands,72.5,31.1
    .accept 9276 >>接任务: 进攻塞布提拉
step
    >>与游侠Krennan和Helios船长交谈
    .goto Ghostlands,72.2,29.7
    .turnin -9274 >>交任务: 水中鬼魂
    .turnin 9146 >>交任务: 向赫里奥斯中尉报到
    .accept 9214 >>接任务: 暗松巨魔的武器
step
    .goto Ghostlands,72.6,31.2
    .abandon 9274 >>溺水者的遗弃精神
step
    .goto Ghostlands,72.6,31.2
    >>走东边的斜坡，和药剂师Venustus谈谈
    .accept 9275 >>接任务: 香料
step
    >>爬上西部斜坡，和Ranger Vynna通话
    .goto Ghostlands,71.9,32.7
    .turnin 9282 >>交任务: 远行者营地
    .accept 9161 >>接任务: 叛徒之影
step
    #sticky
    #label Juju
    .goto Ghostlands,66.4,28.6,40,0
    .goto Ghostlands,60.5,29.1
    >>为巨魔Juju杀死和掠夺巨魔。
    >>焚烧地面上的木乃伊尸体，通常在沿着墙壁的小房间里。尝试在开始护送之前烧掉8具以上尸体，你可能必须进入西边的房间
    .complete 9199,1 --Collect Troll Juju (x8)
    .complete 9193,1 --Collect Mummified Troll Remains Burned (x10)
step << Rogue
    #sticky
    #completewith Lillyend
    #label Lilatha
    >>掠夺地窖周围的箱子。确保你有20门开锁技能，并且已经抢走了金戒指。否则，不要启动护送
    .complete 9491,1 --Pitted Gold Band (1)
step
    >>跑进营火室
    .goto Ghostlands,62.9,31.8
    .complete 9193,2 --Investigate the Amani Catacombs
step
    #label Lillyend
    #requires Lilatha
    >>护送员：在出发之前，请确保您在出发途中完成了所有任务！！
    .goto Ghostlands,62.9,32.8
    .accept 9212 >>接任务: 逃离墓穴
step << !Druid !Paladin !Priest
    >>离开墓穴约60码后，她身上有两个暴徒。确保你在离开之前烧完尸体！
    .goto Ghostlands,67.8,28.9,40,0
    .goto Ghostlands,72.2,30.1
    .complete 9212,1 --Escort Ranger Lilatha back to the Farstrider Enclave
step << Druid/Paladin/Priest
    >>离开墓穴约60码后，她身上有两个暴徒。记得给她擦屁股。确保你在离开之前烧完尸体！
    .goto Ghostlands,67.8,28.9,40,0
    .goto Ghostlands,72.1,31.8
    .complete 9212,1 --Escort Ranger Lilatha back to the Farstrider Enclave
step
    #requires Juju
    >>与Helios船长交谈
    .goto Ghostlands,72.4,29.7
    .turnin 9212,1 >>交任务: 逃离墓穴 << Paladin
    .turnin 9212 >>交任务: 逃离墓穴 << !Paladin
step << Rogue
    >>跑回宁静
    .goto Ghostlands,47.2,34.3
    .turnin 9491 >>交任务: 贪婪
    .accept 10548 >>接任务: 悲伤的事实
    .vendor >>检查埃拉兰是否有邪恶的弯刀或喉咙穿孔。如果你没早点拿到，就买一个
step
    >>去大楼的顶层。跟这本书谈谈
    .goto Ghostlands,78.8,19.8,30,0
    .goto Ghostlands,79.6,17.6
    .turnin 9161 >>交任务: 叛徒之影
    .accept 9162 >>接任务: 往日的线索
step << Rogue
    #sticky
    #completewith next
    >>打开周围的原始宝箱，直到你掠夺一个头部
    .complete 10548,1 --Archaeologist's Shrunken Head (1)
step
    .goto Ghostlands,76.0,46.5
    >>杀死该地区的巨魔。掠夺他们以获取权杖和斧头
    .complete 9276,1 --Kill Shadowpine Shadowcaster (x8)
    .complete 9276,2 --Kill Shadowpine Headhunter (x8)
    .complete 9214,2 --Collect Shadowcaster Mace (x3)
    .complete 9214,1 --Collect Headhunter Axe (x3)
step
    .goto Ghostlands,72.2,31.2
    .turnin 9276 >>交任务: 进攻塞布提拉
    .accept 9277 >>接任务: 突袭塞布努瓦
step
    >>沿着西坡道走
    .goto Ghostlands,72.0,32.7
    .turnin 9162 >>交任务: 往日的线索
    .accept 9172 >>接任务: 向魔导师坎迪瑞斯报到
step << Rogue
    #completewith shrunkedheads
    #label ShrunkenHead
    >>打开周围的原始宝箱，直到你掠夺一个头部。
    .complete 10548,1 --Archaeologist's Shrunken Head (1)
step
    #sticky
    #label Catlords
    .goto Ghostlands,63.0,75.0,0,0
    >>杀死该地区的巨魔。抢走他们的棍子和爪子
    .complete 9277,1 --Kill Shadowpine Catlord (x10)
    .complete 9277,2 --Kill Shadowpine Hexxer (x10)
    .complete 9214,3 --Collect Catlord Claws (x3)
    .complete 9214,4 --Collect Hexxer Stave (x3)
step
    .use 22796 >>在大楼里，篝火后面使用药剂师的毒药
    .goto Ghostlands,68.2,57.8
    .complete 9275,3 --Poison the Fresh Fish Rack (x1)
step
    .use 22796 >>在两间小屋之间使用药剂师的毒药
    .goto Ghostlands,65.1,66.7
    .complete 9275,1 --Poison the Raw Meat Rack (x1)
step
    .use 22796 >>在两间小屋之间使用药剂师的毒药
    .goto Ghostlands,63.0,75.0
    .complete 9275,2 --Poison the Smoked Meat Rack (x1)
step << Rogue
    #label shrunkedheads
    >>完成打开原始宝箱直到你掠夺一个头部。
    .complete 10548,1 --Archaeologist's Shrunken Head (1)
step
    .goto Ghostlands,65.1,66.7
    .xp 18 >>升级到18级
step << Priest/Mage/Druid/Paladin
    #completewith next
    >>杀死邪恶的凯尔加斯。当他开始施放咒语时，你应该能够在他站在后面的圆柱体上滥用视线(LoS)，从而在每堂课上为他单独表演。只要确保有冷却液可用(如果可以的话，还有药剂)。如果你做不到，那么你可以找一个小组，或者跳过。我强烈建议你完成这个任务
    .goto Ghostlands,65.1,79.2
    .complete 9215,1 --Collect Head of Kel'gash the Wicked (x1)
step << Rogue
    #sticky
    #requires ShrunkenHead
    #completewith next
    >>杀死邪恶的凯尔加斯。确保备有药水、绷带和躲避剂。在他开始施放咒语时，在他站在视线(LoS)的后面的圆柱体周围放风筝。如果你做不到，那么你可以找一个小组，或者跳过。我强烈建议你做这个任务。
    .goto Ghostlands,65.1,79.2
    .complete 9215,1 --Collect Head of Kel'gash the Wicked (x1)
step << Warlock
    #completewith next
    >>杀死邪恶的凯尔加斯。你应该能够通过让你的宠物制造仇恨来独奏它，然后在它身上装点，以及当它试图对你施放法术时，视线(LoS)。小心，因为他很少使用100点伤害的瞬发闪电电击。如果你做不到，那么你可以找一个小组，或者跳过。我强烈建议你完成这个任务
    .goto Ghostlands,65.1,79.2
    .complete 9215,1 --Collect Head of Kel'gash the Wicked (x1)
step << Hunter
    #completewith next
    >>杀死邪恶的凯尔加斯。当他试图对你施放魔法时，你应该能够通过视线(LoS)独奏他的咒语。小心，因为他很少使用100点伤害的瞬发闪电电击。如果你做不到，那么你可以找一个小组，或者跳过。我强烈建议你做这个任务。
    .goto Ghostlands,65.1,79.2
    .complete 9215,1 --Collect Head of Kel'gash the Wicked (x1)
step
    #requires Catlords
    .goto Ghostlands,58.2,65.1
    >>杀死营地周围的暗夜精灵以获得水晶控制球。
    .collect 23191,1 --Collect Crystal Controlling Orb (x1)
step
    .use 23191 >>使用月亮水晶上的水晶控制球。
    .goto Ghostlands,58.2,65.1
    .complete 9169,1 --Collect Night Elf Moon Crystal Deactivated (x1)
step
    >>返回Farstrader Enclave
    .goto Ghostlands,72.4,31.3
    .turnin 9277,1 >>交任务: 突袭塞布努瓦 << Paladin
    .turnin 9277 >>交任务: 突袭塞布努瓦 << !Paladin
step
    .isQuestComplete 9215
    .goto Ghostlands,72.4,29.7
    .turnin 9215,1 >>交任务: 克尔加什的徽记！ << Hunter
    .turnin 9215 >>交任务: 克尔加什的徽记！ << !Hunter
step
    .goto Ghostlands,72.4,29.7
    .turnin 9214 >>交任务: 暗松巨魔的武器
step
    >>向东坡道跑去
    .goto Ghostlands,72.6,31.5
    .turnin 9275 >>交任务: 香料
step
    >>前往太阳圣殿上方的山地营地
    .goto Ghostlands,65.0,41.2,60,0
    .goto Ghostlands,60.3,35.8
    .turnin 9169 >>交任务: 关闭安欧维恩
step << Rogue
    >>跑回宁静。选择转身匕首。保存这把匕首(或任何匕首)，因为你以后需要它
    .goto Ghostlands,47.2,34.3
    .turnin 10548 >>交任务: 悲伤的事实
    .vendor >>再次检查埃拉兰是否有邪恶弯刀或喉咙穿刺器。如果你没早点拿到，就买一个
step
    #sticky
    #completewith endofsun
    >>跑回宁静。如果达雷尼斯魔法师不在，回到这一步，他应该很快就会重生。
    .goto Ghostlands,45.9,32.1
    .accept 9151 >>接任务: 太阳圣殿
step
    .turnin 9193 >>交任务: 调查阿曼尼墓穴
    .goto Ghostlands,44.8,32.7
    .turnin 9199 >>交任务: 巨魔的邪符
    .goto Ghostlands,44.8,32.3
step << Mage/Warlock/Priest
    .goto Ghostlands,47.7,32.3
    .vendor >>购买药剂师的长袍。装备它
    .collect 22986,1 --Collect Apothecary's Robe (1)
step << Rogue/Hunter/Druid/Shaman
    .goto Ghostlands,47.7,32.3
    .vendor >>购买死亡追踪者背心。装备它
    .collect 22987,1 --Collect Deathstalker's Vest (1)
step << Druid
    .cast 18960 >>前往: 月光林地
    .goto Moonglade,52.5,40.6
    .trainer >>训练你的职业咒语
step << Mage/Priest/Warlock/Hunter/Shaman
    #completewith next
    .goto Ghostlands,45.4,30.5
    .fly Silvermoon >>飞往银月城
step << Shaman wotlk
    .goto Silvermoon City,71.8,56.6
    .trainer >>训练你的职业咒语
step << BloodElf Mage
    .goto Eversong Woods,54.4,50.7
    .turnin 9134 >>交任务: 葛拉米
    .accept 9135 >>接任务: 返回军需官雷米尔身边
step << Priest
    >>如果你愿意的话，你也可以在训练后从AH那里查看一个更大的魔杖
    .goto Silvermoon City,55.4,26.8
    .trainer >>训练你的职业咒语
step << Mage
    .goto Silvermoon City,57.2,18.9
    .trainer >>训练你的职业咒语
step << Warlock
    .goto Silvermoon City,75.5,45.1,10,0
    .goto Silvermoon City,74.4,47.2
    >>进入大楼，然后下楼
    .trainer >>训练你的职业咒语
step << Warlock tbc
    .goto Silvermoon City,74.0,44.8
    .vendor >>为你的虚空行者买书
    .collect 16357 --Collect Grimoire of Consume Shadows (x1)
    .collect 16351 --Collect Grimoire of Sacrifice (x1)
step << Hunter
    .goto Silvermoon City,82.4,26.0
    .trainer >>训练你的职业咒语
step << Hunter tbc
    .goto Silvermoon City,82.2,28.1
    .trainer >>训练宠物的法术
step << Mage/Priest/Warlock/Hunter/Druid/Shaman
    #completewith next
    .hs >>安宁之心
step << BloodElf Mage
    .goto Ghostlands,47.3,29.3
    .turnin 9135 >>交任务: 返回军需官雷米尔身边
step
    #label endofsun
    .goto Ghostlands,55.1,48.7
    .turnin 9172 >>交任务: 向魔导师坎迪瑞斯报到
    .accept 9176 >>接任务: 通灵双塔
step
    >>上楼去圣殿
    .goto Ghostlands,54.8,48.4
    .turnin 9151 >>交任务: 太阳圣殿
    .isOnQuest 9151
step
    >>上楼去圣殿
    .goto Ghostlands,54.8,48.4
    .accept 9220 >>接任务: 戴索姆之战
step
    >>掠夺金字塔中间的箱子
    .goto Ghostlands,40.4,49.7
    .complete 9176,1 --Collect Stone of Flame (x1)
step
    >>掠夺金字塔中间的箱子
    .goto Ghostlands,34.3,47.7
    .complete 9176,2 --Collect Stone of Light (x1)
step << !Rogue !Hunter
    .goto Ghostlands,37.8,51.9,60,0
    .goto Ghostlands,36.3,70.4,60,0
    .goto Ghostlands,37.8,51.9,60,0
    .goto Ghostlands,37.8,51.9,60,0
    .goto Ghostlands,36.3,70.4,60,0
    .goto Ghostlands,37.8,51.9,60,0
    .goto Ghostlands,37.8,51.9,60,0
    .goto Ghostlands,36.3,70.4,60,0
    .goto Ghostlands,37.8,51.9
    >>碾碎死亡伤疤，杀死暴徒并掠夺他们的腐烂心脏和脊椎尘。注意恐怖骨哨兵中断(盾击)
    *Deathcage Sorcerer and Dreadbone Sentinels drop the Spinal Dust. Risen Stalkers and Ghouls drop the Hearts.
    .complete 9216,1 --Collect Rotting Heart (x10)
.complete 9218,1 --Collect Spinal Dust (x10)
step
    .goto Ghostlands,31.7,74.3,40,0
    .goto Ghostlands,38.4,77.5,40,0
    .goto Ghostlands,31.7,74.3,40,0
    .goto Ghostlands,31.7,74.3,40,0
    .goto Ghostlands,38.4,77.5,40,0
    .goto Ghostlands,31.7,74.3,40,0
    .goto Ghostlands,31.7,74.3,40,0
    .goto Ghostlands,38.4,77.5,40,0
    .goto Ghostlands,31.7,74.3
    >>《杀死死神之眼》、《尼鲁比斯》和《嚎啕大哭》
    .complete 9220,1 --Kill Eye of Dar'Khan (x5)
    .complete 9220,2 --Kill Nerubis Centurion (x6)
    .complete 9220,3 --Kill Wailer (x6)
step
    #completewith next
    .hs >>安宁之心
    .cooldown item,6948,>0
step
    >>返回宁静。上楼去
    .goto Ghostlands,48.9,31.3
    .accept 9216 >>接任务: 腐烂精华
    .accept 9218 >>接任务: 脊骨之尘
    .turnin 9216 >>交任务: 腐烂精华
    .turnin 9218 >>交任务: 脊骨之尘
step
    .goto Ghostlands,55.1,48.8
    .turnin 9176 >>交任务: 通灵双塔
    .accept 9167 >>接任务: 叛徒的毁灭
step
    >>上楼去
    .goto Ghostlands,54.8,48.6
    .turnin 9220 >>交任务: 戴索姆之战
    .accept 9170 >>接任务: 达尔坎的军官
    .accept 9877 >>接任务: 疗伤药膏
step
    >>返回宁静
    .goto Ghostlands,47.6,34.9
    .turnin 9877 >>交任务: 疗伤药膏
    .accept 9164 >>接任务: 戴索姆的俘虏
step
    .goto Ghostlands,46.4,56.5
    .turnin 9281 >>交任务: 清理道路
step
    #completewith Jurion
    >>如果你能找到一个团体，就杀了努克洛特。他在嚎叫的Ziggurat产卵，巡逻队向西到Windrunner村，然后过河到Goldenmist村。
    .complete 9156,1 --Collect Knucklerot's Head (x1)
    .unitscan Knucklerot
step
    #completewith next
    >>杀掉并掠夺卢兹兰的头颅。如果你找不到一个团队或单独的他，跳过这个任务。他在死亡疤痕上下巡逻
    .unitscan Luzran
    .complete 9156,2 --Collect Luzran's Head (x1)
step
    #label Jurion
    >>进入地下室。杀死里面的Jurion。与埃妮丝(地上的尸体)交谈
    .complete 9170,3 --Kill Jurion the Deceiver (x1)
    .goto Ghostlands,32.1,74.5,-1
    .complete 9164,1 --Apothecary Enith Rescued
    .goto Ghostlands,32.1,73.9,-1
    .skipgossip
step
    >>杀死Mirdoran
    .goto Ghostlands,37.4,79.3
    .complete 9170,1 --Kill Mirdoran the Fallen (x1)
step
    .goto Ghostlands,38.4,84.0,20 >>前往屠宰场
step
    #label Varnis
    .goto Ghostlands,41.0,83.2
    >>与学徒瓦尼斯(桌子上的尸体)交谈
    .complete 9164,2 --Apprentice Varnis Rescued
    .skipgossip
step
    #label Vedoran
    .goto Ghostlands,32.8,89.9,0,0
    >>与游侠维多兰(桌上的尸体)交谈
    .complete 9164,3 --Ranger Vedoran Rescued
    .skipgossip
step
    #completewith next
    >>杀死博尔哥特。他是个可恶的大家伙，能在两个屠宰场中的一个里面产卵
    .goto Ghostlands,41.3,83.0,30,0
    .complete 9170,2 --Kill Borgoth the Bloodletter (x1)
    .unitscan Borgoth the Bloodletter
step
    >>杀死黑马索菲。他在其中一座金字塔里
    .goto Ghostlands,35.8,89.1,30,0
    .goto Ghostlands,29.3,88.9
    .complete 9170,4 --Kill Masophet the Black (x1)
    .unitscan Masophet the Black
step
    >>杀死博尔哥特。他是个可恶的大家伙，能在两个屠宰场中的一个里面产卵
    .goto Ghostlands,32.7,90.3,30,0
    .goto Ghostlands,41.3,83.0,30,0
    .goto Ghostlands,32.7,90.3
    .complete 9170,2 --Kill Borgoth the Bloodletter (x1)
    .unitscan Borgoth the Bloodletter
step
    #requires Vedoran
    >>杀死Ziggurat内的Dar'Khan。你可能需要一个团队来完成这个任务。你可以跳过它，但我们强烈建议你做这个任务，因为武器需要升级多少。你可以在主厅的楼梯底部展示他的能力
    *You can use mana tap to ranged pull mobs out of the room << BloodElf tbc
    *Be sure to use the weapon you got from an earlier quest then swap to your normal weapon
    .goto Ghostlands,33.0,81.3
    .complete 9167,1 --Collect Dar'Khan's Head (x1)
step
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    >>选择2小时剑，因为它对近战伤害/近战编织来说难以置信(弓太快) << Hunter tbc
    .goto Ghostlands,55.2,48.8
    .turnin 9167 >>交任务: 叛徒的毁灭 << !Paladin
    .turnin 9167,4 >>交任务: 叛徒的毁灭 << Paladin
    .isQuestComplete 9167
step << BloodElf
    .accept 9328 >>接任务: 辛多雷的英雄
    .isQuestTurnedIn 9167
step << !BloodElf
    .accept 9811 >>接任务: 辛多雷的朋友
    .isQuestTurnedIn 9167
step
    #label borgothturnin
    .goto Ghostlands,54.9,48.5
    >>上楼去
    .turnin 9170 >>交任务: 达尔坎的军官
    .turnin 9164 >>交任务: 戴索姆的俘虏
step
    #completewith next
    .hs >>安宁之心
    .cooldown item,6948,>0
step
    .isQuestComplete 9156
    .goto Ghostlands,46.1,33.5
    .turnin 9156,1 >>交任务: 通缉：纳克雷洛特和卢兹兰 << Warlock/Priest/Mage
    .turnin 9156,2 >>交任务: 通缉：纳克雷洛特和卢兹兰 << Rogue/Paladin
    .turnin 9156 >>交任务: 通缉：纳克雷洛特和卢兹兰 << !Warlock !Priest !Mage !Rogue !Paladin
    .isQuestComplete 9156
step
    .goto Ghostlands,47.7,32.3
    .vendor >>购买宁静冠军斗篷。装备它
    .collect 22990,1 --Collect Tranquillien Champion's Cloak (1)
    .isQuestTurnedIn 9167
step
    .goto Ghostlands,31.7,74.3
    .xp 20 >>升级到20
step
    #completewith next
    .goto Ghostlands,45.5,30.5
    .fly Silvermoon >>飞往银月城
step << Shaman
    .goto Silvermoon City,71.8,56.6
    .trainer >>训练你的职业咒语
step << BloodElf Paladin
    .goto Silvermoon City,54.0,71.0
    .turnin 9134 >>交任务: 葛拉米
step << Druid
    .goto Silvermoon City,71.5,55.8
    .trainer >>训练你的职业咒语
.train 5188 >>火车疗伤触摸r4
step << Priest
    .goto Silvermoon City,55.4,26.8
    .trainer >>训练你的职业咒语
step << Mage
    .goto Silvermoon City,57.2,18.9
    .trainer >>训练你的职业咒语
step << Mage
    .goto Silvermoon City,58.1,20.9
    .money <0.4000
    .train 32272 >>火车传送：银月城
step << Rogue
    .goto Silvermoon City,79.7,52.1
    .trainer >>训练你的职业咒语
    .train 8676 >>训练伏击，你需要这个来完成任务
    .train 1943 >>火车断裂，你需要这个来完成任务
--ZX come back to this later
step << Warlock
    .goto Silvermoon City,75.3,44.5,20,0
    .goto Silvermoon City,73.1,46.9
    >>进入大楼。下楼去
    .trainer >>训练你的职业咒语
step << Warlock tbc
    .vendor >>购买Torment格栅(2级)
    .collect 16346,1
step << Hunter
    .goto Silvermoon City,82.2,28.1
    .trainer >>训练你的宠物法术
step << Hunter
    .goto Silvermoon City,82.4,26.0
    .trainer >>训练你的职业咒语
step << Hunter
    .money <0.6032
    .goto Silvermoon City,86.2,35.4
    .vendor >>从Celana购买重型递归弓
    .collect 3027,1 --Heavy Recurve Bow
step << Paladin
    .goto Silvermoon City,89.3,35.2
    .turnin 9685 >>交任务: 救赎死者
step << Paladin
    .goto Silvermoon City,91.2,36.9
    .trainer >>训练你的职业咒语
step
    #label Hero
    .goto Silvermoon City,53.8,20.5
    .turnin 9328 >>交任务: 辛多雷的英雄 << BloodElf
    .accept 9621 >>接任务: 部落的特使 << BloodElf
    .turnin 9811 >>交任务: 辛多雷的朋友 << !BloodElf
    .accept 9812 >>接任务: 部落的特使 << !BloodElf
    .isQuestTurnedIn 9167
step
    .goto Silvermoon City,49.47,15.03
    .cast 25649 >>进入Silvermoon。将易位之珠带到地下
step << Warlock
    .isOnQuest 10605
    .abandon 10605 >>放弃卡伦丁传票
step << Warlock
    #completewith Envoy
    +不要在幽暗城执行术士任务。你将在Orgrimmar做这件事，因为任务线好多了
step
    #completewith next
    .goto Undercity,66.0,44.0,35 >>乘电梯到幽暗城
step << !Scourge
    .goto Undercity,63.3,48.6
    .fp Undercity >>获取幽暗城飞行路线
step << Mage
    .goto Undercity,84.2,15.6
    .train 3563 >>火车通讯：地下城
step << BloodElf
    #label Envoy
    .goto Undercity,52.0,64.6,30,0
    .goto Undercity,57.8,91.8
     >>进入皇家区。与希尔瓦娜斯·Windrunner女士交谈
    .turnin 9621 >>交任务: 部落的特使
    .accept 9626 >>接任务: 觐见酋长
    .isQuestTurnedIn 9167
step << BloodElf
    .goto Undercity,57.8,91.8
     >>与希尔瓦娜斯·Windrunner女士交谈
    .accept 9425 >>接任务: 前往塔伦米尔
    .turnin 9180 >>交任务: 幽暗城之旅
step << !BloodElf
    .goto Undercity,57.8,91.8
    >>与希尔瓦娜斯·Windrunner女士交谈
    .turnin 9812 >>交任务: 部落的特使
    .accept 9813 >>接任务: 觐见酋长
    .turnin 9177 >>交任务: 幽暗城之旅
    .isQuestTurnedIn 9167
step
    .goto Undercity,55.20,90.91
    .goto Undercity,67.88,14.97,30 >>转到主平台的边缘，执行“注销跳过”，方法是定位角色，直到其看起来像是浮动的，然后注销并重新登录。
    .link https://www.youtube.com/watch?v=jj85AXyF1XE >>当跑向转弯处时，打开此标签。单击此处查看示例
step
    .goto Tirisfal Glades,60.7,58.8
    .zone Durotar >>乘坐飞艇前往: 杜隆塔尔
]])
