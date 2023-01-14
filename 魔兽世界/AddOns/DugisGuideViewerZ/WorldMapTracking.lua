local DGV = DugisGuideViewer
if not DGV then return end
local L = DugisLocals
local _
local maps_82to13 = maps_82to13

local HBD = LibStub("HereBeDragons-2.0-Dugis", true) 

local objectivesBulbThreshold = 6

local folkIconDir = [[Interface\MINIMAP\TRACKING\]]

local addedObjectives = {}

DGV.questsPool = {}
DGV.questId2Title = DGV.questId2Title or {}

local completedQuests = GetQuestsCompleted() 

local Math = GUIUtils.Math

local WMT = DGV:RegisterModule("WorldMapTracking")

local hoveredBulbQuestId = nil

function DGV.QuestId2QuestLogId(questId_)
	for questLogId = 1, 40 do
		local _, _, _, _, _, _, _, questId = GetQuestLogTitle(questLogId)
		if tonumber(questId_) == questId then
			return questLogId
		end
	end
end

function DGV.GetAllActiveQuests(watchedOnly)
	local result = {}
	local questDisplayed = QUESTS_DISPLAYED or 1 
	local currentHeaderName = ""
	local currentHeaderIndex = -1
	for i= 1, MAX_QUESTS + questDisplayed do 
		local title, _, _, isHeader, _, isComplete, _, questId = GetQuestLogTitle(i);	
		if isHeader then
			currentHeaderName = title
			currentHeaderIndex = i
		end
		if questId and questId ~= 0 --[[ and not isComplete ]] then
			if not watchedOnly or IsQuestWatched(i) then

				local questTypeMarkup = QuestUtils_GetQuestTypeTextureMarkupString(questId);

				result[#result + 1] = {index = i, questId=questId, questTypeMarkup = questTypeMarkup, isComplete=isComplete, name = title, headerTitle = currentHeaderName, headerIndex = currentHeaderIndex}
			end
		end
	end
	
	return result
end


DugisQuestsDataProvider = CreateFromMixins(MapCanvasDataProviderMixin);

function DugisQuestsDataProvider:GetPinTemplate()
	return "QuestPinTemplate";
end

function DugisQuestsDataProvider:OnAdded(mapCanvas)
	MapCanvasDataProviderMixin.OnAdded(self, mapCanvas);

	self:RegisterEvent("QUEST_LOG_UPDATE");
	self:RegisterEvent("QUEST_WATCH_LIST_CHANGED");

	if not self.setFocusedQuestIDCallback then
		self.setFocusedQuestIDCallback = function(event, ...) self:SetFocusedQuestID(...); end;
	end
	if not self.clearFocusedQuestIDCallback then
		self.clearFocusedQuestIDCallback = function(event, ...) self:ClearFocusedQuestID(...); end;
	end
end

function DugisQuestsDataProvider:OnRemoved(mapCanvas)
	MapCanvasDataProviderMixin.OnRemoved(self, mapCanvas);
end

function DugisQuestsDataProvider:SetFocusedQuestID(questId)
	self.focusedQuestID = questId;
	self:RefreshAllData();
end

function DugisQuestsDataProvider:ClearFocusedQuestID(questId)
	self.focusedQuestID = nil;
	self:RefreshAllData();
end

function DugisQuestsDataProvider:OnEvent(event, ...)
	if event == "QUEST_LOG_UPDATE" then
		
	elseif event == "QUEST_WATCH_LIST_CHANGED" then
		self:RefreshAllData();
	elseif event == "QUEST_POI_UPDATE" then
		self:RefreshAllData();
	end
end

function DugisQuestsDataProvider:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate());
end

function DugisQuestsDataProvider:RefreshAllData(_, isInThread)

	local tempTable = {}

	if DGV.forcingMapChange then
		return
	end

	local pinsToHide = {}

	for i=1, #DGV.questsPool do 
		pinsToHide[DGV.questsPool[i]] = true
	end

	local mapID = self:GetMap():GetMapID();
	if not mapID then
		return;
	end

	if not WMT.DataProviders:IsTrackingEnabled(nil, 14) then
		return
	end

	local questsOnMap = DGV.GetAllActiveQuests()
	
	for i, questInfo in pairs(questsOnMap) do
		LuaUtils:RestIfNeeded(isInThread)
		local questId = questInfo.questId
		local x, y, mapID_ =  WMT:GetQuestPosition(questId)
		if x then
			x, y = Math:AvoidCircleOverlaping(x, y, questId, tempTable) 

			local questContinent = DGV.GetMapContinent_dugi(mapID_)
			local currentContinent = DGV.GetMapContinent_dugi(mapID)

			if questContinent == currentContinent then
				x, y = HBD:TranslateZoneCoordinates(x, y, mapID_, mapID, true)
				local pin = self:AddQuest(questId, x, y);
				DGV.questsPool[#DGV.questsPool + 1] = pin
				pinsToHide[pin] = nil
			end
		end
	end

	for pin in pairs(pinsToHide) do 
		pin:Hide()
	end
end

function DugisQuestsDataProvider:ShouldShowQuest(questId, mapType, doesMapShowTaskObjectives)
	if self.focusedQuestID and self.focusedQuestID ~= questId then
		return false;
	end
	if QuestUtils_IsQuestWorldQuest(questId) then
		if not doesMapShowTaskObjectives then
			return false;
		end
	end
	return MapUtil.ShouldMapTypeShowQuests(mapType);
end

function DugisQuestsDataProvider:OnCanvasSizeChanged()
end

function DugisQuestsDataProvider:AddQuest(questId, x, y, frameLevelOffset, targetMapId)
	local pin = self:GetMap():AcquirePin(self:GetPinTemplate());
	pin.questId = questId;

	local isSuperTracked = questId == DGV.superTrackedQuestID;
	local isComplete = IsQuestComplete(questId);

	GUIUtils.Quests:SetupQuestButton(pin, isSuperTracked, 30, 35, isSuperTracked and "yellow" or "brown")

	pin:SetFrameLevel(5001)
	pin:SetFrameStrata("TOOLTIP")

	pin:SetPosition(x, y);
	return pin;
end

QuestPinMixin = CreateFromMixins(MapCanvasPinMixin);

function QuestPinMixin:OnLoad()
	self.UpdateTooltip = self.OnMouseEnter;
end

local function ShowQuestTooltip(questId, onlyTooltip)
	local objectives = DGV.GetObjectivesInfo(questId)

	WorldMapTooltip:SetOwner(WorldMapFrame, "ANCHOR_CURSOR_RIGHT", 5, 2);
	WorldMapTooltip:AddLine(DGV.questId2Title[tonumber(questId)] or ("Quest: " .. questId), nil, nil, nil, true);

	for _, objective in pairs(objectives) do
		WorldMapTooltip:AddLine(" - " .. objective.text, 1, 1, 1, true);
	end

	WorldMapTooltip:Show();

	if DGV.hoveredQuestId ~= questId and not onlyTooltip then
		DGV.hoveredQuestId = questId
		UpdateTrackingFilters(true)
	end
end

function QuestPinMixin:OnMouseEnter()
	ShowQuestTooltip(self.questId, DGV.IsQuestReadyForTurnIn(self.questId))
end

function QuestPinMixin:OnMouseLeave()
	if tonumber(hoveredBulbQuestId) ~= tonumber(DGV.hoveredQuestId) or (DGV.hoveredQuestId == nil)  then
		WorldMapTooltip:Hide();
	end
	self:GetMap():TriggerEvent("ClearHighlightedQuestPOI");
	DGV.hoveredQuestId = nil
	UpdateTrackingFilters(true)
end

function QuestPinMixin:OnClick(button, b)
	DGV.OnQuestPOIClick(self.questId)
	UpdateTrackingFilters(true)
end


local DugisDropDown = LuaUtils.DugisDropDown

local lastPointIndex = 1
local trackingPoints = {}
local trackingMap = {}
WMT.trackingPoints = trackingPoints

WMT.essential = true

function WMT:Initialize()

    DGV.questId2Title = DugisGuideViewer.questId2Title_EN
    
    if GetLocale() == "frFR" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_FR
	elseif GetLocale() == "deDE" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_DE	
	elseif GetLocale() == "esES" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_ES	
	elseif GetLocale() == "esMX" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_ES		
	elseif GetLocale() == "itIT" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_IT		
	elseif GetLocale() == "itIT" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_IT	
	elseif GetLocale() =="zhCN" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_CN
	elseif GetLocale() =="zhTW" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_CN
	elseif GetLocale() =="koKR" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_KO	
	elseif GetLocale() =="ruRU" then 
        DGV.questId2Title = DugisGuideViewer.questId2Title_RU					
    end

	WorldMapFrame:AddDataProvider(DugisQuestsDataProvider)

	DugisGuideUser = DugisGuideUser or {}
	DugisGuideUser.excludedTrackingPoints =  DugisGuideUser.excludedTrackingPoints or {}

	local trackingIndex =
	{
		["Interface\\Minimap\\Tracking\\Auctioneer"] = 1,
		["Interface\\Minimap\\Tracking\\Banker"] = 2,
		["Interface\\Minimap\\Tracking\\BattleMaster"] = 3,
		["Interface\\Minimap\\Tracking\\Class"] = 4,
		["Interface\\Minimap\\Tracking\\FlightMaster"] = 5,
		["Interface\\Minimap\\Tracking\\Food"] = 6,
		["Interface\\Minimap\\Tracking\\Innkeeper"] = 7,
		["Interface\\Minimap\\Tracking\\Mailbox"] = 8,
		["Interface\\Minimap\\Tracking\\Poisons"] = 9,
		["Interface\\Minimap\\Tracking\\Profession"] = 10,
		["Interface\\Minimap\\Tracking\\Reagents"] = 11,
		["Interface\\Minimap\\Tracking\\Repair"] = 12,
		["Interface\\Icons\\tracking_wildpet"] = 13,
		
		[136452] = 1,  -- Auctioneer
		[136453] = 2,  -- Banker
		[136454] = 3,  -- BattleMaster
		[136455] = 4,  -- Class
		[136456] = 5,  -- FlightMaster
		[136457] = 6,  -- Food
		[136458] = 7,  -- Innkeeper
		[136459] = 8,  -- Mailbox
		[136462] = 9,  -- Poisons
		[136463] = 10, -- Profession
		[136464] = 11, -- Reagents
		[136465] = 12, -- Repair
		[613074] = 13  -- tracking_wildpet
		
	}

	local real_GetTrackingInfo = GetTrackingInfo
	do
		local i;

---------------------------------
----------- WOW Classic:---------
---------------------------------
--GetNumTrackingTypes not present. Todo: Check if needed/find replacement.
		
		for i=1,GetNumTrackingTypes() do
			local _,icon,_,info = real_GetTrackingInfo(i)
			
			if trackingIndex[icon] then
				trackingMap[i] = trackingIndex[icon]
			end
		end
	end		

	local function GetTrackingInfo(id)
		local map = {}

		map[1] = {"Auctioneer", 136452          , true}
		map[2] = {"Banker", 136453              , true}
		map[3] = {"Battlemaster", 136454        , true}
		map[4] = {L["Class Trainer"], [[Interface\MINIMAP\TRACKING\Class]], true}
		map[5] = {"Flight Master", 136456       , true}
		map[6] = {"Food & Drink", 136457        , true}
		map[7] = {"Innkeeper", 136458           , true}
		map[8] = {"Mailbox", 136459             , true}
		map[9] = {"Mailbox", 136459             , false}
		map[10] = {"Profession Trainers", 136463 , true}
		map[11] = {"Reagents", 136464            , true}
		map[12] = {"Repair", 136465              , true}
		map[13] = {"", 0                         , false}
		map[14] = {"Quests", [[Interface\MINIMAP\TRACKING\QuestBlob]]    , true}
		map[15] = {"Quests Objectives", [[Interface\AddOns\DugisGuideViewerZ\Artwork\bullet_white]]    , true}
		map[16] = {"Spirit Healer", [[Interface\WORLDSTATEFRAME\ColumnIcon-GraveyardDefend1]], true}
		map[17] = {"New Quests", [[Interface\AddOns\DugisGuideViewerZ\Artwork\accept]], true}

		return unpack(map[id])
	end

	local function UnspecifyMapName(mapName)
		if not mapName then return end
		local dropUnderscoreMapName = string.match(mapName, "[^_]*")
		if dropUnderscoreMapName~=mapName then return dropUnderscoreMapName end
	end
	WMT.UnspecifyMapName = UnspecifyMapName

	local GetProfessionName_cache = {}
	local function GetProfessionName(spellId)
		local result = GetProfessionName_cache[spellId]
		if not result then
			result = GetSpellInfo(spellId)
			GetProfessionName_cache[spellId] = result
		end
		return result or ""
	end

	local englishProfessionTable= setmetatable(
	{
		["2259"]	= "Alchemy",
		["3100"]	= "Blacksmithing",
		["7411"]	= "Enchanting",
		["4036"]	= "Engineering",
		["2108"]	= "Leatherworking",
		["3908"]	= "Tailoring",
		["2575"]	= "Mining",
		["8613"]	= "Skinning",
		["2550"]	= "Cooking",
		["3273"]	= "First Aid",
		["7731"]	= "Fishing",
		["2368"]	= "Herbalism",
	},
	{__index=function(t,k) rawset(t, k, k); return k; end})

	local DataProviders = {
		--["Mailbox"] = {},
		["Vendor"] = {},
		["ClassTrainer"] = {},
		["ProfessionTrainer"] = {},
		["Banker"] = {},
		["Battlemaster"] = {},
		["PetBattles"] = {},
		["Quest"] = {},
		["QuestObjective"] = {},
		["SpiritHealer"] = {},
		["NewQuests"] = {},
	}
	WMT.DataProviders = DataProviders
	
	function DataProviders.IterateProviders(invariant, control)
		while true do
			local value
			control,value = next(DataProviders, control)
			if not control then return end
			if type(value)=="table" then 
				return control,value 
			end
		end
	end
	
	function DataProviders:SelectProvider(trackingType, location, ...)
		for k,v in DataProviders.IterateProviders do
			if v.ProvidesFor and v:ProvidesFor(trackingType, location, ...) then
				return v
			end
		end
	end
	
	local function ValidateTrackingType(arg, ...)
		if not DataProviders:SelectProvider(arg) and tonumber(arg)~=8 then
			DGV:DebugFormat("WorldMapTracking invalid data", "|cffff2020tracking type|r", arg, "data", (strjoin(":", ...)))
		end
	end
	
	local function ValidateNumber(arg, ...)
		if not tonumber(arg) then
			DGV:DebugFormat("WorldMapTracking invalid data", "|cffff2020number|r", arg, "data", (strjoin(":", ...)))
		end
	end
	
	local function ValidateCoords(arg, ...)
		local x,y = DGV:UnpackXY(arg)
		if not y or x>1 or y>1 then
			DGV:DebugFormat("WorldMapTracking invalid data", "|cffff2020coord|r", arg, "data", (strjoin(":", ...)))
		end
	end

	local function RGBPercToHex(r, g, b)
		r = r <= 1 and r >= 0 and r or 0
		g = g <= 1 and g >= 0 and g or 0
		b = b <= 1 and b >= 0 and b or 0
		return string.format("%02x%02x%02x", r*255, g*255, b*255)
	end	

	DataProviders.IsTrackingCategoryTicket = function(trackingType)
		local res = DugisGuideViewer.chardb and DugisGuideViewer.chardb["trownsFolkTypeFilters"] and DugisGuideViewer.chardb["trownsFolkTypeFilters"][trackingType]
		return res
	end
	
	function DataProviders:IsTrackingEnabled(provider, trackingType, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.IsTrackingEnabled then
			return provider:IsTrackingEnabled(trackingType, ...)
		else
			return DataProviders.IsTrackingCategoryTicket(trackingType)
		end
	end
	
	function DataProviders:GetTooltipText(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.GetTooltipText then
			return provider:GetTooltipText(trackingType, location, ...)
		else
			return (GetTrackingInfo(trackingType))
		end
	end

	function DataProviders:ShouldShow(provider, trackingType, location, ...)
		ValidateTrackingType(trackingType, trackingType, location, ...)
		ValidateCoords(location, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.ShouldShow then
			return provider:ShouldShow(trackingType, location, ...)
		else
			return DGV:CheckRequirements(...)
		end
	end
	
	function DataProviders:GetIcon(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.GetIcon then
			return provider:GetIcon(trackingType, location, ...)
		else
			return select(2,GetTrackingInfo(trackingType))
		end
	end
	
	function DataProviders:GetIconScale(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)

		if provider and provider.GetIconScale then
			return provider:GetIconScale(trackingType, location, ...)
		end
	end
	
	function DataProviders:ShouldShowMinimap(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.ShouldShowMinimap then
			return provider:ShouldShowMinimap(trackingType, location, ...)
		else
			return false
		end
	end
	
	function DataProviders:GetNPC(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.GetNPC then
			return provider:GetNPC(trackingType, location, ...)
		else return end
	end
	
	function DataProviders:GetDetailIcon(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.GetDetailIcon then
			return provider:GetDetailIcon(trackingType, location, ...)
		else return end
	end
	
	function DataProviders:GetCustomTrackingInfo(provider, trackingType, location, ...)
		provider = provider or self:SelectProvider(trackingType, location, ...)
		if provider and provider.GetCustomTrackingInfo then
			return provider:GetCustomTrackingInfo(trackingType, location, ...)
		else return end
	end

	local function GetNPCTT1(trackingType, location, npc)
		if DGV.GetLocalizedNPC then
			return DGV:GetLocalizedNPC(npc)
		end
	end

	function DataProviders.QuestObjective:ProvidesFor(trackingType)
		return trackingType==15
	end	

	function DataProviders.SpiritHealer:ProvidesFor(trackingType)
		return trackingType==16
	end	

	function DataProviders.NewQuests:ProvidesFor(trackingType)
		return trackingType==17
	end	

	function DataProviders.Vendor:ProvidesFor(trackingType)
		return trackingType==1 or trackingType==5 or trackingType==6  or trackingType==7 or
			trackingType==9 or trackingType==11 or trackingType==12
	end

	function DataProviders.Quest:GetTooltipText(questType, coordinates, questId, unitID, minLevel, classMask, raceMask)
		local color
		if questId then
			local level = DGV:GetQuestLevel(tonumber(questId))			
			if level and level > 0 then
				color = GetQuestDifficultyColor(level)
			end
		end		
		
		if color then 
			color = RGBPercToHex(color.r, color.g, color.b)
		else 
			color = "ffd200"
		end	
		
		local questPart = "|cff" .. color  .. (DGV.questId2Title[tonumber(questId)] or ("Quest:"..questId)) .. "|r"
		local npcPart = (DugisGuideViewer:GetLocalizedNPC(unitID) or ("NPC:" .. unitID))
		
		if tonumber(minLevel) > UnitLevel("player") then 
			local minLevel = "|cffff0000Requires level "..minLevel.."|r"
			return questPart, npcPart, minLevel
		else
			return questPart, npcPart.."\n|cff11ff11Available|r"
		end
	end

	function DataProviders.Quest:GetNPC(_, _, _, unitID)
		return unitID
	end

	function DataProviders.NewQuests:GetNPC(_, _, _, unitID, _, _, _)
		return unitID 
	end

	function DataProviders.NewQuests:GetIcon(_, coord, questId, unitID, minLevel, lvl, zone, type)
		local playerLevel = UnitLevel("player")
		minLevel = tonumber(minLevel)
		local isLowLevel = (playerLevel - (minLevel or 0)) >= 10

		local filter = nil

		if isLowLevel and DataProviders.IsTrackingCategoryTicket(18) then
			filter = "dark"
		end
		
		if type == "end" then
			return [[Interface\AddOns\DugisGuideViewerZ\Artwork\turnin]], filter
		elseif minLevel and tonumber(minLevel) and UnitLevel("player") and tonumber(minLevel) > UnitLevel("player") then 
			return [[Interface\AddOns\DugisGuideViewerZ\Artwork\accept_g]], filter
		end
		
		return [[Interface\AddOns\DugisGuideViewerZ\Artwork\accept]], filter
	end
	
	function DataProviders.QuestObjective:GetTooltipText(questType, coord, questId, unitID, minLevel, itemId, type)
		local color
		if questId then
			local level = DGV:GetQuestLevel(tonumber(questId))			
			if level and level > 0 then
				color = GetQuestDifficultyColor(level)
			end
		end		
		
		if color then 
			color = RGBPercToHex(color.r, color.g, color.b)
		else 
			color = "ffd200"
		end
		
		local questPart = "|cff" .. color  .. (DGV.questId2Title[tonumber(questId)] or ("Quest:"..questId)) .. "|r"
		local minLevel = "Requires level "..minLevel

		if type == "O" and itemId and itemId ~= "" then
			local text = GetItemInfo(tonumber(itemId))
			return text, questPart--.."\n" .. minLevel
		end	

        local npcPart

		if type ~= "MO"	 then
			npcPart = (DugisGuideViewer:GetLocalizedNPC(unitID) or ("NPC:" .. unitID))
		else
			npcPart = DGV:GetLocalizedObject(unitID) or ("Object:" .. unitID) 
		end
		
		return npcPart, questPart-- .. "\n" .. minLevel
	end 


	function DataProviders.QuestObjective:GetNPC(questType, coord, questId, unitID, _, itemId, type)
		if type == "O" or type == "MO" then
			return
		end		
		return unitID
	end

	function DataProviders.SpiritHealer:GetNPC()
		return 6491
	end

	function DataProviders.SpiritHealer:GetTooltipText()
		return DugisGuideViewer:GetLocalizedNPC(6491)
	end

	local _, unitClass = UnitClass("player")
	local classMap = {
		WARRIOR = 1,   -- 00000000001
		PALADIN = 2,   -- 00000000010
		HUNTER = 4,    -- 00000000100
		ROGUE = 8,     -- 00000001000
		PRIEST = 16,   -- 00000010000
		SHAMAN = 64,   -- 00001000000
		MAGE = 128,    -- 00010000000
		WARLOCK = 256, -- 00100000000
		--JU_WRATCH - not sure what could be here - it just prevent lua error for Seildenn character
		DEATHKNIGHT = 512, -- 01000000000
		DRUID = 1024   -- 10000000000
	}

	unitClass = classMap[unitClass]
	function IsClassValid(classBits)
		local shouldShow = true

		--AND operation on bits
		if tonumber(classBits) and bit.band(tonumber(classBits), unitClass) ~= unitClass then
			shouldShow = false
		end
		
		return shouldShow
	end

	local _, unitRace = UnitRace("player")
	local mapRace = {
		Human = 1,    --00000001
		Orc = 2,      --00000010
		Dwarf = 4,    --00000100
		NightElf = 8, --00001000
		Scourge = 16, --00010000
		Tauren = 32,  --00100000
		Gnome = 64,   --01000000
		Troll = 128,   --10000000
		BloodElf = 512,  
		Draenei = 1024,
	}
	unitRace = mapRace[unitRace]

	function IsRaceValid(raceBits)
		local shouldShow = true

		--AND operation on bits
		if tonumber(raceBits) and bit.band(tonumber(raceBits), unitRace) ~= unitRace then
			shouldShow = false
		end
		
		return shouldShow
	end

	function DataProviders.Quest:ShouldShow(questType, coordinates, questId, unitID, minLevel, classBits, raceBits)
		local shouldShow = true

		--AND operation on bits
		if tonumber(classBits) and bit.band(tonumber(classBits), unitClass) ~= unitClass then
			shouldShow = false
		end

		--AND operation on bits
		if tonumber(raceBits) and bit.band(tonumber(raceBits), unitRace) ~= unitRace then
			shouldShow = false
		end
		
		return shouldShow
	end

	function DataProviders.Vendor:ShouldShow(trackingType, location, npc, subZone, ...)
		ValidateNumber(npc, trackingType, location, npc, subZone, ...)
		if not DGV:CheckRequirements(...) then return end
		local class = select(2,UnitClass("player"))
		if (trackingType==9 and class~="ROGUE") then return false end
		return true
	end

	function DGV:GetFlightMasterName(npc)
		return DataProviders.Vendor:GetTooltipText(5, nil, npc)
	end

	function DataProviders.Vendor:GetTooltipText(trackingType, ...)
		return GetNPCTT1(trackingType, ...) or (GetTrackingInfo(trackingType)) 
	end
	
	function DataProviders.Vendor:GetNPC(trackingType, location, npc)
		return npc
	end

	function DataProviders.ClassTrainer:ProvidesFor(trackingType)
		return trackingType==4
	end

	local function GetGildedNPCTooltip(guildFunc, ...)
		local tt1 = GetNPCTT1(...)
		local tt2;
		if tt1 then tt2 = "|cffffffff<"..guildFunc(...)..">|r" end
		return tt1 or guildFunc(...), tt2
	end
	
	function DataProviders.ClassTrainer:GetTooltipText(trackingType, location, npc, class, gender)
		local genderString = ""
		if gender=="F" then genderString=" Female" end
		return GetGildedNPCTooltip(
			function(trackingType, location, npc, class) return L[class.." Trainer"..genderString] end,
					trackingType, location, npc, class, gender)
	end

	function DataProviders.ClassTrainer:ShouldShow(trackingType, location, npc, class)
		ValidateNumber(npc, trackingType, location, npc, class)
		return class:lower()==select(2,UnitClass("player")):lower() and true
	end
	
	function DataProviders.ClassTrainer:GetNPC(trackingType, location, npc)
		return npc
	end
	
	function DataProviders.ClassTrainer:IsTrackingEnabled()
		if not DugisGuideViewer.chardb["trownsFolkTypeFilters"] then 
			DugisGuideViewer.chardb["trownsFolkTypeFilters"] = {}
		end	
		return DugisGuideViewer.chardb["trownsFolkTypeFilters"][4]
	end
	
	function DataProviders.NewQuests:IsTrackingEnabled()
		return DataProviders.IsTrackingCategoryTicket(18) or DataProviders.IsTrackingCategoryTicket(17)
	end
	
	function DataProviders.ClassTrainer:GetIcon()
		return "Interface\\Minimap\\Tracking\\Class"
	end
	
	function DataProviders.QuestObjective:GetIconScale()
		return 0.4, 0.3
	end

	function DataProviders.QuestObjective:ShouldShow(trackingType, coord, questId, unitId, minLevel, id, type, zone)
		if WorldMapFrame:GetMapID() == tonumber(zone) and GetQuestLogIndexByID(tonumber(questId)) ~= 0 and WorldMapFrame:GetMapID() == tonumber(zone) and not DGV.IsQuestReadyForTurnIn(questId) then
			return true
		end
	end

	function DataProviders.SpiritHealer:ShouldShow(trackingType, coord, questId, unitId, minLevel, id, type, zone)
		return true
	end

	local function RequiredQuestCompleted(questIdToCheck)
		local quests = WorldTrackingRawQuests
		local questData = quests[questIdToCheck]
		local preIds = questData.pre 
		if preIds then
			if tonumber(preIds) then
				preIds = {preIds}
			end

			for _, pre in pairs(preIds) do
				if not completedQuests[tonumber(pre)] then
					return false
				end
			end
		end
		return true
	end

	function DataProviders.NewQuests:ShouldShow(trackingType, coord, questId, unitId, min, lvl, zone, type)
		if type == "start" then
			local questLogId = DGV.QuestId2QuestLogId(questId)

			local playerLevel = UnitLevel("player")
			if min == "" then min=nil end
			if lvl == "" then lvl=nil end
			local minLevel = min or lvl or playerLevel or 0
			local maxLevel = lvl or min or playerLevel or 0
	
			minLevel = tonumber(minLevel)
			maxLevel = tonumber(maxLevel)
			local playerLevel = UnitLevel("player")

			local isLowLevel = (playerLevel - minLevel) >= 10
			local isHighLevel = not isLowLevel

			if questLogId  --already accepted quests
			or completedQuests[tonumber(questId)] --completed quests
			or (minLevel and playerLevel + 2 < minLevel) -- not available quests

			or (isLowLevel and not DataProviders.IsTrackingCategoryTicket(18))
			or (isHighLevel and not DataProviders.IsTrackingCategoryTicket(17))

			or math.abs(minLevel - maxLevel) >= 15  --festival
			or not RequiredQuestCompleted(tonumber(questId)) then 
				return false
			end 

			return true
		end

		if type == "end" then
			if DGV.IsQuestReadyForTurnIn(questId) then
				return true
			end

			return false
		end
	end 

	function DataProviders.NewQuests:GetTooltipText(_, coord, questId, unitID, minLevel)
		local color
		if questId then
			local level = DGV:GetQuestLevel(tonumber(questId))			
			if level and level > 0 then
				color = GetQuestDifficultyColor(level)
			end
		end		
		
		if color then 
			color = RGBPercToHex(color.r, color.g, color.b)
		else 
			color = "ffd200"
		end	
	
		local questPart = "|cff" .. color  .. (DGV.questId2Title[tonumber(questId)] or ("Quest:"..questId)) .. "|r"
		local npcPart = (DugisGuideViewer:GetLocalizedNPC(unitID) or ("NPC:" .. unitID))
		local levelPart = ""

		if minLevel then
			levelPart = "Requires level "..minLevel
		end
		if (tonumber(minLevel) or 0) > UnitLevel("player") then 
			local levelPart = "|cffff0000Requires level "..minLevel.."|r"
			return questPart, npcPart, levelPart
		else
			return questPart, npcPart.."\n|cff11ff11Available|r"
		end
	end

	function DataProviders.ClassTrainer:ShouldShowMinimap()
		return true
	end

	function DataProviders.ProfessionTrainer:ProvidesFor(trackingType)
		return trackingType==10
	end
	
	function DataProviders.ProfessionTrainer:GetTooltipText(trackingType, location, npc, spell, gender)
		local genderString = ""
		if gender=="F" then genderString=" Female" end
		return GetGildedNPCTooltip(
			function(trackingType, location, npc, spell) return L[englishProfessionTable[spell].." Trainer"..genderString] end,
					trackingType, location, npc, spell)
	end
	
	function DataProviders.ProfessionTrainer:ShouldShow(trackingType, location, npc, spell, gender, ...)
		ValidateNumber(npc, trackingType, location, npc, spell, gender, ...)
		if not DGV:CheckRequirements(...) then return end
		local spellNum = tonumber(spell)
		local class = select(2,UnitClass("player"))
		if (spell=="Portal" and class~="MAGE") or
			(spell=="Pet" and class~="HUNTER")
		then return false end
		--[[if not spellNum then return true end
		local prof1, prof2 = GetProfessions()
		return (not prof1) or (not prof2) or --unchosen professions
			spellNum==2550 or spellnum==3273 or spellNum==131474 or --cooking,first aid,fishing,
			IsUsableSpell(GetSpellInfo(spellNum))]]
		return true
	end
	
	function DataProviders.ProfessionTrainer:GetNPC(trackingType, location, npc)
		return npc
	end

	function DataProviders.Banker:ProvidesFor(trackingType)
		return trackingType==2
	end

	function DataProviders.Quest:ProvidesFor(trackingType)
		return trackingType==14
	end
	
	function DataProviders.Banker:GetTooltipText(...)
		return GetGildedNPCTooltip(
			function(...) return L["Banker"] end, ...)
	end
	
	function DataProviders.Banker:GetNPC(trackingType, location, npc)
		return npc
	end

	function DataProviders.Battlemaster:ProvidesFor(trackingType)
		return trackingType==3
	end
	
	function DataProviders.Battlemaster:GetTooltipText(...)
		return GetGildedNPCTooltip(
			function(...) return L["Battlemaster"] end, ...)
	end
	
	function DataProviders.Battlemaster:GetNPC(trackingType, location, npc)
		return npc
	end
	--Comment Start for DQE	

	--Comment end for DQE
	local petJournalLookup = {}
	--_G["BATTLE_PET_NAME_"..i]
	function DGV:PopulatePetJournalLookup()


---------------------------------
----------- WOW Classic:---------
---------------------------------  
--PET_JOURNAL_LIST_UPDATE is not present. Todo: Check if needed/find replacement.		
		--DGV:UnregisterEvent("PET_JOURNAL_LIST_UPDATE")


		DGV:DebugFormat("PopulatePetJournalLookup")
		--Legion beta cheap fix
		--C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
		--C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false)
		--C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true)
		--C_PetJournal.AddAllPetSourcesFilter()
		wipe(petJournalLookup)

---------------------------------
----------- WOW Classic:---------
---------------------------------  
--C_PetJournal and PET_JOURNAL_LIST_UPDATE are not present. Todo: Check if needed/find replacement.			
--[[
		for i=1,C_PetJournal.GetNumPets(false) do
			local _,speciesID,collected,_,_,_,_,speciesName,_,familyType,creatureID,_,flavorText = 
				C_PetJournal.GetPetInfoByIndex(i)
			petJournalLookup[speciesID] = 
					string.format("%d:%s:%s:%d:%d", creatureID, speciesName, flavorText:gsub("(:)", "%%3A"), familyType, collected and 1)
		end


		DGV:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
		]]
	end
	
	local lastNumPets = 0
	function DGV:PET_JOURNAL_LIST_UPDATE()
		local _, num = C_PetJournal.GetNumPets(false)
		if num~=lastNumPets then
			DGV:PopulatePetJournalLookup()
			lastNumPets = num
		end
	end
	
	--[[function DGV:LOOT_CLOSED()
		WMT:UpdateTrackingMap()
	end	
	
	function DGV:LOOT_SLOT_CLEARED()
		WMT:UpdateTrackingMap()
	end]]
	
	function DataProviders.PetBattles:ProvidesFor(trackingType)
		return trackingType=="P"
	end
	
	function DataProviders.PetBattles:GetTooltipText(trackingType, location, speciesID, extraToolTip)
		local value = petJournalLookup[tonumber(speciesID)]
		if not value and speciesID then
		   local speciesName, speciesIcon, petType, companionID, tooltipSource, tooltipDescription, isWild, canBattle, isTradeable, isUnique, obtainable, creatureDisplayID = C_PetJournal.GetPetInfoBySpeciesID(tonumber(speciesID))
			petJournalLookup[tonumber(speciesID)] = 
				string.format("%d:%s:%s:%d:%d", companionID, speciesName, tooltipDescription:gsub("(:)", "%%3A"), petType, nil)
			value = petJournalLookup[tonumber(speciesID)]
		elseif not speciesID then
			return false
		end
		local _, speciesName, flavorText, familyType, collected = strsplit(":", value)
		if flavorText then
			flavorText = format("\"%s\"", flavorText:gsub("(%%3A)", ":"))
		end
		if extraToolTip=="" then extraToolTip=nil end
		if extraToolTip then
			extraToolTip = format("|cffffffff%s", extraToolTip)
		end
		if familyType then
			DGV:DebugFormat("PetBattles:GetTooltipText", "familyType", familyType)
			familyType = format("|cffffffff%s", _G["BATTLE_PET_NAME_"..familyType])
		end
		if collected then
			if tonumber(collected)>0 then
				collected = format("|cff20ff20%s", L["Collected"])
			else
				collected = format("|cffff2020%s", L["Not Collected"])
			end
		end
		return speciesName, nil, familyType, collected, extraToolTip -- no flavorText for now. 
	end
		
    local function getPetTypeFilters()
        if not DugisGuideViewer.chardb["petTypeFilters"] then
            DugisGuideViewer.chardb["petTypeFilters"] = {
                Humanoid     = true,
                Dragon       = true,
                Flying       = true,
                Undead       = true,
                Critter      = true,
                Magical      = true,
                Elemental    = true,
                Beast        = true,
                Aquatic      = true,
                Mechanical   = true
            }              
        end     
        return DugisGuideViewer.chardb["petTypeFilters"]
    end
    
    if DugisGuideViewer.chardb["showCollectedPets"] == nil then
        DugisGuideViewer.chardb["showCollectedPets"] = true
    end 
    
    if DugisGuideViewer.chardb["showNotCollectedPets"] == nil then
        DugisGuideViewer.chardb["showNotCollectedPets"] = true
    end

	function DataProviders.PetBattles:ShouldShow(trackingType, location, speciesID, ...)
		ValidateNumber(speciesID, trackingType, location, speciesID, ...)
   		return false
	end
	
	function DataProviders.PetBattles:IsTrackingEnabled()
		for i=1, GetNumTrackingTypes() do 
			local name, texture, active, category = real_GetTrackingInfo(i); 
			if texture == 613074 then
				return active
			end
		end
	end
	
	function DataProviders.PetBattles:GetIcon(trackingType, location, speciesID, criteriaIndex, extraToolTip, ...)
		return DataProviders.PetBattles:GetDetailIcon(_, _, speciesID)
	end
	
	function DataProviders.PetBattles:ShouldShowMinimap()
		return false
	end
	
	function DataProviders.PetBattles:GetNPC(trackingType, location, speciesID)
		local value = petJournalLookup[tonumber(speciesID)]
		if not value and speciesID then
		   local speciesName, speciesIcon, petType, companionID, tooltipSource, tooltipDescription, isWild, canBattle, isTradeable, isUnique, obtainable, creatureDisplayID = C_PetJournal.GetPetInfoBySpeciesID(tonumber(speciesID))
			petJournalLookup[tonumber(speciesID)] = 
				string.format("%d:%s:%s:%d:%d", companionID, speciesName, tooltipDescription:gsub("(:)", "%%3A"), petType, nil)
			value = petJournalLookup[tonumber(speciesID)]
		elseif not speciesID then
			return false
		end
		return tonumber((strsplit(":", value)))
	end
	
	function DataProviders.PetBattles:GetDetailIcon(trackingType, location, speciesID)
		--if not petJournalLookup[tonumber(speciesID)] then return end
		local familyType
		if petJournalLookup[tonumber(speciesID)] then 
			familyType = tonumber((select(4, strsplit(":", petJournalLookup[tonumber(speciesID)]))))
		elseif speciesID then 
			familyType = tonumber((select(3, C_PetJournal.GetPetInfoBySpeciesID(speciesID))))
		end 
		if PET_TYPE_SUFFIX[familyType] then
			return "Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[familyType];
		else
			return "Interface\\PetBattles\\PetIcon-NO_TYPE";
		end
	end

	function DGV:UnpackXY(coord)
-- 		if not tonumber(coord) then
-- 		  DGV:DebugFormat("UnpackXY", "coord", coord, "stack", debugstack())
-- 		end
		if type(coord)=="string" then
			local xString,yString = coord:match("(%d+.%d+),(%d+%.%d+)")
			if yString then
				return tonumber(xString)/100, tonumber(yString)/100
			end
		end
		if not tonumber(coord) then return end
		local factor 
		if tonumber(coord) > 99999999 then
			factor = 2^16
		else 
			factor = 10000 --Handy notes coord
		end
		local x,y =  floor(coord / factor) / factor, (coord % factor) / factor
		--DGV:DebugFormat("GetXY", "x", x, "y", y)
		return x,y
	end


	local questId2Zone = {}
	local function UpdateBulbs(mapID)

		local isSuperQuestReady = DGV.IsQuestReadyForTurnIn(DGV.superTrackedQuestID)
		local isHoveredQuestReady = DGV.IsQuestReadyForTurnIn(DGV.hoveredQuestId)

		if not WMT.DataProviders:IsTrackingEnabled(nil, 14) then
			GUIUtils.Drawing:ClearAllShapes()
			return
		end

		local quest2Points = {}
		for k, point in pairs(trackingPoints) do
			local trackingType, coord, questId, _,_,_,_,zone = unpack(point.args)
			
			if trackingType == 15 
			and point.shown then

				local shown = false
				if 	tonumber(questId) == tonumber(DGV.superTrackedQuestID)
				and not isSuperQuestReady
				and DGV.QuestId2QuestLogId(DGV.superTrackedQuestID)
				then
					shown = true
					local targetPoints =quest2Points[questId]
					if not targetPoints then
						targetPoints = {}
						quest2Points[questId] = targetPoints
					end
					
					local x, y = DGV:UnpackXY(coord)
					targetPoints[#targetPoints + 1] = {x=x, y=y}
					questId2Zone[questId] = zone
				end

				if not shown and
				tonumber(questId) == tonumber(DGV.hoveredQuestId)
				and not isHoveredQuestReady
				and DGV.QuestId2QuestLogId(DGV.hoveredQuestId) then
					shown = true
					local targetPoints =quest2Points[questId]
					if not targetPoints then
						targetPoints = {}
						quest2Points[questId] = targetPoints
					end
					local x, y = DGV:UnpackXY(coord)
					targetPoints[#targetPoints + 1] = {x=x, y=y}
					questId2Zone[questId] = zone
				end

			end
		end

		GUIUtils.Drawing:ClearAllShapes()
		if DGV:UserSetting(DGV_SHOW_OBJ_BULBS) then
			for questId, points in pairs(quest2Points) do 
				if tonumber(questId2Zone[questId]) == tonumber(mapID) then
					local pointGroups = Math:Points2PointsGroups(points)

					for i, pointGroup in pairs(pointGroups) do
						if #points >= objectivesBulbThreshold then 
							GUIUtils.Drawing:DrawPointsCould("worldmapObjectivePoints"..questId..i..mapID, pointGroup, DugisMapOverlayFrame, {0.5, 0.5, 1, 0.5},
							function()
								hoveredBulbQuestId = questId
								ShowQuestTooltip(questId)
							end, function()
								hoveredBulbQuestId = nil
								WorldMapTooltip:Hide();
							end, true, questId)
						end
					end
				end
			end
		end
	end


	local function GetPointKey(trackingType, pointArgs) 
		local a = pointArgs
		if trackingType == 17 then return (a[1] or "")..(a[2] or "")..(a[3] or "")..(a[4] or "")..(a[5] or "")..(a[6] or "")..(a[7] or "")..(a[8] or "") end
		return (a[1] or "")..(a[2] or "")..(a[3] or "")
	end

	local lastUpdate = GetTime()
	function UpdateTrackingFilters(onlyBulbs)

		if DGV.forcingMapChange then
			return
		end

		local mapID, level = WorldMapFrame:GetMapID()
		if onlyBulbs then
			UpdateBulbs(mapID)
			return
		end

		completedQuests = GetQuestsCompleted() 

		local colors = {
			{ 0.902,0.6902,0.6667 } ,
			{ 0.6627,0.1961,0.149 } ,
			{ 0.7647,0.6078,0.8275},
			{ 0.3882,0.2235,0.4549},
			{ 0.498,0.702,0.8353 },
			{ 0.1608,0.502,0.7255 } ,
			{ 0.2824,0.7882,0.6902} ,
			{ 0.9686,0.8627,0.4353} ,
			{ 0.9451,0.7686,0.0588} ,
			{ 0.8275,0.3294,0},
			{ 0.702,0.7137,0.7176 } ,
			{ 1,0,0 },
			{ 0,1,0 },
			{ 0,0,1 },
			{ 1,1,1 },
			{ 0,0,0 }, 
		}
		local colors_buff = {}
		local colorIndex = 1

		LuaUtils:QueueThreadCancelOld("UpdateTrackingFilters", function()
		for _,point in pairs(trackingPoints) do
			local trackingType, coord, questId, b, c = unpack(point.args)

            local pointKey = GetPointKey(trackingType, point.args) 
			LuaUtils:RestIfNeeded(true)
			if 
				point.shown and
				DataProviders:IsTrackingEnabled(point.provider, unpack(point.args)) and
				DugisGuideUser.excludedTrackingPoints[pointKey] ~= true and
				DataProviders:ShouldShow(point.provider, unpack(point.args))
			then

				local objectiveColor = {1,1,1}
				local r,g,b

				r, g, b = unpack(objectiveColor)

				if trackingType == 15 then
					objectiveColor = colors_buff[questId]
					if not objectiveColor then
						objectiveColor = colors[colorIndex] or { math.random() ,math.random() ,math.random() }
						colors_buff[questId]=objectiveColor
						colorIndex = colorIndex + 1
					end

					r, g, b = unpack(objectiveColor)

					if point.args[7] == "MO" or point.args[7] == "O" then
						r = r * 1.8
						g = g * 1.8
						b = b * 1.8
						if r > 1 then r = 1 end
						if g > 1 then g = 1 end
						if b > 1 then b = 1  end
					end
				end				

				if not point:IsShown() then
					local icon, filter = DataProviders:GetIcon(point.provider, unpack(point.args))
					local scale, minimapScale = DataProviders:GetIconScale(point.provider, unpack(point.args))
					scale, minimapScale = scale or 1, minimapScale or 1
					local size = 14 * scale
					local size1 = 14 * minimapScale
                    
                    if point.overridenIcon == "P" then
                        icon = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\ObjectIconsAtlas"
                    end
					
                    local xn1, yn1, xn2, yn2 = 0.068359375, 0.9296875, 0.126953125, 0.98828125
                    
					if trackingType == "P" then
						point.icon:SetTexture(icon)
                        if point.overridenIcon then
                            point.icon:SetTexCoord(xn1, xn2, yn1, yn2)
                        else
                            point.icon:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000)
                        end
					else
						point.icon:SetTexture(icon)
                        if point.overridenIcon then
                            point.icon:SetTexCoord(xn1, xn2, yn1, yn2)
                        else
                            point.icon:SetTexCoord(0, 1, 0, 1)
                        end
					end

					if filter == "dark" then
						r, g ,b = r * 0.6, g * 0.6, b * 0.6
					end

					point.icon:SetVertexColor(r, g ,b)

					point:SetHeight(size)
					point:SetWidth(size)
                    --Minimap icons no longer needed in WRATH Classic 
					--[[if point.minimapPoint then
						point.minimapPoint.icon:SetTexture(icon)
						point.minimapPoint.icon:SetVertexColor(r, g ,b)
                        
                        if point.minimapPoint.overridenIcon == "P" then
                            point.minimapPoint.icon:SetTexCoord(xn1, xn2, yn1, yn2)
                        end
                        
						point.minimapPoint:SetHeight(size1)
						point.minimapPoint:SetWidth(size1)
						point.minimapPoint:Show()
						point.minimapPoint.hidden = false
							
						local x, y = DGV:UnpackXY(coord)
						DugisGuideViewer:PlaceIconOnMinimap(point.minimapPoint, point.mapId, level, x, y, true, false)
					end]]
					local x, y = DGV:UnpackXY(coord)
					
					local placeToShow = HBD_PINS_WORLDMAP_SHOW_PARENT

					if trackingType == 17 then
						placeToShow = HBD_PINS_EVERYWHERE_EXCEPT_WORLD_MAP
					end

					DGV:PlaceIconOnWorldMap(WorldMapButton, point,  point.mapId, level, x, y , nil, nil, placeToShow)
				end

				point.visible = true

			else
				point.visible = false
				if point.minimapPoint then
					point.minimapPoint:Hide()
					point.minimapPoint.hidden = true
				end
				
			end

			HBD:RefreshPin(point)
		end

		end, function()
			DugisQuestsDataProvider:RefreshAllData()
			UpdateBulbs(mapID)
			if DGV.Modules.GPSArrowModule and DGV.Modules.GPSArrowModule.UpdateQuestPOIs then
				LuaUtils:QueueThreadCancelOld("UpdateTrackingFilters_UpdateQuestPOIs", function()
					DGV.Modules.GPSArrowModule:UpdateQuestPOIs(true)
				end)
			end
		end)

	end

---------------------------------
----------- WOW Classic:---------
---------------------------------	
--SetTracking and ClearAllTracking not present. Todo: Check if needed/find replacement.	

	--hooksecurefunc("SetTracking", UpdateTrackingFilters)
	--hooksecurefunc("ClearAllTracking", UpdateTrackingFilters)

	local function AddWaypoint(point, extraData, onEnd)
        if DGV:IsModuleRegistered("Target") and DGV:UserSetting(DGV_TARGETBUTTON) then
			local npcId = DataProviders:GetNPC(point.provider, unpack(point.args))
			
			if npcId then
				DGV:SetNPCTarget(npcId)
				if DGV:UserSetting(DGV_TARGETBUTTONSHOW) then  
                    DGV.DoOutOfCombat(function()
                        DugisGuideViewer.Modules.Target.Frame:Show()
                    end)
				end

				if DGV:IsModuleRegistered("ModelViewer") and DGV.Modules.ModelViewer.Frame and DGV.Modules.ModelViewer.Frame:IsShown() then
					DGV.Modules.ModelViewer:SetModel(npcId)
				end
			end
		end
    
		local x, y = DGV:UnpackXY(point.args[2])
		DGV:AddCustomWaypoint(
			x, y, DataProviders:GetTooltipText(point.provider, unpack(point.args)),
			DGV:GetCurrentMapID(), nil, nil, nil, extraData, onEnd )
	end

--[[	function WMT:GetAchievementProgress(achievementID)
		local numCompleted = 0
		
		if achievementID and achievementID ~= "" then
			local num = GetAchievementNumCriteria(achievementID)
			LuaUtils:loop(num, function(index)
				local _, _, completed = GetAchievementCriteriaInfo(achievementID, index)
				
				if completed then
					numCompleted = numCompleted + 1
				end
			end)
		end
		return numCompleted
	end ]] -- This create stuttering issue with some character, removed for now
	
	local function point_OnClick(self, button)
		local clickedButton = self

		self = self.point or self
		if button == "RightButton" then
			local menu = DGV.ArrowMenu:CreateMenu("world_map_point_menu")
			DGV.ArrowMenu:CreateMenuTitle(menu,
					DataProviders:GetTooltipText(self.provider, unpack(self.args)))
			local setWay = DGV.ArrowMenu:CreateMenuItem(menu, L["Set as waypoint"])
			setWay:SetFunction(function ()
				DGV:RemoveAllWaypoints()
				AddWaypoint(self, extraData)
			end)
			local addWay = DGV.ArrowMenu:CreateMenuItem(menu, L["Add waypoint"])
			addWay:SetFunction(function () AddWaypoint(self)  end)
            local pointKey = GetPointKey(self.args[1], self.args) 
			local removeTracking = DGV.ArrowMenu:CreateMenuItem(menu, L["Remove tracking"])
			removeTracking:SetFunction(function () 
                DugisGuideUser.excludedTrackingPoints[pointKey] = true
                if self.minimapPoint then
                    DGV:RemoveIconFromMinimap(self.minimapPoint)
                end
                DGV:RemoveWorldMapIcon(self)    
                WMT:UpdateTrackingMap()
            end)
            
			local trackingTypeText = (GetTrackingInfo(self.args[1]))
			if trackingTypeText then
				local untrack = DGV.ArrowMenu:CreateMenuItem(menu,
					string.format(L["Remove %s Tracking"], trackingTypeText))
				untrack:SetFunction(function ()
					DugisGuideViewer.chardb["trownsFolkTypeFilters"] = DugisGuideViewer.chardb["trownsFolkTypeFilters"] or {}
					DugisGuideViewer.chardb["trownsFolkTypeFilters"][self.args[1]] = false
					UpdateTrackingFilters()
				end)
			end
			menu:ShowAtCursor()
		elseif button == "LeftButton" then
			if not IsShiftKeyDown() then
				DGV:RemoveAllWaypoints()
			end

			if self.args[1] == 15 then
				local unitID = DataProviders:GetNPC(self.provider, unpack(self.args))
				
				if unitID then
					DGV.Modules.ModelViewer:SetModel(unitID)
					DGV.Modules.ModelViewer:Finalize()
				end
			end
		
			AddWaypoint(self, nil, function()
				local icon = clickedButton.icon:GetTexture() 
				local iconCoords = {clickedButton.icon:GetTexCoord()}
				local extraData = {icon = icon, iconCoords = iconCoords}
				SetExtraData(extraData) 
			end)
		end
	end
	
	local toolTipIconTexture
	local overPoint
	local function DugisWaypointTooltip_OnShow()
		if DugisWaypointTooltipTextLeft1 and overPoint and overPoint.toolTipIcon then
			local height = DugisWaypointTooltipTextLeft1:GetHeight()
			local width = DugisWaypointTooltipTextLeft1:GetWidth()
			if not toolTipIconTexture then
				toolTipIconTexture = DugisWaypointTooltip:CreateTexture("ARTWORK")
				toolTipIconTexture:SetPoint("TOPRIGHT", -5, -5)
				toolTipIconTexture:SetWidth(height+5)
				toolTipIconTexture:SetHeight(height+5)
			end
			DugisWaypointTooltip:SetMinimumWidth(20+width+20+height)
			toolTipIconTexture:SetTexture(overPoint.toolTipIcon)
			toolTipIconTexture:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000) --temporary pet journal solution
			toolTipIconTexture:Show()
		elseif toolTipIconTexture then
			toolTipIconTexture:Hide()
		end
	end
    
    DugisWaypointTooltip.updateDugisWaypointTooltipLines = function()
        DugisWaypointTooltip:ClearLines()
        local lineIndex = 0
        
        if DugisWaypointTooltip.lines then
            for _, line in pairs(DugisWaypointTooltip.lines) do
                if DugisGuideViewer:IsModuleLoaded("NPCJournalFrame") then 
                    line = DGV.NPCJournalFrame:ReplaceSpecialTags(line, false)
                end
                if lineIndex == 0 then
                    DugisWaypointTooltip:AddLine(line, nil, nil, nil, true)
                elseif lineIndex == 1 then 
                    DugisWaypointTooltip:AddLine(line, nil, nil, nil, true)
                elseif lineIndex == 2 then 
                    DugisWaypointTooltip:AddLine(line, 1, 1, 1, true)					
                end
                
                lineIndex = lineIndex + 1
            end
        end
        
        if not DugisWaypointTooltip.hooked then
            DugisWaypointTooltip:HookScript("OnShow", DugisWaypointTooltip_OnShow)
            DugisWaypointTooltip.hooked = true
        end
        
        DugisWaypointTooltip:Show()
        
        DugisWaypointTooltip:SetClampedToScreen(true)
       
        local screenWidth = GetScreenWidth()
        local mapWidth = WorldMapFrame.ScrollContainer.Child:GetWidth() 
        local xOffset = (screenWidth - mapWidth) / 2
		
---------------------------------
----------- WOW Classic:---------
---------------------------------	
--WorldMapFrame.IsMaximized doesn't exist. INFO: in classic the map is always maximized		
       -- if WorldMapFrame:IsMaximized() then
            DugisWaypointTooltip:SetClampRectInsets(0,0,0,0) 
       -- else
       --     DugisWaypointTooltip:SetClampRectInsets(-xOffset + 180,0,0,-35)  
       -- end
    end
	
	local function AddTooltips(...)
    
        DugisWaypointTooltip.lines = {}
    
		for i=1,select("#", ...) do
            local line = (select(i, ...))
            if line == nil then
                line = ""
            end
            
            --Line processing
            line = string.gsub(line, "=COLON=",":")
            DugisWaypointTooltip.lines[#DugisWaypointTooltip.lines+1] = line
		end
        
        DugisWaypointTooltip:updateDugisWaypointTooltipLines()
	end

	local modelFrame = CreateFrame("PlayerModel", nil, DugisWaypointTooltip)
	WMT.modelFrame = modelFrame
	modelFrame:SetFrameStrata("TOOLTIP")
	
	local function GetMaxLineWidth()
		local maxW
		LuaUtils:loop(10, function(index)
			local line = _G["DugisWaypointTooltipTextLeft"..index]
			if line then
				if not maxW or line:GetWidth() > maxW then
					maxW = line:GetWidth()
				end
			else
				return "break"
			end
		end)
		return maxW
	end

    DugisWaypointTooltip.updateModel = function()
        npcId = DugisWaypointTooltip.npcId
    
        if DGV:UserSetting(DGV_HIDE_MODELS_IN_WORLDMAP) then
            return
        end
    
		if not npcId then return end
        
		local width = 150
		local maxLine = (GetMaxLineWidth() or width) + 30
		
		if maxLine > width then
			width = maxLine
		end
		
		if width > 155 then
			width = 155
			DugisWaypointTooltipTextLeft1:SetWidth(140)		
			if DugisWaypointTooltipTextLeft2 then
				DugisWaypointTooltipTextLeft2:SetWidth(140)
			end
		end
		
        if (DugisWaypointTooltip:GetWidth() < width) then
            DugisWaypointTooltip:SetWidth(width)
        end

		DugisWaypointTooltip:SetWidth(width) 
        
        local textHeight = DugisWaypointTooltip:GetHeight()
        DugisWaypointTooltip:SetHeight(DugisWaypointTooltip:GetWidth() + textHeight - 15)
                
        
        if UIParent:IsVisible() then
            modelFrame:SetPoint("TOPLEFT", 5, -textHeight + 5)
            modelFrame:SetPoint("BOTTOMRIGHT", -5, 5)
		else
            modelFrame:SetPoint("TOPLEFT", 5, -textHeight + 5)
            modelFrame:SetPoint("BOTTOMRIGHT", -5, 5)
		end
        

		local mv = DGV.Modules.ModelViewer
		--DGV:DebugFormat("point_OnEnter", "mv.npcDB[npcId]", mv.npcDB[npcId], "npcId", npcId)
		modelFrame:Show()
		modelFrame:ClearModel()
		if mv and mv.npcDB and mv.npcDB[npcId] then
			local value = mv.npcDB[npcId]
			if value and value ~= "" then
				modelFrame:SetDisplayInfo(value)
			end
		else
			if npcId and npcId ~= "" then
				modelFrame:SetCreature(npcId)
			end
		end

		--todo: use data from DisplayModelsExtra
		if npcId == 6491 then 
			modelFrame:SetCamDistanceScale(2.8)
		else
			modelFrame:SetCamDistanceScale(1)
		end
		
		modelFrame:Show()
        
        --GetModel is missing. More info: http://eu.battle.net/wow/en/forum/topic/17612062455
		if not modelFrame:GetModelFileID() or modelFrame:GetModelFileID()=="" then 
            modelFrame:Hide() 
        end    
    
    end

	local function point_OnEnter(self, button)
		local flightMaster = self.args and self.args[1] == 5
		if UIParent:IsVisible() then
			DugisWaypointTooltip:SetParent(UIParent)
		else
			DugisWaypointTooltip:SetParent(self)
		end

		DugisWaypointTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
		self = self.point or self
		overPoint = self
		DugisWaypointTooltip:SetFrameStrata("TOOLTIP")
    
        local texts = {DataProviders:GetTooltipText(self.provider, unpack(self.args))}

		local npcId = DataProviders:GetNPC(self.provider, unpack(self.args))
        
        if texts[1] == nil and npcId then
            texts[1] = "NPC "..npcId
        end
		
		if self.name and flightMaster then 
			texts[1] = "|cffffffff"..self.name.."|r"
		elseif flightMaster then
			texts[1] = "|cfff0eb20Flight location not learned|r"
		end		
        
		AddTooltips(unpack(texts))

        if not flightMaster then 
			DugisWaypointTooltip.npcId = npcId
	        DugisWaypointTooltip:updateModel()
		end

	end

	local function point_OnLeave(self, button)
		DugisWaypointTooltip:Hide()
		modelFrame:Hide()
		modelFrame:ClearModel()
	end
	
	local function minimapPoint_OnUpdate(self)
	--[[ todo: find replcement, test for API 8.0
		local dist,x,y = DugisGuideViewer.astrolabe:GetDistanceToIcon(self)
		if not dist then
			self:Hide()
			return
		end

		if DugisGuideViewer.astrolabe:IsIconOnEdge(self) then
			self.icon:Hide()
		else
			self.icon:Show()
		end
		]]
	end

	local function GetCreatePoint(...)
		
		local point = trackingPoints[lastPointIndex] 
		if not point then
			point = CreateFrame("Button", nil, DugisMapOverlayFrame)
			point:RegisterForClicks("RightButtonUp","LeftButtonUp")
			point:SetScript("OnClick", point_OnClick)
			point:SetScript("OnEnter", point_OnEnter)
			point:SetScript("OnLeave", point_OnLeave)
			point.icon = point:CreateTexture("ARTWORK")
			point.icon:SetAllPoints()
			point.icon:Show()

			hooksecurefunc(point, "Show", function(p)
				if p.args[7] == "MO" or p.args[7] == "O" then
					p:SetFrameLevel(3002)
					p.minimapPoint:SetFrameLevel(3002)
				else
					p:SetFrameLevel(3001) 
					p.minimapPoint:SetFrameLevel(3001)
				end
			end)
		end
		point:Hide()
        local args = {...}
        local pointType = args[#args]
        local overridenIcon
        
        if pointType == "P" then
            args = LuaUtils:RemoveKey(args, #args)
            overridenIcon = "P"
        end
       
		point.args = args
        
		point.args[1] = tonumber(point.args[1]) or point.args[1]
		point.args[2] = tonumber(point.args[2]) or point.args[2]
		point.provider = DataProviders:SelectProvider(unpack(args))
		if point.args[1] == 5 and point.args[4] then --Flightmaster Zone name
			point.name = point.args[4]
		end
		local icon = DataProviders:GetDetailIcon(point.provider, unpack(point.args))
		if icon then
			point.toolTipIcon = icon
		else
			point.toolTipIcon = nil
		end
        
        point.overridenIcon = overridenIcon
        
		if not point.minimapPoint then
			point.minimapPoint = CreateFrame("Button", nil, DugisMinimapOverlayFrame)
			point.minimapPoint:RegisterForClicks("RightButtonUp","LeftButtonUp")
			point.minimapPoint:SetScript("OnClick", point_OnClick)
			point.minimapPoint:SetScript("OnEnter", point_OnEnter)
			point.minimapPoint:SetScript("OnLeave", point_OnLeave)
			point.minimapPoint:SetScript("OnUpdate", minimapPoint_OnUpdate)
			point.minimapPoint.icon = point.minimapPoint:CreateTexture("ARTWORK")
			point.minimapPoint.icon:SetAllPoints()
			point.minimapPoint.icon:Show()
			point.minimapPoint.hidden = false
			point.minimapPoint.point = point
		end
		point.minimapPoint.overridenIcon = overridenIcon
		point.minimapPoint:Hide()
		point.minimapPoint.hidden = true

		trackingPoints[lastPointIndex] = point
		lastPointIndex = lastPointIndex + 1

		return point
	end

	local function GetDistance(point)
		local DugisArrow = DGV.Modules.DugisArrow
		--local x, y = GetXY(point.args[2])
		local x, y = DGV:UnpackXY(point[4])
		--	DugisArrow.map, DugisArrow.floor, DugisArrow.pos_x, DugisArrow.pos_y)
		return DGV:ComputeDistance(point[1], point[2] or  DugisArrow.floor, x, y,
			DugisArrow.map, DugisArrow.floor, DugisArrow.pos_x, DugisArrow.pos_y)
	end
	WMT.GetDistance = GetDistance

	local function IterateZonePoints(mapName, pointData, ofType, allContinents, IterateZonePoints, dontCheckDistance)
		if not pointData then return end
		local DugisArrow = DGV.Modules.DugisArrow
		local currentContinent = DGV.GetCurrentMapContinent_dugi()
        
        local mapID = mapName
        local level
        
        --Old convention (map name)
        if not tonumber(mapID) then
            local mapName,level = strsplit(":",mapName)
            local nsMapName = UnspecifyMapName(mapName)
            if nsMapName then
                if not DugisGuideUser.CurrentMapVersions or DugisGuideUser.CurrentMapVersions[nsMapName]~=mapName then return end
            end
            
            --Case made for "Dalaran70" mapName
            if not nsMapName and not tonumber(mapName) then
                mapName = mapName:gsub('[0-9]*', "") 
            end
            
            mapID = DGV:GetMapIDFromShortName(nsMapName or mapName)
            level = tonumber(level)
        end
        
		if 
			currentContinent~=DGV.GetMapContinent_dugi(mapID) and 
			mapName~=DGV:GetDisplayedMapNameOld() and
			not allContinents
		then
			return
		end
		local index = 0
		local zonePointIterator
		zonePointIterator = function()
			index = index + 1
			if not pointData[index] then return nil end
			if ofType then
				local tType = pointData[index]:match("(.-):")
				if tType~=ofType then
					return zonePointIterator()
				end
			end
			local point = {mapID, level, strsplit(":", pointData[index])}
			point[3] = tonumber(point[3]) or point[3]
			point[4] = tonumber(point[4]) or point[4]
--DGV:DebugFormat("IterateZonePoints", "mapName", mapName, "ShouldShow", (DataProviders:ShouldShow(nil, point[3], point[4], unpack(point, 5))), "GetDistance", (GetDistance(point)))
			if DataProviders:ShouldShow(nil, point[3], point[4], unpack(point, 5)) and
				(dontCheckDistance or GetDistance(point))
			then
				return point
			else
				return zonePointIterator()
			end
		end
		return zonePointIterator
	end
	
	local function IterateFlightPoints(invariant, control)
		while invariant do
			local data
			control,data = next(invariant,control)
			if control then
				if not data.requirements or DGV:CheckRequirements(strsplit(":", data.requirements)) then
					local point = {data.m, data.f, 5, data.coord, control}
					if DataProviders:ShouldShow(nil, point[3], point[4], unpack(point, 5)) and
						GetDistance(point)
					then
						return control, point
					end
				end
			else return end
		end
	end

	function DGV.IterateAllFindNearestPoints(ofType, allContinents, dontCheckDistance)
		local faction = UnitFactionGroup("player")

		local key, value, factionTable, factionKey, zonePointIterator, flightPointIterator, flightPointInvariant, flightPointControl
		local trackingPointTable = DugisWorldMapTrackingPoints
		local rootIterator
		rootIterator = function()
			if flightPointIterator then
				flightPointControl, value = flightPointIterator(flightPointInvariant, flightPointControl)
				if not flightPointControl then return end
				return value
			end
			if zonePointIterator then
				local tmp = zonePointIterator()
				if tmp then
					return tmp
				else
					zonePointIterator=nil
				end
			end
			if factionTable then
				factionKey, value = next(factionTable, factionKey)
				if factionKey then
					zonePointIterator = IterateZonePoints(factionKey, value, ofType, allContinents, nil, dontCheckDistance)
				else
					factionTable = nil
				end
			else
				key,value = next(trackingPointTable, key)
				if not key then 
					if trackingPointTable==DugisWorldMapTrackingPoints then 
						trackingPointTable = CollectedWorldMapTrackingPoints_v2
						if trackingPointTable then
							return rootIterator()
						end
					end
					if ofType and ofType~="5" then return end
					local fullData = DGV.Modules.TaxiData:GetFullData()
					local continent = DGV.GetCurrentMapContinent_dugi()
					flightPointIterator, flightPointInvariant = IterateFlightPoints, fullData[continent]
				elseif key==faction then
					factionTable = value
				elseif key~="Horde" and key~="Alliance" and key~="Neutral" then
					zonePointIterator = IterateZonePoints(key, value, ofType, allContinents, nil, dontCheckDistance)
				end
			end
			return rootIterator()
		end
		return rootIterator
	end

	local function RemoveAllPoints()
		for _,point in pairs(trackingPoints) do
			point:Hide()
			if point.minimapPoint then
				point.minimapPoint:Hide()
				point.minimapPoint.hidden = true
			end
			point.shown = false
		end

		lastPointIndex = 1
	end

	local function AddPointsToTheMap(mapId, pointData, inThread)
		if not pointData then return end
		local data
		for _,data in pairs(pointData) do

			LuaUtils:RestIfNeeded(inThread)

            --Replacing colons in special tags to "=COLON=" to avoid interpreting internat ":" marks 
            data = string.gsub(data, '%(.+%)', function(textFound) 
                return string.gsub(textFound, ":", "=COLON=")
			end) 

			
			local point = GetCreatePoint(strsplit(":", data))
			point.mapId = mapId
			point.shown = true
		end
	end
	
	local function AddFlightPointData()
		local fullData = DGV.Modules.TaxiData:GetFullData()
		local faction = UnitFactionGroup("player")
		local characterData
		if DugisFlightmasterDataTable then 
			characterData = DugisFlightmasterDataTable
		end
		local map = DGV:GetCurrentMapID() 
		if map == 876 or map == 875 then return end		
		local continent = DGV.GetCurrentMapContinent_dugi()		
		if fullData and fullData[continent] then
			for npc,data in pairs(fullData[continent]) do
				local requirements = data and data.requirements
				local name 
				if characterData and characterData[continent] and characterData[continent][npc] then 
					name = characterData[continent][npc].name
				end
				if 
					data.m==map and 
					(not requirements or DGV:CheckRequirements(strsplit(":", requirements)))
				then
					local point = GetCreatePoint("5", data.coord, npc, name)
					point.mapId = data.m
					point.shown = true
				end
			end
		end
	end
    
	function GetNearest(type)
		completedQuests = GetQuestsCompleted() 
		
		local shortest, shortestDist
		--for _,point in ipairs(trackingPoints) do
		--	local selected
		--	if (button.arg1 and button.arg1==point.args[4]) or button.arg1==point.args[1] then
		for point in DGV.IterateAllFindNearestPoints() do
			local selected
			if (type and type==point[6]) or type==point[3] then
				selected = point
				local dist = GetDistance(selected)
				if dist and (not shortestDist or dist < shortestDist) then
					shortest = selected
					shortestDist = dist
				end
			end
		end
		return shortest
	end

	local function FindNearest(type)

		local DugisArrow = DGV.Modules.DugisArrow
		DGV:RemoveAllWaypoints()
		--AddWaypoint(GetNearest(button))
		local nearest = GetNearest(type)
		if nearest then
			local x, y = DGV:UnpackXY(nearest[4])
			local map, level = nearest[1], nearest[2] or DugisArrow.floor
			DGV:AddCustomWaypoint(
				x, y, DataProviders:GetTooltipText(nil, unpack(nearest, 3)),
				map, level)
		end
        
        if LuaUtils:IsElvUIInstalled() then
            DropDownList1.showTimer = 1
        else
            LibDugi_DropDownList1.showTimer = 1
        end        

        DugisDropDown.LibDugi_HideDropDownMenu(1)
        DugisDropDown.LibDugi_HideDropDownMenu(2)
	end

	DGV.FindNearest = FindNearest

	local function IterateDropdownLevel(level)
		local listFrame = _G["DropDownList"..level];
               
		local listFrameName = listFrame:GetName();
		local count = listFrame.numButtons
		local i = 0
		return function()
			i = i + 1
			if i<=count then return _G[listFrameName.."Button"..i] end
		end
	end


	
	local function UpdateCurrentMapVersion()
		local currentMapName = DGV:GetDisplayedMapNameOld()
		local nsMapName = UnspecifyMapName(currentMapName)
		if nsMapName then
			if not DugisGuideUser.CurrentMapVersions then
				DugisGuideUser.CurrentMapVersions = {}
			end
			DugisGuideUser.CurrentMapVersions[nsMapName] = currentMapName
		end
	end

	
	--[[ todo: find replacement
	hooksecurefunc("WorldMapFrame_UpdateMap",
		function()
			if WMT.loaded then
				WMT:UpdateTrackingMap()
				UpdateCurrentMapVersion()
			end
		end)
          
	]]

		
	function DGV:MINIMAP_UPDATE_TRACKING()
		WMT:UpdateTrackingMap()
	end
		

	local QUEST_LOG_UPDATE_lastTime =  -1
	function DGV:QUEST_LOG_UPDATE()
		if QUEST_LOG_UPDATE_lastTime == GetTime() then
			return
		end

		DGV.duringQuestLogUpdateProcesing = true
		QUEST_LOG_UPDATE_lastTime = GetTime()

		ProcessObjectivesData(nil, function()
			DugisQuestsDataProvider:RefreshAllData()
		
			if DGV.ReProcessObjectivesData then
				DGV.ReProcessObjectivesData(15, function()
					DGV.duringQuestLogUpdateProcesing = false	
				end)
			else
				DGV.duringQuestLogUpdateProcesing = false
			end
		end)
	end

	function DGV:TRAINER_SHOW()
		local npcId = DGV:GuidToNpcId(UnitGUID("npc"))
		local x,y = select(3, DGV:GetPlayerPosition())
		if y then 
			local packed = DGV:PackXY(x,y)
			DGV:DebugFormat("TRAINER_SHOW", "Tracking Data", format("(type):%s:%s", packed, npcId))
		end
	end

	function WMT:OnMapChangedOrOpen(openEvent, mapUnchanged)
		if openEvent and mapUnchanged then
			UpdateTrackingFilters(true)
			return
		end
		if openEvent then
			--Hidding all POIs
			if WMT.trackingPoints then
				for k, point in pairs(WMT.trackingPoints) do
					point:Hide()
				end
			end
		end		
		GUIUtils.Drawing:ClearAllShapes()
		WMT:UpdateTrackingMap()
	end

	local function matchNames(value, name)
		return value and name and strfind(strlower(value), strlower(name), 1, true)
	end

	
	local function processUnit(questId, id, isItem, questData, targetData, zoneToProcess, mainObjects)
		local quests = WorldTrackingRawQuests 
		local items =  WorldTrackingRawItems
		local units = WorldTrackingRawNPCs
		local objects = WorldTrackingRawObjects
		local minLevel = questData["min"] 
		
		local UNIT, OBJECT = "U", "O"

		local objectivesInfo = DGV.GetObjectivesInfo(questId)

		local unitIds = {}
		if isItem then
			local itemInfo = items[id]
			local itemName = GetItemInfo(tonumber(id))


			local leftObjectiveExists = "no-any-objectives"
			for k, objectiveInfo in pairs(objectivesInfo) do
				LuaUtils:RestIfNeeded(true)
				if objectiveInfo.type == "item" and matchNames( objectiveInfo.item_NPC_name, itemName) then
					if objectiveInfo.done == false then
						leftObjectiveExists = true
					end
					if objectiveInfo.done == true and leftObjectiveExists ~= true then
						leftObjectiveExists = false
					end
				end
			end

			if leftObjectiveExists == true or leftObjectiveExists == "no-any-objectives"  then
				if itemInfo and itemInfo.U then
					for _, unitId in pairs(itemInfo.U) do
						unitIds[unitId] = UNIT
					end
				end

				if itemInfo and itemInfo.O then
					for _, objectId  in pairs(itemInfo.O) do
						unitIds[objectId] = OBJECT
					end
				end
			end
		else
		
			local unitName = DugisGuideViewer:GetLocalizedNPC(tonumber(id))
			local leftObjectiveExists = "no-any-objectives"

			for k, objectiveInfo in pairs(objectivesInfo) do
				LuaUtils:RestIfNeeded(true)
				if matchNames(objectiveInfo.item_NPC_name, unitName) then
					if objectiveInfo.done == false then
						leftObjectiveExists = true
					end
					if objectiveInfo.done == true and leftObjectiveExists ~= true then
						leftObjectiveExists = false
					end
				end
			end

			if leftObjectiveExists == true 
			or leftObjectiveExists == "no-any-objectives" 
			then	
				unitIds[id] = UNIT
			end

			if mainObjects then
				for _, objectId  in pairs(mainObjects) do
					unitIds[objectId] = "MO"
				end
			end

		end

		local zone2AddedTable = {}

		DGV.questId2Zone = DGV.questId2Zone or {}

		for unitId, type in pairs(unitIds) do
			LuaUtils:RestIfNeeded(true)
			local data = {}
			if type == OBJECT or type == "MO" then
				data = objects[unitId] 
			end

			if type == UNIT then
				data = units[unitId] 
			end

			if data then
				local unitDataCoords = data["coords"]

				if unitDataCoords then
					LuaUtils:ShuffleTable(unitDataCoords)
					for k, v in pairs(unitDataCoords) do
						local x, y, zone_, respawn = unpack(v) 
						zone = maps_82to13[zone_] or zone_

						LuaUtils:RestIfNeeded(true)

						if not zoneToProcess or zone == zoneToProcess then
							local coord = DGV:PackXY(x * 0.01, y * 0.01)

							local nodeString = "15:"..coord..":"..questId..":"..unitId..":"..(minLevel or 0)..":"..id..":"..type..":"..zone
							
							if not DGV.questId2Zone[tonumber(questId)] then
								DGV.questId2Zone[tonumber(questId)] = tonumber(zone)
							end

							if not addedObjectives[nodeString] then
								
								local nodeString2Added = zone2AddedTable[zone] 
								if not nodeString2Added then
									nodeString2Added =  LuaUtils:ValuesAsKeys(targetData[zone])
									zone2AddedTable[zone] = nodeString2Added
								end

								if not nodeString2Added[nodeString] then
									targetData[zone] = targetData[zone] or {}
									targetData[zone][#targetData[zone] + 1] = nodeString
									addedObjectives[nodeString] = true
								end
							end
						end
					end
				end
			end
		end
	end

	local GetQuestPosition_cache = {}

	--Calculates quest position based on center of the related objectives positions
	function WMT:GetQuestPosition(questId, formMapId)


		local completed = C_QuestLog.IsQuestFlaggedCompleted(questId)
		local key = ""..(completed or "")..questId

		if GetQuestPosition_cache[key] then
			return unpack(GetQuestPosition_cache[key])
		end

		local points = {}

		local quests = WorldTrackingRawQuests

		if DGV.IsQuestReadyForTurnIn(questId) then
			local questInfo_ = quests[questId]
			local endingUnitId = questInfo_ and questInfo_["end"] and questInfo_["end"].U and questInfo_["end"].U[1]

			if endingUnitId then
				local unitData = WorldTrackingRawNPCs[endingUnitId]
				if unitData then 
					local unitCoords = unitData.coords and unitData.coords[1]
					if unitCoords then
						x, y, mapID_ = unpack(unitCoords)

						if mapID_ then
							mapID_ = maps_82to13[mapID_] or mapID_

							local result = {x * 0.01, y * 0.01, mapID_}
							GetQuestPosition_cache[key] = result
							return unpack(result)
						end
					end
				end
			end
		end	
	
		local zone = nil

		if trackingPoints then
			for k, point in pairs(trackingPoints) do
				if point.shown then
					local trackingType, coord, questId_, _,_,_,_,zone_  = unpack(point.args)
					if trackingType == 15 and tonumber(questId_) == tonumber(questId) then
						local x, y = DGV:UnpackXY(coord)
						zone = zone_
						points[#points + 1] = {x=x, y=y}
					end
				end
			end
		end

		local pointGroups = Math:Points2PointsGroups(points)

		local allCenters = {}

		if #points >= objectivesBulbThreshold then
			for _, group in pairs(pointGroups) do
				local cX, cY = Math:Points2Center(group)
				if cX and cY then
					allCenters[#allCenters + 1] = {x=cX, y=cY}
				end
			end
		else
			for _, point in pairs(points) do
				allCenters[#allCenters + 1] = {x=point.x, y=point.y}
			end
		end 

		local resultExists = true

		local pX,pY = select(3, DGV:GetPlayerPosition())
		--Position not available
		if not pX or not pY then 
		    resultExists = false
		end

		local c = Math:ClosestPoint({x=pX,y=pY}, allCenters)
		--Cannot find center
		if not c then
			resultExists = false
		end

		if not resultExists then
			--trying to get accept position
			local questInfo_ = quests[questId]
			local startingUnitId = questInfo_ and questInfo_["start"] and questInfo_["start"].U and questInfo_["start"].U[1]

			if startingUnitId then
				local unitData = WorldTrackingRawNPCs[startingUnitId]
				if unitData then 
					local unitCoords = unitData.coords and unitData.coords[1]
					if unitCoords then
						x, y, mapID_ = unpack(unitCoords)

						if mapID_ then
							mapID_ = maps_82to13[mapID_] or mapID_
							return x * 0.01, y * 0.01, mapID_
						end
					end
				end
			end	
			
			return nil, nil, tonumber(zone) 
		end

		local result = {c.x, c.y, tonumber(zone)}
		GetQuestPosition_cache[questId] = result
		return unpack(result)
	end

	local function GetTrackingTargetData()
		--Adding quests into main point data table
		local faction = UnitFactionGroup("player")
		return DugisWorldMapTrackingPoints[faction]
	end

	function ProcessObjectivesData(zoneToProcess, onEnd)
	  LuaUtils:QueueThreadCancelOld("ProcessObjectivesData", function()
		local items =  WorldTrackingRawItems
		local targetData = GetTrackingTargetData()

		local DGV = DugisGuideViewer
		local quests = WorldTrackingRawQuests

		local allActiveQuests = DGV.GetAllActiveQuests()

		-----------------Objective points-----------------
		for _, questInfo in pairs(allActiveQuests) do
			LuaUtils:RestIfNeeded(true)
			local questId = questInfo.questId
			local data = quests[questId]

			if data and GetQuestLogIndexByID(tonumber(questId)) ~= 0 then
				local class = data["class"]
				local race = data["race"]  

				if (not class or IsClassValid(class)) and (not race or IsRaceValid(race)) then
					local obj = data["obj"] 
					if obj then
						--Processing related units
						if obj.U then
							for _, unitId in pairs(obj.U) do 
								LuaUtils:RestIfNeeded(true)
								processUnit(questId, unitId, false, data, targetData, zoneToProcess)
							end
						end


						--Processing required items
						if obj.I then
							for _, itemId in pairs(obj.I) do 
								LuaUtils:RestIfNeeded(true)
								--Checking for NPC that drops this item
								local relatedItemData = items[itemId]
								if relatedItemData and relatedItemData.U and #relatedItemData.U > 0 then 
									LuaUtils:RestIfNeeded(true)
									processUnit(questId, itemId, true, data, targetData, zoneToProcess)
								end

								if relatedItemData and relatedItemData.O and #relatedItemData.O > 0 then 
									LuaUtils:RestIfNeeded(true)
									processUnit(questId, itemId, true, data, targetData, zoneToProcess)
								end
							end
						end

					 	--Processing related objects
						if obj.O then
							if  #obj.O > 0 then 
								LuaUtils:RestIfNeeded(true)
								processUnit(questId, "", false, data, targetData, zoneToProcess, obj.O)
							end
						end
					end
				end
		   end
		end

		------------------Available/new quests------------------
		local addedAvailableQuests = {}
		local zone2AddedTable = {}

		local quests = WorldTrackingRawQuests 
		local units = WorldTrackingRawNPCs

		for questId, questInfo in pairs(quests) do
			LuaUtils:RestIfNeeded(true)
			if IsClassValid(questInfo.class) and IsRaceValid(questInfo.race) then
				local minLevel = questInfo["min"] 
				local optimalLevel = questInfo["lvl"] 
				local startUnits = (questInfo.start and questInfo.start.U) or {}
				local endUnits = (questInfo["end"] and questInfo["end"].U) or {}
				for i, units_ in pairs({startUnits, endUnits}) do
					LuaUtils:RestIfNeeded(true)
					local type = (i == 1) and "start" or "end"
					for _, unitId in pairs(units_) do
						LuaUtils:RestIfNeeded(true)
						local data = units[unitId] 

						if data then
							local unitDataCoords = data["coords"]
							if unitDataCoords then
								for k, v in pairs(unitDataCoords) do
									LuaUtils:RestIfNeeded(true)

									local x, y, zone_ = unpack(v)
									local zone = maps_82to13[zone_] or zone_ or ""
			
									local coord = DGV:PackXY(x * 0.01, y * 0.01)

									local nodeString = "17:"..coord..":"..questId..":"..unitId..":"..(minLevel or "")..":"..(optimalLevel or "")..":"..(zone or "")..":"..type
			
									if not addedAvailableQuests[nodeString] then
										targetData[zone] = targetData[zone] or {}

										local nodeString2Added = zone2AddedTable[zone] 
										if not nodeString2Added then
											nodeString2Added =  LuaUtils:ValuesAsKeys(targetData[zone])
											zone2AddedTable[zone] = nodeString2Added
										end

										if not nodeString2Added[nodeString] then
											targetData[zone][#targetData[zone] + 1] = nodeString
											addedAvailableQuests[nodeString] = true
										end
									end 
								end
							end
						end
					end				
				end

			end
		end

	  end, function()
		WMT:UpdateTrackingMap()
		if onEnd then
			onEnd()
		end
	  end)
	end	

	DGV.ReProcessObjectivesData = function(typeToReprocess, onEnd)
		zoneToReprocess = zoneToReprocess or WorldMapFrame:GetMapID()
		
			local targetData = GetTrackingTargetData()
			local lines = targetData[zoneToReprocess]

			if not lines then
				return
			end

			LuaUtils:QueueThreadCancelOld("ReProcessObjectivesData", function()
				local indicesToRemove = {}
				for index, line in pairs(lines) do
					local type = strsplit(":", line)
					LuaUtils:RestIfNeeded(true)
					if type == tostring(typeToReprocess) then
						indicesToRemove[#indicesToRemove + 1] = index
						addedObjectives[line] = nil
					end
				end
		
				table.sort(indicesToRemove, function(a, b) return a > b end)
				
				for i=1, #indicesToRemove do
					local index = indicesToRemove[i]
					table.remove(lines, index)
				end
			end, function()
				ProcessObjectivesData(zoneToReprocess, onEnd)
			end)

	end
	
	local function AddTownsfolkItemToMenu(name, folkType, icon, destinationMenu)
		local info = {}
		info.func = function(item, arg2, arg3, enabled)
			--local function PetFilterMenuItemClicked(item)
			local folkType = item.arg1
			DGV.chardb["trownsFolkTypeFilters"] = DGV.chardb["trownsFolkTypeFilters"] or {}
			DGV.chardb["trownsFolkTypeFilters"][folkType] = enabled
			UpdateTrackingFilters()
			
			if DGV.Modules.DugisWatchFrame and DGV.Modules.DugisWatchFrame.UpdateQuestsVisibility then
				DGV.Modules.DugisWatchFrame:UpdateQuestsVisibility()
			end

			if DGV.Modules.GPSArrowModule and DGV.Modules.GPSArrowModule.UpdateQuestPOIs then
				DGV.Modules.GPSArrowModule:UpdateQuestPOIs()
			end
		end
		info.text = name
		info.icon = icon
		info.arg1 = folkType
		info.notCheckable = false
		info.keepShownOnClick = true
		info.isNotRadio = true
		
		info.checked = function(button) 
			DGV.chardb["trownsFolkTypeFilters"] = DGV.chardb["trownsFolkTypeFilters"] or {}
			return DGV.chardb["trownsFolkTypeFilters"][folkType] == true
		end
		
		destinationMenu[#destinationMenu + 1] = info
	end	

	DGV.AddTownsfolkItemToMenu = AddTownsfolkItemToMenu

	function WMT:Load()
		ProcessObjectivesData()

		LuaUtils:Delay(3, function()
			DGV:PopulatePetJournalLookup()
		end)

		function WMT:UpdateTrackingMap()
		  LuaUtils:QueueThreadCancelOld("UpdateTrackingMap", function()

			if not WMT.loaded then return end

			local currentMapName = DGV:GetDisplayedMapNameOld() or "nil"
			local mapId = WorldMapFrame:GetMapID() or "nil"
			local mapNames = {[mapId] = currentMapName}

			local infos = C_Map.GetMapChildrenInfo(mapId, nil, true)

			for _, info in pairs(infos) do 
				mapNames[info.mapID] = info.name
			end

			RemoveAllPoints()

		  for mapId, mapName in pairs(mapNames) do
		    local level = DGV:UiMapID2DungeonLevel(mapId)

			DugisGuideUser.trackingIconPosition = DugisGuideUser.trackingIconPosition or {}
			if not DGV:UserSetting(DGV_WORLDMAPTRACKING) then 
				DugisGuideUser.trackingIconPosition.hide = true
				return 
			end

			DugisGuideUser.trackingIconPosition.hide = false
            
            local faction = UnitFactionGroup("player")
            
            if mapName and level then
                AddPointsToTheMap(mapName..":"..level, DugisWorldMapTrackingPoints[faction][mapName..":"..level], true);
                AddPointsToTheMap(mapName, DugisWorldMapTrackingPoints[mapName], true)
                AddPointsToTheMap(mapName..":"..level, DugisWorldMapTrackingPoints[mapName..":"..level], true)
            end

            if not mapId then
                return
            end

            AddPointsToTheMap(mapId, DugisWorldMapTrackingPoints[mapId], true)
            AddPointsToTheMap(mapId, DugisWorldMapTrackingPoints[faction][mapId], true)

			if not trackingPoints[1] then
				local nsMapName = UnspecifyMapName(mapName)
				if nsMapName then
					AddPointsToTheMap(nsMapName..":"..level, DugisWorldMapTrackingPoints[faction][nsMapName..":"..level], true);
					AddPointsToTheMap(nsMapName, DugisWorldMapTrackingPoints[nsMapName], true)
					AddPointsToTheMap(nsMapName..":"..level, DugisWorldMapTrackingPoints[nsMapName..":"..level], true)
				end
			end
			if CollectedWorldMapTrackingPoints_v2 and CollectedWorldMapTrackingPoints_v2[faction] then
                if mapName then
				    AddPointsToTheMap(mapName..":"..level, CollectedWorldMapTrackingPoints_v2[faction][mapName..":"..level], true)
                end
                
                if mapId then
				    AddPointsToTheMap(mapId, CollectedWorldMapTrackingPoints_v2[faction][mapId], true)
                end
				
			end
		  end
			 end, function()
				AddFlightPointData()
				UpdateTrackingFilters()
			 end)
			
		end
	
		DGV:RegisterEvent("TRAINER_SHOW")
        
        local function IsShowMinimapMenu()
            local result = 0
            
            local dropDownPrefix = ""
            
            LuaUtils:loop(_G[dropDownPrefix.."DropDownList1"].numButtons, function(buttonIndex)
                local button = _G[dropDownPrefix.."DropDownList1Button"..buttonIndex]
                
                if button:GetText() == MINIMAP_TRACKING_NONE and button:IsShown() and button:IsVisible() then
                    result = result + 1
                end 
                
             --[[    if button:GetText() == TOWNSFOLK_TRACKING_TEXT and button:IsShown() and button:IsVisible() then
                    result = result + 1
                end ]]
            end)
            
            return result == 1
        end

        local moved = false
        local allTrackingPoints = nil
        
        local function GetAllTrackingPoints(threading)
            local result = {}
			for point in DGV.IterateAllFindNearestPoints() do  
				LuaUtils:RestIfNeeded(threading)
                result[#result + 1] = point
            end            
            return result
        end
        

		DGV:RegisterEvent("MINIMAP_UPDATE_TRACKING")
		DGV:RegisterEvent("QUEST_LOG_UPDATE")
		WMT:UpdateTrackingMap()
		

		local professionTable = setmetatable({},
		{
			__index = function(t,i)
				local spell = tonumber(i)
				local v = i
				if spell then
					v = (GetSpellInfo(i))
				end
				return v and L[v]
			end,
		})		

        local function ShowExtraMenu()
            if not IsShowMinimapMenu() then
                return
            end
            
            if not MinimapExtraMenuFrame then
                extraMenuFrame = CreateFrame("Frame", "MinimapExtraMenuFrame", UIParent, "LibDugi_UIDropDownMenuTemplate")
			
            end
        
            if allTrackingPoints == nil then
                allTrackingPoints =  GetAllTrackingPoints()
            end

            local nearestOptions = {} 
            local menu = {
                { text = "Dugi Guides", isTitle = true, isNotRadio = true, notCheckable = true
                },
                { text = "Find nearest", hasArrow = true, isNotRadio = true, notCheckable = true,
                    menuList = nearestOptions
                }
            }
            
			DGV.AddTownsfolkItemToMenu("Track Quest POIs", 14, folkIconDir.."QuestBlob", menu)
			DGV.AddTownsfolkItemToMenu("Track Quest Spawn", 15, [[Interface\AddOns\DugisGuideViewerZ\Artwork\bullet_white]], menu)
			DGV.AddTownsfolkItemToMenu("Track Quest Givers", 17, [[Interface\AddOns\DugisGuideViewerZ\Artwork\accept]], menu)
			DGV.AddTownsfolkItemToMenu("Trivial Quest", 18, [[Interface\AddOns\DugisGuideViewerZ\Artwork\accept_g]], menu)
			DGV.AddTownsfolkItemToMenu("Spirit Healer", 16, [[Interface\WORLDSTATEFRAME\ColumnIcon-GraveyardDefend1]], menu)

            local added = {}
            for _, point in pairs(allTrackingPoints) do
                local button
                local found = false
                local trackingType = point[3]
                local name, texture = GetTrackingInfo(trackingType)
                if name and not added[name] then
                    added[name] = true
                    
                    local info;
                    info = {}
                    info.text = name
                    info.func = function() FindNearest(trackingType) end;
                    info.icon = texture;
                    info.arg1 = trackingType;
                    info.isNotRadio = true;
                    info.notCheckable = true
                    info.keepShownOnClick = true;
                    info.tCoordLeft = 0;
                    info.tCoordRight = 1;
                    info.tCoordTop = 0;
                    info.tCoordBottom = 1;

                    if trackingType==10 then
                        info.icon = nil;
                        info.func =  nil;
                        info.notCheckable = true;
                        info.keepShownOnClick = false;
                        info.hasArrow = true;
                                
                        info.menuList = {}
                        local added1 = {}
                                
                         for _, point1 in pairs(allTrackingPoints) do
                            local trackingType, _, _, spell = unpack(point1, 3)
                            if trackingType==10 and spell and not added1[spell] then
                                added1[spell] = true
                                
                                local info1;
                                info1 = {};
                                info1.text = professionTable[spell];
                                
                                info1.func = function() FindNearest(spell) end;
                                info1.notCheckable = true
                                info1.icon = select(2, GetTrackingInfo(10));
                                info1.arg1 = spell;
                                info1.isNotRadio = true;
                                info1.keepShownOnClick = false;
                                
                                info.menuList[#info.menuList + 1]  = info1
                            end
                        end
                        
                    end
                    
                    nearestOptions[#nearestOptions + 1]  = info
                end
            end
            
            local added = {}
            
            for providerKey,provider in DataProviders.IterateProviders do
                if provider.GetCustomTrackingInfo then
                    local text, icon, configAccessor, configMutator =  provider:GetCustomTrackingInfo()
                    if text then
                    
                        local option = {}
                        local info;
                        option.text = L[text]
                        option.icon = icon
                        option.arg1 = nil;
                        option.checked = configAccessor
                        option.isNotRadio = true;
                        option.func =  function(arg1, arg2, arg3, enabled)
                            configMutator(enabled)
                            WMT:UpdateTrackingMap()
                        end;
                        option.notCheckable = false;
                        option.keepShownOnClick = true;
                        option.hasArrow = false;
                        
                        menu[#menu + 1] = option
                        
                    end
                end
            end

            MinimapExtraMenuFrame.point = "TOPRIGHT"
            MinimapExtraMenuFrame.relativePoint = "BOTTOMRIGHT"

			local top = DropDownList1:GetTop()
			if top ~= nil and top < GetScreenHeight() * 0.5 then
				MinimapExtraMenuFrame.point = "BOTTOMRIGHT"
				MinimapExtraMenuFrame.relativePoint = "TOPRIGHT"
			end
			
             if LuaUtils:IsElvUIInstalled() then
                DugisDropDown.LibDugi_EasyMenu(menu, MinimapExtraMenuFrame, DropDownList1, 0 , -3, "MENU"); 
                LuaUtils:TransferBackdropFromElvUI()
             else
                DugisDropDown.LibDugi_EasyMenu(menu, MinimapExtraMenuFrame, DropDownList1, 0 , 0, "MENU");
             end

            if not hooked then
                hooked = true

				DropDownList1:HookScript("OnHide", function()
					DugisDropDown.LibDugi_HideDropDownMenu(1)
					DugisDropDown.LibDugi_HideDropDownMenu(2)
                   	allTrackingPoints = nil
                end)
				
				LibDugi_DropDownList1:HookScript("OnHide", function()
					HideDropDownMenu(1)
					HideDropDownMenu(2)
                   	allTrackingPoints = nil
                end)

				hooksecurefunc("UIDropDownMenu_StopCounting", function(_, notFromUI)
					if notFromUI then
						return
					end
					LuaUtils.DugisDropDown.LibDugi_UIDropDownMenu_StopCounting(LibDugi_DropDownList1, true)
				end)

			 	hooksecurefunc(DugisDropDown, "LibDugi_UIDropDownMenu_StopCounting", function(_, notFromUI)
					if notFromUI then
						return
					end
					UIDropDownMenu_StopCounting(DropDownList1, true)
				end)
            end 
        end

        if ElvUIMiniMapTrackingDropDown then
            hooksecurefunc(ElvUIMiniMapTrackingDropDown, "initialize", function()
				LuaUtils:Delay(0.01, function()
					 ShowExtraMenu()
				end)
            end)

            hooksecurefunc(DugisDropDown, "LibDugi_UIDropDownMenu_Initialize",  function()
                LuaUtils:TransferBackdropFromElvUI()
            end)
            
            DropDownList1:HookScript("OnShow", function()
				LuaUtils:Delay(0.01, function()
					 ShowExtraMenu()
				end)
            end)
            
        else
			hooksecurefunc("ToggleDropDownMenu", function(level, value, dropDownFrame)
				if dropDownFrame == MiniMapTrackingDropDown then
					if _G[ "DropDownList"..level]:IsShown() then
						ShowExtraMenu()
					end
				end
            end)
        end	
	end
	
	function WMT:Unload()
		--DGV:UnregisterEvent("LOOT_CLOSED")
		--DGV:UnregisterEvent("LOOT_SLOT_CLEARED")
		DGV:UnregisterEvent("PET_JOURNAL_LIST_UPDATE")
		DGV:UnregisterEvent("TRAINER_SHOW")
		DGV:UnregisterEvent("MINIMAP_UPDATE_TRACKING")
		DGV:UnregisterEvent("QUEST_LOG_UPDATE")
	end

    function DGV.AbandonByQuestId(questId)
        for i=1,GetNumQuestLogEntries() do 
            SelectQuestLogEntry(i)
            local AbandonQID = select(8, GetQuestLogTitle(i))
            if AbandonQID == questId then
                SetAbandonQuest()
                AbandonQuest() 
            end
        end
    end

    local pressedAbandonIndex = nil
    StaticPopupDialogs["GROUP_ABANDON_CONFIRMATION"] = {
        text = "Abandon All Quests?",
        button1 = "Yes",
        button2 = "No",
        OnHide = function()
            pressedAbandonIndex = nil
        end,
        OnAccept = function()
            local questIdsToBeAbandoned = {}
            local questLogIndex = pressedAbandonIndex + 1
            local numEntries = GetNumQuestLogEntries()
            for i = questLogIndex, numEntries do
                local _, _, _, isHeader, _, _, _, questId = GetQuestLogTitle(i)
                if isHeader then
                    break
                else
                    questIdsToBeAbandoned[#questIdsToBeAbandoned + 1] = questId
                end
            end
            for _, questId in pairs(questIdsToBeAbandoned) do
                 DGV.AbandonByQuestId(questId)
            end
            pressedAbandonIndex = nil
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }


    hooksecurefunc("QuestLog_Update", function(...)
		local numEntries, numQuests = GetNumQuestLogEntries();
		local questDisplayed = QUESTS_DISPLAYED or 1 
		for i=1, questDisplayed, 1 do
			local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
			local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questId, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex);

			local parentButton = _G["QuestLogTitle"..i];
			if parentButton then
				if parentButton.abandonGroupButton == nil then
					local buttonFrame = GUIUtils:AddButton(parentButton, "", 274, 5, 28, 28, 28, 28, function(self)  
						StaticPopupDialogs["GROUP_ABANDON_CONFIRMATION"].text = "Abandon All " .. GetQuestLogTitle(self.abandonGroupButton.questLogIndex) .. " Quests?" 
						if pressedAbandonIndex == nil then
							pressedAbandonIndex = self.abandonGroupButton.questLogIndex
							StaticPopup_Show ("GROUP_ABANDON_CONFIRMATION")
						end
					end, [[INTERFACE\BUTTONS\CancelButton-Up]], [[INTERFACE\BUTTONS\CancelButton-Down]],  [[INTERFACE\BUTTONS\CancelButton-Down]])
					buttonFrame.button.abandonGroupButton =  parentButton
					parentButton.abandonGroupButton = buttonFrame
				end

				parentButton.questLogIndex = questIndex
				parentButton.abandonGroupButton.button:Hide()

				if not DGV:UserSetting(DGV_SHOWQUESTABANDONBUTTON) or not isHeader then
					parentButton.abandonGroupButton.button:Hide()
				else
					parentButton.abandonGroupButton.button:Show()
				end
			end
        end
	end)


end


local AceGUI = LibStub("AceGUI-3.0")

local speciesData = {}
local exportResults = {}
local exportNavigationIndex = 1
local onePageResultsAmount = 2000 --Pets / page

function DugisGuideViewer:ShowResults()
    if not exportTextEditor then
        exportTextEditor = AceGUI:Create("MultiLineEditBox")
        exportTextEditor.frame:SetParent(UIParent)
        exportTextEditor.frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 250, -80)
        exportTextEditor.frame:SetWidth(470)
        exportTextEditor.frame:SetHeight(470)
        exportTextEditor.frame:Show()
    end
    
    exportTextEditor:SetText(exportResults[exportNavigationIndex] or "No more results.")
    
    exportTextEditor.label:SetText("Pets from "..((exportNavigationIndex -1) * onePageResultsAmount).." to "..((exportNavigationIndex * onePageResultsAmount))..". Press 'Next results' to see next results.") 
    exportTextEditor.button:SetScript("OnClick", function()
        exportNavigationIndex = exportNavigationIndex + 1
        DugisGuideViewer:ShowResults()
    end) 
    
    exportTextEditor.button:SetText("Next results")
    exportTextEditor.button:SetWidth(200)
    
    exportTextEditor.button:Enable()
end

local wow2dugisTownfoldsMap = {
	[2] = 12, --Repair
	[3] = 6, --Food & Drink
	[6] = 11, --Reagents
	[7] = 7, --Innkeeper
	[8] = 5, --Flight Master
	[9] = 3, --Battlemaster
	[10] = 4, --Class
	[11] = 10, --Profession Trainers
	[12] = 1, --Auctioneer
	[13] = 2, --Banker
	[14] = 8, --Mailbox
}



hooksecurefunc("SetTracking", function()
	local count = GetNumTrackingTypes();
	for id = 1, count do
		local name, texture, active, category  = GetTrackingInfo(id);

		DGV.chardb["trownsFolkTypeFilters"] = DGV.chardb["trownsFolkTypeFilters"] or {}
		DGV.chardb["trownsFolkTypeFilters"][trackingMap[id] or -1] = active
	end

	UpdateTrackingFilters()
	
	if DGV.Modules.DugisWatchFrame and DGV.Modules.DugisWatchFrame.UpdateQuestsVisibility then
		DGV.Modules.DugisWatchFrame:UpdateQuestsVisibility()
	end

	if DGV.Modules.GPSArrowModule and DGV.Modules.GPSArrowModule.UpdateQuestPOIs then
		DGV.Modules.GPSArrowModule:UpdateQuestPOIs()
	end
end)