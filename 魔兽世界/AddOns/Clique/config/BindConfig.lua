--[[-------------------------------------------------------------------------
-- BindConfig.lua
--
-- This file contains the definitions of the binding configuration panel.
--
-- Events registered:
--   None
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

local libDropDown = LibStub("LibDropDown")
local MAX_ROWS = 12

function CliqueConfig:ShowWithSpellBook()
    self:ClearAllPoints()
    self:SetParent(SpellBookFrame)
    self:SetPoint("LEFT", SpellBookFrame, "RIGHT", 55, 0)
    self:Show()
end

function CliqueConfig:OnShow()
    if not self.initialized then
        self:SetupGUI()
        self:HijackSpellbook()
        self.initialized = true
    end

    -- Hide the alertTab if the spellbook isn't shown
    if SpellButton1:IsVisible() then
        self.bindAlert:Show()
    else
        self.bindAlert:Hide()
    end

    CliqueSpellTab:SetChecked(true)
    self:UpdateList()
    self:EnableSpellbookButtons()
    self:UpdateAlert()
end

function CliqueConfig:OnHide()
    self:ClearAllPoints()
    self:SetParent(UIParent)
    HideUIPanel(self)
    CliqueSpellTab:SetChecked(false)
    self:UpdateAlert()
end

function CliqueConfig:SetupTalents()
    if addon:ProjectIsClassic() then
        self.talents = {L["Default"]}
    else
        self.talents = {}
        for i = 1, addon:GetNumTalentSpecs() do
            local name = addon:GetTalentSpecName(i)
            self.talents[i] = name
        end
    end
end

function CliqueConfig:SetupGUI()
    self:SetupTalents()

    self.rows = {}
    for i = 1, MAX_ROWS do
        self.rows[i] = CreateFrame("Button", "CliqueRow" .. i, self.page1, "CliqueRowTemplate")
    end

    self.rows[1]:ClearAllPoints()
    self.rows[1]:SetPoint("TOPLEFT", self.page1.column1, "BOTTOMLEFT", 0, -3)
    self.rows[1]:SetPoint("RIGHT", self.page1.column2, "RIGHT", 0, 0)

    for i = 2, MAX_ROWS do
        self.rows[i]:ClearAllPoints()
        self.rows[i]:SetPoint("TOPLEFT", self.rows[i - 1], "BOTTOMLEFT")
        self.rows[i]:SetPoint("RIGHT", self.page1.column2, "RIGHT", 0, 0)
    end

    if self.TitleContainer then
        self.TitleContainer.TitleText:SetText(L["Clique Binding Configuration"])
    else
        self.TitleText:SetText(L["Clique Binding Configuration"])
    end

    self.dialog = _G["CliqueDialog"]
    self.dialog.title = self.dialog.TitleText
    self.dialog:SetUserPlaced(false)
    self.dialog:ClearAllPoints()
    self.dialog:SetPoint("CENTER", self, "CENTER", 30, 0)

    self.dialog.title:SetText(L["Set binding"])
    self.dialog.button_accept:SetText(L["Accept"])

    self.dialog.button_binding:SetText(L["Set binding"])
    local desc = L["In order to specify a binding, move your mouse over the button labelled 'Set binding' and either click with your mouse or press a key on your keyboard. You can modify the binding by holding down a combination of the alt, control and shift keys on your keyboard."]
    self.dialog.desc:SetText(desc)

    self.alert = _G["CliqueTabAlert"]

    self.bindAlert.text:SetText(L["You are in Clique binding mode"])

    self.close = _G[self:GetName() .. "CloseButton"]
    self.close:SetScript("OnClick", function()
        HideUIPanel(CliqueConfig)
    end)

    self.page1.column1:SetText(L["Action"])
    self.page1.column2:SetText(L["Binding"])

    -- Set columns up to handle sorting
    self.page1.column1.sortType = "name"
    self.page1.column2.sortType = "key"
    self.page1.sortType = self.page1.column2.sortType

    self.page1.button_spell:SetText(L["Bind spell"])
    self.page1.button_other:SetText(L["Bind other"])
    self.page1.button_options:SetText(L["Options"])

    self.page2.button_binding:SetText(L["Set binding"])
    self.page2.button_save:SetText(L["Save"])
    self.page2.button_cancel:SetText(L["Cancel"])
    local desc = L["You can use this page to create a custom macro to be run when activating a binding on a unit. When creating this macro you should keep in mind that you will need to specify the target of any actions in the macro by using the 'mouseover' unit, which is the unit you are clicking on. For example, you can do any of the following:\n\n/cast [target=mouseover] Regrowth\n/cast [@mouseover] Regrowth\n/cast [@mouseovertarget] Taunt\n\nHover over the 'Set binding' button below and either click or press a key with any modifiers you would like included. Then edit the box below to contain the macro you would like to have run when this binding is activated."]

    self.page2.desc:SetText(desc)
    self.page2.editbox = CliqueScrollFrameEditBox

    self.page1:Show()
end

function CliqueConfig:Column_OnClick(frame, button)
    self.page1.sortType = frame.sortType
    self:UpdateList()
end

function CliqueConfig:HijackSpellbook()
    self.spellbookButtons = {}

    for idx = 1, 12 do
        local parent = _G["SpellButton" .. idx]
        local button = CreateFrame("Button", "CliqueSpellbookButton" .. idx, parent, "CliqueSpellbookButtonTemplate")
        button.spellbutton = parent
        button:EnableKeyboard(false)
        button:EnableMouseWheel(true)
        button:RegisterForClicks("AnyDown")
        button:SetID(parent:GetID())
        self.spellbookButtons[idx] = button
    end

    SpellBookFrame:HookScript("OnShow", function(frame)
        self:EnableSpellbookButtons()
    end)
    SpellBookFrame:HookScript("OnHide", function(frame)
        self:EnableSpellbookButtons()
    end)

    self:EnableSpellbookButtons()
end

function CliqueConfig:EnableSpellbookButtons()
    local enabled;

    if self.page1:IsVisible() and SpellBookFrame:IsVisible() then
        enabled = true
    end

    if self.spellbookButtons then
        for idx, button in ipairs(self.spellbookButtons) do
            if enabled and addon:APIIsTrue(button.spellbutton:IsEnabled()) then
                button:Show()
            else
                button:Hide()
            end
        end
    end
end

-- Spellbook button functions
function CliqueConfig:Spellbook_EnableKeyboard(button, motion)
    button:EnableKeyboard(true)
end

function CliqueConfig:Spellbook_DisableKeyboard(button, motion)
    button:EnableKeyboard(false)
end

function CliqueConfig:Spellbook_OnBinding(button, key)
    if key == "ESCAPE" then
        HideUIPanel(CliqueConfig)
        return
    end

    local slot = SpellBook_GetSpellBookSlot(button:GetParent());
    local name, spellSubName, subtype = GetSpellBookItemName(slot, SpellBookFrame.bookType)
    local texture = GetSpellBookItemTexture(slot, SpellBookFrame.bookType)

    if spellSubName == "" then
        spellSubName = nil
    end

    local key = addon:GetCapturedKey(key)
    if not key then
        return
    end

    local succ, err = addon:AddBinding{
        key = key,
        type = "spell",
        spell = name,
        spellSubName = spellSubName,
        icon = texture
    }

    CliqueConfig:UpdateList()
end

function CliqueConfig:Button_OnClick(button)
    -- Click handler for "Bind spell" button
    if button == self.page1.button_spell then
        ShowUIPanel(SpellBookFrame)
        CliqueConfig:ShowWithSpellBook()

    -- Click handler for "Bind other" button
    elseif button == self.page1.button_other then
        local config = CliqueConfig

        if not button.menu then
            button.menu = libDropDown:NewMenu(button, "CliqueBindOtherDropdown")
            button.menu:SetAnchor("TOPLEFT", button, "TOPRIGHT", 15, 0)
            button.menu:SetStyle("MENU")
            button.menu:SetFrameStrata("DIALOG")

            button.menu:AddLine({
                text = L["Select a binding type"],
                isTitle = true,
            })
            button.menu:AddLine({
                text = L["Target clicked unit"],
                func = function()
                    self:SetupCaptureDialog("target")
                end,
            })
            button.menu:AddLine({
                text = L["Open unit menu"],
                func = function()
                    self:SetupCaptureDialog("menu")
                end,
                notCheckable = true,
            })
            button.menu:AddLine({
                text = L["Run custom macro"],
                func = function()
                    config.page1:Hide()
                    config.page2.bindType = "macro"
                    -- Clear out the entries
                    config.page2.bindText:SetText(L["No binding set"])
                    config.page2.editbox:SetText("")
                    config.page2.button_save:Disable()
                    config.page2:Show()
                end,
                notCheckable = true,
            })
        end
        button.menu:Toggle()
    -- Click handler for "Edit" button
    elseif button == self.page1.button_options then
        if not button.menu then
            button.menu = libDropDown:NewMenu(button, "CliqueOptionsButtonDropdown")
            button.menu:SetAnchor("TOPLEFT", button, "TOPRIGHT", 15, 0)
            button.menu:SetStyle("MENU")
            button.menu:SetFrameStrata("DIALOG")

            button.menu:AddLine({
                text = L["Select an options category"],
                isTitle = true,
            })
            button.menu:AddLine({
                text = L["Open options panel"],
                func = function()
                    HideUIPanel(SpellBookFrame)
                    HideUIPanel(CliqueConfig)
                    if Settings then
                        Settings.OpenToCategory(addonName)
                    elseif InterfaceOptionsFrame_OpenToCategory then
                        InterfaceOptionsFrame_OpenToCategory(addon.optpanels["GENERAL"])
                        InterfaceOptionsFrame_OpenToCategory(addon.optpanels["GENERAL"])
                    end
                end,
            })
        end
        button.menu:Toggle()

    elseif button == self.page2.button_save then
        -- Check the input
        local key = self.page2.key
        local macrotext = self.page2.editbox:GetText()

        if self.page2.binding then
            self.page2.binding.key = key
            self.page2.binding.macrotext = macrotext
            self.page2.binding = nil
            addon:FireMessage("BINDINGS_CHANGED")
        else
            local succ, err = addon:AddBinding{
                key = key,
                type = "macro",
                macrotext = macrotext,
            }
        end
        self:UpdateList()
        self.page2:Hide()
        self.page1:Show()
    elseif button == self.page2.button_cancel then
        self.page2.binding = nil
        self.page2:Hide()
        self.page1:Show()
    end
end

local memoizeBindings = setmetatable({}, {__index = function(t, k, v)
    local binbits = addon:GetBinaryBindingKey(k)
    rawset(t, k, binbits)
    return binbits
end})

local compareFunctions;
compareFunctions = {
    name = function(a, b)
        local texta = addon:GetBindingActionText(a.type, a)
        local textb = addon:GetBindingActionText(b.type, b)
        if texta == textb then
            return compareFunctions.key(a, b)
        end
        return texta < textb
    end,
    key = function(a, b)
        local keya = addon:GetBindingKey(a)
        local keyb = addon:GetBindingKey(b)
        if keya == keyb then
            return memoizeBindings[a] < memoizeBindings[b]
        elseif not keya or not keyb then
            return false
        else
            return keya < keyb
        end
    end,
    binding = function(a, b)
        local mem = memoizeBindings
		if mem[a] == mem[b] then
			return compareFunctions.name(a, b)
		else
			return mem[a] < mem[b]
		end
    end,
}

-- Mapping between binding entry and index in profile
function CliqueConfig:UpdateList()
    local page = self.page1
    local binds = addon.bindings

    -- GUI not created yet
    if not self.initialized then
        return
    elseif not self:IsVisible() then
        return
    end

    -- Sort the bindings
    local sort = {}
    for idx, entry in pairs(binds) do
        sort[#sort + 1] = entry
    end

    if page.sortType then
        table.sort(sort, compareFunctions[page.sortType])
    else
        table.sort(sort, compareFunctions.key)
    end

    -- Enable or disable the scroll bar
    if #sort > MAX_ROWS - 1 then
        -- Set up the scrollbar for the item list
        page.slider:SetMinMaxValues(0, #sort - MAX_ROWS)

        -- Adjust and show
        if not page.slider:IsShown() then
            -- Adjust column positions
            for idx, row in ipairs(self.rows) do
                row.bind:SetWidth(90)
            end
            page.slider:SetValue(0)
            page.slider:Show()
        end
    elseif page.slider:IsShown() then
        -- Move column positions back and hide the slider
        for idx, row in ipairs(self.rows) do
            row.bind:SetWidth(105)
        end
        page.slider:Hide()
    end

    -- Update the rows in the list
    local offset = page.slider:GetValue() or 0
    for idx, row in ipairs(self.rows) do
        local offsetIndex = offset + idx
        if sort[offsetIndex] then
            local bind = sort[offsetIndex]
            row.icon:SetTexture(addon:GetBindingIcon(bind))
            row.name:SetText(addon:GetBindingActionText(bind.type, bind))
            row.info:SetText(addon:GetBindingInfoText(bind))
            row.bind:SetText(addon:GetBindingKeyComboText(bind))
            row.binding = bind
            row:Show()
        else
            row:Hide()
        end
    end
end

function CliqueConfig:ClearEditPage()
end

function CliqueConfig:ShowEditPage()
    self:ClearEditPage()
    self.page1:Hide()
    self.page3:Show()
end

function CliqueConfig:Save_OnClick(button, down)
end

function CliqueConfig:Cancel_OnClick(button, down)
    self:ClearEditPage()
    self.page3:Hide()
    self.page1:Show()
end

function CliqueConfig:SetupCaptureDialog(type, binding)
    self.dialog.bindType = type
    self.dialog.binding = binding

    if not binding then
        local actionText = addon:GetBindingActionText(type, binding)
        self.dialog.title:SetText(L["Set binding: %s"]:format(actionText))
    else
        -- This is a change to an existing binding
        local actionText = addon:GetBindingActionText(type, binding)
        self.dialog.title:SetText(L["Change binding: %s"]:format(actionText))
    end

    self.dialog.bindText:SetText("")
    self.dialog:Show()
end

function CliqueConfig:BindingButton_OnClick(button, key)
    local dialog = CliqueDialog
    dialog.key = addon:GetCapturedKey(key)
    if dialog.key then
        CliqueDialog.bindText:SetText(addon:GetBindingKeyComboText(dialog.key))
    end
end

function CliqueConfig:MacroBindingButton_OnClick(button, key)
    local key = addon:GetCapturedKey(key)
    if key then
        self.page2.key = key
        self.page2.bindText:SetText(addon:GetBindingKeyComboText(key))
        self.page2.button_save:Enable()
    else
        self.page2.bindText:SetText(L["No binding set"])
        self.page2.button_save:Disable()
    end
end

function CliqueConfig:AcceptSetBinding()
    local dialog = CliqueDialog
    local key = dialog.key

    if dialog.binding then
        -- This was a CHANGE binding instead of a SET binding
        dialog.binding.key = key
        dialog.binding = nil
        -- Do not forget to update the attributes as well
        self:UpdateList()
        addon:FireMessage("BINDINGS_CHANGED")
    else
        local succ, err = addon:AddBinding{
            key = key,
            type = dialog.bindType,
        }
        if succ then
            self:UpdateList()
        end
    end
    dialog:Hide()
end

local function toggleSet(binding, set, ...)
    local exclude = {}
    for i = 1, select("#", ...) do
        local item = select(i, ...)
        table.insert(exclude, item)
    end

    return function(line, button)
        if not binding.sets then
            binding.sets = {}
        end
        if binding.sets[set] then
            binding.sets[set] = nil
        else
            binding.sets[set] = true
        end

        for idx, exclset in ipairs(exclude) do
            binding.sets[exclset] = nil
        end

        local checked = not not binding.sets[set]

        line:SetCheckedState(checked)

        CliqueConfig:UpdateList()
        addon:FireMessage("BINDINGS_CHANGED")
    end
end

function CliqueConfig:Row_OnClick(frame, button)
    local binding = frame.binding
    local actionText = addon:GetBindingActionText(binding.type, binding)

    if not self.rowDropdown then
        self.rowDropdown = libDropDown:NewMenu(frame, "CliqueRowDropdown")
        self.rowDropdown:SetStyle("MENU")
        self.rowDropdown:SetFrameStrata("DIALOG")
    end

    local menu = self.rowDropdown
    local scale = frame:GetEffectiveScale()
    local x, y = GetCursorPosition()
    menu:ClearAllPoints()
    menu:SetPoint("CENTER", nil, "BOTTOMLEFT", x / scale, y / scale)

    menu:ClearLines()
    menu:AddLine({
        text = L["Configure binding: '%s'"]:format(actionText:sub(1,15)),
        isTitle = true,
    })

    if binding.type == "macro" then
        menu:AddLine({
            text = L["Edit macro"],
            func = function()
                self.page2.bindType = "macro"
                local bindText = addon:GetBindingKeyComboText(binding)
                self.page2.bindText:SetText(bindText)
                self.page2.binding = binding
                self.page2.key = binding.key
                self.page2.editbox:SetText(binding.macrotext)
                self.page2.button_save:Enable()
                self.page1:Hide()
                self.page2:Show()
            end,
        })
    else

        menu:AddLine({
            text = L["Change binding"],
            func = function()
                local binding = frame.binding
                self:SetupCaptureDialog(binding.type, binding)
            end,
        })
    end

    menu:AddLine({
        text = L["Delete binding"],
        func = function()
            addon:DeleteBinding(frame.binding)
            self:UpdateList()
        end,
    })

    if binding.type == "spell" and binding.spellSubName then
        -- Enable a 'Remove Rank' option
        menu:AddLine({
            text = L["Remove spell rank"],
            func = function()
                local binding = frame.binding
                binding.spellSubName = nil
                self:UpdateList()
                addon:FireMessage("BINDINGS_CHANGED")
            end,
        })
    end

    -- Bind set submenu
    local subMenu = {}
    table.insert(subMenu, {
        text = L["Default"],
        checked = function() return binding.sets["default"] end,
        func = toggleSet(binding, "default"),
        tooltipTitle = L["Clique: 'default' binding-set"],
        tooltip = L["A binding that belongs to the 'default' binding-set will always be active on your unit frames, unless you override it with another binding."],
        keepShown = true,
    })

    table.insert(subMenu, {
        text = L["Friend"],
        checked = function() return binding.sets["friend"] end,
        func = toggleSet(binding, "friend"),
        tooltipTitle = L["Clique: 'friend' binding-set"],
        tooltip = L["A binding that belongs to the 'friend' binding-set will only be active when clicking on unit frames that display friendly units, i.e. those you can heal and assist. If you click on a unit that you cannot heal or assist, nothing will happen."],
        keepShown = true,
    })

    table.insert(subMenu, {
        text = L["Enemy"],
        checked = function() return binding.sets["enemy"] end,
        func = toggleSet(binding, "enemy"),
        tooltipTitle = L["Clique: 'enemy' binding-set"],
        tooltip = L["A binding that belongs to the 'enemy' binding-set will always be active when clicking on unit frames that display enemy units, i.e. those you can attack. If you click on a unit that you cannot attack, nothing will happen."],
        keepShown = true,
    })

    table.insert(subMenu, {
        text = L["Out-of-combat (ONLY)"],
        checked = function() return binding.sets["ooc"] end,
        func = toggleSet(binding, "ooc"),
        tooltipTitle = L["Clique: 'ooc' binding-set"],
        tooltip = L["A binding that belongs to the 'ooc' binding-set will only be active when the player is out-of-combat, regardless of the other binding-sets this binding belongs to. As soon as the player enters combat, these bindings will no longer be active, so be careful when choosing this binding-set for any spells you use frequently."],
        keepShown = true,
    })

    -- Add some buttons for the talent specs
    for i = 1, #self.talents do
        local key = "spec" .. i
        table.insert(subMenu, {
            text = L["Talents: %s"]:format(self.talents[i]),
            checked = function() return binding.sets[key] end,
            func = toggleSet(binding, key),
            tooltipTitle = L["Clique: talent set '%s' (%d) binding-set"]:format(self.talents[i], i),
            tooltip = L["A binding that belongs to this binding-set is only active when the player has the given talent specialization active"],
            keepShown = true,
        })
    end

    table.insert(subMenu, {
        text = L["Hovercast bindings (target required)"],
        checked = function() return binding.sets["hovercast"] end,
        func = toggleSet(binding, "hovercast", "global"),
        tooltipTitle = L["Clique: 'hovercast' binding-set"],
        tooltip = L["A binding that belongs to the 'hovercast' binding-set is active whenever the mouse is over a unit frame, or a character in the 3D world. This allows you to use 'hovercasting', where you hover over a unit in the world and press a key to cast a spell on them. THese bindings are also active over unit frames."],
        keepShown = false,
    })

    table.insert(subMenu, {
        text = L["Global bindings (no target)"],
        checked = function() return binding.sets["global"] end,
        func = toggleSet(binding, "global", "hovercast"),
        tooltipTitle = L["Clique: 'global' binding-set"],
        tooltip = L["A binding that belongs to the 'global' binding-set is always active. If the spell requires a target, you will be given the 'casting hand', otherwise the spell will be cast. If the spell is an AOE spell, then you will be given the ground targeting circle."],
        keepShown = false,
    })

    menu:AddLine({
        text = L["Enable/Disable binding-sets"],
        menu = subMenu,
        keepShown = true,
    })

    menu:Toggle()
end

function CliqueConfig:SpellTab_OnClick(frame)
    if self:IsVisible() then
        HideUIPanel(CliqueConfig)
    elseif SpellBookFrame:IsVisible() then
        self:ShowWithSpellBook()
    else
        ShowUIPanel(CliqueConfig)
    end
end

function CliqueConfig:UpdateAlert(type)
    local alert = CliqueTabAlert
    if not addon.settings.alerthidden and SpellBookFrame:IsVisible() and CliqueConfig:IsVisible() then
        alert.type = type
        alert.text:SetText(L["When both the Clique binding configuration window and the spellbook are open, you can set new bindings simply by performing them on the spell icon in your spellbook. Simply move your mouse over a spell and then click or press a key on your keyboard along with any combination of the alt, control, and shift keys. The new binding will be added to your binding configuration."])
        alert:Show()
    else
        alert:Hide()
    end
end
