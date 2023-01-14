local addonName, ns = ...
local AceGUI = LibStub("AceGUI-3.0")
local L = Aptechka.L
local AddTooltip = ns.WidgetAddTooltip

local function AddAsterix(aceWidget)
    local t = aceWidget.frame:CreateTexture(nil, "ARTWORK")
    t:SetAtlas("VignetteKill")
    t:SetSize(15,15)
    t:SetVertexColor(0,1,0)
    t:SetPoint("TOPRIGHT", -4, -1)
    t:Hide()
    aceWidget.asterix = t
    return t

    -- mechagon-projects
    -- GreenCross
    -- VignetteKill
end

function ns.AddSlider(form, relWidth, title, dataKey, defaultValue, min, max, step, onChangedCallback)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel(title)
    slider:SetSliderValues(min, max, step)
    slider:SetRelativeWidth(relWidth)
    slider:SetCallback("OnValueChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v >= min and v <= max then
            self.parent.target[dataKey] = v
        else
            self.parent.target[dataKey] = defaultValue
            self:SetText(self.parent.target[dataKey] or "1")
        end
        onChangedCallback(self.parent, dataKey, value)
    end)
    form.controls[dataKey] = slider
    form:AddChild(slider)
    AddAsterix(slider)
    return slider
end

function ns.AddDropdown(form, relWidth, title, dataKey, defaultValue, values, onChangedCallback)
    local dropdown = AceGUI:Create("Dropdown")
    dropdown:SetLabel(title)
    dropdown:SetRelativeWidth(relWidth)
    dropdown:SetList(values)
    dropdown:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.target[dataKey] = value
        onChangedCallback(self.parent, dataKey, value)
    end)
    form.controls[dataKey] = dropdown
    form:AddChild(dropdown)
    AddAsterix(dropdown)
    return dropdown
end

function ns.AddEditbox(form, relWidth, title, dataKey, defaultValue, onChangedCallback)
    local dropdown = AceGUI:Create("EditBox")
    dropdown:SetLabel(title)
    dropdown:SetRelativeWidth(relWidth)
    dropdown:SetCallback("OnEnterPressed", function(self, event, value)
        self.parent.target[dataKey] = value
        onChangedCallback(self.parent, dataKey, value)
    end)
    form.controls[dataKey] = dropdown
    form:AddChild(dropdown)
    AddAsterix(dropdown)
    return dropdown
end

function ns.AddFontDropdown(form, relWidth, title, dataKey, defaultValue, onChangedCallback)
    local dropdown = AceGUI:Create("LSM30_Font")
    dropdown:SetLabel(title)
    dropdown:SetRelativeWidth(relWidth)
    dropdown:SetList() -- Internally it falls back to LibStub("LibSharedMedia-3.0"):HashTable("font")
    dropdown:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.target[dataKey] = value
        self:SetValue(value or defaultValue)
        onChangedCallback(self.parent, dataKey, value)
    end)
    form.controls[dataKey] = dropdown
    AddAsterix(dropdown)
    form:AddChild(dropdown)
end

function ns.AddCheckbox(form, relWidth, title, dataKey, defaultValue, onChangedCallback)
    local checkbox = AceGUI:Create("CheckBox")
    checkbox:SetLabel(title)
    checkbox:SetRelativeWidth(relWidth)
    checkbox:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.target[dataKey] = value
        onChangedCallback(self.parent, dataKey, value)
    end)
    form.controls[dataKey] = checkbox
    form:AddChild(checkbox)
    AddAsterix(checkbox)
    return checkbox
end

function ns.InitForm()
    local form = AceGUI:Create("ScrollFrame")
    form:SetFullWidth(true)
    form:SetLayout("Flow")
    form.opts = {}
    form.controls = {}
    form.SetTargetWidget = function(form, name, isProfile)
        assert(name)
        form.isProfile = isProfile
        form.widgetName = name
        local popts, gopts
        if isProfile then
            popts, gopts = Aptechka:GetWidgetsOptionsOrCreate(name)
        else
            popts, gopts = Aptechka:GetWidgetsOptions(name)
        end
        local opts = Aptechka:GetWidgetsOptionsMerged(name)
        form.target = isProfile and opts or gopts
        form.Fill(form, name, form.target, popts, gopts, isProfile)
    end

    form.Refill = function(form)
        local name = form.widgetName
        local isProfile = form.isProfile
        local popts, gopts = Aptechka:GetWidgetsOptions(name)
        local opts = Aptechka:GetWidgetsOptionsMerged(name)
        form.Fill(form, name, form.target, popts, gopts, isProfile)
    end
    return form
end

local framePoints = {
    TOPLEFT = "TOPLEFT",
    TOPRIGHT = "TOPRIGHT",
    BOTTOMLEFT = "BOTTOMLEFT",
    BOTTOMRIGHT = "BOTTOMRIGHT",
    CENTER = "CENTER",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
    TOP = "TOP",
    BOTTOM = "BOTTOM",
}

ns.WidgetForms = {}

local function callbackUpdateForm(form, key, value)
    local name = form.widgetName
    Aptechka:ReconfigureWidget(name)
    form:Refill();
    AptechkaOptions.widgetConfig.header:Update()
end
local function callbackUpdateFormAndTree(form, key, value)
    callbackUpdateForm(form, key, value)
    AptechkaOptions.widgetConfig.tree:UpdateWidgetTree()
end

local function MakeControlSetter(setFuncName)
    return function(form, key, opts, gopts, isProfile)
        local control = form.controls[key]
        control[setFuncName](control, opts[key])
        if opts == gopts then
            control.asterix:Hide()
        else
            if opts[key] ~= gopts[key] then
                control.asterix:Show()
            else
                opts[key] = nil
                control.asterix:Hide()
            end
        end
    end
end
local Control_SetValue = MakeControlSetter("SetValue")
local Control_SetText = MakeControlSetter("SetText")

local function CreateAnchorSettings(form)
    local point = ns.AddDropdown(form, 0.3, L"Point", "point", "TOPLEFT", framePoints, callbackUpdateForm)
    local xoffset = ns.AddSlider(form, 0.3, L"X Offset", "x", 0, -200, 200, 0.5, callbackUpdateForm)
    local yoffset = ns.AddSlider(form, 0.3, L"Y Offset", "y", 0, -200, 200, 0.5, callbackUpdateForm)
end
local function FillAnchorSettings(form, opts, popts, gopts)
    Control_SetValue(form, "point", opts, gopts)
    Control_SetValue(form, "x", opts, gopts)
    Control_SetValue(form, "y", opts, gopts)
end


local tooltipOnEnter = function(self, event)
    GameTooltip:SetOwner(self.frame, "ANCHOR_TOPLEFT")
    local spells = Aptechka:ListSpellsForWidget(self.form.widgetName)
    if next(spells) then
        for cat, list in pairs(spells) do
            GameTooltip:AddLine(string.upper(cat))
            for _, spellData in ipairs(list) do
                GameTooltip:AddLine(string.format("    |T%d:0|t %s", spellData[2], spellData[1]))
            end
        end
    else
        GameTooltip:AddLine("None")
    end
    GameTooltip:Show();
end
local tooltipOnLeave = function(self, event)
    GameTooltip:Hide();
end
local function CreateSpellListingButton(form)
    local spellList = AceGUI:Create("Button")
    spellList:SetText(L"List Widget Spells")
    spellList:SetRelativeWidth(0.7)
    spellList:SetCallback("OnEnter", tooltipOnEnter)
    spellList:SetCallback("OnLeave", tooltipOnLeave)
    form:AddChild(spellList)
    spellList.form = form
    form.controls["spellList"] = spellList
    return spellList
end

local function CreateDisable(form)
    local disabled = ns.AddCheckbox(form, 0.25, L"Disabled", "disabled", false, callbackUpdateFormAndTree)
    CreateSpellListingButton(form)
end
local function FillDisable(form, opts, popts, gopts)
    Control_SetValue(form, "disabled", opts, gopts)
end

local function CreateSizeSettings(form)
    local height = ns.AddSlider(form, 0.46, L"Height", "height", 20, 2, 100, 0.5, callbackUpdateForm)
    local width = ns.AddSlider(form, 0.46, L"Width", "width", 20, 2, 100, 0.5, callbackUpdateForm)
end
local function FillSizeSettings(form, opts, popts, gopts)
    Control_SetValue(form, "height", opts, gopts)
    Control_SetValue(form, "width", opts, gopts)
end

local growthDirections = {
    UP = "UP",
    DOWN = "DOWN",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
}

local function CreateArraySettings(form)
    local growth = ns.AddDropdown(form, 0.46, L"Growth Direction", "growth", "UP", growthDirections, callbackUpdateForm)
    local max = ns.AddSlider(form, 0.46, L"Max Size", "max", 4, 0, 10, 1, callbackUpdateForm)
end
local function FillArraySettings(form, opts, popts, gopts)
    Control_SetValue(form, "growth", opts, gopts)
    Control_SetValue(form, "max", opts, gopts)
end

-- Icon

local function CreateBaseIconSettings(form)
    CreateSizeSettings(form)
    CreateAnchorSettings(form)
    local font = ns.AddFontDropdown(form, 0.46, L"Stacks Font", "font", AptechkaDefaultConfig.defaultFont, callbackUpdateForm)
    local textsize = ns.AddSlider(form, 0.46, L"Font Size", "textsize", 12, 6, 30, 1, callbackUpdateForm)
    local alpha = ns.AddSlider(form, 0.95, L"Alpha", "alpha", 1, 0, 1, 0.05, callbackUpdateForm)
    local outline = ns.AddCheckbox(form, 0.46, L"Outline", "outline", false, callbackUpdateForm)
    local edge = ns.AddCheckbox(form, 0.46, L"Edge", "edge", true, callbackUpdateForm)
end
local function FillBaseIconSettings(form, opts, popts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)

    Control_SetValue(form, "font", opts, gopts)
    Control_SetValue(form, "textsize", opts, gopts)
    Control_SetValue(form, "alpha", opts, gopts)
    Control_SetValue(form, "outline", opts, gopts)
    Control_SetValue(form, "edge", opts, gopts)
end

ns.WidgetForms.Icon = {}
function ns.WidgetForms.Icon.Create(form)
    form = form or ns.InitForm()

    CreateDisable(form)
    CreateBaseIconSettings(form)

    return form
end

function ns.WidgetForms.Icon.Fill(form, name, opts, popts, gopts)
    FillDisable(form, opts, popts, gopts)
    FillBaseIconSettings(form, opts, popts, gopts)
end

-- ProgressIcon
ns.WidgetForms.ProgressIcon = ns.WidgetForms.Icon

-- IconArray
ns.WidgetForms.IconArray = {}
function ns.WidgetForms.IconArray.Create(form)
    form = form or ns.WidgetForms.Icon.Create(form)
    CreateArraySettings(form)
    return form
end

function ns.WidgetForms.IconArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.Icon.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
end

-- BarIcon
ns.WidgetForms.BarIcon = {}
function ns.WidgetForms.BarIcon.Create(form)
    form = form or ns.WidgetForms.Icon.Create(form)
    local vertical = ns.AddCheckbox(form, 0.95, L"Vertical Bar", "vertical", false, callbackUpdateForm)

    return form
end
function ns.WidgetForms.BarIcon.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.Icon.Fill(form, name, opts, popts, gopts)
    Control_SetValue(form, "vertical", opts, gopts)
end

-- BarIconArray
ns.WidgetForms.BarIconArray = {}
function ns.WidgetForms.BarIconArray.Create(form)
    form = form or ns.WidgetForms.BarIcon.Create(form)
    CreateArraySettings(form)
    return form
end

function ns.WidgetForms.BarIconArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.BarIcon.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
end

-- DebuffIcon

ns.WidgetForms.DebuffIcon = {}

local borderStyles = {
    STRIP_RIGHT = "Right Strip",
    STRIP_BOTTOM = "Bottom Strip",
    CORNER = "Corner",
    BORDER = "Border",
    NONE = "None",
}
function ns.WidgetForms.DebuffIcon.Create(form)
    form = form or ns.InitForm()

    CreateBaseIconSettings(form)
    local style = ns.AddDropdown(form, 0.46, L"Border Style", "style", "STRIP_RIGHT", borderStyles, callbackUpdateForm)
    local animdir = ns.AddDropdown(form, 0.46, L"Animation Direction", "animdir", "LEFT", growthDirections, callbackUpdateForm)
    return form
end

function ns.WidgetForms.DebuffIcon.Fill(form, name, opts, popts, gopts)
    FillBaseIconSettings(form, opts, popts, gopts)
    Control_SetValue(form, "style", opts, gopts)
    Control_SetValue(form, "animdir", opts, gopts)
end

-- DebuffIconArray

ns.WidgetForms.DebuffIconArray = {}
function ns.WidgetForms.DebuffIconArray.Create(form)
    form = form or ns.WidgetForms.DebuffIcon.Create(form)
    CreateArraySettings(form)
    local bigscale = ns.AddSlider(form, 0.46, L"Boss Scale", "bigscale", 1.3, 1, 2, 0.05, callbackUpdateForm)

    local test = AceGUI:Create("Button")
    test:SetText(L"Test Debuffs")
    test:SetRelativeWidth(0.46)
    test:SetCallback("OnClick", function(self, event)
        Aptechka.TestDebuffSlots()
    end)
    form:AddChild(test)

    return form
end

function ns.WidgetForms.DebuffIconArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.DebuffIcon.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
    Control_SetValue(form, "bigscale", opts, gopts)
end


-- Indicator
ns.WidgetForms.Indicator = {}
function ns.WidgetForms.Indicator.Create(form)
    form = form or ns.InitForm()

    CreateDisable(form)
    CreateSizeSettings(form)
    CreateAnchorSettings(form)

    return form
end

function ns.WidgetForms.Indicator.Fill(form, name, opts, popts, gopts)
    FillDisable(form, opts, popts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)
end

-- IndicatorArray

ns.WidgetForms.IndicatorArray = {}
function ns.WidgetForms.IndicatorArray.Create(form)
    form = form or ns.WidgetForms.Indicator.Create(form)
    CreateArraySettings(form)
    return form
end

function ns.WidgetForms.IndicatorArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.Indicator.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
end

-- Bar

ns.WidgetForms.Bar = {}
function ns.WidgetForms.Bar.Create(form)
    form = form or ns.InitForm()

    CreateDisable(form)
    CreateSizeSettings(form)
    CreateAnchorSettings(form)
    local vertical = ns.AddCheckbox(form, 0.95, L"Vertical Bar", "vertical", false, callbackUpdateForm)

    return form
end

function ns.WidgetForms.Bar.Fill(form, name, opts, popts, gopts)
    FillDisable(form, opts, popts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)
    Control_SetValue(form, "vertical", opts, gopts)
end

-- BarArray

ns.WidgetForms.BarArray = {}
function ns.WidgetForms.BarArray.Create(form)
    form = form or ns.WidgetForms.Bar.Create(form)
    CreateArraySettings(form)
    return form
end

function ns.WidgetForms.BarArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.Bar.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
end


-- Text

local textEffects = {
    NONE = "None",
    SHADOW = "Shadow",
    OUTLINE = "Outline",
}
local justifyDirections = {
    CENTER = "CENTER",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
}

ns.WidgetForms.Text = {}
function ns.WidgetForms.Text.Create(form)
    form = form or ns.InitForm()

    CreateDisable(form)
    CreateAnchorSettings(form)
    local font = ns.AddFontDropdown(form, 0.46, L"Font", "font", AptechkaDefaultConfig, callbackUpdateForm)
    local textsize = ns.AddSlider(form, 0.46, L"Font Size", "textsize", 12, 6, 30, 1, callbackUpdateForm)
    local effect = ns.AddDropdown(form, 0.46, L"Effect", "effect", "NONE", textEffects, callbackUpdateForm)

    local bg = ns.AddCheckbox(form, 0.95, L"Background", "bg", false, callbackUpdateForm)
    CreateSizeSettings(form)
    local bgAlpha = ns.AddSlider(form, 0.46, L"Background Alpha", "bgAlpha", 0.5, 0, 1, 0.05, callbackUpdateForm)
    local padding = ns.AddSlider(form, 0.46, L"Padding", "padding", 0, 0, 10, 0.5, callbackUpdateForm)
    local justify = ns.AddDropdown(form, 0.46, L"Justify", "justify", "CENTER", justifyDirections, callbackUpdateForm)
    local zorder = ns.AddSlider(form, 0.46, L"Z-Order", "zorder", 0, -10, 10, 1, callbackUpdateForm)

    return form
end

function ns.WidgetForms.Text.Fill(form, name, opts, popts, gopts)
    FillDisable(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)
    Control_SetValue(form, "font", opts, gopts)
    Control_SetValue(form, "textsize", opts, gopts)
    Control_SetValue(form, "effect", opts, gopts)

    Control_SetValue(form, "bg", opts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    Control_SetValue(form, "bgAlpha", opts, gopts)
    Control_SetValue(form, "padding", opts, gopts)
    Control_SetValue(form, "justify", opts, gopts)
    Control_SetValue(form, "zorder", opts, gopts)
end

ns.WidgetForms.TextArray = {}
function ns.WidgetForms.TextArray.Create(form)
    form = form or ns.WidgetForms.Text.Create(form)
    CreateArraySettings(form)
    return form
end

function ns.WidgetForms.TextArray.Fill(form, name, opts, popts, gopts)
    ns.WidgetForms.Text.Fill(form, name, opts, popts, gopts)
    FillArraySettings(form, opts, popts, gopts)
end

-- StaticText

ns.WidgetForms.StaticText = ns.WidgetForms.Text

-- Texture

ns.WidgetForms.Texture = {}

local rotationAngles = {
    [0] = "0°",
    [90] = "90°",
    [180] = "180°",
    [270] = "270°",
}
local blendModes = {
    ADD = "ADD",
    BLEND = "BLEND",
}

function ns.WidgetForms.Texture.Create(form)
    form = form or ns.InitForm()

    CreateDisable(form)
    CreateSizeSettings(form)
    CreateAnchorSettings(form)
    local texture = ns.AddEditbox(form, 0.95, L"Texture", "texture", "", callbackUpdateForm)
    local rotation = ns.AddDropdown(form, 0.46, L"Rotation", "rotation", 0, rotationAngles, callbackUpdateForm)
    local zorder = ns.AddSlider(form, 0.46, L"Z-Order", "zorder", 0, -10, 10, 1, callbackUpdateForm)
    local alpha = ns.AddSlider(form, 0.46, L"Alpha", "alpha", 1, 0, 1, 0.05, callbackUpdateForm)
    local blendmode = ns.AddDropdown(form, 0.46, L"Blend Mode", "blendmode", "BLEND", blendModes, callbackUpdateForm)
    local disableOverrides = ns.AddCheckbox(form, 0.95, L"Disable Texture Overrides", "disableOverrides", false, callbackUpdateForm)

    return form
end

function ns.WidgetForms.Texture.Fill(form, name, opts, popts, gopts)
    FillDisable(form, opts, popts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)
    Control_SetText(form, "texture", opts, gopts)
    Control_SetValue(form, "rotation", opts, gopts)
    Control_SetValue(form, "zorder", opts, gopts)
    Control_SetValue(form, "alpha", opts, gopts)
    Control_SetValue(form, "blendmode", opts, gopts)
    Control_SetValue(form, "disableOverrides", opts, gopts)
end

ns.WidgetForms.FloatingIcon = {}

function ns.WidgetForms.FloatingIcon.Create(form)
    form = form or ns.InitForm()

    CreateSizeSettings(form)
    CreateAnchorSettings(form)
    local angle = ns.AddSlider(form, 0.46, L"Angle", "angle", 0, 0, 360, 1, callbackUpdateForm)
    local spreadArc = ns.AddSlider(form, 0.46, L"Spread Arc", "spreadArc", 30, 0, 120, 1, callbackUpdateForm)
    local range = ns.AddSlider(form, 0.46, L"Range", "range", 45, 0, 200, 1, callbackUpdateForm)
    local animDuration = ns.AddSlider(form, 0.46, L"Anim Length", "animDuration", 1.5, 0, 10, 0.1, callbackUpdateForm)

    local test = AceGUI:Create("Button")
    test:SetText(L"Test Icons")
    test:SetRelativeWidth(0.46)
    test:SetCallback("OnClick", function(self, event)
        Aptechka:TestBuffGains()
    end)
    form:AddChild(test)

    return form
end

function ns.WidgetForms.FloatingIcon.Fill(form, name, opts, popts, gopts)
    FillSizeSettings(form, opts, popts, gopts)
    FillAnchorSettings(form, opts, popts, gopts)
    Control_SetValue(form, "angle", opts, gopts)
    Control_SetValue(form, "spreadArc", opts, gopts)
    Control_SetValue(form, "range", opts, gopts)
    Control_SetValue(form, "animDuration", opts, gopts)
end
