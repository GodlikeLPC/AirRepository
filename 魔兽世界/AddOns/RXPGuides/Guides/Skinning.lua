RXPGuides.RegisterGuide([[
#tbc
#wotlk
#group +专业水准测量
#subgroup 剥皮
<< Horde
#name 1-375 部落

step << Mage
    #completewith Thuwd
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill skinning,75,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .zoneskip Orgrimmar
    .zoneskip Shattrath City
    .skill skinning,75,1
step << !Mage
    #completewith Thuwd
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill skinning,75,1
step
    #sticky
    #label Shank
    .goto Orgrimmar,63.0,45.5,0,0
    >>从图德旁边的塔马尔买一把去皮刀
    .collect 7005,1 --Skinning Knife (1)
    .skill skinning,75,1
step
    #label Thuwd
    .goto Orgrimmar,62.1,45.7,20,0
    .goto Orgrimmar,63.4,45.4
    .train 8613 >>在Orgrimmar的大楼中培训来自Thuwd的剥皮学徒(1-75)
       .skill skinning,75,1
step
    #requires Shank
    #completewith next
    .goto Durotar,45.5,12.2
    .zone Durotar >>前往: 杜隆塔尔
    .skill skinning,75,1
step
    #requires Shank
    .openmap Durotar
    .skill skinning,75 >>在Durotar中，通过杀死野兽、掠夺野兽，然后剥皮，从1-75开始升级你的剥皮。按“M”打开地图以查看路线。
    .loop 45,Durotar,54.5,68.2,54.2,60.1,54.7,58.9,54.5,54.3,51.2,51.8,51.1,46.6,47.4,42.7,45.7,37.7,45.0,34.3,43.0,34.9,42.6,37.0,40.8,37.0,38.5,34.3,36.5,31.3,36.9,25.0,38.5,21.7,40.8,21.1,43.0,21.4,44.4,19.2,43.5,15.7,
step << !Mage
    .goto Orgrimmar,48.8,91.0
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill skinning,125,1
    .cooldown item,6948,<0,1
step << Mage
    #completewith next
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill skinning,125,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,125,1
    .zoneskip Orgrimmar
step << !Mage
    #completewith next
    .goto Shattrath City,52.2,52.9
    .zone Orgrimmar >>前往: 奥格瑞玛
    .skill skinning,125,1
step
    .goto Orgrimmar,62.1,45.7,20,0
    .goto Orgrimmar,63.4,45.4
    .train 8617 >>在Orgrimmar的大楼里，从图德出发，训练旅行者剥皮(75-150)
    .skill skinning,125,1
step
    #completewith next
    .goto Orgrimmar,45.1,63.9
    .fly Crossroads >>飞向十字路口
    .zoneskip The Barrens
    .skill skinning,125,1
step
    >>目标是在到达陶拉霍营地之前达到至少125级技能
    .skill skinning,125 >>在荒野从75-125整平你的皮肤
    .loop 45,The Barrens,51.0,31.7,51.0,35.0,50.2,36.3,49.3,38.0,49.6,39.9,49.0,42.5,50.2,45.4,49.5,47.8,46.0,51.7,45.9,53.7,46.3,56.2,
step
    .goto The Barrens,45.1,59.1
    .train 8618 >>培训Taurajo营地Dranh的专家剥皮(150-225)
    .skill skinning,165,1
step
    .skill skinning,165 >>在荒地从125-165整平你的皮肤
    .loop 45,The Barrens,46.1,59.9,46.9,63.1,46.7,65.3,46.9,68.0,45.6,71.5,45.4,74.6,45.0,77.6,47.1,79.2,46.8,82.0,44.8,85.2
step
    #completewith next
    .goto Thousand Needles,32.1,22.7
    .zone Thousand Needles >>前往: 千针石林
    .skill skinning,205,1
step
    .skill skinning,205 >>在千针165-205之间平整您的皮肤
    .loop 45,Thousand Needles,31.4,25.4,30.8,28.2,31.4,31.2,30.0,34.2,29.9,41.7,31.2,47.5,32.2,52.4,38.8,56.7,42.9,59.7,48.4,59.4,53.3,54.0,57.7,56.5,61.7,60.1,66.6,61.6,69.9,62.7,72.1,67.7,71.8,74.2,72.9,81.3,77.4,84.0,80.9,87.7,78.6,91.1,75.7,89.7
step
    .goto Feralas,88.8,41.4,-1
    .goto Tanaris,51.3,21.4,-1
    .zone Tanaris >>前往: 塔纳利斯
    .skill skinning,230,1
    .zoneskip Feralas
step
    #completewith next
    .goto Tanaris,51.6,25.4
    .fly Camp Mojache >>飞往莫雅奇营地
    .skill skinning,230,1
    .zoneskip Feralas
step
    .goto Feralas,74.7,43.0,12,0
    .goto Feralas,74.5,43.0
    .train 10768 >>在莫贾奇营地的大帐篷中，从库列格训练工匠剥皮(225-300)
    .skill skinning,230,1
step
    .skill skinning,230 >>在费拉拉斯从205-230开始平整您的皮肤
    .loop 45,Feralas,72.3,44.4,71.1,41.5,74.4,40.7,76.7,39.4,76.7,39.4,79.2,38.3,79.7,39.9,79.2,44.1,78.9,46.2,78.3,47.8,76.5,48.7,75.4,51.9,73.1,54.6,
step
    >>杀死洞穴里的野人或外面的鹰头狮，然后剥下它们的皮
    .skill skinning,260 >>在费拉拉斯，从230-260开始平整你的皮肤
    .loop 45,Feralas,58.7,55.0,57.2,56.4,55.3,56.3,56.2,58.3,55.5,62.1,56.1,63.9,54.6,65.4,53.4,68.5,53.8,70.0,54.5,73.6,56.3,73.5,55.5,69.9
step
    >>杀死洞穴里的野人或外面的野兽，然后剥下它们的皮
    .skill skinning,280 >>在费拉拉斯，从260-280开始平整您的皮肤
    .loop 45,Feralas,48.4,37.9,49.9,33.7,52.,31.8,49.4,31.5,49.5,29.3,50.1,26.4,47.6,24.5,45.8,24.6,46.5,27.5,46.3,29.9
step
    #completewith next
    .goto Feralas,75.4,44.4
    >>骑马返回Mojache营地
    .fly Marshal's Refuge >>飞往元帅庇护所
    .zoneskip Un'Goro Crater
    .skill skinning,300,1
step
    .skill skinning,300 >>在Un'Goro陨石坑从280-300整平您的皮肤
    .loop 45,Un'Goro Crater,31.5,28.9,37.1,28.9,42.1,33.4,42.7,40.2,40.7,45.1,34.3,44.6,29.4,40.0,29.4,34.4,31.5,28.9
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill skinning,305,1
    .zoneskip Hellfire Peninsula
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,305,1
    .zoneskip Hellfire Peninsula
step
    #completewith Moorutu
    .goto Shattrath City,64.1,41.1
    .fly Thrallmar >>飞往萨尔玛
    .skill skinning,305,1
    .skill riding,300,1
    .zoneskip Hellfire Peninsula
step
    #completewith next
    .goto Hellfire Peninsula,56.3,38.6
    .zone Hellfire Peninsula >>前往: 地狱火半岛
    .skill skinning,305,1
    .skill riding,<300,1
step
    #label Moorutu
    .goto Hellfire Peninsula,56.3,38.6
    .train 32678 >>从萨尔玛的穆鲁图培训滑雪大师(300-375)
    .skill skinning,305,1
step
    >>杀死饥饿的Helboars，然后剥下它们的皮
    .skill skinning,305 >>在Hellfire半岛从300-305开始平整您的皮肤
    .loop 45,Hellfire Peninsula,61.6,57.2,63.3,61.3,65.3,61.8,68.9,62.0,70.1,64.5,68.1,66.2,65.1,66.6,63.8,69.4,63.6,73.1,63.4,77.2,60.9,77.7,59.0,74.1,56.6,71.8
step
    >>杀死无爪黑豹，然后剥下它们的皮
    .skill skinning,310 >>在Hellfire半岛从305-310开始平整您的皮肤
    .loop 45,Hellfire Peninsula, 47.7,77.9,47.5,73.2,48.6,69.8,49.3,66.7,51.0,66.1,52.4,69.7,53.2,74.0,51.6,78.0,49.6,79.5,47.7,77.9
step
    >>杀死野猪孵化器和野猪掠夺者，然后剥下他们的皮
    .skill skinning,330 >>在Hellfire半岛从310-330整平您的皮肤
    .loop 45,Hellfire Peninsula,41.1,82.5,35.2,87.4,34.7,91.1,37.2,91.8,40.3,88.5,42.4,85.3,41.1,82.5
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill skinning,375,1
    .zoneskip Nagrand
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,375,1
    .zoneskip Nagrand
    .cooldown item,6948,>0,1
step
    #completewith next
    .goto Nagrand,77.4,54.6
    .zone Nagrand >>前往: 纳格兰
    .skill skinning,375,1
step
    >>杀死塔布克和克莱夫蹄，然后剥下它们的皮
    .skill skinning,375 >>在纳格兰从330-375开始平整您的皮肤
    .loop 45,Nagrand,51.3,37.6,52.3,33.6,54.1,30.0,52.8,26.1,50.6,25.3,48.4,26.8,46.6,27.2,46.6,33.6,46.5,40.3,47.0,45.1,49.2,49.2,53.5,53.8,55.3,52.8,57.3,49.8,60.1,48.4,62.0,46.1,60.6,43.4,57.9,42.5,54.7,42.5,52.7,40.7,51.3,37.6
step
    +恭喜您达到375 Skinning！
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
#group +专业水准测量
#subgroup 剥皮
<< Alliance
#name 1-375 联盟

step << Mage
    #completewith Maris
    .zone Stormwind City >>前往: 暴风城
    .skill skinning,75,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,75,1
    .zoneskip Stormwind City
step << !Mage
    .goto Shattrath City,55.8,36.6
    .zone Stormwind City >>前往: 暴风城, 在沙塔斯城使用传送门
    .skill skinning,75,1
step
    #sticky
    #label Shank
    .goto Stormwind City,71.6,62.8,0,0
    >>从Simon旁边的Jillian那里买一把去皮刀
    .collect 7005,1 --Skinning Knife (1)
    .skill skinning,75,1
step
    #label Maris
    .goto Stormwind City,72.6,62.1,12,0
    .goto Stormwind City,72.1,62.2
    .train 8613 >>在暴风城的房子里培训Maris的学徒剥皮(1-75)
    .skill skinning,75,1
step
    #requires Shank
    #completewith next
    .goto Elwynn Forest,32.3,49.9
    .zone Elwynn Forest >>前往: 艾尔文森林
    .skill skinning,75,1
step
    #requires Shank
    .openmap Elwynn Forest
    .skill skinning,75 >>在Elwynn，通过杀死野猪，掠夺野猪，然后剥皮，从1-75开始升级你的剥皮等级。按“M”打开地图以查看路线。
	.loop 25,Elwynn Forest,32.6,83.0,31.0,85.6,32.6,87.8,33.6,85.4,32.6,83.0
step << Mage
    #completewith next
    .zone Ironforge >>前往: 铁炉堡
    .skill skinning,125,1
step << !Mage
    .goto Stormwind City,68.2,72.9,20,0
    .goto Stormwind City,71.0,72.5
    >>返回暴风城
    .fly Ironforge
    .zone Ironforge >>前往: 铁炉堡
    .zoneskip Ironforge
    .skill skinning,125,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,125,1
    .zoneskip Ironforge
step << !Mage
    #completewith next
    .goto Shattrath City,56.3,36.9
    .zone Ironforge >>前往: 铁炉堡, 使用沙塔斯城的传送门
    .skill skinning,125,1
step
    .goto Ironforge,42.1,33.2,15,0
    .goto Ironforge,40.4,35.5,12,0
    .goto Ironforge,39.9,32.5
    .train 8617 >>在铁炉堡的房子里，从巴尔萨斯(Balthus)出发，训练旅行者剥皮(75-150)
    .skill skinning,125,1
step
    #completewith next
    .goto Ironforge,55.5,47.7
    .fly Thelsamar >>飞往塞尔斯马尔
    .skill skinning,125,1
    .zoneskip Loch Modan
step
    .skill skinning,115 >>在莫丹湖从75-115开始平整您的皮肤
    .loop 45,Loch Modan,34.4,53.8,37.7,52.3,41.7,54.4,44.4,64.1,49.9,69.3,55.6,66.9,63.9,63.4,59.4,62.0,63.0,57.0,64.3,48.7,62.2,38.9,59.9,36.9,59.5,29.8,58.9
step
    .skill skinning,125 >>在莫丹湖从115-125开始平整您的皮肤
    .loop 45,Loch Modan,61.5,40.9,72.4,41.8,76.8,47.9,77.4,41.4,59.9,28.0,61.5,40.9
step << Mage
    #completewith next
    .zone Ironforge >>前往: 铁炉堡
    .skill skinning,155,1
step << !Mage
    .goto Loch Modan,33.9,51.0
    >>返回塞尔斯马尔
    .fly Ironforge
    .zone Ironforge >>前往: 铁炉堡
    .zoneskip Ironforge
    .skill skinning,155,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,155,1
    .zoneskip Ironforge
step << !Mage
    #completewith next
    .goto Shattrath City,56.3,36.9
    .zone Ironforge >>前往: 铁炉堡, 使用沙塔斯城的传送门
    .skill skinning,155,1
step
    .goto Ironforge,42.1,33.2,15,0
    .goto Ironforge,40.4,35.5,12,0
    .goto Ironforge,39.9,32.5
    .train 8618 >>在铁炉堡的房子里，从巴尔萨斯培训专家剥皮(150-225)
    .skill skinning,155,1
step
    #completewith next
    .goto Ironforge,55.5,47.7
    .fly Menethil >>飞往米奈希尔港
    .skill skinning,155,1
    .zoneskip Wetlands
step
    .skill skinning,155 >>在湿地中从140-155整平您的皮肤
    .loop 45,Wetlands,31.9,42.0,30.4,45.1,29.9,47.5,27.7,46.7,26.6,47.8,26.5,49.7,24.6,53.8,22.7,57.4,20.2,54.4,18.9,50.7
step
    #completewith next
    .goto Wetlands,9.5,59.7
    >>骑马返回米奈希尔
    .fly Refuge Pointe >>飞往避难点
    .zoneskip Arathi Highlands
step
    .skill skinning,185 >>从155-185年开始在阿拉希高地平整你的皮肤
    .loop 45,Arathi Highlands,44.9,52.8,47.0,54.9,49.7,50.6,52.4,46.0,55.2,48.3,59.4,45.1,64.4,45.4,68.6,39.1,66.8,34.3,64.3,38.0,59.6,38.4,55.5,42.9,51.3,40.4,46.5,41.1,43.3,38.7,42.0,43.4,40.7,48.4,36.2,49.8
step
    .skill skinning,205 >>从185-205年开始，在阿拉希高地平整您的皮肤
    .loop 45,Arathi Highlands,47.2,69.9,46.8,73.0,45.7,76.4,45.6,81.2,48.2,82.6,51.1,74.4,54.1,69.9,56.6,68.0,54.9,62.9,48.7,60.6,47.2,69.9
step << Mage
    #completewith next
    .zone Ironforge >>前往: 铁炉堡
    .skill skinning,230,1
step << !Mage
    .goto Arathi Highlands,45.8,46.1
    >>返回避难所
    .fly Ironforge
    .zone Ironforge >>前往: 铁炉堡
    .zoneskip Ironforge
    .skill skinning,230,1
    .cooldown item,6948,<0,1
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,230,1
    .zoneskip Ironforge
step << !Mage
    #completewith next
    .goto Shattrath City,56.3,36.9
    .zone Ironforge >>前往: 铁炉堡, 使用沙塔斯城的传送门
    .skill skinning,230,1
step
    .goto Ironforge,42.1,33.2,15,0
    .goto Ironforge,40.4,35.5,12,0
    .goto Ironforge,39.9,32.5
    .train 10768 >>在铁炉堡的房子里，从巴尔萨斯培训工匠剥皮(225-300)
    .skill skinning,230,1
step << Mage
    #completewith next
    .zone Dustwallow Marsh >>前往: 尘泥沼泽
    .skill skinning,230,1
step << !Mage
    #completewith next
    .goto Ironforge,55.5,47.7
    .fly Menethil >>飞往米奈希尔港。或者，支付法师一个通往塞拉莫尔的门户
    .skill skinning,230,1
    .zoneskip Dustwallow Marsh
    .zoneskip Feralas
step << !Mage
    .goto Wetlands,5.0,63.5
    .zone Dustwallow Marsh >>在塞拉摩乘船前往: 尘泥沼泽
    .skill skinning,230,1
    .zoneskip Feralas
step
    #completewith next
    .goto Dustwallow Marsh,67.5,51.3
    .fly Thalanaar >>飞往Thalanaar
    .skill skinning,230,1
    .zoneskip Feralas
step
    .skill skinning,230 >>在费拉拉斯从205-230开始平整您的皮肤
    .loop 45,Feralas,72.3,44.4,71.1,41.5,74.4,40.7,76.7,39.4,76.7,39.4,79.2,38.3,79.7,39.9,79.2,44.1,78.9,46.2,78.3,47.8,76.5,48.7,75.4,51.9,73.1,54.6,
step
    >>杀死洞穴里的野人或外面的鹰头狮，然后剥下它们的皮
    .skill skinning,260 >>在费拉拉斯，从230-260开始平整你的皮肤
    .loop 45,Feralas,58.7,55.0,57.2,56.4,55.3,56.3,56.2,58.3,55.5,62.1,56.1,63.9,54.6,65.4,53.4,68.5,53.8,70.0,54.5,73.6,56.3,73.5,55.5,69.9
step
    >>杀死洞穴里的野人或外面的野兽，然后剥下它们的皮
    .skill skinning,280 >>在费拉拉斯，从260-280开始平整您的皮肤
    .loop 45,Feralas,48.4,37.9,49.9,33.7,52.,31.8,49.4,31.5,49.5,29.3,50.1,26.4,47.6,24.5,45.8,24.6,46.5,27.5,46.3,29.9
step << Mage
    #completewith next
    .zone Dustwallow Marsh >>前往: 尘泥沼泽
    .skill skinning,300,1
step
    #completewith next
    .goto Dustwallow Marsh,67.5,51.3 << Mage
    .goto Feralas,30.2,43.2 << !Mage
    >>前往羽毛山寨 << !Mage
    .fly Marshal's Refuge >>飞往元帅庇护所
    .skill skinning,300,1
    .zoneskip Un'Goro Crater
step
    .skill skinning,300 >>在Un'Goro陨石坑从280-300整平您的皮肤
    .loop 45,Un'Goro Crater,31.5,28.9,37.1,28.9,42.1,33.4,42.7,40.2,40.7,45.1,34.3,44.6,29.4,40.0,29.4,34.4,31.5,28.9
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill skinning,330,1
    .zoneskip Hellfire Peninsula
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,330,1
    .zoneskip Hellfire Peninsula
step
    #completewith Jelena
    .goto Shattrath City,64.1,41.1
    .fly Honor Hold >>飞到荣誉举行
    .skill skinning,330,1
    .skill riding,300,1
    .zoneskip Hellfire Peninsula
step
    #completewith next
    .goto Hellfire Peninsula,56.7,63.8
    .zone Hellfire Peninsula >>前往: 地狱火半岛, 飞往荣耀堡
    .skill skinning,330,1
    .skill riding,<300,1
step
    #label Jelena
    .goto Hellfire Peninsula,54.9,63.6,12,0
    .goto Hellfire Peninsula,54.5,63.2
    .train 32678 >>在Jelena的Honor Hold酒店培训滑雪大师(300-375)
    .skill skinning,305,1
step
    >>杀死饥饿的Helboars，然后剥下它们的皮
    .skill skinning,305 >>在Hellfire半岛从300-305开始平整您的皮肤
    .loop 45,Hellfire Peninsula,61.6,57.2,63.3,61.3,65.3,61.8,68.9,62.0,70.1,64.5,68.1,66.2,65.1,66.6,63.8,69.4,63.6,73.1,63.4,77.2,60.9,77.7,59.0,74.1,56.6,71.8
step
    >>杀死无爪黑豹，然后剥下它们的皮
    .skill skinning,310 >>在Hellfire半岛从305-310开始平整您的皮肤
    .loop 45,Hellfire Peninsula, 47.7,77.9,47.5,73.2,48.6,69.8,49.3,66.7,51.0,66.1,52.4,69.7,53.2,74.0,51.6,78.0,49.6,79.5,47.7,77.9
step
    >>杀死野猪孵化器和野猪掠夺者，然后剥下他们的皮
    .skill skinning,330 >>在Hellfire半岛从310-330整平您的皮肤
    .loop 45,Hellfire Peninsula,41.1,82.5,35.2,87.4,34.7,91.1,37.2,91.8,40.3,88.5,42.4,85.3,41.1,82.5
step << Mage
    #completewith next
    .zone Shattrath City >>前往: 沙塔斯城
    .skill skinning,375,1
    .zoneskip Nagrand
step << !Mage
    #completewith next
    .hs >>赫斯到沙塔斯城
    .skill skinning,375,1
    .zoneskip Nagrand
    .cooldown item,6948,>0,1
step
    #completewith next
    .goto Nagrand,77.4,54.6
    .zone Nagrand >>前往: 纳格兰
    .skill skinning,375,1
step
    >>杀死塔布克和克莱夫蹄，然后剥下它们的皮
    .skill skinning,375 >>在纳格兰从330-375开始平整您的皮肤
    .loop 45,Nagrand,51.3,37.6,52.3,33.6,54.1,30.0,52.8,26.1,50.6,25.3,48.4,26.8,46.6,27.2,46.6,33.6,46.5,40.3,47.0,45.1,49.2,49.2,53.5,53.8,55.3,52.8,57.3,49.8,60.1,48.4,62.0,46.1,60.6,43.4,57.9,42.5,54.7,42.5,52.7,40.7,51.3,37.6
step
    +恭喜您达到375 Skinning！
]])
