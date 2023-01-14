local DGV, L, DropDown = DugisGuideViewer, DugisLocals, LuaUtils.DugisDropDown, GetCreateTable
local GAS = DGV:RegisterModule("GearAdvisorSettings", "GearAdvisor")
local AceGUI = LibStub("AceGUI-3.0")

if GAS then
    GAS.essential = true

    function GAS:Initialize()
        function GAS:Load()
            local IterateSpecData, IterateLocalStatsAndShorts, GetCreateTable = DGV.Modules.GearAdvisorData.IterateSpecData, DGV.Modules.ItemStats.IterateLocalStatsAndShorts, DGV.GetCreateTable

            local function HideStatWeights()
                local i,frame = 2
                repeat
                    frame = _G["DugisStatWeight"..i]
                    if frame then 
                        UIDropDownMenu_SetSelectedValue(frame.StatDropDown, -1);
                        frame.WeightEdit:SetText("")
                        frame:Hide() 
                    end
                    i = i + 1
                until(not frame)
            end

            local function EnsureStatWeightFrame(parent, index)
                local name = "DugisStatWeight"..index
                local weightFrame = _G[name]
                if not weightFrame then
                    weightFrame = CreateFrame("Frame", name, parent, "DugisStatWeightTemplate")
                    weightFrame:SetID(index)
                end
                if index~=1 then
                    local previousWeight = _G["DugisStatWeight"..(index-1)]
                    if previousWeight then
                        weightFrame:SetPoint("TOPLEFT", previousWeight, "BOTTOMLEFT", 0, -8)
                    end
                end
                weightFrame:Show()
                return weightFrame
            end


            local frameWeights 

            function RefreshCustomWeights(frame)
                frameWeights = frameWeights or frame
                HideStatWeights()
                local specKey = DugisCustomWeightsDropdown.selectedValue
                if not specKey then return end
                local i = 1
                for statKey, statTable in IterateSpecData, specKey do
                    if statKey then
                        local swFrame = EnsureStatWeightFrame(frameWeights, i)
                        UIDropDownMenu_SetSelectedValue(swFrame.StatDropDown, statKey);
                        swFrame.WeightEdit:SetText(statTable[1] or "")
                        i = i + 1
                    end
                end
                local swFrame = EnsureStatWeightFrame(frameWeights, i)
                UIDropDownMenu_SetSelectedValue(swFrame.StatDropDown, -1);
                swFrame.WeightEdit:SetText("")
            end

            local function ApplyWeights()
                for i=2, 1000 do 
                    local frame = _G["DugisStatWeight"..i]
                    if frame and not frame:IsShown() then
                        GAS.WeightEditChanged(frame)
                    else
                        return
                    end
                end
            end

            function GetScoresTextInfo(text)
                if text:find("Pawn: v1:") then
                    return "pawnv1"
                end
            end
        
            function ImportScoresFromText(text, frame)
                if GetScoresTextInfo(text) == "pawnv1" then
                    local weightHash = GetCreateTable()
                            
                    weightHash["Strength"]			= "STR"
                    weightHash["Agility"]			= "AGI"
                    weightHash["Intellect"]		= "INT"
                    weightHash["Stamina"]			= "STA"
                    weightHash["Spirit"]			= "SPI"
                    weightHash["Health"]           = "HEALTH"
                    weightHash["Mana"]             = "MANA"
        
                                
                    weightHash["CritRating"]		= "CRIT_RATING"
                    weightHash["HitRating"]		= "HIT_RATING"
                    weightHash["ExpertiseRating"]  = "EXPERTISE_RATING"
                    weightHash["HasteRating"]      = "HASTE_RATING"
                    weightHash["ArmorPenetration"] = "ARMOR_PENETRATION"
        
                    weightHash["SpellDamage"]		= "DAMAGE_SPELL_POWER"
                    weightHash["Healing"]			= "HEALING_SPELL_POWER"
                    weightHash["SpellPower"]       = "SPELL_POWER"
                    weightHash["SpellHitRating"]	= "SPELL_HIT_RATING"
                    weightHash["SpellCritRating"]	= "SPELL_CRIT_RATING"
                    weightHash["SpellHasteRating"] = "SPELL_HASTE_RATING"
                    weightHash["SpellPenetration"] = "SPELL_PENETRATION"
        
                    weightHash["Armor"]			= "ARMOR"
                    weightHash["DodgeRating"]		= "DODGE_RATING"
                    weightHash["ParryRating"]		= "PARRY_RATING"
                    weightHash["BlockRating"]		= "BLOCK_RATING"
                    weightHash["BlockValue"]		= "BLOCK_VALUE"						
                    weightHash["DefenseRating"]	= "DEFENSE_RATING"		
        
                    weightHash["Mp5"]				= "MANA_REGEN"
                    weightHash["Hp5"]              = "HEALTH_REGEN"
                    weightHash["Ap"]				= "ATTACK_POWER"
                    weightHash["Rap"]				= "RANGED_ATTACK_POWER"	
                    weightHash["FeralAp"]			= "FERAL_ATTACK_POWER"						
                    weightHash["Dps"]				= "DPS"
                    weightHash["MeleeDps"]			= "DPS"
                    weightHash["RangedDps"]		= "DPS"
                    weightHash["MeleeMaxDamage"]   = "DAMAGE"
                    weightHash["MeleeSpeed"]   = "DAMAGE"
                    weightHash["ResilienceRating"] = "RESILIENCE_RATING"
        
                    weightHash["FireResist"]        = "FIRE_RES"
                    weightHash["FrostResist"]        = "FROST_RES"
                    weightHash["ArcaneResist"]        = "ARCANE_RES"
                    weightHash["ShadowResist"]        = "SHADOW_RES"
                    weightHash["NatureResist"]        = "NATURE_RES"
        
                    weightHash["RedSocket"]        = "RED_SOCKET"
                    weightHash["YellowSocket"]        = "YELLOW_SOCKET"
                    weightHash["BlueSocket"]        = "BLUE_SOCKET"
                    
                    weightHash["FireSpellDamage"]		= "FIRE_SPELL_POWER"
                    weightHash["ShadowSpellDamage"]	= "SHADOW_SPELL_POWER"
                    weightHash["NatureSpellDamage"]	= "NATURE_SPELL_POWER"
                    weightHash["ArcaneSpellDamage"]	= "ARCANE_SPELL_POWER"
                    weightHash["FrostSpellDamage"]		= "FROST_SPELL_POWER"
                    weightHash["HolySpellDamage"]		= "HOLY_SPELL_POWER"																					
            
                    text = string.gsub(text, '^.*\:', '')
                    text = string.gsub(text, ' [)]', '')
                    text = string.gsub(text, '[)]', '')
                    
                    local scores = LuaUtils:split(text, ",")
                    local classAndSpec = DugisCustomWeightsDropdown.selectedValue
        
                    local maxSpellPowerCandidate, spellPowerExplicitlyValued = 0
                    LuaUtils:foreach(scores, function(score)
                        score = LuaUtils:trim(score)
                        local scoreName, scoreValue = unpack(LuaUtils:split(score, "="))
                        local weightIdentifier = weightHash[scoreName]
                        
                        if weightIdentifier then
                            scoreValue = scoreValue and tonumber(scoreValue)
                            if scoreValue and scoreValue > 0 then
                                if weightIdentifier == "SPELL_POWER" then
                                    spellPowerExplicitlyValued = true
                                elseif weightIdentifier == "FIRE_SPELL_POWER" or
                                    weightIdentifier == "SHADOW_SPELL_POWER" or
                                    weightIdentifier == "NATURE_SPELL_POWER" or
                                    weightIdentifier == "ARCANE_SPELL_POWER" or
                                    weightIdentifier == "FROST_SPELL_POWER" or
                                    weightIdentifier == "HOLY_SPELL_POWER" or
                                    weightIdentifier == "DAMAGE_SPELL_POWER" or
                                    weightIdentifier == "HEALING_SPELL_POWER" 
                                then
                                    maxSpellPowerCandidate = math.max(scoreValue, maxSpellPowerCandidate)
                                end
                                DGV.Modules.GearAdvisorData.SetCustomValue(
                                        classAndSpec, 
                                        weightIdentifier, 
                                        scoreValue)
                            end
                        end
                    end)
                    if not spellPowerExplicitlyValued and maxSpellPowerCandidate > 0 then
                        DGV.Modules.GearAdvisorData.SetCustomValue(
                            classAndSpec, 
                            "SPELL_POWER", 
                            maxSpellPowerCandidate)
                    end
                    
                   RefreshCustomWeights(frame)
                   weightHash:Pool()
                end
            end

            function GAS:GetSettingsCategory(frame, category, top, topRightColumn)
                local SettingsDB = 	DGV.chardb
                if category~="Gear Advisor" then return end
                --Reset GA Blacklist Button
                if not DGV_ResetGABlacklistButton then
                    local button = CreateFrame("Button", "DGV_ResetGABlacklistButton", frame.ScrollChild, "UIPanelButtonTemplate")
                    local btnText = L["Reset Ban List"]
                    local fontwidth = DGV:GetFontWidth(btnText, "GameFontHighlight")
                    button:SetText(btnText)
                    button:SetWidth(fontwidth + 30)
                    button:SetHeight(22)
                    button:SetPoint("TOPLEFT", frame.ScrollChild, "TOPLEFT", DUGI_SETTINGS_PADDING_LEFT, top-3)
                    top = top-3-button:GetHeight()
                    button:RegisterForClicks("LeftButtonUP")
                    button:SetScript("OnClick", 
                        function() 
                            if DGV.chardb.GA_Blacklist then
                                wipe(DGV.chardb.GA_Blacklist)
                                DGV.Modules.GearAdvisorEquip.ContinueEquip(true)
                            end
                        end)
                end

                if not DugisGearAdvisorLabel then
                    top = top - 15
                    local frame = frame.ScrollChild
                    local fontstring = frame:CreateFontString("DugisGearAdvisorLabel","ARTWORK", "GameFontNormalLarge")
                    fontstring:SetText(SettingsDB[DGV_GAWINCRITERIACUSTOM].text)
                    fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_PADDING_LEFT, top)
                    fontstring:SetJustifyV("TOP")
                    top = top - fontstring:GetStringHeight() - 5
                    
                    local orderedListContainer = CreateFrame("Frame", "DGV_OrderedListContainer"..DGV_GAWINCRITERIACUSTOM, frame)
                    orderedListContainer.optionIndex = DGV_GAWINCRITERIACUSTOM
                    orderedListContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 27, top)
                    orderedListContainer:SetPoint("RIGHT", frame, "RIGHT", -10, -195)
                    orderedListContainer:SetFrameLevel(1)
                    local lastListItem

                    local i = 1
                    for _ in DGV.Modules.GearAdvisor.IterateWinCriteria do
                        local listItem = CreateFrame("Frame", nil, orderedListContainer, "DugisOrderedListItemTemplate")
                        listItem:SetID(i)
                        i = i + 1
                        if lastListItem then
                            listItem:SetPoint("TOP", lastListItem, "BOTTOM")
                        else
                            listItem:SetPoint("TOP", orderedListContainer)
                        end
                        lastListItem = listItem
                    end
                    DGV.Modules.GearAdvisor.IteratePrioritizedWinCriteria()

                    local lastShown = DGV:UpdateOrderedListView(DGV_GAWINCRITERIACUSTOM, orderedListContainer:GetChildren())
                    top = top - orderedListContainer:GetHeight() - 5
                    
                    local addString = frame:CreateFontString("DugisGearAdvisorAddLabel","ARTWORK", "GameFontNormal")
                    addString:SetText(L["Add"])
                    addString:SetWidth(addString:GetStringWidth())
                    addString:SetHeight(40)
                    addString:SetPoint("TOPLEFT", orderedListContainer, "BOTTOMLEFT")
                    
                    local dropdown = DGV:CreateDropdown(
                            "DugisGearAdvisorDropdown", 
                            frame, 
                            nil, 
                            nil, 
                            function(button)
                                local gaWinCriteriaOptions = DGV.chardb[DGV_GAWINCRITERIACUSTOM].options
                                if not tContains(gaWinCriteriaOptions, button.value) then
                                    local indexOfFalse = DGV.tIndexOfFirst(gaWinCriteriaOptions, false)
                                    if indexOfFalse then
                                        gaWinCriteriaOptions[indexOfFalse] = button.value
                                    else
                                        tinsert(gaWinCriteriaOptions, button.value)
                                    end
                                    DGV:UpdateOrderedListView(DGV_GAWINCRITERIACUSTOM, orderedListContainer:GetChildren())
                                end
                            end,
                            DGV.Modules.GearAdvisor.IterateWinCriteria
                        )
                    dropdown:SetPoint("LEFT", addString, "RIGHT", -10)
                end

                if not DugisCustomWeightsLabel then
                    local frame_ = frame
                    local frame = frame.ScrollChild
                    local fontstring = frame:CreateFontString("DugisCustomWeightsLabel","ARTWORK", "GameFontNormalLarge")
                    fontstring:SetText(DGV.db.global[DGV_GAWEIGHTSCUSTOM].text)
                    fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_RIGHT_COLUMN_X, topRightColumn + 24)
                    fontstring:SetJustifyV("TOP")

                    local dropdown = DGV:CreateDropdown(
                            "DugisCustomWeightsClassDropdown", 
                            frame, 
                            CLASS, 
                            nil, 
                            function(button)
                                DropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DugisCustomWeightsClassDropdown, button.value)
                            end,
                            DGV.Modules.GearAdvisorData.IterateClasses
                        )
                    dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_RIGHT_COLUMN_X + DUGI_SETTINGS_PADDING_LEFT - 17, topRightColumn-23)
                    DropDown.LibDugi_UIDropDownMenu_SetSelectedValue(dropdown, (select(2, UnitClass("player"))))
                    topRightColumn = topRightColumn - 23 - dropdown:GetHeight()

                    local getClass = function()
                        return DugisCustomWeightsClassDropdown.selectedValue
                    end
                    dropdown = DGV:CreateDropdown(
                            "DugisCustomWeightsDropdown", 
                            frame, 
                            NAME, 
                            nil, 
                            function(button)
                                DropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DugisCustomWeightsDropdown, button.value)
                                RefreshCustomWeights(frame)
                            end,
                            function(invariant, specKey)
                                local specKey, specName = DGV.Modules.GearAdvisorData.IterateClassSpecs(getClass(), specKey)
                                return specKey, specKey, specName
                            end
                        )

                    local val = DugisGuideViewer.Modules.GearAdvisorData.IterateClassSpecs()
                    DropDown.LibDugi_UIDropDownMenu_SetSelectedValue(dropdown, val)

                    dropdown.noResize = false
                    dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_RIGHT_COLUMN_X + DUGI_SETTINGS_PADDING_LEFT - 17, topRightColumn-23)
                    topRightColumn = topRightColumn - 23 - dropdown:GetHeight()

                    local button = CreateFrame("Button", "DugisCustomWeightsResetButton", frame, "UIPanelButtonTemplate")
                    local fontwidth = DGV:GetFontWidth(RESET, "GameFontHighlight")
                    button:SetText(RESET)
                    button:SetWidth(fontwidth + 30)
                    button:SetHeight(22)
                    button:SetPoint("TOP", DugisCustomWeightsDropdown)
                    button:SetPoint("LEFT", DugisCustomWeightsDropdownButton, "RIGHT", 10, 0)
                    button:RegisterForClicks("LeftButtonUP")
                    button:SetScript("OnClick", 
                        function()
                            local selected = DugisCustomWeightsDropdown.selectedValue
                            if selected then
                                DGV.Modules.GearAdvisorData.ResetSpecData(selected)
                                RefreshCustomWeights(frame)
                            end
                        end)

                    if not DugisStatWeight1 then
                        local weightFrame = EnsureStatWeightFrame(frame, 1)
                        weightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_RIGHT_COLUMN_X + DUGI_SETTINGS_PADDING_LEFT - 17, topRightColumn-43)
                    end

                    local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
                    button:SetText("Apply weights")
                    button:SetWidth(120) 
                    button:SetHeight(22)
                    button:SetPoint("TOPLEFT", DugisCustomWeightsDropdown, 15, -35)
                    button:Show()

                    button:RegisterForClicks("LeftButtonUP")
                    button:SetScript("OnClick", function()
                        ApplyWeights()
                    end)

                    local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
                    button:SetText("Import weights")
                    button:SetWidth(120) 
                    button:SetHeight(22)
                    button:SetPoint("TOPLEFT", DugisCustomWeightsDropdown, 145, -35)
                    button:Show()
                
                    button:RegisterForClicks("LeftButtonUP")

                    StaticPopupDialogs["SCORES_IMPORT_DIALOG"] = {
                        text = "Paste below scores from another addon and press Import.",
                        button1 = "Import",
                        button2 = "Cancel",
                        editBoxWidth = 400,
                        OnShow = function(self)
                            if not DGV.weightsImportParent then
                                DGV.weightsImportParent = frame
                            end

                            if not DGV.weightsImportEditBox then
                                DGV.weightsImportEditBox = AceGUI:Create("MultiLineEditBox")
                            end
                            DGV.weightsImportEditBox.frame:SetParent(self)
                            DGV.weightsImportEditBox.editBox:SetCountInvisibleLetters(true)
                            DGV.weightsImportEditBox.frame:ClearAllPoints()
                            DGV.weightsImportEditBox.frame:SetPoint("TOPLEFT", self, "TOPLEFT", 50, -40)
                            DGV.weightsImportEditBox.frame:SetWidth(370)
                            DGV.weightsImportEditBox.frame:SetHeight(170) 
                            DGV.weightsImportEditBox:SetFocus()
                            self:SetHeight(320) 
                            DGV.weightsImportEditBox.frame:Show()
                            DGV.weightsImportEditBox.button:Hide()
                            DGV.weightsImportEditBox.label:Hide()
                            
                            self.insertedFrame = DGV.weightsImportEditBox.frame
                            self.textEditorObject = DGV.weightsImportEditBox
                            self:SetFrameLevel(1000)
                        end,
                        OnHide = function()
                        end,
                        OnAccept = function(self)
                            local text = self.textEditorObject:GetText()
                            ImportScoresFromText(text, frame)
                            self.textEditorObject:SetText("")
                        end,
                        timeout = 0,
                        whileDead = true,
                        hideOnEscape = true,
                        preferredIndex = 3,
                    }

                    button:SetScript("OnClick", function()
                        StaticPopup_Show ("SCORES_IMPORT_DIALOG")
                    end)

                    RefreshCustomWeights(frame)
                end
            end

            local function StatWeightDropdownOnClick(button)
                if not DugisCustomWeightsDropdown.selectedValue then return end
                local dropdown = button:GetParent().dropdown
                if dropdown.selectedValue~=-1 then
                    DGV.Modules.GearAdvisorData.SetCustomValue(
                        DugisCustomWeightsDropdown.selectedValue, 
                        dropdown.selectedValue)
                end
                UIDropDownMenu_SetSelectedValue(dropdown, button.value)
                GAS.WeightEditChanged(dropdown:GetParent().WeightEdit)
            end

            local function StatWeightDropdownInitialize()
                local info = UIDropDownMenu_CreateInfo()
                info.text = L["Choose a Stat"]
                info.value = -1
                info.func = StatWeightDropdownOnClick
                info.classicChecks = true
                UIDropDownMenu_AddButton(info)
                for _, stat, short in IterateLocalStatsAndShorts do
                    info.text = short
                    info.value = stat
                    info.func = StatWeightDropdownOnClick
                    info.checked = nil
                    UIDropDownMenu_AddButton(info)
                end
            end

            function GAS.StatWeightDropdownOnLoad(frame)
                UIDropDownMenu_Initialize(frame, StatWeightDropdownInitialize)
                UIDropDownMenu_SetSelectedValue(frame, -1);
                UIDropDownMenu_SetButtonWidth(frame, "TEXT");
                UIDropDownMenu_SetWidth(frame, 130);
            end

            function GAS.WeightEditChanged(frame)
                local statKey, value = frame:GetParent().StatDropDown.selectedValue, frame:GetText()
                if DugisCustomWeightsDropdown.selectedValue and tonumber(value) then
                    DGV.Modules.GearAdvisorData.SetCustomValue(DugisCustomWeightsDropdown.selectedValue, statKey, value)
                    RefreshCustomWeights(frame:GetParent())
                end
            end

            function GAS.StatWeightDropdownRemove(frame)
                DGV.Modules.GearAdvisorData.SetCustomValue(
                    DugisCustomWeightsDropdown.selectedValue, 
                    frame:GetParent().StatDropDown.selectedValue)
                RefreshCustomWeights(frame:GetParent())
            end
        end

        function GAS:Unload()
        end
    end
end