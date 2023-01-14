RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance !Warlock !Hunter
#name 1-6 寒脊山谷
#next 6-11 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome/Dwarf
step << !Gnome !Dwarf
    #sticky
    #completewith next
.goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step
    >>删除您的炉石
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk	
    .accept 179 >>接任务: 矮人的交易
step << Warrior
#sticky
#completewith next
.goto Dun Morogh,28.6,72.2,20,0
+杀死狼群10美分以上的小贩垃圾，然后进入大楼
step << Warrior
.goto Dun Morogh,28.8,69.2,20 >>进入大楼
step << Warrior
    .goto Dun Morogh,28.7,67.7
    .vendor >>供应商垃圾
step << Warrior
    .goto Dun Morogh,28.8,67.2
    .train 6673 >>火车战斗呐喊
step
    >>杀死狼。抢他们的肉
.goto Dun Morogh,28.7,74.8
    .complete 179,1 --Collect Tough Wolf Meat (x8)
step
    .xp 2 >>升级到2
step << Priest/Mage
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商垃圾，修理。购买15杯水。如果你没有足够的钱，就多磨几只狼
    .collect 159,15 --Collect Refreshing Spring Water (x15)
step << Paladin/Warrior
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商垃圾
step << Paladin
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3107 >>接任务: 神圣符文
step << Gnome Warrior
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3112 >>接任务: 简易备忘录
step << Dwarf Warrior
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3106 >>接任务: 简易符文
step << Mage
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3114 >>接任务: 雕文备忘录
step << Priest
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3110 >>接任务: 神圣符文
step << Gnome Rogue
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3113 >>接任务: 密文备忘录
step << Dwarf Rogue
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3109 >>接任务: 密文符文
step << !Dwarf !Gnome
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
step
#xprate <1.5
    .goto Dun Morogh,29.7,71.2
    .accept 170 >>接任务: 新的威胁
step
#xprate <1.5
    #sticky
    #completewith Rockjaw
    >>杀死你看到的普通岩颚巨魔。你可能需要杀死额外的埋葬岩爪巨魔才能重生。
    .complete 170,1 --Kill Rockjaw Trogg (x6)
        >>杀死Burly Rockjaw Troggs
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 233 >>交任务: 寒脊山谷的送信任务
    .accept 183 >>接任务: 猎杀野猪
    .accept 234 >>接任务: 寒脊山谷的送信任务
step
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>交任务: 猎杀野猪
step << Paladin/Mage
.xp 3+860>>提升经验到860+/1400经验
.goto Dun Morogh,23.0,75.0,40,0
.goto Dun Morogh,24.2,72.5,40,0
.goto Dun Morogh,27.7,76.3,40,0
.goto Dun Morogh,23.0,75.0,40,0
.goto Dun Morogh,24.2,72.5,40,0
.goto Dun Morogh,27.7,76.3,40,0
step
#label Rockjaw
.goto Dun Morogh,25.1,75.7
    .turnin 234 >>交任务: 寒脊山谷的送信任务
    .accept 182 >>接任务: 巨魔洞穴
step << Paladin/Mage
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >>接任务: 热酒快递
>>一旦接受，将启动5分钟计时器。放松并遵循指南
step << Paladin/Mage
#xprate <1.5
    .goto Dun Morogh,28.7,77.5
    >>如果你现在还没有处理完Troggs，就上去杀了他们
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step << Paladin/Mage
    #sticky
    #completewith Scalding1
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >>接任务: 热酒快递
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
step << Paladin/Mage
    #label Scalding1
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
    .accept 3365 >>接任务: 归还酒杯
    .vendor >>供应商垃圾
step << Dwarf Paladin
    .goto Dun Morogh,28.8,68.3
    .turnin 3107 >>交任务: 神圣符文
    .train 20271 >>训练判断
.train 19740 >>火车祝福力量
.train 465 >>训练奉献光环
step << Human Paladin/Draenei Paladin
    .goto Dun Morogh,28.8,68.3
    .train 20271 >>训练判断
.train 19740 >>火车祝福力量
.train 465 >>训练奉献光环
step << Gnome Mage
    .goto Dun Morogh,28.7,66.4
    .turnin 3114 >>交任务: 雕文备忘录
    .train 1459 >>训练奥术智能
    .train 116 >>列车防冻螺栓
step << Human Mage/Draenei Mage
    .goto Dun Morogh,28.7,66.4
    .train 1459 >>训练奥术智能
    .train 116 >>列车防冻螺栓
step << Paladin/Mage
#xprate <1.5
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >>交任务: 新的威胁
step << Mage
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商，购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << !Paladin !Mage
#xprate <1.5
    #sticky
    #label TrollTroggs
>>在玩巨魔的时候，杀死你在附近看到的任何岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step << Paladin/Mage
    .goto Dun Morogh,26.3,79.2,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
>>杀死霜鬃巨魔幼崽
.complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
>>杀死霜鬃巨魔幼崽
.complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage
    .goto Dun Morogh,25.0,76.0
    .abandon 3364 >>放弃烫发晨报-你还不需要它
step << !Paladin !Mage
    .xp 4 >>升级到4
step << !Paladin !Mage
    #requires TrollTroggs
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >>交任务: 巨魔洞穴
    .accept 218 >>接任务: 被窃取的日记
step << Paladin/Mage
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >>交任务: 巨魔洞穴
    .accept 218 >>接任务: 被窃取的日记
step << !Paladin !Mage
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >>接任务: 热酒快递
    >>你现在有500万美元要拿到《华尔街日报》，然后交上《晨报》。如果你的任务失败了，死后再捡起来
step << Paladin/Mage
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >>交任务: 归还酒杯
step
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
.goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step << !Paladin !Mage
    .goto Dun Morogh,29.5,69.8,100 >>在精神治疗者处死亡并重生
step << !Paladin !Mage
#sticky
#completewith Scalding2
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >>接任务: 热酒快递
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
step << !Paladin !Mage
    #label Scalding2
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
    .accept 3365 >>接任务: 归还酒杯
    .vendor >>供应商垃圾
step << Gnome Rogue
.goto Dun Morogh,28.4,67.5
    .turnin 3113 >>交任务: 密文备忘录
step << Dwarf Rogue
.goto Dun Morogh,28.4,67.5
    .turnin 3109 >>交任务: 密文符文
step << Dwarf Priest
.goto Dun Morogh,28.6,66.4
    .turnin 3110 >>交任务: 神圣符文
    .train 1243 >>列车动力词：坚韧
.train 589 >>训练暗语：痛苦
    .train 2052 >>训练Lesser Heal r2
step << Human Priest/NightElf Priest/Draenei Priest
.goto Dun Morogh,28.6,66.4
    .train 1243 >>列车动力词：坚韧
.train 589 >>训练暗语：痛苦
    .train 2052 >>训练Lesser Heal r2
step << Gnome Warrior
.goto Dun Morogh,28.8,67.2
    .turnin 3112 >>交任务: 简易备忘录
    .train 772 >>列车Rend
    .train 100 >>列车收费
step << Dwarf Warrior
.goto Dun Morogh,28.8,67.2
    .turnin 3106 >>交任务: 简易符文
    .train 772 >>列车Rend
    .train 100 >>列车收费
step << Human Warrior/NightElf Warrior/Draenei Warrior
.goto Dun Morogh,28.8,67.2
    .train 772 >>列车Rend
    .train 100 >>列车收费
step << !Paladin !Mage
#xprate <1.5
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >>交任务: 新的威胁
step << Priest
.money <0.0024
.goto Dun Morogh,30.0,71.5
    .vendor >>买5杯水
    .collect 159,5 --Collect Refreshing Spring Water (x5)
step
    >>磨碎一点回到这里
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >>交任务: 被窃取的日记
    .accept 282 >>接任务: 森内尔的观察站
step << !Paladin !Mage
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >>交任务: 归还酒杯
step
    >>把一些暴徒赶到这里
.goto Dun Morogh,33.5,71.8
    .turnin 282 >>交任务: 森内尔的观察站
    .accept 420 >>接任务: 森内尔的观察站
step
    .goto Dun Morogh,33.9,72.2
    .accept 2160 >>接任务: 塔诺克的补给品
step
.goto Dun Morogh,34.1,71.6,20,0
.goto Dun Morogh,35.7,66.0,20 >>穿过隧道
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance !Warlock !Hunter
#name 6-11 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome/Dwarf
#next 11-14 黑海岸
step
    #sticky
#completewith BoarMeat3
>>杀死野猪，为稍后获取野猪肉
.collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    #sticky
#completewith BoarRibs
>>杀死野猪，获取野猪肋骨供日后使用
.collect 2886,6 --Collect Crag Boar Rib (x6)
step << Dwarf Priest
>>磨碎东北至哈拉诺斯的野猪
.goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2145>>提升经验到2145/+2800xp
step << !Dwarf/!Priest
>>将野猪磨碎，东北至哈拉诺斯
.goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2415>>提升经验到2415/+2800xp
step
    .goto Dun Morogh,47.0,55.1,75 >>在精神疗愈者处死亡并重生，或者跑向哈拉诺斯。确保你的分区不是Coldridge Pass
step
    #label BoarMeat3
.goto Dun Morogh,47.0,55.1,1500 >>.
step
    #label BoarRibs
.goto Dun Morogh,47.0,55.1,1500 >>.
step
.goto Dun Morogh,46.7,53.8
    .turnin 420 >>交任务: 森内尔的观察站
step
    .goto Dun Morogh,46.7,53.5
    .vendor >>供应商垃圾
step << !Priest
    .goto Dun Morogh,48.3,57.0
.xp 6 >>升级到6
step << !Priest
    .goto Dun Morogh,46.8,52.4
    .accept 384 >>接任务: 啤酒烤猪排
step << !Priest
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >>交任务: 塔诺克的补给品
step << Rogue
.goto Dun Morogh,47.2,52.4
    .money <0.0028
    .vendor >>去克雷格·比尔姆，购买并装备3级投掷武器，花费28美分
step << Rogue
.goto Dun Morogh,47.6,52.6
    .train 1757 >>训练邪恶打击r2
    .train 1776 >>火车凿槽
step << Mage
    .goto Dun Morogh,47.5,52.1
    .train 143 >>训练火球r2
    .train 2136 >>列车防火爆炸
step << Paladin
    .goto Dun Morogh,47.6,52.1
    .train 639 >>训练圣光r2
    .train 498 >>训练神圣保护
step << Dwarf Priest
.goto Dun Morogh,47.3,52.2
    .accept 5625 >>接任务: 圣光之衣
step << Dwarf Priest
    .goto Dun Morogh,45.8,54.6
     .complete 5625,1 --Heal and fortify Mountaineer Dolf
step << Dwarf Priest
.goto Dun Morogh,47.3,52.2
    .turnin 5625 >>接任务: 圣光之衣
    .train 591 >>火车Smite r2
    .train 17 >>列车动力字：盾牌
    .train 2052 >>训练Lesser Heal r2
step << !Dwarf Priest
.goto Dun Morogh,47.3,52.2
    .train 591 >>火车Smite r2
    .train 17 >>列车动力字：盾牌
    .train 2052 >>训练Lesser Heal r2
step << Priest
    .xp 6 >>升级到6
step << Priest/Mage/Shaman/Druid
    .goto Dun Morogh,47.4,52.5
    .home >>将您的炉石设置为Thunderbrew酒厂
    .vendor >>尽可能多地购买5级饮料
step << !Mage !Priest
    .goto Dun Morogh,47.4,52.5
    .home >>将您的炉石设置为Thunderbrew酒厂
    .vendor >>供应商垃圾
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .train 3127 >>列车招架
step << Paladin/Warrior/Shaman/Druid
    .goto Dun Morogh,45.8,51.8,20 >>进入大楼
step << Gnome Warrior/Human Warrior/NightElf Warrior
    .goto Dun Morogh,45.3,52.2
.vendor >>供应商垃圾箱。如果能给你足够的钱买格拉迪斯(5s9c)，就卖掉你的武器。如果你还不够，你会回来的
step << Gnome Warrior/Human Warrior/NightElf Warrior
    .goto Dun Morogh,45.3,52.2
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
.vendor >>供应商垃圾箱。如果你的武器有足够的钱买大斧(4s60c)，就卖掉它。如果你还不够，你会回来的
step << Dwarf Warrior
    .money <0.0460
    .goto Dun Morogh,45.3,52.2
    >>购买大斧子并装备
    .collect 2491,1 --Collect Large Axe
step << Paladin
    .goto Dun Morogh,45.3,52.2
.vendor >>供应商垃圾箱。如果能给你足够的钱买木槌，就卖掉你的武器(6s66c)。如果你还不够，你会回来的
step << Paladin
    .money <0.0666
    .goto Dun Morogh,45.3,52.2
    >>购买木槌并装备
    .collect 2493,1 --Collect Wooden Mallet
.goto Durotar,56.5,73.1
step << Druid/Shaman
.vendor >>供应商垃圾箱。如果你有足够的钱买手杖(5s4c)，就卖掉你的武器。如果你还不够，你会回来的
step << Druid/Shaman
    .goto Durotar,56.5,73.1
    .money <0.0504
    >>购买手杖并装备
    .collect 2495,1 --Collect Walking Stick
step << Warrior/Rogue
    .goto Dun Morogh,45.3,51.9
    .train 2018 >>火车铁匠。你将在稍后进行采矿，这将允许你制造磨砺之石(+2武器伤害，持续1小时)。你应该在20级左右停止做这些。
step << Paladin
    .goto Dun Morogh,45.3,51.9
    .train 2018 >>火车铁匠。稍后你将获得采矿，这将允许你制造重石(+2武器伤害，持续1小时)。你应该在20级左右停止做这些。
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >>接任务: 贝尔丁的工具
step
    #sticky
#completewith next
>>杀死野猪，为稍后获取野猪肉
.collect 769,4 --Collect Chunk of Boar Meat (x4)
step
.goto Dun Morogh,49.4,48.4
    >>不要在途中杀死熊
    .accept 317 >>接任务: 贝尔丁的补给
step
#xprate <1.5
    .goto Dun Morogh,49.6,48.6
    .accept 313 >>接任务: 灰色洞穴
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >>交任务: 贝尔丁的工具
step
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >>接任务: 海格纳的弹药
step << Warrior/Paladin/Rogue
.money <0.0087
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >>购买采矿镐
step << Warrior/Paladin/Rogue
.money <0.0010
    .goto Dun Morogh,50.2,50.4
.train 2580 >>进屋去。训练采矿，铸造寻找矿物
step
    #sticky
#completewith BoarRibs2
>>杀死野猪以获得野猪肋骨
.collect 2886,6 --Collect Crag Boar Rib (x6)
step << Paladin/Warrior/Rogue
    #sticky
    #completewith BoarMeat
>>获取野猪肉，以便在您请求时储存喷气式蒸汽机
.complete 317,1 --Collect Chunk of Boar Meat (x4)
step << Paladin/Warrior/Rogue
    #sticky
    #completewith BearFur
    >>获取熊皮毛，以便在您的任务中为喷气式飞机提供库存
.complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
.complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >>交任务: 贝尔丁的补给
    .accept 318 >>接任务: 艾沃沙酒
step << Warrior
    .goto Dun Morogh,46.9,52.1,20,0
.goto Dun Morogh,47.4,52.5
    .vendor >>尽可能多地购买5级食物
step << Priest/Mage/Shaman/Druid
    .goto Dun Morogh,46.9,52.1,20,0
.goto Dun Morogh,47.4,52.5
    .vendor >>买尽可能多的5级饮料。
step << !Paladin !Warrior !Rogue
#xprate <1.5
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    >>到洞里去。杀死Wendigos。掠夺他们的鬃毛
    >>留意纹理，以获得磨快武器所需的粗糙石头/加重石头 << Paladin/Warrior/Rogue
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    >>掠夺板条箱
.goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Collect Rumbleshot's Ammo (x1)
step
    #label BearFur
.goto Dun Morogh,40.6,62.6,30,0
.goto Dun Morogh,40.7,65.1
    .turnin 5541 >>交任务: 海格纳的弹药
    .vendor >>供应商和维修
step
    #label BoarMeat
step << !Paladin !Warrior !Rogue
    .xp 7 >>升级到7
step << Paladin/Warrior/Rogue
    .goto Dun Morogh,42.5,66.3,40,0
    .goto Dun Morogh,45.1,65.4,40,0
    .goto Dun Morogh,49.4,62.3,40,0
    .goto Dun Morogh,50.8,59.3,40,0
    .goto Dun Morogh,48.0,59.2,40,0
    .goto Dun Morogh,48.2,55.6,40,0
    .goto Dun Morogh,51.4,50.4,40,0
    .goto Dun Morogh,42.5,66.3,40,0
    .goto Dun Morogh,45.1,65.4,40,0
    .goto Dun Morogh,49.4,62.3,40,0
    .goto Dun Morogh,50.8,59.3,40,0
    .goto Dun Morogh,48.0,59.2,40,0
    .goto Dun Morogh,48.2,55.6,40,0
    .goto Dun Morogh,51.4,50.4,40,0
    >>杀死熊和野猪。抢他们的皮毛和肉
    .complete 317,2 --Collect Thick Bear Fur (x2)
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >>交任务: 贝尔丁的补给
    .accept 318 >>接任务: 艾沃沙酒
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >>购买采矿镐
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.2,50.4
.train 2580 >>进屋去。训练采矿，铸造寻找矿物
step << Warrior/Paladin/Rogue
    .isOnQuest 313
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >>交任务: 灰色洞穴
step << Warrior/Paladin/Rogue
    .xp 7 >>升级到7
step << Gnome Warrior/Human Warrior/NightElf Warrior
    .goto Dun Morogh,45.3,52.2
    .money <0.0509
    >>购买Gladius并装备它
    .collect 2488,1 --Collect Gladius
step << Dwarf Warrior
    .money <0.0460
    .goto Dun Morogh,45.3,52.2
    >>购买大斧子并装备
    .collect 2491,1 --Collect Large Axe
step << Paladin
    .money <0.0666
    .goto Dun Morogh,45.3,52.2
    .vendor >>购买木槌并装备
    .collect 2493,1 --Collect Wooden Mallet
step << Paladin/Warrior/Rogue
    .goto Dun Morogh,47.4,52.5
    .vendor >>买尽可能多的五级食物。
step << Paladin/Warrior/Rogue
    >>在途中碾碎一些暴徒
.goto Dun Morogh,43.0,47.4,50,0
    .goto Dun Morogh,39.6,48.9,50,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >>接任务: 马克格拉恩的干肉
step << !Paladin !Warrior !Rogue
>>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,50,0
    .goto Dun Morogh,36.0,52.0,50,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >>接任务: 马克格拉恩的干肉
step << !Mage !Priest
.goto Dun Morogh,30.5,46.0
    .vendor >>供应商垃圾
step << Priest/Mage/Shaman/Druid
.goto Dun Morogh,30.5,46.0
    .vendor >>小贩购买10杯5级饮料
step
.goto Dun Morogh,30.2,45.8
    .turnin 318 >>交任务: 艾沃沙酒
    .accept 319 >>接任务: 艾沃沙酒
    .accept 315 >>接任务: 完美烈酒
step
    .goto Dun Morogh,30.2,45.5
    .accept 310 >>接任务: 针锋相对
step
#label BoarRibs2
.goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
.goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
    >>杀死熊、野猪和豹子
.complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
>>完成野猪肋
.complete 384,1 --Collect Crag Boar Rib (x6)
step
.goto Dun Morogh,30.2,45.7
    .turnin 319 >>交任务: 艾沃沙酒
    .accept 320 >>接任务: 艾沃沙酒
step
.xp 7+3735>>提升经验到3735+/4500xp
.goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
.goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
step
    .goto Dun Morogh,30.3,37.5,50 >>跑到这里
step
    .isQuestTurnedIn 384
    .xp 7+4360>>提升经验到4360+/4500xp，然后转到此处
    .goto Dun Morogh,30.3,37.5,50
step
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
.goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
.deathskip >>继续向北奔跑，摔倒死亡，然后重生
step
.goto Wetlands,12.7,46.7,30 >>游到岸上
step
.goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
step
    #completewith next
.hs >>赫斯到哈拉诺斯
step
.goto Dun Morogh,47.4,52.5
>>从Belm购买狂想曲麦芽和雷霆啤酒
    .complete 384,2 --Collect Rhapsody Malt (x1)
    .collect 2686,1 --Collect Thunder Ale (x1)
step
    .isOnQuest 310
    .goto Dun Morogh,47.6,52.4,10 >>进客栈老板后面的房间
step
    >>下楼去，然后和贾文谈谈，给他雷霆啤酒
    >>等待木桶鼠标移到“无人看守”位置，然后handin
    .turnin 310 >>交任务: 针锋相对
    .accept 311 >>接任务: 向马莱斯回报
step
.goto Dun Morogh,46.8,52.4
    .turnin 384 >>交任务: 啤酒烤猪排
     >>当你下一个供应商时出售配方
step
    .xp 8 >>升级到8
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .train 6760 >>训练剔骨r2
    .train 5277 >>列车逃逸
step << Mage
    .goto Dun Morogh,47.5,52.1
    .train 205 >>列车防冻螺栓r2
.train 118 >>训练变形
step << Paladin
    .train 853 >>训练正义之锤
    .train 1152 >>列车净化
    .train 3127 >>列车招架
step << Priest
    .goto Dun Morogh,47.3,52.2
    .train 139 >>列车更新
step << Warrior
.goto Dun Morogh,47.4,52.6
    .train 284 >>训练英雄打击r2
    .train 1715 >>训练腿筋
step << Warrior/Rogue/Paladin tbc
    .istrained 3273
.money <0.0095
    .goto Dun Morogh,47.2,52.6
    .train 3273 >>培训急救
step << Paladin
    .goto Dun Morogh,45.3,52.2
    .vendor >>购买木制锤子。如果你需要钱的话，卖包(如果你找到了)。或者武器，如果你能买的话。
    .collect 2493,1 --Collect Wooden Mallet
step << Paladin/Warrior/Rogue
.goto Dun Morogh,47.4,52.5
    .vendor >>尽可能多地从客栈老板那里购买5级食物
step << Priest/Mage/Shaman/Druid
.goto Dun Morogh,47.4,52.5
    .vendor >>尽可能多地向客栈老板购买5级饮料
step
    .goto Dun Morogh,46.7,53.8
    .accept 287 >>接任务: 霜鬃巨魔要塞
step
#xprate <1.5
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >>交任务: 灰色洞穴
step << !Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 320 >>交任务: 艾沃沙酒
step << Rogue
    .goto Dun Morogh,49.4,48.4
    >>选择野营刀。保存以备以后使用
    .turnin 320 >>交任务: 艾沃沙酒
step
#xprate <1.5
    .goto Dun Morogh,45.8,49.4
    .accept 412 >>接任务: 自动净化装置
step
.goto Dun Morogh,43.1,45.0,20,0
.goto Dun Morogh,42.1,45.4,20 >>跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,30,0
    .goto Dun Morogh,41.5,43.6,30,0
    .goto Dun Morogh,39.7,40.0,30,0
    .goto Dun Morogh,42.1,34.3,30,0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线(LoS)在小屋后面。如果你运气不好，就跑到另一个地方去
    .complete 315,1 --Collect Shimmerweed (x6)
step
.goto Dun Morogh,38.4,49.9,40 >>跑向老冰胡子
step << !Mage
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>单击此处
    .complete 312,1 --MacGrann's Dried Meats (1)
step << Mage
    >>变形老冰胡子，然后洗劫肉
.goto Dun Morogh,38.5,53.9
    .complete 312,1 --Collect MacGrann's Dried Meats (x1)
step
    .goto Dun Morogh,34.6,51.7
    .turnin 312 >>交任务: 马克格拉恩的干肉
step << Mage/Priest/Druid/Shaman
.goto Dun Morogh,30.4,45.8
.vendor >>尽可能多地购买5级饮料
step << Warrior/Paladin/Rogue
.goto Dun Morogh,30.4,45.8
.vendor >>供应商垃圾
step
    .goto Dun Morogh,30.2,45.7
    .turnin 315 >>交任务: 完美烈酒
    .accept 413 >>接任务: 微光酒
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交任务: 向马莱斯回报
step
#xprate <1.5
    .goto Dun Morogh,27.2,43.0,40,0
    .goto Dun Morogh,24.8,39.3,40,0
    .goto Dun Morogh,25.6,43.4,40,0
    .goto Dun Morogh,24.3,44.0,40,0
    .goto Dun Morogh,25.4,45.4,40,0
    >>杀死麻风侏儒。掠夺他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step
    .isOnQuest 287
    .goto Dun Morogh,24.5,50.8,30 >>进入洞穴
step
    .goto Dun Morogh,22.1,50.3,40,0
    .goto Dun Morogh,21.3,52.9,40,0
    >>杀死洞穴内的猎头
    .complete 287,1 --Kill Frostmane Headhunter (x5)
    step
    .goto Dun Morogh,23.4,51.5,15 >>返回洞穴
step
    >>往下跳
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    .goto Dun Morogh,23.0,52.2
    .xp 9 >>升级到9级
step
    .isOnQuest 287
    .goto Dun Morogh,46.7,53.8
.deathskip >>在精神治疗师处死亡并重生
step
    .goto Dun Morogh,46.7,53.8
    .turnin 287 >>交任务: 霜鬃巨魔要塞
    .accept 291 >>接任务: 森内尔的报告
step
#xprate <1.5
    .goto Dun Morogh,45.8,49.4
    .turnin 412 >>交任务: 自动净化装置
step << Warrior tbc
    #sticky
    #completewith next
.money >0.0950
    +开始研磨，直到你有9s50c的可售物品，然后跑进铁炉堡
step << Warrior tbc
    .goto Dun Morogh,53.5,34.9,30 >>跑进铁炉堡
step << Warrior tbc
.goto Ironforge,61.2,89.5
    .train 199 >>列车2h梅斯
step << Warrior tbc
    #sticky
    #completewith next
.goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
step
    .goto Dun Morogh,60.1,52.6,50,0
.goto Dun Morogh,63.1,49.8
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,12,0
    .goto Dun Morogh,62.2,49.4,8 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
.goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (x)
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    >>途中磨碎一点
.goto Dun Morogh,68.6,54.7
    .vendor >>供应商垃圾
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step
.goto Dun Morogh,70.6,56.6,30,0
.goto Dun Morogh,70.8,53.3,30,0
.goto Dun Morogh,71.9,50.7,30,0
.goto Dun Morogh,72.9,53.1,30,0
.goto Dun Morogh,70.6,56.6,30,0
.goto Dun Morogh,70.8,53.3,30,0
.goto Dun Morogh,71.9,50.7,30,0
.goto Dun Morogh,72.9,53.1,30,0
    >>在山洞里杀死Troggs
.complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step
.goto Dun Morogh,67.1,59.7,40,0
.goto Dun Morogh,70.7,58.2,40,0
.goto Dun Morogh,71.0,53.9,40,0
.xp 10 >>在拖架上升级到10
step << !Warrior !Rogue
    .goto Dun Morogh,68.4,54.5
    .vendor >>购买x10等级5食物和饮料
step << Warrior/Rogue
    .goto Dun Morogh,68.4,54.5
    .vendor >>购买x10 5级食物
step << Priest tbc/Rogue tbc
    .goto Dun Morogh,47.1,55.1,60 >>在精神治疗者处死亡并重生，或者逃跑
step << Priest tbc
    #sticky
#completewith next
.goto Dun Morogh,47.3,52.2
    .train 2006 >>如果你要和其他玩家一起玩，训练复活
step << !NightElf !Draenei Priest tbc
    .goto Dun Morogh,47.3,52.2
    .accept 5636 >>接任务: 绝望祷言
    .train 2053 >>训练Lesser Heal r3
    .train 8092 >>训练心灵冲击
.train 594 >>训练暗语：痛苦r2
    .train 13908 >>训练绝望祈祷
step << !NightElf !Draenei Priest tbc
    .goto Dun Morogh,47.3,52.2
    .train 2053 >>训练Lesser Heal r3
    .train 8092 >>训练心灵冲击
.train 594 >>训练暗语：痛苦r2
step << Rogue tbc
    .goto Dun Morogh,47.6,52.5
    .accept 2218 >>接任务: 救赎之路
    .train 2983 >>火车冲刺
    .train 674 >>训练双Wield
    .train 6770 >>训练Sap
    .train 1784 >>列车隐身
    >>装备野营刀
step
    .goto Dun Morogh,81.2,42.7,15 >>在路上磨磨蹭蹭，到隧道里去
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>途中研磨
.goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
.goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >>交任务: 驾驶员的复仇
step
    .isOnQuest 413
    .goto Dun Morogh,81.2,42.7,15 >>穿过隧道往回走
step
    .goto Dun Morogh,79.6,50.7,50,0
.goto Dun Morogh,82.3,53.5,25,0
    .goto Dun Morogh,86.3,48.8
    .turnin -413 >>交任务: 微光酒
step
    .isQuestTurnedIn 413
    .goto Dun Morogh,86.3,48.8
    .accept 414 >>接任务: 卡德雷尔的酒
step
    .isOnQuest 414
.goto Dun Morogh,86.2,51.3,20 >>穿过隧道
step << Mage/Rogue
    .goto Loch Modan,22.1,73.1
    .accept 224 >>接任务: 保卫国王的领土
step << Mage/Rogue
    .goto Loch Modan,22.6,75.4,30,0
.goto Loch Modan,23.2,73.7
    >>进入沙坑
    .accept 267 >>接任务: 穴居人的威胁
step << Mage/Rogue
    .goto Loch Modan,30.0,68.4,30,0
    .goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    .goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    .goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step << Mage/Rogue
    .goto Loch Modan,29.9,68.2,30,0
    .goto Loch Modan,22.2,73.3
    .turnin 224 >>交任务: 保卫国王的领土
step << Mage/Rogue
    .goto Loch Modan,23.2,73.7
    .turnin 267 >>交任务: 穴居人的威胁
step
    #completewith next
    .goto Loch Modan,35.3,46.9,150 >>跑向塞尔斯马尔
step << Mage
    .goto Loch Modan,35.5,48.4
    .vendor >>购买40个5级牛奶
step << Mage
#xprate <1.5
    .goto Loch Modan,34.8,49.3
    .accept 418 >>接任务: 塞尔萨玛血肠
step << Rogue tbc
    .goto Loch Modan,35.5,48.4
    .home >>把你的炉石放在塞尔萨马尔
step << Mage
    .goto Loch Modan,34.8,48.6
    .vendor >>最多购买3个6槽袋
step << !Mage/wotlk
#xprate >1.499 << Mage
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    >>找到卡德雷尔，他在大路上巡逻
    .turnin 414 >>交任务: 卡德雷尔的酒
    .accept 1339 >>接任务: 巡山人卡尔·雷矛的任务 << wotlk/Rogue
step << Mage
#xprate <1.5
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    >>找到卡德雷尔，他在大路上巡逻
    .turnin 414 >>交任务: 卡德雷尔的酒
    .accept 416 >>接任务: 狗头人的耳朵
    .accept 1339 >>接任务: 巡山人卡尔·雷矛的任务
    --Mage needs 12 for r3 fireball
step << Gnome/Dwarf
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
.goto Loch Modan,37.0,47.8
    .accept 6387 >>接任务: 荣誉学员
step << Mage
#xprate <1.5
    #sticky
    #completewith ThelsamarFood
    >>杀死蜘蛛。为蜘蛛Ichor抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step << Mage
#xprate <1.5
    #sticky
    #completewith ThelsamarFood
    >>杀死熊。抢他们的熊肉
    .complete 418,2 --Collect Bear Meat (x3)
step << Mage
#xprate <1.5
    #sticky
    #completewith ThelsamarFood
    >>杀死野猪。为了猪的肠道杀死它们
    .complete 418,1 --Collect Boar Intestines (x3)
step << Mage
#xprate <1.5
    #label ThelsamarFood
    .goto Loch Modan,23.3,17.9,30 >>跑到北边的沙坑。途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step << Rogue
#xprate <1.5
.goto Loch Modan,23.3,17.9,30 >>跑到北边的沙坑
step << Rogue/Mage
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商垃圾，修理
step << Mage
#xprate <1.5
    >>楼上的
    .goto Loch Modan,24.7,18.3
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
    .accept 307 >>接任务: 肮脏的爪子
step << Rogue/wotlk
#xprate >1.499 << Mage
    >>楼上的
    .goto Loch Modan,24.7,18.3
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
    .accept 1338 >>接任务: 卡尔·雷矛的订单
step << Mage
#xprate <1.5
    #completewith next
    .goto Loch Modan,35.5,18.2,40 >>去洞口杀老鼠
step << Mage
#xprate <1.5
.goto Loch Modan,35.5,19.9,12,0
.goto Loch Modan,36.4,20.7,12,0
.goto Loch Modan,35.3,22.0,12,0
.goto Loch Modan,35.9,22.1,12,0
.goto Loch Modan,36.3,24.7,12,0
.goto Loch Modan,35.7,24.3,12,0
.goto Loch Modan,34.9,24.9,12,0
.goto Loch Modan,35.7,24.3,12,0
.goto Loch Modan,36.3,24.7,12,0
.goto Loch Modan,35.9,22.1,12,0
.goto Loch Modan,35.3,22.0,12,0
.goto Loch Modan,36.4,20.7,12,0
.goto Loch Modan,35.5,19.9,12,0
    >>收集你在山洞里找到的板条箱。小心，因为这在11级很难做到，而且风水师会火焰防护(防火)
    .complete 307,1 --Collect Miners' Gear (x4)
step << Mage
#xprate <1.5
    #label Kobolds
    >>杀死科波德斯。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
step << Mage
#xprate <1.5
    #sticky
    #completewith Thelsamar3
    >>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
    .complete 418,3 --Collect Spider Ichor (x3)
step << Mage
#xprate <1.5
    #sticky
    #completewith Thelsamar3
    >>在Thelsamar鲜血香肠区杀死熊
    .complete 418,2 --Collect Bear Meat (x3)
step << Mage
#xprate <1.5
    #sticky
    #completewith Thelsamar3
    >>在赛尔萨马尔血肠区杀死野猪
    .complete 418,1 --Collect Boar Intestines (x3)
step << Mage
#xprate <1.5
    #label Thelsamar3
    .goto Loch Modan,23.3,17.9,40 >>跑回沙坑，途中碾磨
step << Mage
#xprate <1.5
    .goto Loch Modan,24.7,18.3
    .turnin 307 >>交任务: 肮脏的爪子
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
    .accept 1338 >>接任务: 卡尔·雷矛的订单 << wotlk
step << Mage
#xprate <1.5
    #sticky
    #label Meat9
    .goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
    .goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
.goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Collect Bear Meat (x3)
step << Mage
#xprate <1.5
    #sticky
    #label Ichor9
    .goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
    .goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
    .goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step << Mage
#xprate <1.5
    #sticky
    #label Intestines9
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
    .goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Collect Boar Intestines (x3)
step << Mage
#xprate <1.5
    #requires Meat9
    .zone Loch Modan >>.
step << Mage
#xprate <1.5
    #requires Ichor9
    .zone Loch Modan >>.
step << Mage
#xprate <1.5
    #requires Intestines9
    .zone Loch Modan >>.
step << Mage
#xprate <1.5
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    >>找到卡德雷尔，他在大路上巡逻
    .goto Loch Modan,36.9,46.1
    .turnin 416 >>交任务: 狗头人的耳朵
step << Mage
#xprate <1.5
    .goto Loch Modan,34.8,49.3
    .turnin 418 >>交任务: 塞尔萨玛血肠
step << Mage
    .xp 12-420 <<tbc
    .xp 12-2310 << wotlk
step << Rogue/wotlk
    #xprate >1.499 << Mage
    .deathskip >>在塞尔萨马尔死亡并重生
step << Rogue
#xprate <1.5
    #sticky
    #completewith next
    +磨碎暴徒，直到你至少有33银币和可售物品
step << Gnome/Dwarf
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
    .turnin 6387 >>交任务: 荣誉学员
    .accept 6391 >>接任务: 飞往铁炉堡
    .fly Ironforge >>飞往铁炉堡
step << !Gnome !Dwarf
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
    .fly Ironforge >>飞往铁炉堡
step << Gnome/Dwarf
    .goto Ironforge,51.5,26.3
    .turnin 6391 >>交任务: 飞往铁炉堡
    .accept 6388 >>接任务: 格莱斯·瑟登
step << Dwarf/Gnome
    >>不要在任何地方飞行
.goto Ironforge,55.5,47.8
    .turnin 6388 >>交任务: 格莱斯·瑟登
    .accept 6392 >>接任务: 向布洛克回复 << Rogue tbc
step << Paladin
    .goto Ironforge,23.1,6.1
    .trainer >>访问您的培训师并训练咒语
step << Mage
    .goto Ironforge,27.2,8.6
    .train 145 >>训练火球r3
    .train 604 >>列车阻尼魔法
    .train 7300 >>训练霜甲r2
    .train 122 >>训练Frost Nova
    .train 5504 >>火车魔法水r1
    .train 5505 >>Train Conjure Water第2集
step
    .goto Ironforge,39.5,57.5
    .turnin 291 >>交任务: 森内尔的报告
step << Warrior/Rogue
    .goto Ironforge,62.0,88.8
    .collect 25873,1 >>从Brenwyn Wintersteel购买一把锋利的飞刀。装备它。
step << Warrior
    #sticky
    .goto Ironforge,65.9,88.4
    .train 2687 >>训练血腥
    .train 6546 >>列车Rend r2
step << Warrior
    .goto Ironforge,70.9,89.9
    >>与Muren Stormpike交谈
    .accept 1678 >>接任务: 维吉雷克
step << Warrior
    >>返回Dun Morogh
    .goto Dun Morogh,27.8,58.0
    .complete 1678,1 --Vejrek's Head (1)
step << Warrior
    .goto Ironforge,70.8,90.2
    .turnin 1678 >>交任务: 维吉雷克
    .accept 1680 >>接任务: 托姆斯·深炉
step << Warrior
    .goto Ironforge,48.7,42.7
    .turnin 1680 >>交任务: 托姆斯·深炉
step << Rogue/wotlk
.goto Ironforge,77.0,51.0,30 >>进入Deeprun Tram
step << Rogue/wotlk
    .accept 6661 >>接任务: 捕捉矿道老鼠
step << Rogue/wotlk
    .use 17117>>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step << Rogue/wotlk
    .turnin 6661 >>交任务: 捕捉矿道老鼠
    .accept 6662 >>接任务: 我的兄弟，尼普希 << Rogue/wotlk
step << !Rogue tbc
    .goto Ironforge,55.5,47.8
    >>回到铁炉堡
    .fly Menethil >>飞往米奈希尔
step << Rogue/wotlk
     >>骑到电车的另一侧，然后转弯
    .turnin 6662 >>交任务: 我的兄弟，尼普希
step << Rogue/wotlk
    .goto StormwindClassic,58.1,16.5
    .turnin 1338 >>交任务: 卡尔·雷矛的订单
    .isOnQuest 1338
step << Rogue
    .goto StormwindClassic,57.1,57.7
    .train 201 >>训练1h剑
step << Rogue
    .goto StormwindClassic,57.6,57.1
    .vendor >>从Gunther那里购买一把弯刀并装备它
step << Rogue tbc
    #sticky
    #completewith next
.hs >>希斯玛之炉
step << !NightElf Rogue tbc
    .goto Loch Modan,37.0,47.8
.turnin 6392 >>交任务: 向布洛克回复
step << Rogue tbc
    .goto Ironforge,55.5,47.8
    .fly Menethil >>飞往米奈希尔
step << Gnome/Dwarf
    .abandon 6392 >>放弃返回Brock
step << tbc
    .money <0.076
    .goto Wetlands,10.4,56.0,15,0
.goto Wetlands,10.1,56.9,15,0
.goto Wetlands,10.6,57.2,15,0
.goto Wetlands,10.7,56.8
    .vendor >>如果你有7.6秒，检查Neal Allen的铜管，如果有就买
    .bronzetube
step << tbc
    .money <0.0385
.goto Wetlands,8.1,56.3
    .vendor >>检查Dewin的治疗药剂，购买时间减至1秒
step << tbc
    #sticky
#completewith Darkshore1
+在这里等船
.goto Wetlands,4.7,57.3
step << tbc
    #label Darkshore1
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸
step << Warlock wotlk/Rogue wotlk
    #xprate <1.5
    .goto StormwindClassic,52.61,65.71
    .home >>将您的炉石设置为暴风城
step << wotlk
    .goto StormwindNew,21.8,56.2
    .zone Darkshore >>乘船前往: 黑海岸
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance Warlock
#name 1-12 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome Warlock
#next 12-14 丹莫罗;11-14 黑海岸
step << !Gnome !Dwarf
    #sticky
    #completewith next
.goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step
    >>删除您的炉石 << tbc
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .accept 179 >>接任务: 矮人的交易
step << tbc
    #sticky
    #completewith next
    .goto Dun Morogh,28.6,72.2,20,0
    +杀死狼群10美分以上的小贩垃圾，然后进入大楼
step << tbc
    .goto Dun Morogh,28.8,69.2,20 >>进入大楼
step << tbc
    .goto Dun Morogh,28.8,66.2
    .vendor >>与恶魔书小贩、小贩垃圾对话
step << tbc
    .goto Dun Morogh,28.6,66.1
    .train 348 >>火车献祭
    .accept 1599 >>接任务: 开端
step
    >>杀死狼。抢他们的肉
.goto Dun Morogh,28.4,75.4
    .complete 179,1 --Collect Tough Wolf Meat (x8)
step
    .xp 2 >>升级到2
step << tbc
#sticky
#completewith next
    .goto Dun Morogh,26.8,79.8,30,0
    .goto Dun Morogh,30.1,82.4,30 >>在途中杀死一些狼，然后看这个
.link https://www.youtube.com/watch?v=iUvGsRbIVp8 >>单击此处
step << tbc
    >>杀死Frostmane新手。掠夺他们的羽毛魅力
.goto Dun Morogh,29.0,82.6,20,0
.goto Dun Morogh,29.0,81.2,30,0
.goto Dun Morogh,30.1,82.4,20,0
    .complete 1599,1 --Collect Feather Charm (x3)
step << tbc
    .goto Dun Morogh,29.5,69.8,100 >>在精神治疗师处死亡并重生
step << tbc
    .goto Dun Morogh,28.6,66.1
    .turnin 1599 >>交任务: 开端
step
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3115 >>接任务: 被污染的备忘录
step << tbc
>>召唤小鬼，拒绝
.goto Dun Morogh,30.0,71.5
    .vendor >>小贩垃圾，买15杯水。如果你没有足够的钱，就去磨更多的钱
    .collect 159,15 --Collect Refreshing Spring Water (x15)
step
#xprate <1.5
    .goto Dun Morogh,29.7,71.2
    .accept 170 >>接任务: 新的威胁
step
#xprate <1.5
    #sticky
    #completewith Rockjaw
    >>杀死你看到的普通岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
#xprate <1.5
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    >>杀死Burly Rockjaw Troggs
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 233 >>交任务: 寒脊山谷的送信任务
    .accept 183 >>接任务: 猎杀野猪
    .accept 234 >>接任务: 寒脊山谷的送信任务
step
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>交任务: 猎杀野猪
step
#label Rockjaw
    .goto Dun Morogh,25.1,75.7
    .turnin 234 >>交任务: 寒脊山谷的送信任务
    .accept 182 >>接任务: 巨魔洞穴
step
#xprate <1.5
    #sticky
    #label Troggs
    .goto Dun Morogh,28.7,77.5
    >>如果你到现在还没有处理完流浪汉，就到这里来
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
    .xp 4 >>升级到4
step
.goto Dun Morogh,25.0,76.0
    .accept 3364 >>接任务: 热酒快递
>>一旦接受，将启动5分钟计时器。放松并遵循指南
step << wotlk
    .hs >>使用您的炉石
step
    #sticky
    #completewith next
    #requires Troggs
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >>接任务: 热酒快递
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
step
    #requires Troggs
.goto Dun Morogh,28.8,66.4
    .turnin 3364 >>交任务: 热酒快递
    .accept 3365 >>接任务: 归还酒杯
    .vendor >>供应商垃圾
step
.goto Dun Morogh,28.6,66.1
    >>上楼去
    .train 688 >>列车召唤小鬼 << wotlk
    .train 172 >>培训腐败
    .turnin 3115 >>交任务: 被污染的备忘录
step
#xprate <1.5
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >>交任务: 新的威胁
step << tbc
.goto Dun Morogh,30.0,71.5
    .vendor >>供应商，多买5瓶水
step
    .goto Dun Morogh,26.3,79.2,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
>>杀死霜鬃巨魔幼崽
.complete 182,1 --Kill Frostmane Troll Whelp (x14)
step
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >>交任务: 归还酒杯
step
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >>交任务: 巨魔洞穴
    .accept 218 >>接任务: 被窃取的日记
step
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
.goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀死格里克尼尔，然后掠夺他的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
.goto Dun Morogh,28.4,79.7,30,0
.goto Dun Morogh,26.8,79.6,20 >>跑出洞穴
step
    .goto Dun Morogh,25.1,75.7
    .turnin 218 >>交任务: 被窃取的日记
    .accept 282 >>接任务: 森内尔的观察站
step
    >>把一些暴徒赶到这里
.goto Dun Morogh,33.5,71.8
    .turnin 282 >>交任务: 森内尔的观察站
    .accept 420 >>接任务: 森内尔的观察站
step
    .goto Dun Morogh,33.9,72.2
    .accept 2160 >>接任务: 塔诺克的补给品
step
.goto Dun Morogh,34.1,71.6,20,0
.goto Dun Morogh,35.7,66.0,20 >>穿过隧道
step
    #sticky
#completewith BoarMeat3
>>杀死野猪，为稍后获取野猪肉
.collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    #sticky
#completewith BoarRibs
>>杀死野猪，获取野猪肋骨供日后使用
.collect 2886,6 --Collect Crag Boar Rib (x6)
step
>>磨碎东北至哈拉诺斯的野猪
.goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2415>>提升经验到2415/+2800xp
step
    .goto Dun Morogh,47.0,55.1,75 >>在精神疗愈者处死亡并重生，或者跑向哈拉诺斯。确保你的分区不是Coldridge Pass
step
    #label BoarMeat3
    .zone Dun Morogh >>.
step
    #label BoarRibs
    .zone Dun Morogh >>.
step
.goto Dun Morogh,46.7,53.8
    .turnin 420 >>交任务: 森内尔的观察站
step
    .xp 6 >>升级到6
step
    .goto Dun Morogh,46.7,53.5
    .vendor >>供应商垃圾
step << tbc
.goto Dun Morogh,47.3,53.7
    .vendor >>去丹妮那里，买一本血腥契约书并使用它
step
.goto Dun Morogh,47.3,53.7
    >>与Gimrizz交谈
    .train 695 >>列车阴影螺栓r2
    .train 1454 >>列车生命抽头
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >>接任务: 贝尔丁的工具
step
    #sticky
#completewith next
>>杀死野猪，为稍后获取野猪肉
.collect 769,4 --Collect Chunk of Boar Meat (x4)
step
.goto Dun Morogh,49.4,48.4
    >>不要在途中杀死熊
    .accept 317 >>接任务: 贝尔丁的补给
step
#xprate <1.5
    .goto Dun Morogh,49.6,48.6
    .accept 313 >>接任务: 灰色洞穴
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >>交任务: 贝尔丁的工具
step
.goto Dun Morogh,50.1,49.4
    .accept 5541 >>接任务: 海格纳的弹药
step
    #sticky
#completewith BoarRibs2
>>杀死野猪以获得野猪肋骨
.collect 2886,6 --Collect Crag Boar Rib (x6)
step
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
.complete 317,2 --Collect Thick Bear Fur (x2)
step
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >>交任务: 贝尔丁的补给
    .accept 318 >>接任务: 艾沃沙酒
step
    #sticky
    #completewith supplies
    +如果你以前买不起技能，现在就去买
step
    .goto Dun Morogh,46.8,52.4
    .accept 384 >>接任务: 啤酒烤猪排
step
    #label supplies
.goto Dun Morogh,47.2,52.2
    .turnin 2160 >>交任务: 塔诺克的补给品
step
.goto Dun Morogh,47.4,52.5
    .home >>将您的炉石设置为Thunderbrew酒厂
step
#xprate <1.5
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    .goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    >>到洞里去。杀死Wendigos。掠夺他们的鬃毛
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    >>掠夺板条箱
    .goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Collect Rumbleshot's Ammo (x1)
step
    .goto Dun Morogh,40.6,62.6,30,0
    .goto Dun Morogh,40.7,65.1
    .turnin 5541 >>交任务: 海格纳的弹药
    .vendor >>供应商和维修
step
    .xp 7 >>升级到7
step
>>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,50,0
    .goto Dun Morogh,36.0,52.0,50,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >>接任务: 马克格拉恩的干肉
step
.goto Dun Morogh,30.5,46.0
    .vendor >>小贩从Kreg购买x10 5级饮料
step
    .goto Dun Morogh,30.2,45.8
    .turnin 318 >>交任务: 艾沃沙酒
    .accept 319 >>接任务: 艾沃沙酒
    .accept 315 >>接任务: 完美烈酒
step
    .goto Dun Morogh,30.2,45.5
    .accept 310 >>接任务: 针锋相对
step
#label BoarRibs2
    .goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
    .goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
    >>杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    >>完成野猪肋
    .complete 384,1 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,30.2,45.7
    .turnin 319 >>交任务: 艾沃沙酒
    .accept 320 >>接任务: 艾沃沙酒
step
    .xp 7+3735>>提升经验到3735+/4500xp
    .goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
    .goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
step
    .goto Dun Morogh,30.3,37.5,50 >>跑到这里
step
    .isQuestTurnedIn 384
    .xp 7+4360>>提升经验到4360+/4500xp，然后转到此处
    .goto Dun Morogh,30.3,37.5,50
step
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    .goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
    .deathskip >>继续向北奔跑，摔倒死亡，然后重生
step
    .goto Wetlands,12.7,46.7,30 >>游到岸上
step
    .goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
step
    .hs >>赫斯到哈拉诺斯
step
    .goto Dun Morogh,47.4,52.5
    >>从Belm购买狂想曲麦芽和雷霆啤酒
    .complete 384,2 --Collect Rhapsody Malt (x1)
    .collect 2686,1,310,1 --Collect Thunder Ale (x1)
step
    .goto Dun Morogh,47.6,52.4,10 >>进客栈老板后面的房间
step
    >>下楼去，然后和贾文谈谈，给他雷霆啤酒
    >>等待木桶鼠标移到“无人看守”位置，然后handin
    .turnin 310 >>交任务: 针锋相对
    .accept 311 >>接任务: 向马莱斯回报
step
    .goto Dun Morogh,46.8,52.4
    .turnin 384 >>交任务: 啤酒烤猪排
     >>当你下一个供应商时出售配方
step
    .xp 8 >>升级到8
step << tbc
    .goto Dun Morogh,47.3,53.7
    .vendor >>去找丹妮，买一本Firebolt r2的书并使用它
step
    .goto Dun Morogh,47.3,53.7
    >>与Gimrizz交谈
    .train 980 >>训练痛苦诅咒
    .train 5782 >>训练恐惧
step
    .goto Dun Morogh,46.7,53.8
    .accept 287 >>接任务: 霜鬃巨魔要塞
step
#xprate <1.5
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >>交任务: 灰色洞穴
step
    .goto Dun Morogh,49.4,48.4
    .turnin 320 >>交任务: 艾沃沙酒
step
#xprate <1.5
    .goto Dun Morogh,45.8,49.4
    .accept 412 >>接任务: 自动净化装置
step
    #completewith next
    .goto Dun Morogh,43.1,45.0,20,0
    .goto Dun Morogh,42.1,45.4,20 >>跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,30,0
    .goto Dun Morogh,41.5,43.6,30,0
    .goto Dun Morogh,39.7,40.0,30,0
    .goto Dun Morogh,42.1,34.3,30,0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线(LoS)在小屋后面。如果你运气不好，就跑到另一个地方去
    .complete 315,1 --Collect Shimmerweed (x6)
step
    #completewith next
    .goto Dun Morogh,38.4,49.9,40 >>跑向老冰胡子
step
    >>害怕老冰胡子，然后掠夺洞穴内的箱子
    .goto Dun Morogh,38.5,53.9
    .complete 312,1 --Collect MacGrann's Dried Meats (x1)
step
    .goto Dun Morogh,34.6,51.7
    .turnin 312 >>交任务: 马克格拉恩的干肉
step << tbc
    .goto Dun Morogh,30.4,45.8
    .vendor >>尽可能多地购买5级饮料
step
    .goto Dun Morogh,30.2,45.7
    .turnin 315 >>交任务: 完美烈酒
    .accept 413 >>接任务: 微光酒
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交任务: 向马莱斯回报
step
#xprate <1.5
    .goto Dun Morogh,27.2,43.0,40,0
    .goto Dun Morogh,24.8,39.3,40,0
    .goto Dun Morogh,25.6,43.4,40,0
    .goto Dun Morogh,24.3,44.0,40,0
    .goto Dun Morogh,25.4,45.4,40,0
    >>杀死麻风侏儒。掠夺他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step
    .xp 9 >>升级到9
step
    #completewith next
    .goto Dun Morogh,24.5,50.8,30 >>进入洞穴
step
    .goto Dun Morogh,22.1,50.3,40,0
       .goto Dun Morogh,21.3,52.9,40,0
    >>杀死洞穴内的猎头
    .complete 287,1 --Kill Frostmane Headhunter (x5)
step
    >>跳进下面的角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #completewith next
    .deathskip >>在精神治疗师处死亡并重生
step
    .goto Dun Morogh,46.7,53.8
    .turnin 287 >>交任务: 霜鬃巨魔要塞
    .accept 291 >>接任务: 森内尔的报告
step
#xprate <1.5
    .goto Dun Morogh,45.8,49.4
    .turnin 412 >>交任务: 自动净化装置
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,12,0
    .goto Dun Morogh,62.2,49.4,8 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
.goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (x)
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    >>途中磨碎一点
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商，购买x10 5级水/x5 5级食物
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >>接任务: 公众之仆
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >>接任务: 该死的石腭怪！
step
.goto Dun Morogh,70.6,56.6,30,0
.goto Dun Morogh,70.8,53.3,30,0
.goto Dun Morogh,71.9,50.7,30,0
.goto Dun Morogh,72.9,53.1,30,0
.goto Dun Morogh,70.6,56.6,30,0
.goto Dun Morogh,70.8,53.3,30,0
.goto Dun Morogh,71.9,50.7,30,0
.goto Dun Morogh,72.9,53.1,30,0
    >>在山洞里杀死Troggs
.complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >>交任务: 该死的石腭怪！
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >>交任务: 公众之仆
step
.xp 10 >>升级到10
step
    .goto Dun Morogh,81.2,42.7,15 >>在路上磨磨蹭蹭，到隧道里去
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>途中研磨
.goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
.goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >>交任务: 驾驶员的复仇
step
    #completewith next
    .goto Dun Morogh,81.2,42.7,25 >>穿过隧道往回走
step
    .goto Dun Morogh,79.6,50.7,50,0
    .goto Dun Morogh,82.3,53.5,25,0
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >>交任务: 微光酒
    .accept 414 >>接任务: 卡德雷尔的酒
step
    #completewith next
    .goto Dun Morogh,86.2,51.3,20 >>穿过隧道
step
    .goto Loch Modan,22.1,73.1
    .accept 224 >>接任务: 保卫国王的领土
step
    .goto Loch Modan,22.6,75.4,30,0
    .goto Loch Modan,23.2,73.7
    >>进入沙坑
    .accept 267 >>接任务: 穴居人的威胁
step << wotlk
    .goto Loch Modan,30.0,72.4,100,0
    .goto Loch Modan,34.7,71.6,100,0
    .goto Loch Modan,30.9,81.1,100,0
    .goto Loch Modan,30.0,72.4,100,0
    .goto Loch Modan,34.7,71.6,100,0
    .goto Loch Modan,30.9,81.1,100,0
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step << wotlk
    .goto Loch Modan,22.2,73.3
    .turnin 224 >>交任务: 保卫国王的领土
step << wotlk
    .goto Loch Modan,23.2,73.7
    .turnin 267 >>交任务: 穴居人的威胁
step
    .goto Loch Modan,35.3,46.9,150 >>跑向塞尔斯马尔
step << tbc
    .goto Loch Modan,35.5,48.4
    .home >>把你的炉石放在塞尔萨马尔
step << tbc
#xprate <1.5
    .goto Loch Modan,34.8,49.3
    .accept 418 >>接任务: 塞尔萨玛血肠
step
    .goto Loch Modan,34.0,46.5
    .vendor >>供应商垃圾，修复
step
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    .goto Loch Modan,32.6,49.9,40,0
    .goto Loch Modan,37.2,46.1,40,0
    .goto Loch Modan,36.7,41.6,40,0
    >>找到卡德雷尔，他在大路上巡逻
    .turnin 414 >>交任务: 卡德雷尔的酒
    .accept 416 >>接任务: 狗头人的耳朵 << tbc
    .accept 1339 >>接任务: 巡山人卡尔·雷矛的任务
step
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .accept 6387 >>接任务: 荣誉学员
step << tbc
    #sticky
    #completewith ThelsamarFood
    >>杀死蜘蛛。为蜘蛛Ichor抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step << tbc
    #sticky
    #completewith ThelsamarFood
    >>杀死熊。抢他们的熊肉
    .complete 418,2 --Collect Bear Meat (x3)
step << tbc
    #sticky
    #completewith ThelsamarFood
    >>杀死野猪。为了猪的肠道杀死它们
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #completewith next
    #label ThelsamarFood
    .goto Loch Modan,23.3,17.9,30 >>跑到北边的沙坑。途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商垃圾，修理
step
    >>楼上的
    .goto Loch Modan,24.7,18.3
    .turnin 1339 >>交任务: 巡山人卡尔·雷矛的任务
    .accept 307 >>接任务: 肮脏的爪子 << tbc
    .accept 1338 >>接任务: 卡尔·雷矛的订单
step
    #label Thelsamar
    .goto Loch Modan,32.0,47.2,150 >>在精神治疗者那里死去并重生，或者跑到这里
step
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
    .turnin 6387 >>交任务: 荣誉学员
    .accept 6391 >>接任务: 飞往铁炉堡
    .fly Ironforge >>飞往铁炉堡
step
    .goto Ironforge,51.5,26.3
    .turnin 6391 >>交任务: 飞往铁炉堡
    .accept 6388 >>接任务: 格莱斯·瑟登
step
    >>不要在任何地方飞行
.goto Ironforge,55.5,47.8
    .turnin 6388 >>交任务: 格莱斯·瑟登
    .accept 6392 >>接任务: 向布洛克回复
step
    .goto Ironforge,39.5,57.5
    .turnin 291 >>交任务: 森内尔的报告
step
    #sticky
    #completewith next
+跳到铁砧顶部，然后退出并返回
.goto Ironforge,49.7,43.7
step
.goto Ironforge,77.0,51.0,30 >>进入Deeprun Tram
step
    .accept 6661 >>接任务: 捕捉矿道老鼠
step
    .use 17117>>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >>交任务: 捕捉矿道老鼠
    .accept 6662 >>接任务: 我的兄弟，尼普希
step
     >>骑到电车的另一侧，然后转弯
    .turnin 6662 >>交任务: 我的兄弟，尼普希
step
    .goto StormwindClassic,58.1,16.5
    .turnin 1338 >>交任务: 卡尔·雷矛的订单
step
    .goto StormwindClassic,62.5,62.3,30,0
    .goto StormwindClassic,66.3,62.1
    .fp Stormwind >>获取暴风城飞行路线
step
    .money <0.2090
    .goto StormwindClassic,57.1,57.7
    .train 227 >>火车杆
step
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,15,0
    .goto StormwindClassic,27.2,78.1,10 >>走进屠宰羔羊
step
    .goto StormwindClassic,25.2,78.5
    .accept 1688 >>接任务: 苏伦娜·凯尔东
    .train 1120 >>训练吸取灵魂
    .train 6201 >>训练Create Healthstone
    .train 696 >>训练恶魔皮肤r2
    .train 707 >>火车献祭r2
step
    .deathskip >>使用生命水龙头并站在你旁边的篝火上，在精神治疗者处死亡并重生
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step << tbc
#xprate <1.5
    .goto Elwynn Forest,42.1,65.9
    .accept 62 >>接任务: 法戈第矿洞
step << tbc
#xprate <1.5
    .goto Elwynn Forest,42.9,65.7
    .abandon 109 >>向Gryan Stoutmantle提交的放弃报告
step << tbc
#xprate <1.5
    #completewith next
    .goto Elwynn Forest,42.9,65.7,15 >>去客栈
step << tbc
#xprate <1.5
    >>在你靠近的左边
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >>接任务: 狗头人的蜡烛
step << tbc
#xprate <1.5
    .goto Elwynn Forest,42.1,67.3
    .accept 47 >>接任务: 金砂交易
step
.goto Elwynn Forest,42.1,67.3
    .accept 40 >>接任务: 鱼人的威胁
step << tbc
#xprate <1.5
    #sticky
    #completewith Candles
    >>从附近的Kobolds买蜡烛
    .complete 60,1 --Collect Kobold Candle (x8)
step << tbc
#xprate <1.5
    #sticky
#completewith Dust
    >>从附近的Kobolds获取金沙
    .complete 47,1 --Collect Gold Dust (x10)
step << tbc
#xprate <1.5
    #completewith next
    .goto Elwynn Forest,38.1,81.6,15 >>从下入口进入
step << tbc
#xprate <1.5
    >>继续穿过矿井
.goto Elwynn Forest,40.5,82.3
    .complete 62,1 --Scout Through the Fargodeep Mine
step << tbc
#xprate <1.5
    #label Candles
    .goto Elwynn Forest,38.4,83.4,2500 >>.
step << tbc
#xprate <1.5
    #label Dust
    .goto Elwynn Forest,38.4,83.4,2500 >>.
step << tbc
#xprate <1.5
    .goto Elwynn Forest,38.4,83.4
    >>杀死科波德斯。抢蜡烛和灰尘
    .complete 60,1 --Collect Kobold Candle (x8)
    .complete 47,1 --Collect Gold Dust (x10)
step
    .goto Elwynn Forest,34.7,84.5
    .accept 88 >>接任务: 公主必须死！
step
    .goto Elwynn Forest,24.6,78.2
    .accept 176 >>接任务: 通缉：霍格
step
    #sticky
    #completewith next
    >>请留意取金时间表(幸运滴)，或Gruff Swiftbite的100%滴(罕见)。额外210xp
    .collect 1307,1,123 --Collect Gold Pickup Schedule (x1)
    .accept 123 >>接任务: 收货人
step
    #label Hogger
.goto Elwynn Forest,27.0,86.7,40,0
.goto Elwynn Forest,26.1,89.9,40,0
.goto Elwynn Forest,25.2,92.7,40,0
.goto Elwynn Forest,27.0,93.9,40,0
.goto Elwynn Forest,27.0,86.7,40,0
.goto Elwynn Forest,26.1,89.9,40,0
.goto Elwynn Forest,25.2,92.7,40,0
.goto Elwynn Forest,27.0,93.9,40,0
.goto Elwynn Forest,27.0,86.7,40,0
.goto Elwynn Forest,26.1,89.9,40,0
.goto Elwynn Forest,25.2,92.7,40,0
.goto Elwynn Forest,27.0,93.9,40,0
    >>Hogger可以出现在该地区的多个地点。让他恐惧重重，和/或在24,80时以<60%的马力将他风筝到塔上。抢走他的爪子
    .complete 176,1 --Collect Huge Gnoll Claw (x1)
step
#completewith next
    .goto Elwynn Forest,39.5,60.5,200 >>在精神疗养院死去并重生，或者跑回金郡
step
.goto Elwynn Forest,42.1,65.9
    >>选择Staff。装备它
    .turnin 176 >>交任务: 通缉：霍格
    .turnin 40 >>交任务: 鱼人的威胁
    .accept 35 >>接任务: 卫兵托马斯
step
    #sticky
    .isOnQuest 123
    .goto Elwynn Forest,42.1,65.9
    .turnin 123 >>交任务: 收货人
step << tbc
#xprate <1.5
    .goto Elwynn Forest,42.1,65.9
    .turnin 62 >>交任务: 法戈第矿洞
    .accept 76 >>接任务: 玉石矿洞
step << tbc
#xprate <1.5
    .goto Elwynn Forest,42.1,67.3
    .turnin 47 >>交任务: 金砂交易
step
    .abandon 147 >>放弃捕猎
step << tbc
#xprate <1.5
    .goto Elwynn Forest,43.3,65.7
    .turnin 60 >>交任务: 狗头人的蜡烛
    .accept 61 >>接任务: 送往暴风城的货物
step
    #sticky
    #completewith soylago
    .goto Elwynn Forest,44.1,66.0,12 >>如果你是12楼，去客栈老板后面的房间，然后下楼。否则，请跳过此步骤
    .goto Elwynn Forest,44.4,66.2
    .train 755 >>列车健康漏斗
    .train 705 >>列车阴影螺栓r3
    .xp <12,1
step
    .goto Elwynn Forest,43.8,65.8
    .vendor >>购买x10等级5饮料
step << tbc
#xprate <1.5
    #label soylago
    .goto Elwynn Forest,47.6,63.3,60,0
    .goto Elwynn Forest,61.8,54.0,20 >>往矿井外面走
step << tbc
#xprate <1.5
    >>进入矿井，继续沿着中间的小路走
    .goto Elwynn Forest,60.4,50.2
    .complete 76,1 --Scout through the Jasperlode Mine
step
    .goto Elwynn Forest,61.8,54.0,40,0
    .goto Elwynn Forest,74.0,72.2
    >>在去这里的路上磨磨蹭蹭
    .turnin 35 >>交任务: 卫兵托马斯
step << tbc
    #xprate <1.5
    .accept 37 >>接任务: 失踪的卫兵
    .accept 52 >>接任务: 保卫边境
step << tbc
#xprate <1.5
    #sticky
    #completewith Prowlers
    >>在执行其他任务时杀死潜行者
    .complete 52,1 --Kill Prowler (x8)
step << tbc
#xprate <1.5
    #sticky
    #completewith Bears
    >>在执行其他任务时杀死熊。杀死你看到的任何人
    .complete 52,2 --Kill Young Forest Bear (x5)
step << tbc
#xprate <1.5
    .goto Elwynn Forest,72.7,60.3
    .turnin 37 >>交任务: 失踪的卫兵
    .accept 45 >>接任务: 罗尔夫的下落
step << tbc
#xprate <1.5
    .goto Elwynn Forest,81.4,66.1
    .accept 5545 >>接任务: 木材危机
step << tbc
#xprate <1.5
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾处理和维修(如果需要)
step << tbc
#xprate <1.5
    #sticky
    #completewith next
    >>注意树下的一捆捆原木。
    .complete 5545,1 --Collect Bundle of Wood (x8)
step << tbc
#xprate <1.5
    #label Bundles
    .goto Elwynn Forest,79.8,55.5
    >>把暴徒拉到小屋前，走开，然后让其中一个保持恐惧，并尝试在两个上面都留下点。然后在地上洗劫尸体
    .turnin 45 >>交任务: 罗尔夫的下落
    .accept 71 >>接任务: 回复托马斯
step << tbc
#xprate <1.5
.goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
.goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    >>开始后退，完成包裹
    .collect 13872,8 --Collect Bundle of Wood (x8)
step << tbc
#xprate <1.5
    .goto Elwynn Forest,81.4,66.1
    .turnin 5545 >>交任务: 木材危机
step << tbc
#xprate <1.5
    #label Bears
.goto Elwynn Forest,79.5,68.8
    .accept 83 >>接任务: 红色亚麻布
step << tbc
#xprate <1.5
    #label Prowlers
    .goto Elwynn Forest,79.5,68.8,10000
    step
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
    >>杀死最后一批暴徒保护边境
    .complete 52,1 --Kill Prowler (x8)
    .complete 52,2 --Kill Young Forest Bear (x5)
step << tbc
#xprate <1.5
    .goto Elwynn Forest,74.0,72.2
    .turnin 52 >>交任务: 保卫边境
    .turnin 71 >>交任务: 回复托马斯
    .accept 39 >>接任务: 托马斯的报告
step << tbc
#xprate <1.5
    .goto Elwynn Forest,70.5,77.6,40,0
    .goto Elwynn Forest,68.1,77.5,40,0
    .goto Elwynn Forest,68.2,81.4,40,0
    .goto Elwynn Forest,70.8,80.9,40,0
    .goto Elwynn Forest,70.5,77.6,40,0
    .goto Elwynn Forest,68.1,77.5,40,0
    .goto Elwynn Forest,68.2,81.4,40,0
    .goto Elwynn Forest,70.8,80.9,40,0
    .goto Elwynn Forest,70.5,77.6,40,0
    .goto Elwynn Forest,68.1,77.5,40,0
    .goto Elwynn Forest,68.2,81.4,40,0
    .goto Elwynn Forest,70.8,80.9,40,0
    >>开始围着农场转，杀掉德菲亚斯，然后掠夺他们的头巾
    .complete 83,1 --Collect Red Linen Bandana (x6)
step
    .goto Elwynn Forest,69.8,79.5
    .abandon 109 >>向Gryan Stoutmantle提交的放弃报告
step
    >>杀死房子里的暴徒，让摩根保持恐惧(他凿伤并杀死宠物)，核弹袭击苏雷纳。为她的喉咙掠夺她
    .goto Elwynn Forest,71.0,80.8
    .complete 1688,1 --Collect Surena's Choker (x)
step
    #label Deed
    .goto Elwynn Forest,69.8,79.5
    .goto Elwynn Forest,69.5,76.4,0
    .goto Elwynn Forest,71.3,79.2,0
    >>杀死公主。抢走她的衣领
    .complete 88,1 --Collect Brass Collar (x1)
step << tbc
#xprate <1.5
    .goto Elwynn Forest,79.5,68.9
    .turnin 83 >>交任务: 红色亚麻布
step << tbc
#xprate <1.5
    #sticky
    #completewith next
    .goto Elwynn Forest,83.3,66.1
    .vendor >>供应商垃圾，修理
step << tbc
    .xp 12
step
    #sticky
    #completewith next
    .goto Elwynn Forest,91.7,72.3,90 >>在途中研磨，确保至少有2个灵魂碎片(使用吸取灵魂)
    .collect 6265,2 --Collect Soul Shard (x2)
step
    .goto Redridge Mountains,17.4,69.6
    .accept 244 >>接任务: 豺狼人的入侵
step
    .abandon 184 >>放弃Furlbrow的契约
step
    >>小心路上的暴徒
    .goto Redridge Mountains,30.7,60.0
    .turnin 244 >>交任务: 豺狼人的入侵
step
    .goto Redridge Mountains,29.30,53.60
    .accept 3741 >>接任务: 希拉里的项链
    .xp <12,1
step
    >>在水下寻找希拉里的项链。它在一片褐色的泥土里
    .goto Redridge Mountains,27.80,56.05,0
    .goto Redridge Mountains,26.56,50.63,0
    .goto Redridge Mountains,23.96,55.17,0
    .goto Redridge Mountains,19.16,51.75,0
    .goto Redridge Mountains,31.12,54.21,0
    .goto Redridge Mountains,34.03,55.34,0
    .goto Redridge Mountains,38.09,54.49,0
    .goto Redridge Mountains,19.16,51.75,70,0
    .goto Redridge Mountains,38.09,54.49,70,0
    .complete 3741,1 --Hilary's Necklace (1)
    .xp <12,1
step
    .goto Redridge Mountains,29.20,53.60
    .turnin 3741 >>交任务: 希拉里的项链
    .xp <12,1
step
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge >>获得Redridge Mountains飞行路线
    .fly Stormwind >>飞到暴风城
step << wotlk
    .goto StormwindClassic,52.8,65.4
    .home >>将您的炉石设置为暴风
step << tbc
#xprate <1.5
    >>选择火箭。这些有很好的伤害，可以用来劈开
    .goto StormwindClassic,56.2,64.6
    .turnin 61 >>交任务: 送往暴风城的货物
step
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,15,0
    .goto StormwindClassic,27.2,78.1,10 >>走进屠宰羔羊
step
.goto StormwindClassic,25.3,78.2
    .train 755 >>列车健康漏斗
    .train 705 >>列车阴影螺栓r3
    .xp <12,1
step
    .goto StormwindClassic,25.2,78.5
    .turnin 1688 >>交任务: 苏伦娜·凯尔东
    .accept 1689 >>接任务: 誓缚
step
    .goto StormwindClassic,25.2,80.7,12,0
    .goto StormwindClassic,23.2,79.5,12,0
    .goto StormwindClassic,26.3,79.5,12,0
    .goto StormwindClassic,25.5,78.1
    >>去地下室的底部。用血石窒息器召唤虚空行者并杀死它
    .complete 1689,1 --Kill Summoned Voidwalker (x1)
step
    .goto StormwindClassic,25.2,78.5
    >>一旦你学会了，就不要召唤你的虚空行者
    .turnin 1689 >>交任务: 誓缚
step
    .deathskip >>使用生命水龙头并站在术士训练师旁边的篝火上，在精神治疗者处死亡并重生
step
    .goto Elwynn Forest,41.7,65.9
    .vendor >>供应商垃圾，修理
step
    .goto Elwynn Forest,42.1,65.9
    .turnin -76 >>交任务: 玉石矿洞
    .turnin -39 >>交任务: 托马斯的报告
step
    .goto Elwynn Forest,34.7,84.5
    .turnin 88 >>交任务: 公主必须死！
step
    .abandon 59 >>弃布皮甲
step << wotlk
    .goto Elwynn Forest,27.0,93.9
    .xp 12
step << wotlk
    .goto Elwynn Forest,44.4,66.2
    >>故意死亡，在戈尔德郡重生
    >>前往客栈地下室
    .train 755 >>列车健康漏斗
    .train 705 >>列车阴影螺栓r3
step
    .hs >>赫斯到莫丹湖 << tbc
    .hs >>从火炉到暴风 << wotlk
step << wotlk
    .goto StormwindNew,21.8,56.2
    >>前往: 暴风城
    .zone Darkshore >>前往: 黑海岸
]])

RXPGuides.RegisterGuide([[
#tbc
<< Alliance Warlock
#name 12-14 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome Warlock
#next 14-20 秘血岛
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买6个袋位袋，直到所有袋位都满了
step
    .goto Loch Modan,34.0,46.5
    .vendor >>供应商垃圾，修理
step
#sticky
#completewith Thelsamar
>>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
.complete 418,3 --Collect Spider Ichor (x3)
step
    #sticky
    #completewith Thelsamar
>>在Thelsamar鲜血香肠区杀死熊
.complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #completewith Thelsamar
>>在赛尔萨马尔血肠区杀死野猪
.complete 418,1 --Collect Boar Intestines (x3)
step
    #label Thelsamar
.goto Loch Modan,39.3,27.0,100 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
.goto Loch Modan,35.5,18.2,30 >>去洞口杀老鼠
step
.goto Loch Modan,35.5,19.9,12,0
.goto Loch Modan,36.4,20.7,12,0
.goto Loch Modan,35.3,22.0,12,0
.goto Loch Modan,35.9,22.1,12,0
.goto Loch Modan,36.3,24.7,12,0
.goto Loch Modan,35.7,24.3,12,0
.goto Loch Modan,34.9,24.9,12,0
.goto Loch Modan,35.7,24.3,12,0
.goto Loch Modan,36.3,24.7,12,0
.goto Loch Modan,35.9,22.1,12,0
.goto Loch Modan,35.3,22.0,12,0
.goto Loch Modan,36.4,20.7,12,0
.goto Loch Modan,35.5,19.9,12,0
    >>收集你在山洞里找到的板条箱。小心，因为这可能很困难，风水师会火焰防护(防火)
    .complete 307,1 --Collect Miners' Gear (x4)
step
.goto Loch Modan,35.5,18.2,30 >>回洞里去
step
    #sticky
    #completewith Kobolds
    .goto Loch Modan,42.9,9.9
    .vendor >>供应商，必要时进行维修(可选)
step
    #label Kobolds
    >>杀死科波德斯。抢走他们的耳朵
.complete 416,1 --Collect Tunnel Rat Ear (x12)
step
#sticky
#completewith Thelsamar3
>>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
.complete 418,3 --Collect Spider Ichor (x3)
step
    #sticky
    #completewith Thelsamar3
>>在Thelsamar鲜血香肠区杀死熊
.complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
    #completewith Thelsamar3
>>在赛尔萨马尔血肠区杀死野猪
.complete 418,1 --Collect Boar Intestines (x3)
step
    #label Thelsamar3
.goto Loch Modan,23.3,17.9,30 >>跑回沙坑，途中碾磨
step
    .goto Loch Modan,24.1,18.2
    .vendor >>供应商和维修
step
    .goto Loch Modan,24.7,18.3
    .turnin 307 >>交任务: 肮脏的爪子
step
    .xp 13 >>升级到13
step
    #sticky
#label Meat9
.goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
    .goto Loch Modan,26.9,10.7,40,0
    .goto Loch Modan,30.9,10.6,40,0
    .goto Loch Modan,28.6,15.4,40,0
    .goto Loch Modan,30.5,26.6,40,0
    .goto Loch Modan,33.4,30.3,40,0
    .goto Loch Modan,39.4,33.3,40,0
.goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Collect Bear Meat (x3)
step
    #sticky
#label Ichor9
.goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
    .goto Loch Modan,31.9,16.4,40,0
    .goto Loch Modan,28.0,20.6,40,0
    .goto Loch Modan,33.8,40.5,40,0
    .goto Loch Modan,36.2,30.9,40,0
    .goto Loch Modan,39.0,32.1,40,0
.goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Collect Spider Ichor (x3)
step
    #sticky
#label Intestines9
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
    .goto Loch Modan,38.0,34.9,40,0
    .goto Loch Modan,37.1,39.8,40,0
    .goto Loch Modan,29.8,35.9,40,0
    .goto Loch Modan,27.7,25.3,40,0
    .goto Loch Modan,28.6,22.6,40,0
.goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Collect Boar Intestines (x3)
step
    #requires Meat9
.goto Loch Modan,36.9,46.1,2500 >>.
step
    #requires Ichor9
.goto Loch Modan,36.9,46.1,2500 >>.
step
    #requires Intestines9
.goto Loch Modan,36.9,46.1,2500 >>.
step
.goto Loch Modan,32.6,49.9,40,0
.goto Loch Modan,37.2,46.1,40,0
.goto Loch Modan,36.7,41.6,40,0
.goto Loch Modan,32.6,49.9,40,0
.goto Loch Modan,37.2,46.1,40,0
.goto Loch Modan,36.7,41.6,40,0
    >>找到卡德雷尔，他在大路上巡逻
.goto Loch Modan,36.9,46.1
    .turnin 416 >>交任务: 狗头人的耳朵
step
    >>进入大楼
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .turnin 6392 >>交任务: 向布洛克回复
step
    .goto Loch Modan,34.8,49.3
    .turnin 418 >>交任务: 塞尔萨玛血肠
step
    .goto Loch Modan,30.0,68.4,30,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step
    #sticky
    #completewith FlyIF
    .money >0.5642
    .goto Loch Modan,30.0,68.4,30,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
.goto Loch Modan,30.0,72.4,50,0
    .goto Loch Modan,34.7,71.6,50,0
    .goto Loch Modan,30.9,81.1,50,0
    +研磨，直到你有价值56美分42美分的可售物品+钱，然后跳过这一步
step
.goto Loch Modan,32.7,76.5,0
.xp 13+9200>>提升经验到9200+/11000xp
step
.goto Loch Modan,22.2,73.3
    .turnin 224 >>交任务: 保卫国王的领土
step
.goto Loch Modan,23.2,73.7
    .turnin 267 >>交任务: 穴居人的威胁
step
    .xp 14 >>在拖架上升级到14
step
    #sticky
    #completewith next
    .goto Loch Modan,32.0,47.2,150 >>跑向塞尔斯马尔
step
.goto Loch Modan,33.9,51.0
    .fly Ironforge >>飞往铁炉堡
step
    #sticky
    #label Wand1
    #completewith Wand2
.goto Ironforge,25.8,75.2,0 >>或者，如果价格<30s 6c，从AH购买一个更大的魔杖
.collect 11288,1 --Collect Greater Magic Wand
step
    #label Wand2
    #completewith Wand1
    .goto Ironforge,24.0,16.7,20,0
.goto Ironforge,22.6,16.5
    .vendor >>进入大楼，然后下楼。购买阴燃魔杖
step
    #requires Wand2
.goto Ironforge,51.1,8.7,18 >>进入大楼
.goto Ironforge,50.4,6.3
    .train 6222 >>培训腐败r2
    .train 755 >>列车健康漏斗
    .train 705 >>列车阴影螺栓r3
step
    .goto Ironforge,53.2,7.8,18 >>进入大楼
.goto Ironforge,53.0,6.4
    .vendor >>购买消耗阴影r1，然后牺牲r1
step
    .goto Ironforge,55.5,47.8
    .fly Menethil >>飞往米奈希尔
step
    .money <0.076
    .goto Wetlands,10.4,56.0,15,0
.goto Wetlands,10.1,56.9,15,0
.goto Wetlands,10.6,57.2,15,0
.goto Wetlands,10.7,56.8
    .vendor >>如果你有7.6秒，检查Neal Allen的铜管，如果有就买
    .bronzetube
step
    .money <0.0385
.goto Wetlands,8.1,56.3
    .vendor >>检查Dewin的治疗药剂，购买时间减至1秒
step
    #sticky
#completewith next
+在这里等船
.goto Wetlands,4.7,57.3
step
    .zone Darkshore >>当船来的时候上去, 前往: 黑海岸
step
    #sticky
    #completewith next
.goto Darkshore,36.8,44.3,0
.vendor >>如果你愿意的话，你可以从酒店底层的莱尔德那里买到便宜的食物(20c五级食物)。
step
    >>客栈顶层
.goto Darkshore,37.0,44.1
    .accept 983 >>接任务: 传声盒827号
step
    .goto Darkshore,38.8,43.4
    .accept 2118 >>接任务: 瘟疫蔓延
step
    .goto Darkshore,39.3,43.4
    .accept 984 >>接任务: 熊怪的威胁
step
    .goto Darkshore,36.6,45.6
    .accept 3524 >>接任务: 搁浅的巨兽
step
    .goto Darkshore,36.3,45.6
    .fp Auberdine >>获取奥伯丁飞行路线
step
    #sticky
#completewith Darkshore2
>>杀死爬虫。在执行其他任务时掠夺他们的腿
    .complete 983,1 --Collect Crawler Leg (x6)
step
    .goto Darkshore,36.4,50.9
    .complete 3524,1 --Collect Sea Creature Bones (x1)
step
    .goto Darkshore,38.3,52.7,30,0
    .goto Darkshore,38.9,62.0,30,0
    .goto Darkshore,38.3,52.7,30,0
    .goto Darkshore,38.9,62.0,30,0
    .goto Darkshore,38.3,52.7
    >>继续向南走，直到你找到一只狂犬病熊，当你攻击一只时，用你袋子里的塔纳瑞恩希望
    .complete 2118,1 --Rabid Thistle Bear Captured
step
    #label Darkshore2
.goto Darkshore,39.0,53.2
    .complete 984,1 --Find a corrupt furbolg camp
step
.goto Darkshore,36.7,52.4,40,0
.goto Darkshore,35.6,47.6,40,0
.goto Darkshore,36.2,44.5,40,0
.goto Darkshore,36.7,52.4,40,0
.goto Darkshore,35.6,47.6,40,0
.goto Darkshore,36.2,44.5,40,0
>>杀死爬虫。抢走他们的腿
    .complete 983,1 --Collect Crawler Leg (x6)
step
    .goto Darkshore,36.6,46.3
    .turnin 983 >>交任务: 传声盒827号
step
    .goto Darkshore,36.6,45.6
    .turnin 3524 >>交任务: 搁浅的巨兽
step
    .goto Darkshore,38.8,43.4
    .turnin 2118 >>交任务: 瘟疫蔓延
step
    .goto Darkshore,39.3,43.4
    .turnin 984 >>交任务: 熊怪的威胁
step
    .goto Darkshore,36.6,45.6
    .abandon 1001 >>放弃Buzzbox 411
step
    #sticky
#completewith Azuremyst
+在这里等船
.goto Darkshore,30.8,41.0
step
    .goto Darkshore,30.8,41.0
.abandon 4681 >>废弃冲上岸
step
    #label Azuremyst
    .zone Azuremyst Isle >>前往: 黑海岸
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance Hunter
#name 1-11 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf Hunter
#next 11-14 黑海岸
step << !Gnome !Dwarf
    #sticky
    #completewith next
.goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    >>与Sten Stoutarm交谈
    .accept 179 >>接任务: 矮人的交易
step
    .goto Dun Morogh,29.0,74.4
    .complete 179,1 --Tough Wolf Meat (8)
step
    .goto Dun Morogh,29.93,71.20 << tbc
    .goto Dun Morogh,29.87,71.87 << wotlk
    .turnin 179 >>交任务: 矮人的交易
    .accept 233 >>接任务: 寒脊山谷的送信任务
    .accept 3108 >>接任务: 风蚀符文
step
#xprate <1.5
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .accept 170 >>接任务: 新的威胁
step
#xprate <1.5
    #sticky
    #label Rockjaw
    >>杀死你看到的普通岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
#xprate <1.5
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    .goto Dun Morogh,26.9,72.7,30,0
    .goto Dun Morogh,25.1,72.1,30,0
    >>杀死Burly Rockjaw Troggs
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    >>与塔林·基尼交谈
    .turnin 233 >>交任务: 寒脊山谷的送信任务
    .accept 234 >>接任务: 寒脊山谷的送信任务
    .accept 183 >>接任务: 猎杀野猪
step
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    .goto Dun Morogh,22.2,72.5,40,0
    .goto Dun Morogh,20.5,71.4,40,0
    .goto Dun Morogh,21.1,69.0,40,0
    .goto Dun Morogh,22.8,69.6,40,0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>交任务: 猎杀野猪
step
    .goto Dun Morogh,25.1,75.7
    >>与格雷林·白胡子交谈
    .turnin 234 >>交任务: 寒脊山谷的送信任务
    .accept 182 >>接任务: 巨魔洞穴
step
#completewith next
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
>>杀死霜鬃巨魔幼崽
.complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step
    .xp 4 >>升级到4
step
    #requires Rockjaw
    .goto Dun Morogh,25.0,75.9
    .accept 3364 >>接任务: 热酒快递
step
    #completewith next
    .hs >>炉底回到起始区域
step
#xprate <1.5
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .turnin 170 >>交任务: 新的威胁
step
    .goto Dun Morogh,29.1,67.5
    >>与索加斯·格里姆森交谈
    .turnin 3108 >>交任务: 风蚀符文
        .train 1978 >>火车蛇刺
step
    .goto Dun Morogh,28.8,66.5
    >>与Durnan Furcutter交谈
    .turnin 3364 >>交任务: 热酒快递
    .accept 3365 >>接任务: 归还酒杯
step
    .goto Dun Morogh,25.0,75.9
    .turnin 3365 >>交任务: 归还酒杯
step
#completewith next
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
    .goto Dun Morogh,22.7,79.3,30,0
    .goto Dun Morogh,20.9,75.7,30,0
>>杀死霜鬃巨魔幼崽
.complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step
    .goto Dun Morogh,25.0,75.9
    .turnin 182 >>交任务: 巨魔洞穴
    .accept 218 >>接任务: 被窃取的日记
step
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
.goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
.goto Dun Morogh,28.4,79.7,30,0
.goto Dun Morogh,26.8,79.6,20 >>跑出洞穴
step
    .goto Dun Morogh,25.1,75.7
    .turnin 218 >>交任务: 被窃取的日记
    .accept 282 >>接任务: 森内尔的观察站
step
    .goto Dun Morogh,33.5,71.8
    >>与登山者Thalos交谈
    .turnin 282 >>交任务: 森内尔的观察站
    .accept 420 >>接任务: 森内尔的观察站
step
    .goto Dun Morogh,33.8,72.2
    >>与手对话弹簧链轮
    .accept 2160 >>接任务: 塔诺克的补给品
step
.goto Dun Morogh,34.1,71.6,20,0
.goto Dun Morogh,35.7,66.0,20 >>穿过隧道
step
    #sticky
#completewith BoarMeat3
>>杀死野猪，为稍后获取野猪肉
.collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    #sticky
#completewith BoarRibs
>>杀死野猪，获取野猪肋骨供日后使用
.collect 2886,6 --Collect Crag Boar Rib (x6)
step
    #label BoarMeat3
.goto Dun Morogh,46.7,53.8,100 >>跑到哈拉诺斯
step
    #label BoarRibs
.zone Dun Morogh >>.
step
.goto Dun Morogh,46.7,53.8
    .turnin 420 >>交任务: 森内尔的观察站
step
    .goto Dun Morogh,46.8,52.4
    >>与Ragnar Thunderbrew交谈
    .accept 384 >>接任务: 啤酒烤猪排
step
    .goto Dun Morogh,47.2,52.2
    >>与坦诺克冰锤交谈
    .turnin 2160 >>交任务: 塔诺克的补给品
step
    .goto Dun Morogh,46.0,51.7
    >>与Tharek Blackstone交谈
    .accept 400 >>接任务: 贝尔丁的工具
step
    .goto Dun Morogh,49.5,48.3
    >>与飞行员Bellowfiz交谈
    .accept 317 >>接任务: 贝尔丁的补给
step
#xprate <1.5
    .goto Dun Morogh,49.6,48.5
    >>与Stonegear飞行员交谈
    .accept 313 >>接任务: 灰色洞穴
step
    .goto Dun Morogh,50.1,49.4
    >>与Loslor Rudge交谈
    .accept 5541 >>接任务: 海格纳的弹药
step
    .goto Dun Morogh,50.4,49.1
    >>与Beldin Steelgrill交谈
    .turnin 400 >>交任务: 贝尔丁的工具
step
    #sticky
#completewith BoarRibs2
>>杀死野猪以获得野猪肋骨
.collect 2886,6 --Collect Crag Boar Rib (x6)
step
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
.goto Dun Morogh,52.0,50.1,40,0
.goto Dun Morogh,51.5,53.9,40,0
.goto Dun Morogh,50.1,53.9,40,0
.goto Dun Morogh,49.9,50.9,40,0
.goto Dun Morogh,48.0,49.5,40,0
.goto Dun Morogh,48.2,46.9,40,0
.goto Dun Morogh,43.5,52.5,40,0
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
.complete 317,2 --Collect Thick Bear Fur (x2)
step
    .goto Dun Morogh,49.4,48.4
    >>与飞行员Bellowfiz交谈
    .turnin 317 >>交任务: 贝尔丁的补给
    .accept 318 >>接任务: 艾沃沙酒
step
    .xp 6
step << Hunter
    .goto Dun Morogh,45.8,53.1
    .train 3044 >>火车奥术射击
step
    >>掠夺板条箱
.goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Rumbleshot's Ammo (1)
step
    .goto Dun Morogh,40.7,65.1
    >>与Hegnar Rumbleshot交谈
    .turnin 5541 >>交任务: 海格纳的弹药
step << Hunter
    .goto Dun Morogh,40.7,65.1
    >>购买4级枪升级，如果你没有钱，跳过这一步
    .collect 2509,1
step
#xprate <1.5
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
.goto Dun Morogh,42.5,54.8,40,0
    .goto Dun Morogh,42.4,52.2,40,0
    .goto Dun Morogh,41.0,49.4,40,0
    >>到洞里去。杀死Wendigos。掠夺他们的鬃毛
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    .xp 7
step
>>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,50,0
    .goto Dun Morogh,36.0,52.0,50,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >>接任务: 马克格拉恩的干肉
step
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>单击此处
    .complete 312,1 --MacGrann's Dried Meats (1)
step
    .goto Dun Morogh,34.6,51.6
    .turnin 312 >>交任务: 马克格拉恩的干肉
step
    .goto Dun Morogh,30.2,45.8
    >>与Rejold Barleybrew交谈
    .turnin 318 >>交任务: 艾沃沙酒
    .accept 319 >>接任务: 艾沃沙酒
    .accept 315 >>接任务: 完美烈酒
step
    .goto Dun Morogh,30.2,45.4
    >>与Marleth Barleybrew交谈
    .accept 310 >>接任务: 针锋相对
    #label BoarRibs2
step
    #title Secondary objective
    #completewith next
    >>杀死熊、野猪和豹子
.complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step << Hunter
>>开始返回哈拉诺斯，同时在途中完成其他任务目标。
    .xp 8-1400
    .complete 384,1
step << Hunter
#xprate <1.5
    .goto Dun Morogh,49.6,48.5
    .turnin 313 >>交任务: 灰色洞穴
step
    .goto Dun Morogh,47.4,52.5
    >>向客栈老板购买以下物品：
    .complete 384,2 --Rhapsody Malt (1)
    .collect 2686,1,311 --Thunder Ale
step
    .goto Dun Morogh,47.7,52.6
    >>下楼，把雷霆啤酒给贾文，然后点击无人看守的桶
    .turnin 310 >>交任务: 针锋相对
    .accept 311 >>接任务: 向马莱斯回报
step
    .goto Dun Morogh,47.3,52.5
    .home >>将您的炉石设置为Kharanos
step
    .goto Dun Morogh,46.9,52.4
    >>与Ragnar Thunderbrew交谈
    .turnin 384 >>交任务: 啤酒烤猪排
step
    .goto Dun Morogh,46.7,53.9
    .accept 287 >>接任务: 霜鬃巨魔要塞
step << Hunter
    .goto Dun Morogh,45.8,53.0
    .train 5116>>火车震荡射击
step
    .goto Dun Morogh,63.1,49.8
    >>与Rudra Amberstill交谈
    .accept 314 >>接任务: 保护牲畜
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,12,0
    .goto Dun Morogh,62.2,49.4,8 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
.goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (x)
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >>交任务: 保护牲畜
step
    .goto Dun Morogh,69.1,56.3
    >>与Foreman Stonebrow交谈
    .accept 432 >>接任务: 该死的石腭怪！
step
    >>杀死Troggs
.goto Dun Morogh,70.6,58.7,40,0
    .goto Dun Morogh,67.2,59.4,40,0
    .complete 432,1 --Rockjaw Skullthumper (6)
step
    .goto Dun Morogh,69.1,56.4
    .turnin 432 >>交任务: 该死的石腭怪！
step
    .goto Dun Morogh,68.9,55.9
    .vendor >>供应商垃圾，修理
step
    #completewith next
    .goto Dun Morogh,81.2,42.7,25 >>在路上磨磨蹭蹭，到隧道里去
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >>接任务: 失踪的驾驶员
step
    >>途中研磨
.goto Dun Morogh,79.7,36.2
    .turnin 419 >>交任务: 失踪的驾驶员
    .accept 417 >>接任务: 驾驶员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
.goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >>交任务: 驾驶员的复仇
step << tbc
    #sticky
    #completewith next
    .deathskip >>故意死亡并在哈拉诺斯重生
step << wotlk
    .goto Loch Modan,23.2,17.7
    .zone Loch Modan >>前往: 洛克莫丹
step << wotlk
    >>一旦你到了莫丹湖，你就会故意死去，然后在塞尔萨马尔重生
    .goto Loch Modan,33.9,51.0
    .fp Thelsamar >>获取Thelsamar飞行路线
step << wotlk
    .hs >>赫斯到哈拉诺斯
step
#xprate <1.5
    .goto Dun Morogh,45.8,49.4
    .accept 412 >>接任务: 自动净化装置
step
#completewith next
.goto Dun Morogh,43.1,45.0,20,0
.goto Dun Morogh,42.1,45.4,20 >>跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,30,0
    .goto Dun Morogh,41.5,43.6,30,0
    .goto Dun Morogh,39.7,40.0,30,0
    .goto Dun Morogh,42.1,34.3,30,0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线(LoS)在小屋后面。如果你运气不好，就跑到另一个地方去
    .complete 315,1 --Collect Shimmerweed (x6)
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交任务: 向马莱斯回报
    .turnin 315 >>交任务: 完美烈酒
    .accept 413 >>接任务: 微光酒 << tbc
step
    .goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
.goto Dun Morogh,31.5,38.9,40,0
    .goto Dun Morogh,28.3,39.9,40,0
    .goto Dun Morogh,28.7,43.7,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,25.8,47.2,40,0
    .goto Dun Morogh,30.0,51.8,40,0
    >>杀死熊、野猪和豹子
.complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    .goto Dun Morogh,30.2,45.7
    >>与Rejold Barleybrew交谈
    .turnin 319 >>交任务: 艾沃沙酒
    .accept 320 >>接任务: 艾沃沙酒
step
    #sticky
#label hh
    .complete 287,2 --Frostmane Headhunter (5)
step
    >>小心别死在这里
    .goto Dun Morogh,22.3,50.7,20,0
    .goto Dun Morogh,22.5,51.5,20,0
.goto Dun Morogh,22.7,52.0
    .complete 287,1 --Fully explore Frostmane Hold (1)
step
#xprate <1.5
    #requires hh
    .goto Dun Morogh,27.2,43.0,40,0
    .goto Dun Morogh,24.8,39.3,40,0
    .goto Dun Morogh,25.6,43.4,40,0
    .goto Dun Morogh,24.3,44.0,40,0
    .goto Dun Morogh,25.4,45.4,40,0
.goto Dun Morogh,27.2,43.0,40,0
    .goto Dun Morogh,24.8,39.3,40,0
    .goto Dun Morogh,25.6,43.4,40,0
    .goto Dun Morogh,24.3,44.0,40,0
    .goto Dun Morogh,25.4,45.4,40,0
    >>杀死麻风侏儒。掠夺他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step << tbc
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step << tbc
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step << tbc
.goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
.deathskip >>继续向北奔跑，摔倒死亡，然后重生
step << tbc
.goto Wetlands,12.7,46.7,30 >>游到岸上
step << tbc
.goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
step << tbc
    #completewith next
    .hs >>赫斯回到哈拉诺斯
step
    .goto Dun Morogh,46.7,53.7
    >>与Senir Whitebeard交谈
    .turnin 287 >>交任务: 霜鬃巨魔要塞
    .accept 291 >>接任务: 森内尔的报告
step
#xprate <1.5
    .goto Dun Morogh,45.9,49.4
    >>与Razzle Sprysprocket交谈
    .turnin 412 >>交任务: 自动净化装置
step
    .goto Dun Morogh,49.4,48.3
    >>与飞行员Bellowfiz交谈
    .turnin 320 >>交任务: 艾沃沙酒
step
    .goto Dun Morogh,45.8,53.0
    >>与Grif Wildhart交谈
    .accept 6064 >>接任务: 驯服野兽
step
    .goto Dun Morogh,48.3,56.9
>>点击你包里的驯养棒来驯养一头大野猪。尝试在最大射程(30码)进行
    .complete 6064,1 --Tame a Large Crag Boar (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6064 >>交任务: 驯服野兽
    .accept 6084 >>接任务: 驯服野兽
step
    .goto Dun Morogh,49.4,59.4
>>点击你包里的驯雪豹棒。尝试在最大射程(30码)进行
    .complete 6084,1 --Tame a Snow Leopard (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6084 >>交任务: 驯服野兽
    .accept 6085 >>接任务: 驯服野兽
step
    .goto Dun Morogh,50.4,59.7
>>点击你包里的驯冰爪熊棒。尝试在最大射程(30码)进行
    .complete 6085,1 --Tame an Ice Claw Bear (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6085 >>交任务: 驯服野兽
    .accept 6086 >>接任务: 训练野兽
step << tbc
    #sticky
#completewith next
    +在前往铁炉堡的途中驯服冰爪熊或冬狼
    .goto Dun Morogh,49.0,44.6,30,0
.goto Dun Morogh,45.7,42.2,30,0
step << tbc
    .goto Ironforge,16.5,84.1
.zone Ironforge >>前往: 铁炉堡
step << wotlk
#completewith next
    .tame >>驯服一只8级以上的狼
step << wotlk
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step << wotlk
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step << wotlk
.goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
.deathskip >>继续向北奔跑，摔倒死亡，然后重生
step << wotlk
.goto Wetlands,12.7,46.7,30 >>游到岸上
step << wotlk
.goto Wetlands,9.5,59.7
    .fp Menethil >>获取Menethil Harbor航线
    .fly Ironforge >>飞往铁炉堡
step
    .goto Ironforge,39.6,56.9
    .turnin 291 >>交任务: 森内尔的报告
step
    #sticky
    .money <0.1500
    .goto Ironforge,61.5,89.2
    >>购买9级枪升级
    .collect 2511,1
step
    .goto Ironforge,70.8,85.8
    >>与Belia Thundergrante交谈
    .turnin 6086 >>交任务: 训练野兽
step
#completewith next
.goto Ironforge,77.0,51.0,20 >>进入Deeprun Tram
step
    >>与火车站中间站台的侏儒交谈
    .accept 6661 >>接任务: 捕捉矿道老鼠
step
    .use 17117>>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step << wotlk
    .turnin 6661 >>交任务: 捕捉矿道老鼠
    .accept 6662 >>接任务: 我的兄弟，尼普希
step << wotlk
     >>骑到电车的另一侧，然后转弯
    .turnin 6662 >>交任务: 我的兄弟，尼普希
step << wotlk
    .zone Stormwind City >>前往: 暴风城
step << wotlk
    .goto StormwindClassic,57.0,57.6
    .trainer >>贸易区列车交叉
step << wotlk
    >>前往暴风港
    .zone Darkshore >>前往: 黑海岸
step << tbc
.goto Ironforge,77.0,51.0,40 >>回到铁炉堡
step << tbc
    .goto Ironforge,55.5,47.8
    .fly Menethil >>飞往米奈希尔
step << tbc
    .goto Wetlands,4.6,57.2
    .zone Darkshore >>乘船前往: 黑海岸, 在你等待时做些绷带和磨刀石
]])
