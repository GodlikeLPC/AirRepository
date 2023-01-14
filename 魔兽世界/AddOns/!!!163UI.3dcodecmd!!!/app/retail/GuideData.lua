local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();
if _toc_version < 90000 then
	return;
end

local __addon, __ns = ...;

__ns._GUIDE_DATA = {
	['mount'] = {
		-- ["*"] = [[https://ds.163.com/topic/暗影国度/]],
		[1324] = [[https://ds.163.com/feed/607f90d8517f0f1b2f6e8f9e/]],	--	轻盈的迅蹄驼
		[961] = [[https://ds.163.com/feed/608675d68ec3322af5bb87d1/]],	--	清醒的梦魇
		[883] = [[https://ds.163.com/feed/607f8f91f7feba5b60a5439d/]],	--	燃烬巨龙
		[397] = [[https://ds.163.com/feed/607f8ee1f7feba5b60a5426e/]],	--	琉璃石幼龙
		[395] = [[https://ds.163.com/feed/607f8ee1f7feba5b60a5426e/]],	--	北风幼龙
		[69] = [[https://ds.163.com/feed/607f8ee1f7feba5b60a5426e/]],	--	瑞文戴尔的死亡战马
		[280] = [[https://ds.163.com/feed/607f89307c87225bf9bea274/]],	--	旅行者的苔原猛犸象
		[460] = [[https://ds.163.com/feed/607f89307c87225bf9bea274/]],	--	雄壮远足牦牛
		[185] = [[https://ds.163.com/feed/6080237973b0516bbcb3832e/]],	--	乌鸦之神
		[213] = [[https://ds.163.com/feed/6080237973b0516bbcb3832e/]],	--	迅捷白色陆行鸟
		[264] = [[https://ds.163.com/feed/6080237973b0516bbcb3832e/]],	--	蓝色始祖幼龙
		[410] = [[https://ds.163.com/feed/6080237973b0516bbcb3832e/]],	--	装甲拉扎什迅猛龙
		[411] = [[https://ds.163.com/feed/6080237973b0516bbcb3832e/]],	--	迅捷祖利安黑豹
		[419] = [[https://ds.163.com/feed/608023d57c87225bf9bfa545/]],	--	阿曼尼斗熊
		[306] = [[https://ds.163.com/feed/60802422f7feba5b60a63ac9/]],	--	铁箍始祖幼龙
		[307] = [[https://ds.163.com/feed/60802422f7feba5b60a63ac9/]],	--	铁锈始祖幼龙
		[449] = [[https://ds.163.com/feed/608023bb66636f42c13fffd0/]],	--	天蓝水黾
		[537] = [[https://ds.163.com/feed/60802357517f0f1b2f6f8209/]],	--	白色原始迅猛龙
		[538] = [[https://ds.163.com/feed/60802357517f0f1b2f6f8209/]],	--	红色原始迅猛龙
		[539] = [[https://ds.163.com/feed/60802357517f0f1b2f6f8209/]],	--	黑色原始迅猛龙
		[1013] = [[https://ds.163.com/feed/608024e98ec33245d37a2457/]],	--	蜜背收割者
		[203] = [[https://ds.163.com/feed/608025af66636f42c140042f/]],	--	塞纳里奥作战角鹰兽
		[986] = [[https://ds.163.com/feed/6080258466636f42c14003bb/]],	--	黯蹄废墟游荡者
		[463] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	琥珀巨蝎
		[504] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	雷霆天神云端翔龙
		[479] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	天蓝骑乘仙鹤
		[481] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	帝王骑乘仙鹤
		[480] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	金黄骑乘仙鹤
		[507] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	红色影踪派骑乘虎
		[505] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	绿色影踪派骑乘虎
		[506] = [[https://ds.163.com/feed/6080260312b80d3c259fce05/]],	--	蓝色影踪派骑乘虎
		[174] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	白色骑乘塔布羊
		[154] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	白色作战塔布羊
		[170] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	蓝色骑乘塔布羊
		[153] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	蓝色作战塔布羊
		[172] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	银色骑乘塔布羊
		[155] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	银色作战塔布羊
		[173] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	褐色骑乘塔布羊
		[156] = [[https://ds.163.com/feed/6080255866636f42c140035d/]],	--	褐色作战塔布羊
		[509] = [[https://ds.163.com/feed/608026037c87225bf9bfa9b3/]],	--	红色筋斗云
		[1250] = [[https://ds.163.com/feed/6080251573b0516bbcb386e3/]],	--	茉莉
		[560] = [[https://ds.163.com/feed/6080232d73b0516bbcb38286/]],	--	灰皮穆山兽
		[364] = [[https://ds.163.com/feed/608024fb12b80d3c259fcbbc/]],	--	缚寒冰霜征服者
		[1404] = [[https://ds.163.com/feed/6080273073b0516bbcb38bd3/]],	--	银风翼狮
		[947] = [[https://ds.163.com/feed/60802887517f0f1b2f6f8d3d/]],	--	谜语人的灵蛇
		[657] = [[https://ds.163.com/feed/608028b166636f42c1400a9e/]],	--	夜嚎铁颚狼
		[1415] = [[https://ds.163.com/feed/608028d966636f42c1400aed/]],	--	树栖巨口蟾
		[1360] = [[https://ds.163.com/feed/607f9d59f7feba5b60a55c9b/]],	--	闪雾奔行者
		[434] = [[https://ds.163.com/feed/607f9a6a73b0516bbcb2a2da/]],	--	暗月跳舞熊
		[429] = [[https://ds.163.com/feed/607f9a6a73b0516bbcb2a2da/]],	--	迅捷森林陆行鸟
		[1414] = [[https://ds.163.com/feed/607f9d1773b0516bbcb2a780/]],	--	罪奔者布兰契
		[1397] = [[https://ds.163.com/feed/607f99b112b80d3c259ee5c6/]],	--	灵种摇篮
		[445] = [[https://ds.163.com/feed/607f9c0512b80d3c259ee9fd/]],	--	实验体12-B
		[442] = [[https://ds.163.com/feed/607f9c0512b80d3c259ee9fd/]],	--	炽炎幼龙
		[444] = [[https://ds.163.com/feed/607f9c0512b80d3c259ee9fd/]],	--	生命缚誓者的仆从
		[425] = [[https://ds.163.com/feed/607f97228ec33245d37939cb/]],	--	奥利瑟拉佐尔的烈焰之爪
		[415] = [[https://ds.163.com/feed/607f97228ec33245d37939cb/]],	--	纯血火鹰
		[399] = [[https://ds.163.com/feed/607f96958ec33245d37938a6/]],	--	褐色骑乘骆驼
		[398] = [[https://ds.163.com/feed/607f96958ec33245d37938a6/]],	--	棕色骑乘骆驼
		[779] = [[https://ds.163.com/feed/607f95a98ec33245d37936a9/]],	--	艾特洛之魂
		[1057] = [[https://ds.163.com/feed/607f98e973b0516bbcb2a052/]],	--	纳沙塔尔鲜血巨蛇
		[448] = [[https://ds.163.com/feed/6086806512b80d1f487a767d/]],	--	翠绿云端翔龙
		[464] = [[https://ds.163.com/feed/6086806512b80d1f487a767d/]],	--	碧蓝云端翔龙
		[465] = [[https://ds.163.com/feed/6086806512b80d1f487a767d/]],	--	金色云端翔龙
		[248] = [[https://ds.163.com/feed/60867f2412b80d1f487a748d/]],	--	青铜幼龙
		[250] = [[https://ds.163.com/feed/60867f2412b80d1f487a748d/]],	--	暮光幼龙
		[253] = [[https://ds.163.com/feed/60867f2412b80d1f487a748d/]],	--	黑色幼龙
		[430] = [[https://ds.163.com/feed/608676208ec3322af5bb8833/]],	--	迅捷春日陆行鸟
		[1445] = [[https://ds.163.com/feed/607cf856517f0f4a11dd2a65/]],	--	软泥之蛇
		[1307] = [[https://ds.163.com/feed/5ff7c3cc8ec3326b9d777aab/]],	--	日舞者
		[1362] = [[https://ds.163.com/feed/60890a5c7c872270be278508/]],	--	锥喉林地咀嚼者
		[1239] = [[https://ds.163.com/feed/608908d612b80d3377a96211/]],	--	X-995型机械猫
		[1248] = [[https://ds.163.com/feed/608908d612b80d3377a96211/]],	--	锈废漂移者
		[1229] = [[https://ds.163.com/feed/608908d612b80d3377a96211/]],	--	生锈的机械爬蛛
		[1258] = [[https://ds.163.com/feed/60890664f7feba4fdf34fb7f/]],	--	法比乌斯
		[517] = [[https://ds.163.com/feed/608905cb4ebd8e2a9c456177/]],	--	雷霆红玉云端翔龙
		[800] = [[https://ds.163.com/feed/6089043c8ec3323f8b80366e/]],	--	深海喂食者
		[972] = [[https://ds.163.com/feed/608902b28ec3323f8b803452/]],	--	安托兰阴暗恶犬
		[1441] = [[https://ds.163.com/feed/6089193566636f3a14bed635/]],	--	被缚的影犬
		[1366] = [[https://ds.163.com/feed/60891a8e517f0f13bf439935/]],	--	骨蹄荒牛
		[1411] = [[https://ds.163.com/feed/60891cd073b0516892abe878/]],	--	掠食的凋零大鹏
		[1372] = [[https://ds.163.com/feed/60891e30517f0f13bf439f0e/]],	--	灼背血牙猪
		[1373] = [[https://ds.163.com/feed/60891e30517f0f13bf439f0e/]],	--	血刺
		[1438] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	浑圆通灵鳐
		[1440] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	致命通灵鳐
		[1439] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	群居通灵鳐
		[1377] = [[https://ds.163.com/feed/6089232566636f3a14bee60c/]],	--	城墙尖啸者
		[1438] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	浑圆通灵鳐
		[1440] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	致命通灵鳐
		[1439] = [[https://ds.163.com/feed/6089235612b80d3377a98788/]],	--	群居通灵鳐
		[1332] = [[https://ds.163.com/feed/608926f58ec3323f8b806929/]],	--	丝柔烁光蛾
		[1426] = [[https://ds.163.com/feed/608927e2517f0f13bf43afb5/]],	--	晋升天鬃马
		[1391] = [[https://ds.163.com/feed/6089290366636f3a14bef0a9/]],	--	忠诚的饕餮者
		[1410] = [[https://ds.163.com/feed/60892aa04ebd8e2a9c45977c/]],	--	巨型死亡大鹏
		[1306] = [[https://ds.163.com/feed/60892d7f73b0516892ac04e1/]],	--	迅捷厄蹄马
		[1393] = [[https://ds.163.com/feed/60892ee573b0516892ac0778/]],	--	野生烁裘徘徊者
		[1310] = [[https://ds.163.com/feed/608942de73b0516892ac2c99/]],	--	可怖的惊惧之翼
		[1211] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	充血猎蝠
		[993] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	呱呱鹦鹉
		[1213] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	复活的骒马
		[1176] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	岩角跃渊者
		[1169] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	拍浪水母
		[1175] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	暮光复仇者
		[1212] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	海岛雷鳞龙
		[1209] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	石皮大角鹿
		[1169] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	拍浪水母
		[1178] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	秦薛的永恒魁麟
		[1175] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	暮光复仇者
		[1208] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	咸水海马
		[1212] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	海岛雷鳞龙
		[1042] = [[https://ds.163.com/feed/60894e6e73b0516892ac4323/]],	--	泥翼信天翁
	},
	['pet'] = {
		-- [1532] = [[https://www.baidu.com/s?wd=伊奇]],
		-- [1152] = [[https://www.baidu.com/s?wd=克洛玛尼斯]],
	},
	['toy'] = {
		-- [134021] = [[https://www.baidu.com/s?wd=X-52火箭头盔]],
	},
	['instance'] = {
		-- [1190] = [[https://www.baidu.com/s?wd=奥迪尔]],
	},
	['encounter'] = {
		-- [2424] = [[https://www.baidu.com/s?wd=德纳修斯大帝]],
	},
	['achievement'] = {
		-- [2336] = [[https://www.baidu.com/s?wd=你疯了吧？！]],
		-- [14783] = [[https://www.baidu.com/s?wd=60级]],
	},
};
__ns._GUIDE_DATA.achievementacomparison = __ns._GUIDE_DATA.achievement;


for Type, data in next, __ns._GUIDE_DATA do
	local _def = data["*"];
	if _def ~= nil then
		setmetatable(data, { __index = function(tbl, key) return _def; end, });
	end
end


--[=[
/run local db = {  }; local ids = C_MountJournal.GetMountIDs(); for i = 1, #ids do db[ids[i]] = { C_MountJournal.GetMountInfoByID(ids[i]) }; end GLOBAL_CORE_DEV_SAVED.mount = db;
/run local db = {  }; for i = 1, C_PetJournal.GetNumPets() do local _, id = C_PetJournal.GetPetInfoByIndex(i); db[id] = { C_PetJournal.GetPetInfoBySpeciesID(id) }; end GLOBAL_CORE_DEV_SAVED.pet = db;
/run local db = {  }; for i = 1, C_ToyBox.GetNumToys() do local id = C_ToyBox.GetToyFromIndex(i); db[id] = { C_ToyBox.GetToyInfo(id) }; end GLOBAL_CORE_DEV_SAVED.toy = db;
/run for _, tbl in next, GLOBAL_CORE_DEV_SAVED do local m = -1; for k, v in next, tbl do m = max(m, k); end for i = 1, m do tbl[i] = tbl[i] and { i, tbl[i], } or "_NIL" end end
]=]