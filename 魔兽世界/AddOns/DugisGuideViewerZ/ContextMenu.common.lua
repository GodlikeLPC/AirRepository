local DGV = DugisGuideViewer

local CM, CMV = DGV:RegisterModule("ContextMenu", "ContextMenuVersion")
CM.essential = true

local DugisDropDown = LuaUtils.DugisDropDown
local function clickCallback(settingsId, itemInfo)
    local checked = itemInfo.checked
    
    if settingsId == DGV_AUTO_MOUNT
    or settingsId == CMV.autoEquipSetting
    or settingsId == DGV_AUTOQUESTACCEPT
    or settingsId == DGV_AUTOFLIGHTPATHSELECT
    or settingsId == DGV_ENABLED_GPS_ARROW
    or settingsId == DGV_TRAIN_SUGGESTIONS
    or settingsId == DGV_ENABLED_MAPPREVIEW
    or settingsId == DGV_NAMEPLATES_TRACKING then
        local newValue = not DugisGuideViewer:GetDB(settingsId)
    
        if settingsId == DGV_AUTOQUESTACCEPT then
            newValue = not (DugisGuideViewer:GetDB(settingsId) and DugisGuideViewer:GetDB(DGV_AUTOQUESTTURNIN))
        end
    
        DugisGuideViewer:SetDB(newValue, settingsId)
        DugisGuideViewer:UpdateAutoMountEnabled()
        
        --Updating checkbox in settings
        DugisGuideViewer.UpdateSettingsCheckbox(settingsId)
        
    end
	
	if  settingsId == DGV_NAMEPLATES_TRACKING then
		if DugisGuideViewer.NamePlate then
			DugisGuideViewer.NamePlate:UpdateActivePlatesExtras()
		end
	end

	if settingsId == CMV.autoEquipSetting then
	
		local orderedListContainer = _G["DGV_OrderedListContainer"..DGV_GAWINCRITERIACUSTOM]
	
		if not DugisGuideViewer:GetDB(CMV.autoEquipSetting) then
			CMV:DisableAutoEquip()
			
			if MainDugisMenuFrame:IsVisible() and ((DugisGuideViewer.SettingsTree or {}).localstatus or {}).selected == "Gear Set" then
				DugisGuideViewer:ForceAllSettingsTreeCategories()
			end
			
			--Saving Loot Suggestions Priorities 
			DugisGuideUser.lastDGV_DGV_GAWinCriteriaCustomValue = DugisGuideViewer.chardb[DGV_GAWINCRITERIACUSTOM].options
			
			--Remove all Loot Suggestions Priorities
			DugisGuideViewer.chardb[DGV_GAWINCRITERIACUSTOM].options = {}
			if orderedListContainer then
				DugisGuideViewer:UpdateOrderedListView(DGV_GAWINCRITERIACUSTOM, orderedListContainer:GetChildren())
			end
		else
			CMV:EnableAutoEquip()

			if MainDugisMenuFrame:IsVisible() and ((DugisGuideViewer.SettingsTree or {}).localstatus or {}).selected == "Gear Set" then
                DugisGuideViewer:ForceAllSettingsTreeCategories()
            end

			--Restoring original DGV_GAWINCRITERIACUSTOM
			if DugisGuideUser.lastDGV_DGV_GAWinCriteriaCustomValue then
				DugisGuideViewer.chardb[DGV_GAWINCRITERIACUSTOM].options = DugisGuideUser.lastDGV_DGV_GAWinCriteriaCustomValue
				if orderedListContainer then
					DugisGuideViewer:UpdateOrderedListView(DGV_GAWINCRITERIACUSTOM, orderedListContainer:GetChildren())
				end
				
				DugisGuideUser.lastDGV_DGV_GAWinCriteriaCustomValue = nil
			end
		end
	end
	
    if settingsId == DGV_AUTOQUESTACCEPT then
        DugisGuideViewer:SetDB(DugisGuideViewer:GetDB(settingsId), DGV_AUTOQUESTTURNIN)
        DugisGuideViewer.UpdateSettingsCheckbox(DGV_AUTOQUESTTURNIN)
    end
    
    if settingsId == "guide-mode" then
        if DGV.CanSwitchMode() and checked then
            DugisGuideViewer.chardb.EssentialsMode = 0
            DugisGuideViewer:TurnOn(true)
        end
    end
    
    if settingsId == "essential-mode" then
        if DGV.CanSwitchMode() and checked then
            DGV.SaveFramesPositions()

            DugisGuideViewer:TurnOnEssentials()
            DugisGuideViewer:RefreshQuestWatch()
        end
    end   
    
    if settingsId == "off-mode" then
        if DGV.CanSwitchMode() and checked then
            DugisGuideViewer.chardb.EssentialsMode = 0
            DugisGuideViewer:TurnOff(true)
        end
    end
	
    if settingsId == DGV_ENABLED_GPS_ARROW then
 		DGV:InitializeZoneMap()
    end
    
    DugisDropDown.LibDugi_UIDropDownMenu_Refresh(MainDugisMenuFrame)
end

local function HideMainMenuOnOtherDropDowns()
	local button = _G["LibDugi_DropDownList1Button1"]; 
	if button then
		local text = button:GetText()
		if text ~= "Addon" and not DugisGuideViewer.showInProgress then
			DugisGuideViewer.NotificationsHeaderParent:Hide()
			DugisGuideViewer:HideNotifications()
		end
	end
end

local function menuFrameOnHide()
    if not DugisGuideViewer.showInProgress then
        DugisGuideViewer:HideNotifications()
    end

    HideMainMenuOnOtherDropDowns()
    MainDugisMenuFrame.onHide = nil
end

function DugisGuideViewer.ShowMainMenu()

	DugisGuideViewer.showInProgress = true

    local height = DugisGuideViewer:ShowNotifications(LibDugi_DropDownList1, {dX = 8, dY = -8})

    HideMainMenuOnOtherDropDowns()
    if MainDugisMenuFrame then
        MainDugisMenuFrame.onHide = menuFrameOnHide
    end
    
    local menu = {
        {text = "Addon", isTitle = true, isNotRadio = true, notCheckable = true},
        
        {text = "Essential Mode", keepShownOnClick = true, checked = function() return select(2, DugisGuideViewer.GetPluginMode()) end, func = function(itemInfo) clickCallback("essential-mode", itemInfo)  end},
        {text = "Off Mode",       keepShownOnClick = true, checked = function() return select(3, DugisGuideViewer.GetPluginMode()) end,       func = function(itemInfo) clickCallback("off-mode", itemInfo)        end},
        
        {text = "Quick Settings", isTitle = true, isNotRadio = true, notCheckable = true},
        
        {text = "Gear Advisor", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(CMV.autoEquipSetting) end
        , func = function(itemInfo) clickCallback(CMV.autoEquipSetting, itemInfo) end},
        
        {text = "Auto Quest Accept/Turn in", isNotRadio = true, keepShownOnClick = true, checked = function() 
        return DugisGuideViewer:UserSetting(DGV_AUTOQUESTACCEPT) and DugisGuideViewer:UserSetting(DGV_AUTOQUESTTURNIN) end
        , func = function(itemInfo) clickCallback(DGV_AUTOQUESTACCEPT, itemInfo) end},
        
        {text = "Auto Select Flight Path", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_AUTOFLIGHTPATHSELECT) end
        , func = function(itemInfo) clickCallback(DGV_AUTOFLIGHTPATHSELECT, itemInfo) end},
		
		{text = "Dugi Zone Map", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_ENABLED_GPS_ARROW) end
        , func = function(itemInfo) clickCallback(DGV_ENABLED_GPS_ARROW, itemInfo) end},
        		
		{text = "Nameplates Tracking", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_NAMEPLATES_TRACKING) end
        , func = function(itemInfo) clickCallback(DGV_NAMEPLATES_TRACKING, itemInfo) end},

        {text = "More settings..", isNotRadio = true, notCheckable = true
        , disabled = function()
            return not DugisGuideViewer:GuideOn()
        end
        , func = function(itemInfo) 
            if not DugisMainBorder:IsVisible() then
                DGV:ShowSettings()
            end
            if DugisMain and DugisMain.settingsTab and DugisGuideViewer.DeselectTopTabs then
                DugisMain.settingsTab:Click()
            end
        end},      
    }

    if TrainPromptFrame then
        tinsert(menu, 10, {text = "Training Reminder", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_TRAIN_SUGGESTIONS) end
            , func = function(itemInfo) clickCallback(DGV_TRAIN_SUGGESTIONS, itemInfo) end})
    end

    if DugisGuideViewer:IsModuleRegistered("MapPreview") then
        tinsert(menu, 7, {text = "Map Preview", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_ENABLED_MAPPREVIEW) end
            , func = function(itemInfo) clickCallback(DGV_ENABLED_MAPPREVIEW, itemInfo) end})
    end

    if C_MountJournal then
        tinsert(menu, 5, {text = "Auto Mount", isNotRadio = true, keepShownOnClick = true, checked = function() return DugisGuideViewer:UserSetting(DGV_AUTO_MOUNT) end
            , func = function(itemInfo) clickCallback(DGV_AUTO_MOUNT, itemInfo) end})
    end

    if DGV.IsPlayerShareClient() then
        tinsert(menu, 4, {text = "Stop Guide Sharing", isNotRadio = true, notCheckable = true,
            keepShownOnClick = false, checked = function() return true end
            , func = function(itemInfo) DGV.DisconnectFromServer()  end})
	end

    if DGV:UserSetting(DGV_ENABLED_GUIDE_SHARING) and not DGV.IsPlayerShareClient() then
        tinsert(menu, 4, {text = "Manage Guide Sharing", isNotRadio = true, notCheckable = true,
            keepShownOnClick = false
            , func = function(itemInfo) 
                DGV:ShowSettings(DGV.GuideSharingCategoryName)
            end})
	end
    
    if DugisGuideViewer:IsModuleRegistered("Guides") then
        tinsert(menu, 2, {text = "Guide Mode",     keepShownOnClick = true, checked = function() return select(1, DugisGuideViewer.GetPluginMode()) end,     func = function(itemInfo) clickCallback("guide-mode", itemInfo)      end})
        
        menu[#menu] = 
        {
            text = "Home", isNotRadio = true, notCheckable = true
            , disabled = function()
                return not DugisGuideViewer:GuideOn() or DugisGuideViewer.chardb.EssentialsMode == 1
            end
            , func = function(itemInfo) 
                if not DugisMainBorder:IsVisible() then
                    DGV:ShowSettings()
                end
                if DugisMain and DugisMain.homeTab then
                    DugisMain.homeTab:Click()
                end
            end
        }
	end

    for _, item in pairs(menu) do
        item.dY = -height + 5
    end
    
    if not MainDugisMenuFrame then
        CreateFrame("Frame", "MainDugisMenuFrame", UIParent, "UIDropDownMenuTemplate, BackdropTemplate")
    end
    
    DugisDropDown.LibDugi_EasyMenu(menu, MainDugisMenuFrame, DugisOnOffButton, 30 , -3, "MENU", nil, {extraHeight = height - 10})
    LibDugi_DropDownList1:SetClampedToScreen(true)
    
    if LuaUtils:IsElvUIInstalled() or Tukui then
       LuaUtils:TransferBackdropFromElvUI()
    end
	
	DugisGuideViewer.showInProgress = false
end

function CM:Initialize()
end