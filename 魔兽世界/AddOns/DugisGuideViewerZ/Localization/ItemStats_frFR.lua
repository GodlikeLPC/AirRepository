if GetLocale() ~= "frFR" then return end
local _, GetCreateTable, FindCaptures
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA";
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT";
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI";
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR";
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI";
		statLookup[ARMOR] = "ARMOR";
		statLookup[DEFENSE_TOOLTIP] = "DEFENSE_RATING";
		statLookup[MANA] = "MANA";
		statLookup[HEALTH] = "HEALTH";
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
		statLookup["Bloquer "] = "BLOCK_VALUE"; --Bloquer : 60
		statLookup["Armure renforcée"] = "ARMOR";
		statLookup["Sorts de soins"] = "HEALING_SPELL_POWER";
		statLookup["Toutes les caractéristiques"] = "ALL_STATS"
		statLookup["mana"] = "MANA_REGEN"; --Équipé : Rend 2 points de mana toutes les 5 secondes.
		statLookup["vie"] = "HEALTH_REGEN"; --Équipé : Rend 2 points de vie toutes les 5 sec.
		statLookup["Score de défense augmenté de"] = "DEFENSE_RATING"; --Équipé : Score de défense augmenté de 25.
		statLookup["la puissance d'attaque"] = "ATTACK_POWER"; --Équipé : +12 à la puissance d'attaque.
		statLookup["Augmente les dégâts et les soins produits par les sorts et effets magiques de"] = "SPELL_POWER"; --Équipé : Augmente les dégâts et les soins produits par les sorts et effets magiques de 6 au maximum.
		statLookup["Augmente la valeur de blocage de votre bouclier de"] = "BLOCK_VALUE"; --Équipé : Augmente la valeur de blocage de votre bouclier de 23.
		statLookup["Augmente votre score de blocage de"] = "BLOCK_RATING"; --Équipé : Augmente votre score de blocage de 5.
		statLookup["Augmente votre score d'esquive de"] = "DODGE_RATING"; --Équipé : Augmente votre score d'esquive de 12.
		statLookup["Augmente votre score de coup critique de"] = "CRIT_RATING"; --Équipé : Augmente votre score de coup critique de 14.
		statLookup["Augmente votre score de toucher de"] = "HIT_RATING"; --Équipé : Augmente votre score de toucher de 10.
		statLookup["Augmente le score de toucher des sorts de"] = "SPELL_HIT_RATING"; --Équipé : Augmente le score de toucher des sorts de 8.
		statLookup["Augmente le score de coup critique des sorts de"] = "SPELL_CRIT_RATING"; --Équipé : Augmente le score de coup critique des sorts de 14.
		statLookup["Augmente votre score de parade de"] = "PARRY_RATING"; --Équipé : Augmente votre score de parade de 20.
		statLookup["la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement"] = "FERAL_ATTACK_POWER"; --Équipé : +280 à la puissance d'attaque pour les formes de félin, d'ours et d'ours redoutable uniquement.
		statLookup["Augmente la puissance des attaques à distance de"] = "RANGED_ATTACK_POWER"; --Équipé : Augmente la puissance des attaques à distance de 14.
		statLookup["Augmente la pénétration de vos sorts de"] = "SPELL_PENETRATION"; --Équipé : Augmente la pénétration de vos sorts de 10.
		statLookup["Augmente les soins prodigués par les sorts et effets de"] = "HEALING_SPELL_POWER"; --Équipé : Augmente les soins prodigués par les sorts et effets de 24 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets des Arcanes de"] = "ARCANE_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets des Arcanes de 14 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Feu de"] = "FIRE_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets de Feu de 7 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Givre de"] = "FROST_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets de Givre de 10 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets d'Ombre de"] = "SHADOW_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets d'Ombre de 11 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets du Sacré de"] = "HOLY_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets du Sacré de 16 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Nature de"] = "NATURE_SPELL_POWER"; --Équipé : Augmente les dégâts infligés par les sorts et effets de Nature de 19 au maximum.
		statLookup["Pêche augmentée de"] = "FISHING" --Équipé : Pêche augmentée de 5.
		statLookup["le score d’expertise"] = "EXPERTISE_RATING"; --Équipé : Augmente de 18 le score d’expertise.
		statLookup["le score de hâte des sorts"] = "SPELL_HASTE_RATING"; --Équipé : Augmente de 40 le score de hâte des sorts.
		statLookup["le score de hâte"] = "HASTE_RATING"; --Équipé : Augmente de 21 le score de hâte.
		statLookup["le score de résilience"] = "RESILIENCE_RATING";  --Équipé : Augmente de 11 le score de résilience.
		statLookup["le score de hâte des sorts"] = "SPELL_HASTE_RATING";--Équipé : Augmente de 32 le score de hâte des sorts.
		statLookup["le score de hâte"] = "HASTE_RATING"; --Équipé : Augmente de 25 le score de hâte.
		statLookup["le score de toucher"] = "HIT_RATING"; --Équipé : Augmente de 19 le score de toucher.
		statLookup["le score de coup critique"] = "CRIT_RATING"; --Équipé : Augmente de 50 le score de coup critique. 
		statLookup["le score de résilience"] = "RESILIENCE_RATING"; -- Équipé : Augmente de 33 le score de résilience
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +1 Esprit
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aé'âà']+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		if strsub(line, 1, 10)=="Dégâts :" then --Dégâts : 10 - 16
			local valueLow, valueHigh = FindCaptures(line, "^Dégâts : (%d+) %- (%d+)$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (dégâts par seconde)%)$") --(5.0 dégâts par seconde)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Équipé : ([%aéê'âà',%s]+) (%d+)%%?%s?a?u?%s?m?a?x?i?m?u?m?%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Équipé : Rend (%d+) points de (%a+) toutes les 5 seco?n?d?e?s?%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Équipé : Augmente de (%d+) ([%aéê'âà'’,%s]+).$")
			if value then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Équipé : Vos attaques ignorent (%d+) points de l'armure de votre adversaire.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end
			
			value  = FindCaptures(line,"^Équipé : Augmente la puissance d'attaque de (%d+) seulement en forme de félin, ours, ours redoutable ou sélénieny%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Augmente la puissance d'attaque de (%d+) seulement en forme de félin, ours, ours redoutable ou sélénien%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			local damageValue
			value, damageValue  = FindCaptures(line,"^Équipé : Augmente les soins prodigués d'un maximum de (%d+) et les dégâts d'un maximum de (%d+) pour tous les sorts et effets magiques.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aé'âà',]+%s[%aé'âà',]+%s?[%aé'âà',]*%s?[%aé'âà',]*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aé'âà' ]+)%s?:? %+?(%d+,?%d*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aé'âà',]+%s[%aé'âà',]+%s?[%aé'âà',]*%s?[%aé'âà',]*)%s?:? %+?(%d+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end
	end

	function ISL:Load()
		FindCaptures, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.GetCreateTable
	end
end