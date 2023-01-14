local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 3

----------------------------------
--		Text Return Formats		--
----------------------------------
local Percent_Rating_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Haste_Format = { "%.2f%%", "%.0f", "%.1f%% (%.0f)", }
local Miss_Chance_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

------------------------------
--		Global Updater		--
------------------------------

AddonTable.missMod, AddonTable.meleeSameLevel, AddonTable.meleeBossLevel, AddonTable.hitChance, AddonTable.hitBonus = 0,0,0,0,0

function AddonTable.MeleeUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then AddonTable.targetLevel = AddonTable.playerLevel + 3 end
	end
	
	-- Hit
	AddonTable.hitChance = GetHitModifier("player")
	AddonTable.hitBonus = GetCombatRatingBonus(CR_HIT_MELEE)
	
	if AddonTable.hitChance == nil then AddonTable.hitChance = 0 end
	if AddonTable.hitBonus == nil then AddonTable.hitBonus = 0 end

	AddonTable.hitChance = AddonTable.hitChance + AddonTable.hitBonus

	-- Miss Chance
	AddonTable.meleeSameLevel = 0
	AddonTable.meleeBossLevel = 0
	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local levelDefense = AddonTable.playerLevel * 5
	local levelDiffDef = 0
	levelDiffDef = AddonTable.targetLevel - AddonTable.playerLevel
	local liveDefense = AddonTable.playerLevel * 5
	local bossDefense = (AddonTable.playerLevel + levelDiffDef) * 5
	local mWeaponSkill = (mainBase + mainMod)			
	local meleeSkillDiff = liveDefense - mWeaponSkill
	local bossSkillDiff = bossDefense - mWeaponSkill
	local bossSkillMod = bossDefense - mWeaponSkill
	AddonTable.missMod = 0
	local missModboss = 0
	local _, isOffHand = UnitAttackSpeed("player")
	local itemType, itemSubtype, classId, subId = 0, 0, 0, 0

	missModboss = AddonTable.meleeBossLevel
	
	if isOffHand ~= nil then
		if meleeSkillDiff > 10 then
			AddonTable.meleeSameLevel = (25 + ((meleeSkillDiff - 10) * 0.4))
			AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - AddonTable.hitChance
		elseif meleeSkillDiff <= 10 then
			AddonTable.meleeSameLevel = (24 + ((meleeSkillDiff) * 0.1))
			AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - AddonTable.hitChance		
		end
		if bossSkillDiff > 10 then
			AddonTable.meleeBossLevel = (25 + ((bossSkillDiff - 10) * 0.4))
			AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - AddonTable.hitChance
			AddonTable.missMod = (25 + ((bossSkillMod - 10) * 0.4))
			AddonTable.missMod = AddonTable.missMod - AddonTable.hitChance
		elseif bossSkillDiff <= 10 then
			AddonTable.meleeBossLevel = (24 + ((bossSkillDiff) * 0.1))
			AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - AddonTable.hitChance   	
			AddonTable.missMod = (25 + ((bossSkillMod - 10) * 0.4))
			AddonTable.missMod = AddonTable.missMod - AddonTable.hitChance				
		end
	else
		if AddonTable.druidFormChk() then
			AddonTable.meleeSameLevel = 5 - AddonTable.hitChance
			AddonTable.meleeBossLevel = 8 - AddonTable.hitChance
		else
			if meleeSkillDiff > 10 then
				AddonTable.meleeSameLevel = (6 + ((meleeSkillDiff - 10) * 0.4))
				AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - AddonTable.hitChance
			elseif meleeSkillDiff <= 10 then
				AddonTable.meleeSameLevel = (5 + ((meleeSkillDiff) * 0.1))
				AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - AddonTable.hitChance		
			end
			if bossSkillDiff > 10 then
				AddonTable.meleeBossLevel = (6 + ((bossSkillDiff - 10) * 0.4))
				AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - AddonTable.hitChance  
				AddonTable.missMod = (6 + ((bossSkillMod - 10) * 0.4))
				AddonTable.missMod = AddonTable.missMod - AddonTable.hitChance					
			elseif bossSkillDiff <= 10 then
				AddonTable.meleeBossLevel = (5 + ((bossSkillDiff) * 0.1))
				AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - AddonTable.hitChance   	
				AddonTable.missMod = (5 + ((bossSkillMod - 10) * 0.1))
				AddonTable.missMod = AddonTable.missMod - AddonTable.hitChance					
			end
		end
	end	

	if AddonTable.meleeSameLevel < 0 then AddonTable.meleeSameLevel = 0
	elseif AddonTable.meleeSameLevel > 100 then AddonTable.meleeSameLevel = 100 end
	if AddonTable.meleeBossLevel < 0 then AddonTable.meleeBossLevel = 0
	elseif AddonTable.meleeBossLevel > 100 then AddonTable.meleeBossLevel = 100 end

end
------------------------------------------------

-- Attack Power
function AddonTable.FunctionList.AP(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local base, posBuff, negBuff = UnitAttackPower("player")
	local attackPower = base + posBuff + negBuff
	local shapeshiftAP = 0
	local baseAP = attackPower
	local debuffColor = ""
	local returnText

	if not AddonTable.isShapeshift then shapeshiftAP = (AddonTable.playerLevel * AddonTable.predStrikes) end

	attackPower = attackPower + shapeshiftAP
	
	if negBuff < 0 then debuffColor = AddonTable.redText end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. attackPower .. "|r" end
	if AddonTable.Band(EB, Base) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. baseAP
	end
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Damage
function AddonTable.FunctionList.DMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local debuffColor = ""
	local returnText
	local classId = 0

	if ohID then  _,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID) end	

	maxDamage = hiDmg + (hiDmg * AddonTable.crusadeTalent) + (hiDmg * AddonTable.desolation) + (hiDmg * AddonTable.frostFever) + (hiDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (hiDmg * AddonTable.bloodFrenzy) + (hiDmg * AddonTable.savageCombat) + (hiDmg * AddonTable.BeastSlaying) + (hiDmg * AddonTable.FocusedFire) + (hiDmg * AddonTable.metaDamage)
	lowDamage = lowDmg + (lowDmg * AddonTable.crusadeTalent) + (lowDmg * AddonTable.desolation) + (lowDmg * AddonTable.frostFever) + (lowDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (lowDmg * AddonTable.bloodFrenzy) + (lowDmg * AddonTable.savageCombat) + (lowDmg * AddonTable.BeastSlaying) + (lowDmg * AddonTable.FocusedFire) + (lowDmg * AddonTable.metaDamage)
	maxDamageOH = offhiDmg + (offhiDmg * AddonTable.crusadeTalent) + (offhiDmg * AddonTable.desolation) + (offhiDmg * AddonTable.frostFever) + (offhiDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (offhiDmg * AddonTable.bloodFrenzy) + (offhiDmg * AddonTable.savageCombat) + (offhiDmg * AddonTable.BeastSlaying) + (offhiDmg * AddonTable.FocusedFire) + (offhiDmg * AddonTable.metaDamage)
	lowDamageOH = offlowDmg + (offlowDmg * AddonTable.crusadeTalent) + (offlowDmg * AddonTable.desolation) + (offlowDmg * AddonTable.frostFever) + (offlowDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (offlowDmg * AddonTable.bloodFrenzy) + (offlowDmg * AddonTable.savageCombat) + (offlowDmg * AddonTable.BeastSlaying) + (offlowDmg * AddonTable.FocusedFire) + (offlowDmg * AddonTable.metaDamage)
	
	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end	
	
	local maxDamageAlt = maxDamageOH
	
	if (ohID and classId == AddonTable.weaponTag) then maxDamageOH = "/" .. math.floor(maxDamageOH)
	else maxDamageOH = "" end	
	
	if negBuff < 0 then debuffColor = AddonTable.redText end

	if AddonTable.Band(EB, MainHand) then returnText = debuffColor .. math.floor(maxDamage) end
	if AddonTable.Band(EB, OffHand) then returnText = math.floor(maxDamageAlt) end
	if AddonTable.Band(EB, Auto) then returnText = math.floor(maxDamage) .. maxDamageOH end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function AddonTable.FunctionList.mDPS(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local DPS = 0
	local DPSOH = 0
	local debuffColor = ""
	local classId = 0
	
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	

	maxDamage = hiDmg + (hiDmg * AddonTable.crusadeTalent) + (hiDmg * AddonTable.desolation) + (hiDmg * AddonTable.frostFever) + (hiDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (hiDmg * AddonTable.bloodFrenzy) + (hiDmg * AddonTable.savageCombat) + (hiDmg * AddonTable.FocusedFire) + (hiDmg * AddonTable.metaDamage)
	lowDamage = lowDmg + (lowDmg * AddonTable.crusadeTalent) + (lowDmg * AddonTable.desolation) + (lowDmg * AddonTable.frostFever) + (lowDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (lowDmg * AddonTable.bloodFrenzy) + (lowDmg * AddonTable.savageCombat) + (lowDmg * AddonTable.FocusedFire) + (lowDmg * AddonTable.metaDamage)
	maxDamageOH = offhiDmg + (offhiDmg * AddonTable.crusadeTalent) + (offhiDmg * AddonTable.desolation) + (offhiDmg * AddonTable.frostFever) + (offhiDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (offhiDmg * AddonTable.bloodFrenzy) + (offhiDmg * AddonTable.savageCombat) + (offhiDmg * AddonTable.FocusedFire) + (offhiDmg * AddonTable.metaDamage)
	lowDamageOH = offlowDmg + (offlowDmg * AddonTable.crusadeTalent) + (offlowDmg * AddonTable.desolation) + (offlowDmg * AddonTable.frostFever) + (offlowDmg * AddonTable.rageRivendare) + AddonTable.hemoDmg + (offlowDmg * AddonTable.bloodFrenzy) + (offlowDmg * AddonTable.savageCombat) + (offlowDmg * AddonTable.FocusedFire) + (offlowDmg * AddonTable.metaDamage)
	
	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end	
	
	local maxDamageOH2 = maxDamageOH
	
	if mainSpeed ~= 0 then
		DPS = ((lowDamage + maxDamage) / 2) / mainSpeed
		DPSOH = ((lowDamageOH + maxDamageOH) / 2) / mainSpeed
	end	
	
	local DPSOH2 = DPSOH
	
	if (ohID and classId == AddonTable.weaponTag) then DPSOH = "/" .. math.floor(DPSOH+1)
	else DPSOH = "" end	
	
	if negBuff < 0 then debuffColor = AddonTable.redText end
	
	if AddonTable.Band(EB, MainHand) then returnText = debuffColor .. math.floor(DPS+1) end
	if AddonTable.Band(EB, OffHand) then returnText = math.floor(DPSOH2+1) end
	if AddonTable.Band(EB, Auto) then returnText = math.floor(DPS+1) .. DPSOH end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical
function AddonTable.FunctionList.Crit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local critChance = GetCritChance("player")
	local critRating = GetCombatRating(CR_CRIT_MELEE)
	critChance = critChance + AddonTable.totemWrath + AddonTable.heartCrusader + AddonTable.masterPoisoner + AddonTable.berserker
	
	if options.Display_Basic then
		critChance = GetCritChance("player")
		critRating = GetCombatRating(CR_CRIT_MELEE)
	end			
	
	if AddonTable.Band(EB, Percentage) then enhancedStat = critChance end
	if AddonTable.Band(EB, Rating) then baseStat = critRating end

	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Critical vs Boss
function AddonTable.FunctionList.CritBoss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local critChance = GetCritChance("player")
	local critBase = critChance
	local levelDifference = 0
	local critAura = 0
	local returnText
	critChance = critChance + AddonTable.totemWrath + AddonTable.heartCrusader + AddonTable.masterPoisoner
	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel

	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end
	critChance = critChance - levelDifference - critAura
	critBase = critBase  - levelDifference - critAura
	
	if critChance < 0 then critChance = 0 end
	if critBase < 0 then critBase = 0 end	
	
	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(critChance) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(critBase) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f"):format(critChance) .. "/" .. ("%.2f%%"):format(critBase) end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical Cap
function AddonTable.FunctionList.CritCap(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local mWeaponSkill = (mainBase + mainMod)

	local critChance = GetCritChance("player")
	local mWepSkill = mWeaponSkill
	local levelDifference = 0
	local critAura = 1.84	
	local ohID = GetInventoryItemID("player", 17)
	local classId = 0
	
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	
	
	if ohID and classId == AddonTable.weaponTag then 
		mWeaponSkill = math.min((mainBase + mainMod), (offBase + offMod)) 
	end
	
	local skillDiff = 365 - mWeaponSkill
	local critSupp = 4.8	
	local dodgeBoss = 5 + (skillDiff * 0.1)
	local glancingBoss = 40	
	local extraWeaponSkill = mWeaponSkill - (AddonTable.playerLevel * 5)
	local mcritCap = 100 - AddonTable.missMod - dodgeBoss - glancingBoss + critSupp + (extraWeaponSkill * 0.04)
	local debuffColor = ""		
	
	critChance = critChance + AddonTable.totemWrath
	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel
	
	if AddonTable.crusader then critChance = critChance + AddonTable.crusaderTalent end

	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	end
	critChance = critChance - levelDifference - critAura
	
	if critChance < 0 then critChance = 0 end		

	if critChance > mcritCap then debuffColor = AddonTable.redText
	elseif critChance == mcritCap then debuffColor = AddonTable.orangeText
	else debuffColor = AddonTable.greenText end

	if mcritCap > 100 then mcritCap = 100
	elseif mcritCap < 0 then mcritCap = 0 end
	
	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. ("%.1f%%"):format(mcritCap) end
	if AddonTable.Band(EB, Base) then returnText = ("%.1f%%"):format(mcritCap) end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. ("%.1f%%"):format(mcritCap) .. "|r/" .. ("%.1f%%"):format(mcritCap) end	

	HUD:UpdateText(data, returnText)	
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.Hit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	--local statFormat = Percent_Rating_Format[EB]
	local hitRating = GetCombatRating(CR_HIT_MELEE)
	local returnText
	local capColor = ""
	
	if AddonTable.hitChance >= 8 then capColor = AddonTable.greenText end

	if AddonTable.Band(EB, Percentage) then returnText = capColor .. ("%.2f%%"):format(AddonTable.hitChance) end
	if AddonTable.Band(EB, Rating) then returnText = hitRating end
	if AddonTable.Band(EB, Both) then returnText = capColor .. ("%.2f%%"):format(AddonTable.hitChance) .. " |r(" .. hitRating .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Haste
function AddonTable.FunctionList.HasteMelee(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local statFormat = Haste_Format[EB]
	local haste = GetCombatRatingBonus(CR_HASTE_MELEE)
	local hasteRating = GetCombatRating(CR_HASTE_MELEE)
	local hasteBonus = haste
	
	haste = haste + AddonTable.icyTalons + AddonTable.meleeHaste + AddonTable.hasteEnchants + AddonTable.unholyHaste + AddonTable.LightningReflexes + AddonTable.bladeFlurry + AddonTable.windFury +
			AddonTable.improvedMoonkin + AddonTable.swiftRet + AddonTable.hiddenHaste + AddonTable.berserkering

	if options.Display_Basic then haste = GetHaste() end
	
	if AddonTable.Band(EB, Percentage) then percentStat = haste end
	if AddonTable.Band(EB, Rating) then ratingStat = hasteRating end
	
	HUD:UpdateText(data, format(statFormat, percentStat and percentStat or ratingStat, ratingStat))
end
------------------------------------------------

-- Attack Speed
function AddonTable.FunctionList.weaponSpeed(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local ohID = GetInventoryItemID("player", 17)
	local _, itemSubtype, _, _, _ = 0
	
	if offSpeed == nil then
		offSpeed = 0
	end	

	local offHandSpeed = offSpeed
	local offHandAuto = offSpeed
	local classId = 0
	
	if ohID then _,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID) end	
	
	if (ohID and classId == AddonTable.weaponTag) then offHandSpeed = "/" .. ("%.1f"):format(offHandSpeed)
	else offHandSpeed = "" end	
	
	if AddonTable.Band(EB, MainHand) then returnText = ("%.2f"):format(mainSpeed) end
	if AddonTable.Band(EB, OffHand) then returnText = ("%.2f"):format(offHandAuto) end
	if AddonTable.Band(EB, Auto) then returnText = ("%.2f"):format(mainSpeed) .. offHandSpeed end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Armor Penenetration
function AddonTable.FunctionList.ArmorPen(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local mhID = GetInventoryItemID("player", 16)
	local ohID = GetInventoryItemID("player", 17)
	local armorPen = GetArmorPenetration()
	local armorPenBase = armorPen
	local armorPenRating = GetCombatRating(CR_ARMOR_PENETRATION)
	local itemType, itemSubtype, classId, mhsubId, ohsubId = 0, 0, 0, 0, 0
	local maceSpecOH = ""
	local returnText
	local battleStance = GetShapeshiftForm()
	local stanceArmorPen = 0
	
	if battleStance == 1 then stanceArmorPen = 10 end

	armorPen = armorPen + AddonTable.bloodGorged + AddonTable.SerratedBlades + stanceArmorPen
	
	if mhID then _,_,_,_,_,_, itemSubtype, _, _, _, _, _, mhsubId = GetItemInfo(mhID) end	
	if (mhID and mhsubId == 4) or (mhID and mhsubId == 5) then armorPen =  armorPen + AddonTable.MaceSpec end
	
	if ohID then _,_,_,_,_,_, itemSubtype, _, _, _, _, _, ohsubId = GetItemInfo(ohID) end   
	if (ohID and ohsubId == 4) or (ohID and ohsubId == 5) then maceSpecOH = " +" .. ("%.0f%%"):format(AddonTable.MaceSpec) end
	if ((mhID and mhsubId == 4) or (mhID and mhsubId == 5)) and ((ohID and ohsubId == 4) or (ohID and ohsubId == 5)) then maceSpecOH = "" end
	
	if options.Display_Basic then armorPen = armorPenBase; maceSpecOH = "" end
	
	if AddonTable.Band(EB, Percentage) then returnText = ("%.2f%%"):format(armorPen) .. maceSpecOH end
	if  AddonTable.Band(EB, Rating) then returnText = armorPenRating end
	if  AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(armorPen) .. maceSpecOH .. " (" .. armorPenRating .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Target Armor
function AddonTable.FunctionList.NPCArmor(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Enhanced_Base
	local debuffColor = ""
	local npcArmorBase = AddonTable.targetArmor
	local npcArmor = 0
	local returnText
	npcArmor = AddonTable.targetArmor - AddonTable.targetArmor * (AddonTable.curseOfWeak/100) - AddonTable.targetArmor * (AddonTable.faerieFire/100) - AddonTable.targetArmor * (AddonTable.exposeArmor/100) - AddonTable.targetArmor * (AddonTable.sunderArmor/100) - AddonTable.shatterArmor
	
	if (AddonTable.sunderArmor > 0) or (AddonTable.exposeArmor > 0) or (AddonTable.faerieFire > 0) or (AddonTable.curseOfWeak > 0) or (AddonTable.shatterArmor > 0) then debuffColor = AddonTable.greenText end
	
	if npcArmor == 0 then debuffColor = "" end
	
	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. ("%.0f"):format(npcArmor) end
	if  AddonTable.Band(EB, Base) then returnText = debuffColor .. ("%.0f"):format(npcArmorBase) end
	if  AddonTable.Band(EB, Both) then returnText = debuffColor .. ("%.0f"):format(npcArmor) .. "|r" .. "/" .. ("%.0f"):format(npcArmorBase) end	
	
	if returnText == nil then returnText = "" end		
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Expertise
function AddonTable.FunctionList.Expertise(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local expertisePercent, offhandExpertisePercent = GetExpertisePercent()
	local expertiseRating = GetCombatRating(CR_EXPERTISE)
	local mhID = GetInventoryItemID("player", 16);
	local ohID = GetInventoryItemID("player", 17);
	local returnText
	local capColor = ""
	local classId = 0
	
	if ohID then _,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID) end	
	
	local mainHandFormat = expertisePercent
	local offHandFormat = offhandExpertisePercent
	
	if (ohID and classId == AddonTable.weaponTag) and offhandExpertisePercent > 0 then offHandFormat = "|r/" .. ("%.2f%%"):format(offHandFormat)
	else offHandFormat = "" end	
	
	if options.Display_MainHand then offHandFormat = "" end
	if mainHandFormat >= 6.5 then capColor = AddonTable.greenText end
	
	if AddonTable.Band(EB, Percentage) then returnText = capColor.. ("%.2f%%"):format(mainHandFormat) .. offHandFormat end
	if  AddonTable.Band(EB, Rating) then returnText = expertiseRating end
	if AddonTable.Band(EB, Both) then returnText = capColor.. ("%.2f"):format(mainHandFormat) .. offHandFormat .. " |r(" .. expertiseRating .. ")" end
	
	if returnText == nil then returnText = "" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Damage Reduction
function AddonTable.FunctionList.BossReduc(HUD, data, options, ...)

	local debuffColor = ""
	local valueSign = ""
	local npcArmorBase = AddonTable.targetArmor
	local npcArmor = 0
	local EB, percentStat, ratingStat = options.Enhanced_Base
	local returnText
	
	npcArmor = AddonTable.targetArmor
	
	local damageReduction = (npcArmor / ((467.5 * AddonTable.targetLevel) + npcArmor - 22167.5)) * 100
	local baseReduction = (AddonTable.targetArmor / ((467.5 * AddonTable.targetLevel) + AddonTable.targetArmor - 22167.5)) * 100
	
	if (AddonTable.sunderArmor > 0) or (AddonTable.exposeArmor > 0) or (AddonTable.faerieFire > 0) or (AddonTable.curseOfWeak > 0) or (AddonTable.shatterArmor > 0) then debuffColor = AddonTable.greenText end

	damageReduction = damageReduction + AddonTable.curseOfWeak + AddonTable.faerieFire + AddonTable.exposeArmor + AddonTable.sunderArmor + AddonTable.shatterArmor
	
	if damageReduction < 0 then damageReduction = math.abs(damageReduction); valueSign = "+" end
	
	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. valueSign .. ("%.1f%%"):format(damageReduction) end
	if  AddonTable.Band(EB, Base) then returnText = valueSign .. ("%.1f%%"):format(baseReduction) end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. valueSign .. ("%.1f%%"):format(damageReduction) .. " (" .. ("%.1f%%"):format(baseReduction) .. ")" end
	
	if returnText == nil then returnText = "" end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function AddonTable.FunctionList.MeleeMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local statFormat = Miss_Chance_Format[EB]

	if AddonTable.Band(EB, SameLevel) then enhancedStat = AddonTable.meleeSameLevel end
	if  AddonTable.Band(EB, BossLevel) then baseStat = AddonTable.meleeBossLevel end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------
