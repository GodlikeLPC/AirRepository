if GetLocale() ~= "ptBR" then return end
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
		statLookup[DEFENSE] = "DEFENSE_RATING";
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
		statLookup["Bloqueio de"] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["o poder de ataque"] = "ATTACK_POWER"; --Equipado: Aumenta em 12 o poder de ataque.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["Armadura Reforçada"] = "ARMOR";
		statLookup["de Armadura"] = "ARMOR";
		statLookup["Feitiços de Cura"] = "HEALING_SPELL_POWER";
		statLookup["Todos os Atributos"] = "ALL_STATS";
		statLookup["de mana a cada"] = "MANA_REGEN";
		statLookup["pontos de vida a cada"] = "HEALTH_REGEN";
		statLookup["o dano causado e a cura realizada por feitiços e efeitos mágicos"] = "SPELL_POWER";
		statLookup["o valor de bloqueio do seu escudo"] = "BLOCK_VALUE";
		statLookup["a sua taxa de bloqueio"] = "BLOCK_RATING"; --Equipado: Aumenta em 5 a sua taxa de bloqueio.
		statLookup["a sua taxa de esquiva"] = "DODGE_RATING"; --Equipado: Aumenta em 12 a sua taxa de esquiva.
		statLookup["a taxa de acerto crítico"] = "CRIT_RATING"; --Equipado: Aumenta em 14 a taxa de acerto crítico.
		statLookup["a taxa de acerto crítico de seus feitiços"] = "SPELL_CRIT_RATING"; --Equipado: Aumenta em 14 a taxa de acerto crítico de seus feitiços.
		statLookup["a taxa de defesa"] = "DEFENSE_RATING"; --Equipado: Aumenta em 25 a taxa de defesa.
		statLookup["a sua taxa de acerto"] = "HIT_RATING"; --Equipado: Aumenta em 10 a sua taxa de acerto.
		statLookup["sua taxa de acerto de feitiços"] = "SPELL_HIT_RATING"; --Equipado: Aumenta em 8 sua taxa de acerto de feitiços.
		statLookup["a sua taxa de aparo"] = "PARRY_RATING"; --Equipado: Aumenta em 20 a sua taxa de aparo.
		statLookup["o poder de ataque quando em forma de Felino, Urso, Urso Hediondo e Luniscante"] = "FERAL_ATTACK_POWER"; --Equipado: Aumenta em 337 o poder de ataque quando em forma de Felino, Urso, Urso Hediondo e Luniscante.
		statLookup["sua penetração de feitiços"] = "SPELL_PENETRATION"; --Equipado: Aumenta em 10 sua penetração de feitiços.
		statLookup["a cura realizada por feitiços e efeitos mágicos"] = "HEALING_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos Arcanos"] = "ARCANE_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Fogo"] = "FIRE_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Gelo"] = "FROST_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Sombra"] = "SHADOW_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos Sagrados"] = "HOLY_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Natureza"] = "NATURE_SPELL_POWER";
		statLookup["a perícia em Pesca"] = "FISHING"; --Equipado: Aumenta em 5 a perícia em Pesca.
		statLookup["a taxa de aptidão"] = "EXPERTISE_RATING"; --Equipado: Aumenta em 18 a taxa de aptidão.
		statLookup["a taxa de aceleração de feitiço"] = "SPELL_HASTE_RATING"; --Equipado: Aumenta em 40 a taxa de aceleração de feitiço.
		statLookup["a taxa de aceleração"] = "HASTE_RATING"; --Equipado: Aumenta em 21 a taxa de aceleração.
		statLookup["a taxa de resiliência"] = "RESILIENCE_RATING"; --Equipado: Aumenta em 11 a taxa de resiliência.
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +4 Agilidade
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([^%d%s]+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		if strsub(line, #line-6)=="de dano" then
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) de dano$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (de dano por segundo)%)$") --(0.9 de dano por segundo)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			value, statKey  = FindCaptures(line,"Equipado: %a+ em [até ]*(%d+)%%? ([^%d]+)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Equipado: %a+ (%d+) ([%a%s]+) 5 s%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Equipado: Seus ataques ignoram (%d+) da Armadura do adversário.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end

			value  = FindCaptures(line,"^Equipado: Aumenta o poder de ataque de longo alcance em (%d+)%.$")
			if value then
				addStat("RANGED_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Equipado: Aumenta em (%d+) o poder de ataque quando em forma de Felino, Urso, Urso Hediondo e Luniscante%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Aumenta em (%d+) o poder de ataque quando em forma de Felino, Urso, Urso Hediondo e Luniscante%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			local damageValue
			value, damageValue  = FindCaptures(line,"^Equipado: Aumenta em (%d+) a cura realizada e em até (%d+) o dano causado por todos os feitiços e efeitos mágicos.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two or three words.
		value, statKey  = FindCaptures(line, "^%+?(%d+,?%d*) (%a+%s%a+%s?%a*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+,?%d*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--Two or three words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*) %+?(%d+,?%d*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end
	end

	function ISL:Load()
		FindCaptures, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.GetCreateTable
	end
end