--[[
	@ALA / ALEX
--]]

local Item2Spell = {
	[1041] = 578,
	[1132] = 580,
	[1133] = 581,
	[1134] = 459,
	[2411] = 470,
	[2414] = 472,
	[2413] = 471,
	[4401] = 4055,
	[5872] = 6899,
	[5873] = 6898,
	[5874] = 6896,
	[5875] = 6897,
	[5655] = 6648,
	[5668] = 6654,
	[8500] = 10707,
	[8495] = 10684,
	[8497] = 10711,
	[8499] = 10697,
	[8588] = 8395,
	[8589] = 10795,
	[8590] = 10798,
	[8591] = 10796,
	[8592] = 10799,
	[5656] = 458,
	[5665] = 6653,
	[8627] = 10787,
	[8485] = 10673,
	[8486] = 10674,
	[8487] = 10676,
	[8632] = 10789,
	[8488] = 10678,
	[8628] = 10792,
	[8583] = 8980,
	[8489] = 10679,
	[8492] = 10683,
	[8633] = 10788,
	[8491] = 10675,
	[8630] = 10790,
	[8501] = 10706,
	[8563] = 10873,
	[5663] = 579,
	[10394] = 10709,
	[10361] = 10716,
	[10822] = 10695,
	[8498] = 10698,
	[10398] = 12243,
	[10392] = 10717,
	[10393] = 10688,
	[11903] = 15648,
	[10360] = 10714,
	[11825] = 15048,
	[8496] = 10680,
	[11826] = 15049,
	[8629] = 10793,
	[12327] = 16060,
	[11023] = 10685,
	[12325] = 16058,
	[11026] = 10704,
	[11027] = 10703,
	[12353] = 16083,
	[8494] = 10682,
	[8595] = 10969,
	[5864] = 6777,
	[11110] = 13548,
	[2415] = 468,
	[11474] = 15067,
	[13582] = 17709,
	[13584] = 17708,
	[12351] = 16081,
	[12354] = 16082,
	[8631] = 8394,
	[13325] = 17458,
	[12302] = 16056,
	[12303] = 16055,
	[12330] = 16080,
	[13326] = 15779,
	[12264] = 15999,
	[13322] = 17454,
	[13332] = 17463,
	[13335] = 17481,
	[13327] = 17459,
	[13329] = 17460,
	[13331] = 17462,
	[12529] = 16450,
	[13086] = 17229,
	[12326] = 16059,
	[13333] = 17464,
	[15290] = 18990,
	[13334] = 17465,
	[8490] = 10677,
	[13317] = 17450,
	[13323] = 17455,
	[13324] = 17456,
	[13321] = 17453,
	[14062] = 18363,
	[15277] = 18989,
	[15292] = 18991,
	[15293] = 18992,
	[18243] = 22719,
	[18248] = 22722,
	[16339] = 16082,
	[16338] = 458,
	[18242] = 22723,
	[18245] = 22724,
	[18247] = 22718,
	[19450] = 23811,
	[18244] = 22720,
	[18778] = 23228,
	[18791] = 23246,
	[18797] = 23251,
	[18766] = 23221,
	[18777] = 23229,
	[18774] = 23222,
	[13328] = 17461,
	[15996] = 19772,
	[18776] = 23227,
	[16343] = 6654,
	[18767] = 23219,
	[19054] = 23530,
	[18768] = 23220,
	[18772] = 23225,
	[18785] = 23240,
	[18787] = 23239,
	[18788] = 23241,
	[8586] = 16084,
	[18773] = 23223,
	[18241] = 22717,
	[19055] = 23531,
	[19030] = 23510,
	[18795] = 23248,
	[18967] = 23430,
	[18796] = 23250,
	[18798] = 23252,
	[18246] = 22721,
	[18790] = 23243,
	[18793] = 23247,
	[18794] = 23249,
	[18965] = 23432,
	[18789] = 23242,
	[19902] = 24252,
	[18966] = 23431,
	[13583] = 17707,
	[19029] = 23509,
	[18902] = 23338,
	[18786] = 23238,
	[20769] = 25162,
	[20371] = 24696,
	[18963] = 23428,
	[18964] = 23429,
	[19872] = 24242,
	[20651] = 25018,
	[22114] = 27241,
	[21321] = 26054,
	[21309] = 26045,
	[21323] = 26056,
	[21324] = 26055,
	[21277] = 26010,
	[21301] = 26533,
	[21305] = 26541,
	[21308] = 26529,
	[21736] = 3363,
	[21218] = 25953,
	[21168] = 25849,
	[22780] = 28487,
	[22781] = 28505,
	[23002] = 28738,
	[23713] = 30156,
	[23720] = 30174,
	[23015] = 28740,
	[23193] = 29059,
	[23007] = 28739,
	[23712] = 30152,
	[22235] = 27570,
	[23083] = 28871,
	[25470] = 32235,
	[25471] = 32239,
	[25472] = 32240,
	[25473] = 32242,
	[25474] = 32243,
	[25475] = 32244,
	[25476] = 32245,
	[25477] = 32246,
	[25596] = 32345,
	[25527] = 32289,
	[25528] = 32290,
	[25529] = 32292,
	[25531] = 32295,
	[25532] = 32296,
	[25533] = 32297,
	[25535] = 32298,
	[25664] = 32420,
	[27445] = 33050,
	[28481] = 34406,
	[28482] = 34407,
	[29901] = 35907,
	[29902] = 35909,
	[29903] = 35910,
	[29904] = 35911,
	[28915] = 39316,
	[29363] = 35156,
	[29364] = 35239,
	[28927] = 34795,
	[29102] = 34896,
	[29103] = 34897,
	[29465] = 22719,
	[29466] = 22718,
	[29104] = 34898,
	[29105] = 34899,
	[29467] = 22720,
	[29468] = 22717,
	[29469] = 22724,
	[29470] = 22722,
	[29471] = 22723,
	[29472] = 22721,
	[29743] = 35711,
	[28936] = 33660,
	[29744] = 35710,
	[29745] = 35713,
	[29746] = 35712,
	[29747] = 35714,
	[29220] = 35020,
	[29221] = 35022,
	[29222] = 35018,
	[29223] = 35025,
	[29224] = 35027,
	[29227] = 34896,
	[29228] = 34790,
	[29229] = 34898,
	[29230] = 34899,
	[29231] = 34897,
	[30609] = 37015,
	[30360] = 24988,
	[29953] = 36027,
	[29956] = 36028,
	[29957] = 36029,
	[29958] = 36031,
	[30480] = 36702,
	[29960] = 36034,
	[32233] = 39709,
	[32314] = 39798,
	[32316] = 39801,
	[32317] = 39800,
	[32318] = 39802,
	[32319] = 39803,
	[32498] = 40405,
	[32588] = 40549,
	[32768] = 41252,
	[31829] = 39315,
	[31830] = 39315,
	[31831] = 39317,
	[31832] = 39317,
	[31833] = 39318,
	[31834] = 39318,
	[31835] = 39319,
	[31836] = 39319,
	[32616] = 40614,
	[32617] = 40613,
	[32622] = 40634,
	[31665] = 38842,
	[31760] = 39181,
	[32458] = 40192,
	[32465] = 40319,
	[33977] = 43900,
	[34129] = 35028,
	[34535] = 10696,
	[33809] = 43688,
	[33816] = 43697,
	[33817] = 43697,
	[33818] = 43698,
	[33993] = 43918,
	[33999] = 43927,
	[33224] = 42776,
	[33225] = 42777,
	[34478] = 45082,
	[32857] = 41513,
	[32858] = 41514,
	[32859] = 41515,
	[32860] = 41516,
	[32861] = 41517,
	[32862] = 41518,
	[34492] = 45125,
	[34493] = 45127,
	[34495] = 45125,
	[33154] = 42609,
	[34060] = 44153,
	[34061] = 44151,
	[34518] = 45174,
	[34519] = 45175,
	[34092] = 44744,
	[34425] = 54187,
	[33179] = 42668,
	[33976] = 43899,
	[37297] = 48406,
	[37298] = 48408,
	[35504] = 46599,
	[37598] = 48954,
	[35225] = 46197,
	[35513] = 46628,
	[37676] = 49193,
	[35226] = 46199,
	[37719] = 49322,
	[37827] = 49378,
	[37828] = 49379,
	[38576] = 51412,
	[38628] = 51716,
	[39656] = 53082,
	[34955] = 45890,
	[35349] = 46425,
	[35350] = 46426,
	[35906] = 48027,
	[38050] = 49964,
	[38658] = 51851,
	[39286] = 52615,
	[39973] = 53316,
	[39896] = 61348,
	[39898] = 61351,
	[39899] = 61349,
	[41133] = 55068,
	[44175] = 60021,
	[43516] = 58615,
	[44177] = 60024,
	[44178] = 60025,
	[43698] = 59250,
	[43951] = 59569,
	[43952] = 59567,
	[43953] = 59568,
	[43954] = 59571,
	[43955] = 59570,
	[43956] = 59785,
	[43957] = 59791,
	[43958] = 59799,
	[43959] = 61465,
	[43960] = 59808,
	[43961] = 61470,
	[43962] = 54753,
	[43963] = 59573,
	[43964] = 59572,
	[43965] = 41515,
	[44689] = 61229,
	[44554] = 61451,
	[44555] = 61442,
	[44690] = 61230,
	[43986] = 59650,
	[44223] = 60118,
	[44556] = 61446,
	[44557] = 61444,
	[44558] = 61309,
	[44151] = 59996,
	[44224] = 60119,
	[44225] = 60114,
	[44226] = 60116,
	[44077] = 59788,
	[44079] = 59793,
	[44080] = 59797,
	[44230] = 59791,
	[44231] = 59793,
	[44707] = 61294,
	[44083] = 61467,
	[44160] = 59961,
	[44234] = 61447,
	[44235] = 61425,
	[43517] = 58636,
	[44085] = 59806,
	[44086] = 61469,
	[44164] = 59976,
	[44168] = 60002,
	[45942] = 64351,
	[44738] = 61472,
	[46099] = 64658,
	[46100] = 64657,
	[44857] = 62048,
	[46101] = 64656,
	[46102] = 64659,
	[44970] = 62508,
	[44971] = 62510,
	[44972] = 62514,
	[44973] = 62513,
	[45586] = 63636,
	[45589] = 63638,
	[45590] = 63639,
	[46109] = 64731,
	[44974] = 62516,
	[44980] = 62542,
	[45591] = 63637,
	[45592] = 63641,
	[45593] = 63635,
	[44885] = 62087,
	[44982] = 62564,
	[44983] = 62561,
	[44984] = 62562,
	[45595] = 63640,
	[45596] = 63642,
	[45597] = 63643,
	[45606] = 63712,
	[45693] = 63796,
	[44998] = 62609,
	[45002] = 62674,
	[45180] = 63318,
	[45802] = 63963,
	[44794] = 61725,
	[45022] = 62746,
	[44810] = 61773,
	[45125] = 63232,
	[45725] = 63844,
	[44721] = 61350,
	[44819] = 61855,
	[44822] = 10713,
	[44842] = 61997,
	[44843] = 61996,
	[44823] = 35910,
	[44824] = 10709,
	[44825] = 10688,
	[44826] = 10706,
	[44827] = 10711,
	[44828] = 10676,
	[44829] = 36029,
	[46544] = 65382,
	[46545] = 65381,
	[46820] = 66096,
	[46821] = 66096,
	[47180] = 67466,
	[46707] = 44369,
	[47100] = 66847,
	[47101] = 66846,
	[46708] = 64927,
	[46308] = 64977,
	[46743] = 65644,
	[46744] = 65638,
	[46745] = 65637,
	[46746] = 65645,
	[46747] = 65642,
	[46748] = 65643,
	[46749] = 65646,
	[46750] = 65641,
	[46751] = 65639,
	[46752] = 65640,
	[46755] = 65641,
	[46756] = 65637,
	[46757] = 65646,
	[46758] = 65640,
	[46759] = 65638,
	[46760] = 65644,
	[46761] = 65639,
	[46890] = 63318,
	[46891] = 66509,
	[46892] = 63318,
	[46894] = 66520,
	[46762] = 65643,
	[46763] = 65642,
	[46764] = 65645,
	[46767] = 65682,
	[46778] = 65917,
	[46802] = 66030,
	[47840] = 67336,
	[46813] = 66087,
	[46171] = 65439,
	[46398] = 65358,
	[46814] = 66088,
	[46815] = 66090,
	[46816] = 66091,
	[47179] = 66906,
	[49283] = 42776,
	[49284] = 42777,
	[49285] = 46197,
	[49286] = 46199,
	[49287] = 68767,
	[49290] = 65917,
	[49693] = 69677,
	[49044] = 68057,
	[49046] = 68056,
	[48527] = 67527,
	[49096] = 68187,
	[49098] = 68188,
	[49636] = 69395,
	[49646] = 69452,
	[49659] = 69529,
	[49343] = 68810,
	[49660] = 69532,
	[49662] = 69535,
	[49663] = 69536,
	[49664] = 69539,
	[49665] = 69541,
	[48112] = 67413,
	[48114] = 67414,
	[48116] = 67415,
	[48118] = 67416,
	[48120] = 67417,
	[48122] = 67418,
	[49362] = 69002,
	[48124] = 67419,
	[48126] = 67420,
	[49282] = 51412,
	[49911] = 70600,
	[49912] = 70613,
	[50435] = 71810,
	[50446] = 71840,
	[53641] = 74932,
	[54810] = 75613,
	[54847] = 75906,
	[54857] = 75936,
	[54860] = 75973,
	[56806] = 78381,
	[54068] = 74918,
	[54069] = 74856,
	[54436] = 75134,
	[54797] = 75596,
	[45801] = 63956,
	[51954] = 72808,
	[51955] = 72807,
	[180089] = 330659,
	[184865] = 348459,
	[194101] = 376324,
	[194518] = 377159,
	[198628] = 387311,
	[198629] = 387323,
	[198630] = 387320,
	[198631] = 387308,
	[198632] = 387319,
	[198633] = 387321,
	[198634] = 387330,
	[198635] = 387325,
	[198636] = 387332,
	[198637] = 387328,
	[198638] = 387329,
	[198639] = 387326,
	[198640] = 387331,
	[198665] = 384796,
};
local Spell2Item = {}
for iid, sid in next, Item2Spell do
	if Spell2Item[sid] then
		tinsert(Spell2Item[sid], iid);
	else
		Spell2Item[sid] = { iid };
	end
end
local LearnedSpell = {};
local LearnedSpellItem = {};


-->		upvalue
	local hooksecurefunc = hooksecurefunc;
	local tonumber = tonumber;

	local strmatch = string.match;

	local GetMerchantItemID = GetMerchantItemID;
	local GetBuybackItemLink = GetBuybackItemLink;
	local GetContainerItemInfo = GetContainerItemInfo or C_Container.GetContainerItemInfo;
	local GetAuctionItemInfo = GetAuctionItemInfo;
	local GetAuctionSellItemInfo = GetAuctionSellItemInfo;
	local LootSlotHasItem, GetLootSlotType, GetLootSlotLink = LootSlotHasItem, GetLootSlotType, GetLootSlotLink;
	local LOOT_SLOT_ITEM = LOOT_SLOT_ITEM;
	local GetLootRollItemLink = GetLootRollItemLink;
	local GetInventoryItemID = GetInventoryItemID;
	local GetTradePlayerItemLink = GetTradePlayerItemLink;
	local GetTradeTargetItemLink = GetTradeTargetItemLink;
	local GetQuestItemLink = GetQuestItemLink;
	local GetQuestLogChoiceInfo, GetQuestLogRewardInfo = GetQuestLogChoiceInfo, GetQuestLogRewardInfo;
	local GetInboxItem = GetInboxItem;
	local GetSendMailItem = GetSendMailItem;
	local GetTradeSkillReagentItemLink, GetTradeSkillItemLink = GetTradeSkillReagentItemLink, GetTradeSkillItemLink;
	local GetCraftReagentItemLink, GetCraftItemLink = GetCraftReagentItemLink, GetCraftItemLink;
	local GetGuildBankItemLink = GetGuildBankItemLink;

	local GetItemInfoInstant = GetItemInfoInstant;

-->
local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();
local __is_classic = _toc_version > 11300 and _toc_version < 20000;
local __is_bcc = _toc_version > 20400 and _toc_version < 30000;
local __is_wlk = _toc_version > 30300 and _toc_version < 90000;


local function LF_TooltipSetItemByID(Tooltip, iid)
	local _, _, _, _, _, class, subclass = GetItemInfoInstant(iid);
	if Item2Spell[iid] and class == 15 and (subclass == 0 or subclass == 2 or subclass == 3) then
		if LearnedSpellItem[iid] then
			Tooltip:AddLine("|cffff0000----------------已学----------------|r");
		else
			Tooltip:AddLine("|cff00ff00----------------可学----------------|r");
		end
		Tooltip:Show();
	end
end
local function LF_TooltipSetHyperlink(Tooltip, link)
	if link then
		local cid = strmatch(link, "item:(%d+)");
		if cid ~= nil then
			cid = tonumber(cid);
			if cid then
				LF_TooltipSetItemByID(Tooltip, cid);
			end
		end
	end
end
local function LF_TooltipSetMerchantItem(Tooltip, index)
	local iid = GetMerchantItemID(index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetBuybackItem(Tooltip, index)
	local link = GetBuybackItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetBagItem(Tooltip, bag, slot)
	local _, num, _, _, _, _, link, _, _, iid = GetContainerItemInfo(bag, slot);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetAuctionItem(Tooltip, type, index)
	local name, _, num, _, _, _, _, _, _, _, _, _, _, _, _, _, iid = GetAuctionItemInfo(type, index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetAuctionSellItem(Tooltip)
	local name, _, num, _, _, _, _, _, _, iid = GetAuctionSellItemInfo();
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetLootItem(Tooltip, slot)
	if LootSlotHasItem(slot) and GetLootSlotType(slot) == LOOT_SLOT_ITEM then
		local link = GetLootSlotLink(slot);
		if link then
			local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
			if iid ~= nil then
				LF_TooltipSetItemByID(Tooltip, iid);
			end
		end
	end
end
local function LF_TooltipSetLootRollItem(Tooltip, slot)
	local link = GetLootRollItemLink(slot);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetInventoryItem(Tooltip, unit, slot)
	local iid = GetInventoryItemID(unit, slot);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetTradePlayerItem(Tooltip, index)
	local link = GetTradePlayerItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetTradeTargetItem(Tooltip, index)
	local link = GetTradeTargetItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetQuestItem(Tooltip, type, index)
	local link = GetQuestItemLink(type, index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetQuestLogItem(Tooltip, type, index)
	local iid, _;
	if type == "choice" then
		_, _, _, _, _, iid = GetQuestLogChoiceInfo(index);
	else
		_, _, _, _, _, iid = GetQuestLogRewardInfo(index)
	end
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetInboxItem(Tooltip, index, index2)
	local name, iid, _, num = GetInboxItem(index, index2 or 1);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetSendMailItem(Tooltip, index)
	local name, iid, _, num = GetSendMailItem(index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetTradeSkillItem(Tooltip, index, reagent)
	local link;
	if reagent then
		link = GetTradeSkillReagentItemLink(index, reagent);
	else
		link = GetTradeSkillItemLink(index);
	end
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetCraftItem(Tooltip, index, reagent)
	local link = GetCraftReagentItemLink(index, reagent);
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetGuildBankItem(Tooltip, tab, index)
	local link = GetGuildBankItemLink(tab, index);
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipGUISetItem(Tooltip)
	local _, link = Tooltip:GetItem();
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local LT_HookedTooltip = {  };
local function F_HookTooltip(Tooltip)
	if LT_HookedTooltip[Tooltip] ~= nil then
		return;
	end
	LT_HookedTooltip[Tooltip] = true;
	--
	hooksecurefunc(Tooltip, "SetHyperlink", LF_TooltipSetHyperlink);
	hooksecurefunc(Tooltip, "SetItemByID", LF_TooltipSetItemByID);
	--
	hooksecurefunc(Tooltip, "SetMerchantItem", LF_TooltipSetMerchantItem);
	hooksecurefunc(Tooltip, "SetBuybackItem", LF_TooltipSetBuybackItem);
	hooksecurefunc(Tooltip, "SetBagItem", LF_TooltipSetBagItem);
	hooksecurefunc(Tooltip, "SetAuctionItem", LF_TooltipSetAuctionItem);
	hooksecurefunc(Tooltip, "SetAuctionSellItem", LF_TooltipSetAuctionSellItem);
	hooksecurefunc(Tooltip, "SetLootItem", LF_TooltipSetLootItem);
	hooksecurefunc(Tooltip, "SetLootRollItem", LF_TooltipSetLootRollItem);
	hooksecurefunc(Tooltip, "SetInventoryItem", LF_TooltipSetInventoryItem);
	hooksecurefunc(Tooltip, "SetTradePlayerItem", LF_TooltipSetTradePlayerItem);
	hooksecurefunc(Tooltip, "SetTradeTargetItem", LF_TooltipSetTradeTargetItem);
	hooksecurefunc(Tooltip, "SetQuestItem", LF_TooltipSetQuestItem);
	hooksecurefunc(Tooltip, "SetQuestLogItem", LF_TooltipSetQuestLogItem);
	hooksecurefunc(Tooltip, "SetInboxItem", LF_TooltipSetInboxItem);
	hooksecurefunc(Tooltip, "SetSendMailItem", LF_TooltipSetSendMailItem);
	hooksecurefunc(Tooltip, "SetTradeSkillItem", LF_TooltipSetTradeSkillItem);
	hooksecurefunc(Tooltip, "SetCraftItem", LF_TooltipSetCraftItem);
	if __is_classic then
		hooksecurefunc(Tooltip, "SetTrainerService", LF_TooltipGUISetItem);
	elseif __is_bcc or __is_wlk then
		hooksecurefunc(Tooltip, "SetGuildBankItem", LF_TooltipSetGuildBankItem);
	end
end




local GetNumCompanions = GetNumCompanions;
local GetCompanionInfo = GetCompanionInfo;
local function proc()
	for index = 1, GetNumCompanions("CRITTER") do
		local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("CRITTER", index);
		LearnedSpell[spellID] = true;
		local items = Spell2Item[spellID];
		if items ~= nil then
			for i = 1, #items do
				LearnedSpellItem[items[i]] = true;
			end
		end
	end
end

local F = CreateFrame('FRAME');
F:RegisterEvent("COMPANION_LEARNED");
F:RegisterEvent("COMPANION_UNLEARNED");
F:RegisterEvent("PLAYER_ENTERING_WORLD");
F:SetScript("OnEvent", function(self, event)
	if event == "COMPANION_LEARNED" then
		proc();
	elseif event == "COMPANION_UNLEARNED" then
		LearnedSpell = {};
		LearnedSpellItem = {};
		proc();
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD");
		F_HookTooltip(GameTooltip);
		F_HookTooltip(ItemRefTooltip);
		proc();
	end
end);
