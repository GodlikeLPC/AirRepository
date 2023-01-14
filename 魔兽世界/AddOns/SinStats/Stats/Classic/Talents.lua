local AddName, AddonTable = ...
local L = AddonTable.L


function AddonTable.talentScan()
	local className, classFilename, classId = UnitClass("player")
	if (classFilename == "MAGE") then  
	
		local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 13)
				AddonTable.spellCritMod = (points * 2)
				
		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
				AddonTable.arcaneMod = points * 1
				AddonTable.aiMod = ((points * 1)/100)

		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
				AddonTable.hitMod = points * 2

		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 2)
				AddonTable.arcaneFocus = points * 2
				if AddonTable.arcaneFocus > 0 then
					AddonTable.labelHit = (" (|cff69CCF0+" .. ("%.0f"):format(AddonTable.arcaneFocus) .. "|r)")
				else
					AddonTable.labelHit = ""
				end
   
		local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 15)      
				AddonTable.firepowerMod = ((points * 2)/100)
    
		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 8)
				AddonTable.pierceMod = ((points * 2) / 100)

	elseif (classFilename == "PRIEST") then
	
		local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
				AddonTable.spellCritMod = points * 1

		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 5)
				AddonTable.hitMod = points * 2
				if AddonTable.hitMod > 0 then
				AddonTable.labelHit = (" (|cff8787ED+" .. ("%.0f"):format(AddonTable.hitMod) .. "|r)")  
				else
					AddonTable.labelHit = ""
				end

		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 15)
				AddonTable.DarkNessTalent = ((points * 2) / 100)
   		
		local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 15)   
				AddonTable.spiritualHealing = ((points * 2) / 100)
    

	elseif (classFilename == "PALADIN") then

		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 10)
				AddonTable.wisTalent = ((points * 10)/100)	

	elseif (classFilename == "WARLOCK") then

		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 16)
				AddonTable.shadowMastery = ((points * 2)/100)
       
		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 15)
				AddonTable.emberstorm = ((points * 2)/100)   

	elseif (classFilename == "SHAMAN") then
	
		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 14)  
				AddonTable.purification = ((points * 2)/100)      

	end 
end
