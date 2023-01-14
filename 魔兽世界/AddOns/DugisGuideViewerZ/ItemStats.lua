local _, ISL, GetCreateTable, tUnpack, statLookup, testGear, localStatShorts, localStatOrder,
	AssertStatValue, DumpTooltipLinesIfStat, YieldAutoroutine, ParseText
local strfind, DGV = strfind, DugisGuideViewer
local REQUIRES_RED = 0.99999779462814
local REQUIRES_GREEN = 0.12548992037773
local REQUIRES_BLUE = 0.12548992037773

local IS = DGV:RegisterModule("ItemStats", "ItemStatsLocal")
if IS then
	IS.essential = true

	local statTooltip = CreateFrame("GameTooltip", "DugiTooltip", nil, "GameTooltipTemplate")
	statTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	function statTooltip:NumLines()
		return 40
	end

	function IS:Initialize()

		function IS.FindCaptures(line, pattern)
			return select(3, strfind(line, pattern))
		end

		function IS:Load()
			ISL, GetCreateTable, tUnpack, YieldAutoroutine = DGV.Modules.ItemStatsLocal, DGV.GetCreateTable, DGV.tUnpack, DGV.YieldAutoroutine
			statLookup = GetCreateTable()
			ISL.PopulateFlattenedStatLookup(statLookup)
			ParseText = ISL.ParseText
			
			local function IterateTooltipLines(invariant, control)
				if not control then 
					control = 1
					statTooltip:ClearLines()
					statTooltip:SetHyperlink(invariant)
				end

				local line, text, r, g, b
				repeat
					control = control + 1
					local region = select(control, statTooltip:GetRegions())
					if region and region:GetObjectType() == "FontString" then
						line, text, r, g, b = region, region:GetText(), region:GetTextColor()
					end
				until(text or control==select("#", statTooltip:GetRegions()))
				return line and text and control, text and line, text, r, g, b
			end

			local function AddStat(table, stat, value, lookup)
				if not stat then return end
				if lookup then stat = statLookup[stat] or stat end
				if stat=="ALL_STATS" then
					AddStat(table, "STA", value)
					AddStat(table, "INT", value)
					AddStat(table, "AGI", value)
					AddStat(table, "STR", value)
					AddStat(table, "SPI", value)
					return
				end
				value = value and tonumber(value) or 0
				if value == 0 then return end
					local existingValue = table[stat]
					if existingValue then value = value + existingValue end
					table[stat] = value
				end

			local function IsEquivalent(n1, n2)
				return math.abs(n1-n2)<.00000000000001
			end
		
			local function GetItemSums(itemLink, itemSums)
				local itemSums = itemSums or GetCreateTable()
				local proficiencyMet = true
				local callback = function(fStat, fValue, flookup)
					AddStat(itemSums, fStat, fValue, flookup)
				end
				for _,line,text,r,g,b in IterateTooltipLines,itemLink do
					if text then
						if strsub(text, 1, 2)=="|c" then --strip colorization
							text = strsub(text, 11, #text-2)
						end
						local direct = statLookup[text]
						if direct then 
							AddStat(itemSums, direct, 1)
						else
							ParseText(text, callback)
						end
						proficiencyMet = proficiencyMet and not
							(IsEquivalent(r,REQUIRES_RED) and 
							IsEquivalent(g,REQUIRES_GREEN) and 
							IsEquivalent(b,REQUIRES_BLUE))
					end
				end
				YieldAutoroutine()
				return itemSums, proficiencyMet
			end
			--/dump DugisGuideViewer.Modules.ItemStats.GetItemSums("[Inscribed Leather Boots]")
			IS.GetItemSums = GetItemSums

			--/run DugisGuideViewer.Modules.ItemStats.Test()
			--This may need to be run repeatedly to preload the info for each of the items into the game client's cache
			function IS.Test()
				local start = debugprofilestop()
				for i=1,100 do
					AssertStatValue("STR", 1, "\124cff1eff00\124Hitem:4947::::::::60:::::\124h[Jagged Dagger]\124h\124r")
					AssertStatValue("STA", 1, "\124cff1eff00\124Hitem:18957::::::::60:::::\124h[Brushwood Blade]\124h\124r")
					AssertStatValue("SPI", 1, "\124cff1eff00\124Hitem:6238::::::::60:::::\124h[Brown Linen Robe]\124h\124r")
					AssertStatValue("INT", 1, "\124cff1eff00\124Hitem:6241::::::::60:::::\124h[White Linen Robe]\124h\124r")
					AssertStatValue("AGI", 4, "\124cff1eff00\124Hitem:4909::::::::60:::::\124h[Kodo Hunter's Leggings]\124h\124r")
					AssertStatValue("DAMAGE", 9, "\124cff1eff00\124Hitem:4947::::::::60:::::\124h[Jagged Dagger]\124h\124r")
					AssertStatValue("DAMAGE", 13, "\124cffffffff\124Hitem:2493::::::::60:::::\124h[Wooden Mallet]\124h\124r")
					AssertStatValue("SPEED", 1.7, "\124cffffffff\124Hitem:5040::::::::60:::::\124h[Shadow Hunter Knife]\124h\124r")
					AssertStatValue("ARCANE_SPELL_POWER", 14, "\124cff0070dd\124Hitem:7757::::::::60:::::\124h[Windweaver Staff]\124h\124r")
					AssertStatValue("FIRE_SPELL_POWER", 7, "\124cff0070dd\124Hitem:5183::::::::60:::::\124h[Pulsating Hydra Heart]\124h\124r")
					AssertStatValue("FROST_SPELL_POWER", 10, "\124cff1eff00\124Hitem:2950::::::::60:::::\124h[Icicle Rod]\124h\124r")
					AssertStatValue("SHADOW_SPELL_POWER", 11, "\124cff0070dd\124Hitem:1484::::::::60:::::\124h[Witching Stave]\124h\124r")
					AssertStatValue("HOLY_SPELL_POWER", 16, "\124cff0070dd\124Hitem:20504::::::::60:::::\124h[Lightforged Blade]\124h\124r")
					AssertStatValue("NATURE_SPELL_POWER", 19, "\124cff1eff00\124Hitem:1998::::::::60:::::\124h[Bloodscalp Channeling Staff]\124h\124r")
					AssertStatValue("HEALING_SPELL_POWER", 24, "\124cff0070dd\124Hitem:2271::::::::60:::::\124h[Staff of the Blessed Seer]\124h\124r")
					AssertStatValue("DAMAGE_SPELL_POWER", 8, "\124cff0070dd\124Hitem:2271::::::::60:::::\124h[Staff of the Blessed Seer]\124h\124r")
					AssertStatValue("SPELL_POWER", 6, "\124cff1eff00\124Hitem:892::::::::60:::::\124h[Gnoll Casting Gloves]\124h\124r")
					AssertStatValue("SPELL_PENETRATION", 10, "\124cffa335ee\124Hitem:22383::::::::60:::::\124h[Sageblade]\124h\124r")
					AssertStatValue("RANGED_ATTACK_POWER", 14, "\124cff1eff00\124Hitem:10510::::::::60:::::\124h[Mithril Heavy-bore Rifle]\124h\124r")
					AssertStatValue("PARRY_RATING", 20, "\124cff0070dd\124Hitem:9379::::::::60:::::\124h[Sang'thraze the Deflector]\124h\124r")
					AssertStatValue("SPELL_HIT_RATING", 8, "\124cff0070dd\124Hitem:22240::::::::60:::::\124h[Greaves of Withering Despair]\124h\124r")
					AssertStatValue("HIT_RATING", 10, "\124cff0070dd\124Hitem:13018::::::::60:::::\124h[Executioner's Cleaver]\124h\124r")
					AssertStatValue("FERAL_ATTACK_POWER", 337, "\124cffa335ee\124Hitem:21268::::::::60:::::\124h[Blessed Qiraji War Hammer]\124h\124r")
					AssertStatValue("DEFENSE_RATING", 25, "\124cff0070dd\124Hitem:14624::::::::60:::::\124h[Deathbone Chestplate]\124h\124r")
					AssertStatValue("SPELL_CRIT_RATING", 14, "\124cff0070dd\124Hitem:17719::::::::60:::::\124h[Inventor's Focal Sword]\124h\124r")
					AssertStatValue("CRIT_RATING", 14, "\124cff1eff00\124Hitem:3854::::::::60:::::\124h[Frost Tiger Blade]\124h\124r")
					AssertStatValue("DODGE_RATING", 12, "\124cff1eff00\124Hitem:4130::::::::60:::::\124h[Smotts' Compass]\124h\124r")
					AssertStatValue("BLOCK_RATING", 5, "\124cff0070dd\124Hitem:7787::::::::60:::::\124h[Resplendent Guardian]\124h\124r")
					AssertStatValue("ATTACK_POWER", 12, "\124cff1eff00\124Hitem:16987::::::::60:::::\124h[Screecher Belt]\124h\124r")
					AssertStatValue("BLOCK_VALUE", 60+23, "\124cffa335ee\124Hitem:17066::::::::60:::::\124h[Drillborer Disk]\124h\124r")
					AssertStatValue("BLOCK_VALUE", 1, "\124cffffffff\124Hitem:6176::::::::60:::::\124h[Dwarven Kite Shield]\124h\124r")
					AssertStatValue("MANA_REGEN", 2, "\124cff0070dd\124Hitem:20431::::::::60:::::\124h[Lorekeeper's Ring]\124h\124r")
					AssertStatValue("HEALTH_REGEN", 5, "\124cff0070dd\124Hitem:17743::::::::60:::::\124h[Resurgence Rod]\124h\124r")
					AssertStatValue("HEALTH_REGEN", 2, "\124cff1eff00\124Hitem:17770::::::::60:::::\124h[Branchclaw Gauntlets]\124h\124r")
					AssertStatValue("DPS", 3.7, "\124cffffffff\124Hitem:8177::::::::60:::::\124h[Practice Sword]\124h\124r")
					AssertStatValue("ARMOR", 5, "\124cffffffff\124Hitem:11475::::::::60:::::\124h[Wine-stained Cloak]\124h\124r")
					AssertStatValue("FISHING", 5, "\124cff1eff00\124Hitem:19972::::::::60:::::\124h[Lucky Fishing Hat]\124h\124r")
					AssertStatValue("EXPERTISE_RATING", 18, "\124cff0070dd\124Hitem:31544::::::::70:::::\124h[Clefthoof Hide Leggings]\124h\124r")
					AssertStatValue("SPELL_HASTE_RATING", 40, "\124cffa335ee\124Hitem:34364::::::::70:::::\124h[Sunfire Robe]\124h\124r");
					AssertStatValue("HASTE_RATING", 21, "\124cffa335ee\124Hitem:34893::::::::70:::::\124h[Vanir's Right Fist of Brutality]\124h\124r");
					AssertStatValue("ARMOR_PENETRATION", 98, "\124cff0070dd\124Hitem:34703::::::::70:::::\124h[Latro's Dancing Blade]\124h\124r");
					AssertStatValue("RESILIENCE_RATING", 11, "\124cffa335ee\124Hitem:28555::::::::70:::::\124h[Seal of the Exorcist]\124h\124r");
					AssertStatValue("RED_SOCKET", 3, "\124cffa335ee\124Hitem:34364::::::::70:::::\124h[Sunfire Robe]\124h\124r");
					AssertStatValue("YELLOW_SOCKET", 1, "\124cffa335ee\124Hitem:23535::::::::70:::::\124h[Helm of the Stalwart Defender]\124h\124r");
					AssertStatValue("BLUE_SOCKET", 1, "\124cffa335ee\124Hitem:23535::::::::70:::::\124h[Helm of the Stalwart Defender]\124h\124r");
				end
				DGV:DebugFormat("ItemStats.Test", "milliseconds", debugprofilestop()-start)
			end

			--/run DugisGuideViewer.Modules.ItemStats.FindConstant("")
			function IS.FindConstant(query)
				for key, value in next,_G do
					if value and type(value)=="string" then
						if string.match(key, query) then
							DGV:DebugFormat("ItemStats.FindConstant", "query", query, "key", key, "value", value)
						end
						if string.match(value, query) then
							DGV:DebugFormat("ItemStats.FindConstant", "query", query, "key", key, "value", value)
						end
					end
				end
			end

			--/run DugisGuideViewer.Modules.ItemStats.DumpTooltipLinesForStat("FISHING")
			function IS.DumpTooltipLinesForStat(stat)
				for link, checkStat in next, testGear do
					DumpTooltipLinesIfStat(stat, checkStat, link)
				end
			end

			AssertStatValue = function(stat, value, link)
				local stats = GetItemSums(link)
				local statValue = stats[stat]
				assert(statValue, "stats table does not contain "..stat)
				assert(statValue==value, string.format("expected value %s, was actually %s", value, statValue))
				stats:Pool()
			end

			DumpTooltipLinesIfStat = function(stat, checkStat, link)
				if stat==checkStat then
					DGV:DebugFormat("DumpTooltipLinesIfStat", "link", link)
					IS.DumpTooltipLines(link)
				end
			end
			
			--/run DugisGuideViewer.Modules.ItemStats.DumpTooltipLines("")
			function IS.DumpTooltipLines(link)
				for _,line,text in IterateTooltipLines,link do
					if text then
						DGV:DebugFormat("DumpTooltipLines", "stat", stat, "text", text)
					end
				end
			end

			local LoadItemLink
			LoadItemLink = function(link)
				local count = 0
				for _,line,text in IterateTooltipLines,link do 
					if text then
						count = count + 1
					end
				end
				if count <= 1 then
					DGV.RegisterStopwatchReaction(5):WithAction(LoadItemLink, link):InvokePassively():Once()
					return
				end
			end

			local function LoadTestGear()
				testGear = GetCreateTable();
				testGear["\124cff1eff00\124Hitem:4947::::::::60:::::\124h[Jagged Dagger]\124h\124r"] = "STR"
				testGear["\124cff1eff00\124Hitem:18957::::::::60:::::\124h[Brushwood Blade]\124h\124r"] = "STA"
				testGear["\124cff1eff00\124Hitem:6238::::::::60:::::\124h[Brown Linen Robe]\124h\124r"] = "SPI"
				testGear["\124cff1eff00\124Hitem:6241::::::::60:::::\124h[White Linen Robe]\124h\124r"] = "INT"
				testGear["\124cff1eff00\124Hitem:4909::::::::60:::::\124h[Kodo Hunter's Leggings]\124h\124r"] = "AGI"
				testGear["\124cffffffff\124Hitem:2493::::::::60:::::\124h[Wooden Mallet]\124h\124r"] = "DAMAGE"
				testGear["\124cffffffff\124Hitem:5040::::::::60:::::\124h[Shadow Hunter Knife]\124h\124r"] = "SPEED"
				testGear["\124cff0070dd\124Hitem:7757::::::::60:::::\124h[Windweaver Staff]\124h\124r"] = "ARCANE_SPELL_POWER"
				testGear["\124cff0070dd\124Hitem:5183::::::::60:::::\124h[Pulsating Hydra Heart]\124h\124r"] = "FIRE_SPELL_POWER"
				testGear["\124cff1eff00\124Hitem:2950::::::::60:::::\124h[Icicle Rod]\124h\124r"] = "FROST_SPELL_POWER"
				testGear["\124cff0070dd\124Hitem:1484::::::::60:::::\124h[Witching Stave]\124h\124r"] = "SHADOW_SPELL_POWER"
				testGear["\124cff0070dd\124Hitem:20504::::::::60:::::\124h[Lightforged Blade]\124h\124r"] = "HOLY_SPELL_POWER"
				testGear["\124cff1eff00\124Hitem:1998::::::::60:::::\124h[Bloodscalp Channeling Staff]\124h\124r"] = "NATURE_SPELL_POWER"
				testGear["\124cff0070dd\124Hitem:2271::::::::60:::::\124h[Staff of the Blessed Seer]\124h\124r"] = "HEALING_SPELL_POWER"
				testGear["\124cff1eff00\124Hitem:892::::::::60:::::\124h[Gnoll Casting Gloves]\124h\124r"] = "SPELL_POWER"
				testGear["\124cffa335ee\124Hitem:22383::::::::60:::::\124h[Sageblade]\124h\124r"] = "SPELL_PENETRATION"
				testGear["\124cff1eff00\124Hitem:10510::::::::60:::::\124h[Mithril Heavy-bore Rifle]\124h\124r"] = "RANGED_ATTACK_POWER"
				testGear["\124cff0070dd\124Hitem:9379::::::::60:::::\124h[Sang'thraze the Deflector]\124h\124r"] = "PARRY_CHANCE"
				testGear["\124cff0070dd\124Hitem:22240::::::::60:::::\124h[Greaves of Withering Despair]\124h\124r"] = "SPELL_HIT_CHANCE"
				testGear["\124cff0070dd\124Hitem:13018::::::::60:::::\124h[Executioner's Cleaver]\124h\124r"] = "HIT_CHANCE"
				testGear["\124cffa335ee\124Hitem:21268::::::::60:::::\124h[Blessed Qiraji War Hammer]\124h\124r"] = "FERAL_ATTACK_POWER"
				testGear["\124cff0070dd\124Hitem:14624::::::::60:::::\124h[Deathbone Chestplate]\124h\124r"] = "DEFENSE"
				testGear["\124cff0070dd\124Hitem:17719::::::::60:::::\124h[Inventor's Focal Sword]\124h\124r"] = "SPELL_CRIT_CHANCE"
				testGear["\124cff1eff00\124Hitem:3854::::::::60:::::\124h[Frost Tiger Blade]\124h\124r"] = "CRIT_CHANCE"
				testGear["\124cff1eff00\124Hitem:4130::::::::60:::::\124h[Smotts' Compass]\124h\124r"] = "DODGE_CHANCE"
				testGear["\124cff0070dd\124Hitem:7787::::::::60:::::\124h[Resplendent Guardian]\124h\124r"] = "BLOCK_CHANCE"
				testGear["\124cff1eff00\124Hitem:16987::::::::60:::::\124h[Screecher Belt]\124h\124r"] = "ATTACK_POWER"
				testGear["\124cffa335ee\124Hitem:17066::::::::60:::::\124h[Drillborer Disk]\124h\124r"] = "BLOCK_VALUE"
				testGear["\124cffffffff\124Hitem:6176::::::::60:::::\124h[Dwarven Kite Shield]\124h\124r"] = "BLOCK_VALUE"
				testGear["\124cff0070dd\124Hitem:20431::::::::60:::::\124h[Lorekeeper's Ring]\124h\124r"] = "MANA_REGEN"
				testGear["\124cff0070dd\124Hitem:17743::::::::60:::::\124h[Resurgence Rod]\124h\124r"] = "HEALTH_REGEN"
				testGear["\124cff1eff00\124Hitem:17770::::::::60:::::\124h[Branchclaw Gauntlets]\124h\124r"] = "HEALTH_REGEN"
				testGear["\124cffffffff\124Hitem:8177::::::::60:::::\124h[Practice Sword]\124h\124r"] = "DPS"
				testGear["\124cffffffff\124Hitem:11475::::::::60:::::\124h[Wine-stained Cloak]\124h\124r"] = "ARMOR"
				testGear["\124cff1eff00\124Hitem:19972::::::::60:::::\124h[Lucky Fishing Hat]\124h\124r"] = "FISHING"
				testGear["\124cff0070dd\124Hitem:31544::::::::70:::::\124h[Clefthoof Hide Leggings]\124h\124r"] = "EXPERTISE_RATING"
				testGear["\124cffa335ee\124Hitem:34364::::::::70:::::\124h[Sunfire Robe]\124h\124r"] = "SPELL_HASTE_RATING"
				testGear["\124cffa335ee\124Hitem:34893::::::::70:::::\124h[Vanir's Right Fist of Brutality]\124h\124r"] = "HASTE_RATING"
				testGear["\124cff0070dd\124Hitem:34703::::::::70:::::\124h[Latro's Dancing Blade]\124h\124r"] = "ARMOR_PENETRATION"
				testGear["\124cffa335ee\124Hitem:28555::::::::70:::::\124h[Seal of the Exorcist]\124h\124r"] = "RESILIENCE_RATING"
				testGear["\124cffa335ee\124Hitem:23535::::::::70:::::\124h[Helm of the Stalwart Defender]\124h\124r"] = "RED_SOCKET"
				for link, stat in next, testGear do
					LoadItemLink(link)
				end
			end

			if DGV.Debug then
				LoadTestGear()
			end

			localStatShorts = GetCreateTable()
			localStatShorts["STR"] = ITEM_MOD_STRENGTH_SHORT
			localStatShorts["SPI"] = ITEM_MOD_SPIRIT_SHORT
			localStatShorts["AGI"] = ITEM_MOD_AGILITY_SHORT
			localStatShorts["INT"] = ITEM_MOD_INTELLECT_SHORT
			localStatShorts["DPS"] = STAT_DPS_SHORT
			localStatShorts["STA"] = ITEM_MOD_STAMINA_SHORT
			localStatShorts["ARMOR"] = STAT_ARMOR
			localStatShorts["DEFENSE_RATING"] = DEFENSE_TOOLTIP
			localStatShorts["SPEED"] = SPEED
			localStatShorts["DAMAGE"] = DAMAGE
			localStatShorts["HEALTH"] = ITEM_MOD_HEALTH_SHORT
			localStatShorts["MANA"] = ITEM_MOD_MANA_SHORT
			localStatShorts["HEALTH_REGEN"] = ITEM_MOD_HEALTH_REGENERATION_SHORT
			localStatShorts["MANA_REGEN"] = ITEM_MOD_MANA_REGENERATION_SHORT
			localStatShorts["ATTACK_POWER"] = ITEM_MOD_ATTACK_POWER_SHORT
			localStatShorts["RANGED_ATTACK_POWER"] = ITEM_MOD_RANGED_ATTACK_POWER_SHORT
			localStatShorts["FERAL_ATTACK_POWER"] = ITEM_MOD_FERAL_ATTACK_POWER_SHORT
			localStatShorts["SPELL_POWER"] = ITEM_MOD_SPELL_POWER_SHORT
			localStatShorts["SPELL_PENETRATION"] = ITEM_MOD_SPELL_PENETRATION_SHORT
			localStatShorts["BLOCK_VALUE"] = ITEM_MOD_BLOCK_VALUE_SHORT
			localStatShorts["SPELL_CRIT_RATING"] = ITEM_MOD_CRIT_SPELL_RATING_SHORT
			localStatShorts["SPELL_HIT_RATING"] = ITEM_MOD_HIT_SPELL_RATING_SHORT
			localStatShorts["CRIT_RATING"] = COMBAT_RATING_NAME9
			localStatShorts["BLOCK_RATING"] = COMBAT_RATING_NAME5
			localStatShorts["HIT_RATING"] = COMBAT_RATING_NAME6
			localStatShorts["PARRY_RATING"] = COMBAT_RATING_NAME4
			localStatShorts["DODGE_RATING"] = COMBAT_RATING_NAME3
			localStatShorts["HOLY_RES"] = RESISTANCE1_NAME
			localStatShorts["FIRE_RES"] = RESISTANCE2_NAME
			localStatShorts["NATURE_RES"] = RESISTANCE3_NAME
			localStatShorts["FROST_RES"] = RESISTANCE4_NAME
			localStatShorts["SHADOW_RES"] = RESISTANCE5_NAME
			localStatShorts["HOLY_SPELL_POWER"] = DAMAGE_SCHOOL2
			localStatShorts["FIRE_SPELL_POWER"] = DAMAGE_SCHOOL3
			localStatShorts["NATURE_SPELL_POWER"] = DAMAGE_SCHOOL4
			localStatShorts["FROST_SPELL_POWER"] = DAMAGE_SCHOOL5
			localStatShorts["SHADOW_SPELL_POWER"] = DAMAGE_SCHOOL6
			localStatShorts["ARCANE_SPELL_POWER"] = DAMAGE_SCHOOL7	
			localStatShorts["HEALING_SPELL_POWER"] = ITEM_MOD_SPELL_HEALING_DONE_SHORT
			localStatShorts["DAMAGE_SPELL_POWER"] = ITEM_MOD_SPELL_DAMAGE_DONE_SHORT
			localStatShorts["EXPERTISE_RATING"] = ITEM_MOD_EXPERTISE_RATING_SHORT
			localStatShorts["SPELL_HASTE_RATING"] = string.format("%s %s", STAT_CATEGORY_SPELL, ITEM_MOD_HASTE_RATING_SHORT)
			localStatShorts["HASTE_RATING"] = ITEM_MOD_HASTE_RATING_SHORT
			localStatShorts["ARMOR_PENETRATION"] = ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT
			localStatShorts["RESILIENCE_RATING"] = ITEM_MOD_RESILIENCE_RATING_SHORT
			localStatShorts["RED_SOCKET"] = EMPTY_SOCKET_RED
			localStatShorts["YELLOW_SOCKET"] = EMPTY_SOCKET_YELLOW
			localStatShorts["BLUE_SOCKET"] = EMPTY_SOCKET_BLUE

			localStatOrder = GetCreateTable("STR",
				"AGI",
				"STA",
				"INT",
				"SPI",
				"ARMOR",
				"DAMAGE",
				"SPEED",
				"DPS",
				"HEALTH",
				"MANA",
				"HEALTH_REGEN",
				"MANA_REGEN",
				"SPELL_CRIT_RATING",
				"SPELL_HIT_RATING",
				"SPELL_HASTE_RATING",
				"CRIT_RATING",
				"HIT_RATING",
				"HASTE_RATING",
				"DEFENSE_RATING",
				"PARRY_RATING",
				"BLOCK_RATING",
				"DODGE_RATING",
				"RESILIENCE_RATING",
				"EXPERTISE_RATING",
				"ATTACK_POWER",
				"RANGED_ATTACK_POWER",
				"FERAL_ATTACK_POWER",
				"SPELL_POWER",
				"HOLY_SPELL_POWER",
				"FIRE_SPELL_POWER",
				"NATURE_SPELL_POWER",
				"FROST_SPELL_POWER",
				"SHADOW_SPELL_POWER",
				"ARCANE_SPELL_POWER",
				"HEALING_SPELL_POWER",
				"DAMAGE_SPELL_POWER",
				"SPELL_PENETRATION",
				"BLOCK_VALUE",
				"ARMOR_PENETRATION",
				"RED_SOCKET",
				"YELLOW_SOCKET",
				"BLUE_SOCKET",
				"HOLY_RES",
				"FIRE_RES",
				"NATURE_RES",
				"FROST_RES",
				"SHADOW_RES")
			
			function IS.GetLocalStatShort(stat)
				return localStatShorts[stat]
			end

			function IS.IterateLocalStatsAndShorts(invariant, index)
				if not index then index = 0 end
				index = index + 1
				if index > #localStatOrder then return end
				local key = localStatOrder[index]
				return index, key, localStatShorts[key]
			end
		end

		function IS:Unload()
			for statKey, stats in next, statLookup do
				if type(stats)=="table" then
					stats:Pool()
				end
			end
			statLookup:Pool()
			if testGear then testGear:Pool() end
			if localStatShorts then localStatShorts:Pool() end
			if localStatOrder then localStatOrder:Pool() end
		end
	end
end