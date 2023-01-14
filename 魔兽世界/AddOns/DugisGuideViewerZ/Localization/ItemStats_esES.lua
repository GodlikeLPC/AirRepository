if GetLocale() ~= "esES" then return end
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
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[SPEED] = "SPEED";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["Armadura reforzada"] = "ARMOR";
		statLookup["armadura"] = "ARMOR"; --5 armadura
		statLookup["Defensa aumentada"] = "DEFENSE"; --Equipar: Defensa aumentada +17.
		statLookup["Hechizos Curativos"] = "HEALING_SPELL_POWER";
		statLookup["Todas las estadísticas"] = "ALL_STATS";
		statLookup["de maná cada"] = "MANA_REGEN"; --Equipar: Restaura 2 p. de maná cada 5 s.
		statLookup["de salud cada"] = "HEALTH_REGEN"; --Equipar: Restaura 5 p. de salud cada 5 s.
		statLookup["Aumenta el daño y la sanación de los hechizos mágicos y los efectos hasta en"] = "SPELL_POWER"; --Equipar: Aumenta el daño y la sanación de los hechizos mágicos y los efectos hasta en 6 p.
		statLookup["Aumenta el valor de bloqueo de tu escudo en"] = "BLOCK_VALUE"; --Equipar: Aumenta el valor de bloqueo de tu escudo en 23 p.
		statLookup["Aumenta tu índice de bloqueo en"] = "BLOCK_RATING"; --Equipar: Aumenta tu índice de bloqueo en 5 p.
		statLookup["Aumenta tu índice de esquivar en"] = "DODGE_RATING"; --Equipar: Aumenta tu índice de esquivar en 12 p.
		statLookup["Aumenta tu índice de golpe crítico en"] = "CRIT_RATING"; --Equipar: Aumenta tu índice de golpe crítico en 14 p.
		statLookup["Aumenta tu índice de golpe en"] = "HIT_RATING"; --Equipar: Aumenta tu índice de golpe en 10 p.
		statLookup["Aumenta tu índice de golpe con hechizos en"] = "SPELL_HIT_RATING"; --Equipar: Aumenta tu índice de golpe con hechizos en 8 p.
		statLookup["Aumenta tu índice de parada en"] = "PARRY_RATING"; --Equipar: Aumenta tu índice de parada en 20 p.
		statLookup["Aumenta el índice de defensa en"] = "DEFENSE_RATING"
		statLookup["Aumenta tu índice de golpe crítico con hechizos en"] = "SPELL_CRIT_RATING"
		statLookup["Aumenta tu índice de pericia en"] = "EXPERTISE_RATING"; --Equipar: Aumenta tu índice de pericia en 18 p.
		statLookup["Mejora el índice de celeridad con hechizos en"] = "SPELL_HASTE_RATING" --Equipar: Mejora el índice de celeridad con hechizos en 40 p.
		statLookup["Mejora el índice de celeridad en"] = "HASTE_RATING" --Equipar: Mejora el índice de celeridad en 21 p.
		statLookup["Mejora tu índice de temple en"] = "RESILIENCE_RATING" --Equipar: Mejora tu índice de temple en 11.
		statLookup["el poder de ataque bajo formas felinas, de oso, de oso temible y de lechúcico lunar"] = "FERAL_ATTACK_POWER";
		statLookup["el poder de ataque a distancia"] = "RANGED_ATTACK_POWER"
		statLookup["Aumenta el poder de ataque en"] = "ATTACK_POWER" --Equipar: Aumenta el poder de ataque en 12 p.
		statLookup["Aumenta la penetración de tus hechizos en"] = "SPELL_PENETRATION"; --Equipar: Aumenta la penetración de tus hechizos en 10 p.
		statLookup["Aumenta la curación de los hechizos y los efectos hasta en"] = "HEALING_SPELL_POWER"; --Equipar: Aumenta la curación de los hechizos y los efectos hasta en 24 p.
		statLookup["Aumenta el daño causado por los hechizos Arcanos y los efectos hasta en"] = "ARCANE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos Arcanos y los efectos hasta en 14 p.
		statLookup["Aumenta el daño causado por los hechizos de Fuego y los efectos hasta en"] = "FIRE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Fuego y los efectos hasta en 7 p.
		statLookup["Aumenta el daño causado por los hechizos de Escarcha y los efectos hasta en"] = "FROST_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Escarcha y los efectos hasta en 10 p.
		statLookup["Aumenta el daño causado por los hechizos de las Sombras y los efectos hasta en"] = "SHADOW_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de las Sombras y los efectos hasta en 11 p.
		statLookup["Aumenta el daño causado por los hechizos Sagrados y los efectos hasta en"] = "HOLY_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos Sagrados y los efectos hasta en 16 p.
		statLookup["Aumenta el daño causado por los hechizos de Naturaleza y los efectos hasta en"] = "NATURE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Naturaleza y los efectos hasta en 19 p.
		statLookup["Pesca aumentada"] = "FISHING"; ----Equipar: Pesca aumentada +5.
		statLookup["Mejora el índice de celeridad con hechizos en"] = "SPELL_HASTE_RATING";
		statLookup["Mejora el índice de celeridad en"] = "HASTE_RATING";
		statLookup["Mejora el índice de golpe en"] = "HIT_RATING";
		statLookup["Mejora el índice de golpe crítico en"] = "CRIT_RATING";
		statLookup["Mejora tu índice de temple en"] = "RESILIENCE_RATING";
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

		if strsub(line, #line-4)=="Daño" then --10 - 16 Daño
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) Daño$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (daño por segundo)%)$") --(6.0 p. de daño por segundo)
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

			value, statKey  = FindCaptures(line,"^Equipar: Restaura (%d+) p. ([%aá%s]+) 5 s%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			--[[value, statKey  = FindCaptures(line,"^Equipar: %+(%d+)%s?p?%.? ([^%d]+)%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end]]

			value, statKey = FindCaptures(line, "^Equipar: Aumenta en (%d+) p. ([^%d]+)%.$")
			if value then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^Equipar: Tus ataques ignoran (%d+) p. de la armadura de tu oponente.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end

			value  = FindCaptures(line,"^Equip: Aumenta el poder de ataque (%d+) p. solo con las formas de gato, oso, oso temible y lechúcico lunar%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^Aumenta el poder de ataque (%d+) p. solo con las formas de gato, oso, oso temible y lechúcico lunar%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			local damageValue
			value, damageValue  = FindCaptures(line,"^Equipar: Aumenta la sanación que haces hasta (%d+) p. y el daño que infliges hasta (%d+) p. con todos los hechizos mágicos y efectos.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+,?%d*)%s?p?%.? (%a+%s%a+%s?%a*%s?%a*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%p?) %+?(%d+,?%d*)%s?p?%.?$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*%s?%a*) %+?(%d+,?%d*)%s?p?%.?$")
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