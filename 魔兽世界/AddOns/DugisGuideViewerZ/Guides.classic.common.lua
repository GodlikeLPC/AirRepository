if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
local DGV = DugisGuideViewer
local DGU
if not DGV then return end

local LuaUtils = LuaUtils

local Guides = DGV:RegisterModule("Guides")
local _
local BF = LibStub("LibBabble-Faction-3.0")
local BFR = BF:GetReverseLookupTable()
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local shareSystem

DGV.questAutoGuideName = "Auto World Quest Guide"

DGV.ReturnTag_cache = {}

DGV.Guides = Guides

local AceGUI = LibStub("AceGUI-3.0")

guidePercentagesCache = {}

local guideStepCharsLimit = 130

local lastUsedStepIndex = -1

--Menu categories
local Category = {
	Home=1,
	CurrentGuide=2,
	Settings=3,
	Help=11,
	Leveling=5,
	Dungeons=6,
	Dailies=7,
	Events=8,
	Achievements=10,
	Professions=9,
	Suggest=4,
	Elites=12,
	Mounts=13,
	Pets=14,
	Bosses=15,
	RecentGuides=17,
	Followers=18,
	ClearGuide=16
}

function Guides:Initialize()
	shareSystem = DGV.GetShareSystem()

    guidesMainScroll = GUIUtils:CreateScrollFrame(DugisMain)
    guidesMainScroll.scrollBar:SetHeight(322)
    
    --Preparing data for macros
	--[[
    macrosDataDefaults = LuaUtils:clone(macrosData)

    if not DugisGuideUser.macrosData then 
        DugisGuideUser.macrosData = LuaUtils:clone(macrosData)
    else
        for categoryName, categoryData in pairs(macrosData) do
            if not DugisGuideUser.macrosData[categoryName] then
                DugisGuideUser.macrosData[categoryName] = LuaUtils:clone(categoryData)
            else
                local userCategoryData = DugisGuideUser.macrosData[categoryName]
                for index, macroData in pairs(categoryData) do
                
                    local alreadyExistsInUserData = false
                    for index1, userMacroData in pairs(userCategoryData) do
                        if userMacroData.name == macroData.name and not userMacroData.isEditable then
                            alreadyExistsInUserData = true
                        end
                    end
                
                    if not alreadyExistsInUserData then
                        userCategoryData[#userCategoryData + 1] = LuaUtils:clone(macroData)
                    end
                end
            end
        end
    end]]
    

	DGU = DugisGuideUser
    if DGU.RecentGuides == nil then
        DGU.RecentGuides = {}
    end
    
    --LastIndices[heading].lastIndex
    if DGU.RecentGuides.LastIndices == nil then
        DGU.RecentGuides.LastIndices = {}
    end
    
    --Guides[heading][1..5]
    if DGU.RecentGuides.Guides == nil then
        DGU.RecentGuides.Guides = {}
    end
    
    --Headings[1...n]
    if DGU.RecentGuides.Categories == nil then
        DGU.RecentGuides.Categories = {}
    end
    
    
    
	local Main, DebugPrint, RegisterFunctionReaction = DugisMain, DGV.DebugPrint, DGV.RegisterFunctionReaction
	local NPCJournalFrame

	local GetQuestDifficultyColor = GetQuestDifficultyColor
	local visualRows

    DGV.GetLastUsedStepIndex = function()
        return lastUsedStepIndex
    end
    
    DGV.SetLastUsedStepIndex = function(val)
        lastUsedStepIndex = val
    end
	
	local CurrentAction
	local CurrentQuestName
	local JustTurnedInQID = -1 --A quest that has just been turned in has its isComplete status indeterminate in quest log
	local CurrentTag
	
	local i
	local L = DugisLocals
	local crowheight
	
	function GetCurrentGuideLeftShouldScroll()
		local tabInfo = GetCurrentGuideTypeTabInfo()
		return tabInfo and tabInfo:RightShouldScroll()
	end
	
	local function IterateCurrentHolidays(invariant, control)
		if not control then control = 0 end
		control = control + 1

---------------------------------
----------- WOW Classic:---------
---------------------------------  	
--Calendar_LoadUI and C_Calendar not present.  Todo: probably remove
		--[[Calendar_LoadUI()


		local date = C_Calendar.GetDate()
		
		local presentWeekday = date.weekday;
		local presentMonth = date.month;
		local presentDay = date.monthDay;
		local presentYear = date.year;
		
		C_Calendar.SetAbsMonth(presentMonth, presentYear)
		local numEvents = C_Calendar.GetNumDayEvents(0, presentDay)
		if control > numEvents then return end
		local calendarType
        
        if CalendarGetDayEvent then
           calendarType = select(4, CalendarGetDayEvent(0, presentDay, control))
        else
           calendarType = select(4, C_Calendar.GetDayEvent(0, presentDay, control))
        end
        
		if calendarType=="HOLIDAY" then
            if CalendarGetHolidayInfo then
                return control, CalendarGetHolidayInfo(0, presentDay, control)
            else
                return control, C_Calendar.GetHolidayInfo(0, presentDay, control)
            end
		end

		]]
	end
	
	local function SetCurrentEventIcon(icon)
		local textureBase
		for index, _, _, tex in IterateCurrentHolidays do
			if tex and tex~="" then 
				textureBase = tex
				break
			end
		end
		if not textureBase then
            if icon then
                icon:SetTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\achievement_bg_masterofallbgs")
            else
                return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\achievement_bg_masterofallbgs"
            end
		else
            if icon then
				if tonumber(textureBase) then
					icon:SetTexture(textureBase)
				else
					icon:SetTexture("Interface\\Calendar\\Holidays\\"..textureBase.."Start")
				end
                
                icon:SetTexCoord(0, 0.7109375, 0, 0.7109375)
            else
                return "Interface\\Calendar\\Holidays\\"..textureBase.."Start", 0, 0.7109375, 0, 0.7109375
            end
		end
	end
	
	local tabs = {
		[Category.Home] = {text = "Home",		title = "Home",					LeftFrame = DGVHomeFrame, 						RightFrame = DGVSearchFrame, rightShouldScroll = false},
		[Category.CurrentGuide] = {text = "Current Guide",								LeftFrame = CreateFrame("Frame"), 	RightFrame = DGVCurrentGuideFrame,	rightShouldScroll = true, leftShouldScroll = true},
		[Category.Settings] = {text = "Settings",	title = "Settings for Dugi Guides", 											RightFrame = DGVScrollFrame3, rightShouldScroll = false},
		[Category.Help] = {text = "Help",		title = "Help",									LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame11,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\help-i"},
		[Category.Leveling] = {text = "Leveling", 	title = "Leveling Guides", 	guidetype = "L",	LeftFrame = DGVHomeFrame, 		RightFrame = DGVScrollFrame4,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Achievement_Level_60", rightShouldScroll = false},
		[Category.Dungeons] = {text = "Dungeons", 	title = "Dungeon Guides", 	guidetype = "I",	LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame5,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Achievement_Dungeon_GloryoftheHERO", rightShouldScroll = false},
		[Category.Dailies] = {text = "Dailies",	title = "Daily Guides",	guidetype = "D",		LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame6,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Achievement_general_25kdailyquests", rightShouldScroll = false},
		[Category.Events] = {text = "Events",		title = "Event Guides", 	guidetype = "E",	LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame7,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\achievement_bg_masterofallbgs", rightShouldScroll = false},
		[Category.Achievements] = {text = "Achievements",	title = "Achievement Guides", guidetype = "A",LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame8,	icon="Interface\\Icons\\ACHIEVEMENT_GUILDPERK_HONORABLEMENTION", rightShouldScroll = false},
		[Category.Professions] = {text = "Professions", 	title = "Profession Guides", guidetype = "P",LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame9,	icon="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\INV_Scroll_11", rightShouldScroll = false},
		[Category.Suggest] = {text = "Suggest", title = "Suggested Guides", 				LeftFrame = DGVHomeFrame, 		RightFrame = DGVScrollFrame10, 	icon="Interface\\Icons\\INV_Misc_Orb_01", rightShouldScroll = false},
        [Category.Elites] = {text = "Elites", 	title = "Elites Guides", guidetype = "NPC", LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame12,	icon="Interface\\Icons\\spell_shadow_deathscream", rightShouldScroll = false},
        [Category.Mounts] = {text = "Mounts", 	title = "Mounts Guides", guidetype = "Mounts", LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame13,	icon="Interface\\Icons\\Ability_mount_ridingelekk", rightShouldScroll = false},
        [Category.Pets] = {text = "Pets", 	title = "Companions Guides", guidetype = "Pets", LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame14,	icon="Interface\\Icons\\Ability_racial_bearform", rightShouldScroll = false},
        [Category.Bosses] = {text = "Bosses", 	title = "Bosses Guides", guidetype = "Bosses", LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame15,	icon="Interface\\Icons\\Achievement_Dungeon_ClassicDungeonMaster", rightShouldScroll = false},
		[Category.ClearGuide] = {text = "Clear Guide",		title = "Clear the loaded guide from the Small Frame",									LeftFrame = DGVHomeFrame,		RightFrame = DGVScrollFrame16,	icon="Interface\\Buttons\\UI-GroupLoot-Pass-Up"},		
        [Category.RecentGuides] = {text = "Recent Guides", title = "Recent Guides", 		LeftFrame = DGVHomeFrame, 		RightFrame = DGVScrollFrame17, 	icon="Interface\\Icons\\Spell_shadow_unstableaffliction_1", rightShouldScroll = false},
        [Category.Followers] = {text = "Followers", title = "Followers", guidetype = "Followers", LeftFrame = DGVHomeFrame, 		RightFrame = DGVScrollFrame18, 	icon="Interface\\Icons\\achievement_garrisonfollower_rare", rightShouldScroll = false},
    }
	local SEARCH_TAB, SUGGEST_TAB, RECENT_TAB, MACROS_TAB = Category.Home, Category.Suggest, Category.RecentGuides, 19
	local currentGuideTabInfo = tabs[Category.CurrentGuide]
    
    DGV.tabs = tabs
	
	local function AccessValue(valueOrAccessor)
		if type(valueOrAccessor)=="function" then 
			return valueOrAccessor() 
		else return valueOrAccessor end
	end
	
	local function TabInfoRightShouldScroll(self)
		return self.rightShouldScroll
	end
	
	local function TabInfoLeftShouldScroll(self)
		return AccessValue(self.leftShouldScroll)
	end
	
	local activeTabInfo, PopulateSuggestedGuides
    local lastClickedTab = nil
    
    function DGV.ClearGuide()
        
        CurrentTitle = nil
        DugisGuideViewer.CurrentTitle = nil
		lastUsedStepIndex = -1
		shareSystem.notCompletedPlayers = {}
		
		DGV.SendCurrentGuideTitleToClients()
        
        tabs[RECENT_TAB].treeData = {}
        guideategorieswrapper:UpdateTreeVisualization()

        DGV:ClearScreen()
        
        DugisGuideUser.CurrentQuestIndex = nil
        CurrentQuestName = nil
        DugisGuideViewer:RemoveAllWaypoints()			
		DugisGuideViewer.Modules.ModelViewer.Frame:Hide()
		
		DGV.SendDataToServer("NGSI")
		DGV.SendDataToClients("NGSI-SV")		
        
        --HOME
        Guides.TabInfoActivate(tabs[Category.Home])    
    end
    
    function Guides.UpdateTreeDate(tabInfo, treeData)
        if treeData then
        
            if guideategorieswrapper then
                guideategorieswrapper:ClearAllPoints() 
            end            
        
            local x = 400
            local y = -30
            local parent = guidesMainScroll.frame
            
            if DugisMain then
                parent = DugisMain
                x = 400
                y = -30
            end
        
            local wrapper = GUIUtils:SetTreeData(parent, nil, "guideategories", 
                treeData, nil, nil, nil, nil, x, y, 5, -5
                ,function(oryginalText, nodeData)
                   if DGV.ProcessNPCLeafColor and nodeData.isLeaf then
                       if nodeData.textAddon then
                         return DGV.ProcessNPCLeafColor(oryginalText, tabInfo.guidetype)..nodeData.textAddon 
                       else
                         return DGV.ProcessNPCLeafColor(oryginalText, tabInfo.guidetype) 
                       end
                   else
                       return oryginalText
                   end
                 end,
                 function(self, newHeight)
                    local newMax = newHeight - 100
                    if newMax < 1 then
                        newMax = 1
                    end
                    
                    if whatsNewFrame and whatsNewFrame:IsVisible() and whatsNewFrame:GetRegions() and whatsNewFrame:GetRegions():GetHeight() then
                        newMax = newMax + whatsNewFrame:GetRegions():GetHeight()
                    end

                    guidesMainScroll.scrollBar:SetMinMaxValues(1, newMax)
                    if UpdateWhatsNewFramePositions then
                        UpdateWhatsNewFramePositions()
                    end
                 end,
                 function(self, delta)
                    guidesMainScroll.scrollBar:SetValue(guidesMainScroll.scrollBar:GetValue() - delta * 44)  
                 end, nil, nil, nil, nil, nil, nil, nil, isInThread)

            if DugisMain then
                wrapper:SetParent(DugisMain)
                wrapper:SetPoint("TOPLEFT", DugisMain, "TOPLEFT", 0, 0)
            end
            
            if recentGuidesLabel == nil then
                guideategorieswrapper:CreateFontString("recentGuidesLabel", "ARTWORK", "GameFontNormalLarge")
            end
            
    

            if #treeData == 0 then
                noGuideLoaded:Show()
                noGuideLoaded:SetText(L["No Guide Loaded"])
                noGuideLoaded:SetPoint("TOPLEFT", guidesMainScroll.frame, "TOPLEFT", 3, -5)
                recentGuidesLabel:SetParent(guidesMainScroll.frame)
            else
                noGuideLoaded:Hide()
            end
            
            if tabInfo.text == "Recent Guides" then
                    
                recentGuidesLabel:Hide()
                noGuideLoaded:Hide()
                if tabs[RECENT_TAB].treeData and #tabs[RECENT_TAB].treeData > 0 then
                    recentGuidesLabel:Show()
                else
                    recentGuidesLabel:Hide()
                end 
                
                recentGuidesLabel:SetText(L["Recent Guides"])
                
                recentGuidesLabel:SetParent(guideategorieswrapper)
                recentGuidesLabel:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", 3, -5)
                guideategorieswrapper.indernalDeltaX = 0
                guideategorieswrapper.internalDeltaY = -25
                guideategorieswrapper:UpdateTreeVisualization()
                
            end	            
        end
        
        guidesMainScroll.frame.content = guideategorieswrapper
        guidesMainScroll.frame:SetScrollChild(guideategorieswrapper) 
    
        if guideategorieswrapper then
            if tabInfo.text == "Current Guide" then
            
                guideategorieswrapper:SetWidth(347)
                guidesMainScroll.frame:SetPoint("TOPLEFT", DugisMain, 5, -47)
                guidesMainScroll.frame:SetWidth(400)
            
                guideategorieswrapper.indernalDeltaX = 0
                guideategorieswrapper.internalDeltaY = -40
                guideategorieswrapper:UpdateTreeVisualization()
               
                DugisMainLeftScrollFrame.currentGuideIcon:SetParent(guideategorieswrapper)
                DugisMainLeftScrollFrame.currentGuideIcon:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", 10, -5)
                DugisMainLeftScrollFrame.currentGuideIcon:Show()
                
                DugisMainLeftScrollFrame.guideType:SetParent(guideategorieswrapper)
                DugisMainLeftScrollFrame.guideType:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", 48, -10)
                DugisMainLeftScrollFrame.guideType:Show()
                
                DugisPreloadButton:ClearAllPoints()
                DugisPreloadButton:SetParent(guideategorieswrapper)
                DugisPreloadButton:SetPoint("TOPLEFT", 250, -10)
                
                if CurrentTitle then
                    DugisPreloadButton:Show()
                    guidesMainScroll.scrollBar:Show()
                else
                    noGuideLoaded:Show()
                    noGuideLoaded:SetText(L["No Guide Loaded"])
                    noGuideLoaded:SetPoint("TOPLEFT", guidesMainScroll.frame, "TOPLEFT", 3, -5)
                    DugisPreloadButton:Hide()
                    guideategorieswrapper:Hide()
                    DugisMainLeftScrollFrame.currentGuideIcon:Hide()
                    DugisMainLeftScrollFrame.guideType:Hide()
                    guidesMainScroll.scrollBar:Hide()
                end
                
                guidesMainScroll.scrollBar:SetPoint("TOPLEFT", guidesMainScroll.frame, "TOPLEFT", 352, -10)
            else
                guideategorieswrapper:SetWidth(405)
                if tabInfo.text == "Help" then
                    guidesMainScroll.frame:Hide()
                else
                    guidesMainScroll.frame:SetParent( DugisMain)
                    guidesMainScroll.frame:SetPoint("TOPLEFT", DugisMain, 370, -40)
                    guidesMainScroll.frame:Show()
                    guidesMainScroll.scrollBar:SetPoint("TOPLEFT", guidesMainScroll.frame, "TOPLEFT", 412, -20)
                    guidesMainScroll.scrollBar:SetHeight(319)
                    guidesMainScroll.frame:SetWidth(600)
                    DugisMainLeftScrollFrame.currentGuideIcon:Hide()
                    DugisMainLeftScrollFrame.guideType:Hide()
                    DugisPreloadButton:Hide()
                end
            end
        end
        
        return wrapper
    
	end
	
	function DGV.OnSettingsMenuClick(tabInfo)
		tabInfo:Activate()
		if tabInfo.text == "Help" then
		   DugisGuideViewer.TFD.TutorialFrameDugisReset()
		end
		LuaUtils:PlaySound("igCharacterInfoTab");
	end

    local playerMarks = {}
	local function TabInfoActivate_(self, isInThread)
        Guides.currentTabTitle = self.text 
    
        DGV:AddGuideToRecentGuides(CurrentTitle)
        
        --CurrentTitle
        local gType = DGV.gtype[CurrentTitle]
        DGV.SmallFrame.SetGuideForActiveTab(CurrentTitle, gType)
        
        PopulateRecentGuides()
        
        
        if DGV:isValidGuide(CurrentTitle) and (not CurrentTitle or not GetCurrentGuideTypeTabInfo().leftShouldScroll) and self.text and self.text ~= "Current Guide" then
            guidesMainScroll.frame:Hide()
        else
            guidesMainScroll.frame:Show()
        end
        
        if whatsNewFrame then
            whatsNewFrame:Hide()
            whatsNewFrame.title:Hide()
        end
        
        if NPCJournalFrame then
            NPCJournalFrame.playersMounts = nil
            NPCJournalFrame.playersPets = nil
            NPCJournalFrame.playersFollowers = nil
        end
        
        if self.text == "Suggest" then
            PopulateSuggestedGuides(isInThread)
        end        
        
        local treeData = self.treeData
        
        if not self.treeData and self.text == "Current Guide" then
            if GetCurrentGuideTypeTabInfo() then
                treeData = GetCurrentGuideTypeTabInfo().treeData
            end
        end   

        if self.text ~= "Recent Guides" and recentGuidesLabel then
            recentGuidesLabel:Hide()
        end

        if noGuideLoaded == nil then
            guidesMainScroll.frame:CreateFontString("noGuideLoaded", "ARTWORK", "GameFontNormalLarge")
        end
        
        Guides.UpdateTreeDate(self, treeData)

        SetCurrentGuideIcon()
        
        if  self.text == "Settings" then
            guidesMainScroll.frame:Hide()
        end          
    
		if activeTabInfo==self then return end
		if activeTabInfo then
			if activeTabInfo:RightShouldScroll() then
				activeTabInfo.rightScrollHistory = Main.rightScroll.bar:GetValue()
			end
			if activeTabInfo.LeftFrame then
				local leftFrame = AccessValue(activeTabInfo.LeftFrame)
				if leftFrame then
					leftFrame:Hide()
				end
			end
			activeTabInfo.RightFrame:Hide()
			DugisReloadButton:Hide() DugisResetButton:Hide() DugisPercentButton:Hide()
		end
		activeTabInfo = self
		
		Main.title:SetText(self.title)
		Main.title:Show()
		
		if self.text ~= "Home" then
			DGV.Search:Hide()
			DGV.Search:ClearText()
		end
		
        if self.text == "Recent Guides" then
			PopulateRecentGuides()
            
            if recentGuidesLabel then
                if tabs[RECENT_TAB].treeData and #tabs[RECENT_TAB].treeData > 0 then
                    recentGuidesLabel:Show()
                else
                    recentGuidesLabel:Hide()
                end
            end            
		end
		
		if self.text == "Clear Guide" then
            DGV.ClearGuide()
		end

		if self.text == "Current Guide" and DGV:isValidGuide(CurrentTitle) == true then	
			DugisReloadButton:Show() DugisResetButton:Show() DugisPercentButton:Show() 
			DGV.Search:Show()
			DGV:TabTextRefresh()
			Main.rightScroll:SetPoint("BOTTOM", Main.rightFrameHost, 0, 30)
            DugisGuideViewer:UpdateCurrentGuideExpanded()
		end

		function DGV.HideAllSharingMarks()
			for _, playerMark in pairs(playerMarks) do
				playerMark:Hide()
			end
		end
        
        function DGV.UpdateGuideVisualRows()
            if not visualRows then
                return
            end

            local scrollY = Main.rightScroll.bar:GetValue()
            for index = 1, lastUsedStepIndex do
			  local visualRow = visualRows[index]

			  if visualRow then
                local yInScrollWindow = -visualRow.y - scrollY
                if visualRow.frame then
                    visualRow.frame:ClearAllPoints()
                end
                if (yInScrollWindow >= -40 and yInScrollWindow < 320) or index == lastUsedStepIndex then
                    DugisGuideViewer:UpdateRowVisualizations(index)
                else
                    if visualRow.frame then
                        visualRow.frame:Hide()
                    end
                end
			  end
		    end

			DGV.HideAllSharingMarks()

		  DGV.HideAllSharingMarks()

		  local clientMarkColors = {{1,0.4,0.0}, {0.63,0.76,0.89}, {0.55,0.79,0.69}, {0.93,0.93,0.54}, {0.95,0.68,0.72}
		  , {0.95,0.63,0.51}, {0.95,0.63,0.51}, {0.69,0.68,0.83}}	
		  

		  local allPlayersVisualData = {}

		  local index = 1

		  --Adding client marks
		  if shareSystem.shareClients then
			  for playername, shareClient in pairs(shareSystem.shareClients) do 
				  local clientCureentStep = tonumber((shareClient.guideState and shareClient.guideState.currentStepIndex) or -1)
				  local clientCurrentTitle = shareClient.guideState and shareClient.guideState.currentTitle

				  local rowObj = visualRows[clientCureentStep]

				  if rowObj and clientCurrentTitle == CurrentTitle and shareClient.guideState.hasGuide
				  and shareClient.status == "connected" then
					  allPlayersVisualData[#allPlayersVisualData + 1] = {index = index, color = clientMarkColors[index] or {1,1,1}, 
						  playername = playername, rowObj = rowObj
					  }
				  end

				  index = index + 1
			  end
		  end

			--Adding server mark
		  if DGV.IsPlayerShareClient() then
			  local clientCurrentStep = tonumber((shareSystem.shareServer.guideState and shareSystem.shareServer.currentStepIndex_serverSide) or -1)

			  local rowObj = visualRows[clientCurrentStep]

			  if shareSystem.shareServer.guideState.currentTitle and rowObj then
				  allPlayersVisualData[#allPlayersVisualData + 1] = {index = index, color = {1,0,0}, 
					  playername = shareSystem.shareServer.playername .. " - this player is sharing the guide with you.", rowObj = rowObj
				  }
			  end
		  end


		  for _, playerVisualData in pairs(allPlayersVisualData) do
			  local mark = playerMarks[playerVisualData.index]
			  if not mark then 
				  mark = CreateFrame("Frame", nil, currentGuideTabInfo.RightFrame)
				  local tex = mark:CreateTexture("BACKGROUND")
				  tex:SetColorTexture(unpack(playerVisualData.color))
				  tex:SetAllPoints()			
				  tex:Show()
				  mark:SetSize(5, 34)
				  mark:EnableMouse(true)
				  mark:SetFrameLevel(50)
				  mark:SetFrameStrata("TOOLTIP")
				  mark:SetScript("OnLeave", function() GameTooltip:Hide() end)   
				  
				  mark:SetScript("OnEnter", function(self)
					  GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR", 10, 10)
					  GameTooltip:AddLine(self.playername, 1, 1, 1, 1, true)
					  GameTooltip:Show()
					  GameTooltip:ClearAllPoints()
				  end)							
			  end	 

			  mark.playername = playerVisualData.playername
			  playerMarks[playerVisualData.index] = mark
			  mark:Show()

			  mark:ClearAllPoints()
			  local x = 764
			  if DugisGuideUser.showLeftMenuForCurrentGuide then
				  x = 392
			  end

			  mark:SetPoint("TOPLEFT", currentGuideTabInfo.RightFrame, x, playerVisualData.rowObj.y)
		  end
        end
		
		if self.guidetype then
			if not self.text == "Elites" or not self.text == "Mounts" or not self.text == "Pets" or not self.text == "Bosses" or not self.text == "Followers" then
				DugisPreloadButton:SetParent(Main)
				DugisPreloadButton:ClearAllPoints()
				DugisPreloadButton:SetPoint("BOTTOMRIGHT", Main.rightFrameHost, 0, 3)
				DugisPreloadButton:Show()
			end
			Main.rightScroll:SetPoint("BOTTOM", Main.rightFrameHost, 0, 30)
		end
			
		if self.text ~= "Current Guide" and not self.guidetype then
			Main.rightScroll:SetPoint("BOTTOM", Main.rightFrameHost)
			DugisPreloadButton:Hide()
		end
        	
        if searchThread == nil then
            self.RightFrame:Show()
        end
        
		if self:RightShouldScroll() then
			Main.rightScroll:SetScrollChild(self.RightFrame)
			self.RightFrame:SetWidth(400)
			Main.rightScroll.bar:SetValue(self.rightScrollHistory or 1)
			Main.rightScroll:Show()
		else
			Main.rightScroll:Hide()
			self.RightFrame:SetAllPoints(Main.rightFrameHost)
		end
		
        if Main.leftScroll then
            Main.leftScroll:Hide()
        end

		if self.text == "Elites" and not DGV:IsModuleRegistered("NPCDataModule") then 
			Main.rightScroll:Hide()
		end

		if self.text == "Mounts" and not DGV:IsModuleRegistered("MountDataModule") then 
			Main.rightScroll:Hide()
		end
		
		if self.text == "Pets" and not DGV:IsModuleRegistered("PetDataModule") then 
			Main.rightScroll:Hide()
		end
		
		if self.text == "Bosses" and not DGV:IsModuleRegistered("BossDataModule") then 
			Main.rightScroll:Hide()
		end		
        
		if self.text == "Followers" and not DGV:IsModuleRegistered("FollowerDataModule") then 
			Main.rightScroll:Hide()
		end		
        
				
		local leftFrame = AccessValue(self.LeftFrame)
		if leftFrame then
			leftFrame:Show()
			if self:LeftShouldScroll() then
				DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrollBackground())
                if Main.leftScroll then
                    Main.leftScroll:SetScrollChild(leftFrame)
                    leftFrame:SetWidth(350)
                    Main.leftScroll.bar:SetValue(self.leftScrollHistory or 1)
                    Main.leftScroll:Show()
                end
				
				if self.text=="Current Guide" and GetCurrentGuideTypeTabInfo() then
					self.leftScrollMax = GetCurrentGuideTypeTabInfo().rightScrollMax
				else
                    DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrolllesBackground())
                end
			else
				DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrolllesBackground())
				leftFrame:SetAllPoints(Main.leftFrameHost)
			end
			Main.leftFrameHost:Show()
			Main.rightFrameHost:ClearAllPoints()
			Main.rightFrameHost:SetPoint("TOPLEFT", 375, -44)
			Main.rightFrameHost:SetPoint("BOTTOMRIGHT", -25, 0)
			
			if leftFrame==DGVHomeFrame then
				Main.title:Hide()
				DGV.Search:ShowGlobal()
			end
		else
			Main.leftFrameHost:Hide()
			DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrolllesBackground())
			Main.rightFrameHost:ClearAllPoints()
			Main.rightFrameHost:SetPoint("TOPLEFT", 0, -44)
			Main.rightFrameHost:SetPoint("BOTTOMRIGHT", -25, 0)
		end
		if self.RightFrame.panel and self.RightFrame.firstHeading then
			self.RightFrame.firstHeading:SetPoint("TOPLEFT", self.RightFrame, "TOPLEFT", 0, -5)
			self.RightFrame.panel:Hide()
		end
        
		if self.text == "Home" then
            if  DGV_SearchBox:GetText() == "" then
				DGV.OnSettingsMenuClick(tabs[Category.RecentGuides])
            end
        end
        
        DugisGuideViewer:UpdateCurrentGuideExpanded()
        
        if lastClickedTab ~= self.text and guideategorieswrapper then
            guideategorieswrapper:SaveExpansionState(self.text)
            guideategorieswrapper:LoadExpansionState(lastClickedTab, isInThread)
            guidesMainScroll.scrollBar:SetValue(0)
        end
        --[===[ Disable macro guide
        if self.text == "Macros" then
            DugisGuideViewer.DeselectTopTabs()
            
            tabs[MACROS_TAB].treeData = {}
            guideategorieswrapper:UpdateTreeVisualization()
            Guides.TabInfoActivate(tabs[MACROS_TAB])
        
            DGVHomeFrame:Hide()
            guidesMainScroll.frame:Hide()
            
            local textEditor, cancelButton, textCancel, editNameButton, editDescriptionButton, editCodeButton, deleteMacroButton
            
            function GetAllMacros()
                local result = {}
                
                for i = 1, MAX_ACCOUNT_MACROS do
                    local name, texture, body = GetMacroInfo(i)
                    if name and body then
                        result[#result + 1] = {index = i, name = name, body = body, texture = texture}
                    else
                        break
                    end 
                end
                
                for i = MAX_ACCOUNT_MACROS + 1, (MAX_ACCOUNT_MACROS + MAX_CHARACTER_MACROS) do
                    local name, texture, body = GetMacroInfo(i)
                    if name and body then
                        result[#result + 1] = {index = i, name = name, body = body, texture = texture}
                    else
                        break
                    end 
                end
            
                return result
            end
            
            function MacroBody2MacroIndex(body)
                body = LuaUtils:trim(body)
            
                local result = nil
                for _, macroInfo in pairs(GetAllMacros()) do
                    if LuaUtils:trim(macroInfo.body) == body then
                        result = macroInfo.index
                    end
                end
                return result
            end

            if DGV.Guides.currentSelectedMacroData == nil then
                DGV.Guides.currentSelectedMacroData = DugisGuideUser.macrosData.general[1]
            end
            
            if DGV.Guides.currentSelectedCategory == nil then
                DGV.Guides.currentSelectedCategory = "general"
            end
            
            local defaultMacroIcon = [[Interface/ICONS/INV_Misc_QuestionMark]]
            
        
            local MacroEditor = DugisMain.MacrosWrapper.MacroEditor
            local MacroName = MacroEditor.MacroName
            local MacroDescription = MacroEditor.MacroDescription
            local MacroCode = MacroEditor.MacroCode
            
            MacroEditor.AddToSlotButton:SetScript("OnClick", function()
                SlashCmdList["MACRO"]()
                local name = DGV.Guides.currentSelectedMacroData.name
                local body = DGV.Guides.currentSelectedMacroData.data.macroCode
                local icon = DGV.Guides.currentSelectedMacroData.icon
                
                if type(DGV.Guides.currentSelectedMacroData.icon) == "string" then
                    icon = icon:gsub([[Interface/ICONS/]], "")
                end
                
                local numAccountMacros, numCharacterMacros = GetNumMacros();
                
                if numAccountMacros >= MAX_ACCOUNT_MACROS then
                    print("|cff11ff11This account has already 120 macros.|r")
                    return
                end
                
                local index = CreateMacro(name, icon, body, false)
                MacroFrame_SelectMacro(index)
            
                MacroFrame_Update()
            end)
        
            function UpdateTexts()
                MacroName:SetText(DGV.Guides.currentSelectedMacroData.name)
                MacroDescription:SetText(DGV.Guides.currentSelectedMacroData.data.macroDescription)
                MacroCode:SetText(DGV.Guides.currentSelectedMacroData.data.macroCode)
            end
            
            function UpdateIcons()
                for key, value in pairs(DugisGuideUser.macrosData) do
                    for _, node in pairs(DugisGuideUser.macrosData[key]) do
                        if not node.isPlusButton then
                            local body = node.data.macroCode
                            local icon = MacroBody2MacroIcon(body)
                            if icon then
                                node.icon = icon
                            else
                                node.icon = defaultMacroIcon
                            end
                        end
                    end
                end
                
                RefreshMacrosList()
            end            
            
            MacroEditor.ResetToDefault:SetScript("OnClick", function()
                local name = DGV.Guides.currentSelectedMacroData.name
                local body = DGV.Guides.currentSelectedMacroData.data.macroCode
                local icon = DGV.Guides.currentSelectedMacroData.icon
                
                
                if not DGV.Guides.currentSelectedMacroData or not DGV.Guides.currentSelectedCategory or not DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory] then
                    return
                end
                
                local macroData = DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory]
                local macroIndex = nil
                
                for index, defaultMacroData in pairs(macrosDataDefaults[DGV.Guides.currentSelectedCategory]) do
                    if defaultMacroData.name == name then
                        macroIndex = index
                    end 
                end
                
                if not macroIndex then
                    return 
                end
                
                local defaultBody = macrosDataDefaults[DGV.Guides.currentSelectedCategory][macroIndex].data.macroCode
                local defaultDescription = macrosDataDefaults[DGV.Guides.currentSelectedCategory][macroIndex].data.macroDescription
                local defaultName = macrosDataDefaults[DGV.Guides.currentSelectedCategory][macroIndex].name
                
                DGV.Guides.currentSelectedMacroData.data.macroCode = defaultBody
                DGV.Guides.currentSelectedMacroData.data.macroDescription = defaultDescription
                DGV.Guides.currentSelectedMacroData.name = defaultName
                UpdateTexts()
                UpdateIcons()
            end)
            
             --local textEditor, cancelButton, textCancel, editNameButton, editDescriptionButton, editCodeButton
             
             function UpdateMacroButtonsVisibility()
                local currentMacroData = DGV.Guides.currentSelectedMacroData
                local isEditable = currentMacroData.isEditable
                
                if isEditable then
                    editNameButton.button:Show()
                    editDescriptionButton.button:Show()
                    editCodeButton.button:Show()
                   Guides.deleteMacroButton.button:Show()
                   MacroEditor.ResetToDefault:Hide()
                  
                else
                    editNameButton.button:Hide()
                    editDescriptionButton.button:Show()
                    editCodeButton.button:Show()
                    MacroEditor.ResetToDefault:Show()
                    Guides.deleteMacroButton.button:Hide()
                end
                
             end
        
            function RefreshMacrosList()
                local macroData =  DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory]
                
                if not macroData then
                    DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory] = {}
                    macroData = DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory]
                end
                
                if #macroData == 0 or not macroData[#macroData].isPlusButton then
                    macroData[#macroData + 1] = {name = "New macro", textColor = {r=1, g=1, b=1}, isPlusButton = true, nodeTextY = -3, nodeTextX = 23
                    , icon = [[Interface/AddOns/DugisGuideViewerZ/Artwork/plus16px]], iconSize = 16
                    , data = {macroCode = "",  macroDescription = ""}}
                end
                
                    
                local config = {
                    parent             = DugisMain.MacrosWrapper
                    , name             = "macrosubcategories"
                    , data             = macroData or {}
                    , x                = 10
                    , y                = -86
                    , nodesOffsetY     = -10
                    , width            = 330
                    , height           = 308
                    , onNodeClick      = function(visualNode)
                            if not visualNode.nodeData.isPlusButton then
                                DGV.Guides.currentSelectedMacroData = visualNode.nodeData
                                UpdateTexts()
                                MacroEditor:Show()
                                UpdateMacroButtonsVisibility()
                            else
                                if DGV.Guides.currentSelectedCategory then
                                    local macros = DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory]

                                    macros[#macros + 1] = {isEditable = true, name = "My new macro", icon = defaultMacroIcon, data = {macroCode = "/say Hello World!",  macroDescription = "description"}}
                                    DGV.Guides.currentSelectedMacroData = macros[#macros]

                                    UpdateIcons()
                                    UpdateTexts()
                                    MacroEditor:Show()
                                    UpdateMacroButtonsVisibility()
                                   
                                    if Guides.macrolist.scrollBar:IsVisible() then
                                        local val = Guides.macrolist.frame:GetVerticalScrollRange()
                                        Guides.macrolist.scrollBar:SetValue(val - 102)
                                    end
                                end 
                            end
                        end
                    , iconSize         = 22
                    , nodeHeight       = 24
                    , onDragFunction   = function(visualNode)
                            local body = visualNode.nodeData.data.macroCode
                            local macroIndex = MacroBody2MacroIndex(body)
                            if macroIndex then
                                PickupMacro(macroIndex)
                            end
                        end
                    , nodeTextX        = 30
                }
                
                Guides.macrolist = GUIUtils.SetScrollableTreeFrame(config)
                
                if not Guides.macrolist.scrollBar.bkg then
                    local tex = Guides.macrolist.scrollBar:CreateTexture("BACKGROUND")
                    tex:SetColorTexture(0, 0, 0)
                    tex:SetAllPoints()
                    tex:SetAlpha(0.1)
                    tex:Show()
                    Guides.macrolist.scrollBar.bkg = tex
                end
                
                Guides.macrolist.scrollBar:SetPoint("TOPLEFT", DugisMain.MacrosWrapper, "TOPLEFT", 302, -61)
                Guides.macrolist.scrollBar:SetParent(DugisMain.MacrosWrapper)
                Guides.macrolist.scrollBar:SetHeight(320)
                Guides.macrolist.scrollBar:SetScript("OnValueChanged",
                function (self, value)
                    Guides.macrolist.frame:SetVerticalScroll(value)
                end)
                
                table.remove(macroData, #macroData)
            end
            
            function RefreshMacrosCategories()
                local config = {
                    parent             = DugisMain.MacrosWrapper
                    , name             = "macrocategories"
                    , data             = macroCategories
                    , x                = 10
                    , y                = -86
                    , nodesOffsetY     = -10
                    , width            = 330
                    , height           = 308
                    , onNodeClick      = function(visualNode)
                        DGV.Guides.currentSelectedCategory = visualNode.nodeData.data.categoryName
                        RefreshMacrosList()   
                        macrocategorieswrapper:Hide()
                        Guides.macrolist.frame:Show()
                        
                        DugisMain.MacrosWrapper.MacroInfo.CategoryIcon:SetTexture(visualNode.nodeData.icon)
                        DugisMain.MacrosWrapper.MacroInfo.CategoryIcon:SetPoint("TOPLEFT", 49, -49)
                        DugisMain.MacrosWrapper.MacroInfo.CategoryName:SetText(visualNode.nodeData.name)
                        
                        DugisMain.MacrosWrapper.BackToCategoriesButton:Show()
                        
                        
                        Guides.macrolist.scrollBar:SetValue(0)
                        
                    end
                    , iconSize         = 25
                    , nodeHeight       = 27
                    , noScrollMode     = true
                    , columnWidth      = 120
                    , nodeTextX        = 30
                }
            
                GUIUtils.SetScrollableTreeFrame(config)
                
                RefreshMacrosList()
            end
            
            function MacroBody2MacroIcon(body)
                local index = MacroBody2MacroIndex(body)

                if index then
                    local _, texture, _ = GetMacroInfo(index)
                    return texture
                end
            end            

            DugisMain.MacrosWrapper:Show()
            
            if not Guides.uiInitialized then
                RefreshMacrosCategories()    
                UpdateTexts()
                
                UpdateIcons()
            
                Guides.macrolist.frame:Hide()
                
                MacroEditor:Hide()
            end
                
            local initializeMacroHooksTimer    
            initializeMacroHooksTimer = C_Timer.NewTicker(1, function()
                if not Guides.hookedMacroFramefunctions and MacroFrame_Update then
                    hooksecurefunc("MacroFrame_Update", function()
                        UpdateIcons()
                    end)   
                    
                    hooksecurefunc("MacroFrame_Show", function()
                        UpdateIcons()
                    end)    
                    
                    hooksecurefunc("MacroFrameSaveButton_OnClick", function()
                        UpdateIcons()
                    end)   
                    
                    hooksecurefunc("MacroFrame_DeleteMacro", function()
                        UpdateIcons()
                    end)  
                                  
                    hooksecurefunc("RefreshPlayerSpellIconInfo", function()
                        UpdateIcons()
                    end)  
                    
                    hooksecurefunc("MacroFrame_SaveMacro", function()
                        UpdateIcons()
                    end)  
                    
                    initializeMacroHooksTimer:Cancel()
                    Guides.hookedMacroFramefunctions = true
                end
            end)
            
            if not Guides.uiInitialized then
                textEditor = AceGUI:Create("MultiLineEditBox")
                textEditor.frame:SetParent(DugisMain.MacrosWrapper)
                textEditor.editBox:SetCountInvisibleLetters(true)
                textEditor.frame:SetPoint("TOPLEFT", DugisMain.MacrosWrapper, "TOPLEFT", 380, -60)
                textEditor.frame:SetWidth(370)
                textEditor.frame:SetHeight(320)
                Guides.textEditor = textEditor
                Guides.macrolist.scrollBar:Hide()
            else
                textEditor = Guides.textEditor
            end
            
            if not Guides.uiInitialized then
                cancelButton = CreateFrame("Button", nil , textEditor.frame, "UIPanelButtonTemplate" or "UIPanelButtonTemplate2")
                cancelButton:SetPoint("TOPLEFT", textEditor.button, "TOPRIGHT", 10, 0)
                cancelButton:SetHeight(22)
                cancelButton:SetWidth(textEditor.label:GetStringWidth() + 24)
                cancelButton:SetText("Cancel")
                cancelButton:Show()
                
                cancelButton:SetScript("OnClick", function()
                    textEditor.frame:Hide()
                    MacroEditor:Show()
                end)
                Guides.cancelButton = cancelButton
            else
                cancelButton = Guides.cancelButton
            end
            
            if not Guides.uiInitialized then
                textCancel = cancelButton:GetFontString()
                textCancel:ClearAllPoints()
                textCancel:SetPoint("TOPLEFT", cancelButton, "TOPLEFT", 5, -5)
                textCancel:SetPoint("BOTTOMRIGHT", cancelButton, "BOTTOMRIGHT", -5, 1)
                textCancel:SetJustifyV("MIDDLE")
                Guides.textCancel = textCancel
            else
                textCancel = Guides.textCancel
            end
            
            textEditor.editBox:HookScript("OnTextChanged", function()
                  local text = textEditor.editBox:GetText()
            end)
            
            textEditor.button:HookScript("OnClick", function()
              if textEditor.onAccept then
                 textEditor.onAccept()
              end
            end)
            
            local function EditText(caption, initialText, onAccept)
                textEditor.frame:Show()
                MacroEditor:Hide()
                
                textEditor.label:SetText(caption)
                textEditor.editBox:SetText(initialText)
                textEditor.onAccept = function()
                    textEditor.frame:Hide()
                    MacroEditor:Show()
                    
                    onAccept()
                end  
            end
            
            local function ShowInfo(parent, text)
                GameTooltip:SetOwner(DugisMain, "ANCHOR_BOTTOMRIGHT")
                GameTooltip:AddLine(text, 1, 1, 1, 1, true)
                GameTooltip:Show()
                GameTooltip:ClearAllPoints()
                GameTooltip:SetPoint("BOTTOMRIGHT", DugisMain, "BOTTOMRIGHT", 6, -42)            
            end
            
            local function CreateEditButton(onClick, infoText)
                local button = GUIUtils:AddButton(MacroEditor, "", 0,  0, 16, 16, 16, 16, onClick
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/pen16px.tga]]
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/pen16px.tga]]
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/pen16px.tga]]
                )
                
                button.button:Show()
                button.button:ClearAllPoints()
                
                button.button:SetScript("OnEnter", function()
                    ShowInfo(button.button, infoText or "Edit")
                end)
                
                button.button:SetScript("OnLeave", function() GameTooltip:Hide() end)                
            
                return button
            end 

            local function CreateDeleteButton(onClick, infoText)
                local button = GUIUtils:AddButton(MacroEditor, "", 0,  0, 32, 32, 32, 32, onClick
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/trash32px.tga]]
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/trash32px.tga]]
                , [[Interface/AddOns/DugisGuideViewerZ/Artwork/trash32px.tga]]
                )
                
                button.button:Show()
                button.button:ClearAllPoints()
                
                button.button:SetScript("OnEnter", function()
                    ShowInfo(button.button, infoText or "Delete")
                end)
                
                button.button:SetScript("OnLeave", function() GameTooltip:Hide() end)    
            
                return button
            end  

            if not Guides.uiInitialized then
                editNameButton = CreateEditButton(function()
                    textEditor.editBox:SetMaxLetters(30)
                    EditText("Edit macro name", MacroName:GetText(), function()
                        local text = textEditor.editBox:GetText()
                        
                        DGV.Guides.currentSelectedMacroData.name = text
                        MacroName:SetText(text)
                        RefreshMacrosList() 
                    end)
                end, "Edit macro name")
                editNameButton.button:SetPoint("BOTTOMRIGHT", MacroName, "BOTTOMRIGHT", 20, 0)
                Guides.editNameButton = editNameButton
            else
                editNameButton = Guides.editNameButton
            end
            
            if not Guides.uiInitialized then
                editDescriptionButton = CreateEditButton(function()
                    textEditor.editBox:SetMaxLetters(500)
                    EditText("Edit macro '"..MacroName:GetText().."' description", MacroDescription:GetText(), function()
                        local text = textEditor.editBox:GetText()
                        DGV.Guides.currentSelectedMacroData.data.macroDescription = text
                        MacroDescription:SetText(text)
                        RefreshMacrosList() 
                    end)
                end, "Edit macro description")
                editDescriptionButton.button:SetPoint("BOTTOMRIGHT", MacroDescription, "BOTTOMRIGHT", 20, 0)
                Guides.editDescriptionButton = editDescriptionButton
            else
                editDescriptionButton = Guides.editDescriptionButton
            end
            
            if not Guides.uiInitialized then
                editCodeButton = CreateEditButton(function()
                    textEditor.editBox:SetMaxLetters(255)
                    EditText("Edit macro '"..MacroName:GetText().."' code", MacroCode:GetText(), function()
                        local text = textEditor.editBox:GetText()
                        MacroCode:SetText(text)
                        DGV.Guides.currentSelectedMacroData.data.macroCode = text
                        RefreshMacrosList() 
                        UpdateIcons()
                    end)
                end, "Edit macro code")
                editCodeButton.button:SetPoint("BOTTOMRIGHT", MacroCode, "BOTTOMRIGHT", 20, 0)
                Guides.editCodeButton = editCodeButton
            else
                editCodeButton = Guides.editCodeButton
            end     
            
            if not Guides.uiInitialized then
                deleteMacroButton = CreateDeleteButton(function()
                    if DGV.Guides.currentSelectedCategory then
                        local macros = DugisGuideUser.macrosData[DGV.Guides.currentSelectedCategory]
                        local index = LuaUtils:indexOf(DGV.Guides.currentSelectedMacroData, macros) 
                        table.remove(macros, index)
                        RefreshMacrosList()
                        MacroEditor:Hide()
                        if Guides.macrolist.scrollBar:IsVisible() then
                            local val = Guides.macrolist.frame:GetVerticalScrollRange()
                            Guides.macrolist.scrollBar:SetValue(val - 150)
                        else
                            Guides.macrolist.scrollBar:SetValue(0)
                        end
                        
                    end
                    
                end, "Delete this macro")
                deleteMacroButton.button:SetPoint("BOTTOMRIGHT", MacroEditor, "BOTTOMRIGHT", -30, 20)
                Guides.deleteMacroButton = deleteMacroButton
            else
                deleteMacroButton = Guides.deleteMacroButton
            end
            
            Guides.uiInitialized = true

		else
            DugisMain.MacrosWrapper:Hide()
            
        end]===]
        
        function UpdateWhatsNewText()
            local text = NPCJournalFrame:ReplaceSpecialTags(whatsNewText, nil, nil, nil, true)
			whatsNewFrame:SetJustifyH("LEFT")
            whatsNewFrame:SetText(text)
        end
        
        function UpdateWhatsNewFramePositions()
            if whatsNewFrame and whatsNewFrame:IsVisible() then
                guidesMainScroll.scrollBar:SetMinMaxValues(1, whatsNewFrame:GetRegions():GetHeight())
                
                local extraOffset = -10
                local parentHeight = guideategorieswrapper.height
                
                if parentHeight == 0 then
                    extraOffset = 20
                end
                
                local whatsNewLeft = 5
                
                whatsNewFrame:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", whatsNewLeft, -parentHeight -70 + extraOffset) 
                whatsNewFrame.title:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", whatsNewLeft, -parentHeight -40 + extraOffset) 
            end            
        end
        
        if self.text == "Recent Guides" then
            if not whatsNewFrame then
                CreateFrame("SimpleHTML", "whatsNewFrame", guideategorieswrapper)
                CreateFrame("SimpleHTML", "whatsNewFrame_EventHandler", whatsNewFrame)
                
                whatsNewFrame_EventHandler:SetScript("OnHyperlinkClick", function(...)
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkClick(...)
                end) 
                
                whatsNewFrame_EventHandler:SetScript("OnHyperlinkEnter", function(self, linkData, link, button)
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkEnter(self, linkData, link, button, false, false, true)
                    NPCJournalFrame.needToUpdateWaypointButtonsWN = true
                end)     
                
                whatsNewFrame_EventHandler:SetScript("OnHyperlinkLeave", function(...)
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkLeave(...)
                    NPCJournalFrame.needToUpdateWaypointButtonsWN = true
                end) 
                
                --Whats new configuration
                
                local whatsNewTitleYOffset = -9
                local whatsNewTitleFont = "GameFontNormalLarge"
                local whatsNewTitleColor = {1, 0.82, 0, 1}
                local whatsNewContentYOffset = -40
                local whatsNewContentFont = GameFontHighlight
                
                guidesMainScroll.frame:EnableMouseWheel(true)
                guidesMainScroll.frame:SetScript("OnMouseWheel", function(self, delta)
                    guidesMainScroll.scrollBar:SetValue(guidesMainScroll.scrollBar:GetValue() - delta * 44)  
                end)  

                local title = guideategorieswrapper:CreateFontString(guideategorieswrapper, "ARTWORK", whatsNewTitleFont)
                whatsNewFrame.title = title
                title:SetText("What's new|TInterface\\AddOns\\DugisGuideViewerZ\\Artwork\\highlight.tga:1:100:-80:10|t")
                title:SetTextColor(unpack(whatsNewTitleColor))
                title:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", 20, whatsNewTitleYOffset)
                title:Show()
                
                whatsNewFrame:SetFontObject(whatsNewContentFont)
                whatsNewFrame:EnableMouse(false)
                whatsNewFrame:SetHyperlinksEnabled(false) 
                whatsNewFrame:SetWidth(362)
                whatsNewFrame:SetHeight(282)
                whatsNewFrame:SetJustifyH("CENTER")
                whatsNewFrame:SetJustifyV("TOP")    
                
                whatsNewFrame:SetSpacing(2)
                whatsNewFrame:SetFrameLevel(51)
                
                whatsNewFrame_EventHandler:SetFontObject(whatsNewContentFont)
                whatsNewFrame_EventHandler:EnableMouse(true)
                whatsNewFrame_EventHandler:SetWidth(362)
                whatsNewFrame_EventHandler:SetHeight(282)
                whatsNewFrame_EventHandler:SetJustifyH("CENTER")
                whatsNewFrame_EventHandler:SetJustifyV("TOP")    
                whatsNewFrame_EventHandler:SetFrameLevel(50)
                whatsNewFrame_EventHandler:SetPoint("TOPLEFT", guideategorieswrapper, "TOPLEFT", 20, whatsNewContentYOffset) 
                whatsNewFrame_EventHandler:SetSpacing(2)
                whatsNewFrame_EventHandler:SetAlpha(0.1)
            end
            
            whatsNewFrame:Show()
            whatsNewFrame.title:Show()
            whatsNewFrame_EventHandler:Show()
            whatsNewFrame_EventHandler:SetAllPoints(whatsNewFrame)
            
            local text = NPCJournalFrame:ReplaceSpecialTags(whatsNewText, nil, nil, nil, true)
			whatsNewFrame_EventHandler:SetJustifyH("LEFT")
            whatsNewFrame_EventHandler:SetText(text)
            
            guidesMainScroll.scrollBar:Show()  
      
            UpdateWhatsNewText()
            
			if UpdateWhatsNewFramePositions then
				UpdateWhatsNewFramePositions()
			end
        end	        
        
        lastClickedTab = self.text
	end
    
    function Guides.TabInfoActivate(self)
        if self.text == "Suggest" then
            LuaUtils:CreateThread("TabInfoActivate", function()
                MainFramePreloader:ShowPreloader()   
                TabInfoActivate_(self, true)
                MainFramePreloader:HidePreloader()   
            end)
        else
            LuaUtils:RunInThreadIfNeeded("TabInfoActivate", function(isInThread, self)   
                TabInfoActivate_(self, isInThread)
            end, nil, {self})        
        end
    end    
	
	for _,tab in ipairs(tabs) do
		tab.Activate = Guides.TabInfoActivate
		tab.RightShouldScroll = TabInfoRightShouldScroll
		tab.LeftShouldScroll = TabInfoLeftShouldScroll
	end
	
	GetCurrentGuideTypeTabInfo = function()
		if DGV:isValidGuide(CurrentTitle) == true then
			local guideType = DGV.gtype[CurrentTitle]
			for _,tabInfo in ipairs(tabs) do
				if tabInfo.guidetype==guideType then
					return tabInfo
				end
			end
		end
	end

	local function AutoCheckLootSteps()
		 for i=1, (lastUsedStepIndex or 0) do
			if DGV:havelootitem(i) == true and not DGV:ReturnTag("O", i) and DGV:GetQuestState(i-1) == "C"  then
				DGV:SetChkToComplete(i)
			end	
		end

		DGV.UpdateGuideVisualRows()
	end


	function DGV:ReloadButtonOnClick()
		DGV:DisplayViewTabInThread(CurrentTitle, nil, true, AutoCheckLootSteps)
        DGV:CollapseCurrentGuide()
        DGV:UpdateCurrentGuideExpanded()  
	end

	function DGV:ResetButtonOnClick()
        LuaUtils:RunInThreadIfNeeded("DGV_ResetButtonOnClick", function(isInThread)
        
		local i
		for i = 1, lastUsedStepIndex do
			LuaUtils:RestIfNeeded(isInThread)
			DGV:ClrChk(i)	
		end
		DGV:MoveToNextQuest(1)
		DGV:AutoScroll(0)
        
        end)    
	end
    
    --choiceId - textual or numeric value
    function DGV:GoToChoice(choiceId)
        DGV:SetChkToComplete(DugisGuideUser.CurrentQuestIndex)
    
		for i = 1, lastUsedStepIndex do
            local currentChoiceId = DGV:ReturnTag("CHOICE", i)
            if currentChoiceId and tostring(currentChoiceId) == tostring(choiceId) then
                DugisGuideViewer:MoveToNextQuest(i + 1)
                return
            end
		end  
    end

    --choiceId - textual or numeric value
    function DGV:MarkStepsByChoiceId(choiceId, asCompleted)
		for i = 1, lastUsedStepIndex do
            choiceGuideIndex = i + 1
            local currentChoiceId = DGV:ReturnTag("CHOICE", i)
            if currentChoiceId and tostring(currentChoiceId) == tostring(choiceId) then
                if asCompleted then
                    DGV:SetChkToComplete(i)
                else
                    DGV:SetChkToNotComplete(i)
                end
            end
		end  
    end
    
	function DGV:GetQuestState(index, guideName)
        local questIndex = string.format("%s:%d", guideName or CurrentTitle or "", index)
		return DGU.QuestState[questIndex]
	end
    
	--Performance optimization
    local duringMultiStepsChecking = false

	function DGV:SetQuestState(index, setting)
		--self:DebugFormat("SetQuestState", "index", index, "setting", setting, "stack", debugstack(2))
        if  CurrentTitle == DGV.questAutoGuideName and index == 2  then
            return 
        end
		DGU.QuestState[CurrentTitle..':'..index] = setting

		if setting == "C" or setting == "U" then
			shareSystem.notCompletedPlayers[index] = nil
		end

		visualRow = visualRows[index]
		
		DGV.SendDataToServer("NGSS", {index, setting}, 2)

        if visualRow then
            visualRow.needsUpdate = true
        end
	end

	function DGV:MarkForUpdate(index)
        visualRow = visualRows[index]
        if visualRow then
            visualRow.needsUpdate = true
        end
	end		

	function DGV:GetQIDByLogIndex(lindex)
		return select(8, GetQuestLogTitle(lindex))
	end

	function DGV:GetGuideIndexByQID(qid, action)
		local i
		for i=1, lastUsedStepIndex do
			if DGV.qid[i] == qid and (not action or DGV.actions[i] == action) then return i end
		end	
	 end

	function DGV:CompleteQID(qid, state)
		local i
		for i = 1, lastUsedStepIndex do
			if DGV.qid[i] == qid and DGV.actions[i] == state then
				DGV:SetChkToComplete(i)
			end
		end
	end

    function DGV:SetCompletedSID(sid, completed, reset)            
		local i
		for i = 1, lastUsedStepIndex do
			if DGV.sid[i] == sid then
                local index = string.format("%s:%d", guideName or CurrentTitle, i)
                if (completed) then
                    DGV:SetChkToComplete(i)
                elseif reset then
                    DGV:SetChkToNotComplete(i)
                end
			end
		end
		DGV:MoveToNextQuest()
	end
	
    function DGV:SetCompleteAllSID()
		local i
		for i = 1, lastUsedStepIndex do
			if DGV:ReturnTag("SID", i) then
                DGV:SetChkToComplete(i)
			end
		end
        DGV:MoveToNextQuest()		
	end	

    function QuestSuperTracking_GetClosestQuest_Dugis()
        local closestQuestID;
        local title_

		local minDistSqr = math.huge;

        -- Supertrack if we have a valid quest
        return closestQuestID, title_
    end
    

	function DGV:IsCompleteLootQO(calledfrom, itemid, guideIndex)
		--Loot completion
		if not guideIndex then guideIndex = DGU.CurrentQuestIndex end
		local lootitem, lootqty 	= DGV:ReturnTag("L", guideIndex)
		local optional 				= DGV:ReturnTag("O", guideIndex)			
		local inlog 				= DGV:GetQuestLogIndexByQID(DGV.qid[guideIndex])
		local flag = 0

		if calledfrom == "CMSG" then
			if (lootitem and (GetItemCount(lootitem) + 1) >= lootqty) and lootitem == itemid then  
				if (optional and inlog) or (not optional) then
				flag = 1
				end
			end
		elseif calledfrom == "QLU" then
			if lootitem and GetItemCount(lootitem) >= lootqty then  
				if (optional and inlog) or (not optional) then
				flag = 1
				end
			end
		end
		
		if flag == 1 then
			return true
		end
	end

	function DGV:QuestPartComplete(guideIndex)
		local questpart = self:ReturnTag("QIDP", guideIndex)
		if questpart then
			local qid 				=  DGV.qid[guideIndex]
			local logidx 			=  DGV:GetQuestLogIndexByQID(qid)
			local desc, _, done 	=  GetQuestLogLeaderBoard(tonumber(questpart), logidx)		
            
            --Fallback to GetQuestObjectiveInfo in case GetQuestLogLeaderBoard doesn't return information about part completeness.
			if not desc and not done and not logidx then



---------------------------------
----------- WOW Classic:---------
--------------------------------- 
--GetQuestObjectiveInfo not present.  Todo: check if needed/find replacement 
			  --  local text, objectiveType, finished = GetQuestObjectiveInfo(qid, questpart, false)
			  


                if finished then
                    return true
                end
            end
            
			if done and logidx then 
				return true
			end
		end
	end

	function DGV:UpdatePlayerLevels(playerLevel)
		local i
		playerLevel = playerLevel or UnitLevel("player")
		if DGV:isValidGuide(CurrentTitle) == true then
			local guidesize = DGV:GetLastUsedStepIndex()	
			for i=1, guidesize do		
				local reqlvl = self:ReturnTag("PL", i)	
				if reqlvl and reqlvl <= playerLevel and DGV:GetQuestState(i) ~= "C" and not strmatch(self.actions[i], "[f]") then
					self:SetChkToComplete(i)
					if i == DGU.CurrentQuestIndex then self:MoveToNextQuest() end
				end
			end
		end
	end
	
	local function EvaluateMAP(map)
		if map then 
			if DGV:GetPlayerMapPositionDisruptive() == tonumber(map) then return true end
		end
	end
	
	local function EvaluatePHA(pha)
		local currentMap = DGV:GetCurrentMapID()
		local isCurrentMapIsleOfThunder = currentMap == 504 or currentMap == 505 or currentMap == 506
	
		if isCurrentMapIsleOfThunder and NUM_WORLDMAP_POIS == 0 then 
			--WorldMapFrame_Update()
			if NUM_WORLDMAP_POIS == 0 then return true end
		end
		if isCurrentMapIsleOfThunder then 			
			local lowest = 6
			for i=1, NUM_WORLDMAP_POIS do
				local _, poiID

                if GetMapLandmarkInfo then
                    _, _, _, _, _, _, _, _, _, poiID = GetMapLandmarkInfo(i)
                else
                    _, _, _, _, _, _, _, _, _, _, poiID = C_WorldMap.GetMapLandmarkInfo(i)
                end

				if WorldMap_IsSpecialPOI(poiID) then 
					if SPECIAL_POI_INFO[poiID].phase < lowest then 
						lowest = SPECIAL_POI_INFO[poiID].phase
					end
				end
			end
			if lowest ~= 6 then
				return lowest >= tonumber(pha)
			end
		end
	end
	
	local function EvaluateBUFF(buff, nilOnBuffNil)
        if not buff and nilOnBuffNil then
            return
        end
    
		if buff then 
			buff = tonumber(buff)
		end
		for i=1,10 do
			local _,icon = UnitBuff("player",i)
			if (icon and icon == buff) then return true end
			local _,icon = UnitDebuff("player",i)
			if (icon and icon == buff) then return true end
		end
	end		
    
	local function EvaluateBUFF_(buff)
        if not buff then
            return
        end
    
		if buff then 
			buff = tonumber(buff)
		end
		for i=1,10 do
			local _,icon = UnitBuff("player",i)
			if (icon and icon == buff) then return true end
			local _,icon = UnitDebuff("player",i)
			if (icon and icon == buff) then return true end
		end
	end		

	local function EvaluateTID(tid)
		return tid and IsQuestFlaggedCompleted(tid) and not DGV:GetQuestLogIndexByQID(tid)
	end	
	
	local function EvaluateAYG(ayg)
        if not ayg then
            return
        end
		local index = DGV:GetQuestLogIndexByQID(tonumber(ayg))
		local aygComplete
		if index then 		
			aygComplete = select(6, GetQuestLogTitle(index))
		end
		return IsQuestFlaggedCompleted(ayg) or aygComplete
	end		
	
	local function EvaluateOID(oid)
		local index = DGV:GetGuideIndexByQID(tonumber(oid), "A")
		return (index and DGV:GetQuestState(index) == "C") or IsQuestFlaggedCompleted(oid)
	end		
    
    local function EvaluateOIDsORs(oid1, oid2, oid3, oid4)
        return (oid1 and EvaluateOID(oid1)) 
        or (oid2 and EvaluateOID(oid2)) 
        or (oid3 and EvaluateOID(oid3)) 
        or (oid4 and EvaluateOID(oid4)) 
	end	

	local function EvaluatePRE(pre)
		local index = DGV:GetGuideIndexByQID(tonumber(pre), "T")
		--if index then DebugPrint("Debug EvaluatePRE: pre="..tonumber(pre).." DGV:GetQuestState(index)="..DGV:GetQuestState(index)) end
		return (index and DGV:GetQuestState(index) == "C") or IsQuestFlaggedCompleted(pre)
	end

	local function EvaluateREP(factionId, standingRequirement)
		local name, _, standingID = GetFactionInfoByID(tonumber(factionId))
		--DebugPrint("Debug EvaluateREP: standingID="..tostring(standingID).." name="..tostring(name).." factionId="..tonumber(factionId))
		if not standingID then 
			standingID = 4
		end		
		return standingID >= tonumber(standingRequirement)
	end

	local function EvaluateFS(factionId, standingRequirement)
		local name, _, _, _, _, barValue = GetFactionInfoByID(tonumber(factionId))
		return barValue >= tonumber(standingRequirement)
	end
    
	local function EvaluateFS_(factionId, standingRequirement)
        if not factionId then
            return
        end
		local name, _, _, _, _, barValue = GetFactionInfoByID(tonumber(factionId))
		return barValue >= tonumber(standingRequirement)
	end

	local function CheckInitOpt(i)
		local rowFrame = visualRows[i].frame
		if rowFrame.Opt.text==nil then
			local optional 		= DGV:ReturnTag("O", i)
			local pre, pre2, pre3	= DGV:ReturnTag("PRE", i) or DGV:ReturnTag("OO", i)
			local pha			= DGV:ReturnTag("PHA", i)			
			local rep, standing	= DGV:ReturnTag("REP", i)
			local friend, level	= DGV:ReturnTag("FS", i)
			local prof, _		= DGV:ReturnTag("OP", i)
			if optional then
				rowFrame.Opt.text = string.format(" (%s)", L.Optional)
				rowFrame.Opt.optional = true
			elseif pre then
				rowFrame.Opt.text = string.format(" (%s)", L["Pre-quest required"])
				rowFrame.Opt.pre = tonumber(pre)
			elseif pre2 then
				rowFrame.Opt.text = string.format(" (%s)", L["Pre-quest required"])
				rowFrame.Opt.pre2 = tonumber(pre2)				
			elseif pha then
				rowFrame.Opt.text = string.format(" (%s)", L["Stage required"])
				rowFrame.Opt.pha = tonumber(pha)				
			elseif rep then
				rowFrame.Opt.text = string.format(" (%s)", L["Reputation Required"])
				rowFrame.Opt.rep, rowFrame.Opt.standing = tonumber(rep), tonumber(standing)
			elseif friend then
				rowFrame.Opt.text = string.format(" (%s)", L["Reputation Required"])
				rowFrame.Opt.friend, rowFrame.Opt.level = tonumber(friend), tonumber(level)
			elseif prof then
				rowFrame.Opt.text = string.format(" (%s)", L["Profession Required"])
				rowFrame.Opt.prof = true	
			else
				rowFrame.Opt.text	= ""
			end
		end
	end
        
	function DGV:SetQuestColor(i) 
        if i > lastUsedStepIndex then return end
    
		local rowFrame = visualRows[i].frame
		local questpart = self:ReturnTag("QIDP", i)
		if DGV:CheckForSkip(i) then CheckInitOpt(i) end
		
        if not rowFrame then
            return
        end
		
        local questState = self:GetQuestState(i)
        
		if (rowFrame.Opt.optional and i~= DGU.CurrentQuestIndex and questState ~= "C") or 
			(rowFrame.Opt.prof and i~= DGU.CurrentQuestIndex and questState ~= "C") or
			(rowFrame.Opt.pre and not EvaluatePRE(rowFrame.Opt.pre)) or 
			(rowFrame.Opt.pre2 and not EvaluatePRE(rowFrame.Opt.pre2)) or 			
			(rowFrame.Opt.pha and not EvaluatePHA(rowFrame.Opt.pha)) or
			(rowFrame.Opt.rep and not EvaluateREP(rowFrame.Opt.rep, rowFrame.Opt.standing)) or
			(rowFrame.Opt.friend and not EvaluateFS(rowFrame.Opt.friend, rowFrame.Opt.level)) then
			rowFrame.Name:SetTextColor(0.75, 0.75, 0.75, 1)
			rowFrame.Desc:SetTextColor(0.75, 0.75, 0.75, 1) 
			rowFrame.Opt:SetTextColor(0.75, 0.75, 0.75, 1) 
			rowFrame.Opt:SetFontObject("GameFontHighlightSmall",5)
			return
		elseif (strmatch(self.actions[i], "[ACT]") and self:UserSetting(DGV_QUESTCOLORON)) or (questpart and strmatch(self.actions[i], "[NK]") and self:UserSetting(DGV_QUESTCOLORON)) then	--set difficulty color on A/C/T actions
			local color  = self:GetQuestDiffColor(i)
			if color then
				rowFrame.Name:SetTextColor(color.r, color.g, color.b, 1) 
				rowFrame.Opt:SetTextColor(color.r, color.g, color.b, 1) 		
			end
			return
		end
		DGV:SetQuestTextNormal(i)
	end

	function DGV:GetQuestDiffColor(i)
		local color
		local qid = self.qid[i]
		if qid then
			local level = DGV:GetQuestLevel(qid)
			if level and level > 0 then
				color = GetQuestDifficultyColor(level)
			end
		end
		return color
	end

	function DGV:SetAllQuestColor()
		local i, qid
		for i, qid in ipairs(DGV.actions) do
			DGV:SetQuestColor(i)
		end
	end

	function DGV:GetReqQuestLevel(qid)
		if self.ReqLevel[qid] then
			return self.ReqLevel[qid][2]
		end
	end

	function DGV:SetChkToComplete(i, fromSmallFrame)
        local state = DGV:GetQuestState(i)
		if DGV:isValidGuide(CurrentTitle) == true and state ~= "C" and state ~= "X" then

			if not fromSmallFrame then
				local completedByAllClients = true

				local players = {}
				--All players will be recreated in the loop below for the index i
				shareSystem.notCompletedPlayers[i] = players
				if DGV.IsPlayerShareServer() then
					local action = DGV.actions[i]

					for playername, shareClient in pairs(shareSystem.shareClients) do 
						--Ignore offline clients as they are not making progress
						if shareClient.status == "connected" and  shareClient.guideState then

							--Case when client has guide installed
							if shareClient.guideState.hasGuide then
								local clientStepStates = shareClient.guideState.stepStates

								if clientStepStates then
									local clientStepStatus = clientStepStates[i]
									if clientStepStatus == "U" or clientStepStatus == nil or clientStepStatus == "" then
										completedByAllClients = false
										players[playername] = true
									end
								end
							else
								---MISSING GUIDE MODE---
								shareClient.guideState.questStates = shareClient.guideState.questStates or {}
								local questStates = shareClient.guideState.questStates
								local allQuestIds = DGV.aqids and DGV.aqids[i]
								if allQuestIds then

									--Indicates if client completed some quest related to current index
									--If at least one of all quests related to current index is completed 
									--then the quest should be considered as completed
									local atLeastOneQuestWithTheSameState = false
									for questId in pairs(allQuestIds) do
										local questState = questStates[questId]

										if questState and questState[action] == true and 
										(action == "T" or action == "C" or action == "A") then
											atLeastOneQuestWithTheSameState = true
										end
									end

									if not atLeastOneQuestWithTheSameState then
										--To prevent sending QSI_REQUEST multiple times with the same data
										local alreadySent = {}
										for questId in pairs(allQuestIds) do
											if not alreadySent[questId.. i] then
												alreadySent[questId.. i] = true
												DGV.SendDataToClient(shareClient, playername, "QSI_REQUEST", {questId, i}, 2)
												completedByAllClients = false
												players[playername] = true
											end
										end
									end
								end
							end
						end
					end
				end
		
				if not completedByAllClients then 
					DGV:MarkForUpdate(i)
					return 
				end
			end

			self:SetQuestState(i, "C")
		end
	end

    function DGV:SetChkToNotComplete(i)
		if DGV:isValidGuide(CurrentTitle) == true then
			self:SetQuestState(i, "U")
		end
	end

	function DGV:AchieveCompleteFromAchieveID(achieveID, achieveIndex)
		if achieveID ~= 6856 and 
			achieveID ~= 6716 and 
			achieveID ~= 6846 and 
			achieveID ~= 6754 and 
			achieveID ~= 6857 and 
			achieveID ~= 6850 and 
			achieveID ~= 6855 and 
			achieveID ~= 6847 and 
			achieveID ~= 6858 and -- Exclude lorewalker achievement 
			self:UserSetting(DGV_ACCOUNTWIDEACH) then -- Account Wide Achievement
			if (select(4, GetAchievementInfo(achieveID))) then return true end
		end 
		
		if not achieveID then
			return achieveID
		end
		
		local achievementNum = tonumber(GetAchievementNumCriteria(achieveID))
		if achieveIndex and tonumber(achieveIndex) <= achievementNum then
			return (select(3, GetAchievementCriteriaInfo(achieveID, achieveIndex)))
		elseif achieveID then
			return select(4, GetAchievementInfo(achieveID))
			--print(achieveID.." "..achieveIndex)
		end
		
	end

	function DGV:AchieveCompleteFromGuideIndex(guideindx)
		--achieve
		if self.gtype[CurrentTitle] == "A" or self.gtype[CurrentTitle] == "E" or self.gtype[CurrentTitle] == "D" or self.gtype[CurrentTitle] == "L" then 
			local comp, categoryID, description, completed, achieveID, achieveIndex, ret
			achieveID = self:ReturnTag("AID", guideindx)
			achieveIndex = self:ReturnTag("AC", guideindx)
			
			if achieveID then
				ret = self:AchieveCompleteFromAchieveID(achieveID, achieveIndex)
				return ret
			end
		end
	end

	function DGV:PrintAchieve(achieveID, achieveIndex)
		local name, completed, description, ccompleted, cdescription
		
		_, name, _, completed, _, _, _, description, _, _, _ = GetAchievementInfo(achieveID)
		if completed == true then comp = " complete" else comp = " NOT complete" end

		if achieveIndex then
			cdescription, _, ccompleted = GetAchievementCriteriaInfo(achieveID, achieveIndex)
			if ccompleted == true then ccomp = " complete" else ccomp = " NOT complete" end
			DebugPrint("["..achieveID.."] "..name..comp.." STEP: ["..achieveIndex.."] "..cdescription..ccomp)	
		else
			DebugPrint("["..achieveID.."] "..name..comp)			
		end
	end

	function DGV:PrintAllGuideAchieves()
		for i=1, lastUsedStepIndex do
			local achieveID = self:ReturnTag("AID", i)
			local achieveIndex = self:ReturnTag("AC", i)
			if achieveID then self:PrintAchieve(achieveID, achieveIndex) end
		end
	end

	function DGV:SetQuestsState(isInThread)
		local i
		if DGU.QuestState and visualRows then
			
			--Find all previously completed quests and check them
			for i=1, lastUsedStepIndex do		
				LuaUtils:RestIfNeeded(isInThread)
            
				local qid = self.qid[i]
				local state = self:GetQuestState(i)
				if state == "X" or DGU.toskip[qid] then --User skipped	
					self:SetChktoX(i)	
				elseif state == "C" then
					self:SetChkToComplete(i)
				else
					self:ClrChk(i)
				end
			end
			
			self:UpdateMainFrame(isInThread)

		end	
	end

	function DGV:HasQuestBeenTurnedIn(qid)
		if qid then
			return IsQuestFlaggedCompleted(qid)
		end
		-- if DGU.turnedinquests[qid] then
			-- return true
		-- end
	end
	
	local function IsPlayerLevelWithinRange(playerLevel, range)
		if not range then return end
		local minimum, operator, maximum = range:match("%((%d+)(.)(%d*)")
		minimum = tonumber(minimum); maximum = tonumber(maximum)
		if not maximum and operator=="+" then maximum=GetMaxPlayerLevel() end
		return 
			minimum 
			and minimum <= playerLevel 
			and maximum 
			and (maximum > playerLevel or maximum == GetMaxPlayerLevel()),
			minimum,
			maximum
	end

	local function IterateGuidesInRange(invariant, control)
		local playerLevel = DGU.PlayerLevel or UnitLevel("player")
		while true do
			control = next(DGV.guides, control)
			if not control then return end
			local pass, minimum, maximum = IsPlayerLevelWithinRange(playerLevel, DGV:GetGuideRange(control))
			if pass then
				if minimum > UnitLevel("player") - 20 then --need this to reduce suggestions in lower levels
					return control, minimum, maximum
				end
			end
		end
	end
	
	local inRangeLabels = {}
	local inRangeButtons = {}
    
    local function UpdateSuggestFrameImage(mainGuideMetaData, forDungeons)
        local hasImagePreview = (mainGuideMetaData ~= nil and mainGuideMetaData.image ~= nil and mainGuideMetaData.image ~= "")
            
        if hasImagePreview then
            local image = mainGuideMetaData.image
            DugisGuideSuggestFrame.GuideImage:SetTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Guides\\"..image)
            
            DugisGuideSuggestFrame.GuideImage:SetPoint( "TOPLEFT",  DugisGuideSuggestFrame.GuideTitle,  "TOPLEFT",  10, -35)
            
            if forDungeons then
                DugisGuideSuggestFrame:SetHeight(120 + 138)
            else
                DugisGuideSuggestFrame:SetHeight(120 + 158)
            end
            
            DugisGuideSuggestFrame.Or:SetPoint( "TOPLEFT",  DugisGuideSuggestFrame.GuideTitle,  "TOPLEFT",  -17, -175)
            DugisGuideSuggestFrame.GuideImage:Show()
        else
            DugisGuideSuggestFrame.GuideImage:SetTexture(nil)
            DugisGuideSuggestFrame:SetHeight(120)
            DugisGuideSuggestFrame.Or:SetPoint( "TOPLEFT",  DugisGuideSuggestFrame.GuideTitle,  "TOPLEFT",  -17, -25)
            DugisGuideSuggestFrame.GuideImage:Hide()
        end
    end
    
    --Examples:
    --/script AskDungeonGuideSuggest("121(34-39)#121(35-41)#121(36-42)")
    --/script AskDungeonGuideSuggest("462(1-10 Blood Elf)#462(1-12 Blood Elf)#462(1-13 Blood Elf)", "121(34-39)#121(35-41)#121(36-42)")
	function AskDungeonGuideSuggest(...)
        DugisGuideSuggestFrame.GuideImage:Hide()
        
		if DGV:UserSetting(DGV_GUIDESUGGESTMODE) then
            local suggestedGuideRaw = select(1, ...)
			local suggestedGuide = DGV:GetFormattedTitle(suggestedGuideRaw)
			DugisGuideSuggestFrame.Title:SetText(L["Suggested Dungeon Guide"]..":")
			DugisGuideSuggestFrame.Or:SetText(L["Alternative Dungeon Guides"]..":")
			DugisGuideSuggestFrame.GuideTitle:SetText("|cffffffff"..suggestedGuide.."|r")
            
            local mainGuideMetaData = DugisGuideViewer.guidemetadata[suggestedGuideRaw]
            
			DugisGuideSuggestFrame:SetFrameStrata("TOOLTIP")
			DugisGuideSuggestFrame.Title2:Hide()
			DugisGuideSuggestFrame.CompleteYesButton:Hide()			
			DugisGuideSuggestFrame:Show()
			DugisGuideSuggestFrame.suggestedGuide = suggestedGuide
			for _,label in ipairs(inRangeLabels) do
				label:Hide()
			end
			for _,button in ipairs(inRangeButtons) do
				button:Hide()
			end
            
            UpdateSuggestFrameImage(mainGuideMetaData, true)
			DugisGuideSuggestFrame.Or:Hide()
			
			local lastFontString
			for i=2,select("#", ...) do
				local dungeonGuide = select(i, ...)
				local formatted = DGV:GetFormattedTitle(dungeonGuide)
				
				local fontString,button = inRangeLabels[i-1],inRangeButtons[i-1]
				if not fontString then
					fontString = DugisGuideSuggestFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
					fontString:SetJustifyH("LEFT")
					fontString:SetWidth(240)
					fontString:SetHeight(25)
					fontString:SetPoint(
						"TOPLEFT", 
						lastFontString or  DugisGuideSuggestFrame.Or, 
						"BOTTOMLEFT", 
						(lastFontString and 0) or 20, 0)
					tinsert(inRangeLabels, fontString)
					
					button = CreateFrame("Button", nil, DugisGuideSuggestFrame, "UIPanelButtonTemplate")



					button:SetWidth(55)
					button:SetHeight(23)
					button:SetPoint("LEFT", fontString, "RIGHT", 5, 0)
					button:SetText("Go")
					tinsert(inRangeButtons, button)
				end
				fontString:SetText("|cffffffff"..formatted.."|r")
				fontString:Show()
				button:SetScript("OnClick", 
					function()
						print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(formatted).."|cff11ff11 selected.|r")
						DGV:DisplayViewTab(DGV:GetRawTitle(formatted))
						PlaySoundFile("Sound\\Interface\\AlarmClockWarning3.ogg")
						DugisGuideSuggestFrame:Hide()
					end)
				button:Show()
				lastFontString = fontString
			end
			if select("#", ...)>1 then
				DugisGuideSuggestFrame:SetHeight(DugisGuideSuggestFrame:GetHeight()+(select("#", ...)-1)*25+35)
				DugisGuideSuggestFrame.Or:Show()
			end
		end
	end
	
	local dungeonMatches
	local function MatchDungeonGuides(currentZone, playerLevel)
		if not currentZone then
            LuaUtils:DugiSetMapToCurrentZone()
			--currentZone = DGV:GetPlayerMapPositionDisruptive()
			currentZone = DGV:GetCurrentMapID() 
		end
		if not playerLevel then
			playerLevel = UnitLevel("player")
		end
		local preferredSuggestionFound
		if not dungeonMatches then dungeonMatches = {} end
		wipe(dungeonMatches)
		if DGV.guidelist and DGV.guidelist["I"] then 
			for _,title in ipairs(DGV.guidelist["I"]) do
				local zone = tonumber(title:match("^(%d+)"))
				if not zone then
					zone = tonumber(DGV:GetMapIDFromName(title:match("^(.-)%s?%(")))
				end
				if currentZone==zone then
					if CurrentTitle==title then return end
					local range = DGV:GetGuideRange(title)
					if not preferredSuggestionFound and IsPlayerLevelWithinRange(playerLevel, range) then
						preferredSuggestionFound = true
						tinsert(dungeonMatches, 1, title)
					else
						tinsert(dungeonMatches, title)
					end
				end
			end
		end 
		if dungeonMatches and #dungeonMatches>0 then
			AskDungeonGuideSuggest(unpack(dungeonMatches))
			return true
		end
	end
	
	local function SuggestDungeonsByLevelRange(playerLevel)
		if not dungeonMatches then dungeonMatches = {} end
		wipe(dungeonMatches)
		for guideInRange in IterateGuidesInRange do
			if DGV.gtype[guideInRange] == "I" then
				tinsert(dungeonMatches, guideInRange)
			end
		end
		if dungeonMatches and #dungeonMatches>0 then
			AskDungeonGuideSuggest(unpack(dungeonMatches))
			return true
		end
	end

	function DGV:DugisSuggestButtonOnClick()
		local playerLevel = UnitLevel("player")
		if activeTabInfo.text=="Leveling" then
			DGV:AskGuideSuggest(playerLevel)
		elseif activeTabInfo.text=="Dungeons" then
			local currentZone = DGV:GetPlayerMapPositionDisruptive()
			if not MatchDungeonGuides(currentZone, playerLevel) then
				SuggestDungeonsByLevelRange(playerLevel)
			end
		end
	end
	
	-- 
	-- Guide Suggest
	--
    --/script DugisGuideViewer:AskGuideSuggest()
    --/script AskDungeonGuideSuggest("462(1-10 Blood Elf)#462(1-12 Blood Elf)#462(1-13 Blood Elf)", "121(34-39)#121(35-41)#121(36-42)")
	function DGV:AskGuideSuggest(playerLevel)
        DugisGuideSuggestFrame.GuideImage:Hide()
    
		if not playerLevel then
			playerLevel = UnitLevel("player")
		end

		if self:UserSetting(DGV_GUIDESUGGESTMODE) then
			local suggestedGuide, suggestedGuideRaw = self:GetSuggestedGuide(playerLevel)
			if not suggestedGuide and UnitLevel("player") ~= GetMaxPlayerLevel() then 
				--print("|cff11ff11Dugi Guides: |rPlayer level "..UnitLevel("player").." guide not installed."); 
				return 
			elseif not suggestedGuide then
				return
			end
			suggestedGuide = self:GetFormattedTitle(suggestedGuide)
			DugisGuideSuggestFrame.Title:SetText(L["Suggested Leveling Guide"]..":")
			DugisGuideSuggestFrame.Or:SetText(L["Alternative Leveling Guides"]..":")
			DugisGuideSuggestFrame.GuideTitle:SetText("|cffffffff"..suggestedGuide.."|r")
			DugisGuideSuggestFrame:SetFrameStrata("TOOLTIP")
			DugisGuideSuggestFrame.Title2:Show()
			DugisGuideSuggestFrame.CompleteYesButton:Show()
			DugisGuideSuggestFrame:Show()
			DugisGuideSuggestFrame.suggestedGuide = suggestedGuide
			for _,label in ipairs(inRangeLabels) do
				label:Hide()
			end
			for _,button in ipairs(inRangeButtons) do
				button:Hide()
			end
			DugisGuideSuggestFrame:SetHeight(120)
            
            local mainGuideMetaData = DugisGuideViewer.guidemetadata[suggestedGuideRaw]
            UpdateSuggestFrameImage(mainGuideMetaData)
            
			DugisGuideSuggestFrame.Or:Hide()
			local lastFontString
			local rangeCount = 0
			for guideInRange,minimum in IterateGuidesInRange do
				if minimum > 1 then

					local formatted = self:GetFormattedTitle(guideInRange)
					if formatted~=suggestedGuide and self.gtype[guideInRange] == "L" then
						rangeCount = rangeCount + 1
						local fontString,button = inRangeLabels[rangeCount],inRangeButtons[rangeCount]
						if not fontString then
							fontString = DugisGuideSuggestFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
							fontString:SetJustifyH("LEFT")
							fontString:SetWidth(240)
							fontString:SetHeight(25)
							fontString:SetPoint(
								"TOPLEFT", 
								lastFontString or  DugisGuideSuggestFrame.Or, 
								"BOTTOMLEFT", 
								(lastFontString and 0) or 20, 0)
							tinsert(inRangeLabels, fontString)
							
							button = CreateFrame("Button", nil, DugisGuideSuggestFrame, "UIPanelButtonTemplate")



							button:SetWidth(55)
							button:SetHeight(23)
							button:SetPoint("LEFT", fontString, "RIGHT", 5, 0)
							button:SetText("Go")
							tinsert(inRangeButtons, button)
						end
						fontString:SetText("|cffffffff"..formatted.."|r")
						fontString:Show()
						button:SetScript("OnClick", 
							function()
								print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(formatted).."|cff11ff11 selected.|r")
								DGV:DisplayViewTab(DGV:GetRawTitle(formatted))
								PlaySoundFile("Sound\\Interface\\AlarmClockWarning3.ogg")
								DugisGuideSuggestFrame:Hide()
							end)
						button:Show()
						lastFontString = fontString
					end
				end
			end
			if rangeCount>0 then
				DugisGuideSuggestFrame:SetHeight(DugisGuideSuggestFrame:GetHeight()+rangeCount*25+35)
				DugisGuideSuggestFrame.Or:Show()
			end
		end

	end

	function DGV:SuggestButtonOnClick(firstTime, threading)
		local suggestedGuide
		
		if firstTime then 
			suggestedGuide = DGV:GetSuggestedGuide(UnitLevel("player"))
		else 
			suggestedGuide = DugisGuideSuggestFrame.suggestedGuide
		end
		
		if suggestedGuide then 
			DebugPrint("#SUGGESTED:"..suggestedGuide) 
		elseif UnitLevel("player") ~= GetMaxPlayerLevel() then
			DebugPrint("#SUGGESTED: NIL")
			print("|cff11ff11Dugi Guides: |rPlayer level "..UnitLevel("player").." guide not installed.")
		end
		
		if suggestedGuide then
			print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(suggestedGuide).."|cff11ff11 selected.|r")
            if threading then
                DGV:DisplayViewTab(DGV:GetRawTitle(suggestedGuide), nil, threading)
            else
                DGV:DisplayViewTabInThread(DGV:GetRawTitle(suggestedGuide), nil, false)
            end
			PlaySoundFile("Sound\\Interface\\AlarmClockWarning3.ogg")
		end
		
		DugisGuideViewer:RemoveGuideSuggestionNotifications()
		
		DugisGuideSuggestFrame:Hide()
	end

	function DGV:CompleteCurrentQuest()
		if CurrentTitle == nil or DGV.gtype[CurrentTitle] ~= "L" then 
			print("|cff11ff11Dugi Guides:|r No leveling guide loaded. Select a leveling guide first by clicking the suggest button or choose one manually.")
		else 
			local logindex
			local i = DGU.CurrentQuestIndex
			while i <= lastUsedStepIndex do
					logindex = self:GetQuestLogIndexByQID(self.qid[i])
					if not logindex and (DGV:GetQuestState(i) ~= "C") then
						self:SetChktoX(i)
				end
				i = i + 1
			end		
			DugisGuideSuggestFrame:Hide()
			DGV:DisplayViewTab(CurrentTitle)
			self:MoveToNextQuest()
			print("|cff11ff11Dugi Guides:|r Skipped (|cffcc0000x|r) all steps not related to Quests in Log.")
		end
		
		DugisGuideViewer:RemoveGuideSuggestionNotifications()	
	end
    
    if  DugisGuideUser.alreadySuggestedGuides == nil then
        DugisGuideUser.alreadySuggestedGuides = {}
    end
    
	function DGV:ShouldSuggestNewGuide(playerLevel, checkIfWasAlreadySuggested)
		if DugisGuideViewer.CurrentTitle then return end --Disable for classic for now
		--Don't suggest new guide when player can't move to next zone
		--502 DK Start Zone, 539, 611, 545, 678, 679, Worgen Start Zone, 605, 544, 681, 682 Goblin Start Zone
		local mapId = DGV:GetCurrentMapID() 
		DebugPrint("Current mapID:"..mapId)
		if mapId == 502 or mapId == 539 or mapId == 611 or mapId == 545 or mapId == 678 or mapId == 679 or mapId == 605 or mapId == 544 or mapId == 681 or mapId == 682 or mapId == 808 then return end 
        
		local suggestedGuide, suggestedGuideRaw = self:GetSuggestedGuide(playerLevel)
        
		if suggestedGuide ~= CurrentTitle and suggestedGuideRaw ~= nil and (not DugisGuideUser.alreadySuggestedGuides[suggestedGuideRaw] or not checkIfWasAlreadySuggested) then
            --Adding to buffer so in the future the same guide is not suggested anymore
            DugisGuideUser.alreadySuggestedGuides[suggestedGuideRaw] = true
			return true
		end
	end
    
	function DGV:LevelUpSuggestGuide(playerLevel)
        if DGV:ShouldSuggestNewGuide(playerLevel) then
            --DGV:AskGuideSuggest(playerLevel)
        end
	end
	
	local lastCheck = -1
	function DGV.ShowSuggestGuideNotification(playerLevelToBeUsed, onLevelUp)
		local playerLevel = playerLevelToBeUsed or UnitLevel("player")
        
        --CurrentTitle
        if DGV:ShouldSuggestNewGuide(playerLevel, DGV:UserSetting(DGV_ENABLED_GUIDE_NOTIFICATIONS) and DugisGuideViewer:NotificationsEnabled()) 
        and (CurrentTitle == nil or DGV.gtype[CurrentTitle] == "L") and DGV:UserSetting(DGV_GUIDESUGGESTMODE) then
			if DGV:UserSetting(DGV_ENABLED_GUIDE_NOTIFICATIONS) and DugisGuideViewer:NotificationsEnabled() then
				
				local notification = DugisGuideViewer:GetNotificationByType("guide-suggestion")
				if notification == nil then
					--Show notification
					--Check if notification already exist:
					notification = DugisGuideViewer:AddNotification({title = "Leveling Guide Suggested"
					, notificationType = "guide-suggestion"})
					DugisGuideViewer:ShowNotifications()   
					DugisGuideViewer.RefreshMainMenu()
				end
				
				if DGV:UserSetting(DGV_ALWAYS_SHOW_STANDARD_PROMPT_GUIDE) then
					DugisGuideViewer:AskGuideSuggest(playerLevel)
				end
				
			else
				--Old standard prompt
				if onLevelUp then
					--DugisGuideViewer:AskGuideSuggest(playerLevel)
				end
			end
		
		end
	end
	
	LuaUtils:Delay(5, function()
		DugisGuideUser.alreadySuggestedGuides = {}
		
		LuaUtils:invokeWhen(function()
			return LuaUtils.DugiGuidesIsLoading == false
		end, function()
			DugisGuideViewer.ShowSuggestGuideNotification()	
		end)
		
	end)
	
	function DGV:PLAYER_XP_UPDATE(self, level) --not really needed, extra calculations for no reason. 
		--[[local playerXP = UnitXP("player")
		local nextXP = UnitXPMax("player") 
		local percent = playerXP/nextXP
                
        for _, value in pairs({0, 1, 2, 3, 4}) do
            value = value * 0.2
            if percent >= value and percent < (value + 0.2) and lastCheck ~= value then
                DGV.ShowSuggestGuideNotification()
                lastCheck = value
            end
        end ]]
	end	
    
	local function _CycleThroughGuides(guideName, playerLevel)
		local safety = 0
		playerLevel = playerLevel or UnitLevel("player")
		DebugPrint("playerLevel is"..playerLevel.." unitlevel is"..UnitLevel("player"))
		
		while guideName and safety < 50 do
			local LevelRange = DGV:GetGuideRange(guideName)
			if IsPlayerLevelWithinRange(playerLevel, LevelRange) then
				return guideName
			end
			
			safety = safety + 1
			guideName = DGV.nextzones[guideName]
		end
	end

    
    --Result: Formatted Guide, Raw Guide
	function DGV:GetSuggestedGuide(playerLevel)
		if CurrentTitle then DebugPrint("[SG] Start at current guide:"..CurrentTitle) end
		
		local suggestion
		--Only search starting with CurrentTitle if we are on a Leveling guide
		if DGV.gtype[CurrentTitle] == "L" then suggestion = _CycleThroughGuides(self:GetRawTitle(CurrentTitle), playerLevel) end
		
		if suggestion then DebugPrint("[SG] Suggestion from current guide:"..suggestion) return suggestion, suggestion end 
			
		local playerClass, engPlayerClass = UnitClass("player")
		local playerRace,  engPlayerRace  = UnitRace("player") 
		local playerFaction,  engPlayerFaction  = UnitFactionGroup("player") 
		local guideName
		-- 
		-- Starting Zones
		--
		local startguides = 
		{
				BloodElf = "1941(1-12 Blood Elf)#1941(1-12 Blood Elf)#1941(1-12 Blood Elf)", 
				Orc = "1411(1-12 Orc & Troll)#1411(1-12 Orc & Troll)#1411(1-12 Orc & Troll)", 
				Troll = "1411(1-12 Orc & Troll)#1411(1-12 Orc & Troll)#1411(1-12 Orc & Troll)", 
				--Goblin = "194(1-5 Goblin)",
				Tauren = "1412(1-12 Tauren)#1412(1-12 Tauren)#1412(1-12 Tauren)", 
				Scourge = "1420(1-12 Undead)#1420(1-12 Undead)#1420(1-12 Undead)", 
				Undead = "1420(1-12 Undead)#1420(1-12 Undead)#1420(1-12 Undead)", 
				Dwarf = "1426(1-12 Dwarf & Gnome)#1426(1-12 Dwarf & Gnome)#1426(1-12 Dwarf & Gnome)", 
				Gnome = "1426(1-12 Dwarf & Gnome)#1426(1-12 Dwarf & Gnome)#1426(1-12 Dwarf & Gnome)", 
				Draenei = "1943(1-12 Draenei)#1943(1-12 Draenei)#1943(1-12 Draenei)", 
				Human = "1429(1-12 Human)#1429(1-12 Human)#1429(1-12 Human)", 
				NightElf = "1438(1-12 Night Elf)#1438(1-12 Night Elf)#1438(1-12 Night Elf)", 
				--Worgen = "179(1-12 Worgen)", 
				DeathKnight = "124(55-59 Death Knight)",
				--Pandaren = "378(1-12 Pandaren)",
				--DemonHunter = "672(98-100)",
				--Level110 = "War Campaign (110-120)",
--				VoidElf = "",
--				LightforgedDraenei = "",
--				Nightborne = "",
--				HighmountainTauren = "",
		}
		
		--[[if playerLevel >= 110 and playerLevel < 120 then 
			guideName = startguides["Level110"]
		elseif(engPlayerClass == "DEATHKNIGHT") then
			guideName = startguides["DeathKnight"]
		elseif (engPlayerClass == "DEMONHUNTER") then
			guideName = startguides["DemonHunter"]
		elseif (engPlayerRace == "Pandaren") and (engPlayerFaction == "Alliance") then 
			guideName = startguides["Human"]
		elseif (engPlayerRace == "Pandaren") and (engPlayerFaction == "Horde") then 
			guideName = startguides["Orc"]
		else --]]
		if(engPlayerClass == "DEATHKNIGHT") then
			guideName = startguides["DeathKnight"]
		else
			guideName = startguides[engPlayerRace] 
		end
		--DebugPrint("guideName"..guideName)
		DebugPrint("[SG] No guide found, begin with starting playerRace"..engPlayerRace)
		suggestion = _CycleThroughGuides(guideName, playerLevel)

		if suggestion then DebugPrint("[SG] Suggestion is: "..self:GetFormattedTitle(suggestion)) return self:GetFormattedTitle(suggestion), suggestion end



	end

	function DGV:ReturnGuideTag(tag, Title, threading)
		local GuideTitle = Title or CurrentTitle
		local GuideTags = self.guidetags[GuideTitle]
		
		if not GuideTags then return end
		
		if tag == "PZ" then
			return GuideTags:match("|PZ|")
		elseif tag == "SG" then
			local _, _, check 	= GuideTags:find("|SG|([^|]+)|")
			return check and loadstring("return "..check)()
		end
	end

	function DGV:GetQuestDescription(guideIndex)
		local self = DGV
		local isCollect, desc
		local action 	 = DGV.actions[guideIndex]
		local questTitle = DGV.quests1L[guideIndex]
		
		if NPCJournalFrame then
			questTitle = NPCJournalFrame:ReplaceSpecialTags(DGV.quests1L[guideIndex], true)
		end
		
		local questDesc  = DGV:RemoveParen(DGV.quests2[guideIndex]) 
		local npcID		 = DGV:ReturnTag("NPC", guideIndex)
		
		questDesc 	= self:GetLocalizedNPC(npcID)
		questTitle 	= self:TranslateQuestObjective(guideIndex) or questTitle
		
		if (DGV:ReturnTag("T", guideIndex)) then isCollect = true end
		
		if not questTitle then questTitle = "..." end
		if not questDesc then questDesc = "" end
		
		if action == "A" then
			if questDesc ~= "" then
				desc = L["Accept"].." |cffffd200'"..questTitle.."'|r ("..questDesc..")"
			else
				desc = L["Accept"].." |cffffd200'"..questTitle.."'|r"
			end
		elseif action == "T" then
			if questDesc ~= "" then
				desc = L["Turn in"].." |cffffd200'"..questTitle.."'|r ("..questDesc..")"
			else
				desc = L["Turn in"].." |cffffd200'"..questTitle.."'|r"
			end
		elseif action == "F" then
			desc = L["Fly to"].." |cffffd200"..questTitle.."|r"
		elseif action == "C" then
			desc = L["Complete"].." |cffffd200'"..questTitle.."'|r"
		elseif action == "R" then
			desc = L["Travel to"].." |cffffd200"..questTitle.."|r"
		elseif action == "H" then
			desc = L["Hearth to"].." |cffffd200"..questTitle.."|r"
		elseif action == "h" then
			desc = L["Set Hearth at"].." |cffffd200"..questTitle.."|r"
		elseif action == "f" then
			desc = L["Grab"].." |cffffd200"..questTitle.."|r flight path"				
		elseif action == "U" then
			desc = L["Use"].." |cffffd200"..questTitle.."|r"
		elseif action == "K" then
			desc = L["Kill"].." |cffffd200"..questTitle.."|r"
		elseif action == "B" then
			desc = L["Buy"].." |cffffd200"..questTitle.."|r"
		elseif isCollect == true then
			desc = L["Collect"].." |cffffd200"..questTitle.."|r" 			
		else
			desc = "|cffffd200"..(questTitle or "").."|r"
		end
		return desc
	end

	local function IsInDungeon(mapID)
		if mapID ~= 970 and DGV.Modules.TaxiData.InstancePortals[mapID] then
			return true
		else
			return
		end
	end
	
	--Map current quest. LuaUtils:DugiGetQuestWorldMapAreaID return 0 if player is not on quest
	if not DelayAndMapCurrentObjectiveFrame then
		DelayAndMapCurrentObjectiveFrame = CreateFrame("Frame")
		DelayAndMapCurrentObjectiveFrame:Hide() 
	end 
	
	function DGV:DelayAndMapCurrentObjective(delay, func) 
		if DelayAndMapCurrentObjectiveFrame:IsShown() then return end
		DelayAndMapCurrentObjectiveFrame.func = func
		DelayAndMapCurrentObjectiveFrame.delay = delay 
		DelayAndMapCurrentObjectiveFrame:Show()
	end
	
	DelayAndMapCurrentObjectiveFrame:SetScript("OnUpdate", function(self, elapsed) 
		self.delay = self.delay - elapsed 
		if self.delay <= 0 then  
			self:Hide() 
			if not self.fromOnModulesLoaded then
				DGV:MapCurrentObjective()
			end
			DGV:WatchQuest()
		end
	end)		
	
	function DGV:MapCurrentObjective(guideIndex, onclick)
	if DGV:isValidGuide(CurrentTitle) == true then
		if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and not onclick then 
			guideIndex = DugisGuideUser.NextQuestIndex
		else 	
			guideIndex = guideIndex or DGU.CurrentQuestIndex
		end 
	
		local mapID, mapFloor, desc, i, TomTomUID, qid
		
		if self:UserSetting(DGV_WAYPOINTSON) or onclick then
			desc = DGV:GetQuestDescription(guideIndex)
			qid = self.qid[guideIndex]
			
			-- Get the mapFloor and mapID
			if self:ReturnTag("Z", guideIndex) then 
				mapID, mapFloor = self:ReturnTag("Z", guideIndex)
				if mapFloor == nil then 
					if IsInDungeon(mapID) or mapID == 504 or mapID == 321 then --Dalaran and Orgrimmar
						mapFloor = 1 
					else 
						mapFloor = 0 
					end
				end			
				--DebugPrint("Mapping with |Z|mapID mapFloor| tag mapId: "..mapID)
				--if mapFloor then DebugPrint("Note floor"..mapFloor) end
			-- Use guide header if a valid Guide Zone is stated 	
			elseif self:GetMapNameFromID(self.GuideMapID) then 
				--DebugPrint("Mapping with Guide zone: "..self.GuideMapID)
				mapID = self.GuideMapID
				if IsInDungeon(mapID) or mapID == 504 or mapID == 321 then --Dalaran and Orgrimmar
					mapFloor = 1 
				else 
					mapFloor = 0 
				end
			-- Use the QID zone. 
			elseif qid and LuaUtils:DugiGetQuestWorldMapAreaID(qid) ~= 0 then 
				--DebugPrint("Mapping with QID zone: "..LuaUtils:DugiGetQuestWorldMapAreaID(qid) )
				mapID, mapFloor = LuaUtils:DugiGetQuestWorldMapAreaID(qid), DGV.GetCurrentMapDungeonLevel()
			end
				
			--Remove previous objective's mapping
			DGV:RemoveAllWaypoints()
			
			if DGV:ReturnTag("PPOS", guideIndex) then

				local x, y
				mapID, mapFloor, x, y = DGV:GetPlayerPosition()

				if self:UserSetting(DGV_CARBONITEARROW) and DGV.carboniteloaded and x then
					self.WaypointsShown = false
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x*100, y*100, desc, guideIndex)
				elseif self:UserSetting(DGV_TOMTOMARROW) and DGV.tomtomloaded and x then
					self.WaypointsShown = false
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x*100, y*100, desc, guideIndex)
					DGV:SafeSetMapQuestId(DGV.qid[guideIndex]);
				elseif x then
					self.WaypointsShown = true
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x*100, y*100, desc, guideIndex)
					DGV:SafeSetMapQuestId(DGV.qid[guideIndex]);
				end
				return
			elseif DGV:ReturnTag("POI", guideIndex) and qid and LuaUtils:DugiGetQuestWorldMapAreaID(qid) > 0 then 

				local m, f = LuaUtils:DugiGetQuestWorldMapAreaID(qid)
				if m then LuaUtils:DugiSetMapByID(m) end --this is needed otherwise QuestPOIGetIconInfo returns nil for POI not in current map.
				local _, posX, posY, objective = QuestPOIGetIconInfo(qid)
	
				if posX then
					DGV:AddCustomWaypoint(posX, posY, desc, m, f, qid)
					return	
				end								
			end				
			
			--Get coordinate from current guide step
			local XYVals = DGV:getCoords(guideIndex)
			if not XYVals then return end
			local isCircular = self:ReturnTag("W", guideIndex)~=nil
			if isCircular and #XYVals == 1 then DugisGuideUser.FinalizeWaypoint = nil end

			for i, coord in ipairs(XYVals) do
				local x, y = unpack(coord)	
				if self:UserSetting(DGV_CARBONITEARROW) and DGV.carboniteloaded then
					self.WaypointsShown = false

-- 					local c, z = getCZ(mapID)
-- 					if czLookup[mapID] then
-- 						TomTomUID = TomTom:AddZWaypoint(c, z, x, y, desc)
-- 					else
-- 						TomTomUID = TomTom:AddWaypoint(x, y, desc)
-- 					end
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x, y, desc, guideIndex)
					--TomTom:SetCrazyArrow (carbonite) not working atm, for now coordinates are returned backwards
					--if i == #XYVals then TomTom:SetCrazyArrow(DugisArrow.waypoints[1].tomtom, 5, desc) DugisArrow:Hide() end	
				elseif self:UserSetting(DGV_TOMTOMARROW) and DGV.tomtomloaded then
					self.WaypointsShown = false
-- 					local opts = {}
-- 					opts.title = desc				
-- 					TomTomUID = TomTom:AddMFWaypoint(mapID, mapFloor, x/100, y/100, opts)
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x, y, desc, guideIndex)
-- 					if i == #XYVals then TomTom:SetCrazyArrow(DGV.DugisArrow.waypoints[1].tomtom, 5, desc) DGV.DugisArrow:Hide() end
					DGV:SafeSetMapQuestId(DGV.qid[guideIndex]);	
				else
					self.WaypointsShown = true
					--Guide uses player zone tag and text zone name, text matches zone name 
					--if not self:IsValidDistance( mapID, mapFloor, x, y ) and CurrentTitle:match("|PZ|") and string.find(GetZoneText(), self.CurrentZoneName) then
					if not self:IsValidDistance( mapID, mapFloor, x, y ) and DGV:ReturnGuideTag("PZ") and string.find(GetZoneText(), self.CurrentZoneName) then
						mapID, mapFloor = self:GetPlayerPosition( "player" )
						DebugPrint("Error: No valid distance, changing mapID, mapFloor to current player position")
					end
					--DebugPrint("self.CurrentZoneName="..self.CurrentZoneName.."GetZoneText()="..GetZoneText())
					DGV.DugisArrow:AddWaypoint(mapID, mapFloor, x, y, desc, guideIndex)

					--if i == 1 then DGV.DugisArrow:setArrow( mapID, mapFloor, x, y, desc ) DGV.DugisArrow:Show() end
					DGV:SafeSetMapQuestId(DGV.qid[guideIndex]);
				end			
			end
			
		end
	end
	end

	function DGV:AutoScroll(indx)
		if Main.rightScroll:GetScrollChild() ~= DGVCurrentGuideFrame then return end
		if indx and crowheight then
			local val = (crowheight * indx) - 100
			if val < 0 then val = 0 end
			Main.rightScroll.bar:SetValue(val)
		end	
	end
    
    local lastBoxIndex = -1
    local lastCheckedState = nil
    
	--Large frame checkbox checked by user
	function DugisGuideViewer_CheckButton_OnEvent(self, event,...)
		local boxindex = self:GetParent().guestStepIndex

		local oldChk	 =  DGV:GetQuestState(boxindex)
		local clearBox
		
		if event == "RightButton" then clearBox = 1 end
        
        local clickedIndexStart = boxindex
        local clickedIndexEnd = boxindex
        
        if lastBoxIndex ~= -1 and IsShiftKeyDown() then
            clickedIndexStart = lastBoxIndex + 1
        end
        
        lastBoxIndex = boxindex
        
        duringMultiStepsChecking = true
        
        if clickedIndexStart ~= clickedIndexEnd  and IsShiftKeyDown() and lastCheckedState then
            for i = clickedIndexStart, clickedIndexEnd  do
                DGV:SetQuestState(i, lastCheckedState)
            end
            
            DGV:MoveToNextQuest()
        else
            local i = clickedIndexEnd
            DGV:TriStateChk(i, clearBox)	
            
            local chk	 =  DGV:GetQuestState(i)
            
            --If user is checking box, move to next step
            if chk == "C" or chk == "X" then
                --if not manualmode or chk == "X" then
                if chk == "X" then 
                    DGV:SkipQuest(i)	
                end
                
                --If CQI just got checked (either by user or because it has same QID as another user checked)
               
                local currentQuestState = DGV:GetQuestState(DGU.CurrentQuestIndex)
                if currentQuestState == "C" or currentQuestState == "X" then
                    DGV:MoveToNextQuest()
                elseif (DGV:UserSetting(DGV_MULTISTEPMODE) or DGV:ReturnTag("AYG", DGU.CurrentQuestIndex)) then
                    DGV:MoveToNextQuest()
                end
                if i == lastUsedStepIndex then
                    DGV:LoadNextGuide()
                end	
            --User is unchecking box, move to prev step
            else--if _G[chkboxname]:GetChecked() == 0 then
                DGV:ClrChk(i)
                
                if oldChk == "X" then
                    DGV:UnSkipQuest(i)
                end
                
                local questDesc  = DGV.quests2[i]
                
                local allChoicesText = ""
                
                for match_ in string.gmatch(questDesc, 'ALLCHOICES(.+)END') do 
                    allChoicesText = match_
                end                    
                
                local allChoices = LuaUtils:split(allChoicesText, ':')
                
                for _, choiceId in pairs(allChoices) do
                    DGV:MarkStepsByChoiceId(choiceId, false)
                end
                
                
                --If CQI just got unchecked (either by user or because it has same QID as another user unchecked)
                local nextindex = DGV:FindNextUnchecked()
                if nextindex < DGU.CurrentQuestIndex then
                    DGV:MoveToPrevQuest()
                elseif DGV:UserSetting(DGV_MULTISTEPMODE) or DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) then 
                    DGV:MoveToNextQuest()
                end
            
            end	

            lastCheckedState = chk         
        end
        
        duringMultiStepsChecking = false
        
        LuaUtils:RunInThreadIfNeeded("DugisGuideViewer_CheckButton_OnEvent", function(isInThread)
        end, function()
            DGV:SetPercentComplete()
        end)
        
        DGV.UpdateGuideVisualRows()
        DGV:UpdateSmallFrame()
	end
    
    function DGV:SetSamallFrameProgressBar(value, text)
        SmallFrameProgressBar:SetValue(100 * value)
        SmallFrameProgressBarText:SetText(text.."%")
    end

	function DGV:LoadNextGuide()
		local nextguide = DGV.nextzones[CurrentTitle]

		if nextguide then 
			DGV:DisplayViewTabInThread(nextguide)
		else -- Clear Guide
			DGV:ClearScreen()
			CurrentTitle = nil
			DugisGuideViewer.CurrentTitle = nil
			shareSystem.notCompletedPlayers = {}
			DGV.SendCurrentGuideTitleToClients()
			DugisGuideUser.CurrentQuestIndex = nil
			DGV.SendDataToServer("NGSI")
			DGV.SendDataToClients("NGSI-SV")			
            lastUsedStepIndex = -1
			CurrentQuestName = nil
			DugisGuideViewer:RemoveAllWaypoints()
		end
				
		if CurrentTitle ~= nil and UnitLevel("player") >= 9 then 
			if self.gtype[CurrentTitle] == "L" then
				DGV:AskGuideSuggest()
			end
		end
	end

	function DGV:TriStateChk(index, clear)
		local questState 		= self:GetQuestState(index)
        
		if clear or questState == "X" then
			self:SetQuestState(index, "U")
		elseif questState == "C" then
			self:SetQuestState(index, "X")
		elseif questState == "U" then
			self:SetQuestState(index, "C")
		end
	end

	function DGV:SetChktoX(index)
		self:SetQuestState(index, "X")
	end

	function DGV:ClrChk(index)
		self:SetQuestState(index, "U")
	end

	--User chose to skip the quest and is now changing their mind
	function DGV:UnSkipQuest(qindex)
		local qid = DGV.qid[qindex]
		
		if strmatch(self.actions[qindex], "[ACTNK]") then	
			--Mark all quests with this same qid
			self:UnSkip(qid)
			self:UnSkipPostReqs(qid)	
		else
			DGV:ClrChk(qindex)
		end
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
	end

	--User chose to not do this quest
	function DGV:SkipQuest(qindex)
		local qid = DGV.qid[qindex]
		
		--local logindex = DGV:GetQuestLogIndexByQID(DGV.qid[qindex])
		--if logindex then RemoveQuestWatch(logindex)	end	
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		
		if strmatch(self.actions[qindex], "[ACTNK]") then
			self:Skip(qid)
			self:SkipPostReqs(qid)
		else --Other tag type only skip this one, not the chain
			DGV:SetChktoX(qindex)
		end
	end

	function DGV:SetQuestTextNormal(i)
		local rowFrame = visualRows[i].frame
		rowFrame.Name:SetTextColor(1, 0.82, 0, 1) 
		rowFrame.Desc:SetTextColor(1, 1, 1, 1) 
		rowFrame.Opt:SetText("")
	end
	
	function DGV.IterateRelevantSteps(invariant, control, nextquest, skipped)
		if not control then
			control = DGU.CurrentQuestIndex
			return control
		else
			local qid = DGV.qid[control]
			control = control + 1
			local between = 1
			if not nextquest then nextquest = DGU.CurrentQuestIndex + 1 end
			if not skipped then skipped = 1 end
			
			if control < lastUsedStepIndex then --prevent last row error
                
                local controlQuestState = DGV:GetQuestState(control)
				if (qid==DGV.qid[control] and qid==DGV.qid[control - 1] and not DGV:ReturnTag("AYG", control - skipped)) and (strmatch(DGV.actions[control], "[NCK]") and strmatch(DGV.actions[control - 1], "[NCK]")) or 
					DGV:CheckForSkip(control) or 
					controlQuestState == "C" or 
					controlQuestState == "X" then

					nextquest = nextquest + 1 
					skipped = skipped + 1
					
					return DGV.IterateRelevantSteps(invariant, control, nextquest, skipped)
				end
                
                local nextQuestIndexAction = DGV.actions[DGU.CurrentQuestIndex + 1] or ""
                local currentQuestIndexAction = DGV.actions[DGU.CurrentQuestIndex] or ""
                local nextquestAction = DGV.actions[nextquest] or ""
                local controlAction = DGV.actions[control] or ""

				if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and strmatch(nextquestAction, "[RATBhU]") and DGV:GetQuestState(nextquest) == "U" then
					if  strmatch(controlAction, "[ATBhUf]") then
						return control					
					end
				end
	
				if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and strmatch(nextquestAction, "[RCNK]") and DGV:GetQuestState(nextquest) == "U" then
					if strmatch(controlAction, "[CNKB]") and not (strmatch(DGV.actions[control - 1] or "", "[ATBhUf]") and DGV:GetQuestState(control) ~= "U") and not DGV:ReturnTag("MD", DGU.CurrentQuestIndex) and not DGV:ReturnTag("MD", control) and not DGV:ReturnTag("AYG", control) then
						return control
					elseif control == nextquest and strmatch(controlAction, "[RFH]") then
						return control
					end
				end	
							
			
				if  strmatch(currentQuestIndexAction, "[RFH]") and strmatch(nextQuestIndexAction, "[ATBhUf]") and not DGV:ReturnTag("SID", DGU.CurrentQuestIndex) then  
					if strmatch(controlAction, "[ATBhUf]") then
						return control
					end
				end
	
				if strmatch(currentQuestIndexAction, "[RFH]") and strmatch(nextQuestIndexAction, "[CNK]") and not DGV:ReturnTag("SID", DGU.CurrentQuestIndex) then  
					if  strmatch(controlAction, "[CNKBU]") and not DGV:ReturnTag("MD", DGU.CurrentQuestIndex) and not DGV:ReturnTag("MD", control) and not DGV:ReturnTag("AYG", control) then
						return control
					elseif DGV:ReturnTag("U", control) and not strmatch(controlAction, "[RFH]") and not DGV:ReturnTag("MD", DGU.CurrentQuestIndex) and not DGV:ReturnTag("MD", control) then
						return control
					end
				end			
	
				if  strmatch(currentQuestIndexAction, "[BhUf]") and strmatch(nextQuestIndexAction, "[AT]") and not DGV:ReturnTag("SID", DGU.CurrentQuestIndex) then  
					if strmatch(controlAction, "[ATBhUf]") then
						return control
					end
				end
	
				if  strmatch(currentQuestIndexAction, "[AT]") or (strmatch(DGV.actions[DGU.NextQuestIndex], "[AT]") and DGV:ReturnTag("AYG", DGU.CurrentQuestIndex)) and not DGV:ReturnTag("SID", DGU.CurrentQuestIndex) then  
					if strmatch(controlAction, "[ATBhUf]") then
						return control
					end
				end
				
				if strmatch(currentQuestIndexAction, "[CNK]") and not DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and not DGV:ReturnTag("SID", DGU.CurrentQuestIndex) then   
					if  strmatch(controlAction, "[CNKB]") and not DGV:ReturnTag("MD", DGU.CurrentQuestIndex) and not DGV:ReturnTag("MD", control) then
						return control
					elseif  DGV:ReturnTag("U", control) and not strmatch(controlAction, "[RFHU]") and not DGV:ReturnTag("MD", DGU.CurrentQuestIndex) and not DGV:ReturnTag("MD", control) then
						return control
					end
				end	
			end			
		end
	end

	function DGV:WatchQuest()
		local logindex
		DGU.removedQuests = {}
		
		if ((self:UserSetting(DGV_OBJECTIVECOUNTER) and not self:IsSmallFrameFloating())) and DGV:isValidGuide(CurrentTitle) == true then
			local i = DGU.CurrentQuestIndex
			local action = self.actions[i]
			if i and action and strmatch(action, "[R]") then
				logindex = self:GetQuestLogIndexByQID(self.qid[i])
				i = i + 1
			end
			local skiplogindex = nil
			local onceonly = false
			while i <= lastUsedStepIndex and action and strmatch(action, "[CTNK]") do
				local qid = tonumber(self.qid[i])
				if self:GetQuestState(i) ~= "X" then
					if DGV.carboniteloaded then
						logindex = self:GetCarboniteQuestLogIndexByQID(qid)	
					else
						logindex = self:GetQuestLogIndexByQID(qid)				
					end
					if logindex and DGV.carboniteloaded and Nx.Quest then
						Nx.Quest.Watch:Add(logindex)
					elseif logindex and DugisGuideUser.shownObjectives[qid] then
						if self:UserSetting(DGV_OBJECTIVECOUNTER) and self:UserSetting(DGV_MULTISTEPMODE) then
							RemoveQuestWatch(logindex)
							DGU.removedQuests[qid] = true
						elseif self:UserSetting(DGV_OBJECTIVECOUNTER) and not self:UserSetting(DGV_MULTISTEPMODE) and (skiplogindex ~= logindex) and not onceonly and not strmatch(self.actions[DGU.CurrentQuestIndex], "[R]") then
							RemoveQuestWatch(logindex)
							skiplogindex = logindex
							onceonly = true
							DGU.removedQuests[qid] = true
						elseif skiplogindex ~= logindex or strmatch(self.actions[DGU.CurrentQuestIndex], "[R]") then
							AddQuestWatch(logindex)
						end
					end
				end			
				i = i + 1
			end
		end
		
		if self:UserSetting(DGV_OBJECTIVECOUNTER) and DGV:isValidGuide(CurrentTitle) == true then
			DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		end
	end	
	
	function DGV:havelootitem(indx)
		local havel
		local lootitem, lootqty 	= DGV:ReturnTag("L", indx)
		if lootitem and (GetItemCount(lootitem) >= lootqty) then havel = true else havel = false end
		return havel
	end
	
	function DGV:havecurrencyitem(indx)
		local havec
		local curitem, curqty 	= DGV:ReturnTag("CUR", indx)
		if curitem and (select(2, GetCurrencyInfo(curitem)) >= curqty) then havec = true else havec = false end
		return havec
	end	

	function DGV:haveuseitem(indx)
		local haveu
		local useitem 				= DGV:ReturnTag("U", indx)
		local uinbag 				= DGV:InBag(useitem)
		if (useitem and uinbag) then haveu = true else haveu = false end 
		return haveu
	end
    
    function DGV:IsQuestInObjectiveTracker(questId)
        if IsWorldQuestWatched(questId) then
            return true
        end
    end    
  
---------------------------------
----------- WOW Classic:---------
---------------------------------	
--BonusObjectiveTracker_UntrackWorldQuest is not present. Todo: check if needed/find replacement 
--[[
    hooksecurefunc("BonusObjectiveTracker_UntrackWorldQuest", function()
        DugisGuideViewer:MoveToPrevQuest()
	end)   
	]]
	
---------------------------------
----------- WOW Classic:---------
---------------------------------
--BonusObjectiveTracker_TrackWorldQuest is not present. Todo: check if needed/find replacement 
--[[	
    hooksecurefunc("BonusObjectiveTracker_TrackWorldQuest", function()
        DugisGuideViewer:MoveToPrevQuest()
	end)     
	]]

    local function isQuestCompleted(qid)
        if qid then
            local logIndx = DugisGuideViewer:GetQuestLogIndexByQID(qid)
            if logIndx then
                local _, _, _, _, _, qComplete, _, _ = GetQuestLogTitle(logIndx) 
            end
            return qComplete == 1 
        end
    end

	function DGV:CheckForSkip(indx) 
		local lootitem			 	= DGV:ReturnTag("L", indx) and not DGV:ReturnTag("OO", indx) 
		local optional 				= DGV:ReturnTag("O", indx) or DGV:ReturnTag("OO", indx) -- |OO| used with |QID| |L|, Show optional quest but tick step if loot exist. 
		local pre, pre2, pre3		= DGV:ReturnTag("PRE", indx)
		local rep, standing			= DGV:ReturnTag("REP", indx)
		local friend, level			= DGV:ReturnTag("FS", indx)		
		local useitem 				= DGV:ReturnTag("U", indx)
		local inlog 				= DGV:GetQuestLogIndexByQID(DGV.qid[indx])
		local action				= DGV.actions[indx]
		local toohigh				= DGV:IsQuestTooHigh(indx)
		local hasprof, _			= DGV:ReturnTag("OP", indx)
		local pha					= DGV:ReturnTag("PHA", indx)
		local map1, map2, map3, map4 = DGV:ReturnTag("MAP", indx)
		local tid					= DGV:ReturnTag("TID", indx)
		local questId				= DGV:ReturnTag("QID", indx)
		local WQ					= DGV:ReturnTag("WQ", indx)
		local tidInlog
       
        if questId and LuaUtils:trim(questId) ~= "" and tonumber(questId) ~= nil then
            local isWOrldQuest = QuestUtils_IsQuestWorldQuest(questId)
            if WQ or isWOrldQuest then
            
                if not DGV:IsQuestInObjectiveTracker(questId) or isQuestCompleted(questId) then
                    return true
                end
            end
        end
		
		if tid then tidInlog = DGV:GetQuestLogIndexByQID(tonumber(tid)) end
		
		local haveuse, haveloot
		haveuse = self:haveuseitem(indx)
		haveloot = self:havelootitem(indx)
		local inmap 
		if map1 then 
			if EvaluateMAP(map1) then 
				inmap = true 
			elseif EvaluateMAP(map2) then 
				inmap = true
			elseif EvaluateMAP(map3) then 
				inmap = true
			elseif EvaluateMAP(map4) then 
				inmap = true
			else
				inmap = false
			end
		end
		--|L| + "A" + Optional - skipped if the user does not have the item (and quantity) needed. 
		--|U| + "A" + Optional - skipped if the user does not have the item to use
		
		--[[
		local loginfo
		local qid = DGV.qid[indx]
		if inlog and qid and indx then
			loginfo = "qid:"..qid.."guideindex"..indx.."logindex:"..inlog
		elseif qid and indx then
			loginfo = "qid:"..qid.."guideindex"..indx
		elseif indx then
			loginfo = "guideindex"..indx
		end
		DebugLog(loginfo)
		--]]
		
		if optional and action == "A" and (haveloot or haveuse)  then
		--if optional and action == "A" and haveuse then
			--DebugPrint("Detected use/loot item in bag, display quest")
			return false
		elseif optional and haveloot then
			return false				
		elseif hasprof and not DGV:HasProfession(hasprof) then
			return true
		elseif optional and inmap then 
			return false
		elseif optional and tidInlog then
			return false
		elseif optional and lootitem then
			return true														
		elseif optional and not inlog then
			--DebugPrint("SKIP: optional and not in log.")
			return true				
		--elseif optional and ((action =="A" and useitem and not haveuse) or (lootitem and not haveloot)) then
		elseif optional and (action =="A" and useitem and not haveuse) then
			--DebugPrint("SKIP: not enough loot or no use item")
			return true
		elseif rep and not EvaluateREP(rep, standing) then
			return true		
		elseif friend and not EvaluateFS(friend, level) then
			return true		
		elseif inlog then
			return false				
		elseif pre and not EvaluatePRE(pre) then
			return true
		elseif pre2 and not EvaluatePRE(pre2) then
			return true	
		elseif pre3 and not EvaluatePRE(pre3) then
			return true						
		elseif pha and not EvaluatePHA(pha) then 
			return true											
		elseif toohigh then
			return true --Create more cons than pros and not really needed
		else
			return false
		end
		
	end

	function DGV:CheckForLocation(indx) 
		--R - Run, F - Fly, b - Boat, H - use hearth
		if not DGV.actions then
		    return 
		end
		local action = DGV.actions[indx]
		local guideIndex
		if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) then
			guideIndex = DGU.NextQuestIndex	
		else
			guideIndex = DGU.CurrentQuestIndex
		end		
		
		if indx == guideIndex and (action == "R" or action == "F" or action == "b" or action == "H") and not DGV.tags[DGU.CurrentQuestIndex]:match("(|REACH|)") then
			local subzonetext = string.trim(GetSubZoneText()) -- returns blank if no subzone
			local zonetext = GetZoneText() 
			local quest = self:RemoveParen(self.quests1L[indx])
			if subzonetext == quest or zonetext == quest then			
				return true
			end
		end
	end

	local function CheckForWaypointLocation(indx)
		if CurrentTitle ~= nil then 
        
			if DGU.CurrentQuestIndex and indx == DGU.CurrentQuestIndex and DGV.tags[DGU.CurrentQuestIndex] then 
            
                local tag = DGV.tags[DGU.CurrentQuestIndex]
            
                -- Case: |REACH|22,22|   
                local coordinates = tag:match("|REACH|[^|0-9]*([0-9]+[^|]*)|")
                
                if coordinates then
                    local x, y, m, f = unpack(LuaUtils:split(coordinates, ","))
                    x, y, m, f = tonumber(x), tonumber(y), tonumber(m), tonumber(f)
                    
                    if not m or not f then
                        local mapID, mapFloor = DGV:ReturnTag("Z", DGU.CurrentQuestIndex)
                        m = m or mapID
                        f = f or mapFloor
                    end
                    
                    if not m or not f then
                        local qid = DGV.qid[DGU.CurrentQuestIndex]
						local mapID, mapFloor
						if qid then 
                        	mapID, mapFloor = LuaUtils:DugiGetQuestWorldMapAreaID(qid), DGV.GetCurrentMapDungeonLevel()
							m = m or mapID
							f = f or mapFloor
						end
                    end
                    
                    if not m or not f then
                        local pmap, pfloor = DGV:GetPlayerPosition()
                        m = m or pmap
                        f = f or pfloor
                    end
                    
                    if DGV.DugisArrow:DidPlayerReachPlace(x, y, m, f) then
                        return true
                    end
                else
                    -- Case: |REACH|
                    if tag:match("(|REACH|)") and DGV.DugisArrow.waypoints and #DGV.DugisArrow.waypoints==1 and 
                    DGV.DugisArrow:getFirstWaypoint()==DGV.DugisArrow:DidPlayerReachWaypoint() then
                        return true
                    end
                end
             
			end
            
		end 
	end

	function DGV:UpdateTravelToLocation()
		local waypointObjective = CheckForWaypointLocation(DGU.CurrentQuestIndex) 
		if waypointObjective then 
			DGV:SetChkToComplete(DGU.CurrentQuestIndex)
			DGV:MoveToNextQuest()
		end
	end
	
	--Check for current hearthstone location
	function DGV:CheckForHearth(indx)
		if indx == DGU.CurrentQuestIndex then
			local action = DGV.actions[indx]
			if action == "h" then
				local quest = DGV.quests1L[indx]
				if GetBindLocation() == quest then			
					return true
				end
			end
		end
	end 

	function DGV:FindNextUnchecked(isInThread)
		local indx = 1
		while indx < lastUsedStepIndex do
			--self:DebugFormat("FindNextUnchecked", "self:GetQuestState(indx)", self:GetQuestState(indx), "DGV:CheckForSkip(indx)", DGV:CheckForSkip(indx))
			if self:GetQuestState(indx) == "U" and DGV:CheckForSkip(indx) == false then
				break
			end
            
			LuaUtils:RestIfNeeded(isInThread)
            
			indx = indx + 1
		end
		return indx

	end
	
	local function SetUseItem(index)
		DGV:SetUseItem(DGU.CurrentQuestIndex)
	end

	function DGV:OnMoveToNextQuest()
		local questId	= DGV:ReturnTag("QID", DGU.CurrentQuestIndex)
		if questId and questId ~= "" then

			local questsOnMap = DGV.GetAllActiveQuests()
			local questExists = false

			for i, questInfo in pairs(questsOnMap) do
				if tonumber(questId) == tonumber(questInfo.questId) then
					questExists = true
				end
			end

			if questExists then
				DGV.superTrackedQuestID = tonumber(questId)
				LuaUtils:Delay(1, function()
					DGV.UpdateAllQuestVisualizations()
				end)
			end
		end
	end

	--Move to next quest after CurrentQuest we are on
	--Or specific quest with MoveToIndex
	function DGV:MoveToNextQuest(MoveToIndex, isInThread, recursion, fromOnModulesLoaded, fromSeverUpdate)
		local checkMoved
		if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and not MoveToIndex then 
			checkMoved = DGU.NextQuestIndex
		else 	
			checkMoved = DGU.CurrentQuestIndex
		end
	
		if DGV.IsStepCompletedByServer(MoveToIndex or DGU.CurrentQuestIndex) then
			DGU.CurrentQuestIndex = MoveToIndex or DGU.CurrentQuestIndex
		else
			DGU.CurrentQuestIndex = tonumber(shareSystem and shareSystem.shareServer and shareSystem.shareServer.currentStepIndex_serverSide)
		end

		if not fromSeverUpdate then
			DGV.SendDataToServer("NGSI")
		else
			DGV.SendDataToServer("NGSI-TERMINAL")
		end

		DGV.SendDataToClients("NGSI-SV")		

		if not recursion then
			DGV:OnMoveToNextQuest()
		end

		if not DGU.CurrentQuestIndex then return end
		if DGU.CurrentQuestIndex <= lastUsedStepIndex then

			--Phasing out the global CQI
            local oldQuestIndex = DGU.CurrentQuestIndex
			local new = DGV:FindNextUnchecked()

			if DGV.IsStepCompletedByServer(new) then
				DGU.CurrentQuestIndex = new
			else
				DGU.CurrentQuestIndex = tonumber(shareSystem and shareSystem.shareServer and shareSystem.shareServer.currentStepIndex_serverSide)
			end

			if not fromSeverUpdate then
				DGV.SendDataToServer("NGSI")
			else
				DGV.SendDataToServer("NGSI-TERMINAL", true)
			end
			DGV.SendDataToClients("NGSI-SV")			

			if not recursion then
				DGV:OnMoveToNextQuest()
			end
		
            --First two conditions are toDelayAndMapCurrentObjective prevent infinite loop / stack pverflow
			if DGU.CurrentQuestIndex and oldQuestIndex ~= DGU.CurrentQuestIndex and ((DGV:havelootitem(DGU.CurrentQuestIndex) == true and not DGV:ReturnTag("O", DGU.CurrentQuestIndex)) or DGV:havecurrencyitem(DGU.CurrentQuestIndex) == true) then
				DebugPrint("#####havelootitem(DGU.CurrentQuestIndex) ")
				DGV:SetChkToComplete(DGU.CurrentQuestIndex)
				DGV:MoveToNextQuest(nil, isInThread, true, nil, fromSeverUpdate)    
			end	
			
			if self:ReturnTag("AS", DGU.CurrentQuestIndex) and self:UserSetting(DGV_AUTOSTICK) then
				self.Modules.StickyFrame:AddRow(DGU.CurrentQuestIndex)
				DGV:SetChkToComplete(DGU.CurrentQuestIndex)
				DGV:MoveToNextQuest(nil, isInThread, true, nil, fromSeverUpdate)   

			end
			self.UpdateStickyFrame( )

			if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) then 
				DGV:UpdateCompletionVisuals(true) 
			end			
			
			if (not DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and checkMoved ~= DGU.CurrentQuestIndex) or 
				(DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) and checkMoved ~= DGU.NextQuestIndex) or 
				MoveToIndex then
				if not DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) then
					DGV:UpdateCompletionVisuals(true) 
				end
				DGV:SetQuestColor(DGU.CurrentQuestIndex)
				CurrentAction = DGV.actions[DGU.CurrentQuestIndex] 	
				CurrentQuestName = DGV.quests1L[DGU.CurrentQuestIndex] 
	
				DGV.DoOutOfCombat(SetUseItem, DGU.CurrentQuestIndex)
				DGV:SetTarget(DGU.CurrentQuestIndex)
					
				if DGV:ReturnTag("POI", DGU.CurrentQuestIndex) then 
					DGV:DelayAndMapCurrentObjective(0.5, fromOnModulesLoaded)
				else				
					DGV:DelayAndMapCurrentObjective(0.2, fromOnModulesLoaded) 
					DGV:WatchQuest()
				end
				
				if DGV:IsModelDataOn() then self:ShowModel(DGU.CurrentQuestIndex) end
				
				--DGV:SetPercentComplete()
	
				--if not MoveToIndex then
				DGV:PlayCompletionSound(DGV_STEPCOMPLETESOUND)
				--end								
				DGV:CompleteOnZoneCheck()
			end
			
		end
		
		if DGV:ReturnTag("RESET", DGU.CurrentQuestIndex) then 
			DGV:ResetButtonOnClick()
		end			
		
        if not recursion then
            DugisGuideViewer:SetPercentComplete()
        end
	end

	function DGV:MoveToPrevQuest()
			local checkMoved = DGU.CurrentQuestIndex
            if not checkMoved or not visualRows or not visualRows[checkMoved] then
                return
            end
		
			local nextindex = DGV:FindNextUnchecked()

			if DGV.IsStepCompletedByServer(nextindex) then
				DGU.CurrentQuestIndex = nextindex
			end

			DGV.SendDataToServer("NGSI")
			DGV.SendDataToClients("NGSI-SV")
		
			DGV:SetQuestColor(DGU.CurrentQuestIndex)

			CurrentAction = DGV.actions[DGU.CurrentQuestIndex] 
			CurrentQuestName = DGV.quests1L[DGU.CurrentQuestIndex] 

			if self:ReturnTag("AS", DGU.CurrentQuestIndex) and self:UserSetting(DGV_AUTOSTICK) then
				self.Modules.StickyFrame:AddRow(DGU.CurrentQuestIndex)
				DGV:SetChkToComplete(DGU.CurrentQuestIndex)
				DGV:MoveToNextQuest()   
			end
			self:UpdateStickyFrame( )

			if checkMoved ~= DGU.CurrentQuestIndex then
				DGV:UpdateCompletionVisuals(true)
				DGV.DoOutOfCombat(SetUseItem, DGU.CurrentQuestIndex)
				DGV:SetTarget(DGU.CurrentQuestIndex)
				DGV:DelayAndMapCurrentObjective(0.2)

				if DGV:IsModelDataOn() then self:ShowModel(DGU.CurrentQuestIndex) end
			
				--DGV:UpdateSmallFrame()
				DGV:WatchQuest()
				
				DGV:SetPercentComplete()
				
				DGV:CompleteOnZoneCheck()
			end
	end

	--Uncheck quests and start from beginning of quest progress
	function DGV:ResetAllQuests()
		for i = 1, lastUsedStepIndex do
			DGV:ClrChk(i)
		end
		if not self.preLoadMode then
			CurrentQuestName = DGV.quests1L[1]
			CurrentAction = DGV.actions[1]
			DGU.CurrentQuestIndex = 1
			DGV.SendDataToServer("NGSI")
			DGV.SendDataToClients("NGSI-SV")

			DGU.NextQuestIndex = 1
			DGV:UpdateSmallFrame()

			DGV.DoOutOfCombat(SetUseItem, DGU.CurrentQuestIndex)
			DGV:SetTarget(DGU.CurrentQuestIndex)
			--QueryQuestsCompleted()
		end
        
        DGV.UpdateGuideVisualRows()
	end
	
	function DGV:WipeOutViewTab()
		local i
		for i =1, lastUsedStepIndex do
            local rowObj = visualRows[i]
            if rowObj and rowObj.frame then
                rowObj.frame:Hide()
            end
		end
        lastUsedStepIndex = -1
		DugisPercentButtonName:Hide()	
	end

	--Format: "39(9-14)#39(10-15)#39(11-17)"
	function DGV:GetRawTitle(FormattedTitle)
		if self.rawtitle[FormattedTitle] then
			return self.rawtitle[FormattedTitle]
		else
			return FormattedTitle
		end
	end
	
	local function _GetTitleMapID(title)
		return tonumber(title:match("[%d]*"))
	end


	--Format: Elwynn Forest (1-9 Human)
	--RawTitle, optional GuideDifficulty "Easy" "Normal" or "Hard"
	function DGV:GetFormattedTitle(RawTitle, GuideDifficulty)
		if not RawTitle then return end
		local GuideLevelRange, LocalizedMapName 



		
		local BeforeParen = RawTitle:match("([^%(]*)")
		if BeforeParen then BeforeParen = strtrim(BeforeParen) end
			
		--"(1-9 Human)"
		GuideLevelRange = DGV:GetGuideRange(RawTitle, GuideDifficulty)


		--"Elwynn Forest"

		LocalizedMapName 	= self:GetMapNameFromID(_GetTitleMapID(RawTitle)) or BeforeParen
		
		--"Elwynn Forest (1-9 Human)"
		if GuideLevelRange and LocalizedMapName then
			GuideLevelRange = LocalizedMapName.." "..GuideLevelRange
		end
		
		local ret = GuideLevelRange or RawTitle or "No Title"
		return ret
	end


	--title: 30(1-9 Human) or "478(62-64)" or "27(5-10 Dwarf & Gnome)" or "492(77-80 |cffffd200Lore|r)"

	local function _GetTitleLevels(title)
		local race, race2, levels
		title = title:match("%([^%)]*%)") --"(1-9 Human)" or "(62-64)"
			

		if title then 
			if title:match("%d*-%d*%s.*|r") then --"(77-80 |cffffd200Lore|r)"
				return title 
			else
				race  = title:match("%d%s([%a%s]*)") --"Human"
				if race then race = race:trim() end
				race2 = title:match("&%s([%a%s]*)")  --"Gnome" from "Dwarf & Gnome"
				
				--if title then DebugPrint("title="..title.."#") end
				--if race then DebugPrint("race="..race.."#") end
				--if race2 then DebugPrint("race2="..race2.."#") end
				
				levels = title:match("(%d+-%d+)")   --"1-9"
				if levels and race then  
					race = DGV:localize( race, "RACE")
					
					if race2 then
						race2 = DGV:localize( race2, "RACE")
						race = race.." & "..race2
					end
					title = "("..levels.." "..race..")" --"(1-9 Humano)"
				end	
			end
		end 
			
		return title

	end

	--RawTitle: "30(1-9 Human)#30(1-11 Human)#30(1-12 Human)"
	function DGV:GetGuideRange(RawTitle, GuideDifficulty)
		
		local Hard, Normal, Easy= strsplit("#", RawTitle, 3)

		local level = GuideDifficulty or DGV:UserSetting(DGV_GUIDEDIFFICULTY)
		local GuideRange
		
		--"(1-9 Human)" or "(11-17)"
		if Easy and level == "Easy" then
			GuideRange = _GetTitleLevels(Easy)
		elseif Normal and level == "Normal" then
			GuideRange = _GetTitleLevels(Normal)
		elseif Hard then
			GuideRange = _GetTitleLevels(Hard)
		end
		return GuideRange-- or RawTitle
	end
	
    function SetCurrentGuideIcon()
        if CurrentTitle then
            local guideType = DGV.gtype[CurrentTitle]
            if guideType then
                for _, tab in pairs(tabs) do
                    if tab.guidetype == guideType then
                        if tab.icon then
                            if type(tab.icon)=="function" then
                                local textureName = 
                                DugisMainLeftScrollFrame.currentGuideIcon:SetTexture(tab.icon())
                            else
                                DugisMainLeftScrollFrame.currentGuideIcon:SetTexture(tab.icon)
                            end
                        end
                        
                        DugisMainLeftScrollFrame.guideType:SetText(tab.text)
                    end
                end
            end
        end
    end


    local DisplayViewTab_counter =0
    local DisplayViewTab_inProgress = false
    
	--Called from clicking on a guide title
	function DGV:DisplayViewTab(title, skip, threading, autoScrollToCurrent, fromOnModulesLoaded)

 
        if not DugisGuideViewer.UpdateGuideVisualRows then
            return
        end
        
        if DisplayViewTab_inProgress then
            return
        end
    
        DisplayViewTab_counter = DisplayViewTab_counter + 1
        DisplayViewTab_inProgress = true
        
 		if not title then DisplayViewTab_inProgress = false; return end
		if DGV.Modules.StickyFrame.Frame and DGV.Modules.StickyFrame.Frame:IsShown() then 
			DGV:ClearStickyFrame() 
		end
        local rawTitle = string.gsub(title, '|c........', '')
        rawTitle = string.gsub(rawTitle, '|r', '')
        
        if self.guides[rawTitle] and type(self.guides[rawTitle]) ~= "function" and self.guides[rawTitle].OnGuideItemClick then
            self.guides[rawTitle].OnGuideItemClick(self.guides[rawTitle])
            DisplayViewTab_inProgress = false
            return
        end
    
		if InCombatLockdown() then print("|cff11ff11Dugi Guides: |r|cffcc0000Cannot load guides during combat.|r Please try again."); 
        DisplayViewTab_inProgress = false
        return end
        
        MainFramePreloader:ShowPreloader()   
        SmallFramePreloader:ShowPreloader()

        if DisplayViewTab_counter >= 2 then
            LuaUtils.UpdateGameLoadingProgress(threading, 0.2, true)
        end
		
		if title ~= CurrentTitle then
			self:ClearStickyFrame()
			DGU.CurrentQuestIndex = 1
			DGU.NextQuestIndex = 1

			DGV.SendDataToServer("NGSI")
			DGV.SendDataToClients("NGSI-SV")			
		end
		
		--Clear existing guide if any and load this guide
		if title == nil or DGV:isValidGuide(title) == false then
			 DGV:ClearScreen()

			CurrentTitle = nil 
			shareSystem.notCompletedPlayers = {}
			lastUsedStepIndex = -1
			DGV.SendCurrentGuideTitleToClients()
			
		else--if title ~= CurrentTitle then
            local newGuideSelected = CurrentTitle ~= title
     
			CurrentTitle = title
			self.CurrentTitle = title
			shareSystem.notCompletedPlayers = {}
            lastUsedStepIndex = -1
            
            DGV.SendCurrentGuideTitleToClients()
            
            DGV:AddGuideToRecentGuides(title)

			self.GuideMapID = _GetTitleMapID(CurrentTitle)
			self.CurrentZoneName = self:GetMapNameFromID(self.GuideMapID) or title:match("(%w*)%s?%(")

            if DisplayViewTab_counter >= 2 then
                LuaUtils.UpdateGameLoadingProgress(threading, 0.3, true)
            end
            
			DGV:ParseRows(threading, title, false, string.split("\n","\n"..self.guides[title]()))

            if DisplayViewTab_counter >= 2 then
                LuaUtils.UpdateGameLoadingProgress(threading, 0.7, true)
            end
            
			if not self.preLoadMode then
				DGV:QuestsBackgroundTranslator()
			end
			
			DGV:PopulateObjectives(title, nil, threading)

            if DisplayViewTab_counter >= 2 then
                LuaUtils.UpdateGameLoadingProgress(threading, 0.94, true)
            end
            
			--if not self.preLoadMode then
				local name = title..":1"
				if DGU.QuestState[name] == nil then
					DGV:ResetAllQuests()
				else
				--Set state if brand new index appear from due to guide updates
					for i = 1, lastUsedStepIndex do
						if not DGV:GetQuestState(i) then
							DGV:ResetAllQuests()	
						end
					end						
				end
			--end		
            
			DGV:SetQuestsState(threading)
			if not (self.preLoadMode or skip) then
				DGV:UpdatePlayerLevels()
				DGV:ShowViewTab()

				LuaUtils:Delay(0.3, function()
                     LuaUtils:CreateThread("DisplayViewTab_MoveToNextQuest", function()
                        DugisGuideViewer:MoveToNextQuest(DugisGuideViewer:FindNextUnchecked(), nil, nil, fromOnModulesLoaded)
						DGV:SetAllPercents(true)
                     end)
				end)		
			end
            
            if newGuideSelected and DGV.TriggerProfessionsUpdate then
               DGV:TriggerProfessionsUpdate()
            end
            
		end
        
        if DisplayViewTab_counter >= 2 then
            LuaUtils.UpdateGameLoadingProgress(threading, 1, true)
        end
        
		DGV:UpdateAllSIDs()
        
        SetCurrentGuideIcon()
        
        MainFramePreloader:HidePreloader()
        SmallFramePreloader:HidePreloader()

        DugisGuideViewer:UpdateGuideVisualRows()
           
        if autoScrollToCurrent then
            LuaUtils:Delay(0.7, function()
                DGV:AutoScroll(DGU.CurrentQuestIndex) 
            end)
        end
        
        --This event hanler was causing internally scroll range change.
        DugisMain.rightScroll:SetScript("OnScrollRangeChanged", nil)   
        
        DisplayViewTab_inProgress = false

        DGV.firstGuideLoaded = true
	end
    
    function DGV:DisplayViewTabInThread(title, skip, autoScrollToCurrent, onEndFunction)
         LuaUtils:QueueThread("DisplayViewTab", function()
            DGV:DisplayViewTab(title, skip, true, autoScrollToCurrent)
            DugisGuideViewer:UpdateCurrentGuideExpanded()
         end, onEndFunction)
    end    
	
	function Dugis_OnMouseWheel(self, delta)
		local current = self.bar:GetValue()
		local _, Max = self.bar:GetMinMaxValues()
		Max = Max or 1
		if (delta < 0) and (current < Max) then
			self.bar:SetValue(current + 100)
		elseif (delta > 0) and (current > 1) then
			self.bar:SetValue(current - 100)
		end
	end
	
	local function getColor(percent)
	local red, green, blue, alpha
		if percent < 25 then
			red = 1
			green = 0
			blue = 0
			alpha = 1
		elseif percent < 50 then
			red = 1
			green = 0.5
			blue = 0
			alpha = 1
		elseif percent < 75 then
			red = 1
			green = 1
			blue = 0
			alpha = 1
		else
			red = 0
			green = 1
			blue = 0
			alpha = 1
		end
		return red, green, blue, alpha
	end




	-- 
	-- Preload Feature
	--
	local thread
	local preloadFrame = CreateFrame("Frame")
	local preloadCounter = 0
	local preloadThrottle = 0.25
	preloadFrame:SetScript("OnUpdate" , function(self, elapsed)
		preloadCounter = preloadCounter + elapsed
		if preloadCounter >= preloadThrottle and DGV.preLoadMode then
			preloadCounter = preloadCounter - preloadThrottle
			if coroutine.status(thread) ~= "dead" then
				coroutine.resume(thread)
			end
		end

        if NPCJournalFrame and NPCJournalFrame.needToUpdateWaypointButtonsWN then
            UpdateWhatsNewText()
            NPCJournalFrame.needToUpdateWaypointButtonsWN = nil
        end
        
        if whatsNewFrame and whatsNewFrame:IsVisible() and guideategorieswrapper then
            guideategorieswrapper:SetHeight(whatsNewFrame:GetRegions():GetHeight() + 100)
        end  
	end)
    
	local searchThreadFrame = CreateFrame("Frame")
	local searchThreadCounter = 0
	local searchThreadThrottle = 0.01
    
    local function OnSearchThreadEnd()
        DGVSearchFrame:Show()
        
        if not searchDelayTimer then
           DugisSearchProgressIcon:Hide()
        end
        
        DGV_SearchBox:SetAlpha(1)
        SearchingInfoText:Hide()
        DugisMainRightScrollFrame.bar:SetEnabled(true)
    end
    
	searchThreadFrame:SetScript("OnUpdate" , function(self, elapsed)
		searchThreadCounter = searchThreadCounter + elapsed
		if searchThreadCounter >= searchThreadThrottle then
			searchThreadCounter = searchThreadCounter - searchThreadThrottle
            
            if searchThread ~= nil then
                if coroutine.status(searchThread) ~= "dead" then
                    for i=1, 40 do
                        coroutine.resume(searchThread)
                    end
                else
                    OnSearchThreadEnd()
                    searchThread = nil
                end
            end
		end
	end)    
	
	local function GetCreateRowHeading(tabNum, title, originalTabNum, deltaY)
		for _,rh in ipairs(Guides.rowHeadings) do
			if rh.tabNum==tabNum and rh.headingTitle==DGV.headings[title] 
				and (not originalTabNum or originalTabNum==rh.originalTabNum)
				and rh:IsShown()
			then
				return rh
			end
		end
		local label

		for _,rh in ipairs(Guides.rowHeadings) do
			if rh.tabNum==tabNum and not rh:IsShown() then
				label = rh
				break
			end
		end
		if not label then
			label = CreateFrame("Button", "DugisTab"..tabNum.."Heading"..#Guides.rowHeadings, tabs[tabNum].RightFrame, "DugisGuideListingTemplate")
			label.Title:SetFont(GameFontHighlightLarge:GetFont())
			label.Title:SetPoint("RIGHT")
			tinsert(Guides.rowHeadings, label)
		end
		local anchor
		for _,tabLabel in ipairs(Guides.rowHeadings) do
			if tabLabel.tabNum==tabNum and tabLabel:IsShown() then
				anchor = tabLabel

			end
		end
		if not anchor then
			label:SetPoint("TOPLEFT", 0, -5 + (deltaY or 0))
		else
			label:SetPoint("LEFT")
			--label:SetPoint("TOP", anchor, "BOTTOM", 0, -5)
			label.anchor = anchor
		end
		label.tabNum = tabNum
		label.headingTitle = DGV.headings[title]
		label.guideType = tabs[label.tabNum].guidetype
		label.originalTabNum = originalTabNum
		label.Title:SetText(label.headingTitle)
		label:Show()
		return label
	end
    
    DGV.GetCreateRowHeading = GetCreateRowHeading
	
	local function GetCreateTabRow(tabNum, rowNum, title, originalTabNum)
		if tabs[tabNum].visualRows and tabs[tabNum].visualRows[rowNum] then
			local row = tabs[tabNum].visualRows[rowNum]
			row.originalTabNum = originalTabNum
			return row
		end
		local name = "DugisTab"..tabNum.."Row"..rowNum

		local row = _G[name]
		if not row then
			if title then
				row = CreateFrame("Button", name, GetCreateRowHeading(tabNum, title, originalTabNum), "DugisGuideListingTemplate" )
				row:GetParent().lastChild = row
			else
				row = CreateFrame("Button", name, tabs[tabNum].RightFrame, "DugisGuideListingTemplate" )
			end
			row:SetNormalTexture("");
			row.highlight:SetAllPoints()
			row.highlight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
			if not tabs[tabNum].visualRows then
				tabs[tabNum].visualRows = {}
			end
			tabs[tabNum].visualRows[rowNum] = row
		end
        
        row.oryginalText = title
		row.originalTabNum = originalTabNum
		--row:Show()
		return row
	end
    
    DGV.GetCreateTabRow = GetCreateTabRow

	local function preLoad( )
		local guideNum, tabNum
		local self = DGV
		local currentGuide = CurrentTitle
		local currentGuideType = activeTabInfo.guidetype
		
		--DugisPreloadButton:Disable()

		for tabNum = 1, #tabs do --SIDE_TAB_START, #tabs do 
			local guideType = tabs[tabNum].guidetype
			local guideList = self.guidelist and self.guidelist[guideType] -- "L" guide list
			
			if guideType == currentGuideType and guideList then	
				--DebugPrint("guideType="..currentGuideType)
				for guideNum = 1, #guideList do
					
					local guideName = guideList[guideNum]
					local percentText = GetCreateTabRow(tabNum, guideNum).Percent
					--DebugPrint("guideName="..guideName)
					
					--DebugPrint("tab"..tabNum.."row"..guideNum)
					DGV:DisplayViewTab(guideName, nil, true)
                    DGV:SetGuidePercentageCacheValue(guideName, guideType)
					
					LuaUtils:RestIfNeeded(true)
				end
			end
		end
		
		DGV:DisplayViewTab(currentGuide, nil, true)
		
		collectgarbage()
		
		self.preLoadMode = nil
        if guideategorieswrapper then
            guideategorieswrapper:UpdateTreeVisualization()
        end
		
		DebugPrint("####END")
	end

	function DGV:PreloadButtonOnClick()
		self.preLoadMode = true
		thread = coroutine.create(preLoad)
	end

	local percentsSet = false --takes for-ev-er and only needs to be done once
	function DGV:SetAllPercents(threading)
		if percentsSet then return end
		percentsSet = true
		local guidename, text, t, i, guideRow
		local red, green, blue, alpha
		
		
		if DGU["QuestState"] then
			for t = 1, #tabs do 
				local gtype = tabs[t].guidetype
				if DGV.guidelist and gtype and DGV.guidelist[gtype] then
					for i = 1, #DGV.guidelist[gtype] do --Each guide title
                        if threading then
                            LuaUtils:RestIfNeeded(true)
							LuaUtils:WaitForCombatEnd(true)
                        end
						
						guidename 	= 	DGV.guidelist[gtype][i]
						percentText = GetCreateTabRow(t, i).Percent
						if not percentText:GetText() then
							DGV:UpdatePercentText(guidename, percentText, gtype, threading)
						end
						--DebugPrint("guidename="..guidename.."*".."gtype"..gtype)
					end
				end
			end
		end
        LuaUtils:collectgarbage(threading)
            
	end
    
    function DGV:ShouldShowProgess(gtype)
        return gtype ~= "NPC" and gtype ~= "Bosses" and gtype ~= "Followers" and gtype ~= "Mounts" and gtype ~= "Pets" 
    end
    
    local GuideLinesAmount_cache = {}
    function DGV:GuideLinesAmount(guideTitle)
        local value = GuideLinesAmount_cache[guideTitle]
        if value then
            return value
        end
        local value 	= 	DGV:ParseRows(false, guideTitle, true, string.split("\n","\n"..self.guides[guideTitle]())) - 1		
        GuideLinesAmount_cache[guideTitle] = value
        return value
    end
    
    function DGV:SetGuidePercentageCacheValue(guideTitle, gtype)
        local guidesize, unchecked, j
        
        guidesize 	= 	DGV:GuideLinesAmount(guideTitle)
        unchecked 	=	0
        
        for j=1, guidesize do
            local status = DGV:GetQuestState(j,guideTitle)
            if not status or status == "U" then 
                unchecked = unchecked + 1
            end
        end
        
        if unchecked == 1  then 
            percent = 100 
        else 
            percent = 100 - ((unchecked / guidesize) * 100) 
        end
    
        if not guidePercentagesCache[gtype] then
            guidePercentagesCache[gtype] = {}
        end
        
        guidePercentagesCache[gtype][guideTitle] = percent
        
        return percent
    end
    
	function DGV:GetPercentText(guideTitle, gtype)
        local percentage = nil
        
        if guidePercentagesCache[gtype] and guidePercentagesCache[gtype][guideTitle] then
            percentage = guidePercentagesCache[gtype][guideTitle]
        else
            percentage = DGV:SetGuidePercentageCacheValue(guideTitle, gtype, percentage)
        end
		
		if percentage == 0 or (not DGV:ShouldShowProgess(gtype)) then
			return ""
		else
			text = string.format("%.0f",percentage)
			local r, g, b, alpha = getColor(percentage)
            return "|c"..LuaUtils:normalized2HexColor(r,g,b)..text.."%|r"
		end
	end
    
	function DGV:UpdatePercentText(guideTitle, percentText, gtype, threading)
        
		local guidesize, unchecked, j, percent
		
		guidesize 	= 	DGV:GuideLinesAmount(guideTitle) --DGV:ParseRows(threading, guideTitle, true, string.split("\n","\n"..self.guides[guideTitle]())) - 1		
		unchecked 	=	0
		
		for j=1, guidesize do
			local status = DGV:GetQuestState(j,guideTitle)
			if not status or status == "U" then 
				unchecked = unchecked + 1
			end
		end
		if unchecked == 1  then percent = 100 else percent = 100 - ((unchecked / guidesize) * 100) end
		
		if percent == 0 or (not DGV:ShouldShowProgess(gtype)) then
			percentText:SetText("")
		else
			text = string.format("%.0f",percent)
			percentText:SetText(text.."%")
            
			red, green, blue, alpha = getColor(percent)
			percentText:SetTextColor(red, green, blue, alpha)
		end
	end
	
	local function SetCurrentGuideTabPercentComplete()
	  if DGV.gtype then
		local currentGType = DGV.gtype[CurrentTitle]
		for t = 1, #tabs do 
			local gtype = tabs[t].guidetype
			if gtype==currentGType then
				local guides = DGV.guidelist and gtype and DGV.guidelist[gtype]
				if guides then
					for i = 1, #guides do --Each guide title
						guideTitle = guides[i]
						if guideTitle==CurrentTitle then
                            DGV:SetGuidePercentageCacheValue(guideTitle, gtype)
						end
					end
				end
			end
		end
	  end
        
        if guideategorieswrapper then
            guideategorieswrapper:UpdateTreeVisualization()
        end
	end

	function DGV:SetPercentComplete()

		local percent, i
		local unchecked = 0
		local red, green, blue, alpha
		
		if DGV:isValidGuide(CurrentTitle) == true then
			DugisPercentButtonName:Show()
			for i=1, lastUsedStepIndex do	
				if DGV:GetQuestState(i) == "U" then unchecked = unchecked + 1 end	
			end
			
			if unchecked == 1  then
				percent = 100
			else
				percent = 100 - ((unchecked / lastUsedStepIndex) * 100)
			end
				

			local text = string.format("%.0f",percent)
			DugisPercentButtonName:SetText(text.."% "..L["Complete"])
            
            DGV:SetSamallFrameProgressBar(percent * 0.01, text)

			
			red, green, blue, alpha = getColor(percent)
			DugisPercentButtonName:SetTextColor(red, green, blue, alpha) 

		else
			DugisPercentButtonName:SetText("")
		end
		SetCurrentGuideTabPercentComplete()
	end
	
	local function AddToChains( tbl, key, val)
		key = tonumber(key) 
		val = tonumber(val)
			
		if not key or not val then return end
		
		if tbl[key] and not tContains(tbl[key], val) then
			tinsert( tbl[key], val )
			--DebugPrint("insert val:"..val)
		else
			tbl[key] = {val}
		end
	end

	local ChainsRaw = ""
	function DGV:RegisterQuestChains(text)
		ChainsRaw = ChainsRaw .. text .."\n"
		--print("registered "..#text.." bytes of chains")
		local postReqs = {}
		local breadCrumbs = {}
		local val, id, pos, start
		local lineCount, dbgCount, lineStart,lineEnd,lineText = 1, 1, 1, 0, 1
		
		while (lineStart and dbgCount < 3000) do
			lineStart, lineEnd, lineText = strfind( ChainsRaw, "%s*(.-)%s*\n", lineEnd + 1 )	
			if lineStart then
				if strfind( lineText, "=") then
					local postReq, preReq = lineText:match( "(%d+)%s*=%s*(%d+)" )
					if strfind ( lineText, "OR" ) then
						AddToChains( breadCrumbs, postReq, preReq)
						for val in string.gmatch(lineText,"OR%s*(%d+)") do
							AddToChains( breadCrumbs, postReq, val)
						end
					elseif postReq and preReq then
						AddToChains( postReqs, preReq, postReq)
						for val in string.gmatch(lineText,"AND%s*(%d+)") do
							AddToChains( postReqs, val, postReq)
						end
					end
				elseif strfind( lineText, ",") then
					local preReq, postReq = lineText:match( "(%d+)%s*,%s*(%d+)" )
					local commaSep = {}
					local mainChain = {}
					
					for val in string.gmatch(lineText,"%,([^%,]*)") do tinsert(commaSep, val) end 		--Create chain data split at ','
					for val in string.gmatch(lineText,"[%,AND]%s*(%d+)") do tinsert(mainChain, val) end --Create main chain of qids
					for _, val in pairs(mainChain) do AddToChains( postReqs, preReq, val ) end
									
					for start = 1, #commaSep do	--Add sub chains
						for pos = start+1, #commaSep do
							if strfind ( commaSep[start], "AND" ) then	 
								for id in string.gmatch( commaSep[start], "(%d+)") do
									if start + 1 <= #commaSep then AddToChains( postReqs, id, commaSep[start+1] ) end
								end
							else
								for id in string.gmatch( commaSep[pos], "(%d+)") do
									AddToChains( postReqs, commaSep[start], id)
								end
							end
						end
					end
				end	
			end

			--if lineText then DebugPrint("lineText="..lineText) end
			lineCount = lineCount + 1
			dbgCount = dbgCount + 1
		end
			
		--DebugPrint("###linecount="..lineCount.."dbgCount="..dbgCount)
		self.postReqs = postReqs
		self.breadCrumbs = breadCrumbs
		
		ChainsRaw = ""
	end

	function DGV:UnSkipPostReqs(qid)
		local postNum, postReq
		base = base or 1
		
		if not self.postReqs[qid] or base > 50 then return end
		
		for _, postReq in pairs(self.postReqs[qid]) do	
			self:UnSkip(postReq)
			self:UnSkipPostReqs( postReq, base + 1 )
		end	
	end


	function DGV:UnSkip(qid)
		local guideIndex

		if DGU.toskip[qid] then DGU.toskip[qid] = nil end
		for guideIndex = 1, lastUsedStepIndex do
			if (DGV.qid[guideIndex] == qid) and (self:GetQuestState(guideIndex) == "X") and strmatch(self.actions[guideIndex], "[ACTNK]") then 
				DGV:ClrChk(guideIndex)
			end
		end
	end

	function DGV:SkipPostReqs(qid, base)
		local postNum, postReq
		base = base or 1

		
		if not self.postReqs[qid] or base > 50 then return end
		
		for _, postReq in pairs(self.postReqs[qid]) do	
			self:Skip(postReq)
			self:SkipPostReqs( postReq, base + 1 )
		end	
	end

	function DGV:Skip(qid)
		local guideIndex
		
		if DGU.toskip[qid] then DGU.toskip[qid] = true end	
		for guideIndex = 1, lastUsedStepIndex do
			if (DGV.qid[guideIndex] == qid) and (self:GetQuestState(guideIndex) ~= "C") and strmatch(self.actions[guideIndex], "[ACTNK]") then 
				DGV:SetChktoX(guideIndex)
			end
		end
	end

	function DGV:SkipBreadCrumbs(qid)
		local postNum, postReq

		if self.breadCrumbs[qid] then
			for postNum = 1, #self.breadCrumbs[qid] do
				postReq = self.breadCrumbs[qid][postNum]
				self:Skip(postReq)
			end
		end
	end
	
	function DGV:GetToolTipSize(tooltip)
		if tooltip then
			local textobj = _G[tooltip:GetName().."TextLeft1"]
			
			local ttwidth, ttheight = tooltip:GetSize()
			local fwidth = textobj:GetStringWidth()
			local fheight = textobj:GetStringHeight()
			local pad = tooltip:GetPadding()	
			return ttwidth, ttheight, fwidth, fheight, pad
		end
	end

	function DGV:Tooltip_OnEnter(self, event, ...)
      
			local title = self.Name:GetText()
			local text = self.Desc.orgDesc
            
            if not text then
                text = self.Desc:GetText()
            end
			
			CreateFrame( "GameTooltip", "LargeFrameTooltip", nil, "GameTooltipTemplate" ); 
			LargeFrameTooltip:SetOwner(self, "ANCHOR_CURSOR")
			LargeFrameTooltip:SetParent(UIParent)
			
			--LargeFrameTooltip:SetPadding(5)
			LargeFrameTooltip:AddLine("|cffffd200"..(title or "").."|r", 1, 1, 1, true)
			LargeFrameTooltip:AddLine(" ", 1, 1, 1, true)
			LargeFrameTooltip:AddLine(text, 1, 1, 1, true)
			LargeFrameTooltip:Show()
			--[[
			local ttwidth, ttheight, fwidth, fheight, pad = DGV:GetToolTipSize(LargeFrameTooltip)
			
			--DebugPrint("fwidth:"..fwidth.." fheight:"..fheight.." ttwidth"..ttwidth.." ttheight"..ttheight.." pad"..pad)
			
			local scaleFactor = fwidth / ttwidth
			local maxScale = 1.3
			if (scaleFactor > 1) then
				local newwidth
				if scaleFactor > maxScale then
					scaleFactor = maxScale

				end
				
				if(scaleFactor < 1.10) then
					newwidth = fwidth * 1.10
				else 
					newwidth = ttwidth * scaleFactor
				end
				LargeFrameTooltip:SetWidth(newwidth)
				LargeFrameTooltipTextLeft1:SetWidth(newwidth - 15)
				LargeFrameTooltip:SetHeight(LargeFrameTooltipTextLeft1:GetHeight() + 20)

				ttwidth, ttheight, fwidth, fheight, pad = DGV:GetToolTipSize()
				--DebugPrint("2fwidth:"..fwidth.." fheight:"..fheight.." ttwidth"..ttwidth.." ttheight"..ttheight.." pad"..pad)
			end
			--]]
			LargeFrameTooltip:SetFrameStrata("TOOLTIP")
	end

	function DGV:Tooltip_OnLeave()
		if LargeFrameTooltip then LargeFrameTooltip:Hide() end
	end
	
	local icontbl = {
		[Category.Home] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\accept.tga", text = "Accept Quest"},
		[Category.CurrentGuide] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\turnin.tga", text = "Turn in Quest"},
		[Category.Settings] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\partial_cog.tga", text = "General Task"},
		[Category.Suggest] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Ammunition", text = "Kill NPC"},
		[Category.Leveling] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Banker", text = "Collect Item"},
		[Category.Dungeons] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\speak.tga", text = "Speak to"},
		[Category.Dailies] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\vehicle.tga", text = "Use Vehicle"},		
		[Category.Events] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\flightpath.tga", text = "Get Flight Path"},
		[Category.Professions] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Auctioneer", text = "Buy Item"},
		[Category.Achievements] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\None", text = "Use Item"},
		[Category.Help] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Profession", text = "Special Note"},
		[Category.Elites] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\resting.tga", text = "Set Hearthstone"},
		[Category.Mounts] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Innkeeper", text = "Use Hearthstone"},
		[Category.Pets] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\FlightMaster", text = "Fly to"},
		[Category.Bosses] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\StableMaster", text = "Travel to"},
		[Category.ClearGuide] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\multi_daily.tga", text = "Random Daily"},
		[Category.RecentGuides] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\dungeon.tga", text = "Use Dungeon Finder"},
		[Category.Followers] = {path = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\AchievementIcon.tga", text = "Achievement Task"},		
	}

	function DGV:IsQuestTooHigh(guideIndex)
		local reqLevel = self:GetReqQuestLevel(self.qid[guideIndex])
		if reqLevel and reqLevel >  UnitLevel("player") then return true end
	end

	function DGV:IsQuestTooLow(guideIndex)
		if self:GetQuestDiffColor(guideIndex) == QuestDifficultyColors["trivial"] then
			return true

		end
	end

	function DGV:getIcon(objectiveType, i)
		local isDaily, isDungeon, isTooHigh, isKill, isCollect, button, isAlchemy, isBlacksmith, isCooking, isDisenchant, isEnchanting, isEngineering, isFishing, isFirstaid, isHerb, isInscription, isJewel, isLeather, isMining, isSkinning, isSmelting, isTailoring, isMount, isCompanion, isClass, isTabard, isQpart, isSpeak, isVehicle, isMulti, isAchievement, isAchievementpart, isLoot, isUse, isSpeakTitle, asYougo
		
		local qid = self.qid[i]
		local aid = DGV:ReturnTag("AID", i)
		
        local button = {}
        
		local row = visualRows[i]
		
		if row and row.frame then
			button = row.frame.Button
		end
		
		--[[ Not working correctly, dont really need it
		isTooHigh = self:IsQuestTooHigh(i)
		if not isTooHigh and button.validTexture then
			return button.validTexture
		elseif isTooHigh and button.tooHighTexture then
			return button.tooHighTexture
		end--]]
		
		if (DGV.daily[i]) then isDaily = true end
		if (DGV:ReturnTag("I", i)) then isDungeon = true end
		if (DGV:ReturnTag("K", i)) then isKill = true end
		if (DGV:ReturnTag("T", i)) then isCollect = true end
		if (DGV:ReturnTag("AL", i)) then isAlchemy = true end
		if (DGV:ReturnTag("BL", i)) then isBlacksmith = true end
		if (DGV:ReturnTag("CO", i)) then isCooking = true end

		if (DGV:ReturnTag("DI", i)) then isDisenchant = true end
		if (DGV:ReturnTag("ENC", i)) then isEnchanting = true end
		if (DGV:ReturnTag("ENG", i)) then isEngineering = true end
		if (DGV:ReturnTag("FIS", i)) then isFishing = true end
		if (DGV:ReturnTag("FIR", i)) then isFirstaid = true end
		if (DGV:ReturnTag("HE", i)) then isHerb = true end
		if (DGV:ReturnTag("IN", i)) then isInscription = true end	
		if (DGV:ReturnTag("JE", i)) then isJewel = true end
		if (DGV:ReturnTag("LE", i)) then isLeather = true end
		if (DGV:ReturnTag("MI", i)) then isMining = true end
		if (DGV:ReturnTag("SK", i)) then isSkinning = true end
		if (DGV:ReturnTag("SM", i)) then isSmelting = true end
		if (DGV:ReturnTag("TA", i)) then isTailoring = true end
		if (DGV:ReturnTag("MO", i)) then isMount = true end
		if (DGV:ReturnTag("COM", i)) then isCompanion = true end
		if (DGV:ReturnTag("CL", i)) then isClass = true end
		if (DGV:ReturnTag("TAB", i)) then isTabard = true end
		if (DGV:ReturnTag("QIDP", i)) then isQpart = true end
		if (DGV:ReturnTag("S", i)) then isSpeak = true end
		if (DGV:ReturnTag("ST", i)) then isSpeakTitle = true end
		if (DGV:ReturnTag("V", i)) then isVehicle = true end
		if (DGV:ReturnTag("MD", i)) then isMulti = true end
		if (DGV:ReturnTag("AID", i)) then isAchievement = true end
		if (DGV:ReturnTag("AC", i)) then isAchievementpart = true end
		if (DGV:ReturnTag("L", i)) then isLoot = true end
		if (DGV:ReturnTag("U", i)) then isUse = true end
		if (DGV:ReturnTag("SID", i)) then isQpart = true end	
		if (DGV:ReturnTag("AYG", i)) then asYougo = true end		
		if (DGV:ReturnTag("LO", i)) then isLockpick = true end
		
		if isTooHigh and objectiveType == "A" then
			button.tooHighTexture = self.ARTWORK_PATH.."accept_g.tga"	
			return button.tooHighTexture		
		elseif isTooHigh and objectiveType == "T" then
			button.tooHighTexture = self.ARTWORK_PATH.."turnin_g.tga"
			return button.tooHighTexture		
		elseif isDaily and objectiveType == "A" then
			button.validTexture = self.ARTWORK_PATH.."accept_d.tga"
			return button.validTexture	
		elseif isDungeon then
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\dungeon.tga" 
			button.validTexture = icontbl[Category.RecentGuides].path

			return button.validTexture	
		elseif isAlchemy then
			button.validTexture = "Interface\\Icons\\Trade_Alchemy" 
			return button.validTexture
		elseif isBlacksmith then
			button.validTexture = "Interface\\Icons\\Trade_BlackSmithing" 
			return button.validTexture
		elseif isCooking then
			button.validTexture = "Interface\\Icons\\inv_misc_food_15" 
			return button.validTexture
		elseif isDisenchant then
			button.validTexture = "Interface\\Icons\\inv_enchant_disenchant" 
			return button.validTexture
		elseif isEnchanting then
			button.validTexture = "Interface\\Icons\\trade_engraving"
			return button.validTexture
		elseif isEngineering then
			button.validTexture = "Interface\\Icons\\Trade_Engineering"
			return button.validTexture
		elseif isFishing then
			button.validTexture = "Interface\\Icons\\Trade_Fishing"
			return button.validTexture
		elseif isFirstaid then
			button.validTexture = "Interface\\Icons\\Trade_Fishing"
			return button.validTexture
		elseif isHerb then
			button.validTexture = "Interface\\Icons\\Trade_Herbalism" 
			return button.validTexture
		elseif isInscription then
			button.validTexture = "Interface\\Icons\\inv_inscription_tradeskill01" 
			return button.validTexture
		elseif isJewel then
			button.validTexture = "Interface\\Icons\\inv_misc_gem_01" 
			return button.validTexture
		elseif isLeather then
			button.validTexture = "Interface\\Icons\\Trade_LeatherWorking" 
			return button.validTexture		
		elseif isMining then
			button.validTexture = "Interface\\Icons\\Trade_Mining" 
			return button.validTexture
		elseif isSkinning then
			button.validTexture = "Interface\\Icons\\inv_misc_pelt_wolf_01"
			return button.validTexture
		elseif isSmelting then
			button.validTexture = "Interface\\Icons\\spell_fire_flameblades" 
			return button.validTexture		
		elseif isTailoring then
			button.validTexture = "Interface\\Icons\\Trade_Tailoring" 
			return button.validTexture
		elseif isMount then
			button.validTexture = "Interface\\Icons\\Ability_mount_ridingelekk" 
			return button.validTexture
		elseif isCompanion then
			button.validTexture = "Interface\\Icons\\Ability_mount_ridingelekk" 
			return button.validTexture
		elseif isLockpick then
			button.validTexture = "Interface\\Icons\\spell_nature_moonkey"
			return button.validTexture			
		elseif isClass then
			button.validTexture = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Class" 
			return button.validTexture
		elseif isTabard then
			button.validTexture = self.ARTWORK_PATH.."tabard.tga" 
			return button.validTexture		
		elseif (objectiveType == "K" ) and (isLoot or isCollect) then
			button.validTexture = self.ARTWORK_PATH.."kill_collect.tga"
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end			

			return button.validTexture		
		elseif isMulti then
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\multi_daily.tga"
			button.validTexture = icontbl[Category.ClearGuide].path

			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end
			return button.validTexture			
		elseif (objectiveType == "A" ) then 
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\accept.tga"
			button.validTexture = icontbl[Category.Home].path
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end
			return button.validTexture
		elseif (objectiveType == "C") then
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end
			if isKill and isCollect then 
				--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\kill_collect.tga"
				button.validTexture = self.ARTWORK_PATH.."kill_collect.tga"
				return button.validTexture
			elseif isKill and isSpeak then
				button.validTexture = self.ARTWORK_PATH.."speak_kill.tga" 
				return button.validTexture		
			elseif isKill and isUse then 
				button.validTexture = self.ARTWORK_PATH.."cog_kill.tga" 
				return button.validTexture
			elseif isKill then 
				--return "Interface\\Minimap\\TRACKING\\Ammunition"
				button.validTexture = icontbl[Category.Suggest].path
				return button.validTexture				
			elseif isCollect then 
				--return "Interface\\Minimap\\TRACKING\\Banker"
				button.validTexture = icontbl[Category.Leveling].path


				return button.validTexture						
			elseif isSpeak then
				button.validTexture = icontbl[Category.Dungeons].path
				return button.validTexture				
			else
				--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\partial_cog.tga"
				button.validTexture = icontbl[Category.Settings].path
				return button.validTexture
			end
		elseif (objectiveType == "T") then
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\turnin.tga"
			button.validTexture = icontbl[Category.CurrentGuide].path
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end
			return button.validTexture
		elseif isVehicle then
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			end				
			if isSpeak then 
				button.validTexture = self.ARTWORK_PATH.."speak_vehicle.tga" 
				return button.validTexture
			else
				button.validTexture = self.ARTWORK_PATH.."vehicle.tga"
				return button.validTexture
			end									
		elseif (objectiveType == "R") then 
			--return "Interface\\Minimap\\TRACKING\\StableMaster"
			if isSpeak then 
				button.validTexture = self.ARTWORK_PATH.."speak_vehicle.tga" 
				return button.validTexture
			else
				button.validTexture = icontbl[Category.Bosses].path 
				return button.validTexture
			end
		elseif (objectiveType == "F" ) then 
			--return "Interface\\Minimap\\TRACKING\\FlightMaster"
			button.validTexture = icontbl[Category.Pets].path
			return button.validTexture
		elseif (objectiveType == "b" ) then 
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\waves.tga"
			button.validTexture = icontbl[Category.Bosses].path
			return button.validTexture		
		elseif (objectiveType == "H" ) then  
			--return "Interface\\Minimap\\TRACKING\\Innkeeper"
			button.validTexture = icontbl[Category.Mounts].path
			return button.validTexture			
		elseif (objectiveType == "B" ) then 
			--return "Interface\\Minimap\\TRACKING\\Auctioneer"
			button.validTexture = icontbl[Category.Professions].path
			return button.validTexture			
		elseif (objectiveType == "U" ) then  
			--return "Interface\\Minimap\\TRACKING\\None"
			button.validTexture = icontbl[Category.Achievements].path
			return button.validTexture			
		elseif (objectiveType == "h" ) then 
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\resting.tga"
			button.validTexture = icontbl[Category.Elites].path
			return button.validTexture
		elseif (objectiveType == "f") then 
			--return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\flightpath.tga"
			button.validTexture = icontbl[Category.Events].path
			return button.validTexture				
		elseif isAchievementpart then
			button.validTexture = self.ARTWORK_PATH.."AchievementIcon_p.tga" 
			if aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end
			return button.validTexture	
		elseif isAchievement then
			button.validTexture = icontbl[Category.Followers].path 
			if aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end			
			return button.validTexture							
		elseif (objectiveType == "N" ) and isQpart then
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			elseif aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end			  
			if asYougo then
				button.validTexture = icontbl[Category.Help].path
				return button.validTexture
			elseif isSpeak then 
				button.validTexture = self.ARTWORK_PATH.."speak.tga" 
				return button.validTexture
			elseif isCollect and isKill then
				button.validTexture = self.ARTWORK_PATH.."kill_collect.tga"
				return button.validTexture
			elseif isCollect then
				button.validTexture = icontbl[Category.Leveling].path
				return button.validTexture				
			elseif isKill and isUse then
				button.validTexture = self.ARTWORK_PATH.."cog_kill.tga" 
				return button.validTexture
			elseif isKill then
				button.validTexture = icontbl[Category.Suggest].path 
				return button.validTexture							
			else
				button.validTexture = icontbl[Category.Settings].path
				return button.validTexture
			end						
		elseif isLoot then
			--button.validTexture = icontbl[Category.Leveling].path
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			elseif aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end				
			return button.validTexture		
		elseif (objectiveType == "N" ) then  
			button.validTexture = icontbl[Category.Help].path
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			elseif aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end
			if isSpeakTitle then 
				button.validTexture = self.ARTWORK_PATH.."speak.tga" 
				return button.validTexture
			end				
			return button.validTexture		
		else-- (objectiveType == "K" ) then  
			--return "Interface\\Minimap\\TRACKING\\Ammunition"
			button.validTexture = icontbl[Category.Suggest].path
			if qid then 
				button.tag_id = qid
				button.tagType = "qid"
			elseif aid then 
				button.tag_id = aid
				button.tagType = "aid"
			end				
			return button.validTexture		
		end		
	end


	function DGV:HasCoord(guideIndex)
		local coord = "%(([%d.]+),%s?([%d.]+)%)"
        
        if guideIndex > lastUsedStepIndex then return end       
        
		local note = DGV.quests2[guideIndex]
		if note:find(coord) or DGV:ReturnTag("PPOS", guideIndex) then 
			return true 
		end
	end

	--Return a table of current coordinates from the Note tag
	function DGV:getCoords(guideIndex)

		local XYVals = {}
		local coord = "%(([%d.]+),%s?([%d.]+)%)"
		local note = DGV.quests2[guideIndex]
		local x, y
		
		if note and note:find(coord) then
			for x,y in note:gmatch(coord) do
				table.insert(XYVals, {tonumber(x), tonumber(y)})
			end
		end
		return XYVals
	end

	local xyzon
	function DGV:Retxyz(t, i)
			if i == 1 and t == "AAA" then
				xyzon = true
				t = ""
			elseif i == 1 then
				xyzon = false
			end
			
			if xyzon then
				local textd = ""
				local chard
				local data = 0
				for j = 1, #t do
					local c = t:sub(j,j)
					local cb = string.byte(c, 1)
					local k = 3
					chard = ""
					if cb < 128 - k then 
						chard = string.char(cb + k) 
					elseif cb < 192  then 
						local joined = bit.bor(bit.band(63, cb), data) 	
						joined = joined + k
						local upper2 = bit.bor(bit.rshift(bit.band(192,joined), 6), 192) 
						local lower2 = bit.bor(bit.band(63, joined), 128) 
						chard = string.char(upper2)..string.char(lower2)
					elseif cb < 224  and cb > 193  			then 
						data = bit.lshift(bit.band(3, cb),6)
					else
						DebugPrint("Range Err")
					end	
					textd = textd..chard
				end
				t = textd
				--DebugPrint("t="..t)
			end
		return t
	end
    
    
	function DGV:TranslateText(line)
		----- SubZones ----
		local line = string.gsub(line, '{.-}', function(subzone) 
        
			subzone = string.gsub(subzone, '{', '')
			subzone = string.gsub(subzone, '}', '')
			subzone = subzone
			
			if DugisGuideViewer.Localize == 0 then return subzone end
            
            if (DGV.BZL == nil) then
                return subzone
            end
            

			local translatedSubzone = DGV.BZL[subzone]
			if translatedSubzone then
				return translatedSubzone
			else
				return subzone
			end
		end) 
        
		return line
        
	end

	--Parse rows and fill up 3 items: Objective type (actions), Quest name, Note Tag (actions, quests, tags)
	function DGV:ParseRows(threading, _, infoOnly, _,...)
    
    
    
        DGV.ReturnTag_cache = {}
        
		local i
		local indx = 1
		local _, myClass 	= UnitClass("player")
		local _, myRace 	= UnitRace("player")
		local myFaction		= UnitFactionGroup("player")
		local myGender
		if UnitSex("player") == 3 then myGender = "Female" else myGender = "Male" end 
		if myClass == "DEMONHUNTER" then myClass = "DEMON" end
		
        if not infoOnly then
            wipe(DGV.actions)
            wipe(DGV.quests1)
            wipe(DGV.quests1L)
            wipe(DGV.quests2)
            lastUsedStepIndex = -1
        end
		
		--Loop through all rows
		for i = 1, select ("#", ...) do
			local text = select(i, ...)
            
			text = self:TranslateText(text)
            LuaUtils:RestIfNeeded(threading)

			text = self:Retxyz(text, i)
			--if i < 5 then DebugPrint("text="..text) end
			local _, _, classes 	= text:find("|C|([^|]+)|")
			if classes then classes = string.upper(classes) end
			local _, _, races 		= text:find("|R|([^|]+)|")             	
			local _, _, daily 		= text:find("(|D|)")
			local _, _, gender 		= text:find("|G|([^|]+)|")
			local _, _, faction		= text:find("|FAC|([^|]+)|")
			
				if text ~= "" and (not classes or classes:find(myClass)) and (not races or races:find(myRace)) and (not gender or myGender == gender) and (not faction or myFaction == faction) then
					
					local _, _, action, quest, tag = text:find("^(%a) ([^|]*)(.*)") 
                
                if action and quest then 
                  if not infoOnly then
						action = action:trim()
						quest = quest:trim()
                    --Find Use items
						local _, _, useitem = tag:find("|U|([^|]+)|") 
                    
                        DGV.useitem[indx] = useitem

                    --If there is a second objective line, retrieve that
                    local quest2, questtest
                    questtest = tag
                    local _, _, questtest = questtest:find("|[NW]R?|([^|]+)|")
                    if questtest then
                    quest2 = questtest
                    else
                    quest2 = ""
                    end


                    local qid = tag:match("|QID|(%d+)")
                    local eqids = tag:match("|EQID|(.-)|")
                    qid = tonumber(qid)
                    
                    local sid = tag:match("|SID|(%d+)")
                    sid = tonumber(sid)
                
              
                    DGV.actions[indx] = action:trim()
                    DGV.quests1[indx] = quest:trim()
                    DGV.quests1L[indx] = quest:trim()
                    DGV.quests2[indx] = quest2:trim()
                    DGV.tags[indx] = tag
                    DGV.qid[indx] = qid
                    DGV.sid[indx] = sid
                    DGV.daily[indx] = daily
                    if eqids ~= nil and eqids ~= "" then
                        DGV.eqids[indx] = eqids
                    end
                  end
                  indx = indx + 1
                end
			end
		end
        
        return indx
	end
	
	function DGV:InBag(itemid)
		local bag, slot
		if itemid then
			for bag=0,4 do
				for slot=1,GetContainerNumSlots(bag) do
					local item = GetContainerItemLink(bag, slot)
					if item and string.find(item, "item:"..itemid) then return true end
				end
			end
		end
		return false
	end
    
    local function ReplaceCoordinates(qDesc)
        return string.gsub(qDesc, "%(([%d.]+),%s?([%d.]+)%)%s-", "")
    end
    
    function DGV:RefreshReplacedTags()
        if not DGV.actions then
            return
        end
        
        for i = 1 , #DGV.actions do 
            local rowObj = visualRows[i]
            if rowObj ~= nil and rowObj.frame then
                local qDesc = DGV.quests2[i]
                if DGV.NPCJournalFrame then 
                    qDesc = NPCJournalFrame:ReplaceSpecialTags(qDesc, true, i)
                end
                DGV.quests2[i] = qDesc
                
                if qDesc and not DugisGuideViewer:GetDB(DGV_DISPLAYCOORDINATES) then
                    qDesc = ReplaceCoordinates(qDesc)
                end
                
                local qDescCroped = LuaUtils:cropEscapeSequence(string.gsub(qDesc, "\n", " "), guideStepCharsLimit)
                
                rowObj.frame.Desc:SetText(qDescCroped)
                
                rowObj.frame.Desc.orgDesc = qDesc                
            end
        end
    end


    --no optimization needed
    function DGV:GetQuestStepText(i)
        local qDesc = DGV.quests2[i]
        if DGV.NPCJournalFrame and NPCJournalFrame then 
            qDesc = NPCJournalFrame:ReplaceSpecialTags(qDesc, true, i)
        end
        DGV.quests2[i] = qDesc
        
        if qDesc and not DugisGuideViewer:GetDB(DGV_DISPLAYCOORDINATES) then
            qDesc = ReplaceCoordinates(qDesc)
        end
        
        return qDesc
    end

    function DGV:UpdateRowVisualizations(i)
        local rowObj = visualRows[i]
        
        if not rowObj then
            rowObj = {}
            visualRows[i] = rowObj
        end
        
        if rowObj.frame == nil then
            rowObj.frame = CreateFrame("Button", nil, currentGuideTabInfo.RightFrame, "DugisQuestRowTemplate")
            rowObj.frame.Chk:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        end
        rowObj.frame.guestStepIndex = i
        
        local frame = rowObj.frame
        
        --Highlight
        if i == DGU.CurrentQuestIndex then
            frame:SetNormalTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\highlight.tga")   
        else
            frame:SetNormalTexture("")   
        end
        
        if DugisGuideUser.showLeftMenuForCurrentGuide then
            frame.Desc:SetWidth(300)
        else
            frame.Desc:SetWidth(650)
        end
        
        local stepState = DGU.QuestState[CurrentTitle..':'..i]
            
        if rowObj.shouldBeHidden then
            frame:Hide()
            return
        end
    
        frame:Show()
        
        frame:SetPoint("TOPLEFT", 0, rowObj.y)
        DGV:SetQuestColor(i)
        
        --Condition for scrolling optimization performance
        if rowObj.currentTitle ~= CurrentTitle then
            local qDesc = DGV:GetQuestStepText(i)
            
            local qDescCroped = LuaUtils:cropEscapeSequence(string.gsub(qDesc, "\n", " "), guideStepCharsLimit)
            
            frame.Desc:SetText(qDescCroped)
            frame.Desc.orgDesc = qDesc
 
            DGV:SetQuestText(i)
            
			frame.Button:SetNormalTexture(DGV:getIcon(DGV.actions[i], i))	
			local hasDMAPtag = DGV:ReturnTag("DMAP", i)
            if not self:HasCoord(i) and not hasDMAPtag then frame.WayPoint:Disable() else frame.WayPoint:Enable() end
            if self:ReturnTag("NT", i) then frame.Chk:Disable() else frame.Chk:Enable() end
        end
        
        rowObj.currentTitle = CurrentTitle
        
        --Condition for scrolling optimization performance
        if rowObj.needsUpdate then
            frame.Chk:SetChecked(false)
            frame.Chk:Show()
        
            if stepState == "C" then
                frame.Chk:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
                frame.Chk:SetChecked(true)
            end
            
            if stepState == "U" then
                frame.Chk:SetCheckedTexture("") 
                frame.Chk:SetChecked(false)
            end

            if stepState == "X" then
                frame.Chk:SetCheckedTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady") 
                frame.Chk:SetChecked(true)
            end

            --Sticky frame
            local stickyFrameIndex 	= self.Modules.StickyFrame.revStickyQuests[i]
            
            if stickyFrameIndex then
                local stickyFrameChk 	= _G["DGV_SFRow"..stickyFrameIndex.."Chk"]
                if stepState == "C" then
                    stickyFrameChk:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
                    stickyFrameChk:SetChecked(true)
                end
                
                 if stepState == "U" then
                    stickyFrameChk:SetCheckedTexture("") 
                    stickyFrameChk:SetChecked(false)
                end

                if stepState == "X" then
                    stickyFrameChk:SetCheckedTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady") 
                    stickyFrameChk:SetChecked(true)
                end
            end
        end
        
        rowObj.needsUpdate = false
    end
    
        


	--Fill screen with 3 items: Objective type (actions), Quest name, Note Tag (actions, quests, tags)
	function DGV:PopulateObjectives(title, SearchMode, threading)
		--DGV:DebugFormat("PopulateObjectives", "stack", debugstack())
			if not title then title = CurrentTitle end
			crowheight = 35
			local i
			
            lastUsedStepIndex = -1
            
			--Clear any old data
			for i =1, #visualRows do
                local rowObj = visualRows[i]
				local frame = rowObj.frame
                
                if frame then
                    frame:Hide()
                    frame.Name:SetText("")
                    frame.Desc:SetText("")
                    
                    frame.Button.validTexture = nil
                    frame.Button.tooHighTexture = nil
                    frame.Name.levelText = nil
                    
                    frame.Opt.text = nil
                    frame.Opt.pre = nil
                    frame.Opt.rep = nil
                    frame.Opt.standing = nil
                    frame.Opt.friend = nil
                    frame.Opt.level = nil				
                    frame.Opt.optional = nil                    
                end
			end
			
			self:SetViewTabTitle(self:GetFormattedTitle(title))
					
                    
            local searchResultIndex = 0
            local calculatedHeight = 0
                    
			for i = 1, #DGV.actions do 
                local rowObj = visualRows[i]
                
                if not rowObj then
                    rowObj = {}
                    visualRows[i] = rowObj
                end
                
                rowObj.needsUpdate = true
                rowObj.currentTitle = nil
                
                LuaUtils:RestIfNeeded(threading)
				 

                rowObj.shouldBeHidden = false
                lastUsedStepIndex = i
				 
				if not SearchMode then 
                    local currentY = -(i - 1) * 35
                    calculatedHeight = -currentY
                    
                    --Better idea is to calculate right position for each node relatively to the parent. Like this:
                    rowObj.y = currentY                 
				else
					if self.Search:InSearchResults( i ) then
                        searchResultIndex = searchResultIndex + 1
                        
                        local currentY = -(searchResultIndex - 1) * 35
                        calculatedHeight = -currentY
                        rowObj.y = currentY  
					else
                        rowObj.shouldBeHidden = true
					end
				end
			end

			local fwidth = DGV:GetFontWidth(L["Reload"])

			DugisReloadButton:SetText(L["Reload"]) 
			DugisReloadButton:SetWidth(fwidth + 20)
			
			fwidth = DGV:GetFontWidth(L["Reset"])
			DugisResetButton:SetText(L["Reset"])
			DugisResetButton:SetWidth(fwidth + 20)
			
            calculatedHeight = calculatedHeight - 280
           
			if calculatedHeight <=1 then 
                calculatedHeight = 500
            end
           
            DugisMain.rightScroll.bar:SetMinMaxValues(1, calculatedHeight)
            DugisMain.rightScroll.bar:SetValue(0)
	end
    
    function DGV:UpdateStepNumbersPosition(rowFrame, i)
        rowFrame.StepNumber:SetText(i)
        rowFrame.StepNumber:ClearAllPoints()
    
        if DugisGuideUser.showLeftMenuForCurrentGuide then
            rowFrame.StepNumber:SetPoint("TOPRIGHT", -410, -6)
        else
            rowFrame.StepNumber:SetPoint("TOPRIGHT", -38, -6)
        end    
    end
    
    function DGV:UpdateStepNumbersPositions()
		for i = 1, lastUsedStepIndex do
            local rowFrame = visualRows[i].frame 
            if rowFrame and rowFrame.StepNumber then
                DGV:UpdateStepNumbersPosition(rowFrame, i)
            end
		end
    end

	function DGV.GetWaitIcon(number)
		if number == 0 then
			return ""
		end
		return " |TInterface\\Timer\\ChallengesGlow-Logo:20:20:0:0|t" .. ((number and "|cffffffff["..number.."]|r")  or "")
	end

	function DGV:SetQuestText( i ) 
		
		local qName 	= DGV.quests1L[i]
		if DGV.NPCJournalFrame and NPCJournalFrame then		
			qName = NPCJournalFrame:ReplaceSpecialTags(qName, true, i, true)
		end
		DGV.quests1L[i] = qName
		local level 	= DGV:GetQuestLevel(self.qid[i])
		local questpart = self:ReturnTag("QIDP", i)
		
		local rowFrame = visualRows[i].frame
		
		if not rowFrame then
			return
		end
		
		if (level and level > 0 and strmatch(self.actions[i], "[ACT]") and self:UserSetting(DGV_QUESTLEVELON)) or (level and level > 0 and questpart and strmatch(self.actions[i], "[NK]") and self:UserSetting(DGV_QUESTLEVELON)) then
			if not rowFrame.Name.levelText and DGV.Localize == 0  then
				rowFrame.Name.levelText = string.format("[%d] %s", level, qName)
			end
			qName = rowFrame.Name.levelText
		end

		qName = (qName or "") .. DGV.GetWaitIcon(DGV.CountRemainingPlayers(i));
		
		if rowFrame.Name:GetText()~=qName then --optimization
			local width = self:GetFontWidth(qName)	
			rowFrame.Name:SetWidth(width + 10)	
			rowFrame.Name:SetText(qName)
		end
        
        DGV:UpdateStepNumbersPosition(rowFrame, i)
        
		if DGV:CheckForSkip(i) then CheckInitOpt(i) end
		rowFrame.Opt:SetText(rowFrame.Opt.text)
		
		if (rowFrame.Opt.optional or
			rowFrame.Opt.prof or 
			(rowFrame.Opt.pre and not EvaluatePRE(rowFrame.Opt.pre)) or 
			(rowFrame.Opt.pre2 and not EvaluatePRE(rowFrame.Opt.pre2)) or 			
			(rowFrame.Opt.pha and not EvaluatePHA(rowFrame.Opt.pha)) or 			
			(rowFrame.Opt.rep and not EvaluateREP(rowFrame.Opt.rep, rowFrame.Opt.standing))) or 
			(rowFrame.Opt.friend and not EvaluateFS(rowFrame.Opt.friend, rowFrame.Opt.level)) then
			rowFrame.Opt:Show()
		else
			rowFrame.Opt:Hide()	
		end
	end

	-- 
	-- Tab Functions
	--

	-- function DGV:SaveLastScrollBar(lasttab)
		-- SliderVal[lasttab] = Dugis_VSlider:GetValue()
	-- end

	-- function DGV:RestoreScrollBar(currenttab)
		-- DGV:DebugFormat("RestoreScrollBar", "currenttab", currenttab, "SliderVal[currenttab]", SliderVal[currenttab], "SliderMax[currenttab]", SliderMax[currenttab])
		-- Dugis_VSlider:SetValue(SliderVal[currenttab])
		-- Dugis_VSlider:SetMinMaxValues(1, SliderMax[currenttab])
	-- end

	function DGV:ShowViewTab()
		if DGV:isValidGuide(CurrentTitle) == true  then 
			Main.currentGuideTab:GetScript("OnClick")(Main.currentGuideTab)
		else
			Main.currentGuideTab:GetScript("OnClick")(Main.homeTab)
		end
	end

	function DGV:SetViewTabTitle(title)
		Main.title:SetText(title)
	end

	--Update the guide level range on guide listings when difficulty is changed
	function DGV:TabTextRefresh()
		local i, GuideRow
		DGV:SetViewTabTitle(self:GetFormattedTitle(CurrentTitle))
		
		for i = 1, #tabs do
			local TabInfo	= tabs[i]

			local gtype = TabInfo.guidetype
			if gtype then
				if DGV.guidelist and DGV.guidelist[gtype] then
					for j =1 , #DGV.guidelist[gtype] do  				
						GuideRow = _G["DugisTab"..i.."Row"..j]
                        
                        if GuideRow then
                            GuideRow.Title:SetText(self:GetFormattedTitle(DGV.guidelist[gtype][j]))
                        end
					end
				else
					GuideRow = _G["DugisTab"..i.."Row"..1]
					if GuideRow and GuideRow.Title then GuideRow.Title:SetText(L["No Guide Loaded"]) end
				end
			end
		end
	end
	
	Guides.rowHeadings = {}
	if not DGU.subCategoriesExpanded then
		DGU.subCategoriesExpanded = {}
	end
    
    function DGV:GetFlatternRecentGuides()
        local result = {}
        for headingIndex, heading in pairs(DugisGuideUser.RecentGuides.Categories) do
            for _,guide in ipairs(DugisGuideUser.RecentGuides.Guides[heading]) do
                result[#result + 1] = guide
            end
        end
        return result
    end    
    
    local function ExistsInRecentGuides(rawTitle)
        for _,guide in ipairs(DGV:GetFlatternRecentGuides()) do
            if guide == rawTitle then
                return true
            end
        end
        return false
    end

    local function Guide2CategoryName(guide)
        for _,tabInfo in ipairs(tabs) do
            local guideType = DGV.gtype[guide]
			if tabInfo.guidetype and guideType ==  tabInfo.guidetype then
                return tabInfo.title
			end
		end
        return L["Others"]
    end
    
    local function InTable(tbl, item)
        for key, value in pairs(tbl) do
            if value == item then return key end
        end
        return false
    end
    
    function DGV:AddGuideToRecentGuides(rawGuideTitle)
        local categoryName = Guide2CategoryName(rawGuideTitle) 
            
        if not ExistsInRecentGuides(rawGuideTitle) then
            if DugisGuideUser.RecentGuides.LastIndices[categoryName] == nil then
                DugisGuideUser.RecentGuides.LastIndices[categoryName] = 1
                DugisGuideUser.RecentGuides.Guides[categoryName] = {}
            else
                DugisGuideUser.RecentGuides.LastIndices[categoryName] = DugisGuideUser.RecentGuides.LastIndices[categoryName] + 1
            end

            if DugisGuideUser.RecentGuides.LastIndices[categoryName] > 5 then
                DugisGuideUser.RecentGuides.LastIndices[categoryName] = 1
            end
            
            local lastIndex = DugisGuideUser.RecentGuides.LastIndices[categoryName]
          
            if DugisGuideUser.RecentGuides.Guides[categoryName] == nil then
                DugisGuideUser.RecentGuides.Guides[categoryName] = {}
            end
            
            DugisGuideUser.RecentGuides.Guides[categoryName][lastIndex] = rawGuideTitle
            if  not InTable(DugisGuideUser.RecentGuides.Categories, categoryName) then
                DugisGuideUser.RecentGuides.Categories[#DugisGuideUser.RecentGuides.Categories + 1] = categoryName
            end
        end
    end
	
	--Load a guide from a tab
	function DugisGuideViewer_TabRow_OnEvent(self, event, ...)
        local rawTitle = self:GetParent().nodeData.data.rawTitle
        DGV:AddGuideToRecentGuides(rawTitle)
        
        local clickedType = DugisGuideViewer.gtype[rawTitle]
        local metaData = DugisGuideViewer.guidemetadata[rawTitle]
        
        if clickedType == "Followers" or clickedType == "Pets" or clickedType == "Mounts" or clickedType == "Bosses" or clickedType == "NPC" then
            NPCJournalFrame:OnGuideRowClick("", metaData.objectId, clickedType)
            return
        end
        
        DGV:DisplayViewTabInThread(rawTitle, nil, true)
        print("|cff11ff11Dugi Guides: |r"..DGV:GetFormattedTitle(rawTitle).."|cff11ff11 selected.|r")
        
        DGV:AddGuideToRecentGuides(rawTitle)
	end	
	
	local _G = _G
    
    local tabRowsListCache = {}
    --TODO check if there is a need of cache lifetime/cache expiration
    local function GetCachedTabRows(tabNum)
        if tabRowsListCache[tabNum] and tabNum ~= RECENT_TAB and tabNum ~= SUGGEST_TAB  and tabNum ~= SEARCH_TAB then
            return tabRowsListCache[tabNum]
        end
        local index = 1
        local key = format("DugisTab%dRow%d", tabNum, index)
        local result = {}
        local currentValue = _G[key]
        while currentValue do
            result[#result + 1] = currentValue
            index = index + 1
            key = format("DugisTab%dRow%d", tabNum, index)
            currentValue = _G[key]
        end
        
        tabRowsListCache[tabNum] = result
        return result
    end
	
	local function VerifyRank(rank, minimum, maximum)
		if minimum and rank<minimum then return end
		if maximum and rank>=maximum then return end
		return true
	end
	
	function DGV.SuggestProfessionGuidePredicate(englishProfArg1, minRank1, maxRank1, englishProfArg2, minRank2, maxRank2)
---------------------------------
----------- WOW Classic:---------
--------------------------------- 3
--GetProfessions not present.  Todo: check if needed/find replacement 
--[[
		local profIndex1, profIndex2 = GetProfessions()
		local localProf1, rank1
		if profIndex1 then localProf1, _, rank1 = GetProfessionInfo(profIndex1) end
		local localProf2, rank2
		if profIndex2 then localProf2, _, rank2 = GetProfessionInfo(profIndex2) end
		local localProfArg1 = L[englishProfArg1]
		local matchArg1 = (localProfArg1==localProf1 and VerifyRank(rank1, minRank1, maxRank1)) or (localProfArg1==localProf2 and VerifyRank(rank2, minRank1, maxRank1))
		if matchArg1 and not englishProfArg2 then return true end
		if englishProfArg2 then
			local localProfArg2 = L[englishProfArg2]
			local matchArg2 = (localProfArg2==localProf1 and VerifyRank(rank1, minRank2, maxRank2)) or (localProfArg2==localProf2 and VerifyRank(rank2, minRank2, maxRank2))
			return matchArg1 and matchArg2
		end]]		
	end
	
	function DGV.SuggestCurrentHolidayPredicate(guideTextureBase)
		for index, _, _, textureBase in IterateCurrentHolidays do
			if textureBase==guideTextureBase then return true end
		end
	end
	
	function DGV.SuggestReputationAchievementPredicate(reputation)
		local _, _, standingId = GetFactionInfoByID(reputation)
		if standingId<8 then return true end
	end
	
	function DGV.SuggestQuestAchievementPredicate(qid)
		local isCompleted = IsQuestFlaggedCompleted(qid) 
		if isCompleted then return true end
	end	
	
	
	local function IterateSuggestedGuides(invariant, key)
	
		local gtype = invariant[1]
		local threading = invariant[2]
		
		if gtype=="I" or gtype=="L" then
			for guideInRange,minimum in IterateGuidesInRange,nil,key do
				if DGV.gtype[guideInRange] == gtype then
					return guideInRange
				end
			end
		else
			while true do
				LuaUtils:RestIfNeeded(threading)
				key = next(DGV.guides, key)
				if not key then 
					return 
				end
				if DGV.gtype[key] == gtype then
					if DGV:ReturnGuideTag("SG", key) then
						return key
					end
				end
			end
		end
	end
        
    local playerRace,  engPlayerRace  = UnitRace("player") 
    local yofs = -5
    local rowheight = 14
    local rowCount = 0
    local lastHeading
    local function GetGuides(guideType, category)
        local result = {}
        local currentZone = DGV:GetCurrentMapID() 

        if DGV.guidelist and DGV.guidelist[guideType] ~= nil then
            for _,guide in ipairs(DGV.guidelist[guideType]) do
                
                local zone = tonumber(guide:match("^(%d+)"))
                if not zone then
					zone = guide:match("^(.-)%s?%(")
					if zone then 
	                    zone = tonumber(DGV:GetMapIDFromName(zone))
					end 
                end            
            
                if zone == currentZone   then
                     result[#result + 1] = guide
                end
            end
        end
        
        return result
    end
    
    function GetPercentageTextByNodeData(nodeData)
         return DGV:GetPercentText(nodeData.data.rawTitle, nodeData.data.guideType)
    end
    
    local guideType2Node = {}
    local headerL1Title2Node = {}
    local headerL2Title2Node = {}
    local headerL3Title2Node = {}
    tabs[SUGGEST_TAB].treeData = {}  

    function BeginAddingGuidesToTreeData(treeDataParent)
        treeDataParent.treeData = {}
        guideType2Node = {}
        headerL1Title2Node = {}
        headerL2Title2Node = {}
        headerL3Title2Node = {}
    end    
    
    local guideType2GuideTitle = {}
    
    for _, tab in pairs(tabs) do
        if tab.guidetype then
            guideType2GuideTitle[tab.guidetype] = tab.title
        end
    end
    
    local guideType2Icon = {}
    
    for _, tab in pairs(tabs) do
        if tab.guidetype then
            guideType2Icon[tab.guidetype] = tab.icon
        end
    end
    
    function AddGuideToTreeData(treeData, guideTitle, guideType, guideTypeAsTopCategory)
        local currentHeadingL1 = DGV.headings[guideTitle]
        local currentHeadingL2 = DGV.hedingsL2[guideTitle]
        local currentHeadingL3 = DGV.hedingsL3[guideTitle]
        local currentGuideType = guideType
        local currentNode
        
        if guideTypeAsTopCategory then
            currentNode = guideType2Node[guideType]
        else
            currentNode = headerL1Title2Node[currentHeadingL1]
        end 
        
        --New node
        --Categories Level 0
        if not currentNode and guideTypeAsTopCategory then
            local key = currentGuideType
            currentNode = {name=guideType2GuideTitle[currentGuideType], textColor={r=1, g=1, b=1}, expandedByDefault=true, disabledMouse=true, nodes={}, data={}}
            
            if guideType2Icon[currentGuideType] then
                currentNode.icon=guideType2Icon[currentGuideType]
                if type(currentNode.icon) == "function" then
                    currentNode.icon = currentNode.icon()
                end
                
                currentNode.iconSize = 20
                currentNode.iconDY = 1                
                currentNode.iconDX = -3                
           end
            
            guideType2Node[key] = currentNode
            treeData[#treeData + 1] = currentNode
        end
        
        --New node
        --Categories Level 1
        if not guideTypeAsTopCategory then
            if not currentNode then
                local key = currentHeadingL1
                currentNode = {name=currentHeadingL1, nodes={}, data={}}
                headerL1Title2Node[key] = currentNode
                treeData[#treeData + 1] = currentNode
            end
        else
            local key = currentGuideType..currentHeadingL1
            
            local currentL1Node = headerL1Title2Node[key]
            if not currentL1Node then
                currentL1Node = {name=currentHeadingL1, nodes={}, data={}}
                headerL1Title2Node[key] = currentL1Node
                currentNode.nodes[#currentNode.nodes + 1] = currentL1Node
            end
            
            currentNode = currentL1Node
        end
        
        --Categories Level 2
        if currentHeadingL2 then
            local key = currentHeadingL1 .. currentHeadingL2
            
            local currentL2Node = headerL2Title2Node[key]
            if not currentL2Node then
                currentL2Node = {name=currentHeadingL2, nodes={}, data={}}
                headerL2Title2Node[key] = currentL2Node
                currentNode.nodes[#currentNode.nodes + 1] = currentL2Node
            end
            
            currentNode = currentL2Node
        end  
        
        --Categories Level 3
        if currentHeadingL3 then
            local key = currentHeadingL1 .. currentHeadingL2 .. currentHeadingL3
        
            local currentL3Node = headerL3Title2Node[key]
            if not currentL3Node then
                currentL3Node = {name=currentHeadingL3, nodes={}, data={}}
                headerL3Title2Node[key] = currentL3Node
                currentNode.nodes[#currentNode.nodes + 1] = currentL3Node
            end
            
            currentNode = currentL3Node
        end
        
        --Leaf
        if currentNode then
            currentNode.nodes[#currentNode.nodes + 1] = {name=DGV:GetFormattedTitle(guideTitle)
            , isLeaf=true
            , onMouseEnter = OnGuideRowMouseEnter
            , onMouseLeave = OnGuideRowMouseLeave
            , onMouseClick = DugisGuideViewer_TabRow_OnEvent
            , rightText = GetPercentageTextByNodeData
            , data={rawTitle = guideTitle, guideType = guideType}}
        end
    
    end
    
    local suggestedQuests = nil
    
    function Guides.UpdateQuestsPart()
        local existingNodes = tabs[SUGGEST_TAB].treeData
        
        local categoryNode
        local key
        
        --Searching for old "Quests" node
        if existingNodes then
            for k, v in pairs(existingNodes) do 
                if v.type == "quests" then
                    categoryNode = v
                    key = k
                end
            end
        end
    
        if not categoryNode then
            categoryNode = {name="|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|tQuests in Log", type="quests", nodes={}, data={}}
            table.insert(tabs[SUGGEST_TAB].treeData, 1, categoryNode)
            key = 1
        end
        
        local node = tabs[SUGGEST_TAB].treeData[key]
        table.remove(tabs[SUGGEST_TAB].treeData, key)
        
        if suggestedQuests and #suggestedQuests > 0 then
            table.insert(tabs[SUGGEST_TAB].treeData, 1, node)
        end
        
        categoryNode.nodes={}
        
        if suggestedQuests then
            for k, v in pairs(suggestedQuests) do
                categoryNode.nodes[#categoryNode.nodes + 1] = v             
            end
        end    
    end

    local latestQuestIds = {}
    
    function Guides.UpdateSuggestedQuests(threading)
    
        if not DGV.guidelist then
            return
        end
    
        suggestedQuests = {}
        local somethingHasChanged = false
        
        local tabsAmount = #tabs
       
        local allPresentQuests = {}
        for i=1,GetNumQuestLogEntries() do
            local qid2 = select(8, GetQuestLogTitle(i))
            allPresentQuests[qid2] = true
            if not latestQuestIds[qid2] then
                somethingHasChanged = true
            end
        end
        
        --Checking if some quest has changed 
        for k, v in pairs (latestQuestIds) do
            if not allPresentQuests[k] then
                somethingHasChanged = true
            end 
        end
        
        latestQuestIds = LuaUtils:clone(allPresentQuests)
        
        if not somethingHasChanged then
            return
        end
        
        local alreadyAddedQuests = {}
		for i=1, tabsAmount do
			local gtype = tabs[i].guidetype
			if DGV.guidelist and gtype and DGV.guidelist[gtype] then
				local subCat = DGV.guidelist[gtype]
				for j =1 , #subCat do
                    LuaUtils:RestIfNeeded(threading)
                    
					local title = subCat[j]
                    
                    local formattedGuideTitle = DGV:GetFormattedTitle(title)
                    
                    local amount = DGV.Search:IsQuestPresentInGuide(title, gtype, allPresentQuests)
					if amount > 0 and not alreadyAddedQuests[title] then
                        alreadyAddedQuests[title] = true
                        
                        suggestedQuests[#suggestedQuests + 1] = {
                            name=DGV:GetFormattedTitle(title)
                            , isLeaf=true
                            , onMouseEnter = OnGuideRowMouseEnter
                            , onMouseLeave = OnGuideRowMouseLeave
                            , onMouseClick = DugisGuideViewer_TabRow_OnEvent
                            , rightText = GetPercentageTextByNodeData
                            , textAddon = "\n     |cFF00FF00"..(""..amount.." quest"..(amount > 1 and "s" or "").." in log").."|r"
                            , data={rawTitle = title, guideType = gtype}} 
					end
				end
			end
		end  
        
        Guides.UpdateQuestsPart()
    end
    
	PopulateSuggestedGuides  = function(threading)
        tabs[SUGGEST_TAB].treeData = {}
        
        playerRace,  engPlayerRace  = UnitRace("player") 
        if engPlayerRace == "BloodElf" then
            engPlayerRace = "Blood Elf"
        end
        if engPlayerRace == "NightElf" then
            engPlayerRace = "Night Elf"
        end
        
        if engPlayerRace == "Scourge" then
            engPlayerRace = "Undead"
        end

        BeginAddingGuidesToTreeData(tabs[SUGGEST_TAB])
        
        local iGuides = GetGuides("I", "Current Zone")
        for _, guide in pairs(iGuides) do
		
			if threading then
				LuaUtils:RestIfNeeded(threading)
				LuaUtils:WaitForCombatEnd(true)
			end
		
            local isStartingZone = (string.match(DGV.headings[guide], "Starting Zones") ~= nil)
            if not isStartingZone or (isStartingZone and string.match(guide, engPlayerRace)) then
                AddGuideToTreeData(tabs[SUGGEST_TAB].treeData, guide, "I", true)
            end
        end
        
        local lGuides = GetGuides("L", "Current Zone")
        for _, guide in pairs(lGuides) do
		
			if threading then
				LuaUtils:RestIfNeeded(threading)
				LuaUtils:WaitForCombatEnd(true)
			end
		
            local isStartingZone = (string.match(DGV.headings[guide], "Starting Zones") ~= nil)
            if not isStartingZone or (isStartingZone and string.match(guide, engPlayerRace)) then
                AddGuideToTreeData(tabs[SUGGEST_TAB].treeData, guide, "L", true)
            end
        end

		for _,tabInfo in ipairs(tabs) do
			if tabInfo.guidetype then
			
				local guide = IterateSuggestedGuides({tabInfo.guidetype, threading}, guide)
			
				while guide  do
                    if threading then
                        LuaUtils:RestIfNeeded(threading)
						LuaUtils:WaitForCombatEnd(true)
                    end

                    local isStartingZone = (string.match(DGV.headings[guide], "Starting Zones") ~= nil)
                    if not isStartingZone or (isStartingZone and string.match(guide, engPlayerRace)) then
                        AddGuideToTreeData(tabs[SUGGEST_TAB].treeData, guide, tabInfo.guidetype, true)
                    end
					
					guide = IterateSuggestedGuides({tabInfo.guidetype, threading}, guide)
				end
			end
		end
        
        Guides.UpdateQuestsPart()
	end
    
    PopulateRecentGuides = function()
        BeginAddingGuidesToTreeData(tabs[RECENT_TAB])
        
		for _,tabInfo in ipairs(tabs) do
			if tabInfo.guidetype then
				local headingLabel = nil

                local allRecentGuides = DGV:GetFlatternRecentGuides()
				for _,guide in ipairs(allRecentGuides) do
                    if tabInfo.guidetype == DGV.gtype[guide] then
                        if threading then
                            LuaUtils:RestIfNeeded(threading)
                            LuaUtils:WaitForCombatEnd(true)
                        end
                        
                        AddGuideToTreeData(tabs[RECENT_TAB].treeData, guide, tabInfo.guidetype)
                    end
				end
			end
		end
	end
	
	function DGV:InitializeTabs(threading)
		local yofs = -5
		local rowheight = 14
		local i, j, SettingNum, IconNum
		local GuideRow

		Main.homeTab.tabInfo = tabs[Category.Home]
		Main.homeTab:SetText(L["Home"])
		Main.currentGuideTab.tabInfo = tabs[Category.CurrentGuide]
		Main.currentGuideTab:SetText(L["Current Guide"])
		Main.settingsTab.tabInfo = tabs[Category.Settings]
		DGV:CreateSettingsTree(tabs[Category.Settings].RightFrame)
		tabs[Category.Settings]:Activate()
		PopulateSuggestedGuides(threading)

		local visualControlMap = {
			[Category.Suggest] = 1,
			[Category.Leveling] = 2,
			[Category.Dungeons] = 3,
			[Category.Events] = 4,
			[Category.Professions] = 5,			
			[Category.Dailies] = 6,
			[Category.ClearGuide] = 7,
			[Category.Help] = 8
		}

		local mainMenuLeftIndex = -1
		local mainMenuRightIndex = -1
		local mainMenuXSpace = 180
		local mainMenuYSpace = 43
		local mainMenuItemWidth = 170

		for i = 4, #tabs do
			if threading then
				LuaUtils:RestIfNeeded(threading)
				LuaUtils:WaitForCombatEnd(true)
			end
		
	
			local selection
			local TabInfo	= tabs[i]
			
			if visualControlMap[i] then
				selection	= DGVHomeFrame["selection"..visualControlMap[i]]
				selection.tabInfo = TabInfo
				
				if TabInfo.guidetype and not self.guidelist[TabInfo.guidetype] then
					selection:Hide()
				else
					selection.text:SetText(L[TabInfo.text])
					local texture = TabInfo.icon
					if type(texture)=="function" then
						texture(selection.icon)
					else
						selection.icon:SetTexture(texture)
					end
					selection.tooltip = L[TabInfo.title]
					selection:ClearAllPoints()

					local dX = 0
					local yIndex
					if i == Category.Help then
						mainMenuRightIndex = mainMenuRightIndex + 1
						dX = mainMenuXSpace
						yIndex = mainMenuRightIndex
					else
						mainMenuLeftIndex = mainMenuLeftIndex + 1
						yIndex = mainMenuLeftIndex
					end

					local buttonX, buttonY = 6 + dX, -yIndex * mainMenuYSpace - 10 
					local textX, textY = 42 + dX, -yIndex * mainMenuYSpace - 15

					selection:SetPoint("TOPLEFT", DGVHomeFrame, "TOPLEFT",  buttonX, buttonY )
					selection.text:SetPoint("TOPLEFT", DGVHomeFrame, "TOPLEFT",  textX, textY)
					selection:SetWidth(mainMenuItemWidth)
					TabInfo.RightFrame:Hide()
				end
			end

			
			if TabInfo.text == "Help" then
				--For technical support please contact:
				if not DGV_HelpURLEditBox then
					local logo = CreateFrame("Button", nil, TabInfo.RightFrame)
					logo:SetNormalTexture([[Interface\AddOns\DugisGuideViewerZ\Artwork\logo.tga"]])
					logo:SetPoint("TOPLEFT", -30, 0)
					logo:SetHeight(64)
					logo:SetWidth(256)					

					local techSupport = TabInfo.RightFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
					techSupport:SetText(L["For technical support please contact:"])
					techSupport:SetPoint("TOPLEFT", logo, "BOTTOMLEFT", 16, 0)
					
					local helpUrl = CreateFrame("EditBox", "DGV_HelpURLEditBox", TabInfo.RightFrame)
					helpUrl:SetFontObject(GameFontHighlight)
					helpUrl:SetTextInsets(2,2,2,2)
					helpUrl:SetMultiLine(true)
					helpUrl:SetAutoFocus(false)
					local setText = 
						function() 
							helpUrl:SetText("http://www.dugiguides.com/tech-support/")
						end
					setText()
					helpUrl:SetScript("OnTextChanged", function(self, user) if user then setText();helpUrl:HighlightText(); end end)

					helpUrl:SetScript("OnEditFocusGained", function() helpUrl:HighlightText() end)
					helpUrl:SetScript("OnMouseDown", function() helpUrl:HighlightText() end)
					helpUrl:SetScript("OnEditFocusLost", function() helpUrl:HighlightText(0,0) end)
					helpUrl:SetPoint("TOPLEFT", techSupport, "BOTTOMLEFT", 0, 0)
					helpUrl:SetWidth("500")
					helpUrl:SetHeight("20")
					helpUrl:Show()
					
					local videoTutorial = TabInfo.RightFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
					videoTutorial:SetText(L["Video tutorials are available from the link below:"])
					videoTutorial:SetPoint("TOPLEFT", DGV_HelpURLEditBox, "BOTTOMLEFT", 0, -16)
					
					local videoUrl= CreateFrame("EditBox", "DGV_VideoURLEditBox", TabInfo.RightFrame)
					videoUrl:SetFontObject(GameFontHighlight)
					videoUrl:SetTextInsets(2,2,2,2)
					videoUrl:SetMultiLine(true)
					videoUrl:SetAutoFocus(false)
					local setText = 
						function() 
							videoUrl:SetText("http://www.dugiguides.com/videos/")
						end
					setText()
					videoUrl:SetScript("OnTextChanged", function(self, user) if user then setText();videoUrl:HighlightText(); end end)

					videoUrl:SetScript("OnEditFocusGained", function() videoUrl:HighlightText() end)
					videoUrl:SetScript("OnMouseDown", function() videoUrl:HighlightText() end)
					videoUrl:SetScript("OnEditFocusLost", function() videoUrl:HighlightText(0,0) end)
					videoUrl:SetPoint("TOPLEFT", videoTutorial, "BOTTOMLEFT", 0, 0)
					videoUrl:SetWidth("500")
					videoUrl:SetHeight("20")
					videoUrl:Show()		
									
					local iconRefHeading = TabInfo.RightFrame:CreateFontString(nil,"ARTWORK", "GameFontNormalLarge")
					iconRefHeading:SetText(L["Icon Reference"])
					iconRefHeading:SetPoint("TOPLEFT", DGV_VideoURLEditBox, "BOTTOMLEFT", 0, -16) 
				
					local wrow1 = 0
					local wrow2 = 0
					local wrow3 = 0
					local wmax = 0
					for IconNum = 1, #icontbl do
						local width = self:GetFontWidth(L[icontbl[IconNum].text], "GameFontHighlight")
						if width > wmax then wmax = width end
					
						if IconNum == 6 then
							wrow1 = wmax
							wmax = 0
						elseif IconNum == 12 then
							wrow2 = wmax
							wmax = 0
						elseif IconNum == #icontbl then
							wrow3 = wmax
							wmax = 0
						end
						
					end
					
					for IconNum = 1, #icontbl do
						local icon = CreateFrame("Button", "DGV_Settingsicon"..IconNum, TabInfo.RightFrame, "IconReferenceTemplate")
									
						icon.Button:SetNormalTexture(icontbl[IconNum].path)
						icon.Name:SetText(L[icontbl[IconNum].text])
						icon.Name:SetJustifyH("LEFT")
						
						if IconNum < 7 then icon:SetWidth(wrow1 + 50) icon.Name:SetWidth(wrow1 + 50) elseif IconNum < 13 then icon:SetWidth(wrow2 + 50) icon.Name:SetWidth(wrow2 + 50) elseif IconNum < 19 then icon:SetWidth(wrow3 + 50) icon.Name:SetWidth(wrow3 + 50)  end
						if IconNum == 1 then
							icon:SetPoint("TOPLEFT", iconRefHeading, "BOTTOMLEFT",  5, 0)

							--icon:SetPoint("TOPLEFT", 20, -20) 
						elseif IconNum == 7 then
							icon:SetPoint("LEFT", "DGV_Settingsicon1", "RIGHT", -15, 0)
						elseif IconNum == 13 then
							icon:SetPoint("LEFT", "DGV_Settingsicon7", "RIGHT", -15, 0)	
						else
							icon:SetPoint("TOP", "DGV_Settingsicon"..(IconNum-1), "BOTTOM", 0, 13)
						end				
					end
				end
			end
			
            function OnGuideRowMouseEnter(self)
                local nodeData = self:GetParent().nodeData
            
                local title = nodeData.data.rawTitle
                local heading = DugisGuideViewer.headings[title]
                local guidetags = DugisGuideViewer.guidetags[title]
                local gtype = DugisGuideViewer.gtype[title]
                local formatted = DugisGuideViewer:GetFormattedTitle(title)
                local guidemetadata = DugisGuideViewer.guidemetadata[title]
                
                if guidemetadata then
                    NPCJournalFrame:OnGuideRowMouseEnter(title, guidemetadata.objectId, gtype)
                end
                
                if guidemetadata then
                     if guidemetadata.description then
                        local description = guidemetadata.description
                        local image = guidemetadata.image
                        local hintFrame = DGV.NPCJournalFrame.hintFrame
						if description then description = NPCJournalFrame:ReplaceSpecialTags(description, true) end
                        hintFrame:SetMode(GUIUtils.HINT_WINDOW_IMAGE_MODE)
                        hintFrame.frame:ClearAllPoints()
                        hintFrame.frame:SetPoint("TOPLEFT", DugisMain, "TOPRIGHT", 8, 11) 
                        
                        hintFrame.frame:SetWidth(280)
                        hintFrame.showImageInImageMode = (guidemetadata.image ~= nil)
                        
                        formatted = string.gsub(formatted, '|c........', '')
                        formatted = string.gsub(formatted, '|r', '')
                        hintFrame.text:SetTextColor(1, 1, 1);
						if description == "" then 
                            hintFrame:SetText("|cffffd200"..formatted.."|r")
						else
                            hintFrame:SetText("|cffffd200"..formatted.."|r\n\n|cffffffff"..description.."|r")
						end
                        hintFrame.text:SetPoint("TOPLEFT", hintFrame.frame, "TOPLEFT", 18, -150)
                        if image ~= nil then
                            hintFrame.imageFrame.texture:SetTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\Guides\\"..image)
                        end
                        hintFrame:Show(true)    
                        hintFrame:UpdateHeight()                       
                    end
                end
            end    
            
            function OnGuideRowMouseLeave()        
                local hintFrame = NPCJournalFrame.hintFrame
                hintFrame.frame:Hide()   
            end
			
			local gtype = TabInfo.guidetype
			if gtype then
				if DGV.guidelist and DGV.guidelist[gtype] then
                
                    BeginAddingGuidesToTreeData(TabInfo)
                    
					for j =1 , #DGV.guidelist[gtype] do
                        if threading then
                            LuaUtils:RestIfNeeded(threading)
   							LuaUtils:WaitForCombatEnd(true)
                        end
                    
						local title = DGV.guidelist[gtype][j]
                        
                        AddGuideToTreeData(TabInfo.treeData, title, gtype)
					end
				end
			end
		end
        
        DugisGuideViewer.Guides.UpdateSuggestedQuests(threading)         
	end
    
	function PopulateGlobalSearchResults()
		local yofs = -5
		local rowheight = 14
		local rowCount = 0
        
        local tabRowsList = GetCachedTabRows(SEARCH_TAB)
        
        for i, row in pairs(tabRowsList) do
            row.title = nil
            row:Hide()
        end
        
		for headingIndex,rh in ipairs(Guides.rowHeadings) do
			if rh.tabNum==SEARCH_TAB then
				rh:ClearAllPoints()
				rh:Hide()
			end
		end

        local headerL1Title2Node = {}
        tabs[SEARCH_TAB].treeData = {}
        
        local i=1
        local tabsAmount = #tabs
        Guides.progress = 0
        
		for i=1, tabsAmount do
           
			local gtype = tabs[i].guidetype
			if DGV.guidelist and gtype and DGV.guidelist[gtype] then
				local subCat = DGV.guidelist[gtype]
				--DGV:DebugFormat("PopulateGlobalSearchResults", "gtype", gtype)
                local lastProgress = Guides.progress
                 
				for j =1 , #subCat do
                    Guides.progress = lastProgress + (j / #subCat)/tabsAmount
                    Guides:UpdateSearchText()
                    
                    LuaUtils:RestIfNeeded(true)
					local title = subCat[j]
                    local matches, questTitle, questId = DGV.Search:InSearchResults(DGV.headings[title], DGV:GetFormattedTitle(title), title, gtype, tabsAmount * #subCat)
					if matches then
                        local currentNode = nil
                        local currentHeading = DGV.headings[title]
                        
                        local currentNode = headerL1Title2Node[currentHeading]
                        
                        --New node
                        if not currentNode then
                            currentNode = {name=currentHeading, nodes={}, data={}}
                            headerL1Title2Node[currentHeading] = currentNode
                            tabs[SEARCH_TAB].treeData[#tabs[SEARCH_TAB].treeData + 1] = currentNode
                        end
                        
                        if currentNode then
                            currentNode.nodes[#currentNode.nodes + 1] = {name=DGV:GetFormattedTitle(title)
                            , isLeaf=true
                            , onMouseEnter = OnGuideRowMouseEnter
                            , onMouseLeave = OnGuideRowMouseLeave
                            , onMouseClick = DugisGuideViewer_TabRow_OnEvent
                            , rightText = GetPercentageTextByNodeData
                            , textAddon = questTitle and "\n     |Hquest:"..(questId or "").."|h|cFF00FF00["..questTitle.."]|r|h"
                            , data={rawTitle = title, guideType = gtype}}
                        end
					end
				end
			end
            Guides.progress =  i / tabsAmount
		end

        --Locations
        ---------------------------------
        --------- TREE FRAME ------------
        ---------------------------------
        if DGV_SearchBox:GetNumLetters() > 1 then
            nodes = DGV:GetLocationsAndPortalsByText(DGV_SearchBox:GetText())
            
            for _, node in pairs(nodes) do
                tabs[SEARCH_TAB].treeData[#tabs[SEARCH_TAB].treeData + 1] = node
            end
        else
        end
        
        tabs[SEARCH_TAB]:Activate()
        
		local tabInfo = tabs[SEARCH_TAB]
		tabInfo.rightScrollMax = rowheight * rowCount +  50

        --In case some locations/portals are found the current tab must be hidden 
        if rowCount == 0 and #nodes > 0 then
            activeTabInfo.RightFrame:Hide()
        end
	end
    
    local lastProgress = Guides.progress or 0
    function Guides:UpdateSearchText()
        if Guides.progress == nil or  math.abs(Guides.progress - lastProgress) < 0.0001 then
            return
        end
        
        local percentage = ""
        
        if Guides.progress then
            percentage = string.format("%4.2f", LuaUtils:Round(Guides.progress * 100, 2)) .. "% " 
        end
        SearchingInfoText:SetText(percentage .. L["Searching for"] .. ": " .. DGV_SearchBox:GetText() .. "..")
        
        lastProgress = Guides.progress
    end
    
    function Guides:UpdateSearch()
        searchThread = coroutine.create(PopulateGlobalSearchResults)

        if DGV_SearchBox:GetNumLetters() > 1 then
            DGV_SearchBox:SetAlpha(0.0)
            SearchingInfoText:Show()
            Guides:UpdateSearchText()
            searchingPattern = DGV_SearchBox:GetText()
            DugisMainRightScrollFrame.bar:SetEnabled(false)
        else
            SearchingInfoText:Hide()
        end
    end
	
	local abandonQuestReaction
	function Guides:Load()

		DGV:RegisterEvent("GET_ITEM_INFO_RECEIVED")


---------------------------------
----------- WOW Classic:---------
---------------------------------  
--No such event. Todo: check if needed/find replacement 
		--DGV:RegisterEvent("UNIT_ENTERED_VEHICLE")



		DGV:RegisterEvent("PLAYER_ENTERING_WORLD")


---------------------------------
----------- WOW Classic:---------
---------------------------------  
--No such event. Todo: check if needed/find replacement 
		--DGV:RegisterEvent("UNIT_EXITED_VEHICLE")


		DGV:RegisterEvent("GOSSIP_CLOSED")


---------------------------------
----------- WOW Classic:---------
---------------------------------  
--No such events. Todo: check if needed/find replacement 
		--DGV:RegisterEvent("SCENARIO_UPDATE")
		--DGV:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
		--DGV:RegisterEvent("SCENARIO_COMPLETED")
		

        DGV:RegisterEvent("UNIT_AURA")		
		if not DGV.guides then DGV.guides = {} end
		if not DGV.guidetags then DGV.guidetags = {} end
        if not DGV.guidemetadata then DGV.guidemetadata = {} end
		if not DGV.nextzones then DGV.nextzones = {} end
		if not DGV.gtype then DGV.gtype = {} end
		if not DGV.rawtitle then DGV.rawtitle = {} end
		if not DGV.guidelist then DGV.guidelist = {} end
		if not DGV.headings then DGV.headings = {} end
        
		if not DGV.hedingsL2 then DGV.hedingsL2 = {} end
		if not DGV.hedingsL3 then DGV.hedingsL3 = {} end

		--DGV.queryquests = {}
		DGV.actions = {}
		DGV.quests1 = {}
		DGV.quests1L = {} --localized quest list
		DGV.quests2 = {}
		DGV.useitem = {}
		DGV.qid = {}
        --Extra quest ids
		DGV.eqids = {}
        DGV.sid = {}
		DGV.daily = {}
		DGV.MappedPoints = {}
		DGV.tags = {}
		DGV.coords = {}
		if not DGU.removedQuests then DGU.removedQuests = {} end
		if not DGU.shownObjectives then DGU.shownObjectives = {} end
		DGV.postReqs = {}
		DGV.breadCrumbs = {}
		DGV.visualRows = {}
		visualRows = DGV.visualRows

		function DugisGuideViewer.UpdateWorldQuestAutoGuide()
            if CurrentTitle == DGV.questAutoGuideName then    
				local questId, title = QuestSuperTracking_GetClosestQuest_Dugis()
				local currentQuestId = DGV.qid[DGU.CurrentQuestIndex]
				if currentQuestId ~= questId then
			
					if DGV.guides and DGV.guides[DGV.questAutoGuideName] then
						DGV:WipeOutViewTab()

						DGV:ParseRows(false, DGV.questAutoGuideName, false
						, string.split("\n"
						,"\n"..DGV.guides[DGV.questAutoGuideName]() ))

						for i = 1, 2 do
							DGV:UpdateRowVisualizations(i)
						end

						DGV:PopulateObjectives(DGV.questAutoGuideName, nil, false)
						DGV:SetQuestText(2)
						DugisGuideViewer:UpdateGuideVisualRows()
					end

					if DGV.SmallFrame and DGV.SmallFrame.autoGuidePOIButton and DugisArrowGlobal then
						DGV.SmallFrame.autoGuidePOIButton.worldQuest = true
					end

					if questId then
						DGU.CurrentQuestIndex = 2
						DGV:SetQuestState(1, "C")
						lastUsedStepIndex = 2

						DGV.SendDataToServer("NGSI")
						DGV.SendDataToClients("NGSI-SV")						
					else 
						DGU.CurrentQuestIndex = 1
						lastUsedStepIndex = 1
						DGV:SetQuestState(1, "U")

						DGV.SendDataToServer("NGSI")
						DGV.SendDataToClients("NGSI-SV")						
					end
					DGV.Guides.UpdateVisuals()
                end
            end
        end
        
        local questToUncomplete = {}
        
		function DGV:CompleteQuest(completedQID)
			--DebugPrint("Finished a quest, HookScript QuestFrameCompleteQuestButton")
			local qid = completedQID or DGV:GetQIDFromQuestName(GetTitleText())
			--if qid then

			--	DGU.turnedinquests[qid] = true
			--end
			--if CurrentAction and qid then DebugPrint("HOOK qid is"..qid.."*".."action ="..CurrentAction.."*".."titletext="..GetTitleText()) end

			local acceptandcomplete 			= DGV:ReturnTag("E", DGU.CurrentQuestIndex)

			--if not acceptandcomplete then return end

			if not  DGV.quests1L[DGU.CurrentQuestIndex] then return end
			local _, _, questnoparen = DGV.quests1L[DGU.CurrentQuestIndex]:find("([^%(]*)")
			questnoparen = questnoparen:trim()
            
            questToUncomplete[#questToUncomplete + 1] = qid

			if (CurrentAction == "T" and DGV.qid[DGU.CurrentQuestIndex] == qid) or (acceptandcomplete and GetTitleText() == L[questnoparen] )
			then
				if qid then DebugPrint("Detected curent quest turned in"..qid) end
				DGV:SetChkToComplete(DGU.CurrentQuestIndex)
				DGV:MoveToNextQuest()
			else
				DGV:CompleteQID(qid, "T") --not needed UpdateMainFrame() handles this
				DGV:MoveToNextQuest()
			end
			--JustTurnedInQID = qid
            LuaUtils:Delay(5, function()
                for _, qidToUncheck in pairs(questToUncomplete) do
                    for i=1, lastUsedStepIndex do
                        local qid = DugisGuideViewer.qid[i]
                        if tonumber(qidToUncheck) == tonumber(qid) and QuestUtils_IsQuestWorldQuest(tonumber(qid)) then
                            DugisGuideViewer:SetChkToNotComplete(i)
                        end
                    end
                end
                
                questToUncomplete = {}
                DugisGuideViewer:MoveToPrevQuest()
            end)
            
            DugisGuideViewer.UpdateWorldQuestAutoGuide()
            
		end
        
        function Guides.OnPlayerLocationChange()
            DugisGuideViewer.UpdateWorldQuestAutoGuide()
        end        
        
        local lastX, lastY = DGV:GetPlayerMapPosition()
        function Guides.OnFrameUpdate()
            local x, y = DGV:GetPlayerMapPosition()
            local dX, dY = x-lastX, y-lastY
            
            local currentDistance = math.sqrt(dX*dX + dY*dY)
            if currentDistance > 0.005 then
                Guides.OnPlayerLocationChange()
                lastX, lastY = DGV:GetPlayerMapPosition()
            end
        end

		function DGV:ClearScreen()
			if InCombatLockdown() then print("|cff11ff11Dugi Guides: |r|cffcc0000Cannot clear guides during combat.|r Please try again."); return end
			DGV:SetViewTabTitle(L["No Guide Loaded"])
			DGV:LoadInitialView(L["No Guide Loaded"], "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\iconbutton.tga", L["Right Click Here To Select One"])
			DGV:WipeOutViewTab()
			wipe(DGV.actions)
            lastUsedStepIndex = -1
			DGV:UpdateSmallFrame()
			if DugisGuideViewer:IsModuleLoaded("Target") then
				DugisGuideViewer.Modules.Target.Frame:Hide()
			end
			DugisGuideViewerActionItemFrame:Hide()
			DugisSecureQuestButton:Hide()
			if SmallFrameProgressBar and SmallFrameProgressBar:IsShown() then SmallFrameProgressBar:Hide() end			
		end

		function DGV:isValidGuide(title)
			if self.guides[title] then
				return true
			end
			return false
		end
		
		function DGV:ShowLargeWindow()
            if DGV.IsHiddenForCombat(DugisMainBorder) then
                return 
            end
                   
            if DGV.IsHiddenForCombat(DugisMain) then
                return 
            end
        
			--DugisMainframe:SetHeight(400)
			DGV:AutoScroll(DGU.CurrentQuestIndex)
			DugisMainBorder:Show()
			DugisMainBorder.bg:Show()
			--DugisSmallFrameLogo:Show()

			DugisMain:Show()
			LuaUtils:PlaySound("igCharacterInfoOpen")
			--DugisReloadButton:Show()
			--DugisSuggestButton:Show()
			--DugisResetButton:Show()
			--DGV:SetAllBorders()
			DugisMainBorder:SetHeight(420)
            
            DugisGuideViewer:UpdateCurrentGuideExpanded()
            
			if UpdateWhatsNewFramePositions then
				UpdateWhatsNewFramePositions()
			end
            
            if Guides.currentTabTitle == tabs[SUGGEST_TAB].text then
                Guides.UpdateTreeDate(tabs[SUGGEST_TAB], tabs[SUGGEST_TAB].treeData)
            end
		end
		
		function DGV:CheckForFloorChange()
			if type(DGU.CurrentQuestIndex) == "boolean" then
				DGU.CurrentQuestIndex = 1
			end
			if CurrentAction == "R" or self:ReturnTag("F", DGU.CurrentQuestIndex) then
				local map, floor = self:ReturnTag("F", DGU.CurrentQuestIndex)
				if map and floor and floor == DGV.DugisArrow.floor and map == DGV.DugisArrow.map then
					--DebugPrint("Detected correct floor in dungeon")
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				elseif not floor and map and map == DGV.DugisArrow.map then
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				end	
			end
		end
		
		local AbandonQID
		local function UpdateAbandonQID()

			local i = GetQuestLogSelection()
			AbandonQID = select(8, GetQuestLogTitle(i))
			--DGV:DebugFormat("UpdateAbandonQID", "AbandonQID", AbandonQID)
		end
		abandonQuestReaction = RegisterFunctionReaction("AbandonQuest", nil, UpdateAbandonQID)
		
		function DGV:UpdateMainFrame(isInThread)
			if DGV:isValidGuide(CurrentTitle) ~= true then return end
			local i, guideIndex
			local setChecked = false 
			
            
            local indicesToComplete = {}
            local notCompletedQuests = {}
            
			--Check for all completed or user uncompleted quests in quest log 
			for guideIndex = 1, lastUsedStepIndex do
				local qComplete, QuestComplete
				local qid 			= self.qid[guideIndex]
				local eqids 	    = self.eqids[guideIndex]
				local logIndx 		= self:GetQuestLogIndexByQID(qid)
				local action 		= self.actions[guideIndex]
				local questState	= self:GetQuestState(guideIndex)
				local playerLevel	= UnitLevel("player")
				
				if logIndx then _, _, _, _, _, qComplete, _, _ = GetQuestLogTitle(logIndx) end
                
                local allTurned = self:HasQuestBeenTurnedIn(qid)
                
                if eqids then
                    for _, questId_ in pairs(LuaUtils:split(eqids, " ")) do
                        questId_ = tonumber(questId_)
                        if questId_ then
                            if not self:HasQuestBeenTurnedIn(questId_) then
                                allTurned = false
                            end                             
                        
                            local logIndx_ 		= self:GetQuestLogIndexByQID(questId_)
                            if logIndx_ then
                                local _, _, _, _, _, qComplete_ = GetQuestLogTitle(logIndx_) 
                                if qComplete_ ~= 1 then
                                    qComplete = 0
                                end
                            end
                        end
                    end
                end
                
				LuaUtils:RestIfNeeded(isInThread)
				 
			 	if qComplete == 1 
                or self:CheckForHearth(guideIndex) 
                or self:ProfessionCompletedAtGuideIndex(guideIndex)
                or self:AchieveCompleteFromGuideIndex(guideIndex)
                or self:CheckForLocation(guideIndex) 
                --isDaily 
                or (not self:ReturnTag("D", guideIndex) and allTurned ) 
                or self:QuestPartComplete(guideIndex) 
                then 
                    QuestComplete = true 
                 else 
                    QuestComplete = nil 
                    if qid then
                        notCompletedQuests[qid] = true
                    end
                 end
								
				if (action == "A" and logIndx) 
                or (QuestComplete and action ~= "T") 
                or (QuestComplete and action == "T" and not logIndx) 
                or (
                    questState == "C" and action
                    and strmatch(action, "[NFfRBbh]") 
                    --questPart
                    and not self:ReturnTag("QIDP", guideIndex) 
                    --needsLoot 
                    and not self:ReturnTag("L", guideIndex)
                ) 
                or (
                    action ~= "f" 
                    and (self:ReturnTag("PL", guideIndex) or 1000000) <= playerLevel
                )
                --ayg
                or EvaluateAYG(self:ReturnTag("AYG", guideIndex))
                or (EvaluateTID(self:ReturnTag("TID", guideIndex))) 
                or (EvaluateBUFF_(self:ReturnTag("BUFF", guideIndex)))
                or EvaluateOIDsORs(self:ReturnTag("OID", guideIndex))
				or (EvaluateFS_(self:ReturnTag("REPR", guideIndex)))
                then  												
					if not (questState == "C" or questState == "X") then 
                   
                       indicesToComplete[guideIndex] = qid or 1
					   setChecked = true

					end 
				end
			end
            
            for guideIndex, qid in pairs(indicesToComplete) do
                if not qid or qid == 1 then
                    DGV:SetChkToComplete(guideIndex)
                else
                    if QuestUtils_IsQuestWorldQuest(qid) then
                        --Making unchecked World Quests on complete. Filtering out compelted quests.
                        if notCompletedQuests[qid] then
                            DGV:SetChkToComplete(guideIndex)
                        end
                    else
                        DGV:SetChkToComplete(guideIndex)
                    end
                end
            end
            
			if setChecked and not self.preLoadMode then
                local nextUnchecked = self:FindNextUnchecked(isInThread)
            
				if (nextUnchecked ~= DGU.CurrentQuestIndex) then
					self:MoveToNextQuest(nextUnchecked, isInThread)
				else
					self:MoveToNextQuest(nil, isInThread)
				end
			elseif self:ReturnTag("POI", guideIndex) then 
				self:DelayAndMapCurrentObjective(0.2)				
			end 
			
			--Abandoned Quest
			if AbandonQID and DGU.CurrentQuestIndex then
				--local logidx = self:GetQuestLogIndexByQID(AbandonQID)
				--if not logidx then --user abandoned quest but it hasn't registered yet			
					for i =1, lastUsedStepIndex do 
						LuaUtils:RestIfNeeded(isInThread)
						if self.qid[i] == AbandonQID and strmatch(self.actions[i], "[ACTNKR]") then
							self:ClrChk(i)
						end
						local oid1, oid2, oid3, oid4	= self:ReturnTag("OID", i)
						if tonumber(oid1) == AbandonQID or tonumber(oid2) == AbandonQID or tonumber(oid3) == AbandonQID or tonumber(oid4) == AbandonQID and strmatch(self.actions[i], "[ACTNKR]") then
							self:ClrChk(i)
						end
					end
					local nextindex = self:FindNextUnchecked()
					if nextindex < DGU.CurrentQuestIndex then
						self:MoveToPrevQuest()
					end
					AbandonQID = nil	
				--end
			end				
			
			self.UpdateStickyFrame( )
		end
		
		-- function DGV:UpdateQueryQuests()
			-- if DGV.queryquests then
				-- local quest
				-- for quest, _ in pairs(DGV.queryquests) do
					-- DGU.turnedinquests[quest] = true
				-- end
				-- DGV.queryquests = {}
			-- end
		-- end
		
		local lastInstanceEntered
		local function CheckDungeonZoneIn()
			if IsInInstance() then
				--local currentZone = DGV:GetPlayerMapPositionDisruptive() --required to override MapPreview
                LuaUtils:DugiSetMapToCurrentZone()
                currentZone = DGV:GetCurrentMapID() 
				if currentZone==lastInstanceEntered then return end --one suggestion per entry
				lastInstanceEntered = currentZone
				MatchDungeonGuides(currentZone)
			end
		end
		
		function DGV:CompleteOnZoneCheck()
			local correctzone
			
			if DGV:ReturnTag("CHKMAP", DGU.CurrentQuestIndex) then 
				DGV:MoveToNextQuest()
			end
			
			if DGV:ReturnTag("AYG", DGU.CurrentQuestIndex) then						
				correctzone = DGV:CheckForLocation(DGU.NextQuestIndex)	
				if correctzone then 
					DGV:SetChkToComplete(DGU.NextQuestIndex)
					DGV:MoveToNextQuest()
				end							
			else 
				correctzone = DGV:CheckForLocation(DGU.CurrentQuestIndex)
				if correctzone then 
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				end
			end
		end
		
		function DGV:Zone_OnEvent()
			DGV:CompleteOnZoneCheck()
			CheckDungeonZoneIn()
		end
		
		function DGV:CHAT_MSG_SYSTEM(event, msg)
			--Detect hearth, quest accept or quest complete
			local msgqid, curqid, questnoparen
			local _, _, loc 	= msg:find(L["(.*) is now your home."])
			local _, _, accept = msg:find(L["Quest accepted: (.*)"])
			
			if DGV:isValidGuide(self.CurrentTitle) == false then return end
			
			if loc then --Set Hearth	
				questnoparen = DGV.quests1[DGU.CurrentQuestIndex]:match("([^%(]*)")
				questnoparen = questnoparen:trim()
				if CurrentAction == "h" and questnoparen == loc then
					DebugPrint( "Detected setting hearth to ".. loc.."message:".. msg)
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				end

			elseif accept then	--Quest accept
				curqid 		= DGV.qid[DGU.CurrentQuestIndex]
				msgqid 		= DGV:GetQIDFromQuestName(accept)	
				--DebugPrint("accept ="..accept.."quest id is"..msgqid.."*".."action ="..CurrentAction.."*")
				
				if CurrentAction == "A" and msgqid == curqid then
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				elseif DGV:ReturnTag("E", DGU.CurrentQuestIndex) then
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				else --not current quest but accept by user into log
					DGV:CompleteQID(msgqid, "A")
					DGV:MoveToNextQuest()
				end
				
				--Skip breadcrumbs if any
				self:SkipBreadCrumbs(msgqid)
			end

		end
		
		--[[function DGV:UI_INFO_MESSAGE(err, msg)
			if (CurrentAction == "f") then
			DebugPrint("CurrentAction="..CurrentAction.."msg="..msg.."ERR_NEWTAXIPATH="..ERR_NEWTAXIPATH)
				if msg == ERR_NEWTAXIPATH then

					DebugPrint("Detected completed new flight path")
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()	
				end
			end
		end]]--
		
		local function CheckLTag()
			if CurrentTitle ~= nil then
				local itemid
				local guideIndex = DGU.CurrentQuestIndex
				--local itemlink = string.match(msg, LOOT_SELF_REGEX) or string.match(msg, LOOT_PUSHED_REGEX)
				
				--if itemlink then itemid = string.match(itemlink, "item:(%d+):")	end
				
				--[[for guideIndex = 1, lastUsedStepIndex do
					if DGV:ReturnTag("L", guideIndex) then 
						if DGV:IsCompleteLootQO("CMSG", itemid, guideIndex) then 
							DGV:SetChkToComplete(guideIndex) 
							DGV:MoveToNextQuest()
						end
					end 
				end]]
				if DGV:ReturnTag("L", guideIndex) and DGV:havelootitem(guideIndex) == true and not DGV:ReturnTag("O", guideIndex) then 
					DGV:SetChkToComplete(guideIndex) 
					DGV:MoveToNextQuest()
				end 				
			end			
		end 

		local LOOT_SELF_REGEX = gsub(LOOT_ITEM_SELF, "%%s", "(.+)") --"You receive item: %s."
		local LOOT_PUSHED_REGEX = gsub(LOOT_ITEM_PUSHED_SELF, "%%s", "(.+)") --"You receive loot: %s."
		function DGV:CHAT_MSG_LOOT(event, msg)	--We use delay 1s now because BFA loot detection is slower. 
			local guideIndex = DGU.CurrentQuestIndex
			if DGV:ReturnTag("L", guideIndex) then 
				LuaUtils:Delay(1, function()
					CheckLTag()
				end)
			end 
		end
		
		function DGV:PLAYER_LEVEL_UP(self, level)
			DGV.CalculateScore_cache = {}

			if DGV.CheckForTrainingSuggestions then
				LuaUtils:Delay(3, function()
					DGV.CheckForTrainingSuggestions()
				end)
			end

            DGV.GearFinderScoreGuide_cache_v1 = {}
        
			--skip quest that is grey ! or too high level, and check again on playerlevel up event to see if they can pick them up
			if not InCombatLockdown() then		
				DGU.PlayerLevel = tonumber(level) or UnitLevel("player")
				DGV:UpdatePlayerLevels(DGU.PlayerLevel)
                --DGV.ShowSuggestGuideNotification(DGU.PlayerLevel, true)
                DGV:DisplayViewTabInThread(CurrentTitle, nil, false)
			else
				DGV.DoOutOfCombat(DGV.PLAYER_LEVEL_UP)
			end
			DugisGuideUser.alreadySuggestedGuides = {}
		end		

		
		function DGV:GOSSIP_CLOSED()
			DebugPrint("###GOSSIP_CLOSED")
			LuaUtils:Delay(1, function()
				if self:ReturnTag("V", DGU.CurrentQuestIndex) or DGV.actions[DGU.CurrentQuestIndex] == "F" then
					--if UnitInVehicle("player") == 1 or UnitControllingVehicle("player") == true or UnitOnTaxi("player") == true or HasOverrideActionBar("player") == true then
					if UnitOnTaxi("player") == true then
						DGV:SetChkToComplete(DGU.CurrentQuestIndex)
						DGV:MoveToNextQuest()
					end
				end
			end)
		end
		
		function DGV:UNIT_ENTERED_VEHICLE()
			DebugPrint("###UNIT_ENTERED_VEHICLE")
			if self:ReturnTag("V", DGU.CurrentQuestIndex) or DGV.actions[DGU.CurrentQuestIndex] == "F" then
				--if UnitInVehicle("player") == 1 or UnitControllingVehicle("player") == true or UnitOnTaxi("player") == true or HasOverrideActionBar("player") == true then
				if UnitOnTaxi("player") == true then
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				end
			end
		end		
         
        local UpdateVisuals_Timer    
        function DGV.Guides.UpdateVisuals()
            if UpdateVisuals_Timer then
                UpdateVisuals_Timer:Cancel()
            end
            
            UpdateVisuals_Timer = C_Timer.NewTicker(0.1, function()
                if DGV.UpdateGuideVisualRows then
                    DGV.UpdateGuideVisualRows()
                    DGV:UpdateSmallFrame(nil, true)
                end
                UpdateVisuals_Timer:Cancel()
                UpdateVisuals_Timer = nil
            end)            
        end
        
		function DGV:GET_ITEM_INFO_RECEIVED(event, ...)
            DGV.Guides.UpdateVisuals()
		end	   
        
        function DGV:PLAYER_ENTERING_WORLD()
           DGV:UpdateAllSIDs(true)
		end
        
		function DGV:UpdateAllSIDs(reset)
			

---------------------------------
----------- WOW Classic:---------
--------------------------------- 		
--C_Scenario not present.  Todo: check if needed/find replacement 		
--[[

			local name, currentStage, numStages = C_Scenario.GetInfo()
			if not name then return end
		--	if ( currentStage and currentStage > numStages ) then --Dungeon Complete
		--		DGV:SetCompleteAllSID()
		--	else 		
			local _, _, numCriteria = C_Scenario.GetStepInfo()
			for crit=1, numCriteria do
				local _, _, criteriaCompleted, _, _, _, _, _, criteriaID = C_Scenario.GetCriteriaInfo(crit)

				DGV:SetCompletedSID(criteriaID, criteriaCompleted, reset)
			end
			local tblBonusSteps = C_Scenario.GetBonusSteps();
			for i = 1, #tblBonusSteps do
				local bonusStepIndex = tblBonusSteps[i];
				local _, _, numCriteria = C_Scenario.GetStepInfo(bonusStepIndex);
			  for criteriaIndex = 1, numCriteria do
					local _, _, criteriaCompleted, _, _, _, _, _, criteriaID = C_Scenario.GetCriteriaInfoByStep(bonusStepIndex, criteriaIndex)
					DGV:SetCompletedSID(criteriaID, criteriaCompleted, reset)
				end	
			end	
			local setcheck 

			for i = 1, lastUsedStepIndex do
				local guideStage = DGV:ReturnTag("STAGE", i)
				local qid = DGV:ReturnTag("QID", i)
				if guideStage == "" then 
					guidestage = nil 				
				end
				guideStage = tonumber(guideStage)
				if (guideStage and guideStage < currentStage) or (guideStage and currentStage == 0) then 
					DGV:SetChkToComplete(i)
					setcheck = true
				elseif guideStage and guideStage > currentStage and not qid then 
					DGV:SetChkToNotComplete(i)
					setcheck = true
				end
			end
			if setcheck then DGV:MoveToNextQuest() end

			]]
        end
        
        function DGV:SCENARIO_CRITERIA_UPDATE(eventName, criteriaId)
            DGV:UpdateAllSIDs()
		end

		--[[function DGV:SCENARIO_UPDATE()
            DGV:UpdateAllSIDs()
		end

        function DGV:SCENARIO_COMPLETED()
            DGV:UpdateAllSIDs()
		end--]] --don't really need these SCENARIO_CRITERIA_UPDATE takes care of it all.
        
		function DGV:UNIT_EXITED_VEHICLE()
			DebugPrint("###UNIT_EXITED_VEHICLE")
			self:MapCurrentObjective()
		end

		function DGV:UNIT_AURA()
			if DGV:ReturnTag("BUFF", DGU.CurrentQuestIndex) then
				local buff = DGV:ReturnTag("BUFF", DGU.CurrentQuestIndex)
				if EvaluateBUFF(buff) == true then
					DGV:SetChkToComplete(DGU.CurrentQuestIndex)
					DGV:MoveToNextQuest()
				end
			end
		end					
        
        
        --heading       Category name. It can be a table for example {"Starting Zones", "Forests", "Green Forests"} in this case "Starting Zones" is Level 1 category, "Forests" level 2 and "Green Forests" level 3 category
		--title: 		A string describing the zone and level range
		--nextguide: 	(Optional) The next guide to load when this guide is completed
		--faction:		Values: Horde, Alliance or nil means both factions
		--guidetype: 	Levling(L), Dailies(D) or Events(E) type of guide
		--rowinfo: 		Containins the actual guide data
		--tag: 			Guide options like |PZ|
		function DGV:RegisterGuide(heading, title, nextguide, faction, class, guidetype, tag, rowinfo, metadata)
			local myfaction = UnitFactionGroup("player") --No need to localize
			local myclass = select(2, UnitClass("player"))
			
			if class ~= nil then 
				if class ~= myclass then return end
			end
            
            local heading = heading
            local hedingL2 = nil
            local hedingL3 = nil
            
            if type(heading) == "table" then
                hedingL3 = heading[3]
                hedingL2 = heading[2]
                heading = heading[1]
            end
			
			if faction == myfaction or faction == nil then	
				--DebugPrint( "Title:"..title.."nextguide:"..nextguide.."faction:"..faction.."guidetype"..guidetype)
				
				self.guides[title] 	= rowinfo
				self.guidetags[title] 	= tag
				self.nextzones[title] 	= nextguide
				self.gtype[title] 	= guidetype
				self.headings[title] 	= heading
                
                if hedingL2 then
                    self.hedingsL2[title] = hedingL2
                end    
                
                if hedingL3 then
                    self.hedingsL3[title] = hedingL3
                end
                
                metadata = metadata or {}
                self.guidemetadata[title] = metadata
				
				--Save backwards lookup from display title to raw title
				local title1 = self:GetFormattedTitle(title, "Easy")
				local title2 = self:GetFormattedTitle(title, "Normal")
				local title3 = self:GetFormattedTitle(title, "Hard")
						

				if title1 then
					self.rawtitle[title1] = title
				end
				
				if title2 then
					self.rawtitle[title2] = title
				end
				
				if title3 then
					self.rawtitle[title3] = title
				end
				
				if guidetype == "L" then 			
					if not self.guidelist["L"] then self.guidelist["L"] ={} end
					table.insert(self.guidelist["L"], title)
				elseif guidetype == "I" then
					if not self.guidelist["I"] then self.guidelist["I"] ={} end
					table.insert(self.guidelist["I"], title)
				elseif guidetype == "D" then
					if not self.guidelist["D"] then self.guidelist["D"] ={} end
					table.insert(self.guidelist["D"], title)
				elseif guidetype == "E" then
					if not self.guidelist["E"] then self.guidelist["E"] ={} end
					table.insert(self.guidelist["E"], title)
				elseif guidetype == "A" then
					if not self.guidelist["A"] then self.guidelist["A"] ={} end
					table.insert(self.guidelist["A"], title)
				elseif guidetype == "Followers" then
					if not self.guidelist["Followers"] then self.guidelist["Followers"] ={} end
					table.insert(self.guidelist["Followers"], title)
				elseif guidetype == "Bosses" then
					if not self.guidelist["Bosses"] then self.guidelist["Bosses"] ={} end
					table.insert(self.guidelist["Bosses"], title)
				elseif guidetype == "NPC" then
					if not self.guidelist["NPC"] then self.guidelist["NPC"] ={} end
					table.insert(self.guidelist["NPC"], title)
				elseif guidetype == "Pets" then
					if not self.guidelist["Pets"] then self.guidelist["Pets"] ={} end
					table.insert(self.guidelist["Pets"], title)				
                elseif guidetype == "Mounts" then
					if not self.guidelist["Mounts"] then self.guidelist["Mounts"] ={} end
					table.insert(self.guidelist["Mounts"], title)
				elseif guidetype == "P" then
					if not self.guidelist["P"] then self.guidelist["P"] ={} end
					table.insert(self.guidelist["P"], title)
				end
			end
		end

		function DGV:GetUnfinishedGuideIndexByQID(qid)
			local i
			for i=1, lastUsedStepIndex do
				if DGV.qid[i] == qid and DGV:GetQuestState(i)~="C" then return i end
			end	
		end
	

		function DGV:ReturnTag(tag, i)
            if i == nil or i > lastUsedStepIndex then
                return 
            end
        
            local cacheTable = DGV.ReturnTag_cache[i]
            
            if cacheTable then
                local cacheVal = cacheTable[tag]
                if cacheVal then
                    return unpack(cacheVal)
                end
            else
                cacheTable = {}
                DGV.ReturnTag_cache[i] = cacheTable
            end
             
			i = i or DGU.CurrentQuestIndex
			local tags = DGV.tags[i]
			local questTitle = DGV.quests1L[i]
			
			if not tags then 
                cacheTable[tag] = {}
                return 
            end
			if tag == "O" then 
                
                local val = {tags:find("|O|")}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "MAP" then
				local map1, map2, map3, map4 = tags:match("|MAP|(%d+),?%s?(%d*),?%s?(%d*),?%s?(%d*)|")
				if map1 == "" then map1 = nil end
				if map2 == "" then map2 = nil end
				if map3 == "" then map3 = nil end
				if map4 == "" then map4 = nil end	
                local val = {map1, map2, map3, map4}
                cacheTable[tag] = val
                return unpack(val)            
			elseif tag == "PRE" then
				local pre1, pre2, pre3 = tags:match("|PRE|(%d+),?%s?(%d*)|")
				if pre1 == "" then pre1 = nil end
				if pre2 == "" then pre2 = nil end
				if pre3 == "" then pre3 = nil end
                local val = {pre1, pre2, pre3}
                cacheTable[tag] = val
                return unpack(val) 
			elseif tag == "PHA" then
                local val = {tags:match("|PHA|(%d+)")}
                cacheTable[tag] = val
                return unpack(val) 
			elseif tag == "OID" then
				local oid1, oid2, oid3, oid4 = tags:match("|OID|(%d+),?%s?(%d*),?%s?(%d*),?%s?(%d*)|")
				if oid1 == "" then oid1 = nil end
				if oid2 == "" then oid2 = nil end
				if oid3 == "" then oid3 = nil end
				if oid4 == "" then oid4 = nil end
	
                local val = {oid1, oid2, oid3, oid4}
                cacheTable[tag] = val
                return unpack(val) 			
			elseif tag == "AYG" then
                local val = {tags:match("|AYG|(%d+)")}
                cacheTable[tag] = val
                return unpack(val) 
			elseif tag == "TID" then
                local val = {tags:match("|TID|(%d+)")}
                cacheTable[tag] = val
                return unpack(val) 
			elseif tag == "REP" then
                local val = {tags:match("|REP|(%d+),%s*(%d)")	}
                cacheTable[tag] = val
                return unpack(val) 
			elseif tag == "FS" then
                local val = {tags:match("|FS|(%d+),%s*(%d+)")}
                cacheTable[tag] = val
                return unpack(val)  
			elseif tag == "REPR" then
                local val = {tags:match("|REPR|(%d+),%s*(%d+)")}
                cacheTable[tag] = val
                return unpack(val)  
			elseif tag == "QIDP" then
				local qidpart = tags:match("|QID|%d+%.(%d+)")
                local val = {qidpart}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "L" then
				local _, _, lootitem, lootqty = tags:find("|L|(%d+)%s?(%d*)|")
				lootqty = tonumber(lootqty) or 1
                local val = {lootitem, lootqty}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "CUR" then
				local _, _, curitem, curqty = tags:find("|CUR|(%d+)%s?(%d*)|")
				curqty = tonumber(curqty) or 1
				curitem = tonumber(curitem)
                local val = {curitem, curqty}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "P" then
				local categoryID, maxlevel = tags:match("|P|([^%s]*)%s?(%d*)|")
				local val = {categoryID, tonumber(maxlevel) or 1}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "PM" then
				local categoryID, maxlevel = tags:match("|PM|([^%s]*)%s?(%d*)|")
				local val = {categoryID, tonumber(maxlevel) or 1}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "OP" then
				local categoryID, professionlvl = tags:match("|OP|([^%s]*)%s?(%d*)|")
                local val = {categoryID, tonumber(professionlvl) or 1}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "PL" then
				local playerlvl = tags:match("|PL|(%d+)|")
                local val = {tonumber(playerlvl)}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "Z" then --ex: |Z|mapID mapFloor|
				local mapID, mapFloor = tags:match("|Z|(%d+)%s?(%d*)|")
                local val = {tonumber(mapID), tonumber(mapFloor)}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "F" then --ex: |F|mapID mapFloor|
				local mapID, mapFloor = tags:match("|F|(%d+)%s?(%d*)|")
                local val = {tonumber(mapID), tonumber(mapFloor)}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "NPC" then --ex: |NPC|37087| or |NPC|708, 704, 705|
				local npc1, npc2, npc3, npc4, npc5 = tags:match("|NPC|(%d+),?%s?(%d*),?%s?(%d*),?%s?(%d*),?%s?(%d*)|")
				if npc1 == "" then npc1 = nil end
				if npc2 == "" then npc2 = nil end
				if npc3 == "" then npc3 = nil end
				if npc4 == "" then npc4 = nil end
				if npc5 == "" then npc5 = nil end
                local val = {npc1, npc2, npc3, npc4, npc5}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "CHOICE" then --ex: |CHOICE|2|
				local id = tags:match("|CHOICE|(%d+)")
                local val = {id}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "OBJ" then --ex: |OBJ|37087| or |OBJ|708, 704, 705|
				local obj1, obj2, obj3, obj4, obj5 = tags:match("|OBJ|(%d+),?%s?(%d*),?%s?(%d*),?%s?(%d*),?%s?(%d*)|")
				if obj1 == "" then obj1 = nil end
				if obj2 == "" then obj2 = nil end
				if obj3 == "" then obj3 = nil end
				if obj4 == "" then obj4 = nil end
				if obj5 == "" then obj5 = nil end
 
                local val = {obj1, obj2, obj3, obj4, obj5}
                cacheTable[tag] = val
                return unpack(val)
			elseif tag == "S" then 
				if tags:match("|N|Speak ") or tags:match("|N|Talk ") or tags:match(" Speak ") or tags:match(" speak ") or tags:match(" Talk ") or tags:match(" talk ") or tags:match("|N|Parle") or tags:match("|N|Discuter") or tags:match(" Parle ") or tags:match(" parle ") or tags:match(" Discuter ") or tags:match(" discuter ") or questTitle:match("Speak") or questTitle:match("Parle") then
                    local val = {true}
                    cacheTable[tag] = val
                    return unpack(val)
				end
			elseif tag == "ST" then 
				if questTitle:match("Speak") or questTitle:match("Parle") then
                    local val = {true}
                    cacheTable[tag] = val
                    return unpack(val)
				end				
			elseif tag == "K" then 
				if (tags:match(" Kill ") or tags:match(" kill ") or tags:match("|N|Kill ") or tags:match("|N|kill ") or tags:match(" killing ") or tags:match(" en tuant ") or tags:match("Slay ") or tags:match("slay ") or tags:match("Defeat ") or tags:match("defeat ") or tags:match("ExÃƒÂ©cuter ") or tags:match("exÃƒÂ©cuter ") or tags:match("%) from ") or tags:match("%) sur ") or tags:match("drop") or tags:match("obtenu") or tags:match(" damage ") or tags:match("|N|Damage ") or tags:match(" attack ") or tags:match("|N|Attack ")) and tags:match("|NPC|") then
					if not (questTitle:match("%(item:") or questTitle:match("%[[^%]]+%]")) then
                        local val = {true}
                        cacheTable[tag] = val
                        return unpack(val)
					end
				end
			elseif tag == "T" then 
				if (tags:match("%(item:") or tags:match("%[[^%]]+%]") or tags:match("|T|")) and not tags:match("|U|") then 
                    local val = {true}
                    cacheTable[tag] = val
                    return unpack(val)
				end
			elseif tag == "RESET" then 
				if tags:match("|RESET|") then 
                    local val = {true}
                    cacheTable[tag] = val
                    return unpack(val)
				end					
			elseif tag == "STAGE" then
				local stage = tags:match("|SID|%d+%|(%d*)|")
                local val = {stage}
                cacheTable[tag] = val
                return unpack(val)
			end
            
            local val = {select(3, tags:find("|"..tag.."|([^|]*)|?"))}
            cacheTable[tag] = val
            return unpack(val)
		end

		function DGV:IterateGuideIndicesWithQID(qid, delegate)
			local i
			for i=1, lastUsedStepIndex do
				if DGV.qid[i] == qid then
					delegate(i)
				end
			end
		end
		
		function DGV.DeselectTopTabs()
			Main.homeTab:Enable();
			Main.homeTab:GetFontString():SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			Main.homeTab.selectedGlow:Hide();
			
			Main.currentGuideTab:Enable();
			Main.currentGuideTab:GetFontString():SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			Main.currentGuideTab.selectedGlow:Hide();
			
			Main.settingsTab:SetChecked(false)
		end
	end
	
	function Guides:OnModulesLoaded(threading)
		NPCJournalFrame = DGV.NPCJournalFrame
		DGV:InitializeTabs(threading)
		DGV:HideLargeWindow()	
		DGV:ShowViewTab()
		
		--Load saved guide
		if DGV:isValidGuide(CurrentTitle) == true  then
			DGV:DisplayViewTab(CurrentTitle, nil, threading, nil, true)
		else --Load Default 	
			DGV:ClearScreen()
			if DGV.chardb.FirstTime then
				DGV.chardb.FirstTime = false
				DGV:InitFramePositions()
				DGV:SuggestButtonOnClick(true, threading)			
			end		
		end
        
        if DGV.GuidesOnModulesLoadedExtension then
            DGV.GuidesOnModulesLoadedExtension()
        end
        
	end
	
	function Guides:Unload()
		DGV:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
		DGV:UnregisterEvent("UNIT_ENTERED_VEHICLE")
		DGV:UnregisterEvent("PLAYER_ENTERING_WORLD")
		DGV:UnregisterEvent("UNIT_EXITED_VEHICLE")
		DGV:UnregisterEvent("GOSSIP_CLOSED")
        DGV:UnregisterEvent("SCENARIO_UPDATE")
        DGV:UnregisterEvent("SCENARIO_CRITERIA_UPDATE")
        DGV:UnregisterEvent("SCENARIO_COMPLETED")    
        DGV:UnregisterEvent("UNIT_AURA")		    
		abandonQuestReaction:Dispose()
		for i = 1, #tabs do
			local j
			for j=1,math.huge,1 do

				local row=_G["DugisTab"..i.."Row"..j]
				if not row then break end
				--row:Hide()
			end
		end
		
		QuestLogFrameTrackButton_OnClick = DGV.NoOp
		DGV:HideLargeWindow()
		if DGV:UserSetting(DGV_UNLOADMODULES) then
			wipe(DGV.guides)
			DGV.guides = nil
			wipe(DGV.guidetags)
			DGV.guidetags = nil
			wipe(DGV.nextzones)
			DGV.nextzones = nil
			wipe(DGV.gtype)
			DGV.gtype = nil
			wipe(DGV.rawtitle)
			DGV.rawtitle = nil
			wipe(DGV.guidelist)
			DGV.guidelist = nil
			wipe(DGV.headings)
			DGV.headings = nil
                     
            wipe(DGV.hedingsL2)
			DGV.hedingsL2 = nil 
            wipe(DGV.hedingsL3)
			DGV.hedingsL3 = nil
		end
		
		--wipe(DGV.queryquests)
		--DGV.queryquests = nil
		wipe(DGV.actions)
		DGV.actions = nil
		wipe(DGV.quests1)
		DGV.quests1 = nil
		wipe(DGV.quests1L)
		DGV.quests1L = nil --localized quest list
		wipe(DGV.quests2)
		DGV.quests2 = nil
		wipe(DGV.useitem)
		DGV.useitem = nil
		wipe(DGV.qid)
		DGV.qid = nil
		wipe(DGV.daily)
		DGV.daily = nil
		wipe(DGV.MappedPoints)
		DGV.MappedPoints = nil
		wipe(DGV.tags)
		DGV.tags = nil
		wipe(DGV.coords)
		DGV.coords = nil
		wipe(DGV.postReqs)
		DGV.postReqs = nil
		wipe(DGV.breadCrumbs)
		DGV.breadCrumbs = nil
		wipe(DGV.visualRows)
		DGV.visualRows = nil
		visualRows = nil
	end
end
