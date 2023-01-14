local MAX_TUTORIAL_VERTICAL_TILE = 30;
local MAX_TUTORIAL_IMAGES = 3;
local MAX_TUTORIAL_KEYS = 4;
 
local TUTORIALFRAME_TOP_HEIGHT = 80;
local TUTORIALFRAME_MIDDLE_HEIGHT = 10;
local TUTORIALFRAME_BOTTOM_HEIGHT = 30;
local TUTORIALFRAME_WIDTH = 364;
 
local TUTORIAL_LAST_ID = nil;
 
local TUTORIAL_QUEST_ACCEPTED = false; -- used to trigger tutorials after closing the quest log, but after accepting a quest.
 
DUGIS_TUTORIAL_QUEST_TO_WATCH = nil;
DUGIS_TUTORIAL_DISTANCE_TO_QUEST_KILL_SQ = (50 * 50); -- the square distance to trigger the "near quest creature" tutorial.

local DISPLAY_DATA;

local TFD = {}
DugisGuideViewer.TFD = TFD

local lastFirstPossibleIndex = -1

function TFD.TutorialFrameDugisReset()
    TutorialFrameDugisState = {}
    TutorialFrameDugisState.displayedTutorials = {1}
    TutorialFrameDugisHidden = nil
    TFD.TutorialFrameDugis_NewTutorial(2, true)
    lastFirstPossibleIndex = -1
end

if TutorialFrameDugisState == nil then
    TutorialFrameDugisState = {}
    TutorialFrameDugisState.displayedTutorials = {}    
end

--/script local f = GetFirstPossibleNotSeenTutorial(); print(f)
--/script TFD.TutorialFrameDugis_NewTutorial(1, true)
--/script TryToShowTutorial1()
--/script displayedTutorials = {}

local function GetNextTutorialIndex(id)
    if id >= #DISPLAY_DATA then
        return nil
    end
    
    local newIndex = id+1
    
    local tutorialDefinition = DISPLAY_DATA[newIndex]
    
    if tutorialDefinition and tutorialDefinition.canBeDisplayed then
        if not tutorialDefinition.canBeDisplayed() then
            return GetNextTutorialIndex(newIndex)
        end        
    end
    
    return id+1
end
 
local function GetPrevTutorialIndex(id)
    if id <= 1 then
        return nil
    end
    
    local newIndex = id-1
    
    local tutorialDefinition = DISPLAY_DATA[newIndex]
    
    if tutorialDefinition and tutorialDefinition.canBeDisplayed then
        if not tutorialDefinition.canBeDisplayed() then
            return GetPrevTutorialIndex(newIndex)
        end        
    end
    
    return id-1
end 

local function GetFirstPossibleNotSeenTutorial()
    for i = 1, #DISPLAY_DATA do
        if TutorialFrameDugisState.displayedTutorials[i] == false or TutorialFrameDugisState.displayedTutorials[i] == nil then
            local tutorialDefinition = DISPLAY_DATA[i]
            if tutorialDefinition.canBeDisplayed == nil or tutorialDefinition.canBeDisplayed() then
                return i
            end
        end
    end
end

local function TryToShowTutorial1()
    local firstPossibleIndex = GetFirstPossibleNotSeenTutorial()
    
    if lastFirstPossibleIndex == nil and firstPossibleIndex then
       TutorialFrameDugis:Hide()
    end
     
    lastFirstPossibleIndex = firstPossibleIndex
    
    if TutorialFrameDugis:IsShown() then
        --tutorial already open
        
        --checking if the current tutorial can be still displayed. If not then find firts possible
        if DISPLAY_DATA[TutorialFrameDugis.id].canBeDisplayed == nil or DISPLAY_DATA[TutorialFrameDugis.id].canBeDisplayed() then
            --Updating tutorial
            TFD.TutorialFrameDugis_NewTutorial(TutorialFrameDugis.id, true)
            return
        end
    end

    
    if firstPossibleIndex ~= nil then
        TFD.TutorialFrameDugis_NewTutorial(firstPossibleIndex, true)
    else
        TutorialFrameDugis:Hide()
    end
end

C_Timer.NewTicker(2,function()
    if TutorialFrameDugisHidden ~= true then
        TryToShowTutorial1()
    end
end) 

--Hidding tutorial when it cannot be displayed anymore
C_Timer.NewTicker(0.1,function()
    if TutorialFrameDugis:IsShown() then
        if DISPLAY_DATA[TutorialFrameDugis.id].canBeDisplayed ~= nil and DISPLAY_DATA[TutorialFrameDugis.id].canBeDisplayed() == false then
            TutorialFrameDugis:Hide()
        end
    end
end)

 
local ARROW_TYPES = {
    "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight",
    "ArrowCurveUpRight", "ArrowCurveUpLeft", "ArrowCurveDownRight", "ArrowCurveDownLeft",
    "ArrowCurveRightDown", "ArrowCurveRightUp", "ArrowCurveLeftDown", "ArrowCurveLeftUp",
}
 --/script TutorialFrameDugis:Show()
 --/script TFD.TutorialFrameDugis_Update(14)
 
 --/script if i == nil then i= 0 end; i = i + 1; TutorialFrame_NewTutorial(i, true)
 --/script TFD.TutorialFrameDugis_NewTutorial(1, true)
 
 --/script TutorialFrameDugis["Arrow_" .. "LEFT" .. 1]:Show()
 --/script Tutorial_PointerUp.Anim:Play()  
 
 
local MOUSE_SIZE = { x = 76, y = 101}
 
 
CURRENT_DUGIS_TUTORIAL_QUEST_INFO = nil;


local function GetEmptyMouse()
    return [[|TInterface\TutorialFrame\UI-TUTORIAL-FRAME:16:12:0:0:512:512:79:154:218:318|t]]
end

local function GetLeftMouse()
    return [[|TInterface\TutorialFrame\UI-TUTORIAL-FRAME:16:12:0:0:512:512:0:76:218:318|t]]
end

local function GetRightMouse()
    return [[|TInterface\TutorialFrame\UI-TUTORIAL-FRAME:16:12:0:0:512:512:0:76:320:420|t]]
end

local function GetDGGold()
    return [[|TInterface\AddOns\DugisGuideViewerZ\Artwork\iconbutton:16:16:0:-3|t]]
end

local function GetDGSilver()
    return [[|TInterface\AddOns\DugisGuideViewerZ\Artwork\iconbutton_s:16:16:0:-3|t]]
end

local function GetDGCopper()
    return [[|TInterface\AddOns\DugisGuideViewerZ\Artwork\iconbutton_c:16:16:0:-3|t]]
end

local function GetGreenArrow()
    return [[|TInterface\AddOns\DugisGuideViewerZ\Artwork\UpgradeArrow:14:14:0:0|t]]
end

local function GetTargetButton()
    return [[|TInterface\Icons\Ability_Hunter_SniperShot:16:16:0:-2|t]]
end

local function GetCheckBox()
    return [[|TInterface\Buttons\UI-CheckBox-Up:14:14:0:-5|t]]
end

local function GetCross()
    return [[|TInterface\RAIDFRAME\ReadyCheck-NotReady:14:14:0:-5|t]]
end

local function GetTick()
    return [[|TInterface\Buttons\UI-CheckBox-Check:14:14:0:-5|t]]
end

local function LightBlue(text)
    return "|cFF5AD3DC"..text.."|r"
end

local function WhiteText(text)
    return "|cFFFFFFFF"..text.."|r"
end

local function getFirstVisibleAbandonButton()
    local firstVisibleButton = nil

    if QuestScrollFrame then
        for parentButton in QuestScrollFrame.headerFramePool:EnumerateActive() do
            if parentButton.abandonGroupButton and parentButton.abandonGroupButton.button:IsVisible() then
                local buttonTop = QuestMapFrame.QuestsFrame:GetTop() - parentButton.abandonGroupButton.button:GetTop()
                
                if buttonTop >= 0 and DugisGuideViewer:UserSetting(DGV_SHOWQUESTABANDONBUTTON) then
                    
                    firstVisibleButton = parentButton.abandonGroupButton.button
                end
            end
        end
    end

    return firstVisibleButton
end
 
--canBeDisplayed says if the target object (related to the Tutorial pointer) is displayed and the rutorial can be displayed
 
DISPLAY_DATA = {
    -- layers can be BACKGROUND, BORDER, ARTWORK, OVERLAY, HIGHLIGHT
    -- if you don't assign one it will default to ARTWORK
 
    [1] = { --TUTORIAL_QUESTGIVERS
            showYesButton = true,
            hidePrevButton = true,
            hideNextButton = true,
            hideCloseButton = true,
            showNoButton = true,
            anchorData = {align = "TOP", xOff = 0, yOff = -300},
            textBox = {topLeft_xOff = 33, topLeft_yOff = -200, bottomRight_xOff = -29, bottomRight_yOff = 35},
            imageData1 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\iconbutton", xOff = -100 - 20, yOff = -50},
            imageData2 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\logo", xOff = 60 - 20, width = 300, height = 300 * 0.25, yOff = -50},
			--mouseData = {image = "RightClick", xOff = 80},
            contentText = 
    [[Welcome to Dugi Guides,

Would you like run the tutorial for  using the addon for the first time?]],
			--contentTitle = "Dugi Gudes - Welcome!",        
        },    
         [2] = { --TUTORIAL_QUESTGIVERS
                tileHeight = 21, 
                width = 350,
                hidePrevButton = true,
                alignToParent = {parent = "DugisOnOffButton"},
                anchorData = {align = "LEFT", xOff = 350, yOff = 0},
                callOut = {parent = "DugisOnOffButton", align = "TOPLEFT", xOff = -10, yOff = 10, width = 54, height = 51},
                textBox = {topLeft_xOff = 33, topLeft_yOff = -200, bottomRight_xOff = -29, bottomRight_yOff = 35},
                --imageData1 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\iconbutton", align = "TOP", xOff = -70, yOff = -90},
                --mouseData = {image = "RightClick", align = "TOP", xOff = 80, yOff = -60},
                contentText = 
        [[Welcome to Dugi Guides!

To begin you can ]]..LightBlue("Right-Click ")..GetRightMouse()..[[ on the ]]..GetDGGold()..[[ icon to open the large frame menu to select your guides]],
                --contentTitle = "Dugi Gudes - Welcome!",        
            },
         [3] = { --TUTORIAL_QUESTGIVERS
                tileHeight = 21, 
                width = 350,
                alignToParent = {parent = "DugisOnOffButton"},
                anchorData = {align = "LEFT", xOff = 350, yOff = 0},
                callOut = {parent = "DugisOnOffButton", align = "TOPLEFT", xOff = -10, yOff = 10, width = 54, height = 51},
                textBox = {topLeft_xOff = 33, topLeft_yOff = -200, bottomRight_xOff = -29, bottomRight_yOff = 35},
                --imageData1 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\iconbutton", align = "TOP", xOff = -70, yOff = -90},
                --mouseData = {image = "RightClick", align = "TOP", xOff = 80, yOff = -60},
                contentText = 
        [[You can also ]]..LightBlue("Left-Click ")..GetLeftMouse()..[[ on the icon to switch to different modes

]]..GetDGGold()..[[ = Full guide mode
]]..GetDGSilver()..[[ = Essential (no guide) mode
]]..GetDGCopper()..[[ = Off mode]],
                --contentTitle = "Dugi Gudes - Welcome!",        
            },			
        [4] = { --TUTORIAL_QUESTGIVERS
        tileHeight = 21, 
        width = 350,
        --canBeDisplayed = function() return false; end,
        anchorData = {align = "LEFT", xOff = 350, yOff = 0},
        alignToParent = {parent = "DugisSmallFrame"},

        callOut = {parent = "DugisSmallFrame", align = "TOPLEFT", xOff = 0, 
        
        yOff = function()
            if DugisGuideViewer:UserSetting(DGV_ANCHOREDSMALLFRAME) then
                return 35
            else
                return 0
            end   
        end
        
        , width = function()  
        
            if DugisGuideViewer:UserSetting(DGV_ANCHOREDSMALLFRAME) then
                --/script TFD.TutorialFrameDugis_NewTutorial(1, true)
                return DugisSmallFrame:GetWidth() + 5
            else
                return DugisSmallFrame:GetWidth() + 5
            end        
        
            
        end
        , height = function()  
            --One time I got lua error  "attempt to index field 'WatchBackground' (a nil value)"
            --This condition is to prevent that error.
            if DugisGuideViewer:UserSetting(DGV_ANCHOREDSMALLFRAME) and DugisGuideViewer.Modules.DugisWatchFrame.WatchBackground then
                return DugisGuideViewer.Modules.DugisWatchFrame.WatchBackground:GetHeight()
            else
                return DugisSmallFrame:GetHeight()
            end
             
        end},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -210, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\iconbutton", align = "TOP", xOff = -70, yOff = -90},
        --mouseData = {image = "LeftClick", align = "TOP", xOff = 80, yOff = -60},
        contentText = 
[[The Small Frame is the primary step-by-step guide, it will progress automatically after you complete the step

You can also ]]..LightBlue("Right-Click ")..GetRightMouse()..[[ on the Small Frame to open the large menu]],
       -- contentTitle = "Dugi Gudes - Welcome!",        
    },
     
    [5] = { 
        tileHeight = 21, 
        width = 350,
        anchorData = {align = "LEFT", xOff = 450, yOff = 0},
        alignToParent = {parent = "DugisArrowFrame"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisArrowFrame") end,
        --  xOff = -3, yOff = 15, width = 85, height = 77
        callOut = {parent = "DugisArrowFrame", align = "TOPLEFT", yOff = 3
        ,xOff = function()
            if DugisArrowFrame.arrow:IsShown() then
                if DugisArrowGlobal.currentTexture:find("QuestionMark") ~= nil then
                    return -8
                end
            end
            if DugisArrowFrame.button:IsShown() then
                return 7
            end
            return -3
        end        
        ,yOff = function()
            if DugisArrowFrame.arrow:IsShown() then
                if DugisArrowGlobal.currentTexture:find("QuestionMark") ~= nil then
                    return 8
                end  
            end
            if DugisArrowFrame.button:IsShown() then
                return 7
            end
            return 3
        end
        ,height = function()  
            if DugisArrowFrame.arrow:IsShown() then
                if DugisArrowGlobal.currentTexture:find("Down") ~= nil then
                    return 85
                end
                if DugisArrowGlobal.currentTexture:find("stair") ~= nil then
                    return 75  
                end
                if DugisArrowGlobal.currentTexture:find("QuestionMark") ~= nil then
                    return 57
                end   
            end
            if DugisArrowFrame.button:IsShown() then
                return 67
            end
            return 65
        end
        ,width = function()  
            if DugisArrowFrame.arrow:IsShown() then
                if DugisArrowGlobal.currentTexture:find("Down") ~= nil then
                    return 65
                end
                if DugisArrowGlobal.currentTexture:find("QuestionMark") ~= nil then
                    return 57
                end
            end
            if DugisArrowFrame.button:IsShown() then
                return 67
            end            
            return 85
        end
        },
        textBox = {topLeft_xOff = 33, topLeft_yOff = -180, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\AddOns\\DugisGuideViewerZ\\Artwork\\stair", align = "TOP", xOff = -70, yOff = -20},
        contentText = [[The waypoint arrow will provide you with instructions to reach your destination

A ]]..GetGreenArrow()..[[ green waypoint arrow means you are in the questing area

]]..LightBlue("Right-Click ")..GetRightMouse()..[[ on the waypoint arrow to open the option menu for the waypoint arrow]],
        --contentTitle = "Dugi Gudes",       
    },
     
    [6] = { 
        tileHeight = 21, 
		width = 350,
        anchorData = {align = "TOP", xOff = 0, yOff = 30},
        alignToParent = {parent = "DugisGuideViewer_ModelViewer"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisGuideViewer_ModelViewer") end,
        callOut = {parent = "DugisGuideViewer_ModelViewer", align = "TOPLEFT", xOff = -3, yOff = 0, 
        width = function() 
            return DugisGuideViewer_ModelViewer:GetWidth() + 8
        end, 
        height = function() 
            return DugisGuideViewer_ModelViewer:GetHeight()
        end, 
        },
        contentText = [[The Model Viewer will display important NPC or objects that you will need to interact with to complete your current step

The Target Button ]]..GetTargetButton()..[[ will always match the NPC displayed in model viewer]],
       -- contentTitle = "Dugi Gudes",
    },
	
    [7] = { 
        tileHeight = 21, 
		width = 350,
        anchorData = {align = "LEFT", xOff = 450, yOff = 0},
        alignToParent = {parent = "DugisGuideViewer_TargetFrame"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisGuideViewer_TargetFrame") end,
        callOut = {parent = "DugisGuideViewer_TargetFrame", align = "TOPLEFT", xOff = -11, yOff = 10, width = 48, height = 46},
        contentText = LightBlue("Left-Click ")..GetLeftMouse()..[[ on the ]]..GetTargetButton()..[[ icon to automatically target and mark important NPCs for the current step

You can also keybind the Target Button by going to the WoW Key Bindings menu in the "Other" category]],
       -- contentTitle = "Dugi Gudes",
    },
    [8] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainHomeTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisMainHomeTab") end,
        callOut = {parent = "DugisMainHomeTab", align = "TOPLEFT", xOff = -18, yOff = 5, width = 156, height = 50},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[The Home tab is where you can find the main guide menu to select your guide]],
        --contentTitle = "Dugi Gudes",
    }, 		
   [9] = { 
        tileHeight = 19, 
		width = 350,
		hideNextButton = true,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainCurrentGuideTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisMainHomeTab") and not DGVCurrentGuideFrame:IsVisible() end,
        callOut = {parent = "DugisMainCurrentGuideTab", align = "TOPLEFT", xOff = -18, yOff = 5, width = 156, height = 50},
        --textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = LightBlue("Left-Click ")..GetLeftMouse()..[[ on the tab to view the Current Guide]],
        --contentTitle = "Dugi Gudes",
    }, 	 
    [10] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainCurrentGuideTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DGVCurrentGuideFrame") end,
        callOut = {parent = "DugisMainCurrentGuideTab", align = "TOPLEFT", xOff = -18, yOff = 5, width = 156, height = 50},
        --textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[The Current Guide tab displays your selected guide. Most guides will progress automatically and you ]]..WhiteText("normally don't need to modify it"),
        --contentTitle = "Dugi Gudes",
    },  
    [11] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainCurrentGuideTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DGVCurrentGuideFrame") end,
        callOut = {parent = "DugisMainCurrentGuideTab", align = "TOPLEFT", xOff = -18, yOff = 5, width = 156, height = 50},
        --textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[You can modify the current guide by...

]]..LightBlue("Left-Click ")..GetLeftMouse()..[[ on the check box to mark it as ]]..GetTick()..[[ complete

]]..LightBlue("Left-Click Twice ")..GetLeftMouse()..[[ on the check box to mark as ]]..GetCross()..[[ skipped

]]..LightBlue("Right-Click ")..GetRightMouse()..[[ on the check box to remove any mark]],
        --contentTitle = "Dugi Gudes",
    }, 
    [12] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainCurrentGuideTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DGVCurrentGuideFrame") end,
        callOut = {parent = "DugisMainCurrentGuideTab", align = "TOPLEFT", xOff = -18, yOff = 5, width = 156, height = 50},
        --textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[You can also tick multiple steps at the same time by holding ]]..LightBlue("Shift-Click ")..GetLeftMouse()..[[ on the check box.]],
        --contentTitle = "Dugi Gudes",
    }, 	    
    [13] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisResetButton"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisResetButton")  end,
        callOut = {parent = "DugisResetButton", align = "TOPLEFT", xOff = -7, yOff = 7, width = 71, height = 38},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[You can use ]]..WhiteText("Reset")..[[ button to un-tick all the steps in the Current Guide

You will need to use this button for some guides like the Daily quests guides]],
        --contentTitle = "Dugi Gudes",
    },     
    [14] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisReloadButton"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisReloadButton") end,
        callOut = {parent = "DugisReloadButton", align = "TOPLEFT", xOff = -7, yOff = 7, width = 81, height = 38},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[The ]]..WhiteText("Reload")..[[ button will automatically detect and completed steps and tick them

You should use this after clicking the ]]..WhiteText("Reset")..[[ button]],
        --contentTitle = "Dugi Gudes",
    },
    [15] = { 
        tileHeight = 19, 
		width = 350,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "CurrentGuideExpandButton"},
        canBeDisplayed = function() return CurrentGuideExpandButton and CurrentGuideExpandButton:IsVisible() end,
        --callOut = {parent = "CurrentGuideExpandButton", align = "RIGHT", xOff = -7, yOff = 7, width = 81, height = 38},
		callOut = {parent = "CurrentGuideExpandButton", align = "TOPLEFT", xOff = -6, yOff = 3, width = 42, height = 38},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = [[You can click on this button to expand the current guide view]],
        --contentTitle = "Dugi Gudes",
    },		
    [16] = { 
        tileHeight = 19, 
		width = 350,
		hideNextButton = true,
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DugisMainSettingsTab"},
        canBeDisplayed = function() return LuaUtils.IsFrameVisible("DugisMainSettingsTab") and not (DugisGuideViewer.currentTabText == "Settings") end,
        callOut = {parent = "DugisMainSettingsTab", align = "TOPLEFT", xOff = -8, yOff = 6, width = 46, height = 43},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        --imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        --mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText =  LightBlue("Left-Click ")..GetLeftMouse()..[[ here to view the Settings menu]],
        --contentTitle = "Dugi Gudes",
    },         
    [17] = { --TUTORIAL_QUESTGIVERS
        tileHeight = 21, 
        width = 350,
        alignToParent = {parent = function()
            return getFirstVisibleAbandonButton()
        end},
        anchorData = {align = "LEFT", xOff = 350, yOff = 0},
        callOut = {parent = function()
            return getFirstVisibleAbandonButton()
        end, align = "TOPLEFT", xOff = -7, yOff = 6, width = 42, height = 38},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -200, bottomRight_xOff = -29, bottomRight_yOff = 35},
        canBeDisplayed = function()
            return getFirstVisibleAbandonButton() ~= nil
        end,
        contentText = [[This is the ]]..WhiteText("Mass Abandon")..[[ quest button. 
]]..LightBlue("Left-Click ")..GetLeftMouse()..[[ on the icon to abandon all the quests in that catergory]],
    },
--[[    [14] = { 
        tileHeight = 19, 
        anchorData = {align = "RIGHT", xOff = -250, yOff = 0},
        alignToParent = {parent = "DGV_ItemButtonScale"},
        canBeDisplayed = function() return DGV_ItemButtonScale and DGV_ItemButtonScale:IsVisible() end,
        callOut = {parent = "DGV_ItemButtonScale", align = "TOPLEFT", xOff = -18, yOff = 24, width = 183, height = 61},
        textBox = {topLeft_xOff = 33, topLeft_yOff = -145, bottomRight_xOff = -29, bottomRight_yOff = 35},
        imageData1 = {file ="Interface\\TutorialFrame\\UI-TutorialFrame-AttackCursor", align = "TOP", xOff = -60, yOff = -60},
        mouseData = {scale = 1.2, image = "LeftClick", align = "TOP", xOff = 50, yOff = -45},
        contentText = "Item Button Scale Description",
        contentTitle = "Dugi Gudes",
    }, --]]
};

local function AddText(parent, text, x, y, width, height, fontSize)
    local textBox = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    
    textBox:SetNonSpaceWrap(true)
    textBox:SetWordWrap(true)
    
    textBox:SetText(text)
    if height ~= nil then
        textBox:SetHeight(height)
    end
    textBox:SetJustifyH("LEFT")
    textBox:SetJustifyV("TOP")
    textBox:SetPoint("TOPLEFT", parent, 30, -180)
    textBox:SetPoint("TOPRIGHT", parent,-30, -180)
    textBox:SetSpacing(2)
    
    return textBox
end
 
function TFD.TutorialFrameDugis_OnLoad(self)
    TutorialFrameDugisText = AddText(TutorialFrameDugis, "text", 0, 0, 500)

    TutorialFrameDugiTexture:SetGradientAlpha("VERTICAL", 0.22, 0.19, 0, 1, 0, 0, 0, 1)
    --/script TFD.TutorialFrameDugis_NewTutorial(1, true)
    -- DugisGuideViewer:SetFrameBackdrop(TutorialFrameDugis, DugisGuideViewer.BACKGRND_PATH, [[Interface\TutorialFrame\UI-TutorialFrame-CalloutGlow]], 2, 2, 2, 2)
    TutorialFrameDugis:SetBackdrop({
         bgFile=nil,
         edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
         tile=false,
         tileSize = 50,
         edgeSize = 5,
    });
          
    TutorialFrameDugis:SetBackdropBorderColor(1,1,0,0.3)    

    self:RegisterEvent("TUTORIAL_TRIGGER");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("LEARNED_SPELL_IN_TAB"); 
 
    for i = 1, MAX_TUTORIAL_VERTICAL_TILE do
        local texture = self:CreateTexture("TutorialFrameDugisLeft"..i, "BORDER");
        texture:SetTexture("Interface\\TutorialFrame\\UI-TUTORIAL-FRAME");
        texture:SetTexCoord(0.0066406, 0.0261719, 0.856250025, 0.8675781275);
        texture:SetSize(11, 10);
        texture = self:CreateTexture("TutorialFrameDugisRight"..i, "BORDER");
        texture:SetTexture("Interface\\TutorialFrame\\UI-TUTORIAL-FRAME");
        texture:SetTexCoord(0.0066406, 0.0261719, 0.856250025, 0.8675781275);
        texture:SetSize(7, 10);
    end
    TutorialFrameDugisLeft1:SetPoint("TOPLEFT", TutorialFrameDugisTop, "BOTTOMLEFT", 6, 0);
    TutorialFrameDugisRight1:SetPoint("TOPRIGHT", TutorialFrameDugisTop, "BOTTOMRIGHT", -1, 0);
     
    for i = 1, MAX_TUTORIAL_IMAGES do
        local texture = self:CreateTexture("TutorialFrameDugisImage"..i, "ARTWORK");
    end
 
    for i = 1, MAX_TUTORIAL_KEYS do
        local texture = self:CreateTexture("TutorialFrameDugisKey"..i, "ARTWORK");
        texture:SetTexture("Interface\\TutorialFrame\\UI-TUTORIAL-FRAME");
        texture:SetTexCoord(0.0066406, 0.0261719, 0.856250025, 0.8675781275);
        texture:SetSize(76, 72);
        local keyString = self:CreateFontString("TutorialFrameDugisKeyString"..i, "ARTWORK", "GameFontNormalHugeBlack");
        keyString:SetPoint("CENTER", texture, "CENTER", 0, 10);
    end
 
    local checkbox = CreateFrame("CheckButton", "TutorialFrameCheckbox", TutorialFrameDugis, "ChatConfigCheckButtonTemplate");
    checkbox:SetPoint("BOTTOMRIGHT", TutorialFrameDugis, "BOTTOMRIGHT", -90, 32);
    TutorialFrameCheckboxText:SetText("");
    TutorialFrameCheckboxText = checkbox:CreateFontString("TEXT", "OVERLAY", "GameFontHighlightSmall")
    TutorialFrameCheckboxText:SetPoint("BOTTOMLEFT", checkbox, "BOTTOMLEFT", -20, 0)
    TutorialFrameCheckboxText:SetWidth(160)
    TutorialFrameCheckboxText:SetHeight(25)
    TutorialFrameCheckboxText:Show()
    TutorialFrameCheckboxText:SetText("Stop Tutorial");
    checkbox.tooltip = "";
    TFD.TutorialFrameDugis_ClearTextures();
end
 
function TFD.TutorialFrameDugis_OnEvent(self, event, ...)
    if ( event == "TUTORIAL_TRIGGER" ) then
    elseif ( event == "DISPLAY_SIZE_CHANGED" ) then
        TFD.TutorialFrameDugis_Update(TutorialFrameDugis.id);
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
    elseif ( event == "LEARNED_SPELL_IN_TAB" ) then
    end
end
 
function TFD.TutorialFrameDugis_OnShow(self)
    self:RegisterEvent("DISPLAY_SIZE_CHANGED");
    TFD.TutorialFrameDugis_CheckNextPrevButtons();
end
 
function TFD.TutorialFrameDugis_OnHide(self)
    self:UnregisterEvent("DISPLAY_SIZE_CHANGED");
end
 
function TFD.TutorialFrameDugis_OnKeyDown(self, key)
    local displayData = DISPLAY_DATA[ self.id ];
    if (displayData["keyData1"]) then
        local allOff = true;
        for i = 1, MAX_TUTORIAL_KEYS do
            local keyTexture = _G["TutorialFrameDugisKey"..i];
            local keyString = _G["TutorialFrameDugisKeyString"..i];
            local keyData = displayData["keyData"..i];
            if(keyTexture and keyString and keyData) then
                local key1, key2 = GetBindingKey(keyData.command);
                if (key == key1 or key == key2) then
                    if (keyData.linkedTexture) then
                        _G[keyData.linkedTexture]:Hide();
                    end
                    keyTexture:ClearAllPoints();
                    keyTexture:Hide();
                    keyString:Hide();
                end
                if (keyTexture:IsShown()) then
                    allOff = false;
                end
            end
        end
        if (allOff) then
            TFD.TutorialFrameDugis_Hide();
        end
    end
end
 
function TFD.TutorialFrameDugis_OnMouseDown(self, button)
    -- go through the mouse arrows
    local displayData = DISPLAY_DATA[ self.id ];
    local anyArrows = false;
    for i = 1, getn(ARROW_TYPES) do
        local arrowData = displayData[ ARROW_TYPES[i] ];
        local arrowTexture = _G[ "TutorialFrameDugis"..ARROW_TYPES[i] ];
        if (arrowTexture and arrowData and arrowData.command) then
            anyArrows = true;
            if (arrowTexture:IsShown() and arrowData.command == button) then
                arrowTexture:ClearAllPoints();
                arrowTexture:Hide();
                break;
            end
        end
    end
 
    local allOff = true;
    for i = 1, getn(ARROW_TYPES) do
        local arrowData = displayData[ ARROW_TYPES[i] ];
        local arrowTexture = _G[ "TutorialFrameDugis"..ARROW_TYPES[i] ];
        if (arrowData and arrowData.command and arrowTexture and arrowTexture:IsShown()) then
            allOff = false;
        end
    end
 
    if (anyArrows and allOff) then
        TFD.TutorialFrameDugis_Hide();
    end
end
 
function TFD.TutorialFrameDugis_CheckNextPrevButtons()
    if GetNextTutorialIndex(TutorialFrameDugis.id) then
        TutorialFrameDugisNextButton:Enable();
    else
        TutorialFrameDugisNextButton:Disable();
    end
    
    if GetPrevTutorialIndex(TutorialFrameDugis.id) then
        TutorialFrameDugisPrevButton:Enable();
    else
        TutorialFrameDugisPrevButton:Disable();
    end
end

--  Elements:
--    Title
--    Images
--    Text
--    Arrows
--

local function GetImagesTop()
    if TutorialFrameDugisTitle:GetText() ~= "" and TutorialFrameDugisTitle:GetText() ~= nil then
        return 60
    else
        return 10
    end
end

local function GetTextTop()
    local offset = 0
    if TFD.AreImagesVisible() then
        offset  = 140
    else
        offset  = 20
    end

    return GetImagesTop() + offset
end

local function CalculateHeight()
    return GetTextTop() + TutorialFrameDugisText:GetHeight() + 60
end

function TFD.AreImagesVisible()
    local imageVisible = _G["TutorialFrameDugisImage1"]:IsShown()
    local mouseVisible = TutorialFrameDugisMouse:IsShown()
    
    return imageVisible or mouseVisible
end
 
function TFD.TutorialFrameDugis_Update(currentTutorial)
   -- FlagTutorial(currentTutorial);
    TFD.TutorialFrameDugis_ClearTextures();
    TutorialFrameDugis.id = currentTutorial;
    
    TutorialFrameDugisState.displayedTutorials[currentTutorial] = true
 
    local displayData = DISPLAY_DATA[ currentTutorial ];
    if ( not displayData ) then
        return;
    end
 
    local _, className = UnitClass("player");
    local _, raceName  = UnitRace("player");
    className = strupper(className);
    raceName = strupper(raceName);
    if ( className == "DEATHKNIGHT") then
        raceName = "DEATHKNIGHT";
    end
     
    if ( displayData.raceRequired and not CURRENT_DUGIS_TUTORIAL_QUEST_INFO) then
        return;
    end
 
    -- setup the frame
    if (displayData.anchorData) then
        local anchorData = displayData.anchorData;
        
        local par = UIParent
        
        if anchorData.parent then
            par = _G[anchorData.parent]
        end
        TutorialFrameDugis:SetPoint( anchorData.align, par, anchorData.align, anchorData.xOff, anchorData.yOff );
    end
 
    if displayData.showYesButton then
        TutorialFrameDugis.YesButton:Show()
    else
        TutorialFrameDugis.YesButton:Hide()
    end    
    
    if displayData.showNoButton then
        TutorialFrameDugis.NoButton:Show()
    else
        TutorialFrameDugis.NoButton:Hide()
    end
    
    local height = 300
    Tutorial_PointerUp:Hide()
    Tutorial_PointerLeft:Hide()
    Tutorial_PointerDown:Hide()
    Tutorial_PointerRight:Hide() 
    
    local width = TUTORIALFRAME_WIDTH
    
    if displayData.width ~= nil then
        width = displayData.width
    end
    
    --Autoheight:
    height = 200
    
    ----------------------
    
    TutorialFrameDugisLeft1:Show();
    TutorialFrameDugisRight1:Show();
    TutorialFrameDugisOkayButton:Show();
    TutorialFrameDugisPrevButton:Show();
    TutorialFrameDugisNextButton:Show();
    TutorialFrameDugis:SetSize(width, height);


    if displayData.hideNextButton then
        TutorialFrameDugisNextButton:Hide()
    end  
    
    if displayData.hidePrevButton then
        TutorialFrameDugisPrevButton:Hide()
    end       
    
    if displayData.hideCloseButton then
        TutorialFrameDugisOkayButton:Hide()
    end   
 
    -- setup the text
    -- check for race-class specific first, then race specific, then class, then normal
    local text = _G["TUTORIAL"..currentTutorial.."_"..raceName.."_"..className];
    if ( not text ) then
        text = _G["TUTORIAL"..currentTutorial.."_"..raceName];
        if ( not text ) then
            if ( displayData.raceRequired ) then
                return;
            end
            text = _G["TUTORIAL"..currentTutorial.."_"..className];
            if ( not text ) then
                text = _G["TUTORIAL"..currentTutorial];
            end
        end
    end
    if (displayData.raidwarning) then
        RaidNotice_AddMessage(RaidWarningFrame, text, HIGHLIGHT_FONT_COLOR);
        return;
    end
     
    local displayNPC, killCreature;
    if ( CURRENT_DUGIS_TUTORIAL_QUEST_INFO ) then
        displayNPC = CURRENT_DUGIS_TUTORIAL_QUEST_INFO.displayNPC;
        killCreature = CURRENT_DUGIS_TUTORIAL_QUEST_INFO.killCreature;
    end
    if (displayData.displayNPC and displayNPC) then
        TutorialANPCModel:SetCreature(displayNPC);
        TutorialANPCModel:Show();
    elseif (displayData.killCreature and killCreature) then
        TutorialANPCModel:SetCreature(killCreature);
        TutorialANPCModel:Show();
    end
 
    if displayData.contentText then
        text = displayData.contentText
    end
    
    if displayData.contentTitle then
        title = displayData.contentTitle
    else
        title = ""
    end    
 
    if (text) then
        TutorialFrameDugisText:SetText(text);
    end
     
    if (title) then
        TutorialFrameDugisTitle:SetText(title);
    end
 
    -- setup the callout
    local callOut = displayData.callOut;
    if(callOut) then
    
        local parent = callOut.parent
        if type(parent) == "function" then
            parent = parent()
        end
    
    
        if ( callOut.align2 ) then
            local xOff = callOut.xOff2
            local yOff = callOut.yOff2
            
            TutorialFrameDugisCallOut:SetPoint( callOut.align2, parent, callOut.align2, xOff, yOff );
        else
            local w = callOut.width
            local h = callOut.height
            
            if type(w) == "function" then  w = w()  end
            if type(h) == "function" then  h = h()  end       
            
            TutorialFrameDugisCallOut:SetSize(w, h);
        end
        
        local xOff = callOut.xOff
        local yOff = callOut.yOff
        
        if type(xOff) == "function" then  xOff = xOff()  end
        if type(yOff) == "function" then  yOff = yOff()  end            
        
        TutorialFrameDugisCallOut:SetPoint( callOut.align, parent, callOut.align, xOff, yOff);
        TutorialFrameDugisCallOut:Show();
        AnimateCalloutA:Play();
    end
 
    -- setup images
    for i = 1, MAX_TUTORIAL_IMAGES do
        local imageTexture = _G["TutorialFrameDugisImage"..i];
        local imageData = displayData["imageData"..i];
        if(imageData and imageTexture) then
            imageTexture:SetTexture(imageData.file);
            local yOff = -GetImagesTop()
            if imageData.yOff then
                yOff = imageData.yOff
            end
            imageTexture:SetPoint( "TOP", TutorialFrameDugis, "TOP", imageData.xOff, yOff)
            imageTexture:Show()
            
            if imageData.width ~= nil then
                imageTexture:SetSize(imageData.width, imageData.height)
            end
        elseif( imageTexture ) then
            imageTexture:ClearAllPoints()
            imageTexture:SetTexture("")
            imageTexture:Hide()
        end
    end
 
    -- setup mouse
    local mouseData = displayData.mouseData;
    if(mouseData) then
        local mouseTexture = _G["TutorialFrameDugisMouse"..mouseData.image];
        mouseTexture:SetPoint(  "TOP", TutorialFrameDugis,  "TOP", mouseData.xOff, -GetImagesTop() );
        TutorialFrameDugisMouse:SetPoint( "TOP",  TutorialFrameDugis, "TOP", mouseData.xOff, -GetImagesTop() );
         
        local scale = 1.0;
        if ( mouseData.scale ) then
            scale = mouseData.scale;
        end
        mouseTexture:SetSize( MOUSE_SIZE.x * scale, MOUSE_SIZE.y * scale );
        TutorialFrameDugisMouse:SetSize( MOUSE_SIZE.x * scale, MOUSE_SIZE.y * scale );
        mouseTexture:Show();
        TutorialFrameDugisMouse:Show();
        AnimateMouseDugis:Play();
    end
 
 
    height = CalculateHeight()
    TutorialFrameDugis:SetSize(width, height);  
    
    
    --Updating text position
    TutorialFrameDugisText:ClearAllPoints();
    
    TutorialFrameDugisText:SetPoint("TOPLEFT", TutorialFrameDugis, 30, -GetTextTop())
    TutorialFrameDugisText:SetPoint("TOPRIGHT", TutorialFrameDugis, -30, -GetTextTop())
    
     
    -- show
    TutorialFrameDugis:Show();
    TFD.TutorialFrameDugis_CheckNextPrevButtons();
    
    if displayData.alignToParent then
    
     TutorialFrameDugis:ClearAllPoints()
        local alignToParent = displayData.alignToParent;
        
        local par = UIParent
        
        if alignToParent.parent then
            if type(alignToParent.parent) == "function" then
                par = alignToParent.parent()
            else
                par = _G[alignToParent.parent]
            end
        end
        
        local parentX = par:GetLeft()
        local parentY = par:GetTop()
        
        if parentX == nil then
            parentX = 0
        end     
        
        if parentY == nil then
            parentY = 0
        end
        
        local parentWidth = par:GetWidth()
        local parentHeight = par:GetHeight()
        local parentCenterX = parentX + parentWidth * 0.5
        local parentCenterY = parentY - parentHeight * 0.5
        local parentNX = parentCenterX / GetScreenWidth() - 0.5
        local parentNY = parentCenterY / GetScreenHeight() - 0.5
        
        local direction = "bottom"        
        
        
        if parentNY < 0 then
            direction = "top" 
        else
            direction = "bottom"
        end
        
        if parentNX < 0 and math.abs(parentNX) > math.abs(parentNY) then
            direction = "right" 
        end
        
        if parentNX > 0 and math.abs(parentNX) > math.abs(parentNY) then
            direction = "left" 
        end  
            
        
        if (displayData.alignToParent.direction) then
            direction = displayData.alignToParent:direction()
        end
        
        if direction == "right" then
            TutorialFrameDugis:SetPoint( "LEFT", par, "RIGHT", 40, 0);
            Tutorial_PointerLeft:Show()
        end
        
        if direction == "top" then
            TutorialFrameDugis:SetPoint( "BOTTOM", par, "BOTTOM", 0, 40 + par:GetHeight());
            Tutorial_PointerDown:Show()
        end        
                
        if direction == "bottom" then
           -- height = CalculateHeight()
            TutorialFrameDugis:SetPoint( "BOTTOM", par, "BOTTOM", 0, -40  -  height);
            Tutorial_PointerUp:Show()
        end        
        
        if direction == "left" then
            TutorialFrameDugis:SetPoint( "LEFT", par, "RIGHT", -40 -  TutorialFrameDugis:GetWidth() - par:GetWidth(), 0);
            Tutorial_PointerRight:Show()
        end
    end
end
 
function TFD.TutorialFrameDugis_ClearTextures()
    TutorialFrameDugis:ClearAllPoints();
    TutorialFrameDugisText:Show()
 
    TutorialANPCModel:Hide();
 
    AnimateCalloutA:Stop();
    TutorialFrameDugisCallOut:ClearAllPoints();
    TutorialFrameDugisCallOut:Hide();
     
    TutorialFrameDugisMouse:ClearAllPoints();
    TutorialFrameDugisMouseRightClick:ClearAllPoints();
    TutorialFrameDugisMouseLeftClick:ClearAllPoints();
    TutorialFrameDugisMouseBothClick:ClearAllPoints();
    TutorialFrameDugisMouseWheel:ClearAllPoints();
    TutorialFrameDugisMouse:Hide();
    TutorialFrameDugisMouseRightClick:Hide();
    TutorialFrameDugisMouseLeftClick:Hide();
    TutorialFrameDugisMouseBothClick:Hide();
    TutorialFrameDugisMouseWheel:Hide();
    
    AnimateMouseDugis:Stop();
 
    -- top & left1 & right1 never have thier anchors changed; or are independantly hidden
    for i = 2, MAX_TUTORIAL_VERTICAL_TILE do
        local leftTexture = _G["TutorialFrameDugisLeft"..i];
        local rightTexture = _G["TutorialFrameDugisRight"..i];
        leftTexture:ClearAllPoints();
        rightTexture:ClearAllPoints();
        leftTexture:Hide();
        rightTexture:Hide();
    end
 
    for i = 1, MAX_TUTORIAL_IMAGES do
        local imageTexture = _G["TutorialFrameDugisImage"..i];
        imageTexture:ClearAllPoints();
        imageTexture:SetTexture("");
        imageTexture:Hide();
    end
 
    for i = 1, MAX_TUTORIAL_KEYS do
        local keyTexture = _G["TutorialFrameDugisKey"..i];
        local keyString = _G["TutorialFrameDugisKeyString"..i];
        keyTexture:ClearAllPoints();
        keyTexture:Hide();
        keyString:Hide();
    end
     
    for i = 1, getn(ARROW_TYPES) do
        local arrowTexture = _G[ "TutorialFrameDugis"..ARROW_TYPES[i] ];
        arrowTexture:ClearAllPoints();
        arrowTexture:Hide();
    end
end
 
function TFD.TutorialFrameDugis_NewTutorial(tutorialID, forceShow)

    if not TutorialFrameCheckbox then
        return
    end

    Tutorial_PointerUp.Anim:Play() 
    Tutorial_PointerLeft.Anim:Play() 
    Tutorial_PointerDown.Anim:Play() 
    Tutorial_PointerRight.Anim:Play() 


    if tutorialID == 1 then
        TutorialFrameCheckbox:Hide() 
    else
        TutorialFrameCheckbox:Show()
    end
    
    if(forceShow) then
        TFD.TutorialFrameDugis_Update(tutorialID);
        return;
    end
     
    for index, value in pairs(TUTORIALFRAME_QUEUE) do
        if( (value == tutorialID) ) then
            return;
        end
    end
 
    TUTORIAL_LAST_ID = tutorialID;
    local button = TutorialFrameDugisAlertButton;
    if ( not TutorialFrameDugis:IsShown() ) then
        button.id = tutorialID;
        button:Show();
        UIParent_ManageFramePositions();
        if (( not TutorialFrameDugis:IsShown() and not InCombatLockdown()) or DISPLAY_DATA[tutorialID].raidwarning ) then
            TutorialFrameDugis_AlertButton_OnClick(button);
        end
    elseif ( button:IsEnabled() == 0 ) then
        button.id = tutorialID;
    end
    TFD.TutorialFrameDugis_CheckBadge();
    TutorialFrameDugis["ArrowA_" .. "RIGHT" .. 1]:Show();
    TutorialFrameDugis["ArrowA_" .. "RIGHT" .. 1].Anim:Play();    
    
end
 
function TFD.TutorialFrameDugisPrevButton_OnClick(self)
    if TutorialFrameCheckbox:GetChecked() then
        TutorialFrameDugisHidden = true
        TutorialFrameCheckbox:SetChecked(false)
        TFD.TutorialFrameDugis_Hide()
        return
    end
    
    LuaUtils:PlaySound("igMainMenuOptionCheckBoxOn");
    local prevTutorial = GetPrevTutorialIndex(TutorialFrameDugis.id);
    
    if prevTutorial then
        TFD.TutorialFrameDugis_Update(prevTutorial);
    end
end
 
function TFD.TutorialFrameDugisNextButton_OnClick(self)
    if TutorialFrameCheckbox:GetChecked() then
        TutorialFrameDugisHidden = true
        TutorialFrameCheckbox:SetChecked(false)
        TFD.TutorialFrameDugis_Hide()
        return
    end
    
    LuaUtils:PlaySound("igMainMenuOptionCheckBoxOn");
    local nextTutorial = GetNextTutorialIndex(TutorialFrameDugis.id);
    
    if nextTutorial then
        TFD.TutorialFrameDugis_Update(nextTutorial);
    end
end
 
function TFD.TutorialFrameDugis_Hide(stopTutorial)
    LuaUtils:PlaySound("igMainMenuClose");
    HideUIPanel(TutorialFrameDugis);
    
    if TutorialFrameCheckbox:GetChecked() or stopTutorial == true then
        TutorialFrameDugisHidden = true
    end
    
    TutorialFrameCheckbox:SetChecked(false)
end
 
function TFD.TutorialFrameDugis_CheckBadge()
    TutorialFrameDugisAlertButtonBadge:Hide();
    TutorialFrameDugisAlertButtonBadgeText:Hide();
end
