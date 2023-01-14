local MOD, DGV = DugisGuideViewer, DugisGuideViewer
if not MOD then return end

local Record = MOD:RegisterModule("Record")
local DebugPrint = function(any) MOD:DebugDump(any) end

local _

function Record:Initialize()
	SLASH_DGR1 = "/dgr"
	local used = nil
	local L = DugisLocals
	
	local questRecord = ""
	local function EvaluateQuestRecordLimit()
		while #(DGV.chardb.QuestRecordTable) > DGV:GetDB(DGV_RECORDSIZE) do
			tremove(DGV.chardb.QuestRecordTable, 1)
		end
		questRecord = ""
		for i=1, #DGV.chardb.QuestRecordTable do
			questRecord = questRecord..DGV.chardb.QuestRecordTable[i]
		end
		if DGV_QuestRecordEditBox then DGV_QuestRecordEditBox.SetRecordText() end
	end
	
	if not DGV_QuestRecordContainer then
		local scrollChild = DugisRecordFrame.scroll.child
		local chkBox = CreateFrame("CheckButton", nil, scrollChild, "InterfaceOptionsCheckButtonTemplate")
		chkBox:SetPoint("TOPLEFT", 15, 0)
		chkBox.Text:SetText(L["Enabled"])
		--chkBox:SetHitRectInsets(0, -200, 0, 0)
		chkBox:SetChecked(DGV.chardb.QuestRecordEnabled)
		chkBox:RegisterForClicks("LeftButtonDown")
		chkBox:SetScript("OnClick", 
			function() 
				DGV.chardb.QuestRecordEnabled = not not chkBox:GetChecked()
				EvaluateQuestRecordLimit()
			end)
		
		local slider = DGV:CreateSlider("DGV_RecordSizeSlider", scrollChild, "Record Size", DGV_RECORDSIZE, 50, 500, 50, 50, "50", "500", 
			function() EvaluateQuestRecordLimit() end)
		slider:SetPoint("TOPLEFT", chkBox, "TOPRIGHT", DGV:GetFontWidth(L["Enabled"], "GameFontHighlight")+32, 0)
		slider:SetPoint("CENTER", 250, 0)
		slider:Hide()
		
		local button = CreateFrame("Button", nil, scrollChild, "UIPanelButtonTemplate")
		button:SetText(L["Clear Record"])
		button:SetWidth(DGV:GetFontWidth(L["Clear Record"], "GameFontHighlight")+30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", slider, "TOPRIGHT", 32, 0)
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() DGV:ClearRecord() end)
		
		local questRecordContainer = CreateFrame("Frame", "DGV_QuestRecordContainer", scrollChild)
		questRecordContainer:SetPoint("TOPLEFT", chkBox, "BOTTOMLEFT", 0, 0)
		questRecordContainer:SetPoint("RIGHT", DugisRecordFrame.scroll.bar, "LEFT", 0, 0)
		questRecordContainer:SetHeight(0)
		
		local questRecordBox = CreateFrame("EditBox", "DGV_QuestRecordEditBox", questRecordContainer)
		questRecordBox:SetFontObject(GameFontHighlightSmall)
		questRecordBox:SetTextInsets(2,2,2,2)
		questRecordBox:SetMultiLine(true)
		questRecordBox:SetAutoFocus(false)
		questRecordBox:SetAllPoints()
		questRecordBox.SetRecordText = 
			function()
				if questRecord then questRecordBox:SetText(questRecord) end
			end
		questRecordBox:SetScript("OnTextChanged", function(self, user) if user then questRecordBox.SetRecordText(); end end)
		questRecordBox:SetScript("OnEditFocusGained", function() questRecordBox:HighlightText() end)
		questRecordBox:SetScript("OnMouseDown", function() questRecordBox:HighlightText() end)
		questRecordBox:SetScript("OnEditFocusLost", function() questRecordBox:HighlightText(0,0) end)
		questRecordBox:SetScript("OnLoad", function(self) self:SetAutoFocus(false) end)
		questRecordBox:SetScript("OnEscapePressed", function(self) self:SetAutoFocus(false) self:ClearFocus() end)
		DGV.RECORD_MIN_Y = 1
		questRecordBox:SetScript("OnCursorChanged", 
			function(self, x, y, width, height)
				if DGV.RECORD_MIN_Y>0 then 
					DGV.RECORD_MIN_Y = -1*(scrollChild:GetHeight()-99)
				end
				if DGV.RECORD_MIN_Y>y then DGV.RECORD_MIN_Y = y end
				questRecordContainer:SetHeight(math.abs(DGV.RECORD_MIN_Y))
			end)
		--questRecordBox:SetAllPoints(questRecordContainer)
		questRecordBox:Show()
		EvaluateQuestRecordLimit()
		questRecordBox.SetRecordText()
		--SliderMax[i] = math.floor(1000+100-scrollChild:GetHeight())
		DGV_QuestRecordContainer:Hide()
	end

	function MOD:ClearRecord()
		MOD.RECORD_MIN_Y = 1
		wipe(DugisGuideViewer.chardb.QuestRecordTable)
        DGV.chardb.QuestRecordTableScenarios = {}
        DGV.chardb.QuestRecordTableCriterias = {}
		EvaluateQuestRecordLimit()
	end

	local accepted, currentcompletes, oldcompletes, currentquests, oldquests, currentboards, oldboards, titles, objectives, acceptQuest, turnInQuest, firstscan, abandoning = nil

	local function GuidToNpcId(guid)
		if not guid then return nil end
        local unitType, npcID = strmatch(guid or '', '^([^:]+)%-%d+%-%d+%-%d+%-%d+%-(%d+)%-')
        return npcID
	end
	
	local function GuidIsNpc(guid)
		if not guid then return nil end
		local unitType, npcID = strmatch(guid or '', '^([^:]+)%-%d+%-%d+%-%d+%-%d+%-(%d+)%-')
		return unitType == "Creature"
	end

	local function GetLocationString()
		LuaUtils:DugiSetMapToCurrentZone()
		local _, _, x, y = DGV:GetUnitPosition()
        
        if not x then
            x, y = 0, 0
        end
        
		return string.format("%s (%.2f, %.2f)", "in {"..GetSubZoneText().."}", x * 100, y * 100)
	end
	
	local function GetLocationId()
		LuaUtils:DugiSetMapToCurrentZone()
		return string.format("%s", DGV:GetCurrentMapID())
	end	
	
	local function SetSimpleRecord(text)
		--DebugPrint("Debug DugisGuideViewer.chardb.QuestRecordEnabled="..tostring(DugisGuideViewer.chardb.QuestRecordEnabled))
		if not DugisGuideViewer.chardb.QuestRecordEnabled then return end
		tinsert(DugisGuideViewer.chardb.QuestRecordTable, "\n- "..text)
		EvaluateQuestRecordLimit()
	end

	local function SetRecord(header, title, questId, objective, description, getLocation, npcId)
		wipe(used)
		if not DugisGuideViewer.chardb.QuestRecordEnabled then return end
		if not title then title = "" else title = " "..title end
		local recordItem = string.format("\n%s%s ||QID||%s||", header, title, questId)
		if objective then recordItem=recordItem..string.format(" ||QO||%s||", objective) end
		local location, locationId = "", ""
		if getLocation then 
			location = GetLocationString() 
			locationId = GetLocationId()
		end
		if description or getLocation then
			if not description then description = ""
			else location=" "..location end
			recordItem=recordItem..string.format(" ||N||%s%s|| ||Z||%s|", description, location, locationId)
		end
		if npcId then recordItem=recordItem..string.format(" ||NPC||%d||", npcId) end
		tinsert(DugisGuideViewer.chardb.QuestRecordTable, recordItem)
		EvaluateQuestRecordLimit()
	end
    
	local function AddRecordLine(text)
        if not DugisGuideViewer.chardb.QuestRecordEnabled then return end
		tinsert(DugisGuideViewer.chardb.QuestRecordTable, text)
		EvaluateQuestRecordLimit()
	end

	local function PopulateQuestInfo(infoTable)
		local currentQuestId = GetQuestID()
		if currentQuestId then
			infoTable.QID = currentQuestId
			infoTable.NpcName = GetUnitName("npc")
			infoTable.NpcId = GuidToNpcId(UnitGUID("npc"))
			infoTable.Objective = GetObjectiveText()
		end
	end

	local function RecordTarget()
		local target = UnitGUID("target")
		if target then
			local npc = ""
			if GuidIsNpc(target) then npc = string.format(" ||NPC||%s||", GuidToNpcId(target)) end
			SetSimpleRecord("Target: "..GetUnitName("target")..npc)
		end
	end

	local function RecordLastKill()
		if DugisGuideUser.lastKillGuid ~= nil then
			SetSimpleRecord(string.format("Last Kill: %s ||NPC||%s||", DugisGuideUser.lastKillName, GuidToNpcId(DugisGuideUser.lastKillGuid)))
			DugisGuideUser.lastKillGuid, DugisGuideUser.lastKillName = nil
		end
	end

	local orig = AbandonQuest
	function AbandonQuest(...)
		abandoning = true
		return orig(...)
	end

	local UsedItem = MOD.NoOp

	hooksecurefunc("UseContainerItem", function(bag, slot, ...)
		if MerchantFrame:IsVisible() then return end
		UsedItem(GetContainerItemLink(bag, slot))
	end)
			
---------------------------------
----------- WOW Classic:---------
---------------------------------
--UseQuestLogSpecialItem is not present. Todo: check if still needed/find replacement.
--[[	
	hooksecurefunc("UseQuestLogSpecialItem", function(questLogIndex)
		UsedItem(GetQuestLogSpecialItemInfo(questLogIndex))
	end)
	]]

	hooksecurefunc("SecureCmdUseItem", function(item)
        if item then
            _, link = GetItemInfo(item)
            UsedItem(link)
        end
	end)

	function Record:Load()
		accepted, currentcompletes, oldcompletes, currentquests, oldquests, currentboards, oldboards, titles, objectives, acceptQuest, turnInQuest, firstscan, abandoning = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, true	
	
		SlashCmdList["DGR"] = function(msg)
			if msg == "" then
				MOD:ShowRecord()
			elseif msg == "limit" then
                print("limit")
				MOD:ToggleRecordLimit()
			else
                print("RecordNote")
				MOD:RecordNote(msg)
			end
		end

		function MOD:ToggleRecordLimit()
			if DugisGuideViewer:GetDB(DGV_RECORDSIZE)<2^52 then
				print("|cff11ff11" .. "Dugis Unbound Quest Record Limit" )
				DugisGuideViewer:SetDB(2^52, DGV_RECORDSIZE)
			else
				print("|cff11ff11" .. "Dugis Quest Record Limit Set (4000 lines)" )
				DugisGuideViewer:SetDB(4000, DGV_RECORDSIZE)
				DGV_RecordSizeSlider:SetValue(50)
				EvaluateQuestRecordLimit()
			end
		end

		function MOD:ShowRecord()
			DugisRecordFrame:Show()
			DGV_QuestRecordContainer:Show()
		end

		function MOD:RecordNote(note)
			print("|cff11ff11" .. "Dugis Quest Record Note: "..note)
			SetSimpleRecord("Note: "..note.." ||N||"..GetLocationString().."| ||Z||"..GetLocationId().."|")
			RecordTarget()
		end

		local lastautocomplete;
		function MOD:OnAutoComplete(event, qid)
			lastautocomplete = qid
		end

		function MOD:OnQuestDetail()
			PopulateQuestInfo(acceptQuest)
			objectives[acceptQuest.QID] = acceptQuest.Objective
		end
		
		function MOD:OnQuestComplete()
			PopulateQuestInfo(turnInQuest)
		end
		
		DugisGuideUser.lastKillGuid = nil
		DugisGuideUser.lastKillName = nil

		function MOD:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
			local timestamp, combatEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags 
			= CombatLogGetCurrentEventInfo()
			if combatEvent == "PARTY_KILL" and GuidIsNpc(destGUID) and destGUID then
				DugisGuideUser.lastKillGuid = destGUID
				DugisGuideUser.lastKillName = destName
			end
		end	
        
        function MOD:RecordCurrentScenario()
            local stageName, stageDescription, numCriteria, _, _, _, numSpells, spellInfo, weightedProgress =  C_Scenario.GetStepInfo()
            local scenarioName, currentStage, numStages, flags, _, _, _, xp, money = C_Scenario.GetInfo();
            
            if stageName and stageDescription and DGV.chardb.QuestRecordTableScenarios[stageName] == nil then
                AddRecordLine("\n".."Stage " .. currentStage)
                AddRecordLine("\n".."Stage Name - " .. stageName)
                AddRecordLine("\n".."Stage Goal - " .. stageDescription)
                DGV.chardb.QuestRecordTableScenarios[stageName] = true
            end
        end
        
        function MOD:SCENARIO_UPDATE(event, ...)
            MOD:RecordCurrentScenario()
        end
        
        function MOD:SCENARIO_CRITERIA_UPDATE(event, ...)
            MOD:RecordCurrentScenario()
			local scenarioId = ...
            local scenarioName, currentStage, numStages, flags, _, _, _, xp, money = C_Scenario.GetInfo();
            
            local stageName, stageDescription, numCriteria, _, _, _, numSpells, spellInfo, weightedProgress =  C_Scenario.GetStepInfo()
            local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(1)
            
            LuaUtils:loop(numCriteria, function(index)
                local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(index)
                if completed and not DGV.chardb.QuestRecordTableCriterias[criteriaID] then
                
                    local location = GetLocationString() 
                    local locationId = GetLocationId()
                    local locationPart = string.format(" ||N|%s|| ||Z||%s|",  location, locationId)
                    AddRecordLine("\n".."C "..criteriaString.." |SID|"..criteriaID.."|" .. locationPart)
                    DGV.chardb.QuestRecordTableCriterias[criteriaID] = true
                    MOD:UpdateRecord()
                end
            end)
		end
		
---------------------------------
----------- WOW Classic:---------
---------------------------------  		
--Events not present. Todo: check if still needed/find replacement.
        --MOD:RegisterEvent("SCENARIO_UPDATE")
        --MOD:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
		MOD:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

		function MOD:UpdateRecord()
			DebugPrint("DebugPrintUpdateRecord")
			currentquests, oldquests = oldquests, currentquests
			currentboards, oldboards = oldboards, currentboards
			currentcompletes, oldcompletes = oldcompletes, currentcompletes
			wipe(currentquests)
			wipe(currentboards)
			wipe(currentcompletes)
			        
			for i=1,GetNumQuestLogEntries() do
                local title, _, _, isHeader, _, complete, _, qid = GetQuestLogTitle(i)
				if not isHeader and qid then
					currentquests[qid] = true
					titles[qid] = title

					local n = GetNumQuestLeaderBoards(i)
					if n>1 then
						for j=1,n do
							local text, objtype, finished = GetQuestLogLeaderBoard(j, i)
							if finished then
								DebugPrint("Debug Record Finished Board "..qid.."."..j)
								currentboards[qid.."."..j] = text
							end
						end
					else
						currentcompletes[qid] = complete == 1 and title or nil
					end
				end
			end
			
			if firstscan then
				for qid in pairs(currentquests) do 
					accepted[qid] = true 
				end
				firstscan = nil
				return
			end			

			for qidboard,text in pairs(currentboards) do
				local qid = tonumber(strmatch(qidboard, "^(%d+)%.%d", 1))
				if not oldboards[qidboard] and accepted[qid] then
					SetRecord("N", text, qidboard, nil, nil, true)
					RecordLastKill()
					RecordTarget()
				end
			end

			for qidcomplete,title in pairs(currentcompletes) do
				--print("accepted: "..accepted[qidcomplete].." : oldcomplete: "..oldcompletes[qidcomplete])
				if not oldcompletes[qidcomplete] then
					--print(accepted[qidcomplete])
					if accepted[qidcomplete] then
					--DebugPrint("Debug C: qidcomplete="..qidcomplete.." objectives[qidcomplete]"..objectives[qidcomplete])
					SetRecord("C", title, qidcomplete, nil, objectives[qidcomplete] or nil, true)
					RecordLastKill()
					RecordTarget()
					end
				end
			end

			for qid in pairs(oldquests) do
				if not currentquests[qid] then
					if not abandoning then
						if lastautocomplete == qid then
							SetSimpleRecord("Field turnin:")
							SetRecord("T", titles[qid], qid)
						else
							local name
							local id
							if turnInQuest.QID==qid then
								id = turnInQuest.NpcId
								if id then name = "(npc:"..id..")" end
							end
							SetRecord("T", titles[qid], qid, nil, name, true, id)
						end
					end
					objectives[qid] = nil
					titles[qid] = nil
					accepted[qid] = nil
					abandoning = nil
				end
			end

			for qid in pairs(currentquests) do
				if not oldquests[qid] then
					DebugPrint("Debug Record Accepted "..qid)
					accepted[qid] = true
					local auto = false
---------------------------------
----------- WOW Classic:---------
---------------------------------  		
--GetNumAutoQuestPopUps not present. Todo: check if still needed/find replacement.					
					--[[
					for i=1,GetNumAutoQuestPopUps() do
						local questID, popUpType = GetAutoQuestPopUp(i)
						if questID == qid and popUpType == "OFFER" then
							auto = true
							break
						end
					end
					]]
					if auto then
						SetSimpleRecord("Auto quest:")
						SetRecord("A", titles[qid], qid)
					else
						local name
						local id
						if acceptQuest.QID==qid then
							id = acceptQuest.NpcId
							if id then name = "(npc:"..id..")"	end
						end
						SetRecord("A", titles[qid], qid, nil, name, true, id)
					end
					return
				end
			end
		end

		used = {}
		UsedItem = function(link)
			if link and not used[link] then
				used[link] = true
				SetSimpleRecord(string.format("Used item: %s ||U||%d|| ||N||%s||", link, MOD:GetItemIdFromLink(link), GetLocationString()))
			end
		end
	end

	function Record:Unload()
		accepted, currentcompletes, oldcompletes, currentquests, oldquests, currentboards, oldboards, titles, objectives, acceptQuest, turnInQuest, firstscan, abandoning = nil
		used = nil
		UsedItem = MOD.NoOp
	end
end