if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
--------------- Configuration -----------------

--higher value => longer processing =>  higher FPS
local CALCULATIONS_TIME_FOR_EMPTY_CACHE = 5  --Used in case new character was crated ot the player level has changed

--higher value => longer processing =>  higher FPS
local CALCULATIONS_TIME_FOR_FILLED_CACHE = 1  --For the same player level

--To check the performance on level change you can  run: /run DugisCharacterCache.CalculateScore_cache_v12 = {}    and then   /reload

local gearFinderDebug = false
local listItemsLimit = 6
local maxRequiredLEvelDifference = 1

local InitializeGearFinderUI_initialized = false
-----------------------------

if not DugisGearFinder then
    DugisGearFinder = {}
end

local mainFrameWidth = 280
local mainFrameHeight = 425
local mainFrameX = -32
local suggestionWidth = mainFrameWidth - 42
local suggestionX = 17
local suggestionY = -55
local scrollChildX = 5
local preloaderWidth = mainFrameWidth - 38 
local preloaderX = 1
local scrollTopX = 24
local scrollTopY = 0

local scrollBarX = scrollTopX - 8
local scrollBarY = scrollTopY - 24
local scrollBottomX = scrollTopX
local scrollBottomY = scrollTopY - mainFrameHeight + 115

local scrollBarHeight = mainFrameHeight - 51

local moreFrameX = 23
local moreFrameY = 10

local tooltipFrameX = moreFrameX
local tooltipFrameY = moreFrameY


--local StatLogic = LibStub("LibStatLogic-1.2-Dugi")

local DGF = DugisGearFinder

--Variables for CacheItemsForGearFinder
DGF.retryQueue = {}
DGF.retryCounter = {}


--{slot1 = {itemId1 = item1, itemId2 =item2,}, slot2 = {itemId1 = item1, itemId2 =item2,}}
DGF.itemsBySlot = {}


local DGV = DugisGuideViewer
if not DGV then return end

local LuaUtils = LuaUtils

local GA = DugisGuideViewer.Modules.GearAdvisor

--{{control, iteratedItemLink}, {control, iteratedItemLink}, ...}
DGF.GeadAdvisorItemIterator_cache = {}
DGF.IsQuestCompleted_cache = GetQuestsCompleted()

----------------------------
local DGV = DugisGuideViewer

local GearFinderModule = DGV:RegisterModule("GearFinder")
local DebugPrint = DGV.DebugPrint

function GearFinderModule:ShouldLoad()
	return DugisGuideViewer.chardb.EssentialsMode < 1 and DugisGuideViewer:GuideOn()
end

DGV.EquipmentFlyoutPopoutButton_SetReversed = function(self, isReversed)
	if ( self:GetParent().verticalFlyout ) then
		if ( isReversed ) then
			self:GetNormalTexture():SetTexCoord(0.15625, 0.84375, 0, 0.5);
			self:GetHighlightTexture():SetTexCoord(0.15625, 0.84375, 0.5, 1);
		else
			self:GetNormalTexture():SetTexCoord(0.15625, 0.84375, 0.5, 0);
			self:GetHighlightTexture():SetTexCoord(0.15625, 0.84375, 1, 0.5);
		end
	else
		if ( isReversed ) then
			self:GetNormalTexture():SetTexCoord(0.15625, 0, 0.84375, 0, 0.15625, 0.5, 0.84375, 0.5);
			self:GetHighlightTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 1, 0.84375, 1);
		else
			self:GetNormalTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 0, 0.84375, 0);
			self:GetHighlightTexture():SetTexCoord(0.15625, 1, 0.84375, 1, 0.15625, 0.5, 0.84375, 0.5);
		end
	end
end

function HideGF()
    if DGF.mainFrame then  DGF.mainFrame:Hide() end
    if GearFinderExtraItemsFrame then  GearFinderExtraItemsFrame:Hide()  end
    if GearFinderTooltipFrame then  GearFinderTooltipFrame:Hide()  end
    DGF:SetToNormalAllMoreButtons()
    DGF.shown = false
end


function ShowGF()
    if DGF.mainFrame then  DGF.mainFrame:Show() end
    DGF.shown = true

    DGF:InitializeGearFinderUI()

    if LuaUtils:ThreadInProgress("SetSuggestedItemGuides") or LuaUtils:ThreadInProgress("CacheItemsForGearFinder") then
        return
    end

    if DGF.allGearIds then
        DGV.InitializeGearFinder()
    end

    DGF:CacheItemsForGearFinder()
    DGF:UpdateTabsForGearFinder()
 
    if not DugisGearFinderFrame:IsShown() then
        DGF:SetToNormalAllMoreButtons()
        if GearFinderExtraItemsFrame then
            GearFinderExtraItemsFrame:Hide()
        end
    end
end

function GearFinderModule:Initialize()

    local buttonFrame = GUIUtils:AddButton(PaperDollFrame, "", ZygorGuidesViewer and 280 or 313, -44, 23, 23, 23, 23, function(self) 
        if DGF.shown then
            HideGF()
        else
            ShowGF()
        end
       
    end, [[Interface\AddOns\DugisGuideViewerZ\Artwork\UpgradeArrow]]
    , [[Interface\AddOns\DugisGuideViewerZ\Artwork\UpgradeArrow]]
    , [[Interface\AddOns\DugisGuideViewerZ\Artwork\UpgradeArrow]])

    buttonFrame.button:SetScript('OnEnter', function()
        GameTooltip:SetOwner(buttonFrame.button, "ANCHOR_RIGHT");
        GameTooltip:SetText('Dugi Guides Gear Finder', 1, 1, 1);
        GameTooltip:Show()
    end)

    buttonFrame.button:SetScript('OnLeave', function()
        GameTooltip:Hide()
    end)
    
    buttonFrame.button:Hide()

    DGF.gearFinderButton =  buttonFrame.button

    GearFinderModule.loaded = true

   DGV.InitializeGearFinder()
end

function GearFinderModule:Load()
    if DGF.allGearIds and DugisGuideViewer:UserSetting(DGV_ENABLEDGEARFINDER) then
        GearFinderModule.loaded = true
    end
end

local function GetAuctionHouseCategoryName(classID, subClassID, inventoryType)
	local name = "";
	if inventoryType then
		name = GetItemInventorySlotInfo(inventoryType);
	elseif classID and subClassID then
		name = GetItemSubClassInfo(classID, subClassID);
	elseif classID then
		name = GetItemClassInfo(classID);
	end
	return name
end

local function GetAuctionItemSubClasses_dugis(classIndex)
    if classIndex == 1 then
        return {
            [0] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_AXE1H      ) ,
            [1] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_AXE2H      ) ,
            [2] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_BOWS       ) ,
            [3] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_GUNS       ) ,
            [4] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_MACE1H     ) ,
            [5] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_MACE2H     ) ,
            [6] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_POLEARM    ) ,
            [7] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_SWORD1H    ) ,
            [8] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_SWORD2H    ) ,
            [9] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_WARGLAIVE    ) ,
            [10] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_STAFF      ) ,
            [13] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_UNARMED    ) ,
            --[14] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_GENERIC    ) ,
            [14] = AUCTION_SUBCATEGORY_MISCELLANEOUS                                             ,
            [15] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_DAGGER     ) ,
            [16] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_THROWN     ) ,
            [18] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_CROSSBOW   ) ,
            [19] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_WAND       ) ,
           -- [0] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_FISHINGPOLE)
            
            }
        
    end
    
    --AUCTION_CATEGORY_ARMOR
    if classIndex == 2 then
        return {
            [0] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_GENERIC  ) ,
            [1] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_CLOTH    ) ,
            [2] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_LEATHER  ) ,
            [3] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_MAIL     ) ,
            [4] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_PLATE    ) ,
            [5] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_COSMETIC ) ,
            [6] = GetAuctionHouseCategoryName(LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD ) 
        }
    end
end


local allOwnedItems = {}
local itemId2IsOwned = {}

function GearFinderModule:Unload()
    HideUIPanel(CharacterFrame)
    if DGV:UserSetting(DGV_UNLOADMODULES) then
        wipe(DGF.gearId2GearInfos_map)
        wipe(DGF.guideTitle2GearIds_map)
        wipe(DGF.allGearGuides)
        wipe(DGF.gearId2DroppedByBoss_map)
        wipe(DGF.gearId2Quests_map)
        wipe(DGF.gearId2PossibleDifficulties_map)
        wipe(DGF.allGearIds)
        wipe(DGF.itemsBySlot)
        wipe(DGF.retryQueue)
        wipe(DGF.retryCounter)
        wipe(DGF.GeadAdvisorItemIterator_cache)
        wipe(DugisCharacterCache.CalculateScore_cache_v12)
        wipe(DGF.IsQuestCompleted_cache)

        DGF.gearId2GearInfos_map = {}
        DGF.guideTitle2GearIds_map = {}
        DGF.allGearGuides = {}
        DGF.gearId2DroppedByBoss_map = {}
        DGF.gearId2Quests_map = {}
        DGF.gearId2PossibleDifficulties_map = {}
        DGF.allGearIds = {}
        DGF.itemsBySlot = {}
        DGF.retryQueue = {}
        DGF.retryCounter = {}
        DGF.GeadAdvisorItemIterator_cache = {}
        DGF.IsQuestCompleted_cache = {}
        DugisCharacterCache.CalculateScore_cache_v12 = {}
        CacheItemsForGearFinder_invoked = false

        collectgarbage("step", 100000)

        GearFinderModule.loaded = false

        DGF:UpdateTabsForGearFinder()
    end
end
---------------------------

local equipementSlots = {
    "INVTYPE_HEAD",
    "INVTYPE_NECK",
    "INVTYPE_HAND",
    --INVTYPE_WEAPON_MERGED  Always displayed - except Hunters
    --INVTYPE_OFFHAND_MERGED  Always Displayed, except Hunters
    --INVTYPE_2HWEAPON  Displayed if ITEM_CLASS_WEAPON,2,6,7,9,10
    --INVTYPE_RANGED_MERGED   Displayed if ITEM_CLASS_WEAPON,3,4,15
    "INVTYPE_SHOULDER",
    "INVTYPE_CLOAK",
    "INVTYPE_CHEST_MERGED",
    "INVTYPE_WRIST",
    "INVTYPE_WAIST",
    "INVTYPE_LEGS",
   "INVTYPE_FEET",
   "INVTYPE_FINGER",
   "INVTYPE_TRINKET",
}


local localizedClass, englishClass, classIndex = UnitClass("Player");

function DGF:Slot2VirtualSlot(slot)
    if slot == "INVTYPE_ROBE" or slot == "INVTYPE_CHEST" then
        return "INVTYPE_CHEST_MERGED"
    end

    if slot == "INVTYPE_RANGED" or slot == "INVTYPE_RANGEDRIGHT" then
        return "INVTYPE_RANGED_MERGED"
    end

     if slot == "INVTYPE_WEAPONOFFHAND" or slot == "INVTYPE_HOLDABLE" or slot == "INVTYPE_SHIELD" then
        return "INVTYPE_OFFHAND_MERGED"
    end

    if slot == "INVTYPE_WEAPON" or slot == "INVTYPE_WEAPONMAINHAND" then
        return "INVTYPE_WEAPON_MERGED"
    end

    return slot
end

--slot - virtual slot
local function IsArmorSpecSlot(slot)
    return
        slot=="INVTYPE_CHEST_MERGED" or
        slot=="INVTYPE_FEET" or
        slot=="INVTYPE_HAND" or
        slot=="INVTYPE_HEAD" or
        slot=="INVTYPE_LEGS" or
        slot=="INVTYPE_SHOULDER" or
        slot=="INVTYPE_WAIST" or
        slot=="INVTYPE_WRIST"
end

function DGF:LocalizeSlot(slot)
   local map = {
        ["INVTYPE_2HWEAPON"] = "Two Hand" ,
        ["INVTYPE_CHEST_MERGED"] = "Chest",
        ["INVTYPE_HAND"] = "Hand",
        ["INVTYPE_RANGED_MERGED"] = "Ranged",
        ["INVTYPE_WEAPON_MERGED"] = "Weapon",
        ["INVTYPE_OFFHAND_MERGED"] = "Off-hand"
    }

    slot = DGF:Slot2VirtualSlot(slot)

    if map[slot] then
        return map[slot]
    end

    return _G[slot]
end

local itemButtons = {}
local extraButtons = {}
local tooltipItems = {}

function DGF:Print(...)
    if gearFinderDebug then
        print(...)
    end
end

--{[difficultyId] => shouldInclude:true/false}
function DGF:GetDifficultyFilters()
    local filers = {}

    LuaUtils:loop(100, function(diffId)
        filers[diffId] = true
    end)

    filers[1] =  DGV:UserSetting(DGV_INCLUDE_DUNG_NORMAL)
    filers[2] =  DGV:UserSetting(DGV_INCLUDE_DUNG_HEROIC)

    filers[7] =  DGV:UserSetting(DGV_INCLUDE_RAIDS_RAIDFINDER)

    filers[23] = DGV:UserSetting(DGV_INCLUDE_DUNG_MYTHIC)
    filers[24] = DGV:UserSetting(DGV_INCLUDE_DUNG_TIMEWALKING)

    filers[17] = DGV:UserSetting(DGV_INCLUDE_RAIDS_RAIDFINDER)
    filers[14] = DGV:UserSetting(DGV_INCLUDE_RAIDS_NORMAL)
    filers[15] = DGV:UserSetting(DGV_INCLUDE_RAIDS_HEROIC)
    filers[16] = DGV:UserSetting(DGV_INCLUDE_RAIDS_MYTHIC)

    return filers
end

function DGF:IsQuestCompleted(questId)
    return DGF.IsQuestCompleted_cache[questId] ~= nil
end

function DGF:PlayerHasEnoughLevel(suggestion)
    local currenLevel = UnitLevel("player")

    if suggestion.item.info.reqlevelByQuest ~= nil then
        return currenLevel >= suggestion.item.info.reqlevelByQuest
    end

    if suggestion.item.info.reqlevel ~= 0 and suggestion.item.info.reqlevel ~= nil then
        return currenLevel >= suggestion.item.info.reqlevel
    end

    return true
end

function DGF:StartGuide(guide)
    if DGV.DisplayViewTabInThread and DugisGuideViewer.chardb.EssentialsMode ~= 1 and DugisGuideViewer:GuideOn() then
        DGV:DisplayViewTabInThread(guide)
    end
end

function DGF:LoadGuideButtonOnClick(self)
    local suggestion = self.suggestion

    if suggestion then
        local theBestGuide = DGF:GetTheBestGuideForGearId(self.suggestion.item.info.itemid, true)
        DGF:StartGuide(theBestGuide)
		print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(theBestGuide).."|cff11ff11 selected.|r")
		LuaUtils:PlaySound(567458)
        --Print("Guide Loaded: ", self.suggestion.item.info.equipslot, self.suggestion.item.info.name, self.suggestion.item.info.itemid, " Used guide:", DugisGuideViewer:GetFormattedTitle(theBestGuide))
    else
        DGF:Print("Guide Loaded: ", self.slot)
    end
end

function DGF:HideAllMoreButtons()
    for _, item in pairs(itemButtons) do
        item.loadGuideButton:Hide()
    end
    for _, item in pairs(extraButtons) do
        item.loadGuideButton:Hide()
    end
end
--/run  ShowGF()
function DGF:SetToNormalAllMoreButtons()
    for _, item in pairs(itemButtons) do
        DGV.EquipmentFlyoutPopoutButton_SetReversed(item.moreButton, false)
        item.moreButton.reversed = false
      --  item.SelectedBar:Hide()
    end
    for _, item in pairs(extraButtons) do
        DGV.EquipmentFlyoutPopoutButton_SetReversed(item.moreButton, false)
        item.moreButton.reversed = false
       -- item.SelectedBar:Hide()
    end
end

local boxSize = 49
local boxSizeTwoLabels = 36


local function ItemTexture(suggestion)
    return suggestion.item.info.texture
end

local function ItemName(suggestion)
    return suggestion.item.info.name
end

function DGF.ItemQuality(suggestion)
    return suggestion.item.info.quality
end

--The layout can be: "two-labels", "three-labels"
function DGF:GetCreateGuideBox(parent, x, y, layout, index, reuseItems)
    local slotButtonName = nil
    
    if reuseItems then
        slotButtonName = "GearFinderSlotButton"..index 
    end

    local box 
    
    if _G[slotButtonName] and reuseItems then
        box = _G[slotButtonName]
    else
        box = CreateFrame("Button", slotButtonName ,parent, "GearFinderFrame_ItemFrame")
        
        local topLabel = box:CreateFontString(nil,nil,"SystemFont_Med1")
        topLabel:ClearAllPoints()
        topLabel:SetPoint("TOPLEFT",box,"TOPLEFT",5, -3)
        topLabel:SetTextColor(1, 1, 1)
        topLabel:SetNonSpaceWrap(true)

        local bottomLabel = box:CreateFontString(nil,nil,"SystemFont_Shadow_Small")
        bottomLabel:ClearAllPoints()
        bottomLabel:SetPoint("BOTTOMLEFT",box,"BOTTOMLEFT",36, 4)
        bottomLabel:SetText("")
        bottomLabel:SetTextColor(1, 1, 1)
        bottomLabel:SetNonSpaceWrap(true)

        local middleLabel = box:CreateFontString(nil,nil,"SystemFont_Shadow_Small")
        middleLabel:ClearAllPoints()
        middleLabel:SetPoint("BOTTOMLEFT",box,"BOTTOMLEFT",36, 18)
        middleLabel:SetTextColor(1, 1, 1)
        middleLabel:SetNonSpaceWrap(true)
        middleLabel:SetText("Loading..")

        topLabel:SetJustifyH("LEFT")
        middleLabel:SetWordWrap(false)
        middleLabel:SetJustifyH("LEFT")

        topLabel:SetWordWrap(false)
        bottomLabel:SetWordWrap(false)
        bottomLabel:SetJustifyH("LEFT")

        if layout == "two-labels" then
            bottomLabel:SetPoint("BOTTOMLEFT",box,"BOTTOMLEFT", 38, 4)
            topLabel:SetPoint("TOPLEFT",box,"TOPLEFT", 38, -7)
            middleLabel:Hide()
        end

        local iconFrame = CreateFrame("Frame", nil, box)
        iconFrame:SetSize(28, 28)

        iconFrame:SetPoint("BOTTOMLEFT",box,"BOTTOMLEFT", 5, 3)

        local itemTexture = iconFrame:CreateTexture()
        itemTexture:SetAllPoints(iconFrame)
        iconFrame:Show()

        local moreButton = CreateFrame("Button", nil, box, "GearFinderMoreTemplate")
        moreButton:SetScript("OnLoad", nil)
        moreButton.slotItem = box
        moreButton:Show()

        moreButton:SetHeight(32);
        moreButton:SetWidth(16);
        moreButton:GetNormalTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 0, 0.84375, 0);
        moreButton:GetHighlightTexture():SetTexCoord(0.15625, 1, 0.84375, 1, 0.15625, 0.5, 0.84375, 0.5);
        moreButton:ClearAllPoints();
        moreButton:SetPoint("LEFT", box, "RIGHT", -9, -7);
        moreButton:Hide()
    
        if box.SpecRing then
            box.SpecRing:Hide()
        end

        moreButton:SetScript("OnClick", function(self)
            if LuaUtils:ThreadInProgress("MoreButtonClicked") then
                return
            end

            LuaUtils:CreateThread("MoreButtonClicked", function()
                        local wasReverser = self.reversed
                        DGF:SetToNormalAllMoreButtons()
                        self.reversed = not wasReverser

                        DGV.EquipmentFlyoutPopoutButton_SetReversed(self, self.reversed)

                       -- self.slotItem.SelectedBar:Show()

                        if not self.reversed then
                            GearFinderExtraItemsFrame:Hide()
                         --   self.slotItem.SelectedBar:Hide()
                            return
                        end

                        GearFinderExtraItemsFrame:Show()

                        local localizedSlotName = DGF:LocalizeSlot(self.slotItem.suggestion.item.info.equipslot)
                        GearFinderExtraItemsFrame.headerLabel:SetText(localizedSlotName)

                        LuaUtils:loop(5, function(index)
                            extraButtons[index]:Hide()
                        end)

                        local deltaY = 0

                        if self.slotItem.top5suggestions then
                            for index, suggestion in pairs(self.slotItem.top5suggestions) do
                                if extraButtons[index] then
                                    extraButtons[index].topLabel:SetText("X")

                                    local shortName = ItemName(suggestion)
                                    local requiredLevelInfo = ""

                                    extraButtons[index].itemTexture:SetTexture(ItemTexture(suggestion))

                                    local r, g, b, hex = GetItemQualityColor(DGF.ItemQuality(suggestion))

                                    local requiredLevelInfo = ""
                                    local requiredLevelInfoBefore = ""
                                    if not DGF:PlayerHasEnoughLevel(suggestion) then
                                        local lvl = suggestion.item.info.reqlevel

                                        if suggestion.item.info.reqlevelByQuest ~= nil then
                                            lvl = suggestion.item.info.reqlevelByQuest
                                        end

                                        if string.len(shortName) > 18 then
                                            requiredLevelInfoBefore = "|c00FF0000@L"..lvl.."|r "
                                        else
                                            requiredLevelInfoBefore = "|c00FF0000@ Level "..lvl.."|r "
                                        end
                                    end

                                    extraButtons[index].topLabel:SetText(requiredLevelInfoBefore.."|c"..hex..shortName.."|r")
                                    local guide = DGF:GetTheBestGuideForGearId(suggestion.item.info.itemid, true)

                                    if DugisGuideViewer.GetFormattedTitle then
                                        guide = DugisGuideViewer:GetFormattedTitle(guide)
                                    end

                                    extraButtons[index].bottomLabel:SetText("|cFFFFFFFF"..guide.."|r" )
                                    extraButtons[index].bottomLabel:SetWidth(210)
                                    extraButtons[index].topLabel:SetWidth(195)

                                    extraButtons[index].suggestion = suggestion
                                    extraButtons[index]:Show()

                                    deltaY = deltaY + boxSizeTwoLabels

                                    GearFinderExtraItemsFrame:SetHeight(deltaY + 65)
                                end

                                GearFinderExtraItemsFrame.headerLabel:SetText(localizedSlotName .." " .. index.."/"..#self.slotItem.top5suggestions.."..")
                            end

                            GearFinderExtraItemsFrame.headerLabel:SetText(localizedSlotName)
                        end
                end
            )
        end)


        box.layout = layout

        moreButton:SetScript("OnEnter", function()
            GameTooltip:SetOwner(moreButton, "ANCHOR_RIGHT")
            GameTooltip:AddLine("Load more suggestions", 1, 1, 1)
            GameTooltip:Show()
        end)

        moreButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        -------------Info button---------------------------
        local loadGuideButton = CreateFrame("Button", nil, box)
        loadGuideButton:SetSize(28, 28)
        loadGuideButton.slotItem = box
        loadGuideButton:SetPoint("TOPRIGHT",box,"TOPRIGHT",5, 5)
        loadGuideButton:SetNormalTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Up.blp")
        loadGuideButton:SetHighlightTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Highlight.blp")
        loadGuideButton:SetPushedTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Down.blp")
        loadGuideButton:Hide()
        loadGuideButton:SetScript("OnClick", function(self)
            LuaUtils:CreateThread("LoadGuideButtonOnClick", function()
                DGF:LoadGuideButtonOnClick(box)
            end)
        end)

        loadGuideButton.box = box

        loadGuideButton:SetScript("OnEnter", function(self)
            LuaUtils:CreateThread("LoadGuideButtonOnEnter", function()
            
                local gearId = box.suggestion.item.info.itemid

                local guideTitle, gearInfo = DGF:GetTheBestGuideForGearId(gearId, true)

                if not gearInfo then
                    return
                end

                local questName = ""

                if gearInfo.questIds then
                    for _, questId in pairs(gearInfo.questIds) do
                        if not DGF:IsQuestCompleted(questId) then
                            if DugisGuideViewer.NPCJournalFrame.GetQuestInfo then
                                local questInfo = DugisGuideViewer.NPCJournalFrame:GetQuestInfo(tonumber(questId))
                                if questInfo then
                                    questName = questInfo.name
                                end
                            end
                        end
                    end
                end

                GameTooltip:SetOwner(moreButton, "ANCHOR_RIGHT")

                local guideTitleFormatted = guideTitle
                local guideExists = true

                if not DugisGuideViewer:isValidGuide(guideTitle) then
                    guideExists = false
                end

                if  DugisGuideViewer.GetFormattedTitle then
                    guideTitleFormatted = DugisGuideViewer:GetFormattedTitle(guideTitle)
                end

                if guideTitleFormatted then
                    if gearInfo.reputationId then
                        GameTooltip:AddLine("Reputation With: |cFFFFFFFF"..guideTitleFormatted.."|r" , 1, 0.8, 0.0)
                    else
                        GameTooltip:AddLine("Found In: |cFFFFFFFF"..guideTitleFormatted.."|r" , 1, 0.8, 0.0)
                    end
                end

                if gearInfo.bossId then
                    local numericBossId = tonumber(gearInfo.bossId)
                    local droppedBy
                    local bossName

                    if numericBossId > 0 then
                        bossName =  DugisGuideViewer:GetLocalizedNPC(numericBossId)
                    else
                        if gearInfo.encounterId then
                            bossName = EJ_GetEncounterInfo(gearInfo.encounterId)
                        end
                    end

                    if not bossName then
                        droppedBy = "Boss "..gearInfo.bossId
                    else
                        droppedBy = bossName
                    end
                    GameTooltip:AddLine("Dropped by: |cFFFFFFFF"..droppedBy.."|r" , 1, 0.8, 0.0)
                end

                if questName ~= "" then
                    GameTooltip:AddLine("Reward From: |cFFFFFFFF"..questName.."|r" , 1, 0.8, 0.0)
                end

                if guideExists then
                    GameTooltip:AddLine("Click to load the guide", 0, 1, 0)
                else
                    GameTooltip:AddLine("Guide not available", 1, 0, 0)
                end
                GameTooltip:Show()

                if self.box.top5suggestions == nil or #self.box.top5suggestions < 2 then
                    self.box.moreButton:Hide()
                else
                    self.box.moreButton:Show()
                end
            
            
            end)
        end)

        loadGuideButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
            
        
       box:SetScript("OnEnter", function(self)
            if self.suggestion and self.suggestion.item.info.itemid then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
                
                local link = self.suggestion.item.info.itemlink
                GameTooltip:SetHyperlink(link);
            end

            DGF:HideAllMoreButtons()

            if self.suggestion then
                self.loadGuideButton:Show()
            end

            if self.suggestion then
               -- self.HighlightBar:Show()
            end
        end)

        box:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
--            self.HighlightBar:Hide();
        end)

        box:SetScript("OnClick", nil)
        

        box.topLabel = topLabel
        box.middleLabel = middleLabel
        box.bottomLabel = bottomLabel
        box.moreButton = moreButton
        box.loadGuideButton = loadGuideButton
        box.itemTexture = itemTexture
        
    end

    box:SetSize(suggestionWidth, boxSize)

    if layout == "two-labels" then
        box:SetSize(257, boxSizeTwoLabels)
    end

    box:SetPoint("TOPLEFT",x, y)
    box.texture = box:CreateTexture()
    box.texture:SetAllPoints(box)
    --box.texture:SetTexture("Interface\\CHARACTERFRAME\\BarHighlight.blp")
  
    return box
end

function DGF:UpdateGearButtons(itemButtons, showShadows)
    local STRIPE_COLOR = {r=1, g=1, b=1}

	for i = 1, #itemButtons do
        local button = itemButtons[i];

       -- button.Check:Hide();
       -- button.icon:Hide()

       showShadows = false

       button.BgMiddle:ClearAllPoints()
       button.BgMiddle:SetPoint("TOPLEFT", button, 0,0);
       button.BgMiddle:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 5, 0);
       button.BgMiddle:Show()

        if i == 1 and showShadows then
            button.BgTop:Show();
        else
            button.BgTop:Hide();
        end

        if i == numRows and showShadows then
            button.BgBottom:Show();
        else
            button.BgBottom:Hide();
        end

        if i % 2 == 0 then
             button.Stripe:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
            button.Stripe:SetAlpha(0.1);
            button.Stripe:SetHeight( button.layout == "two-labels" and 37 or 50)
            button.Stripe:SetWidth(button.layout == "two-labels" and (suggestionWidth + 15) or suggestionWidth)
            button.Stripe:Show();
        else
            button.Stripe:Hide();
        end

        if not showShadows then
             button.BgMiddle:SetAlpha(1)
        else
             button.BgMiddle:SetAlpha(1)
        end
	end
end

function DGF:CreateExtraItemsFrame()
    if _G["GearFinderExtraItemsFrame"] then
        return
    end

    local frame = CreateFrame("Frame", "GearFinderExtraItemsFrame", UIParent, "BackdropTemplate")
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetWidth(285)
    frame:SetHeight(299)

    frame:SetBackdrop({
    bgFile = [[Interface\GLUES\Models\UI_MainMenu_Cataclysm\UI_BLACKCOLOR01.BLP]]
    ,edgeFile =  DugisGuideViewer:GetBorderPath(),
                                            tile = false, tileSize = 30, edgeSize = 32,
                                            insets = { left = 10, right = 5, top = 10, bottom = 5 }})

    frame:SetBackdropColor(1,1,1,1)

	DugisGuideViewer.ApplyElvUIColor(frame)
    
    --/run  GearFinderTooltipFrame:ClearAllPoints(); GearFinderTooltipFrame:SetPoint("TOPLEFT", "DugisGearFinderFrame", "TOPRIGHT", 0, 0)
    GearFinderExtraItemsFrame:SetPoint( "TOPLEFT", "DugisGearFinderFrame", "TOPRIGHT", moreFrameX, moreFrameY)

    frame:SetParent(CharacterFrame)
    frame:Hide()


--[[     local bkg = frame:CreateTexture()
    bkg:SetAllPoints(frame)
    bkg:Show()
    bkg:SetColorTexture(0,0,0, 1) ]]

    --Header
    local headerLabel = frame:CreateFontString(nil, nil, "SystemFont_Med3")
    headerLabel:ClearAllPoints()
    headerLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -25)
    headerLabel:SetText("Top gear guides")
    headerLabel:SetTextColor(1,0.8,0)
    headerLabel:SetNonSpaceWrap(true)
    GearFinderExtraItemsFrame.headerLabel = headerLabel

    --Close button
    LuaUtils:loop(5, function(index)
        local button = DGF:GetCreateGuideBox(frame, 15,  -index * (boxSizeTwoLabels) - 10, "two-labels")
        button.moreButton:Hide()
        extraButtons[#extraButtons + 1] = button
    end)

    DGF:UpdateGearButtons(extraButtons, false)
end

function DGF:GearFinderTooltipFrame()
    if _G["GearFinderTooltipFrame"] then
        return
    end

    DGF:InitializeGearFinderUI()

    local frame = CreateFrame("Frame", "GearFinderTooltipFrame", UIParent, "BackdropTemplate")
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetWidth(285)
    frame:SetHeight(299)
    frame:SetClampedToScreen(true)

    frame:Hide()

    frame:SetBackdrop({
    bgFile = [[Interface\GLUES\Models\UI_MainMenu_Cataclysm\UI_BLACKCOLOR01.BLP]]
    ,edgeFile =  DugisGuideViewer:GetBorderPath(),
                                            tile = false, tileSize = 30, edgeSize = 32,
                                            insets = { left = 10, right = 5, top = 10, bottom = 5 }})

    frame:SetBackdropColor(1,1,1,1)

  
	
	DugisGuideViewer.ApplyElvUIColor(frame)

    --GearFinderTooltipFrame:SetPoint("TOPRIGHT",CharacterFrame, 283, 5)


    GearFinderTooltipFrame:SetPoint( "TOPLEFT", "DugisGearFinderFrame", "TOPRIGHT", tooltipFrameX, tooltipFrameY)
    GearFinderTooltipFrame:SetWidth(suggestionWidth + 50)


    --Header
    local headerLabel = frame:CreateFontString(nil, nil, "SystemFont_Med3")
    headerLabel:ClearAllPoints()
    headerLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -25)
    headerLabel:SetText("Items found:")
    headerLabel:SetTextColor(1,0.8,0)
    headerLabel:SetNonSpaceWrap(true)
    GearFinderTooltipFrame.headerLabel = headerLabel

    --Close button
    LuaUtils:loop(18, function(index)
        local button = DGF:GetCreateGuideBox(frame, suggestionX,  -index * (boxSizeTwoLabels) - 10 , "two-labels")
         tooltipItems[#tooltipItems + 1] = button

         button.topLabel:SetNonSpaceWrap(true)
         button.topLabel:SetWidth(210)
    end)

    for _, itemButton in pairs(tooltipItems) do
        itemButton:Hide()
    end

    DGF:UpdateGearButtons(tooltipItems, false)
end

function DGF:HideExtraButtonsFrame()
    DGF:SetToNormalAllMoreButtons()
    if GearFinderExtraItemsFrame then
        GearFinderExtraItemsFrame:Hide()
    end
end

local function UpdateCurrentGuideTtile()
    --Updating the tooltip

    DGF:InitializeGearFinderUI()

    for _, itemButton in pairs(tooltipItems) do
        itemButton:Hide()
    end

    local yIndex = 1
    for _, itemButton in pairs(itemButtons) do
        if itemButton.suggestion and itemButton.suggestedGuide == DugisGearFinderFrame.suggestedGuide.suggestedGuideTitle then
            tooltipItems[yIndex].bottomLabel:SetText(DGF:LocalizeSlot(itemButton.suggestion.item.info.equipslot))
            local itemName = ItemName(itemButton.suggestion)
            local r, g, b, hex = GetItemQualityColor(DGF.ItemQuality(itemButton.suggestion))
            tooltipItems[yIndex].topLabel:SetText("|c"..hex..itemName.."|r")
            tooltipItems[yIndex].itemTexture:SetTexture(ItemTexture(itemButton.suggestion))
            tooltipItems[yIndex]:Show()
            yIndex = yIndex + 1
        end
    end

    GearFinderTooltipFrame:SetHeight(yIndex * boxSizeTwoLabels + 30)
end

function DGF:BuildSlots()

    local equipementSlotsCopy = LuaUtils:clone(equipementSlots)
    
    table.insert(equipementSlotsCopy, 4, "INVTYPE_RANGED_MERGED")
    table.insert(equipementSlotsCopy, 4, "INVTYPE_2HWEAPON")
    table.insert(equipementSlotsCopy, 4, "INVTYPE_OFFHAND_MERGED")
    table.insert(equipementSlotsCopy, 4, "INVTYPE_WEAPON_MERGED")
    
    for _, item in pairs(itemButtons) do
        item:Hide()
    end
    
    itemButtons = {}
    
    for index, value in pairs(equipementSlotsCopy) do
        local slotText = DGF:LocalizeSlot(value)

        local itemFrame = DGF:GetCreateGuideBox(DugisGearFinderFrame.ScrollChild, 0, -index * boxSize , "three-labels", index, true)
        itemFrame.topLabel:SetText(slotText)
        itemFrame.slot = value
        
        itemFrame:Show()

        itemButtons[#itemButtons + 1] = itemFrame
    end

    DGF:UpdateGearButtons(itemButtons, true)
end



function DGF:InitializeGearFinderUI()
    if InitializeGearFinderUI_initialized then
        return
    end

    local GA = DGV.Modules.GearAdvisor
    if not GA then return end

    InitializeGearFinderUI_initialized = true

    local parent = CreateFrame("Frame", "GearFinderMainFrame", UIParent, "GearFinderFrameTemplate")

    parent:SetBackdrop({ 
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], 
        tile = true, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })

    DGF.mainFrame = parent

  --  parent:SetSize(mainFrameWidth, mainFrameHeight)
    parent:SetPoint("TOPLEFT", "CharacterFrame", "TOPRIGHT", mainFrameX, -14)
    parent:SetSize(mainFrameWidth, mainFrameHeight)
    parent:Hide()

    CreateFrame("ScrollFrame", "DugisGearFinderFrame", parent, "UIPanelScrollFrameTemplate2")

    DugisGearFinderFrame:SetScript("OnEvent", DGF.ItemInfoEventHandler)
	DugisGearFinderFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	DugisGearFinderFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	--DugisGearFinderFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

    DugisGearFinderFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", scrollChildX, -5)
    DugisGearFinderFrame:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",-27, 4)
    DugisGearFinderFrame:Show()

    DugisGearFinderFrame.ScrollChild = CreateFrame("Frame", nil ,DugisGearFinderFrame)

    DugisGearFinderFrame:SetScrollChild(DugisGearFinderFrame.ScrollChild)
    DugisGearFinderFrame.ScrollChild:SetSize(200, 950)
    --DugisGearFinderFrame.ScrollChild:SetPoint("TOPLEFT", 3, -30)

    DugisGearFinderFrame.ScrollChild:SetParent(DugisGearFinderFrame)

    CreateFrame("Frame", "SuggestedGearGuide", DugisGearFinderFrame.ScrollChild)
    SuggestedGearGuide:SetSize(suggestionWidth, 40)
    SuggestedGearGuide:SetPoint("TOPLEFT", 0, 0)
    SuggestedGearGuide:Show()

    --/run DugisGearFinderFrameTop:SetHeight(319)
    DugisGearFinderFrameTop:SetHeight(319)
    DugisGearFinderFrameTop:ClearAllPoints()
    DugisGearFinderFrameTop:SetPoint("TOPRIGHT",  scrollTopX, scrollTopY)
    DugisGearFinderFrameBottom:ClearAllPoints()
    DugisGearFinderFrameBottom:SetPoint("TOPRIGHT",  scrollBottomX, scrollBottomY)
    DugisGearFinderFrameScrollBar:ClearAllPoints()
    DugisGearFinderFrameScrollBar:SetPoint("TOPRIGHT",  scrollBarX, scrollBarY)
    DugisGearFinderFrameScrollBar:SetHeight(scrollBarHeight)
    DugisGearFinderFrameScrollBar:SetWidth(15)

    -- Preloder
    CreateFrame("Frame", "GearFinderPreloader" , DugisGearFinderFrame, "DugisPreloader")
    GearFinderPreloader:SetSize(preloaderWidth, 40)
    GearFinderPreloader:SetParent(DugisGearFinderFrame)
    GearFinderPreloader:SetPoint("BOTTOMLEFT", preloaderX, -1)
    GearFinderPreloader:Hide()

    local animationGroup = GearFinderPreloader.Icon:CreateAnimationGroup()
    animationGroup:SetLooping("REPEAT")
    local animation = animationGroup:CreateAnimation("Rotation")
    animation:SetDegrees(-360)
    animation:SetDuration(1)
    animation:SetOrder(1)
    DGF.preloaderAnimationGroup = animationGroup

    local suggestedGuide = SuggestedGearGuide:CreateFontString(nil, nil, "SystemFont_Med1")
    suggestedGuide:ClearAllPoints()
    suggestedGuide:SetPoint("TOPLEFT", SuggestedGearGuide, "TOPLEFT", 2, -2)
    suggestedGuide:SetText("Best Guide")
    suggestedGuide:SetTextColor(1,0.8,0)
    suggestedGuide:SetNonSpaceWrap(true)

    local suggestedGuideSubtitle = SuggestedGearGuide:CreateFontString(nil, nil, "SystemFont_Shadow_Small")
    suggestedGuideSubtitle:ClearAllPoints()
    suggestedGuideSubtitle:SetPoint("TOPLEFT", SuggestedGearGuide, "TOPLEFT", 7, -20)
    suggestedGuideSubtitle:SetText("-")
    suggestedGuideSubtitle:SetTextColor(1,0.8,0)
    suggestedGuideSubtitle:SetNonSpaceWrap(true)

    SuggestedGearGuide:SetScript("OnMouseDown", function()
        if suggestedGuide.suggestedGuideTitle then
            DGF:StartGuide(suggestedGuide.suggestedGuideTitle)
			print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(suggestedGuide.suggestedGuideTitle).."|cff11ff11 selected.|r")
			LuaUtils:PlaySound(567458)
            --DGF:Print("Guide Loaded: ", suggestedGuide.suggestedGuideTitle)
        end
    end)

    ---------------------------------
    CreateFrame("Button", "SuggestedGuideButtonDG", SuggestedGearGuide)
    SuggestedGuideButtonDG:SetSize(28, 28)
    SuggestedGuideButtonDG:SetPoint("TOPLEFT",SuggestedGearGuide,"TOPLEFT", suggestionWidth - 22, 2)
    SuggestedGuideButtonDG:SetNormalTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Up.blp")
    SuggestedGuideButtonDG:SetHighlightTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Highlight.blp")
    SuggestedGuideButtonDG:SetPushedTexture("Interface\\MINIMAP\\UI-Minimap-MinimizeButtonUp-Down.blp")
    SuggestedGuideButtonDG:Hide()
    SuggestedGuideButtonDG:SetScript("OnClick", function(self)
        if suggestedGuide.suggestedGuideTitle then
            DGF:StartGuide(suggestedGuide.suggestedGuideTitle)
			print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(suggestedGuide.suggestedGuideTitle).."|cff11ff11 selected.|r")
			LuaUtils:PlaySound(567458)
        end
    end)

    SuggestedGuideButtonDG:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(SuggestedGuideButtonDG, "ANCHOR_RIGHT")

        local guideExists = true
        if not DugisGuideViewer:isValidGuide(suggestedGuide.suggestedGuideTitle) then
            guideExists = false
        end

        if guideExists then
            GameTooltip:AddLine("Click to load the guide", 1, 1, 1)
        else
            GameTooltip:AddLine("Guide not available", 1, 0, 0)
        end

        GameTooltip:Show()
    end)

    SuggestedGuideButtonDG:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    SuggestedGearGuide:SetScript("OnLeave", function(self)
        if not SuggestedGuideButtonDG:IsMouseOver() then
            SuggestedGuideButtonDG:Hide()
        end

        GearFinderTooltipFrame:Hide()
    end)

    SuggestedGearGuide:SetScript("OnEnter", function(self)
        if suggestedGuideSubtitle:GetText() ~= "-" then
            SuggestedGuideButtonDG:Show()
        end

        UpdateCurrentGuideTtile()

        if tooltipItems[1]:IsShown() and not GearFinderExtraItemsFrame:IsShown() then
            GearFinderTooltipFrame:Show()
        end
    end)

    DugisGearFinderFrame.suggestedGuide = suggestedGuide
    DugisGearFinderFrame.suggestedGuideSubtitle = suggestedGuideSubtitle

    DGF:BuildSlots()

    DGF:GearFinderTooltipFrame()

--[[
    hooksecurefunc("CharacterFrame_Collapse", function()
        DGF:HideExtraButtonsFrame()
    end)
]]

--[[
    hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", function()
        if not DugisGearFinderFrame:IsShown() then
            DGF:SetToNormalAllMoreButtons()
            if GearFinderExtraItemsFrame then
                GearFinderExtraItemsFrame:Hide()
            end
        end
    end)
]]
    --uaUtils.Profiler:Stop("InitializeGearFinderUI")
end


local DungeonUtils = {}

DungeonUtils.expansionLevel2Limit = {
	[0] = 60,
	[1] = 80,
	[2] = 80,
	[3] = 90,
	[4] = 90,
	[5] = 100,
	[6] = 110,
	[7] = 120,
}

-- GetLFGDungeonInfo doesn't return any data for the following dungeons so values must be added manualy.
DungeonUtils.dungeon2DungeonInfo = {    
	-- Legion                                                                          
	["dun_777"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Assault on Violet Hold"        
	["dun_740"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Black Rook Hold"               
	["dun_800"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Court of Stars"                
	["dun_762"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Darkheart Thicket"             
	["dun_721"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Halls of Valor"                
	["dun_727"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Maw of Souls"                  
	["dun_767"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Neltharion's Lair"             
	["dun_726"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"The Arcway"                    
	["dun_707"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Vault of the Wardens"          
	["dun_860"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Return to Karazhan"            
	["dun_900"]  = {expansionLevel = 6, minLevel = 110, difficulty = 23   },  --"Cathedral of Eternal Night"    
	-- BFA                                                              
	["dun_968"]   = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Atal'Dazar"                  
	["dun_1001"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Freehold"                    
	["dun_1041"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Kings' Rest"                 
	["dun_1036"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Shrine of the Storm"         
	["dun_1023"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Siege of Boralus"            
	["dun_1030"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Temple of Sethraliss"        
	["dun_1012"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"The Motherlode!!"            
	["dun_1022"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"The Underrot"                
	["dun_1002"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Tol Dagor"                   
	["dun_1021"]  = {expansionLevel = 7, minLevel = 120, difficulty = 23  },   --"Waycrest Manor"              
}

-- BFA dungeons have different min levels per faction
DungeonUtils.dungeon2MinLevel = { 
	[1672] = { Alliance = 110, Horde = 120 }, -- Freehold
	[1774] = { Alliance = 110, Horde = 120 }, -- Shrine of the Storm
	[1705] = { Alliance = 110, Horde = 120 }, -- Waycrest Manor
	[1778] = { Alliance = 115, Horde = 120 }, -- Tol Dagor
	[1668] = { Alliance = 120, Horde = 110 }, -- Atal´dazar
	[1694] = { Alliance = 120, Horde = 110 }, -- Temple of Sethraliss
	[1777] = { Alliance = 120, Horde = 110 }, -- The Underrot
	[1707] = { Alliance = 120, Horde = 115 }, -- The Motherlode!!
}

local playerFaction = UnitFactionGroup("player")

function DungeonUtils.GetDungeonInfo(id)
    if not id then return end

    if type(id)=="string" and not DungeonUtils.dungeon2DungeonInfo[id] then return end 

    local _, typeID, minLevel, expansionLevel, difficulty, isHoliday
    
    if DungeonUtils.dungeon2DungeonInfo[id] then
        local dungeonInfo = DungeonUtils.dungeon2DungeonInfo[id]
        expansionLevel, minLevel, difficulty = dungeonInfo.expansionLevel, dungeonInfo.minLevel, dungeonInfo.difficulty
    else
        typeID, _, minLevel, _, _, _, _, expansionLevel, _, _, difficulty, _, _, isHoliday = GetLFGDungeonInfo(id)
    end

    if expansionLevel ~= nil and typeID ~= 4 then
        local result = {}

        result.id = id
        result.name = name
        result.difficulty = difficulty
        result.isHoliday = isHoliday
        if DungeonUtils.dungeon2MinLevel[id] then
            result.minLevel = DungeonUtils.dungeon2MinLevel[id][playerFaction]
        else
            result.minLevel = minLevel
        end
        result.expansionLevel = expansionLevel
        result.maxScaleLevel = math.max(DungeonUtils.expansionLevel2Limit[expansionLevel] or 0, result.minLevel or 0) 

        return result
    end
end

function DungeonUtils.IsMythicDungeon(itemInfo)
    local originalItemInfo = itemInfo.info.originalItemInfo

	local dungeon_ = originalItemInfo.dungeon
	if dungeon_ == 0 then 
        dungeon_ = "dun_"..originalItemInfo.instanceId
    end

	local dungeon = DungeonUtils.GetDungeonInfo(dungeon_)
    
	if not dungeon or dungeon.expansionLevel > GetExpansionLevel() or dungeon.isHoliday then 
        return false 
    end
    
	return dungeon.difficulty == 23 and dungeon.maxScaleLevel == MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()]
end


-- {...} Contains pairs:  position1, value1, position2, value2 ...
function DGF.SetValuesForItemLink(itemlink, ...)	
	local _, itemstring = itemlink:match("(.*)item:([0-9-:]*)(.*)")
	if not itemstring then 
        return itemlink
    end

	local itemLinkParts = {strsplit(":", itemstring)}
    
	for i = 2, 13 do 
        itemLinkParts[i] = itemLinkParts[i] or "" 
    end 

	for i = 1, select("#", ...), 2 do 
        itemLinkParts[select(i, ...)] = select(i + 1, ...) 
    end

	itemlink = table.concat(itemLinkParts, ":")
    
	wipe(itemLinkParts)

	return "item:"..itemlink 
end

function DGF.RemoveBonusFromItemLink(itemlink,bonusid)
	if not itemlink or  not bonusid then 
        return itemlink
    end

	local itemlink = DGF.SetValuesForItemLink(itemlink)
	itemlink = itemlink:gsub(":"..bonusid, "")
	local itemLinkParts = {strsplit(":", itemlink)}

	itemLinkParts[14] = (tonumber(itemLinkParts[14]) or 1) - 1
	table.insert(itemLinkParts, bonuses)
	return table.concat(itemLinkParts, ":")
end

function DGF.AddBonusForItemLink(itemlink, bonuses)
    if not itemlink or not bonuses then 
        return itemlink
    end
    
    -- clean up decorations
    local itemlink = DGF.SetValuesForItemLink(itemlink)
    local itemLinkParts = {strsplit(":", itemlink)}

    local _, count = string.gsub(bonuses, ":", "")
    itemLinkParts[14] = (itemLinkParts[14] or 0) + count + 1
    
    table.insert(itemLinkParts, bonuses)
    return table.concat(itemLinkParts, ":")
end

function DGF:GetItemInfoById(itemId, threading, originalItemInfo)
    local itemlink = ""
    local numericItemId = tonumber(itemId)
    if numericItemId == nil or numericItemId == 0 then
        itemlink = itemId
    else
        itemlink="item:"..itemId..":0:0:0:0:0:0:0:0:0:0:0"
    end

    local name,link,quality,ilevel, reqlevel, class, subclass, maxstack, equipslot, texture, vendorprice = LuaUtils.GetItemInfo_dugi(itemlink, threading)

   -- reqlevel = nil--StatLogic:GetRequiredPlayerLevel(itemlink, threadingMode) or reqlevel
        
    --Min
    local reqlevelByQuest = nil

    if not name then
        return nil
    end

    -- Loads stats into item.stats
    local stats = GetItemStats(itemlink)
    if not stats then
        return nil
    end

    if reqlevel == nil or reqlevel == 0 or (reqlevel == 1 and ilevel > 10) then
       local relatedQuests = DGF.gearId2Quests_map[itemId]

       --This condition is needed because GetItemInfoById is used also to get information about possesed gears (not nesseserly avaliable in GearInfoData lua file)
       if relatedQuests then
           local requiredLevelbyQuestMin = 0
           for questId,_ in pairs(relatedQuests) do
               local levels = DGV.ReqLevel[questId]
               if levels then
                   if reqlevelByQuest == nil then
                        reqlevelByQuest = levels[2]
                   else
                        if levels[2] < reqlevelByQuest then
                            reqlevelByQuest = levels[2]
                        end
                   end
               end
           end
       end
    end

   -- DGF:Print(reqlevelByQuest)
    local item

    if DugisGearFinder.optimized then
        item = {
                info = {
                --original item id
                itemid = itemId
                , name = name
                , reqlevel = reqlevel
                , reqlevelByQuest = reqlevelByQuest
                , class = class
                , quality = quality
                , subclass = subclass
                , texture = texture
                , equipslot = equipslot
                , itemlink = itemlink
                },
                tooltip={}
            }
    else
        item = {
            info = {
            --original item id
            itemid = itemId
            , name = name
            , itemlink = itemlink
            , quality = quality
            , ilevel = ilevel
            , reqlevel = reqlevel
            , reqlevelByQuest = reqlevelByQuest
            , class = class
            , subclass = subclass
            , texture = texture
            , equipslot = equipslot
            , vendorprice = vendorprice
            },
            stats = stats,
            tooltip={}
        }
    end
    
    if originalItemInfo then
        item.info.originalItemInfo = originalItemInfo
    else
        local infos = DGF.gearId2GearInfos_map[itemId] or DGF.gearId2GearInfos_map[itemlink]
        if infos then
            item.info.originalItemInfo = infos[1]
        end
    end

    return item
end


function DGF:GetAllOwnedItems(onlyBelowPlayerLevel)
    local result = {}

    local itemInvariant = DugisGuideViewer:GetCreateTable()
    itemInvariant.first = itemMustWin
    itemInvariant.skip = skip

    for control, iteratedItemLink in GeadAdvisorItemIterator, itemInvariant do
        local itemInfo = DGF:GetItemInfoById(iteratedItemLink, true)

        if itemInfo == nil then
            return
        end
        
		LuaUtils:RestIfNeeded(true)
        
        --SCORE
        local level = UnitLevel("player")

        local uniqueInventorySlot = GetDefaultUniqueInventorySlot(itemInfo.info.equipslot)

        local score = GA.CalculateScore(itemInfo.info.itemlink, GA:GetPlayerSpecKey())
        
        local lvl = itemInfo.info.reqlevel

        if itemInfo.info.reqlevelByQuest ~= nil then
            lvl = itemInfo.info.reqlevelByQuest
        end

        if (not onlyBelowPlayerLevel) or (level >= lvl ) then
            result[#result + 1] = {link=iteratedItemLink, itemId = itemInfo.info.itemid, item = itemInfo, score = score}
        end

       -- result[#result + 1] =  itemInfo
    end

    --LuaUtils.Profiler:Stop("GetAllOwnedItems")

    return result
end

--{itemId1 = true, itemid2 = true, ...}
function DGF:GetAllOwnedItemIds(noThread)
    local result = {}

    for _, value in pairs(allOwnedItems) do
        result[value.itemId] = true
    end

    return result
end

--/run GetTheBestOwnedItemBySlot("INVTYPE_WRIST")
--In case slot is a "double" slot then this function should return then next after the best item if exists.
--This way in case that in slotX1 there is item with score 100 and in slotX2 item is with score 150 but the considered item has score 120 
--it will suggest that new one to be on slotX1
function DGF:GetTheBestOwnedItemBySlot(slot, onlyBelowPlayerLevel)
    if #allOwnedItems == 0 then
        return nil
    end

    local theBest = nil
    local secondTheBest = nil
    
    local isDoubleSlot = slot == "INVTYPE_WEAPON_MERGED" or slot == "INVTYPE_FINGER" or slot == "INVTYPE_TRINKET"
    
    DGF:Print("-------------------------")
    DGF:Print("POSSESSED items for ",slot," slot:")
    for index, item in pairs(allOwnedItems) do
        if DGF:Slot2VirtualSlot(item.item.info.equipslot) == slot then
            DGF:Print("itemId:", item.item.info.itemid, " SCORE:", item.score)
        end

        if DGF:Slot2VirtualSlot(item.item.info.equipslot) == slot and (theBest == nil or item.score > theBest.score) then
            theBest = item
        end
    end
    
    if theBest then
        for index, item in pairs(allOwnedItems) do
            if DGF:Slot2VirtualSlot(item.item.info.equipslot) == slot and (not secondTheBest or item.score > secondTheBest.score) and item.score <= theBest.score and theBest ~= item then
                secondTheBest = item
            end
        end
    end

    if not theBest then
        DGF:Print("-none")
    end

    if theBest then
        DGF:Print("AMONG POSSESSED THE BEST IS:"..theBest.link, " itemId:", theBest.item.info.itemid, " (SCORE: ", theBest.score, ")")
    else
        DGF:Print("THE BEST WAS NOT FOUND AMONG POSSESSED")
    end

    if secondTheBest and secondTheBest ~= theBest and isDoubleSlot then
        return secondTheBest
    else
         return theBest
    end
  
end

function DGF:CanBeGearObtaind(gearId)
    if not DGF.gearId2DroppedByBoss_map[gearId] then
    
        if DugisGearFinder.gearId2LevelRange[gearId] then
            return true
        end
    
        --Checking if all quests are not completed
        local allRelatedQuests = DGF.gearId2Quests_map[gearId]
        local allQuestsCompleted = true

        if allRelatedQuests then
            for questId, _ in pairs(allRelatedQuests) do
                if not DGF:IsQuestCompleted(questId) then
                    allQuestsCompleted = false
                end
            end
        end

        if allQuestsCompleted then
            return false
        end
    end

    return true
end

--Returns the score of the guide (takes into account only not owned items)
function DGF:ScoreGuide(guideTitle, noThread, yields)
    local guideScore = 0
	
	if DGV.GearFinderScoreGuide_cache_v1 == nil then
		DGV.GearFinderScoreGuide_cache_v1 = {}
	end

    local gearIds = DGF.guideTitle2GearIds_map[guideTitle] or {}
	
	local gearControlSum = 0;
	
    for _, gearId in pairs(gearIds) do
		gearControlSum = gearControlSum + (tonumber(gearId) or 0)
	end
	
	if DGV.GearFinderScoreGuide_cache_v1[guideTitle..gearControlSum] then
		return DGV.GearFinderScoreGuide_cache_v1[guideTitle..gearControlSum]
	end

    if not yields then
        yields = 0
    end

    local level = UnitLevel("player")

    local itemId2IsOwned = DGF:GetAllOwnedItemIds(noThread)

    for _, gearId in pairs(gearIds) do

        local shouldBeConsidered = true

        if itemId2IsOwned[gearId] == true then
            shouldBeConsidered = false
        end

        if not DGF:CanBeGearObtaind(gearId) then
            shouldBeConsidered = false
        end

       if shouldBeConsidered then
           local itemInfo = DGF:GetItemInfoById(gearId, noThread ~= true)

            if itemInfo ~= nil then
                if not noThread then
					LuaUtils:RestIfNeeded(true)
                    LuaUtils:WaitForCombatEnd()
                end

               local uniqueInventorySlot = GetDefaultUniqueInventorySlot(itemInfo.info.equipslot)
               local score = GA.CalculateScore(itemInfo.info.itemlink, GA:GetPlayerSpecKey())
               guideScore = guideScore + score
           else
           end
       end
    end

	DGV.GearFinderScoreGuide_cache_v1[guideTitle..gearControlSum] = guideScore
    return guideScore
end

--gearGuidesSet - set of guides to analyse. If nil then = DGF.allGearGuides
function DGF:GetTheBestGuide(gearGuidesSet, noThread, yields)
    if not gearGuidesSet then
        gearGuidesSet = DGF.allGearGuides
    end

    local theBestTitle, theBestScore, theBestIndex = nil, nil, nil
    if gearGuidesSet then
        for index, guideTitle in pairs(gearGuidesSet) do

            LuaUtils.Profiler:Start("ScoreGuide")
            local guideScore = DGF:ScoreGuide(guideTitle, noThread, yields)
            LuaUtils.Profiler:Stop("ScoreGuide")

            if theBestScore == nil or guideScore > theBestScore then
                theBestScore = guideScore
                theBestTitle = guideTitle
                theBestIndex = index
            end
        end
    end

    return theBestTitle, theBestScore, theBestIndex
end

--Returns theBestTitle, related gearInfo
function DGF:GetTheBestGuideForGearId(gearId, noThread, yields)
    local gearInfos = DGF.gearId2GearInfos_map[gearId]
    local guidesList = {}

    local filters = DGF:GetDifficultyFilters()

    for _, gearInfo in pairs(gearInfos) do
        --Filtering by difficulty:
        local passedByFilter = false
        local difficulty = gearInfo.dungeonDifficulty

        if difficulty == nil or filters[difficulty] then
            guidesList[#guidesList + 1] = gearInfo.guideTitle
        end
    end
    local theBestTitle, theBestScore, theBestIndex = DGF:GetTheBestGuide(guidesList, noThread, yields)

    if theBestTitle then
        return theBestTitle, gearInfos[theBestIndex]
    end
end

local allowedWeaponClassNames = {}
local allowedArmoClassNames = {}


local function addItem2itemsBySlot(item)

    local equipslot = item.info.equipslot

  --  if IsEquipment(equipslot) then
        local virtualSlot = DGF:Slot2VirtualSlot(equipslot)

        if not DGF.itemsBySlot[virtualSlot] then
            DGF.itemsBySlot[virtualSlot] = {}
        end

        --Filtering items by class and specialization
        local canBePassed = true

        if item.info.class == "Armor" then
            if not LuaUtils:isInTable(item.info.subclass, allowedArmoClassNames) then
                --TODO
               -- canBePassed = false
            else
            end
        end
        if item.info.class == "Weapon" then
            if not LuaUtils:isInTable(item.info.subclass, allowedWeaponClassNames) then
                --TODO
              --  canBePassed = false
            else
            end
        end

        if canBePassed then
            DGF.itemsBySlot[virtualSlot][item.info.itemid] = item
        else
        end
 --   else
  --  end

end

--Updating suggested gears in case settings were changed
function DGV.OnGearFinderSettingsChanged()
    DGF:CacheItemsForGearFinder()
end

--Updates data needed by GearFinder for calculations. It collects for example current owned gears.
function DGF:UpdateDynamicDataForGearFinder()
    if LuaUtils:ThreadInProgress("UpdateDynamicDataForGearFinder") or LuaUtils:ThreadInProgress("CacheItemsForGearFinder") or LuaUtils:ThreadInProgress("SetSuggestedItemGuides")  then
        return
    end

    LuaUtils:CreateThread("UpdateDynamicDataForGearFinder", function()

        --If it is before GearAdvisor initialization return
        while not GeadAdvisorItemIterator or UnitAffectingCombat("player") or 
        LuaUtils:ThreadInProgress("SetSuggestedItemGuides") or LuaUtils:ThreadInProgress("CacheItemsForGearFinder") do
            LuaUtils:RestIfNeeded(true)
        end

        itemId2IsOwned = {}
        for control, iteratedItemLink in GeadAdvisorItemIterator, itemInvariant do
            if iteratedItemLink then
                itemId2IsOwned[iteratedItemLink] = true
            end
        end
        
        local allOwnedItems_ = DGF:GetAllOwnedItems()

        if allOwnedItems_ then
            allOwnedItems = allOwnedItems_
        end

        --- Updating Allowed subclasses
        local GA = DGV.Modules.GearAdvisor
        --[[
        if GA and DugisGuideViewer:IsModuleLoaded("GearAdvisor") then
            local allowedWeaponSubclassIndices = GA:GetGearAdvisorScoringValues("LE_ITEM_CLASS_WEAPON")
            local allowedArmorSubclassIndices = GA:GetGearAdvisorScoringValues("LE_ITEM_CLASS_ARMOR")

            local allWaponSubclasses = GetAuctionItemSubClasses_dugis(1)
            local allArmorSubclasses = GetAuctionItemSubClasses_dugis(2)

            allowedWeaponClassNames = {}
            allowedArmoClassNames = {}

            for _, index in pairs(allowedWeaponSubclassIndices) do
                local index = tonumber(index)
                allowedWeaponClassNames[#allowedWeaponClassNames + 1] = allWaponSubclasses[index]
            end

            for _, index in pairs(allowedArmorSubclassIndices) do
                local index = tonumber(index)
                allowedArmoClassNames[#allowedArmoClassNames + 1] = allArmorSubclasses[index]
            end
        end     
        ]]   
        
    end)
end

function DGF.ItemInfoEventHandler(self, event, ...)
    if event == "GET_ITEM_INFO_RECEIVED" then
        local itemId = ...
        
        --Protecting from adding not needed items
        if not DGF.gearId2GearInfos_map[itemId] and not itemId2IsOwned[itemId] then
            return
        end

        local item = DGF:GetItemInfoById(itemId, false)

        if item then
            addItem2itemsBySlot(item)
        end
    end
    
    if event == "PLAYER_EQUIPMENT_CHANGED" then
        DugisGearFinder:UpdateDynamicDataForGearFinder()
    end 
    
    if event == "PLAYER_SPECIALIZATION_CHANGED" then
		DGF:BuildSlots()
		if GetSpecialization() ~= DugisGuideViewer.specializaton then
			DGV.OnGearFinderSettingsChanged()
			DugisGuideViewer.specializaton = GetSpecialization()
		end
    end
end

function DGF:MakeSuggestions()
    if GearFinderPreloader then
      GearFinderPreloader:Hide()
      DGF.preloaderAnimationGroup:Stop()
    end

    LuaUtils:CreateThread("SetSuggestedItemGuides", function()
            if GearFinderPreloader then
                GearFinderPreloader:Show()
                DGF.preloaderAnimationGroup:Play()
            end
            DGF:SetSuggestedItemGuides()
        end,
        function()
            if GearFinderPreloader then
                GearFinderPreloader:Hide()
                DGF.preloaderAnimationGroup:Stop()
            end
        end
    )
end


local cacheIntensity = 50
local CacheItemsForGearFinder_invoked = false
local CacheItemsForGearFinderIsInQueue = false

function DGF:CacheItemsForGearFinder()
    --Preventing invoked caching many times on settings change
    if CacheItemsForGearFinderIsInQueue then
        return
    end
    
    LuaUtils:CreateThread("WaitForCacheItemsForGearFinderEnd", function()
    
        GearFinderPreloader:Show()
        DGF.preloaderAnimationGroup:Play()
    
        CacheItemsForGearFinderIsInQueue = true
        while LuaUtils:ThreadInProgress("CacheItemsForGearFinder") do
            coroutine.yield()
        end

		if allowedWeaponClassNames == nil or allowedArmoClassNames == nil or (#allowedWeaponClassNames == 0 and #allowedArmoClassNames == 0) then
			DugisGearFinder:UpdateDynamicDataForGearFinder()
        end	
        
		while LuaUtils:ThreadInProgress("UpdateDynamicDataForGearFinder") do
            coroutine.yield()
        end

        LuaUtils:CreateThread("CacheItemsForGearFinder", function()
            while  LuaUtils:ThreadInProgress("UpdateDynamicDataForGearFinder") or LuaUtils:ThreadInProgress("SetSuggestedItemGuides")  do
                coroutine.yield()
            end

            CacheItemsForGearFinderIsInQueue = false
        
            if CacheItemsForGearFinder_invoked then
                return
            end

            CacheItemsForGearFinder_invoked = true

            DGV.InitializeGearFinderData()

            local allGearsAmount = #DGF.allGearIds

            for i=1, #DGF.allGearIds do
                LuaUtils:RestIfNeeded(true)

                local itemInfo = DGF.allGearIds[i]

                if type(itemInfo.gearId) == "string" then
                    local item = DGF:GetItemInfoById(itemInfo.gearId, true, itemInfo)
                    
                    --Speeding up the caching
                    for j = i, i + 10 do
                        if DGF.allGearIds[j] then
                           GetItemInfo(DGF.allGearIds[j].gearId)
                        end
                    end
                    
                    if item then
                        addItem2itemsBySlot(item)
                    end
                else
                    local name = GetItemInfo(itemInfo.gearId)

                    --Available in game cache
                    if name then
                        local item = DGF:GetItemInfoById(itemInfo.gearId, true, itemInfo)
                        if item then
                            addItem2itemsBySlot(item)
                        end
                    end
                end

                local progress = (LuaUtils:Round(100 * i/allGearsAmount/3, 0) * 3)
                if progress == 0 then progress = 3 end
                GearFinderPreloader.TexWrapper.Text:SetText("Preparing "..progress.."%..")
            end

            return "success"

        end,
        --on end
        function()


            DGF:MakeSuggestions()
        end
        , 1, 0.01)
            
        
    end)

end

function DGF:GetSuggesedGearBySlot(invslot, yields, slotButton)

    if not yields then
        yields = 1
    end

    if not DGF.itemsBySlot[invslot] then
        return nil
    end

    local ownedItemsIds = {}

    for index, value in pairs(allOwnedItems) do
       ownedItemsIds[value.item.info.itemid] = true
    end

    local level = UnitLevel("player")
    local _, characterClass = UnitClass("player")

    if not DGF.itemsBySlot[invslot] then
        return
    end
    local itemsBelowPlayerLevel = {}
    local itemsAbovePlayerLevel = {}	-- upgrades with restrictions

    local theBestForSlot = DGF:GetTheBestOwnedItemBySlot(invslot, true)

    local amount = 0

    for _, _ in pairs(DGF.itemsBySlot[invslot]) do
        amount = amount + 1
    end

    local filters = DGF:GetDifficultyFilters()

    slotButton.middleLabel:SetText("Loading...")
    slotButton.itemTexture:Hide()

    local i = 0

    for itemId, item in pairs(DGF.itemsBySlot[invslot]) do

            i = i + 1
            if amount > 0 then
                slotButton.bottomLabel:SetText("|cFF888888"..(LuaUtils:Round(100 * i/amount/5, 0) * 5).."%|r")
            end

            local uniqueInventorySlot = GetDefaultUniqueInventorySlot(item.info.equipslot)

            LuaUtils:RestIfNeeded(true)

            local tooLowPlayerLevel = ((item.info.reqlevel ~= nil and item.info.reqlevel ~= 0 and level < item.info.reqlevel)
            or (item.info.reqlevelByQuest ~= nil and item.info.reqlevelByQuest ~= 0 and level < item.info.reqlevelByQuest))

            local itemRequiredLevelDiff = item.info.reqlevel ~= nil and (item.info.reqlevel - level)
            local questRequiredLevelDiff = item.info.reqlevelByQuest ~= nil and (item.info.reqlevelByQuest - level)

            --Filtering already owned:
            local itemAlreadyOwned = ownedItemsIds[item.info.itemid]
            --Filtering by difficulty:
            local passedByFilter = false
            local difficulties = DGF.gearId2PossibleDifficulties_map[item.info.itemid]
            if difficulties == nil then
                difficulties = {}
            end
            for difficultyId, v in pairs(difficulties) do
                if difficultyId == "empty-difficulty" or filters[difficultyId] then
                    passedByFilter = true
                    break
                end
            end
            
            local passedByLevelRange = true
            
            if DugisGearFinder.gearId2LevelRange[itemId] then
                local levelMin = DugisGearFinder.gearId2LevelRange[itemId][1]
                local levelMax = DugisGearFinder.gearId2LevelRange[itemId][2]
                
                if levelMax and level > levelMax then
                    passedByLevelRange = false
                end
                
                if levelMin and level < levelMin then
                    passedByLevelRange = false
                end
            end            

            local passedByArmorSpecBonusExclusion = true
            local slot = DGF:Slot2VirtualSlot(item.info.equipslot)


            --Filtering by option "Search for quest gears"
            local passedByQuestsGears = itemId ~= nil and ((DGF.gearId2Quests_map[itemId] and (DGF.gearId2Quests_map == nil or (
            DGV:UserSetting(DGV_GEARS_FROM_QUEST_GUIDES) == true
            or not DGF.gearId2Quests_map[itemId].amountMoreThan0)) ) or (DGF.gearId2isReputation and DGF.gearId2isReputation[itemId] == true) )  

            --Checking for allowed armor
            local passedByArmorType = true

            if IsArmorSpecSlot(slot) then
                if characterClass == "PRIEST" or characterClass == "MAGE" or characterClass == "WARLOCK" then
                    if item.info.subclass ~= "Cloth" then
                        passedByArmorType = false
                    end
                end

                if characterClass == "DRUID" or characterClass == "ROGUE" then
                    if item.info.subclass ~= "Cloth" and item.info.subclass ~= "Leather" then
                        passedByArmorType = false
                    end
                end

                if characterClass == "HUNTER" then
                    if item.info.subclass ~= "Cloth" and item.info.subclass ~= "Leather" then
                        if item.info.subclass == "Mail" then 
                            if level < 40 then
                                passedByArmorType = false
                            end
                        else
                            passedByArmorType = false
                        end
                    end
                end
 
                if characterClass == "WARRIOR" or characterClass == "PALADIN" or characterClass == "DEATHKNIGHT" then
                    if item.info.subclass == "Plate" then 
                        if level < 40 then
                            passedByArmorType = false
                        end
                    end
                end

            end

            --Filtering by already existing the best score

            local passed = not itemAlreadyOwned
            and DGF:CanBeGearObtaind(itemId)
            and passedByFilter
            and passedByQuestsGears
            and passedByArmorType
            and passedByArmorSpecBonusExclusion
            and passedByLevelRange

            if passed
            then
				LuaUtils:RestIfNeeded(true)
				LuaUtils:WaitForCombatEnd()
            
                local score = GA.CalculateScore(item.info.itemlink, GA:GetPlayerSpecKey())
                
                local rightScore = true
                if theBestForSlot and theBestForSlot.score >= score then
                  --todo test
                     rightScore = false
                end

                if rightScore then
                    if tooLowPlayerLevel then
                        if itemRequiredLevelDiff then
                            if itemRequiredLevelDiff <= maxRequiredLEvelDifference then
                                tinsert (itemsAbovePlayerLevel,{item=item,score=score})
                            end
                        else
                            if questRequiredLevelDiff then
                                if questRequiredLevelDiff <= maxRequiredLEvelDifference then
                                    tinsert (itemsAbovePlayerLevel,{item=item,score=score})
                                end
                            end
                        end    
                    else
                        if rightScore then
                            tinsert (itemsBelowPlayerLevel,{item=item,score=score})
                        end
                    end
                end
            else
        end
    end

    --Sorting itemsBelowPlayerLevel by score (from hight to low)  {highest, ..., lowest}
    table.sort(itemsBelowPlayerLevel, function(a,b)
        return a.score > b.score
    end)

     --Sorting itemsAbovePlayerLevel by required level  Sorted from low to high
    table.sort(itemsAbovePlayerLevel, function(a,b)
        local lvla = a.item.info.reqlevel
        local lvlb = b.item.info.reqlevel

        if a.item.info.reqlevelByQuest ~= nil then
            lvla = a.item.info.reqlevelByQuest
        end

        if b.item.info.reqlevelByQuest ~= nil then
           lvlb = b.item.info.reqlevelByQuest
        end

        if lvla == lvlb then
            return a.score > b.score
        end

        return lvla < lvlb
    end)
    DGF:Print("-------------------------")
    DGF:Print("--SET  \"Below\" of items: ",invslot,"  (please see google doc, possessed are excluded, limit "..listItemsLimit.." items, so some may not be displayed)")
    for i=1, #itemsBelowPlayerLevel do
        if i < listItemsLimit then
            DGF:Print("#",i, invslot,  ItemName(itemsBelowPlayerLevel[i]), itemsBelowPlayerLevel[i].item.info.itemid, "SCORE: ", itemsBelowPlayerLevel[i].score, " Req lvl:", itemsBelowPlayerLevel[i].item.info.reqlevel, " Req lvl by guide:", itemsBelowPlayerLevel[i].item.info.reqlevelByQuest  )
        end
    end
    DGF:Print("--SET \"Above\" of items: ", invslot,"  (please see google doc, possessed are excluded, limit "..listItemsLimit.." items, so some may not be displayed)")
    for i=1, #itemsAbovePlayerLevel do
        if i < listItemsLimit then
            DGF:Print("#",i, invslot, ItemName(itemsAbovePlayerLevel[i]), itemsAbovePlayerLevel[i].item.info.itemid, "SCORE: ", itemsAbovePlayerLevel[i].score, " Req lvl:", itemsAbovePlayerLevel[i].item.info.reqlevel, " Req lvl by guide:", itemsAbovePlayerLevel[i].item.info.reqlevelByQuest   )
        end
    end

    -- STEP 1 (https://docs.google.com/document/d/1pPHzCCmkcLuFGGat8qZJTc54uPpldOFJWSlH8aoa610/edit)

    if #itemsBelowPlayerLevel > 0 then
        --todo descruption - log
        DGF:Print("STEP 1 (the best possessed for slot doesn't exist)...")
        DGF:Print("**** SUGGESTED GUIDE: ",invslot, ItemName(itemsBelowPlayerLevel[1]), itemsBelowPlayerLevel[1].item.info.itemid, "  Req lvl:", itemsBelowPlayerLevel[1].item.info.reqlevel, " Req lvl by guide:", itemsBelowPlayerLevel[1].item.info.reqlevelByQuest )

        local top5Suggestions = {}
        for i=1, 5 do
            if itemsBelowPlayerLevel[i] then
                top5Suggestions[#top5Suggestions + 1] = itemsBelowPlayerLevel[i]
            end
        end

        if #top5Suggestions < 5 and #itemsAbovePlayerLevel > 0 then
            for i = 1, 5 do
                if #top5Suggestions < 5 and itemsAbovePlayerLevel[i] then
                    top5Suggestions[#top5Suggestions + 1] = itemsAbovePlayerLevel[i]
                end
            end
        end

        return itemsBelowPlayerLevel[1], top5Suggestions
    end

    -- STEP 2
    if #itemsAbovePlayerLevel > 0 then
        DGF:Print("STEP 2")
        DGF:Print("**** SUGGESTED GUIDE: ", invslot,  ItemName(itemsAbovePlayerLevel[1])..(" Req lvl: "..itemsAbovePlayerLevel[1].item.info.reqlevel.." Req lvl by guide: ".. (itemsAbovePlayerLevel[1].item.info.reqlevelByQuest or "nil")), itemsAbovePlayerLevel[1].item.info.itemid)

        local top5Suggestions = {}
        for i=1, 5 do
            if itemsAbovePlayerLevel[i] then
                top5Suggestions[#top5Suggestions + 1] = itemsAbovePlayerLevel[i]
            end
        end
        return  itemsAbovePlayerLevel[1], top5Suggestions
    end
end

local inSetSuggestedItemGuides = false

function DGF:SetSuggestedItemGuides()

    if inSetSuggestedItemGuides then
        return
    end

    inSetSuggestedItemGuides = true
    DGF:HideExtraButtonsFrame()

    LuaUtils.Profiler:Start("SetSuggestedItemGuides")
    ----------------to be optimized

    GearFinderPreloader.TexWrapper.Text:SetText("Searching for gears")

    local yields = CALCULATIONS_TIME_FOR_FILLED_CACHE
    if not DugisCharacterCache.CalculateScore_cache_v12.hasItems then
        yields = CALCULATIONS_TIME_FOR_EMPTY_CACHE
    end

    LuaUtils.Profiler:Start("Searching for gears")
    for _, slotButton in pairs(itemButtons) do

        local slot = slotButton.slot
        local suggestedItem, top5suggestions = DGF:GetSuggesedGearBySlot(slot, yields, slotButton)

        slotButton.suggestedGuide = nil

        if suggestedItem then
            local theBestGuide = DGF:GetTheBestGuideForGearId(suggestedItem.item.info.itemid, false, yields)
            local shortName = ItemName(suggestedItem)
            local slotText = DGF:LocalizeSlot(slotButton.slot)

            local requiredLevelInfo = ""

            if not DGF:PlayerHasEnoughLevel(suggestedItem) then

                local lvl = suggestedItem.item.info.reqlevel

                if suggestedItem.item.info.reqlevelByQuest ~= nil then
                    lvl = suggestedItem.item.info.reqlevelByQuest
                end

                if string.len(slotText) > 15 then
                    requiredLevelInfo = " |c00FF0000@L"..lvl.."|r"
                else
                    requiredLevelInfo = " |c00FF0000@ Level "..lvl.."|r"
                end
            end

            local r, g, b, hex = GetItemQualityColor(suggestedItem.item.info.quality)
            slotButton.middleLabel:SetText("|c"..hex..suggestedItem.item.info.name.."|r")
            local formattedTitle = theBestGuide
            if DugisGuideViewer.GetFormattedTitle then
               formattedTitle = DugisGuideViewer:GetFormattedTitle(theBestGuide)
            end

            slotButton.suggestedGuide = theBestGuide
            if formattedTitle then
                slotButton.bottomLabel:SetText("|cFFFFFFFF" .. formattedTitle .. "|r")
            end
            slotButton.bottomLabel:SetWidth(160)
            slotButton.middleLabel:SetWidth(160)

            slotButton.itemTexture:SetTexture( ItemTexture(suggestedItem))
            slotButton.itemTexture:Show()

            slotButton.topLabel:SetText(slotText..requiredLevelInfo)

            slotButton.suggestion = suggestedItem
            slotButton.top5suggestions = top5suggestions
            slotButton.middleLabel:Show()
        else
            local slotText = DGF:LocalizeSlot(slot)
            slotButton.topLabel:SetText(slotText)
            slotButton.bottomLabel:SetText("|cFF888888Cannot find better gear|r")
            slotButton.middleLabel:Hide()
            slotButton.top5suggestions = {}
            slotButton.suggestion = nil
            slotButton.itemTexture:Hide()
        end

        if slotButton.top5suggestions and #slotButton.top5suggestions >= 2 then
            slotButton.moreButton:Show()
        else
            slotButton.moreButton:Hide()
        end
    end
    ----------------END to be optimized
    LuaUtils.Profiler:Stop("Searching for gears")

    --Updating the best
    LuaUtils.Profiler:Start("Updating the best")

    LuaUtils.Profiler:Start("Searching for guide")

    GearFinderPreloader.TexWrapper.Text:SetText("Searching for guide")


    local atLeastOneBelowPlayerLevel = false

    for _, itemButton in pairs(itemButtons) do
        if itemButton.suggestedGuide and DGF:PlayerHasEnoughLevel(itemButton.suggestion) then
            atLeastOneBelowPlayerLevel = true
        end
    end

    local scoreByGuide = {}
    local theBestGuideScore = nil
    local theBestGuide = nil
    ----------------------------------
    --Searching for suggested guide by the best score
--   for _, itemButton in pairs(itemButtons) do
--       if itemButton.suggestedGuide and (DGF:PlayerHasEnoughLevel(itemButton.suggestion) or (atLeastOneBelowPlayerLevel == false)) then
--           local score = itemButton.suggestion.score
--           if theBestGuideScore == nil or theBestGuideScore < score then
--               theBestGuideScore = score
--               theBestGuide = itemButton.suggestedGuide
--           end
--       end
--   end
 
    --Searching for suggested guide by the highest score sum of suggested gears
    --{"guide title 1" => 30052, "guide title 2" => 3452}
    local guide2gearsScoreSum = {}
    for _, itemButton in pairs(itemButtons) do
        if itemButton.suggestedGuide and (DGF:PlayerHasEnoughLevel(itemButton.suggestion) or (atLeastOneBelowPlayerLevel == false)) then
            if not guide2gearsScoreSum[itemButton.suggestedGuide] then
                guide2gearsScoreSum[itemButton.suggestedGuide] = itemButton.suggestion.score
            else
                guide2gearsScoreSum[itemButton.suggestedGuide] = guide2gearsScoreSum[itemButton.suggestedGuide] + itemButton.suggestion.score
            end
        end
    end
    
    local theHighestSum = nil
    for guide, sum in pairs(guide2gearsScoreSum) do
        if theHighestSum == nil or sum > theHighestSum then
            theHighestSum = sum
            theBestGuide = guide
        end
    end
    
    -----------------------------------

    DugisGearFinderFrame.suggestedGuide.suggestedGuideTitle  = theBestGuide

    LuaUtils.Profiler:Stop("Searching for guide")
    if DugisGearFinderFrame.suggestedGuide.suggestedGuideTitle then
        local formattedTitle = DugisGearFinderFrame.suggestedGuide.suggestedGuideTitle
        if DugisGuideViewer.GetFormattedTitle then
           formattedTitle = DugisGuideViewer:GetFormattedTitle(DugisGearFinderFrame.suggestedGuide.suggestedGuideTitle)
        end

        DugisGearFinderFrame.suggestedGuideSubtitle:SetText("|cFFFFFFFF"..formattedTitle.."|r")
        DugisGearFinderFrame.suggestedGuideSubtitle:SetWordWrap(true)
        DugisGearFinderFrame.suggestedGuideSubtitle:SetWidth(150)
        DugisGearFinderFrame.suggestedGuideSubtitle:SetJustifyH("LEFT")
    else
        DugisGearFinderFrame.suggestedGuideSubtitle:SetText("-")
    end

    for index, box in pairs(itemButtons) do
        box:SetPoint("TOPLEFT", 0, -index * boxSize - DugisGearFinderFrame.suggestedGuideSubtitle:GetHeight() + 20)
    end

    LuaUtils.Profiler:Stop("Updating the best")


    LuaUtils.Profiler:Stop("SetSuggestedItemGuides")

    inSetSuggestedItemGuides = false
end




function DGF:UpdatetabsPosition()
    local isZygorLoaded = nil --DugisGuideViewer.zygorloaded

    local tabsShift = 0

    if isZygorLoaded then
        tabsShift = 24
    end

--    PaperDollSidebarTab3:SetPoint("BOTTOMRIGHT",PaperDollSidebarTabs,"BOTTOMRIGHT",-60 - tabsShift, 0)
end

function DGF:UpdateTabsForGearFinder()
    if DugisGuideViewer.chardb.EssentialsMode == 1 or not DugisGuideViewer:GuideOn() 
    or not DugisGuideViewer:UserSetting(DGV_ENABLEDGEARFINDER) then
        if DGF.gearFinderButton ~= nil then
            DGF.gearFinderButton:Hide()
        end
--        PaperDollSidebarTab3:SetPoint("BOTTOMRIGHT",PaperDollSidebarTabs,"BOTTOMRIGHT",-60, 0)
        return
    end

    DGF.gearFinderButton:Show()
    DGF:UpdatetabsPosition()

    DGF:CreateExtraItemsFrame()
    DGF:GearFinderTooltipFrame()

end

local InitializeGearFinder_invoked = false
function DGV.InitializeGearFinder(invokedByIUChange)
    if DugisGuideViewer.chardb.EssentialsMode ~= 1 and DugisGuideViewer:GuideOn() 
        and DugisGuideViewer:UserSetting(DGV_ENABLEDGEARFINDER) then
        DGF:InitializeGearFinderUI()
        if invokedByIUChange then
            HideUIPanel(CharacterFrame)
        end
    end

    if not InitializeGearFinder_invoked then
        CharacterFrame:HookScript("OnShow", function()
            DGF:UpdateTabsForGearFinder()
            if GearFinderTooltipFrame then
                GearFinderTooltipFrame:Hide()
            end
        end)

        CharacterFrame:HookScript("OnHide", function()
            HideGF()
        end)

        InitializeGearFinder_invoked = true
    end
end


