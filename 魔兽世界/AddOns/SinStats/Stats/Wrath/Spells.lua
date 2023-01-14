local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2


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

AddonTable.critSpellChance, AddonTable.hitSpell, AddonTable.hitSpellRating, AddonTable.regenBase, AddonTable.regenCasting, AddonTable.critSpellBase, AddonTable.regenBaseBasic, AddonTable.regenCastingBasic  = 0, 0, 0, 0, 0, 0, 0, 0

function AddonTable.SpellUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then
		AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then
			AddonTable.targetLevel = AddonTable.playerLevel + 3
		end
	end

	-- Critical
	AddonTable.critSpellChance = 0
	AddonTable.critSpellBase = 0
	local holySchool = GetSpellCritChance(2)
	local fireSchool = GetSpellCritChance(3)
	local natureSchool = GetSpellCritChance(4)
	local frostSchool = GetSpellCritChance(5)
	local shadowSchool = GetSpellCritChance(6)
	local arcaneSchool = GetSpellCritChance(7)
	local spellCritTable = {holySchool, fireSchool, natureSchool, frostSchool, shadowSchool, arcaneSchool}
	table.sort(spellCritTable)
	AddonTable.critSpellChance = spellCritTable[#spellCritTable]
	AddonTable.critSpellBase = AddonTable.critSpellChance
	AddonTable.critSpellChance = AddonTable.critSpellChance + AddonTable.combustionCount + AddonTable.tidalMastery + AddonTable.starlight + AddonTable.masterImp +
	AddonTable.masterSucc + AddonTable.totemWrath + AddonTable.innerFocus + AddonTable.heartCrusader + AddonTable.wintersChill + AddonTable.impSorch + AddonTable.impShadowbolt + AddonTable.faerieCrit
	
	AddonTable.impDemonicTactics = AddonTable.critSpellChance * AddonTable.ImpDemonicTactics
	
	if AddonTable.faerieFireImp > AddonTable.misery then AddonTable.misery = 0 end

	-- Hit
	AddonTable.hitSpell = GetCombatRatingBonus(CR_HIT_SPELL)
	AddonTable.hitSpellRating = GetCombatRating(CR_HIT_SPELL)
	AddonTable.hitSpell = AddonTable.hitSpell + AddonTable.hitMod + AddonTable.elePrecision + AddonTable.balancePower + AddonTable.heroicPresence + AddonTable.arcaneFocus +
	AddonTable.Suppression + AddonTable.virulence + AddonTable.misery + AddonTable.faerieFireImp
	
	-- MP2
	local notcasting = 0
	local tempRegen = 0
	AddonTable.regenBase, AddonTable.regenCasting = GetManaRegen()

	AddonTable.regenBase = AddonTable.regenBase * 2
	AddonTable.regenCasting = (AddonTable.regenCasting * 2)

	if AddonTable.regenBase == AddonTable.regenCasting then
		if notcasting then
			AddonTable.regenBase = notcasting
		end
	else
		notcasting = AddonTable.regenBase
	end
	
	AddonTable.regenBaseBasic = AddonTable.regenBase
	AddonTable.regenCastingBasic = AddonTable.regenCasting

	tempRegen = AddonTable.felEnergy + (AddonTable.epiphany * 0.4) + AddonTable.manaTide + ((AddonTable.aspectViper/3) * 2)

	AddonTable.regenCasting = AddonTable.regenCasting + tempRegen + (AddonTable.innervate * 2)
	AddonTable.regenBase = AddonTable.regenBase + AddonTable.felEnergy + AddonTable.evoc + (AddonTable.epiphany * 0.4) + AddonTable.manaTide + ((AddonTable.aspectViper/3) * 2) + (AddonTable.innervate * 2)
	
end
-------------------------------------------------

-- Healing
function AddonTable.FunctionList.Healing(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local healSpell = GetSpellBonusHealing()
	local healBase = healSpell

	healSpell = (healSpell + (healSpell * AddonTable.spiritualHealing) + (healSpell * AddonTable.avenWrath) + (healSpell * AddonTable.giftNature) + (healSpell * AddonTable.purification) + (healSpell * AddonTable.blessedResil) + 
				(healSpell * AddonTable.divinity) + (healSpell * AddonTable.treeofLife) + (healSpell * AddonTable.FocusedPower))	
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = healSpell end
	if  AddonTable.Band(EB, Base) then baseStat = healBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Holy
function AddonTable.FunctionList.Holy(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local holySpell = GetSpellBonusDamage(2)
	local holyBase = holySpell

	holySpell = (holySpell + (holySpell * AddonTable.vengBuff) + (holySpell * AddonTable.avenWrath) + (holySpell * AddonTable.zoneBuff) + (holySpell * AddonTable.crusadeTalent) + 
	(holySpell * (AddonTable.masterFel / 100)) + (holySpell * AddonTable.curseElements) + (holySpell * AddonTable.ebonPlague) + (holySpell * AddonTable.earthMoon) + (holySpell * AddonTable.FocusedPower) +
	(holySpell * AddonTable.arcaneEmpowerment) + (holySpell * AddonTable.feroInspiration) + (holySpell * AddonTable.BeastSlaying))
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = holySpell end
	if AddonTable.Band(EB, Base) then baseStat = holyBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Nature
function AddonTable.FunctionList.Nature(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local natureSpell = GetSpellBonusDamage(4)
	local natureBase = natureSpell

	natureSpell = (natureSpell + (natureSpell * AddonTable.stormStrike) + (natureSpell * AddonTable.zoneBuff) + (natureSpell * AddonTable.curseElements) + 
	(natureSpell * AddonTable.ebonPlague) + (natureSpell * AddonTable.earthMoon) + (natureSpell * AddonTable.arcaneEmpowerment) + (natureSpell * AddonTable.feroInspiration) + (natureSpell * AddonTable.BeastSlaying))
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = natureSpell end
	if AddonTable.Band(EB, Base) then baseStat = natureBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Shadow
function AddonTable.FunctionList.Shadow(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local shadowSpell = GetSpellBonusDamage(6)
	local shadowBase = shadowSpell

	shadowSpell = (shadowSpell + (shadowSpell * AddonTable.DarkNessTalent) + (shadowSpell * AddonTable.dsSuc) + (shadowSpell * AddonTable.zoneBuff) +
	(shadowSpell * AddonTable.shadowFormDmg) + (shadowSpell * AddonTable.shadowWeaving) + (shadowSpell * AddonTable.curseElements) + (shadowSpell * AddonTable.shadowMastery) +
	(shadowSpell * (AddonTable.masterSucc / 100)) + (shadowSpell * (AddonTable.masterFel / 100)) + (shadowSpell * AddonTable.ebonPlague) + (shadowSpell * AddonTable.earthMoon) + (shadowSpell * AddonTable.FocusedPower) +
	(shadowSpell * AddonTable.arcaneEmpowerment) + (shadowSpell * AddonTable.feroInspiration) + (shadowSpell * AddonTable.BeastSlaying) + (shadowSpell * AddonTable.DemonicPact) + (shadowSpell * AddonTable.metaDamage))

	if AddonTable.Band(EB, Enhanced) then enhancedStat = shadowSpell end
	if AddonTable.Band(EB, Base) then baseStat = shadowBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Fire
function AddonTable.FunctionList.Fire(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local fireSpell = GetSpellBonusDamage(3)
	local fireBase = fireSpell

	fireSpell = (fireSpell + (fireSpell * AddonTable.aiMod) + (fireSpell * AddonTable.zoneBuff) + (fireSpell * AddonTable.emberstorm) + (fireSpell * AddonTable.dsImp) + (fireSpell * AddonTable.playFire) +
	(fireSpell * AddonTable.arcanePower) + (fireSpell * AddonTable.curseElements) + (fireSpell * (AddonTable.masterImp / 100)) + (fireSpell * (AddonTable.masterFel / 100)) + (fireSpell * AddonTable.ebonPlague) + 
	(fireSpell * AddonTable.earthMoon) + (fireSpell * AddonTable.moltenFury) + (fireSpell * AddonTable.arcaneEmpowerment) + (fireSpell * AddonTable.arcanePower) + (fireSpell * AddonTable.feroInspiration) + 
	(fireSpell * AddonTable.BeastSlaying) + (fireSpell * AddonTable.DemonicPact) + (fireSpell * AddonTable.metaDamage))
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = fireSpell end
	if AddonTable.Band(EB, Base) then baseStat = fireBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Frost
function AddonTable.FunctionList.Frost(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local frostSpell = GetSpellBonusDamage(5)
	local frostBase = frostSpell

	frostSpell = (frostSpell + (frostSpell * AddonTable.pierceMod) + (frostSpell * AddonTable.aiMod) + (frostSpell * AddonTable.zoneBuff) + (frostSpell * AddonTable.playFire) + 
	(frostSpell * AddonTable.impFrostbolt) + (frostSpell * AddonTable.arcticWind) + (frostSpell * (AddonTable.masterFel / 100)) + (frostSpell * AddonTable.arcanePower) +
	(frostSpell * AddonTable.curseElements) + (frostSpell * AddonTable.ebonPlague) + (frostSpell * AddonTable.earthMoon) + (frostSpell * AddonTable.moltenFury) + 
	(frostSpell * AddonTable.arcaneEmpowerment) + (frostSpell * AddonTable.arcanePower) + (frostSpell * AddonTable.feroInspiration) + (frostSpell * AddonTable.BeastSlaying))
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = frostSpell end
	if AddonTable.Band(EB, Base) then baseStat = frostBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Arcane
function AddonTable.FunctionList.Arcane(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local arcaneSpell = GetSpellBonusDamage(7)
	local arcaneBase = arcaneSpell

	arcaneSpell = (arcaneSpell + (arcaneSpell * AddonTable.aiMod) + (arcaneSpell * AddonTable.arcanePower) + (arcaneSpell * AddonTable.playFire) + (arcaneSpell * AddonTable.zoneBuff) + 
	(arcaneSpell * (AddonTable.masterFel / 100)) + (arcaneSpell * AddonTable.curseElements) + (arcaneSpell * AddonTable.ebonPlague) + (arcaneSpell * AddonTable.earthMoon) + (arcaneSpell * AddonTable.moltenFury) + 
	(arcaneSpell * AddonTable.arcaneEmpowerment) + (arcaneSpell * AddonTable.arcanePower) + (arcaneSpell * AddonTable.feroInspiration) + (arcaneSpell * AddonTable.BeastSlaying))
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = arcaneSpell end
	if AddonTable.Band(EB, Base) then baseStat = arcaneBase end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------
 
-- Critcal
function AddonTable.FunctionList.SpellCrit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local critSpellRating = GetCombatRating(CR_CRIT_SPELL)
	local returnText
	
	if options.Display_Basic then AddonTable.critSpellChance = AddonTable.critSpellBase end
	
	if AddonTable.Band(EB, Percentage) then returnText = ("%.2f%%"):format(AddonTable.critSpellChance) .. AddonTable.callofThunder .. AddonTable.devastation end
	if AddonTable.Band(EB, Rating) then returnText = critSpellRating end
	if AddonTable.Band(EB, Both) then  returnText = ("%.2f%%"):format(AddonTable.critSpellChance) .. AddonTable.callofThunder .. AddonTable.devastation .. " (" .. critSpellRating .. ")" end	
	
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critcal vs Boss
function AddonTable.FunctionList.SpellCritBoss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
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
	
	AddonTable.critSpellBase = AddonTable.critSpellBase - levelDifference - critAura
	AddonTable.critSpellChance = AddonTable.critSpellChance - levelDifference - critAura
	
	if AddonTable.critSpellChance < 0 then AddonTable.critSpellChance = 0 end
	if AddonTable.critSpellBase < 0 then AddonTable.critSpellBase = 0 end		
	
	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(AddonTable.critSpellChance) .. AddonTable.callofThunder .. AddonTable.devastation end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(AddonTable.critSpellBase) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(AddonTable.critSpellChance) .. AddonTable.callofThunder .. AddonTable.devastation .. " (" .. ("%.2f%%"):format(AddonTable.critSpellBase) .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Haste
function AddonTable.FunctionList.HasteCaster(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Haste_Format[EB]
	local hasteSpell = GetHaste()
	local hasteRating = GetCombatRating(CR_HASTE_SPELL)
	local hasteBonus = GetCombatRatingBonus(CR_HASTE_SPELL)
	
	hasteBonus = hasteBonus + AddonTable.castHaste + AddonTable.earthMother + AddonTable.eleMasteryHaste + AddonTable.Enlightenment + AddonTable.NetherwindPresence +
				 AddonTable.borrowedTime + AddonTable.maelstromWeapon + AddonTable.naturesGrace + AddonTable.CelestialFocus + AddonTable.improvedMoonkin + AddonTable.swiftRet + AddonTable.hiddenHaste + 
				 AddonTable.berserkering
	
	if options.Display_Basic then hasteSpell = GetHaste() end

	if AddonTable.Band(EB, Percentage) then enhancedStat = hasteBonus end
	if AddonTable.Band(EB, Rating) then baseStat = hasteRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.SpellHit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local returnText
	local capColor = ""

	if AddonTable.hitSpell == nil then AddonTable.hitSpell = 0 end
	if AddonTable.hitSpellRating == nil then AddonTable.hitSpellRating = 0 end
	if AddonTable.hitSpell >= 17 then capColor = AddonTable.greenText end

	if AddonTable.Band(EB, Percentage) then returnText = capColor .. ("%.2f%%"):format(AddonTable.hitSpell) end
	if AddonTable.Band(EB, Rating) then returnText = AddonTable.hitSpellRating end
	if AddonTable.Band(EB, Both) then returnText = capColor .. ("%.2f%%"):format(AddonTable.hitSpell) .. " |r(" .. AddonTable.hitSpellRating .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function AddonTable.FunctionList.SpellMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local statFormat = Double_Percent_Format[EB]
	
	local missSameLevel = 3
	local missBossLevel = 17
	
	if AddonTable.hitSpell == nil then AddonTable.hitSpell = 0 end
	if AddonTable.hitSpellRating == nil then AddonTable.hitSpellRating = 0 end
	
	missSameLevel = (missSameLevel - AddonTable.hitSpell)
	missBossLevel = (missBossLevel - AddonTable.hitSpell)
	
	if missSameLevel < 0 then missSameLevel = 0
	elseif missSameLevel > 100 then missSameLevel = 100 end
	if missBossLevel < 0 then missBossLevel = 0
	elseif missBossLevel > 100 then missBossLevel = 100 end

	if AddonTable.Band(EB, SameLevel) then enhancedStat = missSameLevel end
	if  AddonTable.Band(EB, BossLevel) then baseStat = missBossLevel end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- MP2
function AddonTable.FunctionList.ManaRegen(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Regen_Normal_Casting
	local statFormat = Mana_Regen_Format[EB]
	
	if options.Display_Basic then
		AddonTable.regenBase = AddonTable.regenBaseBasic
		AddonTable.regenCasting = AddonTable.regenCastingBasic
	end	

	if AddonTable.Band(EB, Regen) then enhancedStat = AddonTable.regenBase end
	if  AddonTable.Band(EB, Casting) then baseStat = AddonTable.regenCasting end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- MP5
function AddonTable.FunctionList.MP5(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Regen_Normal_Casting
	local statFormat = Mana_Regen_Format[EB]
	
	if options.Display_Basic then
		AddonTable.regenBase = AddonTable.regenBaseBasic
		AddonTable.regenCasting = AddonTable.regenCastingBasic
	end	

	AddonTable.regenBase = (AddonTable.regenBase / 2) * 5
	AddonTable.regenCasting = (AddonTable.regenCasting / 2) * 5	

	if AddonTable.Band(EB, Regen) then enhancedStat = AddonTable.regenBase end
	if  AddonTable.Band(EB, Casting) then baseStat = AddonTable.regenCasting end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Spell Penetration
function AddonTable.FunctionList.SpellPenetration(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local statFormat = Double_Rating_Format[EB]
	local spellPenetration = GetSpellPenetration()
	
	if AddonTable.Band(EB, Enhanced) then enhancedStat = spellPenetration end
	if  AddonTable.Band(EB, Base) then baseStat = spellPenetration end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------
