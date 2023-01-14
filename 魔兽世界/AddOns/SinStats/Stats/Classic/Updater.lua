local AddName, AddonTable = ...
local L = AddonTable.L

function AddonTable.EventsUpdate()
print("hi")
if AddonTable.Profile.EventEnable then
	if (UnitAffectingCombat('player') and AddonTable.Profile.EventCombat and not AddonTable.CharPanel) then
		AddonTable.Profile.HideHUD = false	
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end

	if (not UnitAffectingCombat('player') and AddonTable.Profile.EventCombat and not AddonTable.CharPanel) then
			AddonTable.Profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			AddonTable:InitialiseProfile(AddonTable.Profile)
	end
end
end
----------------------------
-- Local Helper Functions --
----------------------------
function AddonTable.shapeshitCheck()
	if (classFilename == "DRUID") then
		local index = GetShapeshiftForm()
		if (index == 1) or (index == 3) then
			return true
		else
			return false
		end
	end
end 

-- Stats computing
function AddonTable.StatsCompute()

	-- Init

	local base = 0
	
	if (AddonTable.playerLevel < 19) then
		if (AddonTable.classFilename ~= "WARRIOR") and (AddonTable.classFilename ~= "ROGUE") then
			base = ((AddonTable.spirit/2))
		end
	elseif (AddonTable.classFilename == "HUNTER") or (AddonTable.classFilename == "PALADIN") or (AddonTable.classFilename == "WARLOCK") or (AddonTable.classFilename == "SHAMAN") then
		base = ((AddonTable.spirit/5) + 15)
	elseif (AddonTable.classFilename == "PRIEST") or (AddonTable.classFilename == "MAGE") then
		base = ((AddonTable.spirit/4) + 12.5)
	elseif (AddonTable.classFilename == "DRUID") then
		base = ((AddonTable.spirit/5) + 15)
	end 

	local mp5 = 0
	local tierPieces = 0
	local zgPieces = 0 
	local pouchCounter = 0
	local atkspeed = 0	
	local scourgeMp5 = 0
	
	if (AddonTable.classFilename ~= "WARRIOR") and (AddonTable.classFilename ~= "ROGUE") then
		for i=1,23 do
			local itemLink = GetInventoryItemLink("player", i)
			if itemLink then
				local stats = GetItemStats(itemLink)
				local itemId, enchantId = itemLink:match("item:(%d+):(%d+)")
				
					if stats then
						local statMP5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"]
							if (statMP5) then
								mp5 = mp5 + statMP5 + 1
							end
					end
					
					if enchantId then
						enchantId = tonumber(enchantId)
							if enchantId == 2715 then
								scourgeMp5 = 5
							end
					end
					
	if (AddonTable.classFilename == "PRIEST") or (AddonTable.classFilename == "DRUID") or (AddonTable.classFilename == "PALADIN") or (AddonTable.classFilename == "SHAMAN") then
		local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))
			if itemName then
				if classId == 5 then 
					if string.sub(itemName, -13) == "Transcendence" then
						tierPieces = tierPieces + 1
					end
				elseif classId == 11 then 
					if string.sub(itemName, 1, 9) == "Stormrage" then
						tierPieces = tierPieces + 1
					end
					if (string.sub(itemName, 10, 17) == "Haruspex") or 
						(string.sub(itemName, -15) == "South Seas Kelp") or
						(string.sub(itemName, 1, 9) == "Wushoolay") then
						zgPieces = zgPieces + 1
					end
				elseif classId == 2 then 
					if (string.sub(itemName, 10, 20) == "Freethinker") or 
						(string.sub(itemName, 1, 7) == "Gri'lek") or
						(string.sub(itemName, 1, 12) == "Hero's Brand") then
						zgPieces = zgPieces + 1
					end
				elseif classId == 7 then 
					if (string.sub(itemName, 1, 5) == "Augur") or 
						(string.sub(itemName, 1, 8) == "Unmarred") or
						(string.sub(itemName, 1, 9) == "Wushoolay") then
						zgPieces = zgPieces + 1
					end
					if string.sub(itemName, -14) == "Earthshatterer" then
						tierPieces = tierPieces + 1
					end
				end
			end
	end
	
	if (AddonTable.classFilename == "HUNTER") then
		local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))
			if itemName then
				if (string.sub(itemName, -10) == "Ammo Pouch") or
					(string.sub(itemName, 1, 10) == "Small Shot") or
					(string.sub(itemName, -9) == "Ammo Sack") or
					(string.sub(itemName, -6) == "Quiver") then
					pouchCounter = 10
				elseif (string.sub(itemName, 1, 9) == "Bandolier") or
						(string.sub(itemName, -11) == "Night Watch") then
						pouchCounter = 11
				elseif (string.sub(itemName, 1, 13) == "Heavy Leather") or
						(string.sub(itemName, 1, 12) == "Heavy Quiver") then
						pouchCounter = 12
				elseif (string.sub(itemName, 1, 13) == "Thick Leather") or
						(string.sub(itemName, 1, 9) == "Quickdraw") then
						pouchCounter = 13
				elseif (string.sub(itemName, 1, 8) == "Ribbly's") then
					pouchCounter = 14
				elseif (string.sub(itemName, 1, 10) == "Gnoll Skin") or 
					(string.sub(itemName, 1, 10) == "Harpy Hide") or
					(string.sub(itemName, -6) == "Lamina") then
					pouchCounter = 15								
				end		        
			end				
	end										
			end
		end
	end 

	local effectiveMR = mp5 * 0.4       
	local talentRegen = 0
	local totemTalent = 0
	
	if (AddonTable.classFilename == "MAGE") then
		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12) 
		talentRegen = (((base)/100) * (points * 5))
	elseif (AddonTable.classFilename == "DRUID") then
		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6) 
		talentRegen = ((base/100) * (points * 5))
	elseif (AddonTable.classFilename == "PRIEST") then
		local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 8) 
		talentRegen = ((base/100) * (points * 5))
	elseif (AddonTable.classFilename == "SHAMAN") then
		local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 10)
		totemTalent = ((base/100) * (points * 5))
	end 
 
	local magearmor = 0
	local evoc = 0  
	local felEnergy = 0 
	local siphonregen = 0
	local siphoncast = 0    
	local innerregen = 0
	local innercast = 0
	local bowisdom = 0
	local wismp5 = 0
	local springtotem = 0
	local tidetotem = 0
	local swregen = 0   
	local fishsoup = 0
	local fishsoupmp5 = 0   
	local sageFish = 0
	local warchief = 0
	local mageblood = 0
	local meleeHaste = 100	
	local rangedHaste = 100
	local castHaste = 100
	local epiphany = 0
	local drinkRegen = 0
	local totemicPower = 0
	local tierBonusShield = 0	
	AddonTable.arcanePower, AddonTable.sancAura, AddonTable.combustionCount, AddonTable.shadowFormDmg, AddonTable.dmfbuff, AddonTable.silithyst, AddonTable.vengeance = 0, 0, 0, 0, 0, 0, 0
	AddonTable.totalMP5, AddonTable.totalMP2, AddonTable.castingMP2, AddonTable.totalHaste, AddonTable.totalRangedHaste, AddonTable.buffCount = 0, 0, 0, 0, 0, 0

if (AddonTable.classFilename ~= "WARRIOR") and (AddonTable.classFilename ~= "ROGUE") then 
	
	for i = 1, 40 do
		local _, _, count, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
		if not spellId then break end
		
		if spellId then
			AddonTable.buffCount = i
		end
		
		AddonTable.buffCount = AddonTable.buffCount		

		if spellId == 29166 then 
			innerregen = ((base)*4)
			innercast = base    
		end
		
		if spellId == 16609 then 
			warchief = 10
			meleeHaste = (meleeHaste + 15)
		end 
		
		if spellId == 25941 then
			sageFish = 6
		end
		
		if spellId == 430 then
			drinkRegen = 16.8
		elseif spellId == 431 then
			drinkRegen = 41.50
		elseif spellId == 432 then
			drinkRegen = 69.6
		elseif spellId == 1133 then
			drinkRegen = 99.5
		elseif spellId == 1135 then
			drinkRegen = 132.8
		elseif spellId == 1137 then
			drinkRegen = 195.6
		elseif spellId == 22734 then
			drinkRegen = 280
		end		
		
		if spellId == 28824 then
			totemicPower = 28
		end		
		
		-- wisdom
		if spellId == 19742 then 
			bowisdom = (((10 * AddonTable.wisTalent) * 0.4) + (10 * 0.4))
			wismp5 = ((10 * AddonTable.wisTalent)  + 10)
		elseif spellId == 19850 then 
			bowisdom = (((15 * AddonTable.wisTalent) * 0.4) + (15 * 0.4))
			wismp5 = ((15 * AddonTable.wisTalent)  + 15)   
		elseif spellId == 19852 then
			bowisdom = (((20 * AddonTable.wisTalent) * 0.4) + (20 * 0.4))
			wismp5 = ((20 * AddonTable.wisTalent)  + 20)   
		elseif spellId == 19853 then
			bowisdom = (((25 * AddonTable.wisTalent) * 0.4) + (25 * 0.4))
			wismp5 = ((25 * AddonTable.wisTalent)  + 25)   
		elseif spellId == 19854 then 
			bowisdom = (((30 * AddonTable.wisTalent) * 0.4) + (30 * 0.4))
			wismp5 = ((30 * AddonTable.wisTalent)  + 30)   
		elseif spellId == 25290 then 
			bowisdom = (((33 * AddonTable.wisTalent) * 0.4) + (33 * 0.4))
			wismp5 = ((33 * AddonTable.wisTalent)  + 33)   
		elseif spellId == 25894 then 
			bowisdom = (((30 * AddonTable.wisTalent) * 0.4) + (30 * 0.4))
			wismp5 = ((30 * AddonTable.wisTalent)  + 30)   
		elseif spellId == 25918 then
			bowisdom = (((33 * AddonTable.wisTalent) * 0.4) + (33 * 0.4))
			wismp5 = ((33 * AddonTable.wisTalent)  + 33)	
		
		-- totems
		elseif spellId == 5677 then 
			if totemTalent > 0 then
				springtotem = 4 + totemTalent
			else
				springtotem = 4
			end 
		elseif spellId == 10491 then 
			if totemTalent > 0 then
				springtotem = 6 + totemTalent
			else
				springtotem = 6
			end 
		elseif spellId == 10493 then 
			if totemTalent > 0 then
				springtotem = 8 + totemTalent
			else
				springtotem = 8
			end 
		elseif spellId == 10494 then 
			if totemTalent > 0 then
				springtotem = 10 + totemTalent
			else
				springtotem = 10
			end 
		elseif spellId == 24853 then   
			springtotem = 27
		elseif spellId == 16191 then 
			tidetotem = 114 
		elseif spellId == 17355 then 
			tidetotem = 154 
		end
		
		if spellId == 18194 then 
			fishsoup = (8 * 0.4)
			fishsoupmp5 = 8 
		end
		
		if spellId == 15604 then 
			swregen = 60
		end 
		
		if spellId == 24363 then
			mageblood = 12
		end
		
		if spellId == 23768 then
			AddonTable.dmfbuff = 0.10
		end
		
		if spellId == 29534 then
			AddonTable.silithyst = 0.05
		end
		
		if spellId == 26635 then
			local health = UnitHealth("player")
			local max_health = UnitHealthMax("player")
			local percenthealth = ((health/max_health) * 100)
			if percenthealth > 40 then	
				rangedHaste = (rangedHaste + 10)
				meleeHaste = (meleeHaste + 10)
				AddonTable.castHaste = (AddonTable.castHaste + 10)		
			else 
				rangedHaste = (rangedHaste + 30)
				meleeHaste = (meleeHaste + 30)	
				AddonTable.castHaste = (AddonTable.castHaste + 30)		
			end
		end		

		if spellId == 16322 then 
			meleeHaste = (meleeHaste + 3)
		end		
		
		if spellId == 7396 then 
			meleeHaste = (meleeHaste + 10)
		end		
		
		if spellId == 16609 then 
			meleeHaste = (meleeHaste + 15)
		end		
		
		if spellId == 15167 then 
			meleeHaste = (meleeHaste + 65)
		end		
		
		if spellId == 21165 then 
			meleeHaste = (meleeHaste + 20)
		end				
			
	if (AddonTable.classFilename == "MAGE") then  
	
		if spellId == 28682 then
			AddonTable.combustionCount = count
			AddonTable.combustionCount = AddonTable.combustionCount * 10
		end
		
		if spellId == 6117 or spellId == 22782 or spellId == 22783 then 
			magearmor = ((base)*0.3)
		elseif spellId == 12051 then
			evoc = ((base)*15)
		end	
					
		if spellId == 23723 then
			AddonTable.castHaste = (AddonTable.castHaste + 33)
		end	
		
		if spellId == 12042 then
			AddonTable.arcanePower = 0.3
		end
		
	end
	
	if (AddonTable.classFilename == "WARLOCK") then
	
		local maxpower = UnitPowerMax("player" , mana)
		
		if spellId == 18792 then 
			felEnergy = ((maxpower * 0.02) / 2)
		end
		
		if spellId == 18371 then 
			siphonregen = ((base)*2)
			siphoncast = ((base)/2)     
		end    
		
		if spellId == 18791 then
			dsSuc = 0.15
		end
		
		if spellId == 18789 then
			dsImp = 0.15	
		end
	end 
	
	if (AddonTable.classFilename == "DRUID") then
	
		if shapeshitCheck() then
			if spellId == 16322 then
				meleeHaste = (meleeHaste + 3)
			end		
			
			if spellId == 7396 then
				meleeHaste = (meleeHaste + 10)
			end
			
			if spellId == 16609 then
				meleeHaste = (meleeHaste + 15)
			end	
			
			if spellId == 15167 then 
				meleeHaste = (meleeHaste + 65)
			end	
			
			if spellId == 13494 then 
				meleeHaste = (meleeHaste + 50)
			end
		end
	end

	if (AddonTable.classFilename == "HUNTER") then
		
		if spellId == 3045 then 
			rangedHaste = (rangedHaste + 40)
		end		
		
		if spellId == 6150 then 
			rangedHaste = (rangedHaste + 30)
		end	
		
		if spellId == 28866 then 
			rangedHaste = (rangedHaste + 20)
		end	

	end
	
	if (AddonTable.classFilename == "PALADIN") then
				
		if spellId == 20050 then
			AddonTable.vengeance = 0.03
		elseif spellId == 20052 then
			AddonTable.vengeance = 0.06
		elseif spellId == 20053 then
			AddonTable.vengeance = 0.09
		elseif spellId == 20054 then
			AddonTable.vengeance = 0.12
		elseif spellId == 20055 then
			AddonTable.vengeance = 0.15
		end	
		
		if spellId == 23733 then 
			meleeHaste = (meleeHaste + 25)
			AddonTable.castHaste = (AddonTable.castHaste + 33)
		end		
		
		if spellId == 28866 then 
			meleeHaste = (meleeHaste + 20)
		end	
		
		if spellId == 20218 then	
			AddonTable.sancAura = 0.1
		end
	end
	
	if (AddonTable.classFilename == "PRIEST") then
	
		if spellId == 15473 then
			AddonTable.shadowFormDmg = 0.15
		end
		
		if spellId == 28804 then
			epiphany = 24 
		end	
		
		if spellId == 20218 then
			AddonTable.sancAura = 0.1
		end
	end	
	
	if (AddonTable.classFilename == "SHAMAN") then
		
		if spellId == 28866 then 
			meleeHaste = (meleeHaste + 20)
		end	
		
		if tierPieces >= 8 then
			if spellId == 324 or spellId == 325 or spellId == 905 or spellId == 945 or spellId == 8134 or spellId == 10431 or spellId == 10432 then
				tierBonusShield = 15
			end
		end
		end	
		end
	end

	if (AddonTable.classFilename == "WARRIOR") then
	
	AddonTable.buffCount = AddonTable.buffCount + 1
	
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
			if not spellId then break end   
			
		if spellId then
			AddonTable.buffCount = i
		end
		
		AddonTable.buffCount = AddonTable.buffCount + 1
			
			if spellId == 12966 then 
				meleeHaste = (meleeHaste + 10)
			elseif spellId == 12967 then 
				meleeHaste = (meleeHaste + 15)
			elseif spellId == 12968 then 
				meleeHaste = (meleeHaste + 20)
			elseif spellId == 12969 then 
				meleeHaste = (meleeHaste + 25)	
			elseif spellId == 12970 then 
				meleeHaste = (meleeHaste + 30)
			end
			
			if spellId == 16322 then 
				meleeHaste = (meleeHaste + 3)
			end	
			
			if spellId == 7396 then 
				meleeHaste = (meleeHaste + 10)
			end	
			
			if spellId == 16609 then
				meleeHaste = (meleeHaste + 15)
			end	
			
			if spellId == 15167 then 
				meleeHaste = (meleeHaste + 65)
			end	
			
			if spellId == 21165 then 
				meleeHaste = (meleeHaste + 20)
			end	
			
			if spellId == 28866 then 
				meleeHaste = (meleeHaste + 20)
			end	
			
			if spellId == 26635 then 
				local health = UnitHealth("player")
				local max_health = UnitHealthMax("player")
				local percenthealth = ((health/max_health) * 100)
				if percenthealth > 40 then	
					rangedHaste = (rangedHaste + 10)
					meleeHaste = (meleeHaste + 10)
					AddonTable.castHaste = (AddonTable.castHaste + 10)		
				else 
					rangedHaste = (rangedHaste + 30)
					meleeHaste = (meleeHaste + 30)	
					AddonTable.castHaste = (AddonTable.castHaste + 30)		
				end
		end	
	end
		
	elseif (AddonTable.classFilename == "ROGUE") then
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
			if not spellId then break end
			
		if spellId then
			AddonTable.buffCount = i
		end
		
		AddonTable.buffCount = AddonTable.buffCount					
			
			if spellId == 5171 then 
				meleeHaste = (meleeHaste + 20)
			elseif spellId == 6774 then 
				meleeHaste = (meleeHaste + 30)
			end
			
			if spellId == 13877 then 
				meleeHaste = (meleeHaste + 20)
			end
			
			if spellId == 16322 then 
				meleeHaste = (meleeHaste + 3)
			end	
			
			if spellId == 7396 then 
				meleeHaste = (meleeHaste + 10)
			end	
			
			if spellId == 16609 then 
				meleeHaste = (meleeHaste + 15)
			end	
			
			if spellId == 15167 then 
				meleeHaste = (meleeHaste + 65)
			end	
			
			if spellId == 21165 then 
				meleeHaste = (meleeHaste + 20)
			end	
			
			if spellId == 28866 then 
				meleeHaste = (meleeHaste + 20)
			end	
			
			if spellId == 26635 then
				local health = UnitHealth("player")
				local max_health = UnitHealthMax("player")
				local percenthealth = ((health/max_health) * 100)
				if percenthealth > 40 then	
					rangedHaste = (rangedHaste + 10)
					meleeHaste = (meleeHaste + 10)
					AddonTable.castHaste = (AddonTable.castHaste + 10)		
				else 
					rangedHaste = (rangedHaste + 30)
					meleeHaste = (meleeHaste + 30)	
					AddonTable.castHaste = (AddonTable.castHaste + 30)		
				end
			end	
		end
	end

	local hasteHead = 0
	local hasteLegs = 0
	local hasteHands = 0
	local slotId = GetInventorySlotInfo("HandsSlot")
	local link = GetInventoryItemLink("player", slotId)

	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			-- print("enchantId", enchantId, enchantId == 931)
			if enchantId == 931 then
				hasteHands = hasteHands + 1
			end
		end
	end

	local slotId = GetInventorySlotInfo("HeadSlot")
	local link = GetInventoryItemLink("player", slotId)
	
	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			if enchantId == 2543 then
				hasteHands = hasteHands + 1
			end
		end
	end	
	
	local slotId = GetInventorySlotInfo("LegsSlot")
	local link = GetInventoryItemLink("player", slotId)
	
	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			if enchantId == 2543 then
				hasteHands = hasteHands + 1
			end
		end
	end		

	local oilEnchants = 0
	local oilRegen = 0
	
	if (AddonTable.classFilename ~= "WARRIOR") and (AddonTable.classFilename ~= "ROGUE") then
		local hasMainHandEnchant, _, _, mainHandEnchantID, _, _, _, _ = GetWeaponEnchantInfo()
		if hasMainHandEnchant then
			if mainHandEnchantID == 2624 then
				oilEnchants = 4
				oilRegen = oilEnchants * 0.4
			elseif mainHandEnchantID == 2625 then
				oilEnchants = 8
				oilRegen = oilEnchants * 0.4
			elseif mainHandEnchantID == 2629 then
				oilEnchants = 12
				oilRegen = oilEnchants * 0.4
			end
		end
	end 

	local tierBonus = 0
	if tierPieces >= 3 then
		tierBonus = ((base) * 0.15)
		springtotem = springtotem + (springtotem * 0.25)
	end
	
	
	local zgMP5 = 0 	
	if zgPieces >= 2 then
		zgMP5 = 4
	end         
	
	AddonTable.totalMP51 = mp5 + wismp5 + fishsoupmp5 + zgMP5 + oilEnchants + scourgeMp5 + totemicPower + warchief + mageblood + epiphany + sageFish
	AddonTable.totalMP2 = (base) + effectiveMR + innerregen + evoc + (scourgeMp5 * 0.4) + (totemicPower * 0.4) + (tierBonusShield * 0.4) + bowisdom + fishsoup + springtotem + tidetotem + siphonregen + swregen + felEnergy + oilRegen + drinkRegen + (warchief * 0.4) + (mageblood * 0.4) + (zgMP5 * 0.4) + (epiphany * 0.4) + (sageFish * 0.4)
	AddonTable.castingMP2 = effectiveMR + innercast + magearmor + (scourgeMp5 * 0.4) + (totemicPower * 0.4) + (tierBonusShield * 0.4) + talentRegen + bowisdom + fishsoup + springtotem + tidetotem + siphoncast + tierBonus + swregen + felEnergy + (warchief * 0.4) + (mageblood * 0.4) + oilRegen + (zgMP5 * 0.4) + (epiphany * 0.4) + (sageFish * 0.4) 
	AddonTable.totalMP5 = (AddonTable.totalMP2/2) * 5
	AddonTable.castingMP5 = (AddonTable.castingMP2/2) * 5
	AddonTable.totalHaste = meleeHaste + hasteHands
	AddonTable.totalRangedHaste = rangedHaste + pouchCounter + hasteHands
	
end 

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function AddonTable.OnEventFunc(event, ...)

	AddonTable.spirit = UnitStat("player", 5)

	if event == "CHARACTER_POINTS_CHANGED" then
	-----	
		AddonTable.talentScan()
		AddonTable.StatsCompute()
	-----	
	elseif event == "PLAYER_LEVEL_UP" then
	-----	
		AddonTable.playerLevel = UnitLevel("player")
	-----	
	elseif event == "PLAYER_TARGET_CHANGED" then
		local exists = UnitExists("target")
		local hostile = UnitCanAttack("player", "target")
	
		if hostile or not exists then
			AddonTable.SinLive()
		end
	-----	
	else
	-----
	
	-- SinLive
	local unit = ...
	if unit == "target" then
		AddonTable.SinLive()
	return
	end
	AddonTable.StatsCompute()
	
end -- end events
end -- end function