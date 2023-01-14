local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, SameLevel, BossLevel, Regen, Casting = 3, 1, 2, 1, 2, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Percent_Rating_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Haste_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Double_Rating_Format = { "%.0f", "%.0f", "%.0f (%.0f)", }
local Mana_Regen_Format = { "%.1f", "%.1f", "%.1f (%.1f)", }
local Double_Percent_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

------------------------------
--		Global Updater		--
------------------------------

AddonTable.hitSpellChance, AddonTable.hitSpellGear, AddonTable.regenBase, AddonTable.regenCasting, AddonTable.regenBaseBasic, AddonTable.regenCastingBasic  = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.healSpell, AddonTable.holySpell, AddonTable.natureSpell, AddonTable.shadowSpell, AddonTable.fireSpell, AddonTable.frostSpell, AddonTable.arcaneSpell = 0, 0, 0, 0, 0, 0, 0


function AddonTable.SpellUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then
		AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then
			AddonTable.targetLevel = AddonTable.playerLevel + 3
		end
	end
	
	AddonTable.spirit = UnitStat("player", 5)
	
	-- Spell Power
	AddonTable.healSpell = GetSpellBonusHealing()
	AddonTable.holySpell = GetSpellBonusDamage(2)
	AddonTable.natureSpell = GetSpellBonusDamage(4)	
	AddonTable.shadowSpell = GetSpellBonusDamage(6)
	AddonTable.fireSpell = GetSpellBonusDamage(3)
	AddonTable.frostSpell = GetSpellBonusDamage(5)
	AddonTable.arcaneSpell = GetSpellBonusDamage(7)	
	AddonTable.healSpell = AddonTable.healSpell + (AddonTable.healSpell * AddonTable.spiritualHealing) + (AddonTable.healSpell * AddonTable.purification)
	AddonTable.holySpell = (AddonTable.holySpell + (AddonTable.holySpell * AddonTable.dmfbuff) + (AddonTable.holySpell * AddonTable.silithyst) + (AddonTable.holySpell * AddonTable.sancAura) + (AddonTable.holySpell * AddonTable.vengeance))
	AddonTable.natureSpell = (AddonTable.natureSpell + (AddonTable.natureSpell * AddonTable.dmfbuff) + (AddonTable.natureSpell * AddonTable.silithyst))  
	AddonTable.shadowSpell = (AddonTable.shadowSpell + (AddonTable.shadowSpell * AddonTable.shadowMastery) + (AddonTable.shadowSpell * AddonTable.DarkNessTalent) + (AddonTable.shadowSpell * AddonTable.dsSuc) + (AddonTable.shadowSpell * AddonTable.dmfbuff) + (AddonTable.shadowSpell * AddonTable.silithyst) + (AddonTable.shadowSpell * AddonTable.shadowFormDmg))
	AddonTable.fireSpell = (AddonTable.fireSpell + (AddonTable.fireSpell * AddonTable.firepowerMod) + (AddonTable.fireSpell * AddonTable.aiMod) + (AddonTable.fireSpell * AddonTable.emberstorm) + (AddonTable.fireSpell * AddonTable.dsImp) + (AddonTable.fireSpell * AddonTable.dmfbuff) + (AddonTable.fireSpell * AddonTable.silithyst) + (AddonTable.fireSpell * AddonTable.arcanePower))
	AddonTable.frostSpell = (AddonTable.frostSpell + (AddonTable.frostSpell * AddonTable.pierceMod) + (AddonTable.frostSpell * AddonTable.aiMod) + (AddonTable.frostSpell * AddonTable.dmfbuff) + (AddonTable.frostSpell * AddonTable.silithyst) + (AddonTable.frostSpell * AddonTable.arcanePower))
	AddonTable.arcaneSpell = (AddonTable.arcaneSpell + (AddonTable.arcaneSpell * AddonTable.aiMod) + (AddonTable.arcaneSpell * AddonTable.dmfbuff) + (AddonTable.arcaneSpell * AddonTable.silithyst) + (AddonTable.arcaneSpell * AddonTable.arcanePower))
	
	-- Hit
	AddonTable.hitSpellChance = GetCombatRatingBonus(8)
	AddonTable.hitSpellGear = GetSpellHitModifier()
	
	if AddonTable.hitSpellChance == nil or AddonTable.hitSpellGear == nil then
		AddonTable.hitSpellChance = 0
		AddonTable.hitSpellGear = 0
	end

	AddonTable.hitSpellGear = AddonTable.hitSpellGear / 7	
end
-------------------------------------------------

-- Critical
function AddonTable.FunctionList.SpellCrit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local critSpellChance = 0
	local holySchool = GetSpellCritChance(2)
	local fireSchool = GetSpellCritChance(3)
	local natureSchool = GetSpellCritChance(4)
	local frostSchool = GetSpellCritChance(5)
	local shadowSchool = GetSpellCritChance(6)
	local arcaneSchool = GetSpellCritChance(7)
	local levelDifference = 0
	local critAura = 1.8
	local returnText

	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end

	spellCritTable = {holySchool, fireSchool, natureSchool, frostSchool, shadowSchool, arcaneSchool}
	table.sort(spellCritTable)
	critSpellChance = spellCritTable[#spellCritTable]
	local critBase = critSpellChance
	critSpellChance = critSpellChance + AddonTable.combustionCount + AddonTable.arcaneMod + AddonTable.spellCritMod
	AddonTable.critSpellBoss = critSpellChance - levelDifference - critAura
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = ("%.2f%%"):format(critSpellChance)
	end
	if  AddonTable.Band(EB, Base) then
		returnText = ("%.2f%%"):format(AddonTable.critSpellBoss)
	end
	if  AddonTable.Band(EB, Both) then
		returnText = ("%.2f%%"):format(critSpellChance) .. " (" .. ("%.2f%%"):format(AddonTable.critSpellBoss) .. ")"
	end
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.SpellHit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText

	local baseHit = AddonTable.hitSpellChance + AddonTable.hitSpellGear
	AddonTable.hitSpellChance = AddonTable.hitSpellChance + AddonTable.hitMod + AddonTable.hitSpellGear
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = ("%.2f%%"):format(AddonTable.hitSpellChance) .. AddonTable.labelHit
	end
	if  AddonTable.Band(EB, Base) then
		returnText = ("%.2f%%"):format(baseHit)
	end
	if  AddonTable.Band(EB, Both) then
		returnText = ("%.2f%%"):format(AddonTable.hitSpellChance) .. AddonTable.labelHit .. " (" .. ("%.2f%%"):format(baseHit) .. ")"
	end
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function AddonTable.FunctionList.SpellMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local statFormat = Double_Percent_Format[EB]
	
	local missSameLevel = 3
	local missBossLevel = 16
	
	if AddonTable.hitSpellChance == nil then
		AddonTable.hitSpellChance = 0
	end
	if AddonTable.hitSpellRating == nil then
		AddonTable.hitSpellRating = 0
	end
	
	missSameLevel = (missSameLevel - AddonTable.hitSpellChance)
	missBossLevel = (missBossLevel - AddonTable.hitSpellChance)
	
	if missSameLevel < 0 then
		missSameLevel = 0
	elseif missSameLevel > 100 then
		missSameLevel = 100
	end
	if missBossLevel < 0 then
		missBossLevel = 0
	elseif missBossLevel > 100 then
		missBossLevel = 100
	end

	if AddonTable.Band(EB, SameLevel) then
		enhancedStat = missSameLevel
	end
	if  AddonTable.Band(EB, BossLevel) then
		baseStat = missBossLevel
	end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Healing
function AddonTable.FunctionList.Healing(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local healBase = GetSpellBonusHealing()
	
	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.healSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = healBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Holy
function AddonTable.FunctionList.Holy(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local holyBase = GetSpellBonusDamage(2)
	
	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.holySpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = holyBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Nature
function AddonTable.FunctionList.Nature(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local natureBase = GetSpellBonusDamage(4)
	
	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.natureSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = natureBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Shadow
function AddonTable.FunctionList.Shadow(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local shadowBase = GetSpellBonusDamage(6)

	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.shadowSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = shadowBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Fire
function AddonTable.FunctionList.Fire(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local fireBase = GetSpellBonusDamage(3)
	
	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.fireSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = fireBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Frost
function AddonTable.FunctionList.Frost(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local frostBase = GetSpellBonusDamage(5)
	
	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.frostSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = frostBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Arcane
function AddonTable.FunctionList.Arcane(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local arcaneBase = GetSpellBonusDamage(7)

	if AddonTable.Band(EB, Enhanced) then
		enhancedStat = AddonTable.arcaneSpell
	end
	if  AddonTable.Band(EB, Base) then
		baseStat = arcaneBase
	end
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Undead Spell Power
function AddonTable.FunctionList.SpellUD(HUD, data, options, ...)

	local undeadSpell = 0
	local cleansingSet = 0
	local udTrinket = 0
	local markTrinket = 0
	local mhEnchant = 0
	local ohEnchant = 0
	local glovesCheck = GetInventoryItemID("player", 10)
	local bracersCheck = GetInventoryItemID("player", 9)	
	local chestCheck = GetInventoryItemID("player", 5)
	local trinketCheck = GetInventoryItemID("player", 13)
	local trinketCheck2 = GetInventoryItemID("player", 14)
	local _, _, _, mainHandEnchantID, _, _, _, offHandEnchantId  = GetWeaponEnchantInfo()
	
	if trinketCheck == 19812 or trinketCheck2 == 19812 then
		udTrinket = 48
	end
	if trinketCheck == 23207 or trinketCheck2 == 23207 then
		markTrinket = 85
	end
	
	if (mainHandEnchantID == 2685) then
		mhEnchant = 60
	end
	if (offHandEnchantId == 2685) then
		ohEnchant = 60
	end		
	if glovesCheck == 23084 then
		cleansingSet = cleansingSet + 35
	end
	if bracersCheck == 23091 then
		cleansingSet = cleansingSet + 26
	end
	if chestCheck == 23085 then
		cleansingSet = cleansingSet + 48
	end			

	spellTable = {AddonTable.frostSpell, AddonTable.fireSpell, AddonTable.arcaneSpell, AddonTable.shadowSpell, AddonTable.natureSpell, AddonTable.holySpell}
	table.sort(spellTable)
	undeadSpell = spellTable[#spellTable]
	undeadSpell = undeadSpell + udTrinket + markTrinket + mhEnchant + ohEnchant + cleansingSet
	
	HUD:UpdateText(data, undeadSpell)
end
------------------------------------------------

-- Haste
function AddonTable.FunctionList.HasteCaster(HUD, data, options, ...)
	
	HUD:UpdateText(data, AddonTable.castHaste .. "%")
end
------------------------------------------------

-- MP2
function AddonTable.FunctionList.ManaRegen(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Regen_Normal_Casting
	local statFormat = Mana_Regen_Format[EB]

	if AddonTable.Band(EB, Regen) then
		enhancedStat = AddonTable.totalMP2
	end
	if  AddonTable.Band(EB, Casting) then
		baseStat = AddonTable.castingMP2
	end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- MP5
function AddonTable.FunctionList.MP5(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Regen_Normal_Casting
	local statFormat = Mana_Regen_Format[EB]

	if AddonTable.Band(EB, Regen) then
		enhancedStat = AddonTable.totalMP5
	end
	if  AddonTable.Band(EB, Casting) then
		baseStat = AddonTable.castingMP5
	end

	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------
