RXPGuides.RegisterGuide([[
#wotlk
#group +专业水准测量
#subgroup 采矿
<< Horde
#name 1-375 部落

step << Mage
    #completewith Makaru
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,65,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .zoneskip Orgrimmar
    .skill mining,65,1
step << !Mage
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,65,1
step
    #sticky
    #label Pick
    .goto Orgrimmar,73.3,26.6,0,0
    >>从Makaru旁边的Gorina购买采矿镐
    .collect 2901,1 --Mining Pick (1)
    .skill mining,65,1
step
    #label Makaru
    .goto Orgrimmar,73.1,26.1
    .train 2575 >>在Orgrimmar的建筑中培训来自Makaru的采矿学徒(1-75)
    .skill mining,65,1
step
    #requires Pick
    #completewith next
    .goto Durotar,45.5,12.2
    .zone Durotar >>前往: 杜隆塔尔
    .skill mining,65,1
step
    #requires Pick
    .openmap Durotar
    .skill mining,65 >>在Durotar从1-65开始平整你的采矿。按“M”打开地图以查看路线。
    .loop 60,Durotar,43.6,21.5,40.9,18.8,39.6,16.2,38.7,21.6,36.8,27.5,39.5,27.0,39.4,28.3,39.2,32.8,41.1,33.7,44.1,33.8,45.7,31.2,47.4,30.9,48.6,34.0,46.9,34.8,48.2,36.7,46.2,38.9,43.6,40.2,41.0,37.3,36.8,35.4,36.8,43.4,37.8,50.3,38.6,52.8,41.6,51.3,43.1,43.5,44.5,49.2,48.0,49.2,48.6,49.3,50.0,50.0,50.7,53.7,51.6,59.5,51.5,61.7,54.7,60.6,56.7,58.9,60.5,59.9,60.2,55.3,57.7,48.2,55.6,40.3,55.5,37.7,53.8,36.2,53.0,29.5,53.6,24.8,53.9,27.8,51.7,27.4,48.2,21.4,43.6,21.5
step << Mage
    #completewith next
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,125,1
step << !Mage
    .goto Orgrimmar,48.8,91.0
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,125,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .zoneskip Orgrimmar
    .skill mining,125,1
step << !Mage
    #completewith next
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,125,1
step
    .goto Orgrimmar,73.1,26.1
    .train 2576 >>Orgrimmar大楼内Makaru的Train Journeyman Mining(75-150)
    .skill mining,125,1
step
    #completewith next
    .goto Orgrimmar,45.1,63.9
    .fly Crossroads >>飞向十字路口
    .zoneskip The Barrens
step
    .skill mining,125 >>在荒地从65-125整平你的采矿[路线1]
    .loop 60,The Barrens,52.7,30.9,54.4,27.4,55.6,26.4,56.2,24.5,58.0,25.0,58.5,26.1,58.9,24.8,57.2,18.8,57.6,16.9,54.4,16.9,53.5,18.6,50.7,12.5,49.0,14.6,47.8,15.8,47.0,15.3,46.9,12.8,44.1,13.0,43.0,14.2,39.6,14.4,38.9,11.7,37.5,16.0,41.0,18.6,40.7,21.7,40.1,24.3,41.9,28.9,43.5,27.0,44.9,25.3,45.4,23.1,49.0,28.5,52.7,30.9
    +65-125[路线2]
    .loop 60,The Barrens,46.6,36.9,46.8,38.9,50.3,41.5,51.1,42.8,55.1,42.8,56.5,43.6,51.7,47.4,49.0,48.8,51.2,51.6,52.1,53.4,52.9,52.6,53.2,54.5,51.7,55.4,51.0,57.8,47.7,66.3,47.3,69.4,48.7,69.5,47.7,72.7,48.5,80.4,48.4,84.0,48.8,87.2,47.0,84.8,44.0,84.4,41.0,80.5,41.1,79.3,44.0,78.2,43.7,74.2,45.7,69.1,43.6,54.8,44.6,54.3,43.8,52.6,44.0,51.4,41.4,45.4,43.5,44.4,43.3,40.2,45.7,37.0,46.6,36.9
step << Mage
    #completewith next
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,175,1
step << !Mage
    .goto The Barrens,51.5,30.3,-1
    .goto The Barrens,44.4,59.2,-1
    .fly Orgrimmar
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,175,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,175,1
    .zoneskip Orgrimmar
step << !Mage
    #completewith next
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,175,1
step
    .goto Orgrimmar,73.1,26.1
    .train 3564 >>在Orgrimmar大楼的Makaru培训专家采矿(150-225)
    .skill mining,175,1
step << Mage
    #completewith next
    .zone Undercity >>前往: 幽暗城
    .skill mining,175,1
step << !Mage
    #completewith next
    .goto Durotar,45.5,12.2
    .zone Durotar >>前往: 杜隆塔尔, 或者使用法师的奥格瑞玛传送门
    .skill mining,175,1
    .zoneskip Undercity
step << !Mage
    .goto Durotar,50.7,13.3,20,0
    .goto Durotar,50.8,13.9
    .zone Stranglethorn Vale >>前往: 荆棘谷, 乘坐飞艇到提瑞斯法林地
    .skill mining,175,1
    .zoneskip Undercity
step << !Mage
    .goto Undercity,66.3,4.4
    .zone Undercity >>前往: 幽暗城
    .skill mining,175,1
    .zoneskip Arathi Highlands
step
    #completewith next
    .goto Undercity,65.9,44.1,50,0
    .goto Undercity,63.3,48.6
    .fly Hammerfall >>飞到Hammerfall
    .skill mining,175,1
    .zoneskip Arathi Highlands
step
    .skill mining,175 >>在阿拉希高地从125-175整平你的采矿
    .loop 60,Arathi Highlands,71.9,31.0,66.4,27.7,63.4,32.6,59.9,36.2,60.9,41.7,53.9,47.8,49.0,51.3,52.0,45.5,52.6,35.4,48.2,38.5,42.4,42.8,40.4,46.6,35.5,44.3,39.1,35.6,42.8,31.6,34.6,22.8,28.8,18.7,29.6,32.0,24.7,30.7,23.9,35.5,21.0,34.1,22.9,42.7,27.5,49.7,30.1,51.4,32.8,62.1,34.3,65.4,39.8,70.7,44.2,75.7,45.6,75.5,52.5,77.3,54.6,74.9,55.1,71.7,59.5,70.6,63.2,72.8,66.1,73.1,68.2,74.4,71.1,68.2,72.0,59.9,69.8,56.7,73.7,45.9,79.2,40.3,81.7,35.8,82.6,39.0,76.6,33.2,75.2,28.8,71.9,31.0
step
    #completewith next
    .goto Arathi Highlands,73.1,32.7
    .fly Revantusk Village >>飞往Revantusk村
    .skill mining,225,1
step
    .skill mining,225 >>在腹地175-225整平你的采矿
    .loop 60,The Hinterlands,70.9,63.3,73.9,58.0,72.9,53.0,76.5,52.4,77.6,48.8,72.9,48.5,64.6,43.0,60.6,38.5,61.7,34.3,67.5,36.2,69.3,27.4,66.1,21.8,67.2,16.5,68.7,14.2,64.2,16.1,58.6,20.7,59.0,28.3,57.3,35.2,57.6,38.3,51.8,47.3,47.6,38.5,46.7,35.7,45.0,41.1,40.7,45.6,38.9,47.4,34.2,42.2,32.2,43.3,32.1,48.8,28.9,53.5,24.9,59.5,26.6,68.0,30.9,62.4,35.8,64.0,34.2,68.5,31.4,70.4,31.5,72.6,34.2,74.0,36.1,68.7,39.7,65.9,45.7,70.0,49.0,65.4,50.7,67.3,52.7,58.3,58.0,51.6,65.7,54.8,66.0,60.7,70.9,63.3
step << Mage
    #completewith next
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,245,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,245,1
    .zoneskip Orgrimmar
step << !Mage
    #completewith next
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill mining,245,1
step
    .goto Orgrimmar,73.1,26.1
    .train 10248 >>在Orgrimmar的建筑中，从Makaru培训工匠采矿(225-300)
    .skill mining,245,1
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,245,1
    .zoneskip Tanaris
    .reputation 989,revered,<0,1
step << Mage
    #completewith next
    .zone Tanaris >>前往: 塔纳利斯, 如果你的时间守护者声望已到达尊敬, 请与塞菲尔交谈, 传送到时光之穴
    .skill mining,245,1
    .skipgossip
    .reputation 989,revered,<0,1
step
    #completewith next
    .goto Orgrimmar,45.1,63.9
    .fly Gadgetzan >>飞到Gadgetzan
    .skill mining,245,1
    .zoneskip Tanaris
step
    >>如果矿脉内有矿脉，请进入硅石蜂巢
    .skill mining,245 >>从塔纳瑞斯的225-245水平开采
    .loop 60,Tanaris,55.9,24.3,54.1,24.6,47.1,23.9,46.7,29.8,43.9,26.0,34.3,26.1,34.3,31.7,36.7,33.4,33.4,37.7,32.8,42.1,29.9,46.4,27.8,56.7,28.2,61.0,30.4,62.8,30.9,67.3,28.2,74.0,30.8,77.2,34.7,80.3,41.7,76.7,44.3,76.1,51.3,79.0,57.8,69.3,58.8,63.2,61.8,53.9,65.3,56.7,69.1,54.6,73.3,53.9,72.3,49.1,71.0,43.6,69.0,41.7,67.0,41.5,55.9,24.3
step
    #completewith next
    .goto Tanaris,51.6,25.4,-1
    .goto Un'Goro Crater,70.7,90.7,-1
    .fly Marshal's Refuge >>从Gadgetzan飞到元帅庇护所，如果更近的话，也可以骑到Un'Goro
    .skill mining,275,1
    .zoneskip Un'Goro Crater
step
    .skill mining,275 >>在Un'Goro陨石坑中从245-275整平采矿
    .loop 60,Un'Goro Crater,48.4,13.8,53.1,30.7,56.1,33.3,62.2,32.3,58.6,23.4,57.7,14.1,63.0,16.8,64.5,20.9,69.5,20.3,71.6,28.1,74.5,34.5,75.6,38.7,78.9,41.8,76.5,43.8,76.2,51.1,76.0,61.2,79.6,59.9,76.0,61.2,74.1,68.0,69.8,68.4,60.8,65.7,61.6,70.1,63.8,79.0,60.4,83.4,56.1,89.5,54.4,86.3,51.0,86.5,44.8,82.6,48.8,80.7,50.7,72.5,54.3,64.9,46.9,65.4,39.0,64.8,37.1,55.5,35.8,53.7,35.7,48.2,33.4,47.7,38.3,37.0,44.5,35.1,44.1,28.8,35.8,22.1,39.6,17.4,44.2,14.5,48.4,13.8
step
    .skill mining,300 >>在Un'Goro火山口275-300处平整采矿
    .loop 60,Un'Goro Crater,48.4,13.8,53.1,30.7,56.1,33.3,62.2,32.3,58.6,23.4,57.7,14.1,63.0,16.8,64.5,20.9,69.5,20.3,71.6,28.1,74.5,34.5,75.6,38.7,78.9,41.8,76.5,43.8,76.2,51.1,76.0,61.2,79.6,59.9,76.0,61.2,74.1,68.0,69.8,68.4,60.8,65.7,61.6,70.1,63.8,79.0,60.4,83.4,56.1,89.5,54.4,86.3,51.0,86.5,44.8,82.6,48.8,80.7,50.7,72.5,54.3,64.9,50.8,53.4,50.8,53.4,53.1,51.3,52.5,47.6,51.7,45.7,47.7,46.8,46.9,51.8,47.9,64.6,39.0,64.8,37.9,78.6,31.8,78.9,32.1,73.6,32.7,70.8,28.9,68.2,25.3,61.4,22.9,58.2,24.2,55.0,24.3,43.1,22.2,41.2,28.1,40.4,32.8,47.7,38.3,37.0,44.5,35.1,44.1,28.8,35.8,22.1,39.6,17.4,44.2,14.5,48.4,13.8
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,325,1
    .zoneskip Hellfire Peninsula
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,325,1
    .zoneskip Hellfire Peninsula
step
    #completewith Krugosh
    .goto Shattrath City,64.1,41.1
    .fly Thrallmar >>飞往萨尔玛
    .skill mining,325,1
    .skill riding,300,1
    .zoneskip Hellfire Peninsula
step
    #completewith next
    .goto Hellfire Peninsula,55.4,37.6
    .zone Hellfire Peninsula >>前往: 地狱火半岛
    .skill herbalism,325,1
    .skill riding,<300,1
step
    #label Krugosh
    .goto Hellfire Peninsula,55.4,37.6
    .train 29354 >>从萨尔玛的克鲁戈什培训采矿大师(300-375)
    .skill mining,325
step
    .skill mining,325 >>在Hellfire Peninsula从300-325整平您的采矿
    .loop 60,Hellfire Peninsula,48.0,58.4,51.5,54.4,53.3,56.4,57.1,52.7,60.4,51.7,59.9,47.9,49.8,48.1,46.6,43.9,48.5,35.8,54.5,30.0,51.8,23.7,49.1,28.3,44.0,29.5,42.1,33.0,40.7,30.0,37.3,30.6,34.6,30.5,33.3,33.9,37.0,39.4,40.0,43.0,41.4,47.8,43.1,55.3,38.8,52.9,37.4,50.0,31.6,48.0,31.1,43.1,28.8,40.8,25.4,46.0,16.6,45.1,16.8,38.9,13.2,37.2,11.2,48.2,7.6,49.9,14.8,60.2,20.6,54.7,23.9,56.5,22.0,63.0,26.2,78.2,28.7,78.7,30.3,71.5,27.4,66.2,30.2,64.3,30.9,60.9,35.5,59.6,35.5,64.2,36.4,69.5,41.5,64.4,43.9,66.9,47.1,65.7,47.2,61.2,48.0,58.4
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,350,1
    .zoneskip Terokkar Forest
step << !Mage
    .goto Terokkar Forest,60.5,24.2
    .zone Terokkar Forest >>前往: 泰罗卡森林
    .skill mining,350,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,350,1
    .zoneskip Terokkar Forest
step
    #completewith next
    .goto Terokkar Forest,39.6,24.8
    .zone Terokkar Forest >>前往: 泰罗卡森林
    .skill mining,350,1
step
    .skill mining,350 >>在Terokkar Forest从325-350水平开采
    .loop 60,Terokkar Forest,30.6,37.2,29.7,48.0,25.3,55.4,19.5,56.1,16.7,70.0,18.3,78.3,26.1,75.9,25.8,65.8,28.8,65.1,30.8,68.9,29.7,76.3,32.5,77.9,41.0,79.8,48.6,80.6,52.5,76.8,55.2,72.8,61.4,72.1,61.4,83.5,69.1,86.7,75.4,87.4,74.4,82.3,70.3,76.6,72.6,73.2,66.3,71.0,63.9,65.1,56.6,65.8,56.8,61.4,51.2,56.4,42.7,48.4,37.8,39.1,45.1,35.1,49.1,36.0,53.1,32.9,56.7,34.5,55.9,39.3,58.2,47.0,64.8,55.1,66.3,53.6,68.6,52.7,71.1,45.0,69.4,38.2,73.0,36.8,71.6,30.8,65.4,31.5,59.9,23.0,54.6,25.2,53.2,27.8,49.1,20.1,50.9,16.6,43.9,10.0,42.2,22.2,39.4,19.2,35.8,7.9,27.8,10.8,23.7,9.5,21.9,11.4,21.3,14.5,30.6,37.2
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,375,1
    .zoneskip Nagrand
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,375,1
    .zoneskip Nagrand
    .cooldown item,6948,>0,1
step
    #completewith next
    .goto Nagrand,77.4,54.6
    .zone Nagrand >>前往: 纳格兰
    .skill mining,375,1
step
    #label Nagrand
    .skill mining,375 >>在Nagrand从350-375调平您的采矿
    .loop 60,Nagrand,70.8,76.0,77.7,59.9,71.6,60.3,70.6,52.1,72.2,43.4,66.1,34.7,68.0,50.3,61.2,55.5,56.9,53.2,56.4,57.9,48.4,50.9,51.5,39.8,50.3,24.7,46.1,20.7,38.9,22.4,45.3,45.8,42.7,49.2,39.5,44.8,37.8,29.6,31.7,28.3,25.6,15.0,27.1,23.6,23.2,29.1,8.0,40.4,9.9,43.7,23.4,48.1,21.0,53.5,28.0,65.1,29.9,71.0,25.4,71.8,28.9,80.8,40.4,83.0,43.1,76.3,43.7,64.1,48.6,79.4,50.7,67.2,57.2,63.3,69.0,81.5,70.8,76.0
step
    +恭喜您达到375 Mining！
]])

RXPGuides.RegisterGuide([[
#wotlk
#group +专业水准测量
#subgroup 采矿
<< Alliance
#name 1-375 联盟

step << Mage
    #completewith Gelman
    .zone Stormwind City >>前往: 暴风城
    .skill mining,65,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,65,1
    .zoneskip Stormwind City
step << !Mage
    .goto Shattrath City,55.8,36.6
    .zone Stormwind City >>前往: 暴风城, 在沙塔斯城使用传送门
    .skill mining,65,1
step
    #sticky
    #label Pick
    .goto Stormwind City,60.2,37.0,20,0
    .goto Stormwind City,59.1,37.5,0,0
     >>在暴风城楼下的布鲁克那里买一把采矿镐
    .collect 2901,1 --Mining Pick (1)
    .skill mining,65,1
step
    #label Gelman
    .goto Stormwind City,59.3,37.9
    .train 2575 >>在暴风城楼上的盖尔曼培训采矿学徒(1-75)
    .skill mining,65,1
step
    #requires Pick
    #completewith next
    .goto Elwynn Forest,32.3,49.9
    .zone Elwynn Forest >>前往: 艾尔文森林
    .skill mining,65,1
step
    #requires Pick
    .openmap Elwynn Forest
    .skill mining,65 >>在Elwynn Forest从1-65开始平整采矿。按“M”打开地图以查看路线。
    .loop 60,Elwynn Forest,37.9,52.6,41.0,52.9,43.8,50.4,50.8,58.8,51.4,65.6,54.7,62.1,60.6,63.4,58.6,57.7,61.8,54.2,65.5,58.6,69.0,68.6,65.8,72.8,58.5,77.5,51.2,85.3,51.0,75.7,46.7,72.6,43.5,76.0,39.1,82.6,38.2,84.6,36.7,81.6,40.5,73.7,37.2,72.2,34.1,71.9,26.7,69.9,27.0,67.4,29.4,63.6,29.3,60.1,31.2,54.9,37.9,52.6
step << Mage
    #completewith next
    .zone Stormwind City >>前往: 暴风城
    .skill mining,125,1
step << !Mage
    .goto Stormwind City,73.0,89.9
    .zone Stormwind City >>前往: 暴风城
    .skill mining,125,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,125,1
    .zoneskip Stormwind City
step << !Mage
    #completewith next
    .goto Shattrath City,55.8,36.6
    .zone Stormwind City >>前往: 暴风城, 在沙塔斯城使用传送门
    .skill mining,125,1
step
    .goto Stormwind City,60.2,37.0,20,0
    .goto Stormwind City,59.3,37.9
    .train 2576 >>在暴风城楼上的房子里，从盖尔曼(Gelman)出发，训练旅行者采矿(75-150)
    .skill mining,125,1
step
    #completewith next
    .goto Stormwind City,68.2,72.9,20,0
    .goto Stormwind City,71.0,72.5
    .fly Lakeshire >>飞往莱克郡
    .skill mining,125,1
    .zoneskip Redridge Mountains
step
    .skill mining,125 >>在雷德里奇山脉从65-125整平您的采矿
    .loop 60,Redridge Mountains,39.8,39.6,47.5,38.8,54.9,44.7,60.7,44.8,71.5,50.0,67.6,52.2,65.7,60.9,61.2,65.1,53.1,76.1,65.0,75.9,70.2,74.4,74.4,83.6,77.4,67.6,81.6,69.5,86.9,61.4,84.2,50.1,80.3,42.7,76.5,36.9,66.6,42.8,60.5,39.7,51.6,40.4,46.1,23.0,41.5,14.4,37.4,13.2,33.6,7.8,37.4,13.2,41.5,14.4,46.1,23.0,45.0,31.5,40.3,32.1,29.5,22.0,24.4,25.5,23.5,32.1,19.8,34.1,20.7,28.2,20.7,37.7,29.1,36.8,39.8,39.6
step << Mage
    #completewith next
    .zone Stormwind City >>前往: 暴风城
    .skill mining,175,1
step << !Mage
    .goto Redridge Mountains,30.6,59.4
    .fly Stormwind
    .zone Stormwind City >>前往: 暴风城
    .skill mining,175,1
    .zoneskip Stormwind City
    .cooldown item,6948,<0,1
step << !Mage
    .hs >>赫斯到沙塔斯城
    .skill mining,175,1
    .zoneskip Stormwind City
step << !Mage
    #completewith next
    .goto Shattrath City,55.8,36.6
    .zone Stormwind City >>前往: 暴风城, 在沙塔斯城使用传送门
    .skill mining,175,1
step
    .goto Stormwind City,60.2,37.0,20,0
    .goto Stormwind City,59.3,37.9
    .train 3564 >>在暴风城楼上的盖尔曼培训专家采矿(150-225)
    .skill mining,175,1
step
    #completewith next
    .goto Stormwind City,68.2,72.9,20,0
    .goto Stormwind City,71.0,72.5
    .fly Refuge Pointe >>飞往避难点
    .skill mining,175,1
    .zoneskip Arathi Highlands
step
    .skill mining,175 >>在阿拉希高地从125-175整平你的采矿
    .loop 60,Arathi Highlands,71.9,31.0,66.4,27.7,63.4,32.6,59.9,36.2,60.9,41.7,53.9,47.8,49.0,51.3,52.0,45.5,52.6,35.4,48.2,38.5,42.4,42.8,40.4,46.6,35.5,44.3,39.1,35.6,42.8,31.6,34.6,22.8,28.8,18.7,29.6,32.0,24.7,30.7,23.9,35.5,21.0,34.1,22.9,42.7,27.5,49.7,30.1,51.4,32.8,62.1,34.3,65.4,39.8,70.7,44.2,75.7,45.6,75.5,52.5,77.3,54.6,74.9,55.1,71.7,59.5,70.6,63.2,72.8,66.1,73.1,68.2,74.4,71.1,68.2,72.0,59.9,69.8,56.7,73.7,45.9,79.2,40.3,81.7,35.8,82.6,39.0,76.6,33.2,75.2,28.8,71.9,31.0
step
    #completewith next
    .goto Arathi Highlands,45.8,46.1
    .fly Aerie Peak >>飞到艾瑞峰
    .skill mining,225,1
    .zoneskip The Hinterlands
step
    .skill mining,225 >>在腹地175-225整平你的采矿
    .loop 60,The Hinterlands,70.9,63.3,73.9,58.0,72.9,53.0,76.5,52.4,77.6,48.8,72.9,48.5,64.6,43.0,60.6,38.5,61.7,34.3,67.5,36.2,69.3,27.4,66.1,21.8,67.2,16.5,68.7,14.2,64.2,16.1,58.6,20.7,59.0,28.3,57.3,35.2,57.6,38.3,51.8,47.3,47.6,38.5,46.7,35.7,45.0,41.1,40.7,45.6,38.9,47.4,34.2,42.2,32.2,43.3,32.1,48.8,28.9,53.5,24.9,59.5,26.6,68.0,30.9,62.4,35.8,64.0,34.2,68.5,31.4,70.4,31.5,72.6,34.2,74.0,36.1,68.7,39.7,65.9,45.7,70.0,49.0,65.4,50.7,67.3,52.7,58.3,58.0,51.6,65.7,54.8,66.0,60.7,70.9,63.3
step << Mage
    #completewith next
    .zone Ironforge >>前往: 铁炉堡
    .skill mining,245,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .zoneskip Ironforge
    .skill mining,245,1
step << !Mage
    #completewith next
    .goto Shattrath City,56.3,36.9
    .zone Ironforge >>前往: 铁炉堡, 使用沙塔斯城的传送门
    .skill mining,245,1
step
    .goto Ironforge,51.8,29.5,15,0
    .goto Ironforge,49.6,28.2,12,0
    .goto Ironforge,49.9,26.3
    .train 3564 >>从铁炉堡楼下的Geofram培训工匠采矿(225-300)
    .skill mining,245,1
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,245,1
    .zoneskip Tanaris
    .reputation 989,revered,<0,1
step << Mage
    .zone Tanaris >>前往: 塔纳利斯, 如果你的时间守护者声望已到达尊敬, 请与塞菲尔交谈, 传送到时光之穴
    .skill mining,245,1
    .skipgossip
    .reputation 989,revered,<0,1
step << Mage
    #completewith next
    .zone Dustwallow Marsh >>前往: 尘泥沼泽
    .skill mining,245,1
    .zoneskip Tanaris
step << !Mage
    #completewith next
    .goto Ironforge,55.5,47.7
    .fly Wetlands >>飞往米奈希尔港
    .skill mining,245,1
    .zoneskip Tanaris
step << !Mage
    .goto Wetlands,5.0,63.5
    .zone Dustwallow Marsh >>在塞拉摩乘船前往: 尘泥沼泽
    .skill mining,245,1
    .zoneskip Tanaris
step
    #completewith next
    .goto Dustwallow Marsh,67.5,51.3
    .fly Gadgetzan >>飞到Gadgetzan
    .skill mining,245,1
    .zoneskip Tanaris
step
    >>如果矿脉内有矿脉，请进入硅石蜂巢
    .skill mining,245 >>从塔纳瑞斯的225-245水平开采
    .loop 60,Tanaris,55.9,24.3,54.1,24.6,47.1,23.9,46.7,29.8,43.9,26.0,34.3,26.1,34.3,31.7,36.7,33.4,33.4,37.7,32.8,42.1,29.9,46.4,27.8,56.7,28.2,61.0,30.4,62.8,30.9,67.3,28.2,74.0,30.8,77.2,34.7,80.3,41.7,76.7,44.3,76.1,51.3,79.0,57.8,69.3,58.8,63.2,61.8,53.9,65.3,56.7,69.1,54.6,73.3,53.9,72.3,49.1,71.0,43.6,69.0,41.7,67.0,41.5,55.9,24.3
step
    #completewith next
    .goto Tanaris,51.0,29.4,-1
    .goto Un'Goro Crater,70.7,90.7,-1
    .fly Marshal's Refuge >>从Gadgetzan飞到元帅庇护所，如果更近的话，也可以骑到Un'Goro
    .skill mining,275,1
    .zoneskip Un'Goro Crater
step
    .skill mining,275 >>在Un'Goro陨石坑中从245-275整平采矿
    .loop 60,Un'Goro Crater,48.4,13.8,53.1,30.7,56.1,33.3,62.2,32.3,58.6,23.4,57.7,14.1,63.0,16.8,64.5,20.9,69.5,20.3,71.6,28.1,74.5,34.5,75.6,38.7,78.9,41.8,76.5,43.8,76.2,51.1,76.0,61.2,79.6,59.9,76.0,61.2,74.1,68.0,69.8,68.4,60.8,65.7,61.6,70.1,63.8,79.0,60.4,83.4,56.1,89.5,54.4,86.3,51.0,86.5,44.8,82.6,48.8,80.7,50.7,72.5,54.3,64.9,46.9,65.4,39.0,64.8,37.1,55.5,35.8,53.7,35.7,48.2,33.4,47.7,38.3,37.0,44.5,35.1,44.1,28.8,35.8,22.1,39.6,17.4,44.2,14.5,48.4,13.8
step
    .skill mining,300 >>在Un'Goro火山口275-300处平整采矿
    .loop 60,Un'Goro Crater,48.4,13.8,53.1,30.7,56.1,33.3,62.2,32.3,58.6,23.4,57.7,14.1,63.0,16.8,64.5,20.9,69.5,20.3,71.6,28.1,74.5,34.5,75.6,38.7,78.9,41.8,76.5,43.8,76.2,51.1,76.0,61.2,79.6,59.9,76.0,61.2,74.1,68.0,69.8,68.4,60.8,65.7,61.6,70.1,63.8,79.0,60.4,83.4,56.1,89.5,54.4,86.3,51.0,86.5,44.8,82.6,48.8,80.7,50.7,72.5,54.3,64.9,50.8,53.4,50.8,53.4,53.1,51.3,52.5,47.6,51.7,45.7,47.7,46.8,46.9,51.8,47.9,64.6,39.0,64.8,37.9,78.6,31.8,78.9,32.1,73.6,32.7,70.8,28.9,68.2,25.3,61.4,22.9,58.2,24.2,55.0,24.3,43.1,22.2,41.2,28.1,40.4,32.8,47.7,38.3,37.0,44.5,35.1,44.1,28.8,35.8,22.1,39.6,17.4,44.2,14.5,48.4,13.8
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,325,1
    .zoneskip Hellfire Peninsula
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,325,1
    .zoneskip Hellfire Peninsula
step
    #completewith Hurnak
    .goto Shattrath City,64.1,41.1
    .fly Honor Hold >>飞到荣誉举行
    .skill mining,325,1
    .skill riding,300,1
    .zoneskip Hellfire Peninsula
step
    #completewith next
    .goto Hellfire Peninsula,56.7,63.8
    .zone Hellfire Peninsula >>前往: 地狱火半岛, 飞往荣耀堡
    .skill herbalism,325,1
    .skill riding,<300,1
step
    #label Hurnak
    .goto Hellfire Peninsula,56.7,63.8
    .train 29354 >>在Honor Hold铁匠内的Hurnak培训采矿大师(300-375)
    .skill mining,325
step
    .skill mining,325 >>在Hellfire Peninsula从300-325整平您的采矿
    .loop 60,Hellfire Peninsula,48.0,58.4,51.5,54.4,53.3,56.4,57.1,52.7,60.4,51.7,59.9,47.9,49.8,48.1,46.6,43.9,48.5,35.8,54.5,30.0,51.8,23.7,49.1,28.3,44.0,29.5,42.1,33.0,40.7,30.0,37.3,30.6,34.6,30.5,33.3,33.9,37.0,39.4,40.0,43.0,41.4,47.8,43.1,55.3,38.8,52.9,37.4,50.0,31.6,48.0,31.1,43.1,28.8,40.8,25.4,46.0,16.6,45.1,16.8,38.9,13.2,37.2,11.2,48.2,7.6,49.9,14.8,60.2,20.6,54.7,23.9,56.5,22.0,63.0,26.2,78.2,28.7,78.7,30.3,71.5,27.4,66.2,30.2,64.3,30.9,60.9,35.5,59.6,35.5,64.2,36.4,69.5,41.5,64.4,43.9,66.9,47.1,65.7,47.2,61.2,48.0,58.4
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,350,1
    .zoneskip Terokkar Forest
step << !Mage
    .goto Terokkar Forest,60.5,24.2
    .zone Terokkar Forest >>前往: 泰罗卡森林
    .skill mining,350,1
    .zoneskip Terokkar Forest
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,350,1
    .zoneskip Terokkar Forest
step
    #completewith next
    .goto Terokkar Forest,39.6,24.8
    .zone Terokkar Forest >>前往: 泰罗卡森林
    .skill mining,350,1
step
    .skill mining,350 >>在Terokkar Forest从325-350水平开采
    .loop 60,Terokkar Forest,30.6,37.2,29.7,48.0,25.3,55.4,19.5,56.1,16.7,70.0,18.3,78.3,26.1,75.9,25.8,65.8,28.8,65.1,30.8,68.9,29.7,76.3,32.5,77.9,41.0,79.8,48.6,80.6,52.5,76.8,55.2,72.8,61.4,72.1,61.4,83.5,69.1,86.7,75.4,87.4,74.4,82.3,70.3,76.6,72.6,73.2,66.3,71.0,63.9,65.1,56.6,65.8,56.8,61.4,51.2,56.4,42.7,48.4,37.8,39.1,45.1,35.1,49.1,36.0,53.1,32.9,56.7,34.5,55.9,39.3,58.2,47.0,64.8,55.1,66.3,53.6,68.6,52.7,71.1,45.0,69.4,38.2,73.0,36.8,71.6,30.8,65.4,31.5,59.9,23.0,54.6,25.2,53.2,27.8,49.1,20.1,50.9,16.6,43.9,10.0,42.2,22.2,39.4,19.2,35.8,7.9,27.8,10.8,23.7,9.5,21.9,11.4,21.3,14.5,30.6,37.2
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill mining,375,1
    .zoneskip Nagrand
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill mining,375,1
    .zoneskip Nagrand
    .cooldown item,6948,>0,1
step
    #completewith next
    .goto Nagrand,77.4,54.6
    .zone Nagrand >>前往: 纳格兰
    .skill mining,375,1
step
    .skill mining,375 >>在Nagrand从350-375调平您的采矿
    .loop 60,Nagrand,70.8,76.0,77.7,59.9,71.6,60.3,70.6,52.1,72.2,43.4,66.1,34.7,68.0,50.3,61.2,55.5,56.9,53.2,56.4,57.9,48.4,50.9,51.5,39.8,50.3,24.7,46.1,20.7,38.9,22.4,45.3,45.8,42.7,49.2,39.5,44.8,37.8,29.6,31.7,28.3,25.6,15.0,27.1,23.6,23.2,29.1,8.0,40.4,9.9,43.7,23.4,48.1,21.0,53.5,28.0,65.1,29.9,71.0,25.4,71.8,28.9,80.8,40.4,83.0,43.1,76.3,43.7,64.1,48.6,79.4,50.7,67.2,57.2,63.3,69.0,81.5,70.8,76.0
step
    +恭喜您达到375 Mining！
]])
