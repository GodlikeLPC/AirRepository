local AddName, AddonTable = ...
local L = AddonTable.L

----------------------------
-- Local Helper Functions --
----------------------------
function AddonTable.druidFormChk()
	if (classFilename == "DRUID") then
		local index = GetShapeshiftForm()
		if (index == 1) or (index == 3) then return true
		else return false end
	end
end

-- Target Armor
local function TargetArmor(self)
	AddonTable.targetArmor = 0
	local NPCguid, NPCname = UnitGUID("target"), UnitName("target")	
	if NPCguid ~= nil then
		local NPCtype, _, _, _, _, npc_id, _ = strsplit("-",NPCguid)
		npc_id = tonumber(npc_id)
			if NPCtype == "Creature" then
				if AddonTable.BossArmor[npc_id] then AddonTable.targetArmor = AddonTable.BossArmor[npc_id][1] end
			end	
	end
end

-- Item level
local function itemLevelCheck()
	AddonTable.averageiLvl = 0
	local mainHandEquipLoc, offHandEquipLoc
	for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		if slot ~= INVSLOT_BODY and slot ~= INVSLOT_TABARD then
			local id = GetInventoryItemID("player", slot)
			if id then
				local _, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(id)
				if itemLevel == nil then itemLevel = 0 end
				AddonTable.averageiLvl = AddonTable.averageiLvl + itemLevel
				if slot == INVSLOT_MAINHAND then mainHandEquipLoc = itemEquipLoc
				elseif slot == INVSLOT_OFFHAND then offHandEquipLoc = itemEquipLoc end
			end
		end
	end
	local invSlots
	if mainHandEquipLoc and offHandEquipLoc then invSlots = 17 else
		local equippedItemLoc = mainHandEquipLoc or offHandEquipLoc
		invSlots = ( equippedItemLoc == "INVTYPE_WEAPON" or equippedItemLoc == "INVTYPE_WEAPONMAINHAND" ) and 17 or 16
	end
	AddonTable.averageiLvl = (AddonTable.averageiLvl/invSlots)
end

-- Stats computing
function AddonTable.StatsCompute()

	-- Init
	AddonTable.castHaste, AddonTable.meleeHaste, AddonTable.rangedHaste = 0, 0, 0
	AddonTable.buffCount, AddonTable.heroicPresence, AddonTable.zoneBuff, AddonTable.maxmana, AddonTable.ancestralHealing, AddonTable.inspiration = 0, 0, 0, 0, 0, 0
	AddonTable.arcanePower, AddonTable.combustionCount, AddonTable.evoc, AddonTable.unholyHaste, AddonTable.blessingSanc, AddonTable.rightFury, AddonTable.borrowedTime = 0, 0, 0, 0, 0, 0, 0
	AddonTable.masterImp, AddonTable.masterFel, AddonTable.masterSucc, AddonTable.dsSuc, AddonTable.dsImp, AddonTable.felEnergy, AddonTable.runeInvicibility, AddonTable.moltenArmor = 0, 0, 0, 0, 0, 0, 0, 0
	AddonTable.innervate, AddonTable.isShapeshift, AddonTable.treeofLife, AddonTable.bladeFlurry, AddonTable.bladeBarrier, AddonTable.renewedHope, AddonTable.windFury, AddonTable.berserkering = 0, false, 0, 0, 0, 0, 0, 0
	AddonTable.aspectViper, AddonTable.icyTalons, AddonTable.vengStacks, AddonTable.vengBuff, AddonTable.avenWrath, AddonTable.epiphany, AddonTable.desolation, AddonTable.shamanRage = 0, 0, 0, 0, 0, 0, 0, 0
	AddonTable.shadowFormDmg, AddonTable.innerFocus, AddonTable.eleMasteryHaste, AddonTable.totemWrath, AddonTable.shadowWeaving, AddonTable.divineProt, AddonTable.armyDead, AddonTable.maelstromWeapon = 0, 0, 0, 0, 0, 0, 0, 0
	AddonTable.stanceArmorPen, AddonTable.berserker, AddonTable.arcaneEmpowerment, AddonTable.feroInspiration, AddonTable.naturesGrace, AddonTable.improvedMoonkin, AddonTable.talentCaster = 0, 0, 0, 0, 0, 0, nil
	AddonTable.swiftRetCheck, AddonTable.impMoonCheck, AddonTable.swiftRet, AddonTable.faerieCheck, AddonTable.hiddenHaste, AddonTable.metaDamage, AddonTable.metaCrit = false, false, 0, false, 0, 0, 0

	for i = 1, 40 do
		local _, _, count, _, _, _, caster, _, _, spellId = UnitBuff("player",i, "HELPFUL")
		if not spellId then break end
		
		if spellId then AddonTable.buffCount = i end
		
		AddonTable.maxmana = UnitPowerMax("player", Enum.PowerType.Mana)
		AddonTable.buffCount = AddonTable.buffCount
		if AddonTable.HeroicPresence[spellId] then AddonTable.heroicPresence = AddonTable.HeroicPresence[spellId][1] end	
		if AddonTable.TotemOfWrath[spellId] then AddonTable.totemWrath = AddonTable.TotemOfWrath[spellId][1] end
		if AddonTable.InnervateEffect[spellId] then AddonTable.innervate = (AddonTable.maxmana * AddonTable.InnervateEffect[spellId][1]) / 10 end
		if AddonTable.OutlandsBuffs[spellId] then AddonTable.zoneBuff = AddonTable.OutlandsBuffs[spellId][1] end
		if AddonTable.BlessingOfSanc[spellId] then AddonTable.blessingSanc = AddonTable.BlessingOfSanc[spellId][1] end
		if AddonTable.WindFuryTotem[spellId] then AddonTable.windFury = AddonTable.WindFuryTotem[spellId][1] + AddonTable.ImprovedWindfury end
		if AddonTable.RenewedHope[spellId] then AddonTable.renewedHope = AddonTable.RenewedHope[spellId][1] end
		if AddonTable.RuneInvicibility[spellId] then AddonTable.runeInvicibility = AddonTable.RuneInvicibility[spellId][1] end
		if AddonTable.AncestralHealing[spellId] then AddonTable.ancestralHealing = AddonTable.AncestralHealing[spellId][1] end
		if AddonTable.Inspiration[spellId] then AddonTable.inspiration = AddonTable.Inspiration[spellId][1] end
		if AddonTable.Flurry[spellId] then AddonTable.meleeHaste = AddonTable.meleeHaste + AddonTable.Flurry[spellId][1] end			
		if AddonTable.PowerInfusion[spellId] then AddonTable.castHaste = AddonTable.castHaste + AddonTable.PowerInfusion[spellId][1] end
		if AddonTable.ArcaneEmpowerment[spellId] then AddonTable.arcaneEmpowerment = AddonTable.ArcaneEmpowerment[spellId][1] end
		if AddonTable.FerociousInspiration[spellId] then AddonTable.feroInspiration = AddonTable.FerociousInspiration[spellId][1] end
		if AddonTable.Berserkering[spellId] then AddonTable.berserkering = AddonTable.Berserkering[spellId][1] end
		if AddonTable.MoonkinAura[spellId] and caster ~= "player" and not AddonTable.swiftRetCheck then
			AddonTable.talentCaster = caster
			AddonTable.hiddenHaste = AddonTable.impMoon
			if GetTime() - AddonTable.throttleTime > AddonTable.inspectDelay then
				local inRange = CheckInteractDistance(caster, 1)
					if inRange then AddonTable.canInspect = CanInspect(caster)
						if AddonTable.canInspect then NotifyInspect(caster) end
						AddonTable.impMoonCheck = true
						AddonTable.throttleTime = GetTime()
					end
			end
		end
		if AddonTable.RetributionAura[spellId] and caster ~= "player" and not AddonTable.impMoonCheck then 
			AddonTable.talentCaster = caster 
			AddonTable.hiddenHaste = AddonTable.impRet
			if GetTime() - AddonTable.throttleTime > AddonTable.inspectDelay then
				local inRange = CheckInteractDistance(caster, 1)
					if inRange then AddonTable.canInspect = CanInspect(caster)
						if AddonTable.canInspect then NotifyInspect(caster) end
						AddonTable.swiftRetCheck = true
						AddonTable.throttleTime = GetTime()
					end
			end
		end
	--
	
	-- Mage
	if (AddonTable.classFilename == "MAGE") then

		AddonTable.maxmana = UnitPowerMax("player", Enum.PowerType.Mana)
		if AddonTable.Combustion[spellId] then AddonTable.combustionCount = count * (AddonTable.Combustion[spellId][1]) end
		if AddonTable.IcyVeins[spellId] then AddonTable.castHaste = AddonTable.castHaste + (AddonTable.IcyVeins[spellId][1]) end		
		if AddonTable.Combustion[spellId] then AddonTable.combustionCount = count * (AddonTable.Combustion[spellId][1]) end		
		if AddonTable.Evocation[spellId] then AddonTable.evoc = AddonTable.maxmana * (AddonTable.Evocation[spellId][1] / 8) * 2 end		
		if AddonTable.MoltenArmor[spellId] then AddonTable.moltenArmor = AddonTable.MoltenArmor[spellId][1] end
		if AddonTable.ArcanePower[spellId] then AddonTable.arcanePower = AddonTable.ArcanePower[spellId][1] end		
	--
	
	-- Warlock
	elseif (AddonTable.classFilename == "WARLOCK") then
	
		local maxpower = UnitPowerMax("player" , mana)
		if AddonTable.FelEnergy[spellId] then AddonTable.felEnergy = (maxpower * AddonTable.FelEnergy[spellId][1]) end
		if AddonTable.TouchOfShadow[spellId] then AddonTable.dsSuc = AddonTable.TouchOfShadow[spellId][1] end
		if AddonTable.BurningWish[spellId] then AddonTable.dsImp = AddonTable.BurningWish[spellId][1] end
		if AddonTable.MasterDemoImp[spellId] then AddonTable.masterImp = AddonTable.MasterDemoImp[spellId][1] end
		if AddonTable.MasterDemoSucc[spellId] then AddonTable.masterSucc = AddonTable.MasterDemoSucc[spellId][1] end
		if AddonTable.MasterDemoFel[spellId] then AddonTable.masterFel = AddonTable.MasterDemoFel[spellId][1] end
		if AddonTable.Eradication[spellId] then AddonTable.castHaste = AddonTable.castHaste + AddonTable.Eradication[spellId][1] end
		if AddonTable.Metamorphosis[spellId] then AddonTable.metaDamage = AddonTable.Metamorphosis[spellId][1]; AddonTable.metaCrit = AddonTable.Metamorphosis[spellId][2] end
	--	
		
	-- Druid
	elseif (AddonTable.classFilename == "DRUID") then
	
		if AddonTable.TreeOfLife[spellId] then AddonTable.treeofLife = AddonTable.TreeOfLife[spellId][1] end		
		if GetShapeshiftForm == 1 or GetShapeshiftForm == 3 then AddonTable.isShapeshift = true
		else AddonTable.isShapeshift = false end	
		if AddonTable.NaturesGrace[spellId] then AddonTable.naturesGrace = AddonTable.NaturesGrace[spellId][1] end
		if AddonTable.Moonkin[spellId] and AddonTable.ImprovedMoonkin > 0 then AddonTable.improvedMoonkin = AddonTable.ImprovedMoonkin end
		if AddonTable.swiftRetCheck then AddonTable.improvedMoonkin = 0 end
		
	--
	
	-- Hunter
	elseif (AddonTable.classFilename == "HUNTER") then

		local playerMaxMana = UnitPowerMax("player", Enum.PowerType.Mana)	
		if AddonTable.AspectOfViper[spellId] then AddonTable.aspectViper = playerMaxMana * AddonTable.AspectOfViper[spellId][1] end
	--
	
	-- Paladin
	elseif (AddonTable.classFilename == "PALADIN") then

		if AddonTable.AvengingWrath[spellId] then AddonTable.avenWrath = AddonTable.AvengingWrath[spellId][1] end
		if AddonTable.DivineProtection[spellId] then AddonTable.divineProt = AddonTable.DivineProtection[spellId][1] end
		if (AddonTable.riFuryTalent > 0) and AddonTable.RighteousFury[spellId] then AddonTable.rightFury = AddonTable.riFuryTalent end
		if AddonTable.Vengeance[spellId] then AddonTable.vengStacks = count
			if AddonTable.vengeance == 3 and AddonTable.vengStacks > 0 then AddonTable.vengBuff = (AddonTable.vengStacks * AddonTable.vengeance) / 100
			elseif AddonTable.vengeance == 2 and AddonTable.vengStacks > 0 then AddonTable.vengBuff = (AddonTable.vengStacks * AddonTable.vengeance) / 100					
			elseif AddonTable.vengeance == 1 and AddonTable.vengStacks > 0 then AddonTable.vengBuff = (AddonTable.vengStacks * AddonTable.vengeance) / 100				
			else AddonTable.vengBuff = 0 end
		end
		if AddonTable.RetributionAura[spellId] and AddonTable.SwiftRetribution > 0 then AddonTable.swiftRet = AddonTable.SwiftRetribution end
		if AddonTable.impMoonCheck then AddonTable.swiftRet = 0 end
		
	--
	
	-- Priest
	elseif (AddonTable.classFilename == "PRIEST") then

		if AddonTable.InnerFocus[spellId] then AddonTable.innerFocus = AddonTable.InnerFocus[spellId][1] end
		if AddonTable.ShadowForm[spellId] then AddonTable.shadowFormDmg = AddonTable.ShadowForm[spellId][1] end
		if AddonTable.Epiphany[spellId] then AddonTable.epiphany = AddonTable.Epiphany[spellId][1] end			
		if spellId == 15258 then AddonTable.shadowWeaving = count ; AddonTable.shadowWeaving = (AddonTable.shadowWeaving * 2) / 100 end
		if AddonTable.BorrowedTime[spellId] then AddonTable.borrowedTime = AddonTable.BorrowedTime[spellId][1] end					
	--

	-- Shaman
	elseif (AddonTable.classFilename == "SHAMAN") then

		if AddonTable.ElementalMastery[spellId] then AddonTable.eleMasteryHaste = AddonTable.ElementalMastery[spellId][1] end
		if AddonTable.ShamanisticRage[spellId] then AddonTable.shamanRage = AddonTable.ShamanisticRage[spellId][1] end
		if AddonTable.MaelstromWeapon[spellId] then AddonTable.maelstromWeapon = AddonTable.MaelstromWeapon[spellId][1] end
	--

	-- Warrior
	elseif (AddonTable.classFilename == "WARRIOR") then
	
		if AddonTable.Berserker[spellId] then AddonTable.berserker = AddonTable.Berserker[spellId][1] end
	--
	
	-- Rogue
	elseif (AddonTable.classFilename == "ROGUE") then
		
		if AddonTable.SliceAndDice[spellId] then AddonTable.meleeHaste = AddonTable.meleeHaste + AddonTable.SliceAndDice[spellId][1] end	
		if AddonTable.BladeFlurry[spellId] then AddonTable.bladeFlurry = AddonTable.BladeFlurry[spellId][1] end		
	--
	
	-- Death Knight
	elseif (AddonTable.classFilename == "DEATHKNIGHT") then

		if AddonTable.SliceAndDice[spellId] then AddonTable.meleeHaste = AddonTable.meleeHaste + AddonTable.SliceAndDice[spellId][1] end	
		if AddonTable.IcyTalons[spellId] then AddonTable.icyTalons = AddonTable.icyTalons + AddonTable.IcyTalons[spellId][1] end
		if AddonTable.IcyTalonsImp[spellId] then AddonTable.icyTalons = AddonTable.IcyTalonsImp[spellId][1] end
		if AddonTable.UnholyPresence[spellId] then AddonTable.unholyHaste = AddonTable.UnholyPresence[spellId][1] end
		if AddonTable.Desolation[debuffId] then AddonTable.desolation = AddonTable.Desolation[debuffId][1] end
		if AddonTable.BladeBarrier[spellId] then AddonTable.bladeBarrier = AddonTable.BladeBarrier[spellId][1] end
		if AddonTable.ArmyofDead[spellId] then AddonTable.armyDead = AddonTable.ArmyofDead[spellId][1] + AddonTable.parryChance + AddonTable.dodgeChance end			

	end -- end class checks
	end -- end loop player
	
	-- Defense
	AddonTable.baseDefense, _ = UnitDefense("player")
	AddonTable.defenseBonus = GetCombatRatingBonus(CR_DEFENSE_SKILL)
	AddonTable.defenseRating = GetCombatRating(CR_DEFENSE_SKILL)
	AddonTable.totalDefense = 0
	local numberLines = GetNumSkillLines()
	local defGearBonus = 0
	
	
	if AddonTable.defenseBonus == nil then AddonTable.defenseBonus = 0 end
	if AddonTable.defenseRating == nil then AddonTable.defenseRating = 0 end	
	
	for i = 1, numberLines do
		local skillName, header, _, _, _, skillModifier  = GetSkillLineInfo(i)
		
		if skillName == nil then break end
		if (not header) and (skillName == DEFENSE) then defGearBonus = skillModifier break end
	end
	AddonTable.totalDefense = AddonTable.defenseBonus + defGearBonus + AddonTable.baseDefense
	--
end 

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function AddonTable.OnEventFunc(event, ...)

	if event == "CHARACTER_POINTS_CHANGED" then
	-----	
		AddonTable.talentScan()
		AddonTable.StatsCompute()
	-----
	elseif event == "UNIT_INVENTORY_CHANGED" then
		itemLevelCheck()
	-----
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
	-----	
	local event, subevent, _, _, _, _, _, destGUID, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
	local storedGUID = UnitGUID("target")
	local playerGUID = UnitGUID("player")
	local petGUID = UnitGUID("pet")
	AddonTable.manaTide = 0
	

	if (AddonTable.manaTideCheck[spellId]) and (destGUID == playerGUID) then
		local TideMana = UnitPowerMax("player", Enum.PowerType.Mana)
		AddonTable.manaTide = ((TideMana * 0.06) / 3) * 2
		AddonTable.manaTide = AddonTable.manaTide
	end	


	-----
	elseif event == "PLAYER_LEVEL_UP" then	
	-----	
		AddonTable.playerLevel = UnitLevel("player")
	-----	
	elseif event == "INSPECT_READY" then
	-----
	if AddonTable.impMoonCheck then
		AddonTable.impMoon = 0
		AddonTable.impMoon = select(5, GetTalentInfo(1,19, AddonTable.canInspect, AddonTable.talentCaster))
	end
	if AddonTable.swiftRetCheck then
		AddonTable.impRet = 0
		AddonTable.impRet = select(5, GetTalentInfo(3,22, AddonTable.canInspect, AddonTable.talentCaster))
	end	
	if AddonTable.faerieCheck then
		AddonTable.faerieFireImp = 0
		AddonTable.faerieFireImp = select(5, GetTalentInfo(1,15, AddonTable.canInspect, AddonTable.talentCaster))
	end
	--if AddonTable.swiftRetCheck and AddonTable.impMoonCheck then AddonTable.xpoints = AddonTable.xpoints / 2 end
	-----
	elseif event == "PLAYER_TARGET_CHANGED" then
	-----	
		local exists = UnitExists("target")
		local hostile = UnitCanAttack("player", "target")
		AddonTable.BeastSlaying = 0
	
		if hostile or not exists then AddonTable.SinLive() end
		if exists and AddonTable.raceId == 8 and UnitCreatureType("target") == "Beast" then AddonTable.BeastSlaying = 0.05 end
	
		TargetArmor()
	-----
	else
	-----	
	
	local unit = ...
	if unit == "target" then AddonTable.SinLive() return end
	if unit == "pet" and UnitCreatureFamily("pet") == "Imp" then 
		for i = 1, 20 do 
			local _, _, _, _, _, _, _, _, _, spellId = UnitAura("pet",i, "PLAYER")
			if not spellId then break end
			AddonTable.demonicEmp = 0
			if spellId == 54444 then AddonTable.demonicEmp = 20 end
		end	
	end
	
	AddonTable.StatsCompute()

end -- end events
end -- end function
