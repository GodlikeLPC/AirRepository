local UIDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0");


local ActionButton_OnLoad = ActionButton_OnLoad or ActionBarActionButtonMixin and ActionBarActionButtonMixin.OnLoad;
local ActionButton_Update = ActionButton_Update or ActionBarActionButtonMixin and ActionBarActionButtonMixin.Update;
local ActionButton_UpdateAction = ActionButton_UpdateAction or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateAction;
local ActionButton_UpdateHotkeys = ActionButton_UpdateHotkeys or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateHotkeys;
local ActionButton_UpdateState = ActionButton_UpdateState or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateState;
local ActionButton_UpdateUsable = ActionButton_UpdateUsable or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateUsable;
local ActionButton_UpdateCooldown = ActionButton_UpdateCooldown or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateCooldown;
local ActionButton_UpdateFlash = ActionButton_UpdateFlash or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateFlash;
local ActionButton_UpdateCount = ActionButton_UpdateCount or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateCount;
local ActionButton_UpdateFlyout = ActionButton_UpdateFlyout or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateFlyout;
local ActionButton_UpdateOverlayGlow = ActionButton_UpdateOverlayGlow or ActionBarActionButtonMixin and ActionBarActionButtonMixin.UpdateOverlayGlow;
local ActionButton_SetTooltip = ActionButton_SetTooltip or ActionBarActionButtonMixin and ActionBarActionButtonMixin.SetTooltip;
local ActionButton_StartFlash = ActionButton_StartFlash or ActionBarActionButtonMixin and ActionBarActionButtonMixin.StartFlash;
local ActionButton_StopFlash = ActionButton_StopFlash or ActionBarActionButtonMixin and ActionBarActionButtonMixin.StopFlash;
local ActionButton_IsFlashing = ActionButton_IsFlashing or ActionBarActionButtonMixin and ActionBarActionButtonMixin.IsFlashing;
local ActionButton_ShowOverlayGlow = ActionButton_ShowOverlayGlow or ActionBarActionButtonMixin and ActionBarActionButtonMixin.ShowOverlayGlow;
local ActionButton_HideOverlayGlow = ActionButton_HideOverlayGlow or ActionBarActionButtonMixin and ActionBarActionButtonMixin.HideOverlayGlow;

local Masque = LibStub and LibStub('Masque', true)
local AddButtonToGroup = function(btnname, index, groupname, func)
    if not Masque then
        return
    end
    local Group = Masque:Group('额外动作条', groupname)
    for i = 1, index do
        local btn = _G[format(btnname, i)]
        if(btn) then
            Group:AddButton(btn)
            if(func) then
                pcall(func, btn)
            end
        end
    end
end

_G.MOGUBar_Info = {};   --  saved db

local MOVING_MOGUBAR = nil;
local MOGUBAR_WINDOWS
local MOGUBAR_UNLOCK_BAR
local MOGUBAR_LOCK_BAR
local MOGUBAR_MINIMIZE_BAR
local MOGUBAR_RESTORE_BAR
local MOGUBAR_RESIZE
local MOGUBAR_CLOSE_BAR
local MOGUBAR_ARRANGEMENT
local MOGUBAR_ARRANGEMENT_HORIZONTAL
local MOGUBAR_ARRANGEMENT_VERTICAL
local MOGUBAR_ARRANGEMENT_FUNNY
local MOGUBAR_BUTTONS
local MOGUBAR_INCREASE_BUTTON
local MOGUBAR_DECREASE_BUTTON
local MOGUBAR_MESSAGE_ERROR_NO_ENOUGH_ID
local MOGUBAR_CLOSE_BAR_INFO
local MOGUBAR_ENABLE
local MOGUBAR_RESET
local MOGUBAR_HIDE_TAB
local MOGUBAR_HIDE_GRID
local MOGUBAR_OTHERS
local MOGUBAR_CREATE_NEW_BAR
local MOGUBAR_TAB_HELP_TEXT
if (GetLocale() == "zhCN") then
    MOGUBAR_WINDOWS = "窗口操作";
    MOGUBAR_UNLOCK_BAR = "解锁动作条";
    MOGUBAR_LOCK_BAR = "锁定动作条";
    MOGUBAR_MINIMIZE_BAR = "最小化动作条";
    MOGUBAR_RESTORE_BAR = "恢复动作条";
    MOGUBAR_RESIZE = "缩放动作条";
    MOGUBAR_CLOSE_BAR = "关闭动作条";
    MOGUBAR_ARRANGEMENT = "排列方式";
    MOGUBAR_ARRANGEMENT_HORIZONTAL = "横向排列";
    MOGUBAR_ARRANGEMENT_VERTICAL = "纵向排列";
    MOGUBAR_ARRANGEMENT_FUNNY = "趣味排列";
    MOGUBAR_BUTTONS = "按钮操作";
    MOGUBAR_INCREASE_BUTTON = "增加按钮";
    MOGUBAR_DECREASE_BUTTON = "减少按钮";
    MOGUBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "没有可分配的动作按钮ID。";
    MOGUBAR_CLOSE_BAR_INFO = "关闭动作条将使你所有的动作按钮信息失去，你真的想关闭动作按钮吗？";
    MOGUBAR_ENABLE = "开启额外动作条";
    MOGUBAR_RESET = "按鍵綁定";
    MOGUBAR_HIDE_TAB = "隐藏动作条标题头";
    MOGUBAR_HIDE_GRID = "隐藏未用的动作按钮";
    MOGUBAR_OTHERS = "其它操作";
    MOGUBAR_CREATE_NEW_BAR = "创建新的动作条";
    MOGUBAR_TAB_HELP_TEXT = "按住鼠标左键可拖动,\n单击鼠标右键弹出操作菜单,\n鼠标滚轮增加/减少按钮,\nCTRL左键可以切换布局。"
elseif (GetLocale() == "zhTW") then
    MOGUBAR_WINDOWS = "視窗";
    MOGUBAR_UNLOCK_BAR = "解鎖快捷列";
    MOGUBAR_LOCK_BAR = "鎖定快捷列";
    MOGUBAR_MINIMIZE_BAR = "最小化快捷列";
    MOGUBAR_RESTORE_BAR = "恢復快捷列";
    MOGUBAR_RESIZE = "縮放動作條";
    MOGUBAR_CLOSE_BAR = "關閉快捷列";
    MOGUBAR_ARRANGEMENT = "排列方式";
    MOGUBAR_ARRANGEMENT_HORIZONTAL = "橫向排列";
    MOGUBAR_ARRANGEMENT_VERTICAL = "縱向排列";
    MOGUBAR_ARRANGEMENT_FUNNY = "趣味排列";
    MOGUBAR_BUTTONS = "按鈕";
    MOGUBAR_INCREASE_BUTTON = "增加按鈕";
    MOGUBAR_DECREASE_BUTTON = "減少按鈕";
    MOGUBAR_OTHERS = "其它操作";
    MOGUBAR_CREATE_NEW_BAR = "創建新的快捷列";
    MOGUBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "沒有可分配的動作按鈕ID。";
    MOGUBAR_CLOSE_BAR_INFO = "關閉快捷列將失去你所有的動作按鈕訊息，你確定要關閉動作按鈕嗎？";
    MOGUBAR_ENABLE = "開啟额外快捷列";
    MOGUBAR_RESET = "按鍵綁定";
    MOGUBAR_HIDE_TAB = "隱藏快捷列標題";
    MOGUBAR_HIDE_GRID = "隱藏未用的動作按鈕";
    MOGUBAR_TAB_HELP_TEXT = "按住滑鼠左鍵可對快捷列進行拖曳,\n點選滑鼠右鍵彈出操作選單。"
else
	MOGUBAR_WINDOWS = "Window";
	MOGUBAR_UNLOCK_BAR = "Unlock";
	MOGUBAR_LOCK_BAR = "Lock";
	MOGUBAR_MINIMIZE_BAR = "Minimize";
	MOGUBAR_RESTORE_BAR = "Restore";
	MOGUBAR_RESIZE = "Resize Bar";
	MOGUBAR_CLOSE_BAR = "Close";
	MOGUBAR_ARRANGEMENT = "Arrangement";
	MOGUBAR_ARRANGEMENT_HORIZONTAL = "Horizontal arrangement";
	MOGUBAR_ARRANGEMENT_VERTICAL = "Vertical arragnement";
	MOGUBAR_ARRANGEMENT_FUNNY = "Funny arrangement";
	MOGUBAR_BUTTONS = "Button";
	MOGUBAR_INCREASE_BUTTON = "Increase button";
	MOGUBAR_DECREASE_BUTTON = "Decrease button";
	MOGUBAR_OTHERS = "Other";
	MOGUBAR_CREATE_NEW_BAR = "Create new bar";
	MOGUBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "No more button could be arragned.";
    MOGUBAR_CLOSE_BAR_INFO = "All button information you want to close will be lost, do you really want to do?";
    MOGUBAR_ENABLE = "Enable MOGU Bar";
	MOGUBAR_RESET = "Key Binding";
	MOGUBAR_HIDE_TAB = "Hide action bar headers";
	MOGUBAR_HIDE_GRID = "Hide unused action buttons";
	MOGUBAR_TAB_HELP_TEXT = "Hold mouse left button to move bar,\nRight click to popup menu.";
end
local MOGUBar_MAX_BUTTONS = 12;
local MOGUBar_MiniumButtons = 1;
local U1BAR_DEFAULT_BTNS = 10;
local MOGUBar_DropDownWidth = 124;
local U1BAR_MAX_BARS = 10;
local MOGUBar_Enabled = nil;
local MOGUBar_bShowGrid = nil;
StaticPopupDialogs["CLOSE_BAR"] = {
    preferredIndex = 3,
    text = MOGUBAR_CLOSE_BAR_INFO,
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, data)
        MOGUBar_CloseExBar(data);
    end,
    OnCancel = function(self, MOGUBar_3a41fa2f33897b6c190993d845e6b222) end,
    showAlert = 1,
    timeout = 0,
    whileDead = 1
};

function MOGUBarButton_OnLoad(self)
    self.buttonType = "MOGUBarActionButton";
    --copy from ActionButton_OnLoad, remove ActionBarButtonEventsFrame_RegisterFrame
	self.flashing = 0;
	self.flashtime = 0;
	self:SetAttribute("showgrid", 0);
	self:SetAttribute("type", "action");
	self:SetAttribute("checkselfcast", true);
	self:SetAttribute("checkfocuscast", true);
	self:SetAttribute("useparent-unit", true);
	self:SetAttribute("useparent-actionpage", true);
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("AnyUp");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ACTIONBAR_SHOWGRID");
	self:RegisterEvent("ACTIONBAR_HIDEGRID");
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	self:RegisterEvent("UPDATE_BINDINGS");
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM");

    self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");

	--ActionBarButtonEventsFrame_RegisterFrame(self); --SetActionUIButton(self, action, self.cooldown);
	ActionButton_UpdateAction(self);
	ActionButton_UpdateHotkeys(self, self.buttonType);
end

local BScale = BLibrary("BScale");
local BEvent = BLibrary("BEvent");
function MOGUBar_ForceRefreshActionBar()
    -- ActionBar_PageUp();
    -- ActionBar_PageDown();
    local page = GetActionBarPage();
    if page == 1 then
        ChangeActionBarPage(2);
        ChangeActionBarPage(page);
    else
        ChangeActionBarPage(1);
        ChangeActionBarPage(page);
    end
end

function MOGU_ShowKeyBindingFrame(ToWhich)
    if not InCombatLockdown() then
        if (ToWhich == nil) then
            KeyBindingFrame_LoadUI();
            ShowUIPanel(KeyBindingFrame);
            return;
        end
        for index = 1, GetNumBindings(), 1 do
            local command, category, key1, key2 = GetBinding(index);
            if (command == ToWhich) then
                KeyBindingFrame_LoadUI();
                ShowUIPanel(KeyBindingFrame);
                KeyBindingFrameScrollFrameScrollBar:SetValue((index - 1) * KEY_BINDING_HEIGHT);
            end
        end
    end
end

function MOGUBar_Toggle(which)
    if (which == 1) then
        if (not MOGUBar_Enabled) then
            MOGUBar_OpenExBar();
            MOGUBar_ForceRefreshActionBar();
            MOGUBar_Enabled = 1;
        end
    else
        if (MOGUBar_Enabled) then
            for index = 1, U1BAR_MAX_BARS, 1 do
                local ExBar = getglobal("U1BAR" .. index);
                if (ExBar) then
                    MOGUBar_CloseExBar(nil, ExBar);
                end
                -- MOGUBar_MovePartyMemberFrame();
                MOGUBar_MoveDurabilityFrame();
            end
            MOGUBar_Enabled = nil;
        end
    end
end

function MOGU_DelayCall(func, delay, ...)
    if (not MOGUFramecallroutine) then
        MOGUFramecallroutine = {};
    end
    table.insert(MOGUFramecallroutine, {
        func = func,
        delay = delay,
        lastUpdate = 0,
        arg = { ... },
    });
end

mehide = CreateFrame("Frame") --缩放在离开3秒后消失
mehide:SetScript("OnUpdate", function(this)
    if MOGUBarOpacitySlider.Leave == 1 then
        gettime = gettime or GetTime()
    else
        gettime = GetTime()
    end
    if (GetTime() - gettime > 1) then
        MOGUBarOpacitySlider:Hide();
        MOGUBarOpacitySlider.Leave = nil
    end
end)
function MOGUBar_ToggleShowGrid(switch)
    if (switch) then
        MOGUBar_bShowGrid = true;
        for index = 1, U1BAR_MAX_BARS, 1 do
            local ExBar = getglobal("U1BAR" .. index);
            if (ExBar and ExBar:IsVisible()) then
                for index2 = 1, MOGUBar_MAX_BUTTONS, 1 do
                    local ExButton = getglobal(ExBar:GetName() .. "AB" .. index2);
                    MOGUActionButton_ShowGrid(ExButton);
                    ActionButton_Update(ExButton);
                end
            end
        end
    else
        MOGUBar_bShowGrid = false;
        for index = 1, U1BAR_MAX_BARS, 1 do
            local ExBar = getglobal("U1BAR" .. index);
            if (ExBar and ExBar:IsVisible()) then
                for index2 = 1, MOGUBar_MAX_BUTTONS, 1 do
                    local ExButton = getglobal(ExBar:GetName() .. "AB" .. index2);
                    MOGUActionButton_HideGrid(ExButton);
                    ActionButton_Update(ExButton);
                end
            end
        end
    end
end

function MOGUBarFrame_OnLoad(self)
    self:SetClampedToScreen(true);
end

function MOGUBar_TabDropDownInitialize(frame, level)
    MOGUBar_info = {};
    MOGUBar_info.text = MOGUBAR_WINDOWS;
    MOGUBar_info.isTitle = 1;
    MOGUBar_info.notCheckable = 1;
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    MOGUBar_info = {};
    local currBar = frame:GetParent():GetParent();
    if (currBar and currBar.isLocked) then
        MOGUBar_info.text = MOGUBAR_UNLOCK_BAR;
    else
        MOGUBar_info.text = MOGUBAR_LOCK_BAR;
    end
    MOGUBar_info.func = MOGUBar_SetLock;
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    if (currBar and currBar.minimized) then
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_RESTORE_BAR;
        MOGUBar_info.func = MOGUBar_RestoreExBar;
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    else
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_MINIMIZE_BAR;
        MOGUBar_info.func = MOGUBar_MinizeExBar;
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    end
    MOGUBar_info = {};
    MOGUBar_info.text = MOGUBAR_RESIZE;
    MOGUBar_info.func = MOGUBar_ShowScaleSlider;
    --缩放
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    if (MOGUBar_GetNumExBars() > 1) then
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_CLOSE_BAR;
        MOGUBar_info.func = function()
            StaticPopup_Show("CLOSE_BAR", nil, nil, currBar);
        end;
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    end
    if (currBar and not currBar.minimized) then
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_ARRANGEMENT;
        MOGUBar_info.isTitle = 1;
        MOGUBar_info.notCheckable = 1;
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        if (currBar.arrangement ~= "horizontal") then
            MOGUBar_info = {};
            MOGUBar_info.text = MOGUBAR_ARRANGEMENT_HORIZONTAL;
            MOGUBar_info.func = MOGUBar_SetAlignHorizontal;
            UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        end
        if (currBar.arrangement ~= "vertical") then
            MOGUBar_info = {};
            MOGUBar_info.text = MOGUBAR_ARRANGEMENT_VERTICAL;
            MOGUBar_info.func = MOGUBar_SetAlignVertical;
            UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        end
        if (currBar.arrangement ~= "funny") then
            MOGUBar_info = {};
            MOGUBar_info.text = MOGUBAR_ARRANGEMENT_FUNNY;
            MOGUBar_info.func = MOGUBar_SetAlignFunny;
            UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        end
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_BUTTONS;
        MOGUBar_info.isTitle = 1;
        MOGUBar_info.notCheckable = 1;
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_INCREASE_BUTTON;
        MOGUBar_info.func = U1BAR_IncreaseButton;
        MOGUBar_info.disabled = 1;
        if (MOGUBar_GetNumButtons(currBar) < MOGUBar_MAX_BUTTONS) then
            MOGUBar_info.disabled = nil;
        end
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
        MOGUBar_info = {};
        MOGUBar_info.text = MOGUBAR_DECREASE_BUTTON;
        MOGUBar_info.func = U1BAR_DecreaseButton;
        MOGUBar_info.disabled = 1;
        if (MOGUBar_GetNumButtons(currBar) > MOGUBar_MiniumButtons) then
            MOGUBar_info.disabled = nil;
        end
        UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    end
    MOGUBar_info = {};
    MOGUBar_info.text =
    MOGUBAR_OTHERS;
    MOGUBar_info.isTitle = 1;
    MOGUBar_info.notCheckable = 1;
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    MOGUBar_info = {};
    MOGUBar_info.text = MOGUBAR_CREATE_NEW_BAR;
    MOGUBar_info.func = U1BAR_CreateNewActionBar;
    if (MOGUBar_GetNumExBars() >= U1BAR_MAX_BARS) then
        MOGUBar_info.disabled = 1;
    end
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    MOGUBar_info = {};
    MOGUBar_info.text = "打开控制台设置";
    MOGUBar_info.func = function()
        if UUI then
            UUI.OpenToAddon("ExtraActionBar", true)
        end
    end;
    UIDD:UIDropDownMenu_AddButton(MOGUBar_info);
    --[[
    local info = {}
    info.text = "关闭标题头"
    info.func = function() _G[ExBar:GetName().."Tab"]:Hide() DEFAULT_CHAT_FRAME:AddMessage("额外动作条标题头已关闭，如需开启，请在控制台中设置") end
    UIDD:UIDropDownMenu_AddButton(info);
    ]]
end

function MOGUBar_SetLock()
    local bar = U1BAR_FindBar();
    if (bar) then
        if (bar.isLocked) then
            bar.isLocked = nil;
        else
            bar.isLocked = 1;
        end
        MOGUBar_SaveExBarToDB(bar);
    end
end

function U1BAR_FindBar(self)
    local bar = getglobal("U1BAR" .. UIDD:UIDropDownMenu_GetCurrentDropDown():GetParent():GetParent():GetID());
    if (not bar) then
        bar = getglobal("U1BAR" .. self:GetParent():GetID());
    end
    return bar;
end

local map = { vertical = "horizontal", horizontal = "funny", funny = "vertical" }

function MOGUBarTab_OnClick(self, button)
    if (button == "RightButton" and not InCombatLockdown()) then
        if (GetScreenWidth() - self:GetRight() < MOGUBar_DropDownWidth - 40) then
            UIDD:ToggleDropDownMenu(1, nil, getglobal(self:GetName() .. "DropDown"), self:GetName(), 10 - MOGUBar_DropDownWidth, 3);
        else
            UIDD:ToggleDropDownMenu(1, nil, getglobal(self:GetName() .. "DropDown"), self:GetName(), 10, 3);
        end
        PlaySound(1115);
        return;
    elseif(button == "LeftButton" and not InCombatLockdown()) then
        if IsModifierKeyDown() then
            U1BAR_SetAlign(self:GetParent(), map[self:GetParent().arrangement or "funny"])
        end
    end

    UIDD:CloseDropDownMenus();
end

function MOGUBarDropDown_OnLoad(self)
    -- UIDropDownMenu_Initialize(self, MOGUBar_TabDropDownInitialize, "MENU");
    -- UIDropDownMenu_SetButtonWidth(self, 50);
    -- UIDropDownMenu_SetWidth(self, 50);
    -- local self = UIDD:Create_UIDropDownMenu(tab:GetName() .. "DropDown", tab);
    UIDD:UIDropDownMenu_Initialize(self, MOGUBar_TabDropDownInitialize, "MENU")
    UIDD:UIDropDownMenu_SetButtonWidth(self, 50);
    UIDD:UIDropDownMenu_SetWidth(self, 50);
end

function U1BAR_IncreaseButton(self, bar)
    local ExBar = bar or U1BAR_FindBar(self);
    if (ExBar) then
        for index = 1, MOGUBar_MAX_BUTTONS, 1 do
            local showGrid = getglobal(ExBar:GetName() .. "AB" .. index);
            if (showGrid and not showGrid.forceShow) then
                showGrid.forceShow = true;
                MOGUActionButton_ShowGrid(showGrid);
            end
            showGrid.grid_timestamp = 0;
            if (showGrid and showGrid.hide) then
                MOGUBar_ShowButton(showGrid);
                local SavedVar = MOGUBar_GetPlayerSavedVar();
                if (SavedVar[ExBar:GetName()]) then
                    SavedVar[ExBar:GetName()].buttonCount = index;
                end
                MOGUBar_ForceRefreshActionBar();
                break;
            end
        end
        if (ExBar.arrangement == "funny") then
            U1BAR_SetAlign(ExBar, "funny");
        end
    end
end

function U1BAR_DecreaseButton(self, bar)
    local ExBar = bar or U1BAR_FindBar(self);
    if (ExBar) then
        for index = 1, MOGUBar_MAX_BUTTONS, 1 do
            local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
            if (ExButton and not ExButton.forceShow) then
                ExButton.forceShow = true;
                MOGUActionButton_ShowGrid(ExButton);
            end
            ExButton.grid_timestamp = 0;
        end
        for index = MOGUBar_MAX_BUTTONS, 2, -1 do
            local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
            if (ExButton and not ExButton.hide) then
                MOGUBar_HideButton(ExButton);
                local SavedVar = MOGUBar_GetPlayerSavedVar();
                if (SavedVar[ExBar:GetName()]) then
                    SavedVar[ExBar:GetName()].buttonCount = index - 1;
                end
                break;
            end
        end
        if (ExBar.arrangement == "funny") then
            U1BAR_SetAlign(ExBar, "funny");
        end
    end
end

function U1BAR_SetAlign(ExBar, align)
    if (align == "horizontal") then
        for index = 2, MOGUBar_MAX_BUTTONS, 1 do
            local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
            local PrevExButton = ExBar:GetName() .. "AB" .. (index - 1);
            ExButton:ClearAllPoints();
            ExButton:SetPoint("LEFT", PrevExButton, "RIGHT", 6, 0);
        end
        ExBar.arrangement = "horizontal";
    elseif (align == "vertical") then
        for index = 2, MOGUBar_MAX_BUTTONS, 1 do
            local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
            local PrevExButton = ExBar:GetName() .. "AB" .. (index - 1);
            ExButton:ClearAllPoints();
            ExButton:SetPoint("TOP", PrevExButton, "BOTTOM", 0, -6);
        end
        ExBar.arrangement = "vertical";
    elseif (align == "funny") then
        local NumButtons = MOGUBar_GetNumButtons(ExBar);
        MOGUBar_FunnyAlign(ExBar, NumButtons);
        ExBar.arrangement = "funny";
    end
    MOGUBar_SaveExBarToDB(ExBar);
end

function MOGUBar_SetButtonPoint(ExBar, index, point, relativeTo, relativePoint, x, y)
    local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
    ExButton:ClearAllPoints();
    ExButton:SetPoint(point, relativeTo, relativePoint, x, y);
    return ExButton;
end

function MOGUBar_FunnyAlign(ExBar, NumButtons)
    if (NumButtons == 1) then
    elseif (NumButtons == 2) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOP", ExButton1:GetName(), "BOTTOM", 0, -6);
    elseif (NumButtons == 3) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "TOPLEFT", ExButton1:GetName(), "BOTTOM", 3, -6);
    elseif (NumButtons == 4) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "TOPLEFT", ExButton1:GetName(), "BOTTOM", 3, -6);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOP", ExButton2:GetName(), "BOTTOMRIGHT", 3, -6);
    elseif (NumButtons == 5) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOPRIGHT", ExButton1:GetName(), "BOTTOMLEFT", -3, -6);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "TOP", ExButton1:GetName(), "BOTTOM", 0, -6);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOPLEFT", ExButton1:GetName(), "BOTTOMRIGHT", 3, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "TOP", ExButton3:GetName(), "BOTTOM", 0, -6);
    elseif (NumButtons == 6) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOPRIGHT", ExButton2:GetName(), "BOTTOM", -3, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "LEFT", ExButton5:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 7) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "LEFT", ExButton1:GetName(), "RIGHT", 6, 0);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "LEFT", ExButton3:GetName(), "RIGHT", 6, 0);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "TOPLEFT", ExButton3:GetName(), "BOTTOM", 3, -6);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "LEFT", ExButton6:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 8) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOPRIGHT", ExButton2:GetName(), "BOTTOM", -3, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "LEFT", ExButton5:GetName(), "RIGHT", 6, 0);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "TOPLEFT", ExButton4:GetName(), "BOTTOM", 3, -6);
        local ExButton8 = MOGUBar_SetButtonPoint(ExBar, 8, "LEFT", ExButton7:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 9) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "LEFT", ExButton1:GetName(), "RIGHT", 6, 0);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOP", ExButton1:GetName(), "BOTTOM", 0, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "LEFT", ExButton5:GetName(), "RIGHT", 6, 0);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "TOP", ExButton4:GetName(), "BOTTOM", 0, -6);
        local ExButton8 = MOGUBar_SetButtonPoint(ExBar, 8, "LEFT", ExButton7:GetName(), "RIGHT", 6, 0);
        local ExButton9 = MOGUBar_SetButtonPoint(ExBar, 9, "LEFT", ExButton8:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 10) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "LEFT", ExButton1:GetName(), "RIGHT", 6, 0);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOPRIGHT", ExButton1:GetName(), "BOTTOM", -3, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "LEFT", ExButton5:GetName(), "RIGHT", 6, 0);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "LEFT", ExButton6:GetName(), "RIGHT", 6, 0);
        local ExButton8 = MOGUBar_SetButtonPoint(ExBar, 8, "TOPLEFT", ExButton4:GetName(), "BOTTOM", 3, -6);
        local ExButton9 = MOGUBar_SetButtonPoint(ExBar, 9, "LEFT", ExButton8:GetName(), "RIGHT", 6, 0);
        local ExButton10 = MOGUBar_SetButtonPoint(ExBar, 10, "LEFT", ExButton9:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 11) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "LEFT", ExButton1:GetName(), "RIGHT", 6, 0);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOP", ExButton2:GetName(), "BOTTOM", 0, -6);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "TOP", ExButton4:GetName(), "BOTTOM", 0, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "RIGHT", ExButton6:GetName(), "LEFT", -6, 0);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "LEFT", ExButton6:GetName(), "RIGHT", 6, 0);
        local ExButton8 = MOGUBar_SetButtonPoint(ExBar, 8, "TOP", ExButton6:GetName(), "BOTTOM", 0, -6);
        local ExButton10 = MOGUBar_SetButtonPoint(ExBar, 10, "TOP", ExButton8:GetName(), "BOTTOM", 0, -6);
        local ExButton9 = MOGUBar_SetButtonPoint(ExBar, 9, "RIGHT", ExButton10:GetName(), "LEFT", -6, 0);
        local ExButton11 = MOGUBar_SetButtonPoint(ExBar, 11, "LEFT", ExButton10:GetName(), "RIGHT", 6, 0);
    elseif (NumButtons == 12) then
        local ExButton1 = getglobal(ExBar:GetName() .. "AB" .. 1);
        local ExButton2 = MOGUBar_SetButtonPoint(ExBar, 2, "LEFT", ExButton1:GetName(), "RIGHT", 6, 0);
        local ExButton3 = MOGUBar_SetButtonPoint(ExBar, 3, "LEFT", ExButton2:GetName(), "RIGHT", 6, 0);
        local ExButton4 = MOGUBar_SetButtonPoint(ExBar, 4, "TOP", ExButton1:GetName(), "BOTTOM", 0, -6);
        local ExButton5 = MOGUBar_SetButtonPoint(ExBar, 5, "LEFT", ExButton4:GetName(), "RIGHT", 6, 0);
        local ExButton6 = MOGUBar_SetButtonPoint(ExBar, 6, "LEFT", ExButton5:GetName(), "RIGHT", 6, 0);
        local ExButton7 = MOGUBar_SetButtonPoint(ExBar, 7, "TOP", ExButton4:GetName(), "BOTTOM", 0, -6);
        local ExButton8 = MOGUBar_SetButtonPoint(ExBar, 8, "LEFT", ExButton7:GetName(), "RIGHT", 6, 0);
        local ExButton9 = MOGUBar_SetButtonPoint(ExBar, 9, "LEFT", ExButton8:GetName(), "RIGHT", 6, 0);
        local ExButton10 = MOGUBar_SetButtonPoint(ExBar, 10, "TOP", ExButton7:GetName(), "BOTTOM", 0, -6);
        local ExButton11 = MOGUBar_SetButtonPoint(ExBar, 11, "LEFT", ExButton10:GetName(), "RIGHT", 6, 0);
        local ExButton12 = MOGUBar_SetButtonPoint(ExBar, 12, "LEFT", ExButton11:GetName(), "RIGHT", 6, 0);
    end
end

function MOGUBar_SetAlignHorizontal(self)
    local ExBar = U1BAR_FindBar(self);
    U1BAR_SetAlign(ExBar, "horizontal");
end

function MOGUBar_SetAlignVertical(self)
    local ExBar = U1BAR_FindBar(self);
    U1BAR_SetAlign(ExBar, "vertical");
end

function MOGUBar_SetAlignFunny(self)
    local ExBar = U1BAR_FindBar(self);
    U1BAR_SetAlign(ExBar, "funny");
end

function MOGUBar_GetNumButtons(ExBar)
    for index = 1, MOGUBar_MAX_BUTTONS, 1 do
        local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
        if (ExButton and ExButton.hide) then
            return index - 1;
        end
    end
    return MOGUBar_MAX_BUTTONS;
end

function MOGUBar_GetNumExBars()
    local ExBarID = 0;
    for index = 1, U1BAR_MAX_BARS, 1 do
        local ExBar = getglobal("U1BAR" .. index);
        if (ExBar and ExBar:IsVisible()) then
            ExBarID = ExBarID + 1;
        end
    end
    return ExBarID;
end

function MOGUActionButton_OnEvent(self, event, ...)
    if (event == "ACTIONBAR_SHOWGRID") then
        MOGUActionButton_ShowGrid(self);
    elseif(event == "ACTIONBAR_HIDEGRID") then
        MOGUActionButton_HideGrid(self);
    else
        U1BAR_ActionButton_OnEvent(self, event, ...);
    end
end

function MOGUActionButton_ShowGrid(button)
    if (not InCombatLockdown()) then
        button:SetAttribute("showgrid", button:GetAttribute("showgrid") + 1);
        MOGUActionButton_UpdateGrid(button);
    end
end

function MOGUActionButton_HideGrid(button)
    if (not InCombatLockdown()) then
        local grid = button:GetAttribute("showgrid");
        grid = grid - 1;
        if (button.forceShow) then
            button.forceShow = nil;
            grid = grid - 1;
        end
        if (grid < 0) then
            grid = 0;
        end
        button:SetAttribute("showgrid", grid);
        MOGUActionButton_UpdateGrid(button);
    end
end

function MOGUActionButton_UpdateGrid(button)
    if (button:GetAttribute("statehidden")) then
        button:Hide();
    elseif (HasAction(button:GetAttribute("action"))) then
        button:Show();
    elseif (button:GetAttribute("showgrid") >= 1) then
        button:Show();
    else
        button:Hide();
    end
end

---靠，仅仅是用来新创建的按钮显示5秒空白的...
CoreScheduleTimer(true, 2, function()
    for barId = 1, 10 do
        local bar = _G[format("U1BAR%d", barId)]
        if bar and bar:IsVisible() then
            for i = 1, MOGUBar_MAX_BUTTONS, 1 do
                local btn = getglobal(bar:GetName() .. "AB" .. i);
                if (btn.forceShow) then
                    if (not btn.grid_timestamp) then
                        btn.grid_timestamp = 0;
                    end
                    btn.grid_timestamp = btn.grid_timestamp + 2;
                    if (btn.grid_timestamp > 5) then
                        btn.forceShow = nil;
                        btn:SetAttribute("showgrid", btn:GetAttribute("showgrid") - 1);
                    end
                    MOGUActionButton_UpdateGrid(btn);
                else
                    btn.grid_timestamp = 0;
                end
                if (not btn.bookFrameShow and SpellBookFrame:IsShown()) then
                    MOGUActionButton_ShowGrid(btn);
                    btn.bookFrameShow = true;
                elseif (btn.bookFrameShow and not SpellBookFrame:IsShown()) then
                    MOGUActionButton_HideGrid(btn);
                    btn.bookFrameShow = false;
                end
            end
        end
    end
end)

function MOGUBar_ShowButton(ExButton)
    local NormalTexture = getglobal(ExButton:GetName() .. "NormalTexture");
    ExButton.hide = nil;
    NormalTexture:SetAlpha(0.3);
    ExButton:SetAttribute("statehidden", nil);
    MOGUActionButton_UpdateGrid(ExButton);
    return true;
end

function MOGUBar_HideButton(ExButton)
    ExButton.hide = 1;
    ExButton:SetAttribute("statehidden", true);
    MOGUActionButton_UpdateGrid(ExButton);
end

function U1BAR_SetPos(bar)
    bar:ClearAllPoints();
    bar:SetPoint("CENTER", "UIParent", "CENTER", 0, 60);
end

function MOGUBar_SetAllExBarsPos()
    for index = 1, U1BAR_MAX_BARS, 1 do
        local ExBar = getglobal("U1BAR" .. index);
        if (ExBar and ExBar:IsVisible()) then
            U1BAR_SetPos(ExBar);
        end
    end
end

-- function MOGUBar_9d9ae0ea8d213958f106e815d1c56b12() end

function U1BAR_CreateBar(name)
    local bar = CreateFrame("Frame", name, UIParent, "MOGUBarFrameTemplate");
    if CoreHideOnPetBattle then
        CoreHideOnPetBattle(bar)
    end
    U1BAR_SetPos(bar);
    AddButtonToGroup(name.."AB%d", 12, "额外动作条"..name)
    return bar;
end

function MOGUBar_HideExBar(ExBar)
    ExBar:Hide();
    for index = 1, MOGUBar_MAX_BUTTONS, 1 do
        local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
        MOGUBar_HideButton(ExButton);
    end
end

function MOGUBar_GetExBar(name)
    local NumExBars = MOGUBar_GetNumExBars();
    if (NumExBars > U1BAR_MAX_BARS) then
        return;
    end
    local index;
    local ExBar;
    if (name) then
        local startpoint, endpoint, id = string.find(name, "^U1BAR(%d+)$");
        ExBar = getglobal(name);
        if ExBar then
            ExBar:Show();
            return ExBar;
        elseif id then
            ExBar = U1BAR_CreateBar(name);
            ExBar:SetID(id);
            local titile = getglobal(ExBar:GetName() .. "TabTitle");
            titile:SetText(id);
            ExBar:Show();
            return ExBar;
        end
    end
    for index = 1, U1BAR_MAX_BARS, 1 do
        ExBar = getglobal("U1BAR" .. index);
        if (ExBar and not ExBar:IsVisible()) then
            ExBar:Show();
            return ExBar;
        end
    end
    for index = 1, U1BAR_MAX_BARS, 1 do
        ExBar = getglobal("U1BAR" .. index);
        if (not ExBar) then
            ExBar = U1BAR_CreateBar("U1BAR" .. index);
            ExBar:SetID(index);
            local titile = getglobal(ExBar:GetName() .. "TabTitle");
            titile:SetText(id);
            ExBar:Show();
            return ExBar;
        end
    end
end

function U1BAR_CreateNewActionBar()
    local bar = MOGUBar_GetExBar();
    if (bar) then
        local titile = getglobal(bar:GetName() .. "TabTitle");
        titile:SetText(bar:GetID());
        --MHDB["mgbar"..ExBar:GetID()] = true
        bar.isLocked = nil;
        bar.minimized = nil;
        bar.sonID = 1;
        for index = 1, MOGUBar_MAX_BUTTONS, 1 do
            local btn = getglobal(bar:GetName() .. "AB" .. index);
            local id = bar.sonID + (10 - bar:GetID()) * MOGUBar_MAX_BUTTONS;
            btn:SetScript("OnEvent", MOGUActionButton_OnEvent);
            btn:SetAttribute("action", id);
            btn.bookFrameShow = nil;
            MOGUBar_ShowButton(btn);
            bar.sonID = bar.sonID + 1;
            if (MOGUBar_bShowGrid) then
                btn:SetAttribute("showgrid", 1);
            else
                btn:SetAttribute("showgrid", 0);
            end
            btn.forceShow = true;
            MOGUActionButton_ShowGrid(btn);
            MOGUActionButton_UpdateGrid(btn);
        end
        for i = U1BAR_DEFAULT_BTNS + 1, MOGUBar_MAX_BUTTONS, 1 do
            local ExButton = getglobal(bar:GetName() .. "AB" .. i);
            MOGUBar_HideButton(ExButton);
        end
        U1BAR_SetAlign(bar, "vertical");
        MOGUBar_SaveExBarToDB(bar);
        MOGUBar_ForceRefreshActionBar();
    end
end

function MOGUBar_CloseExBar(self, ExBar)
    if (not ExBar) then
        ExBar = U1BAR_FindBar(self);
    end
    MOGUBar_HideExBar(ExBar);
    MOGUBar_SaveExBarToDB(ExBar);
end

function MOGUBar_GetPlayerSavedVar()
    local PlayerName = UnitName("Player");
    if (not PlayerName or PlayerName == UNKNOWNOBJECT or PlayerName == UKNOWNBEING) then
        return nil;
    end
    if (not MOGUBar_Info[PlayerName]) then
        MOGUBar_Info[PlayerName] = {
            U1BAR1 = {
                buttonCount = 7,
                arrangement = "funny",
                region = {top = GetScreenHeight()/2, left = GetScreenWidth()/2 + 225,}
            }
        };
    end
    return MOGUBar_Info[PlayerName];
end

function MOGUBar_LoadSavedVar(ExBar)
    if (ExBar and ExBar:IsVisible()) then
        local SavedVar = MOGUBar_GetPlayerSavedVar();
        local MOGUBar_info = SavedVar[ExBar:GetName()];
        if (MOGUBar_info and MOGUBar_info.region) then
            ExBar.arrangement = MOGUBar_info.arrangement;
            ExBar.isLocked = MOGUBar_info.isLocked;
            ExBar.minimized = MOGUBar_info.minimized;
            ExBar.scale = MOGUBar_info.scale;
            ExBar.togglePartyFrame = MOGUBar_info.togglePartyFrame;
            ExBar.toggleDurabilityFrame = MOGUBar_info.toggleDurabilityFrame;
            if (ExBar.scale) then
                BScale:SetScale(ExBar, ExBar.scale);
            end
            ExBar:ClearAllPoints();
            ExBar:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", MOGUBar_info.region.left, MOGUBar_info.region.top);
            U1BAR_SetAlign(ExBar, MOGUBar_info.arrangement);
            -- if (ExBar.togglePartyFrame) then
            --     MOGUBar_MovePartyMemberFrame(1);
            -- end
            if (ExBar.toggleDurabilityFrame) then
                MOGUBar_MoveDurabilityFrame(1);
            end
        end
    end
end

function MOGUBar_OpenExBar()
    local SavedVar = MOGUBar_GetPlayerSavedVar();
    if (not SavedVar) then
        MOGU_DelayCall(MOGUBar_OpenExBar, 2);
        return;
    end
    local GotOneBar = nil;
    for index = 1, U1BAR_MAX_BARS, 1 do
        local ExBarName = "U1BAR" .. index;
        if (SavedVar[ExBarName]) then
            local ExBar = getglobal(ExBarName);
            if (not ExBar) then
                ExBar = MOGUBar_GetExBar(ExBarName);
            end
            ExBar.keyframe = CreateFrame("Frame", nil, UIParent);
            ExBar.sonID = 1;
            local NumButtons = SavedVar[ExBarName].buttonCount;
            if (not NumButtons) then
                NumButtons = MOGUBar_MAX_BUTTONS;
            end
            for U1B_i = 1, MOGUBar_MAX_BUTTONS, 1 do
                local ExButton = getglobal(ExBarName .. "AB" .. U1B_i);
                local loc1 = ExBar.sonID + (10 - ExBar:GetID()) * MOGUBar_MAX_BUTTONS;
                ExButton:SetAttribute("action", loc1);
                ExBar.sonID = ExBar.sonID + 1;
                ExButton:SetScript("OnEvent", MOGUActionButton_OnEvent);
                if (MOGUBar_bShowGrid) then
                    ExButton:SetAttribute("showgrid", 1);
                else
                    ExButton:SetAttribute("showgrid", 0);
                end
            end
            for U1B_i = 1, NumButtons, 1 do
                local ExButton = getglobal(ExBarName .. "AB" .. U1B_i);
                MOGUBar_ShowButton(ExButton);
            end
            for U1B_i = NumButtons + 1, MOGUBar_MAX_BUTTONS, 1 do
                local ExButton = getglobal(ExBarName .. "AB" .. U1B_i);
                MOGUBar_HideButton(ExButton);
            end
            for U1B_i = 1, MOGUBar_MAX_BUTTONS, 1 do
                local ExButton = getglobal(ExBarName .. "AB" .. U1B_i);
                MOGUActionButton_UpdateGrid(ExButton);
            end
            MOGUBar_LoadSavedVar(ExBar);
            local titile = getglobal(ExBarName .. "TabTitle");
            titile:SetText(ExBar:GetID());
            if (ExBar.minimized) then
                MOGUBar_MinizeExBar(ExBar);
            end
            GotOneBar = true;
        end
    end
    if (not GotOneBar) then
        U1BAR_CreateNewActionBar();
    end
end

-- function MOGUBar_d7613b704685de240b505fbb41cef8ca(type, message)
--     if (type == "Error") then
--         ChatFrame1:AddMessage(message, 1.0, 0.0, 0.0);
--     elseif (type == "Info") then
--         ChatFrame1:AddMessage(message, 1.0, 1.0, 0.0);
--     end
-- end

function MOGUBar_GetExBarRegion(ExBar)
    local region = {};
    region.left = ExBar:GetLeft();
    region.right = ExBar:GetRight();
    region.top = ExBar:GetTop();
    region.bottom = ExBar:GetBottom();
    if (not region.left or not region.right or not region.top or not region.bottom) then
        return nil;
    end
    region.left = math.floor(region.left + 0.5);
    region.right = math.floor(region.right + 0.5);
    region.top = math.floor(region.top + 0.5);
    region.bottom = math.floor(region.bottom + 0.5);
    return region;
end

function MOGUBar_SaveExBarToDB(ExBar)
    local SavedVar = MOGUBar_GetPlayerSavedVar();
    if (ExBar and SavedVar) then
        if (ExBar:IsVisible()) then
            local MOGUBar_info = {};
            local region = MOGUBar_GetExBarRegion(ExBar);
            MOGUBar_info.region = region;
            MOGUBar_info.arrangement = ExBar.arrangement;
            MOGUBar_info.isLocked = ExBar.isLocked;
            MOGUBar_info.minimized = ExBar.minimized;
            MOGUBar_info.scale = ExBar.scale;
            MOGUBar_info.togglePartyFrame = ExBar.togglePartyFrame;
            MOGUBar_info.toggleDurabilityFrame = ExBar.toggleDurabilityFrame;
            MOGUBar_info.buttonCount = MOGUBar_GetNumButtons(ExBar);
            SavedVar[ExBar:GetName()] = MOGUBar_info;
        else
            SavedVar[ExBar:GetName()] = nil;
        end
    end
end

function MOGUBar_ShowScaleSlider(self)
    local ExBar = U1BAR_FindBar(self);
    local bar = getglobal(ExBar:GetName() .. "Tab");
    local top = bar:GetTop() * bar:GetEffectiveScale();
    local left = bar:GetLeft() * bar:GetEffectiveScale();
    MOGUBarOpacitySlider.frame = nil;
    MOGUBarOpacitySlider:SetAlpha(1);
    MOGUBarOpacitySlider:ClearAllPoints();
    MOGUBarOpacitySlider:SetPoint("TOPRIGHT", bar, "TOPLEFT", -20, 0);
    MOGUBarOpacitySlider:Show();
    MOGUBarOpacitySlider:SetMinMaxValues(50, 150);
    MOGUBarOpacitySlider:SetValueStep(10);
    if (ExBar.scale) then
        MOGUBarOpacitySlider:SetValue(ExBar.scale * 100);
    else
        MOGUBarOpacitySlider:SetValue(100);
    end
    MOGUBarOpacitySlider.frame = ExBar;
end

function MOGUBar_MinizeExBar(self)
    local ExBar = U1BAR_FindBar(self);
    for index = 1, MOGUBar_MAX_BUTTONS, 1 do
        local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
        if (ExButton) then
            ExButton.minimized = 1;
            MOGUBar_HideButton(ExButton);
        end
    end
    ExBar.minimized = 1;
    MOGUBar_SaveExBarToDB(ExBar);
end

function MOGUBar_RestoreExBar(self)
    local ExBar = U1BAR_FindBar(self);
    for index = 1, MOGUBar_MAX_BUTTONS, 1 do
        local ExButton = getglobal(ExBar:GetName() .. "AB" .. index);
        if (ExButton and ExButton.hide) then
            ExButton.minimized = nil;
            MOGUBar_ShowButton(ExButton);
        end
        ActionButton_UpdateState(ExButton);
        MOGUActionButton_UpdateGrid(ExButton);
    end
    ExBar.minimized = nil;
    local SavedVar = MOGUBar_GetPlayerSavedVar();
    local MOGUBar_info = SavedVar[ExBar:GetName()];
    U1BAR_SetAlign(ExBar, MOGUBar_info.arrangement);
    MOGUBar_SaveExBarToDB(ExBar);
end

function MOGUBar_MoveDurabilityFrame(value)
    if (value) then
        DurabilityFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", -20, 15);
    else
        DurabilityFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", 40, 15);
    end
end

function MOGUBar_MovePartyMemberFrame(value)
    do return end
    if (value) then
        PartyMemberFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 40, -128);
    else
        PartyMemberFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -128);
    end
end

function MOGUBarTab_OnMouseDown(self, ExButton)
    if (ExButton ~= "LeftButton") then
        return;
    end
    local ExBar = self:GetParent();
    if (not ExBar.isLocked and not ExBar.inCombat) then
        ExBar:StartMoving();
        ExBar.moving = true;
        MOVING_MOGUBAR = ExBar;
    end
end

function MOGUBarTab_OnMouseUp(self, ExButton)
    local ExBar = self:GetParent();
    if (ExBar.moving or InCombatLockdown()) then
        ExBar:StopMovingOrSizing();
        ExBar.moving = false;
        MOVING_MOGUBAR = nil;
        MOGUBar_SaveExBarToDB(ExBar);
    end
end

function MOGUBarTab_OnEnter(self)
    self:GetParent().isFading = nil;
    self:GetParent().locking = true;
    GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
    GameTooltip:SetText(MOGUBAR_TAB_HELP_TEXT);
    GameTooltip:Show();
end

function MOGUBarTab_OnLeave(self)
    local dropdown = getglobal(self:GetName() .. "DropDown");
    if (UIDD:UIDropDownMenu_GetCurrentDropDown() ~= dropdown) then
        self:GetParent().locking = nil;
    end
    self:GetParent().lastLeave = GetTime();
    GameTooltip:Hide();
end

function MOGUBarOpacitySlider_OnValueChanged(self, value)
    getglobal(self:GetName() .. "Text"):SetText(math.floor(value) .. "%");
    if (self.frame) then
        BScale:SetScale(self.frame, value / 100);
        self.frame.scale = value / 100;
        MOGUBar_SaveExBarToDB(self.frame);
    end
end

local function MOGUBarOpacitySlider_Hide()
    if (MOGUBarOpacitySlider.Leave) then
        MOGUBarOpacitySlider:Hide();
    end
end

local function MOGUBarOpacitySlider_StartFade()
    if (MOGUBarOpacitySlider.Leave) then
        UICoreFrameFadeIn(MOGUBarOpacitySlider, 0.5, 1, 0);
        MOGU_DelayCall(MOGUBarOpacitySlider_Hide, 0.5);
    end
end

function MOGUBarOpacitySlider_OnEnter(self)
    MOGUBarOpacitySlider.Leave = nil;
end

function MOGUBarOpacitySlider_OnLeave(self)
    if (MOGUBarOpacitySlider.frame) then
        MOGUBarOpacitySlider.Leave = 1;
    end
    MOGU_DelayCall(MOGUBarOpacitySlider_StartFade, 2);
end

function U1BAR_ActionButton_Update (self)
	local name = self:GetName();

	local action = self.action;
	local icon = _G[name.."Icon"];
	local buttonCooldown = _G[name.."Cooldown"];
	local texture = GetActionTexture(action);

	if ( HasAction(action) ) then

		if ( not self.eventsRegistered ) then
			self.eventsRegistered = true;

			self:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
			self:RegisterEvent("UPDATE_INVENTORY_ALERTS");
			self:RegisterEvent("PLAYER_TARGET_CHANGED");
			self:RegisterEvent("TRADE_SKILL_SHOW");
			self:RegisterEvent("TRADE_SKILL_CLOSE");
			self:RegisterEvent("PLAYER_ENTER_COMBAT");
			self:RegisterEvent("PLAYER_LEAVE_COMBAT");
			self:RegisterEvent("START_AUTOREPEAT_SPELL");
			self:RegisterEvent("STOP_AUTOREPEAT_SPELL");
			self:RegisterEvent("UNIT_ENTERED_VEHICLE");
			self:RegisterEvent("UNIT_EXITED_VEHICLE");
			self:RegisterEvent("UNIT_INVENTORY_CHANGED");
			self:RegisterEvent("LEARNED_SPELL_IN_TAB");
			self:RegisterEvent("PET_STABLE_UPDATE");
			self:RegisterEvent("PET_STABLE_SHOW");
			self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
			self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
            if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
                self:RegisterEvent("ARCHAEOLOGY_CLOSED");
                self:RegisterEvent("COMPANION_UPDATE");
            end
		end

		if ( not self:GetAttribute("statehidden") ) then
            if not InCombatLockdown() then
			    self:Show();
            end
		end
		ActionButton_UpdateState(self);
		ActionButton_UpdateUsable(self);
		ActionButton_UpdateCooldown(self);
		ActionButton_UpdateFlash(self);
	else


		if ( self.eventsRegistered ) then

			self:UnregisterEvent("ACTIONBAR_UPDATE_STATE");
			self:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
			self:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
			self:UnregisterEvent("PLAYER_TARGET_CHANGED");
			self:UnregisterEvent("TRADE_SKILL_SHOW");
			self:UnregisterEvent("TRADE_SKILL_CLOSE");
			self:UnregisterEvent("PLAYER_ENTER_COMBAT");
			self:UnregisterEvent("PLAYER_LEAVE_COMBAT");
			self:UnregisterEvent("START_AUTOREPEAT_SPELL");
			self:UnregisterEvent("STOP_AUTOREPEAT_SPELL");
			self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
			self:UnregisterEvent("LEARNED_SPELL_IN_TAB");
			self:UnregisterEvent("PET_STABLE_UPDATE");
			self:UnregisterEvent("PET_STABLE_SHOW");
            if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
				self:UnregisterEvent("UNIT_ENTERED_VEHICLE");
				self:UnregisterEvent("UNIT_EXITED_VEHICLE");
				self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
				self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
				-- self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
				self:UnregisterEvent("ARCHAEOLOGY_CLOSED");
				self:UnregisterEvent("COMPANION_UPDATE");
			elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
				self:UnregisterEvent("UNIT_ENTERED_VEHICLE");
				self:UnregisterEvent("UNIT_EXITED_VEHICLE");
				self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
				self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
			end
			self.eventsRegistered = nil;
		end

		if ( self:GetAttribute("showgrid") == 0 ) then
            if not InCombatLockdown() then
			    self:Hide();
            end
		else
			buttonCooldown:Hide();
		end
	end

	-- Add a green border if button is an equipped item
	local border = _G[name.."Border"];
	if ( IsEquippedAction(action) ) then
		border:SetVertexColor(0, 1.0, 0, 0.35);
		border:Show();
	else
		border:Hide();
	end

	-- Update Action Text
	local actionName = _G[name.."Name"];
	if ( not IsConsumableAction(action) and not IsStackableAction(action) ) then
		actionName:SetText(GetActionText(action));
	else
		actionName:SetText("");
	end

	-- Update icon and hotkey text
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		self.rangeTimer = -1;
		self:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
	else
		icon:Hide();
		buttonCooldown:Hide();
		self.rangeTimer = nil;
		self:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		local hotkey = _G[name.."HotKey"];
        if ( hotkey:GetText() == RANGE_INDICATOR ) then
			hotkey:Hide();
		else
			hotkey:SetVertexColor(0.6, 0.6, 0.6);
		end
	end
	ActionButton_UpdateCount(self);

	-- Update flyout appearance
	--ActionButton_UpdateFlyout(self);

	ActionButton_UpdateOverlayGlow(self);

	-- Update tooltip
	if ( GameTooltip:GetOwner() == self ) then
		ActionButton_SetTooltip(self);
	end

	self.feedback_action = action;
end

function U1BAR_ActionButton_OnEvent (self, event, ...)

	local arg1 = ...;
	if ((event == "UNIT_INVENTORY_CHANGED" and arg1 == "player") or event == "LEARNED_SPELL_IN_TAB") then
		if ( GameTooltip:GetOwner() == self ) then
			ActionButton_SetTooltip(self);
		end
	end
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == 0 or arg1 == tonumber(self.action) ) then
			U1BAR_ActionButton_Update(self);
		end
		return;
	end
	if ( event == "PLAYER_ENTERING_WORLD" or event == "UPDATE_SHAPESHIFT_FORM" ) then
		-- need to listen for UPDATE_SHAPESHIFT_FORM because attack icons change when the shapeshift form changes
		U1BAR_ActionButton_Update(self);
		return;
	end
	if ( event == "ACTIONBAR_PAGE_CHANGED" or event == "UPDATE_BONUS_ACTIONBAR" ) then
		ActionButton_UpdateAction(self);
		local actionType, id, subType = GetActionInfo(self.action);
		if ( actionType == "spell" and id == 0 ) then
			ActionButton_HideOverlayGlow(self);
		end
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		ActionButton_UpdateHotkeys(self, self.buttonType);
		return;
	end

	-- All event handlers below this line are only set when the button has an action

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		self.rangeTimer = -1;
	elseif ( (event == "ACTIONBAR_UPDATE_STATE") or
		((event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE") and (arg1 == "player")) or
		((event == "COMPANION_UPDATE") and (arg1 == "MOUNT")) ) then
		ActionButton_UpdateState(self);
	elseif ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		ActionButton_UpdateUsable(self);
	elseif ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		ActionButton_UpdateCooldown(self);
		-- Update tooltip
		if ( GameTooltip:GetOwner() == self ) then
			ActionButton_SetTooltip(self);
		end
	elseif ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE"  or event == "ARCHAEOLOGY_CLOSED" ) then
		ActionButton_UpdateState(self);
	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		if ( IsAttackAction(self.action) ) then
			ActionButton_StartFlash(self);
		end
	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		if ( IsAttackAction(self.action) ) then
			ActionButton_StopFlash(self);
		end
	elseif ( event == "START_AUTOREPEAT_SPELL" ) then
		if ( IsAutoRepeatAction(self.action) ) then
			ActionButton_StartFlash(self);
		end
	elseif ( event == "STOP_AUTOREPEAT_SPELL" ) then
		if ( ActionButton_IsFlashing(self) and not IsAttackAction(self.action) ) then
			ActionButton_StopFlash(self);
		end
	elseif ( event == "PET_STABLE_UPDATE" or event == "PET_STABLE_SHOW") then
		-- Has to update everything for now, but this event should happen infrequently
		U1BAR_ActionButton_Update(self);
	elseif ( event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" ) then
		local actionType, id, subType = GetActionInfo(self.action);
		if ( actionType == "spell" and id == arg1 ) then
			ActionButton_ShowOverlayGlow(self);
		end
	elseif ( event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" ) then
		local actionType, id, subType = GetActionInfo(self.action);
		if ( actionType == "spell" and id == arg1 ) then
			ActionButton_HideOverlayGlow(self);
		end
	end
end
