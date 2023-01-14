local _, L, GetCreateTable, YieldAutoroutine, GetRunningAutoroutine, BeginAutoroutine, GetItemSums,
    autoEquipReaction, tempIgnoreCache

local DGV = DugisGuideViewer
local GAE = DGV:RegisterModule("GearAdvisorEquip", "GearAdvisor")
if GAE then
    local GA = DGV.Modules.GearAdvisor
    local IS = DGV.Modules.ItemStats
    GAE.essential = true


    function GAE:Initialize()
        function GAE:Load()
            L, GetCreateTable, GetRunningAutoroutine, BeginAutoroutine, YieldAutoroutine, GetItemSums, tPool = 
            DugisLocals, DGV.GetCreateTable, DGV.GetRunningAutoroutine, DGV.BeginAutoroutine, DGV.YieldAutoroutine, DGV.Modules.ItemStats.GetItemSums, DGV.tPool
            local GetInventoryItemLink = GetInventoryItemLink
                

            local function IterateEquipSlots(standings, slot)
                if not slot then slot = INVSLOT_HEAD
                elseif slot == INVSLOT_RANGED then return
                elseif slot == INVSLOT_SHOULDER then slot = INVSLOT_CHEST -- skip shirt
                elseif slot == INVSLOT_FINGER2 then slot = INVSLOT_BACK -- skip trinkets
                else slot = slot + 1 end

                return slot, standings[slot]
            end

            local function ClearCompareLines()
                if not DugisEquipPromptFrame.compare then return end
                for _,fontString in ipairs(DugisEquipPromptFrame.compare) do
                    fontString:Hide()
                end
            end

            local function AddSetCompareLine(text, r, g, b, a)
                if not DugisEquipPromptFrame.compare then DugisEquipPromptFrame.compare = {} end
                local toSet
                for _,fontString in ipairs(DugisEquipPromptFrame.compare) do
                    if not fontString:IsShown() then
                        toSet = fontString
                        break
                    end
                end
                if not toSet then
                    toSet = DugisEquipPromptFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                    toSet:SetJustifyH("LEFT")
                    toSet:SetJustifyV("TOP")
                    tinsert(DugisEquipPromptFrame.compare, toSet)
                    if #DugisEquipPromptFrame.compare==1 then
                        toSet:SetPoint("TOPLEFT", DugisEquipPromptFrame.recommended, "TOPRIGHT", 15, 0)
                    else
                        toSet:SetPoint("TOPLEFT", DugisEquipPromptFrame.compare[#DugisEquipPromptFrame.compare-1], "BOTTOMLEFT")
                    end
                end
                toSet:SetHeight(13)
                toSet:SetWidth(1000)
                toSet:SetText(text)
                local width = toSet:GetStringWidth()
                if width>170 then
                    toSet:SetHeight(13+math.floor(width/160)*13)
                end
                if r then
                    toSet:SetTextColor(r,g,b)
                end
                toSet:SetWidth(170)
                toSet:Show()
            end

            local function FindEquip(slot, itemLink, containerItemIterator)
                local invariant = GetCreateTable():BindToAutoroutineLifetime(tPool)
                for _,containerItemLink in containerItemIterator, invariant do
                    if itemLink==containerItemLink then
                        PickupContainerItem(invariant.bag, invariant.slot)
                        PickupInventoryItem(slot)
                        invariant:Pool()
                        return true
                    end
                end
                for control,inventoryItemLink in GA.InventoryItemIterator do
                    if itemLink==inventoryItemLink then
                        PickupInventoryItem(control)
                        PickupInventoryItem(slot)
                        invariant:Pool()
                        return true
                    end
                end
                invariant:Pool()
            end
            
            local function Equip(slot, itemLink)
                if itemLink~=nil then
                    return FindEquip(slot, itemLink, GA.BagItemIterator) or FindEquip(slot, itemLink, GA.BankItemIterator)
                end
            end

            local function GetItemStats(itemLink, statTable)
                local itemSums = GetCreateTable():BindToAutoroutineLifetime(tPool)
                GetItemSums(itemLink, itemSums)
                for statKey, value in next, itemSums do
                    local short = IS.GetLocalStatShort(statKey)
                    if short then
                        statTable[short] = value
                    end
                end
                itemSums:Pool()
            end

            local function GetItemStatDelta(itemLink, currentItemLink, statTable)
                local itemSums = GetCreateTable():BindToAutoroutineLifetime(tPool)
                GetItemSums(itemLink, itemSums)
                local currentItemSums = GetCreateTable():BindToAutoroutineLifetime(tPool)
                GetItemSums(currentItemLink, currentItemSums)
                for statKey, currentValue in next, currentItemSums do
                    local short = IS.GetLocalStatShort(statKey)
                    if short then
                        local value = (currentValue * -1) + (itemSums[statKey] or 0)
                        statTable[short] = value
                    end
                end
                for statKey, value in next, itemSums do
                    local short = IS.GetLocalStatShort(statKey)
                    if short and not statTable[short] then
                        statTable[short] = value
                    end
                end
                itemSums:Pool()
                currentItemSums:Pool()
            end

            tempIgnoreCache = GetCreateTable()
            function EquipOrPrompt(slot, itemLink, showPrompt, remaining)
                if not itemLink then return end
                if tContains(tempIgnoreCache, itemLink..slot) then return end --avoids nagging over and over for the same piece in the same slot without long term ban listing (reset by manual gear set equip or reload ui)
                local currentItemLink = GetInventoryItemLink("player", slot)
                remaining = remaining and remaining-1
                if currentItemLink==itemLink then
                    return true, showPrompt, remaining
                end
                if not showPrompt or not DGV:UserSetting(DGV_SHOWAUTOEQUIPPROMPT) then --commented to show prompt if slot is empty
                    Equip(slot, itemLink)
                    return true, showPrompt, remaining
                else
                    DugisEquipPromptFrame.slot = slot
                    DugisEquipPromptFrame.recommended.item = itemLink
                    DugisEquipPromptFrame.recommended.title = L["Equip recommended item:"]
                    DugisEquipPromptFrame.action = "EQUIP"
                    DugisEquipItemHighlight:SetPoint("TOPLEFT", DugisEquipPromptFrame.recommended.itemButton, "TOPLEFT", -8, 7)
                    DugisEquipItemHighlight:Show()

                    DugisEquipPromptFrame.forAll:Enable()
                    DugisEquipPromptFrame.forAll.text:SetTextColor(1.0, 0.82, 0)
                    if remaining and remaining>0 then
                        DugisEquipPromptFrame.forAll:SetChecked(false)
                        DugisEquipPromptFrame.forAll.text:SetText(L["Do above for remaining %d items"]:format(remaining))
                        DugisEquipPromptFrame.forAll:Show()
                    else
                        DugisEquipPromptFrame.forAll:Hide()
                    end
                    DugisEquipPromptFrame.blacklist:SetChecked(false)
                    DugisEquipPromptFrame.blacklist.text:SetText(L["Add %s to ban list"]:format(itemLink))
                    DugisEquipPromptFrame.blacklist.text:SetWidth(352)
                    DugisEquipPromptFrame.blacklist.text:SetJustifyH("LEFT")

                    ClearCompareLines()
                    local statTable = GetCreateTable()
                    if currentItemLink then
                        DugisEquipPromptFrame.existing.item = currentItemLink
                        DugisEquipPromptFrame.existing.title = L["Or keep equipped item:"]
                        GetItemStatDelta(itemLink, currentItemLink, statTable)
                        AddSetCompareLine(ITEM_DELTA_DESCRIPTION)
                    else
                        DugisEquipPromptFrame.existing.item = nil
                        DugisEquipPromptFrame.existing.title = L["Or leave slot empty:"]
                        GetItemStats(itemLink, statTable)
                        AddSetCompareLine(L["Item has the following stats:"])
                    end
                    
                    if DGV:UserSetting(DGV_ENABLED_GEAR_NOTIFICATIONS) and DugisGuideViewer:NotificationsEnabled() then
                        local notificationTitle = "Gear Upgrade Suggested"
                        local notification =  DugisGuideViewer:GetNotificationByTitle(notificationTitle)
                        
                        DugisEquipPromptFrame.dontRemoveNotificationOnCancel = false
                        
                        if notification == nil then
                            notification = DugisGuideViewer:AddNotification({title = notificationTitle
                            , notificationType = "gear-suggestion" })
                            DugisGuideViewer:ShowNotifications()   
                            DugisGuideViewer.RefreshMainMenu()
                        end
                        
                        DugisEquipPromptFrame.notificationId = notification.id
                        
                        if DGV:UserSetting(DGV_ALWAYS_SHOW_STANDARD_PROMPT_GEAR) then
                            --Old standard prompt
                            DugisEquipPromptFrame:Show()
                            DugisEquipPromptFrame.dontRemoveNotificationOnCancel = true
                        end
                    else
                        --Old standard prompt
                        DugisEquipPromptFrame:Show()
                    end
                    DugisEquipPromptFrame.compare[1]:Hide()
                    for statShort, value in next, statTable do
                        if value and type(value)=="number" then
                            DugisEquipPromptFrame.compare[1]:Show()
                            local color = "ff00ff00"
                            if value < 0 or (statShort == SPEED and value > 0) then
                                color = "ffff2020"
                            end
                            if mod(value, 1)==0 then
                                AddSetCompareLine(L["|c%s%d|r %s"]:format(color, value, statShort), 1, 1, 1) --Localization: enUS uses number-space-statname
                            else
                                AddSetCompareLine(L["|c%s%.1f|r %s"]:format(color, value, statShort), 1, 1, 1)
                            end
                        end
                    end
                    statTable:Pool()
                end
            end

            local function ContinueEquipSpec(specKey, showPrompt, slot)
                local standings = GetCreateTable():BindToAutoroutineLifetime(tPool)
                GA.ScoreCarriedEquipment(specKey, standings, true)
                GA.ScoreBankEquipment(specKey, standings, true)
                YieldAutoroutine()
                local diff = GetCreateTable()
                for control in IterateEquipSlots, standings, slot do
                    local itemLink = standings[control]
                    local currentItemLink = GetInventoryItemLink("player", control)
                    if itemLink and itemLink~=currentItemLink then
                        diff:Insert(control)
                    end
                end
                local continue, showPrompt, remaining = nil, showPrompt, diff:Length()
                for _,control in diff:IPairs() do
                    local itemLink = standings[control]
                    continue, showPrompt, remaining = EquipOrPrompt(control, itemLink, showPrompt, remaining)
                    YieldAutoroutine()
                    if not continue then break end
                end
                diff:Pool()
                standings:Pool()
            end
            
            local function ContinueEquipRoutine(showPrompt, slot)
                local itemClass, itemSubclass
                local mainLink = GetInventoryItemID("player", INVSLOT_MAINHAND)
                if mainLink then
                    itemClass, itemSubclass = select(6,GetItemInfoInstant(mainLink))
                end
                if itemClass==LE_ITEM_CLASS_WEAPON and itemSubclass==LE_ITEM_WEAPON_FISHINGPOLE then
                    ContinueEquipSpec("FISHING", showPrompt, slot)
                else
                    for _, specKey, specName in IteratePrioritizedWinCriteria do
                        if specKey ~= WIN_CRITERIA_COIN then
                            ContinueEquipSpec(specKey, showPrompt, slot)
                            break
                        end
                    end
                end
            end

            function ContinueEquip(showPrompt, slot)
                if GetRunningAutoroutine("ContinueEquipRoutine") then return end
                BeginAutoroutine("ContinueEquipRoutine", ContinueEquipRoutine, showPrompt, slot)
            end
            GAE.ContinueEquip = ContinueEquip

            autoEquipReaction = DGV.RegisterReaction("BAG_UPDATE")
                :Or(DGV.RegisterReaction("PLAYER_EQUIPMENT_CHANGED"))
                :Or(DGV.RegisterReaction("BANKFRAME_OPENED"))
                :WithPredicate(function() return DGV:UserSetting(DGV_AUTOEQUIP) end)
                :WithAction(ContinueEquip, true, nil)
                :InvokePassively()
                :Defer()
                :OutOfCombat()

            function GAE:OnPromptHidden(prompt)
                prompt.action = not prompt.blacklist:GetChecked() and prompt.action
                local quit = (prompt.forAll:GetChecked() and prompt.action == "SKIP") or prompt.action == "CANCEL"
                local doTheSameForAll = prompt.forAll:GetChecked()
                if prompt.blacklist:GetChecked() then
                    if not DGV.chardb.GA_Blacklist then DGV.chardb.GA_Blacklist = {} end
                    DGV.chardb.GA_Blacklist[DGV:GetItemIdFromLink(prompt.recommended.item)] = true
                end
                if prompt.action == "EQUIP" then
                    Equip(prompt.slot, prompt.recommended.item)
                elseif prompt.action == "SKIP" then
                    tinsert(tempIgnoreCache, prompt.recommended.item..prompt.slot)
                end
                if not quit then
                    ContinueEquip(not doTheSameForAll, prompt.slot)
                end
            end

            function GAE:OnGearOptionClicked(button)
                if button==DugisEquipPromptFrame.recommended then
                    DugisEquipPromptFrame.action="EQUIP"
                else
                    DugisEquipPromptFrame.action="SKIP"
                end
            end

            function GAE:GetSlotBackgroundInfo(slot)
                local slotFrame = DGV.ListContains(slot,
                    function(frame)
                        return (GetInventorySlotInfo(strsub(frame:GetName(),10)));
                    end,
                    PaperDollItemsFrame:GetChildren())
                return _G[strupper(strsub(slotFrame:GetName(), 10))], slotFrame.backgroundTextureName
            end
        end

        function GAE:Unload()
            autoEquipReaction:Dispose()
            tempIgnoreCache:Pool()
        end
    end
end