--[[ 
===============================================================
Dugi Guides Addon License Agreement

Copyright (c) 2010-2015 Dugi Guides LTD
All rights reserved.

File Source: http://www.dugiguides.com 
Author Name: Fransisco Brevoort
Email: support@dugiguides.com

The contents of this addon, excluding third-party resources, are
copyrighted to its author with all rights reserved, under United
States copyright law and various international treaties.

In particular, please note that you may not distribute this addon in
any form, with or without modifications, including as part of a
compilation, without prior written permission from its author.

The author of this addon hereby grants you the following rights:

1. You may use this addon for private use only.

2. You may make modifications to this addon for private use only.

All rights not explicitly addressed in this license are reserved by
the copyright holder.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]


--Preserving original functions from being overridden
GetMapOverlayInfo_original = GetMapOverlayInfo
GetNumMapOverlays_original = GetNumMapOverlays

local function SetWorldMapScale(expanded)
	if MapsterOptionsButton then
		return 
	end

	if expanded then
		WorldMapFrame:SetScale(1)
	else
		WorldMapFrame:SetScale(0.665130)
	end
end

local LuaUtils = LuaUtils
local DugisDropDown = LuaUtils.DugisDropDown

--Texts
local GuideSharingCategoryName = "Guide Sharing BETA"
local quickSettingsLabel = "Quick Settings"

local lastMapUpdate = GetTime()

local maximumShareGuideClients = 4

--DugisCharacterCache initialization	
if not DugisCharacterCache then
    DugisCharacterCache = {}
end

local _
DugisGuideViewer = {
	events = {},
	globalHandlers = {},
	eventFrame = CreateFrame("Frame"),
	RegisterEvent = function(self, event, method)
		self.eventFrame:RegisterEvent(event)
		if self.events[event] then
			local existingRegistration = self.events[event]
			if type(existingRegistration)~="table" then
				if existingRegistration==method then return end
				self.events[event] = self.GetCreateTable(existingRegistration, method or event)
			else
				for _,exItem in existingRegistration:IPairs() do
					if exItem==method then return end
				end
				existingRegistration:Insert(method or event)
			end
		else
			self.events[event] = method or event
		end
	end,
	UnregisterEvent = function(self, event, method)
		local existingRegistration = self.events[event]
		if existingRegistration and type(existingRegistration)=="table" then
			assert(existingRegistration:Length()>1)
			method = method or event
			existingRegistration:RemoveFirst(method)
			if existingRegistration:Length()==1 then
				self.events[event] = existingRegistration[1]
				existingRegistration:Pool()
			end
			return
		end

		if self.events[event] then
			self.eventFrame:UnregisterEvent(event)
		end
		self.events[event] = nil
	end,
	IsRegisteredEvent = function(self, event, method)
		local existingRegistration = self.events[event]
		return existingRegistration
	end,	
	version = GetAddOnMetadata("DugisGuideViewer", "Version"),
	RegisterGlobalEventHandler = function(self, method)
		self.globalHandlers[method] = true
	end,
	UnregisterGlobalEventHandler = function(self, method)
		self.globalHandlers[method] = nil
	end,
}
local DugisGuideViewer = DugisGuideViewer
local DGV = DugisGuideViewer

LuaUtils.DGV = DGV

DUGI_SETTINGS_RIGHT_COLUMN_X = 300
DUGI_SETTINGS_PADDING_LEFT = 16

--Settings categories
local SEARCH_LOCATIONS_CATEGORY = 1
local QUESTING_CATEGORY = 2
local DUGI_ARROW_CATEGORY = 3
local DUGI_ZONE_MAP_CATEGORY = 4
local DISPLAY_CATEGORY = 5
local FRAMES_CATEGORY = 6
local MAPS_CATEGORY = 7
local TAXI_SYSTEM_CATEGORY = 8
local TARGET_BUTTON_CATEGORY = 9
local TOOLTIP_CATEGORY = 10
local OTHER_CATEGORY = 11
local GUIDE_SHARING_CATEGORY = 12
local PROFILES_CATEGORY = 13
local GEAR_ADVISOR_CATEGORY = 14
local TALENT_ADVISOR_CATEGORY = 15  


local savablePositionsFrameNames = {
     "DugisMainBorder"
    ,"DugisRecordFrame"
    --,"DugisSecureQuestButton"
    -- ,"DugisGuideViewerActionItemFrame"
    ,"DugisArrowFrame"
    ,"DugisGuideViewer_TargetFrame"
	,"DugisSmallFrameContainer"
	,"DugisGuideViewer_ModelViewer"
	,"DugisOnOffButton"
	,"GPSArrowScroll"
	,"DugisFlightProgressBar"
	,"ObjectiveTrackerBackground"
	,"DugisMapViewer"
}

local framesHiddenDuringCombat = {
     "DugisMain"
    , "DugisMainBorder"
    , "DugisArrowFrame"
	, {frameDefinition = "DugisSmallFrameContainer", condition = function() return DGV:IsSmallFrameFloating() end} 
	, {frameDefinition = "SmallFrameCollapseHeader", condition = function() return DGV:IsSmallFrameFloating() end} 
	, {frameDefinition = function() return SmallFrameCollapseHeader.MinimizeButton end, condition = function() return DGV:IsSmallFrameFloating() end} 
    ,"GPSArrowScroll"
    ,"DugisGuideViewer_ModelViewer"
    ,"DugisGuideViewer_TargetFrame"
    ,"DugisEquipPromptFrame"
    ,"DugisGuideSuggestFrame"
    ,"DugisMapViewer"
}

DugisGuideViewer.eventFrame:SetScript("OnEvent", function(self, event, ...)
	DGV.UpdateFramesCombatVisibility()

	LuaUtils:Delay(2, function()
		DGV.UpdateFramesCombatVisibility()
	end)

	local entry = DugisGuideViewer.events[event]
	--if DugisGuideViewer.DebugFormat then DugisGuideViewer:DebugFormat("OnEvent", "event", event) end
	if type(entry)=="table" then
		for _,method in entry:IPairs() do
			if method and DugisGuideViewer[method] then
				DugisGuideViewer[method](DugisGuideViewer, event, ...)
			end
		end
	else
		if entry and DugisGuideViewer[entry] then
			DugisGuideViewer[entry](DugisGuideViewer, event, ...)
		end
	end
	for method in pairs(DugisGuideViewer.globalHandlers) do

		method(event, ...)
	end
end)


DugisGuideViewer:RegisterEvent("PLAYER_ENTERING_WORLD")
DugisGuideViewer:RegisterEvent("PLAYER_ALIVE")
DugisGuideViewer:RegisterEvent("ADDON_LOADED")

DugisGuideViewer:RegisterEvent("SKILL_LINES_CHANGED")
DugisGuideViewer:RegisterEvent("CHAT_MSG_SKILL")
DugisGuideViewer:RegisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED")
DugisGuideViewer:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
DugisGuideViewer:RegisterEvent("PLAYER_REGEN_DISABLED")
DugisGuideViewer:RegisterEvent("PLAYER_REGEN_ENABLED")
DugisGuideViewer:RegisterEvent("MAP_EXPLORATION_UPDATED")
DugisGuideViewer:RegisterEvent("PLAYER_MONEY")



--todo: find replacement
--DugisGuideViewer:RegisterEvent("WORLD_MAP_UPDATE")

local FirstTime = 1
local L = DugisLocals

if GetLocale() == "enUS" then
	DugisGuideViewer.Localize = 0
else
	DugisGuideViewer.Localize = 1
	
end

--local LastGuideNumRows = 0
local Localize = 0	--Print Localization Error messages
local SettingsRevision = 10

local Debug = Debug
DugisGuideViewer.Debug = 0
DugisGuideViewer.ARTWORK_PATH = "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\"
DugisGuideViewer.BACKGRND_PATH = "Interface\\DialogFrame\\UI-DialogBox-Background"
DugisGuideViewer.EDGE_PATH = "Interface\\DialogFrame\\UI-DialogBox-Border"

BINDING_HEADER_DUGI = "Dugi Guides"
_G["BINDING_NAME_CLICK DugisGuideViewer_TargetFrame:RightButton"] = L["Target Button"]
_G["BINDING_NAME_CLICK DugisSecureQuestButton:LeftButton"] = L["Floating Item Button"]


--Default colors definition
DugisGuideViewer.defaultBadArrowColor = {1, 0, 0} 
DugisGuideViewer.defaultMiddleArrowColor = {1, 0.5, 0}
DugisGuideViewer.defaultGoodArrowColor = {1, 0.5, 0}
DugisGuideViewer.defaultExactArrowColor = {1, 1, 0}
DugisGuideViewer.defaultQuestingAreaColor = {0, 1, 0}
DugisGuideViewer.defaultDistancedArrowPingColor = {1, 1, 0, 0.7}

local grayDefault = {0.2, 0.2, 0.2}
local redDefault = {0.8, 0, 0}
local yellowDefault = {0.8, 0.8, 0}
local greenDefault = {0.0, 0.7, 0}
local greenDefault1 = {0, 0.8, 0}
DugisGuideViewer.defaultWaySegmentColor = function()

	--Backward compatibility
	local oldSettings = DugisGuideViewer:UserSetting(104) --DGV_ANTCOLOR 
	
	if oldSettings ==[[Interface\COMMON\Indicator-Gray]] then
		return grayDefault
	end
	
	if oldSettings ==[[Interface\COMMON\Indicator-Red]] then
		return redDefault
	end	
	
	if oldSettings ==[[Interface\COMMON\Indicator-Yellow]] then
		return yellowDefault
	end	
	
	if oldSettings ==[[Interface\COMMON\Indicator-Green]] then
		return greenDefault
	end		
	
	return greenDefault1
end

local function LocalizePrint(message)
	if Localize == 1 then
		print(message)
	end
end
DugisGuideViewer.LocalizePrint = LocalizePrint

local function DebugPrint(message)
	if DugisGuideViewer.Debug >= 1 then
		print(message)
	end
end
DugisGuideViewer.DebugPrint = DebugPrint

local function LoadSettings()
	local self = DugisGuideViewer
	--Settings Page Checkboxes
	DGV_QUESTLEVELON = 1
	DGV_LOCKSMALLFRAME = 2
	DGV_LOCKLARGEFRAME = 3
	DGV_WAYPOINTSON = 4
	DGV_ITEMBUTTONON = 5
	DGV_ENABLEQW_DEPRECATED = 6 -- 6 can be repurposed
	DGV_DUGIARROW = 7
	DGV_SHOWCORPSEARROW = 8
	DGV_CLASSICARROW = 9
	DGV_CARBONITEARROW = 10
	DGV_TOMTOMARROW = 11
	DGV_SHOWANTS = 12
	DGV_AUTOQUESTACCEPT = 13
	DGV_DISPLAYCOORDINATES = 14
	DGV_AUTOQUESTACCEPTALL = 15
	DGV_AUTOSELL = 16
	DGV_REMOVEMAPFOG = 17
	DGV_SMALLFRAMEBORDER = 18
	DGV_TARGETBUTTON = 19
	DGV_TARGETBUTTONSHOW = 20
	DGV_SHOWONOFF = 21
	DGV_STICKYFRAME = 22
    DGV_STICKYFRAMESHOWDESCRIPTIONS = 23
	DGV_DISPLAYMAPCOORDINATES = 24
	DGV_ENABLEMODELDB = 25
	DGV_ENABLENPCNAMEDB = 26
	DGV_ENABLEQUESTLEVELDB = 27
	DGV_ANCHOREDSMALLFRAME = 28
	DGV_QUESTCOLORON = 29
	DGV_SHOW_SMALL_FRAME_HEADER = 30
	DGV_UNLOADMODULES = 31
	DGV_FIXEDWIDTHSMALL = 32
	DGV_MOVEWATCHFRAME = 33
	DGV_WATCHFRAMEBORDER = 34
	DGV_WORLDMAPTRACKING = 35
	DGV_AUTOQUESTTURNIN = 36
	DGV_ACCOUNTWIDEACH = 37
	DGV_EMBEDDEDTOOLTIP = 38
	DGV_OBJECTIVECOUNTER = 39
	DGV_MULTISTEPMODE = 40
	DGV_FIXEDWIDEFRAME = 41
	DGV_AUTOEQUIP = 42
	DGV_SHOWAUTOEQUIPPROMPT = 43
	DGV_DISABLEWATCHFRAMEMOD = 44	
	DGV_AUTOREPAIR = 45
	DGV_AUTOREPAIRGUILD = 46
	DGV_HIGHLIGHTSTEPONENTER = 47
	DGV_MANUALWAYPOINT = 48
	DGV_TOMTOMEMULATION = 49
	DGV_LOCKMODELFRAME = 50
	DGV_JOURNALFRAME = 51
	DGV_JOURNALFRAMEBUTTONSTICKED = 52
	DGV_GUIDESUGGESTMODE = 53	
	DGV_PLACEHOLDER54 = 54
	DGV_PLACEHOLDER55 = 55
	DGV_MODEL_VIEWER_BORDER = 56
    DGV_AUTOFLIGHTPATHSELECT = 57
	DGV_TARGETTOOLTIP = 58
	DGV_USETAXISYSTEM = 59
	DGV_SHOWQUESTABANDONBUTTON = 60
	DGV_PLACEHOLDER61 = 61	
	DGV_DISPLAYALLSTATS = 62	
	DGV_DISPLAYGUIDESPROGRESS = 63	
	DGV_DISPLAYGUIDESPROGRESSTEXT = 64	
	DGV_AUTOQUESTITEMLOOT = 65
	DGV_PLACEHOLDER66 = 66
	DGV_BLINKMINIMAPICONS = 67
    DGV_NAMEPLATES_SHOW_TEXT = 68
	DGV_NAMEPLATES_TRACKING = 69
	DGV_TRGET_BUTTON_FIXED_MODE = 70
	DGV_NAMEPLATES_SHOW_ICON = 71
	DGV_GPS_MERGE_WITH_DUGI_ARROW = 72
    
	DGV_GPS_MINIMAP_TERRAIN_DETAIL = 73
	DGV_GPS_AUTO_HIDE = 74
	DGV_HIDE_UI_DURING_COMBAT = 75
	DGV_GPS_ARROW_AUTOZOOM = 76
    
    DGV_ENABLED_GPS_ARROW = 77
	
	DGV_AUTO_QUEST_TRACK = 78
	DGV_WAYPOINT_PING = 79
    
    DGV_HIDE_MODELS_IN_WORLDMAP = 80
    DGV_AUTO_MOUNT = 81
    DGV_SHOW_FLIGHT_LEFT_TIME = 82
    
    DGV_DISABLE_QUICK_SETTINGS = 83
    
    DGV_TAXISYSTEM_ZONE_PORTALS = 84
    DGV_TAXISYSTEM_PLAYER_PORTALS = 85
    DGV_TAXISYSTEM_BOATS = 86
    DGV_TAXISYSTEM_CLASS_PORTALS = 87
    DGV_TAXISYSTEM_WHISTLE = 88
    DGV_ENABLED_GEAR_NOTIFICATIONS = 89
    DGV_ENABLED_GUIDE_NOTIFICATIONS = 90
	
    DGV_ALWAYS_SHOW_STANDARD_PROMPT_GEAR = 91
    DGV_ALWAYS_SHOW_STANDARD_PROMPT_GUIDE = 92
	DGV_BAD_COLOR = 93
	DGV_MIDDLE_COLOR = 94
	DGV_GOOD_COLOR = 95
	DGV_EXACT_COLOR = 96
	DGV_QUESTING_AREA_COLOR = 97
    DGV_ENABLED_JOURNAL_NOTIFICATIONS = 98
    DGV_USE_NOTIFICATIONS_MARK = 99
	
	DGV_WAY_SEGMENT_COLOR = 1001
	DGV_SMALL_FRAME_EXTEND_UP = 1002

	DGV_SHOW_OBJ_BULBS = 1003
	--Not used. Not removed from here to prevent ids shift and options mix.
	DGV_SHOW_OBJ_BULBS_ON_HOVER = 1004
	DGV_TRAIN_SUGGESTIONS = 1005

	DGV_CLEAR_FINAL_WAYPOINT = 1006
	DGV_MINIMIZE_MAP_BUTTON = 1007

	DGV_ENABLED_GUIDE_SHARING = 1008
	DGV_TARGET_TOOLTIP_OBJECTIVES = 1009
	DGV_SHOW_EXTRA_WAYPOINT_ICON = 1010

	DGV_DISTANCED_ARROW = 1011
	DGV_DISTANCED_ARROW_PING_COLOR = 1012
	DGV_CTRL_RIGHT_CLICK_ARROW_MENU = 1013
	DGV_ENABLEDGEARFINDER = 1014

	--Sliders
	DGV_MINIBLOBQUALITY = 200
	DGV_SHOWTOOLTIP = 201
	DGV_RECORDSIZE = 202

	DGV_SMALLFRAMEFONTSIZE = 204
	DGV_TARGETBUTTONSCALE = 205
	DGV_ITEMBUTTONSCALE = 206
	DGV_JOURNALFRAMEBUTTONSCALE = 207
	DGV_SMALLFRAME_STEPS = 208
	DGV_MOUNT_DELAY = 209
	
	DGV_GPS_BORDER_OPACITY = 210
	DGV_GPS_MAPS_OPACITY = 211
	DGV_GPS_MAPS_SIZE = 212
	DGV_GPS_ARROW_SIZE = 213
	DGV_NAMEPLATEICONSIZE = 214
	DGV_NAMEPLATETEXTSIZE = 215
    
	DGV_SMALL_FRAME_TABS_AMOUNT = 216
	DGV_PATH_WIDTH = 217
	DGV_TALENT_PROFILE = 218

	DGV_DISTANCED_ARROW_SIZE = 219
	
	--Dropdowns
	DGV_GUIDEDIFFICULTY = 100
	DGV_SMALLFRAMETRANSITION = 101
	DGV_LARGEFRAMEBORDER = 102
	DGV_STEPCOMPLETESOUND = 103
	--DGV_ANTCOLOR = 104
	DGV_TAXIFLIGHTMASTERS = 109
	DGV_PLACEHOLDER111 = 111
	DGV_SMALLFRAMEDOCKING = 112
	DGV_PLACEHOLDER113 = 113
	DGV_MAIN_FRAME_BACKGROUND = 114
	DGV_ROUTE_STYLE = 115
		
	--DGV_MINIBLOBS = 104
	DGV_TOOLTIPANCHOR = 105
	DGV_QUESTCOMPLETESOUND = 107
	DGV_DISPLAYPRESET = 108
	DGV_PLACEHOLDER110 = 110
	
	DGV_GPS_BORDER = 116
    
    DGV_TAXIREACHEDSOUND = 117
	
	--Custom
	DGV_TARGETBUTTONCUSTOM = 300
	DGV_PROFILECUSTOM = 301
	DGV_GAWINCRITERIACUSTOM = 302
	DGV_GAWEIGHTSCUSTOM = 303

	local defaults = {
		profile = {
			char = {
				settings = {
					QuestRecordTable = {},
					QuestRecordTableCriterias = {},
					QuestRecordTableScenarios = {},
                    framePositions = {},
					QuestRecordEnabled = true,
					ModelViewer = {	pos_x = 300, pos_y = 45, relativePoint="CENTER"},
					StickyFrame = {	pos_x = 485, pos_y = 130, relativePoint="CENTER"},
					FirstTime = true,
					EssentialsMode = 0,
					SettingsRevision = 0,
					WatchFrameSnapped = true,
					GuideOn = true,
					sz = {}, --check boxes ids
					[DGV_PLACEHOLDER54]	= { module = "Disabled"},					
					[DGV_PLACEHOLDER55]	= { module = "Disabled"},
					[DGV_PLACEHOLDER66]	= { module = "Disabled"},
					[DGV_PLACEHOLDER111] = { module = "Disabled" },
					[DGV_PLACEHOLDER110] = { module = "Disabled" },
					[DGV_PLACEHOLDER113] = { module = "Disabled" },
					[DGV_PLACEHOLDER61] = { module = "Disabled"},	
					[DGV_QUESTLEVELON]			= { category = "Other",	text = "Display Quest Level", 	checked = false,	tooltip = "Show the quest level on the large and small frames", module = "Guides"},
					[DGV_QUESTCOLORON] 		= { category = "Other",	text = "Color Code Quest", 	checked = true,		tooltip = "Color code quest against your character's level", module = "Guides"},
					[DGV_LOCKSMALLFRAME] 		= { category = "Frames",	text = "Lock Small Frame", 	checked = false,	tooltip = "Lock small frame into place", module = "SmallFrame"},
					[DGV_MOVEWATCHFRAME] 		= { category = "Frames",	text = "Move Objective Tracker", showOnRightColumn = true, checked = false,	tooltip = "Allow movement of the watch frame, not available if other incompatible addons are loaded.", module = "DugisWatchFrame"},
					[DGV_ANCHOREDSMALLFRAME] 	= { category = "Display",	text = "Anchored Small Frame", 	checked = true,	tooltip = "Allow a fixed Anchored Small Frame that will integrate with the Objective Tracker", module = "SmallFrame", update = "UpdateSmallFrame"},
					[DGV_LOCKLARGEFRAME] 		= { category = "Frames",	text = "Lock Large Frame", 	checked = false,	tooltip = "Lock large frame into place", module = "Guides"},
					[DGV_WAYPOINTSON]			= { category = "Dugi Arrow",	text = "Automatic Waypoints", 	checked = true,		tooltip = "Automatically map waypoints from the Small Frame or from the Objective Tracker in essential mode",},
					[DGV_ITEMBUTTONON] 		= { category = "Questing",	text = "Floating Item Button",		checked = true,		tooltip = "Shows a small window to click when an item is needed for a quest",},
					[DGV_ENABLEQW_DEPRECATED] = {},
					[DGV_DUGIARROW]			= { category = "Dugi Arrow",	text = "Show Dugi Arrow",	checked = true,		tooltip = "Show Dugis waypoint arrow",},
					[DGV_SHOWCORPSEARROW]		= { category = "Dugi Arrow",	text = "Show Corpse Arrow",	checked = true,		tooltip = "Show the corpse arrow to direct you to your body", indent = true},
					[DGV_CLASSICARROW]			= { category = "Dugi Arrow",	text = "Classic Arrow",		checked = true,		tooltip = "Switch between modern and classic arrow icons", indent = true,},
					[DGV_CARBONITEARROW] 		= { category = "Dugi Arrow",	text = "Use Carbonite Arrow",	checked = true,	tooltip = "Use the Carbonite arrow instead of the built in arrow"},
					[DGV_TOMTOMARROW] 		= { category = "Dugi Arrow",	text = "Use TomTom Arrow", 	checked = false,	tooltip = "Use the TomTom arrow instead of the built in arrow"},
					[DGV_SHOWANTS] 			= { category = "Dugi Arrow",	text = "Show Ant Trail",	checked = true,		tooltip = "Display ant trail between waypoints on the world map",},
					[DGV_AUTOQUESTACCEPT] 		= { category = "Questing",	text = "Auto Quest Accept",	checked = false,	tooltip = "Automatically accept quests from NPCs. Disable with shift",},
					[DGV_AUTOQUESTACCEPTALL]	= { category = "Questing",	text = "Only Quests in Current Guide",	checked = true,	tooltip = "Auto quest accept feature will only accept quests in current guide", indent = true, module = "Guides"},							
					[DGV_AUTOQUESTTURNIN]	= { category = "Questing",	text = "Auto Quest Turn in",	checked = false,	tooltip = "Automatically turn in quests from NPCs. Disable with shift"},							
					[DGV_AUTOSELL]         		= { category = "Other",		text = "Auto Sell Greys",    	checked = true,    	tooltip = "Automatically sell grey quality items to merchant NPCs",},
					[DGV_AUTOREPAIR]			= { category = "Other",		text = "Auto Repair",    		checked = false,    tooltip = "Automatically repair all damaged equipment at repair NPC",},
					[DGV_AUTOFLIGHTPATHSELECT]			= { category = "Dugi Arrow",	showOnRightColumn = true,	text = "Auto Select Flight Path",	checked = false,	tooltip = "Automatically select the suggested flight path after opening the flightmaster map",},
					[DGV_USETAXISYSTEM]			= { category = "Taxi System", text = "Use Taxi System",	checked = true,	tooltip = "Taxi system will find the fastest route to get to your destination with the use of portals, teleports, vehicles etc. Disabling this option will give you a direct waypoint instead.",},
					[DGV_TAXISYSTEM_ZONE_PORTALS]			= { category = "Taxi System",	text = "Use Zone Portals",	checked = true,	tooltip = "",},
					[DGV_TAXISYSTEM_PLAYER_PORTALS]			= { category = "Taxi System",	text = "Use Player Portals",	checked = true,	tooltip = "",},
					[DGV_TAXISYSTEM_BOATS]			= { category = "Taxi System",	text = "Use Boats",	checked = true,	tooltip = "",},
					[DGV_TAXISYSTEM_CLASS_PORTALS]			= { category = "Taxi System",	text = "Use Class Portals",	checked = true,	tooltip = "",},
					--[DGV_TAXISYSTEM_WHISTLE]			= { category = "Taxi System",	text = "Use Flight Master Whistle",	checked = true,	tooltip = "",},
					[DGV_SHOW_FLIGHT_LEFT_TIME]			= { category = "Taxi System",	text = "Show Flight Time",	 showOnRightColumn = true,  checked = false,	tooltip = "",},
					[DGV_HIDE_UI_DURING_COMBAT]			= { category = "Display",	text = "Hide Frames in Combat",	 dY = 25, showOnRightColumn = true,  checked = false,	tooltip = "",},
					[DGV_SMALL_FRAME_EXTEND_UP]			= { category = "Display",	text = "Expand upwards",	 showOnRightColumn = true,  checked = false,	tooltip = "Expand the SmallFrame upward instead of downward. Usefull if you want to position the guide near thebottom of the screen",},
					[DGV_MODEL_VIEWER_BORDER]			= { category = "Frames",	text = "Model Viewer Frame Border",	 showOnRightColumn = true,  checked = true,	tooltip = "",},
					[DGV_AUTOREPAIRGUILD]		= { category = "Hide",		text = "Use Guild Bank",    	checked = false,   	tooltip = "Use guild funds when repairing automatically", indent=true,},
					[DGV_AUTO_QUEST_TRACK] 		= { category = "Questing",	text = "Auto Quest Tracking",	checked = false,		tooltip = "Automatically add quest to the Objective Tracker on accept or objective update", indent=false},
					[DGV_GUIDESUGGESTMODE] 		= { category = "Questing",	text = "Guide Suggest Mode",	showOnRightColumn = true, checked = true,		tooltip = "Suggest guides for your player on level up", module = "Guides", indent=false,},
					[DGV_SMALLFRAMEBORDER] 		= { category = "Frames",	text = "Small Frame Border", dY = -103, position = DGV_DISABLEWATCHFRAMEMOD + 1,	showOnRightColumn = true,	checked = true,	tooltip = "Use the same border that is selected for the large frame", module = "SmallFrame"},
					[DGV_WATCHFRAMEBORDER] 		= { category = "Frames",	text = "Objective Tracker Frame Border", position = DGV_DISABLEWATCHFRAMEMOD + 2,	showOnRightColumn = true,	checked = true,		tooltip = "Add a border for the Objective Tracker Frame", module = "DugisWatchFrame"},
					[DGV_REMOVEMAPFOG]     		= { category = "Maps",		text = "Remove Map Fog",  	checked = true,    	tooltip = "View undiscovered areas of the world map, type /reload in your chat box after change of settings",},
					[DGV_HIGHLIGHTSTEPONENTER]	= { category = "Tooltip",	text = "Highlight Guide Steps",	checked = true,	tooltip = "Guide step text color intensifies when moused over", module = "SmallFrame"},
					[DGV_DISPLAYCOORDINATES]	= { category = "Tooltip",	text = "Tooltip Coordinates",	checked = false,	tooltip = "Show destination coordinates in the status frame tooltip", module = "Guides"},
					[DGV_TARGETBUTTON] 		= { category = "Target",	text = "Target Button",		checked = true,		tooltip = "Target the NPC needed for the quest step", module = "Target"},
					[DGV_TARGETBUTTONSHOW]		= { category = "Target",	text = "Show Target Button",	checked = true,		tooltip = "Show target button frame", indent = "true", module = "Target"},
					[DGV_SHOWONOFF]			= { category = "Frames",	text = "Show DG Icon Button",	checked = true,		tooltip = "Show the On/Off button which enables or disables the guide", },
					[DGV_STICKYFRAME]			= { category = "Frames",	text = "Enable Sticky Frame",	checked = true,		tooltip = "Shift click a quest step to track in the frame", module = "StickyFrame" },
                    [DGV_STICKYFRAMESHOWDESCRIPTIONS]			= { category = "Frames",	text = "Sticky Frame Step Description",	checked = true,		tooltip = "Show step descriptions in the Sticky Frame", module = "StickyFrame" },
					--[DGV_AUTOSTICK] 		= { category = "Other",		text = "Auto Stick", 		checked = true,		tooltip = "This feature will automatically add 'as you go...' step into sticky frame",},
					[DGV_DISPLAYMAPCOORDINATES] 	= { category = "Maps",		text = "Map Coordinates",  	checked = true,    	tooltip = "Show Player and Mouse coordinates at the bottom of the map.",},
					[DGV_WORLDMAPTRACKING] 		= { category = "Maps",		text = "World Map Tracking",  	checked = true,    	tooltip = "Add minimap tracking icons on the world map.",},
					[DGV_BLINKMINIMAPICONS] 		= { category = "Maps",		text = "Blink Minimap Resource Nodes",  	checked = false,    	tooltip = "Resource nodes for gathering profession will blink in your minimap to make it easier to notice", module = "Disabled"},
					[DGV_HIDE_MODELS_IN_WORLDMAP] 		= { category = "Maps",		text = "Hide Model Preview in World Map",  	checked = false,    	tooltip = "Hide Model Preview in World Map"},
					[DGV_SHOW_OBJ_BULBS] = { category = "Maps", text = "Show Objective Bulbs", checked = true, tooltip = ""},
					[DGV_ENABLEMODELDB]		= { category = "Hide",	text = "Model Database",	checked = true,		tooltip = "Allows model viewer to function", module = "NpcsF", update = "UpdateSmallFrame"},
					[DGV_ENABLENPCNAMEDB]		= { category = "Other",	text = "NPC Name Database",	checked = true,		tooltip = "Provides localized NPC names. Required for target button.", module = "Disabled"},
					[DGV_ENABLEQUESTLEVELDB]		= { category = "Other",	text = "Quest Level Database", showOnRightColumn = true,	checked = true,		tooltip = "Shows minimum level required for quests.\n\nAlso used for color coding the quests.", module = "ReqLevel"},
					[DGV_UNLOADMODULES]		= { category = "Other",	text = "Unload Modules", showOnRightColumn = true,	checked = false,	tooltip = "Unloading modules will allow the addon to run on low memory setting in Essential Mode but will require a UI reload to return back to normal. ", module = "Guides"},
					[DGV_TRAIN_SUGGESTIONS]		= { category = "Other",	text = "Training Reminder", checked = true, tooltip = ""},
					[DGV_AUTOQUESTITEMLOOT]	= { category = "Questing",	text = "Auto Loot Quest Item",	checked = true,		tooltip = "Automatically loot quest items.",},
					[DGV_ACCOUNTWIDEACH]		= { category = "Hide",text = "Account Wide Achievement",	checked = false,		tooltip = "Detects account wide achievements completion.", module = "Guides"},
					[DGV_DISTANCED_ARROW]		= { category = "Dugi Arrow",text = "Icon Arrow",  position = DGV_WAYPOINT_PING + 1,	checked = true, showOnRightColumn = true,		tooltip = "Dynamic arrow that circle around the character"},
					[DGV_DISTANCED_ARROW_PING_COLOR]	= { category = "Dugi Arrow",	dX = 0, dY = 150,		text = "Icon Arrow Ping Color", checked = false, tooltip = "", showOnRightColumn = true},	
					[DGV_CTRL_RIGHT_CLICK_ARROW_MENU]	= { category = "Other",	text = "CTRL + Right Click Arrow Menu", checked = true, tooltip = ""},						[DGV_DISABLE_QUICK_SETTINGS]		= { category = "Other",text = "Disable Quick Settings Under "..[[|T]]..DugisGuideViewer.ARTWORK_PATH.."iconbutton"..[[:20:20|t]].."Icon",	checked = false,		tooltip = "", module = "Guides"},
                    [DGV_ENABLEDGEARFINDER]			= { category = "Other",	showOnRightColumn = false,	text = "Enable Gear Finder",	checked = true,	tooltip = "Gear Finder",},					

					[DGV_AUTO_MOUNT]		= { category = "Auto Mount", text = "Enable auto mount",	checked = false,		tooltip = "Automatically mounts the fastest available mount.", module = "Guides"},
					[DGV_EMBEDDEDTOOLTIP]		= { category = "Display",	text = "Embedded Tooltip",	checked = true,	tooltip = "Displays tooltip information under guide step", module = "Guides", update = "UpdateSmallFrame"},
					[DGV_FIXEDWIDTHSMALL]		= { category = "Display",	text = "Fixed Width Small Frame",	checked = true,	tooltip = "Floating Small Frame won't adjust size horizontally and remain the same width as the Objective Tracker.", module = "Guides"},
					[DGV_OBJECTIVECOUNTER]		= { category = "Display",	text = "Show Quest Objectives",	checked = true,		tooltip = "Display quest objectives in small/anchored frame instead of the watch frame", module = "Guides", update = "UpdateSmallFrame"},
					[DGV_MULTISTEPMODE]		= { category = "Display",	text = "Multi-step Mode",	checked = true,	tooltip = "Allow status frame to show all currently relevant quests.", module = "Guides"},
					[DGV_FIXEDWIDEFRAME]		= { category = "Display",	text = "Wider Objective Tracker",	checked = false,	tooltip = "Increases the width of the Objective tracker", module = "Hide"},
					[DGV_AUTOEQUIP]				= { category = "Gear Advisor", text = "Auto Equip First Priority", checked = true, tooltip = "Automatically maintain the best item for each slot as player level, spec and inventory changes occur. Scores are based upon the first Loot Suggestion Priority", module = "GearAdvisor"},
					[DGV_SHOWAUTOEQUIPPROMPT]	= { category = "Gear Advisor",	text = "Show Auto Equip Prompt", checked = true, tooltip = "Display a prompt to verify before committing auto equip changes", module = "GearAdvisor"},
					[DGV_GAWINCRITERIACUSTOM]	= { category = "Gear Advisor", text = "Loot Suggestion Priority", tooltip = "Determines how gear should be scored, in order of greatest to least importance.", module = "GearAdvisor"},
					[DGV_DISABLEWATCHFRAMEMOD]	= { category = "Frames",		text = "Lock Objective Tracker", showOnRightColumn = true, indent = true, checked = true,		tooltip = "Lock the objective tracker frame.", module = "DugisWatchFrame"},
					[DGV_MANUALWAYPOINT]		= { category = "Dugi Arrow",		text = "Manual Waypoints",checked = true,		tooltip = "Enable user placed waypoints on the world map by pressing Ctrl + Right click or Shift + Right click to link them together, disable this option if the hotkey conflict with another addon",},
					[DGV_TOMTOMEMULATION]		= { category = "Dugi Arrow",		text = "TomTom Addon Emulation",checked = true,		tooltip = "Enable /way commands and compatibility with other addons that use TomTom addon (eg LightHeaded)",},					
					[DGV_LOCKMODELFRAME]		= { category = "Frames", text = "Lock Model Frame",  checked = true,  tooltip = "Lock model viewer frame into place", module = "ModelViewer"},
					[DGV_JOURNALFRAME]			= { category = "Frames",		text = "NPC Journal Button", checked = true,		tooltip = "Enable NPC Journal Frame", module = "NPCJournalFrame"},					
                    [DGV_JOURNALFRAMEBUTTONSTICKED]			= { category = "Frames",		text = "Floating NPC Journal Button", checked = false, tooltip = "Allow NPC Journal to float anywhere on the screen", indent=true, module = "NPCJournalFrame"},	
					[DGV_TARGETBUTTONCUSTOM]	= { category = "Target",	text = "Customize Macro",		checked = false,	tooltip = "Customize Target Macro", module = "Target", indent = true, editBox = "",},
					[DGV_TRGET_BUTTON_FIXED_MODE] = { category = "Target", text = "Fixed Mode", position = DGV_TARGETBUTTONSHOW + 1, indent = true, checked = true, default = true, tooltip = "", module = "Guides"},					
					[DGV_TARGETTOOLTIP]			= { category = "Target",		text = "Target Button Tooltip", checked = true, tooltip = "Display a tooltip for the target button to display the target name and model", indent = true, module = "Target"},						
					[DGV_WAYPOINT_PING]			= { category = "Dugi Arrow",		text = "Waypoint Reached Sound", checked = true, tooltip = "Plays a ping sound upon reaching each waypoint", showOnRightColumn = true},													
					[DGV_CLEAR_FINAL_WAYPOINT]	= { category = "Dugi Arrow",  dY = -26,	text = "Clear Final Waypoint", checked = false, tooltip = "Always clear the last waypoint on reach", showOnRightColumn = true},													
					[DGV_SHOW_EXTRA_WAYPOINT_ICON]            = { category = "Display",      text = "Show Waypoint Buttons", checked = true, tooltip = "", showOnRightColumn = true},        
					[DGV_MINIMIZE_MAP_BUTTON]	= { category = "Maps", text = "Minimize Map Button", checked = true, tooltip = ""},													
					[DGV_ENABLED_GUIDE_SHARING]	= { category = GuideSharingCategoryName, text = "Enable Guide Sharing", dY = -46,  checked = true,  tooltip = "If unchecked you will not be able to send and not receive Guide Sharing invitations.",},												
					[DGV_TARGET_TOOLTIP_OBJECTIVES]	= { category = "Tooltip", text = "Show Objectives In Target Tooltip",  checked = true,  tooltip = "",},												
					
					[DGV_BAD_COLOR]			= { category = "Dugi Arrow",	text = "Bad Color", checked = false, tooltip = "", showOnRightColumn = true},													
					[DGV_MIDDLE_COLOR]			= { category = "Dugi Arrow",	dX = 120, dY = 26,		text = "Middle Color", checked = false, tooltip = "", showOnRightColumn = true},													
					[DGV_GOOD_COLOR]			= { category = "Dugi Arrow",		text = "Good Color", checked = false, tooltip = "", showOnRightColumn = true},													
					[DGV_EXACT_COLOR]			= { category = "Dugi Arrow",	dX = 120, dY = 26,		text = "Exact Color", checked = false, tooltip = "", showOnRightColumn = true},													
					[DGV_QUESTING_AREA_COLOR]	= { category = "Dugi Arrow",	dX = 0, dY = -5,		text = "Questing Area Color", checked = false, tooltip = "", showOnRightColumn = true},													
				
					[DGV_WAY_SEGMENT_COLOR]		= { category = "Dugi Arrow",	position = DGV_TOMTOMEMULATION + 1,	text = "Ant Trail Color", dY = -18, dX = 100, checked = false,	tooltip = "",},					
					[DGV_ENABLED_GPS_ARROW]		= { category = "Dugi Zone Map", text = "Enable Zone Map", checked = true,	tooltip = "Turn on / off the Dugi Zone Map feature",},					
					[DGV_GPS_ARROW_AUTOZOOM]		= { category = "Dugi Zone Map", text = "Enable Auto Zoom", checked = true, default = true,	tooltip = "Automatically Zoom in / out the map based on the current waypoint",},					
					[DGV_GPS_AUTO_HIDE]		= { category = "Dugi Zone Map", text = "Auto Hide Zone Map", checked = true, default = true,	tooltip = "Automatically hides Dugi Map in case there are no waypoints.",},					
					[DGV_GPS_MERGE_WITH_DUGI_ARROW]		= { category = "Dugi Zone Map", text = "Merge With Dugi Arrow", checked = true, default = true,	tooltip = "Dugi Arrow text is displayed underneath the Zone Map and Dugi arrow is automatically shown within close range of the waypoints",},					
					[DGV_GPS_MINIMAP_TERRAIN_DETAIL]		= { category = "Dugi Zone Map", text = "Minimap Terrain Detail", checked = true, default = true,	tooltip = "Turns minimap terrain details on.",},					
					
					[DGV_ENABLED_GEAR_NOTIFICATIONS]			= { category = "Notifications",	position = 1,	text = "Gear Advisor Suggestions as Notifications", checked = true, tooltip = "If disabled standard gear suggestion prompts will be shown.", module = "GearAdvisor"},
					[DGV_ENABLED_GUIDE_NOTIFICATIONS]			= { category = "Notifications",	position = 3,	text = "Leveling Guide Suggestions as Notifications", checked = true, tooltip = "If disabled standard guide suggestion prompts will be shown.", module = "Guides"},													
					[DGV_ENABLED_JOURNAL_NOTIFICATIONS]			= { category = "Notifications",	position = 5,	text = "NPC Journal Frame targets as Notifications", checked = true, tooltip = "If enabled NPC Journal Frame prompts will be shown.", module = "Guides"},													
					[DGV_USE_NOTIFICATIONS_MARK]			= { category = "Notifications",	position = 6,	text = "Show |TInterface\\AddOns\\DugisGuideViewerZ\\Artwork\\notification.tga:20:20:0:0:64:64:39:64:0:25|t mark for new Notifications.", checked = true, tooltip = "If enabled |TInterface\\AddOns\\DugisGuideViewerZ\\Artwork\\notification.tga:16:16:0:0:64:64:39:64:0:25|t mark will be shown when new Notifications come.", module = "Guides"},													
					
					[DGV_ALWAYS_SHOW_STANDARD_PROMPT_GEAR]			= { category = "Notifications", indent = true, position = 2, text = "Always Show Standard Prompt", checked = true, tooltip = "", module = "Guides"},													
					[DGV_ALWAYS_SHOW_STANDARD_PROMPT_GUIDE]			= { category = "Notifications", indent = true, position = 4, text = "Always Show Standard Prompt", checked = true, tooltip = "", module = "Guides"},													

					[DGV_GUIDEDIFFICULTY]		= { category = "Questing",	text = "Leveling Mode",			checked = "Normal", module = "Hidden",
						options = {
							{	text = "Easy", colorCode = GREEN_FONT_COLOR_CODE, },
							{	text = "Normal", colorCode = YELLOW_FONT_COLOR_CODE, },
							{	text = "Hard", colorCode = ORANGE_FONT_COLOR_CODE, },
						}
					},
					[DGV_SMALLFRAMETRANSITION] 	= { category = "Frames",		text = "Small Frame Effect",	checked = "Flash", module = "SmallFrame",
						options = {
							{	text = "None", },
							{	text = "Flash", },
						}
					},
					[DGV_MAIN_FRAME_BACKGROUND] 	= { category = "Display",		text = "Background",	checked = "Solid", module = "SmallFrame",
						options = {
							{	text = "Solid", },
							{	text = "Transparent", },
						}
					}, 
					[DGV_ROUTE_STYLE] 	= { category = "Dugi Arrow",		text = "Ant Trail",	checked = "Dotted",
						options = {
							{	text = "Dotted", },
							{	text = "Solid", },
						}
					}, 
					[DGV_TALENT_PROFILE] 	= { category = "Talent Advisor", text = "", checked = "None",
						options = {
						}
				    }, 
					[DGV_LARGEFRAMEBORDER] 		= { category = "Frames",		text = "Borders",	checked = "BlackGold",
						options = {
							{	text = "Default", },
							{	text = "BlackGold", },
							{	text = "Bronze", },
							{	text = "DarkWood", },
							{	text = "ElvUI", value = "ElvUI", textFunc = function() 
								if Tukui then
									return "ElvUI/Tukui";
								else
									return "ElvUI";
								end
							end     },
							{	text = "Eternium", },
							{	text = "Gold", },
							{	text = "Metal", },
							{	text = "MetalRust", },
							{	text = "OnePixel", },
							{	text = "Stone", },
							{	text = "StonePattern", },
							{	text = "Thin", },
							{	text = "Wood", },
						}
					}, 
					[DGV_GPS_BORDER] 		= { category = "Dugi Zone Map",  text = "Dugi Map Borders",	checked = "TextPanel", default = 1,
						options = {
							{	text = "TextPanel", },
							{	text = "ElvUI2", },
						}
					},
					[DGV_STEPCOMPLETESOUND]		= { category = "Questing",	text = "Step Complete Sound", checked = "Sound\\Interface\\MapPing.ogg", module = "Guides",
						options = {
							{	text = "None", 			value	= nil },
							{	text = "Map Ping", 		value = [[Sound\Interface\MapPing.ogg]]},
							{	text = "Window Close", 		value = [[Sound\Interface\AuctionWindowClose.ogg]]},
							{	text = "Window Open", 		value = [[Sound\Interface\AuctionWindowOpen.ogg]]},
							{	text = "Boat Docked", 		value = [[Sound\Doodad\BoatDockedWarning.ogg]]},
							{	text = "Bell Toll Alliance", 	value = [[Sound\Doodad\BellTollAlliance.ogg]]},
							{	text = "Bell Toll Horde",	value = [[Sound\Doodad\BellTollHorde.ogg]]},
							{	text = "Explosion",		value = [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.ogg]]},
							{	text = "Shing!",		value = [[Sound\Doodad\PortcullisActive_Closed.ogg]]},
							{	text = "Wham!",			value = [[Sound\Doodad\PVP_Lordaeron_Door_Open.ogg]]},
							{	text = "Simon Chime",		value = [[Sound\Doodad\SimonGame_LargeBlueTree.ogg]]},
							{	text = "War Drums",		value = [[Sound\Event Sounds\Event_wardrum_ogre.ogg]]},
							{	text = "Humm",			value = [[Sound\Spells\SimonGame_Visual_GameStart.ogg]]},
							{	text = "Short Circuit",		value = [[Sound\Spells\SimonGame_Visual_BadPress.ogg]]},
						}
					},
                    [DGV_TAXIREACHEDSOUND]		= { category = "Taxi System",	text = "Taxi Reached Sound", checked = "", module = "Taxi",
						options = {
							{	text = "None", 			value	= nil },
							{	text = "Map Ping", 		value = [[Sound\Interface\MapPing.ogg]]},
							{	text = "Window Close", 		value = [[Sound\Interface\AuctionWindowClose.ogg]]},
							{	text = "Window Open", 		value = [[Sound\Interface\AuctionWindowOpen.ogg]]},
							{	text = "Boat Docked", 		value = [[Sound\Doodad\BoatDockedWarning.ogg]]},
							{	text = "Bell Toll Alliance", 	value = [[Sound\Doodad\BellTollAlliance.ogg]]},
							{	text = "Bell Toll Horde",	value = [[Sound\Doodad\BellTollHorde.ogg]]},
							{	text = "Explosion",		value = [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.ogg]]},
							{	text = "Shing!",		value = [[Sound\Doodad\PortcullisActive_Closed.ogg]]},
							{	text = "Wham!",			value = [[Sound\Doodad\PVP_Lordaeron_Door_Open.ogg]]},
							{	text = "Simon Chime",		value = [[Sound\Doodad\SimonGame_LargeBlueTree.ogg]]},
							{	text = "War Drums",		value = [[Sound\Event Sounds\Event_wardrum_ogre.ogg]]},
							{	text = "Humm",			value = [[Sound\Spells\SimonGame_Visual_GameStart.ogg]]},
							{	text = "Short Circuit",		value = [[Sound\Spells\SimonGame_Visual_BadPress.ogg]]},
						}
					},
					[DGV_TAXIFLIGHTMASTERS]		= { category = "Taxi System",	text = "Use Flightmasters", checked = "Auto",
						options = {
							{	text = "Auto", colorCode = GREEN_FONT_COLOR_CODE, value = "Auto" },
							{	text = "Always", colorCode = YELLOW_FONT_COLOR_CODE, value = "Always" },
							{	text = "Never", colorCode = RED_FONT_COLOR_CODE, value = "Never" },
						}
					},						
					[DGV_QUESTCOMPLETESOUND]		= { category = "Questing",	text = "Quest Complete Sound", checked = "Sound\\Creature\\Peon\\PeonBuildingComplete1.ogg", module = "DugisWatchFrame",
						options = {
							{	text = "None", 			value	= nil },
							{	text = "Default", 		value = [[Sound\Creature\Peon\PeonBuildingComplete1.ogg]]},
							{	text = "Troll Male", 		value = [[Sound\Character\Troll\TrollVocalMale\TrollMaleCongratulations01.ogg]]},
							{	text = "Troll Female",		value = [[Sound\Character\Troll\TrollVocalFemale\TrollFemaleCongratulations01.ogg]]},
							{	text = "Tauren Male",		value = [[Sound\Creature\Tauren\TaurenYes3.ogg]]},
							{	text = "Tauren Female",		value = [[Sound\Character\Tauren\TaurenVocalFemale\TaurenFemaleCongratulations01.ogg]]},
							{	text = "Undead Male",		value = [[Sound\Character\Scourge\ScourgeVocalMale\UndeadMaleCongratulations02.ogg]]},
							{	text = "Undead Female",		value = [[Sound\Character\Scourge\ScourgeVocalFemale\UndeadFemaleCongratulations01.ogg]]},
							{	text = "Orc Male",		value = [[Sound\Character\Orc\OrcVocalMale\OrcMaleCongratulations02.ogg]]},
							{	text = "Orc Female",		value = [[Sound\Character\Orc\OrcVocalFemale\OrcFemaleCongratulations01.ogg]]},
							{	text = "NightElf Female",	value = [[Sound\Character\NightElf\NightElfVocalFemale\NightElfFemaleCongratulations02.ogg]]},
							{	text = "NightElf Male",		value = [[Sound\Character\NightElf\NightElfVocalMale\NightElfMaleCongratulations01.ogg]]},
							{	text = "Human Female",		value = [[Sound\Character\Human\HumanVocalFemale\HumanFemaleCongratulations01.ogg]]},
							{	text = "Human Male",		value = [[Sound\Character\Human\HumanVocalMale\HumanMaleCongratulations01.ogg]]},
							{	text = "Gnome Male",		value = [[Sound\Character\Gnome\GnomeVocalMale\GnomeMaleCongratulations03.ogg]]},
							{	text = "Gnome Female",		value = [[Sound\Character\Gnome\GnomeVocalFemale\GnomeFemaleCongratulations01.ogg]]},
							{	text = "Dwarf Male",		value = [[Sound\Character\Dwarf\DwarfVocalMale\DwarfMaleCongratulations04.ogg]]},
							{	text = "Dwarf Female",		value = [[Sound\Character\Dwarf\DwarfVocalFemale\DwarfFemaleCongratulations01.ogg]]},
							{	text = "Draenei Male",		value = [[Sound\Character\Draenei\DraeneiMaleCongratulations02.ogg]]},
							{	text = "Draenei Female",	value = [[Sound\Character\Draenei\DraeneiFemaleCongratulations03.ogg]]},
							{	text = "BloodElf Female",	value = [[Sound\Character\BloodElf\BloodElfFemaleCongratulations03.ogg]]},
							{	text = "BloodElf Male",		value = [[Sound\Character\BloodElf\BloodElfMaleCongratulations02.ogg]]},
							{	text = "Worgen Male",		value = [[Sound\Character\PCWorgenMale\VO_PCWorgenMale_Congratulations01.ogg]]},
							{	text = "Worgen Female",		value = [[Sound\Character\PCWorgenFemale\VO_PCWorgenFemale_Congratulations01.ogg]]},
							{	text = "Goblin Male",		value = [[Sound\Character\PCGoblinMale\VO_PCGoblinMale_Congratulations01.ogg]]},
							{	text = "Goblin Female",		value = [[Sound\Character\PCGoblinFemale\VO_PCGoblinFemale_Congratulations01.ogg]]},
							{	text = "Pandaren Male",		value = [[Sound\Character\PCPandarenMale\VO_PCPandarenMale_Congratulations02.ogg]]},
							{	text = "Pandaren Female",		value = [[Sound\Character\PCPandarenFemale\VO_PCPandarenFemale_Congratulations02.ogg]]},						
							{	text = "Void Elf Male",	value = [[Sound\Character\pc_-_void_elf_male\vo_735_pc_-_void_elf_male_28_m.ogg]]},
							{	text = "Void Elf Female",	value = [[Sound\Character\pc_-_void_elf_female\vo_735_pc_-_void_elf_female_28_f.ogg]]},
							{	text = "Highmountain Tauren Male",	value = [[Sound\Character\pc_-_highmountain_tauren_male\vo_735_pc_-_highmountain_tauren_male_28_m.ogg]]},
							{	text = "Highmountain Tauren Female",	value = [[Sound\Character\pc_-_highmountain_tauren_female\vo_735_pc_-_highmountain_tauren_female_28_f.ogg]]},
							{	text = "Lightforged Draenei Male",	value = [[Sound\Character\pc_-_lightforged_draenei_male\vo_735_pc_-_lightforged_draenei_male_28_m.ogg]]},
							{	text = "Lightforged Draenei Female",	value = [[sound\character\pc_-_lightforged_draenei_female\vo_735_pc_-_lightforged_draenei_female_28_f.ogg]]},
							{	text = "Nightborne Male",	value = [[Sound\Character\pc_-_nightborne_elf_male\vo_735_pc_-_nightborne_elf_male_28_m.ogg]]},
							{	text = "Nightborne Female",	value = [[Sound\Character\pc_-_nightborne_elf_female\vo_735_pc_-_nightborne_elf_female_28_f.ogg]]},		
							{	text = "Dark Iron Dwarf Male",	value = [[Sound\Character\pc_dark_iron_dwarf_male\vo_801_pc_dark_iron_dwarf_male_284_m.ogg]]},
							{	text = "Dark Iron Dwarf Female",	value = [[Sound\Character\pc_dark_iron_dwarf_female\vo_801_pc_dark_iron_dwarf_female_284_f.ogg]]},
							{	text = "Mag'har Orc Male",	value = [[Sound\Character\pc_maghar_orc_male\vo_801_pc_maghar_orc_male_114_m.ogg]]},
							{	text = "Mag'har Orc Female",	value = [[Sound\Character\pc_maghar_orc_female\vo_801_pc_maghar_orc_female_114_f.ogg]]},												
						}
					},
					[DGV_TOOLTIPANCHOR]			= {category = "Tooltip",	text = "Tooltip Anchor", checked = "Default", module = "SmallFrame",
						options = {



							{	text = "Default", },
							{	text = "Bottom", },
							{	text = "Top", },
							{	text = "Left", },
							{	text = "Right", },
							{	text = "Bottom Left", },
							{	text = "Bottom Right", },
							{	text = "Top Left", },
							{	text = "Top Right", },
						}
					},
					[DGV_DISPLAYPRESET]			= {category = "Display",	text = "Recommended Preset Settings", checked = "Multi-step - Anchored", module = "SmallFrame",
						options = {
							{	text = "Minimal", },
							{	text = "Minimal - No Borders", },
							{	text = "Standard", },
							{	text = "Standard - Anchored", },
							{	text = "Multi-step", },
							{	text = "Multi-step - Anchored", },							
						}
					},
					[DGV_SMALLFRAMEDOCKING] = {category = "Frames", text = "Small Frame Behavior", checked = "Auto", module = "SmallFrame",
						tooltip = "Decides how the Small Frame will expand when it is not anchored inside the Watch Frame.",
						options = {
							{ text = "Auto", },
							{ text = "Relative to Watch Frame", },
							{ text = "Expand Down", },
							{ text = "Expand Up", },
							{ text = "Expand in Both Directions", },
						}
					},
					[DGV_MINIBLOBQUALITY]		= { category = "Maps",	text = "Minimap Blob Quality",	checked = 0 },
					[DGV_SHOWTOOLTIP]			= { category = "Tooltip",	text = "Auto Tooltip (%.1fs)", checked = 5, module = "SmallFrame", tooltip ="Amount of time the Tooltip will remain in view from the last mouse over on small frame" },
					[DGV_SMALL_FRAME_TABS_AMOUNT]	= {	category = "Display",	text = "Guide Tabs (%.0f)", checked = 2, module = "SmallFrame", tooltip = "Adjust the number of tabs in the Small Frame to load multiple guides" },
					[DGV_MOUNT_DELAY]	= {	category = "Auto Mount",	text = "Delay After Spell (%.1fs)", checked = 1, tooltip = "" },
                    [DGV_DISPLAYGUIDESPROGRESS] 	= { category = "Display",	text = "Show Progress Bar", intent = true, dX = 20,	checked = true,	tooltip = "Show Progress Bar", module = "SmallFrame"},
                    [DGV_DISPLAYGUIDESPROGRESSTEXT] 	= { category = "Display",	text = "Show % text", 	checked = true, indent = true, dX = 15,	tooltip = "Show % text", module = "SmallFrame"},
                    [DGV_TARGETBUTTONSCALE]	    = {	category = "Target",	text = "Target Button Size (%.1f)", checked = 1, module = "Target", tooltip = "Size of the target button." },
					[DGV_ITEMBUTTONSCALE]	    = {	category = "Questing",	text = "Item Button Size (%.1f)",showOnRightColumn = true, checked = 1, tooltip = "Size of the item button." },
					[DGV_NAMEPLATES_TRACKING] = { category = "Questing", text = "Nameplates Tracking", dY = -58, showOnRightColumn = true, checked = true, default = true, tooltip = "",},
					
					[DGV_NAMEPLATES_SHOW_ICON] = { category = "Questing", text = "Show icon", indent = true, showOnRightColumn = true, checked = true, default = false, tooltip = "",},
					[DGV_NAMEPLATES_SHOW_TEXT] = { category = "Questing", text = "Show text", position = DGV_NAMEPLATES_SHOW_ICON + 1, indent = true, showOnRightColumn = true, checked = true, default = false, tooltip = "",},
					[DGV_SHOW_SMALL_FRAME_HEADER] = { category = "Display",	position = DGV_DISPLAYGUIDESPROGRESS-1, text = "Show Guides Header", indent = false, showOnRightColumn = false, checked = true, default = true, tooltip = "",},									
					[DGV_NAMEPLATEICONSIZE]	    = {	category = "Questing",	text = "Nameplate icon size (%.1f)",showOnRightColumn = true, checked = 5, tooltip = "" },
					[DGV_NAMEPLATETEXTSIZE]	    = {	category = "Questing",	text = "Nameplate text size (%.1f)",showOnRightColumn = true, checked = 3, tooltip = "" },
                  
					[DGV_SHOWQUESTABANDONBUTTON]			= { category = "Questing",	showOnRightColumn = true,	text = "Abandon Quests Button",	checked = true,	tooltip = "Mass abandon quests button in your quest log to automatically abandon all quests by their category or zone",},
                    
                    -- This may be back [DGV_DISPLAYALLSTATS]			= { category = "Gear Scoring",	showOnRightColumn = false,	text = "Display All Stats",	checked = false,	tooltip = "Display unused stats for gear scoring",},					
                  
                    [DGV_JOURNALFRAMEBUTTONSCALE]	    = {	category = "Frames",	text = "NPC Journal Button Size (%.1f)", checked = 4, module = "SmallFrame", tooltip = "Size of the NPC Journal Frame button." },
                    [DGV_SMALLFRAME_STEPS]	    = {	category = "Display",	text = "Maximum Multi Step (%.0f)", checked = 4, module = "SmallFrame", tooltip = "Maximum amout of steps in the Small Frame." },
                    [DGV_PATH_WIDTH]	    = {	category = "Dugi Arrow",	text = "Trail Width (%.0f)", checked = 5,  tooltip = "" },
                    [DGV_DISTANCED_ARROW_SIZE]	    = {	category = "Dugi Arrow",	text = "Size (%.0f)", checked = 7,  tooltip = "" },
                    [DGV_GPS_BORDER_OPACITY]	    = {	category = "Dugi Zone Map",	text = "Zone Map Border Opacity (%.1f)", checked = 1, default = 1, tooltip = "" },
                    [DGV_GPS_MAPS_OPACITY]	    = {	category = "Dugi Zone Map",	text = "Zone Map Opacity (%.1f)", checked = 0.4, default = 0.3, tooltip = "" },
                    [DGV_GPS_MAPS_SIZE]	    = {	category = "Dugi Zone Map",	text = "Zone Map Size (%.1f)", checked = 5, default = 5, tooltip = "" },
                    [DGV_GPS_ARROW_SIZE]	    = {	category = "Dugi Zone Map",	text = "Character Arrow Size (%.1f)", checked = 2, default = 2, tooltip = "" },
					[DGV_RECORDSIZE]			= { checked = 500 },
				},
			},
		},
		global = {
			[DGV_GAWEIGHTSCUSTOM]		= { category = "Gear Advisor", text = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|tCustom Stat Weights", module = "GearAdvisor"},
		}
	}
	
    --Number 100 for checkboxes was reached. It cannot be used because it would conflict with DGV_GUIDEDIFFICULTY.  
	local sz = defaults.profile.char.settings.sz
	
	LuaUtils:loop(99, function(val)
		sz[#sz + 1] = val
	end)
	
    --For new checkboxes their ids should be added here.
	sz[#sz + 1] = DGV_WAY_SEGMENT_COLOR
	sz[#sz + 1] = DGV_SMALL_FRAME_EXTEND_UP	
	sz[#sz + 1] = DGV_SHOW_OBJ_BULBS	
	sz[#sz + 1] = DGV_SHOW_OBJ_BULBS_ON_HOVER	
	sz[#sz + 1] = DGV_TRAIN_SUGGESTIONS	
	sz[#sz + 1] = DGV_CLEAR_FINAL_WAYPOINT	
	sz[#sz + 1] = DGV_MINIMIZE_MAP_BUTTON	
	sz[#sz + 1] = DGV_ENABLED_GUIDE_SHARING	
	sz[#sz + 1] = DGV_TARGET_TOOLTIP_OBJECTIVES	
	sz[#sz + 1] = DGV_SHOW_EXTRA_WAYPOINT_ICON	
	sz[#sz + 1] = DGV_DISTANCED_ARROW
	sz[#sz + 1] = DGV_DISTANCED_ARROW_PING_COLOR
	sz[#sz + 1] = DGV_CTRL_RIGHT_CLICK_ARROW_MENU
	sz[#sz + 1] = DGV_ENABLEDGEARFINDER
		
	self.db 		= LibStub("AceDB-3.0"):New("DugisGuideViewerProfiles", defaults)
	self.chardb		= self.db.profile.char.settings
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")
	--Track quest POIs enabled by default	
	if not DugisGuideViewer.chardb["trownsFolkTypeFilters"] then DugisGuideViewer.chardb["trownsFolkTypeFilters"] = {} end
	if DugisGuideViewer.chardb["trownsFolkTypeFilters"][14] == nil then 
		DugisGuideViewer.chardb["trownsFolkTypeFilters"][14] = true
	end
end

function DugisGuideViewer:GetDefaultValue(settingId)
	return DugisGuideViewer.chardb[settingId].default
end

function DugisGuideViewer:GuideOn()
	return DugisGuideViewer.chardb.GuideOn
end

function DugisGuideViewer:IsGoldMode()
	return DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1
end

function DugisGuideViewer:ProfileChanged()
	self.chardb = self.db.profile.char.settings
	self:ForceAllSettingsTreeCategories()
	self:SettingFrameChkOnClick()
    DugisGuideViewer:RestoreFramesPositions()
	--After dugi fix in the copper mode Update is not available (clocking it: #128)
    if DugisGuideViewer.Modules.DugisWatchFrame.DelayUpdate then
        DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
    end
end

local function Dugi_Fix()
	CurrentTitle = nil
    if DGV.SetLastUsedStepIndex then
        DGV.SetLastUsedStepIndex(-1)
    end
	DugisGuideViewer.CurrentTitle = nil
	DugisGuideUser.CurrentQuestIndex = nil
	CurrentQuestName = nil
	DugisGuideUser = (DugisGuideUser and wipe(DugisGuideUser)) or  {}
	DugisGuideUser.toskip = {}
	DugisGuideUser.QuestState = {}
	DugisGuideUser.turnedinquests = {}
	DugisGuideUser.removedQuests = {}
	DugisFlightmasterDataTable = {}
	DugisGuideViewerDB = nil
	DugisGuideViewer:ClearScreen()
	DugisGuideViewer.chardb.QuestRecordTable.framePositions = {}
	DugisGuideUser.SkipSaveFramesPosition = true	
    DugisGuideUser.userCustomWeights_v3 = nil
	questId2Title = {data={}}
end

local function ResetDB()
	local essentials = DugisGuideViewer.chardb.EssentialsMode
	local rev = DugisGuideViewer.chardb.SettingsRevision
	local guid = DugisGuideUser.CharacterGUID
	Dugi_Fix()
	LoadSettings()
	DugisGuideViewer.chardb.FirstTime = true
	DugisGuideUser.CharacterGUID = UnitGUID("player") or guid or "PRIOR_RESET"
	DugisGuideViewer.chardb.SettingsRevision = SettingsRevision
	DugisGuideViewer.chardb.EssentialsMode = essentials
end

local startTime = GetTime()
local lastIncompatibleAddonLoaded = nil
function DugisGuideViewer:IncompatibleAddonLoaded()
	local dT = GetTime() - startTime
	if dT > 5 and lastIncompatibleAddonLoaded ~= nil then
		return lastIncompatibleAddonLoaded
	end
	lastIncompatibleAddonLoaded = (DGV.carboniteloaded and Nx.Quest) or DGV.sexymaploaded or DGV.nuiloaded or DGV.elvuiloaded or DGV.tukuiloaded or DGV.shestakuiloaded or DugisGuideUser.PetBattleOn or DugisGuideViewer.dominosquestloaded or DugisGuideViewer.eskaquestloaded
	return lastIncompatibleAddonLoaded
end

function DugisGuideViewer:IsSmallFrameFloating()
	return (not DugisGuideViewer:UserSetting(DGV_ANCHOREDSMALLFRAME)) 
	--If Incompatible Addon is Loaded we don't want to modify the Watch Quest Frame so the small frame should me separated
	or DGV:IncompatibleAddonLoaded()
	or not DugisGuideViewer:IsGoldMode()
end

function DugisGuideViewer:IsSmallFrameAnchored()
	return not  DugisGuideViewer:IsSmallFrameFloating()
end

local function GetShareSystem()
	DugisGuideViewer.chardb.shareSystem = DugisGuideViewer.chardb.shareSystem or {}
	return DugisGuideViewer.chardb.shareSystem
end

DGV.GetShareSystem = GetShareSystem

local CATEGORY_TREE
function DugisGuideViewer:OnInitialize()
	DugisGuideViewer.Debug = DugisGuideViewer.Debug or DugisGuideUser.DebugOn
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("ZONE_CHANGED");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	self:RegisterEvent("QUEST_ACCEPTED")
	self:RegisterEvent("QUEST_WATCH_UPDATE")
	self:RegisterEvent("QUEST_LOG_UPDATE")
	self:RegisterEvent("QUEST_TURNED_IN")
	self:RegisterEvent("UNIT_QUEST_LOG_CHANGED")	
	self:RegisterEvent("QUEST_AUTOCOMPLETE")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_COMPLETE")	
	self:RegisterEvent("UI_INFO_MESSAGE")
	--self:RegisterEvent("QUEST_QUERY_COMPLETE")
	self:RegisterEvent("ZONE_CHANGED_INDOORS")
	self:RegisterEvent("MINIMAP_UPDATE_ZOOM")	
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("SKILL_LINES_CHANGED")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
	self:RegisterEvent("SPELLS_CHANGED")

	
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

	self:RegisterEvent("PLAYER_TARGET_CHANGED")

	if not self:IsRegisteredEvent("CHAT_MSG_ADDON") then
		self:RegisterEvent("CHAT_MSG_ADDON")
	end	

	C_ChatInfo.RegisterAddonMessagePrefix("dugis")
	
	CATEGORY_TREE = { 
        [SEARCH_LOCATIONS_CATEGORY ] =  { value = "Search Locations", 	text = L["Search Locations"]}, 
        [QUESTING_CATEGORY         ] =  { value = "Questing", 	text = L["Questing"] },
        [DUGI_ARROW_CATEGORY       ] =  { value = "Dugi Arrow", 	text = L["Dugi Arrow"] }, 
        [DUGI_ZONE_MAP_CATEGORY    ] =  { value = "Dugi Zone Map", 	text = L["Dugi Zone Map"] }, 
        [DISPLAY_CATEGORY          ] =  { value = "Display", 	text = L["Display"], 	icon = nil }, 
        [FRAMES_CATEGORY           ] =  { value = "Frames", 	text = L["Frames"]}, 
		[GEAR_ADVISOR_CATEGORY	   ] =  { value = "Gear Advisor", 	text = L["Gear Advisor"], scroll = true }, 
        [MAPS_CATEGORY             ] =  { value = "Maps", 		text = L["Maps"] }, 
        [TAXI_SYSTEM_CATEGORY      ] =  { value = "Taxi System",text = L["Taxi System"],icon = nil }, 
        [TARGET_BUTTON_CATEGORY    ] =  { value = "Target",		text = L["Target Button"]}, 
        [TOOLTIP_CATEGORY          ] =  { value = "Tooltip", 	text = L["Tooltip"] },
		[OTHER_CATEGORY            ] =  { value = "Other", 		text = L["Other"] }, 
		[GUIDE_SHARING_CATEGORY    ] =  { value = GuideSharingCategoryName, 		text = L[GuideSharingCategoryName] }, 
        [PROFILES_CATEGORY 	       ] =  { value = "Profiles", 	text = L["Profiles"] }, 
		[TALENT_ADVISOR_CATEGORY   ] =  { value = "Talent Advisor", 	text = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t"..L["Talent Advisor"], }, 

	}

	if not DugisGuideViewer:IsModuleRegistered("Guides") then tremove(CATEGORY_TREE, TOOLTIP_CATEGORY) end --Tooltip

	if not DugisGuideViewer:IsModuleRegistered("Target") then tremove(CATEGORY_TREE, TARGET_BUTTON_CATEGORY) end --Target
	if not DugisGuideViewer:IsModuleRegistered("Guides") then tremove(CATEGORY_TREE, DISPLAY_CATEGORY) end --Display
	if not DugisGuideViewer:IsModuleRegistered("GearAdvisor") then tremove(CATEGORY_TREE, GEAR_ADVISOR_CATEGORY) end
	
	LoadSettings()
	if DugisGuideViewerDB and DugisGuideViewerDB.char then --migrate old user data
		local settings = DugisGuideViewerDB.char[self.db.keys.profile] and DugisGuideViewerDB.char[self.db.keys.profile].settings
		if settings and settings.SettingsRevision==self.chardb.SettingsRevision then
			for k, v in pairs(settings) do
				self.db.profile.char.settings[k] = v
			end
		end
		DugisGuideViewerDB = nil
	end
	if self.chardb.SettingsRevision~=SettingsRevision then
		DugisGuideViewer:DebugFormat("resetting self.chardb.settings.SettingsRevision", "revision", self.chardb.SettingsRevision)
		ResetDB()
		self.chardb.SettingsRevision=SettingsRevision;
	end
	if not DugisGuideViewer:IsModuleRegistered("Guides") then
		self.chardb.EssentialsMode = 1
	end
	--self:InitMapping( )
	DugisGuideViewer:UpdateMainFrame()
    DugisGuideViewer:UpdateAutoMountEnabled()
    
    GUIUtils:CreatePreloader("MainFramePreloader", DugisMain)
    MainFramePreloader:SetFrameStrata("DIALOG")
    MainFramePreloader:SetFrameLevel(120)
	
	DGV.InitializeShareGuide()

	LuaUtils:Delay(2, function()
		local currentTitle 
		if DugisGuideViewer:IsGoldMode() then
			currentTitle = CurrentTitle
		end		
		DGV.SendDataToServer("CLIENT_ONLINE", {currentTitle}, 1)
		DGV.SendDataToClients("SERVER_ONLINE")
	end)

end

function DugisGuideViewer:initAnts()
	local addon
	
	DugisGuideViewer.carboniteloaded = nil
	DugisGuideViewer.tomtomloaded = nil
	DugisGuideViewer.sexymaploaded = nil
	DugisGuideViewer.nuiloaded = nil
	DugisGuideViewer.tukuiloaded = nil
	DugisGuideViewer.elvuiloaded = nil
	DugisGuideViewer.shestakuiloaded = nil
	DugisGuideViewer.mapsterloaded = nil
	DugisGuideViewer.armoryloaded = nil
	DugisGuideViewer.outfitterloaded = nil
	DugisGuideViewer.arkinventoryloaded = nil
	DugisGuideViewer.zygorloaded = nil
	DugisGuideViewer.wqtloaded = nil	
	DugisGuideViewer.dominosquestloaded = nil	
	DugisGuideViewer.eskaquestloaded = nil		

	for addon=1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(addon)

		local loaded = IsAddOnLoaded(addon)
		
		if name == "Carbonite" and loaded then DugisGuideViewer.carboniteloaded = false 
		elseif name == "TomTom" and loaded then DugisGuideViewer.tomtomloaded = true
--		elseif name == "SexyMap" and loaded then DugisGuideViewer.sexymaploaded = true
		elseif name == "nUI" and loaded then DugisGuideViewer.nuiloaded = true
		elseif name == "Tukui" and loaded then DugisGuideViewer.tukuiloaded = true
--		elseif name == "ElvUI" and loaded then DugisGuideViewer.elvuiloaded = true
		elseif name == "LUI" and loaded then DugisGuideViewer.luiloaded = true
		elseif name == "ShestakUI" and loaded then DugisGuideViewer.shestakuiloaded = true
		elseif name == "Mapster" and loaded then DugisGuideViewer.mapsterloaded = true
		elseif name == "Armory" and loaded then DugisGuideViewer.armoryloaded = true
		elseif name == "Outfitter" and loaded then DugisGuideViewer.outfitterloaded = true
		elseif name == "Wholly" and loaded then DugisGuideViewer.whollyloaded = true
		elseif name == "ArkInventory" and loaded then DugisGuideViewer.arkinventoryloaded = true 
		elseif name == "ZygorGuidesViewer" and loaded then DugisGuideViewer.zygorloaded = true
		elseif name == "Dominos_Quest" and loaded then DugisGuideViewer.dominosquestloaded = true	
		elseif name == "EskaQuestTracker" and loaded then DugisGuideViewer.eskaquestloaded = true				
		elseif name == "WorldQuestTracker" and loaded then 
			DugisGuideViewer.wqtloaded = true 
			if WQTrackerDB then 
				if WQTrackerDB.profiles.Default.enable_doubletap then
					WQTrackerDB.profiles.Default.enable_doubletap = false
					print("|cff11ff11" .. "Dugi: Disabled WorldQuestTracker's \"Auto World Map\" option, this needs to be off for Dugi waypoint.")
				end
			end
		end	
	end
	
	--if DugisGuideViewer.tomtomloaded then TomTom.profile.persistence.cleardistance = 0 end
end

function DugisGuideViewer:GetFontWidth(text, fonttype)
	local font = fonttype or "GameFontNormal"

	if not DugisFW then CreateFrame( "GameTooltip", "DugisFW" ) end
	local frame = DugisFW
	local fontstring = frame:CreateFontString("tmpfontstr","ARTWORK", font)
	fontstring:SetText(text)
	local fontwidth = fontstring:GetStringWidth()
	return fontwidth
end

function DugisGuideViewer:PrintTable( tbl )
	local key, val, val2
	
	DebugPrint("Table Contents:")
	
	if not tbl then DebugPrint("Table Empty") return end
	
	for key, val in pairs(tbl) do
		if type(val) == "table" then
			for _, val2 in pairs(val) do
				self:PrintBoolTbl(key,val2)
			end
		else
			self:PrintBoolTbl(key,val)
		end
	end
end

function DugisGuideViewer:PrintBoolTbl(key, val)
	local printstr = "key: "
	if type(key) == "boolean" then
		if key == true then printstr = printstr.."true" else printstr = printstr.."false" end
	else

		printstr = printstr..key
	end
	
	printstr = printstr.." val: "
	if type(val) == "boolean" then
		if val == true then printstr = printstr.."true" else printstr = printstr.."false" end
	else
		printstr = printstr..val
	end
	
	DebugPrint(printstr)
end


function DugisGuideViewer:RestoreFramesPositions()
--todo: uncomment this
	if DugisGuideViewer.chardb.QuestRecordTable.framePositions then
        LuaUtils:foreach(savablePositionsFrameNames, function(frameName)
			local framePosition = DugisGuideViewer.chardb.QuestRecordTable.framePositions[frameName]
			if framePosition and not (frameName == "WatchFrame" and (DugisGuideViewer:IncompatibleAddonLoaded() or not DGV:GuideOn() ))
            then
				local frame = _G[frameName]
				if frame then
                    if frameName == "DugisFlightProgressBar" then
                        frame = frame.Bar
                    end
					frame:ClearAllPoints( )
					if framePosition.point then
						if type(framePosition.relativeTo) == "string" and not _G[framePosition.relativeTo] then
							return;
						end
						frame:SetPoint(framePosition.point, framePosition.relativeTo, framePosition.relativePoint, framePosition.xOfs, framePosition.yOfs)
						
						if frameName == "WatchFrame" and DugisGuideViewer.Modules.DugisWatchFrame then
							local WF = DugisGuideViewer.Modules.DugisWatchFrame
							WF.objectiveTrackerX, WF.objectiveTrackerY = GUIUtils:GetRealFeamePos(WatchFrame)
						end
						
					end
				end
			end
		end)
	end

	DugisGuideViewer.restoredFramePositions = true
end

function DugisGuideViewer:NotificationsEnabled()
    return DugisGuideViewer:UserSetting(DGV_DISABLE_QUICK_SETTINGS) ~= true
end

function DugisGuideViewer:UpdateNotificationsMarkVisibility()
    local notifications = DugisGuideViewer:GetNotifications()
    
    if #notifications > 0 and DugisGuideViewer:UserSetting(DGV_USE_NOTIFICATIONS_MARK) then
        NotificationsMark:Show()
    else
        NotificationsMark:Hide()
    end
end

local notificationsData = {}

function DugisGuideViewer:GetNotifications()
    return notificationsData
end

function DugisGuideViewer:SetNotifications(notifications)
    notificationsData = notifications
    DugisGuideViewer:UpdateNotificationsMarkVisibility()
end

local visualNotifications = {}

function DugisGuideViewer:NotificationsVisible()
    return true
end

function DugisGuideViewer:Notification2VisualNotification(id)
    local result
    for _, visualNotification in pairs(visualNotifications) do
        if visualNotification.id == id then
            result = visualNotification
            break
        end
    end
    return result
end

local lastUsedId = 1
function DugisGuideViewer:AddNotification(definition, limitPerNotificationType)
    local notifications = DugisGuideViewer:GetNotifications()
    
    --Check if some gear suggestion already exists. In case it does remove it. 
    --This ensures that only one gear-suggestion is shown
    if definition.notificationType == "gear-suggestion" then
        for index, notification in pairs(notifications) do
            if notification.notificationType == "gear-suggestion" then
                DugisGuideViewer:RemoveNotification(notification.id)
            end
        end
    end
    
    definition = definition or {}
    
    --Check if the same notification already exists
    if definition.notificationType == "journal-frame-notification" then
        local alreadyExisting = DugisGuideViewer:GetNotificationsBy(function(notification) 
            return notification.journalData and notification.journalData.guideObjectId == definition.guideObjectId and notification.journalData.guideType == definition.guideType  
        end)
        
        if alreadyExisting and #alreadyExisting > 0 then
            return 
        end
    end
    
    --Removing items above the limit
    if limitPerNotificationType then
        local oldAmount = DugisGuideViewer:CountNotificationsByType(definition.notificationType)
        while oldAmount >= limitPerNotificationType do
            local theOldest = DugisGuideViewer:GetTheOldestNotification()
            DugisGuideViewer:RemoveNotification(theOldest.id)
            oldAmount = DugisGuideViewer:CountNotificationsByType(definition.notificationType)
        end
    end
    
    notifications[#notifications + 1] = {
        title = definition.title
        , notificationType = definition.notificationType
        , id = lastUsedId
        , created = GetTime()
    }
    
    if definition.notificationType == "journal-frame-notification" then
        notifications[#notifications].journalData = {guideObjectId = definition.guideObjectId, guideType = definition.guideType}
    end
    
    lastUsedId = lastUsedId + 1
    
    DugisGuideViewer:SetNotifications(notifications)
	
	return notifications[#notifications]
end

function DugisGuideViewer:RemoveNotification(id)
    local notifications = DugisGuideViewer:GetNotifications()
    
    for index, notification in pairs(notifications) do
        if notification.id == id then
            table.remove(notifications, index)
        end
    end
    
    DugisGuideViewer:SetNotifications(notifications)
end

function DugisGuideViewer:RemoveGuideSuggestionNotifications()
	local notification = DugisGuideViewer:GetNotificationByType("guide-suggestion")
	if notification then
		self:RemoveNotification(notification.id)
	end	
end

function DugisGuideViewer:RemoveNotificationWithAnimation(id)
    local visualNotification = DugisGuideViewer:Notification2VisualNotification(id)
    if visualNotification then
        LuaUtils:FadeOut(visualNotification, 1, 0, 0.7, 
        function()
            DugisGuideViewer:RemoveNotification(id)
            DugisGuideViewer:ShowNotifications()
            DugisGuideViewer.RefreshMainMenu()
        end)
    else
		DugisGuideViewer:RemoveNotification(id)
	end
end

function DugisGuideViewer:GetNotification(id)
    local notifications = DugisGuideViewer:GetNotifications()
    local result
    
    for index, notification in pairs(notifications) do
        if notification.id == id then
            result = notification
            break
        end
    end
    
    return result
end

function DugisGuideViewer:GetNotificationByTitle(title)
    local notifications = DugisGuideViewer:GetNotificationsBy(function(notification)
        return notification.title == title
    end)
    
    return notifications and notifications[1]
end


function DugisGuideViewer:GetTheOldestNotification()
    local notifications = DugisGuideViewer:GetNotifications()
    local theOldest
    for index, notification in pairs(notifications) do
        if theOldest == nil or notification.created < theOldest.created then
            theOldest = notification
        end
    end
    
    return theOldest
end

function DugisGuideViewer:CountNotificationsByType(notificationType)
    return #DugisGuideViewer:GetNotificationsByType(notificationType)
end


function DugisGuideViewer:GetNotificationsBy(filterFunction)
    local notifications = DugisGuideViewer:GetNotifications()
    local result = {}

    for index, notification in pairs(notifications) do
        if filterFunction(notification) then
            result[#result + 1] = notification
        end
    end
    
    return result
end

function DugisGuideViewer:GetNotificationsByType(notificationType)
    return DugisGuideViewer:GetNotificationsBy(function(notification)
        return notification.notificationType == notificationType
    end)
end

function DugisGuideViewer:GetNotificationByType(notificationType)
    local result = DugisGuideViewer:GetNotificationsByType(notificationType)
    if #result > 0 then
        return result[1]
    end
end

local lastNotificationParent = nil
local lastNotificationsConfig = nil

function DugisGuideViewer:ShowNotifications(parent, config)

    if not parent and not lastNotificationParent then
        return
    end
    
    lastNotificationParent = parent or lastNotificationParent
    lastNotificationsConfig = config or lastNotificationsConfig or {}

    local notifications = DugisGuideViewer:GetNotifications()
    
    local dY = 0
    
    DugisGuideViewer:HideNotifications()
    
    if not self.NotificationsHeader then
        self.NotificationsHeaderParent = CreateFrame("Frame", nil, lastNotificationParent)
        self.NotificationsHeaderParent:SetPoint("TOPLEFT", lastNotificationParent, "TOPLEFT", 15, -12) 
        self.NotificationsHeaderParent:Show()
        self.NotificationsHeaderParent:SetWidth(100)
        self.NotificationsHeaderParent:SetHeight(20)
        
        self.NotificationsHeader = self.NotificationsHeaderParent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft") 
        self.NotificationsHeader:SetText("Notifications")
        self.NotificationsHeader:Show()
        self.NotificationsHeader:SetPoint("TOPLEFT", self.NotificationsHeaderParent, "TOPLEFT", 0, 0)    
        self.NotificationsHeader:SetAlpha(1) 
    end
    
    if #notifications > 0 then
        dY = -20
        self.NotificationsHeaderParent:Show()
    else
        self.NotificationsHeaderParent:Hide()
    end
    
    for index, notification in pairs(notifications) do
        --Building notification 
        local visualNotification
        
        if visualNotifications[index] then
            visualNotification = visualNotifications[index]
        else
            visualNotifications[index] = CreateFrame("Button", nil, lastNotificationParent, "NotificationItemTemplate")
            visualNotification = visualNotifications[index]
        end
        
        if DugisGuideViewer:NotificationsVisible() then
            visualNotification:Show()
        end
        
        visualNotification:SetAlpha(1)
        visualNotification:ClearAllPoints()       
        
        visualNotification:SetPoint("TOPLEFT", lastNotificationParent, "TOPLEFT", (lastNotificationsConfig.dX or 0), dY + (lastNotificationsConfig.dY or 0))
        visualNotification:SetPoint("RIGHT", lastNotificationParent, "RIGHT", -(lastNotificationsConfig.dX or 0), 0)

        visualNotification.Title:SetText(notification.title)  
        
        local height = visualNotification.Title:GetHeight() + 5
        
        if height < 20 then 
            height = 20
        end        
        
        visualNotification:SetHeight(height)        
        visualNotification.Background:SetHeight(height)  

        dY = dY - height - 1                
        
        visualNotification.id = notification.id
    end
    
    DugisGuideViewer:UpdateNotificationsMarkVisibility()
    
    return -dY
end

function DugisGuideViewer:HideNotifications()
    for _, visualNotification in pairs(visualNotifications) do
        visualNotification:Hide()
    end
end

function DugisGuideViewer:OnNotificationClicked(notification)

    if notification.notificationType == "journal-frame-notification" then
        local guideType = notification.journalData.guideType
        local guideObjectId = notification.journalData.guideObjectId
        
        DugisGuideViewer.NPCJournalFrame:SetGuideData(guideType, guideObjectId, true)
        
        LuaUtils:FadeOut(LibDugi_DropDownList1, 1, 0, 0.7, 
        function()
            DugisGuideViewer:RemoveNotification(notification.id)
            DugisGuideViewer:UpdateNotificationsMarkVisibility()
            LibDugi_DropDownList1:Hide()
            LibDugi_DropDownList1:SetAlpha(1)
        end)
		return
        
    end    


    if notification.notificationType == "gear-suggestion" then
        DugisEquipPromptFrame:Show()
        DugisEquipPromptFrame.notificationId = notification.id
        
        LuaUtils:FadeOut(LibDugi_DropDownList1, 1, 0, 0.7, 
        function()
            DugisGuideViewer:RemoveNotification(notification.id)
            DugisGuideViewer:UpdateNotificationsMarkVisibility()
            LibDugi_DropDownList1:Hide()
            LibDugi_DropDownList1:SetAlpha(1)
        end)
		return
        
    end    
	
    if notification.notificationType == "guide-suggestion" then
        DugisGuideViewer:AskGuideSuggest(UnitLevel("player"))
        LuaUtils:FadeOut(LibDugi_DropDownList1, 1, 0, 0.7, 
        function()
            DugisGuideViewer:RemoveNotification(notification.id)
            DugisGuideViewer:UpdateNotificationsMarkVisibility()
            LibDugi_DropDownList1:Hide()
            LibDugi_DropDownList1:SetAlpha(1)
        end)
		return
    end
	
    if notification.notificationType == "training-suggestion" then
		TrainPromptFrame:Show()
		DugisGuideViewer:RemoveNotificationWithAnimation(notification.id)
		DugisGuideViewer:UpdateNotificationsMarkVisibility()
		LibDugi_DropDownList1:Hide()
		LibDugi_DropDownList1:SetAlpha(1)
		return
    end
	
    DugisGuideViewer:RemoveNotificationWithAnimation(notification.id)
end

function DugisGuideViewer:OnNotificationDismissClicked(notification)
    if notification.notificationType == "gear-suggestion" then
        DugisEquipPromptFrame:Show()
        DugisEquipPromptFrameCancelButton:Click()
    end
end

--/run TestNotifications()
local function TestNotifications()
    DugisGuideViewer:AddNotification({title = "Test notification 1"})
    DugisGuideViewer:AddNotification({title = "Test notification 2"})
    DugisGuideViewer:AddNotification({title = "Test notification 3"})
    DugisGuideViewer:AddNotification({title = "Test notification 4"})
    DugisGuideViewer:ShowNotifications()
    DugisGuideViewer.RefreshMainMenu()
end

function DugisGuideViewer:OnLoad()
	--DugisGuideViewer.Target:Init( )
	--DugisGuideViewer.chardb.GuideOn = true
	--DugisGuideViewer.StickyFrame:Init( )
	
    --TestNotifications()
    
	self:SetAllBorders()
	DugisGuideViewer:SetMemoryOptions()

	DugisGuideViewer:SetEssentialsOnCancelReload()
    DugisGuideViewer.DugiGuidesOnLoadingStart()

LuaUtils:PostCombatRun("LoadingModules", function(threading)
    if not DugisGuideViewer:GuideOn() then
        LuaUtils.DugiGuidesIsLoading = false
    end

	DugisGuideViewer.chardb.GuideOn = DugisGuideViewer:GuideOn() and DugisGuideViewer:ReloadModules(threading)
	DugisGuideViewer:SettingFrameChkOnClick(_, true)
	
	if ((DugisGuideViewer.carboniteloaded and Nx.Quest) or DugisGuideViewer.sexymaploaded or DugisGuideViewer.nuiloaded or DugisGuideViewer.elvuiloaded or DugisGuideViewer.tukuiloaded or DugisGuideViewer.shestakuiloaded or DugisGuideViewer.dominosquestloaded or DugisGuideViewer.eskaquestloaded) then 
		DugisGuideViewer:SetDB(false, DGV_ANCHOREDSMALLFRAME)

		DugisGuideViewer:SetDB(false, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:UpdateCompletionVisuals()
	end

    LuaUtils:collectgarbage(threading)
	DugisGuideViewer:UpdateIconStatus()
	if DugisGuideViewer:IsModuleLoaded("DugisWatchFrame") and self:UserSetting(DGV_DISABLEWATCHFRAMEMOD) then
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
	end
	DugisGuideViewer:RefreshQuestWatch()
	DugisGuideUser.PetBattleOn = false
	
	if DugisGuideViewer:UserSetting(DGV_ENABLENPCNAMEDB) == false then
		DugisGuideViewer:SetDB(true, DGV_ENABLENPCNAMEDB)
	end
    
    DugisGuideViewer:RestoreFramesPositions()
    
    --bugfix #128 Fix unclickable DG icon bug
    if DugisOnOffButton:GetTop() == nil then
        DugisOnOffButton:ClearAllPoints();
        DugisOnOffButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", -13, -20)
    end
end)
    

end

function DugisGuideViewer:SetMemoryOptions()
	--[[if not DugisGuideViewer:UserSetting(DGV_ENABLEMODELDB) then 
		--table.wipe(self.ModelViewer.npcDB)
		--table.wipe(self.ModelViewer.objDB)
		--self.ModelViewer.npcDB = {}

		--self.ModelViewer.objDB = {}
		--DebugPrint("#Wipe Objects")
		DugisGuideViewer.UnloadModule("NpcsF")
		DugisGuideViewer.UnloadModule("ObjectsF")
		DugisGuideViewer.UnloadModule("NpcsT")
		DugisGuideViewer.UnloadModule("ObjectsT")
		DugisGuideViewer.UnloadModule("ModelViewer")
	elseif DugisGuideViewer.GuideOn then
		DugisGuideViewer:LoadModule("ModelViewer")
		DugisGuideViewer.LoadModule("NpcsF")
		DugisGuideViewer.LoadModule("ObjectsF")
		DugisGuideViewer.LoadModule("NpcsT")
		DugisGuideViewer.LoadModule("ObjectsT")
	end
	
	if not DugisGuideViewer:UserSetting(DGV_ENABLENPCNAMEDB) then 
		--table.wipe(DugisNPCs)
		DugisNPCs = {}
		DebugPrint("#Wipe NPC table")
	end
	
	if not DugisGuideViewer:UserSetting(DGV_ENABLEQUESTLEVELDB) then
		--table.wipe(self.ReqLevel)
		self.ReqLevel = {}
		DebugPrint("#Wipe ReqLevel table")
	end]]
	
	collectgarbage()
end

local function Disable(frame, dontChangeState)
	if frame then 
		--DebugPrint("frame type:"..frame:GetObjectType())
		if frame:GetObjectType() == "CheckButton" then
			if not dontChangeState then
				frame:SetChecked(false)
			end
			frame.Text:SetTextColor(0.5, 0.5, 0.5)
		end
		frame:Disable() 
	end
end

local function Enable(frame)
	if frame then
		if frame:GetObjectType() == "CheckButton" then
			frame.Text:SetTextColor(1, 1, 1) 
		end
		frame:Enable() 
	end
end

local profileCache = {}
local profileList = {}
local function getProfileList(noCurrent, noDefaults)
	wipe(profileList)
	if not noDefaults then
		profileList[1] = L["Default"]
		profileList[2] = DugisGuideViewer.db.keys.char
		profileList[3] = tinsert(profileList, DugisGuideViewer.db.keys.realm)
		profileList[4] = UnitClass("player")
	end
	
	wipe(profileCache)
	DugisGuideViewer.db:GetProfiles(profileCache)
	for _,v in ipairs(profileCache) do
		if not tContains(profileList, v) then
			tinsert(profileList, v)
		end
	end
	
	if noCurrent then
		for i,v in ipairs(profileList) do
			if v==DugisGuideViewer.db.keys.profile then
				tremove(profileList, i)
				break
			end
		end
	end
	
	return profileList
end

local function SetUseItem(index)
	DugisGuideViewer:SetUseItem(index)
end

local function SetUseItemByQID(questId)
	DugisGuideViewer:SetUseItemByQID(questId)
end

function DugisGuideViewer:UpdateOrderedListView(optionIndex, ...)
	local SettingsDB = 	DugisGuideViewer.chardb
	local container = _G["DGV_OrderedListContainer"..optionIndex]
	local height = 16*#SettingsDB[optionIndex].options
	if height==0 then height=1 end
	container:SetHeight(height)
	local lastShown
	for i=1,select("#", ...) do
		local option = SettingsDB[optionIndex].options[i]
		local child = select(i, ...)
		if option then
			if type(option)=="string" then
				child.text:SetText(L[option])
			else
				local _, specName = GetSpecializationInfo(option)
				child.text:SetText(specName)
			end
			child:Show()
			lastShown = child
		else
			child:Hide()
		end
	end
	return lastShown
end

function DugisGuideViewer:GetNamedMountType(mountType)
    if  mountType == 230 then
        return "ground"
    end
    
    if mountType == 248  then
        return "flying"
    end
    
    if mountType == 254  or mountType == 231 or mountType == 232 then
        return "aquatic"
    end
    
    return "other"
end

--Configuration
local rightColumnX = DUGI_SETTINGS_RIGHT_COLUMN_X
local columnPaddingLeft = DUGI_SETTINGS_PADDING_LEFT

function DugisGuideViewer:InsertControlBeforeCheckbox(SettingNum, category, top, topRightColumn, frame)
    if category=="Frames" and SettingNum == DGV_SMALLFRAMEBORDER then
        --Borders
		local fontstring = frame:CreateFontString(nil,"ARTWORK", "GameFontNormalLarge")
		fontstring:SetText(L["Borders"])
		fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + columnPaddingLeft, topRightColumn - 77)    
	end
	
	if category=="Dugi Arrow" and SettingNum == DGV_BAD_COLOR then
		local fontstring = frame:CreateFontString(nil,"ARTWORK", "GameFontNormal")
		fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + columnPaddingLeft, topRightColumn - 7)   
	    topRightColumn = topRightColumn - 30
		DGV.arrowColorsSectionHeader = fontstring
	end
	
	if category=="Other" and SettingNum == DGV_ENABLEQUESTLEVELDB and (DugisGuideViewer:IsModuleRegistered("Guides") 
	or DugisGuideViewer:IsModuleRegistered("ReqLevel") ) then
        --Memory
		local fontstring = frame:CreateFontString(nil,"ARTWORK", "GameFontNormalLarge")
		fontstring:SetText(L["Memory"])
		fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + columnPaddingLeft, topRightColumn + 24)    
	end	
    
    return top, topRightColumn
end

function DugisGuideViewer:InsertControlAfterCheckbox(SettingNum, category, top, topRightColumn, frame)
	--Reset Profile Button
	if category=="Dugi Arrow" and not DGV_ResetColorsButton and SettingNum == DGV_QUESTING_AREA_COLOR then
	
		topRightColumn = topRightColumn - 15
		local button = CreateFrame("Button", "DGV_ResetColorsButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Default Colors"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + columnPaddingLeft, topRightColumn)
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() 
			if DugisGuideViewer:UserSetting(DGV_DISTANCED_ARROW) then
				DugisGuideViewer.onColorChange("DGV_DISTANCED_ARROW_PING_COLOR", unpack(DugisGuideViewer.defaultDistancedArrowPingColor))
			else
				DugisGuideViewer.onColorChange("DGV_BAD_COLOR", unpack(DugisGuideViewer.defaultBadArrowColor))
				DugisGuideViewer.onColorChange("DGV_MIDDLE_COLOR", unpack(DugisGuideViewer.defaultMiddleArrowColor))
				DugisGuideViewer.onColorChange("DGV_GOOD_COLOR", unpack(DugisGuideViewer.defaultGoodArrowColor))
				DugisGuideViewer.onColorChange("DGV_EXACT_COLOR", unpack(DugisGuideViewer.defaultExactArrowColor))
				DugisGuideViewer.onColorChange("DGV_QUESTING_AREA_COLOR", unpack(DugisGuideViewer.defaultQuestingAreaColor))
			end
		end)

		DGV.defaultColorsButton = button
	end

	if category=="Other" and not DGV_ResetTrainSuggestions and SettingNum == DGV_TRAIN_SUGGESTIONS then
		local button = CreateFrame("Button", "DGV_ResetTrainSuggestions", frame, "UIPanelButtonTemplate")
		local btnText = L["Reset"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", DUGI_SETTINGS_PADDING_LEFT + 130 + fontwidth, top + 25)
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() 
			for abilityId, abilityInfo in pairs(DugisGuideUser.suggestionState or {}) do 
				abilityInfo.ignored = false
			end
			DGV.CheckForTrainingSuggestions()
		end)
	end
	
	if category=="Dugi Zone Map" and not DGV_ResetGPSButton and SettingNum == DGV_GPS_MERGE_WITH_DUGI_ARROW then
	
		local button = CreateFrame("Button", "DGV_ResetGPSButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Default Setting"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top - 180)
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() 
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_ARROW_AUTOZOOM)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_AUTO_HIDE)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_MERGE_WITH_DUGI_ARROW)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_MINIMAP_TERRAIN_DETAIL)
			
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_BORDER_OPACITY)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_MAPS_OPACITY)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_MAPS_SIZE)
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_ARROW_SIZE)
			
			DugisGuideViewer.SetSettingDefaultValue(DGV_GPS_BORDER)
			
			DugisGuideViewer.Modules.GPSArrowModule.UpdateVisibility()
			DugisGuideViewer.Modules.GPSArrowModule.UpdateMerged()
			DugisGuideViewer.Modules.GPSArrowModule.UpdatePOISVisibility()
			DugisGuideViewer.Modules.GPSArrowModule:UpdateBorder()
			DugisGuideViewer.Modules.GPSArrowModule.UpdateMinimapAlpha()
		end)
	end
	
	if category=="Notifications" and SettingNum == DGV_USE_NOTIFICATIONS_MARK then
		top = top - 12
		if not enableNotificationsInfo then
			frame:CreateFontString("enableNotificationsInfo","ARTWORK", "GameFontHighlightSmall")
			enableNotificationsInfo:SetText(L["Enable Quick Settings option in 'Other' category to use Notifications."])
		end
		enableNotificationsInfo:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top )    	
	end
    
    return top, topRightColumn
end

function DugisGuideViewer:UpdateCheckbox(SettingNum)
	if SettingNum == DGV_USE_NOTIFICATIONS_MARK then
		if DugisGuideViewer:NotificationsEnabled() then
			enableNotificationsInfo:Hide()
		else
			enableNotificationsInfo:Show()
		end
	end
end

function DugisGuideViewer.UpdateSettingsCheckbox(settingsId)
    local value = DugisGuideViewer:GetDB(settingsId)
    local chkBoxName = "DGV.ChkBox"..settingsId
    local chkBox = _G[chkBoxName]
    if chkBox then
        chkBox:SetChecked(value)
    end
end

function DugisGuideViewer.SetCheckboxChecked(settingsId, newValue)
	DugisGuideViewer:SetDB(newValue, settingsId)
	DugisGuideViewer.UpdateSettingsCheckbox(settingsId)
end

function DugisGuideViewer.SetSettingDefaultValue(settingsId)
	local defaultValue = DugisGuideViewer:GetDefaultValue(settingsId)
	if defaultValue ~= nil then
		if DugisGuideViewer.sliderControls[settingsId] then
			--Slider
			DugisGuideViewer.sliderControls[settingsId]:SetValue(defaultValue)
		elseif DugisGuideViewer.dropdownControls[settingsId] then
		
			local defaultIndex = defaultValue
			local defaultValue
			if type(DugisGuideViewer.chardb[settingsId].options[defaultIndex]) == "string" then
				defaultValue = DugisGuideViewer.chardb[settingsId].options[defaultIndex]
			else
				defaultValue = DugisGuideViewer.chardb[settingsId].options[defaultIndex].text
			end
			
			DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DugisGuideViewer.dropdownControls[settingsId], defaultIndex)
			DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DugisGuideViewer.dropdownControls[settingsId], defaultValue)
			DugisDropDown.LibDugi_UIDropDownMenu_SetText(DugisGuideViewer.dropdownControls[settingsId], defaultValue)
			
			DugisGuideViewer:SetDB(defaultValue, settingsId)
		else
			--Checkbox
			DugisGuideViewer:SetDB(defaultValue, settingsId)
			DugisGuideViewer.UpdateSettingsCheckbox(settingsId)
		end
	end
end

local function IsScrollCategory(category)
	for _, categoryNode in next,CATEGORY_TREE do
		if categoryNode.value == category then
			return categoryNode.scroll
		end
	end
end

local AceGUI = LibStub("AceGUI-3.0")
local function GetSettingsCategoryFrame(category, parent)
	local self = DugisGuideViewer
	local frameName = string.format("DGV_%sCategoryFrame", category)
	local frame = _G[frameName]
	if not frame then
		if IsScrollCategory(category) then
			frame = CreateFrame("ScrollFrame", frameName, parent, "UIPanelScrollFrameTemplate")
			frame:SetAllPoints()
			local topMargin, bottomMargin = -4, 4 --solves a bit of clipping outside the border
			if DugisGuideViewer.chardb.EssentialsMode == 1 then
				frame:SetPoint("TOPLEFT", 0, topMargin -5)
				frame:SetPoint("BOTTOMRIGHT", -9, bottomMargin) 
			else
				frame:SetPoint("TOPLEFT", 0, topMargin)
				frame:SetPoint("BOTTOMRIGHT", 0, bottomMargin) 
			end
			frame:SetScrollChild(CreateFrame("Frame", frameName.."ScrollChild", frame))
			frame.ScrollChild = frame:GetScrollChild()
			frame.ScrollChild:SetPoint("TOPLEFT")
			frame.ScrollChild:SetWidth(parent:GetWidth())
			frame.ScrollChild:SetHeight(parent:GetHeight() + topMargin - bottomMargin - 190)
		else
			frame =  CreateFrame("Frame", frameName, parent)
			frame:SetAllPoints(parent)
		end
	
		local frame = frame.ScrollChild or frame
		local fontstring = frame:CreateFontString(nil,"ARTWORK", "GameFontNormalLarge")
		fontstring:SetText(L[category])
		fontstring:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, -16)
	end
	
	local SettingsDB = 	DugisGuideViewer.chardb
	local top = -40
    local topRightColumn = -40
	
	local checkboxesInfo = {}
	
    for _, SettingNum in pairs(SettingsDB.sz) do
		checkboxesInfo[#checkboxesInfo + 1] = {SettingNum = SettingNum, info = SettingsDB[SettingNum]}
	end
	
    --Sorting table by ids (standard past behaviour). In case position parameter exists sorts by position.
    table.sort(checkboxesInfo, function(a, b)
		local position_a = (a.info and a.info.position) or a.SettingNum
		local position_b = (b.info and b.info.position) or b.SettingNum
		
		return position_a < position_b
    end)

    for _, info in pairs(checkboxesInfo) do
		local SettingNum = info.SettingNum
		local setting = SettingsDB[SettingNum]
		if setting and setting.category==category
			and(not DugisGuideViewer:GetDB(SettingNum, "module") 
			or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(SettingNum, "module")))
		then
			local chkBoxName = "DGV.ChkBox"..SettingNum
			local chkBox = _G[chkBoxName]
			if not chkBox then
				local frame = frame.ScrollChild or frame
				top, topRightColumn = DugisGuideViewer:InsertControlBeforeCheckbox(SettingNum, category, top, topRightColumn, frame)
				
				chkBox = CreateFrame("CheckButton", chkBoxName, frame, "InterfaceOptionsCheckButtonTemplate")
                
                local topValue = top
                local xShift = 0
                
                if SettingsDB[SettingNum].showOnRightColumn then
                    xShift = rightColumnX
                    
                    topValue = topRightColumn
					
					topValue = topValue + (SettingsDB[SettingNum].dY or 0)
                    topRightColumn = topRightColumn - chkBox:GetHeight()
                    topRightColumn = topRightColumn + (SettingsDB[SettingNum].dY or 0)
				else
					topValue = topValue + (SettingsDB[SettingNum].dY or 0)
                    top = top - chkBox:GetHeight()
					top = top + (SettingsDB[SettingNum].dY or 0)
                end
                
				xShift = xShift + (SettingsDB[SettingNum].dX or 0)
				
				if SettingsDB[SettingNum].indent then
					chkBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 40 + xShift, topValue)
				else
					chkBox:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft + xShift, topValue)
				end
				chkBox.Text:SetText(L[SettingsDB[SettingNum].text])
				chkBox:SetHitRectInsets(0, 0, 0, 0)
				chkBox:RegisterForClicks("LeftButtonDown")
				chkBox:SetScript("OnClick", function() DugisGuideViewer:SettingFrameChkOnClick (chkBox) 	   end)
				chkBox:SetScript("OnEnter", function() DugisGuideViewer:SettingsTooltip_OnEnter(chkBox, event) end)
				chkBox:SetScript("OnLeave", function() DugisGuideViewer:SettingsTooltip_OnLeave(chkBox, event) end)
                

				top, topRightColumn = DugisGuideViewer:InsertControlAfterCheckbox(SettingNum, category, top, topRightColumn, frame)	
                
			end
			chkBox:SetChecked(SettingsDB[SettingNum].checked)
			
			DugisGuideViewer:UpdateCheckbox(SettingNum)
		end
	end
	
	if category=="Dugi Arrow" then
		function DugisGuideViewer.onColorChange(id, r, g, b, alpha)
			DugisGuideUser[id] = {r, g, b, alpha}
			DugisArrowGlobal.lastAngle = -1000
			
			_G["DGV.ChkBox".._G[id]]:SetColor({r, g, b})
			_G["DGV.ChkBox".._G[id]].alpha = alpha
		end
	
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_BAD_COLOR], DugisGuideUser.DGV_BAD_COLOR or DugisGuideViewer.defaultBadArrowColor , function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_BAD_COLOR", r, g, b)
		end)
		
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_MIDDLE_COLOR], DugisGuideUser.DGV_MIDDLE_COLOR or DugisGuideViewer.defaultMiddleArrowColor, function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_MIDDLE_COLOR", r, g, b)
		end)	
		
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_GOOD_COLOR], DugisGuideUser.DGV_GOOD_COLOR or DugisGuideViewer.defaultGoodArrowColor, function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_GOOD_COLOR", r, g, b)
		end)
		
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_EXACT_COLOR], DugisGuideUser.DGV_EXACT_COLOR or DugisGuideViewer.defaultExactArrowColor, function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_EXACT_COLOR", r, g, b)
		end)
		
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_QUESTING_AREA_COLOR], DugisGuideUser.DGV_QUESTING_AREA_COLOR or DugisGuideViewer.defaultQuestingAreaColor, function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_QUESTING_AREA_COLOR", r, g, b)
		end)		
		
		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_WAY_SEGMENT_COLOR], DugisGuideUser.DGV_WAY_SEGMENT_COLOR or DugisGuideViewer.defaultWaySegmentColor(), function(r, g, b)
			DugisGuideViewer.onColorChange("DGV_WAY_SEGMENT_COLOR", r, g, b)
		end)

		GUIUtils:MakeColorPicker(_G["DGV.ChkBox"..DGV_DISTANCED_ARROW_PING_COLOR], DugisGuideUser.DGV_DISTANCED_ARROW_PING_COLOR or DugisGuideViewer.defaultDistancedArrowPingColor, function(r, g, b, alpha)
			DugisGuideViewer.onColorChange("DGV_DISTANCED_ARROW_PING_COLOR", r, g, b, alpha)
			DGV.TriggerPingAnimation(5)
		end)

		DGV.UpdateDistancedArrowSettingsSection()
	end
	

	
	--Customize macro edit box
	if SettingsDB[DGV_TARGETBUTTONCUSTOM].category==category
		and(not DugisGuideViewer:GetDB(DGV_TARGETBUTTONCUSTOM, "module")
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_TARGETBUTTONCUSTOM, "module")))
	then
		local macroFrame = _G["DGV.MacroFrame"]
		local textBox =  _G["DGV.InputBox"..DGV_TARGETBUTTONCUSTOM]
		local chkBox =  _G["DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM]
		if not macroFrame then
			macroFrame = CreateFrame("Frame", "DGV.MacroFrame", frame, "BackdropTemplate")
			textBox = CreateFrame("EditBox", "DGV.InputBox"..DGV_TARGETBUTTONCUSTOM,  macroFrame, "InputBoxTemplate")
			chkBox = CreateFrame("CheckButton", "DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM, frame, "InterfaceOptionsCheckButtonTemplate")
			if SettingsDB[DGV_TARGETBUTTONCUSTOM].indent then
				chkBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, top)
			else
				chkBox:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top)
			end
			chkBox.Text:SetText(L[SettingsDB[DGV_TARGETBUTTONCUSTOM].text])
			chkBox:SetHitRectInsets(0, -200, 0, 0)
			chkBox:RegisterForClicks("LeftButtonDown")
			chkBox:SetScript("OnClick", function() DugisGuideViewer:SettingFrameChkOnClick (chkBox)	   end)
			chkBox:SetScript("OnEnter", function() DugisGuideViewer:SettingsTooltip_OnEnter(chkBox, event) end)
			chkBox:SetScript("OnLeave", function() DugisGuideViewer:SettingsTooltip_OnLeave(chkBox, event) end)

			top = top - chkBox:GetHeight()

			macroFrame:SetSize(260, 90)
			macroFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, top)
			DugisGuideViewer:SetFrameBackdrop(macroFrame, "Interface\\Tooltips\\UI-Tooltip-Background", "Interface\\Tooltips\\UI-Tooltip-Border", 5, 5, 5, 5)
			macroFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
			macroFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);

			textBox:SetMultiLine(true)
			textBox:SetSize(260, 90)
			textBox:SetAutoFocus(false)
			textBox:ClearAllPoints( )
			textBox:SetPoint("TOPLEFT", macroFrame, "TOPLEFT", 10, -10)
			textBox:SetPoint("BOTTOMRIGHT", macroFrame, "BOTTOMRIGHT", -10, -10)
			textBox:SetMaxLetters(215)
			local filename, _, _ = textBox:GetFont()
			textBox:SetFont(filename, 11)
			textBox.Left:SetTexture(nil)
			textBox.Middle:SetTexture(nil)
			textBox.Right:SetTexture(nil)
			
			textBox:Show()
			
			top = top - macroFrame:GetHeight()
			
			local button = DugisGuideViewer:CreateButton("DGV_ApplyMacroButton", frame, "Apply", function() DugisGuideViewer.Modules.Target:CustomizeMacro() end)
			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, top-3)
			local right = button:GetWidth()
			
			button = DugisGuideViewer:CreateButton("DGV_ResetMacroButton", frame, "Default", function() DugisGuideViewer.Modules.Target:ResetMacro() end)
			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 40 + right, top-3)
			local right2 = button:GetWidth()
			
			button = DugisGuideViewer:CreateButton("DGV_ClearMacroButton", frame, "Clear", function() DugisGuideViewer.Modules.Target:ClearMacro() end)

			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 40 + right + right2, top-3)

			
			top = top-3-button:GetHeight()
		end
		
		chkBox:SetChecked(SettingsDB[DGV_TARGETBUTTONCUSTOM].checked)
		textBox:SetText(self.chardb[DGV_TARGETBUTTONCUSTOM].editBox)
	end
	
	if category == "Auto Mount" then
        if not DGV_MountIcon_ground then
        
            local function onMountIconEnter(node)
                local name = C_MountJournal.GetMountInfoByID(node.nodeData.data.mountId)
                local creatureDisplayID, descriptionText, sourceText, isSelfMount, mountType = C_MountJournal.GetMountInfoExtraByID(node.nodeData.data.mountId)
                
                if DugisGuideViewer:IsModuleLoaded("NPCJournalFrame") and DugisGuideViewer.NPCJournalFrame and name and creatureDisplayID then
                DugisGuideViewer.NPCJournalFrame:ShowGuideObjectPreview(name, creatureDisplayID)
                end
            end
            
            local function onMountIconLeave(node)
                if DugisGuideViewer:IsModuleLoaded("NPCJournalFrame") and DugisGuideViewer.NPCJournalFrame.hintFrame then
                    DugisGuideViewer.NPCJournalFrame.hintFrame.frame:Hide()   
                end
            end
        
            local function PrepareMountsForTree(requestedMountType)
                local result = {}
            
                local dontMountText = ""
  
            
                result[#result + 1] = {name = "Don't mount", icon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up"
                , data = {mountType = requestedMountType, buttonType = "none"}}
                
                result[#result + 1] = {name = "Random Favorite " .. LuaUtils:CamelCase(requestedMountType), icon = "Interface\\Icons\\achievement_guildperk_mountup"
                , data = {mountType = requestedMountType, buttonType = "auto"}}
            
            
                local firstContainer = {}
                local secondContainer = {}
                local unsortedTempFirstContainer = {}
                local unsortedTempSecondContainer = {}
            
                for _, mountId in pairs(C_MountJournal.GetMountIDs()) do
                    local name, _, icon, _, isUsable, _, isFavorite, isFactionSpecific, faction, _, isCollected = C_MountJournal.GetMountInfoByID(mountId)
                    local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(mountId)
                    
                                    
                    local _, _, _, _, isUsable, _, isFavorite, _, _, _, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountId)
                    local _, _, _, _, mountTypeId = C_MountJournal.GetMountInfoExtraByID(mountId)       

                    local englishFaction, localizedFaction = UnitFactionGroup("player")
                    local rightFaction = (isFactionSpecific == false) or (englishFaction == "Alliance" and faction == 1) or (englishFaction == "Horde" and faction == 0)
                    
                    if isCollected and rightFaction then
                        --use requestedMountType for order purposes
                        local container = unsortedTempSecondContainer
                        if requestedMountType ==  DugisGuideViewer:GetNamedMountType(mountType) then
                            container = unsortedTempFirstContainer
                        end
                        
                        container[#container + 1] = {name = name, icon = icon, onMouseEnter = onMountIconEnter, onMouseLeave = onMountIconLeave,
                        data = {mountId = mountId, mountType = requestedMountType, buttonType = "mount-item"}}
                    end
                end
                
                table.sort(unsortedTempFirstContainer, function(a,b) return a.name < b.name end)
                table.sort(unsortedTempSecondContainer, function(a,b) return a.name < b.name end)
                
                for _, mount in pairs(unsortedTempFirstContainer) do
                    firstContainer[#firstContainer + 1] = mount
                end             
                
                for _, mount in pairs(unsortedTempSecondContainer) do
                    secondContainer[#secondContainer + 1] = mount
                end
                
                for _, item in pairs(firstContainer) do
                    result[#result + 1] = item
                end
                
                for _, item in pairs(secondContainer) do
                    result[#result + 1] = item
                end
            
                return result
            end
            
            function DugisGuideViewer:UpdateMountSettingsIcons()
                for _, mountType in pairs({"ground", "flying", "aquatic"}) do
                    local preferedMount =  DugisGuideViewer.chardb["prefered-auto-mount-"..mountType]
                 
                    if preferedMount == "auto" or preferedMount == nil then
                        _G["DGV_MountIcon_"..mountType]:SetNormalTexture("Interface\\Icons\\achievement_guildperk_mountup")
                        _G["DGV_MountIcon_"..mountType].Title:SetText("Random Favorite")
                    elseif preferedMount == "none" then
                        _G["DGV_MountIcon_"..mountType]:SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
                        _G["DGV_MountIcon_"..mountType].Title:SetText("None")
                    else
                        local name, _, icon = C_MountJournal.GetMountInfoByID(preferedMount)
                        _G["DGV_MountIcon_"..mountType]:SetNormalTexture(icon)
                        _G["DGV_MountIcon_"..mountType].Title:SetText(name)
                    end
                
                end
            end
            
            local mountListScrollFrame
            
            local function ShowMounts(mountType)
                local config = {
                      parent = frame
                    , name                    = "mountsList"
                    , data                    = PrepareMountsForTree(mountType)
                    , x                       = rightColumnX
                    , y                       = -10
                    , nodesOffsetY            = -10
                    , width                   = 420
                    , height                  = 308
                    , onNodeClick             = function(visualNode)
                            mountsListwrapper:Hide()
                            
                            if visualNode.nodeData.data.buttonType == "mount-item" then 
                                DugisGuideViewer.chardb["prefered-auto-mount-"..mountType] = visualNode.nodeData.data.mountId
                            elseif visualNode.nodeData.data.buttonType == "auto" then
                                DugisGuideViewer.chardb["prefered-auto-mount-"..mountType] = "auto"
                            elseif visualNode.nodeData.data.buttonType == "none" then
                                 DugisGuideViewer.chardb["prefered-auto-mount-"..mountType] = "none"
                            end
                            
                            DugisGuideViewer:UpdateMountSettingsIcons()
                            
                            mountListScrollFrame.scrollBar:Hide()
                      end
                    , iconSize                = 25
                    , nodeHeight              = 27
                    , noScrollMode            = false
                    , columnWidth             = 240
                    , nodeTextX               = 30
                    , scrollX                 = 560
                    , scrollY                 = -40
                    , scrollHeight            = 260
                    , nodeTextY               = -7 }
                
                mountListScrollFrame = GUIUtils.SetScrollableTreeFrame(config)
                
                mountListScrollFrame.scrollBar:ClearAllPoints()
                mountListScrollFrame.frame:ClearAllPoints()
                
                mountListScrollFrame.scrollBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -20, -40)
                mountListScrollFrame.frame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 100, -15)  
            end
        
            local function addText(y, name, title)
                local text = frame:CreateFontString(name, "ARTWORK", "GameFontHighlight")
                text:SetText(L[title])
                text:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 20, y)            
            end
            
            local function addIcon(y, mountType)
                local button = CreateFrame("Button", "DGV_MountIcon_"..mountType, frame, "DugisGuideTreeNodeTemplate")
                button.Title:SetText("None")
                button.Title:SetPoint("TOPLEFT", button, "TOPLEFT", 40, -10)
                button:SetWidth(150)
                button:SetHeight(32)
                button.normal:SetWidth(32)
                button.normal:SetHeight(32)
                button.highlight:SetWidth(32)
                button.highlight:SetHeight(32)
                button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, y)
                button:Show()
                button:SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
                button:SetScript("OnClick", function()
                    ShowMounts(mountType)
                end)
            end
            
            local space = -60
            local offset = -92
            local iconOffset = 3
            
            addText(space * 0 + offset, "flyingTitle", "Prefered mount in flyable areas")
            addIcon(space * 0 + offset - iconOffset, "flying")
            
            addText(space * 1 + offset,"groundTitle", "Prefered mount in non-flyable areas")
            addIcon(space * 1 + offset - iconOffset,"ground")
            
            addText(space * 2 + offset, "aquaticTitle", "Prefered mount in water")
            addIcon(space * 2 + offset - iconOffset, "aquatic")
            
            local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
            local btnText = L["Key Bindings"]
            local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
            button:SetText(btnText)
            button:SetWidth(fontwidth + 20)
            button:SetHeight(22)
            button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, -rightColumnX)
            button:RegisterForClicks("LeftButtonUP")
            button:SetScript("OnClick", function() 
                GUIUtils:ShowBindings("Dugi Guides")
            end)
          
        end
        
        DugisGuideViewer:UpdateMountSettingsIcons()
	end
	
	--custom new profile
	if category=="Profiles" then
		local profileFrame = _G["DGV.CustomProfileFrame"]
		local textBox =  _G["DGV.InputBox"..DGV_PROFILECUSTOM]
		if not profileFrame then
			profileFrame = CreateFrame("Frame", "DGV.CustomProfileFrame", frame)
			profileFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 22, top)
			profileFrame:SetPoint("RIGHT")
			
			-- new profile
			textBox = CreateFrame("EditBox", "DGV.InputBox"..DGV_PROFILECUSTOM,  profileFrame, "InputBoxTemplate")
			local newButton = DugisGuideViewer:CreateButton("DGV_NewProfileButton", profileFrame, L["OK"], function() DugisGuideViewer.db:SetProfile(textBox:GetText()) end)
			textBox:SetMultiLine(false)
			textBox:SetSize(200, 15)
			textBox:SetAutoFocus(false)
			textBox:ClearAllPoints( )
			textBox:SetPoint("BOTTOMLEFT", 3, 0)
			newButton:SetPoint("LEFT", textBox, "RIGHT", 3)
			newButton:SetWidth(50)
			newButton:Show()
			textBox:Show()
			
			local dropdown_text = textBox:CreateFontString("DGV_CustomProfileFrameTitle", "ARTWORK", "GameFontHighlight")
			dropdown_text:SetText(L["New Profile"])
			dropdown_text:SetPoint("BOTTOMLEFT", textBox, "TOPLEFT", -5, 7)
			profileFrame:SetHeight(22+dropdown_text:GetHeight())
			
			top = top - 5 - profileFrame:GetHeight()
		end
		
		textBox:SetText(self.db.keys.profile)
	end
	
	if SettingsDB[DGV_ENABLED_GUIDE_SHARING].category==category  then
		DGV.sharesSettingsParentFrame = frame
		DGV.UpdateServerShareVisualization()
	end

	local function UpdateSettingsSearchHeight()
        local _max = SettingsSearchScroll.frame.wrapper.height
        
        if _max < 1 then
            _max = 1
        end
        
        SettingsSearchScroll.scrollBar:SetMinMaxValues(1, _max) 
    end
        
    if category == "Search Locations" and not DugisGearWeightsClassDropdownLabel then
        if not SettingsSearchScroll then
            SettingsSearchScroll = GUIUtils:CreateScrollFrame(frame)
                        
            SettingsSearchScroll.frame:SetWidth(388) 
            SettingsSearchScroll.scrollBar:SetPoint("TOPLEFT", parent, "TOPLEFT", 570, -52)
            SettingsSearchScroll.scrollBar:SetWidth(30)
            SettingsSearchScroll.scrollBar:Hide()
            
            
            
            SettingsSearchScroll.frame:EnableMouseWheel(true)
            SettingsSearchScroll.frame:SetScript("OnMouseWheel", function(self, delta)
                SettingsSearchScroll.scrollBar:SetValue(SettingsSearchScroll.scrollBar:GetValue() - delta * 24)  
            end)     
            
        end
        
        
        if not SettingsSearch_SearchBox then
            CreateFrame("EditBox", "SettingsSearch_SearchBox", frame, "InputBoxTemplate")
        end
        
        SettingsSearch_SearchBox:SetAutoFocus(false)
        SettingsSearch_SearchBox:SetSize("150", "25")
        SettingsSearch_SearchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 180, -10)
        SettingsSearch_SearchBox:SetScript("OnLoad", function(self)  end)
        SettingsSearch_SearchBox:SetScript("OnEscapePressed", function(self) self:SetAutoFocus(false) self:ClearFocus() end)
        SettingsSearch_SearchBox:SetScript("OnTextChanged", function() 
            if SettingsSearch_SearchBox:GetNumLetters() > 1 then
                local nodes = DugisGuideViewer:GetLocationsAndPortalsByText(SettingsSearch_SearchBox:GetText())
                
                --Passing data to tree frame       
                GUIUtils:SetTreeData(SettingsSearchScroll.frame, nil, "SettingMenu", nodes, nil, nil, function(self)
                    UpdateSettingsSearchHeight()

                end, function(self)
                    
                    DugisGuideViewer:RemoveAllWaypoints()
                    local data = self.nodeData.data
                    if data.isPortal == true then
                        DugisGuideViewer:AddCustomWaypoint(data.x, data.y, "Portal " .. data.mapName, data.mapId, data.f)      
                    else
                        local mapId = DugisGuideViewer:GetMapIDFromName(data.zone)
                        DugisGuideViewer:AddCustomWaypoint(data.x / 100, data.y / 100, data.subzoneName, mapId, 0)      
                    end
					SettingsSearch_SearchBox:SetAutoFocus(false)
					SettingsSearch_SearchBox:ClearFocus()
                end)  
                
                UpdateSettingsSearchHeight()
                SettingsSearchScroll.frame.wrapper:UpdateTreeVisualization()
                
                if  SettingsSearchScroll.frame.wrapper.height > 200 then
                    SettingsSearchScroll.scrollBar:Show()

                else
                    SettingsSearchScroll.scrollBar:Hide()
                end
                 
                SettingsSearchScroll.scrollBar:SetPoint("TOPLEFT", SettingsSearchScroll.scrollBar:GetParent(), "TOPLEFT", 562, -17)

                SettingsSearchScroll.frame.wrapper:SetWidth(423)
                SettingsSearchScroll.frame:SetWidth(608)
                SettingsSearchScroll.frame.wrapper:SetHeight(64)
 
                SettingsSearchScroll.frame:SetHeight(291)
                SettingsSearchScroll.scrollBar:SetHeight(256)
                SettingsSearchScroll.scrollBar:SetFrameLevel(100)
                
                SettingsSearchScroll.frame.content =SettingsSearchScroll.frame.wrapper
                SettingsSearchScroll.frame:SetScrollChild(SettingsSearchScroll.frame.wrapper)  
            else
            end
        end)
        SettingsSearch_SearchBox:Show()
        
          
    end
    
    if category == "Display" then
        DGV.UpdateEnabledVisibility()
	end

	if category == GuideSharingCategoryName then
        DGV.UpdateEnabledVisibility()
    end	
	
	self:GetModuleSettings(frame, category, top, topRightColumn)
 
	--Disable Ant Trail option

	if DugisGuideViewer.carboniteloaded and SettingsDB[DGV_SHOWANTS].category==category then
		local ChkBox = _G["DGV.ChkBox"..DGV_SHOWANTS]

		--ChkBox:SetChecked(false)
		ChkBox:Disable()
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5)
	
	elseif SettingsDB[DGV_CARBONITEARROW].category==category then
		local ChkBox = _G["DGV.ChkBox"..DGV_CARBONITEARROW]

		--ChkBox:SetChecked(false)
		ChkBox:Disable()
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 	
	end

	if not DugisGuideViewer.tomtomloaded and SettingsDB[DGV_TOMTOMARROW].category==category  then
		local ChkBox = _G["DGV.ChkBox"..DGV_TOMTOMARROW]		

		--ChkBox:SetChecked(false)
		ChkBox:Disable() 
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 		
	end
	
	if DugisGuideViewer.tomtomloaded and SettingsDB[DGV_TOMTOMEMULATION].category==category  then
		local ChkBox = _G["DGV.ChkBox"..DGV_TOMTOMEMULATION]		

		--ChkBox:SetChecked(false)
		ChkBox:Disable() 
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 		
	end	
	
	if (DugisGuideViewer.tomtomloaded or DugisGuideViewer.mapsterloaded) and SettingsDB[DGV_DISPLAYMAPCOORDINATES].category==category  then
		local ChkBox = _G["DGV.ChkBox"..DGV_DISPLAYMAPCOORDINATES]		

		ChkBox:SetChecked(false)
		ChkBox:Disable() 
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 		
	end	
	
	if DugisGuideViewer.mapsterloaded and SettingsDB[DGV_REMOVEMAPFOG].category==category  then
		local ChkBox = _G["DGV.ChkBox"..DGV_REMOVEMAPFOG]		

		ChkBox:SetChecked(false)
		ChkBox:Disable() 
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 		
	end		

	if ((DugisGuideViewer.carboniteloaded and Nx.Quest) or DugisGuideViewer.sexymaploaded or DugisGuideViewer.nuiloaded or DugisGuideViewer.elvuiloaded or DugisGuideViewer.tukuiloaded or DugisGuideViewer.shestakuiloaded or DugisGuideViewer.dominosquestloaded or DugisGuideViewer.eskaquestloaded) and SettingsDB[DGV_MOVEWATCHFRAME].category==category then
		DugisGuideViewer:SetDB(false, DGV_MOVEWATCHFRAME)
		Disable(_G["DGV.ChkBox"..DGV_MOVEWATCHFRAME]) 		

		DugisGuideViewer:SetDB(false, DGV_DISABLEWATCHFRAMEMOD)
		Disable(_G["DGV.ChkBox"..DGV_DISABLEWATCHFRAMEMOD])
	elseif SettingsDB[DGV_MOVEWATCHFRAME].category==category and not self:UserSetting(DGV_MOVEWATCHFRAME) then
		Disable(_G["DGV.ChkBox"..DGV_DISABLEWATCHFRAMEMOD])
	elseif SettingsDB[DGV_MOVEWATCHFRAME].category==category and self:UserSetting(DGV_MOVEWATCHFRAME) then
		Enable(_G["DGV.ChkBox"..DGV_DISABLEWATCHFRAMEMOD])		
	end
	
	if ((DugisGuideViewer.carboniteloaded and Nx.Quest) or DugisGuideViewer.sexymaploaded or DugisGuideViewer.nuiloaded or DugisGuideViewer.elvuiloaded or DugisGuideViewer.tukuiloaded or DugisGuideViewer.shestakuiloaded or DugisGuideViewer.dominosquestloaded or DugisGuideViewer.eskaquestloaded) and SettingsDB[DGV_WATCHFRAMEBORDER].category==category  then
		local ChkBox = _G["DGV.ChkBox"..DGV_WATCHFRAMEBORDER]		

		ChkBox:SetChecked(false)
		ChkBox:Disable() 
		ChkBox.Text:SetTextColor(0.5, 0.5, 0.5) 		
	end		
	
	if SettingsDB[DGV_ANCHOREDSMALLFRAME].category==category then
		local ChkBox = _G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]
		if not ((DugisGuideViewer.carboniteloaded and Nx.Quest) or DugisGuideViewer.sexymaploaded or DugisGuideViewer.nuiloaded or DugisGuideViewer.elvuiloaded or DugisGuideViewer.tukuiloaded or DugisGuideViewer.shestakuiloaded or DugisGuideViewer.dominosquestloaded or DugisGuideViewer.eskaquestloaded)
		then
			Enable(ChkBox)
		else
			Disable(ChkBox)
		end
	end
	
	local ChkBoxes = {
		 DGV_ALWAYS_SHOW_STANDARD_PROMPT_GEAR
		,DGV_ALWAYS_SHOW_STANDARD_PROMPT_GUIDE
		,DGV_ENABLED_GEAR_NOTIFICATIONS
		,DGV_ENABLED_GUIDE_NOTIFICATIONS
		,DGV_ENABLED_JOURNAL_NOTIFICATIONS
		,DGV_USE_NOTIFICATIONS_MARK
	}
	
    for _, checkboxId in pairs(ChkBoxes) do
		if SettingsDB[checkboxId].category == category then
			local chkBox = _G["DGV.ChkBox"..checkboxId]
			if DugisGuideViewer:NotificationsEnabled() then
				Enable(chkBox)
			else
				Disable(chkBox, true)
			end
		end
	end
	
	if not DugisGuideViewer:UserSetting(DGV_AUTOREPAIR) then
		DugisGuideViewer:SetDB(false, DGV_AUTOREPAIRGUILD)
		local Chk = _G["DGV.ChkBox"..DGV_AUTOREPAIRGUILD]
		Disable(Chk)
	else
		local Chk = _G["DGV.ChkBox"..DGV_AUTOREPAIRGUILD]
		Enable(Chk)
	end
	
	--Reset Frames Position Button
	if category=="Frames" and not DGV_ResetFramesButton then

		local button = CreateFrame("Button", "DGV_ResetFramesButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Reset Frames Position"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top-3)
		top = top-3-button:GetHeight()
		--button:SetPoint("TOPLEFT", "DGV.ChkBox6", "BOTTOMLEFT", "0", "-3")
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() DugisGuideViewer:InitFramePositions() end)
	end	
    
	--Reset Tracking Points
	if category=="Maps" and not DGV_ResetTrackingPointsButton and DugisGuideViewer:IsModuleRegistered("Guides") then

		local button = CreateFrame("Button", "DGV_ResetTrackingPointsButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Reset Tracking Points"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top-3)
		top = top-3-button:GetHeight()
		--button:SetPoint("TOPLEFT", "DGV.ChkBox6", "BOTTOMLEFT", "0", "-3")
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() 
            DugisGuideUser.excludedTrackingPoints = {}
            UpdateTrackingFilters()
        end)
	end
	
	--Reset Profile Button
	if category=="Profiles" and not DGV_ResetProfileButton then
		local button = CreateFrame("Button", "DGV_ResetProfileButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Reset Profile"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", columnPaddingLeft, top-3)
		top = top-3-button:GetHeight()
		--button:SetPoint("TOPLEFT", "DGV.ChkBox6", "BOTTOMLEFT", "0", "-3")
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() 
			DugisGuideViewer.db:ResetProfile()
		end)
	end
	
	--Memory settings Apply button
	if category=="Other" and not DGV_MemoryApplyButton and DugisGuideViewer:IsModuleRegistered("Guides") then
		local button = CreateFrame("Button", "DGV_MemoryApplyButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Apply Memory Settings"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + columnPaddingLeft, topRightColumn-3)
		topRightColumn = topRightColumn-3-button:GetHeight()
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() DugisGuideViewer:ReloadModules() end)
	end
	
	--[[--Memory settings Garbage Collect
	if category=="Memory" then
		local button = CreateFrame("Button", "DGV_CollectGarbageButton", frame, "UIPanelButtonTemplate")
		local btnText = L["Collect Garbage"]
		local fontwidth = DugisGuideViewer:GetFontWidth(btnText, "GameFontHighlight")
		button:SetText(btnText)
		button:SetWidth(fontwidth + 30)
		button:SetHeight(22)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, top-3)
		top = top-3-button:GetHeight()
		button:RegisterForClicks("LeftButtonUP")
		button:SetScript("OnClick", function() collectgarbage() end)
	end]]

	top = top - 24
	--Guide Suggest Difficulty Dropdown
	if SettingsDB[DGV_GUIDEDIFFICULTY].category==category
		and(not DugisGuideViewer:GetDB(DGV_GUIDEDIFFICULTY, "module")
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_GUIDEDIFFICULTY, "module")))
		and not DGV_GuideSuggestDropdown
	then
		local dropdown = self:CreateDropdown("DGV_GuideSuggestDropdown", frame, "Leveling Mode", DGV_GUIDEDIFFICULTY, self.GuideSuggestDropDown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, top)
		--top = top-22-dropdown:GetHeight()
	end
	if DGV_GuideSuggestDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_GuideSuggestDropdown, DGV_GuideSuggestDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_GuideSuggestDropdown, DugisGuideViewer:UserSetting(DGV_GUIDEDIFFICULTY))
	end
	
	--Status Frame Effect Dropdown
	if SettingsDB[DGV_SMALLFRAMETRANSITION].category==category 
		and(not DugisGuideViewer:GetDB(DGV_SMALLFRAMETRANSITION, "module") 
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_SMALLFRAMETRANSITION, "module")))
		and not DGV_StatusFrameEffectDropdown
	then
		topRightColumn = topRightColumn-27
		local dropdown = self:CreateDropdown("DGV_StatusFrameEffectDropdown", frame, "Small Frame Effect", DGV_SMALLFRAMETRANSITION, self.StatusFrameEffectDropDown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX, topRightColumn)
	end
	if DGV_StatusFrameEffectDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_StatusFrameEffectDropdown, DGV_StatusFrameEffectDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_StatusFrameEffectDropdown, DugisGuideViewer:UserSetting(DGV_SMALLFRAMETRANSITION))
	end	
    
	if SettingsDB[DGV_MAIN_FRAME_BACKGROUND].category==category 
		and not DGV_Main_Frame_Background_Dropdown
	then
		local dropdown = self:CreateDropdown("DGV_Main_Frame_Background_Dropdown", frame, "Large Frame Background"
        , DGV_MAIN_FRAME_BACKGROUND, self.MainFrameBackgroundDropDown_OnClick)
        
        topRightColumn = topRightColumn - 40
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 333, topRightColumn)
	end
    
	if SettingsDB[DGV_ROUTE_STYLE].category==category 
		and not DGV_route_style
	then
		local dropdown = self:CreateDropdown("DGV_route_style", frame, "Ant Trail"
        , DGV_ROUTE_STYLE, self.RouteStyleDropDown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -297)
	end

	if SettingsDB[DGV_TALENT_PROFILE].category==category and not DGV_talent_profile then
		local options = {
			{ text = "None",},
		}

		local playerClass = select(2, UnitClass("player"))

		if DGV.TalentTemplates and DGV.TalentTemplates[playerClass] then 
			local templates = DGV.TalentTemplates[playerClass]

			for key in LuaUtils.spairs(templates, function(a, b) return  (a.order or 0) < (b.order or 0)  end) do
				options[#options + 1] = {text = key ,}
			end

			for _, template in pairs(templates) do
				template.order = nil
			end
		end

		SettingsDB[DGV_TALENT_PROFILE].options = options

		local dropdown = self:CreateDropdown("DGV_talent_profile", frame, "Templates", DGV_TALENT_PROFILE, function(button)
			DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_talent_profile, button:GetID() )
			DugisGuideViewer:SetDB(button.value, DGV_TALENT_PROFILE)
			DGV.Modules.TalentAdvisor.UpdateSuggestions()
		end)

		local left = 3
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", left, top)
		dropdown:SetWidth(200)
		top = top-22-dropdown:GetHeight()
	end
	if DGV_talent_profile then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_talent_profile, DGV_talent_profile.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_talent_profile, DugisGuideViewer:UserSetting(DGV_TALENT_PROFILE))
	end		


	--Large Frame Border  Dropdown
	if SettingsDB[DGV_LARGEFRAMEBORDER].category==category  and not DGV_LargeFrameBorderDropdown then
		local dropdown = self:CreateDropdown("DGV_LargeFrameBorderDropdown", frame, "Borders", DGV_LARGEFRAMEBORDER, self.LargeFrameBorderDropdown_OnClick)
		local left = 3
        
        if not DugisGuideViewer:IsModuleRegistered("SmallFrame") then
            topRightColumn = topRightColumn - 40
        end
        
		if DGV_StatusFrameEffectDropdownTitle then left = DGV_StatusFrameEffectDropdownTitle:GetWidth() + 20 end
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + left, topRightColumn)
	end
	if DGV_LargeFrameBorderDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_LargeFrameBorderDropdown, DGV_LargeFrameBorderDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_LargeFrameBorderDropdown, DugisGuideViewer:UserSetting(DGV_LARGEFRAMEBORDER))
	end
	
	--GPS Border  Dropdown
	if SettingsDB[DGV_GPS_BORDER].category==category  and not DGV_gps_border then
		local dropdown = self:CreateDropdown("DGV_gps_border", frame, "Zone Map Border", DGV_GPS_BORDER, self.GPSBorderDropdown_OnClick)
		local left = 3
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", left, top)
	end
	if DGV_gps_border then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_gps_border, DGV_gps_border.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_gps_border, DugisGuideViewer:UserSetting(DGV_GPS_BORDER))
	end
	
	--Step Complete Sound Dropdown
	if SettingsDB[DGV_STEPCOMPLETESOUND].category==category
		and(not DugisGuideViewer:GetDB(DGV_STEPCOMPLETESOUND, "module")
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_STEPCOMPLETESOUND, "module")))
		and not DGV_StepCompleteSoundDropdown
	then
		local dropdown = self:CreateDropdown("DGV_StepCompleteSoundDropdown", frame, "Step Complete Sound", DGV_STEPCOMPLETESOUND, self.StepCompleteSoundDropdown_OnClick)
		local left = 3
		if DGV_GuideSuggestDropdownTitle then left = DGV_GuideSuggestDropdownTitle:GetWidth() + 20 end
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", left, top)
		top = top-22-dropdown:GetHeight()
	elseif SettingsDB[DGV_STEPCOMPLETESOUND].category==category and DGV_GuideSuggestDropdown then
		top = top-22-DGV_GuideSuggestDropdown:GetHeight()
	end
	if DGV_StepCompleteSoundDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_StepCompleteSoundDropdown, DGV_StepCompleteSoundDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_StepCompleteSoundDropdown, DugisGuideViewer:UserSetting(DGV_STEPCOMPLETESOUND))
	end
	
	--Flightmaster Handling Dropdown
	if SettingsDB[DGV_TAXIFLIGHTMASTERS].category==category and not DGV_TaxiFlightmasterDropdown then
		local dropdown = self:CreateDropdown("DGV_TaxiFlightmasterDropdown", frame, "Use Flightmasters", DGV_TAXIFLIGHTMASTERS, self.TaxiFlightmasterDropdown_OnClick)
		local left = 3
		if DGV_AntColorDropdownTitle then left = DGV_AntColorDropdownTitle:GetWidth() + 20 end
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", left, top)
		top = top-22-dropdown:GetHeight()
	end
	if DGV_TaxiFlightmasterDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_TaxiFlightmasterDropdown, DGV_TaxiFlightmasterDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_TaxiFlightmasterDropdown, DugisGuideViewer:UserSetting(DGV_TAXIFLIGHTMASTERS))
	end	
    
    --TaxiReachedSound  Dropdown
    function DugisGuideViewer.TaxiReachedSound_OnClick(button)
        DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_TaxiReachedSound, button:GetID() )
        DugisGuideViewer:SetDB(button.value, DGV_TAXIREACHEDSOUND)
        PlaySoundFile(DugisGuideViewer:GetDB(DGV_TAXIREACHEDSOUND))
    end    
    
	--Taxi Destination Reached
	if SettingsDB[DGV_TAXIREACHEDSOUND].category==category
		and(not DugisGuideViewer:GetDB(DGV_TAXIREACHEDSOUND, "module")
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_TAXIREACHEDSOUND, "module")))
		and not DGV_TaxiReachedSound
	then
		local dropdown = self:CreateDropdown("DGV_TaxiReachedSound", frame, "Taxi Reached Sound", DGV_TAXIREACHEDSOUND, self.TaxiReachedSound_OnClick)
        topRightColumn = topRightColumn-27
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX, topRightColumn)
	end
    
	if DGV_TaxiReachedSound then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_TaxiReachedSound, DGV_TaxiReachedSound.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_TaxiReachedSound, DugisGuideViewer:UserSetting(DGV_TAXIREACHEDSOUND))
	end    

	--Quest Complete Sound Dropdown
	if SettingsDB[DGV_QUESTCOMPLETESOUND].category==category
		and(not DugisGuideViewer:GetDB(DGV_QUESTCOMPLETESOUND, "module")
		or DugisGuideViewer:IsModuleRegistered(DugisGuideViewer:GetDB(DGV_QUESTCOMPLETESOUND, "module")))
		and not DGV_QuestCompleteSoundDropdown
	then
		local dropdown = self:CreateDropdown("DGV_QuestCompleteSoundDropdown", frame, "Quest Complete Sound", DGV_QUESTCOMPLETESOUND, self.QuestCompleteSoundDropdown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, top)
		top = top-22-dropdown:GetHeight()
	end
	if DGV_QuestCompleteSoundDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_QuestCompleteSoundDropdown, DGV_QuestCompleteSoundDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_QuestCompleteSoundDropdown, DugisGuideViewer:UserSetting(DGV_QUESTCOMPLETESOUND))
	end
	
	--Tooltip Anchor
	if SettingsDB[DGV_TOOLTIPANCHOR].category==category  and not DGV_TooltipAnchorDropdown then
		local dropdown = self:CreateDropdown("DGV_TooltipAnchorDropdown", frame, "Tooltip Anchor", DGV_TOOLTIPANCHOR, self.TooltipAnchorDropdown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, top)
		top = top-22-dropdown:GetHeight()
	end
	if DGV_TooltipAnchorDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_TooltipAnchorDropdown, DGV_TooltipAnchorDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_TooltipAnchorDropdown, DugisGuideViewer:UserSetting(DGV_TOOLTIPANCHOR))
	end
	
	if DugisGuideViewer:IsModuleRegistered("SmallFrame") and SettingsDB[DGV_DISPLAYPRESET].category==category and not DGV_DisplayPresetDropdown then
		local dropdown = self:CreateDropdown("DGV_DisplayPresetDropdown", frame, "Recommended Preset Settings", DGV_DISPLAYPRESET, self.DisplayPresetDropdown_OnClick)
		dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, top)
		top = top-22-dropdown:GetHeight()
	end
	if DugisGuideViewer:IsModuleRegistered("SmallFrame") and DGV_DisplayPresetDropdown then
		DugisDropDown.LibDugi_UIDropDownMenu_Initialize(DGV_DisplayPresetDropdown, DGV_DisplayPresetDropdown.initFunc)
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_DisplayPresetDropdown, DugisGuideViewer:UserSetting(DGV_DISPLAYPRESET))
	end
	
	-- select profile
	if category=="Profiles" then
		local dropdown = DGV_SelectProfileDropdown
		if not dropdown then
			dropdown = self:CreateDropdown(
				"DGV_SelectProfileDropdown", 
				frame, 
				"Existing Profiles", 
				nil, 
				function(button) 
					DugisGuideViewer.db:SetProfile(button.value)
				end, 
				getProfileList)
			dropdown:SetPoint("TOPLEFT", 3, top)
			top = top-22-dropdown:GetHeight()
		end
		DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_SelectProfileDropdown, DugisGuideViewer.db.keys.profile)
	end

	
	-- copy from profile
	if category=="Profiles" then
		local dropdown = DGV_CopyProfileDropdown
		if not dropdown then
			dropdown = self:CreateDropdown(
				"DGV_CopyProfileDropdown", 
				frame, 
				"Copy From", 
				nil, 
				function(button)
					DugisGuideViewer.db:CopyProfile(button.value)
				end, 
				function() return getProfileList(true, true) end)
			dropdown:SetPoint("TOPLEFT", 3, top)
			top = top-22-dropdown:GetHeight()
		end
	end
	
	-- delete a profile
	if category=="Profiles" then
		local dropdown = DGV_DeleteProfileDropdown
		if not dropdown then
			dropdown = self:CreateDropdown(
				"DGV_DeleteProfileDropdown", 
				frame, 
				"Delete a Profile", 
				nil, 
				function(button)
					DugisGuideViewer.db:DeleteProfile(button.value)
				end, 
				function() return getProfileList(true, true) end)
			dropdown:SetPoint("TOPLEFT", 3, top)
			top = top-22-dropdown:GetHeight()
		end
	end
	
	--Show Tooltip Slider
	if SettingsDB[DGV_SHOWTOOLTIP].category==category and not DGV_ShowTooltipSlider and DugisGuideViewer:IsModuleLoaded("SmallFrame") then
		local slider = self:CreateSlider("DGV_ShowTooltipSlider", frame, SettingsDB[DGV_SHOWTOOLTIP].text, 
			DGV_SHOWTOOLTIP, 0, 30, 1, 5, "0", "30", function() DugisGuideViewer:ShowAutoTooltip() end)
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 23, top)
		top = top-30-slider:GetHeight()
	end
	if DGV_ShowTooltipSlider then
		DGV_ShowTooltipSlider:SetValue(DugisGuideViewer:GetDB(DGV_SHOWTOOLTIP) or 5)
	end

	--DGV_SMALL_FRAME_TABS_AMOUNT
	if SettingsDB[DGV_SMALL_FRAME_TABS_AMOUNT].category==category and not DGV_SmallFrameTabsAmount then
		local slider = self:CreateSlider("DGV_SmallFrameTabsAmount", frame, SettingsDB[DGV_SMALL_FRAME_TABS_AMOUNT].text, 
			DGV_SMALL_FRAME_TABS_AMOUNT, 1, 4, 1, 4, "1", "4")
		slider:HookScript("OnMouseUp", function()
            if DugisGuideViewer.SmallFrame and DugisGuideViewer.SmallFrame.UpdateTabs then
                DugisGuideViewer.SmallFrame.UpdateTabs()
            end   

            DGV.BlinkSmallFrameTabs()
		end)
        topRightColumn = topRightColumn - 60
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 350, topRightColumn)
	end
	if DGV_SmallFrameTabsAmount and DugisGuideViewer:IsModuleLoaded("SmallFrame") then
		DGV_SmallFrameTabsAmount:SetValue(DugisGuideViewer:GetDB(DGV_SMALL_FRAME_TABS_AMOUNT) or 3)
	end	    
    
	--DGV_SMALLFRAME_STEPS
	if SettingsDB[DGV_SMALLFRAME_STEPS].category==category and not DGV_Smallframe_Steps then
		local slider = self:CreateSlider("DGV_Smallframe_Steps", frame, SettingsDB[DGV_SMALLFRAME_STEPS].text, 
			DGV_SMALLFRAME_STEPS, 2, 8, 1, 1, "2", "8")
		slider:HookScript("OnMouseUp", function()
			DugisGuideViewer:UpdateCompletionVisuals()
		end)
        topRightColumn = topRightColumn - 50
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 350, topRightColumn)
	end
	if DGV_Smallframe_Steps then
		DGV_Smallframe_Steps:SetValue(DugisGuideViewer:GetDB(DGV_SMALLFRAME_STEPS) or 6)
	end	
	    
	--DGV_PATH_WIDTH
	if SettingsDB[DGV_PATH_WIDTH].category==category and not DGV_path_width then
		local slider = self:CreateSlider("DGV_path_width", frame, SettingsDB[DGV_PATH_WIDTH].text, 
		DGV_PATH_WIDTH, 1, 10, 1, 1, "1", "10")
		slider:HookScript("OnMouseUp", function()
		--	DGV.OnGearFinderSettingsChanged()
		end)

		slider:SetPoint("TOPLEFT", "DGV.ChkBox"..DGV_WAY_SEGMENT_COLOR, "TOPLEFT", 140, -7)
	end
    
	if DGV_path_width then
		DGV_path_width:SetValue(DugisGuideViewer:GetDB(DGV_PATH_WIDTH) or 5)
	end	

	--config:  {id, controlName, min, max, onMouseUp, relativeFrame, x, y}
	local function InitializeSlider(config)
		--id, controlName, min, max
		if SettingsDB[config.id].category==category and not _G[config.controlName] then
			local slider = self:CreateSlider(config.controlName, frame, SettingsDB[config.id].text, 
			config.id, config.min, config.max, 1, 1, "" .. config.min, "" .. config.max)

			if config.onMouseUp then
				slider:HookScript("OnMouseUp", config.onMouseUp)
			end
	
			if config.relativeFrame then
				slider:SetPoint("TOPLEFT", config.relativeFrame, "TOPLEFT", config.x or 0, config.y or 0)
			end

			if config.width then
				slider:SetWidth(config.width)
			end
			
		end
		
		if _G[config.controlName] then
			_G[config.controlName]:SetValue(DugisGuideViewer:GetDB(config.id) or SettingsDB[config.id].checked or config.default or 1)
		end	
	end
	
	InitializeSlider({id = DGV_DISTANCED_ARROW_SIZE, controlName = "DGV_distanced_arrow_size"
	, min = 2, max = 10, relativeFrame = "DGV.ChkBox"..DGV_DISTANCED_ARROW, x =  150, y = -12, width = 100, 
	onMouseUp = function() DGV.arrowUpdateRequst = true end})
    
	--DGV_MOUNT_DELAY
	if SettingsDB[DGV_MOUNT_DELAY].category==category and not DGV_MountDelay then
		local slider = self:CreateSlider("DGV_MountDelay", frame, SettingsDB[DGV_MOUNT_DELAY].text, 
			DGV_MOUNT_DELAY, 1, 20, 1, 8, "1", "20")
		
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 23, -270)
	end
	if DGV_MountDelay then
		DGV_MountDelay:SetValue(DugisGuideViewer:GetDB(DGV_MOUNT_DELAY) or 6)
	end
    
	--DGV_TARGETBUTTONSCALE
	if SettingsDB[DGV_TARGETBUTTONSCALE].category==category and not DGV_TargetButtonScale then
		local slider = self:CreateSlider("DGV_TargetButtonScale", frame, SettingsDB[DGV_TARGETBUTTONSCALE].text, 
			DGV_TARGETBUTTONSCALE, 1, 10, 1, 1, "1", "10")
		slider:HookScript("OnMouseUp", function()
			if DugisGuideViewer:IsModuleLoaded("Target") then
				DugisGuideViewer:FinalizeTarget()
			end
		end)
		top = -57
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 350, top)
		top = top-35-slider:GetHeight()
	end
	if DGV_TargetButtonScale and DugisGuideViewer:IsModuleLoaded("Target") then
		DGV_TargetButtonScale:SetValue(DugisGuideViewer:GetDB(DGV_TARGETBUTTONSCALE) or 5)
	
	end
	
	--DGV_ITEMBUTTONSCALE
	if SettingsDB[DGV_ITEMBUTTONSCALE].category==category and not DGV_ItemButtonScale then
		local slider = self:CreateSlider("DGV_ItemButtonScale", frame, SettingsDB[DGV_ITEMBUTTONSCALE].text, 
			DGV_ITEMBUTTONSCALE, 1, 10, 1, 1, "1", "10")
		slider:HookScript("OnMouseUp", function()
			if DugisGuideViewer:IsModuleLoaded("Guides") then
				DugisGuideViewer.DoOutOfCombat(SetUseItem, DugisGuideUser.CurrentQuestIndex)
			elseif DugisGuideViewer:IsModuleLoaded("DugisArrow") then
				local questId = DugisGuideViewer.DugisArrow:GetFirstWaypointQuestId()
				DugisGuideViewer.DoOutOfCombat(SetUseItemByQID, questId)
			end
		end)
		top = -115
        
        if not DGV.Modules.Guides then
           top = -90 
        end
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 325, top)
		top = top-30-slider:GetHeight()
	end
	if DGV_ItemButtonScale then
		DGV_ItemButtonScale:SetValue(DugisGuideViewer:GetDB(DGV_ITEMBUTTONSCALE) or 5)
	end		
	
	--DGV_NAMEPLATEICONSIZE
	if SettingsDB[DGV_NAMEPLATEICONSIZE].category==category and not DGV_NameplateIconSize then
		local slider = self:CreateSlider("DGV_NameplateIconSize", frame, SettingsDB[DGV_NAMEPLATEICONSIZE].text, 
			DGV_NAMEPLATEICONSIZE, 1, 10, 1, 5, "1", "10")
		slider:HookScript("OnMouseUp", function()
			if DugisGuideViewer:IsModuleLoaded("NamePlate") then
				DugisGuideViewer.Modules.NamePlate:UpdateActivePlatesExtras()
			end
		end)
		
		top = top - 85
		
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 325, top)
		top = top-30-slider:GetHeight()
	end
	if DGV_NameplateIconSize then
		DGV_NameplateIconSize:SetValue(DugisGuideViewer:GetDB(DGV_NAMEPLATEICONSIZE) or 5)
	end	
	
	
	--DGV_NAMEPLATETEXTSIZE
	if SettingsDB[DGV_NAMEPLATETEXTSIZE].category==category and not DGV_NameplateTextSize then
		local slider = self:CreateSlider("DGV_NameplateTextSize", frame, SettingsDB[DGV_NAMEPLATETEXTSIZE].text, 
			DGV_NAMEPLATETEXTSIZE, 1, 10, 1, 3, "1", "10")
		slider:HookScript("OnMouseUp", function()
			if DugisGuideViewer:IsModuleLoaded("NamePlate") then
				DugisGuideViewer.Modules.NamePlate:UpdateActivePlatesExtras()
			end
		end)
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 325, top)
		top = top-30-slider:GetHeight()
	end
	if DGV_NameplateTextSize then
		DGV_NameplateTextSize:SetValue(DugisGuideViewer:GetDB(DGV_NAMEPLATETEXTSIZE) or 3)
	end	

	--DGV_GPS_MAPS_OPACITY
	if SettingsDB[DGV_GPS_MAPS_OPACITY].category==category and not DGV_gps_maps_opacity then
		local slider = self:CreateSlider("DGV_gps_maps_opacity", frame, SettingsDB[DGV_GPS_MAPS_OPACITY].text, 
			DGV_GPS_MAPS_OPACITY, 0, 1, 0.1, 0.1, "0", "1")
		slider:HookScript("OnValueChanged", function()
			if DugisGuideViewer.Modules.GPSArrowModule then
				DugisGuideViewer.Modules.GPSArrowModule.UpdateOpacity()
			end
		end)	
		
		slider:HookScript("OnMouseUp", function()
			if DugisGuideViewer.Modules.GPSArrowModule then
				DugisGuideViewer.Modules.GPSArrowModule.UpdateMinimapAlpha()
			end
		end)
		
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + 50, topRightColumn)
		topRightColumn = topRightColumn-55
	end
	if DGV_gps_maps_opacity then
		DGV_gps_maps_opacity:SetValue(DugisGuideViewer:GetDB(DGV_GPS_MAPS_OPACITY) or DGV:GetDefaultValue(DGV_GPS_MAPS_OPACITY))
	end	
	
	
	--DGV_GPS_BORDER_OPACITY
	if SettingsDB[DGV_GPS_BORDER_OPACITY].category==category and not DGV_gps_border_opacity then
		local slider = self:CreateSlider("DGV_gps_border_opacity", frame, SettingsDB[DGV_GPS_BORDER_OPACITY].text, 
			DGV_GPS_BORDER_OPACITY, 0, 1, 0.1, 0.1, "0", "1")
		slider:HookScript("OnValueChanged", function()
			if DugisGuideViewer.Modules.GPSArrowModule then
				DugisGuideViewer.Modules.GPSArrowModule.UpdateOpacity()
			end
		end)
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX+ 50, topRightColumn)
		topRightColumn = topRightColumn+27
	end
	if DGV_gps_border_opacity then
		DGV_gps_border_opacity:SetValue(DugisGuideViewer:GetDB(DGV_GPS_BORDER_OPACITY) or DGV:GetDefaultValue(DGV_GPS_BORDER_OPACITY))
	end			
	
	--DGV_GPS_MAPS_SIZE
	if SettingsDB[DGV_GPS_MAPS_SIZE].category==category and not DGV_gps_maps_size then
		local slider = self:CreateSlider("DGV_gps_maps_size", frame, SettingsDB[DGV_GPS_MAPS_SIZE].text, 
			DGV_GPS_MAPS_SIZE, 1, 20, 0.1, 0.1, "1", "20")
		slider:HookScript("OnValueChanged", function()
			if DugisGuideViewer.Modules.GPSArrowModule then
				DugisGuideViewer.Modules.GPSArrowModule.UpdateSize()
			end
		end)
		topRightColumn = topRightColumn-77
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX+ 50, topRightColumn)
		topRightColumn = topRightColumn+27
	end
	if DGV_gps_maps_size then
		DGV_gps_maps_size:SetValue(DugisGuideViewer:GetDB(DGV_GPS_MAPS_SIZE) or DGV:GetDefaultValue(DGV_GPS_MAPS_SIZE))
	end		
	
	--DGV_GPS_ARROW_SIZE
	if SettingsDB[DGV_GPS_ARROW_SIZE].category==category and not DGV_gps_arrow_size then
		local slider = self:CreateSlider("DGV_gps_arrow_size", frame, SettingsDB[DGV_GPS_ARROW_SIZE].text, 
			DGV_GPS_ARROW_SIZE, 1, 10, 0.1, 0.1, "1", "10")
		slider:HookScript("OnValueChanged", function()
			if DugisGuideViewer.Modules.GPSArrowModule then
				DugisGuideViewer.Modules.GPSArrowModule.UpdateArrowSize()
			end
		end)
		topRightColumn = topRightColumn - 77
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", rightColumnX + 50, topRightColumn)
		topRightColumn = topRightColumn + 27
	end
	if DGV_gps_arrow_size then
		DGV_gps_arrow_size:SetValue(DugisGuideViewer:GetDB(DGV_GPS_ARROW_SIZE) or DGV:GetDefaultValue(DGV_GPS_ARROW_SIZE))
	end			
	
    
    local old_DGV_JOURNALFRAMEBUTTONSCALE = DugisGuideViewer:UserSetting(DGV_JOURNALFRAMEBUTTONSCALE)
    --DGV_JOURNALFRAMEBUTTONSCALE
	if SettingsDB[DGV_JOURNALFRAMEBUTTONSCALE].category==category and not DGV_JournalframeButtonScale and DugisGuideViewer:IsModuleLoaded("NPCJournalFrame") then
		local slider = self:CreateSlider("DGV_JournalframeButtonScale", frame, SettingsDB[DGV_JOURNALFRAMEBUTTONSCALE].text, 
			DGV_JOURNALFRAMEBUTTONSCALE, 1, 10, 1, 4, "1", "10", function()
                if old_DGV_JOURNALFRAMEBUTTONSCALE ~= DugisGuideViewer:UserSetting(DGV_JOURNALFRAMEBUTTONSCALE) then
                    DugisGuideViewer.NPCJournalFrame.sidebarButtonFrame:RestoreSidebarIconPosition()
                    old_DGV_JOURNALFRAMEBUTTONSCALE = DugisGuideViewer:UserSetting(DGV_JOURNALFRAMEBUTTONSCALE)
                end
            end)
		top = -117
		slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 350, top)
		top = top-30-slider:GetHeight()
	end
	if DGV_JournalframeButtonScale then
		DGV_JournalframeButtonScale:SetValue(DugisGuideViewer:GetDB(DGV_JOURNALFRAMEBUTTONSCALE) or 4)
	end	    
	
	--if SettingsDB[DGV_BLINKMINIMAPICONS].category==category and DugisGuideViewer.zygorloaded then
		--Disable(_G["DGV.ChkBox"..DGV_BLINKMINIMAPICONS])
	--end
	
	return frame
end

local settingsMenuTreeGroup
function DugisGuideViewer:CreateSettingsTree(parent)
	if DugisGuideViewer.SettingsTree then
		DugisGuideViewer.SettingsTree.frame:ClearAllPoints()
		DugisGuideViewer.SettingsTree.frame:Hide()
		AceGUI:Release(DugisGuideViewer.SettingsTree)
	end
	settingsMenuTreeGroup = AceGUI:Create("TreeGroup")
	settingsMenuTreeGroup:SetTree(CATEGORY_TREE)		
	settingsMenuTreeGroup:EnableButtonTooltips(false)
	--settingsMenuTreeGroup.frame:SetBackdrop(nil);
	settingsMenuTreeGroup.frame:SetParent(parent)
	settingsMenuTreeGroup.treeframe:SetBackdropColor(0,0,0,0);
	settingsMenuTreeGroup.border:SetBackdropColor(0,0,0,0);
	settingsMenuTreeGroup.frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, 0)
	settingsMenuTreeGroup.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 12)
				
	settingsMenuTreeGroup:SetCallback("OnGroupSelected", function(group, event, value)
		for _, child in self.IterateReturns(settingsMenuTreeGroup.border:GetChildren()) do
			child:Hide()
		end
		GetSettingsCategoryFrame(value, settingsMenuTreeGroup.border):Show()

	end)
	settingsMenuTreeGroup:SelectByValue(CATEGORY_TREE[SEARCH_LOCATIONS_CATEGORY].value)
	settingsMenuTreeGroup.frame:Show()
	settingsMenuTreeGroup.frame:GetScript("OnSizeChanged")(settingsMenuTreeGroup.frame)
	DugisGuideViewer.SettingsTree = settingsMenuTreeGroup;
    
    DugisGuideViewer.UpdateLeftMenu()    
end

function DugisGuideViewer:ForceAllSettingsTreeCategories()
	for _,node in pairs(CATEGORY_TREE) do
        if DugisGuideViewer.SettingsTree then
            GetSettingsCategoryFrame(node.value, DugisGuideViewer.SettingsTree.border):Hide()
        end
	end
	local tree = DugisGuideViewer.SettingsTree
    if not tree then
        return
    end
	local status = tree.status or tree.localstatus
	tree:SelectByValue(status.selected)
end

--Guide Suggest Dropdown
function DugisGuideViewer.GuideSuggestDropDown_OnClick(button)
	--DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_GuideSuggestDropdown, button:GetID() )
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedValue(DGV_GuideSuggestDropdown, button.value )
	
	DugisGuideViewer:SetDB(button.value, DGV_GUIDEDIFFICULTY)
	DebugPrint("button.value"..button.value.."button.id"..button:GetID())
	if DugisGuideViewer:IsModuleLoaded("Guides") then DugisGuideViewer:TabTextRefresh() end
end

--Status Frame Effect dropdown
function DugisGuideViewer.StatusFrameEffectDropDown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_StatusFrameEffectDropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_SMALLFRAMETRANSITION)
	
	local options = DugisGuideViewer:GetDB(DGV_SMALLFRAMETRANSITION, "options")
	if button.value == options[1].text then
		--UIFrameFadeIn(DugisSmallFrame, 0.8, 0, 1)
        if DugisGuideViewer.Modules.SmallFrame.PlayFlashAnimation then
            DugisGuideViewer.Modules.SmallFrame:PlayFlashAnimation( )
        end
		DugisGuideViewer.Modules.DugisWatchFrame:PlayFlashAnimation( )
	elseif button.value == options[2].text then
        if DugisGuideViewer.Modules.SmallFrame.StartFrameTransition then
            DugisGuideViewer.Modules.SmallFrame:StartFrameTransition( )
        end
	end
end

function DugisGuideViewer.MainFrameBackgroundDropDown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_Main_Frame_Background_Dropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_MAIN_FRAME_BACKGROUND)
    DugisGuideViewer:UpdateCurrentGuideExpanded()
end

function DugisGuideViewer.RouteStyleDropDown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_route_style, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_ROUTE_STYLE)
    DugisGuideViewer:UpdateCurrentGuideExpanded()
end

function DugisGuideViewer:SetFrameBackdrop(frame, bgFile, edgeFile, left, right, top, bottom, edgeSize)
	if not frame then return end
	if not bgFile and not edgeFile then
		frame:SetBackdrop(nil)
	else
		frame:SetBackdrop( { 
			bgFile = bgFile, 
			edgeFile = edgeFile, tile = true, tileSize = 32, edgeSize = edgeSize or 32, 
			insets = { left = left, right = right, top = top, bottom = bottom }
		})
	end
	
	DugisGuideViewer.ApplyElvUIColor(frame)	
	
end

function DugisGuideViewer:GetBorderPath()
	return self.ARTWORK_PATH.."Border-"..DugisGuideViewer:UserSetting(DGV_LARGEFRAMEBORDER)
end

function DugisGuideViewer:GetGPSBorderPath()
	return self.ARTWORK_PATH.."Border-"..DugisGuideViewer:UserSetting(DGV_GPS_BORDER)
end

function DugisGuideViewer.ApplyElvUIColor(frame)
	local path = DugisGuideViewer:GetBorderPath()
	if frame and string.match(path, "ElvUI") then
		if ElvUI then
			local E = unpack(ElvUI);
			frame:SetBackdropBorderColor(unpack(E['media'].bordercolor));
			return
		end
		
		if DugisGuideViewer.tukuiloaded and Tukui then
			local _, C = unpack(Tukui);
			local general = C["General"]
			if general then
				local BorderColor = general["BorderColor"]
				if BorderColor then
					frame:SetBackdropBorderColor(unpack(BorderColor))
					return
				end
			end
		end

		frame:SetBackdropBorderColor(0,0,0);
	end
end

function DugisGuideViewer:SetAllBorders( )
	if ElvUI and not DugisGuideViewer.ElvUIhooked then
        for _, functionName in pairs({"UpdateAll",  "UpdateBorderColors"}) do
			local E = unpack(ElvUI);
			hooksecurefunc(E, functionName, function()
				DugisGuideViewer:SetAllBorders()
				DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()	
			end)
		end
		DugisGuideViewer.ElvUIhooked = true
	end

	self:SetSmallFrameBorder( )
	self:SetFrameBackdrop(DugisMainBorder, DugisGuideViewer.chardb.EssentialsMode>0 and self.BACKGRND_PATH, self:GetBorderPath(), 10, 3, 11, 5)
	if DugisGuideViewer:IsModuleLoaded("ModelViewer") then
		if DGV:UserSetting(DGV_MODEL_VIEWER_BORDER) then
			self:SetFrameBackdrop(self.Modules.ModelViewer.Frame, self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
		else
			self:SetFrameBackdrop(self.Modules.ModelViewer.Frame, nil)
		end
	end
	self:SetFrameBackdrop(DugisGuideSuggestFrame,  self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
	self:SetFrameBackdrop(DugisEquipPromptFrame,  self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
	self:SetFrameBackdrop(TrainPromptFrame,  self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)

	if DugisGuideViewer:IsModuleLoaded("StickyFrame") then
		self:SetFrameBackdrop(self.Modules.StickyFrame.Frame, "Interface\\DialogFrame\\UI-DialogBox-Gold-Background", self:GetBorderPath(), 10, 4, 12, 5)
	end
	self:SetFrameBackdrop(DugisRecordFrame,  self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
    if GearFinderExtraItemsFrame then
        self:SetFrameBackdrop(GearFinderExtraItemsFrame,  self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
    end   
    
	if DugisGuideViewer.SmallFrame and DugisGuideViewer.SmallFrame.UpdateTabs then
		DugisGuideViewer.SmallFrame.UpdateTabs()
	end    
end

function DugisGuideViewer:SetSmallFrameBorder( )
	--Use same border as large frame

	if DugisGuideViewer:UserSetting(DGV_SMALLFRAMEBORDER)  then
		self:SetFrameBackdrop(SmallFrameBkg, self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
	else
		self:SetFrameBackdrop(SmallFrameBkg, nil)
	end
	
	if DugisGuideViewer:UserSetting(DGV_WATCHFRAMEBORDER) and DugisGuideViewer.Modules.DugisWatchFrame  then
		self:SetFrameBackdrop(DugisGuideViewer.Modules.DugisWatchFrame.ObjectiveTrackerBackground, self.BACKGRND_PATH, self:GetBorderPath(), 10, 4, 12, 5)
	else
		self:SetFrameBackdrop(DugisGuideViewer.Modules.DugisWatchFrame.ObjectiveTrackerBackground, nil)
	end
end

function DugisGuideViewer:DisplayPreset()
	if DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Minimal - No Borders" then 
		DugisGuideViewer:SetDB(false, DGV_ANCHOREDSMALLFRAME)
		_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_SMALLFRAMEBORDER)						
		DugisGuideViewer:SetDB(false, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(false, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(false)
		DugisGuideViewer:SetDB("Scroll", DGV_SMALLFRAMETRANSITION)
	elseif DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Minimal" then 
		DugisGuideViewer:SetDB(false, DGV_ANCHOREDSMALLFRAME)
		_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(false)
		DugisGuideViewer:SetDB(true, DGV_SMALLFRAMEBORDER)				
		DugisGuideViewer:SetDB(true, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(false, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(false)
		DugisGuideViewer:SetDB("Scroll", DGV_SMALLFRAMETRANSITION)
	elseif DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Standard" then 
		DugisGuideViewer:SetDB(false, DGV_ANCHOREDSMALLFRAME)
		_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(false)
		DugisGuideViewer:SetDB(true, DGV_SMALLFRAMEBORDER)						
		DugisGuideViewer:SetDB(true, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(true, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(true)	
		DugisGuideViewer:SetDB("Flash", DGV_SMALLFRAMETRANSITION)
	elseif DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Standard - Anchored" then 
	
		if not DugisGuideViewer.tukuiloaded then
			DugisGuideViewer:SetDB(true, DGV_ANCHOREDSMALLFRAME)
			_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(true)
		end
			
		DugisGuideViewer:SetDB(false, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(false)
		DugisGuideViewer:SetDB(false, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(false)
		DugisGuideViewer:SetDB(true, DGV_SMALLFRAMEBORDER)						
		DugisGuideViewer:SetDB(true, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(true, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(true)	
		DugisGuideViewer:SetDB("Flash", DGV_SMALLFRAMETRANSITION)
	elseif DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Multi-step" then 
		DugisGuideViewer:SetDB(false, DGV_ANCHOREDSMALLFRAME)
		_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(false)
		DugisGuideViewer:SetDB(true, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_SMALLFRAMEBORDER)						
		DugisGuideViewer:SetDB(true, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(true, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(true)	
		DugisGuideViewer:SetDB("Flash", DGV_SMALLFRAMETRANSITION)
	elseif DugisGuideViewer:GetDB(DGV_DISPLAYPRESET)=="Multi-step - Anchored" then
	
		if not DugisGuideViewer.tukuiloaded then
			DugisGuideViewer:SetDB(true, DGV_ANCHOREDSMALLFRAME)
			_G["DGV.ChkBox"..DGV_ANCHOREDSMALLFRAME]:SetChecked(true)
		end
		
		DugisGuideViewer:SetDB(true, DGV_MULTISTEPMODE)
		_G["DGV.ChkBox"..DGV_MULTISTEPMODE]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_OBJECTIVECOUNTER)
		_G["DGV.ChkBox"..DGV_OBJECTIVECOUNTER]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_SMALLFRAMEBORDER)						
		DugisGuideViewer:SetDB(true, DGV_WATCHFRAMEBORDER)
		DugisGuideViewer:SetDB(true, DGV_EMBEDDEDTOOLTIP)
		_G["DGV.ChkBox"..DGV_EMBEDDEDTOOLTIP]:SetChecked(true)
		DugisGuideViewer:SetDB(true, DGV_FIXEDWIDTHSMALL)
		_G["DGV.ChkBox"..DGV_FIXEDWIDTHSMALL]:SetChecked(true)	
		DugisGuideViewer:SetDB("Flash", DGV_SMALLFRAMETRANSITION)				
	end
	DugisGuideViewer:RefreshQuestWatch()
	DugisGuideViewer:UpdateSmallFrame()
end

function DugisGuideViewer:QUEST_ACCEPTED(self, event, qid)
	if not DugisGuideViewer:IsModuleLoaded("Guides") or not DugisGuideViewer:GuideOn() then return end
	local logindex = DugisGuideViewer:GetQuestLogIndexByQID(qid)
	if ( GetNumQuestWatches() < MAX_WATCHABLE_QUESTS and DugisGuideViewer:UserSetting(DGV_AUTO_QUEST_TRACK)) then
		if DugisGuideViewer.chardb.EssentialsMode ~= 1 then 
			if DugisGuideViewer:UserSetting(DGV_OBJECTIVECOUNTER) and qid and not DugisGuideUser.removedQuests[qid] then 

				AddQuestWatch(logindex) -- this is to make quest appear when player first accepted the quest even with blizzard AUTO_QUEST_WATCH off.
				DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
			end
		elseif DugisGuideViewer.chardb.EssentialsMode == 1 then
			--AddQuestWatch(logindex);
			--DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		end
	end
    
    LuaUtils:RunInThreadIfNeeded("QUEST_ACCEPTED", function(isInThread)   
        DugisGuideViewer:UpdateMainFrame(isInThread)
	end)
	
	DugisGuideViewer:UpdateRecord()
    
end

function DugisGuideViewer:QUEST_WATCH_UPDATE(arg1, arg2, arg3, arg4)
	if not DugisGuideViewer:IsModuleLoaded("Guides") or not DugisGuideViewer:GuideOn() then return end


	local qid = DugisGuideViewer:GetQIDByLogIndex(arg2)
	if ( GetNumQuestLeaderBoards(arg2) > 0 and GetNumQuestWatches() < MAX_WATCHABLE_QUESTS and DugisGuideViewer:UserSetting(DGV_AUTO_QUEST_TRACK)) then
		if DugisGuideViewer.chardb.EssentialsMode ~= 1 then 
			if DugisGuideViewer:UserSetting(DGV_OBJECTIVECOUNTER) and qid and not DugisGuideUser.removedQuests[qid] then 
				AddQuestWatch(arg2,MAX_QUEST_WATCH_TIME);
				DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate();
			end
		elseif DugisGuideViewer.chardb.EssentialsMode == 1 then
			--AddQuestWatch(arg2,MAX_QUEST_WATCH_TIME);
			--DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		end
	end
end

local gameStartTime = GetTime()
function DugisGuideViewer:SPELLS_CHANGED()
	--On game start this event is always fiering
	if (GetTime() - gameStartTime) > 10 then
		DGV.CheckForTrainingSuggestions()
	end
end

function DugisGuideViewer:QUEST_WATCH_LIST_CHANGED()

	if DGV.Modules.DugisWatchFrame and DGV.Modules.DugisWatchFrame.UpdateQuestsVisibility then
		DGV.Modules.DugisWatchFrame:UpdateQuestsVisibility()
	end

	if DugisGuideViewer:GuideOn() then

        
		if DugisGuideViewer:IsModuleLoaded("DugisArrow") then
			DugisGuideViewer.DugisArrow:OnQuestLogChanged()
		end
		
		if DugisGuideViewer:GetDB(DGV_WAYPOINTSON) and DugisGuideViewer.chardb.EssentialsMode == 1 and DugisGuideViewer:IsModuleLoaded("QuestPOI") then 
			DugisGuideViewer.Modules.QuestPOI:ObjectivesChangedDelay(3)
		end

    
        if DugisGuideViewer.UpdateWorldQuestAutoGuide then
			DugisGuideViewer.UpdateWorldQuestAutoGuide()
		 end		
	end	
end

function DugisGuideViewer:RefreshQuestWatch()
	if self:UserSetting(DGV_AUTO_QUEST_TRACK) and DugisGuideViewer.GuideOn() then
		SetCVar("autoQuestWatch", 1)
	elseif not self:UserSetting(DGV_AUTO_QUEST_TRACK) and DugisGuideViewer.GuideOn() then
		SetCVar("autoQuestWatch", 0)
	end
	if DugisGuideViewer.chardb.EssentialsMode ~= 1 and DugisGuideViewer:IsModuleLoaded("Guides") then 
		DugisGuideViewer:WatchQuest()
	end
end 

--Large Frame Border Dropdown
function DugisGuideViewer.LargeFrameBorderDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_LargeFrameBorderDropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_LARGEFRAMEBORDER)
	DugisGuideViewer:SetAllBorders( )
	DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
	if DugisGuideViewer.NPCJournalFrame and DugisGuideViewer.NPCJournalFrame.UpdateBorders then DugisGuideViewer.NPCJournalFrame:UpdateBorders() end
end

--GPS Frame Border Dropdown
function DugisGuideViewer.GPSBorderDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_gps_border, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_GPS_BORDER)
	if DugisGuideViewer.Modules.GPSArrowModule then
		DugisGuideViewer.Modules.GPSArrowModule:UpdateBorder()
	end	
end

--Step Complete Sound Dropdown
function DugisGuideViewer.StepCompleteSoundDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_StepCompleteSoundDropdown, button:GetID() )
	DebugPrint("Debug StepCompleteSoundDropdown_OnClick: button.text="..button.value)
	DugisGuideViewer:SetDB(button.value, DGV_STEPCOMPLETESOUND)
	--DugisGuideViewer:SetDB(button.value, DGV_STEPCOMPLETESOUND, "value")
	DebugPrint("Debug StepCompleteSoundDropdown_OnClick: DugisGuideViewer:GetDB(DGV_STEPCOMPLETESOUND)="..DugisGuideViewer:GetDB(DGV_STEPCOMPLETESOUND))
	PlaySoundFile(DugisGuideViewer:GetDB(DGV_STEPCOMPLETESOUND))
end

--Flightmaster Handling Dropdown
function DugisGuideViewer.TaxiFlightmasterDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_TaxiFlightmasterDropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_TAXIFLIGHTMASTERS)
	if DugisGuideViewer.Modules.Taxi and DugisGuideViewer.Modules.Taxi.ResetMovementCache then
		DugisGuideViewer.Modules.Taxi:ResetMovementCache()
	end
end

--Quest Complete Sound Dropdown
function DugisGuideViewer.QuestCompleteSoundDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_QuestCompleteSoundDropdown, button:GetID() )
	DebugPrint("Debug QuestCompleteSoundDropdown_OnClick: button.text="..button.value)
	DugisGuideViewer:SetDB(button.value, DGV_QUESTCOMPLETESOUND)
	--DugisGuideViewer:SetDB(button.value, DGV_STEPCOMPLETESOUND, "value")
	DebugPrint("Debug QuestCompleteSoundDropdown_OnClick: DugisGuideViewer:GetDB(DGV_QUESTCOMPLETESOUND)="..DugisGuideViewer:GetDB(DGV_QUESTCOMPLETESOUND))
	PlaySoundFile(DugisGuideViewer:GetDB(DGV_QUESTCOMPLETESOUND))
end

function DugisGuideViewer.TooltipAnchorDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_TooltipAnchorDropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_TOOLTIPANCHOR)
	DugisGuideViewer:UpdateCompletionVisuals()
end

function DugisGuideViewer.DisplayPresetDropdown_OnClick(button)
	DugisDropDown.LibDugi_UIDropDownMenu_SetSelectedID(DGV_DisplayPresetDropdown, button:GetID() )
	DugisGuideViewer:SetDB(button.value, DGV_DISPLAYPRESET)
	DugisGuideViewer:DisplayPreset()
end

-- 
-- Database
--
function DugisGuideViewer:GetDB(key, field)
	if not DugisGuideViewer.chardb[key] then
		--DebugPrint("key:"..key.." does not exist in database")
		return
	end
	
	if field then
		local func = loadstring("return DugisGuideViewer.chardb["..tostring(key).."]."..field)
		return func()
	else
		return DugisGuideViewer.chardb[key].checked
	end
end

function DugisGuideViewer:SetDB(value, key, field)
	if not DugisGuideViewer.chardb[key] then
		DebugPrint("key:"..key.." does not exist in database")
		return
	end
	
	if field then 
		local func = loadstring("DugisGuideViewer.chardb["..tostring(key).."]."..field.."="..tostring(value))
		--DebugPrint("func="..func)
		func()
	else
		--DebugPrint("DugisGuideViewer.chardb["..key.."].checked ="..value)
		DugisGuideViewer.chardb[key].checked = value
	end
end

function DugisGuideViewer:UserSetting(name)

	local settings = self.chardb
	
	if not settings[name] then 
		--DebugPrint("Error: UserSetting"..name.." not found")
	end

	return self:GetDB(name)--settings[name].checked
end

--Minimap icons blinking
local MinimapIconsDark = nil
local ticker
local function MinimapIconsBlink()
	if DugisGuideViewer:UserSetting(DGV_BLINKMINIMAPICONS) == false and ticker then
		ticker:Cancel()
		ticker = nil
		Minimap:SetBlipTexture("Interface\\MINIMAP\\ObjectIconsAtlas")
		return
	end
	if MinimapIconsDark then
        if MinimapIconsDark then
            Minimap:SetBlipTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\ObjectIconsAtlas") --Seems to reduce the flashing if we use our own file
        end
	else
		Minimap:SetBlipTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\ObjectIconsAtlas_dark")
	end
    MinimapIconsDark = not MinimapIconsDark
end

local function StartMinimapTicker()
	ticker = C_Timer.NewTicker(1, function() MinimapIconsBlink() end) 
end 

CreateFrame("FRAME","MinimapBlinkerFrame")

--Trick to prevent spoiled texture change
local textureObjectIcons = MinimapBlinkerFrame:CreateTexture("textureObjectIcons","OVERLAY") 
textureObjectIcons:SetTexture("Interface\\MINIMAP\\ObjectIcons") 
textureObjectIcons:SetNonBlocking(true) 
textureObjectIcons:Hide()
local textureObjectIconsDark = MinimapBlinkerFrame:CreateTexture("textureObjectIconsDark","OVERLAY")
textureObjectIconsDark:SetTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\ObjectIconsDark.blp") 
textureObjectIconsDark:SetNonBlocking(true) 
textureObjectIconsDark:Hide()

function DGV.UpdateDistancedArrowSettingsSection()
	local standadArrowIds = {
		DGV_BAD_COLOR,
		DGV_MIDDLE_COLOR,
		DGV_GOOD_COLOR,
		DGV_EXACT_COLOR,
		DGV_QUESTING_AREA_COLOR,	
	}

	DGV.defaultColorsButton:ClearAllPoints()

	if  DugisGuideViewer:UserSetting(DGV_DISTANCED_ARROW) then
		for k, id in pairs(standadArrowIds) do 
			_G["DGV.ChkBox"..id]:Hide()
		end

		_G["DGV.ChkBox"..DGV_DISTANCED_ARROW_PING_COLOR]:Show()

		DGV.arrowColorsSectionHeader:SetText(L["Icon Arrow Colors"])

		DGV.defaultColorsButton:SetPoint("TOPLEFT",DGV.arrowColorsSectionHeader, 0, -60)
	else
		for k, id in pairs(standadArrowIds) do 
			_G["DGV.ChkBox"..id]:Show()
		end

		_G["DGV.ChkBox"..DGV_DISTANCED_ARROW_PING_COLOR]:Hide()
		DGV.arrowColorsSectionHeader:SetText(L["Dugi Arrow Colors"])

		DGV.defaultColorsButton:SetPoint("TOPLEFT", DGV.arrowColorsSectionHeader, 0, -115)
	end 

	_G["DGV.ChkBox"..DGV_CLEAR_FINAL_WAYPOINT]:ClearAllPoints()
	_G["DGV.ChkBox"..DGV_CLEAR_FINAL_WAYPOINT]:SetPoint("TOPLEFT", DGV.defaultColorsButton, 0, -30)
end

function DGV:InitializeZoneMap()
	if DugisGuideViewer:UserSetting(DGV_ENABLED_GPS_ARROW) then
		DugisGuideViewer.Modules.GPSArrowModule:Initialize()
		DugisGuideViewer.Modules.GPSArrowModule.initialized = true
		
	else
		if DGV.Modules.GPSArrowModule and DGV.Modules.GPSArrowModule.Unload then
			DGV.Modules.GPSArrowModule:Unload()
			DGV.Modules.GPSArrowModule.loaded = false
		end
	end
	DugisGuideViewer.Modules.GPSArrowModule.UpdateVisibility()
end

function DugisGuideViewer:SettingFrameChkOnClick(box, skip)
	local i, boxindex
	local NPCJournalFrame = DugisGuideViewer.NPCJournalFrame
	--local DGVsettings = self.chardb
	
	if box then
		_, _, boxindex = box:GetName():find("DGV.ChkBox([%d]*)")
		boxindex = tonumber(boxindex)
	end
	
	--Save to DB
    for _, i in pairs(self.chardb.sz) do
		if _G["DGV.ChkBox"..i] then
		if _G["DGV.ChkBox"..i]:GetChecked() then self.chardb[i].checked = true else self.chardb[i].checked = false end
		end
	end
	if _G["DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM] then
		if _G["DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM]:GetChecked() then 
			self.chardb[DGV_TARGETBUTTONCUSTOM].checked = true 
		else 
			self.chardb[DGV_TARGETBUTTONCUSTOM].checked = false 
		end
	end
	

	if not DugisGuideViewer:UserSetting(DGV_ENABLEQUESTLEVELDB) then
		DugisGuideViewer:SetDB(false, DGV_QUESTLEVELON)
		local Chk = _G["DGV.ChkBox"..DGV_QUESTLEVELON]
		Disable(Chk)
	else
		local Chk = _G["DGV.ChkBox"..DGV_QUESTLEVELON]
		Enable(Chk)
	end
	
	if not DugisGuideViewer:UserSetting(DGV_AUTOREPAIR) then
		DugisGuideViewer:SetDB(false, DGV_AUTOREPAIRGUILD)
		local Chk = _G["DGV.ChkBox"..DGV_AUTOREPAIRGUILD]
		Disable(Chk)
	else
		local Chk = _G["DGV.ChkBox"..DGV_AUTOREPAIRGUILD]
		Enable(Chk)
	end
	
	--Quest Level On
	if boxindex == DGV_QUESTLEVELON then
		if DugisGuideViewer:UserSetting(DGV_QUESTLEVELON) and DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
			DugisGuideViewer:UpdateGuideVisualRows()
			DugisGuideViewer:UpdateSmallFrame()
		elseif DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
			DugisGuideViewer:UpdateGuideVisualRows()
			DugisGuideViewer:UpdateSmallFrame()
		end
	end
	
    if boxindex == DGV_SHOW_EXTRA_WAYPOINT_ICON then
        DugisGuideViewer:UpdateSmallFrame()
    end    	

	--Color Code On
	if boxindex == DGV_QUESTCOLORON then
		if DugisGuideViewer:UserSetting(DGV_QUESTCOLORON) and DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
			DugisGuideViewer:UpdateGuideVisualRows()
			DugisGuideViewer:UpdateSmallFrame()
		elseif DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
			DugisGuideViewer:UpdateGuideVisualRows()
			DugisGuideViewer:UpdateSmallFrame()
		end
	end
		
	--Large Frame Lock
	if DugisGuideViewer:UserSetting(DGV_LOCKLARGEFRAME) then 
		DugisMainBorder:EnableMouse(false)
		DugisMainBorder:SetMovable(false)
	else
		DugisMainBorder:EnableMouse(true)
		DugisMainBorder:SetMovable(true)
	end
	
	--Model Viewer Frame Lock
	if DugisGuideViewer:IsModuleLoaded("ModelViewer") then
		DugisGuideViewer.Modules.ModelViewer:UpdateMovable()
	end
		
	if DugisGuideViewer:UserSetting(DGV_ITEMBUTTONON) then
		DugisGuideViewer.DoOutOfCombat(SetUseItem, DugisGuideUser.CurrentQuestIndex)
	else
		DugisGuideViewerActionItemFrame:Hide()		
		DugisSecureQuestButton:Hide()
	end
    
	
	if not self:UserSetting(DGV_ENABLENPCNAMEDB) then
		DugisGuideViewer:SetDB(false, DGV_TARGETBUTTON)
		--self.Target:Disable()
		local ChkBox = _G["DGV.ChkBox"..DGV_TARGETBUTTON]
		Disable(ChkBox)
	else
		local ChkBox = _G["DGV.ChkBox"..DGV_TARGETBUTTON]
		Enable(ChkBox)
	end

	
	if DugisGuideViewer:UserSetting(DGV_TARGETBUTTON) then
		DugisGuideViewer:SetTarget(DugisGuideUser.CurrentQuestIndex)
		
		local ChkBox = _G["DGV.ChkBox"..DGV_TARGETBUTTONSHOW]
		local ChkBox2 = _G["DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM]
		local ChkBox3 = _G["DGV.ChkBox"..DGV_TARGETTOOLTIP]
		local ChkBox4 = _G["DGV.ChkBox"..DGV_TRGET_BUTTON_FIXED_MODE]
		Enable(ChkBox)
		Enable(ChkBox2)
		Enable(ChkBox3)
		Enable(ChkBox4)
	else
		local ChkBox = _G["DGV.ChkBox"..DGV_TARGETBUTTONSHOW]
		local ChkBox2 = _G["DGV.ChkBox"..DGV_TARGETBUTTONCUSTOM]
		local ChkBox3 = _G["DGV.ChkBox"..DGV_TARGETTOOLTIP]
		local ChkBox4 = _G["DGV.ChkBox"..DGV_TRGET_BUTTON_FIXED_MODE]
		Disable(ChkBox)
		Disable(ChkBox2)
		Disable(ChkBox3)		
		Disable(ChkBox4)		
	end

	if DugisGuideViewer:IsModuleLoaded("Target") then
-- 		if DugisGuideViewer:UserSetting(DGV_TARGETBUTTONSHOW) then
-- 			DugisGuideViewer.Modules.Target.Frame:Show()
-- 		else
-- 			DugisGuideViewer.Modules.Target.Frame:Hide()
-- 		end
		DugisGuideViewer:FinalizeTarget()
	end
	
	if self:UserSetting(DGV_TARGETBUTTONCUSTOM) then
		local inputBox = _G["DGV.InputBox"..DGV_TARGETBUTTONCUSTOM]
		Enable(inputBox)
	else
		local inputBox = _G["DGV.InputBox"..DGV_TARGETBUTTONCUSTOM]
		Disable(inputBox)
	end
	
	if self:UserSetting(DGV_SHOWONOFF) then
		DugisOnOffButton:Show()
	else
		DugisOnOffButton:Hide()
	end
	
	if self:UserSetting(DGV_FIXEDWIDEFRAME) then
		--SetCVar( "watchFrameWidth", 1, InterfaceOptionsObjectivesPanelWatchFrameWidth.event);
		--InterfaceOptionsObjectivesPanelWatchFrameWidth:SetChecked(true)
		--InterfaceOptionsPanel_CheckButton_Update(InterfaceOptionsObjectivesPanelWatchFrameWidth)	
		--WatchFrame_SetWidth(GetCVar("watchFrameWidth"))
	else
		--SetCVar( "watchFrameWidth", 0, InterfaceOptionsObjectivesPanelWatchFrameWidth.event);
		--InterfaceOptionsObjectivesPanelWatchFrameWidth:SetChecked(false)
		--InterfaceOptionsPanel_CheckButton_Update(InterfaceOptionsObjectivesPanelWatchFrameWidth)	
		--WatchFrame_SetWidth(GetCVar("watchFrameWidth"))
	end
    
    if NPCJournalFrame and NPCJournalFrame.Enable then
        if self:UserSetting(DGV_JOURNALFRAME) then
            NPCJournalFrame:Enable()
        else
            NPCJournalFrame:Disable()
        end
    end
    
	if DugisGuideViewer:IsModuleLoaded("DugisArrow") then
		if self:UserSetting(DGV_DUGIARROW) then
			if self.Modules.DugisArrow and self.Modules.DugisArrow:getNumWaypoints()>0 then DugisArrowFrame:Show() end
			Enable(_G["DGV.ChkBox"..DGV_SHOWCORPSEARROW])
			Enable(_G["DGV.ChkBox"..DGV_CLASSICARROW])
		else
			Disable(_G["DGV.ChkBox"..DGV_SHOWCORPSEARROW])
			Disable(_G["DGV.ChkBox"..DGV_CLASSICARROW])
			DugisArrowFrame:Hide()
		end
		DugisGuideViewer.DugisArrow:setArrowTexture( )
	end

	if not self:UserSetting(DGV_WATCHFRAMEBORDER) and DugisGuideViewer:IsModuleLoaded("DugisWatchFrame") and self:UserSetting(DGV_DISABLEWATCHFRAMEMOD) then
		DugisGuideViewer.Modules.DugisWatchFrame:Reset()
	end		
	
	if boxindex == DGV_WATCHFRAMEBORDER then
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		DugisGuideViewer:SetAllBorders()
	end

	if boxindex == DGV_MODEL_VIEWER_BORDER then
		DugisGuideViewer:SetAllBorders()
	end	
    
	if boxindex == DGV_AUTO_MOUNT then
		DugisGuideViewer:UpdateAutoMountEnabled()
	end    
    
	if boxindex == DGV_MINIMIZE_MAP_BUTTON then
		if WorldMapFrame:IsShown() then
			DGV.SideBar.OnWMShow()
		end
	end    
	
	if boxindex == DGV_TOMTOMARROW or boxindex == DGV_CARBONITEARROW then
		DebugPrint("Switch arrow type")
		self:RemoveAllWaypoints()
		if DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then
			self:MapCurrentObjective()
		end
	end

	DugisGuideViewer:UpdateStickyFrame( )
	if DugisGuideViewer:IsModuleLoaded("SmallFrame")  then
		DugisGuideViewer:SetSmallFrameBorder( )
		DugisGuideViewer.Modules.SmallFrame:ResetFloating()
		DugisGuideViewer:ShowAutoTooltip()
	end


	DugisGuideViewer.Modules.WorldMapTracking:UpdateTrackingMap()
    
    --OnObjectiveTracker_Update on DGV_MULTISTEPMODE and DGV_ANCHOREDSMALLFRAME and DGV_EMBEDDEDTOOLTIP and DGV_OBJECTIVECOUNTER
	if boxindex == DGV_MULTISTEPMODE or boxindex ==  DGV_ANCHOREDSMALLFRAME or boxindex == DGV_EMBEDDEDTOOLTIP or boxindex == DGV_OBJECTIVECOUNTER then
		DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
		if DugisGuideViewer.Modules.ModelViewer.Finalize then
			DugisGuideViewer.Modules.ModelViewer:Finalize()
		end
	end 
    
    if boxindex ==  DGV_USE_NOTIFICATIONS_MARK then
        DugisGuideViewer:UpdateNotificationsMarkVisibility()
    end        
	
    if boxindex ==  DGV_ENABLED_GPS_ARROW then
        DGV:InitializeZoneMap()
    end    
	
    if boxindex == DGV_TRAIN_SUGGESTIONS then
        DGV.CheckForTrainingSuggestions()
    end    
	
    if boxindex == DGV_TRGET_BUTTON_FIXED_MODE then
		if DugisGuideViewer:IsModuleLoaded("Target") then
			self.Modules.Target:UpdateMode()
		end
    end   
	
	if boxindex == DGV_GPS_AUTO_HIDE then
		if DugisGuideViewer.Modules.GPSArrowModule then
			DugisGuideViewer.Modules.GPSArrowModule.UpdateVisibility()
		end
    end   
 	
	if boxindex == DGV_GPS_MERGE_WITH_DUGI_ARROW then
		if DugisGuideViewer.Modules.GPSArrowModule then
			DugisGuideViewer.Modules.GPSArrowModule.UpdateMerged()
		end
	end   
		
	if boxindex == DGV_DISTANCED_ARROW then
		if DugisGuideViewer.Modules.GPSArrowModule then
			DugisGuideViewer.Modules.GPSArrowModule.UpdateParentAnchor()
			DugisArrowGlobal:UPDATE()
		end
		
		DGV.UpdateDistancedArrowSettingsSection()
    end   	
	
	if boxindex == DGV_GPS_MINIMAP_TERRAIN_DETAIL then
		if DugisGuideViewer.Modules.GPSArrowModule then
			DugisGuideViewer.Modules.GPSArrowModule.UpdateMinimapAlpha()
		end
    end    
    
    if boxindex == DGV_STICKYFRAMESHOWDESCRIPTIONS then
		DugisGuideViewer:UpdateStickyFrame( )
	end       
	
    if boxindex == DGV_NAMEPLATES_TRACKING 
	or boxindex == DGV_NAMEPLATES_SHOW_TEXT 
	or boxindex == DGV_NAMEPLATES_SHOW_ICON then
		if DugisGuideViewer.NamePlate then
			DugisGuideViewer.NamePlate:UpdateActivePlatesExtras()
		end
		
		if self:UserSetting(DGV_NAMEPLATES_TRACKING) then
			Enable(_G["DGV.ChkBox"..DGV_NAMEPLATES_SHOW_TEXT])
			Enable(_G["DGV.ChkBox"..DGV_NAMEPLATES_SHOW_ICON])
		else
			Disable(_G["DGV.ChkBox"..DGV_NAMEPLATES_SHOW_TEXT])
			Disable(_G["DGV.ChkBox"..DGV_NAMEPLATES_SHOW_ICON])
		end
		
	end  
    
    function DGV.UpdateEnabledVisibility()
        local Chk = _G["DGV.ChkBox"..DGV_DISPLAYGUIDESPROGRESS]
        local ChkText = _G["DGV.ChkBox"..DGV_DISPLAYGUIDESPROGRESSTEXT]

        if  DugisGuideViewer:UserSetting(DGV_SHOW_SMALL_FRAME_HEADER)  then
            Enable(Chk)
            Enable(ChkText)
        
            if DugisGuideViewer:UserSetting(DGV_DISPLAYGUIDESPROGRESS) and  DugisGuideViewer:UserSetting(DGV_SHOW_SMALL_FRAME_HEADER)  then
                Enable(ChkText)
            else
                Disable(ChkText)
            end
        else
            Disable(Chk)
            Disable(ChkText)
        end 
        
        
    end
    
    if boxindex ==  DGV_DISPLAYGUIDESPROGRESS then
        DGV.UpdateEnabledVisibility()
    end   
	
    if boxindex == DGV_SHOW_SMALL_FRAME_HEADER then
		DugisGuideViewer:UpdateSmallFrame()
        DGV.UpdateEnabledVisibility()
	end 
    
    function DGV.BlinkSmallFrameTabs()
        DugisGuideViewer.SmallFrame.tabsBox:SetAlpha(1)
        DugisGuideViewer.SmallFrame.FadeInFadeOutTabs(0.07)
    end

    if boxindex == DGV_ENABLEDGEARFINDER then
        if not DugisGuideViewer:UserSetting(DGV_ENABLEDGEARFINDER) then
            HideUIPanel(CharacterFrame)
        else
            DGV.InitializeGearFinder(true)            
        end
	end      

    if boxindex == DGV_JOURNALFRAMEBUTTONSTICKED and DugisGuideViewer.NPCJournalFrame.sidebarButtonFrame then
		DugisGuideViewer.NPCJournalFrame.sidebarButtonFrame:RestoreSidebarIconPosition()
	end 
    
	local function UpdateMovables()
		if DugisGuideViewer.Modules.DugisWatchFrame and DugisGuideViewer.Modules.DugisWatchFrame.UpdateMovables then
			DugisGuideViewer.Modules.DugisWatchFrame:UpdateMovables()
		end
		if DugisGuideViewer.Modules.SmallFrame and DugisGuideViewer.Modules.SmallFrame.UpdateMovables then
			DugisGuideViewer.Modules.SmallFrame:UpdateMovables()
		end
		if DugisGuideViewer.Modules.ModelViewer and DugisGuideViewer.Modules.ModelViewer.UpdateMovable then
			DugisGuideViewer.Modules.ModelViewer:UpdateMovable()
		end
	end

    if boxindex == DGV_MOVEWATCHFRAME then
		if not self:UserSetting(DGV_MOVEWATCHFRAME) then
			Disable(_G["DGV.ChkBox"..DGV_DISABLEWATCHFRAMEMOD])
		else
			Enable(_G["DGV.ChkBox"..DGV_DISABLEWATCHFRAMEMOD])
		end

		UpdateMovables()
	end 

    if boxindex == DGV_LOCKSMALLFRAME then
		UpdateMovables()
	end 

    if boxindex == DGV_LOCKMODELFRAME then
		UpdateMovables()
	end 
	
	if boxindex == DGV_DISABLEWATCHFRAMEMOD then
		UpdateMovables()
	end   
	
	if self:UserSetting(DGV_BLINKMINIMAPICONS) then
		--StartMinimapTicker()
	end 
	
	if boxindex == DGV_AUTO_QUEST_TRACK then
		if self:UserSetting(DGV_AUTO_QUEST_TRACK) then
			SetCVar("autoQuestWatch", 1)
		elseif not self:UserSetting(DGV_AUTO_QUEST_TRACK) then
			SetCVar("autoQuestWatch", 0)
		end
	end

	local update = boxindex and self.chardb[boxindex].update
	local updateFunc = update and self[update]
	if updateFunc then
		updateFunc()
	end
end

function DugisGuideViewer:SettingsTooltip_OnEnter(chk, event)
	local _, _, boxindex = chk:GetName():find("DGV.ChkBox([%d]*)")
	boxindex = tonumber(boxindex)
	
	local DGVsettings = self.chardb
		
	if DGVsettings[boxindex].tooltip ~= "\"\"" then
		GameTooltip:SetOwner( chk, "ANCHOR_BOTTOMLEFT")
		GameTooltip:AddLine(L[DGVsettings[boxindex].tooltip], 1, 1, 1, 1, true)
		GameTooltip:Show()
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOMLEFT", chk, "TOPLEFT", 25, 0)
	end
end

function DugisGuideViewer:SettingsTooltip_OnLeave(self, event)
	GameTooltip:Hide()
end

function DugisGuideViewer:RegisterData(uniqueDataName, getDataFunction)
    if not self.datas then
        self.datas = {}
    end

    self.datas[uniqueDataName] = getDataFunction
end   


function DugisGuideViewer:GetData(uniqueDataName)
    if self.datas and self.datas[uniqueDataName] then
        return self.datas[uniqueDataName]()
    end
    return ""
end     
     

local function ToggleConfig()
	if DugisMainBorder:IsVisible() then
		DugisGuideViewer:HideLargeWindow()
	elseif DugisGuideViewer:GuideOn() then
		--UIFrameFadeIn(DugisMainframe, 0.5, 0, 1)
		--UIFrameFadeIn(Dugis, 0.5, 0, 1)
        if InCombatLockdown() and not DugisGuideViewer.wasMainWindowShown then 
            print("|cff11ff11Dugi Guides: |r|cffcc0000Cannot open settings during combat.|r Please try again."); 
            return 
        end
        
        DugisGuideViewer.wasMainWindowShown = true
		DugisGuideViewer:ShowLargeWindow()
	end
    local NPCJournalFrame = DugisGuideViewer.NPCJournalFrame
    if NPCJournalFrame and NPCJournalFrame.Update and not LuaUtils.DugiGuidesIsLoading then
        NPCJournalFrame:Update()
    end
end

function DugisGuideViewer:ToogleAutoMount()
    local newValue = not DugisGuideViewer:UserSetting(DGV_AUTO_MOUNT)
    DugisGuideViewer:SetDB(newValue, DGV_AUTO_MOUNT)
    local ChkBox = _G["DGV.ChkBox"..DGV_AUTO_MOUNT]	
    if ChkBox then
        ChkBox:SetChecked(newValue)
    end
    DugisGuideViewer:UpdateAutoMountEnabled()
    
    if DugisGuideViewer:UserSetting(DGV_AUTO_MOUNT) then
        print("|cff11ff11Auto Mount is ON|r")
    else
        print("|cff11ff11Auto Mount is OFF|r")
    end    
end

SLASH_DG1 = "/dugi"
SlashCmdList["DG"] = function(msg)	
	if msg == "" then 				-- "/dg" command
		print("|cff11ff11/dugi way xx xx - |rPlace waypoint in current zone.")
		print("|cff11ff11/dugi fix - |rReset all Saved Variable setting.")
		print("|cff11ff11/dugi reset - |rReset all frame position.")
		print("|cff11ff11/dugi on - |rEnable Dugi Addon.")
		print("|cff11ff11/dugi off - |rDisable Dugi Addon.")
		print("|cff11ff11/dugi config - |rDisplay settings menu.")
		print("|cff11ff11/dugi automount - |rToggle Auto Mount on/off.")
	elseif msg  == "on" then
		DugisGuideViewer:TurnOn()
		DugisGuideViewer:UpdateIconStatus()
	elseif msg  == "off" then
		DugisGuideViewer:TurnOff()
		DugisGuideViewer:UpdateIconStatus()
	elseif msg  == "config" then
		ToggleConfig()
	elseif msg  == "reset" then 	--"/dg reset" command
		print("|cff11ff11" .. "Dugi: Frame Reset" )
		DugisGuideViewer:InitFramePositions()
	elseif msg == "fix" then
		print("|cff11ff11" .. "Dugi: Cleared Saved Variables" )
		ResetDB()
		DugisGuideViewer:InitFramePositions()
		DugisGuideViewer:ShowReloadUi()
        DugisGuideViewer.db:ResetProfile()
		--DugisGuideViewer:ReloadModules()
	elseif msg == "automount" then
		DugisGuideViewer:ToogleAutoMount()
	elseif msg == "dgr" then
		DugisGuideViewer:ShowRecord()
	elseif msg == "dgr limit" then
		DugisGuideViewer:ToggleRecordLimit()
	elseif string.find(msg, "dgr ")==1 then
		DugisGuideViewer:RecordNote(string.sub(msg, 5))	
	elseif string.find(msg, "way ")==1 then
		local x,y,zone = string.sub(msg, 5):match("%s*([%d.]+)[,%s?]+([%d.]+)%s*(.*)")
		if zone == "" then zone = DGV:GetCurrentMapID()  end
		if x and y then
			DugisGuideViewer:AddManualWaypoint(tonumber(x)/100, tonumber(y)/100, zone)
		end
	elseif msg == "way" then		
		local zone, mapFloor, x, y = DugisGuideViewer:GetPlayerPosition()
		DugisGuideViewer:AddManualWaypoint(x, y, zone, mapFloor)
	end
end

function DugisGuideViewer:RemoveParen(text)
	if text then
		local _, _, noparen = text:find("([^%(]*)")
		noparen = noparen:trim()
		
		return noparen
	end
end


function DugisGuideViewer:OnOff_OnClick(self, event)
	if event == "LeftButton" then
        if DugisGuideViewer:UserSetting(DGV_DISABLE_QUICK_SETTINGS) ~= true then
            if LibDugi_DropDownList1 and LibDugi_DropDownList1:IsVisible() then
                DugisDropDown.LibDugi_CloseDropDownMenus(1)
            else
                DugisGuideViewer.ShowMainMenu()  
            end
        else
            --Old switching
            DugisGuideViewer:ToggleOnOff()
        end
	elseif event == "RightButton" then
		ToggleConfig()
	end
end

local function SaveFramesPositions()
	if DugisGuideUser.SkipSaveFramesPosition then return end
    if DugisGuideViewer.chardb.QuestRecordTable.framePositions == nil then
        DugisGuideViewer.chardb.QuestRecordTable.framePositions = {}
    end
    for _, frameName in pairs(savablePositionsFrameNames) do
        local framePosition = DugisGuideViewer.chardb.QuestRecordTable.framePositions[frameName]
        if framePosition == nil then
            DugisGuideViewer.chardb.QuestRecordTable.framePositions[frameName] = {}
            framePosition = DugisGuideViewer.chardb.QuestRecordTable.framePositions[frameName]
        end
        local frame = _G[frameName]
		if frame then 
            if frameName == "DugisFlightProgressBar" then
                frame = frame.Bar
            end        
			framePosition.point, framePosition.relativeTo, framePosition.relativePoint, framePosition.xOfs, framePosition.yOfs = frame:GetPoint()
			if framePosition.relativeTo then
				framePosition.relativeTo = framePosition.relativeTo:GetName()
			end
		end 
    end
end

DGV.SaveFramesPositions = SaveFramesPositions

function DugisGuideViewer.UpdateLeftMenu()
    if not settingsMenuTreeGroup then return end
	if DugisGuideViewer.chardb.EssentialsMode ~= 1 then
        if settingsMenuTreeGroup.tree[SEARCH_LOCATIONS_CATEGORY].value == "Search Locations" then
            tremove(settingsMenuTreeGroup.tree,SEARCH_LOCATIONS_CATEGORY)  --
        end
        
        if settingsMenuTreeGroup.localstatus.selected == "Search Locations" then
            settingsMenuTreeGroup:SetSelected(settingsMenuTreeGroup.tree[SEARCH_LOCATIONS_CATEGORY].value)
        end
    else
        if settingsMenuTreeGroup.tree[SEARCH_LOCATIONS_CATEGORY].value ~= "Search Locations" then
            tinsert(settingsMenuTreeGroup.tree,SEARCH_LOCATIONS_CATEGORY, { value = "Search Locations", text = L["Search Locations"], icon = nil })
        end
    end                
    
    settingsMenuTreeGroup:RefreshTree() 
end

function DugisGuideViewer:ToggleOnOff()
	if not DGV.CanSwitchMode() then return end
	if DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode == 0 then
		SaveFramesPositions()
		DugisGuideViewer:TurnOnEssentials()
		DugisGuideViewer:RefreshQuestWatch()
	elseif DugisGuideViewer:GuideOn() then
		DugisGuideViewer:TurnOff()
	else
		DugisGuideViewer.chardb.EssentialsMode = 0
		DugisGuideViewer:TurnOn()
		--DugisGuideViewer:SettingFrameChkOnClick()
	end
	DugisGuideViewer:UpdateIconStatus()
    
   DugisGuideViewer.UpdateLeftMenu()
   DugisGuideViewer:UpdateAutoMountEnabled()
end

function DugisGuideViewer:TurnOnEssentials()
	if DugisGuideViewer.Modules.DugisWatchFrame then
		DugisGuideViewer.Modules.DugisWatchFrame:OnBeforeEssentialModeActive()
	end

	--In the copper mode RemoveAllWaypoints is not available (clocking it: #128)
    if DugisGuideViewer.RemoveAllWaypoints then
        DugisGuideViewer:RemoveAllWaypoints()
    end
	DugisGuideViewer.chardb.GuideOn = true
	DugisGuideViewer.chardb.EssentialsMode = 1
	DugisGuideViewer:ReloadModules()
	--DugisGuideViewer:SettingFrameChkOnClick()
	DugisGuideViewer:UpdateIconStatus()
	DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
	for i=1, 6 do 
		local itembutton = _G["DugisSmallFrameStatus"..i.."Item"]
		if itembutton then 
			DugisGuideViewer.DoOutOfCombat(itembutton.Hide, itembutton)
		end
	end
	if DugisSecureQuestButton then
		DugisSecureQuestButton:Hide()			
	end
	DugisGuideViewer:CreateSettingsTree(DugisMainBorder)
	if DugisGuideViewer:IsModuleLoaded("Target") then DugisGuideViewer.Modules.Target.Frame:Hide() end
	if DugisGuideViewer:IsModuleLoaded("ModelViewer") then DugisGuideViewer.Modules.ModelViewer.Frame:Hide() end
	DugisGuideViewer.Modules.QuestPOI:ObjectivesChangedDelay(3)
	if DugisGuideViewer_ModelViewer and DugisGuideViewer_ModelViewer:IsShown() then DugisGuideViewer_ModelViewer:Hide() end
    
    DugisGuideViewer:UpdateAutoMountEnabled()
	print("|cff11ff11" .. "Dugi Guides Essential Mode" )
end

function DugisGuideViewer:TurnOff(forceOff)
	--if DugisGuideViewer.Modules.DugisWatchFrame then
		--DugisGuideViewer.Modules.DugisWatchFrame:OnBeforePluginOff()
	--end

	if not DugisGuideViewer:GuideOn() and not forceOff then return end
	print("|cff11ff11" .. "Dugi Guides Off" )
	DugisGuideViewer.chardb.GuideOn = false
	DugisGuideViewer.eventFrame:UnregisterAllEvents()
	DugisGuideViewer:HideLargeWindow()
	-- if DugisGuideViewer.ModelViewer.Frame then  --not created when memory setting is restricted
	--	DugisGuideViewer.ModelViewer.Frame:Hide()
	-- end
	--DugisSmallFrameLogo:Hide()
	--DugisGuideViewer.Canvas:Hide()
	--DugisGuideViewer.DugisArrow:Disable()
	--DugisGuideViewer.Target:Disable( )
	--DugisGuideViewer.StickyFrame:Disable()
	--DugisGuideViewer.SmallFrame:Disable()
	if DugisSecureQuestButton then DugisSecureQuestButton:Hide() end
	DugisGuideViewer:ReloadModules()
    
    DugisGuideViewer:UpdateAutoMountEnabled()
end

function DugisGuideViewer:TurnOn(forceOn)
	if DugisGuideViewer:GuideOn() and not forceOn then return end
	print("|cff11ff11" .. "Dugi Guides On" )
	if not DugisGuideViewer:IsModuleRegistered("Guides") then
		DugisGuideViewer.chardb.EssentialsMode = 1
	end
	DugisGuideViewer.chardb.GuideOn = true
	DugisGuideViewer:OnInitialize()	
	--DugisGuideViewer.ModelViewer:ShowCurrentModel()
	--DugisSmallFrameLogo:Show()
	--DugisGuideViewer.Canvas:Show()
	--DugisGuideViewer.DugisArrow:Enable()
	--DugisGuideViewer.Target:Enable( )
	--DugisGuideViewer.StickyFrame:Enable()
	--DugisGuideViewer.SmallFrame:Enable()
	DugisGuideViewer:SetEssentialsOnCancelReload()
	DugisGuideViewer.chardb.GuideOn = DugisGuideViewer:ReloadModules()
	if DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode ~= 1 then DugisGuideViewer:MoveToNextQuest() end
	--DugisGuideViewer:ShowLargeWindow()
	DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()		
	DugisGuideViewer:RefreshQuestWatch()	
    
    DugisGuideViewer:UpdateAutoMountEnabled()
end

if not DugisGuideViewerDelayFrameTwo then
	DugisGuideViewerDelayFrameTwo = CreateFrame("Frame")
	DugisGuideViewerDelayFrameTwo:Hide()
end

function DugisGuideViewer.DelayandSetMapToCurrentZone(delay, func)
	if DugisGuideViewerDelayFrameTwo:IsShown() then return end
	DugisGuideViewerDelayFrameTwo.func = func
	DugisGuideViewerDelayFrameTwo.delay = delay
	DugisGuideViewerDelayFrameTwo:Show()
end

DugisGuideViewerDelayFrameTwo:SetScript("OnUpdate", function(self, elapsed)
	self.delay = self.delay - elapsed
	if self.delay <= 0 then
		self:Hide()
		LuaUtils:DugiSetMapToCurrentZone()
	end
end)
			

--Occurs BEFORE QuestFrameCompleteQuestButton OnClick (works with questguru, doesn't work with carbonite)
local function Dugis_RewardComplete_Click()
	DebugPrint("QuestRewardCompleteButton_OnClick")
	if IsAddOnLoaded("QuestGuru") and DugisGuideViewer:isValidGuide(CurrentTitle) == true then
		DugisGuideViewer:CompleteQuest()
	end

	DGV:UpdateRecord()
	LuaUtils:Delay(1, function() DGV:UpdateRecord()	end)
	LuaUtils:Delay(1.5, function() DGV:UpdateRecord()	end)
	LuaUtils:Delay(2, function() DGV:UpdateRecord()	end)
end

QuestFrameCompleteQuestButton:HookScript("OnClick", function()
	Dugis_RewardComplete_Click()
end)

QuestFrame:HookScript("OnHide", function() DGV:UpdateRecord() end)


--Change map, show
local function OnMapUpdate()
	if DGV.HookLandMarks then
		DGV.HookLandMarks()
	end	
end

local function OnMapChangedOrOpen(openEvent, mapUnchanged)
	if DGV.Modules.WorldMapTracking and DGV.Modules.WorldMapTracking.OnMapChangedOrOpen then
		DugisGuideViewer.Modules.WorldMapTracking:OnMapChangedOrOpen(openEvent, mapUnchanged)
	end

	if DGV.Modules.TaxiDB and DGV.Modules.TaxiDB.OnMapChangedOrOpen then
		DugisGuideViewer.Modules.TaxiDB:OnMapChangedOrOpen()
	end

	if DGV.Modules.MapOverlays and DGV.UpdateOverlaysColors then
       DGV.UpdateOverlaysColors()
    end
end

hooksecurefunc(WorldMapFrame, "OnMapChanged", function(...)
	OnMapUpdate()
	if DugisArrowGlobal and DugisArrowGlobal.OnMapChanged then
		DugisArrowGlobal:OnMapChanged()
	end	
	
	OnMapChangedOrOpen()
end)

local lastMapId = nil
WorldMapFrame:HookScript("OnShow", function(...)
	--Prevent reloading and blinking all POIs each time on map open (performance + UX)
	if WorldMapFrame:GetMapID() ~= lastMapId then 
		OnMapUpdate()
		OnMapChangedOrOpen(true)
		lastMapId = WorldMapFrame:GetMapID()
	else
		OnMapChangedOrOpen(true, true)
	end

	DGV.SideBar.OnWMShow()
end)

WorldMapFrame:HookScript("OnHide", function(...)
	DGV.SideBar.OnWMShow()
end)

--Occurs AFTER QuestFrameCompleteQuestButton OnClick (doesn't work with questguru, works with carbonite)
QuestFrameCompleteQuestButton:HookScript("OnClick", function(...)
	DebugPrint("QuestFrameCompleteQuestButton")
	if not IsAddOnLoaded("QuestGuru") and DugisGuideViewer:isValidGuide(CurrentTitle) == true then
		DugisGuideViewer:CompleteQuest()
	end
end)

function DugisGuideViewer:OnDragStart(frame)
  if not self:UserSetting(DGV_LOCKSMALLFRAME) then
    frame:StartMoving();
    frame.isMoving = true;
  end
end

function DugisGuideViewer:OnDragStop(self)
  self:StopMovingOrSizing();
  self.isMoving = false;
end

function DugisGuideViewer:WayPoint_OnClick(frame)
	local i = frame:GetParent().guestStepIndex

	local DMAPImage = DGV:ReturnTag("DMAP", i)

	if DMAPImage then
		DugisMapViewer.Image:SetTexture("Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\MapInstructions\\"..DMAPImage..".tga")
		DugisMapViewer:Show()
	else

		DugisGuideUser.PreviewPointx = nil
		DugisGuideUser.PreviewPointy = nil	
		DugisGuideViewer:MapCurrentObjective(i, true)
		DugisGuideViewer:ShowAutoTooltip()
		DugisGuideViewer:SafeSetMapQuestId(DugisGuideViewer.qid[i]);
    end 
    --[[local waypointAutoroutine = DugisGuideViewer.GetRunningAutoroutine("SetSmartWaypoint")
    if waypointAutoroutine then
        waypointAutoroutine.onCompletion = function()
         HideNonWaypointPOIs()
        end
    else
        HideNonWaypointPOIs()
    end]] -- this hijack can interrupt multiple waypoints placement fix later 
    --HideNonWaypointPOIs()
end

function DugisGuideViewer:Button_OnEnter(frame)
	if CurrentTitle == nil then return end
	local rowNum = frame:GetParent().guestStepIndex

	if not rowNum then return end
    
    local rowObj = self.visualRows and self.visualRows[rowNum]
    
    if rowObj and rowObj.frame and rowObj.frame.Button then
        id = rowObj.frame.Button.tag_id
        tagType = rowObj.frame.Button.tagType
        GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
        if tagType == "item" then
            GameTooltip:SetItemByID(id)
        elseif tagType == "spell" then
            GameTooltip:SetSpellByID(id)
        elseif tagType == "aid" then
            GameTooltip:SetAchievementByID(id)
		elseif tagType == "qid" then
        end
    end
end

function DugisGuideViewer:HideLargeWindow()	
	DugisMainBorder:Hide()
	--Dugis:Hide()
	LuaUtils:PlaySound("igCharacterInfoClose")
end

function DGV.DugisGuideViewer_Close_ButtonClick()
	DugisGuideViewer:HideLargeWindow()
	--DugisSmallFrameLogo:Hide()
end

--[[
function DugisGuideViewer:MinimizeDungeonMap()
	DGV_DungeonFrame:Hide()
	DugisSmallFrameMaximize:Show()
end
--]]
-- 
-- Events
--

local function PetJournalShowEvent()
    for _, parentButton in pairs(PetJournal.listScroll.buttons) do
        if parentButton.journalFrameButton == nil then
            local sidebarButton = GUIUtils:AddButton(parentButton, "", 180, -11, 20, 20, 20, 20, function(self)  
                local petId = select(4, C_PetJournal.GetPetInfoBySpeciesID(self.journalFrameButton.speciesID))
                DugisGuideViewer.NPCJournalFrame:SetGuideData("Pets", petId, true)
            end
            , [[Interface\EncounterJournal\UI-EJ-PortraitIcon]], [[Interface\Buttons\ButtonHilight-Square]], [[Interface\AddOns\DugisGuideViewerZ\Artwork\npcjournal_button.tga]])
        
            sidebarButton.button.journalFrameButton =  parentButton
            parentButton.journalFrameButton = sidebarButton
        end
    end
end

local function MountJournalShowEvent()
    for _, parentButton in pairs(MountJournal.ListScrollFrame.buttons) do
        if parentButton.journalFrameButton == nil then
            local sidebarButton = GUIUtils:AddButton(parentButton, "", 180, -11, 20, 20, 20, 20, function(self)  
                DugisGuideViewer.NPCJournalFrame:SetGuideData("Mounts", self.journalFrameButton.spellID, true)
            end
            , [[Interface\EncounterJournal\UI-EJ-PortraitIcon]], [[Interface\Buttons\ButtonHilight-Square]], [[Interface\AddOns\DugisGuideViewerZ\Artwork\npcjournal_button.tga]])
        
            sidebarButton.button.journalFrameButton =  parentButton
            parentButton.journalFrameButton = sidebarButton
        end
    end
end

function DugisGuideViewer:PLAYER_LOGIN()
	if DugisGuideUser.SkipSaveFramesPosition then DugisGuideUser.SkipSaveFramesPosition = nil end
	local guid = UnitGUID("player")
	if DugisGuideUser.CharacterGUID == "PRIOR_RESET" then DugisGuideUser.CharacterGUID = guid end
	if DugisGuideUser.CharacterGUID and DugisGuideUser.CharacterGUID~=guid then
		print("|cff11ff11Dugi Guides: |rNew character detected. Wiping settings.")
		ResetDB()
		--todo: check with Fransisco why for new users EssentialsMode was 1
		--self.chardb.EssentialsMode = 1
		self:ReloadModules()
		self:SettingFrameChkOnClick()
	end
	
	--QueryQuestsCompleted()
	DugisGuideViewer:InitializeMapOverlays()
	DugisGuideViewer:InitializeQuestPOI()
	DugisGuideViewer:initAnts()
end

function DugisGuideViewer:NAME_PLATE_UNIT_ADDED(...)
	if self.Modules.NamePlate and self.Modules.NamePlate.OnNAME_PLATE_UNIT_ADDED then self.Modules.NamePlate:OnNAME_PLATE_UNIT_ADDED(...) end
end

function DugisGuideViewer:NAME_PLATE_UNIT_REMOVED(...)
	if self.NamePlate  and self.NamePlate.OnNAME_PLATE_UNIT_REMOVED then self.NamePlate:OnNAME_PLATE_UNIT_REMOVED(...) end
end

function DugisGuideViewer:PLAYER_TARGET_CHANGED()
	DGV:UpdateTargetNameInEditBox()
end


function DugisGuideViewer:PLAYER_LOGOUT( )
    SaveFramesPositions()
end

function DugisGuideViewer:PLAYER_LEAVING_WORLD( )
    SaveFramesPositions()
end

function DGV:OnZoneChange()
	self:Zone_OnEvent()
end

function DugisGuideViewer:ZONE_CHANGED()
	DGV:OnZoneChange()
	if DGV.Modules.MapOverlays and DGV.Modules.MapOverlays.HarvestCurrentMapOverlayInfo then
		DGV.Modules.MapOverlays.HarvestCurrentMapOverlayInfo()
	end
end

function DugisGuideViewer:ZONE_CHANGED_NEW_AREA()
	DGV:OnZoneChange()
	DugisGuideViewer.OnMapChangeUpdateArrow()
	--DugisGuideViewer.DugisArrow:Show()
end

function DugisGuideViewer:ZONE_CHANGED_INDOORS()
	DGV:OnZoneChange()
end

local lastIsIndoors = nil
function DugisGuideViewer:MINIMAP_UPDATE_ZOOM() --MINIMAP_UPDATE_ZOOM is only event that seems to trigger when entering a mic
	if lastIsIndoors == IsIndoors() then
		return
	end
	lastIsIndoors = IsIndoors()

	DugisGuideViewer.DelayandSetMapToCurrentZone(0.5) -- This is needed to update map floor for micro dungeons
	-- the delay is is also needed because SetMapToCurrentZone() on MINIMAP_UPDATE_ZOOM doesn't work straight away.
end


function DugisGuideViewer:QUEST_DETAIL()
	DugisGuideViewer:OnQuestDetail()
end

function DugisGuideViewer:QUEST_AUTOCOMPLETE(...)
	DugisGuideViewer:OnAutoComplete(...)
	DugisGuideViewer:UpdateCompletionVisuals()
	DugisGuideViewer:UpdateRecord()
end

function DugisGuideViewer:QUEST_COMPLETE()
	DugisGuideViewer:OnQuestComplete()
	DugisGuideViewer:UpdateCompletionVisuals()

	DugisGuideViewer:UpdateRecord()
end

local function OnQuestObjectivesComplete()
	DugisGuideViewer:PlayCompletionSound(DGV_QUESTCOMPLETESOUND)
	DugisGuideViewer:UpdateCompletionVisuals()
end

local completedLogQuests,lastCompletedLogQuests = nil, {}

local QuestLogUpdateTrigger = true

if not DugiQuestLogDelayFrame then
	DugiQuestLogDelayFrame = CreateFrame("Frame")
	DugiQuestLogDelayFrame:Hide()
end

function DugisGuideViewer:UNIT_QUEST_LOG_CHANGED(unitID) 
	
	DugisGuideViewer:UpdateRecord()
	DugisGuideViewer:Dugi_QUEST_LOG_UPDATE()
	DugisGuideViewer:UpdateSmallFrame()	

	--todo: test more
	if DugisGuideViewer.NamePlate and DugisGuideViewer.NamePlate.UNIT_QUEST_LOG_CHANGED then
		DugisGuideViewer.NamePlate:UNIT_QUEST_LOG_CHANGED(unitID)
	end
	
	LuaUtils:QueueThread("UpdateSuggestedQuests", function()
		if DugisGuideViewer.Guides and DugisGuideViewer.Guides.UpdateSuggestedQuests then
			DugisGuideViewer.Guides.UpdateSuggestedQuests(true) 
		end
	end)
end 

function DugisGuideViewer:QUEST_TURNED_IN(event, ...)
    local questID = ...;
    
    if QuestUtils_IsQuestWorldQuest(questID) then
        DugisGuideViewer:CompleteQuest(questID)
    end
end

function DugisGuideViewer.QUEST_LOG_UPDATE(func)


    if DGV.Guides and DGV.Guides.UpdateVisuals then
        DGV.Guides.UpdateVisuals()
    end

	DugisGuideViewer:UpdateRecord()
	if DugiQuestLogDelayFrame:IsShown() then return end
	DugiQuestLogDelayFrame.func = func
	DugiQuestLogDelayFrame.delay = 1
	DugiQuestLogDelayFrame:Show()
	if DugisGuideUser.NoQuestLogUpdateTrigger and not QuestLogUpdateTrigger then 
		DugisGuideUser.NoQuestLogUpdateTrigger = nil
		return 
	else
        if FirstTime then
            DugisGuideViewer:Dugi_QUEST_LOG_UPDATE()
        end
	end	
	
	if DGV.NamePlate and DGV.NamePlate.QUEST_LOG_UPDATE then
		DGV.NamePlate:QUEST_LOG_UPDATE()
	end

	if DugisGuideViewer.UpdateWorldQuestAutoGuide then
		DugisGuideViewer.UpdateWorldQuestAutoGuide()
	 end
end

DugiQuestLogDelayFrame:SetScript("OnUpdate", function(self, elapsed)
	self.delay = self.delay - elapsed
	if self.delay <= 0 then
		self:Hide()
	end
end)

function DugisGuideViewer:Dugi_QUEST_LOG_UPDATE()
	--PATCH: If I call OnLoad from PLAYER_LOGIN, 
	--GetNumQuestLogEntries == 0 when it is not.
	--Value seems to be stable after initial QLU event
    
    LuaUtils:RunInThreadIfNeeded("Dugi_QUEST_LOG_UPDATE", function(isInThread)   
    
	if FirstTime then  
		FirstTime = nil
		DugisGuideViewer:OnLoad()

	else
		DugisGuideViewer:UpdateMainFrame(isInThread)
		QuestLogUpdateTrigger = false -- need so that UpdateMainFrame will fire on load
		local i
		lastCompletedLogQuests, completedLogQuests = completedLogQuests, lastCompletedLogQuests
		if completedLogQuests then
			wipe(completedLogQuests)
		end
		for i=1,GetNumQuestLogEntries() do
            local title, _, _, isHeader, _, questFinished, _, qid = GetQuestLogTitle(i)
			if not isHeader then
				local title, _, _, _, _, questFinished = GetQuestLogTitle(i)
				local n = GetNumQuestLeaderBoards(i)
				if n>1 then
					for j=1,n do
						local text, objtype, finished = GetQuestLogLeaderBoard(j, i)
                        LuaUtils:RestIfNeeded(isInThread)
						if not finished then
							questFinished = false
						end
					end
				end
				--DugisGuideViewer:DebugFormat("QUEST_LOG_UPDATE", "qid", qid, "title", title, "questFinished", questFinished, "lastCompletedLogQuests", lastCompletedLogQuests)

				if lastCompletedLogQuests and questFinished and not tContains(lastCompletedLogQuests, qid) then
					OnQuestObjectivesComplete()

					tinsert(completedLogQuests, qid)
				elseif questFinished then
					tinsert(completedLogQuests, qid)
				end
			end
		end
		if not lastCompletedLogQuests then lastCompletedLogQuests = {} end
	end

	if DugisGuideViewer:GuideOn() then
		if DugisGuideViewer:IsModuleLoaded("DugisArrow") then
			DugisGuideViewer.DugisArrow:OnQuestLogChanged(isInThread)
		end
		
		if DugisGuideViewer:GetDB(DGV_WAYPOINTSON) and DugisGuideViewer.chardb.EssentialsMode == 1 and DugisGuideViewer:IsModuleLoaded("QuestPOI") then 
			DugisGuideViewer.Modules.QuestPOI:ObjectivesChangedDelay(3)
		end
		
		if DugisGuideViewer.chardb.EssentialsMode ~= 1 and DugisGuideViewer:UserSetting(DGV_SHOWCORPSEARROW) and UnitIsDeadOrGhost("player") then
			if DugisGuideViewer.Modules.QuestPOI.ObjectivesChangedDelay then
				DugisGuideViewer.Modules.QuestPOI:ObjectivesChangedDelay(3)
			end
		end
	end
    
    end, nil, {}, true)
    
end

function DugisGuideViewer:SKILL_LINES_CHANGED()
	if DugisGuideViewer.TriggerProfessionsUpdate then 
		DugisGuideViewer:TriggerProfessionsUpdate()
	end
end

function DugisGuideViewer:PLAYER_ALIVE(event, addon)
	DugisArrowGlobal.DetectTeleportUsage()
end

function DugisGuideViewer:CHAT_MSG_ADDON(event, addon, message, chatType, sourceCharacterName)
	local name = UnitName("player")
	local sentByName, realmName = strsplit("-", sourceCharacterName)

	DGV.UpdateCharacterRealm(sentByName, realmName)

	if name ~= sentByName then
		if DGV.RecievedData then

			if chatType == "PARTY" then
				--checking if the message was dedicated to the current "player"
				local data_forCharacter = LuaUtils:split(message, "ForPlayer:")

				if data_forCharacter and data_forCharacter[2] == name then
					DGV.RecievedData(sentByName, strsplit(":", data_forCharacter[1]))
				end
			else
				DGV.RecievedData(sentByName, strsplit(":", message))
			end
		end
	end
end

hooksecurefunc("ShowUIPanel", function(arg)
    if arg == TradeSkillFrame then
        if DugisGuideViewer.OnTradeSkillFrameHide then
            DugisGuideViewer.OnTradeSkillFrameHide()
        end
    end
end)

function DugisGuideViewer:ADDON_LOADED(event, addon)
	if addon == "DugisGuideViewerZ" then
		if not DugisLastPosition then
			DugisLastPosition = {}
		end

		DugisArrowGlobal.DetectTeleportUsage()
	
		self:UnregisterEvent("ADDON_LOADED")
		DugisGuideViewer:OnInitialize()
        
        if DugisGuideViewer.StartScanning then
            DugisGuideViewer.StartScanning()
        end
        
        LuaUtils:Delay(5, function()
            if includeButton then
                includeButton(DugisOnOffButton)
            end
        end)
        
	end

end

function DugisGuideViewer:MAP_EXPLORATION_UPDATED(event, addon)
    DGV.UpdateOverlaysColors()
end

function DugisGuideViewer:PLAYER_MONEY(event, addon)
    DGV.CheckForTrainingSuggestions()
end
 
--local lastAllAchProgress = 0 -- This create stuttering issue with some character, removed for now
function DugisGuideViewer:WORLD_MAP_UPDATE(event, addon)
    lastMapUpdate = GetTime()
--[[[	
	local checkedTable = {}
	
	if DugisGuideViewer.Modules.WorldMapTracking and DugisGuideViewer.Modules.WorldMapTracking.trackingPoints then
	
		local allAchProgress = 0
		for _,point in ipairs(DugisGuideViewer.Modules.WorldMapTracking.trackingPoints) do
			local trackingType = unpack(point.args)
			local id = point.args[3]
			
			if trackingType == "A" then
				if not checkedTable[id] then
					allAchProgress = allAchProgress + DugisGuideViewer.Modules.WorldMapTracking:GetAchievementProgress(id)
					checkedTable[id] = true
				end
			end
		end
		
		if allAchProgress ~= lastAllAchProgress then
			DugisGuideViewer.Modules.WorldMapTracking:UpdateTrackingMap()
		end
		lastAllAchProgress = allAchProgress
	end
	]] -- This create stuttering issue with some character, removed for now
end

function DugisGuideViewer:UpdateIconStatus()
	local icon = DugisGuideViewer.ARTWORK_PATH.."iconbutton"
	if DugisGuideViewer:GuideOn() and DugisGuideViewer.chardb.EssentialsMode == 1 then
		icon = DugisGuideViewer.ARTWORK_PATH.."iconbutton_s"
	elseif not DugisGuideViewer:GuideOn() then
		icon = DugisGuideViewer.ARTWORK_PATH.."iconbutton_c"
	end
	DugisOnOffButton:SetNormalTexture(icon)
	if DugisGuideViewer.LDB then
		DugisGuideViewer.LDB:SetIconStatus(icon)
	end

	if DGV.IsPlayerShareServer() or DGV.IsPlayerShareClient() then
		DugisOnOffButton.shareHighlight:Show()
	else
		DugisOnOffButton.shareHighlight:Hide()
	end

--[[    if LuaUtils.DugiGuidesIsLoading then
        DugisOnOffButton:Hide()
    elseif DugisGuideViewer:UserSetting(DGV_SHOWONOFF) then
        DugisOnOffButton:Show()
    end]]
end

function DugisGuideViewer:GetQuestLogIndexByQID(qid)
	local i
	for i=1,GetNumQuestLogEntries() do
		local qid2 = select(8, GetQuestLogTitle(i))
		if qid2 == qid then return i end
	end
end

function DugisGuideViewer:GetCarboniteQuestLogIndexByQID(qid)
	if not Nx.Quest then return end
	if not Nx.Quest.CurQ then return end
	local i
	for i=1,40 do
		if Nx.Quest.CurQ[i] then
			local curq = Nx.Quest.CurQ[i];
			local qid2 = curq.QId;
			if qid2 == qid then return i end
		end
	end
end

function DugisGuideViewer:GetItemIdFromLink(link)
	--|cff9d9d9d|Hitem:7073:0:0:0:0:0:0:0:80:0|h[Broken Fang]|h|r
	if link then return tonumber(link:match(".+|Hitem:([^:]+):.+")) end
end

function DugisGuideViewer:InitFramePositions()
	if DugisGuideViewer:IsModuleLoaded("StickyFrame") then
		self.Modules.StickyFrame.Frame:ClearAllPoints()
		self.Modules.StickyFrame.Frame:SetPoint("CENTER", 225, 180)
	end

	if DugisGuideViewer:IsModuleLoaded("NPCJournalFrame") then 
		sidebarButtonFrame.ResetSidebarIconPosition() 
	end
	
	DugisMainBorder:ClearAllPoints()
	DugisMainBorder:SetPoint("CENTER", 0, 0)
	
	if DugisGuideViewer:IsModuleLoaded("DugisWatchFrame") then
		DugisGuideViewer.Modules.DugisWatchFrame:Reset()
	end

	DugisGuideViewerActionItemFrame:ClearAllPoints()
	DugisSecureQuestButton:ClearAllPoints()
	DugisOnOffButton:ClearAllPoints()
	DugisGuideViewerActionItemFrame:SetPoint("BOTTOM", DugisArrowFrame, "TOP", 10, 4)
	DugisSecureQuestButton:SetPoint("BOTTOM", DugisArrowFrame, "TOP", 10, 4)
	DugisOnOffButton:SetPoint("BOTTOM", DugisArrowFrame, "TOP", -19, 0)

	local actionShown = DugisGuideViewerActionItemFrame:IsShown()
	local questShown = DugisSecureQuestButton:IsShown()
	DugisGuideViewerActionItemFrame:Show()
	DugisSecureQuestButton:Show()

	if not actionShown then
		DugisGuideViewerActionItemFrame:Hide()
	end
	if not questShown then
		DugisSecureQuestButton:Hide()
	end
	
	if DugisGuideViewer:IsModuleLoaded("ModelViewer") then
		DugisGuideViewer.Modules.ModelViewer:ResetPosition() 
	end

	if DugisGuideViewer:IsModuleLoaded("Target") then
		self.Modules.Target.Frame:ClearAllPoints()
		self.Modules.Target.Frame:SetPoint("LEFT", "DugisGuideViewerActionItemFrame", "RIGHT", "5", "0")
		self.Modules.Target.Frame:SetPoint("LEFT", "DugisSecureQuestButton", "RIGHT", "5", "0")
	end

	if DugisGuideViewer:IsModuleLoaded("DugisArrow") then
		DugisGuideViewer.DugisArrow:ResetPosition()
	end
    
	if DugisGuideViewer:IsModuleLoaded("DugisWatchFrame") then
	    DugisGuideViewer.Modules.DugisWatchFrame:ResetWatchFrameMovable()
	end
	
	if DugisGuideViewer:IsModuleLoaded("GPSArrowModule") then
	    DugisGuideViewer.Modules.GPSArrowModule.UpdateMerged(true)
	end
	
end

local function getQuestIndexByQuestName(name)
	local i
	local numq, _ = GetNumQuestLogEntries()
	for i=1,numq do
		local title, _, _, isHeader = GetQuestLogTitle(i)
		if not isHeader then
			if name == title then
				return i
			end

		end
	end
end

function DugisGuideViewer:GetQIDFromQuestName(name)
	local logindx = getQuestIndexByQuestName(name)
	local qid
	if logindx then
		qid = select(8, GetQuestLogTitle(logindx))
	end
	return qid
end

function DugisGuideViewer:CreateFlashFrame(parent)
	local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	frame:Hide()
	local texture = frame:CreateTexture()
	texture:SetAllPoints(frame)
	texture:SetColorTexture(1, 1, 1, 0.6)
	frame:SetBackdrop( { bgFile = nil, edgeFile = DugisGuideViewer.ARTWORK_PATH.."Border-Flash.tga", tile = true, tileSize = 32, edgeSize = 10, insets = { 0, 0, 0, 0 } })
	
	local flashGroup = frame:CreateAnimationGroup()
	local flash = flashGroup:CreateAnimation("Alpha")

	--SmallFrame:ResetFloating()

	flash:SetDuration(0.4)
	flash:SetFromAlpha(1)
	flash:SetToAlpha(0)
	flash:SetSmoothing("OUT")
	flash:SetScript("OnUpdate", function(self)
		local back = frame
		--DebugPrint("progress="..progress)
		local progress = 1 - self:GetSmoothProgress()
		back:SetAlpha(progress)

		if progress == 0 then
			--if progress >= 0.25 then
			flashGroup:Stop()
            back:Hide()
		end

		if flash:IsPlaying() then
			back:Show()
		elseif flash:IsStopped() then
			back:Hide()
		end
	end)

	frame:ClearAllPoints()

	frame:SetPoint("CENTER", parent, 1, -1)
	return flashGroup, flash, frame
end

function DugisGuideViewer:UpdateCompletionVisuals(headerAnim)
	if DugisGuideViewer:IsModuleRegistered("SmallFrame") and DugisGuideViewer:IsModuleRegistered("DugisWatchFrame") and DugisGuideViewer:GuideOn() then 
		DugisGuideViewer:UpdateSmallFrame(headerAnim)
        
        if DugisGuideViewer.Modules.DugisWatchFrame.DelayUpdate then
            DugisGuideViewer.Modules.DugisWatchFrame:DelayUpdate()
        end
		
		if DugisGuideViewer.NamePlate then
			DugisGuideViewer.NamePlate:UpdateActivePlatesExtras()
		end
	end
end

function DugisGuideViewer:CollapseCurrentGuide()
    DugisGuideUser.showLeftMenuForCurrentGuide = true
end

function DugisGuideViewer:ExpandCurrentGuide()
    DugisGuideUser.showLeftMenuForCurrentGuide = false
end

function DugisGuideViewer:ToggleCurrentGuide()
   if DugisGuideUser.showLeftMenuForCurrentGuide then
        DugisGuideViewer:ExpandCurrentGuide()
   else
        DugisGuideViewer:CollapseCurrentGuide()
   end
   DugisGuideViewer:UpdateCurrentGuideExpanded()
end

function DugisGuideViewer:GetScrollBackground()
    local isSolid = DugisGuideViewer:GetDB(DGV_MAIN_FRAME_BACKGROUND) == "Solid"
    if isSolid then
        return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\bg_home_solid"
    else
        return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\bg_home"
    end
end

function DugisGuideViewer:GetScrolllesBackground()
    local isSolid = DugisGuideViewer:GetDB(DGV_MAIN_FRAME_BACKGROUND) == "Solid"
    if isSolid then
        return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\bg_currentguide_solid"
    else
        return "Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\bg_currentguide"
    end
end

function DugisGuideViewer:MainFrameBackgroundOnChange()
    local isSolid = DugisGuideViewer:GetDB(DGV_MAIN_FRAME_BACKGROUND) == "Solid"
    if isSolid then
        DugisMainBorder.bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
    end
end

function DugisGuideViewer:UpdateCurrentGuideExpanded()
    if DugisGuideUser.showLeftMenuForCurrentGuide == nil then
        DugisGuideUser.showLeftMenuForCurrentGuide = true
    end
    
    local shouldShowExpandButton = (DugisMainCurrentGuideTab:GetButtonState() == "DISABLED" and DugisGuideViewer.CurrentTitle ~= nil)

    if not shouldShowExpandButton then
        CurrentGuideExpandButton:Hide()
        
        if DugisGuideViewer.currentTabText == "Settings" then
            DugisMainRightFrameHost:SetPoint("TOPLEFT", DugisMain, -9, -49)
            DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrolllesBackground())
            
            DugisMainLeftScrollFrame.bar:Hide()
        end

        return
    else
        CurrentGuideExpandButton:Show()
    end
    
    if DugisGuideViewer.visualRows == nil or DugisGuideViewer.visualRows[DugisGuideUser.CurrentQuestIndex] == nil then
        return
    end    

    local rowObj = DugisGuideViewer.visualRows[DugisGuideUser.CurrentQuestIndex]
    local highlightedRowTexture
    
    if rowObj.frame then
        highlightedRowTexture = rowObj.frame:GetNormalTexture();
    end
    
    if DugisGuideUser.showLeftMenuForCurrentGuide then
        DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrollBackground())
        
        DugisMainLeftScrollFrame:Show()
        DugisMainLeftScrollFrame.bar:Show()
        DugisMainRightFrameHost:SetPoint("TOPLEFT", DugisMain, 395 - 15, -44)
        CurrentGuideExpandButton:SetPoint("BOTTOMLEFT", DugisMainRightFrameHost, -92 + 30, -1)
        CurrentGuideExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
        CurrentGuideExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
        CurrentGuideExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
        if highlightedRowTexture then
            highlightedRowTexture:SetTexCoord(0, 2, 0, 1)
        end
        
        guidesMainScroll.frame:Show()
    else
        DugisMainBorder.bg:SetTexture(DugisGuideViewer:GetScrolllesBackground())
        
        DugisMainLeftScrollFrame:Hide()
        guidesMainScroll.frame:Hide()
        DugisMainRightFrameHost:SetPoint("TOPLEFT", DugisMain, 8, -44)
        DugisMainLeftScrollFrame:Hide()
        CurrentGuideExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
        CurrentGuideExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
        CurrentGuideExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
        CurrentGuideExpandButton:SetPoint("BOTTOMLEFT", DugisMainRightFrameHost, 280 + 30 , -1)
        if highlightedRowTexture then
            highlightedRowTexture:SetTexCoord(0, 1, 0, 1)
        end
    end
    
    DugisGuideViewer.UpdateGuideVisualRows()
    
    DugisGuideViewer:UpdateStepNumbersPositions()
end

local lastTimes = {}
function DugisGuideViewer:PlayCompletionSound(soundSetting)
	local now = GetTime()

	--DugisGuideViewer:DebugFormat("PlayCompletionSound", "lastTime", lastTime, "now", now, "sound", DugisGuideViewer:GetDB(soundSetting))
	if not lastTimes[soundSetting] or now - lastTimes[soundSetting] > 2 then
		PlaySoundFile(DugisGuideViewer:GetDB(soundSetting))
	end
	lastTimes[soundSetting] = now
end

local lastCUFire
function DugisGuideViewer:CRITERIA_UPDATE()
	local elapsed = GetTime()
	if lastCUFire==elapsed then return end
	lastCUFire = elapsed
	DugisGuideViewer:Guide_CRITERIA_UPDATE()
end


function DugisGuideViewer.TableAppend(t, ...)
	local n = select("#", ...)
	for i=1,n do
		tinsert(t, (select(i, ...)))
	end
end

--2656
--/script DugisGuideViewer:isLearnedSpell(2656)
function DugisGuideViewer:isLearnedSpell(spellIdToCheck)
    local allButtons = {}
    allButtons[1] = PrimaryProfession1.button1
    allButtons[2] = PrimaryProfession1.button2    
    allButtons[3] = PrimaryProfession2.button1
    allButtons[4] = PrimaryProfession2.button2
    allButtons[5] = SecondaryProfession1.button1
    allButtons[6] = SecondaryProfession1.button2    
    allButtons[7] = SecondaryProfession2.button1
    allButtons[8] = SecondaryProfession2.button2    
    allButtons[9] = SecondaryProfession3.button1
    allButtons[10] = SecondaryProfession3.button2    
    allButtons[11] = SecondaryProfession4.button1
    allButtons[12] = SecondaryProfession4.button2
    
    local isLearned = false
    
    for _, button in pairs(allButtons) do    
        local parent =  button:GetParent()
        if parent ~= nil then
            local spellIndex = button:GetID() + (parent.spellOffset or 0)
            local texture = GetSpellBookItemTexture(spellIndex, SpellBookFrame.bookType)
            local spellName, subSpellName = GetSpellBookItemName(spellIndex, SpellBookFrame.bookType)
            local skillType, spellId = GetSpellBookItemInfo(spellIndex, SpellBookFrame.bookType) --or GetSpellBookItemInfo(spellName)
            local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(spellId)
            local isShown = button:IsShown()
            if tonumber(spellId) == tonumber(spellIdToCheck) and isShown then
                isLearned = true
            end
        end
    end
    return isLearned
end

--Returns structure for SetTreeData
function DugisGuideViewer:GetLocationsAndPortalsByText(text)
    local nodes = {}
    
    local onClickFunction = function(node)
            DugisGuideViewer:RemoveAllWaypoints()
            local data = node.nodeData.data
            if data.isPortal == true then
                DugisGuideViewer:AddCustomWaypoint(data.x, data.y, "Portal " .. data.mapName, data.mapId, data.f)      
            else
                local mapId = DugisGuideViewer:GetMapIDFromName(data.zone)
                DugisGuideViewer:AddCustomWaypoint(data.x / 100, data.y / 100, data.subzoneName, mapId, 0)      
            end
            SettingsSearch_SearchBox:SetAutoFocus(false)
            SettingsSearch_SearchBox:ClearFocus()            
        end
    
    local achevementsByLocation = DGV.searchAchievementWaypointsByMapName(text)   
    for areaName, coordinates in pairs(achevementsByLocation) do
        local mapId = self:GetMapIDFromName(areaName)
        
        local localizedMapName
        
        if tonumber(mapId) then
            localizedMapName =  DGV:GetMapNameFromID(mapId)
        else
            localizedMapName =  mapId
        end
        
        nodes[#nodes+1] = {name = DugisLocals["Locations in"].. " " .. (localizedMapName or areaName), nodes = {}}
        for _, value in pairs(coordinates) do
            local nodes = nodes[#nodes].nodes
            nodes[#nodes + 1] = {name = value.subzoneName or "", data = value, isLeaf = true, shownWaypointMark = true,
                onMouseClick = onClickFunction
            }
        end
    end
    
    --Searching for portals
    local portalNodeAlreadyAdded = false
    for mapId, value in pairs(self.Modules.TaxiData.InstancePortals) do
       local id_coord_aId_critIndex = LuaUtils:split(value, ":")
       local coordinates = id_coord_aId_critIndex[2]
        
       local destMapIdString, destFloorString, destLocString, sourceMapIdString, sourceFloorString, sourceLocString = strsplit(":", value)
       local mPort,fPort,xPort,yPort =  tonumber(destMapIdString), tonumber(destFloorString),  self:UnpackXY(destLocString)
    
       local mapName = DGV:GetMapNameFromID(mapId)
       local searchKey = strupper(text)

	   if mapName and strupper(mapName):match(searchKey) then
		
           if not portalNodeAlreadyAdded then
               nodes[#nodes+1] = {name = DugisLocals["Instance Portal"], nodes = {}}
           end
           portalNodeAlreadyAdded = true
           
           local nodes = nodes[#nodes].nodes
           nodes[#nodes + 1] = {name = mapName, isLeaf = true, data = {mapName = mapName, x=xPort, y=yPort, mapId = mapId, f = fPort, isPortal = true}
           , shownWaypointMark = true, onMouseClick = onClickFunction}
       end
    end
    
    return nodes
end

if LibDugi_UIDROPDOWNMENU_MAXLEVELS then
    for i = 1, LibDugi_UIDROPDOWNMENU_MAXLEVELS do 
        local listFrameName = "LibDugi_DropDownList"..i
        if _G[listFrameName] then
            _G[listFrameName]:SetFrameStrata("TOOLTIP")
        end
    end
end

CreateFrame("GameTooltip", "DugisGuideTooltip", UIParent, "GameTooltipTemplate")
DugisGuideTooltip:SetFrameStrata("TOOLTIP")

--This function takes into account if user us currently swemming 
--Returns not exactly speed but speed "weight" 
function DugisGuideViewer:GetMountSpeed(mountId)
    local _, _, _, _, isUsable, _, isFavorite, _, _, _, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountId)
    local _, _, _, _, mountTypeId = C_MountJournal.GetMountInfoExtraByID(mountId)
    
    --Skip if cannot be mounted or is not owned
    if not isUsable or not isCollected then
        return nil
    end
    
    local isInWater = IsSubmerged() or IsSwimming()
    local isFlayableArea = IsFlyableArea() and not isInWater
    local isNoneFlayableArea = not IsFlyableArea() and not isInWater
    
    local speed = 0
    
    local namedMountType = DugisGuideViewer:GetNamedMountType(mountTypeId)
    
    if isFlayableArea then
        local preferedMount =  DugisGuideViewer.chardb["prefered-auto-mount-flying"]
      
        if preferedMount == mountId then
            speed = 5
        else
            local type2speed_map = {flying = 4, ground = 3, aquatic = 2, other = 1}
            speed = type2speed_map[namedMountType]
        end
        
        if preferedMount == "none" then
            speed = nil
        end        
    end
    
    if isNoneFlayableArea then
   
        local preferedMount =  DugisGuideViewer.chardb["prefered-auto-mount-ground"]
        
        if preferedMount == mountId then
            speed = 5
        else
            local type2speed_map = {flying = 3, ground = 4, aquatic = 2, other = 1}
            speed = type2speed_map[namedMountType]
        end
        
        if preferedMount == "none" then
            speed = nil
        end        
    end
    
    if isInWater then
        local preferedMount =  DugisGuideViewer.chardb["prefered-auto-mount-aquatic"]
        
        if preferedMount == mountId then
            speed = 5
        else
            local type2speed_map = {flying = 3, ground = 2, aquatic = 4, other = 1}
            speed = type2speed_map[namedMountType]
        end
        
        if preferedMount == "none" then
            speed = nil
        end
    end

    --If two mounts have the same speed it will pick the favourite one
    if isFavorite and speed ~= nil then
        speed = speed + 0.1
    end

    return speed
end


--This function takes into account currently mounted mount
--mountTypeFilter:  "ground", "flying", "aquatic"
function DugisGuideViewer.GetTheFastestMount()
    local theFastestMountIds = {}
    local theHighestSpeed
    
    for _, mountId in pairs(C_MountJournal.GetMountIDs()) do
    
        local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(mountId)
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected, _ = C_MountJournal.GetMountInfoByID(mountId)
        
        if isUsable and isCollected then
            
            local speed = DugisGuideViewer:GetMountSpeed(mountId)
            
            if speed and (theHighestSpeed == nil or speed >= theHighestSpeed) then
            
                if theHighestSpeed and speed > theHighestSpeed then
                    theFastestMountIds = {}
                end
                theFastestMountIds[#theFastestMountIds + 1] = mountId
                theHighestSpeed = speed
            end
        end
    end
    
    return theFastestMountIds, theHighestSpeed
end

local function IsCasting()
    --local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("player");
	local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = CastingInfo();
    return name ~= nil
end

local function IsLootFrameOpenend()
    return GetNumLootItems() > 0
end

local isInCombat = UnitAffectingCombat("player")
local lastCombatTime = GetTime()
local lastCastingNoneMountTime = GetTime()
local lastCastingMountTime = GetTime()
local lastMountedTime = GetTime()
local lastMovingTime = GetTime()

local mountId2exists = {}

local function IsMountSpell(spellID)
    return mountId2exists[spellID]
end

local function IsCastingNonMountSpell()
   -- local spellID = select(10, UnitCastingInfo("player"))  
	local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = CastingInfo();
    return castID and not IsMountSpell(spellID)
end

function DugisGuideViewer:OnCastingSpell(spellID)
    if spellID and not IsMountSpell(spellID) then
	    if tonumber(spellID) ~= 219223 and tonumber(spellID) ~= 219222 and tonumber(spellID) ~= 197886 and tonumber(spellID) ~= 240022 -- Hunter Windrunning spell effect from Marksman Artifact Bow
		and tonumber(spellID) ~= 241330 and tonumber(spellID) ~= 242597 and tonumber(spellID) ~= 242599 and tonumber(spellID) ~= 242601 -- Rethu's Incessant Courage from Legendary
		and tonumber(spellID) ~= 241835 and tonumber(spellID) ~= 241334 and tonumber(spellID) ~= 242600 and tonumber(spellID) ~= 241836 --Starlight of Celumbra priest legendary
		then   
	        lastCastingNoneMountTime = GetTime()
		end
    end
end

local function IsCastingMountSpell()
    --local spellID = select(10, UnitCastingInfo("player"))  
	local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = CastingInfo();
    return castID and IsMountSpell(spellID)
end

local function WasCastingNoneMount()
    local delay = DugisGuideViewer:GetDB(DGV_MOUNT_DELAY)
    return (GetTime() - lastCastingNoneMountTime) <= delay
end

local function IsUsingSpecialBuff()
    local n1, n2 = UnitBuff("player", 1), UnitDebuff("player", 1)
    local i = 1
    
    while n1 or n2 do
        local name1, icon1, count, _, _, _, _, _, _, spellID = UnitBuff("player", i)
        local name2, icon2, count, _, _, _, _, _, _, spellID = UnitDebuff("player", i) 
        
        n1 = name1
        n2 = name2
		
		if (icon1 and icon1 == 774121) --inv_misc_fishing_raft
		or (icon2 and icon2 == 774121) --inv_misc_fishing_raft
		or (icon1 and icon1 == 134062) --inv_misc_fork&knife
		or (icon1 and icon1 == 132293) --ability_rogue_feigndeath
		or (icon1 and icon1 == 132320) --ability_stealth
		or (icon1 and icon1 == 266311) --ability_hunter_pet_raptor curse of jani
		or (icon1 and icon1 == 132805) then --inv_drink_18
            return true
        end
       
        i = i + 1
    end
end

local function IsFeignDeath()
	local mirrortimer = GetMirrorTimerInfo(3) == "FEIGNDEATH"
	if UnitIsFeignDeath("player") then
		return true 
	end 
       if mirrortimer == true then 
		return true
	end
end

local function IsShapeShift()
	local shapeshiftForm = GetShapeshiftForm()
	if shapeshiftForm and tonumber(shapeshiftForm) > 0 then 
		if select(2, UnitClass("player")) == "SHAMAN" or select(2, UnitClass("player")) == "DRUID" then 
			return true 
		end
	end
end

local function MountTheFastestMount()
    --Preventing dropping from the height and  checking if player is not moving to allow mount
    if IsFlying() or IsPlayerMoving() or IsIndoors() 
       or IsMounted()
       or UnitIsDead("player") or UnitIsGhost("player")
       or C_PetBattles.IsInBattle() or UnitOnTaxi("player")
       or IsShapeShift()
       or (LootFrame and LootFrame:IsVisible()) 
       or IsCasting() or IsLootFrameOpenend() 
       or (GetTime() - lastCombatTime) <= 1
       --or UnitInVehicle("player") or UnitUsingVehicle("player")
       or WasCastingNoneMount() 
       or (GetTime() - lastCastingMountTime) <= 4
       or (CastingBarFrame and CastingBarFrame:IsVisible())
       or (SpellBookProfessionFrame and SpellBookProfessionFrame:IsVisible()) 
       --For few first hundred milliseconds IsFlyableArea is not correct for example after leaving dungeon.
       or (GetTime() - lastMapUpdate) <= 1  
       or UnitAffectingCombat("player")
       or (GetTime() - lastMountedTime) <= 1
       or (GetTime() - lastMovingTime) <= 0.4
       or IsUsingSpecialBuff()
       or IsFeignDeath()
       or IsFalling() then 
        return 
    end

    local theFastestMountIds, theHighestSpeed = DugisGuideViewer.GetTheFastestMount()
    
    if #theFastestMountIds > 0  then
        local randomIndex = math.random(1, #theFastestMountIds)
        C_MountJournal.SummonByID(theFastestMountIds[randomIndex])
    end
end

local autoMountTicker = nil

local function CancelAutoMountingIfNeeded()
    if IsLootFrameOpenend() and not IsFlying() and not IsMounted() then
        C_MountJournal.Dismiss()
    end
end

function DugisGuideViewer:UpdateAutoMountEnabled()
    --[[if DugisGuideViewer:UserSetting(DGV_AUTO_MOUNT) and DugisGuideViewer:GuideOn() then
        if not autoMountTicker then
            autoMountTicker = C_Timer.NewTicker(0.5, function()
            
                if IsCastingNonMountSpell() then
                    lastCastingNoneMountTime = GetTime()
                end     
                
                if IsMounted() then
                    lastMountedTime = GetTime()
                end    
                
                if IsPlayerMoving() then
                    lastMovingTime = GetTime()
                end
                
                if IsCastingMountSpell() then
                    lastCastingMountTime = GetTime()
                end
            
                if UnitAffectingCombat("player") then
                    lastCombatTime = GetTime()
                end
            
                CancelAutoMountingIfNeeded()
                MountTheFastestMount()
            end) 
        end
    else
        if autoMountTicker then
            autoMountTicker:Cancel()
            autoMountTicker = nil
        end
    end]]
end

function DugisGuideViewer.GetPluginMode()
    local isGuideMode = DugisGuideViewer:GuideOn() == true and DugisGuideViewer.chardb.EssentialsMode == 0
    local isEssentialMode = DugisGuideViewer.chardb.EssentialsMode == 1
    local isOffMode = isGuideMode ~= true and not isEssentialMode
    
    return isGuideMode, isEssentialMode, isOffMode
end

function DugisGuideViewer.RefreshMainMenu()
    if LibDugi_DropDownList1:IsShown() then
        DugisGuideViewer.ShowMainMenu()
    end
end

local oldFramesVisibilities = {}
function DGV.UpdateCombatFramesVisibility(isInCombat)
    if isInCombat and not DGV.combatHiddenFrames then
        --hidding frames
        for _, info in pairs(framesHiddenDuringCombat) do
            local frameDefinition
            local condition 
            
            if type(info) == "table" then
                frameDefinition = info.frameDefinition
                condition = info.condition
            else
                frameDefinition = info
            end
            
            if type(frameDefinition) == "function" then
                frameDefinition = frameDefinition()
            end
            
            if not condition or condition() then
                local frame = _G[frameDefinition] or frameDefinition
                if frame and frame.IsShown and frame:IsShown() and oldFramesVisibilities[frameDefinition] == nil then 
                    oldFramesVisibilities[frameDefinition] = true
					LuaUtils:HideFrame_safe(frame)
                end
            end
		end
		
		DGV.combatHiddenFrames = true
	end

	if not isInCombat and DGV.combatHiddenFrames then
        for frameDefinition, wasVisible in pairs(oldFramesVisibilities) do
            local frame = _G[frameDefinition] or frameDefinition
                frame:Show()
        end
		oldFramesVisibilities = {}
		DGV.combatHiddenFrames = false
    end
end

--Here the UI is not yet locked
function DGV.UpdateFramesCombatVisibility()
	if InCombatLockdown() then
		if DGV.chardb then
			if DGV:UserSetting(DGV_HIDE_UI_DURING_COMBAT) then
				DGV.UpdateCombatFramesVisibility(true)
			end
		end
	else
		DGV.UpdateCombatFramesVisibility(false)
	end
end

function DGV.IsHiddenForCombat(frame)
    return oldFramesVisibilities[frame]
end

function DGV.IsQuestReadyForTurnIn(questId_)
    local result = {}
	local questDisplayed = QUESTS_DISPLAYED or 1 
    for i= 1, MAX_QUESTS + questDisplayed do 
        local _, _, _, _, _, isComplete, _, questId = GetQuestLogTitle(i);		
        if questId and questId ~= 0 and tonumber(questId) == tonumber(questId_) then
			if isComplete then 
				return isComplete
			elseif GetNumQuestLeaderBoards(i) == 0 then --for turn in quest with no objective,  not labeled as complete by the game. 
				return true
			end
        end
    end
    
    return false
end

function DGV.UpdateAllQuestVisualizations(isInThread)
	if DGV.Modules.DugisWatchFrame and DGV.Modules.DugisWatchFrame.UpdateQuestsVisibility then
		DGV.Modules.DugisWatchFrame:UpdateQuestsVisibility()
	end

	LuaUtils:QueueThreadCancelOld("UpdateAllQuestVisualizations", function()
		if DGV.Modules.GPSArrowModule and DGV.Modules.GPSArrowModule.UpdateQuestPOIs then
			DGV.Modules.GPSArrowModule:UpdateQuestPOIs(true)
		end
	
		if DugisQuestsDataProvider then
			DugisQuestsDataProvider:RefreshAllData(nil, true)
		end
	end, function()
		if DGV.WorldMapFrameUpdateQuest then
			DGV.WorldMapFrameUpdateQuest()
		end 
	end)
end

function DGV.OnQuestPOIClick(questId)
	DGV.hoveredQuestId = questId
	if DGV.superTrackedQuestID == questId then
		DGV.superTrackedQuestID = nil
	else
		DGV.superTrackedQuestID = questId
	end

	DGV.UpdateAllQuestVisualizations()

	local x, y, zone = DGV.Modules.WorldMapTracking:GetQuestPosition(questId)
	DGV:RemoveAllWaypoints()
	if questId and x and y and zone then

		--[[
			
		DGV:AddCustomWaypoint(x, y, DGV.questId2Title[tonumber(questId)] or 
		("Quest: " .. questLine.button.questId), maps_82to13[zone] or zone)

		]]

		DGV:AddCustomWaypoint(x, y, DGV.questId2Title[tonumber(questId)] or 
		("Quest: " .. questLine.button.questId), maps_82to13[zone] or zone, f, nil --[[ tonumber(questId) ]], nil, nil, function()
			local extraData = DGV.GetIconData("QuestPOI", nil, questId)
			SetExtraData(extraData) 
		end)

	end

	--Case for addons that remove WorldMapFrame border and allow to have shown the rest of UI
	if UpdateTrackingFilters and WorldMapFrame:IsShown() then
		UpdateTrackingFilters(true)
	end
end

function DGV.IsQuestsTrackingEnabled()
	return DGV.Modules.WorldMapTracking and DGV.Modules.WorldMapTracking.DataProviders and DGV.Modules.WorldMapTracking.DataProviders:IsTrackingEnabled(nil, 14)
end

function DGV.ExtraSpaceForPOIsButtons()
	return DGV.IsQuestsTrackingEnabled() and 25 or 0
end

function DGV.PreparePattern(pattern)
	local result = pattern
	result = gsub(result, "([%+%-%*%(%)%?%[%]%^])", "%%%1")
	result = gsub(result, "%d%$","")
	result = gsub(result, "(%%%a)","%(%1+%)")
	result = gsub(result, "%%s%+",".+")
	result = gsub(result, "%(.%+%)%(%%d%+%)","%(.-%)%(%%d%+%)")
	return result
end

--Returns list of the following objects: {type=type["npc"/"item"], item_NPC_name=item_NPC_name, totalNeeded=totalNeeded, leftAmount=leftAmount}
function DGV.GetObjectivesInfo(questId)
	questId = tonumber(questId)
	local result = {}
	local questLogId = DGV.QuestId2QuestLogId(questId)
	if questLogId then
		local objectives = GetNumQuestLeaderBoards(questLogId)
		local qTitle, _, _, _, _, complete = GetQuestLogTitle(questLogId)

		if not DGV.questId2Title[questId] then
			DGV.questId2Title[questId] = qTitle
		end

		if objectives and not complete then
			for i = 1, objectives do
				local text, type, done = GetQuestLogLeaderBoard(i, questLogId)

				-- spawn data
				if type == "monster" then
					local _, _, monsterName, objNum, objNeeded = strfind(text,  DGV.PreparePattern(QUEST_MONSTERS_KILLED))
					objNum, objNeeded = tonumber(objNum), tonumber(objNeeded)
					result[#result + 1] = {text = text, type="npc", done=done, item_NPC_name=monsterName, leftAmount = (objNum and objNeeded) and (objNeeded-objNum) or nil}
				end

				-- item data
				if type == "item" then
					local _, _, itemName, objNum, objNeeded = strfind(text,  DGV.PreparePattern(QUEST_OBJECTS_FOUND))
					objNum, objNeeded = tonumber(objNum), tonumber(objNeeded)
					result[#result + 1] = {text = text, type="item", done=done, item_NPC_name=itemName, leftAmount = (objNum and objNeeded) and (objNeeded-objNum) or nil}
				end
			end
		end
	end
	
	return result
end

function DGV.OnTooltipShowOrUpdate()
	DGV.OnTolltipShow()
end

--To prevent frequent references to _G
local GetTooltipLine_cache
function DGV.GetTooltipLine(i)
	if not GetTooltipLine_cache then 
		GetTooltipLine_cache = {}
		for i = 1, 30 do 
			GetTooltipLine_cache[i] = _G["GameTooltipTextLeft" .. i]
		end
	end
	return GetTooltipLine_cache[i]
end

function DGV.AmountOfTooltipShownLines()
	local counter = 0
	for i = 1, 30 do 
		local line = DGV.GetTooltipLine(i)
		if not line then
			return counter
		end
		if line:IsShown() then
			counter = counter + 1
		end
	end
	return counter
end

local GameTooltip_shown = nil
local GameTooltip_firstLine = nil
local GameTooltip_visibleLines = 0
function DGV.OnFrameUpdate()
	if GameTooltip then
		if GameTooltip:IsShown() and (not GameTooltip_shown 
		or GameTooltip_firstLine ~= GameTooltipTextLeft1:GetText() 
		or GameTooltip_visibleLines ~= DGV.AmountOfTooltipShownLines()) then
			DGV.OnTooltipShowOrUpdate()
			GameTooltip_shown = true
			GameTooltip_firstLine = GameTooltipTextLeft1:GetText()
			GameTooltip_visibleLines = DGV.AmountOfTooltipShownLines()
		end

		if not GameTooltip:IsShown()  then
			GameTooltip_shown = false
		end
	end
end


--Optimization is needed because for loot items the tooltip is updated every frame by Blizzard code (Interface\FrameXML\LootFrame.xml -> OnUpdate -> LootItem_OnEnter)
--Because of that OnTolltipShow and GetQuestInfoByTargetName are invoked also every frame and FPS suffers. 
local GetQuestInfoByTargetName_cache = {}
local GetQuestInfoByTargetName_lastName= ""
local GetQuestInfoByTargetName_lastEmptyCache = GetTime()
--name - target npc name OR target item name that can be taken from the ground
function DGV.GetQuestInfoByTargetName(name)
	local cacheKey = name or ""
	local dT_sec = GetTime() - GetQuestInfoByTargetName_lastEmptyCache
	if dT_sec > 1 then
		--Clearing cache once per second
		GetQuestInfoByTargetName_cache = {} 
		GetQuestInfoByTargetName_lastEmptyCache = GetTime() 
	end

	if GetQuestInfoByTargetName_lastName == name then
		local cachedValue = GetQuestInfoByTargetName_cache[cacheKey]
		if cachedValue then
			return cachedValue
		end
	end

	GetQuestInfoByTargetName_lastName = name 
	
	local result = {}
	result.objectives = {} 

	local quests = DGV.GetAllActiveQuests(false)

	local questFound = false
	--Trying to match by required target NPC (mostly slain) or required item to pick up from the ground
	for _, questInfo in pairs(quests) do
		local questId  = questInfo.questId
		local objectives = DGV.GetObjectivesInfo(questId)

		local questNameAdded
		for _, objective in pairs(objectives) do

			--Plural version will work only for english (cases with "s" postfix). 
			if objective.item_NPC_name == name or (objective.item_NPC_name  == (name or "") .. "s")  then
				if not questNameAdded then
					questNameAdded = true
					questFound = true
				end
				objective.questInfo = questInfo
				result.objectives[#result.objectives + 1] = objective
			end
		end
	end

	--Trying to find all items that provided unit is dropping
	if not questFound then
		local items =  WorldTrackingRawItems
		local rawQuests = WorldTrackingRawQuests

		--we want to limit just for active quests
		for _, questInfo in pairs(quests) do
			local rawQuestData = rawQuests[questInfo.questId]

			if rawQuestData and rawQuestData.obj then
				if rawQuestData.obj.I then
					local requiredRelateditemIds = rawQuestData.obj.I
					for _, itemId in pairs(requiredRelateditemIds) do
						local relatedItemData = items[itemId]
						if relatedItemData and relatedItemData.U and #relatedItemData.U > 0 then 
							for _, unitId in pairs(relatedItemData.U) do 
								local unitName = DGV:GetLocalizedNPC(unitId)

								if unitName == name and not questFound  then
									--We found target npc raw data and quest info.
									local objectives = DGV.GetObjectivesInfo(questInfo.questId)

									for _, objective in pairs(objectives) do
										objective.questInfo = questInfo
										objective.itemId = itemId
										result.objectives[#result.objectives + 1] = objective
									end
								end
							end
						end
					end
				end
			end
		end
	end

	GetQuestInfoByTargetName_cache[cacheKey] = result
	return result
end

function DGV.TolltipContains(text)
	for i = 1, 30 do 
		local line = DGV.GetTooltipLine(i)
		if line then
			if line:IsShown() and line:GetText() == text then
				return true
			end
		else
			return false
		end
	end
end

function DGV.OnTolltipShow()
	if not DGV:UserSetting(DGV_TARGET_TOOLTIP_OBJECTIVES) then 
		return
	end

	local name = GameTooltip:GetUnit()
	name = name or GameTooltipTextLeft1:GetText()

	local questInfo =  DGV.GetQuestInfoByTargetName(name)

	if questInfo  then
		local lastQuestName
		for _, objective in pairs(questInfo.objectives) do
			local newLine = " - " .. objective.text
			if not DGV.TolltipContains(newLine) then
				if lastQuestName ~= objective.questInfo.name then
					GameTooltip:AddLine(objective.questInfo.name)
				end
				lastQuestName = objective.questInfo.name
				GameTooltip:AddLine(newLine, 1, 1, 1, 1, true)
			end
		end

		GameTooltip:Show()
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	DGV.OnTolltipShow(self)
end)

function DGV:GetQuestLevel(qid)
	if self.ReqLevel[qid] then
		return self.ReqLevel[qid][1]
	end
end

function DGV.CanSwitchMode()
	if InCombatLockdown() then 
		print("|cff11ff11Dugi Guides: |r|cffcc0000Cannot change the mode during combat.|r Please try again."); 
		return false 
	end
	return true
end


local function IsSkillTrained(spellName_, skillRank_)
	local spellName, spellSubName = GetSpellBookItemName(1, BOOKTYPE_SPELL)

	local index = 1
	while spellName do
		spellName, spellSubName = GetSpellBookItemName(index, BOOKTYPE_SPELL)

		if spellSubName then
			spellSubName = spellSubName:match("([0-9]+)")
		end

		if spellName_ == spellName and (not tonumber(skillRank_) or not tonumber(spellSubName) or tonumber(spellSubName) >= tonumber(skillRank_)) then
			return true
		end

		index = index + 1
	end

	return false
end

function DGV.RemoveTrainingNotification()
	local notofication = DugisGuideViewer:GetNotificationByType("training-suggestion")
	if notofication then
		DugisGuideViewer:RemoveNotification(notofication.id)
	end
end

local abilitiesData
local playerClass = select(2, UnitClass("player"))

function DGV.IsTalentSkill(abilityId_)
	local abilitiesData = AbilitiesData[playerClass] or {}
	local checkingAbilityName =  GetSpellInfo(abilityId_)

	local isListed = false
	for abilityId, abilityInfo in pairs(abilitiesData) do 
		local rank = unpack(abilityInfo)

		if rank == 1 then
			local name = GetSpellInfo(abilityId)

			if name == checkingAbilityName then
				return false
			end
		end
	end 

	return true
end

function DGV.CheckForTrainingSuggestions()
	if not abilitiesData then
		abilitiesData = AbilitiesData[playerClass] or {}
	end

	if not DGV:UserSetting(DGV_TRAIN_SUGGESTIONS) then
		DGV.RemoveTrainingNotification()
		return
	end

	DugisGuideUser = DugisGuideUser or {}
	DugisGuideUser.suggestionState = DugisGuideUser.suggestionState or {}
	local suggestionState = DugisGuideUser.suggestionState 

	local playerLevel = UnitLevel("player")

	local added = false

 	
	for abilityId, abilityInfo in pairs(abilitiesData) do 
		local rank, level, cost = unpack(abilityInfo)
		local name, _, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(abilityId)

		if level and playerLevel and level <= playerLevel and not IsSkillTrained(name, rank)  then
			--Checking for talent skill
			local checkForPreviousTalentSkills = rank and rank > 1 --DGV.IsTalentSkill(abilityId)

			if checkForPreviousTalentSkills then
				checkForPreviousTalentSkills = DGV.IsTalentSkill(abilityId)
			end

			local isPreviousRankLearned = false
			if checkForPreviousTalentSkills then
				isPreviousRankLearned = IsSkillTrained(name, rank - 1)
			end

			if not checkForPreviousTalentSkills or isPreviousRankLearned then
				if not suggestionState[abilityId] then
					added = true
					suggestionState[abilityId] = {ignored = false}
				end
			end
		end
	end 

	if not added then 
		DGV.RemoveTrainingNotification()
	end

	TrainPromptFrame:Show()
	DGV.UpdateTrainSuggestionsUI()
end

function DGV.UpdateTrainSuggestionsUI()

	local playerFaction = UnitFactionGroup("player")
	local playerFactionNumber = playerFaction and (playerFaction == "Alliance" and 1 or 2)

	local lineHeight = 30

	TrainPromptFrame.lines = TrainPromptFrame.lines or {}
	DugisGuideUser.suggestionState = DugisGuideUser.suggestionState or {}
	
	local suggestionState = DugisGuideUser.suggestionState

	for k, line in pairs(TrainPromptFrame.lines) do
		line:Hide()
	end
	
	local playerMoney = GetMoney()

	local i = 1
	for abilityId, abilityInfo in pairs(suggestionState) do 
		local name, _, icon = GetSpellInfo(abilityId)
		local data = abilitiesData[abilityId]

		if data then
			local rank, level, cost, faction = unpack(abilitiesData[abilityId])

			if (not faction or not playerFactionNumber or faction == playerFactionNumber) 
				and (cost == nil or playerMoney >= cost) then
				if not abilityInfo.ignored and not IsSkillTrained(name, rank) then
					local visualLine = CreateFrame("Button", nil, TrainPromptFrame, "TrainSuggestionLine")
					TrainPromptFrame.lines[i] = visualLine
					visualLine:ClearAllPoints()
					visualLine:SetPoint("TOPLEFT", 35, -lineHeight * i - 50)
					visualLine:Show()

					name = LuaUtils:crop(name, 20)
					local text = name

					if rank then
						text = text .. "   |cff11ff11Rank "..rank.."|r"
					end

					if cost then
						text = text .. "  |cffffffff"..GetCoinTextureString(cost).."|r"
					end

					visualLine.title:SetText(text)
					visualLine.abilityInfo = abilityInfo
					visualLine.skill.icon:Show()
					visualLine.skill.abilityId = abilityId
					visualLine.skill.icon:SetTexture(icon)

					i = i + 1
				end
			end
		else
			suggestionState[abilityId] = nil
		end
	end

	TrainPromptFrame:SetHeight(120 + i * lineHeight)

	if i == 1 then
		TrainPromptFrame:Hide()
	end
end

function DGV.DismissAllTrainingSuggestions()
	for _, abilityInfo in pairs(DugisGuideUser.suggestionState) do 
		abilityInfo.ignored = true
	end

	DGV.UpdateTrainSuggestionsUI()
end

LuaUtils:Delay(15, function()
	DGV.CheckForTrainingSuggestions()
end)

function DGV:GetQuestLevel(qid)
	if self.ReqLevel[qid] then
		return self.ReqLevel[qid][1]
	end
end


--returns values from 0.2 to 2.0
function DGV:GetAntTrialSize()
	local scrollValue = (DGV:GetDB(DGV_PATH_WIDTH) or 5)*0.2
	return scrollValue 
end

function DGV:GetUnitDropNames(unitId)
	local drops = DGV.unitId2itemIds[unitId]
	local result = {}
	for itemId in pairs((drops or {})) do
		local name = GetItemInfo(itemId)
		if name then
			result[name] = itemId
		end
	end
	return result
end

local SideBar = {}
DGV.SideBar = SideBar

local worldmapFrameInitialPos		
local worldMapFrameCloseButtonInitialPos

local WorldMapSidePanel = {}

WorldMapSidePanel.detailsX = 5
WorldMapSidePanel.detailsOffsetY = 0
WorldMapSidePanel.detailsOffsetX = 0
WorldMapSidePanel.detailsY = -21
WorldMapSidePanel.detailsHeight = 247
WorldMapSidePanel.detailsDeltaHeight = 0
WorldMapSidePanel.detailsDeltaWidth = 0
WorldMapSidePanel.backgroundWidth = 400
WorldMapSidePanel.X = 1023

function SideBar.AddWorldMapTexture(texturePath, x, y, w, h, x1, x2, y1, y2, anchorPoint)
	anchorPoint = anchorPoint or "TOPRIGHT"
	local text
	if SideBar.isElvUIAddonInstalled() then
		text = UIParent:CreateTexture(nil, "OVERLAY")
	else
		text = WorldMapFrame:CreateTexture(nil, "OVERLAY")
	end
	text:SetTexture(texturePath)
	text:SetPoint(anchorPoint, WorldMapFrame ,anchorPoint, x, y) 
	text:SetSize(w, h) 
	text:SetTexCoord(x1, x2, y1, y2)
	return text
end

function SideBar.GetAvailableButtons()
	local result = {}

	local money = GetQuestLogRewardMoney();

	if money and money > 0 then
		local icon = [[Interface\ICONS\INV_Misc_Coin_01]]
		
		if money < 10000 then icon = [[Interface\ICONS\INV_Misc_Coin_03]] end
		if money < 100 then icon = [[Interface\ICONS\INV_Misc_Coin_05]] end

		result[#result + 1] = {type = "money", text = GetCoinTextureString(money), icon = icon}
	end

	for i = 1, 10 do 
		local button = _G["QuestLogItem"..i]
		if button then
			DGV.newButtons = DGV.newButtons or {}
			local newButton = DGV.newButtons[i]

			if button:IsShown() then
				local currentButtonInfo = {type = "item"}
				local icon = button.Icon or button.icon or _G[button:GetName().."IconTexture"];

				if icon then
					local texture = icon:GetTexture()
					if texture then
						currentButtonInfo.icon = texture
					end
				end

				currentButtonInfo.text = button.Name:GetText()
				currentButtonInfo.originalButton = button
				currentButtonInfo.originalIndex = i
				result[#result + 1] = currentButtonInfo
			end
		end
	end
	
	return result
end

function SideBar.RewardSize()
	local result = 0
	local buttons = SideBar.GetAvailableButtons()
	for i = 1, #buttons do 
		local ySpace = 57
		if i % 2 == 1  then
			result = result + ySpace
		end
	end

	if result ~= 0 then
		result = result + 25
	end

	if #buttons <= 2 then
		result = result + 10
	end

	return result - WorldMapSidePanel.detailsDeltaHeight
end


SideBar.rightPanelElements = {}

local rightPaddingReduction = 0


SideBar.isLeatrixAddonInstalled = function()
	return _G.LeaMapsDB
end

SideBar.isElvUIAddonInstalled = function()
	return _G.Tukui or _G.ElvUI
end

function SideBar.OnWMShow()
	local WorldMapUnitPin, WorldMapUnitPinSizes

	for pin in WorldMapFrame:EnumeratePinsByTemplate("GroupMembersPinTemplate") do
		WorldMapUnitPin = pin
		WorldMapUnitPinSizes = pin.dataProvider:GetUnitPinSizesTable()
		break
	end

	if not SideBar.minMaxButton and not DGV:UserSetting(DGV_MINIMIZE_MAP_BUTTON) then
		return
	end

	if not worldmapFrameInitialPos then
		worldmapFrameInitialPos = {WorldMapFrame:GetPoint()}
		worldMapFrameCloseButtonInitialPos = {WorldMapFrameCloseButton:GetPoint()}
	end
	
	if not SideBar.minMaxButton then
		local sidePanelX = 0
		local sidePanelY = -23
		local sidePanelHeight = 715
		local extraQuestsOffsetY = 0
		local scrollBarHeight = sidePanelHeight - 33
		local scrollBarY = -24
		local scrollBarX = 0
		local mainPanelYOffset = 0
		local backgroundExtraWidth = 0
		
		if SideBar.isLeatrixAddonInstalled() then
			sidePanelY = -65
			sidePanelHeight = 678
			sidePanelX = -7
			extraQuestsOffsetY = -10
			scrollBarX = -5
			scrollBarY = -68
			scrollBarHeight = sidePanelHeight - 35

			WorldMapSidePanel.detailsOffsetY = -47
			WorldMapSidePanel.detailsOffsetX = -4
			WorldMapSidePanel.detailsDeltaHeight = -43
			WorldMapSidePanel.detailsScrollX = -2
		end

		if SideBar.isElvUIAddonInstalled() then
			mainPanelYOffset = -10
			sidePanelHeight = 798
			sidePanelX = 20
			sidePanelY = 0
			extraQuestsOffsetY = -20
			scrollBarX = 0
			scrollBarY = -48
			scrollBarHeight = sidePanelHeight - 115 + mainPanelYOffset
			WorldMapSidePanel.detailsOffsetX = 4
			WorldMapSidePanel.detailsOffsetY = 20
			WorldMapSidePanel.detailsDeltaHeight = 48
			WorldMapSidePanel.detailsDeltaWidth = 60
			WorldMapSidePanel.detailsScrollX = -2
			backgroundExtraWidth = sidePanelX
		end

		SideBar.extraRightTop = SideBar.AddWorldMapTexture([[Interface\Worldmap\UI-WorldMapSmall-Right]], WorldMapSidePanel.backgroundWidth, -1, 80, 256, 0, 0.6171875, 0, 0.5)
		SideBar.extraLeftTop = SideBar.AddWorldMapTexture([[Interface\Worldmap\UI-WorldMapSmall-Left]], WorldMapSidePanel.backgroundWidth - 80, -1, WorldMapSidePanel.backgroundWidth - 80 + 3, 256, 0.5, 1, 0, 0.5)
		SideBar.extraRightBottom = SideBar.AddWorldMapTexture([[Interface\Worldmap\UI-WorldMapSmall-Right]], WorldMapSidePanel.backgroundWidth, -75, 80, 256, 0, 0.6171875, 0.5, 1, "BOTTOMRIGHT")
		SideBar.extraRight = SideBar.AddWorldMapTexture([[Interface\Worldmap\UI-WorldMapSmall-Right]], WorldMapSidePanel.backgroundWidth, -256, 80,336, 0, 0.6171875, 0.5, 0.6)
		SideBar.extraBottomLeft = SideBar.AddWorldMapTexture([[Interface\Worldmap\UI-WorldMapSmall-Left]], WorldMapSidePanel.backgroundWidth - 80, -75, WorldMapSidePanel.backgroundWidth - 80, 256, 0.5, 1, 0.5, 1, "BOTTOMRIGHT")
		SideBar.bkg = SideBar.AddWorldMapTexture([[Interface\AddOns\DugisGuideViewerZ\Artwork\WorldMapSidePanelBottomBkg]], WorldMapSidePanel.backgroundWidth + sidePanelX, sidePanelY, WorldMapSidePanel.backgroundWidth + backgroundExtraWidth, sidePanelHeight, 0, 0.544921875, 0, 0.65234375)
		SideBar.mask1 = SideBar.AddWorldMapTexture([[Interface\AddOns\DugisGuideViewerZ\Artwork\WorldMapSidePanelBottomMask]], 120, -3, 256, 32, 0, 1, 0, 1, "BOTTOMRIGHT")
		SideBar.mask2 = SideBar.AddWorldMapTexture([[Interface\AddOns\DugisGuideViewerZ\Artwork\WorldMapSidePanelTopMask]], 80, -1, 128, 32, 0, 1, 0, 1)

		SideBar.elementsToHide = {}
		SideBar.rightPanelElements = {SideBar.extraRightTop, SideBar.extraLeftTop, SideBar.extraRightBottom, SideBar.extraRight, SideBar.extraBottomLeft, SideBar.bkg, SideBar.mask1, SideBar.mask2}

		if SideBar.isLeatrixAddonInstalled() then
			SideBar.elementsToHide = {SideBar.extraRightTop, SideBar.extraLeftTop, SideBar.extraRightBottom, SideBar.extraRight, SideBar.extraBottomLeft, SideBar.mask1, SideBar.mask2}
		end

		if SideBar.isElvUIAddonInstalled() then
			SideBar.elementsToHide = {SideBar.extraRightTop,  SideBar.extraLeftTop, SideBar.mask1, SideBar.mask2 , SideBar.extraRightBottom, SideBar.extraBottomLeft, SideBar.extraRight--[[, , SideBar.mask1, SideBar.mask2 ]]}
		
			SideBar.extraRightTop:SetColorTexture(0.5, 0.5, 0.5)
			SideBar.extraRightTop:SetWidth(WorldMapSidePanel.backgroundWidth)
			SideBar.extraRightTop:SetHeight(sidePanelHeight)
		end
		
		WorldMapFrame:SetScript("OnDragStart", function()
			WorldMapFrame:StartMoving()
		end)

		WorldMapFrame:SetScript("OnDragStop", function()
			WorldMapFrame:StopMovingOrSizing()
			WorldMapFrame:SetUserPlaced(false)
			DugisGuideUser.worldmapFramePos = {WorldMapFrame:GetPoint()}
		end)

		SideBar.minMaxButton = CreateFrame("BUTTON", "SideBar.minMaxButton", WorldMapFrame, "MaximizeMinimizeButtonFrameTemplate")
		SideBar.minMaxButton:SetSize(32, 30)

		if DugisGuideUser.worldMapFloating or SideBar.isLeatrixAddonInstalled() then
			SideBar.minMaxButton:Minimize()
		else
			SideBar.minMaxButton:Maximize()
		end

		SideBar.minMaxButton:SetOnMinimizedCallback(function()
			DugisGuideUser.worldMapFloating = true
			SideBar.OnWMShow()
		end)
		
		SideBar.minMaxButton:SetOnMaximizedCallback(function()
			DugisGuideUser.worldMapFloating = false
			SideBar.OnWMShow()
		end)

		SideBar.collapseButton = CreateFrame("BUTTON", "SideBar.collapseButton", WorldMapFrame, "MaximizeMinimizeButtonFrameTemplate")
		SideBar.collapseButton:SetSize(45, 38)

		
		if DugisGuideUser.worldMapSidePanel then
			SideBar.collapseButton:Minimize()
		else
			SideBar.collapseButton:Maximize()
		end

		SideBar.collapseButton:SetOnMinimizedCallback(function()
			DugisGuideUser.worldMapSidePanel = true
			SideBar.OnWMShow()
		end)
		
		SideBar.collapseButton:SetOnMaximizedCallback(function()
			DugisGuideUser.worldMapSidePanel = false
			SideBar.OnWMShow()
		end)

		local texture = [[Interface\QUESTFRAME\QuestMapLogAtlas]]
		SideBar.collapseButton.MaximizeButton:SetNormalTexture(texture)
		SideBar.collapseButton.MinimizeButton:SetNormalTexture(texture)
		SideBar.collapseButton.MaximizeButton:SetPushedTexture(texture)
		SideBar.collapseButton.MinimizeButton:SetPushedTexture(texture)

		SideBar.collapseButton.MaximizeButton:GetNormalTexture():SetTexCoord(0.37890625,0.4150390625,0.876953125,0.91015625)
		SideBar.collapseButton.MinimizeButton:GetNormalTexture():SetTexCoord(0.3291015625,0.365234375,0.9208984375,0.9541015625)
		SideBar.collapseButton.MaximizeButton:GetPushedTexture():SetTexCoord(0.28125,0.3173828125,0.9306640625,0.9638671875)
		SideBar.collapseButton.MinimizeButton:GetPushedTexture():SetTexCoord(0.328125,0.3642578125,0.9541015625,0.9873046875)

		SideBar.collapseButton.MaximizeButton:SetFrameLevel(50)
		SideBar.collapseButton.MinimizeButton:SetFrameLevel(50)

		SideBar.mainPanel = CreateFrame("FRAME", nil, WorldMapFrame)
		SideBar.mainPanel:SetSize(WorldMapSidePanel.backgroundWidth , 495)
		SideBar.mainPanel:SetPoint("TOPLEFT", WorldMapFrame, 1000 , -15 + mainPanelYOffset)
		SideBar.mainPanel:Hide()

		SideBar.mainPanel:SetParent(WorldMapFrame)

		SideBar.mainPanel:EnableMouseWheel(true)
		SideBar.mainPanel:SetScript("OnMouseWheel", function(self, delta)
			SideBar.mainScroll.scrollBar:SetValue(SideBar.mainScroll.scrollBar:GetValue() - delta * 24)  
		end)     

		SideBar.detailsPanel = CreateFrame("FRAME", nil, WorldMapFrame, "QuestDetailsFrameDugisTemplate")
		SideBar.detailsPanel:SetSize(WorldMapSidePanel.backgroundWidth + WorldMapSidePanel.detailsDeltaWidth, 495 + WorldMapSidePanel.detailsHeight + WorldMapSidePanel.detailsDeltaHeight)
		SideBar.detailsPanel:SetPoint("TOPLEFT", WorldMapFrame, WorldMapSidePanel.X + WorldMapSidePanel.detailsOffsetX , -15 +  WorldMapSidePanel.detailsOffsetY)
		SideBar.detailsPanel:Hide()
		SideBar.detailsPanel:SetFrameStrata("TOOLTIP")

		SideBar.mainPanel.Handler = CreateFrame("FRAME", nil, WorldMapFrame)

		--Panel Details components
		for _, frame in pairs({SideBar.mainPanel, SideBar.detailsPanel, SideBar.detailsPanel.Handler, SideBar.mainPanel.Handler}) do 
			frame:EnableMouse(true)
			frame:SetMovable(true)
			frame:RegisterForDrag("LeftButton")
	
			frame:SetScript("OnDragStart", function()
				WorldMapFrame:StartMoving()
			end)
	
			frame:SetScript("OnDragStop", function()
				WorldMapFrame:StopMovingOrSizing()
			end)
		end

		for _, frame in pairs({SideBar.detailsPanel.Abandon, SideBar.detailsPanel.Share, SideBar.detailsPanel.Track}) do 
			frame:SetWidth(132)
		end

		SideBar.detailsPanel.Share:ClearAllPoints()
		SideBar.detailsPanel.Track:ClearAllPoints()

		SideBar.detailsPanel.Share:SetPoint("TOPLEFT", SideBar.detailsPanel.Abandon, "TOPRIGHT", 0,0 )
		SideBar.detailsPanel.Track:SetPoint("TOPLEFT", SideBar.detailsPanel.Share, "TOPRIGHT", 0,0 )

		for _, frame in pairs({SideBar.detailsPanel.Handler, SideBar.mainPanel.Handler}) do 
			frame:ClearAllPoints()
			frame:Show()
		end

		SideBar.detailsPanel.Handler:SetSize(WorldMapSidePanel.backgroundWidth - 25 - WorldMapSidePanel.detailsX, 15)
		SideBar.detailsPanel.Handler:SetPoint("TOPLEFT", 0, 15)	
		
		SideBar.mainPanel.Handler:SetPoint("TOPLEFT", SideBar.mainPanel,  0, 13)
		SideBar.mainPanel.Handler:SetSize(WorldMapSidePanel.backgroundWidth - 30, 15)
		SideBar.mainPanel.Handler:SetFrameStrata("TOOLTIP")

		SideBar.detailsScroll = GUIUtils:CreateScrollFrame(SideBar.detailsPanel, "QuestLogScrollDugis")
		SideBar.mainScroll = GUIUtils:CreateScrollFrame(SideBar.mainPanel, "SidePanelScrollDugis")

		for _, scroll in pairs({SideBar.detailsScroll, SideBar.mainScroll}) do
			scroll.frame:Show()
			scroll.frame:ClearAllPoints()
			scroll.scrollBar:SetMinMaxValues(1, 500) 
			scroll.scrollBar:SetValue(2)
		end

		SideBar.detailsScroll.frame:SetPoint("TOPLEFT", 10, -38 + WorldMapSidePanel.detailsY)
		SideBar.detailsScroll.frame:SetParent(SideBar.detailsPanel)
		SideBar.detailsScroll.scrollBar:SetPoint("TOPLEFT", SideBar.detailsPanel, "TOPLEFT", WorldMapSidePanel.backgroundWidth - 15 - WorldMapSidePanel.detailsX + (WorldMapSidePanel.detailsScrollX or 0), -53 + WorldMapSidePanel.detailsY)

		SideBar.darkBar = SideBar.detailsScroll.frame:CreateTexture()
		SideBar.darkBar:SetPoint("TOPRIGHT", -10, 0)
		
		SideBar.darkBar:SetColorTexture(0,0,0,0.3)

		SideBar.mainScroll.frame:SetParent(SideBar.mainPanel)
		SideBar.mainScroll.frame:SetPoint("TOPLEFT", 40,  sidePanelY + 3 + extraQuestsOffsetY)
		SideBar.mainScroll.frame:SetWidth(WorldMapSidePanel.backgroundWidth)
		SideBar.mainScroll.frame:SetHeight(460 + WorldMapSidePanel.detailsHeight - (SideBar.isLeatrixAddonInstalled() and 70 or 8)) 

		SideBar.mainScroll.scrollBar:SetPoint("TOPLEFT", SideBar.mainPanel, "TOPLEFT", WorldMapSidePanel.backgroundWidth + 2 + scrollBarX , scrollBarY)
		SideBar.mainScroll.scrollBar:SetHeight(scrollBarHeight)	

		for _, frame in pairs({DugiSidePanelTextureMain, DugiSidePanelTextureShadow, DugiSidePanelTextureTop, DugiSidePanelTextureRewards}) do 
			frame:ClearAllPoints()
		end

		DugiSidePanelTextureMain:SetPoint("TOPLEFT", 0, -30 + WorldMapSidePanel.detailsY)
	
		DugiSidePanelTextureShadow:SetTexture([[Interface\QUESTFRAME\QuestMapLogAtlas]]) 
		DugiSidePanelTextureShadow:SetSize(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX, 13)
		DugiSidePanelTextureShadow:SetPoint("TOPLEFT", 0, -33 + WorldMapSidePanel.detailsY )

		DugiSideDetailsRewardsTitle:SetWidth(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX)
		DugiSideDetailsRewardsTitle:SetTextColor(1, 1, 1)
		DugiSideDetailsRewardsTitle:SetAlpha(0.7)
		DugiSideDetailsRewardsTitle:SetShadowColor(0, 0, 0, 0)
		
		DugiSideDetailsQuestLogItemChoose:SetTextColor(1, 1, 1)
		DugiSideDetailsQuestLogItemChoose:SetAlpha(0.7)

		DugiSideDetailsQuestLogItemChoose:SetWidth(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX)
		
		DugiSidePanelTextureTop:SetSize(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX, 50)
		DugiSidePanelTextureTop:SetPoint("TOPLEFT", 0, 15 + WorldMapSidePanel.detailsY)
		
		DugiSidePanelTextureRewards:SetSize(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX, 300)
		DugiSidePanelTextureRewards:SetPoint("TOPLEFT", 0, -385 + WorldMapSidePanel.detailsY - WorldMapSidePanel.detailsDeltaHeight)

		SideBar.detailsScroll.frame:SetWidth(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX)

		local sidePanelDetails = CreateFrame("FRAME", nil, SideBar.detailsScroll.frame, "SidePanelDetailsContentTemplate")
		SideBar.detailsScroll.frame:SetScrollChild(sidePanelDetails)
		sidePanelDetails:Show()
		sidePanelDetails:SetPoint("TOPLEFT", 0, -50 + WorldMapSidePanel.detailsY)

		for _, text in pairs({DugiSideDetailsQuestTitle, DugiSideDetailsLogShtortDesc, DugiSideDetailsObjectivesText, DugiSideDetailsDesc}) do
			text:SetWidth(WorldMapSidePanel.backgroundWidth - 40 - WorldMapSidePanel.detailsX)
		end	

		WorldMapFrame.ScrollContainer:HookScript("OnMouseWheel", function(self, delta)
			local x, y = self:GetNormalizedCursorPosition()
			local nextZoomOutScale, nextZoomInScale = self:GetCurrentZoomRange()
			if delta == 1 then
				if nextZoomInScale > self:GetCanvasScale() then
					self:InstantPanAndZoom(nextZoomInScale, x, y)
				end
			else
				if nextZoomOutScale < self:GetCanvasScale()  then
					self:InstantPanAndZoom(nextZoomOutScale, x, y)
				end
			end
		end)
	end

	DugisGuideUser = DugisGuideUser or {}

	if (DugisGuideUser.worldMapFloating and WorldMapFrame:IsShown() and DGV:UserSetting(DGV_MINIMIZE_MAP_BUTTON)) or SideBar.isLeatrixAddonInstalled() then
		DugisGuideViewer.WorldMapFrameUpdateQuest()

		WorldMapFrame:SetMovable(true)
		WorldMapFrame:RegisterForDrag("LeftButton")

		DugisGuideUser.worldMapX = DugisGuideUser.worldMapX or 100 
		DugisGuideUser.worldMapY = DugisGuideUser.worldMapY or -100 

		if DugisGuideUser.worldmapFramePos then
			WorldMapFrame:ClearAllPoints()
			if SideBar.isElvUIAddonInstalled() then
				WorldMapFrame:SetPoint("TOPLEFT", 20, -120)
			else
				WorldMapFrame:SetPoint(unpack(DugisGuideUser.worldmapFramePos))
			end
		end

		SideBar.mask1:SetDrawLayer("OVERLAY", 5)
		SideBar.mask2:SetDrawLayer("OVERLAY", 5)
		SideBar.bkg:SetDrawLayer("OVERLAY", 6)
	
		if not SideBar.isLeatrixAddonInstalled() then
			SetWorldMapScale(false)
		end
		WorldMapFrame.BlackoutFrame:Hide()

		WorldMapFrame.HandleUserActionToggleSelf = function()
			if WorldMapFrame:IsShown() then WorldMapFrame:Hide() else WorldMapFrame:Show() end
		end

		WorldMapFrame.ScrollContainer.GetCursorPosition = function(self)
			local x, y = MapCanvasScrollControllerMixin.GetCursorPosition(WorldMapFrame.ScrollContainer)
			local scale = WorldMapFrame:GetScale() * UIParent:GetEffectiveScale()
			return x / scale, y / scale
		end 

	    UISpecialFrames[#UISpecialFrames + 1] = "WorldMapFrame"

		for _, v in pairs(SideBar.rightPanelElements) do 
			v:Show()
		end

		for _, v in pairs(SideBar.elementsToHide) do 
			v:Hide()
		end
		
		SideBar.mainPanel:Show()
		SideBar.mainPanel.Handler:Show()
		SideBar.mainPanel:SetFrameStrata("TOOLTIP")

		if not DugisGuideUser.worldMapSidePanel then
			for _, v in pairs(SideBar.rightPanelElements) do 
				v:Hide()
			end	

			SideBar.mainPanel:Hide()
			SideBar.mainPanel.Handler:Hide()
			SideBar.detailsPanel:Hide()
		end

		SideBar.collapseButton:Show()

		WorldMapUnitPinSizes.player = 25
		WorldMapUnitPin:SynchronizePinSizes()

	else
		WorldMapFrame:ClearAllPoints()

		WorldMapFrame:SetPoint("TOP")

		WorldMapFrame.BlackoutFrame:Show()

		if not SideBar.isLeatrixAddonInstalled() then
			SetWorldMapScale(true)
		end
		
		WorldMapFrame:SetMovable(false)
		WorldMapFrame:RegisterForDrag("")

		for _, v in pairs(SideBar.rightPanelElements) do 
			v:Hide()
		end

		SideBar.mainPanel:Hide()
		SideBar.mainPanel.Handler:Hide()
		SideBar.detailsPanel:Hide()
		SideBar.collapseButton:Hide()

		WorldMapUnitPinSizes.player = 16
		WorldMapUnitPin:SynchronizePinSizes()
	end

	if not SideBar.isLeatrixAddonInstalled() then
		if (DugisGuideUser.worldMapFloating and DugisGuideUser.worldMapSidePanel) or SideBar.isLeatrixAddonInstalled() then
			WorldMapFrameCloseButton:ClearAllPoints()
			WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapSidePanel.backgroundWidth + 5 + rightPaddingReduction, 4)
			SideBar.minMaxButton:ClearAllPoints()
			SideBar.minMaxButton:SetPoint("TOPRIGHT", WorldMapSidePanel.backgroundWidth - 17+ rightPaddingReduction, 3)
		else
			SideBar.minMaxButton:ClearAllPoints()
			SideBar.minMaxButton:SetPoint("TOPRIGHT", -18, 3)

			WorldMapFrameCloseButton:ClearAllPoints()
			WorldMapFrameCloseButton:SetPoint(unpack(worldMapFrameCloseButtonInitialPos))
		end

		if WorldMapFrame:IsShown() and not DGV:UserSetting(DGV_MINIMIZE_MAP_BUTTON) then
			if worldMapFrameCloseButtonInitialPos then
				WorldMapFrameCloseButton:ClearAllPoints()
				WorldMapFrameCloseButton:SetPoint(unpack(worldMapFrameCloseButtonInitialPos))
			end
		end
	end

	SideBar.collapseButton:ClearAllPoints()
	SideBar.collapseButton:SetPoint("BOTTOMRIGHT", -18, 35)

	SideBar.mainScroll.scrollBar:SetValue(1)
end

function SideBar.GetObjectivesText(noColoring)
	local numObjectives = GetNumQuestLeaderBoards();
	local result = ""
	for i=1, numObjectives, 1 do
		local text, type, finished = GetQuestLogLeaderBoard(i);

		if finished and not noColoring then
			text = "|cff333333"..text.."|r"
		end

		result = result .. text.."\n"
	end
	return result
end 

function SideBar.UpdateQuestTexts()
	DugiSideDetailsQuestTitle:SetText(GetQuestLogTitle(GetQuestLogSelection()))
	DugiSideDetailsLogShtortDesc:SetText(QuestInfoObjectivesText:GetText())
	DugiSideDetailsObjectivesText:SetText(SideBar.GetObjectivesText())
	DugiSideDetailsDesc:SetText(GetQuestLogQuestText())

	if REWARD_CHOICES then
		DugiSideDetailsQuestLogItemChoose:SetText(REWARD_CHOICES)
	end

	DugiSidePanelTextureBottom:ClearAllPoints()
	DugiSidePanelTextureBottom:SetSize(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX, 40)
	DugiSidePanelTextureBottom:SetPoint("TOPLEFT", 0, -647 + SideBar.RewardSize() + WorldMapSidePanel.detailsY )
	SideBar.detailsScroll.scrollBar:SetHeight(335 + WorldMapSidePanel.detailsHeight - SideBar.RewardSize())

	SideBar.detailsScroll.frame:SetHeight(365 + WorldMapSidePanel.detailsHeight - SideBar.RewardSize())
	SideBar.darkBar:SetSize(18, 365 + WorldMapSidePanel.detailsHeight - SideBar.RewardSize())

	DugiSidePanelTextureMain:SetSize(WorldMapSidePanel.backgroundWidth - WorldMapSidePanel.detailsX, 390+ WorldMapSidePanel.detailsHeight  - SideBar.RewardSize())

	local buttons = SideBar.GetAvailableButtons()

	for _, button in pairs(DGV.newButtons or {}) do
		button:Hide()
	end

	for i = 1, #buttons do 
		local button = buttons[i]

		DGV.newButtons = DGV.newButtons or {}
		local newButton = DGV.newButtons[i]

		if not newButton then
			newButton =  CreateFrame("Button", nil, SideBar.detailsPanel, "QuestLogRewardItemTemplate")
			DGV.newButtons[i] = newButton
		end

		local ySpace = 25
		local x = 10
		local y = -i * ySpace - 446 + SideBar.RewardSize()

		if i % 2 == 0 then
			x = 165
			y = y + ySpace
		end

		newButton:Show()
		newButton:ClearAllPoints()
		newButton:SetPoint("TOPLEFT", x, y + WorldMapSidePanel.detailsY -  WorldMapSidePanel.detailsHeight)

		if button.icon then
			SetItemButtonTexture(newButton, button.icon);
		end

		if button.text then
			newButton.Name:SetText(button.text)
		end

		local oldFrameLevel = GameTooltip:GetFrameLevel()
		newButton:SetScript("OnEnter", function(self)
			if button.originalButton then
				GameTooltip:SetOwner(newButton, "ANCHOR_RIGHT");
				if ( button.originalButton.rewardType == "item" ) then
					GameTooltip:SetQuestLogItem(button.originalButton.type, button.originalButton:GetID());
				elseif (button.originalButton.rewardType == "spell" ) then
					GameTooltip:SetQuestLogRewardSpell(button.originalButton:GetID());
				end
				GameTooltip:SetFrameLevel(30)
				oldFrameLevel = GameTooltip:GetFrameLevel()
			end
		end)

		newButton:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
			GameTooltip:SetFrameLevel(oldFrameLevel)
		end)

		if button.originalIndex then
			local icon = button.originalButton.Icon or button.originalButton.icon
			if icon then
				local r, g, b = icon:GetVertexColor();
				SetItemButtonTextureVertexColor(newButton, r, g, b);
				SetItemButtonNameFrameVertexColor(newButton, r, g, b);
			else
				SetItemButtonTextureVertexColor(newButton, 1, 1, 1);
			end
		else
			SetItemButtonTextureVertexColor(newButton, 1, 1, 1);
		end
	end

	local contentHeight = DugiSideDetailsQuestTitle:GetTop() - DugisPositionIndicator:GetTop() - SideBar.detailsScroll.scrollBar:GetHeight()

	if contentHeight < 1 then contentHeight = 1	end

	SideBar.detailsScroll.scrollBar:SetMinMaxValues(1, contentHeight) 
	if contentHeight == 1 then
		SideBar.detailsScroll.scrollBar:Hide()
		SideBar.darkBar:Hide()
	else
		SideBar.detailsScroll.scrollBar:Show()
		SideBar.darkBar:Show()
	end
end

function SideBar.UpdateTrackUntrackButton()
	if IsQuestWatched(SideBar.currentDetailsQuestIndex) then
		SideBar.detailsPanel.Track:SetText("Untrack")
	else
		SideBar.detailsPanel.Track:SetText("Track")
	end
end

function SideBar.ShowSidePanelDetails(questId, questText, index)
	if DGV.Modules.DugisWatchFrame then
		DGV.Modules.DugisWatchFrame:ShowObjective(questText)
		QuestLogFrame:Hide()
	end

	DGV.questId2Zone = DGV.questId2Zone or {}
	
	if DGV.questId2Zone[questId] then
		LuaUtils:DugiSetMapByID(DGV.questId2Zone[questId])
	end
	
	SideBar.detailsPanel:Show()
	SideBar.UpdateQuestTexts()
	SideBar.mainPanel:Hide()
	SideBar.mainPanel.Handler:Hide()
	SideBar.detailsScroll.scrollBar:SetValue(1)
	SideBar.currentDetailsQuestId = questId
	SideBar.currentDetailsQuestIndex = index
	SideBar.UpdateTrackUntrackButton()

	SideBar.detailsPanel.Share:SetEnabled(QuestFramePushQuestButton:IsEnabled())

end

function SideBar.HideSidePanelDetails()
	if SideBar.currentDetailsQuestId then
		SideBar.detailsPanel:Hide()
		SideBar.mainPanel:Show()
		SideBar.mainPanel.Handler:Show()
		SideBar.currentDetailsQuestId = nil
		SideBar.currentDetailsQuestIndex = nil
	end
end

DGV.rightPanelQuestsPool = {}

local function SetCurrentQuest(questText)
	if DGV.Modules.DugisWatchFrame then
		DGV.Modules.DugisWatchFrame:ShowObjective(questText)
	end
end

local pressedAbandonIndex = nil
local oldFrameStrata = "DIALOG"
StaticPopupDialogs["GROUP_ABANDON_CONFIRMATION1"] = {
	text = "Abandon All Quests?",
	button1 = "Yes",
	button2 = "No",
	OnHide = function(frame)
		pressedAbandonIndex = nil
		frame:SetFrameStrata(oldFrameStrata)
	end,
	OnShow = function(frame)
		oldFrameStrata = frame:GetFrameStrata()
		frame:SetFrameStrata("TOOLTIP")
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


local function InitializeAbantonButtons(treeData)
	for _, headerNode in pairs(treeData) do 
		LuaUtils:RestIfNeeded(true)
		local parentButton = headerNode.visualNode
		if parentButton.abandonGroupButton == nil then
			local buttonFrame = GUIUtils:AddButton(parentButton, "", 320, 6, 28, 28, 28, 28, function(self)  
				StaticPopupDialogs["GROUP_ABANDON_CONFIRMATION1"].text = "Abandon All " .. headerNode.name .. " Quests?" 
				pressedAbandonIndex = parentButton.headerIndex
				StaticPopup_Show("GROUP_ABANDON_CONFIRMATION1")
			end, [[INTERFACE\BUTTONS\CancelButton-Up]], [[INTERFACE\BUTTONS\CancelButton-Down]], [[INTERFACE\BUTTONS\CancelButton-Down]])
			buttonFrame.button.abandonGroupButton =  parentButton
			parentButton.abandonGroupButton = buttonFrame
		end

		parentButton.headerIndex = headerNode.headerIndex
		parentButton.abandonGroupButton.button:SetFrameLevel(200)

		if parentButton.abandonGroupButton then
			if not DGV:UserSetting(DGV_SHOWQUESTABANDONBUTTON) then
				parentButton.abandonGroupButton.button:Hide()
			else
				parentButton.abandonGroupButton.button:Show()
			end
		end
	end
	
end

DGV.WorldMapFrameUpdateQuest = function()
	if not SideBar.mainScroll then
		return
	end


	--Rebuilding side panel controls/list
	LuaUtils:QueueThreadCancelOld("RebuildSideQuestsPanel", function()

	local treeData = {}
	local quests_ = DGV.GetAllActiveQuests()

	local category2Quests = {}

	for _, questInfo in pairs(quests_) do 
		LuaUtils:RestIfNeeded(true)
		local questId  = questInfo.questId
		local headerTitle = questInfo.headerTitle
		category2Quests[headerTitle] = category2Quests[headerTitle] or {}
		category2Quests[headerTitle][#category2Quests[headerTitle] + 1] = questInfo
	end

	for _, pin in pairs(DGV.rightPanelQuestsPool) do
		LuaUtils:RestIfNeeded(true) 
		pin:Hide()
	end

	local y = 0
	if SideBar.mainPanel then
		for headerTitle, quests in pairs(category2Quests) do
			LuaUtils:RestIfNeeded(true)
			local currentNode = {name = headerTitle, data = {},  extraBottomGap = 12, nodes = {}, textColor = {r = 0.8, g = 0.8, b = 0.8}}
			treeData[#treeData + 1] = currentNode

			for i, questInfo in pairs(quests) do 
				LuaUtils:RestIfNeeded(true)
				local questId  = questInfo.questId

				currentNode.headerIndex = questInfo.headerIndex

				local _, level, _, _, _, _, _, _, _, _, _, _, _, _, _, _, isScaling = GetQuestLogTitle(questInfo.index);

				local difficultyColor = GetQuestDifficultyColor(level, isScaling, questId);

				local currentLeaf = {name = questInfo.name, questName = questInfo.name, isLeaf = true, data = {questId = questId}, extraSpace = 5, dX = 8, dY = 0, noHightlight = true,
				onMouseClick = function()
					SideBar.ShowSidePanelDetails(questId, questInfo.name, questInfo.index)
				end, textColor = {r = difficultyColor.r, g = difficultyColor.g, b = difficultyColor.b}}
				currentNode.nodes[#currentNode.nodes + 1] = currentLeaf

				if IsQuestWatched(questInfo.index) then
					currentLeaf.name = currentLeaf.name .. " " .. [[|TInterface\Buttons\UI-CheckBox-Check:20:20:0:-1|t]]
				end

				local objectives = DGV.GetObjectivesInfo(questId)
	
				local objectivesText = ""
				local someObj = false
				for j, obj in pairs(objectives) do 
					LuaUtils:RestIfNeeded(true)
					local currentLeaf = {name = "- " .. obj.text, questName = questInfo.name, isLeaf = true, data = {relatedQuestId = questId}, dX = 6, extraSpace = -4, dY = 3, noHightlight = true,
					onMouseClick = function()
						SideBar.ShowSidePanelDetails(questId, questInfo.name, questInfo.index)
			
					end, textColor = {r = 0.8, g = 0.8, b = 0.8}}
					currentNode.nodes[#currentNode.nodes + 1] = currentLeaf
				end
				
			end
		end
	end

	local tree = GUIUtils:SetTreeData(UIParent, nil, "WorldMapFramePanelTree", treeData, nil, nil, nil, nil, 15, 0, nil,nil,nil,function(_, newHeight)
		if newHeight < 400 then newHeight = 400 end
		SideBar.mainScroll.scrollBar:SetMinMaxValues(1, newHeight - 390) 
	end)


	tree:EnableMouse(false)
	SideBar.mainScroll.frame:SetScrollChild(tree)

	--Bulding quest circle buttons
	local i = 1

	for _, headerNode in pairs(treeData) do 
		LuaUtils:RestIfNeeded(true)

		headerNode.visualNode.Title:SetFont(GUIUtils.getFRIZQTFont(), 14)

		for _, node in pairs(headerNode.nodes) do 
			LuaUtils:RestIfNeeded(true)
			local visualNode = node.visualNode
			if node.data and node.data.questId then
				if not visualNode.questPin then
					visualNode.questPin = CreateFrame("FRAME", nil, visualNode, "QuestPinTemplate")
				end

				local pin = visualNode.questPin

				pin:SetScript("OnMouseDown", function(self)
					DGV.OnQuestPOIClick(self.questId)
					DGV.WorldMapFrameUpdateQuest()
				end)	

				pin:ClearAllPoints()
				pin:SetPoint("CENTER", WorldMapFrameRightPanel, "TOPLEFT", 30, -y)

				pin.questId = node.data.questId;

				local isSuperTracked = node.data.questId == DGV.superTrackedQuestID;

				GUIUtils.Quests:SetupQuestButton(pin, isSuperTracked, 30, 35, isSuperTracked and "yellow" or "brown")

				i =  i + 1
				pin:ClearAllPoints()
				pin:SetPoint("CENTER", visualNode, "TOPLEFT", -13, -12)
				pin:Show()
			else
				if visualNode.questPin then
					visualNode.questPin:Hide()
				end
			end
		end
	end

	InitializeAbantonButtons(treeData)
	end)
end

hooksecurefunc("QuestLog_Update", function()
	DGV.WorldMapFrameUpdateQuest()
end)


hooksecurefunc("AbandonQuest", function()
	SideBar.HideSidePanelDetails()
end)

function SideBar.TrackUntrackQuest()
	local questIndex = SideBar.currentDetailsQuestIndex

	if ( IsQuestWatched(questIndex) ) then
		local questID = GetQuestIDFromLogIndex(questIndex);
		for index, value in ipairs(QUEST_WATCH_LIST) do
			if ( value.id == questID ) then
				tremove(QUEST_WATCH_LIST, index);
			end
		end
		RemoveQuestWatch(questIndex);
		QuestLog_Update();
	else
		-- Set error if no objectives
		if ( GetNumQuestLeaderBoards(questIndex) == 0 ) then
			UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0);
			return;
		end
		-- Set an error message if trying to show too many quests
		if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
			UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0);
			return;
		end
		QuestLog_Update();
	end

	SideBar.UpdateTrackUntrackButton()
end

function DGV:ShowSettings(category)
	if not DugisMainBorder:IsVisible() then
		ToggleConfig()
	end
	if DugisMain and DugisMain.settingsTab and DugisGuideViewer.DeselectTopTabs then
		DugisMain.settingsTab:Click()
	end
	if settingsMenuTreeGroup and category then
		settingsMenuTreeGroup:SelectByValue(category)
	end
end

local function Highlight(text)
	return "|cff11ff11" .. (text or "") .. "|r"
end

function DGV.InitializeShareGuide()

	local shareSystem = DGV.GetShareSystem()
	

	--[[

	--Share Guide System Model. Example data:
	shareSystem = {
		--CLIENTS MODEL (user by server):
		--Information about all other players that are controlled but the server.
		shareClients = {
			--Indes is a player name
			  Qwe = {status="invited", lastUpdateTime=43.2}
			, Zwe = {status="received-invitation", lastUpdateTime=44.2}
			, Rqw = {status="connected", lastUpdateTime=45.2}
			, Wqw = {status="offline", lastUpdateTime=45.2}
			, Sgd = {status="declined", lastUpdateTime=46.2,
				guideState = {   
					---PRESENT GUIDE MODE---
					currentStepIndex = 11,
					joinedAtServerStepIndex = 5,
					stepStates = {[1]="C", [2]="U", [3]="C", [4]="U"},
					currentTitle = "asdsa",  --It might be different thand the title on the server and it is updated only by the client via NGSI event.
					
					---MISSING GUIDE MODE---
					--False means that client has not installed required guide
					hasGuide = true,
					--Information about accepted/ready for turn in/completed quests.
					questStates = {[questId1]={[A]=true, [C]=true, [T]=true,}, [questId2]={ [A]=true, [C]=true, [T]=false}}
				}
			}
		},  

		--SERVER MODEL (used by client):
		--Information about the "master(server)" player and about pending invitation	
		shareServer = {
			playername="Pob", status="invited/connected/offline", lastUpdateTime = GetTime(),
			--data about guide steps that was sent to the server. It is needed to prevent sending the same data multiple times.
			guideState = {
				currentStepIndex = 2,
				stepStates = {[1]="C", [2]="U"},
				currentTitle = "asdsa"
			},

			currentStepIndex_serverSide = 5
		},

		--Used to prevent sending the NGT with the same title using SendCurrentGuideTitleToClients 
		--for server side only
		lastSentTitle,

		--Needed for case when sever completed the step but one of the clients "blocked" going further with steps.
		--Example:  {[1] = {"Xds"=true, "Treds"=true}, [2] = {"Xds"=true}}		
		notCompletedPlayers
	}

	]]

	shareSystem.notCompletedPlayers = shareSystem.notCompletedPlayers or {}
	shareSystem.shareClients = shareSystem.shareClients or {}

	--this tabe is used by client and server and is used for cross realm communication 
	shareSystem.characterName2RealmName = shareSystem.characterName2RealmName or {}

	--Returns player name with realm name
	local function PlayerFullName(playerName)
		local realm = shareSystem.characterName2RealmName[playerName]
		if realm and realm ~= "" then
			return playerName.."-"..shareSystem.characterName2RealmName[playerName]
		end

		return playerName
	end

	--Returns player name with realm name
	function DGV.UpdateCharacterRealm(playerName, realmName)
		if realmName and playerName then
			shareSystem.characterName2RealmName[playerName] = realmName
		end
	end

	function DGV.GetCharacterRealm(playerName)
		return shareSystem.characterName2RealmName[playerName] or ""
	end

	function DGV.SetRealmNameByCache(playerName)
		if shareSystem.characterName2RealmName[playerName] then
			DGV.playerRealmEditBox:SetText(shareSystem.characterName2RealmName[playerName])
		else
			DGV.playerRealmEditBox:SetText("")
		end
	end

	local function GetInitialServerData()
		return {trackedQuests={}}
	end

	function DGV:SendAddonMessage(command, playerShortName)
		if (UnitInParty(playerShortName)) then
			--For support for cross-realm messages
			C_ChatInfo.SendAddonMessage("dugis", command.."ForPlayer:"..playerShortName, "PARTY", PlayerFullName(playerShortName))
		else
			C_ChatInfo.SendAddonMessage("dugis", command, "WHISPER", PlayerFullName(playerShortName))
		end
	end

	shareSystem.shareServer = shareSystem.shareServer or GetInitialServerData()

	
	--------------------------------
	--Guide/path sharing functionality
	--------------------------------


	--[[
	Commands:
		SWI - SetWaypointInfo
		RAW - RemoveAllWaypoints
		CONNECT - recieved connection invitation
		RECEIVED_INVITATION 
		ACCEPTED 
		DISCONNECT_BY_CLIENT
		DISCONNECT_BY_SERVER  
	]]
	function DGV.RecievedData(fromPlayerName, command, ...)
		local params = {...}
		local paramsAmount = #params
		for i = 1, paramsAmount do
			if params[i] == "nil" then
				params[i] = nil
			end
		end
		
		----Special commands like CONNECT, ACCEPTED etc----

		--Recieves client
		if command == "CONNECT" then
			if not DGV:UserSetting(DGV_ENABLED_GUIDE_SHARING) then
				return
			end

			if shareSystem.shareServer and shareSystem.shareServer.status == "connected" then
				DGV:SendAddonMessage("ALREADY_CONNECTED", fromPlayerName)
				return
			end

			shareSystem.shareServer = {playername = fromPlayerName, status = "invited", lastUpdateTime = GetTime()}

			print("Player", Highlight(fromPlayerName), "wants to share the guide with you.|r")

			DGV:ShowInvitation()
			DGV:SendAddonMessage("RECEIVED_INVITATION", fromPlayerName)
			return
		end

		--Recieves client
		if command == "CONNECTED" then
			--todo: check first if the player is not already connected
			if shareSystem.shareServer then
				shareSystem.shareServer.status = "connected"
				shareSystem.shareServer.lastUpdateTime = GetTime()
				local notification =  DugisGuideViewer:GetNotificationByType("share-invitation")
				if notification then
					DugisGuideViewer:RemoveNotification(notification.id)
				end		
				
				print("The player", Highlight(fromPlayerName) , "has started Guide Sharing with you.|r")
			end

			DugisGuideViewer:UpdateIconStatus()

			DGV.SendDataToServer("NGSI")
			return
		end

		--Recieves sever
		if command == "DISCONNECT_BY_CLIENT" then
			if shareSystem.shareClients then
				shareSystem.shareClients[fromPlayerName] = nil
				DGV.OnClientDisconnected(fromPlayerName)
			end
			DGV.UpdateServerShareVisualization()
			DugisGuideViewer:UpdateIconStatus()
			print("The player",  Highlight(fromPlayerName) , "has disconnected from your Guide Sharing.|r")
			if DGV.UpdateGuideVisualRows then
				DGV.UpdateGuideVisualRows()
			end
			return
		end

		--Recieves sever
		if command == "ALREADY_CONNECTED" then
			print("The player",  Highlight(fromPlayerName), "is already connected with another player. Please try again later or ask the player to end the current sharing.|r")
			return
		end

		--Recieves sever
		if command == "RECEIVED_INVITATION" then
			if shareSystem.shareClients[fromPlayerName] then
				shareSystem.shareClients[fromPlayerName] = {status = "received-invitation", lastUpdateTime = GetTime()}
				
				DGV.UpdateServerShareVisualization()
			end
			return
		end

		--Recieves client
		if command == "DISCONNECT_BY_SERVER" then
			if shareSystem.shareServer and shareSystem.shareServer.playername == fromPlayerName then

				if shareSystem.shareServer and shareSystem.shareServer.status == "connected" then
					print("Player", Highlight(fromPlayerName), "has finished the Guide Sharing with you.|r")
				else
					print("Player", Highlight(fromPlayerName), "has canceled the invitation for you.|r")

					if ShareGuideInvitationFrame and ShareGuideInvitationFrame:IsShown() and fromPlayerName == shareSystem.shareServer.playername then
						ShareGuideInvitationFrame:Hide()
					end
				end
				
				shareSystem.shareServer = GetInitialServerData()
				local notification =  DugisGuideViewer:GetNotificationByType("share-invitation")
				if notification then
					DugisGuideViewer:RemoveNotification(notification.id)
				end	
			end

			DugisGuideViewer:UpdateIconStatus()
			return
		end

		--Recieves server
		if command == "ACCEPTED" then
			--Check if the player was invited
			if shareSystem.shareClients[fromPlayerName] then
				--Creating empty client data model
				shareSystem.shareClients[fromPlayerName] = {status = "connected", lastUpdateTime = GetTime(),
					guideState = {stepStates = {}}
				}
				DGV.UpdateServerShareVisualization()
				--Sending connection confirmation to the client that has just accepted the invitation
				DGV:SendAddonMessage("CONNECTED", fromPlayerName)

				print("Player", Highlight(fromPlayerName), "has accepted your share invitation.|r")

				DGV.MarkClientAsOnline(fromPlayerName) 

				--Synchronizing the current Guide
				DGV.SendCurrentGuideTitleToClients()

				--Synchronizing the last waypoint:
				local last = DugisArrowGlobal.waypoints and DugisArrowGlobal.waypoints[#DugisArrowGlobal.waypoints]
				if last then
					DGV.SendDataToClients("SWI", {last.map, last.floor, last.x, last.y, guideIndex, isWTag, questId, true, last.desc}, 9)	
				end
			end
			DugisGuideViewer:UpdateIconStatus()
			return
		end


		----Controlling/game commands----
		--Recieves server
		if command == "DECLINE" then
			if shareSystem.shareClients[fromPlayerName] then
				shareSystem.shareClients[fromPlayerName] = {status = "declined", lastUpdateTime = GetTime()}
				DGV.UpdateServerShareVisualization()
				print("Player", Highlight(fromPlayerName), "has declined your share invitation.|r")
			end
			DugisGuideViewer:UpdateIconStatus()
			return
		end
		
		local server = shareSystem.shareServer

		--Recieves client
		if server and fromPlayerName == server.playername 
		and (server.status == "connected" or server.status == "offline") then
			
			--Recieves client
			if command == "SWI" then
				local mapID, mapFloor, x, y, guideIndex, isWTag, questId, forceCalculation, desc = unpack(params)

				if DugisArrowGlobal.SetWaypointInfo then
					DugisArrowGlobal.SetWaypointInfo(tonumber(mapID), tonumber(mapFloor), 
					tonumber(x), tonumber(y), desc, tonumber(guideIndex), 
					isWTag == "true", tonumber(questId), forceCalculation == "true")
				end
			end
			
			--Recieves client
			if command == "RAW" then
				if DGV.RemoveAllWaypoints then
					DGV:RemoveAllWaypoints()	
				end
			end

			--Recieves client
			if command == "SERVER_ONLINE" then
				DGV.MarkServerAsOnline() 
				local currentTitle 
				if DugisGuideViewer:IsGoldMode() then
					currentTitle = CurrentTitle
				end
				DGV.SendDataToServer("CLIENT_RECEIVED_SERVER_ONLINE", {currentTitle}, 1)
			end	



			--Recieves client
			--Once some commend should be confirmed this message shuld be used
			if command == "CONFIRMATION" then
				DGV.MarkServerAsOnline()
			end	

		end
		

		local client = shareSystem.shareClients and shareSystem.shareClients[fromPlayerName] 
		--Recieves sever
		if client and (client.status == "connected" or client.status == "offline") then
			
			--Recieves sever
			--New Guide Step State
			if command == "NGSS" then
				local  index, newState = unpack(params)
				index = tonumber(index)

				client.guideState = client.guideState or {}
				client.guideState.stepStates = client.guideState.stepStates or {}

				client.guideState.stepStates[index] = newState

				local players = shareSystem.notCompletedPlayers[index]

				if newState == "C" and players and players[fromPlayerName] then
					--Try to check this quide step in case it was already completed by the server.
					DGV:SetChkToComplete(index) 
				end

				DGV.MarkClientAsOnline(fromPlayerName) 

				if DGV.MarkForUpdate then
					DGV:MarkForUpdate(index)
				end

				if DGV.UpdateGuideVisualRows then
					LuaUtils:NamedDelay("UpdateGuideVisualRows", 2, function()
						DGV.UpdateGuideVisualRows()
						if DGV.UpdateSmallFrame then
							DGV:UpdateSmallFrame(nil, true)
						end
						DGV:MoveToNextQuest()
					end)
				end
				
			end			

			--Recieves sever
			--New Guide Step Index
			if command == "NGSI" or command == "NGSI-TERMINAL" then
			  if DGV.MoveToNextQuest then
				local currentTitle, currentStepIndex = unpack(params)
				local clientData = shareSystem.shareClients[fromPlayerName]

				clientData.guideState = clientData.guideState or {}

				clientData.guideState.currentStepIndex = tonumber(currentStepIndex)

				if clientData.guideState.currentTitle ~= currentTitle then
					--print("Player ", fromPlayerName, " changed the guide to:")
				end

				clientData.guideState.currentTitle = currentTitle

				--Infinite loop prevention
				if command ~= "NGSI-TERMINAL" then
					DGV:MoveToNextQuest()
				end
				
				if DGV.UpdateGuideVisualRows then
					DGV.UpdateGuideVisualRows()
				end

				DGV.MarkClientAsOnline(fromPlayerName) 
			  end
			end		
	
			--Recieves sever - needed for cases when client is in essential mode or doesn't have installed the same guide.
			--Quest State Info. 
			if command == "QSI" then
				
				local questId, stepIndex, accepted, completed, turnedIn = unpack(params)

				questId = tonumber(questId)
				accepted = accepted == "true"
				completed = completed == "true"
				turnedIn = turnedIn == "true"

				stepIndex = tonumber(stepIndex)

				client.guideState = client.guideState or {}

				---MISSING GUIDE MODE---
				if not client.guideState.hasGuide then
					client.guideState.questStates = client.guideState.questStates or {}

					--{[questId1]={[A]=true, [C]=true, [T]=true,}, [questId2]={ [A]=true, [C]=true, [T]=false}}
					local questStates = client.guideState.questStates
					
					local questState = questStates[questId]

					if not questState then 
						questState = {}
						questStates[questId] = questState
					end

					local someChange = 
					questState.A ~= accepted or 
					questState.C ~= completed or
					questState.T ~= turnedIn 

					questState.A = accepted 
					questState.C = completed
					questState.T = turnedIn 	
					
					if someChange then
						--Serching for all not completed step indices relted to the client that sent QSI.
						for index, players in pairs(shareSystem.notCompletedPlayers) do
							if players[fromPlayerName] then
								DGV:SetChkToComplete(index) 
								DGV:MarkForUpdate(index)
							end
						end
					
						DGV.MarkClientAsOnline(fromPlayerName) 

						if DGV.UpdateGuideVisualRows then
							DGV.UpdateGuideVisualRows()
						end

						if DGV.UpdateSmallFrame then
							DGV:UpdateSmallFrame(nil, true)
						end

						DGV:MoveToNextQuest()
					end

				end
			end		
					
			DGV.MarkClientAsOnline(fromPlayerName) 

			--Recieves sever
			--In case the client doesn't have installed the guide
			if command == "NO_SUCH_GUIDE" then
				local clientData = shareSystem.shareClients[fromPlayerName]
				if not clientData then
					return
				end

				---MISSING GUIDE MODE---
				clientData.guideState.hasGuide = false

				local title, isGoldMode = unpack(params)

				if isGoldMode == "true" then
					print("Player", Highlight(fromPlayerName), "doesn't have installed the following guide:", Highlight(title))
				else
					print("Player", Highlight(fromPlayerName), "doesn't have Full guide mode enabled. The Share Guide functionality will be limited.")
				end
			end			

			--Recieves sever
			if command == "NEW_CLIENT_MODE" then
				shareSystem.lastSentTitle = nil
				DGV.SendCurrentGuideTitleToClients(true)
			end	

			--Recieves sever
			if command == "CLIENT_ONLINE" then
				DGV:SendAddonMessage("CONFIRMATION", fromPlayerName)
				local clientCurrentTitle = params[1]
				DGV.SendCurrentGuideTitleToClients(clientCurrentTitle ~= CurrentTitle)
			end	

			--Recieves sever
			if command == "CLIENT_RECEIVED_SERVER_ONLINE" then
				local clientCurrentTitle = params[1]
				DGV.SendCurrentGuideTitleToClients(clientCurrentTitle ~= CurrentTitle)
			end	

			--Recieves sever
			--Once some commend should be confirmed this message shuld be used
			if command == "CONFIRMATION" then
			end				

		end

		--Recieves client
		if shareSystem.shareServer and shareSystem.shareServer.status == "connected" then
			local shareServer = shareSystem.shareServer
			shareServer.guideState = shareServer.guideState or {}

			--Recieves client
			--New Guide Title
			if command == "NGT" then
			   LuaUtils:invokeWhen(function()
			   	return not LuaUtils.DugiGuidesIsLoading
			   end, function()
				local  newGuideTitle, formattedTitle = unpack(params)
				

				if DGV:isValidGuide(newGuideTitle) and DugisGuideViewer:IsGoldMode() then
					if shareServer.guideState.currentTitle ~= newGuideTitle then
						shareServer.guideState.currentTitle = newGuideTitle
						print("Server has changed the guide to:", Highlight(formattedTitle))
						
						DGV:DisplayViewTabInThread(newGuideTitle)
						LuaUtils:Delay(3, function()
							DGV.SendDataToServer("NGSI")
						end)
					end
				else
					--For this case NGT should be sent only in case on the server was guide changed indeed (not mupltiple times)
					shareSystem.shareServer.trackedQuests = {}

					if DugisGuideViewer:IsGoldMode()  then
						print("Player", Highlight(fromPlayerName), "wants to share with you the", Highlight(formattedTitle), "guide but you don't have it installed.")
					else
						print("Player", Highlight(fromPlayerName), "wants to share with you the", Highlight(formattedTitle), "guide but you are in the Essential mode. Please switch to Full guide mode in order to have guide sharing fully supported. ")
					end
					DGV.SendDataToServer("NO_SUCH_GUIDE", {formattedTitle, DugisGuideViewer:IsGoldMode()}, 2)
				end

			  end)
			end	
			
			--Recieves client
			--Quest State Info Request. 
			--Needed for essential client or client with missing guide
			--Server needs information about current quest state 
			if command == "QSI_REQUEST" then
				local  questId, stepIndex = unpack(params)
				questId = tonumber(questId)

				DGV.SendQuestInfoToTheServer(questId, stepIndex)
			end

			--Recieves client
			--New guide step index on the server side
			if command == "NGSI-SV" then
				local  currentStepIndex = unpack(params)
				local old = shareServer.currentStepIndex_serverSide 
				shareServer.currentStepIndex_serverSide = currentStepIndex

		
				DGV.MarkServerAsOnline()

				if DGV.MoveToNextQuest then
					DGV:MoveToNextQuest(nil, nil, nil, nil, true)
				end

				if DGV.UpdateGuideVisualRows then
					DGV.UpdateGuideVisualRows()
				end

			end
			
		end
	end 

	function DGV.SendQuestInfoToTheServer(questId, stepIndex)
		local accepted = DugisGuideViewer:IsQuestAccepted(questId)
		local completed = DugisGuideViewer:IsQuestCompleted(questId)
		local turnedIn =  DugisGuideViewer:IsQuestTurnedIn(questId)
		
		--In this table is information about all quests for which should be reported changes to the server.
		shareSystem.shareServer.trackedQuests = shareSystem.shareServer.trackedQuests or {}
		shareSystem.shareServer.trackedQuests[questId] = stepIndex
		
		DGV.SendDataToServer("QSI", {questId, stepIndex, accepted, completed, turnedIn}, 5)
	end

	--paramsAmount is needed because once there is a nil value in the lua table then the # operator might return incorrect value 
	--command + params - maximum length about 240 characters
	function DGV.SendInitialData(command, params, paramsAmount)
		----Special commands like CONNECT, ACCEPTED etc----

		--Sending to client
		if command == "CONNECT" then
			if not shareSystem.shareClients[params[1]] then
				DGV:SendAddonMessage(command, params[1])
				shareSystem.shareClients[params[1]] = {status="invited", lastUpdateTime = GetTime()}

				print("You have sent a Guide Sharing invitation to",  Highlight(params[1]), ". Please wait for the acceptance.")
			end
			DGV.UpdateServerShareVisualization()

			--3.5 seconds waiting for response.
			local timeout = 3.5
			LuaUtils:Delay(timeout, function()
				DGV.RemoveOfflinePlayer(timeout, params[1])
			end)
			return
		end

		--Sending to server
		if command == "ACCEPTED" then
			DGV:SendAddonMessage(command, params[1])
			return
		end	

		--Sending to server
		if command == "DECLINE" then
			DGV:SendAddonMessage(command, params[1])
			return
		end	

		--Sending to server
		if command == "DISCONNECT_BY_CLIENT" then
			DGV:SendAddonMessage(command, params[1])
			return
		end	

		--Sending to client
		if command == "DISCONNECT_BY_SERVER" then
			if shareSystem.shareClients[params[1]] then
				DGV:SendAddonMessage(command, params[1])
			end
			return
		end		

		----Controlling/game commands----
		for playername, shareClient in pairs(shareSystem.shareClients) do 
			if shareClient.status == "connected" then
				params = params or {}

				local name, realm = UnitName("player")
				if name == playername then
					return
				end

				for i = 1, paramsAmount or 0 do
					if params[i] == nil then
						params[i] = "nil"
					end
					params[i] = string.gsub(tostring(params[i]), ":", "COLON")
				end

				local messageToSend = command..":"..table.concat(params, ":")

				DGV:SendAddonMessage(messageToSend, playername)
			end
		end
	end

	function DGV.SendDataToClient(shareClient, playername, command, params, paramsAmount, processFunction)
		params = params or {}
		paramsAmount = paramsAmount or 0
		
		if shareClient.status == "connected" or (command == "SERVER_ONLINE") then
			params = params or {}

			if command == "NGSI-SV" then
				paramsAmount = 1
				params[1] = DugisGuideUser.CurrentQuestIndex
			end

			local shouldSend = true
			if processFunction then
				shouldSend = processFunction(shareClient, unpack(params))
			end

			if shouldSend then
				for i = 1, paramsAmount or 0 do
					if params[i] == nil then
						params[i] = "nil"
					end
					params[i] = string.gsub(tostring(params[i]), ":", "COLON")
				end

				local messageToSend = command..":"..table.concat(params, ":")

				DGV:SendAddonMessage(messageToSend, playername)
			end
		end
	end

	--If the processFunction function return false it will not send the command. 
	function DGV.SendDataToClients(command, params, paramsAmount, processFunction)
	  if shareSystem.shareClients then
		for playername, shareClient in pairs(shareSystem.shareClients) do 
			DGV.SendDataToClient(shareClient, playername, command, params, paramsAmount, processFunction)
		end
	 end
	end

	function DGV.SendNewModelToClients(modelId, displayId, modelName)
		LuaUtils:invokeWhen(function()
			return not LuaUtils.DugiGuidesIsLoading and DGV.GetFormattedTitle ~= nil
		end, function()		
			--Recieves essential client
			--Server changed the current models (clear command)
			if command == "NEW_MODELS" then
				shareSystem.shareServer.models = {}
			end
	--[[ 		local  modelId, displayId, modelName = unpack(params)
			modelId = tonumber(modelId)
			displayId = tonumber(displayId)	 ]]
			if DGV.IsPlayerShareServer() then
				DGV.SendDataToClients("NEW_MODEL", {modelId, displayId, modelName}, 3)
			end
		end)
	end


	function DGV.SendCurrentGuideTitleToClients(forceUpdate)
	  LuaUtils:invokeWhen(function()
	  	return not LuaUtils.DugiGuidesIsLoading and DGV.GetFormattedTitle ~= nil
	  end, function()

		local changedTitle = CurrentTitle ~= shareSystem.lastSentTitle 
		shareSystem.lastSentTitle  = CurrentTitle

		if DGV.IsPlayerShareServer() then
			DGV.SendDataToClients("NGT", {CurrentTitle, DGV:GetFormattedTitle(CurrentTitle)}, 2, function(client, newTitle)
				if client.guideState and 
				(client.guideState.currentTitle == newTitle or 
				---MISSING GUIDE MODE---
				(changedTitle == false and client.guideState.hasGuide == false)) then
					
					if not forceUpdate then
						return false
					end
				end

				--Resseting info about accepted/ready to turn in/completed quests
				client.guideState.questStates = {}

				---MISSING GUIDE MODE---
				client.guideState.hasGuide = true
				return true
			end)
		end
	  end)
	end

	function DGV.SendDataToServer(command, params, paramsAmount)
		params = params or {}
		paramsAmount = paramsAmount or 0

		local shareServer = shareSystem.shareServer
		if shareServer and shareServer.playername and (shareServer.status == "connected" or command == "CLIENT_ONLINE") then

			params = params or {}

			for i = 1, paramsAmount or 0 do
				if params[i] == nil then
					params[i] = "nil"
				end

				if type(params[i]) == "boolean" then
					params[i] = (params[i] and "true") or "false"
				end

				params[i] = string.gsub(tostring(params[i]), ":", "COLON")
			end

			--Sending to server
			if command == "NGSS" then
				local guideIndex, newState = unpack(params)

				shareServer.guideState = shareServer.guideState or {}
				shareServer.guideState.stepStates = shareServer.guideState.stepStates or {}

				--Checking if the server already has updated information
				if shareServer.guideState.stepStates[guideIndex] == newState  then
					--Skipping - the data is already sent to the server
					return
				end

				shareServer.guideState.stepStates[guideIndex] = newState
			end

			--Sending to server
			if command == "NGSI" or command == "NGSI-TERMINAL" then
				local currentTitle 
				if DugisGuideViewer:IsGoldMode() then
					currentTitle = CurrentTitle
				end
				shareServer.guideState = shareServer.guideState or {}

				if shareServer.guideState.currentTitle == currentTitle and 
				shareServer.guideState.currentStepIndex == DugisGuideUser.CurrentQuestIndex   then
					return
				end

				if type(DugisGuideUser.CurrentQuestIndex) == "boolean" then
					DugisGuideUser.CurrentQuestIndex = 1
				end
				params = {currentTitle or "nil", DugisGuideUser.CurrentQuestIndex or "nil"}
				shareServer.guideState.currentTitle = currentTitle
				shareServer.guideState.currentStepIndex = DugisGuideUser.CurrentQuestIndex
			end

			local messageToSend = command..":"..table.concat(params, ":")

			DGV:SendAddonMessage(messageToSend, shareServer.playername)
		end
	end


	-------------------
	----Server side----
	-------------------

	local myClientsFrame
	function DGV.UpdateServerShareVisualization()
		if DGV.sharesSettingsParentFrame  then
			DGV:UpdateSharesInSettings(DGV.sharesSettingsParentFrame)
		end
		DugisGuideViewer:UpdateIconStatus()
	end

	function DGV.SendShareInvitation(playerName)

		--Checking the maximum amount of invited players
		if DGV.CountAllClients() >= maximumShareGuideClients then
			print("You cannot invite more than", Highlight(maximumShareGuideClients), "other players to the Guide Sharing.")
			return
		end

		local myRealm = GetRealmName("player")
		myRealm = myRealm:gsub("%s+", "")

		local playerRealm = DGV.GetCharacterRealm(playerName)

		if playerRealm then
			playerRealm = playerRealm:gsub("%s+", "")
		end
		
		if playerRealm ~= myRealm and not UnitInParty(playerName) and playerRealm ~= "" and playerRealm then
			print(Highlight(playerName), "is in another realm. To share the guide you need to be in the party/raid.")
			return
		end


		--If the player is connected to some server then first disconnect as the player cannot be connected 
		--to the server and control some other client at the same time
		DGV.DisconnectFromServer()

		local clientPlayerName = playerName
		if not clientPlayerName then
			return
		end
		DGV.SendInitialData("CONNECT", {clientPlayerName}, 1)

		if not UnitInParty(clientPlayerName) then
			InviteUnit(clientPlayerName)
		end
	end

	function DGV.CleanAllPastDeclinedInvitations()
		for playername, shareClient in pairs(shareSystem.shareClients) do 
			if shareClient.status == "declined" then
				shareSystem.shareClients[playername] = nil
			end
		end
		DGV.UpdateServerShareVisualization()
	end

	function DGV.CountAllClients()
		local count = 0
		if shareSystem.shareClients then
			for playername, shareClient in pairs(shareSystem.shareClients) do 
				count = count + 1
			end
		end
		return count 
	end

	function DGV.RemoveOfflinePlayer(timeout, playerName)
		local shareClient = shareSystem.shareClients[playerName] 
		if shareClient and shareClient.status == "invited" and (GetTime() - shareClient.lastUpdateTime) > (timeout - 0.2) then
			shareSystem.shareClients[playerName] = nil
			print("Player",  Highlight(playerName), "doesn't have Dugi Addon installed or is offline.", Highlight("Please try again later."))
		end
		DGV.UpdateServerShareVisualization()
	end

	--Returns true in case at least one client has status "connected"
	function DGV.IsPlayerShareServer()
		if not shareSystem.shareClients then return end
		for playername, shareClient in pairs(shareSystem.shareClients) do 
			if shareClient.status == "connected" then
				return true
			end
		end
	end	

	function DGV.DisconnectClient(clientPlayerName)
		if shareSystem.shareClients[clientPlayerName] then
			DGV.SendInitialData("DISCONNECT_BY_SERVER", {clientPlayerName}, 1)
		end

		shareSystem.shareClients[clientPlayerName] = nil
		DGV.OnClientDisconnected(clientPlayerName)

		DGV.UpdateServerShareVisualization()
		if DGV.UpdateGuideVisualRows then 
			DGV.UpdateGuideVisualRows()
		end
	end	

	function DGV.OnClientDisconnected(clientPlayerName)
		local stepsToUpdate = {}
		for index, players in pairs(shareSystem.notCompletedPlayers) do
			if players[clientPlayerName] then
				stepsToUpdate[#stepsToUpdate + 1] = index
			end
			players[clientPlayerName] = nil
		end

		--In case client disconnected we want to try to go further with steps on the server
		--as there is no point to wait for the disconnected client anymore
		for _, index in pairs(stepsToUpdate) do
			DGV:SetChkToComplete(index) 
		end
	end

	function DGV.DisconnectAllClients()
		if shareSystem.shareClients then
			for playername in pairs(shareSystem.shareClients) do
				DGV.DisconnectClient(playername)
			end
		end		
	end	


	function DGV.MarkClientAsOnline(playerName) 
		local client = shareSystem.shareClients[playerName]
		if client and client.status == "offline" then
			client.status = "connected"
			DGV.UpdateServerShareVisualization()
		end
		DugisGuideViewer:UpdateIconStatus()
	end	

	-------------------
	----Client side----
	-------------------



	function DGV.AcceptShareInvitation()
		local serverPlayerName = shareSystem.shareServer and shareSystem.shareServer.playername
		if serverPlayerName then
			DGV.DisconnectAllClients()
			DGV.SendInitialData("ACCEPTED", {serverPlayerName}, 1)
		end
	end

	function DGV.DeclineShareInvitation()
		local serverPlayerName = shareSystem.shareServer and shareSystem.shareServer.playername
		if serverPlayerName then
			DGV.SendInitialData("DECLINE", {serverPlayerName}, 1)
		end
	end

	function DGV.IsPlayerShareClient()
		return shareSystem.shareServer and shareSystem.shareServer.status == "connected"
	end

	function DGV.DisconnectFromServer() 
		local serverPlayerName = shareSystem.shareServer and shareSystem.shareServer.playername
		if serverPlayerName then
			DGV.SendInitialData("DISCONNECT_BY_CLIENT", {serverPlayerName}, 1)
			print("You are not connected to",  Highlight(serverPlayerName), "any more.")
		end

		shareSystem.shareServer = GetInitialServerData()
		DugisGuideViewer:UpdateIconStatus()
	end

	function DGV.MarkServerAsOnline() 
		if shareSystem.shareServer and shareSystem.shareServer.status == "offline" then
			shareSystem.shareServer.status = "connected"
			DugisGuideViewer:UpdateIconStatus()
		end
	end		

	function DGV.MarkServerAsOffline() 
		if shareSystem.shareServer and shareSystem.shareServer.status == "connected" then
			shareSystem.shareServer.status = "offline"
			DugisGuideViewer:UpdateIconStatus()
		end
	end		

	--Checks if server has completed given step. 
	--If not in sharing mode this function returns true.	
	function DGV.IsStepCompletedByServer(index)
		index = tonumber(index)
		if index and DGV.IsPlayerShareClient() then 
			local val = tonumber(shareSystem and shareSystem.shareServer and shareSystem.shareServer.currentStepIndex_serverSide)
			if val then
				return index <= val
			end
		end

		return true
	end

	DGV.CleanAllPastDeclinedInvitations()


	--------------
	------Shared------
	--------------
	function DGV.OnPlayerOffline(playerName) 
		--Client
		local client = shareSystem.shareClients and shareSystem.shareClients[playerName]
		if client and client.status == "connected" then
			client.status = "offline"
			DGV.UpdateServerShareVisualization()
			DugisGuideViewer:UpdateIconStatus()
		end

		--Server
		local server = shareSystem.shareServer
		if server and server.status == "connected" and server.playername ==  playerName then
			server.status = "offline"
			DugisGuideViewer:UpdateIconStatus()
		end
	end

	function DGV.CountRemainingPlayers(questStepIndex)
	
		local players = shareSystem.notCompletedPlayers[questStepIndex]
		local result = 0
		if players then
			for k, v in pairs(players) do
				result = result + 1
			end
		end
		return result
	end


	--------------
	------UI------
	--------------
	function DGV:UpdateTargetNameInEditBox()
		if UnitName("target") and UnitPlayerControlled("target") and DGV.inviteToShareEditBox then
			local guid = UnitGUID("target");
			--Checking if the target is a player, not for example Pet.
			if guid:sub(1,6) == "Player" then
				local playerName, realmName = UnitName("target")
				DGV.UpdateCharacterRealm(playerName, realmName)
				DGV.inviteToShareEditBox:SetText(playerName)
				DGV.SetRealmNameByCache(playerName)
			end
		end
	end

	function DGV:UpdateSharesInSettings(parentFrame)
		local clientNames = {} 
		local index = 1
		local playersDistance = 25
		if shareSystem.shareClients then
			DGV.shareClientControls = DGV.shareClientControls or {}
			
			for playername, shareClient in pairs(shareSystem.shareClients) do 
				clientNames[#clientNames + 1] = playername
				local shareClientControl = DGV.shareClientControls[index]
				if not shareClientControl then
					shareClientControl = CreateFrame("Frame", nil, parentFrame, "GuideSharingClientItemTemplate")
				end

				shareClientControl.PlayerName:SetText(playername)
				shareClientControl.PlayerName:Show()

				shareClientControl.Status:SetText(shareClient.status)
		

				if shareClient.status == "invited" or shareClient.status == "received-invitation"   then
					shareClientControl.Status:SetText("invited")
					shareClientControl.Status:SetTextColor(1, 1, 1)
					shareClientControl.Disconnect_Cancel:SetText("Cancel")
					shareClientControl.Disconnect_Cancel:SetWidth(70)
					shareClientControl.Disconnect_Cancel:SetScript("OnClick", function()
						DGV.DisconnectClient(playername)
						DGV.UpdateServerShareVisualization()
					end)
				end

				if shareClient.status == "connected" or shareClient.status == "offline" then
					shareClientControl.Status:SetTextColor(0.415, 0.658, 0.309)

					if shareClient.status == "connected" then
						shareClientControl.Status:SetTextColor(0.415, 0.658, 0.309)
					end

					if shareClient.status == "offline" then
						shareClientControl.Status:SetTextColor(0.4, 0.4, 0.4)
					end

					shareClientControl.Disconnect_Cancel:SetText("Disconnect")
					shareClientControl.Disconnect_Cancel:SetWidth(90)
					shareClientControl.Disconnect_Cancel:SetScript("OnClick", function()
						DGV.DisconnectClient(playername)
						DGV.UpdateServerShareVisualization()
					end)
				end
				
				if shareClient.status == "declined" then
					shareClientControl.Status:SetTextColor(0.5, 0.5, 0.5)
					shareClientControl.Disconnect_Cancel:SetText("Hide")
					shareClientControl.Disconnect_Cancel:SetWidth(60)

					shareClientControl.Disconnect_Cancel:SetScript("OnClick", function()
						shareSystem.shareClients[playername] = nil
						DGV.UpdateServerShareVisualization()
					end)					
				end

				shareClientControl.Status:Show()
				shareClientControl:Show()	
				
				local dY = -playersDistance * (index-1)
				shareClientControl:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -120 + dY)				

				DGV.shareClientControls[index] = shareClientControl
				index = index + 1
			end	

			for i = index, #DGV.shareClientControls do 
				DGV.shareClientControls[i]:Hide()
			end
		end

		--Adding edit box, invite button and descriptio ntext
		local placeholderText = "Player name"
		local realmPlaceholderText = "Realm name"
		if not DGV.inviteToShareEditBox then
			DGV.inviteToShareEditBox = CreateFrame("EditBox", nil,  parentFrame, "InputBoxTemplate")
			DGV.inviteToShareEditBox:SetText(placeholderText)

			DGV.playerRealmEditBox = CreateFrame("EditBox", nil,  parentFrame, "InputBoxTemplate")
			DGV.playerRealmEditBox:SetText(realmPlaceholderText)

			DGV.inviteButton = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
			DGV.descriptionText = parentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal") 
			DGV.descriptionText:SetTextColor(1, 1, 1)
			DGV.descriptionText:SetText("This feature will allow you to share your guide with other Dugi Addon users. Invited\nplayers will receive the guide leader's automatic / manual waypoints and sync guides\ntogether if you're using the same guide")
			DGV.descriptionText:SetJustifyH("LEFT")
			DGV.descriptionText:Show()
			DGV.descriptionText:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -44)    
		end

		local dY = 0
		if index > 1 then
			dY = -20
		end

		local textBox = DGV.inviteToShareEditBox

		for k, editBox in pairs({DGV.playerRealmEditBox, textBox}) do
			editBox:SetMultiLine(false)
			editBox:SetSize(120, 15)
			editBox:SetAutoFocus(false)
			editBox:ClearAllPoints()
			editBox:Show()
		end

		textBox:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 25, -playersDistance * index - 90 + dY)
		DGV.playerRealmEditBox:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 155, -playersDistance * index - 90 + dY)
			

		DGV.inviteButton:Show()
		DGV.inviteButton:ClearAllPoints()
		DGV.inviteButton:SetText("Invite")
		DGV.inviteButton:SetPoint("TOPLEFT", DGV.playerRealmEditBox, "TOPRIGHT", 30, 4)
		DGV.inviteButton:SetSize(80, 21)
		DGV.inviteButton:SetScript("OnClick", function()
			if textBox:GetText() ~= placeholderText then
				DugisGuideViewer.SendShareInvitation(textBox:GetText())
				textBox:ClearFocus()
			end
		end)
		
		textBox:SetScript("OnEditFocusGained", function()
			if textBox:GetText() == placeholderText then
				textBox:SetText("")
			end
		end)
		
		textBox:SetScript("OnTextChanged", function()
			DGV.SetRealmNameByCache(textBox:GetText())
		end)

		DGV.playerRealmEditBox:SetScript("OnTextChanged", function()
			if textBox:GetText() ~= realmPlaceholderText then
				DGV.UpdateCharacterRealm(textBox:GetText(), DGV.playerRealmEditBox:GetText())
			end
		end)
		
		DGV.playerRealmEditBox:SetScript("OnEditFocusGained", function()
			if DGV.playerRealmEditBox:GetText() == realmPlaceholderText then
				DGV.playerRealmEditBox:SetText("")
			end
		end)

		DGV:UpdateTargetNameInEditBox()
	end

	function DGV:ShowInvitation(invokedByNotificationClick)
		if shareSystem.shareServer and shareSystem.shareServer.playername then
			if DGV:UserSetting(DGV_ENABLED_SHARES_NOTIFICATIONS) and not invokedByNotificationClick then
				local notificationTitle = "Guide Sharing Invitation"
				local notification =  DugisGuideViewer:GetNotificationByType("share-invitation")
				
				if notification == nil then
					notification = DugisGuideViewer:AddNotification({title = notificationTitle
					, notificationType = "share-invitation" })
					DugisGuideViewer:ShowNotifications()   
					DugisGuideViewer.RefreshMainMenu()
				end
			end

			ShareGuideInvitationFrame.Title:SetText("|cffffd200Dugi Guides Sharing|r")
			ShareGuideInvitationFrame.SubTitle:SetText("|cff11ff11"..shareSystem.shareServer.playername .."|r |cffffffffwants to share a guide with you".."|r")
			ShareGuideInvitationFrame.Accept:Show()			
			ShareGuideInvitationFrame:Show()
		end
	end

	function DGV.TryToSendQuestInfoToServer(questId)
		if not questId then
			return
		end

		local action = function()
			local shareSystem = DGV.GetShareSystem()
			if shareSystem  and DGV.IsPlayerShareClient() and shareSystem.shareServer.trackedQuests then
				local index = shareSystem.shareServer.trackedQuests[questId]
				if index then
					DGV.SendQuestInfoToTheServer(questId, index)
				end
			end 	
		end

		LuaUtils:Delay(3, action)
	end

	--We need to show the invitation again in case the player made reload or just entered the game againn.
	if shareSystem and shareSystem.shareServer and shareSystem.shareServer.status == "invited" then
		DGV.RecievedData(shareSystem.shareServer.playername, "CONNECT")
	end

	function DugisGuideViewer:OnModeButtonUpdate(self)
		if self:IsDragging() then
			local minimapX, minimapY = Minimap:GetCenter()
			local mouseX, mouseY = GetCursorPosition()
			mouseX, mouseY = mouseX / Minimap:GetEffectiveScale(), mouseY / Minimap:GetEffectiveScale()

			local mouseMinimapVector =  {x = mouseX - minimapX, y = mouseY - minimapY}
			local mouseMinimapDistance =  sqrt((mouseMinimapVector.x * mouseMinimapVector.x) + (mouseMinimapVector.y * mouseMinimapVector.y))
			
			self:ClearAllPoints()
			if mouseMinimapDistance < 100  then
				local angleRad = math.atan2(mouseMinimapVector.x, mouseMinimapVector.y) 
				local x = 80 * math.sin(angleRad) 
				local y = 80 * math.cos(angleRad) 
				self:SetPoint("CENTER", Minimap, "CENTER", x, y)
			else
				self:SetPoint("CENTER", UIParent, "TOPLEFT", mouseX, -(GetScreenHeight() - mouseY))
			end
		end
	end


end	