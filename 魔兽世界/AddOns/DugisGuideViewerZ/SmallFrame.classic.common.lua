if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
local WATCHFRAME_INITIAL_OFFSET = 0;
local WATCHFRAME_TYPE_OFFSET = 10;
 
local WATCHFRAMELINES_FONTSPACING = 0;

local WATCHFRAME_SETLINES_NUMLINES = 5;  

local WATCHFRAME_ITEM_WIDTH = 33;
local OBJECTIVE_TRACKER_LINE_WIDTH = 248;
local OBJECTIVE_TRACKER_DASH_WIDTH = 10
local OBJECTIVE_TRACKER_TEXT_WIDTH = OBJECTIVE_TRACKER_LINE_WIDTH - OBJECTIVE_TRACKER_DASH_WIDTH - 12

local _


--//////////////////////////////////////////

local DGV = DugisGuideViewer
if not DGV then return end

local function spaceForSmallFrameHeader()
    if not DGV:UserSetting(DGV_SHOW_SMALL_FRAME_HEADER) then
        return 0
    else
        return 25
    end
end

local SmallFrame = DGV:RegisterModule("SmallFrame")--, "Guides")
DGV.SmallFrame = SmallFrame

--Table to keep information about tabs. 
-- { {guide = "", active = true, frame = {}, used = true, type = "P"}, {guide = "", active = false, frame = {}, used = true, type = "D"} }
SmallFrame.tabs = {}

if not DugisGuideUser.smallFrameTabs then
    DugisGuideUser.smallFrameTabs = {}
end

SmallFrame.Frame = CreateFrame("Frame", "DugisSmallFrameContainer", UIParent, "BackdropTemplate")
DugisSmallFrame = SmallFrame.Frame
DugisSmallFrame:SetFrameStrata("BACKGROUND")
DugisSmallFrame:SetFrameLevel(9)
SmallFrame.Frame:SetHeight(52)
SmallFrame.Frame:SetMovable(true)
SmallFrame.Frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -230)
--SmallFrame.Frame:SetClampedToScreen(true)
--The following is required to maintain positioning through guide states
SmallFrame.Frame:SetWidth(1)
SmallFrame.Frame:SetClampedToScreen(true)
SmallFrame.collapsed = false

---BKG
SmallFrame.SmallFrameBkg = CreateFrame("Frame", "SmallFrameBkg", UIParent, "BackdropTemplate")
SmallFrameBkg:SetFrameStrata("BACKGROUND")
SmallFrameBkg:SetFrameLevel(6)
SmallFrameBkg:SetWidth(52)
SmallFrameBkg:SetHeight(52)
SmallFrameBkg:SetPoint("CENTER", 0, 220)

local header = CreateFrame("Frame", "aaa", UIParent, "SmallFrameHeaderTemplate")
--header.module = DEFAULT_OBJECTIVE_TRACKER_MODULE;
header.isHeader = true;
header.Text:SetText("Guides");
--header.animateReason = OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED or 0;
header:SetFrameStrata("BACKGROUND")
header:SetFrameLevel(10)

if headerAnim == true then 
	header.animating = true;
	header.HeaderOpenAnim:Stop();
	header.HeaderOpenAnim:Play();
end 			

header:Show()

SmallFrame.header = header

--Objectives [v] header
SmallFrame.collapseHeader = CreateFrame("Frame", "SmallFrameCollapseHeader", UIParent, "HeaderMenuTemplate")
SmallFrame.collapseHeader:Show()
SmallFrame.collapseHeader:SetWidth(100)
SmallFrame.collapseHeader:SetHeight(20)
SmallFrame.collapseHeader.MinimizeButton:SetScript("OnClick", function()
	SmallFrame.collapsed = not SmallFrame.collapsed
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);

	if DGV.Modules.DugisWatchFrame then
		DGV.Modules.DugisWatchFrame:UpdateQuestsVisibility()
	end
end) 

local function UpdateSmallFrameMinimizer()
	local minimizer = SmallFrame.collapseHeader
	minimizer:ClearAllPoints()
	minimizer:SetPoint("TOPRIGHT", SmallFrame.Frame, "TOPRIGHT", -20, -10)
	 if SmallFrame.collapsed then
        minimizer.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.5)
		minimizer.MinimizeButton:GetPushedTexture():SetTexCoord(0.5, 1, 0, 0.5)  
		SmallFrame.collapseHeader.Title:SetText("Objectives")      
	else
        minimizer.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0.5, 1)
		minimizer.MinimizeButton:GetPushedTexture():SetTexCoord(0.5, 1, 0.5, 1)    
		SmallFrame.collapseHeader.Title:SetText("")
	end  
	
	if DGV:IsSmallFrameFloating() then
		minimizer.MinimizeButton:SetPoint("TOPRIGHT", 0, -4)
	else
		minimizer.MinimizeButton:SetPoint("TOPRIGHT", 0 + DGV.ExtraSpaceForPOIsButtons(), -4)
	end
end

SmallFrame.collapseHeader:HookScript("OnMouseDown", function()
	SmallFrame.OnDragStart()
end)

SmallFrame.collapseHeader:HookScript("OnMouseUp", function()
	SmallFrame.OnDragStop()
end)

------------- OBJECTIVE FRAME BACKGROUND ----------------
SmallFrame.OnFrameUpdate = function()
	--SmallFrame background position
	SmallFrameBkg:ClearAllPoints()
	SmallFrameBkg:SetPoint("TOPLEFT", SmallFrame.Frame, "TOPLEFT", -10,  0) 

	header:ClearAllPoints()
	header:SetPoint("TOPLEFT", SmallFrame.Frame, "TOPLEFT", 18,  -12)
	if SmallFrame.UpdateProgressBarPosition then
		SmallFrame.UpdateProgressBarPosition() 
	end

	if DGV:UserSetting(DGV_SHOW_SMALL_FRAME_HEADER) and not SmallFrame.collapsed  then
		header:Show()
	else
		header:Hide()
	end

	if  UnitAffectingCombat("player") then
		return
	end
	
	if SmallFrame.collapsed then
		SmallFrame.Frame:Hide()
	else
		SmallFrame.Frame:Show()
	end

	--SmallFrame background visibility
	if DGV:UserSetting(DGV_SMALLFRAMEBORDER) and not SmallFrame.collapsed then
		SmallFrameBkg:Show()
	else
		SmallFrameBkg:Hide()
	end

	--SmallFrame background size
	local SmallFrameBkgHeight = SmallFrame.Frame:GetHeight() + 8
	if DGV:IsSmallFrameAnchored() then
		if GetWorldQuestRealHeight then
			if WatchFrame.collapsed then
				SmallFrameBkgHeight = SmallFrameBkgHeight + GetWorldQuestRealHeight() + 25
			else
				SmallFrameBkgHeight = SmallFrameBkgHeight + GetWorldQuestRealHeight() - 2
			end
		end

		SmallFrameBkg:SetSize(300 + DGV.ExtraSpaceForPOIsButtons(), SmallFrameBkgHeight)
	else
		SmallFrameBkg:SetSize(300, SmallFrameBkgHeight)
	end

	
	UpdateSmallFrameMinimizer()

	--Hidding small frame
	if not DugisGuideViewer:IsGoldMode() then
		SmallFrameBkg:Hide()
		SmallFrame.Frame:Hide()
		header:Hide()
		SmallFrame.collapseHeader:Hide()
	end

	if not IsMouseButtonDown("LeftButton") and SmallFrame.OnDragStop then
		SmallFrame:OnDragStop()
	end

	SmallFrame:UpdateMovables()
	SmallFrame:RestoreOriginalObjectiveTrackerPosition()
end

function SmallFrame:RestoreOriginalObjectiveTrackerPosition()
	if DGV:IsSmallFrameAnchored() and not DugisGuideViewer:UserSetting(DGV_MOVEWATCHFRAME) then
		DugisSmallFrameContainer:ClearAllPoints()
		local extraSpace = DGV.ExtraSpaceForPOIsButtons()
		if DugisGuideViewer:UserSetting(DGV_SMALL_FRAME_EXTEND_UP) then
			local h = DugisSmallFrameContainer:GetHeight() - SmallFrameBkg:GetHeight()
			DugisSmallFrameContainer:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -CONTAINER_OFFSET_X - extraSpace, 120 - h)
		else
			local durabilityFrameDY = (DurabilityFrame and DurabilityFrame:IsShown()) and -56 or 0
			DugisSmallFrameContainer:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - extraSpace, -10 + durabilityFrameDY)
		end
	end
end

function SmallFrame:UpdateMovables()
	local smallFrameMovable = true
	SmallFrame.Frame:EnableMouse(smallFrameMovable)
	SmallFrame.collapseHeader:EnableMouse(smallFrameMovable)
	SmallFrameBkg:EnableMouse(smallFrameMovable)
	DugisSmallFrameContainer:EnableMouse(smallFrameMovable)
	if DugisSmallFrameStatus1 then
		DugisSmallFrameStatus1:EnableMouse(smallFrameMovable)
	end		
end

DGV.shouldUpdateObjectiveTracker = false

--sizing constants
local FLOATING_CONTAINER_TOP_PADDING = 24
local FLOATING_CONTAINER_BOTTOM_PADDING = 15
local FLOATING_STATUS_FRAME_TEXT_DESC_PADDING = 7
local FLOATING_STATUS_FRAME_DESC_OBJECTIVES_PADDING = 3
local ANCHORED_CONTAINER_TOP_PADDING = 10
local ANCHORED_CONTAINER_BOTTOM_PADDING = -2
local ANCHORED_STATUS_FRAME_TEXT_DESC_PADDING = 7
local ANCHORED_STATUS_FRAME_DESC_OBJECTIVES_PADDING = 3

local DBMUpdate


local function GetTooltipMaxWidth()
	local maxW = 0
	for i = 1, 40 do
		local line = _G["GameTooltipTextLeft"..i]
		if line then
			local w = line:GetWidth()
			if w > maxW then
				maxW = w
			end
		end
	end
	return maxW
end

function SmallFrame:SetupAutoGuidePOIButton(questId, parent, x, y)
	self.POIButtons = self.POIButtons or {}

	local autoGuidePOIButton = GUIUtils:GetTaskPOI(1, self.POIButtons, parent or UIParent)

	autoGuidePOIButton.Texture:SetDrawLayer("OVERLAY")
	
	local _, _, worldQuestType, rarity, isElite, tradeskillLineIndex = GetQuestTagInfo(questId)
	
	QuestUtil.SetupWorldQuestButton(autoGuidePOIButton, worldQuestType, rarity, isElite, tradeskillLineIndex, false, selected, isCriteria, isSpellTarget)
	C_TaskQuest.RequestPreloadRewardData(questId)

	autoGuidePOIButton:SetParent(parent or UIParent)
	autoGuidePOIButton:SetPoint("TOPLEFT", parent or UIParent, x or 280, y or -240)
	autoGuidePOIButton:SetSize(24, 24)

	parent = parent:GetParent()
	parent:SetScript("OnEnter", function()
		local questLogIndex = GetQuestLogIndexByID(questId);
		local title = GetQuestLogTitle(questLogIndex);

		GameTooltip:SetOwner(autoGuidePOIButton, "ANCHOR_PRESERVE");

		GameTooltip:ClearAllPoints();
		GameTooltip:ClearLines();
		GameTooltip:SetPoint("TOPRIGHT", autoGuidePOIButton, "TOPLEFT", 0, 0);
	
		if ( not HaveQuestData(questId) ) then
			GameTooltip:AddLine(RETRIEVING_DATA, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		else
			local isWorldQuest = true;
			if ( isWorldQuest ) then
				QuestUtils_AddQuestTypeToTooltip(GameTooltip, questId, NORMAL_FONT_COLOR);
				GameTooltip:AddLine(REWARDS, NORMAL_FONT_COLOR:GetRGB());
			else
				GameTooltip:SetText(REWARDS, NORMAL_FONT_COLOR:GetRGB());
			end
			GameTooltip:AddLine(isWorldQuest and WORLD_QUEST_TOOLTIP_DESCRIPTION or BONUS_OBJECTIVE_TOOLTIP_DESCRIPTION, 1, 1, 1, 1);
			GameTooltip_AddBlankLinesToTooltip(GameTooltip, 1);

			QuestUtils_AddQuestRewardsToTooltip(GameTooltip, questId, TOOLTIP_QUEST_REWARDS_STYLE_NONE);

			if GameTooltip.ItemTooltip and GameTooltip.ItemTooltip:IsShown()   then
				GameTooltip_AddBlankLinesToTooltip(GameTooltip, 3);
			end
		end

		GameTooltip:Show()

		local maxW = GetTooltipMaxWidth()
		if GameTooltip.ItemTooltip and GameTooltip.ItemTooltip:IsShown()   then
			GameTooltip:SetWidth(GameTooltip.ItemTooltip.Tooltip:GetWidth() + 54)
		else
			GameTooltip:SetWidth(maxW + 10)
		end
		
		if SmallFrame.stepOriginalOnEnter then
			SmallFrame.stepOriginalOnEnter(parent)
		end
	end)

	parent:SetScript("OnLeave", function()
		GameTooltip:Hide()
		if SmallFrame.stepOriginalOnLeave then
			SmallFrame.stepOriginalOnLeave(parent)
		end
	end)

	autoGuidePOIButton.questID = questId
	self.autoGuidePOIButton = autoGuidePOIButton
end

function SmallFrame:Initialize()
	if SmallFrame.initialized then return end
	SmallFrame.initialized = true

    if ElvUI then
        local ElvUI_ = unpack(ElvUI);
        hooksecurefunc(ElvUI_, "UpdateFontTemplates", function()
            DugisGuideViewer.Modules.DugisWatchFrame.OnFrameUpdate()
        end)
    end	
			
	local L = DugisLocals

	local flashGroup, flash
    
	local function IsTooltipEmbedded()
		return DGV:UserSetting(DGV_EMBEDDEDTOOLTIP)
	end
	
	local function IsFixedWidth()
		return DGV:UserSetting(DGV_FIXEDWIDTHSMALL)
	end
	
	local function ShowObjectives()
		return DGV:UserSetting(DGV_OBJECTIVECOUNTER)
	end
	
	local function MultistepMode()
		return DGV:UserSetting(DGV_MULTISTEPMODE)
	end
	
	local statusFrames = UIFrameCache:New("FRAME", "DugisSmallFrameStatus", SmallFrame.Frame, "DugisSmallFrameTemplate")
	function SmallFrame.IterateActiveStatusFrames(invariant, control)
		return next(statusFrames.usedFrames, control)
	end
	
	local function ClearAllStatusFrames()
		while #statusFrames.usedFrames>0 do
			local frame = tremove(statusFrames.usedFrames)
			tinsert(statusFrames.frames, 1, frame)
			frame:Hide()
			if frame.ItemButton then  
				DGV.DoOutOfCombat(function()
					frame.ItemButton.Hide(frame.ItemButton)
				end)
			end					
		end
	end
	
	local function StatusFrame_InitPoints(frame)
		frame:ClearAllPoints()
		local index = #statusFrames.usedFrames
		if index==1 then
				frame:SetPoint("TOPLEFT", 0, -FLOATING_CONTAINER_TOP_PADDING - spaceForSmallFrameHeader()  )
		else
			frame:SetPoint("TOPLEFT", statusFrames.usedFrames[index-1], "BOTTOMLEFT", 0, -10)
		end
	end
	
	local function StatusFrame_GetCreate()
		local frame = statusFrames:GetFrame()
		frame:SetParent(SmallFrame.Frame)
		if not frame.objectiveLines then
			frame.objectiveLines = UIFrameCache:New("FRAME", frame:GetName().."ObjectiveLine", frame.Objectives, "SmallFrameLineTemplate")
			frame:RegisterForDrag("LeftButton")
			frame:HookScript("OnDragStart", SmallFrame.OnDragStart)
			frame:HookScript("OnDragStop", SmallFrame.OnDragStop)
		end
		frame:Show()
		frame:SetFrameLevel(10)
		StatusFrame_InitPoints(frame)
		return frame
	end
	
	local function StatusFrame_ClearAllObjectiveLines(frame)
		while #frame.objectiveLines.usedFrames>0 do
			local line = tremove(frame.objectiveLines.usedFrames)
			tinsert(frame.objectiveLines.frames, line)
			line:Hide()
		end
		if frame.ItemButton then 
			DGV.DoOutOfCombat(function()
				frame.ItemButton.Hide(frame.ItemButton)
			end)
		end		
	end
	
	local function StatusFrame_Reset(frame)
		frame:Hide()
		frame.guideIndex = nil
		StatusFrame_ClearAllObjectiveLines(frame)
	end
	
	function StatusFrame_GetNonTextWidth(frame)
		local _, _, _, xOfs, yOfs = frame.Text:GetPoint(2)
		local modelButtonWidth
		
		if (frame.guideIndex == DugisGuideUser.CurrentQuestIndex) and DGV:HasModel(frame.guideIndex ) then modelButtonWidth = frame.ModelButton:GetWidth( ) + 9 else modelButtonWidth = 7 end
		return xOfs + modelButtonWidth
	end
	
	function StatusFrame_GetSmartWidth(frame)
		local _, _, _, xOfs, yOfs = frame.Chk:GetPoint()
		local modelButtonWidth
		frame:SetHeight(1000)
		frame:SetWidth(1000)
		if (frame.guideIndex == DugisGuideUser.CurrentQuestIndex) and DGV:HasModel(frame.guideIndex) then modelButtonWidth = frame.ModelButton:GetWidth( ) else modelButtonWidth = 7 end
		local textWidth = frame.Text:GetStringWidth() + 13
		local descWidth = math.min(frame.Desc:GetStringWidth() + 26, 300)
		local width = textWidth + frame.Waypoint:GetWidth() + frame.Icon:GetWidth() + frame.Chk:GetWidth() + modelButtonWidth + xOfs
		return math.max(width, descWidth), textWidth
	end

	local function StatusFrame_GetDesiredWidth(frame)
		local width
		if not DGV:IsSmallFrameFloating() then
			width = SmallFrame.Frame:GetWidth() - 12
		elseif IsFixedWidth() then
			width = OBJECTIVE_TRACKER_LINE_WIDTH + 40
		else
			return StatusFrame_GetSmartWidth(frame)
		end
		return width, width
	end
	
	local function StatusFrame_GetObjectivesHeight(frame)
		local count = 0
		for _,line in ipairs(frame.objectiveLines.usedFrames) do
			count = count + line:GetHeight()
		end
		if count>0 and frame.ItemButton then
			return math.max(count, (WATCHFRAME_ITEM_WIDTH-5))
		elseif count>0 then 
			return math.max(count, 15) --mininum objective height
		else
			return count
		end
	end
	
	local function StatusFrame_MeasureHeight(frame)
		if not DGV:IsSmallFrameFloating() then
			local hasObjectives = #frame.objectiveLines.usedFrames>0
            local height = frame.Text:GetStringHeight() +
				(IsTooltipEmbedded() and ANCHORED_STATUS_FRAME_TEXT_DESC_PADDING or 2) +
				frame.Desc:GetStringHeight() +
				(hasObjectives and ANCHORED_STATUS_FRAME_DESC_OBJECTIVES_PADDING or 0) +
				StatusFrame_GetObjectivesHeight(frame)
            
            local extraHeight = 0
            
            if not IsTooltipEmbedded() and not ShowObjectives() then
                extraHeight = 10
            end
			
			return height + extraHeight
		else
			local hasObjectives = #frame.objectiveLines.usedFrames>0
            local height = frame.Text:GetStringHeight() +
				(IsTooltipEmbedded() and FLOATING_STATUS_FRAME_TEXT_DESC_PADDING or 2) +
				frame.Desc:GetStringHeight() +
				(hasObjectives and FLOATING_STATUS_FRAME_DESC_OBJECTIVES_PADDING or 0) +
				StatusFrame_GetObjectivesHeight(frame)
				
			return height
				
		end
	end
	
	local function StatusFrame_GetCreateObjectiveLine (frame)
		local line = frame.objectiveLines:GetFrame()
		--line:Reset()
		line:Show()
		line:ClearAllPoints()
		return line
	end
	
	local function StatusFrame_SetCurrentWidth(frame, frameWidth, textWidth)
		frame:SetWidth(frameWidth)
		if textWidth then
			frame.Text:SetWidth(textWidth)
			frame.Objectives:SetWidth(frame.Objectives:GetWidth())
			frame.Desc:SetWidth(frame.Desc:GetWidth()) --so GetStringHeight works properly
			if frame.DescEventHandler then
				frame.DescEventHandler:SetWidth(frame.Desc:GetWidth()) --so GetStringHeight works properly
			end
		end
	end
	

	local function UpdateFontSize(frame)
	end
	
	
	local function StatusFrame_Layout(frame)
		if not DGV:IsSmallFrameFloating() then
			--setcharacteristics
			frame.Text:SetMaxLines(3)
			frame.Text:SetWordWrap(true)
			frame.Text:SetNonSpaceWrap(true)


		 
			UpdateFontSize(frame)

			--get desired width
			local frameW, textW  = StatusFrame_GetDesiredWidth(frame)
			
			--set desired width
			StatusFrame_SetCurrentWidth(frame, frameW, textW )

			--set padding values
			frame.Desc:SetPoint("TOP", frame.Text, "BOTTOM", 0, -ANCHORED_STATUS_FRAME_TEXT_DESC_PADDING)
			frame.DescEventHandler:SetPoint("TOP", frame.Text, "BOTTOM", 0, -ANCHORED_STATUS_FRAME_TEXT_DESC_PADDING)
			
			--measure height
			--set height
			frame:SetHeight(StatusFrame_MeasureHeight(frame))
		else
			if IsFixedWidth() then
				--setcharacteristics
				frame.Text:SetMaxLines(2)
				frame.Text:SetWordWrap(true)
				frame.Text:SetNonSpaceWrap(true)
				
				--get desired width
				local frameW, textW = StatusFrame_GetDesiredWidth(frame)
				
				--set desired width
				StatusFrame_SetCurrentWidth(frame, frameW, textW )
			else
				--setcharacteristics
				frame.Text:SetMaxLines(0)
				frame.Text:SetWordWrap(false)
				frame.Text:SetNonSpaceWrap(false)
				
				--get desired width
				StatusFrame_SetCurrentWidth(frame, StatusFrame_GetDesiredWidth(frame))
			end
			
			--set padding values
			frame.Desc:SetPoint("TOP", frame.Text, "BOTTOM", 0, -FLOATING_STATUS_FRAME_TEXT_DESC_PADDING)
			frame.DescEventHandler:SetPoint("TOP", frame.Text, "BOTTOM", 0, -FLOATING_STATUS_FRAME_TEXT_DESC_PADDING)
			
			--measure height
			--set height
			frame:SetHeight(StatusFrame_MeasureHeight(frame))
		end
		
		frame.Desc:SetJustifyH("LEFT")
		frame.DescEventHandler:SetJustifyH("LEFT")
		
	end
	
	function SmallFrame.StatusFrame_GetDescriptionText(guideIndex)
        local descriptionText = DGV:GetQuestStepText(guideIndex) 
        
        --Removed lua error
		if not descriptionText then
			return "", ""
		end
		
        local rawText = descriptionText
		
		if descriptionText and not string.match(descriptionText, "|Hitem") and string.match(descriptionText, "item:%d") then --ReplaceSpecialTags for items if it didn't get converted yet on load. 
			if DGV.NPCJournalFrame then 
				descriptionText = DGV.NPCJournalFrame:ReplaceSpecialTags(descriptionText, true)
			end
		end
		
		return descriptionText, rawText
	end

	local function SetTextColorAndIntensity(fontString, color, highlight, forceDim)
		fontString:SetTextColor(color.r, color.g, color.b)
		if highlight or (not DGV:UserSetting(DGV_HIGHLIGHTSTEPONENTER) and not forceDim) then
			fontString:SetAlpha(1)
		else
			fontString:SetAlpha(0.8)
		end
	end	
	
	local function SetTextColors(frame, onEnter)
		local guideIndex = frame.guideIndex
		if not DGV.actions then
			return
		end
		if guideIndex and DGV.actions[guideIndex] then
			local level = DGV:GetQuestLevel(DGV.qid[guideIndex])
			local questpart = DGV:ReturnTag("QIDP", guideIndex)
			if IsTooltipEmbedded() then
				SetTextColorAndIntensity(frame.Desc, HIGHLIGHT_FONT_COLOR, onEnter)
			end
			local color  = DGV:GetQuestDiffColor(guideIndex)

			if not (
			(strmatch(DGV.actions[guideIndex], "[ACT]") and color and DGV:UserSetting(DGV_QUESTCOLORON)) or (questpart and color and strmatch(DGV.actions[guideIndex], "[NK]") and DGV:UserSetting(DGV_QUESTCOLORON)) 	--set difficulty color on A/C/T actions
			)	
			then
				color = NORMAL_FONT_COLOR
			end
			SetTextColorAndIntensity(frame.Text, color, onEnter)
			if frame.objectiveLines and frame.objectiveLines.usedFrames then
				for _, line in ipairs(frame.objectiveLines.usedFrames) do
					SetTextColorAndIntensity(line.Text, HIGHLIGHT_FONT_COLOR, onEnter, true)
				end
			end
		else 
			SetTextColorAndIntensity(frame.Text, NORMAL_FONT_COLOR, onEnter)
		end
	end
	
	local function SetPointAbsolute(region, point, relativeRegion, relativeRegionAbsoluteX, relativeRegionAbsoluteY, offsetX, offsetY)
		local absoluteY = relativeRegionAbsoluteY and relativeRegionAbsoluteY + offsetY
		local absoluteX = relativeRegionAbsoluteX and relativeRegionAbsoluteX + offsetX
		region:ClearAllPoints()
		region:SetScale(relativeRegion:GetEffectiveScale())
		if DGV:IsSmallFrameFloating() then
			region:SetPoint(point, UIParent, "BOTTOMLEFT", absoluteX - 4, absoluteY)
		else
			region:SetPoint(point, UIParent, "BOTTOMLEFT", absoluteX, absoluteY)
		end
		region:SetFrameStrata(relativeRegion:GetFrameStrata())
		region:SetFrameLevel(relativeRegion:GetFrameLevel())
	end
	
	local function MoveItemButtonPredicate(reaction, frame)
		local val = frame:IsShown() and frame.ItemButton and frame.ItemButton:IsShown()
		if not val then
			reaction:Dispose()
			frame.moveItemButtonReaction = nil
			return
		end
		return true
	end
	
	local function MoveItemButton(reaction, frame)
		if InCombatLockdown() then return end
		SetPointAbsolute(frame.ItemButton, "TOPRIGHT", frame.Objectives, frame.Objectives:GetRight(), frame.Objectives:GetTop(), 10, -2)
	end

	local function SetActionButtonAttributes(button, useitem)
		local item, texture = useitem, useitem and GetItemIcon(useitem)
		if texture then
			if not button.texture then
				button.texture = button:CreateTexture(nil, "ARTWORK")
				button.texture:SetWidth(28) 
				button.texture:SetHeight(28)
				button.texture:SetAllPoints(button)
			end
			button.texture:SetTexture(texture)
			button:SetAttribute("type1", "item")
			button:SetAttribute("item1", "item:"..item)
			button:Show()
		else
			button:SetAttribute("item1", nil)
			button:Hide()
		end
	end
	
	local function SetObjectiveItem(frame, item)
		local itemButton = frame.ItemButton
		if ( not itemButton ) then
			itemButton = CreateFrame("BUTTON", frame:GetName().."Item", nil, "DugisSecureQuestButtonTemplate");
		end
		
		DGV.DoOutOfCombat(function()
			SetActionButtonAttributes(itemButton, item)	
		end)
		
		if not frame.moveItemButtonReaction then
			frame.moveItemButtonReaction = DGV.RegisterStopwatchReaction(.1, MoveItemButtonPredicate, MoveItemButton, frame)
		end
		frame.ItemButton = itemButton;
		
		DGV.DoOutOfCombat(function()
			itemButton:Show()
		end)
	end
	
    local objectiveProgressBars = {}
	function SmallFrame.GetQuestName(stepIndex)
		local qName = DGV.quests1L[stepIndex]
		qName = DGV.NPCJournalFrame:ReplaceSpecialTags(qName, true, stepIndex, true)

		return qName
	end
       
	local function StatusFrame_Populate(frame, stepIndex)
		local item = DGV.useitem[stepIndex]
		frame.guideIndex = stepIndex
		frame.guestStepIndex = stepIndex
		frame.Chk:SetChecked(false)
		if stepIndex and DGV.actions[stepIndex] then
            local questId = DGV.qid[stepIndex]
            local eqids = DGV.eqids[stepIndex]
            
            local allQuestContions = {}
            
            --Making so objectives from extra quests can be displayed. 
            if eqids then
                for _, questId in pairs(LuaUtils:split(eqids, " ")) do
                    if tonumber(questId) then
                        allQuestContions[#allQuestContions + 1] = {questId = tonumber(questId)} 
                    end
                end
            end
            
			local level = DGV:GetQuestLevel(questId)
			local qName = DGV.quests1L[stepIndex]
			local questpart = DGV:ReturnTag("QIDP", stepIndex)
			
			if (level and level > 0 and strmatch(DGV.actions[stepIndex], "[ACT]") and DGV:UserSetting(DGV_QUESTLEVELON)) or (level and level > 0 and questpart and strmatch(DGV.actions[stepIndex], "[NK]") and DGV:UserSetting(DGV_QUESTLEVELON)) then qName = "["..level.."] "..qName end

			qName = SmallFrame.GetQuestName(stepIndex)
			
			frame.Icon:SetNormalTexture(DGV:getIcon(DGV.actions[stepIndex], stepIndex))	
		
			frame.Icon:SetSize(22, 22)
			frame.Icon:SetPoint("RIGHT", frame.Text, "LEFT", -2.5, 0)

			frame.Text:SetText(qName)
			frame.Text:SetPoint("LEFT", 65, 0)
			if IsTooltipEmbedded() then
                local text, rawText = SmallFrame.StatusFrame_GetDescriptionText(frame.guideIndex)
                
				frame.Desc:SetText(text)
                frame.Desc.rawText = rawText
				frame.DescEventHandler:SetText(text)
                frame.DescEventHandler:SetTextColor(1, 0, 0)
                frame.DescEventHandler:SetAlpha(0)
				frame.Desc:Show()		
				frame.DescEventHandler:Show()           
			else
				frame.Desc:SetText("")
				frame.DescEventHandler:SetText("")
				frame.Desc:Hide()
				frame.DescEventHandler:Hide()
			end
            
            if not frame.Desc.isHtml then
                frame.Desc:Hide()
                frame.DescEventHandler:Hide()
            end
            
            if frame.htmlDesc == nil then
                frame.htmlDesc = CreateFrame("SimpleHTML",nil, frame)
                
                frame.htmlDesc:EnableMouse(false)  
                frame.htmlDesc:SetHyperlinksEnabled(false) 

                frame.htmlDesc:SetFontObject(frame.Desc:GetFontObject())
                frame.htmlDesc:SetWidth(222)
                frame.htmlDesc:SetHeight(50)
  
                local text = frame.Desc:GetText()
                
                if text == nil then
                    text = ""
                end
                
                frame.htmlDesc:SetText('<html><body><p align="left">'..text..'<br/><br/></p></body></html>')     
                frame.htmlDesc.rawText = frame.Desc.rawText
                frame.htmlDesc:Show()   

                frame.htmlDesc:SetScript("OnHyperlinkClick", DugisGuideViewer.NPCJournalFrame.OnHyperlinkClick) 
                frame.htmlDesc:SetScript("OnHyperlinkEnter", function(self, linkData, link, button)
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkEnter(self, linkData, link, button, true)
                end) 
                frame.htmlDesc:SetScript("OnHyperlinkLeave", DugisGuideViewer.NPCJournalFrame.OnHyperlinkLeave) 
                
                frame.htmlDescEventHandler = CreateFrame("SimpleHTML",nil, frame)

                frame.htmlDescEventHandler:SetFontObject(frame.Desc:GetFontObject())
                frame.htmlDescEventHandler:SetWidth(222)
                frame.htmlDescEventHandler:SetHeight(50)
                
                local text = frame.Desc:GetText()
                
                if text == nil then
                    text = ""
                end
                
                frame.htmlDescEventHandler:SetText('<html><body><p align="left">'..text..'<br/><br/></p></body></html>')     
                frame.htmlDescEventHandler:Show()   

				frame.htmlDescEventHandler:SetScript("OnHyperlinkClick", function(...)
					local _, _, _, button = ...
					if button == "RightButton" then
						SmallFrame:OnClick(frame, button)
					else
						DugisGuideViewer.NPCJournalFrame.OnHyperlinkClick(...)
					end
                end) 
                
				frame.htmlDescEventHandler:SetScript("OnHyperlinkEnter", function(self, linkData, link, button)
				
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkEnter(self, linkData, link, button, true)
                    UpdateSmallFrameBlocksContent()
                end)     
                
                frame.htmlDescEventHandler:SetScript("OnHyperlinkLeave", function(...)
                    DugisGuideViewer.NPCJournalFrame.OnHyperlinkLeave(...)
                    UpdateSmallFrameBlocksContent()
                end) 
                
                frame.DescEventHandler = frame.htmlDescEventHandler
                frame.DescEventHandler.isHtml = true
                
                frame.Desc = frame.htmlDesc
                frame.Desc.isHtml = true
                
                frame.Desc.GetStringHeight = function()
                    local height = frame.htmlDesc:GetContentHeight()
                    if height ~= nil and height < 10 then
                        height = 10
                    end					
                    return height
                end
                
                frame.Desc.GetStringWidth = function()
                    return frame.htmlDesc:GetWidth()
                end                
             end
			 
			frame.htmlDesc:ClearAllPoints()
			frame.htmlDesc:SetPoint("LEFT", frame, "LEFT", 16, 0)    
			frame.htmlDesc:SetPoint("TOP", frame.Text, "BOTTOM", 0, -8)    
			frame.htmlDesc:SetPoint("RIGHT", frame, "RIGHT", -16, 0)  
			
			frame.htmlDescEventHandler:ClearAllPoints()
			frame.htmlDescEventHandler:SetPoint("LEFT", frame, "LEFT", 16, 0)    
			frame.htmlDescEventHandler:SetPoint("TOP", frame.Text, "BOTTOM", 0, -8)    
			frame.htmlDescEventHandler:SetPoint("RIGHT", frame, "RIGHT", -16, 0)  
			 
			
			local havePOIwaypoint
			local hasDMAPtag = DGV:ReturnTag("DMAP", stepIndex)
			
			if DGV:ReturnTag("POI", stepIndex) and questId then 
				local _, posX, posY, objective = QuestPOIGetIconInfo(questId)
				if posX then 
					havePOIwaypoint = true
				end
			end
			
			if (DGV:HasCoord(stepIndex) or havePOIwaypoint or hasDMAPtag) and DGV:UserSetting(DGV_SHOW_EXTRA_WAYPOINT_ICON) then 
				frame.Waypoint:Enable()
				frame.Waypoint:Show()
				frame.Text:SetPoint("LEFT", 65, 0)
				frame.Chk:SetPoint("RIGHT", frame.Waypoint, "LEFT", 5, 0)				
			else 
				frame.Waypoint:Disable() 
				frame.Waypoint:Hide()
				frame.Text:SetPoint("LEFT", 51, 0)
				frame.Chk:SetPoint("RIGHT", frame.Icon, "LEFT", 0, 0)
			end
			if (stepIndex == DugisGuideUser.CurrentQuestIndex) and DGV:HasModel(stepIndex) then frame.ModelButton:Show() else frame.ModelButton:Hide() end
			if DGV:ReturnTag("NT", stepIndex)  then 
				frame.Chk:Disable()
				frame.Chk:Hide()
			else 
				frame.Chk:Enable()
				frame.Chk:Show()
			end

			if CurrentTitle == DGV.questAutoGuideName and stepIndex == 2 then
				SmallFrame.stepOriginalOnEnter = SmallFrame.stepOriginalOnEnter or frame:GetScript("OnEnter")
				SmallFrame.stepOriginalOnLeave = SmallFrame.stepOriginalOnLeave or frame:GetScript("OnLeave")
				SmallFrame:SetupAutoGuidePOIButton(questId, frame.Icon, -10, 0, function()
					DGV.DugisArrow:QuestPOIWaypoint(self.autoGuidePOIButton, true)
				end)
				self.autoGuidePOIButton:Show()
				frame.Icon:SetNormalTexture(nil)
			else
				if self.autoGuidePOIButton then
					self.autoGuidePOIButton:Hide()
				end
				if SmallFrame.stepOriginalOnEnter then
					frame:SetScript("OnEnter", SmallFrame.stepOriginalOnEnter)
					frame:SetScript("OnLeave", SmallFrame.stepOriginalOnLeave)
				end
			end
		
			SetTextColors(frame)
			
			StatusFrame_ClearAllObjectiveLines(frame)
			local lastLine
            
         
            -----OBJECTIVES-----
			if questId 
            and ShowObjectives() 
            and strmatch(DGV.actions[stepIndex], "[CNKT]") 
            and not DGV:ReturnTag("V", stepIndex)
            and (DGV:getIcon(DGV.actions[stepIndex], stepIndex) ~= "Interface\\Minimap\\TRACKING\\Profession" or DGV:ReturnTag("AYG", stepIndex)) 
            and not DugisGuideUser.shownObjectives[questId] then
            
				DugisGuideUser.shownObjectives[questId] = true -- prevents repeat display of the same objectives
                
				if strmatch(DGV.actions[stepIndex], "[CNK]") then
					
                    table.insert(allQuestContions, 1, {
                        isMain = true,
                        questId = questId
                    })
                    
                    --Filling in allQuestContions table
                    for _, questContion in pairs(allQuestContions) do
                        local questId = questContion["questId"]
                        questContion.questIndex = GetQuestLogIndexByID(questId)
                        
                        _, _, _, _, _, questContion.isQuestComplete, _, _, questContion.startEvent = GetQuestLogTitle(questContion.questIndex);
                        questContion.questWatched = IsQuestWatched(questContion.questIndex)
                        questContion.numObjectives = GetNumQuestLeaderBoards(questContion.questIndex)
                        
                        if ( questContion.isQuestComplete and questContion.isQuestComplete < 0 ) then
                            questContion.isQuestComplete = false;
                            questContion.questFailed = true;
                        elseif ( questContion.numObjectives == 0 and not questContion.startEvent ) then
                            questContion.isQuestComplete = true;      
                        end		
                    end
                    
                    for j = 1, #objectiveProgressBars do
                        objectiveProgressBars[j]:Hide()
                    end
                    
                    local areAllCompleted = true
                    
                    for _, questInfo in pairs(allQuestContions) do
                        if not questInfo.isQuestComplete then
                            areAllCompleted = false
                        end
                    end                   
                    local areAllFailed = true
                    
                    for _, questInfo in pairs(allQuestContions) do
                        if not questInfo.questFailed then
                            areAllFailed = false
                        end
                    end
                
					if not areAllCompleted and not areAllFailed then
                      local y = 0
                    
                      for _, questInfo in pairs(allQuestContions) do
                      
						for i = 1, questInfo.numObjectives do
                            local text, objectiveType, finished = GetQuestLogLeaderBoard(i, questInfo.questIndex)
                            
							if text then
								if IsQuestWatched(questInfo.questIndex) then
									RemoveQuestWatch(questInfo.questIndex)
									QuestLog_Update()
								end
								local line = StatusFrame_GetCreateObjectiveLine(frame)
								if finished then
									line.Dash:SetText("|TInterface\\Scenarios\\ScenarioIcon-Check:16:16:-2|t")
								else
									line.Dash:SetText("- ")
								end
                                line.Text:SetText(text)
								
								local itemWidth = 0
								if item then
									itemWidth = WATCHFRAME_ITEM_WIDTH;
								end
								
								line.Text:SetWidth(line:GetWidth()-line.Dash:GetWidth()-itemWidth)
								local lineHeight = line.Text:GetStringHeight()+WATCHFRAMELINES_FONTSPACING+3
								line:SetHeight(lineHeight)

								--if not lastLine then
								line:SetPoint("RIGHT")
								if finished then
									line:SetPoint("LEFT", -8, 0)
								else
									line:SetPoint("LEFT", 0, 0)
								end
							
                                local extraDY = 0;
                                if DGV:ReturnTag("AWQ", stepIndex) then
									extraDY = 13
									SmallFrame.dH = -12
								else
									SmallFrame.dH = 0
								end
								line:SetPoint("TOP", WATCHFRAMELINES_FONTSPACING, -(y) + extraDY)
								--end 
	   
								y = y + lineHeight                            

								lastLine = line
							end
						end
                      end
                      
                        if item and not allQuestContions[1].isQuestComplete then
							SetObjectiveItem(frame, item)
						end
                      
					end
				end
			end
			frame.Objectives:SetHeight(StatusFrame_GetObjectivesHeight(frame))
		end
		
		if DugisGuideViewer.tukuiloaded then
			local point, _, relativePoint, xOffset, yOffset = DugisSmallFrame:GetPoint(1); 
			if xOffset == 0 and yOffset == 0 and point == "BOTTOMRIGHT" and relativePoint == "BOTTOMRIGHT" then
				DugisGuideViewer.Modules.SmallFrame:Reset()
			end
		end
		
	end
    
    function UpdateSmallFrameBlocksContent()
        local blocks = {DugisSmallFrameContainer:GetChildren()}
        
        for _, frame in pairs(blocks) do
            if frame.Desc and frame.Desc.rawText then
                local text = DGV.NPCJournalFrame:ReplaceSpecialTags(frame.Desc.rawText, true)
				if text then 
					--Changing color
					text = string.gsub(text, '(|Hguide:)([^|]*:)([0-9]*)(|h|c)(........)([^|]*|r|h)', function(a, b, uniqueID, c, color, d) 
						if DGV.NPCJournalFrame.hoveredGuideLinkId == uniqueID then
							color = "ffffffff"
						else
							color = "ff44ff44"
						end
						
						return a..b..uniqueID..c..color..d
					end) 
					
					frame.Desc:SetText(text)
				end 
            end
        end
    end
	
	function SmallFrame:Reset()
		if DGV:IsSmallFrameFloating()	then
			SmallFrame.Frame:ClearAllPoints()	
		end
		SmallFrame:ResetFloating()
	end

	local function UnsnapFromWatchFrame()
	
	end

	function SmallFrame:ResetFloating()
		if DGV:IsSmallFrameFloating() or
			not DugisGuideViewer:GuideOn()
		then
			--UnsnapFromWatchFrame()
			
			--loop and layout
			local maxWidth, maxTextWidth = 0,0
			for _,frame in SmallFrame.IterateActiveStatusFrames do
				StatusFrame_Layout(frame)
				maxWidth = math.max(maxWidth, frame:GetWidth())
				maxTextWidth = math.max(maxTextWidth, frame.Text:GetStringWidth())
			end
			for _,frame in SmallFrame.IterateActiveStatusFrames do
				StatusFrame_SetCurrentWidth(frame, maxWidth)
			end

			if not UnitAffectingCombat("player") then
				SmallFrame.Frame:SetWidth(maxWidth - 2)
			end
			newFrameSize, newTextSize = maxWidth, maxTextWidth
			if #statusFrames.usedFrames>0 and statusFrames.usedFrames[#statusFrames.usedFrames]:GetBottom() then --GetBottom() nil check needed to stop messy error during petbattle
				--todo: check why this is duplicated
				local height = statusFrames.usedFrames[1]:GetTop()	-	
				statusFrames.usedFrames[#statusFrames.usedFrames]:GetBottom() +
				ANCHORED_CONTAINER_TOP_PADDING +
				ANCHORED_CONTAINER_BOTTOM_PADDING 
				+ 30 + spaceForSmallFrameHeader() + (SmallFrame.dH or 0)

				if not UnitAffectingCombat("player") then
					SmallFrame.Frame:SetHeight(height)
				end
			end
			
			DugisGuideViewer:SetSmallFrameBorder()
		end
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
	end

	--[[
	local function PLAYER_REGEN_ENABLED(self)
		
			
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
	--]]

	function SmallFrame:OnClick(self, button)
		name = self:GetName()
		
		if button == "RightButton" then
			if DugisMainBorder:IsVisible() then
				DugisGuideViewer:HideLargeWindow()
			else
				--UIFrameFadeIn(DugisMainframe, 0.5, 0, 1)
				--UIFrameFadeIn(Dugis, 0.5, 0, 1)
				DugisGuideViewer:ShowLargeWindow()
			end
		elseif button == "LeftButton" and IsShiftKeyDown() then
			DugisGuideViewer.Modules.StickyFrame:AddRow(self.guideIndex)
		elseif button == "LeftButton" then
			local questID = DGV.qid[self.guideIndex]
			if DGV.Modules.DugisWatchFrame then
				DGV.Modules.DugisWatchFrame:ShowObjectiveByID(questID)
			end
		end
	end
	
	--Called possibly in combat
	local populateSmallFrameFirstTime = true
	function SmallFrame:PopulateSmallFrame()
		if not DGV:isValidGuide(CurrentTitle) then
			if not CurrentTitle and #statusFrames.usedFrames==1 then
				StatusFrame_InitPoints(statusFrames.usedFrames[1])
			end
			return
		end
		
		local checkmoved = DugisGuideUser.NextQuestIndex -- check if NextQuestIndex has changed
		
		ClearAllStatusFrames()
 		if MultistepMode() and not DGV:ReturnTag("NT", DugisGuideUser.CurrentQuestIndex) then
 			local maxstep = 0
			local total = math.ceil(DugisGuideViewer:GetDB(DGV_SMALLFRAME_STEPS) - 0.5) or 6
			
			if DGV:ReturnTag("SID", DugisGuideUser.CurrentQuestIndex) or DGV:ReturnTag("SID", DugisGuideUser.CurrentQuestIndex + 1 ) then 
				total = 2
			end
			
 			for guideIndex in DGV.IterateRelevantSteps do				
 				maxstep = maxstep + 1
 				if maxstep <= total then 
 					StatusFrame_Populate(StatusFrame_GetCreate(), guideIndex)
 				end
				if maxstep == 2 and not DGV:ReturnTag("AYG", guideIndex) then 
					DugisGuideUser.NextQuestIndex = guideIndex
				elseif DGV:ReturnTag("AYG", DugisGuideUser.CurrentQuestIndex + 1) then 
					DugisGuideUser.NextQuestIndex = DugisGuideUser.CurrentQuestIndex
				end
			end
		elseif DGV:ReturnTag("AYG", DugisGuideUser.CurrentQuestIndex) and not DGV:ReturnTag("NT", DugisGuideUser.CurrentQuestIndex) then -- AYG to make As you go step stick. 
			local maxstep = 0
			for guideIndex in DGV.IterateRelevantSteps do				
				maxstep = maxstep + 1
				if maxstep <= 2 then 
					StatusFrame_Populate(StatusFrame_GetCreate(), guideIndex)
				end
				if maxstep == 2 and not DGV:ReturnTag("AYG", guideIndex) then 
					DugisGuideUser.NextQuestIndex = guideIndex
				elseif DGV:ReturnTag("AYG", DugisGuideUser.CurrentQuestIndex + 1) then
					DugisGuideUser.NextQuestIndex = DugisGuideUser.CurrentQuestIndex
				end
 			end
 		else
 			StatusFrame_Populate(StatusFrame_GetCreate(), DugisGuideUser.CurrentQuestIndex)
 		end	
		
		if populateSmallFrameFirstTime then
			populateSmallFrameFirstTime = false
			DugisGuideViewer.UpdateSmallFrame()
			SmallFrame:AlignToTop()
		end
	end
	
	function SmallFrame:CheckButton_OnEvent(self, event)
		local guideIndex = self:GetParent().guideIndex
		if DugisGuideUser.CurrentQuestIndex then --If a guide is loaded
			if DGV:ReturnTag("NT", guideIndex) then
				--self.Chk:SetChecked(false)
                DGV.UpdateGuideVisualRows()
			elseif guideIndex==DugisGuideUser.CurrentQuestIndex and guideIndex == DGV:GetLastUsedStepIndex() then--LastGuideNumRows then
				--self.Chk:SetChecked(false)
				DugisGuideViewer:LoadNextGuide()
                DGV.UpdateGuideVisualRows()
			else
				DugisGuideViewer:SetChkToComplete(guideIndex, true)
				if guideIndex then
                    LuaUtils:Delay(0.2, function()
                        if DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
                            DugisGuideViewer:MoveToNextQuest(DugisGuideViewer:FindNextUnchecked())
                        end
                    end)
                    
                    LuaUtils:Delay(0.3, function()
                        DGV.UpdateGuideVisualRows()
                    end)
				end
			end
		end
	end

	local autoTooltipFadeTime = math.huge
	local function ResetAutoTooltip()
		if SmallFrameTooltip then SmallFrameTooltip:SetAlpha(1) end
		autoTooltipFadeTime = math.huge
	end

	local function UpdateAutoTooltip()
		local toEnd = autoTooltipFadeTime-GetTime()
		if toEnd <= 0 then 
			SmallFrameTooltip:Hide()
			ResetAutoTooltip()
		elseif toEnd <= 3 then 
			SmallFrameTooltip:SetAlpha(toEnd/3) 
		end
	end

	local tooltip = CreateFrame( "GameTooltip", "SmallFrameTooltip", nil, "GameTooltipTemplate" ); 
	function SetTooltipOnUpdate(self, event)
		if 
			DugisGuideViewer:isValidGuide(CurrentTitle) == true and 
			DugisGuideUser.CurrentQuestIndex and
			not IsTooltipEmbedded()
		then

			local statusFrameTooltipText = SmallFrame.StatusFrame_GetDescriptionText(self.guideIndex)
			local filename, _, _ = SmallFrameTooltipTextLeft1:GetFont() -- needed so that it doesn't overwrite font style when using other addons. 
			
			tooltip:SetOwner(self)
			tooltip:SetFrameStrata("TOOLTIP") 
			tooltip:SetParent(UIParent)
			SmallFrameTooltipTextLeft1:SetFont(filename, 12)
			tooltip:SetPadding(5, 5)
			tooltip:AddLine(statusFrameTooltipText, 1, 1, 1, 1,true)
			tooltip:Show()

			local ttwidth, ttheight, fwidth, fheight, pad = DugisGuideViewer:GetToolTipSize(tooltip)

			tooltip:ClearAllPoints()
			local anchorPoint = strupper(DugisGuideViewer:GetDB(DGV_TOOLTIPANCHOR)):gsub("%s", "")
			if anchorPoint=="DEFAULT" and DGV:IsSmallFrameFloating() then
				anchorPoint = "LEFT"
			elseif anchorPoint=="DEFAULT" then
				anchorPoint = "LEFT"
			end
			
			local toolAnchorPoint 	= ""
			toolAnchorPoint = toolAnchorPoint..((anchorPoint:find("BOTTOM.*") and "TOP") or "")
			toolAnchorPoint	= toolAnchorPoint..((anchorPoint:find("TOP.*") and "BOTTOM") or "")
			toolAnchorPoint = toolAnchorPoint..((anchorPoint:find("^RIGHT") and "LEFT") or "")
			toolAnchorPoint = toolAnchorPoint..((anchorPoint:find("^LEFT") and "RIGHT") or "")
			toolAnchorPoint = toolAnchorPoint..((anchorPoint:find(".+LEFT") and "LEFT") or "")
			toolAnchorPoint = toolAnchorPoint..((anchorPoint:find(".+RIGHT") and "RIGHT") or "")
			
			
			ResetAutoTooltip()
		end
	end
	
   
    local ticker = nil
    function SmallFrame.FadeInFadeOutTabs(speed)
        if ticker then
            ticker:Cancel()
        end

        ticker = C_Timer.NewTicker(speed or 0.02, function()
            local currentAlpha = SmallFrame.tabsBox:GetAlpha()
            
            local isMouseOver = SmallFrame.Frame:IsMouseOver() or SmallFrame.tabsBox:IsMouseOver()
            
            if isMouseOver then
                currentAlpha = currentAlpha + 0.1
                if currentAlpha >= 1 then
                    currentAlpha = 1
                    ticker:Cancel()
                    ticker = nil
                end
                SmallFrame.tabsBox:SetAlpha(currentAlpha)
            else
                currentAlpha = currentAlpha - 0.1
                if currentAlpha <= 0 then
                    currentAlpha = 0
                    ticker:Cancel()
                    ticker = nil
                end
                SmallFrame.tabsBox:SetAlpha(currentAlpha)
            end
        end)
    end
    
	function SmallFrame:OnEnter(self, event)
		SetTooltipOnUpdate(self, event)
		SetTextColors(self, true)
        SmallFrame.FadeInFadeOutTabs()
        LuaUtils:Delay(2, SmallFrame.FadeInFadeOutTabs)
	end
	
	function SmallFrame:OnLeave(self, event)
		DGV:ShowAutoTooltip(self)
		SetTextColors(self)
        SmallFrame.FadeInFadeOutTabs()
        LuaUtils:Delay(2, SmallFrame.FadeInFadeOutTabs)
	end
	
	function SmallFrame:AlignToTop()
		local x, y = GUIUtils:GetRealFeamePos(DugisSmallFrame) 
		if LuaUtils:CanModifyFrame(DugisSmallFrame) then
			DugisSmallFrame:ClearAllPoints()
			DugisSmallFrame:SetPoint("TOPLEFT", x, y)
		end
	end	
	
	function SmallFrame:OnDragStart()
		if not DugisGuideViewer:UserSetting(DGV_MOVEWATCHFRAME) then
			return
		end

		local smallFrameLocked
		if DGV:IsSmallFrameAnchored() then
			smallFrameLocked = DGV:UserSetting(DGV_DISABLEWATCHFRAMEMOD) 
		else
			if DugisGuideViewer:UserSetting(DGV_LOCKSMALLFRAME) then
				smallFrameLocked = true
			else
				smallFrameLocked = false
			end
		end

		if not smallFrameLocked then
			SmallFrame.Frame:StartMoving()
			SmallFrame.Frame.isMoving = true
		end
	end

	function SmallFrame:OnDragStop()
		SmallFrame.Frame:StopMovingOrSizing();
		SmallFrame.Frame.isMoving = false;
		SmallFrame:AlignToTop()

		if DugisGuideViewer:UserSetting(DGV_SMALL_FRAME_EXTEND_UP) then
			local leftTracker, topTracker = GUIUtils:GetRealFeamePos(DugisSmallFrameContainer)
			topTracker = -topTracker
			topTracker = topTracker + DugisSmallFrameContainer:GetHeight()
			local fromBottom = GetScreenHeight() - topTracker

			DugisSmallFrameContainer:ClearAllPoints()
			DugisSmallFrameContainer:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", leftTracker, fromBottom)
		end		
	end	
	
	SmallFrame.Frame:HookScript("OnMouseDown", SmallFrame.OnDragStart)
	SmallFrame.Frame:HookScript("OnMouseUp", SmallFrame.OnDragStop)
	
	function DugisGuideViewer:ShowAutoTooltip(frame)
		frame = frame or DugisSmallFrameStatus1
		if not frame or not DugisGuideViewer.actions then return end
		--if 1 then return end
		if DugisGuideViewer:GetDB(DGV_SHOWTOOLTIP)==0 or (DGV.actions[frame.guideIndex] and strmatch(DugisGuideViewer.actions[frame.guideIndex], "[CNK]")==nil) or DGV:UserSetting(DGV_EMBEDDEDTOOLTIP) then
			if tooltip then tooltip:Hide() end
			ResetAutoTooltip()
			return 
		end
		SetTooltipOnUpdate(frame)
		autoTooltipFadeTime = GetTime() + DugisGuideViewer:GetDB(DGV_SHOWTOOLTIP) + 3
		--SmallFrameTooltip:Show()
		tooltip:SetScript("OnUpdate", UpdateAutoTooltip)
	end
	
	function SmallFrame:PlayFlashAnimation(headerAnim)
		LuaUtils:Delay(0.1, function()
			--if header.animating then return end -- stop flash animation spam
			if not SmallFrame.FlashFrame then
				wf_flashGroup, _, SmallFrame.FlashFrame = DGV:CreateFlashFrame(SmallFrameBkg)
			end
			
			if DGV:UserSetting(DGV_WATCHFRAMEBORDER) and (DGV:UserSetting(DGV_SMALLFRAMETRANSITION) == L["Flash"] or DGV:UserSetting(DGV_SMALLFRAMETRANSITION) == L["Scroll"]) then				
				if headerAnim == true then 

---------------------------------
----------- WOW Classic:---------
--------------------------------- 
--header was not created because of missing API
--[[					
					header.animating = true;
					header.HeaderOpenAnim:Stop();
					header.HeaderOpenAnim:Play();]]
				end 
				--DGV:DebugFormat("PlayFlashAnimation showing", "flashGroup", flashGroup)
				SmallFrame.FlashFrame:Show()
				SmallFrame.FlashFrame:SetWidth(SmallFrameBkg:GetWidth() - 14)
				SmallFrame.FlashFrame:SetHeight(SmallFrameBkg:GetHeight() - 17)
				wf_flashGroup:Stop()
				wf_flashGroup:Play()
			else
				SmallFrame.FlashFrame:Hide()
			end
		end)
	end
    
	function SmallFrame.UpdateProgressBarPosition()
		if not SmallFrameProgressBar then
			return
		end
        SmallFrameProgressBar:ClearAllPoints()
		SmallFrameProgressBar:SetPoint("TOPLEFT", 123, -18)
        
        if (DugisGuideViewer:UserSetting(DGV_DISPLAYGUIDESPROGRESS)) 
		and DugisGuideViewer:isValidGuide(CurrentTitle) == true
		and not DGV.IsSmallFrameCollapsed() 
		and DugisGuideViewer:UserSetting(DGV_SHOW_SMALL_FRAME_HEADER) then
            SmallFrameProgressBar:Show()
        else
            SmallFrameProgressBar:Hide()
        end  
        
        if (DugisGuideViewer:UserSetting(DGV_DISPLAYGUIDESPROGRESSTEXT))
		and DugisGuideViewer:isValidGuide(CurrentTitle) == true
		and not DGV.IsSmallFrameCollapsed() then
            SmallFrameProgressBarText:Show()
        else
            SmallFrameProgressBarText:Hide()
        end
    end
    
    local function GuideType2Icon(type)
        if type == "Clear" or type == nil then
            return --"Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\turnin_d"
        end
    
        for i=1, #DGV.tabs do
            local tab = DGV.tabs[i]
            if tab.guidetype == type then
                return tab.icon
            end
        end
        
        return "Interface\\Icons\\inv_level120"
    end

    function SmallFrame.ShowTabMenu(tab)
        local someGuideLoaded = (tab.type ~= "Clear" and tab.type ~= "" and tab.type ~= nil)
        local menu = {
            {text = someGuideLoaded and  "Clear Guide" or "Select Guide"  , isNotRadio = true, notCheckable = true
            , func = function() 
                if someGuideLoaded then
                    SmallFrame.SetGuideForTab(tab, "", "Clear")
                    if SmallFrame.GetActiveTab() == tab then
                    --    SmallFrame.ActivateTab(tab, true)
                    end
                    DGV.ClearGuide()
                else
                    DGV:ShowLargeWindow()
                end
            end},
            
            {text = "Close Menu", isNotRadio = true, notCheckable = true
            , func = function(itemInfo)   end}      
        }
        
        if not DugisTabMenu then
            CreateFrame("Frame", "DugisTabMenu", UIParent, "UIDropDownMenuTemplate")
        end
        
        LuaUtils.DugisDropDown.LibDugi_EasyMenu(menu, DugisTabMenu, tab.frame, 30 , -3, "MENU", nil)
        LibDugi_DropDownList1:SetClampedToScreen(true)
        
    end
    
	function SmallFrame.UpdateTabs()
        if not DugisGuideUser.smallFrameTabs then
            DugisGuideUser.smallFrameTabs = {}
        end
    
        local buttonsY = -8
    
        local border = DugisGuideViewer:UserSetting(DGV_LARGEFRAMEBORDER)
        
        local shiftX = 
        {
             Default         = 0  
            ,BlackGold       = 2
            ,Bronze          = 0
            ,DarkWood        = 0
            ,ElvUI           = 3
            ,Eternium        = 0
            ,Gold            = 0
            ,Metal           = 0
            ,MetalRust       = 0
            ,OnePixel        = 2
            ,Stone           = 0
            ,StonePattern    = 0
            ,Thin            = 2
            ,Wood            = 0 
        }
        
        buttonsY = buttonsY - shiftX[border]
        
        local tabsSpace = 37
        local lastX = -25
        for i = 1, #SmallFrame.tabs do
            local tab = SmallFrame.tabs[i]
            
            tab.frame.tab = tab
            tab.tabIndex = i
            
            if tab.used and i <= (DugisGuideViewer:UserSetting(DGV_SMALL_FRAME_TABS_AMOUNT) or 3)+0.5 then
                tab.frame:ClearAllPoints()
                
                lastX = lastX + tabsSpace
                tab.frame:SetPoint("TOPLEFT", SmallFrame.tabsBox, "TOPLEFT", lastX, buttonsY)
                
                tab.frame.Icon:ClearAllPoints()
                tab.frame.Icon:SetSize(27, 27)
                tab.frame.Icon:SetPoint("BOTTOM", tab.frame, "BOTTOM", 1, 2)
                tab.frame.Icon:SetTexture(GuideType2Icon(tab.type))
                
                tab.frame:Show()
            else
                tab.frame:Hide()
            end
            
            if tab.active then
                tab.frame.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.78906250, 0.95703125);
            else
                tab.frame.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.61328125, 0.78125000);
            end
            
             DugisGuideUser.smallFrameTabs[i] = {
                guide = tab.guide,
                type = tab.type,
                active = tab.active,
             }
        end
        
    end
    
	function SmallFrame.AddTab(type_, guide_, active)
    
        if  #SmallFrame.tabs >=4 then
            return 
        end
        
        local newTab = {guide = guide_ or "", used = true, active = active, type = type_}
        newTab.frame = CreateFrame("Frame", nil, SmallFrame.tabsBox, "SmallFrameTabTemplate")

        newTab.frame:SetFrameStrata("BACKGROUND")
        newTab.frame:SetFrameLevel(2)
        
        newTab.frame:SetScript("OnMouseDown", function(self, button)
            if LuaUtils:ThreadInProgress("DisplayViewTab") then
                return
            end        
            if button == "LeftButton" then
                SmallFrame.ActivateTab(newTab, true)
                if newTab.guide == "" or not newTab.guide then
                    DGV.ClearGuide()
                end                    
            else
                SmallFrame.ActivateTab(newTab, true)
                SmallFrame.ShowTabMenu(newTab)
            end
        end)
      
        SmallFrame.tabs[#SmallFrame.tabs + 1] = newTab
        
    end    
        
	function SmallFrame.ActivateTab(tab, setRelatedGuide)
        for i = 1, #SmallFrame.tabs do
            SmallFrame.tabs[i].active = false
        end
        tab.active = true
		SmallFrame.UpdateTabs()
        
        if setRelatedGuide then
            DGV:DisplayViewTabInThread(tab.guide or "", nil, true)
        end
    end  
    
	function SmallFrame.GetActiveTab()
        for i = 1, #SmallFrame.tabs do
            if SmallFrame.tabs[i].active then
                return SmallFrame.tabs[i]
            end
        end
        SmallFrame.tabs[1].active = true
        return SmallFrame.tabs[1]
    end  
    
    function SmallFrame.SetGuideForTab(tab, guide, type_)
        tab.guide = guide
        tab.type = type_
        SmallFrame.UpdateTabs()
    end     
    
	function SmallFrame.SetGuideForActiveTab(guide, type_)
        local activeTab = SmallFrame.GetActiveTab()
        SmallFrame.SetGuideForTab(activeTab, guide, type_)
    end 
    
    function SmallFrame.InitializeTabs()
    
        if not DugisGuideUser.smallFrameTab then
            DugisGuideUser.smallFrameTab = {}
        end
    
        SmallFrame.tabsBox = CreateFrame("Frame", nil, SmallFrame.Frame)  
        SmallFrame.tabsBox:SetSize(327, 67)
        SmallFrame.tabsBox:SetPoint("TOPLEFT", SmallFrame.Frame, "TOPLEFT", 1, 35)
        SmallFrame.tabsBox:Show()
        SmallFrame.tabsBox:SetAlpha(0)
            
        SmallFrame.tabsBox:SetScript("OnEnter", function(self, event)
            SmallFrame.FadeInFadeOutTabs()
            LuaUtils:Delay(2, SmallFrame.FadeInFadeOutTabs)
        end)
        
        SmallFrame.tabsBox:SetScript("OnLeave", function(self, event)
            SmallFrame.FadeInFadeOutTabs()
            LuaUtils:Delay(2, SmallFrame.FadeInFadeOutTabs)
        end)
        
        SmallFrame.tabsBox:SetFrameStrata("BACKGROUND")
        SmallFrame.tabsBox:SetFrameLevel(1)
        
        if DugisGuideUser.smallFrameTabs then
            for i=1, #DugisGuideUser.smallFrameTabs do
                local savedTabInfo = DugisGuideUser.smallFrameTabs[i]
                SmallFrame.AddTab(savedTabInfo.type, savedTabInfo.guide, savedTabInfo.active)
            end
        end
        
        SmallFrame.AddTab("Clear")
        SmallFrame.AddTab("Clear")
        SmallFrame.AddTab("Clear")
        SmallFrame.AddTab("Clear")
       
        SmallFrame.UpdateTabs()
    end      
    
	local TransitionFont = nil
	SmallFrame.Load = function()
        if _G["SmallFrameProgressBar"] == nil then
            CreateFrame("StatusBar", "SmallFrameProgressBar", SmallFrame.Frame, "DugisStatusBarTemplate")
            
            SmallFrameProgressBar:SetFrameStrata("BACKGROUND")
            SmallFrameProgressBar:SetFrameLevel(14)
            
            SmallFrameProgressBar:SetScript("OnEnter", function()
                if not DugisGuideViewer:UserSetting(DGV_DISPLAYGUIDESPROGRESSTEXT) then
                    SmallFrameProgressBarText:Show()
                end
            end)
                    
            SmallFrameProgressBar:SetScript("OnLeave", function()
                if not DugisGuideViewer:UserSetting(DGV_DISPLAYGUIDESPROGRESSTEXT) then
                    SmallFrameProgressBarText:Hide()
                end
            end)
        end
        
        SmallFrame.UpdateProgressBarPosition()
    
		if SmallFrame.loaded then return end
		SmallFrame.loaded = true

		local smallElapsed = 1.5
		local watchElapsed = -1

		function SmallFrame:StartFrameTransition( )
			if not DugisSmallFrameStatus1 then return end
			--SmallFrame:StartWatchFrameTransition()
			local fontObj = DugisSmallFrameStatus1.Text:GetFontObject()
			local textR, textG, textB = DugisSmallFrameStatus1.Text:GetTextColor()
			smallElapsed = 0
		end
		
		function SmallFrame:Init( )
		end
		
		function SmallFrame:Enable()
			SmallFrameTooltip:Show()
			SmallFrame:ResetFloating()
		end

		function SmallFrame:Disable()
			SmallFrame.Frame:Hide()
			SmallFrameTooltip:Hide()
			SmallFrame:ResetFloating()
		end
		


		function DGV:LoadInitialView(text, texture, desc)
			ClearAllStatusFrames()
			
			local frame = StatusFrame_GetCreate()
			frame.guideIndex = nil
			frame.Chk:SetChecked(false)
			frame.Desc:SetText(desc)
			frame.DescEventHandler:SetText(desc)
			frame.Desc.rawText = desc
			frame.Desc:SetPoint("LEFT", 42, 0)
			--frame.Desc:Hide()
			frame.Text:SetText(text)
			frame.Text:SetPoint("LEFT", 42, 0)
			frame.Icon:SetNormalTexture(texture)
			frame.Icon:SetSize(28, 28)
			frame.Icon:SetPoint("RIGHT", frame.Text, "LEFT", -1, -8)
			frame.Waypoint:Disable()
			frame.Waypoint:Hide()
			frame.ModelButton:Hide()
			frame.Chk:Disable()
			frame.Chk:Hide()
			frame.Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			StatusFrame_ClearAllObjectiveLines(frame)
			frame.Objectives:SetHeight(0)
			if frame.ItemButton then
				frame.ItemButton:Hide()
			end
			
			
			
		end
		
		local UpdateSmallFrame_firstTime = true
		function DGV:UpdateSmallFrame(headerAnim, dontPlayFlash)

			DugisGuideUser.shownObjectives = {}
			SmallFrame:PopulateSmallFrame( )
			SmallFrame:ResetFloating()
            if not dontPlayFlash then
                SmallFrame:PlayFlashAnimation(headerAnim)
            end            

			DugisGuideViewer:ShowAutoTooltip()
            SmallFrame.UpdateProgressBarPosition()
			
			--Updating
			SmallFrame.Frame:RegisterForDrag(nil)
			SmallFrame.Frame:SetBackdrop(nil)
			
			if not UnitAffectingCombat("player") then
				SmallFrame.Frame:SetWidth(300)
			end
			
			DugisGuideViewer:SetSmallFrameBorder()
			
			--loop and layout
			for _,frame in SmallFrame.IterateActiveStatusFrames do
				StatusFrame_Layout(frame)
			end

			if #statusFrames.usedFrames>0 and statusFrames.usedFrames[#statusFrames.usedFrames]:GetBottom() then --GetBottom() nil check needed to stop messy error during petbattle
				local height = 
				statusFrames.usedFrames[1]:GetTop()	-	
				statusFrames.usedFrames[#statusFrames.usedFrames]:GetBottom() +
				ANCHORED_CONTAINER_TOP_PADDING +
				ANCHORED_CONTAINER_BOTTOM_PADDING 
				+ 30 + spaceForSmallFrameHeader() + (SmallFrame.dH or 0)
				if not UnitAffectingCombat("player") then
					SmallFrame.Frame:SetHeight(height)
				end
			end
			DugisGuideViewer:WatchQuest()

			LuaUtils:Delay(1, function()
				if UpdateSmallFrame_firstTime then
					DGV.UpdateWorldQuestAutoGuide(UpdateSmallFrame_firstTime)
				end
				UpdateSmallFrame_firstTime = false
			end)
		end

		function DGV:OnWatchFrameUpdate()
			--if InCombatLockdown() then return end		
			if DGV.Modules.DugisWatchFrame:ShouldModWatchFrame() and
				not WatchFrame.collapsed and
				not DBMUpdate
			then
			else
				SmallFrameTooltip:Hide()
				if not DGV:IsSmallFrameFloating() then
					LuaUtils:HideFrame_safe(SmallFrame.Frame)
				end
			end
            
		end
		
		function DGV:OnDBMUpdate()
			if DBM.Options.HideObjectivesFrame and 
			WatchFrame:IsVisible() and 
			DGV.Modules.DugisWatchFrame:ShouldModWatchFrame() and
			not WatchFrame.collapsed and 
			DBMUpdate 
			then
				DBMUpdate = false
			elseif DBM.Options.HideObjectivesFrame and 
				not WatchFrame:IsVisible() 
			then
				SmallFrameTooltip:Hide()
				if not DGV:IsSmallFrameFloating() then
					SmallFrame.Frame:Hide()
					DBMUpdate = true 
				end		
			end
		end
		
		SmallFrame:Init()
		SmallFrame:Enable()
		SmallFrame.InitializeTabs()
	end
	SmallFrame.Unload = function()
		if not SmallFrame.loaded then return end
		SmallFrame.loaded = false
		--SmallFrame:Reset()
		SmallFrame:Disable()
		SmallFrame.Frame:Hide()
	end
        
    --This preloader is not visible. It just prevents mouse clicks.
    GUIUtils:CreatePreloader("SmallFramePreloader", SmallFrame.Frame)
    SmallFramePreloader:SetFrameStrata("HIGH")
    SmallFramePreloader.Icon:Hide()  
    
	
end