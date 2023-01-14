local AddName, AddonTable = ...
local L = AddonTable.L

----------------------
--		SinLive		--
----------------------
function AddonTable.SinLive(self)

AddonTable.huntersMark, AddonTable.debuffCount, AddonTable.bloodFrenzy, AddonTable.stormStrike, AddonTable.hemoDmg, AddonTable.exposeArmor, AddonTable.sunderArmor = 0, 0, 0, 0, 0, 0, 0
AddonTable.faerieFire, AddonTable.curseOfWeak, AddonTable.shatterArmor, AddonTable.frostFever, AddonTable.scorpidSting, AddonTable.insectSwarm, AddonTable.improvedFaerie = 0, 0, 0, 0, 0, 0
AddonTable.misery, AddonTable.curseElements, AddonTable.impSorch, AddonTable.wintersChill, AddonTable.ebonPlague, AddonTable.rageRivendare, AddonTable.earthMoon = 0, 0, 0, 0, 0, 0, 0
AddonTable.heartCrusader, AddonTable.savageCombat, AddonTable.impShadowbolt, AddonTable.faerieFireImp, AddonTable.masterPoisoner, AddonTable.moltenFury, AddonTable.faerieCrit = 0, 0, 0, 0, 0, 0, 0
	
	for i = 1, 40 do
	local _, _, dcount, _, _, _, caster, _, _, debuffId = UnitDebuff("target", i)
		if not debuffId then break end
		
		local targetGUID = UnitGUID("target")
		
		if debuffId then AddonTable.debuffCount = i end
		
		AddonTable.debuffCount = AddonTable.debuffCount
		if AddonTable.Misery[debuffId] then AddonTable.misery = AddonTable.Misery[debuffId][1] end
		if AddonTable.HuntsMark[debuffId] then AddonTable.huntersMark = AddonTable.HuntsMark[debuffId][1] end
		if AddonTable.Hemo[debuffId] then AddonTable.hemoDmg = AddonTable.Hemo[debuffId][1] end
		if AddonTable.CurseOfEl[debuffId] then AddonTable.curseElements = AddonTable.CurseOfEl[debuffId][1] end
		if AddonTable.Scorpid[debuffId] then AddonTable.scorpidSting = AddonTable.Scorpid[debuffId][1] end
		if AddonTable.Stormstrike[debuffId] then AddonTable.stormStrike = AddonTable.Stormstrike[debuffId][1] end
		if AddonTable.Blood[debuffId] then AddonTable.bloodFrenzy = AddonTable.Blood[debuffId][1] end
		if AddonTable.Insect[debuffId] then AddonTable.insectSwarm = AddonTable.Insect[debuffId][1] end
		if AddonTable.MasterPoisoner[debuffId] then AddonTable.masterPoisoner = AddonTable.MasterPoisoner[debuffId][1] + AddonTable.MasterPoisonerTalent end				
		if AddonTable.ArmorDebuffs.ExposeArmor[debuffId] then AddonTable.exposeArmor = AddonTable.ArmorDebuffs.ExposeArmor[debuffId][1] end
		if AddonTable.ArmorDebuffs.SunderArmor[debuffId] then AddonTable.sunderArmor = (dcount * AddonTable.ArmorDebuffs.SunderArmor[debuffId][1]) end
		if AddonTable.ArmorDebuffs.FaerieFire[debuffId] then AddonTable.faerieFire = AddonTable.ArmorDebuffs.FaerieFire[debuffId][1]; AddonTable.faerieFireImp = AddonTable.FaerieImproved; AddonTable.faerieCrit = AddonTable.FaerieImproved end
		if AddonTable.ArmorDebuffs.CurseOfWeak[debuffId] then AddonTable.curseOfWeak = AddonTable.ArmorDebuffs.CurseOfWeak[debuffId][1] end
		if AddonTable.EbonPlaguebringer[debuffId] then AddonTable.ebonPlague = AddonTable.EbonPlaguebringer[debuffId][1] end	
		if AddonTable.EarthAndMoon[debuffId] then AddonTable.earthMoon = AddonTable.EarthAndMoon[debuffId][1] end			
		if AddonTable.Shatter[debuffId] then AddonTable.shatterArmor = dcount * AddonTable.Shatter[debuffId][1] end
		if AddonTable.FrostFever[debuffId] and AddonTable.tundraStalker > 0 then AddonTable.frostFever = AddonTable.tundraStalker end
		if AddonTable.BloodPlague[debuffId] and AddonTable.rageRivenTalent > 0 then AddonTable.rageRivendare = AddonTable.rageRivenTalent end		
		if AddonTable.HeartOfCrusader[debuffId] then AddonTable.heartCrusader = AddonTable.HeartOfCrusader[debuffId][1] end
		if AddonTable.WintersChill[debuffId] then AddonTable.wintersChill = dcount end
		if AddonTable.ImprovedScorch[debuffId] then AddonTable.impSorch = AddonTable.ImprovedScorch[debuffId][1] end
		if AddonTable.SavageCombat[debuffId] then AddonTable.savageCombat = AddonTable.SavageCombat[debuffId][1] end
		if AddonTable.ShadowMastery[debuffId] then AddonTable.impShadowbolt = AddonTable.ShadowMastery[debuffId][1] end	
		if AddonTable.MoltenFury > 0 then
			local health = UnitHealth("target")
			local maxHealth = UnitHealthMax("target")
			local percentHealth = (health / maxHealth) * 100
			if percentHealth <= 35 then AddonTable.moltenFury = AddonTable.MoltenFury end
		end	
		if GetTime() - AddonTable.throttleTime > AddonTable.inspectDelay then
		if AddonTable.ArmorDebuffs.FaerieFire[debuffId] and caster ~= "player" then
			AddonTable.talentCaster = caster 
			local inRange = CheckInteractDistance(caster, 1)
				if inRange then AddonTable.canInspect = CanInspect(caster)
					if AddonTable.canInspect then NotifyInspect(caster) end
						AddonTable.faerieCheck = true
						AddonTable.throttleTime = GetTime()
				end
		end
		end
		if AddonTable.faerieCheck and caster == "player" then AddonTable.faerieFireImp = 0; AddonTable.faerieCrit = AddonTable.faerieFireImp end
		if AddonTable.faerieCheck and caster ~= "player" then AddonTable.faerieCrit = 0 end
	end
end