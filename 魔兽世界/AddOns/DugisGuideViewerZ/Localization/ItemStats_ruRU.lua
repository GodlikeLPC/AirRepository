if GetLocale() ~= "ruRU" then return end
local _, GetCreateTable, FindCaptures
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --+1 к выносливости
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --+1 к интеллекту
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --+4 к ловкости
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --+1 к силе
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --+1 к духу
		statLookup[ARMOR] = "ARMOR"; --Броня: 5
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
		statLookup["Блокирование"] = "BLOCK_VALUE"; --Блокирование: 46
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["Повышает силу атаки на"] = "ATTACK_POWER"; --Если на персонаже: Повышает силу атаки на 12.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["Усиленная броня"] = "ARMOR";
		statLookup["Увеличение рейтинга защиты на"] = "DEFENSE"; --Если на персонаже: Увеличение рейтинга защиты на 17 ед.
		statLookup["к лечению"] = "HEALING_SPELL_POWER"; --+55 к лечению
		statLookup["ко всем характеристикам"] = GetCreateTable("STA","INT","AGI","STR","SPI"); --+3 ко всем характеристикам
		statLookup["маны раз в"] = "MANA_REGEN"; --Если на персонаже: Восполнение 2 ед. маны раз в 5 сек.
		statLookup["здоровья каждые"] = "HEALTH_REGEN"; --Если на персонаже: Восполняет 2 ед. здоровья каждые 5 сек.
		statLookup["Увеличивает урон и объем исцеления от магических заклинаний и эффектов максимум на"] = "SPELL_POWER"; --Если на персонаже: Увеличивает урон и объем исцеления от магических заклинаний и эффектов максимум на 6 ед.
		statLookup["Увеличение показателя блока щитом на"] = "BLOCK_VALUE"; --Если на персонаже: Увеличение показателя блока щитом на 23 ед.
		statLookup["Увеличение рейтинга блока на"] = "BLOCK_RATING"; --Если на персонаже: Увеличение рейтинга блока на 5 ед.
		statLookup["Увеличение рейтинга уклонения на"] = "DODGE_RATING"; --Если на персонаже: Увеличение рейтинга уклонения на 12 ед.
		statLookup["Увеличение вероятности нанесения критического урона на"] = "CRIT_RATING"; --Если на персонаже: Увеличение вероятности нанесения критического урона на 14 ед.
		statLookup["Увеличение рейтинга меткости на"] = "HIT_RATING"; --Если на персонаже: Увеличение рейтинга меткости на 10 ед.
		statLookup["Повышает рейтинг критического эффекта заклинаний на"] = "SPELL_CRIT_RATING"; --Если на персонаже: Повышает рейтинг критического эффекта заклинаний на 14.
		statLookup["Увеличение рейтинга парирования атак на"] = "PARRY_RATING"; --Если на персонаже: Увеличение рейтинга парирования атак на 20 ед.
		statLookup["Увеличивает силу атак дальнего боя на"] = "RANGED_ATTACK_POWER"; --Если на персонаже: Увеличивает силу атак дальнего боя на 14.
		statLookup["Увеличивает проникающую способность заклинаний на"] = "SPELL_PENETRATION"; --Если на персонаже: Увеличивает проникающую способность заклинаний на 10.
		statLookup["Усиливает исцеление от заклинаний и эффектов максимум на"] = "HEALING_SPELL_POWER"; --Если на персонаже: Усиливает исцеление от заклинаний и эффектов максимум на 24 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами тайной магии, на"] = "ARCANE_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами тайной магии, на 14 ед.
		statLookup["Увеличение наносимого урона от заклинаний и эффектов огня не более чем на"] = "FIRE_SPELL_POWER"; --Если на персонаже: Увеличение наносимого урона от заклинаний и эффектов огня не более чем на 7 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами льда, на"] = "FROST_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами льда, на 10 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами темной магии, на"] = "SHADOW_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами темной магии, на 11 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами светлой магии, на"] = "HOLY_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами светлой магии, на 16 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами сил природы, на"] = "NATURE_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами сил природы, на 19 ед.
		statLookup["Увеличение навыка \"Рыбная ловля\" на"] = "FISHING"; --Если на персонаже: Увеличение навыка "Рыбная ловля" на +5.
		statLookup["Повышает рейтинг мастерства на"] = "EXPERTISE_RATING"; --Если на персонаже: Повышает рейтинг мастерства на 18.
		statLookup["Повышает рейтинг скорости заклинаний на"] = "SPELL_HASTE_RATING"; --Если на персонаже: Повышает рейтинг скорости заклинаний на 40.
		statLookup["Повышает рейтинг скорости боя на"] = "HASTE_RATING"; --Если на персонаже: Повышает рейтинг скорости боя на 21.
		statLookup["Повышает рейтинг устойчивости на"] = "RESILIENCE_RATING"; --Если на персонаже: Повышает рейтинг устойчивости на 11.
		statLookup["Эффективность брони противника против ваших атак снижена на"] = "ARMOR_PENETRATION"; --Если на персонаже: Эффективность брони противника против ваших атак снижена на 98 ед.
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--+4 к ловкости
		local value, statKey  = FindCaptures(line, "^%+?(%d+) (к [^d%s]+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end
		if strsub(line, 1, #"Урон:")=="Урон:" then --Урон: 10-16
			local valueLow, valueHigh = FindCaptures(line, "^Урон: (%d+)%-(%d+)$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (ед. урона в секунду)%)$") --(5.0 ед. урона в секунду)
		if statKey then
			addStat("DPS", value)
			return
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Если на персонаже: ([^%d]-) %+?(%d+)[%%%sед]*[%.,]$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^Если на персонаже: Восполн[^%s]+ (%d+) ед. ([^d]+) 5 сек%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			--Если на персонаже: Увеличивает силу атаки на 337 ед. в облике кошки, медведя, лютого медведя или лунного совуха.
			value = FindCaptures(line,"^Если на персонаже: Увеличивает силу атаки на (%d+) ед. в облике кошки, медведя, лютого медведя или лунного совуха.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end

			value  = FindCaptures(line,"^Увеличивает силу атаки на (%d+) в облике кошки, медведя, лютого медведя и лунного совуха%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			--Если на персонаже: Повышение на 1% рейтинга меткости заклинаний.
			value = FindCaptures(line, "^Если на персонаже: Повышение на (%d+)%% рейтинга меткости заклинаний%.$")
			if value then
				addStat("SPELL_HIT_RATING", value)
				return
			end

			local damageValue
			value, damageValue  = FindCaptures(line,"^Если на персонаже: Усиливает исходящее исцеление максимум на (%d+) ед., а урон от магических эффектов и заклинаний – максимум на (%d+) ед.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([^d%s]+%s[^d%s]+%s?[^d%s]*%s?[^d%s]*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s:]+):? %+?(%d+,?%d*)$")
		if statKey then
			addStat(statKey, value:gsub(',', '.'), true)
			return
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+%s[^d%s:]+%s?[^d%s:]*%s?[^d%s:]*):? %+?(%d+)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end
		
		-- +11 к урону от заклинаний и лечению\	
		value = FindCaptures(line, "^%+(%d+) к урону от заклинаний и лечению$")	
		if value then
		   addStat("SPELL_POWER", value)
		   return
		end		
	end

	function ISL:Load()
		FindCaptures, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.GetCreateTable
	end
end