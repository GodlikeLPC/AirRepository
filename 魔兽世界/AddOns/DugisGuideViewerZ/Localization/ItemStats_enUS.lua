if GetLocale() ~= "enUS" then return end
local _, GetCreateTable, FindCaptures
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[SPELL_STAT3_NAME] = "STA";
		statLookup[SPELL_STAT4_NAME] = "INT";
		statLookup[SPELL_STAT2_NAME ] = "AGI";
		statLookup[SPELL_STAT1_NAME] = "STR";
		statLookup[SPELL_STAT5_NAME] = "SPI";
		statLookup[ARMOR] = "ARMOR";
		statLookup[DEFENSE_TOOLTIP] = "DEFENSE_RATING";
		statLookup[MANA] = "MANA";
		statLookup[HEALTH] = "HEALTH";
		statLookup[BLOCK] = "BLOCK_VALUE";
		statLookup[RESISTANCE1_NAME] = "HOLY_RES";
		statLookup[RESISTANCE2_NAME] = "FIRE_RES";
		statLookup[RESISTANCE3_NAME] = "NATURE_RES";
		statLookup[RESISTANCE4_NAME] = "FROST_RES";
		statLookup[RESISTANCE5_NAME] = "SHADOW_RES";
		statLookup[RESISTANCE6_NAME] = "ARCANE_RES";
		statLookup[ITEM_MOD_BLOCK_VALUE_SHORT] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["Reinforced Armor"] = "ARMOR";
		statLookup["Increases defense rating by"] = "DEFENSE_RATING";
		statLookup["Healing Spells"] = "HEALING_SPELL_POWER";
		statLookup["All Stats"] = "ALL_STATS";
		statLookup["mana per"] = "MANA_REGEN";
		statLookup["health every"] = "HEALTH_REGEN";
		statLookup["health per"] = "HEALTH_REGEN";
		statLookup["Increases attack power by"] = "ATTACK_POWER";
		statLookup["Increases damage and healing done by magical spells and effects by up to"] = "SPELL_POWER";
		statLookup["Increases the block value of your shield by"] = "BLOCK_VALUE";
		statLookup["Increases your block rating by"] = "BLOCK_RATING";
		statLookup["Increases your dodge rating by"] = "DODGE_RATING";
		statLookup["Increases your critical strike rating by"] = "CRIT_RATING";
		statLookup["Increases your spell critical strike rating by"] = "SPELL_CRIT_RATING";
		statLookup["Increases your hit rating by"] = "HIT_RATING";
		statLookup["Increases your spell hit rating by"] = "SPELL_HIT_RATING";
		statLookup["Increases your parry rating by"] = "PARRY_RATING";
		statLookup["Increases ranged attack power by"] = "RANGED_ATTACK_POWER";
		statLookup["Increases your spell penetration by"] = "SPELL_PENETRATION";
		statLookup["Increases damage done by Arcane spells and effects by up to"] = "ARCANE_SPELL_POWER";
		statLookup["Increases damage done by Fire spells and effects by up to"] = "FIRE_SPELL_POWER";
		statLookup["Increases damage done by Frost spells and effects by up to"] = "FROST_SPELL_POWER";
		statLookup["Increases damage done by Shadow spells and effects by up to"] = "SHADOW_SPELL_POWER";
		statLookup["Increases damage done by Holy spells and effects by up to"] = "HOLY_SPELL_POWER";
		statLookup["Increases damage done by Nature spells and effects by up to"] = "NATURE_SPELL_POWER";
		statLookup["Increased Fishing"] = "FISHING";
		statLookup["Improves spell haste rating by"] = "SPELL_HASTE_RATING";
		statLookup["Improves haste rating by"] = "HASTE_RATING";
		statLookup["Improves hit rating by"] = "HIT_RATING";
		statLookup["Improves critical strike rating by"] = "CRIT_RATING";
		statLookup["Improves your resilience rating by"] = "RESILIENCE_RATING";
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.  
		--This optimization likely exists in every culture, but put it here just in case there are variations.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +1 Stamina, Stamina +1, 1 Armor, +1 Fire Resistance, Healing Spells +1 
		local value, statKey  = FindCaptures(line, "^%+?(%d+) (%a+)$")
		if statKey then
			 addStat(statKey, value, true)
			 return
		end

		if strsub(line, #line-5)=="Damage" then
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) Damage$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (damage per second)%)$") --(0.9 damage per second)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equip: ([%a%s]-) %+?(%d+)%%?%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Equip: Restores (%d+) (%a+ %a+) 5 sec%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Equip: Your attacks ignore (%d+) of your opponent's armor%.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end

			value  = FindCaptures(line,"^Equip: Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end			

			local damageValue
			value, damageValue  = FindCaptures(line,"^Equip: Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two words.
		value, statKey  = FindCaptures(line, "^%+?(%d+%.?%d*) (%a+%s%a+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+%.?%d*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--Two words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+) %+?(%d+%.?%d*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end
	end

	function ISL:Load()
		FindCaptures, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.GetCreateTable
	end

	--[[
		AGI /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:4909::::::::60:::::\124h[Kodo Hunter's Leggings]\124h\124r")
		INT /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:6241::::::::60:::::\124h[White Linen Robe]\124h\124r")
		SPI /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:6238::::::::60:::::\124h[Brown Linen Robe]\124h\124r")
		STA /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:18957::::::::60:::::\124h[Brushwood Blade]\124h\124r")
		STR /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:4947::::::::60:::::\124h[Jagged Dagger]\124h\124r")
		DAMAGE /run DEFAULT_CHAT_FRAME:AddMessage("\124cffffffff\124Hitem:2493::::::::60:::::\124h[Wooden Mallet]\124h\124r")
		ARMOR /run DEFAULT_CHAT_FRAME:AddMessage("\124cffffffff\124Hitem:11475::::::::60:::::\124h[Wine-stained Cloak]\124h\124r")
		DPS DPS_TEMPLATE /run DEFAULT_CHAT_FRAME:AddMessage("\124cffffffff\124Hitem:8177::::::::60:::::\124h[Practice Sword]\124h\124r")
		HEALTH_REGEN  "Equip: Restores 2 health per 5 sec." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:17770::::::::60:::::\124h[Branchclaw Gauntlets]\124h\124r")
			"Equip: Restores 5 health every 5 sec." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:17743::::::::60:::::\124h[Resurgence Rod]\124h\124r")
		MANA_REGEN /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:20431::::::::60:::::\124h[Lorekeeper's Ring]\124h\124r")
		BLOCK_VALUE "1 Block" /run DEFAULT_CHAT_FRAME:AddMessage("\124cffffffff\124Hitem:6176::::::::60:::::\124h[Dwarven Kite Shield]\124h\124r")
			"Equip: Increases the block value of your shield by 23." /run DEFAULT_CHAT_FRAME:AddMessage("\124cffa335ee\124Hitem:17066::::::::60:::::\124h[Drillborer Disk]\124h\124r")
		ATTACK_POWER "Equip: +12 Attack Power." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:16987::::::::60:::::\124h[Screecher Belt]\124h\124r")
		BLOCK_CHANCE "Equip: Increases your chance to block attacks with a shield by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:7787::::::::60:::::\124h[Resplendent Guardian]\124h\124r")
		DODGE_CHANCE "Equip: Increases your chance to dodge an attack by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:4130::::::::60:::::\124h[Smotts' Compass]\124h\124r")
		CRIT_CHANCE "Equip: Improves your chance to get a critical strike by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:3854::::::::60:::::\124h[Frost Tiger Blade]\124h\124r")
		SPELL_CRIT_CHANCE "Equip: Improves your chance to get a critical strike with spells by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:17719::::::::60:::::\124h[Inventor's Focal Sword]\124h\124r")
		DEFENSE "Equip: Increased Defense +17." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:14624::::::::60:::::\124h[Deathbone Chestplate]\124h\124r")
		FERAL_ATTACK_POWER "Equip: +280 Attack Power in Cat, Bear, and Dire Bear forms only." /run DEFAULT_CHAT_FRAME:AddMessage("\124cffa335ee\124Hitem:21268::::::::60:::::\124h[Blessed Qiraji War Hammer]\124h\124r")
		HIT_CHANCE "Equip: Improves your chance to hit by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:13018::::::::60:::::\124h[Executioner's Cleaver]\124h\124r")
		SPELL_HIT_CHANCE "Equip: Improves your chance to hit with spells by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:22240::::::::60:::::\124h[Greaves of Withering Despair]\124h\124r")
		PARRY_CHANCE "Equip: Increases your chance to parry an attack by 1%." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:9379::::::::60:::::\124h[Sang'thraze the Deflector]\124h\124r")
		RANGED_ATTACK_POWER "Equip: +14 ranged Attack Power." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:10510::::::::60:::::\124h[Mithril Heavy-bore Rifle]\124h\124r")
		SPELL_PENETRATION "Equip: Decreases the magical resistances of your spell targets by 10." /run DEFAULT_CHAT_FRAME:AddMessage("\124cffa335ee\124Hitem:22383::::::::60:::::\124h[Sageblade]\124h\124r")
		SPELL_POWER "Equip: Increases damage and healing done by magical spells and effects by up to 6." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:892::::::::60:::::\124h[Gnoll Casting Gloves]\124h\124r")
		HEALING_SPELL_POWER "Equip: Increases healing done by spells and effects by up to 24." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:2271::::::::60:::::\124h[Staff of the Blessed Seer]\124h\124r")
		ARCANE_SPELL_POWER "Equip: Increases damage done by Arcane spells and effects by up to 14." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:7757::::::::60:::::\124h[Windweaver Staff]\124h\124r")
		FIRE_SPELL_POWER "Equip: Increases damage done by Fire spells and effects by up to 7." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:5183::::::::60:::::\124h[Pulsating Hydra Heart]\124h\124r")
		FROST_SPELL_POWER "Equip: Increases damage done by Frost spells and effects by up to 10." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:2950::::::::60:::::\124h[Icicle Rod]\124h\124r")
		SHADOW_SPELL_POWER "Equip: Increases damage done by Shadow spells and effects by up to 11." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:1484::::::::60:::::\124h[Witching Stave]\124h\124r")
		HOLY_SPELL_POWER "Equip: Increases damage done by Holy spells and effects by up to 16." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff0070dd\124Hitem:20504::::::::60:::::\124h[Lightforged Blade]\124h\124r")
		NATURE_SPELL_POWER "Equip: Increases damage done by Nature spells and effects by up to 19." /run DEFAULT_CHAT_FRAME:AddMessage("\124cff1eff00\124Hitem:1998::::::::60:::::\124h[Bloodscalp Channeling Staff]\124h\124r")
		]]
end