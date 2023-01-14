if GetLocale() ~= "koKR" then return end
local _, GetCreateTable, FindCaptures
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --체력 +1
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --지능 +1
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --민첩성 +4
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --힘 +1
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --정신력 +1
		statLookup[ARMOR] = "ARMOR"; --방어도 5
		statLookup[DEFENSE] = "DEFENSE";
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
		statLookup["피해 방어"] = "BLOCK_VALUE"; --60의 피해 방어
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["전투력이"] = "ATTACK_POWER"; --착용 효과: 전투력이 12만큼 증가합니다.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["속도"] = "SPEED";
		statLookup["방어 강화"] = "ARMOR";
		statLookup["방어 숙련도가"] = "DEFENSE_RATING"; --착용 효과: 방어 숙련도가 25만큼 증가합니다.
		statLookup["치유 효과 증가"] = "HEALING_SPELL_POWER"; --치유 효과 증가 +55
		statLookup["모든 능력치"] = "ALL_STATS"; --모든 능력치 +4 
		statLookup["마나가"] = "MANA_REGEN"; --착용 효과: 매 5초마다 2의 마나가 회복됩니다.
		statLookup["생명력이"] = "HEALTH_REGEN"; --착용 효과: 매 5초마다 2의 생명력이 회복됩니다.
		statLookup["모든 주문 및 효과의 공격력과 치유량이 최대"] = "SPELL_POWER"; --착용 효과: 모든 주문 및 효과의 공격력과 치유량이 최대 6만큼 증가합니다.
		statLookup["방패의 피해 방어량이"] = "BLOCK_VALUE"; --착용 효과: 방패의 피해 방어량이 23만큼 증가합니다.
		statLookup["방패 막기 숙련도가"] = "BLOCK_RATING"; --착용 효과: 방패 막기 숙련도가 5만큼 증가합니다.
		statLookup["회피 숙련도가"] = "DODGE_RATING"; --착용 효과: 회피 숙련도가 12만큼 증가합니다.
		statLookup["치명타 적중도가"] = "CRIT_RATING"; --착용 효과: 치명타 적중도가 14만큼 증가합니다.
		statLookup["적중도가"] = "HIT_RATING"; --착용 효과: 적중도가 10만큼 증가합니다.
		statLookup["주문의 극대화 적중도가"] = "SPELL_CRIT_RATING"; --착용 효과: 주문의 극대화 적중도가 14만큼 증가합니다.
		statLookup["무기 막기 숙련도가"] = "PARRY_RATING"; --착용 효과: 무기 막기 숙련도가 20만큼 증가합니다.
		statLookup["원거리 전투력이"] = "RANGED_ATTACK_POWER"; --착용 효과: 원거리 전투력이 14만큼 증가합니다.
		statLookup["주문 관통력이"] = "SPELL_PENETRATION"; --착용 효과: 주문 관통력이 10만큼 증가합니다.
		statLookup["모든 주문 및 효과에 의한 치유량이 최대"] = "HEALING_SPELL_POWER"; --착용 효과: 모든 주문 및 효과에 의한 치유량이 최대 24만큼 증가합니다.
		statLookup["비전 계열의 주문과 효과의 공격력이 최대"] = "ARCANE_SPELL_POWER"; --착용 효과: 비전 계열의 주문과 효과의 공격력이 최대 14만큼 증가합니다.
		statLookup["화염 계열의 주문과 효과의 공격력이 최대"] = "FIRE_SPELL_POWER"; --착용 효과: 화염 계열의 주문과 효과의 공격력이 최대 7만큼 증가합니다.
		statLookup["냉기 계열의 주문과 효과의 공격력이 최대"] = "FROST_SPELL_POWER"; --착용 효과: 냉기 계열의 주문과 효과의 공격력이 최대 10만큼 증가합니다.
		statLookup["암흑 계열의 주문과 효과의 공격력이 최대"] = "SHADOW_SPELL_POWER"; --착용 효과: 암흑 계열의 주문과 효과의 공격력이 최대 11만큼 증가합니다.
		statLookup["신성 계열의 주문과 효과의 공격력이 최대"] = "HOLY_SPELL_POWER"; --착용 효과: 신성 계열의 주문과 효과의 공격력이 최대 16만큼 증가합니다.
		statLookup["자연 계열의 주문과 효과의 공격력이 최대"] = "NATURE_SPELL_POWER"; --착용 효과: 자연 계열의 주문과 효과의 공격력이 최대 19만큼 증가합니다.
		statLookup["주문 적중도가"] = "SPELL_HIT_RATING"; --착용 효과: 주문 적중도가 8만큼 증가합니다.
		statLookup["표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이"] = "FERAL_ATTACK_POWER"; --착용 효과: 표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 337만큼 증가합니다.
		statLookup["낚시 숙련도"] = "FISHING"; --착용 효과: 낚시 숙련도 +5
		statLookup["숙련도가"] = "EXPERTISE_RATING"; --착용 효과: 숙련도가 18만큼 증가합니다.
		statLookup["주문 시전 가속도가"] = "SPELL_HASTE_RATING"; --착용 효과: 주문 시전 가속도가 40만큼 증가합니다.
		statLookup["가속도가"] = "HASTE_RATING"; --착용 효과: 가속도가 21만큼 증가합니다.
		statLookup["탄력도가"] = "RESILIENCE_RATING"; --착용 효과: 탄력도가 11만큼 증가합니다.
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--체력 +1
		--속도 1.70
		local statKey, value  = FindCaptures(line, "^([^d%s]+) %+?(%d+%.?%d*)$")
		if value then
			addStat(statKey, value, true)
			return
		end
		if strsub(line, 1, #"공격력")=="공격력" then --공격력 10 - 16
			local valueLow, valueHigh = FindCaptures(line, "^공격력 (%d+) %- (%d+)$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value = FindCaptures(line,"^%(초당 공격력 (%d+%.?%d*)%)$") --(초당 공격력 5.0)
		if value then
			addStat("DPS", value)
			return
		end
		
		local statKey
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^착용 효과: ([^%d]+) %+?(%d+)[%%%s만큼 감소시킵만큼 증가합니다%.]*$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^착용 효과: 매 5초마다 (%d+)의 ([^%s]+) 회복됩니다%.$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^착용 효과: 공격 시 적의 방어도를 (%d+)만큼 무시합니다.$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end
			
			value  = FindCaptures(line,"^착용 효과: 표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			local damageValue
			value, damageValue  = FindCaptures(line,"^착용 효과: 모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼, 공격력이 최대 (%d+)만큼 증가합니다.$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--One number("+" optional), followed by one, two or three words.
		value, statKey  = FindCaptures(line, "^%+?(%d+)의? ([^d%s]+%s?[^d%s]*%s?[^d%s]*)$")
		if statKey then
			addStat(statKey, value, true)
			return
		end

		--Two or three words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+%s[^d%s]+%s?[^d%s]*) %+?(%d+)$")
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