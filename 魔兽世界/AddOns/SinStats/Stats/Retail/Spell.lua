local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base = 3, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Double_Rating_Format = { "%.0f", "%.0f", "%.0f/%.0f", }
local Base_Casting_Format = { "%.2f", "%.2f", "%.2f/%.2f", }

--------------------------
--		Physical		--
--------------------------
-- Intellect
function AddonTable.FunctionList.Intellect(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local _, stat, posBuff, negBuff = UnitStat("Player", 4)
	local debuffColor = ""
	local returnText
	
	stat = stat + (stat * AddonTable.shatteringStar) + (stat * AddonTable.radiantSpark) + (stat * AddonTable.chaosBrand) + (stat * AddonTable.felSunder)
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if AddonTable.Band(EB, Base) then returnText = stat end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. stat end
	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Spell Power
function AddonTable.FunctionList.SpellPower(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local spellPower = 0
	local SinHolySpell = GetSpellBonusDamage(2);
	local SinFireSpell = GetSpellBonusDamage(3);	
	local SinNatureSpell = GetSpellBonusDamage(4);
	local SinFrostSpell = GetSpellBonusDamage(5);  	
	local SinShadowSpell = GetSpellBonusDamage(6);                        
	local SinArcaneSpell = GetSpellBonusDamage(7);  
	local spellTable = {SinFrostSpell, SinFireSpell, SinArcaneSpell, SinShadowSpell, SinNatureSpell, SinHolySpell}
	table.sort(spellTable)
	spellPower = spellTable[#spellTable]
	local basePower = spellPower
	spellPower = spellPower + (spellPower * AddonTable.shatteringStar) + (spellPower * AddonTable.radiantSpark) + (spellPower * AddonTable.chaosBrand) + (spellPower * AddonTable.felSunder)

	if AddonTable.Band(EB, Enhanced) then enhancedStat = spellPower end
	if AddonTable.Band(EB, Base) then baseStat = basePower end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Healing Power
function AddonTable.FunctionList.Healing(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local healPower = GetSpellBonusHealing()

	if AddonTable.Band(EB, Enhanced) then enhancedStat = healPower end
	if AddonTable.Band(EB, Base) then baseStat = healPower end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Mana Regen
function AddonTable.FunctionList.ManaRegen(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Base_Casting_Format[EB]
	local regenBase, regenCasting = GetManaRegen()
	regenBase = regenBase * 5
	regenCasting = (regenCasting * 5)

	if AddonTable.Band(EB, Enhanced) then enhancedStat = regenBase end
	if AddonTable.Band(EB, Base) then baseStat = regenCasting end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
