RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 增强字符58-60
#version 1
#group RestedXP联盟增加了58-60
#defaultfor 58Boost
#next RestedXP 联盟 60-70\59-61 地狱火半岛
step << Warrior
.accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门
--
step << Paladin
    .goto StormwindClassic,37.3,33.0
    .accept 64028 >>接任务: 新的开始
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门
--
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门
--
step << Priest
    .goto StormwindClassic,38.8,26.4
    .accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门

--
step << Mage
    .goto StormwindClassic,38.7,79.3
    .accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门

--
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Warlock
    .goto StormwindClassic,26.1,77.4
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门

--
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .accept 64028 >>接任务: 新的开始
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门

step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64028 >>交任务: 新的开始
    .accept 64031 >>接任务: 生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64031 >>交任务: 生存工具
    .accept 64034 >>接任务: 战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64034 >>交任务: 战斗训练
    .accept 64035 >>接任务: 天赋异禀
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64035 >>交任务: 天赋异禀
    .accept 64038 >>接任务: 黑暗之门
step << skip
    #completewith bs1
    .goto StormwindClassic,78.0,18.2
    .accept 6182 >>接任务: 第一个和最后一个
    >>奥妮克希亚调谐任务中有一个长脚本RP序列，这使得伯瓦尔在几分钟内无法与玩家互动，如果是这样的话，跳过这一步，在完成燃烧的阶梯后再尝试获得这个任务
step
    #label bs1
    .goto StormwindClassic,66.2,62.2
    .complete 64038,1 --Speak to Dungar Longdrink, the Gryphon Master (1)
    .fly Morgan's Vigil>>飞往摩根守夜
step
    .goto Burning Steppes,85.8,69.0
    .accept 4182 >>接任务: 黑龙的威胁
step
    .goto Burning Steppes,87.7,46.1
    .goto Burning Steppes,88.8,37.6
    .goto Burning Steppes,88.3,41.4
    .goto Burning Steppes,88.6,53.4
    .complete 4182,1 --Black Broodling (15)
    .complete 4182,2 --Black Dragonspawn (10)
    .complete 4182,3 --Black Drake (1)
    .complete 4182,4 --Black Wyrmkin (4)
step
    .goto Burning Steppes,85.8,68.9
    .turnin 4182 >>交任务: 黑龙的威胁
    .accept 4183 >>接任务: 真正的主人
step
    .goto Burning Steppes,84.4,68.4
    .fly Lakeshire >>飞往莱克郡
step
    .goto Redridge Mountains,29.8,44.5
    .turnin 4183 >>交任务: 真正的主人
    .accept 4184 >>接任务: 真正的主人
step
    .goto Redridge Mountains,30.58,59.41
    .fly Stormwind>>飞到暴风城
step
    .goto StormwindClassic,78.0,18.2
    .turnin 4184 >>交任务: 真正的主人
    .accept 4185 >>接任务: 真正的主人
-- .accept 6182 >>接任务: 第一个和最后一个
step
    .goto StormwindClassic,78.11,17.75
    >>与Prestor女士交谈
    .complete 4185,1 --Advice from Lady Prestor (1)
step
    .goto StormwindClassic,78.0,18.2
    .turnin 4185 >>交任务: 真正的主人
    .accept 4186 >>接任务: 真正的主人
step << skip
    .goto StormwindClassic,75.9,59.8
    .turnin 6182 >>交任务: 第一个和最后一个
    .accept 6183 >>接任务: 逝者的荣耀
    .turnin 6183 >>交任务: 逝者的荣耀
    .accept 6184 >>接任务: 弗林特·沙多摩尔
step
    .goto StormwindClassic,66.2,62.3
    .fly Lakeshire >>飞往莱克郡
step
    .goto Redridge Mountains,29.8,44.5
    .turnin 4186 >>交任务: 真正的主人
    .accept 4223 >>接任务: 真正的主人
step
    .goto Redridge Mountains,30.6,59.4
    .fly Morgan's Vigil >>飞往摩根守夜
step
    .goto Burning Steppes,84.6,68.9
    .turnin 4223 >>交任务: 真正的主人
step
    .goto Burning Steppes,84.4,68.3
    .fly Southshore >>飞往南岸
step
    .goto Hillsbrad Foothills,51.1,58.9
    .home >>把你的炉石放在南岸
step
    .goto Hillsbrad Foothills,49.4,52.3
    .fly Chillwind Camp >>飞往奇风营地
step
    #completewith mark1
    .goto Western Plaguelands,42.9,84.6,0
    >>与《奇风》中的德莱尼NPC对话
    .accept 9474 >>接任务: 光明使者的印记
    >>任务给予者是长脚本RP序列的一部分，如果你找不到他，请跳过这一步
step
    .goto Western Plaguelands,42.8,84.0
    .accept 5092 >>接任务: 扫清道路
step
    .goto Western Plaguelands,43.4,84.8
    .accept 5903 >>接任务: 瘟疫与你
step << skip
    .goto Western Plaguelands,43.7,84.5
    .turnin 6184 >>交任务: 弗林特·沙多摩尔
    .accept 6185 >>接任务: 东部的瘟疫
step
    #label mark1
    .goto Western Plaguelands,42.9,85.0
    .fly Light's Hope Chapel >>飞向光明的希望教堂
step
    .goto Eastern Plaguelands,79.5,64.0
    .accept 6021 >>接任务: 流亡者塞达尔
    .accept 5281 >>接任务: 永不安息的灵魂
step << Hunter
    #sticky
    .tame 8602 >>如果你的宠物除了咆哮之外没有其他能力，那么在前往普雷格伍德的路上，抛弃你的宠物并驯服一只58级蝙蝠
    >>买些真菌喂你的新宠物
    .collect 8948,20
    .goto Eastern Plaguelands,79.5,64.0
step
    #sticky
    .abandon 5211 >>如果你有这个任务，放弃达罗郡守卫
step
    .goto Eastern Plaguelands,34.0,28.1
	>>在Plaguewood周围寻找白蚁丘
    .complete 5903,1 --Collect Plagueland Termites (x100)
step
    .goto Eastern Plaguelands,14.5,33.7
    .turnin 5281 >>交任务: 永不安息的灵魂
    .accept 5282 >>接任务: 永不安息的灵魂
step
    #completewith next
    .hs >>炉灶到Southshore
step
    .goto Hillsbrad Foothills,49.4,52.3
    .fly Chillwind Camp >>飞往奇风营地
step
    #completewith tower
    .goto Western Plaguelands,42.9,84.6,0
    >>与《奇风》中的德莱尼NPC对话
    .accept 9474 >>接任务: 光明使者的印记
    >>任务给予者是一个长脚本RP序列的一部分，如果他不在奇风，只要在你通过区域进行任务时注意它即可
step
    .goto Western Plaguelands,50.4,76.4
    .complete 5092,2 --Slavering Ghoul (10)
    .complete 5092,1 --Skeletal Flayer (10)
step
    .goto Western Plaguelands,49.19,78.64
    >>与房子里的玛琳·雷德帕斯交谈
    .accept 5142 >>接任务: 小帕米拉
step
    .goto Western Plaguelands,42.8,84.0
    .turnin 5092 >>交任务: 扫清道路
    .accept 5097 >>接任务: 标记哨塔
    .accept 5215 >>接任务: 瘟疫之锅
step
    .goto Western Plaguelands,43.0,84.6
    .turnin 5215 >>交任务: 瘟疫之锅
    .accept 5216 >>接任务: 目标：费尔斯通农场
step
    .goto Western Plaguelands,43.4,84.8
    .turnin 5903 >>交任务: 瘟疫与你
    .accept 5904 >>接任务: 瘟疫与你
step
    .goto Western Plaguelands,40.0,71.8
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,1 --Tower One marked (1)
step
    .goto Western Plaguelands,37.1,56.9
    >>杀死釜主，抢夺釜钥匙
    .turnin 5216 >>交任务: 目标：费尔斯通农场
    .accept 5217 >>接任务: 返回冰风岗
step
    .goto Western Plaguelands,42.3,66.2
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,2 --Tower Two marked (1)
step
    .goto Western Plaguelands,43.0,84.4
    .turnin 5217 >>交任务: 返回冰风岗
    .accept 5219 >>接任务: 目标：达尔松之泪
step
    .goto Western Plaguelands,46.7,71.0
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,4 --Tower Four marked (1)
step
    .goto Western Plaguelands,53.7,64.7
    .accept 4984 >>接任务: 大自然的苦楚
step
	#completewith Businessman
    .goto Western Plaguelands,46.0,47.7,0
	>>病狼与腐烂潜伏者分享产卵。如果你找不到狼，也杀了他们。
    .complete 4984,1 --Kill Diseased Wolf (x8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,47.8,50.8
	>>点击谷仓内的日记
    .turnin 5058 >>交任务: 达尔松夫人的日记
step
	#completewith DalsonsT
    .goto Western Plaguelands,46.9,51.5,0
	>>寻找在农舍周围巡逻的流浪骷髅
    .collect 12738,1 --Collect Dalson Outhouse Key (x1)
	.unitscan Wandering Skeleton
step
    .goto Western Plaguelands,46.0,52.4
    .complete 5219,1 --Collect Dalson's Tears Cauldron Key (x1)
step
	#label DalsonsT
    .goto Western Plaguelands,46.2,52.1
    .turnin 5219 >>交任务: 目标：达尔松之泪
    .accept 5220 >>接任务: 返回冰风岗
step
    .goto Western Plaguelands,46.9,51.5
	>>寻找在农舍周围巡逻的流浪骷髅
    .collect 12738,1 --Collect Dalson Outhouse Key (x1)
	.unitscan Wandering Skeleton
step
	#completewith next
    .goto Western Plaguelands,48.2,49.7
	>>在睡觉前确保身体健康
    .turnin 5059 >>交任务: 被锁起来的农夫
step
    .goto Western Plaguelands,48.2,49.7
	>>杀死Farmer Dalson。抢他的钥匙
    .collect 12739,1 --Collect Dalson Cabinet Key (x1)
step
    .goto Western Plaguelands,47.4,49.7
	>>点击农舍顶层的橱柜
    .turnin 5060 >>交任务: 被锁起来的农夫
step
    .goto Western Plaguelands,48.4,31.9
    .turnin 5904 >>交任务: 瘟疫与你
    .accept 6389 >>接任务: 瘟疫与你
step
    .goto Western Plaguelands,51.9,28.1
    .accept 6004 >>接任务: 未竟的事业
step
    .goto Western Plaguelands,52.0,44.3,70,0
    .goto Western Plaguelands,50.3,41.1,70,0
    .goto Western Plaguelands,40.7,52.2,70,0
    .goto Western Plaguelands,50.3,41.1,70,0
    .goto Western Plaguelands,52.0,44.3
	>>杀死血腥暴徒。如果你找不到医护人员和猎人，在营地杀死暴徒，迫使他们重生，因为他们与其他暴徒类型共享重生
	>>如果你找不到法师，杀死骑士(因为他们共享后代)
    .complete 6004,1 --Scarlet Medic (2)
    .complete 6004,2 --Scarlet Hunter (2)
    .complete 6004,3 --Scarlet Mage (2)
    .complete 6004,4 --Scarlet Knight (2)
step
    .goto Western Plaguelands,51.9,28.1
    .turnin 6004 >>交任务: 未竟的事业
    .accept 6023 >>接任务: 未竟的事业
step
	#label Businessman
    .goto Western Plaguelands,55.1,23.5
    >>寻找在塔楼上下巡逻的指定暴徒
    .complete 6023,2 --Kill Cavalier Durgen (x1)
    *There is a level 63 elite mob that can spawn at the tower, if that's the case just be patient and wait for Durgen to come down
	.unitscan Cavalier Durgen
step
    #label tower
    .goto Western Plaguelands,55.1,23.5
    >>掠夺塔顶的箱子，如果63级稀有精英挡道，请跳过此步骤
    .complete 9474,1 --Collect Mark of the Lightbringer (x1)
    .isOnQuest 9474
step
    .goto Western Plaguelands,57.5,35.2
    .complete 6023,1 --Huntsman Radley (1)
step
    .goto Western Plaguelands,52.0,28.1
    .turnin 6023 >>交任务: 未竟的事业
    .accept 6025 >>接任务: 未竟的事业
step
	>>跑到Hearthglen的塔顶
    .goto Western Plaguelands,45.6,18.6
    .complete 6025,1 --Overlook Hearthglen from a high vantage point (1)
step
    .goto Western Plaguelands,52.0,28.1
    .turnin 6025 >>交任务: 未竟的事业
step
    .goto Western Plaguelands,51.2,53.3,70,0
    .goto Western Plaguelands,46.9,47.0,70,0
    .goto Western Plaguelands,50.4,35.0,70,0
    .goto Western Plaguelands,45.6,37.7,70,0
    .goto Western Plaguelands,42.8,56.7,70,0
    .goto Western Plaguelands,51.2,53.3
	>>病狼与腐烂潜伏者分享产卵。如果你找不到狼，也杀了他们。
    .complete 4984,1 --Kill Diseased Wolf (x8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,44.3,63.2
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,3 --Tower Three marked (1)
step
    .goto Western Plaguelands,42.7,84.1
    .turnin 5097 >>交任务: 标记哨塔
    .accept 5533 >>接任务: 通灵学院
step
    .goto Western Plaguelands,42.69,83.90
    .turnin 5533 >>交任务: 通灵学院
    .accept 5537 >>接任务: 骸骨碎片
step
    .goto Western Plaguelands,42.94,84.42
    .turnin 5220 >>交任务: 返回冰风岗
    .accept 5222 >>接任务: 目标：嚎哭鬼屋
step
    .goto Western Plaguelands,42.94,84.42
    .turnin 9474 >>交任务: 光明使者的印记
    .isQuestComplete 9474
step
    .goto Western Plaguelands,43.5,84.9
    .turnin 6389 >>交任务: 瘟疫与你
step
    .goto Western Plaguelands,39.4,66.9
    .accept 4971 >>接任务: 时间问题
step
    #completewith next
    >>在安多哈尔杀死骷髅。掠夺他们的碎片
    .goto Western Plaguelands,42.10,69.98,0
    .complete 5537,1 --Skeletal Fragments (15)
step
	>>使用Andorhal中发光筒仓旁边的临时置换器。杀死产卵的暂时寄生虫
    .goto Western Plaguelands,48.2,66.5
    .complete 4971,1 --Temporal Parasite (10)
step
    >>在安多哈尔杀死骷髅。掠夺他们的碎片
    .goto Western Plaguelands,42.10,69.98
    .complete 5537,1 --Skeletal Fragments (15)
step
    .goto Western Plaguelands,53.0,65.8
    .turnin 5222 >>交任务: 目标：嚎哭鬼屋
    .accept 5223 >>接任务: 返回冰风岗
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4984 >>交任务: 大自然的苦楚
    .accept 4985 >>接任务: 大自然的苦楚
step
    .goto Western Plaguelands,53.9,51.3
	>>患病灰熊与瘟疫潜伏者共享产卵。如果你找不到灰熊，也杀了他们。
    .complete 4985,1 --Diseased Grizzly (8)
	.unitscan Diseased Grizzly
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4985 >>交任务: 大自然的苦楚
    .accept 4986 >>接任务: 雕文橡木枝 << !Shaman !Warlock !Paladin
step
    .goto Western Plaguelands,42.9,84.5
    .turnin 5223 >>交任务: 返回冰风岗
    .accept 5225 >>接任务: 目标：盖罗恩农场
step
    .goto Western Plaguelands,62.6,58.7
    .turnin 5225 >>交任务: 目标：盖罗恩农场
    .accept 5226 >>接任务: 返回冰风岗
step
	>>去地下室的底部
    .goto Eastern Plaguelands,27.3,85.3
    .complete 6021,1 --Zaeldarr's Head (1)
step << skip
    .goto Eastern Plaguelands,28.8,79.8
	>>单击地面上的骨架。抢走徽章
    .complete 6185,2 --SI:7 Insignia (Rutger) (1)
step << skip
    .goto Eastern Plaguelands,28.8,74.9
	>>单击地面上的骨架。抢走徽章
    .complete 6185,4 --SI:7 Insignia (Turyen) (1)
step << skip
    .goto Eastern Plaguelands,27.2,75.0
	>>单击地面上的骨架。抢走徽章
    .complete 6185,3 --SI:7 Insignia (Fredo) (1)
    .complete 6185,1 --The Blightcaller Uncovered (1)
step
    .goto Eastern Plaguelands,36.5,90.9
    .turnin 5142 >>交任务: 小帕米拉
    .accept 5149 >>接任务: 帕米拉的洋娃娃
step
	#completewith next
    .goto Eastern Plaguelands,38.14,92.43,20,0
    .goto Eastern Plaguelands,39.61,92.60,20,0
    .goto Eastern Plaguelands,39.60,90.00
    >>掠夺达罗郡建筑物周围的3个玩偶部件。每次尝试掠夺时，都会生成一个鬼魂
	.collect 12886,1
	.collect 12887,1
	.collect 12888,1
step
    .goto Eastern Plaguelands,36.4,90.8
    >>点击任意一个玩偶部件，将其组合在一起
    .complete 5149,1 --Pamela's Doll (1)
step
    .goto Eastern Plaguelands,36.4,90.8
    .turnin 5149 >>交任务: 帕米拉的洋娃娃
    .accept 5152 >>接任务: 玛莱恩姑妈
    .accept 5241 >>接任务: 卡林叔叔
step
    #completewith next
    .hs >>炉灶到Southshore
step
    .goto Eastern Plaguelands,81.6,59.3
    .fly Chillwind Camp >>飞往奇风营地
step
    .goto Western Plaguelands,42.9,84.5
    .turnin 5226 >>交任务: 返回冰风岗
step
    .goto Western Plaguelands,42.7,84.1
    .turnin 5237 >>交任务: 任务完成！
step
    .goto Western Plaguelands,42.7,83.8
    .turnin 5537 >>交任务: 骸骨碎片
step << skip
    .goto Western Plaguelands,43.6,84.4
    .turnin 6185 >>交任务: 东部的瘟疫
    .accept 6186 >>接任务: 凋零者
step
    .goto Western Plaguelands,49.1,78.5
    .turnin 5152 >>交任务: 玛莱恩姑妈
    .accept 5153 >>接任务: 古怪的历史学家
step
    .goto Western Plaguelands,49.6,76.7
	>>盗取房子外面的墓碑
    .complete 5153,1 --Joseph's Wedding Ring (1)
step
    .goto Western Plaguelands,39.46,66.90
    .turnin 4971 >>交任务: 时间问题
    .accept 4972 >>接任务: 找回时间
    .turnin 5153 >>交任务: 古怪的历史学家
    .accept 5154 >>接任务: 达隆郡的历史
step
    #completewith next
    .goto Western Plaguelands,40.4,66.5,0
    >>在被烧毁的房子里寻找小锁盒。每间房子应该有一个
    .complete 4972,1 --Andorhal Watch (5)
step
    .goto Western Plaguelands,43.4,69.6
	>>在安多哈尔市政厅内掠夺书籍，直到找到正确的书籍
    .complete 5154,1 --Collect Annals of Darrowshire (x1)
	*The correct book's pages has a lighter shade of grey and sometimes the correct book won't spawn
	*If you're unlucky, you have to keep looting bad tomes until a good one spawns
step
    .goto Western Plaguelands,40.4,66.5
    >>在被烧毁的房子里寻找小锁盒。每间房子应该有一个
    .complete 4972,1 --Andorhal Watch (5)
step
    .goto Western Plaguelands,39.45,66.88
    .turnin 4972 >>交任务: 找回时间
    .turnin 5154 >>交任务: 达隆郡的历史
    .accept 5210 >>接任务: 卡林·雷德帕斯
step
    .goto Western Plaguelands,42.9,85.0
    .fly Light's Hope Chapel >>飞向光明的希望教堂
step
    .goto Eastern Plaguelands,81.51,59.81
    >>与Carlin Redpath交谈
    .turnin 5241 >>交任务: 卡林叔叔
    .turnin 5210 >>交任务: 卡林·雷德帕斯
    .accept 5181 >>接任务: 达隆郡的恶魔
step
    .goto Eastern Plaguelands,79.7,63.7
    .turnin 6021 >>交任务: 流亡者塞达尔
step
    #completewith next
    .goto Eastern Plaguelands,51.41,49.70
    .xp 60-8750 >>研磨xp直到距离60级8750xp
step
    >>如果你还需要xp，那么做达罗郡的恶棍
    .complete 5181,1 --Skull of Horgus (1)
    .goto Eastern Plaguelands,51.41,49.70
    .complete 5181,2 --Shattered Sword of Marduk (1)
    .goto Eastern Plaguelands,53.90,65.71
    .turnin 5181 >>交任务: 达隆郡的恶魔
    .goto Eastern Plaguelands,81.52,59.87
step
    .goto Eastern Plaguelands,81.64,59.28
    .fly Stormwind >>飞到暴风城
step << skip
    .goto StormwindClassic,77.9,18.2
    .turnin 6186 >>交任务: 凋零者
]])
