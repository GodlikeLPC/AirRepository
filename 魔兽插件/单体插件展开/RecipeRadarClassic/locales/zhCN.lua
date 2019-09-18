local L = LibStub("AceLocale-3.0"):NewLocale("RecipeRadarClassic", "zhCN",false)
if not L then return end

   -- the name of the addon!
--L["Recipe Radar Classic"] = true

L["Left-click to open RecipeRadar."] = "Left-click 打开 RecipeRadar."
L["Right-click and drag to move this button."] = "Right-click 并拖拽此按钮"

   -- these show up in the game's Key Bindings screen
L["Recipe Radar Bindings"] = "Recipe Radar按键绑定"
L["Toggle Recipe Radar"] = "开关Recipe Radar"

   -- options button and corresponding options frame
L["Options"] = "选项"
L["Auto-map Contributive Vendors"] = true
L["Auto-select Current Region"] = "自动选择当前地区"
L["Check Availability for Alts"] = "检查别名的可用性"
L["Minimap Button Position"] = "迷你地图按钮位置"
L["Show Minimap Button"] = "显示迷你地图按钮"

   -- format strings used in the map tooltips
L["1 recipe"] = "1 配方"
L["%d learnable"] = "%d 可学习"
L["%d recipes"] = "%d 配方"

   -- this appears when the recipe is not in your local database
L["Uncached Recipe"] = "未缓存的配方"

   -- uncached recipe tooltip - see RecipeRadar_Availability_CreateTooltip()
L["You may mouse over the"] = true
L["icon to lookup this recipe."] = true
L["Warning: if your server has"] = true
L["not yet seen this item, you"] = true
L["will be disconnected!"] = true

   -- some regions don't have any recipes for sale
L["No recipes for sale in this region."] = "此区域没有配方可供出售"

   -- radio button (and tooltip) that indicates a mapped vendor
L["Locate Vendor on Map"] = "在地图上标记商人位置"
L["Shift-click a vendor to add or remove her location on the world map."] = "Shift-单击商人可以增加/删除他在地图上的位置"

   -- strings in the faction filtering dropdown; we don't need 'Horde' or 'Alliance' because Blizzard provides them for us
L["Factions"] = "阵营"
L["Neutral"] = "中立"

   -- profession filtering dropdown - these strings must match those returned by GetTradeSkillLine() and GetCraftDisplaySkillLine()
L["Professions"] = "专业"
L["Alchemy"] = "炼金术"
L["Blacksmithing"] = "锻造"
L["Cooking"] = "烹饪"
L["Enchanting"] = "附魔"
L["Engineering"] = "工程学"
L["First Aid"] = "急救"
L["Fishing"] = "钓鱼"
L["Herbalism"] = "采药"
L["Inscription"] = "铭文"
L["Jewelcrafting"] = "珠宝加工"
L["Leatherworking"] = "制皮"
L["Mining"] = "采矿"
L["Skinning"] = "剥皮"
L["Tailoring"] = "裁缝"

   -- strings in the availability filtering dropdown
L["Availability"] = "可用性过滤"
L["Already Known (Alts)"] = "已学会（所有）"
L["Already Known (Player)"] = "已学会（当前）"
L["Available Now (Alts)"] = "可用（所有）"
L["Available Now (Player)"] = "可用（当前）"
L["Future Prospect (Alts)"] = "不可用（所有）"
L["Future Prospect (Player)"] = "不可用（当前）"
L["Inapplicable"] = "不符合"

   -- headings for the availability tooltip
L["Available For:"] = "可用："
L["Already Known By:"] = "已学会："
L["Future Prospect For:"] = "不可用："

   -- format string for rank indicator for future prospects; that is, it tells you how soon you can learn the recipe - eg. "163 of 175"
L["%d of %d"] = true

   -- special notes for vendor requirements follow vendor names (eg. "Seasonal Vendor")
L["%s Vendor"] = "%s商人"
L["Intermittent"] = "偶时的"
L["Quest"] = "任务"
L["Roving"] = "移动的"
L["Seasonal"] = "季节性"

   -- other recipe requirements
L["Rogue Only"] = true
L["%s Only"] = true
L["Rogue"] = true
L["Special"] = true

   -- menu item in the right-click context menu for mapped vendor buttons
L["Unmap Vendor"] = true
L["Collapse"] = true
L["Collapse All"] = true
L["Expand"] = true
L["Expand All"] = true
L["Map Vendor"] = true

   -- trade skill specialties
   L["Gnomish Engineer"] = "侏儒工程学"
   L["Armorsmith"] = "防具锻造"
   L["Dragonscale Leatherworking"] = "龙鳞制皮"
   L["Elemental Leatherworking"] = "元素制皮"
   L["Goblin Engineer"] = "地精工程学"
   L["Master Axesmith"] = "大师级铸斧"
   L["Master Hammersmith"] = "大师级铸锤"
   L["Master Swordsmith"] = "大师级铸剑"
   L["Mooncloth Tailoring"] = "月布裁缝"
   L["Shadoweave Tailoring"] = "暗纹裁缝"
   L["Spellfire Tailoring"] = "魔焰裁缝"
   L["Tribal Leatherworking"] = "部族制皮"
   L["Weaponsmith"] = "武器锻造"

   -- continent names for alternate region selection
   L["Kalimdor"] = "卡里姆多"
   L["Eastern Kingdoms"] = "东部王国"
   L["Instances"] = "副本"
   L["Northrend"] = "诺森德"
   L["Outland"] = "外域"

   -- some vendor names may need translating
L["\"Chef\" Overheat"] = true
   L["\"Cookie\" McWeaksauce"] = "“曲奇”米维克索斯"
   L["Aaron Hollman"] = "埃隆·霍尔曼"
   L["Abigail Shiel"] = "阿比盖尔·沙伊尔"
   L["Aendel Windspear"] = "安迪尔·风矛"
L["Agatian Fallanos"] = true
   L["Aged Dalaran Wizard"] = "老迈的达拉然巫师"
   L["Ainderu Summerleaf"] = "埃德尔鲁·夏叶"
L["Alchemist Finklestein"] = true
   L["Alchemist Gribble"] = "炼金师格里比"
   L["Alchemist Pestlezugg"] = "炼金师匹斯特苏格"
   L["Aldraan"] = "阿尔德兰"
   L["Alexandra Bolero"] = "亚历山德拉·波利罗"
   L["Algernon"] = "奥格诺恩"
   L["Almaador"] = "奥玛多尔"
   L["Altaa"] = "奥泰恩"
   L["Alurmi"] = "艾鲁尔米"
   L["Alys Vol'tyr"] = "奥莉丝·沃泰尔"
   L["Amy Davenport"] = "艾米·达文波特"
   L["Andormu"] = "安多尔姆"
   L["Andrew Hilbert"] = "安德鲁·希尔伯特"
   L["Andrion Darkspinner"] = "安迪恩·达克斯宾"
   L["Androd Fadran"] = "安多德·法德兰"
L["Anuur"] = true
   L["Apothecary Antonivich"] = "药剂师安东尼维奇"
   L["Apprentice Darius"] = "学徒达里乌斯"
L["Apprentice of Estulan"] = true
   L["Archmage Alvareaux"] = "大法师奥瓦利斯"
   L["Aresella"] = "阿蕾瑟拉"
   L["Argent Quartermaster Hasana"] = "银色黎明军需官哈萨娜"
   L["Argent Quartermaster Lightspark"] = "银色黎明军需官莱斯巴克"
   L["Arille Azuregaze"] = "埃里雷"
L["Aristaleon Sunweaver"] = true
   L["Arras"] = "阿尔拉斯"
   L["Arred"] = "阿尔雷德"
   L["Arrond"] = "阿隆德"
   L["Asarnan"] = "阿萨纳"
L["Ayla Shadowstorm"] = true
   L["Balai Lok'Wein"] = "巴莱·洛克维"
   L["Bale"] = "拜尔"
   L["Banalash"] = "巴纳拉什"
L["Bario Matalli"] = true
   L["Blackwing"] = "黑翼"
   L["Blimo Gadgetspring"] = "布里莫"
   L["Blixrez Goodstitch"] = "布里克雷兹·古斯提"
   L["Blizrik Buckshot"] = "布雷兹里克·巴克舒特"
   L["Bliztik"] = "布里兹提克"
   L["Bombus Finespindle"] = "伯布斯·钢轴"
   L["Borto"] = "波尔图"
   L["Borya"] = "博亚"
L["Bountiful Barrel"] = true
   L["Bradley Towns"] = "布拉德雷·汤斯"
   L["Braeg Stoutbeard"] = "布莱格·酒须"
   L["Brienna Starglow"] = "布琳娜·星光"
   L["Bro'kin"] = ""
   L["Bronk"] = "布隆克"
L["Brundall Chiselgut"] = true
   L["Bryan Landers"] = "比尔亚·兰德斯"
L["Buckslappy"] = true
   L["Burbik Gearspanner"] = "巴比克·齿轮"
   L["Burko"] = "布尔库"
L["Captain Samir"] = true
   L["Captured Gnome"] = "被俘虏的侏儒"
L["Casandra Downs"] = true
   L["Catherine Leland"] = "凯瑟琳·利兰"
L["Chapman"] = true
L["Christoph Jeffcoat"] = true
   L["Cielstrasza"] = "希尔丝塔萨"
   L["Clyde Ranthal"] = "克莱德·兰萨尔"
   L["Constance Brisboise"] = "康斯坦茨·布里斯博埃斯"
   L["Cookie One-Eye"] = "独眼曲奇"
   L["Coreiel"] = "克蕾伊尔"
   L["Corporal Bluth"] = "布鲁斯下士"
   L["Cowardly Crosby"] = "怯懦的克罗斯比"
   L["Crazk Sparks"] = "克拉赛·斯巴克斯"
   L["Cro Threadstrong"] = "克鲁·粗线"
   L["Daga Ramba"] = "达加·拉姆巴"
   L["Daggle Ironshaper"] = "达格尔·塑铁"
L["Dalni Tallgrass"] = true
   L["Dalria"] = "达利亚"
L["Damek Bloombeard"] = true
   L["Daniel Bartlett"] = "丹尼尔·巴特莱特"
   L["Danielle Zipstitch"] = "丹尼勒·希普斯迪"
   L["Darian Singh"] = "达利安·辛格"
   L["Darnall"] = "旅店老板达纳尔"
   L["Dealer Malij"] = "商人玛里耶"
   L["Defias Profiteer"] = "迪菲亚奸商"
   L["Deneb Walker"] = "德尼布·沃克"
   L["Derak Nightfall"] = "德拉克·奈特弗"
   L["Derek Odds"] = "德里克·奥斯"
L["Desaan"] = true
   L["Deynna"] = "德伊娜"
   L["Dirge Quikcleave"] = "迪尔格·奎克里弗"
   L["Doba"] = "度巴"
   L["Doris Volanthius"] = "桃丽丝·沃兰休斯"
   L["Drac Roughcut"] = "德拉克·卷刃"
L["Draelan"] = true
   L["Drake Lindgren"] = "德拉克·林格雷"
   L["Drovnar Strongbrew"] = "德鲁纳·烈酒"
   L["Duchess Mynx"] = "女公爵麦恩克丝"
   L["Edna Mullby"] = "艾德娜·穆比"
   L["Eebee Jinglepocket"] = "伊比·吉波克"
   L["Egomis"] = "艾苟米斯"
   L["Eiin"] = "伊恩"
   L["Eldara Dawnrunner"] = "艾尔达拉·晨行者"
L["Elizabeth Barker Winslow"] = true
   L["Elynna"] = "艾琳娜"
   L["Emrul Riknussun"] = "埃姆鲁尔·里克努斯"
   L["Enchantress Andiala"] = ""
   L["Eriden"] = "恩里德"
   L["Erika Tate"] = "艾瑞卡·塔特"
   L["Erilia"] = "艾瑞丽亚"
   L["Evie Whirlbrew"] = "埃文·维布鲁"
   L["Fariel Starsong"] = "法蕾尔·星歌"
   L["Fazu"] = "法苏"
   L["Fedryen Swiftspear"] = "芬德雷·迅矛"
   L["Feera"] = "菲拉"
   L["Felannia"] = "菲兰妮娅"
   L["Felicia Doan"] = "菲利希亚·杜安"
   L["Felika"] = "菲利卡"
   L["Fizzix Blastbolt"] = ""
   L["Fradd Swiftgear"] = "弗拉德"
L["Frozo the Renowned"] = true
   L["Fyldan"] = "菲尔丹"
   L["Gagsprocket"] = "加格斯普吉特"
   L["Galley Chief Alunwea"] = "厨师长奥鲁维恩"
   L["Galley Chief Gathers"] = "厨师长加瑟斯"
   L["Galley Chief Grace"] = "厨师长格莱斯"
   L["Galley Chief Halumvorea"] = "厨师长哈鲁沃雷"
   L["Galley Chief Mariss"] = "厨师长玛里斯"
   L["Galley Chief Steelbelly"] = "厨师长拜雷·钢胃"
   L["Gambarinka"] = "加巴林卡"
   L["Gara Skullcrush"] = "迦拉·裂颅者"
   L["Gearcutter Cogspinner"] = "考格斯宾"
   L["Geen"] = "吉恩"
   L["Gelanthis"] = "基兰希斯"
   L["George Candarte"] = "乔治·坎达特"
   L["Gharash"] = "卡尔拉什"
   L["Ghok'kah"] = "格鲁克卡恩"
   L["Gidge Spellweaver"] = "金吉·斯比维尔"
   L["Gigget Zipcoil"] = "吉盖特·火油"
   L["Gikkix"] = "吉科希斯"
   L["Gina MacGregor"] = "吉娜·马克葛瑞格"
   L["Gloria Femmel"] = "格劳瑞亚·菲米尔"
   L["Glyx Brewright"] = "格里克斯·布鲁维特"
   L["Gnaz Blunderflame"] = "格纳兹·枪焰"
L["Goram"] = true
   L["Gretta Ganter"] = "格雷塔·甘特"
   L["Grimtak"] = "格瑞姆塔克"
   L["Grub"] = "格拉布"
   L["Haalrun"] = "海尔伦"
   L["Haferet"] = "哈弗雷特"
   L["Hagrus"] = "哈格鲁斯"
   L["Hammon Karwn"] = "哈蒙·卡文"
   L["Harggan"] = "哈尔甘"
   L["Harklan Moongrove"] = "哈克兰·月林"
   L["Harlon Thornguard"] = "哈隆·棘甲"
   L["Harlown Darkweave"] = "哈鲁恩·暗纹"
   L["Harn Longcast"] = "哈恩·长线"
   L["Haughty Modiste"] = "傲慢的店主"
   L["Heldan Galesong"] = "海尔丹·风歌"
   L["Helenia Olden"] = "海伦妮亚·奥德恩"
   L["High Admiral \"Shelly\" Jorrik"] = "舰队司令“贝壳”约里克"
   L["Himmik"] = "西米克"
   L["Hotoppik Copperpinch"] = "霍图匹克·考伯宾奇"
   L["Hula'mahi"] = "哈拉玛"
L["Ikaneba Summerset"] = true
   L["Ildine Sorrowspear"] = "伊尔蒂"
   L["Indormi"] = "因多米"
   L["Inessera"] = "英妮瑟拉"
   L["Innkeeper Biribi"] = "旅店老板贝莉比"
   L["Innkeeper Fizzgrimble"] = "旅店老板菲兹格瑞博"
   L["Innkeeper Grilka"] = "旅店老板格里尔卡"
L["Isabel Jones"] = true
   L["Jabbey"] = "加贝"
   L["Jandia"] = "詹迪亚"
   L["Janet Hommers"] = "詹奈特·霍莫斯"
   L["Jangdor Swiftstrider"] = "杉多尔·迅蹄"
   L["Jannos Ironwill"] = "加诺斯·铁心"
   L["Jaquilina Dramet"] = "加奎琳娜·德拉米特"
   L["Jase Farlane"] = "贾斯·法拉恩"
   L["Jazzrik"] = "加兹里克"
   L["Jeeda"] = "基达"
   L["Jennabink Powerseam"] = "吉娜比克·铁线"
   L["Jessara Cordell"] = "杰萨拉·考迪尔"
L["Jezebel Bican"] = true
L["Jillian Tanner"] = true
   L["Jim Saltit"] = "吉姆·萨迪特"
   L["Jinky Twizzlefixxit"] = "金克·铁钩"
   L["Johan Barnes"] = "乔汉·巴内斯"
L["John Rigsdale"] = true
   L["Joseph Moore"] = "约瑟夫·摩尔"
   L["Jubie Gadgetspring"] = "朱比"
L["Jungle Serpent"] = true
   L["Jun'ha"] = ""
   L["Juno Dufrain"] = "基诺·杜弗莱"
   L["Jutak"] = "祖塔克"
   L["Kaita Deepforge"] = "凯塔·深炉"
   L["Kalldan Felmoon"] = "卡尔丹·暗月"
   L["Kania"] = "卡妮亚"
   L["Karaaz"] = "卡拉兹"
L["Karizi Porkpatty"] = true
L["Kaye Toogie"] = true
   L["Keena"] = "基纳"
   L["Kelsey Yance"] = "凯尔希·杨斯"
   L["Kendor Kabonka"] = "肯多尔·卡邦卡"
   L["Khara Deepwater"] = "卡拉·深水"
   L["Khole Jinglepocket"] = "霍勒"
   L["Kiknikle"] = "吉克尼库"
   L["Killian Sanatha"] = "基利恩·萨纳森"
   L["Kilxx"] = "基尔克斯"
L["Kim Horn"] = true
   L["Kireena"] = "基瑞娜"
L["Kirembri Silvermane"] = true
   L["Kithas"] = "基萨斯"
   L["Knaz Blunderflame"] = "克纳兹·枪焰"
   L["Knight Dameron"] = "骑士达米隆"
   L["Koren"] = ""
   L["Kor'geld"] = ""
   L["Krek Cragcrush"] = "克雷格·碎岩"
   L["Kriggon Talsone"] = "克雷贡·塔尔松"
   L["Krinkle Goodsteel"] = "克林科·古德斯迪尔"
L["KTC Train-a-Tron Deluxe"] = true
L["Kul Inkspiller"] = true
L["Kuldar Steeltooth"] = true
   L["Kulwia"] = "库尔维亚"
   L["Kzixx"] = "卡兹克斯"
   L["Lady Palanseer"] = "	潘兰希尔女士"
L["Laha Farplain"] = true
L["Laida Gembold"] = true
   L["Laird"] = "莱尔德"
   L["Lalla Brightweave"] = "兰尔拉·亮纹"
   L["Landraelanis"] = "兰达兰尼斯"
L["Larana Drome"] = true
   L["Lardan"] = "拉尔丹"
L["Larissia"] = true
L["Layna Karner"] = true
   L["Lebowski"] = "莱布斯基"
   L["Leeli Longhaggle"] = "莉莉·朗哈格"
   L["Leo Sarn"] = "雷欧·萨恩"
   L["Leonard Porter"] = "莱纳德·波特"
   L["Librarian Erickson"] = "图书馆员埃里克森"
   L["Lieutenant General Andorov"] = "安多洛夫中将"
   L["Lillehoff"] = "李奥霍夫"
   L["Lilly"] = "莉蕾"
   L["Lindea Rabonne"] = "林迪·拉波尼"
   L["Linna Bruder"] = "琳娜·布鲁德"
   L["Lizbeth Cromwell"] = "莉兹白·克伦威尔"
L["Lizna Goldweaver"] = true
   L["Logannas"] = "洛加纳斯"
   L["Logistics Officer Brighton"] = "后勤官员布莱顿"
   L["Logistics Officer Silverstone"] = "后勤官希瓦丝顿"
   L["Logistics Officer Ulrike"] = "后勤军需官乌瑞卡"
   L["Lokhtos Darkbargainer"] = "罗克图斯·暗契"
   L["Loolruna"] = "卢尔鲁娜"
   L["Lorelae Wintersong"] = "罗莱尔·冬歌"
   L["Lyna"] = "琳娜"
   L["Madame Ruby"] = "卢比夫人"
   L["Magnus Frostwake"] = "玛格努斯·霜鸣"
   L["Mahu"] = "曼胡"
L["Mak"] = true
   L["Mallen Swain"] = "	玛林·斯万"
   L["Malygen"] = "玛里甘"
   L["Mari Stonehand"] = "玛里·石拳"
   L["Maria Lumere"] = "玛丽亚·卢米尔"
L["Marith Lazuria"] = true
   L["Martine Tramblay"] = "马丁·塔布雷"
   L["Masat T'andr"] = "马萨特·坦德"
   L["Master Chef Mouldier"] = "大厨师莫迪尔"
   L["Master Craftsman Omarion"] = "大工匠奥玛里恩"
   L["Mathar G'ochar"] = ""
   L["Mavralyn"] = "马弗拉林"
   L["Mazk Snipeshot"] = "玛兹克·斯奈普沙特"
   L["Meilosh"] = "梅罗什"
   L["Melaris"] = "梅拉瑞斯"
   L["Mera Mistrunner"] = ""
   L["Micha Yance"] = "米沙·杨斯"
   L["Millie Gregorian"] = "米利尔·格里高利"
L["Mirla Silverblaze"] = true
   L["Misensi"] = "米森希"
   L["Mishta"] = "米什塔"
L["Misty Merriweather"] = true
   L["Mixie Farshot"] = "米希·法索"
   L["Modoru"] = "莫度鲁"
   L["Montarr"] = "莫塔尔"
   L["Morgan Day"] = "摩根·德尔"
L["Moro Sungrain"] = true
   L["Muheru the Weaver"] = "编织者姆赫鲁"
   L["Muuran"] = "穆尔兰"
   L["Mycah"] = "麦卡"
   L["Mythrin'dir"] = "迈斯林迪尔"
   L["Naal Mistrunner"] = "纳尔·迷雾行者"
   L["Nakodu"] = "纳克杜"
   L["Namdo Bizzfizzle"] = "纳姆杜"
   L["Nandar Branson"] = "南达·布拉森"
   L["Nardstrum Copperpinch"] = "纳斯塔姆·卡布彬"
   L["Narj Deepslice"] = "纳尔基·长刀"
   L["Narkk"] = "纳尔克"
   L["Nasmara Moonsong"] = "纳丝玛拉·月歌"
   L["Nata Dawnstrider"] = "纳塔·黎明行者"
   L["Neal Allen"] = "尼尔·奥雷"
   L["Neii"] = "奈伊"
L["Nemiha"] = true
   L["Nergal"] = "奈尔加"
   L["Nerrist"] = "耐里斯特"
   L["Nessa Shadowsong"] = "尼莎·影歌"
   L["Nina Lightbrew"] = "妮娜·莱特布鲁"
   L["Nioma"] = "尼奥玛"
   L["Nula the Butcher"] = "屠夫努尔拉"
L["Nuri"] = true
   L["Nyoma"] = "奈欧玛"
   L["Ogg'marr"] = "奥克玛尔"
   L["Okuno"] = "沃库诺"
   L["Old Man Heming"] = "老人海明威"
   L["Ontuvo"] = "昂图沃"
   L["Otho Moji'ko"] = "奥索·莫吉克"
   L["Outfitter Eric"] = "埃瑞克"
L["Paku Cloudchaser"] = true
L["Palehoof's Big Bag of Parts"] = true
   L["Paulsta'ats"] = "帕斯塔兹"
   L["Penney Copperpinch"] = "本尼·考伯宾奇"
   L["Phea"] = "菲恩"
   L["Plugger Spazzring"] = "普拉格"
L["Poranna Snowbraid"] = true
L["Pratt McGrubben"] = true
   L["Prospector Khazgorm"] = "勘察员卡兹戈姆"
   L["Provisioner Lorkran"] = "粮食商人洛克兰"
   L["Provisioner Nasela"] = "补给官纳瑟拉"
L["Punra"] = true
L["Qia"] = true
   L["Quartermaster Davian Vaclav"] = "军需官达维安·瓦克拉弗"
   L["Quartermaster Endarin"] = "军需官恩达尔林"
   L["Quartermaster Enuril"] = "军需官恩努利尔"
   L["Quartermaster Jaffrey Noreliqe"] = "军需官亚弗雷"
   L["Quartermaster Miranda Breechlock"] = "军需官米兰达·布利洛克"
   L["Quartermaster Urgronn"] = "军需官乌尔格隆"
   L["Quelis"] = "奎尔里斯"
L["Randah Songhorn"] = true
   L["Ranik"] = "拉尼克"
L["Ranisa Whitebough"] = true
   L["Rann Flamespinner"] = "拉恩·火翼"
   L["Rartar"] = "拉尔塔"
   L["Rathis Tomber"] = "拉提斯·托博尔"
L["Riha"] = true
   L["Rikqiz"] = "雷克奇兹"
   L["Rin'wosho the Trader"] = "商人林沃斯"
   L["Rizz Loosebolt"] = "里兹·飞矢"
   L["Rohok"] = "罗霍克"
   L["Ronald Burch"] = "罗纳德·伯奇"
L["Rose Standish"] = true
   L["Rungor"] = "伦格尔"
   L["Ruppo Zipcoil"] = "鲁普·火油"
   L["Saenorion"] = "塞诺里奥"
   L["Sairuk"] = "塞鲁克"
L["Sal Ferraga"] = true
L["Samuel Van Brunt"] = true
L["Sara Lanner"] = true
L["Sarah Lightbrew"] = true
   L["Sassa Weldwell"] = "萨莎·焊井"
   L["Sebastian Crane"] = "塞巴斯迪安·克兰"
   L["Seer Janidi"] = "先知亚尼迪"
   L["Seersa Copperpinch"] = "希尔萨"
L["Senthii"] = true
   L["Sewa Mistrunner"] = "苏瓦·迷雾行者"
   L["Shaani"] = "珊妮"
   L["Shadi Mistrunner"] = "沙迪·迷雾行者"
   L["Shandrina"] = "珊蒂瑞亚"
   L["Shankys"] = "山吉斯"
L["Shay Pressler"] = true
L["Shazdar"] = true
   L["Sheendra Tallgrass"] = "希恩德拉·深草"
   L["Shen'dralar Provisioner"] = "辛德拉圣职者"
   L["Sheri Zipstitch"] = "	舍瑞·希普斯迪"
   L["Sid Limbardi"] = "希德·利巴迪"
   L["Skreah"] = "斯克雷亚"
   L["Smudge Thunderwood"] = "斯穆德·雷木"
   L["Soolie Berryfizz"] = "苏雷·浆泡"
   L["Sovik"] = "索维克"
L["Steeg Haskell"] = true
   L["Stone Guard Mukar"] = "石头守卫穆卡尔"
   L["Stuart Fleming"] = "斯图亚特·弗雷明"
L["Suja"] = true
   L["Sumi"] = "苏米"
   L["Super-Seller 680"] = "超级商人680型"
   L["Supply Officer Mills"] = "供给官米尔斯"
   L["Tamar"] = "达玛尔"
   L["Tanaika"] = "塔奈卡"
   L["Tanak"] = "塔纳克"
   L["Tansy Puddlefizz"] = "坦斯·泥泡"
   L["Tarban Hearthgrain"] = "塔班·熟麦"
L["Tarien Silverdew"] = true
L["Tari'qa"] = true
L["Taur Stonehoof"] = true
L["Terrance Denman"] = true
   L["Thaddeus Webb"] = "萨德乌斯·韦伯"
   L["Tharynn Bouden"] = "萨瑞恩·博丁"
   L["Thomas Yance"] = "托马斯·杨斯"
L["Threm Blackscalp"] = true
L["Thurgrum Deepforge"] = true
   L["Tiffany Cartier"] = "蒂凡妮·卡蒂亚"
   L["Tilli Thistlefuzz"] = "提尔利·草须"
   L["Timothy Jones"] = "提莫斯·琼斯"
   L["Trader Narasu"] = "商人纳拉苏"
   L["Truk Wildbeard"] = "特鲁克·蛮鬃"
   L["Tunkk"] = "吞克"
   L["Ulthaan"] = "尤萨恩"
   L["Ulthir"] = "尤希尔"
L["Una Kobuna"] = true
   L["Uriku"] = "乌利库"
   L["Uthok"] = "尤索克"
   L["Vaean"] = "维安"
   L["Valdaron"] = "瓦尔达隆"
   L["Vanessa Sellers"] = "瓦妮萨·塞勒斯"
   L["Vargus"] = "瓦古斯"
   L["Veenix"] = "维尼克斯"
L["Velia Moonbow"] = true
   L["Vendor-Tron 1000"] = "贸易机器人1000型 "
   L["Veteran Crusader Aliocha Segard"] = "精锐北伐军战士奥利卡·塞加德"
   L["Vharr"] = "维哈尔"
   L["Viggz Shinesparked"] = "维格兹·沙斯巴克"
   L["Vivianna"] = "薇薇安娜"
   L["Vix Chromeblaster"] = "维克斯·科洛布拉斯"
L["Vizna Bangwrench"] = true
   L["Vizzklick"] = "维兹格里克"
   L["Vodesiin"] = "沃德辛"
   L["Wenna Silkbeard"] = "温纳·银须"
   L["Werg Thickblade"] = "维尔格·厚刃"
L["Wik'Tar"] = true
L["Wilmina Holbeck"] = true
   L["Wind Trader Lathrai"] = "星界商人拉斯莱"
   L["Wolgren Jinglepocket"] = "沃尔格雷·吉波克"
   L["Worb Strongstitch"] = "沃尔布"
   L["Wrahk"] = "瓦尔克"
   L["Wulan"] = "乌兰"
   L["Wulmort Jinglepocket"] = "乌莫尔特"
   L["Wunna Darkmane"] = "温纳·黑鬃"
   L["Xandar Goodbeard"] = "山达·细须"
   L["Xen'to"] = ""
   L["Xerintha Ravenoak"] = "瑟尔琳萨·乌木"
   L["Xizk Goodstitch"] = "希兹克·古斯提"
   L["Xizzer Fizzbolt"] = "希兹尔·菲兹波特"
   L["Yatheon"] = "亚瑟恩"
   L["Yonada"] = "犹纳达"
   L["Ythyar"] = "伊萨尔"
   L["Yuka Screwspigot"] = "尤卡·斯库比格特"
   L["Yurial Soulwater"] = "尤利安·魂水"
   L["Zan Shivsproket"] = "萨恩·刀链"
   L["Zannok Hidepiercer"] = "扎诺克"
   L["Zansoa"] = "詹苏尔"
   L["Zaralda"] = "萨拉尔达"
   L["Zarena Cromwind"] = "萨瑞娜·克罗姆温德"
   L["Zargh"] = "扎尔夫"
L["Zido Helmbreaker"] = true
L["Zixil"] = true
L["Zoey Wizzlespark"] = true
L["Zorbin Fandazzle"] = true
L["Zurai"] = true
L["Zurii"] = true
