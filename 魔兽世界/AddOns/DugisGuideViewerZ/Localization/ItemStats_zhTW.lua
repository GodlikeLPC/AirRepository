if GetLocale() ~= "zhTW" then return end
local _, GetCreateTable, FindCaptures
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --+1耐力
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --+1智力
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --+4敏捷
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --+1力量
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --+1精神
		statLookup["點護甲"] = "ARMOR"; --5點護甲
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
		statLookup["格擋"] = "BLOCK_VALUE"; --46格擋
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["提高攻擊強度"] = "ATTACK_POWER"; --裝備: 提高攻擊強度12點。
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup[EMPTY_SOCKET_RED] = "RED_SOCKET";
		statLookup[EMPTY_SOCKET_YELLOW] = "YELLOW_SOCKET";
		statLookup[EMPTY_SOCKET_BLUE] = "BLUE_SOCKET";
		statLookup["强化护甲"] = "ARMOR"; --强化护甲 +8
		statLookup["防禦等級提高"] = "DEFENSE_RATING"; --裝備: 防禦等級提高25點。
		statLookup["所有属性"] = "ALL_STATS"; --所有属性 +4
		statLookup["法"] = "MANA_REGEN"; --裝備: 每5秒恢復2點法力。
		statLookup["生命"] = "HEALTH_REGEN"; --裝備: 每5秒恢復2點生命力。
		statLookup["使所有法術和魔法效果所造成的傷害和治療效果提高最多"] = "SPELL_POWER"; --裝備: 使所有法術和魔法效果所造成的傷害和治療效果提高最多6點。
		statLookup["使你盾牌的格擋值提高"] = "BLOCK_VALUE"; --裝備: 使你盾牌的格擋值提高23點。
		statLookup["使你的格擋等級提高"] = "BLOCK_RATING"; --裝備: 使你的格擋等級提高5點。
		statLookup["使你的閃躲等級提高"] = "DODGE_RATING"; --裝備: 使你的閃躲等級提高12點。
		statLookup["使你的致命一擊等級提高"] = "CRIT_RATING"; --裝備: 使你的致命一擊等級提高14點。
		statLookup["使你的命中等級提高"] = "HIT_RATING"; --裝備: 使你的命中等級提高10點。
		statLookup["使你的法術致命一擊等級提高"] = "SPELL_CRIT_RATING"; --裝備: 使你的法術致命一擊等級提高14點。
		statLookup["使你的招架等級提高"] = "PARRY_RATING"; --裝備: 使你的招架等級提高20點。
		statLookup["遠程攻擊強度提高"] = "RANGED_ATTACK_POWER"; --裝備: 遠程攻擊強度提高14點。
		statLookup["使你的法術穿透力提高"] = "SPELL_PENETRATION"; --裝備: 使你的法術穿透力提高10點。
		statLookup["使秘法法術和效果所造成的傷害提高最多"] = "ARCANE_SPELL_POWER"; --裝備: 使秘法法術和效果所造成的傷害提高最多14點。
		statLookup["使火焰法術和效果所造成的傷害提高最多"] = "FIRE_SPELL_POWER"; --裝備: 使火焰法術和效果所造成的傷害提高最多7點。
		statLookup["使冰霜法術和效果所造成的傷害提高最多"] = "FROST_SPELL_POWER"; --裝備: 使冰霜法術和效果所造成的傷害提高最多10點。
		statLookup["使暗影法術和效果所造成的傷害提高最多"] = "SHADOW_SPELL_POWER"; --裝備: 使暗影法術和效果所造成的傷害提高最多11點。
		statLookup["使神聖法術和效果所造成的傷害提高最多"] = "HOLY_SPELL_POWER"; --裝備: 使神聖法術和效果所造成的傷害提高最多16點。
		statLookup["使自然法術和效果所造成的傷害提高最多"] = "NATURE_SPELL_POWER"; --裝備: 使自然法術和效果所造成的傷害提高最多19點。
		statLookup["使你的法術命中等級提高"] = "SPELL_HIT_RATING"; --裝備: 使你的法術命中等級提高8點。
		statLookup["在獵豹、熊、巨熊和梟獸形態下的攻擊強度提高"] = "FERAL_ATTACK_POWER"; --裝備: 在獵豹、熊、巨熊和梟獸形態下的攻擊強度提高337點。
		statLookup["點釣魚技能"] = "FISHING"; --裝備: +5點釣魚技能。
		statLookup["點熟練"] = "EXPERTISE_RATING"; --裝備: 提高18點熟練。
		statLookup["點法術加速"] = "SPELL_HASTE_RATING"; --裝備: 提高40點法術加速。
		statLookup["點加速"] = "HASTE_RATING"; --裝備: 提高21點加速。
		statLookup["點韌性"] = "RESILIENCE_RATING"; --裝備: 提高11點韌性。	
	end

	function ISL.ParseText(line, addStat)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--+1耐力
		local value, statKey  = FindCaptures(line, "^%+?(%d+)([^%d%s]+)$")
		if value then
			addStat(statKey, value, true)
			return
		end

		if strsub(line, #line-#"傷害"+1)=="傷害" then --10 - 16傷害
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+)傷害$")
			if valueLow then
				addStat("DAMAGE", (tonumber(valueLow)+tonumber(valueHigh))/2)
				return
			end
		end
		
		local value = FindCaptures(line,"^（每秒傷害(%d+%.?%d*)）$") --（每秒傷害5.0）
		if value then
			addStat("DPS", value)
			return
		end
		
		local statKey
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^裝備: ([^%d%s]+)(%d+)[%%點]-。$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^裝備: 每5秒恢復(%d+)點([^%d%s]+)力。$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value, statKey  = FindCaptures(line,"^裝備: [提高]*%+?(%d+)([^%d%s]+)。$")
			if statKey then
				addStat(statKey, value, true)
				return
			end

			value  = FindCaptures(line,"^裝備: 你的攻擊無視目標(%d+)點護甲值。$")
			if value then
				addStat("ARMOR_PENETRATION", value)
				return
			end
			
			value  = FindCaptures(line,"^裝備: 在猎豹、熊、巨熊和枭兽形态下的攻击强度提高(%d+)点。%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end
			
			value  = FindCaptures(line,"^在猎豹、熊、巨熊和枭兽形态下的攻击强度提高(%d+)点。%.$")
			if value then
				addStat("FERAL_ATTACK_POWER", value)
				return
			end					

			--裝備: 使法術和魔法效果所造成的治療效果提高最多24點，法術傷害提高最多8點。
			local damageValue
			value, damageValue  = FindCaptures(line,"^裝備: 使法術和魔法效果所造成的治療效果提高最多(%d+)點，法術傷害提高最多(%d+)點。$")
			if value then
				addStat("HEALING_SPELL_POWER", value)
				addStat("DAMAGE_SPELL_POWER", damageValue)
				return
			end
		end

		--强化护甲 +8
		--速度 1.70
		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+)%s?%+?(%d+%.?%d*)$")
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