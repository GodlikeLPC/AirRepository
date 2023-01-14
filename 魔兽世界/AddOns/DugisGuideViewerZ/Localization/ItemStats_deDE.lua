if GetLocale() ~= "deDE" then return end
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
		statLookup["Tempo"] = "SPEED";
		statLookup["Verstärkte Rüstung"] = "ARMOR";
		statLookup["Heilzauber"] = "HEALING_SPELL_POWER";
		statLookup["Alle Werte"] = "ALL_STATS";
		statLookup["Mana wieder her"] = "MANA_REGEN"; --Anlegen: Stellt alle 5 Sek. 2 Mana wieder her.
		statLookup["Gesundheit wieder her"] = "HEALTH_REGEN"; --Anlegen: Stellt alle 5 Sek. 2 Gesundheit wieder her.
		statLookup["Punkt(e) Gesundheit"] = "HEALTH_REGEN"; --Anlegen: Stellt alle 5 Sek. 5 Punkt(e) Gesundheit wieder her.
		statLookup["Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung um bis zu"] = "SPELL_POWER"; --Anlegen: Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu 6.
		statLookup["Erhöht den Blockwert Eures Schildes um"] = "BLOCK_VALUE"; --Anlegen: Erhöht den Blockwert Eures Schildes um 23.
		statLookup["Erhöht Eure Blockwertung um"] = "BLOCK_RATING"; --Anlegen: Erhöht Eure Blockwertung um 5.
		statLookup["Erhöht Eure Ausweichwertung um"] = "DODGE_RATING"; --Anlegen: Erhöht Eure Ausweichwertung um 12.
		statLookup["Erhöht Eure kritische Trefferwertung um"] = "CRIT_RATING"; --Anlegen: Erhöht Eure kritische Trefferwertung um 14.
		statLookup["Erhöht Eure Trefferwertung um"] = "HIT_RATING"; --Anlegen: Erhöht Eure Trefferwertung um 10.
		statLookup["Erhöht Eure Zaubertrefferwertung um"] = "SPELL_HIT_RATING"; --Anlegen: Erhöht Eure Zaubertrefferwertung um 8.
		statLookup["Erhöht Eure kritische Zaubertrefferwertung um"] = "SPELL_CRIT_RATING"; --Anlegen: Erhöht Eure kritische Zaubertrefferwertung um 14.
		statLookup["Erhöht Eure Parierwertung um"] = "PARRY_RATING"; --Anlegen: Erhöht Eure Parierwertung um 20.
		statLookup["Erhöht Verteidigungswertung um"] = "DEFENSE_RATING"; --Anlegen: Erhöht Verteidigungswertung um 25.
		statLookup["Erhöht Eure Waffenkundewertung um"] = "EXPERTISE_RATING"; --Anlegen: Erhöht Eure Waffenkundewertung um 18
		statLookup["Erhöht die Zaubertempowertung um"] = "SPELL_HASTE_RATING" --Anlegen: Erhöht die Zaubertempowertung um 40
		statLookup["Erhöht die Tempowertung um"] = "HASTE_RATING" --Anlegen: Erhöht die Tempowertung um 21
		statLookup["Erhöht Eure Abhärtungswertung um"] = "RESILIENCE_RATING" --Anlegen: Erhöht Eure Abhärtungswertung um 11
		statLookup["Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt um"] = "FERAL_ATTACK_POWER"; --Anlegen: Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt um 337.
		statLookup["Erhöht die Angriffskraft um"] = "ATTACK_POWER"; --Anlegen: Erhöht die Angriffskraft um 12.
		statLookup["Erhöht die Distanzangriffskraft um"] = "RANGED_ATTACK_POWER"; --Anlegen: Erhöht die Distanzangriffskraft um 14.
		statLookup["Erhöht Eure Zauberdurchschlagskraft um"] = "SPELL_PENETRATION"; --Anlegen: Reduziert die Magiewiderstände der Ziele Eurer Zauber um 10.
		statLookup["Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu"] = "ARCANE_SPELL_POWER"; --Anlegen: Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu 14.
		statLookup["Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu"] = "FIRE_SPELL_POWER"; --Anlegen: Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu 7.
		statLookup["Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu"] = "FROST_SPELL_POWER"; --Anlegen: Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu 10.
		statLookup["Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu"] = "SHADOW_SPELL_POWER"; --Anlegen: Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu 11.
		statLookup["Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu"] = "HOLY_SPELL_POWER"; --Anlegen: Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu 16.
		statLookup["Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu"] = "NATURE_SPELL_POWER"; --Anlegen: Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu 19.
		statLookup["Angeln"] = "FISHING"; --Anlegen: Angeln +5.
		statLookup["Erhöht die Zaubertempowertung um"] = "SPELL_HASTE_RATING";
		statLookup["Erhöht die Tempowertung um"] = "HASTE_RATING";
		statLookup["Erhöht die kritische Trefferwertung um"] = "HIT_RATING";
		statLookup["Erhöht die kritische Trefferwertung um"] = "CRIT_RATING";
		statLookup["Erhöht Eure Abhärtungswertung um"] = "RESILIENCE_RATING";		
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +1 Willenskraft
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aäüö]+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		if strsub(line, #line-6)=="Schaden" then --10 - 16 Schaden
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) Schaden$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (Schaden pro Sekunde)%)$") --(3.7 Schaden pro Sekunde)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Anlegen: ([%aäüö%s,]+) (%d+)%%?%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Anlegen: Stellt alle 5 Sek. (%d+) ([%a%(%)]+%s?%a* wieder her)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Anlegen: Eure Angriffe ignorieren (%d+) Rüstung Eures Gegners.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end

			statKey, value  = FindCaptures(line,"^Anlegen: ([%aäüö]+) %+(%d+)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end
			
			value  = FindCaptures(line,"^Anlegen: Erhöht die Angriffskraft um(%d+) nur in Katzen-, Bären-, Terrorbären- und Mondkingestalt%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Erhöht die Angriffskraft um(%d+) nur in Katzen-, Bären-, Terrorbären- und Mondkingestalt%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			local damageValue
			value, damageValue  = FindCaptures(line,"^Anlegen: Erhöht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu (%d+) und den verursachten Schaden um bis zu (%d+).$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aäüö]+%s?[%aäüö]*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aäüö]+) %+?(%d+,?%d*)%.?$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--Two words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aäüö]+%s?[%aäüö]*) %+?(%d+)%.?$")
		if statKey then
			addStat(statKey, value, true)
		end
	end

	function ISL:Load()
		FindCaptures, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.GetCreateTable
	end
end