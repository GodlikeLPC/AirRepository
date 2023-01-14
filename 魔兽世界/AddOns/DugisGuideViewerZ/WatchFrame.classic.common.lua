local DGV = DugisGuideViewer
if not DGV then return end
local maps_82to13 = maps_82to13

local WF = DGV:RegisterModule("DugisWatchFrame")
WF.essential = true

local smallAndObjectiveFrameOneBkg = true

DGV.questId2Title = DGV.questId2Title or {}

--Used to make background for WatchFrame only in case small frame is floating.
local ObjectiveTrackerBackground = CreateFrame("Frame", "ObjectiveTrackerBackground", UIParent, "BackdropTemplate")
ObjectiveTrackerBackground:SetFrameStrata("BACKGROUND")
ObjectiveTrackerBackground:SetFrameLevel(8)
ObjectiveTrackerBackground:SetWidth(52)
ObjectiveTrackerBackground:SetHeight(52)
ObjectiveTrackerBackground:SetPoint("CENTER", 0, 220)
ObjectiveTrackerBackground:Hide()
WF.ObjectiveTrackerBackground = ObjectiveTrackerBackground

WF.collapseHeader = CreateFrame("Frame", "WatchFrameCollapseHeader", UIParent, "HeaderMenuTemplate")

WF.collapseHeader.Title = WF.collapseHeader:CreateFontString("OVERLAY", nil, "GameFontHighlightSmall")

WF.collapseHeader:SetWidth(20)
WF.collapseHeader:SetHeight(20)
WF.collapseHeader.MinimizeButton:SetScript("OnClick", function()
	WatchFrame.collapsed = not WatchFrame.collapsed
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	WF:UpdateQuestsVisibility()
end) 


--Variables to store Objective Tracker Frame position in floating mode.
local function GetSmallFrame()
	if DugisGuideViewer.Modules.SmallFrame and DugisGuideViewer.Modules.SmallFrame.Frame then
		return DugisGuideViewer.Modules.SmallFrame
	end
end

local function GetBottomElement()
	if WatchFrame:GetAlpha() == 0 then
		return nil
	end
	local last
	for i=1, #WATCHFRAME_QUESTLINES do
		local line = WATCHFRAME_QUESTLINES[i]
		if line and line:IsVisible() then last = line end
	end
	
	return last
end

local function IsWatchFrameVisible()
	if GetNumQuestWatches() == 0 then
		return false
	end
	for i=1, #WATCHFRAME_QUESTLINES do
		local line = WATCHFRAME_QUESTLINES[i]
		if line and line:IsVisible() then 
			return true
		end
	end
end

local function UpdateWatchFrameMinimizer()
	local smallFrame = GetSmallFrame()
	if WatchFrame.collapsed or (smallFrame and smallFrame.collapsed and DGV:IsSmallFrameAnchored()) then
		WF.collapseHeader.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.5);
		WF.collapseHeader.MinimizeButton:GetPushedTexture():SetTexCoord(0.5, 1, 0, 0.5);
		if not DGV:IncompatibleAddonLoaded() then
			WF.collapseHeader.Title:SetText(OBJECTIVES_LABEL)
			WatchFrame:SetAlpha(0)
		end
	else
		WF.collapseHeader.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0.5, 1);
		WF.collapseHeader.MinimizeButton:GetPushedTexture():SetTexCoord(0.5, 1, 0.5, 1);
		if not DGV:IncompatibleAddonLoaded() then
			WatchFrame:SetAlpha(1)
			WF.collapseHeader.Title:SetText("")
		end
	end
end

function DGV.IsSmallFrameCollapsed()
	local SmallFrame = GetSmallFrame()
	return SmallFrame.collapseHeader:IsShown() and SmallFrame.collapsed
end

ObjectiveTrackerBackground:HookScript("OnMouseDown", function()
	if DugisGuideViewer:UserSetting(DGV_MOVEWATCHFRAME) and not DugisGuideViewer:UserSetting(DGV_DISABLEWATCHFRAMEMOD) then
		if DGV:IsSmallFrameFloating() then
			local frame = ObjectiveTrackerBackground
			frame.startMouseX, frame.startMouseY = GetCursorPosition()
			frame.startFrameX, frame.startFrameY =  GUIUtils:GetRealFeamePos(frame)
			frame.isDragging = true
		end
	end
end)

ObjectiveTrackerBackground:HookScript("OnMouseUp", function()
	ObjectiveTrackerBackground.isDragging = false
end)

local function ObjectiveFrameDugiBkgDrag()
	local frame = ObjectiveTrackerBackground
	if frame.isDragging then
		if not IsMouseButtonDown("LeftButton") then
			frame.isDragging = false
		end
	end

	if DugisGuideViewer:UserSetting(DGV_DISABLEWATCHFRAMEMOD) or DGV:IncompatibleAddonLoaded() then return end
	
	if frame.isDragging then
	 	if  DGV:IsSmallFrameFloating() then
			local currentMouseX, currentMouseY = GetCursorPosition()
			local deltaMouseX, deltaMouseY = currentMouseX - frame.startMouseX, currentMouseY - frame.startMouseY
			local newBkgFrameX, newBkgFrameY = frame.startFrameX + deltaMouseX, frame.startFrameY + deltaMouseY

			DugisGuideUser.objectiveTrackerX = newBkgFrameX
			DugisGuideUser.objectiveTrackerY = newBkgFrameY
		end 
	end
end

local oldObjectiveTrackerOriginal
WF.OnFrameUpdate = function()
	if not WF.initialized then
		return
	end
	
	local SmallFrame = GetSmallFrame()

	ObjectiveTrackerBackground:ClearAllPoints()
	if DGV:IsSmallFrameFloating() then
		ObjectiveTrackerBackground:SetWidth(WF:GetWorldQuestMaxWidth() + 70 +  DGV.ExtraSpaceForPOIsButtons()) 
		ObjectiveTrackerBackground:SetHeight(GetWorldQuestRealHeight() + 25)
	else
		ObjectiveTrackerBackground:SetWidth(300 +  DGV.ExtraSpaceForPOIsButtons())
		ObjectiveTrackerBackground:SetHeight(GetWorldQuestRealHeight() + 30)
	end
	
	
	if DugisGuideUser.objectiveTrackerX == nil then
		DugisGuideUser.objectiveTrackerX,  DugisGuideUser.objectiveTrackerY = GUIUtils:GetRealFeamePos(ObjectiveTrackerBackground) 
	end

	ObjectiveTrackerBackground:SetPoint("TOPLEFT", UIParent, "TOPLEFT", DugisGuideUser.objectiveTrackerX or 0,  DugisGuideUser.objectiveTrackerY or 0) 
	ObjectiveTrackerBackground:Show()

	if not DGV:IncompatibleAddonLoaded() then
		WatchFrame:ClearAllPoints()
		local dX = 0

		if not DGV.IsQuestsTrackingEnabled() then
			dX = -22
		end	

		WatchFrame:SetClampedToScreen(false)
		if DGV:IsSmallFrameFloating() then
			ObjectiveTrackerBackground:SetClampedToScreen(true)
			WatchFrame:SetPoint("TOPLEFT", ObjectiveTrackerBackground, "TOPLEFT", 50 + dX,  -5)
		else
			ObjectiveTrackerBackground:SetClampedToScreen(false)
			WatchFrame:SetPoint("TOPLEFT", ObjectiveTrackerBackground, "TOPLEFT", 50 + dX,  -10)
		end
		WatchFrame:SetHeight(900)
	end

	--Visibility of the WatchFrame background
	if (DGV:IsSmallFrameFloating() and not DGV:UserSetting(DGV_WATCHFRAMEBORDER))
	--In this case the background will be from small frame anyway. 
	--We only change the alpha herre instead of showing/hiding because this frame is used to drag the WatchFrame
	or DGV:IsSmallFrameAnchored() 	
	or not IsWatchFrameVisible()
	or WatchFrame.collapsed
	then
		ObjectiveTrackerBackground:SetAlpha(0)
	else
		ObjectiveTrackerBackground:SetAlpha(1)
	end

	--Visibility of the WatchFrame
	if not DGV:IncompatibleAddonLoaded() then
		if DGV:IsSmallFrameAnchored() and SmallFrame and SmallFrame.collapsed then
			WatchFrame:SetAlpha(0)
		else
			WatchFrame:SetAlpha(1)
		end
	end

	--Position of the WatchFrame
	if DGV:IsSmallFrameAnchored() and SmallFrame then
		ObjectiveTrackerBackground:SetPoint("TOPLEFT", SmallFrame.Frame, "BOTTOMLEFT", -10,  30) 
	end

	--Processing dragging floating Objective Frame (ObjectiveTrackerBackground)
	ObjectiveFrameDugiBkgDrag()

	--Header
	WF.collapseHeader:ClearAllPoints()
	if DGV:IsSmallFrameFloating() then
		WF.collapseHeader:SetPoint("BOTTOMRIGHT", ObjectiveTrackerBackground, "TOPRIGHT", -8, -29)
		WF.collapseHeader:Show()
		WF.collapseHeader:SetParent(UIParent)

		--BURNING_CRUSADE
		--WF.collapseHeader.Title:SetText(OBJECTIVES_LABEL)
	else
		WF.collapseHeader:SetPoint("BOTTOMRIGHT", ObjectiveTrackerBackground, "TOPRIGHT", -9, -45)

		--BURNING_CRUSADE
		--WF.collapseHeader.Title:SetText("")
		if SmallFrame and SmallFrame.collapsed then
			WF.collapseHeader:Hide()
		else
			WF.collapseHeader:Show()
		end
	end

	UpdateWatchFrameMinimizer()

	LuaUtils:HideFrame_safe(WatchFrameCollapseExpandButton)
	LuaUtils:HideFrame_safe(WatchFrameHeader)

	if not IsWatchFrameVisible() or DGV:IncompatibleAddonLoaded() then
		LuaUtils:HideFrame_safe(WF.collapseHeader)
		LuaUtils:HideFrame_safe(ObjectiveTrackerBackground)
	end

	WF:HideUnusedEventHandlers()

	WF:UpdateMovables()
	WF:RestoreOriginalObjectiveTrackerPosition()


	if DugisGuideViewer.Modules.ModelViewer then
		local MV = DugisGuideViewer.Modules.ModelViewer
		if MV.Frame then
			local width = MV.Frame:GetWidth()
				if not InCombatLockdown() then
					if not MV.moving then
						if DGV.chardb.ModelViewer.areRelativeCoords then
							if DGV.chardb.ModelViewer.pos_x == false then
								DGV.chardb.ModelViewer.pos_x = 7
							end
							
							MV.Frame:ClearAllPoints()
							MV.Frame:SetPoint(DGV.chardb.ModelViewer.point or "TOPRIGHT",
							SmallFrameBkg ,
							DGV.chardb.ModelViewer.relativePoint or "TOPLEFT", 
							DGV.chardb.ModelViewer.pos_x, 
							DGV.chardb.ModelViewer.pos_y)
						end
					end
				end
		end
	end
end

function WF:HideUnusedEventHandlers()
	for i=1, #WATCHFRAME_QUESTLINES do
		local line = WATCHFRAME_QUESTLINES[i]
		if line and line.handler then
			if line:IsVisible() then 
				line.handler:Show()
			else
				line.handler:Hide()
			end
		end
	end
end

function WF:OnBeforeEssentialModeActive()
	local SmallFrame = GetSmallFrame()
		
	if SmallFrame and not DGV:IsSmallFrameFloating() then
		DugisGuideUser.objectiveTrackerX, DugisGuideUser.objectiveTrackerY = GUIUtils:GetRealFeamePos(SmallFrame.Frame)
		DugisGuideUser.objectiveTrackerX, DugisGuideUser.objectiveTrackerY = DugisGuideUser.objectiveTrackerX + 40 , DugisGuideUser.objectiveTrackerY - 15
	end
end

function WF:RestoreOriginalObjectiveTrackerPosition()

	if DGV:IsSmallFrameFloating() and not DugisGuideViewer:UserSetting(DGV_MOVEWATCHFRAME) then
		ObjectiveTrackerBackground:ClearAllPoints()
		local durabilityFrameDY = (DurabilityFrame and DurabilityFrame:IsShown()) and -56 or 0
		ObjectiveTrackerBackground:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -CONTAINER_OFFSET_X, -10 + durabilityFrameDY)
	end
end

function WF:UpdateMovables()
	--In onther case the DugisSmallFrameContainer is responsible for moving
	if DGV:IsSmallFrameFloating() then
		if DugisGuideViewer:UserSetting(DGV_DISABLEWATCHFRAMEMOD) then
			ObjectiveTrackerBackground:EnableMouse(false)
		else
			ObjectiveTrackerBackground:EnableMouse(true)
		end
	end
end   

function WF:Initialize()  
	if WF.initialized then return end
	WF.initialized = true
  
    function WF:ResetWatchFrameMovable()
        WF:DelayUpdate()
	end    
    

	local flashGroup, flash
	local L, RegisterFunctionReaction, RegisterMemberFunctionReaction = DugisLocals, DGV.RegisterFunctionReaction, DGV.RegisterMemberFunctionReaction
	
	function WF:ShouldModWatchFrame(forceLoaded)
		if forceLoaded then return true end
		return (WF.loaded or forceLoaded)
	end

	function WF:Reset()
	end
	
    function GetLastWorldQuestBlock()
        local bottomBlock = nil
        local top = 100000
         
        for k, v in pairs(WORLD_QUEST_TRACKER_MODULE.usedBlocks) do
            if (v:GetTop() and v:GetTop() < top)  or (v:GetBottom() and v:GetBottom() < top)then
                bottomBlock = v
                top = v:GetTop()
            end
        end
         
        return bottomBlock
    end
	
	local GetTop_cache = {}
	local function GetTop_cached(block)
		if block:GetTop() then
			GetTop_cache[block] = block:GetTop()
		end
		return GetTop_cache[block] or block:GetTop()  or 0
	end

	local questWatchFrameTopCached = {}
	function GetWorldQuestRealHeight()
		local lastBlock = GetBottomElement()
		if lastBlock then

			local questWatchFrameTop = WatchFrame:GetTop() or questWatchFrameTopCached

			if not questWatchFrameTop then
				questWatchFrameTop = questWatchFrameTopCached
			else
				questWatchFrameTopCached = questWatchFrameTop
			end

			local height = lastBlock:GetHeight() or 0
			local scH = GetScreenHeight()
			local top = ((GetScreenHeight() or 0)  - GetTop_cached(lastBlock))
			local qwTop = ((GetScreenHeight() or 0)  - (questWatchFrameTop or 0))
			local realHeight = top -  qwTop + height
			return realHeight
		else
			return 0
		end
	end

	function WF:GetWorldQuestMaxWidth()
		local maxWidth = 150
		for i=1, #WATCHFRAME_QUESTLINES do
			local line = WATCHFRAME_QUESTLINES[i]
			if line and line:IsShown() and line:IsVisible() then
				if line:GetWidth() > maxWidth then
					maxWidth = line:GetWidth()
				end
			end
		end

		return maxWidth
	end
	
	local firstTime = true
	function WF:DelayUpdate()
		if DugisGuideViewer:IsModuleRegistered("SmallFrame") then 
			DGV:OnWatchFrameUpdate() 
			if firstTime then
				LuaUtils:Delay(2, function()
					DGV:OnWatchFrameUpdate() 
				end)
			end
			firstTime = false
		else
			LuaUtils:Delay(2, function()
				if DugisGuideViewer:IsModuleRegistered("SmallFrame") then 
					DGV:OnWatchFrameUpdate() 
				end
			end)
		end
	end

	local wasColapsedHeader = {}
	function WF:ExpandAll()
		wasColapsedHeader = {}
		for i = 1, MAX_QUESTWATCH_LINES do
			local text, _, _, isHeader, isCollapsed = GetQuestLogTitle(i)
			if isCollapsed and isHeader then
				wasColapsedHeader[text] = true
			end
		end
		
		for i = MAX_QUESTWATCH_LINES, 1, - 1 do
			ExpandQuestHeader(i)
		end
	end

	local function NearestHeader(i)
		for j = i, 1, -1 do
			local text, _, _, isHeader = GetQuestLogTitle(j)
			if isHeader then
				return text, j
			end
		end

		return "", 0
	end

	local function HasSelectedSibling(i)
		local selected = GetQuestLogSelection()
		
		for j = i, MAX_QUESTWATCH_LINES do
			local _, _, _, isHeader = GetQuestLogTitle(j)
			if isHeader then
				break
			end
			if j == selected then
				return true
			end
		end

		for j = i, 1, -1 do
			local _, _, _, isHeader = GetQuestLogTitle(j)
			if isHeader then
				break
			end
			if j == selected then
				return true
			end
		end

		return false
	end

	function WF:ColapseAllExceptSelected()
		for i = MAX_QUESTWATCH_LINES, 1, - 1 do
			local text, _, _, isHeader, _, _, _, _ = GetQuestLogTitle(i)
			local headerText, headerIndex = NearestHeader(i)
			
			if text and not isHeader and wasColapsedHeader[headerText] then
				local hasSelectedSibling = HasSelectedSibling(i)
				if not hasSelectedSibling then
					CollapseQuestHeader(headerIndex)
				end
			end
		end
	end

	function WF:ShowObjective(questText)
		WF:ExpandAll()
		for i=1, MAX_QUESTWATCH_LINES do
			local text = GetQuestLogTitle(i)
			if text == questText then
				QuestLogFrame:Show()
				QuestLog_SetSelection(i)
				WF:ColapseAllExceptSelected()
				return 
			end
		end
		WF:ColapseAllExceptSelected()
	end

	function WF:ShowObjectiveByID(questId)
		WF:ExpandAll()
		for i = 1, MAX_QUESTWATCH_LINES do
			local qid = select(8, GetQuestLogTitle(i))
			if tostring(qid) == tostring(questId) then
				local text = select(1, GetQuestLogTitle(i))
				
				QuestLogFrame:Show()
				QuestLog_SetSelection(i)
				
				WF:ColapseAllExceptSelected()
				return 
			end
		end
		WF:ColapseAllExceptSelected()
	end	

	local objectiveTrackerUpdateReaction--, manageFramePositionsReaction
	function WF:Load()
		objectiveTrackerUpdateReaction = RegisterFunctionReaction("QuestLog_Update", nil, function()
			UpdateWatchFrameMinimizer()
			WF.DelayUpdate()
			if DGV.NamePlate and DGV.NamePlate.QuestWatch_Update then
				DGV.NamePlate:QuestWatch_Update()
			end

			--WatchFrame relies on frame visibility to hide lines when nothing is being watched, 
			--and may leave some visible if we affect WatchFrame.Show (which we do).  Clean up
			--lines, when empty.  This can be removed if the behavior stops
			if GetNumQuestWatches() == 0 then
				for i=1, #WATCHFRAME_QUESTLINES do
					local line = WATCHFRAME_QUESTLINES[i]
					if line then
						line:Hide();
					end
				end
			end
		end)

		WF:UpdateQuestsVisibility()
		WF:UpdateMovables()
	end

	function GetInfoByQuestTitle(title_)
		local questDisplayed = QUESTS_DISPLAYED or 1 
		for i = 1, MAX_QUESTS + questDisplayed do
			local title, _, _, _, _, _, _, questId = GetQuestLogTitle(i)

			if title == title_ then
				return questId, IsQuestWatched(i), title
			end
		end
	end

	hooksecurefunc("QuestLog_Update", function()
		WF:UpdateQuestsVisibility()
	end)

	function WF:UpdateQuestsVisibility()
		WF:UpdateQuestsVisibility_()
		LuaUtils:Delay(0.1, WF.UpdateQuestsVisibility_)
	end

	local function GetLineByQuestTitle(questTitle)
		for i=1, #WATCHFRAME_QUESTLINES do 
			local questLine = WATCHFRAME_QUESTLINES[i]
			if questLine and questLine.text and questLine.text:GetText() == questTitle and questLine.text:IsShown() then
				return questLine, i
			end
		end
	end

	function WF:UpdateQuestsVisibility_()
		for i=1, #WATCHFRAME_QUESTLINES do 
			local questLine = WATCHFRAME_QUESTLINES[i]
			if questLine and questLine.handler then
				questLine.handler:SetScript("OnEnter", nil)
			end

			if questLine and questLine.button then
				questLine.button:Hide()
			end
		end

		local index = 1
		for i=1, GetNumQuestWatches() do
		  local questIndex = GetQuestIndexForWatch(i)

		  if questIndex then
			local questTitle = GetQuestLogTitle(questIndex)
			local questId, isWatched = GetInfoByQuestTitle(questTitle)

			if isWatched then
				local questLine, lineIndex = GetLineByQuestTitle(questTitle)

				if questLine then
					if not questLine.handler then
						questLine.handler = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
						questLine.handler:EnableMouse(true)
						questLine.handler:SetAlpha(0)
					end

					questLine.handler:Show()

					questLine.handler:SetAllPoints(questLine)

					questLine.handler:SetScript("OnClick", function()
						WF:ShowObjective(questLine.text:GetText())
					end)

					questLine.handler:SetScript("OnEnter", function()
						questLine.orgVertexColor = {questLine.text:GetTextColor()}
						questLine.text:SetTextColor(1,1,1)
					end)
					
					questLine.handler:SetScript("OnLeave", function()
						if questLine.orgVertexColor then
							questLine.text:SetTextColor(unpack(questLine.orgVertexColor))
						end
					end)

					if not questLine.button then
						questLine.button = CreateFrame("FRAME", nil, UIParent, "QuestPinTemplate")
						hooksecurefunc(questLine, "Hide", function()
							questLine.button:Hide()
						end)
					end				
					questLine.button:ClearAllPoints()
					questLine.button:SetPoint("TOPLEFT", questLine, -32, 8)
					questLine.button:SetScalingLimits(1, 0.4125, 0.4125);
					questLine.button:Hide()
		
					questLine.button:SetScript("OnMouseDown", function()
						DGV.OnQuestPOIClick(questLine.button.questId)
					end)

					questLine.button.questId = questId
					local smallFrame = GetSmallFrame()
					if WatchFrame.collapsed 
					or (smallFrame and smallFrame.collapsed and not DGV:IsSmallFrameFloating()) 
					or (not DGV.IsQuestsTrackingEnabled()) then
						questLine.button:Hide();
					else
						questLine.button:Show();
					end
					
					local isSuperTracked = tonumber(questId) == tonumber(DGV.superTrackedQuestID)
				
					local color = "brown"
					if isSuperTracked then
						color = "yellow"
					end

					GUIUtils.Quests:SetupQuestButton(questLine.button, isSuperTracked, 30, 35, color)

					questLine.button:SetFrameStrata("HIGH")
					questLine.button:SetFrameLevel(100000)
				end
			end
		  end
		end
	end

	function WF:Unload()
		objectiveTrackerUpdateReaction:Dispose()
	end

	function WF:OnModulesLoaded()
		LuaUtils.DugiGuidesIsLoading = false
		WatchFrame:Show()
		
		DugisGuideViewer:UpdateIconStatus()
	
		if DugisGuideViewer.Modules.DugisWatchFrame then
			LuaUtils:Delay(1, function()
				DGV.Modules.DugisWatchFrame:DelayUpdate()
				DGV.shouldUpdateObjectiveTracker = true
			end)        
		end
	end
	
	if IsAddOnLoaded("DBM-Core") and DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then 
		hooksecurefunc(DBM, "StartCombat", function()
			DGV:OnDBMUpdate()
		end)	
		hooksecurefunc(DBM, "EndCombat", function()
			DGV:OnDBMUpdate()
		end)		
	end
end