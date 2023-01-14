RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 1-10 杜隆塔尔
#version 1
#group RestedXP部落1-30
#defaultfor Orc/Troll
#next 10-13 杜隆塔尔 << Warrior/Shaman
#next 10-20 永歌森林 / 幽魂之地 << !Warrior !Shaman
step << !Orc !Troll
    #sticky
    #completewith next
.goto Durotar,43.3,68.5
    +您选择了一个为兽人和巨魔准备的指南。你应该选择与你开始时相同的起始区域
step
    >>与Kaltunk交谈
    .goto Durotar,43.3,68.5
    .accept 4641 >>接任务: 起点
step << Warlock tbc
    #sticky
    #completewith next
    +杀死野猪10美分以上的供应商垃圾
    .goto Durotar,44.0,71.3,30,0
step << Warlock tbc
    .goto Durotar,42.6,69.0
.accept 1485 >>接任务: 邪灵劣魔
step << Warrior/Shaman
    #sticky
#completewith next
    +杀死野猪10美分以上的供应商垃圾
    .goto Durotar,44.2,65.9,30,0
step << Warrior/Shaman
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾。供应商铠装(如果低于10c)
step
    >>在牢房里与戈内克交谈
    .goto Durotar,42.1,68.4
    .turnin 4641 >>交任务: 起点
    .accept 788 >>接任务: 小试身手
step << Warrior
    .goto Durotar,42.9,69.4
    .train 6673 >>火车战斗呐喊
step << Shaman
    .goto Durotar,42.4,69.0
    .train 8017 >>训练投石武器
step << Warlock tbc
    .goto Durotar,40.6,68.4
    .vendor >>恶魔驯兽师的小贩垃圾
step << Warlock tbc
     .goto Durotar,40.6,68.5
    .train 348 >>火车献祭
step << !Warlock
    #sticky
    #label motboars
    >>杀死北方的野猪
    .goto Durotar,41.9,63.7,0,0
    .complete 788,1 --Mottled Boar (10)
step << Warlock tbc
    #sticky
    #completewith WarlockBoars
>>在前往卑鄙家族的途中杀死斑纹野猪。在联系Familiars之前，尝试一下ding 2。不要坐着喝酒
    .complete 788,1 --Mottled Boar (10)
step << Warlock tbc
    #completewith next
    #label WarlockBoars
    .goto Durotar,45.0,57.4,90 >>跑向家人
step << Warlock tbc
    .goto Durotar,45.3,56.9
    >>杀死邪恶家族的头颅
    .complete 1485,1 --Vile Familiar Head (6)
step << Warlock
    #sticky << tbc
	>>结束杀死斑纹野猪 << tbc
	>>杀死斑点野猪 << wotlk
	.goto Durotar,41.9,63.7 << wotlk
    #label warlockboarfi
    .complete 788,1 --Mottled Boar (10)
step << Warlock
    >>途中打磨野猪
.goto Durotar,40.6,62.6
    .accept 790 >>接任务: 萨科斯
step << !Warlock
    >>途中磨碎野猪。与树旁的哈娜祖交谈
    .goto Durotar,40.6,62.6
    .accept 790 >>接任务: 萨科斯
step
	#sticky
	#completewith next
    .goto Durotar,40.7,65.2,15 >>沿着这条小路走
step << Warlock
    #requires warlockboarfi
    >>杀死萨科特。抢走他的爪子
	.goto Durotar,40.7,67.3
    .complete 790,1 --Sarkoth's Mangled Claw (1)
step << !Warlock
    >>杀死萨科特。抢走他的爪子
	.goto Durotar,40.7,67.3
    .complete 790,1 --Sarkoth's Mangled Claw (1)
step
    >>返回哈纳祖
    .goto Durotar,40.6,62.6
    .turnin 790 >>交任务: 萨科斯
    .accept 804 >>接任务: 萨科斯
step << Warlock tbc
    .xp 3+850>>在回镇的路上提升经验到850+/1400经验
step << Warlock
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾，购买10水 << tbc
    .vendor >>供应商垃圾 << wotlk
step << Warlock tbc
    .goto Durotar,42.6,69.0
    .turnin 1485 >>交任务: 邪灵劣魔
    .accept 1499 >>接任务: 邪灵劣魔
step << Warlock tbc
    .cast 688 >>选择匕首并装备它。记得召唤你的小鬼
	.goto Durotar,42.9,69.1
    .turnin 1499 >>交任务: 邪灵劣魔
    .accept 794 >>接任务: 火刃奖章
step << !Orc !Troll
    #requires motboars
    .goto Durotar,42.1,68.3
    .turnin 788 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Rogue
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3088 >>接任务: 密文羊皮纸
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Rogue
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3083 >>接任务: 密文石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Hunter
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3087 >>接任务: 风蚀羊皮纸
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Hunter
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3082 >>接任务: 风蚀石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Mage
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3086 >>接任务: 雕文石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Priest
    #requires motboars
    .goto Durotar,42.1,68.3
    .turnin 788 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3085 >>接任务: 神圣石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Shaman
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3084 >>接任务: 符文石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Shaman
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3089 >>接任务: 符文羊皮纸
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Warrior
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804,2 >>交任务: 萨科斯
    .accept 2383 >>接任务: 简易羊皮纸
    .accept 789 >>接任务: 工蝎的尾巴
step << Troll Warrior
    #requires motboars
    >>磨蹭着回镇上
    .goto Durotar,42.1,68.3
    .turnin 788,2 >>交任务: 小试身手
    .turnin 804,2 >>交任务: 萨科斯
    .accept 3065 >>接任务: 普通石板
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Warlock
    .goto Durotar,42.1,68.3
    >>磨蹭着回镇上
    .turnin 788 >>交任务: 小试身手
    .turnin 804 >>交任务: 萨科斯
    .accept 3090>>接任务: 被污染的羊皮纸
    .accept 789 >>接任务: 工蝎的尾巴
step << Orc Rogue
    .goto Durotar,41.3,68.0
    .turnin 3088 >>交任务: 密文羊皮纸
step << Orc Warlock tbc
    .goto Durotar,40.6,68.4
    .vendor >>恶魔训练师处的供应商垃圾
step << Warlock wotlk
    .goto Durotar,40.51,68.04
	.money >0.0065
	.vendor >>研磨暴徒，直到你得到65铜。(在销售完所有产品后)
	*Sell your starting gear as well to get 95 copper.
--95c for imp, 65c for min before quest gear/starting gear vendor price.
step << Warlock wotlk
	#completewith next
    .goto Tirisfal Glades,32.3,65.4
	.money >0.0095
	.vendor >>研磨暴徒，直到你得到总共95铜。如果有助于获得95铜，请尽可能提供任何产品。
--95c for imp
step << Orc Warlock
    .goto Durotar,40.6,68.5
    .turnin 3090>>交任务: 被污染的羊皮纸
    .train 172 >>培训腐败 << tbc
	.train 688 >>列车召唤小鬼 << wotlk
step << Shaman/Priest/Mage
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾和购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Warrior/Rogue
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾
step << Hunter
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾。购买1000支箭 
step << Warlock wotlk
	#completewith next
	.cast 688 >>召唤你的小鬼
step
    >>与Galgar交谈
.goto Durotar,42.7,67.3
    .accept 4402 >>接任务: 戈加尔的清凉果
step << Orc Hunter
    >>与帐篷下的Jen'shan交谈
    .goto Durotar,42.8,69.3
    .turnin 3087 >>交任务: 风蚀羊皮纸
step << Troll Hunter
    >>与帐篷下的Jen'shan交谈
    .goto Durotar,42.8,69.3
    .turnin 3082 >>交任务: 风蚀石板
step << Troll Mage
    .goto Durotar,42.5,69.0
    .turnin 3086 >>交任务: 雕文石板
    .train 1459 >>训练奥术智能
step << Troll Priest
    .goto Durotar,42.4,68.8
    .turnin 3085 >>交任务: 神圣石板
.train 1243 >>列车动力词：坚韧
step << Troll Shaman
    .goto Durotar,42.4,69.0
    .turnin 3084 >>交任务: 符文石板
step << Orc Shaman
    .goto Durotar,42.4,69.0
    .turnin 3089 >>交任务: 符文羊皮纸
step << !Warlock tbc/wotlk
    >>与祖雷萨交谈
    .goto Durotar,42.9,69.1
    .accept 792 >>接任务: 邪灵劣魔
step << Orc Warrior
    .goto Durotar,42.9,69.4
    .turnin 2383 >>交任务: 简易羊皮纸
step << Troll Warrior
    .goto Durotar,42.9,69.4
    .turnin 3065 >>交任务: 普通石板
step
    >>在路上篝火旁与Foreman Thazz'ril交谈
    .goto Durotar,44.6,68.7
    .accept 5441 >>接任务: 懒惰的苦工
step
    #sticky
    #completewith imps
    .goto Durotar,44.0,65.3,0,0
    >>掠夺你在寻找时看到的带苹果的仙人掌
    .complete 4402,1 --Cactus Apple (10)
step
    #sticky
    #completewith imps
    .goto Durotar,47.4,65.7,0,0
    .use 16114 >>用Foreman的21点叫醒树旁熟睡的Peons(把它放在你的吧台上，让它更容易使用)
    .complete 5441,1 --Peons Awoken (5)
step << !Warlock
#sticky
    #completewith imps
.goto Durotar,47.1,65.2,30,0
>>在去洞穴的路上杀死蝎子以获取一些尾巴
.complete 789,1 --Scorpid Worker Tail (10)
step << Warlock
    >>杀死蝎子的尾巴
.complete 789,1 --Scorpid Worker Tail (10)
.goto Durotar,47.1,65.2,40,0
.goto Durotar,46.6,58.2,40,0
.goto Durotar,39.8,63.5

step << !Warlock tbc/wotlk
    #label imps
.goto Durotar,45.2,56.8
    >>在山洞前杀死小鬼
    .complete 792,1 --Vile Familiar (12)
step << !Warlock
    #sticky
    #label scorpytails
>>完成蝎子尾巴
.goto Durotar,39.8,63.5
    .complete 789,1 --Scorpid Worker Tail (10)
step
    #sticky
    #label cactusapples
    .goto Durotar,44.0,65.3,0,0
    >>掠夺你看到的带苹果的仙人掌
    .complete 4402,1 --Cactus Apple (10)
step
    .goto Durotar,47.4,65.7
    .use 16114 >>用Foreman的21点叫醒树旁熟睡的Peons(把它放在你的吧台上，让它更容易使用)
    .complete 5441,1 --Peons Awoken (5)
step
    #requires scorpytails
step
    #requires cactusapples
    >>回镇上和Galgar谈谈
    .goto Durotar,42.7,67.2
    .turnin 4402 >>交任务: 戈加尔的清凉果
step << Warrior/Rogue/Hunter/Druid/Paladin/Shaman
    .goto Durotar,42.6,67.3
.vendor >>供应商垃圾
step << Mage/Priest/Warlock
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾和购买10水 << tbc
    .vendor >>供应商垃圾 << wotlk
    .collect 159,10 << tbc --Collect Refreshing Spring Water (x10)
step
    >>头部进入巢穴
    .goto Durotar,42.1,68.3
    .turnin 789 >>交任务: 工蝎的尾巴
step << Shaman
    .goto Durotar,42.4,69.1
    .accept 1516 >>接任务: 大地的召唤
    .train 8042 >>列车接地冲击
step << Mage
    .goto Durotar,42.5,69.0
    .train 116 >>列车防冻螺栓
step << Priest
    .money <0.0190
    .goto Durotar,42.4,68.8
    .train 589 >>训练暗语：痛苦
step << tbc !Warlock/wotlk
    >>与祖雷萨交谈
    .goto Durotar,42.9,69.1
    .turnin 792,3 >>交任务: 邪灵劣魔 << Hunter
    .turnin 792 >>交任务: 邪灵劣魔 << !Hunter
    .accept 794 >>接任务: 火刃奖章
step << Hunter
    .money <0.0190
.goto Durotar,42.8,69.3
.train 13163 >>猴子的训练方面
    .train 1978 >>火车蛇刺
step << Hunter
.goto Durotar,42.8,69.3
    .train 1978 >>火车蛇刺
step << Warrior
    .goto Durotar,42.9,69.4
    .train 772 >>列车Rend
    .train 100 >>列车收费
step
    .goto Durotar,44.6,68.7
    >>与Foreman Thazz'ril交谈
    .turnin 5441 >>交任务: 懒惰的苦工
    .accept 6394 >>接任务: 塔兹利尔的镐
step
	#completewith next
    .goto Durotar,45.2,56.8,30 >>跑向洞穴
step << Shaman
    #sticky
>>为了蹄子杀死恶棍
.complete 1516,1 --Felstalker Hoof (2)
step
>>进入中间的房间，从地上抢夺皮克
.goto Durotar,43.7,53.8
    .complete 6394,1 --Thazz'ril's Pick (1)
step
    #sticky
    #completewith next
.goto Durotar,44.7,54.0,10,0
    .goto Durotar,43.4,52.0,10 >>回到洞穴的这一部分，然后跟着它到这里
step
    >>杀死亚罗格。抢他拿奖章
.goto Durotar,42.7,53.0
    .complete 794,1 --Burning Blade Medallion (1)
	.unitscan Yarrog Baneshadow
step << !Shaman
    .xp 5+1725>>提升经验到1725+/2800xp
step << Shaman
    .xp 5+1200>>提升经验到1200+/2800xp
step << !Paladin
    #completewith next
    .hs >>从炉膛到审判谷
    .goto Durotar,43.3,69.0,100,0
step << Paladin
    .goto Durotar,43.3,69.0,140 >>在洞穴的起点附近死去，在精神治疗者那里重生，或者干脆跑回城镇。
step
    #xprate >1.4
    >>与工头交谈。我们将提前达到6级。
    .goto Durotar,44.6,68.6
    .turnin 6394 >>交任务: 塔兹利尔的镐
step
    >>保存你得到的治疗药剂，因为你以后可能需要它来对付半人马
.goto Durotar,42.8,69.1
    .turnin 794,2 >>交任务: 火刃奖章 << Warrior
    .turnin 794 >>交任务: 火刃奖章 << !Warrior
    .accept 805 >>接任务: 去森金村报到
step
	#completewith next
    .goto Durotar,42.6,67.3
	.vendor >>供应商垃圾
step << !Shaman
    .xp 6 >>升级到6级
step << Priest
	.goto Durotar,42.4,68.8
	.accept 5649 >>接任务: 部族的传统
	.train 591 >>训练Smite 2级
    .train 17 >>列车动力字：盾牌
step << Mage
    .goto Durotar,42.5,69.0
    .train 143 >>训练火球2级
    .train 2136 >>列车防火爆炸
step << Shaman
    .goto Durotar,42.4,69.2
    .turnin 1516 >>交任务: 大地的召唤
    .accept 1517 >>接任务: 大地的召唤
step << Hunter
    .goto Durotar,42.8,69.3
    .train 1130 >>训练猎人的标记
    .train 3044 >>火车奥术射击
step << Warrior
    .goto Durotar,42.9,69.4
    .train 3127 >>列车招架
step << Rogue
.goto Durotar,41.3,68.0
    .train 1757 >>火车罪恶打击2级
    .train 1776 >>火车凿槽
step << Warlock
    .goto Durotar,40.6,68.5
    .train 695 >>列车阴影螺栓等级2
    .train 1454 >>列车生命抽头 << tbc
step << Warlock
    .money <0.0095
.goto Durotar,40.6,68.4
    .vendor >>买血契约书并使用
    .use 16321
step << Shaman
    .goto Durotar,43.0,71.2,20 >>运行隐藏路径
step << Shaman
.goto Durotar,41.5,73.3,10 >>运行隐藏路径
step << Shaman
.goto Durotar,40.8,74.1,8 >>在这里左转
step << Shaman
    .goto Durotar,41.8,74.8,10 >>运行隐藏路径
step << Shaman
    >>用你袋子里的地球皂甙
.goto Durotar,44.0,76.2
    .turnin 1517 >>交任务: 大地的召唤
    .accept 1518 >>接任务: 大地的召唤
step << Shaman
    .goto Durotar,42.4,69.1
    .turnin 1518 >>交任务: 大地的召唤
    .train 332 >>训练疗愈波2级
step
    .isOnQuest 6394
    >>与工头交谈。
    .goto Durotar,44.6,68.6
    .turnin 6394 >>交任务: 塔兹利尔的镐
step
    >>离开起始区域
.goto Durotar,52.1,68.3
    .accept 2161 >>接任务: 苦工的重担
step
    .goto Durotar,54.3,73.3,15,0
    .goto Durotar,54.5,75.0,15,0
    .goto Durotar,54.1,76.6,15,0
    .goto Durotar,54.3,73.3,15,0
    .goto Durotar,54.5,75.0,15,0
    .goto Durotar,54.1,76.6
    >>与拉尔·普罗图斯克交谈。他在3个点之间巡逻
    .accept 786 >>接任务: 科卡尔半人马的进攻
    .unitscan Lar Prowltusk
step
    >>在小屋里与Vel'rin Fang交谈
    .accept 817 >>接任务: 生活所需的虎皮
    .goto Durotar,56.0,73.9
    >>在池边与沃纳尔大师和加德林交谈
    .accept 818 >>接任务: 沃纳尔大师
    .goto Durotar,55.9,74.4 
    .turnin 805 >>交任务: 去森金村报到
    .goto Durotar,55.9,74.7
    .accept 808 >>接任务: 明希纳的颅骨
    .accept 826 >>接任务: 扎拉赞恩
    .accept 823 >>接任务: 向奥戈尼尔报告
step << Shaman
    .goto Durotar,56.5,73.1
    .vendor >>供应商垃圾。如果你有足够的钱买手杖(4s80c)，就把你的武器卖掉。如果你还不够，你会回来的
step << Shaman
    .goto Durotar,56.5,73.1
    .money <0.0480
    >>买根手杖并装备它
    .collect 2495,1 --Collect Walking Stick
step << Rogue
.goto Durotar,56.5,73.1
.vendor >>供应商垃圾。如果你的武器能给你足够的钱买斯蒂莱托(3s82c)，就把它卖掉。如果你还不够，你会回来的
step << Rogue
    .goto Durotar,56.5,73.1
    .money <0.0382
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .goto Durotar,56.5,73.1
.vendor >>供应商垃圾。如果你的武器有足够的钱买大斧(4s60c)，就卖掉它。如果你还不够，你会回来的
step << Orc Warrior
    .goto Durotar,56.5,73.1
    .money <0.0460
    >>购买一把大斧子并装备它
    .collect 2491,1 --Collect Large Axe
step << Paladin
    .goto Durotar,56.5,73.1
.vendor >>供应商垃圾。如果能给你足够的钱买格拉迪斯(5s9c)，就卖掉你的武器。如果你还不够，你会回来的
step << Paladin
    .goto Durotar,56.5,73.1
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Hunter
    .goto Durotar,56.5,73.1
.vendor >>供应商垃圾。如果能给你足够的钱买Hornwood Recurve Bow(2s 71c)，就卖掉你的武器。如果你还不够，你会回来的
step << Hunter
    .goto Durotar,56.5,73.1
    .money <0.0271
    >>购买Hornwood递归弓并装备
    .collect 2506,1 --Collect Hornwood Recurve Bow
step
#sticky
#completewith next
.goto Durotar,59.7,71.7,0
    .goto Durotar,57.6,77.9,0
    >>为了黏液和眼睛，尽可能多地杀死爬行动物和马克鲁拉。这个任务可以稍后完成。
    .complete 818,2 --Crawler Mucus (8)
    .complete 818,1 --Intact Makrura Eye (4)
step
    .goto Durotar,52.1,83.3,75 >>到达海滩尽头
step
.goto Durotar,50.9,79.2,15 >>进入科尔卡基地
step
    #sticky
    #completewith Bonfire
    +如果军阀科尔卡尼斯正在阻止一个计划，在你7级时杀死他。确保使用仙人掌苹果惊喜+2 stam，并使用早期的治疗药剂。
    .unitscan Warlord Kolkanis
step
    >>在帐篷里的地上。
.goto Durotar,49.8,81.2
    .complete 786,1 --Attack Plan: Valley of Trials destroyed (1)
step
    .goto Durotar,47.7,77.4
    .complete 786,2 --Attack Plan: Sen'jin Village destroyed (1)
step
    #label Bonfire
.goto Durotar,46.3,79.0
    .complete 786,3 --Attack Plan: Orgrimmar destroyed (1)
step
    #completewith next
    .deathskip >>在篝火中死去，在精神治疗者那里重生，或者跑回森津村
step << Shaman
    .goto Durotar,56.6,73.1
    .money <0.0480
    >>从外面楼梯下面与Traxexir交谈
    >>买根手杖并装备它
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    .goto Durotar,56.5,73.1
    .money <0.0382
    >>从外面楼梯下面与Traxexir交谈
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .money <0.0460
    .goto Durotar,56.5,73.1
    >>从外面楼梯下面与Traxexir交谈
    >>购买一把大斧子并装备它
    .collect 2491,1 --Collect Large Axe
step << Paladin
    .goto Durotar,56.5,73.1
    .money <0.0509
    >>从外面楼梯下面与Traxexir交谈
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Hunter
    .goto Durotar,56.5,73.1
    .money <0.0271
    >>购买Hornwood递归弓并装备
    .collect 2506,1 --Collect Hornwood Recurve Bow
step
    #completewith next
    .goto Durotar,52.5,44.4,100 >>把暴徒逼到剃刀山。试着把注意力集中在蝎子身上，因为它们会掉落干燥的蝎子眼，每只售价95美分。
step
    .isOnQuest 823
    .goto Durotar,52.2,43.2
    .turnin 823 >>交任务: 向奥戈尼尔报告
step
    >>煤仓顶层内
    .goto Durotar,51.9,43.5
    .accept 784 >>接任务: 背信弃义的人类
step << Shaman/Warrior
    .goto Durotar,52.2,43.2
    .turnin 823 >>交任务: 向奥戈尼尔报告
    .accept 806 >>接任务: 黑暗风暴
step << !Shaman !Warrior
    #xprate <1.5
    .goto Durotar,52.2,43.2
    .turnin 823 >>交任务: 向奥戈尼尔报告
step
    .goto Durotar,51.1,42.6
    .vendor >>供应商垃圾
step
    >>与Cook Torka交谈
    .goto Durotar,51.1,42.4
    .accept 815 >>接任务: 恐龙蛋大餐
step
    .goto Durotar,50.2,43.1,15 >>沿着这条小路走
step
    >>爬上塔楼和Furl Scornbrow谈谈
.goto Durotar,49.9,40.3
    .accept 791 >>接任务: 新的背包
step << Shaman
    .goto Durotar,52.0,40.5
    .money <0.0480
    >>买根手杖并装备它
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    .goto Durotar,52.0,40.5
    .money <0.0382
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .goto Durotar,52.0,40.5
    .money <0.0460
    >>购买一把大斧子并装备它
    .collect 2491,1 --Collect Large Axe
step << Paladin
    .goto Durotar,52.0,40.5
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Hunter
    .goto Durotar,53.0,41.0
    .money <0.0271
    >>购买Hornwood递归弓并装备它，储备箭
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Warrior/Rogue/Paladin
    .goto Durotar,52.0,40.7
    .money <0.0020
    .train 2018 >>火车铁匠。锻造允许你制造锐化宝石(+2武器伤害，持续1小时)。你应该在20级左右停止制作。如果你愿意，可以跳过锻造和采矿
step << Warrior/Rogue/Paladin
    .goto Durotar,51.8,40.9
    .money <0.0010
    .train 2580 >>训练采矿。在你的魔法书中施放“寻找矿物”
step << Priest
    .goto Durotar,54.3,42.9
    .turnin 5649 >>接任务: 部族的传统
    .accept 5648 >>接任务: 灵魂之衣
    .train 2052 >>训练Lesser Heal r2
step << Priest
    .goto Durotar,53.1,46.5
    .cast 2052 >>在Grunt Kor'ja上施放低级别治疗(2级)
    .cast 1243 >>施展权力话语：格伦特·科尔贾的坚韧（排名1）
    .complete 5648,1 --Heal and cast Fortify on Grunt Kor'ja
step << Priest
    .goto Durotar,54.3,42.9
    .turnin 5648 >>接任务: 灵魂之衣
step << Priest/Mage/Warlock/Shaman/Druid
    .goto Durotar,51.5,41.6
    >>与客栈老板交谈
    .turnin 2161 >>交任务: 苦工的重担
    .home >>把你的炉石放在剃刀山
    .vendor >>尽可能多地购买冰镇牛奶
step << Warrior/Rogue/Hunter
    .goto Durotar,51.5,41.6
    >>与客栈老板交谈
    .turnin 2161 >>交任务: 苦工的重担
    .home >>把你的炉石放在剃刀山
    .vendor >>买尽可能多的肉腰
step << Paladin
    .goto Durotar,51.5,41.6
    >>与客栈老板交谈
    .turnin 2161 >>交任务: 苦工的重担
    .home >>把你的炉石放在剃刀山
step << Warrior/Rogue/Paladin
    .goto Durotar,53.0,42.0
    .money <0.0077
.collect 2901,1 >>购买采矿镐。留意我的静脉，用铁匠技术为你的武器制作磨石
step << Paladin
    .goto Orgrimmar,49.1,94.7,20 >>前往: 奥格瑞玛
step << Paladin
    .goto Orgrimmar,32.3,35.7
    .trainer >>去训练你的职业咒语
step << Paladin
    #completewith next
    .goto Durotar,59.2,58.3,15
    .hs >>炉底到剃须山
step
    #sticky
    #label KulTiras
    .goto Durotar,59.2,58.3
>>杀死Kul Tiras暴徒。抢走他们的碎片
    .complete 784,1 --Kul Tiras Sailor (10)
    .complete 784,2 --Kul Tiras Marine (8)
    .complete 791,1 --Canvas Scraps (8)
step
    .goto Durotar,59.7,58.3
    >>去要塞的顶层。杀死Benedict中尉并抢走他的钥匙-小心他使用盾牌猛击(打断)
.complete 784,3 --Lieutenant Benedict (1)
.collect 4882,1 --Collect Benedict's Key (1)
step
.goto Durotar,59.8,57.8,8 >>在这里上楼梯
step
.goto Durotar,59.9,57.5,8 >>在这里上楼梯
step
>>掠夺胸部。从物品中接受任务
.goto Durotar,59.3,57.6
.collect 4881,1,830 --Collect Aged Envelope (1)
    .use 4881
.accept 830 >>接任务: 将军的命令
step
    #xprate <1.5
    .goto Durotar,58.4,57.2
.xp 7+2195>>提升经验到2195+/4500xp
step
    #xprate <1.5
    #requires KulTiras
    #completewith next
.deathskip >>在精神治疗者处死亡并重生，或者跑回剃须刀山
step
    #xprate <1.5
    .goto Durotar,51.9,43.5
    .turnin 784 >>交任务: 背信弃义的人类
    .accept 825 >>接任务: 海底沉船
    .turnin 830 >>交任务: 将军的命令
    .accept 837 >>接任务: 野猪人的进犯
step << Warlock/Shaman/Warrior
    #xprate <1.5
    .goto Durotar,51.9,43.5
.accept 831 >>接任务: 将军的命令
step
    #xprate <1.5
.goto Durotar,49.9,40.3
    .turnin 791 >>交任务: 新的背包
step << !Shaman !Warrior
    #xprate <1.5
    .abandon 806 >>放弃黑暗风暴
step << Shaman
    #xprate <1.5
    .goto Durotar,52.0,40.5
    .money <0.0480
    >>买根手杖并装备它
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    #xprate <1.5
    .goto Durotar,52.0,40.5
    .money <0.0382
    >>购买细高跟鞋并装备它
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    #xprate <1.5
    .goto Durotar,52.0,40.5
    .money <0.0460
    >>购买一把大斧子并装备它
    .collect 2491,1 --Collect Large Axe
step << Paladin
    #xprate <1.5
    .goto Durotar,52.0,40.5
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Hunter
    #xprate <1.5
    .goto Durotar,53.0,41.0
    .money <0.0271
    >>购买Hornwood递归弓并装备
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Warrior/Rogue
    #xprate <1.5
    .goto Durotar,52.0,40.7
    .money <0.0020
    .train 2018 >>火车铁匠。锻造允许你制造锐化宝石(+2武器伤害，持续1小时)。如果你愿意，可以跳过锻造和采矿
step << Warrior/Rogue
    #xprate <1.5
.goto Durotar,51.8,40.9
    .money <0.0010
    .train 2580 >>训练采矿。
    .cast 2580 >>在你的魔法书中施放“寻找矿物”
step << Warrior/Rogue
    #xprate <1.5
    .goto Durotar,53.0,42.0
    .money <0.0077
.collect 2901,1 >>购买采矿镐。留意我的静脉，为你的武器制作磨石
step << Shaman
    #xprate <1.5
    .goto Durotar,54.4,42.6
    .train 2484 >>火车土缚图腾
    .train 324 >>列车避雷网
    .train 8044 >>列车地震r2
    .train 8018 >>训练摇滚武器r2
step << Priest
    #xprate <1.5
    .goto Durotar,54.3,42.9
    .train 139 >>列车更新
step << Warrior
    #xprate <1.5
.goto Durotar,54.2,42.5
    .train 284 >>训练英雄打击r2
    .train 1715 >>训练腿筋
step << Hunter
    #xprate <1.5
    .goto Durotar,51.8,43.5
    .train 5116 >>火车震荡射击
step << Rogue
    #xprate <1.5
.goto Durotar,52.0,43.7
    .train 6760 >>训练剔骨r2
    .train 5277 >>列车逃逸
step << Warlock
    #xprate <1.5
    .goto Durotar,54.4,41.2
    .train 980 >>训练痛苦诅咒
    .train 5782 >>训练恐惧
step << Warrior/Rogue
    #xprate <1.5
    .goto Durotar,54.2,41.9
    .money <0.0095
    .train 3273 >>培训急救
step
    #xprate <1.5
    .goto Durotar,54.4,42.2
    .money <0.1184
.vendor >>从Jark那里买一个6槽包
step << Priest/Warlock/Mage
    #xprate <1.5
    .goto Durotar,51.5,41.6
    .vendor >>尽可能多地购买冰镇牛奶
step << Warrior/Rogue
    #xprate <1.5
    .goto Durotar,51.5,41.6
    .vendor >>买尽可能多的肉腰
step
    #sticky
    #requires KulTiras
    #completewith Tools
    >>在这里杀死一些Makrura以获取眼睛/在前往其他任务的途中为Mucus抓取爬虫。你不需要在这里完成它。
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step
    #xprate <1.5
    #completewith next
    >>检查离海岸最近的船上的工具箱。如果找不到这些产卵，请查看其他船只。它们可能有点难看
    .goto Durotar,61.9,55.5,10 >>在水下的窗户里
    .goto Durotar,62.3,56.3,10 >>水下的
    .goto Durotar,61.4,56.1,10 >>靠近海岸
step
    #xprate <1.5
    .goto Durotar,61.9,55.5,10,0
    .goto Durotar,62.3,56.3,10,0
    .goto Durotar,61.4,56.1,10,0
    .complete 825,1 --Gnomish Tools (3)
step
    #requires KulTiras
    #label Tools
    .goto Durotar,67.2,70.0,125 >>游到岛上
step
    #sticky
    #completewith Fur
    >>杀死所有你看到的老虎的皮毛
    .complete 817,1 --Durotar Tiger Fur (4)
step
    >>在这个岛上的地上掠夺Taillasher鸡蛋。他们通常由Taillasher看守
    .goto Durotar,68.8,71.5
    .complete 815,1 --Taillasher Egg (3)
step
    #sticky
    #completewith Swim
    >>在这里杀死一些Makrura以换取眼睛/爬行动物以换取黏液
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step
    #label Swim
.goto Durotar,66.9,80.0,80 >>游到另一个岛
step
    #sticky
    #completewith Trolls
    >>杀死该地区的巨魔。当巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step << Shaman
    .goto Durotar,67.4,87.8
    >>杀死扎拉扎内。当他施放治愈之波时，保存你的地球冲击。掠夺他的头
    .complete 826,3 --Zalazane's Head (1)
step << Rogue
    .goto Durotar,67.4,87.8
    >>杀死扎拉扎内。把你的凿击术留到他施放治疗波的时候。掠夺他的头
    .complete 826,3 --Zalazane's Head (1)
step << !Rogue !Shaman
    .goto Durotar,67.4,87.8
    >>杀死扎拉扎内。小心，因为他可以治愈(你可能需要治疗药剂)。掠夺他的头
    .complete 826,3 --Zalazane's Head (1)
step
    #label Trolls
.goto Durotar,67.4,87.8
    >>在地上掠夺一个头骨
    .complete 808,1 --Minshina's Skull (1)
step
    #label Fur
>>杀死其余的巨魔。当巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step
>>完成剩余的虎皮
    .goto Durotar,64.7,88.5,30,0
    .goto Durotar,65.2,80.8,30,0
    .goto Durotar,59.9,83.6,30,0
    .goto Durotar,64.7,88.5,30,0
    .goto Durotar,65.2,80.8,30,0
    .goto Durotar,59.9,83.6,30,0
    .complete 817,1 --Durotar Tiger Fur (4)
step
     #completewith next
    .deathskip >>在精神疗愈者处死去并重生，或者跑回森津村
step
    >>完成从Makrura和Crawler那里获得剩余物品
        .goto Durotar,59.7,71.7,50,0
    .goto Durotar,57.6,77.9,50,0
    .goto Durotar,59.7,71.7,50,0
    .goto Durotar,57.6,77.9,50,0
    .goto Durotar,59.7,71.7,50,0
    .goto Durotar,57.6,77.9,50,0
    .goto Durotar,59.7,71.7,50,0
    .goto Durotar,57.6,77.9
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step << Mage
    >>到帐篷里去
.goto Durotar,56.3,75.1
    .train 205 >>列车防冻螺栓r2
.train 118 >>训练变形
step
    >>返回森津村。保存微弱发光的骷髅供以后使用
.goto Durotar,55.9,74.7
    .turnin 808 >>交任务: 明希纳的颅骨
    .turnin 826,1 >>交任务: 扎拉赞恩 << Warrior
    turnin 826 >>交任务: 扎拉赞恩 << !Warrior
step
    >>与Vornal大师、Vel'rin和Lar Prowltusk交谈
    .turnin 818 >>交任务: 沃纳尔大师
    .goto Durotar,56.0,74.3
    .turnin 817 >>交任务: 生活所需的虎皮
    .goto Durotar,56.0,73.9
    .unitscan Lar Prowltusk
    .turnin 786 >>交任务: 科卡尔半人马的进攻
    .goto Durotar,54.3,73.3
step
    #completewith next
    .goto Durotar,48.9,48.5
    .hs >>炉底回到剃须山
step
    #xprate <1.5
    .goto Durotar,48.9,48.5
    >>杀死该地区的Quilboars和Scouts
    .complete 837,1 --Razormane Quilboar (4)
    .complete 837,2 --Razormane Scout (4)
step
    #xprate <1.5
    .goto Durotar,43.8,39.1
    >>杀死该地区的除尘兵和战警。吸尘器有返老还童(治疗)能力，而战队守卫则很虚弱
    .complete 837,3 --Razormane Dustrunner (4)
    .complete 837,4 --Razormane Battleguard (4)
step
    #xprate <1.5
    .goto Durotar,43.8,39.1
    .xp 9+5175>>提升经验到5175+/6500xp
step
    #xprate >1.499
    .goto Durotar,51.9,43.5
    >>前往地堡
    .turnin 784 >>交任务: 背信弃义的人类
    .turnin 830 >>交任务: 将军的命令
    .accept 837 >>接任务: 野猪人的进犯 << Warrior/Shaman
step << Hunter
    .xp <10,1
    .goto Durotar,51.8,43.5
    .accept 6062 >>接任务: 驯服野兽
    .train 13165 >>鹰的训练视角
    .train 13549 >>训练毒蛇刺r2
step << Warlock/Shaman/Warrior/Hunter
    #xprate >1.499
    .goto Durotar,51.9,43.5
.accept 831 >>接任务: 将军的命令
step
    >>与Cook Torka交谈
    .goto Durotar,51.1,42.4
        .turnin 815 >>交任务: 恐龙蛋大餐
step
    #xprate >1.499
    >>爬上山，爬上塔，与Furl Scornbrow交谈，然后装备你的新包。
.goto Durotar,49.9,40.3
    .turnin 791 >>交任务: 新的背包
step << Hunter
    .isOnQuest 6062
    .use 15917 >>单击包中的驯鹿棒。尝试在最大射程(30码)进行
.goto Durotar,51.5,50.0
.complete 6062,1 --Tame a Dire Mottled Boar
step << !Shaman !Warrior
    #xprate >1.499
    .abandon 806 >>放弃黑暗风暴
step
    #xprate <1.5
    .goto Durotar,51.9,43.5
    .turnin 825 >>交任务: 海底沉船
    .turnin 837 >>交任务: 野猪人的进犯
step
    .goto Durotar,43.8,39.1
    .xp 10 >>升级到10
step << Paladin
    #sticky
    #completewith next
    +如果你害怕Eversong比赛，那么现在手动选择10-13 Durotar->13-23 Barrens
step << Shaman
    .goto Durotar,54.4,42.5
    .accept 2983 >>接任务: 火焰的召唤
    .train 8075 >>大地图腾的训练力量
    .train 8050 >>列车火焰冲击
step << Priest
    .goto Durotar,54.3,42.9
    .train 2053 >>训练Lesser Heal r3
    .train 8092 >>训练心灵冲击
.train 594 >>训练暗语：痛苦r2
step << Orc Warrior/Troll Warrior/Undead Warrior
    .goto Durotar,54.2,42.5
    .accept 1505 >>接任务: 老兵犹塞克
    .train 2687 >>训练血腥
    .train 6546 >>列车Rend r2
step << Rogue
    .goto Durotar,52.0,43.7
    .train 2983 >>火车冲刺
    .train 674 >>训练双Wield
    .train 6770 >>训练Sap
    .train 1784 >>列车隐身
step << Rogue
    .goto Durotar,56.5,73.1
    .money <0.0382
    .vendor >>购买另一个细高跟鞋并装备它
step << Warrior/Rogue/Paladin
.goto Durotar,54.2,41.9
    .money <0.0095
    .train 3273 >>培训急救
step << Warlock
    .goto Durotar,54.4,41.2
    .accept 1506 >>接任务: 甘鲁尔的召唤
step << Warlock
    .goto Durotar,54.4,41.2
    .train 1120 >>训练吸取灵魂
    .train 6201 >>训练Create Healthstone
    .train 696 >>训练恶魔皮肤r2
    .train 707 >>火车献祭r2
step << Hunter
    .goto Durotar,51.8,43.5
    .accept 6062 >>接任务: 驯服野兽
    .train 13165 >>鹰的训练视角
    .train 13549 >>训练毒蛇刺r2
step << Hunter
    .goto Durotar,53.0,41.0
    .vendor >>供应商和库存10级箭头
step << Hunter
    .use 15917 >>单击包中的驯鹿棒。尝试在最大射程(30码)进行
.goto Durotar,51.5,50.0
.complete 6062,1 --Tame a Dire Mottled Boar
    .unitscan Dire Mottled Boar
step << Hunter
    .goto Durotar,51.8,43.5
.turnin 6062 >>交任务: 驯服野兽
.accept 6083 >>接任务: 驯服野兽
step << Hunter
    .use 15919 >>不要杀死你看到的装甲蝎子，因为你需要驯服下一个。向北前往海滩，驯服一只冲浪爬虫。
.goto Durotar,59.3,27.6
.complete 6083,1 --Tame a Surf Crawler
    .unitscan Surf Crawler
step << Hunter
    >>返回Razor Hill
    .goto Durotar,51.8,43.5
.turnin 6083 >>交任务: 驯服野兽
.accept 6082 >>接任务: 驯服野兽
step << Hunter
    .use 15920 >>点击你包里的驯蝎棒。尝试在最大射程(30码)进行
    .goto Durotar,59.3,27.6
    .complete 6082,1 --Tame an Armored Scorpid
    .unitscan Armored Scorpid
step << Hunter
    >>返回托塔
    .goto Durotar,51.8,43.5
    .turnin 6082 >>交任务: 驯服野兽
    .accept 6081 >>接任务: 训练野兽
step << Hunter
    >>沿着这条路向北走，和雷兹拉克谈谈
    .goto Durotar,46.4,22.9
    .accept 834 >>接任务: 沙漠之风
step << Warlock/Hunter
    .goto Orgrimmar,49.0,94.2,20 >>前往: 奥格瑞玛
step << Hunter
    >>前往荣誉谷，与Ormak Grimshot交谈
    .goto Orgrimmar,66.0,18.5
    .turnin 6081 >>交任务: 训练野兽
step << Hunter tbc
    >>在酒吧里放上“野兽训练”。记得稍后教你的宠物技能
.goto Orgrimmar,66.3,14.8
    .train 4195 >>训练非凡耐力
    .train 24547 >>训练天然护甲
step << Warlock
.goto Orgrimmar,48.3,45.3
.turnin 1506 >>交任务: 甘鲁尔的召唤
.accept 1501 >>接任务: 虚空中的生物
step << Warlock/Hunter
    .goto Orgrimmar,34.3,36.4
    .turnin 831 >>交任务: 将军的命令
step << Warlock
.goto Orgrimmar,31.6,37.8
.accept 5726 >>接任务: 隐藏的敌人
step << Warlock
    #sticky
    #completewith next
.goto Orgrimmar,36.0,37.7 >>点击你的恶魔皮肤buff。在火盆顶部运行，并使用Life Tap进行冲模。在orgrimmar之外重生
step << Warlock/Hunter
.goto Orgrimmar,49.0,94.2,275 >>逃离Orgrimmar
step << Warlock
.goto Durotar,55.0,9.7,25 >>进入骷髅岩
step << Warlock
    #sticky
    #label Collars
>>杀死燃烧之刃暴徒直到中尉徽章掉落
    .complete 5726,1 --Lieutenant's Insignia (1)
step << Warlock
    #sticky
    #label Eye
    #completewith Skull
    .use 4945 >>或者，你可以为任务物品杀死Gazz'uz(14级术士)。一定要使用之前的骷髅头、任何药水，或者在虚空行者身上使用粘性胶水。你可以用LoS(视线)Gazz'uz躲避他的暗箭，并害怕他的宠物。如果你不能杀了他，试着从他身边溜走，或者在水里死后重生。
    .collect 4903,1,832 --Collect Eye of Burning Shadow
    .accept 832 >>接任务: 燃影之眼
    .unitscan Gazz'uz
step << Warlock
    .goto Durotar,53.6,8.5,10,0
    .goto Durotar,51.8,8.1,10,0
    .goto Durotar,51.6,9.8
    >>进入洞穴的正确路径。继续跟踪洞穴，然后在洞穴尽头掠夺箱子
    .complete 1501,1 --Tablet of Verga (1)
step << Warlock
    #label Skull
    #completewith next
    .deathskip >>在精神疗愈者处死去并重生，或者逃到奥格瑞玛
step << Warlock
.goto Orgrimmar,49.0,94.2,20 >>前往: 奥格瑞玛
step << Warlock
    .goto Orgrimmar,31.8,37.8
    .turnin 5726 >>交任务: 隐藏的敌人
    .accept 5727 >>接任务: 隐藏的敌人
step << Warlock
    .goto Orgrimmar,48.3,45.3
    .turnin 1501 >>交任务: 虚空中的生物
    .accept 1504 >>接任务: 誓缚
step << Warlock
    .isOnQuest 832
.goto Orgrimmar,49.5,50.6
    .turnin 832 >>交任务: 燃影之眼
step << Warlock
    >>与Neeru交谈并完成他的八卦选项
.goto Orgrimmar,49.5,50.6
    .skipgossip
    .complete 5727,1 --Gauge Neeru Fireblade's reaction to you being a member of the Burning Blade (1)
step << Warlock
    .goto Orgrimmar,49.5,50.0
    .use 7464>>使用召唤雕文召唤一个虚空行者。杀了它
    .complete 1504,1 --Summoned Voidwalker (1)
step << Warlock
    >>你现在可以召唤一个虚空行者
.goto Orgrimmar,48.3,45.3
    .turnin 1504 >>交任务: 誓缚
step << Warlock
    .goto Orgrimmar,31.8,37.8
    .turnin 5727 >>交任务: 隐藏的敌人
step << Warlock
    #sticky
    #completewith next
    .goto Orgrimmar,36.0,37.7 >>点击你的恶魔皮肤buff。在火盆顶部运行，并使用Life Tap进行冲模。在orgrimmar之外重生
step << Warlock
    .goto Orgrimmar,49.0,94.2,275 >>逃离Orgrimmar
step << !Shaman !Warrior !Warlock !Hunter
    .goto Durotar,46.4,22.9
    .accept 834 >>接任务: 沙漠之风
step << !Shaman !Warrior !Warlock
    >>掠夺地上的小麻袋
.goto Durotar,51.7,27.7
    .complete 834,1 --Sack of Supplies (5)
step << !Shaman !Warrior !Warlock
    .goto Durotar,46.4,22.9
    >>返回雷兹拉克
    .turnin 834 >>交任务: 沙漠之风
    .accept 835 >>接任务: 保卫商路
step << !Shaman !Warrior !Warlock
    .goto Durotar,51.9,27.4,20 >>从这里穿过洞穴
step << !Shaman !Warrior !Warlock
    >>杀死该地区的哈比
    .goto Durotar,54.0,27.7,30,0
    .goto Durotar,51.3,23.5,30,0
    .goto Durotar,51.5,19.1,30,0
    .goto Durotar,54.0,27.7,30,0
    .goto Durotar,51.3,23.5,30,0
    .goto Durotar,51.5,19.1,30,0
    .complete 835,1 --Dustwind Savage (12)
    .complete 835,2 --Dustwind Storm Witch (8)
step << !Shaman !Warrior !Warlock
    #completewith next
    .deathskip >>在精神疗愈者处死去并重生，或者跑回雷兹拉克
step << !Shaman !Warrior !Warlock
    .goto Durotar,46.4,22.9
    >>返回雷兹拉克
    .turnin 835,2 >>交任务: 保卫商路 << Hunter
    .turnin 835 >>交任务: 保卫商路 << !Hunter
step << Hunter tbc
    .goto Durotar,57.2,12.0
    .tame 3108 >>驯服被包裹的冲浪爬虫(他们的爪等级为3)
step << !Shaman !Warrior
    #sticky
    #completewith next
+去齐柏林塔。带着齐柏林飞艇去幽暗城
    .goto Durotar,50.8,13.8
step << !Shaman !Warrior
.zone Tirisfal Glades >>抵达提里斯福尔
step << !Shaman !Warrior
.goto Undercity,66.2,1.1,18 >>前往幽暗城
step << !Shaman !Warrior
.goto Undercity,62.0,11.3,18 >>在这里上楼梯
step << !Shaman !Warrior
.goto Undercity,54.9,11.3,18 >>使用易位球
step << !Shaman !Warrior
.goto Silvermoon City,62.0,30.1,20 >>抵达银月城
step << Paladin
    #completewith next
    .goto Silvermoon City,91.2,36.9
    .trainer >>去训练你的职业咒语
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 10-13 杜隆塔尔
#version 1
#group RestedXP部落1-30
#defaultfor Warrior !Tauren/Shaman !Tauren
#next 13-23 贫瘠之地
step
    .goto Durotar,50.8,43.6
    .accept 840 >>接任务: 部落的新兵
step << Undead Warrior
    >>爬上塔楼
.goto Durotar,49.9,40.3
    .accept 791 >>接任务: 新的背包
step << Undead Warrior
    .goto Durotar,52.0,40.7
    .money <0.0020
    .train 2018 >>火车铁匠。锻造允许你制造锐化宝石(+2武器伤害，持续1小时)。如果你愿意，可以跳过锻造和采矿
step << Undead Warrior
    .goto Durotar,51.8,40.9
    .money <0.0010
    .train 2580 >>训练采矿。
    .cast 2580 >>在你的魔法书中施放“寻找矿物”
step << Undead Warrior
    .goto Durotar,53.0,42.0
    .money <0.0077
.collect 2901,1 >>购买采矿镐。留意我的静脉，用铁匠技术为你的武器制作磨石
step << Undead Warrior
    .goto Durotar,54.2,42.5
    .accept 1505 >>接任务: 老兵犹塞克
step << Undead Warrior
>>煤仓内，顶层
.goto Durotar,51.9,43.5
.accept 784 >>接任务: 背信弃义的人类
step << Undead Warrior
    #sticky
    #label KulTiras
>>杀死Kul Tiras暴徒。抢走他们的碎片
    .complete 784,1 --Kul Tiras Sailor (10)
    .complete 784,2 --Kul Tiras Marine (8)
    .complete 791,1 --Canvas Scraps (8)
step << Undead Warrior
.goto Durotar,59.2,58.3,15 >>进入要塞
step << Undead Warrior
    .goto Durotar,59.7,58.3
    >>去要塞的顶层。杀死Benedict中尉并抢走他的钥匙-小心他使用盾牌猛击(打断)
.complete 784,3 --Lieutenant Benedict (1)
.collect 4882,1 --Collect Benedict's Key (1)
step << Undead Warrior
.goto Durotar,59.8,57.8,8 >>在这里上楼梯
step << Undead Warrior
.goto Durotar,59.9,57.5,8 >>在这里上楼梯
step << Undead Warrior
>>掠夺胸部。从物品中接受任务
.goto Durotar,59.3,57.6
.collect 4881,1,830 --Collect Aged Envelope (1)
.accept 830 >>接任务: 将军的命令
step << Undead Warrior
    >>跑到森津
.goto Durotar,55.9,74.7
    .accept 808 >>接任务: 明希纳的颅骨
    .accept 826 >>接任务: 扎拉赞恩
    .accept 823 >>接任务: 向奥戈尼尔报告
step << Undead Warrior
    .goto Durotar,67.3,87.1,350 >>游到岛上
step << Undead Warrior
    #sticky
    #completewith Trolls
    >>杀死该地区的巨魔。当巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step << Undead Warrior
    .goto Durotar,67.4,87.8
    >>杀死扎拉扎内。小心，因为他可以治愈(你可能需要治疗药剂)。掠夺他的头
    .complete 826,3 --Zalazane's Head (1)
step << Undead Warrior
    #label Trolls
.goto Durotar,67.4,87.8
    >>在地上掠夺一个头骨
    .complete 808,1 --Minshina's Skull (1)
step << Undead Warrior
>>杀死其余的巨魔。当巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step << Undead Warrior
    #completewith next
    .deathskip >>在精神疗愈者处死去并重生，或者跑回森津村
step << Undead Warrior
    >>保存微弱发光的骷髅供以后使用
.goto Durotar,55.9,74.7
    .turnin 808 >>交任务: 明希纳的颅骨
    .turnin 826 >>交任务: 扎拉赞恩
step << Undead Warrior
    >>跑回Razor Hill
.goto Durotar,52.2,43.2
    .turnin 823 >>交任务: 向奥戈尼尔报告
    .accept 806 >>接任务: 黑暗风暴
step
    #xprate >1.499
    .goto Durotar,48.9,48.5
    >>杀死该地区的Quilboars和Scouts
    .complete 837,1 --Razormane Quilboar (4)
    .complete 837,2 --Razormane Scout (4)
step
    #xprate >1.499
    .goto Durotar,43.8,39.1
    >>杀死该地区的除尘兵和战警。吸尘器有返老还童(治疗)能力，而战队守卫则很虚弱
    .complete 837,3 --Razormane Dustrunner (4)
    .complete 837,4 --Razormane Battleguard (4)
step
    .goto The Barrens,62.2,19.4
    .turnin 840 >>交任务: 部落的新兵
    .accept 842 >>接任务: 十字路口征兵
step
    .goto The Barrens,62.2,19.4
    .zone The Barrens >>前往: 贫瘠之地
step << Warrior
    .goto The Barrens,61.4,21.1
    .turnin 1505 >>交任务: 老兵犹塞克
    .accept 1498 >>接任务: 防御之道
step << Orc Shaman/Troll Shaman
    .goto The Barrens,55.8,20.0
    .turnin 2983 >>交任务: 火焰的召唤
    .accept 1524 >>接任务: 火焰的召唤
step << !Tauren
#xprate <1.5
    .goto The Barrens,52.0,30.5,150 >>跑到十字路口
step << !Tauren
#xprate <1.5
    .goto The Barrens,52.2,31.8
    .accept 870 >>接任务: 遗忘之池
step << !Tauren
#xprate <1.5
    #completewith next
    .goto The Barrens,52.3,32.0
    .vendor >>根据需要购买6个槽袋
step << !Tauren
#xprate <1.5
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交任务: 十字路口征兵
    .accept 844 >>接任务: 平原陆行鸟的威胁
step << Orc/Troll
#xprate <1.5
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接任务: 送往奥格瑞玛的肉
step << !Tauren
#xprate <1.5
    .goto The Barrens,51.9,30.3
    .accept 869 >>接任务: 偷钱的迅猛龙
step << !Tauren
#xprate <1.5
    .goto The Barrens,51.5,30.8
    .accept 871 >>接任务: 野猪人的袭击
    .accept 5041 >>接任务: 十字路口的补给品
step << !Tauren
#xprate <1.5
    .goto The Barrens,51.5,30.4
    .fp >>获取十字路口飞行路线
step << Orc/Troll
#xprate <1.5
    >>不要飞往奥格瑞玛
.goto The Barrens,51.5,30.3
    .turnin 6365 >>交任务: 送往奥格瑞玛的肉
    .accept 6384 >>接任务: 飞往奥格瑞玛
step << !Tauren
#xprate <1.5
.goto The Barrens,51.5,30.1
    .accept 1492 >>接任务: 码头管理员迪兹维格
        .accept 848 >>接任务: 菌类孢子
step << !Tauren
#xprate <1.5
    #sticky
    #completewith next
    >>收集遗忘池周围的白蘑菇。尽量避免暴徒。
.complete 848,1 --Collect Fungal Spores (x4)
step << !Tauren
#xprate <1.5
>>潜水至气泡裂缝
.goto The Barrens,45.1,22.5
    .complete 870,1 --Explore the waters of the Forgotten Pools
step << !Tauren
#xprate <1.5
>>收集遗忘池周围的白蘑菇。尽量避免暴徒。
.goto The Barrens,45.2,23.3,40,0
.goto The Barrens,45.2,22.0,40,0
    .goto The Barrens,44.6,22.5,40,0
    .goto The Barrens,43.9,24.4,40,0
.complete 848,1 --Collect Fungal Spores (x4)
step << !Tauren
#xprate <1.5
    #completewith next
    .deathskip >>在精神治疗者处死去并重生，或者跑回十字路口
step << !Tauren
#xprate <1.5
    .goto The Barrens,51.5,30.1
    .turnin 848 >>交任务: 菌类孢子
    >>等待角色扮演结束，需要几秒钟的时间。药剂师Zamah是一个定时问答者，如果你在任何时候都必须在打开之前退出，请注销。
    .accept 853 >>接任务: 药剂师扎玛
step << !Tauren
#xprate <1.5
    .goto The Barrens,52.2,31.8
    .turnin 870 >>交任务: 遗忘之池
    .accept 877 >>接任务: 死水绿洲
step << !Tauren
#xprate <1.5
    >>沿着这条路跑
.goto The Barrens,44.4,59.2
    .fp >>获取Taurajo营地飞行路线
step << !Tauren
#xprate <1.5
    .line Mulgore,69.0,60.0,58.4,61.7,51.9,59.3
    .goto Mulgore,51.4,59.2,50,0
    .goto Mulgore,59.6,62.4,50,0
    .goto Mulgore,51.4,59.2,50,0
    .goto Mulgore,59.6,62.4,50,0
        .goto Mulgore,51.4,59.2
    >>任务给予者沿着整条路巡逻
    .unitscan Morin Cloudstalker
    .accept 749 >>接任务: 不幸的商队
step << !Tauren
#xprate <1.5
    .goto Mulgore,48.2,53.4
    .accept 11129 >>接任务: 凯雷失踪了！
step << !Tauren
#xprate <1.5
    .goto Mulgore,53.7,48.1
    >>穿过湖面，然后掠夺商队中间的箱子
    .turnin 749 >>交任务: 不幸的商队
    .accept 751 >>接任务: 不幸的商队
step << !Tauren
#xprate <1.5
    .goto Mulgore,55.5,55.8
    >>为了鲜嫩的漫游者肉杀死一只漫游者
    .collect 33009,1 --Collect Tender Strider Meat (1)
step << !Tauren
#xprate <1.5
    .line Mulgore,51.9,59.3,58.4,61.7,69.0,60.0
    .goto Mulgore,51.4,59.2,50,0
    .goto Mulgore,59.6,62.4,50,0
    .goto Mulgore,51.4,59.2,50,0
    .goto Mulgore,59.6,62.4,50,0
        .goto Mulgore,51.4,59.2
    .unitscan Morin Cloudstalker
    .turnin 751 >>交任务: 不幸的商队
step << !Tauren
#xprate <1.5
    .goto Mulgore,47.3,56.9,30,0
    .goto Mulgore,49.4,63.9,30,0
    .goto Mulgore,50.2,60.2,30,0
    .goto Mulgore,46.8,59.6,30,0
    .use 33009 >>找到法国人凯尔。他顺时针巡视整个城镇(所以逆时针走)。走到他跟前，用嫩步兵肉
    .unitscan Kyle the Frenzied
.complete 11129,1 --Kyle Fed (1)
step << !Tauren
#xprate <1.5
    .goto Mulgore,48.3,53.3
    .turnin 11129 >>交任务: 凯雷失踪了！
step << !Tauren
#xprate <1.5
.goto Thunder Bluff,32.0,66.9,20 >>跑向电梯，进入雷霆崖
step << !Tauren !Paladin
#xprate <1.5
    .goto Thunder Bluff,40.9,62.7
    .train 227 >>火车杆
    .train 199 >>列车2h梅斯
step << Paladin
#xprate <1.5
    .goto Thunder Bluff,40.9,62.7
    .train 199 >>列车2h梅斯
step << !Tauren
#xprate <1.5
.goto Thunder Bluff,45.6,52.0,15 >>爬上塔楼
step << !Tauren
#xprate <1.5
    >>去塔的顶层
.goto Thunder Bluff,46.8,49.9
    .fp >>获得雷霆崖飞行路线
step << !Tauren
#xprate <1.5
.goto Thunder Bluff,29.6,29.7,15 >>跳进洞穴
step << !Tauren
#xprate <1.5
    .goto Thunder Bluff,23.0,21.1
    .turnin 853 >>交任务: 药剂师扎玛
step << !Tauren
#xprate <1.5
    #completewith next
    .hs >>炉底到剃须山
step
    .goto Durotar,43.1,30.3
    .accept 816 >>接任务: 丢失的孩子
step
    .goto Durotar,46.4,22.9
    .accept 834 >>接任务: 沙漠之风
step
    >>掠夺地上的小麻袋
.goto Durotar,51.7,27.7
    .complete 834,1 --Sack of Supplies (5)
step
    .goto Durotar,46.4,22.9
    .turnin 834 >>交任务: 沙漠之风
    .accept 835 >>接任务: 保卫商路
step << wotlk
    .goto Durotar,40.8,16.3
    .accept 812 >>接任务: 救命如救火
step << tbc
    .goto Durotar,41.5,18.6
    .accept 812 >>接任务: 救命如救火
step
.goto Orgrimmar,49.0,94.2,20 >>前往: 奥格瑞玛
step << Orc/Troll
#xprate <1.5
    .goto Orgrimmar,54.2,68.6
    .turnin 6384 >>交任务: 飞往奥格瑞玛
    .accept 6385 >>接任务: 双足飞龙管理员多拉斯
step << Orc/Troll
#xprate <1.5
    .goto Orgrimmar,45.2,64.0
     >>交出任务，但不要飞回十字路口
    .turnin 6385 >>交任务: 双足飞龙管理员多拉斯
    .accept 6386 >>接任务: 返回十字路口
step << Orc/Troll
    .goto Orgrimmar,34.3,36.4
    >>从飞行路线塔穿过大桥
    .turnin 831 >>交任务: 将军的命令
step
    .goto Orgrimmar,31.9,37.7
    .accept 5726 >>接任务: 隐藏的敌人
step << Paladin
    .goto Orgrimmar,32.3,35.7
    .trainer >>去训练你的职业咒语
step
    .goto Orgrimmar,47.2,53.4
    >>头撞到阴影的裂缝
    .accept 813 >>接任务: 寻找解毒剂
step
.goto Orgrimmar,49.0,94.2,20 >>逃离Orgrimmar
step
.goto Durotar,41.7,25.5,30 >>跳进雷霆岭
step
    >>杀死菲兹尔，并为他的爪子掠夺他。设法清除周围营地的暴徒，腾出空间
.goto Durotar,41.9,26.0
    .complete 806,1 --Fizzle's Claw (1)
step << !Warrior
.goto Durotar,39.2,32.3,30 >>离开雷脊
step << Warrior
    .goto Durotar,39.2,32.3
    >>为歌唱的鳞片杀死闪电隐藏。执行此操作时，请按照箭头指向出口。
    .complete 1498,1 --Singed Scale (5)
step << Warrior
    .isQuestComplete 1498
    #sticky
    #completewith next
.goto Durotar,39.2,32.3,30 >>离开雷脊
step
>>开始为护身符杀死鳄鱼
    >>南下时杀了他们。我们接下来要做你的图腾任务 << Troll Shaman/Orc Shaman
    .goto Durotar,35.2,27.5,60,0
    .goto Durotar,35.7,57.8,60,0
    .goto Durotar,35.2,27.5,60,0
    .goto Durotar,35.7,57.8
    .complete 816,1 --Kron's Amulet (1)
step << Troll Shaman/Orc Shaman
.goto Durotar,36.6,58.0,15 >>沿着山路跑
step << Troll Shaman/Orc Shaman
    .goto Durotar,38.6,59.0
    .turnin 1524 >>交任务: 火焰的召唤
    .accept 1525 >>接任务: 火焰的召唤
step
    #completewith next
    .deathskip >>在精神治疗者处死亡并重生，或者跑回剃须刀山
step
.goto Durotar,52.3,43.1
    .turnin 806 >>交任务: 黑暗风暴
    .accept 828 >>接任务: 玛高兹
step << Shaman
    #sticky
    #completewith next
    #level 12
    .trainer >>如果你要和其他人一起玩，就要训练祖先的精神
step << Shaman
    #level 12
    .goto Durotar,54.3,42.4
    .train 547 >>训练治愈波r3
    .train 1535 >>火车火新星图腾
step << Warrior
    #level 12
    .goto Durotar,54.3,42.4
    .train 5242 >>训练战斗呐喊r2
    .train 7384 >>列车功率过大
step << !Warrior
    .goto Durotar,54.4,42.2
.vendor >>从Jark购买6个老虎袋，直到你无法装备新袋子
step
    #xprate >1.499
    .goto Durotar,51.9,43.5
    .turnin 837 >>交任务: 野猪人的进犯
step
    >>从剃刀山往东走，然后笔直向北走
    .goto Durotar,55.6,36.6,80,0
    .goto Durotar,56.4,20.1
    .turnin 828 >>交任务: 玛高兹
    .accept 827 >>接任务: 骷髅石
step
    #sticky
    #completewith next
    >>旅行时杀死蝎子获得毒囊
    .goto Durotar,55.7,15.7
    .complete 813,1 --Venomtail Poison Sac (4)
step
    #sticky
    #label Collars2
   .goto Durotar,51.8,10.0
>>在骷髅岩杀死燃烧之刃暴徒以灼烧项圈，直到中尉徽章掉落
    .complete 827,1 --Searing Collar (6)
    .complete 5726,1 --Lieutenant's Insignia (1)
step << Orc Shaman/Troll Shaman/Orc Warrior/Troll Shaman/Troll Warrior
    .use 4945 >>为了燃烧的阴影之眼杀死加兹乌斯。他可能在洞穴的多个区域。使用你之前保存的微弱发光骷髅，在虚空行者身上涂上粘性胶水以减少你受到的伤害，使用治疗药剂恢复健康。使用LoS(视线)避开他的影子箭。如果死亡意味着杀害和掠夺Gazz'uz，不要害怕死亡
.goto Durotar,51.8,10.0
.collect 4903,1,832 --Collect Eye of Burning Shadow
    .accept 832 >>接任务: 燃影之眼
    .unitscan Gazz'uz
step << Tauren Shaman/Tauren Warrior/Undead Warrior/Paladin
    .use 4945 >>为了燃烧的阴影之眼杀死加兹乌斯。他可能在洞穴的多个区域。如果你有治疗药剂，使用它们来恢复健康。使用LoS(视线)避开他的影子箭。如果死亡意味着杀害和掠夺Gazz'uz，不要害怕死亡
.goto Durotar,51.8,10.0
.collect 4903,1,832 --Collect Eye of Burning Shadow
    .accept 832 >>接任务: 燃影之眼
    .unitscan Gazz'uz
step
    #requires Collars2
    #sticky
    #completewith harpingme
    >>旅行时杀死蝎子获得毒囊
    .goto Durotar,55.7,15.7
    .complete 813,1 --Venomtail Poison Sac (4)
step
.goto Durotar,56.4,20.1
    .turnin 827 >>交任务: 骷髅石
    .accept 829 >>接任务: 尼尔鲁·火刃
step << Shaman
    .isOnQuest 1525
    .goto Durotar,56.3,28.0,60,0
    .goto Durotar,52.8,28.7,20 >>向南走，然后进入这里的洞穴，在竖琴区上方
step << Shaman
    >>为试剂袋杀死燃烧之刃信徒
.goto Durotar,52.5,26.7
    .complete 1525,2 --Reagent Pouch (1)
step << Shaman
    .isOnQuest 1525
    .goto Durotar,52.8,28.7,20 >>离开洞穴
step
    .goto Durotar,54.0,27.7,30,0
    .goto Durotar,51.3,23.5,30,0
    .goto Durotar,51.5,19.1,30,0
    .goto Durotar,54.0,27.7,30,0
    .goto Durotar,51.3,23.5,30,0
    .goto Durotar,51.5,19.1,30,0
    >>杀死该地区的哈比
    .complete 835,1 --Dustwind Savage (12)
    .complete 835,2 --Dustwind Storm Witch (8)
step
    #completewith next
    .deathskip >>在精神疗愈者处死去并重生，或者跑回雷兹拉克
step
    >>返回雷兹拉克
    .goto Durotar,46.4,22.9
    .turnin 835 >>交任务: 保卫商路
step
    >>为了毒囊杀死蝎子
    .goto Durotar,55.7,15.7
    .complete 813,1 --Venomtail Poison Sac (4)
step << Warrior/Rogue
	.goto Orgrimmar,81.2,19.0
	.collect 25873,1 >>从Zendo'jian那里购买一把锋利的飞刀
step
    .goto Orgrimmar,31.8,37.8
    .turnin 5726 >>交任务: 隐藏的敌人
step
    .goto Orgrimmar,47.0,53.4
    .turnin 813 >>交任务: 寻找解毒剂
step
    .goto Orgrimmar,49.4,50.5
    .turnin 829 >>交任务: 尼尔鲁·火刃
    .accept 809 >>接任务: 雅克塞罗斯
step
    .isOnQuest 832
    .goto Orgrimmar,49.4,50.5
    .turnin 832 >>交任务: 燃影之眼
step << tbc
    .goto Durotar,41.6,18.7
    >>即使显示“缺少前置请求”，您仍然可以提交此任务
    .turnin 812 >>交任务: 救命如救火
step << wotlk
    .goto Durotar,40.8,16.3
    >>即使显示“缺少前置请求”，您仍然可以提交此任务
    .turnin 812 >>交任务: 救命如救火
step
    .goto Durotar,43.1,30.3
    .turnin 816 >>交任务: 丢失的孩子
step
    .goto The Barrens,62.3,20.1
    .turnin 809 >>交任务: 雅克塞罗斯
    .accept 924 >>接任务: 恶魔之种
step
    .goto The Barrens,62.3,20.0
    >>掠夺阿克泽洛斯旁边的紫石。这个项目有一个30分钟的计时器，所以一定要快点
    .collect 4986,1
    .turnin 926 >>交任务: 有瑕疵的能量石
step << Warrior
    .goto The Barrens,61.4,21.1
    .turnin 1498 >>交任务: 防御之道
    .accept 1502 >>接任务: 索恩格瑞姆·火眼
]])
