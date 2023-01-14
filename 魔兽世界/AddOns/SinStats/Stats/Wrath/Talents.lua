local AddName, AddonTable = ...
local L = AddonTable.L


function AddonTable.talentScan()
	local className, classFilename, classId = UnitClass("player")
	
	if (classFilename == "MAGE") then   
	local points = select(5, GetTalentInfo(1, 3))
		AddonTable.arcaneFocus = points
	
	local points = select(5, GetTalentInfo(1, 13))
			AddonTable.aiMod = ((points * 1)/100)
			
	local points = select(5, GetTalentInfo(1, 18))
			AddonTable.PrismaticCloak = points * 2		
			
	local points = select(5, GetTalentInfo(1, 26))
		AddonTable.NetherwindPresence = points * 2			

	local points = select(5, GetTalentInfo(2, 17))
			AddonTable.playFire = (points * 1) / 100
			
	local points = select(5, GetTalentInfo(2, 19))
		AddonTable.MoltenFury = ((points * 6) / 100)			

	local points = select(5, GetTalentInfo(3, 3))
		AddonTable.pierceMod = ((points * 2) / 100)

	local points = select(5, GetTalentInfo(3,17))
		AddonTable.hitMod = points
		
	local points = select(5, GetTalentInfo(3, 20))
		AddonTable.arcticWind = (points * 1) / 100		
		
	local points = select(5, GetTalentInfo(3, 21))
		AddonTable.impFrostbolt = (points * 5) / 100
		
	elseif (classFilename == "PRIEST") then
	local points = select(5, GetTalentInfo(1, 16))
		AddonTable.FocusedPower = ((points * 2) / 100)
		
	local points = select(5, GetTalentInfo(1, 17))
		AddonTable.Enlightenment = points * 2
		
	local points = select(5, GetTalentInfo(2, 5))
		AddonTable.spiritualHealing = ((points * 2) / 100)
		
	local points = select(5, GetTalentInfo(2, 17))
		AddonTable.blessedResil = (points / 100)

	local points = select(5, GetTalentInfo(3, 2))
		AddonTable.DarkNessTalent = ((points * 2) / 100)		

	local points = select(5, GetTalentInfo(3, 3))
		AddonTable.hitMod = points

	elseif (classFilename == "ROGUE") then
	local points = select(5, GetTalentInfo(1, 16))
		AddonTable.MasterPoisonerTalent = points

	local points = select(5, GetTalentInfo(2, 3))
		AddonTable.MaceSpec = points * 3	
	
	local points = select(5, GetTalentInfo(2, 4))
		AddonTable.LightningReflexes = points * 2		

	local points = select(5, GetTalentInfo(3, 15))
		AddonTable.SleightTalent = points	

	local points = select(5, GetTalentInfo(3, 14))
		AddonTable.SerratedBlades = points * 3
		
	elseif (classFilename == "WARRIOR") then
	local points = select(5, GetTalentInfo(1, 4))
		AddonTable.MaceSpec = points * 3		

	elseif (classFilename == "PALADIN") then
	local points = select(5, GetTalentInfo(2, 9))
		AddonTable.divinity = points / 100
		
	local points = select(5, GetTalentInfo(2, 10))
		AddonTable.riFuryTalent = points * 2	
		
	local points = select(5, GetTalentInfo(2, 19))
		AddonTable.GuardedByLight = points * 3

	local points = select(5, GetTalentInfo(2, 23))
		AddonTable.ShieldTemplar = points

	local points = select(5, GetTalentInfo(3, 2))
		AddonTable.vengeance = points
		
	local points = select(5, GetTalentInfo(3, 14))
		AddonTable.crusadeTalent = points / 100	

	local points = select(5, GetTalentInfo(3, 22))
		AddonTable.SwiftRetribution = points

	elseif (classFilename == "WARLOCK") then
	local points = select(5, GetTalentInfo(1, 5))
		AddonTable.Suppression = points
		
	local points = select(5, GetTalentInfo(1, 11))
		AddonTable.shadowMastery = ((points * 3)/100)
		
	local points = select(5, GetTalentInfo(2, 19))
		AddonTable.DemonicTactics = points * 2
		
	local points = select(5, GetTalentInfo(2, 22))
		AddonTable.ImpDemonicTactics = (points * 10) / 100
		
	local points = select(5, GetTalentInfo(2, 25))
		AddonTable.DemonicPact = (points * 2) / 100		
      
	local points = select(5, GetTalentInfo(3, 8))
		AddonTable.emberstorm = ((points * 3)/100)  

	local points = select(5, GetTalentInfo(3, 11))
		AddonTable.devastation = points * 5
		if AddonTable.devastation > 0 then
			AddonTable.devastation = "|cffff3333 +" .. (points * 5) .. "|r"
		else
			AddonTable.devastation = ""
		end			

	local points = select(5, GetTalentInfo(3, 21))
		AddonTable.MoltenSkin = points * 2
		
	elseif (classFilename == "HUNTER") then
	local points = select(5, GetTalentInfo(1, 10))
		AddonTable.Ferocity = (points * 2)

	local points = select(5, GetTalentInfo(1, 14))
		AddonTable.FocusedFire = points/100
		
	local points = select(5, GetTalentInfo(1, 16))
		AddonTable.AnimalHandler = (points * 5)
		
	local points = select(5, GetTalentInfo(1, 19))
		AddonTable.serpentSwift = (points * 4)
		
	local points = select(5, GetTalentInfo(1, 26))
		AddonTable.KindredSpirits = (points * 4)/100

	elseif (classFilename == "SHAMAN") then
	local points = select(5, GetTalentInfo(1, 2))
		AddonTable.callofThunder = points * 5
		if AddonTable.callofThunder > 0 then
			AddonTable.callofThunder = "|cff0070DD +" .. AddonTable.callofThunder .. "|r"
		else
			AddonTable.callofThunder = ""
		end		

	local points = select(5, GetTalentInfo(1, 16))
		AddonTable.elePrecision = points

	local points = select(5, GetTalentInfo(2, 15))
		AddonTable.ImprovedWindfury = (points * 2)			
			
	local points = select(5, GetTalentInfo(3, 10))
		AddonTable.purification = ((points * 2)/100)
 	
	local points = select(5, GetTalentInfo(3, 12))
		AddonTable.tidalMastery = points
		
	elseif (classFilename == "DRUID") then
	
	local points = select(5, GetTalentInfo(1, 6))
		AddonTable.CelestialFocus = points	
			
	local points = select(5, GetTalentInfo(1, 13))
		AddonTable.balancePower = (points * 2)
			
	local points = select(5, GetTalentInfo(1, 15))
		AddonTable.FaerieImproved = points
		
	local points = select(5, GetTalentInfo(1, 19))
		AddonTable.ImprovedMoonkin = points		
	
	local points = select(5, GetTalentInfo(3, 8))
		AddonTable.giftNature = ((points * 2) / 100)

	local points = select(5, GetTalentInfo(2, 18))
		AddonTable.survFittest = (points * 2)

	local points = select(5, GetTalentInfo(1, 18))
		AddonTable.starlight = (points * 2)
			
	local points = select(5, GetTalentInfo(2, 9))
		AddonTable.predStrikes = points * 0.5
			
	local points = select(5, GetTalentInfo(3, 22))
		AddonTable.earthMother = points * 2	

	elseif (classFilename == "DEATHKNIGHT") then
	
	local points = select(5, GetTalentInfo(1, 24))
		AddonTable.bloodGorged = points * 2
	
	local points = select(5, GetTalentInfo(2, 13))
		AddonTable.tundraStalker = ((points * 3) / 100)

	local points = select(5, GetTalentInfo(3, 20))
		AddonTable.rageRivenTalent = ((points * 2) / 100)			

	local points = select(5, GetTalentInfo(3, 1))
		AddonTable.virulence = points		

	local points = select(5, GetTalentInfo(2, 9))
		AddonTable.frigidDread = points
	end 
end	

