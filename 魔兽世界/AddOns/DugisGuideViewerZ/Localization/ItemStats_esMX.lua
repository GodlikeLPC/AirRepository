if GetLocale() ~= "esMX" then return end
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
		statLookup["bloqueo"] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["el poder de ataque"] = "ATTACK_POWER"; --Equipar: Aumenta 12 p. el poder de ataque.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["Armadura reforzada"] = "ARMOR";
		statLookup["de armadura"] = "ARMOR";
		statLookup["Aumenta el índice de defensa"] = "DEFENSE_RATING"; --Equipar: Aumenta el índice de defensa 25 p.
		statLookup["Hechizos Curativos"] = "HEALING_SPELL_POWER";
		statLookup["Todas las estadísticas"] = "ALL_STATS";
		statLookup["de maná cada"] = "MANA_REGEN"; --Equipar: Restaura 2 p. de maná cada 5 s.
		statLookup["de salud cada"] = "HEALTH_REGEN"; --Equipar: Restaura 2 p. de salud cada 5 s.
		statLookup["el daño y la sanación de los hechizos y efectos mágicos"] = "SPELL_POWER"; --Equipar: Aumenta hasta 6 p. el daño y la sanación de los hechizos y efectos mágicos.
		statLookup["Aumenta el valor de bloqueo de tu escudo"] = "BLOCK_VALUE"; --Equipar: Aumenta el valor de bloqueo de tu escudo 23 p.
		statLookup["Aumenta tu índice de bloqueo"] = "BLOCK_RATING"; --Equipar: Aumenta tu índice de bloqueo 5 p.
		statLookup["Aumenta tu índice de esquivar"] = "DODGE_RATING"; --Equipar: Aumenta tu índice de esquivar 12 p.
		statLookup["Aumenta tu índice de golpe crítico"] = "CRIT_RATING"; --Equipar: Aumenta tu índice de golpe crítico 14 p.
		statLookup["Mejora tu probabilidad de asestar un golpe crítico con hechizos un"] = "SPELL_CRIT_RATING"; --Equipar: Mejora tu probabilidad de asestar un golpe crítico con hechizos un 1%.
		statLookup["Aumenta tu índice de golpe"] = "HIT_RATING"; --Equipar: Aumenta tu índice de golpe 10 p.
		statLookup["tu probabilidad de golpear con hechizos"] = "SPELL_HIT_RATING"; --Equipar: Mejora un 1% tu probabilidad de golpear con hechizos.
		statLookup["Aumenta tu índice de parada"] = "PARRY_RATING"; --Equipar: Aumenta tu índice de parada 20 p.
		statLookup["el poder de ataque bajo formas felinas, de oso, de oso temible y de lechúcico lunar"] = "FERAL_ATTACK_POWER"; --Equipar: Aumenta 337 p. el poder de ataque bajo formas felinas, de oso, de oso temible y de lechúcico lunar.
		statLookup["el poder de ataque a distancia"] = "RANGED_ATTACK_POWER"; --Equipar: Aumenta 14 p. el poder de ataque a distancia.
		statLookup["Aumenta la penetración de tus hechizos"] = "SPELL_PENETRATION"; --Equipar: Aumenta la penetración de tus hechizos 10 p.
		statLookup["la sanación de los hechizos y efectos"] = "HEALING_SPELL_POWER"; --Equipar: Aumenta hasta 24 p. la sanación de los hechizos y efectos.
		statLookup["el daño que infligen los hechizos y efectos Arcanos"] = "ARCANE_SPELL_POWER"; --Equipar: Aumenta hasta 14 p. el daño que infligen los hechizos y efectos Arcanos.
		statLookup["el daño que infligen los hechizos y efectos de Fuego"] = "FIRE_SPELL_POWER"; --Equipar: Aumenta hasta 7 p. el daño que infligen los hechizos y efectos de Fuego.
		statLookup["el daño que infligen los hechizos y efectos de Escarcha"] = "FROST_SPELL_POWER"; --Equipar: Aumenta hasta 10 p. el daño que infligen los hechizos y efectos de Escarcha.
		statLookup["el daño que infligen los hechizos y efectos de las Sombras"] = "SHADOW_SPELL_POWER"; --Equipar: Aumenta hasta 11 p. el daño que infligen los hechizos y efectos de las Sombras.
		statLookup["el daño que infligen los hechizos y efectos Sagrados"] = "HOLY_SPELL_POWER"; --Equipar: Aumenta hasta 16 p. el daño que infligen los hechizos y efectos Sagrados.
		statLookup["el daño que infligen los hechizos y efectos de Naturaleza"] = "NATURE_SPELL_POWER"; --Equipar: Aumenta hasta 19 p. el daño que infligen los hechizos y efectos de Naturaleza.
		statLookup["Pesca aumentada"] = "FISHING"; --Equipar: Pesca aumentada +5 p.
		statLookup["Aumenta tu índice de pericia un"] = "EXPERTISE_RATING"; --Equipar: Aumenta tu índice de pericia un 18.
		statLookup["Aumenta el índice de celeridad con hechizos"] = "SPELL_HASTE_RATING"; --Equipar: Aumenta el índice de celeridad con hechizos 40 p.
		statLookup["la celeridad"] = "HASTE_RATING"; --Equipar: Aumenta 21 p. la celeridad.
		statLookup["el temple JcJ"] = "RESILIENCE_RATING"; --Equipar: Aumenta 11 p. el temple JcJ.
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +4 Espíritu
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aíá]+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		if strsub(line, #line-7)=="de daño" then
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) p%. de daño$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (p. de daño por segundo)%)$") --(6.0 p. de daño por segundo)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equipar: ([^%d]-) %+?(%d+)%s?p?%%?%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"Equipar: %a+ %a*%s?(%d+)%s?p?%.?%%? ([^%d]+)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Equipar: Restaura (%d+) p. ([%aá%s]+) 5 s%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Equipar: %+(%d+)%s?p?%.? ([^%d]+)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Equipar: Tus ataques ignoran (%d+) p%. de la armadura de tu oponente%.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end

			local damageValue
			value, damageValue  = FindCaptures(line,"^Equipar: Aumenta hasta (%d+) p%. la sanación realizada y hasta (%d+) p%. todo el daño infligido con todos los hechizos y efectos mágicos%.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+%.?%d*)%s?p?%.? (%a+%s%a+%s?%a*%s?%a*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+%.?%d*)%s?p?%.?$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*%s?%a*) %+?(%d+%.?%d*)%s?p?%.?$")
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