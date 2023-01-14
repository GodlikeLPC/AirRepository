local _, TipHooker, L, GetCreateTable, GetItemSums, IterateSpecData, IterateClassSpecs, 
    playerClass, classWeaponProficiencies, classArmorProficiencies, subclassSpells, SCORE_KEY_OFFSET, SLOT2_KEY_OFFSET, BEST_ONEHAND, BEST_OFFHAND,
    rewardShowReaction, questHideReaction, adornerParentShowReaction

local DGV = DugisGuideViewer
local GA = DGV:RegisterModule("GearAdvisor", "ItemStats")

if GA then
    GA.essential = true


	function GetDefaultUniqueInventorySlot(equipSlot)
		if equipSlot=="" then return end
		if equipSlot=="INVTYPE_ROBE" then
			return "INVTYPE_CHEST"
		elseif
			equipSlot=="INVTYPE_WEAPON" or equipSlot=="INVTYPE_RANGED" or equipSlot=="INVTYPE_2HWEAPON" or
			equipSlot=="INVTYPE_WEAPONMAINHAND" or equipSlot=="INVTYPE_RANGEDRIGHT"
		then
			return INVSLOT_MAINHAND
		elseif equipSlot=="INVTYPE_SHIELD" or equipSlot=="INVTYPE_WEAPONOFFHAND" or equipSlot=="INVTYPE_HOLDABLE" then
			return INVSLOT_OFFHAND
		end
		return equipSlot
	end

    --Gets spec and class key
    function GA:GetPlayerSpecKey()
        local _, classEn = UnitClass("player")
        local selectedCriterias = DugisGuideViewer.chardb[DGV_GAWINCRITERIACUSTOM].options

        for _, key in pairs(selectedCriterias or {}) do 
            if key ~= false then
                return classEn .. ":" .. key
            end
        end

        --getting the first available for current class
        for specKey in pairs(DGV.staticSpecs) do 
           local specClass = string.split(':', specKey)

           if specClass == classEn then
                return specKey
           end
        end

        return ""
    end

    function GA:Initialize()
        function GA:Load()
            L, GetCreateTable, GetItemSums, IterateSpecData, IterateClassSpecs, tPool = 
            DugisLocals, DGV.GetCreateTable, DGV.Modules.ItemStats.GetItemSums, DGV.Modules.GearAdvisorData.IterateSpecData,  DGV.Modules.GearAdvisorData.IterateClassSpecs, DGV.tPool
            local GetInventoryItemLink, EQUIPPED_FIRST, EQUIPPED_LAST, GetContainerNumSlots, NUM_BAG_SLOTS, GetNumBankSlots, GetContainerItemLink,
                BACKPACK_CONTAINER, QuestFrame, GetNumQuestRewards, GetNumQuestChoices, GetNumQuestLogRewards, QuestInfoFrame = 
                GetInventoryItemLink, EQUIPPED_FIRST, EQUIPPED_LAST, GetContainerNumSlots, NUM_BAG_SLOTS, GetNumBankSlots, GetContainerItemLink,
                BACKPACK_CONTAINER, QuestFrame, GetNumQuestRewards, GetNumQuestChoices, GetNumQuestLogRewards, QuestInfoFrame

            SCORE_KEY_OFFSET = 100
            SLOT2_KEY_OFFSET = 200
            BEST_ONEHAND = 25
            BEST_OFFHAND = 26
            playerClass = select(2,UnitClass("player"))
            canDualWield = playerClass=="ROGUE" or (playerClass=="WARRIOR" and IsPlayerSpell(674)) or (playerClass=="HUNTER" and IsPlayerSpell(674)) or (playerClass=="DEATHKNIGHT" and IsPlayerSpell(674))
            classWeaponProficiencies = GetCreateTable()
            classWeaponProficiencies[LE_ITEM_WEAPON_AXE1H] = playerClass=="PALADIN" or playerClass=="SHAMAN" or playerClass=="WARRIOR" or playerClass=="ROGUE" or playerClass=="HUNTER" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_AXE2H] = playerClass=="PALADIN" or playerClass=="SHAMAN" or playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_BOWS] = playerClass=="HUNTER"
            classWeaponProficiencies[LE_ITEM_WEAPON_GUNS] = playerClass=="HUNTER"
            classWeaponProficiencies[LE_ITEM_WEAPON_CROSSBOW] = playerClass=="HUNTER"
            classWeaponProficiencies[LE_ITEM_WEAPON_MACE1H] = playerClass=="ROGUE" or playerClass=="PRIEST" or playerClass=="SHAMAN" or playerClass=="DRUID" or playerClass=="PALADIN"or playerClass=="WARRIOR" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_MACE2H] = playerClass=="DRUID" or playerClass=="PALADIN" or playerClass=="WARRIOR" or playerClass=="SHAMAN" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_POLEARM] = playerClass=="PALADIN"or playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_SWORD1H] = playerClass=="PALADIN"or playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="MAGE" or playerClass=="ROGUE" or playerClass=="WARLOCK" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_SWORD2H] = playerClass=="PALADIN"or playerClass=="WARRIOR" or playerClass=="DEATHKNIGHT"
            classWeaponProficiencies[LE_ITEM_WEAPON_STAFF] = playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="MAGE" or playerClass=="WARLOCK" or playerClass=="SHAMAN" or playerClass=="DRUID" or playerClass=="PRIEST"
            classWeaponProficiencies[LE_ITEM_WEAPON_UNARMED] = playerClass=="DRUID" or playerClass=="HUNTER" or playerClass=="ROGUE" or playerClass=="WARRIOR" or playerClass=="SHAMAN"
            classWeaponProficiencies[LE_ITEM_WEAPON_DAGGER] = playerClass=="ROGUE" or playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="MAGE" or playerClass=="WARLOCK" or playerClass=="SHAMAN" or playerClass=="DRUID" or playerClass=="PRIEST"
            classWeaponProficiencies[LE_ITEM_WEAPON_THROWN] = playerClass=="ROGUE" or playerClass=="WARRIOR" or playerClass=="HUNTER"
            classWeaponProficiencies[LE_ITEM_WEAPON_WAND] = playerClass=="PRIEST" or playerClass=="MAGE" or playerClass=="WARLOCK"
            classWeaponProficiencies[LE_ITEM_WEAPON_FISHINGPOLE] = true

            classArmorProficiencies = GetCreateTable()
            classArmorProficiencies[LE_ITEM_ARMOR_GENERIC] = true
            classArmorProficiencies[LE_ITEM_ARMOR_CLOTH] = true
            classArmorProficiencies[LE_ITEM_ARMOR_LEATHER] = playerClass=="ROGUE" or playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="SHAMAN" or playerClass=="DRUID" or playerClass=="PALADIN"
            classArmorProficiencies[LE_ITEM_ARMOR_MAIL] = playerClass=="WARRIOR" or playerClass=="HUNTER" or playerClass=="SHAMAN" or playerClass=="PALADIN" or playerClass=="DEATHKNIGHT"
            classArmorProficiencies[LE_ITEM_ARMOR_PLATE] = playerClass=="WARRIOR" or playerClass=="PALADIN" or playerClass=="DEATHKNIGHT"
            classArmorProficiencies[LE_ITEM_ARMOR_SHIELD] = playerClass=="PALADIN" or playerClass=="SHAMAN" or playerClass=="WARRIOR"

            subclassSpells = GetCreateTable()
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_SWORD1H)] = 201 --One-Handed Swords
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_MACE2H)] = 199 --Two-Handed Maces
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_AXE2H)] = 197 --Two-Handed Axes
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_POLEARM)] = 200 --Polearms
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_BOWS)] = 264 --Bows
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_SWORD2H)] = 202 --Two-Handed Swords
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_STAFF)] = 227 --Staves
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_GUNS)] = 266 --Guns
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_DAGGER)] = 1180 --Daggers
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_MACE1H)] = 198 --One-Handed Maces
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_AXE1H)] = 196 --One-Handed Axes
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_UNARMED)] = 15590 --Fist Weapons
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_CROSSBOW)] = 5011 --Crossbows
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_THROWN)] = 2567 --Thrown
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_FISHINGPOLE)] = 7620 --Apprentice Fishing
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_PLATE)] = 750 --Plate Mail
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_MAIL)] = 8737 --Mail
            subclassSpells[GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_LEATHER)] = 9077 --Leather

            local function CalculateScore(itemLink, specKey)
                local itemSums = GetCreateTable():BindToAutoroutineLifetime(tPool)
                local _, proficiencyMet = GetItemSums(itemLink, itemSums)
                local score = 0
                for statKey, statTable in IterateSpecData, specKey do
                    local weightedStatScore = (itemSums[statKey] or 0) * (statTable[1] or 0) --stat value * first weight
                    if weightedStatScore<0 then 
                        score = weightedStatScore
                        break;
                    end
                    score = score + weightedStatScore
                end
                itemSums:Pool()
                return score, proficiencyMet
            end

            GA.CalculateScore = CalculateScore

            if not DugisCharacterCache.CalculateScore_cache_v12 then
                DugisCharacterCache.CalculateScore_cache_v12 = {}
            end

            local function InventoryItemIterator(invariant, slot)
                if not slot then slot = EQUIPPED_FIRST
                else slot = slot + 1 end
                if slot<=EQUIPPED_LAST then
                    local itemLink = GetInventoryItemLink("player", slot)
                    return slot, itemLink
                end
            end
            GA.InventoryItemIterator = InventoryItemIterator

            local function BankItemIterator(invariant, control)
                local slot = invariant.slot
                local bag = invariant.bag
                if not BankFrame or not BankFrame:IsShown() then return end
                if not slot then slot = 1
                else slot = slot + 1 end
                if not bag then bag = -1 end
                if slot > GetContainerNumSlots(bag) then
                    if bag == -1 then bag = NUM_BAG_SLOTS + 1
                    else bag = bag + 1 end
                    if bag > NUM_BAG_SLOTS+GetNumBankSlots() then
                        invariant.slot = nil
                        invariant.bag = nil
                        return 
                    end
                    slot = 1
                end
                invariant.slot = slot
                invariant.bag = bag
                local itemLink = GetContainerItemLink(bag, slot)
                return true, itemLink
            end
            GA.BankItemIterator = BankItemIterator

            local function BagItemIterator(invariant)
                local slot = invariant.slot
                local bag = invariant.bag
                if not slot then slot = 1
                else slot = slot + 1 end
                if not bag then bag = BACKPACK_CONTAINER end
                if slot > GetContainerNumSlots(bag) then
                    bag = bag + 1
                    if bag > NUM_BAG_SLOTS then
                        invariant.slot = nil
                        invariant.bag = nil
                        return
                    end
                    slot = 1
                end
                invariant.slot = slot
                invariant.bag = bag
                local itemLink = GetContainerItemLink(bag, slot)
                return slot, itemLink
            end
            GA.BagItemIterator = BagItemIterator

            local function QuestRewardIterator(invariant)
                if not QuestFrame:IsShown() then return end
                local itemType = invariant.itemType
                local numFunc = invariant.numFunc
                local slot = invariant.slot
                if not itemType then
                    itemType = "reward"
                    func = GetNumQuestRewards
                end
                if not slot then slot = 1
                else slot = slot + 1 end
                while slot > func() do
                    slot = 1
                    if numFunc == GetNumQuestRewards then
                        numFunc = GetNumQuestChoices
                        itemType = "choice"
                    elseif numFunc == GetNumQuestChoices then
                        numFunc = GetNumQuestLogRewards
                        itemType = "reward"
                    elseif numFunc == GetNumQuestLogRewards then
                        numFunc = GetNumQuestLogChoices
                        itemType = "choice"
                    else
                        invariant.itemType = nil
                        invariant.numFunc = nil
                        invariant.slot = nil
                        return 
                    end
                end
                local itemLink, itemName
                if QuestInfoFrame.questLog then
                    itemLink = GetQuestLogItemLink(itemType, slot)
                    if itemType=="choice" then
                        itemName = GetQuestLogChoiceInfo(slot)
                    else
                        itemName = GetQuestLogRewardInfo(slot)
                    end
                else
                    itemLink = GetQuestItemLink(itemType, slot)
                    itemName = GetQuestItemInfo(itemType, slot)
                end
                local itemFrame = _G["QuestInfoItem"..slot]
                if
                    itemLink
                    and itemFrame
                    and itemFrame:IsShown()
                    and itemFrame.type==itemType
                    and itemFrame.name:GetText()==itemName
                then
                    invariant.itemType = itemType
                    invariant.numFunc = numFunc
                    invariant.slot = slot
                    return itemLink
                end
            end

            local function LootRollItemIterator(invariant, frameIndex)
                if not frameIndex then frameIndex = 1
                else frameIndex = frameIndex + 1 end
                if frameIndex<=NUM_GROUP_LOOT_FRAMES then
                    local lootFrame =  _G["GroupLootFrame"..frameIndex]
                    if lootFrame and lootFrame:IsShown() then
                        return frameIndex, GetLootRollItemLink(lootFrame.rollID)
                    end
                end
            end

            local function MerchantItemIterator(invariant, slot)
                if not MerchantFrame:IsShown() then return end
                if not slot then slot = 1
                else slot = slot + 1 end
                local itemLink = GetMerchantItemLink(slot)
                if itemLink then
                    return slot, itemLink
                end
            end

            local function LootItemIterator(invariant, slot)
                if not LootFrame:IsShown() then return end
                if not slot then slot = 1
                else slot = slot + 1 end
                if slot > GetNumLootItems() then return end
                return slot, GetLootSlotLink(slot)
            end

            local function GetValidSlots(link)
                local equipSlot = select(4,GetItemInfoInstant(link))
                if equipSlot then
                    if equipSlot=="INVTYPE_HEAD" then
                        return INVSLOT_HEAD --1
                    elseif equipSlot=="INVTYPE_NECK" then
                        return INVSLOT_NECK --2
                    elseif equipSlot=="INVTYPE_SHOULDER" then
                        return INVSLOT_SHOULDER --3
                    elseif equipSlot=="INVTYPE_CHEST" or equipSlot=="INVTYPE_ROBE" then
                        return INVSLOT_CHEST --5
                    elseif equipSlot=="INVTYPE_WAIST" then
                        return INVSLOT_WAIST --6
                    elseif equipSlot=="INVTYPE_LEGS" then
                        return INVSLOT_LEGS --7
                    elseif equipSlot=="INVTYPE_FEET" then
                        return INVSLOT_FEET --8
                    elseif equipSlot=="INVTYPE_WRIST" then
                        return INVSLOT_WRIST --9
                    elseif equipSlot=="INVTYPE_HAND" then
                        return INVSLOT_HAND --10
                    elseif equipSlot=="INVTYPE_CLOAK" then
                        return INVSLOT_BACK --15
                    elseif equipSlot=="INVTYPE_FINGER" then
                        return INVSLOT_FINGER1, INVSLOT_FINGER2 --11,12
                    elseif equipSlot=="INVTYPE_HOLDABLE" or equipSlot=="INVTYPE_SHIELD" or (equipSlot=="INVTYPE_WEAPONOFFHAND" and canDualWield) then
                        return INVSLOT_OFFHAND --17
                    elseif equipSlot=="INVTYPE_WEAPON" then
                        return INVSLOT_MAINHAND, canDualWield and INVSLOT_OFFHAND --16,17
                    elseif equipSlot=="INVTYPE_WEAPONMAINHAND" or equipSlot=="INVTYPE_2HWEAPON" then
                        return INVSLOT_MAINHAND --16
                    elseif equipSlot=="INVTYPE_RANGED" or equipSlot=="INVTYPE_RANGEDRIGHT" then
                        return INVSLOT_RANGED --18
                    end
                end
            end

            local function IsProficiencyLearned(link)
                local spellId = subclassSpells[select(3,GetItemInfoInstant(link))]
                return not spellId or IsPlayerSpell(spellId)
            end

            local function ValidateSubclass(link, enforceEquippable)
                local itemSubclassString, _, _, itemClass, itemSubclass = select(3,GetItemInfoInstant(link))
                if itemClass==LE_ITEM_CLASS_WEAPON then
                    return classWeaponProficiencies[itemSubclass] 
                        and (not enforceEquippable or IsProficiencyLearned(link))
                elseif itemClass==LE_ITEM_CLASS_ARMOR then
                    if not enforceEquippable 
                        and itemSubclass==LE_ITEM_ARMOR_MAIL 
                        and (playerClass=="HUNTER" or playerClass=="SHAMAN") 
                        and UnitLevel("player") < 38 
                    then  
                        return --don't advise mail until the player is within two levels of training it
                    end
                    return classArmorProficiencies[itemSubclass] 
                        and (not enforceEquippable or IsProficiencyLearned(link))
                end
            end

            local function AppraiseItemSlots(standings, link, specKey, enforceEquippable, slotOne, slotTwo)
                if not slotOne then return end
                local score, proficiencyMet = CalculateScore(link, specKey)
                if enforceEquippable and not proficiencyMet then return end
                return score, slotOne, slotTwo and score, slotTwo
            end

            local function ItemIsBanned(itemLink)
                return DGV.chardb.GA_Blacklist and DGV.chardb.GA_Blacklist[DGV:GetItemIdFromLink(itemLink)]
            end
            
            
            
            
    --{[itemId1] = {[class1]=true, [class2]=true}, [itemId2] = {[class3]=true, [class4]=true}}
    GA.itemId2allowedClasses = {}
    
    --{[itemId1] = {[spec1]=true, [spec2]=true}, [itemId2] = {[spec3]=true, [spec4]=true}}
    GA.itemId2allowedSpecs = {}
        
        
    --------------------------------------

    local function canBePassedItem(itemLink)
        local itemId = DGV:GetItemIdFromLink(itemLink)
        if GA.itemId2allowedClasses[itemId] then
            if not GA.itemId2allowedClasses[itemId][GA.playerClass] then
                return false
            end
        end
        
        if GA.itemId2allowedSpecs[itemId] then
            if not GA.itemId2allowedSpecs[itemId][GA.playerSpec] then
                return false
            end
        end        
        
        return true
    end

    local function ItemWasFirst(control, link)
        if control.first==link then
            control.first = nil
            return true
        end
    end

            
            	--GetContainerItemLink(container, slot)
	--BACKPACK_CONTAINER: Backpack (0)
	--1 through GetNumBankSlots(): Bag slots (as presented in the default UI, numbered right to left)
	--GetInventoryItemLink("unit", slot) EQUIPPED_FIRST, EQUIPPED_LAST
	--GetNumQuestRewards
	--GetNumQuestChoices
	--GetQuestLogItemLink("itemType", index)
	--GetQuestItemLink("itemType", index)
	--name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemID) or GetItemInfo("itemName") or GetItemInfo("itemLink")
	local ITEM_ITERATOR_SKIP_EQUIPPED = 1
	local ITEM_ITERATOR_SKIP_REWARDS = 2
	local ITEM_ITERATOR_SKIP_LOOT_ROLL = 4
	local ITEM_ITERATOR_SKIP_ENCOUNTER_JOURNAL = 8
	local ITEM_ITERATOR_SKIP_VENDOR = 16
	local ITEM_ITERATOR_SKIP_LOOT = 32
	local ITEM_ITERATOR_SKIP_ALL_EXTERNAL = bit.bor(ITEM_ITERATOR_SKIP_REWARDS, ITEM_ITERATOR_SKIP_LOOT_ROLL, ITEM_ITERATOR_SKIP_ENCOUNTER_JOURNAL, ITEM_ITERATOR_SKIP_VENDOR, ITEM_ITERATOR_SKIP_LOOT)
	local function ItemIterator(invariant, control)
		if not control then
			if type(invariant)=="table" then
				control = invariant
				control:BindToAutoroutineLifetime(tPool)
				if control.first then
					return control, control.first
				end
			else
				control = GetCreateTable():BindToAutoroutineLifetime(tPool)
				control.skip = invariant
			end
		end
		if not control.func then
			control.func = GetInventoryItemLink
		end
		local skip = control.skip
		local skipEquipped = skip and bit.band(skip, ITEM_ITERATOR_SKIP_EQUIPPED)==ITEM_ITERATOR_SKIP_EQUIPPED
		local skipRewards = skip and bit.band(skip, ITEM_ITERATOR_SKIP_REWARDS)==ITEM_ITERATOR_SKIP_REWARDS
		local skipLootRoll = skip and bit.band(skip, ITEM_ITERATOR_SKIP_LOOT_ROLL)==ITEM_ITERATOR_SKIP_LOOT_ROLL
		local skipEncounterJournal = skip and bit.band(skip, ITEM_ITERATOR_SKIP_ENCOUNTER_JOURNAL)==ITEM_ITERATOR_SKIP_ENCOUNTER_JOURNAL
		local skipVendor = skip and bit.band(skip, ITEM_ITERATOR_SKIP_VENDOR)==ITEM_ITERATOR_SKIP_VENDOR
		local skipLoot = skip and bit.band(skip, ITEM_ITERATOR_SKIP_LOOT)==ITEM_ITERATOR_SKIP_LOOT
		while true do
			local func = control.func
			local slot = control.slot
			if func==GetInventoryItemLink then
				if not slot then control.slot = skipEquipped and BANK_CONTAINER_INVENTORY_OFFSET+1 or EQUIPPED_FIRST
				else control.slot = slot + 1 end
				if control.slot==EQUIPPED_LAST+1 then control.slot = BANK_CONTAINER_INVENTORY_OFFSET+1 end
				slot = control.slot
				if slot<=BANK_CONTAINER_INVENTORY_OFFSET+NUM_BANKGENERIC_SLOTS then
					local itemLink = GetInventoryItemLink("player", slot)
					if itemLink and select(9, GetItemInfo(itemLink))~="" and not ItemWasFirst(control, itemLink) then
						control.player = slot<=EQUIPPED_LAST
						control.bank = not control.player
						control.bags = false
                        if canBePassedItem(itemLink) then
                            return control, itemLink
                        end
					end
				else
					control.player = nil
					control.bank = nil
					control.bags = nil
					control.func = GetContainerItemLink
					control.slot = nil
				end
			elseif func==GetContainerItemLink then
				if not slot then slot = 0 end
				slot = slot + 1
				control.slot = slot
				if not control.bag then control.bag = BACKPACK_CONTAINER end
				if slot<=GetContainerNumSlots(control.bag) then
					local itemLink = GetContainerItemLink(control.bag, slot)
					control.player = control.bag<=NUM_BAG_SLOTS
					control.bank = not control.player
					control.bags = true
					if itemLink then
						local itemName, _, _, _, _, _, _, _, itemEquipSlot = GetItemInfo(itemLink)
						if
							itemName
							and itemEquipSlot
							and itemEquipSlot~=""
							and not ItemWasFirst(control, itemLink)
						then
                            if canBePassedItem(itemLink) then
                                return control, itemLink
                            end
						end
					end
				else
					control.bag = control.bag + 1
					if control.bag>NUM_BAG_SLOTS+GetNumBankSlots() then
						control.bag = nil
						control.player = nil
						control.bank = nil
						control.bags = nil
						control.func = GetNumQuestRewards
						control.itemType = "reward"
					end
					control.slot = nil
				end
			elseif control.itemType then
				if
					not skipRewards and
					(QuestFrame:IsShown() or
					--QuestLogPopupDetailFrame:IsShown() or
					(WorldMapFrame:IsShown() and QuestMapFrame and QuestMapFrame.DetailsFrame and QuestMapFrame.DetailsFrame:IsShown())) then
					if not slot then slot = 0 end
					slot = slot + 1
					control.slot = slot
					if slot<=func() then
						local itemLink, itemName
						if QuestInfoFrame.questLog then
							itemLink = GetQuestLogItemLink(control.itemType, slot)
							if control.itemType=="choice" then
								itemName = GetQuestLogChoiceInfo(slot)
							else
								itemName = GetQuestLogRewardInfo(slot)
							end
						else
							itemLink = GetQuestItemLink(control.itemType, slot)
							itemName = GetQuestItemInfo(control.itemType, slot)
						end
						local itemFrame = _G["QuestInfoItem"..control.slot]
						if
							itemLink
							and itemFrame
							and itemFrame:IsShown()
							and itemFrame.type==control.itemType
							and itemFrame.name:GetText()==itemName
							and not ItemWasFirst(control, itemLink)
						then
                            if canBePassedItem(itemLink) then
                                return control, itemLink
                            end
						end
					elseif func == GetNumQuestRewards then
						control.func = GetNumQuestChoices
						control.itemType = "choice"
						control.slot = nil
					elseif func == GetNumQuestChoices then
						control.func = GetNumQuestLogRewards
						control.itemType = "reward"
						control.slot = nil
					elseif func == GetNumQuestLogRewards then
						control.func = GetNumQuestLogChoices
						control.itemType = "choice"
						control.slot = nil
					else
						control.func = GetLootRollItemLink
						control.slot = nil
						control.itemType = nil
					end
				else
					control.func = GetLootRollItemLink
					control.slot = nil
					control.itemType = nil
				end
			elseif func==GetLootRollItemLink then
				if not slot then slot = 0 end
				slot = (not skipLootRoll) and slot + 1
				control.slot = slot
				if slot and slot<=NUM_GROUP_LOOT_FRAMES and GroupLootFrame1 and GroupLootFrame1:IsShown() then
					local lootFrame =  _G["GroupLootFrame"..slot]
					if lootFrame and lootFrame:IsShown() then
						local itemLink = func(lootFrame.rollID)
						if itemLink and not ItemWasFirst(control, itemLink) then
                            local control_, link_ = control, func(lootFrame.rollID)
                            if canBePassedItem(link_) then
                                return control_, link_
                            end
						end
					end
				end
				control.func = EJ_GetLootInfoByIndex
				control.slot = nil
			elseif func==EJ_GetLootInfoByIndex then
				if not skipEncounterJournal and
					EncounterJournal and
					EncounterJournal:IsShown() and
					EncounterJournal.encounter.info.lootScroll:IsShown()
				then
					if not slot then slot = 0 end
					slot = slot + 1
					control.slot = slot
					local numLoot = EJ_GetNumLoot()
					if slot<=numLoot then
						local name, icon, slot, armorType, itemID, link, encounterID = func(slot)
						if link and not ItemWasFirst(control, link) then
                            if canBePassedItem(link) then
                                return control, link
                            end
						end
					end
				end
				control.func = GetMerchantItemLink
				control.slot = nil
			elseif func==GetMerchantItemLink then
				if
					not skipVendor and
					MerchantFrame:IsShown()
				then
					if not slot then slot = 0 end
					slot = slot + 1
					control.slot = slot
					local link = func(slot)
					if link and not ItemWasFirst(control, link) then
                        if canBePassedItem(link) then
                            return control, link
                        end
					end
				end
				control.func = GetLootSlotLink
				control.slot = nil
			elseif func==GetLootSlotLink then
				if not slot then slot = 0 end

				slot = slot + 1
				control.slot = slot
				if
					not skipLoot and
					LootFrame:IsShown()
				then
					local link = func(slot)
					if link and not ItemWasFirst(control, link) then
						return control, link
					end
				end
				if slot > GetNumLootItems() then
					control:Pool()
					return
				end
			else
				control:Pool()
				return
			end
		end
	end

    GeadAdvisorItemIterator = ItemIterator

            --------------------------------------

            local function AppraiseItem(standings, link, specKey, enforceEquippable)
                if not link or ItemIsBanned(link) then return end

                local itemMinLevel = nil
                if enforceEquippable then
                    itemMinLevel = select(5,GetItemInfo(link))
                end        
                if (enforceEquippable and ((not itemMinLevel) or itemMinLevel > UnitLevel("player"))) or not ValidateSubclass(link, enforceEquippable) then return end
                return AppraiseItemSlots(standings, link, specKey, enforceEquippable, GetValidSlots(link))
            end

            local function ItemIsTwoHanded(link)
                if not link then return end
                return select(4,GetItemInfoInstant(link))=="INVTYPE_2HWEAPON"
            end

            local function GetCompositeScores(standings, link, score, slot)
                local compositeScore, existingCompositeScore = score, standings[slot+SCORE_KEY_OFFSET] or 0
                if slot==INVSLOT_MAINHAND then
                    if not ItemIsTwoHanded(link) then
                        compositeScore = compositeScore + (standings[BEST_OFFHAND+SCORE_KEY_OFFSET] or 0)
                    end
                    if not ItemIsTwoHanded(standings[slot]) then
                        existingCompositeScore = existingCompositeScore + (standings[BEST_OFFHAND+SCORE_KEY_OFFSET] or 0)
                    end
                elseif slot==INVSLOT_OFFHAND then
                    compositeScore = compositeScore + (standings[BEST_ONEHAND+SCORE_KEY_OFFSET] or 0)
                    existingCompositeScore = existingCompositeScore + (standings[BEST_ONEHAND+SCORE_KEY_OFFSET] or 0)
                    if ItemIsTwoHanded(standings[INVSLOT_MAINHAND]) then
                        existingCompositeScore = standings[INVSLOT_MAINHAND+SCORE_KEY_OFFSET]
                    end
                end
                return compositeScore, existingCompositeScore
            end

            local function FilterBestItemSlot(standings, link, score, slot)
                local scoreIndex = slot+SCORE_KEY_OFFSET
                local compositeScore, existingCompositeScore = GetCompositeScores(standings, link, score, slot)
                if not existingCompositeScore or existingCompositeScore < compositeScore then
                    return score, slot, standings[slot], existingScore
                end
            end

            local function FilterBestItem(standings, link, score, slot, slotTwoScore, slotTwo)
                if not score then return end
                local score, slot, existingItem, existingScore = FilterBestItemSlot(standings, link, score, slot)
                if score then
                    return score, slot, existingItem, existingScore, slotTwo
                elseif slotTwoScore then
                    return FilterBestItemSlot(standings, link, slotTwoScore, slotTwo)
                end
            end

            local function MergeToSlot(standings, itemLink, score, slot)
                local score, slot, existingItem, existingScore = FilterBestItem(standings, itemLink, score, slot)
                if score then
                    standings[slot] = itemLink
                    standings[slot+SCORE_KEY_OFFSET] = score
                    return score, slot, existingItem, existingScore, slotTwo
                end
            end

            local function MergeToSlots(standings, itemLink, score, slot, slotTwoScore, slotTwo)
                if not score then return end
                if slot == INVSLOT_MAINHAND or slot==INVSLOT_OFFHAND then
                    if ItemIsTwoHanded(itemLink) then
                        standings[INVSLOT_OFFHAND] = nil
                    elseif slot==INVSLOT_MAINHAND then
                        MergeToSlot(standings, itemLink, score, BEST_ONEHAND)
                    elseif slot==INVSLOT_OFFHAND then
                        MergeToSlot(standings, itemLink, score, BEST_OFFHAND)
                    end
                end
                local score, slot, existingItem, existingScore, slotTwo = FilterBestItem(standings, itemLink, score, slot, slotTwoScore, slotTwo)
                if score then
                    standings[slot] = itemLink
                    standings[slot+SCORE_KEY_OFFSET] = score
                    if existingScore and slot == INVSLOT_FINGER1 then
                        standings[INVSLOT_FINGER2] = existingItem
                        standings[INVSLOT_FINGER2+SCORE_KEY_OFFSET] = existingScore
                    elseif existingScore and slot == INVSLOT_MAINHAND  then
                        local validSlotTwoKeyIndex = slot+SLOT2_KEY_OFFSET
                        local existingSlotTwo = standings[validSlotTwoKeyIndex]
                        if existingSlotTwo then
                            standings[INVSLOT_OFFHAND] = existingItem
                            standings[INVSLOT_OFFHAND+SCORE_KEY_OFFSET] = existingScore
                        end
                        standings[validSlotTwoKeyIndex] = slotTwo
                    end
                end
            end

            local function MergeStandings(standings, link, specKey, enforceEquippable)
                MergeToSlots(standings, link, FilterBestItem(standings, link, AppraiseItem(standings, link, specKey, enforceEquippable)))
            end

            local function ScoreCarriedEquipment(specKey, standings, enforceEquippable)
                for _,itemLink in InventoryItemIterator do
                    MergeStandings(standings, itemLink, specKey, enforceEquippable)
                end
                local invariant = GetCreateTable():BindToAutoroutineLifetime(tPool)
                for _,itemLink in BagItemIterator, invariant do
                    MergeStandings(standings, itemLink, specKey, enforceEquippable)
                end
                invariant:Pool()
            end
            GA.ScoreCarriedEquipment = ScoreCarriedEquipment

            local function ScoreBankEquipment(specKey, standings, enforceEquippable)
                local invariant = GetCreateTable():BindToAutoroutineLifetime(tPool)
                for _,itemLink in BankItemIterator, invariant do
                    MergeStandings(standings, itemLink, specKey, enforceEquippable)
                end
                invariant:Pool()
            end
            GA.ScoreBankEquipment = ScoreBankEquipment

            local function SelectItemScoreAndSlot(standings, slot)
                if not slot then return end
                return standings[slot], standings[slot+SCORE_KEY_OFFSET], slot
            end

            local function GetTrainingNag(link)
                if not IsProficiencyLearned(link) then
                    return L[" |cffff0000(Requires training in %s)|r"]:format(select(3,GetItemInfoInstant(link)))
                end
                return ""
            end

            local function AddEquipmentTooltipLines(specKey, specName, tooltipLines, itemLink, carriedStandings)
                local slotOne, slotTwo = GetValidSlots(itemLink)
                if not slotOne then return end
                local color = RAID_CLASS_COLORS[select(2,UnitClass("player"))].colorStr

                local carriedItem, carriedItemScore, carriedItemSlot = SelectItemScoreAndSlot(carriedStandings, slotOne)
                local carriedItem2, carriedItemScore2, carriedItemSlot2 = SelectItemScoreAndSlot(carriedStandings, slotTwo)
                local item, itemScore, altItem, altItemScore, itemSlot
                local standings = carriedStandings
                if carriedItem==itemLink then
                    item, itemScore, altItem, altItemScore = carriedItem, carriedItemScore, carriedItem2, carriedItemScore2
                elseif carriedItem2==itemLink then
                    item, itemScore, altItem, altItemScore = carriedItem2, carriedItemScore2, carriedItem, carriedItemScore
                else
                    MergeStandings(standings, itemLink, specKey, false)
                    item, itemScore, itemSlot = SelectItemScoreAndSlot(standings, slotOne)
                    altItem, altItemScore = SelectItemScoreAndSlot(standings, slotTwo)
                    if item ~= itemLink then
                        item, itemScore, itemSlot = SelectItemScoreAndSlot(standings, slotTwo)
                        altItem, altItemScore = SelectItemScoreAndSlot(standings, slotOne)
                    end
                end
                if item == itemLink then
                    local trainingNag = GetTrainingNag(itemLink)
                    if altItem then
                        table.insert(tooltipLines, L["Best in slot with %s - |c%s%s|r"]:format(altItem, color, specName)..trainingNag)
                    elseif item then
                        table.insert(tooltipLines, L["Best in slot - |c%s%s|r"]:format(color, specName)..trainingNag)
                    end

                    local upgradedItem, upgradeValue, upgradedAltItem
                    if carriedItem and carriedItemScore and itemSlot and itemSlot==slotOne then
                        upgradedItem, upgradeValue, upgradedAltItem = carriedItem, (1-carriedItemScore/itemScore)*100, carriedItem2
                    elseif carriedItemScore2 and carriedItem2 and itemSlot and itemSlot==slotTwo then
                        upgradedItem, upgradeValue, upgradedAltItem = carriedItem2, (1-carriedItemScore2/itemScore)*100, carriedItem
                    end
                    
                    if upgradedAltItem and upgradedItem and upgradeValue > 0 then
                        table.insert(tooltipLines, L["|TInterface\\AddOns\\DugisGuideViewerZ\\Artwork\\UpgradeArrow:0|t|cff1eff00+%d%%|r upgrade over %s with %s"]:format(upgradeValue, upgradedItem, upgradedAltItem))
                    elseif upgradedItem and upgradeValue > 0 then

                        table.insert(tooltipLines, L["|TInterface\\AddOns\\DugisGuideViewerZ\\Artwork\\UpgradeArrow:0|t|cff1eff00+%d%%|r upgrade over %s"]:format(upgradeValue, upgradedItem))
                    end
                end
            end

            local WIN_CRITERIA_COIN = "Highest Vendor Price"
            local function IterateWinCriteria(invariant, control)
                local specName
                if control == WIN_CRITERIA_COIN then return end
                control, specName = IterateClassSpecs(invariant, control)
                if not control then
                    return WIN_CRITERIA_COIN, WIN_CRITERIA_COIN
                end
                return control, specName
            end
            GA.IterateWinCriteria = IterateWinCriteria

            function IteratePrioritizedWinCriteria(invariant, control)
                local options = DGV.chardb[DGV_GAWINCRITERIACUSTOM].options
                if not options then
                    options = {}
                    for _, specName in IterateWinCriteria do
                        tinsert(options, specName)
                    end
                    DGV.chardb[DGV_GAWINCRITERIACUSTOM].options = options
                end
                if not control then control = 1
                elseif control >= #options then return
                else control = control + 1 end
                local option =  options[control]
                for specKey, specName in IterateWinCriteria do
                    if option == specName then
                        return control, specKey, specName
                    end
                end
            end
            GA.IteratePrioritizedWinCriteria = IteratePrioritizedWinCriteria

            local tooltipLines
            local function ScoreTooltip(tooltip, link)
                local localTooltipLines = GetCreateTable()
                for _, specKey, specName in IteratePrioritizedWinCriteria do
                    if specKey ~= WIN_CRITERIA_COIN then
                        local standings = GetCreateTable()
                        DGV.YieldAutoroutine()
                        ScoreCarriedEquipment(specKey, standings)
                        AddEquipmentTooltipLines(specKey, specName, localTooltipLines, link, standings)
                        standings:Pool()
                    end
                end
                if tooltipLines then tooltipLines:Pool() end
                tooltipLines = localTooltipLines
            end

            function GA.ProcessTooltip(tooltip, name, link, ...)
                if not link or tooltip:GetName():match("ShoppingTooltip") then return end

                if tooltipLines then
                    for _, line in ipairs(tooltipLines) do
                        tooltip:AddLine(line)
                    end
                    tooltip:Show()
                end
                if not DGV.GetRunningAutoroutine("ScoreTooltip") then
                    DGV.BeginAutoroutine("ScoreTooltip", ScoreTooltip, tooltip, link)
                end
            end

            TipHooker = LibStub("LibTipHooker-1.1")
            TipHooker:Hook(GA.ProcessTooltip, "item")
            TipHooker:RegisterCustomTooltip("item", "WorldMapTooltip")

            local function HideRewardGuidance()
                DugisCoinRewardAdornment:Hide()
                DugisGreenArrowRewardAdornment:Hide()
                DugisYellowArrowRewardAdornment:Hide()
            end

            function ItemChoiceIterator(invariant, control)
                if not control then control = 0 end
                control = control + 1
                
                local isLogFrame = QuestLogFrame:IsShown() or (GossipFrame and GossipFrame:IsShown())
                local getNumChoices = isLogFrame and GetNumQuestLogChoices or GetNumQuestChoices
                local getItemLink = isLogFrame and GetQuestLogItemLink or GetQuestItemLink
                if control<=getNumChoices() then
                    local itemLink = getItemLink("choice", control)
                    if itemLink then
                        return control, itemLink, isLogFrame and _G["QuestLogItem"..control] or QuestInfo_GetRewardButton(QuestInfoFrame.rewardsFrame, control)
                    end
                else return end
            end
            
            local function AppraiseCoinValue(link)
                return select(11, GetItemInfo(link))
            end

            local function CoinRewardAdorner(link, rewardFrame)
                DugisCoinRewardAdornment:ClearAllPoints()
                DugisCoinRewardAdornment:SetParent(rewardFrame)
                DugisCoinRewardAdornment:SetSize(35, 35)
                DugisCoinRewardAdornment:SetPoint("TOPRIGHT", rewardFrame, 5, 9)
        
                DugisCoinRewardAdornment:SetFrameStrata("DIALOG")
                DugisCoinRewardAdornment:SetFrameLevel(501)
                DugisCoinRewardAdornment:Show()
            end

            local function StandardRewardAdorner(link, rewardFrame)
                local chosenColor
                if not DugisGreenArrowRewardAdornment:IsShown() then
                    chosenColor = DugisGreenArrowRewardAdornment
                elseif not DugisYellowArrowRewardAdornment:IsShown() then
                    if DugisGreenArrowRewardAdornment:IsShown() then
                        local _,relativeTo = DugisGreenArrowRewardAdornment:GetPoint()
                        if relativeTo==rewardFrame then return end
                    end
                    chosenColor = DugisYellowArrowRewardAdornment
                end
                if not chosenColor then return end
                chosenColor:SetParent(rewardFrame)
                chosenColor:ClearAllPoints()
                chosenColor:SetSize(28, 28)
                chosenColor:SetPoint("TOP", rewardFrame, "BOTTOMLEFT", 30, 25)
        
                chosenColor:SetFrameStrata("DIALOG")
                chosenColor:SetFrameLevel(501)
                chosenColor:Show()
            end

            local function EvaluateWinCriteron(standings, criterion, link)
                if criterion == WIN_CRITERIA_COIN then
                    return (AppraiseCoinValue(link)), CoinRewardAdorner
                else
                    return (FilterBestItem(standings, link, AppraiseItem(standings, link, criterion))), StandardRewardAdorner
                end
            end

            local function EvaluateRewards()
                HideRewardGuidance()
                local selectionMade
                for _, specKey in IteratePrioritizedWinCriteria do
                    local standings = nil
                    local winScore, winLink, winFrame, winAdorner
                    for _, link, frame in ItemChoiceIterator do
                        if not standings and specKey ~= WIN_CRITERIA_COIN then
                            standings = GetCreateTable():BindToAutoroutineLifetime(tPool)
                            ScoreCarriedEquipment(specKey, standings)
                        end
                        local score, adorner = EvaluateWinCriteron(standings, specKey, link)
                        if score and (not winScore or winScore<score) then
                            winScore = score
                            winLink = link
                            winFrame = frame
                            winAdorner = adorner
                        end
                    end
                    if standings then standings:Pool() end
                    if winLink then
                        if not selectionMade then
                            if winFrame then
                                if glowRewardFrame == nil then
                                    CreateFrame("Frame", "glowRewardFrame", winFrame)
                                    texture = glowRewardFrame:CreateTexture()
                                    texture:SetAllPoints()
                                    texture:SetBlendMode("ADD")
                                    texture:SetTexture("Interface\\QuestFrame\\UI-QuestItemHighlight")
                                end

                                glowRewardFrame:SetWidth(256)
                                glowRewardFrame:SetHeight(64)
                                glowRewardFrame:SetFrameStrata("DIALOG")

                                glowRewardFrame:SetPoint("TOPLEFT", winFrame, "TOPLEFT", -8, 7);

                                glowRewardFrame:Show()
                            else
                                if glowRewardFrame then
                                    glowRewardFrame:Hide()
                                end
                            end

                            DGV.QueueInvocation(winFrame:GetScript("OnClick"), winFrame)
                            selectionMade = true
                        end
                        winAdorner(winLink, winFrame)
                    end
                end
            end

            --Reveals group loot for tooltip testing.  If you use this, make sure you reloadui before playing in a group. 
            --/run DugisGuideViewer.TestGroupLoot(itemId, rollTime)
            function DGV.TestGroupLoot(itemId, rollTime)
                GetLootRollItemInfo = function()
                    local itemName, _, itemRarity, _, _, _, 
                    _, itemStackCount, _, itemTexture  = GetItemInfo(itemId)
                    return itemTexture, itemName, 1, itemRarity, nil, true, true, true
                end
                GameTooltip.SetLootRollItem = function(self)
                    self:SetHyperlink("item:"..itemId);
                end
                GroupLootFrame_OpenNewFrame(1, rollTime)
                GetLootRollItemInfo = test_GetLootRollItemInfo
            end

            local function DeferredRewardFrameShow(frame, elapsed)
                DGV.InterruptAutoroutine("EvaluateRewards")
                DGV.BeginAutoroutine("EvaluateRewards", EvaluateRewards)
            end
            rewardShowReaction = DGV.RegisterMemberFunctionReaction(QuestInfoRewardsFrame, "Show")
                :Or(DGV.RegisterFunctionReaction("QuestFrameItems_Update"))
                :WithAction(DeferredRewardFrameShow)
                :Defer()
            questHideReaction = DGV.RegisterMemberFunctionReaction(QuestInfoRewardsFrame, "Hide"):WithAction(HideRewardGuidance)
            adornerParentShowReaction = DGV.RegisterMemberFunctionReaction(QuestInfoRewardsFrame, "Show"):WithAction(HideRewardGuidance)
        end

        function GA:Unload()
            classWeaponProficiencies:Pool()
            classArmorProficiencies:Pool()
            subclassSpells:Pool()

            TipHooker:Unhook(GA.ProcessTooltip, "item")

            rewardShowReaction:Dispose()
            questHideReaction:Dispose()
            adornerParentShowReaction:Dispose()
        end
    end
end
