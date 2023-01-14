--[[-------------------------------------------------------------------------
-- BlizzardFramesConfig.lua
--
-- This file contains the definitions of the blizzard frame integration
-- options. These settings will not apply until the user interface is
-- reloaded.
--
-- Events registered:
--   - None
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

--[[---------------------------------------------------------------------------
--  Options panel definition
---------------------------------------------------------------------------]]--

local panel = CreateFrame("Frame")
panel.name = "Blizzard Frame Options"
panel.parent = addonName

addon.optpanels["BLIZZFRAMES"] = panel

panel:SetScript("OnShow", function(self)
    if not panel.initialized then
        panel:CreateOptions()
        panel.refresh()
    end
end)

local function make_checkbox(name, label)
    local frame = CreateFrame("CheckButton", "CliqueOptionsBlizzFrame" .. name, panel, "UICheckButtonTemplate")
    frame.text = _G[frame:GetName() .. "Text"]
    frame.type = "checkbox"
    frame.text:SetText(label)
    return frame
end

local function make_label(name, template)
    local label = panel:CreateFontString("CliqueOptionsBlizzFrame" .. name, "OVERLAY", template)
    label:SetWidth(panel:GetWidth())
    label:SetJustifyH("LEFT")
    label.type = "label"
    return label
end

function panel:CreateOptions()
    panel.initialized = true

    local bits = {}
    self.intro = make_label("Intro", "GameFontHighlightSmall")
    self.intro:SetText(L["These options control whether or not Clique automatically registers certain Blizzard-created frames for binding. Changes made to these settings will not take effect until the user interface is reloaded."])
    self.intro:SetPoint("RIGHT")
    self.intro:SetJustifyV("TOP")
    self.intro:SetHeight(40)

    self.PlayerFrame = make_checkbox("PlayerFrame", L["Player frame"])
    self.PetFrame = make_checkbox("PetFrame", L["Player's pet frame"])
    self.TargetFrame = make_checkbox("TargetFrame", L["Player's target frame"])
    self.TargetFrameToT = make_checkbox("TargetFrameToT", L["Target of target frame"])
    self.party = make_checkbox("Party", L["Party member frames"])
    self.compactraid = make_checkbox("CompactRaid", L["Compact raid frames"])
    self.boss = make_checkbox("BossTarget", L["Boss target frames"])

    self.FocusFrame = make_checkbox("FocusFrame", L["Player's focus frame"])
    self.FocusFrameToT = make_checkbox("FocusFrameToT", L["Target of focus frame"])
    self.arena = make_checkbox("ArenaEnemy", L["Arena enemy frames"])

    table.insert(bits, self.intro)
    table.insert(bits, self.PlayerFrame)
    table.insert(bits, self.PetFrame)
    table.insert(bits, self.TargetFrame)
	table.insert(bits, self.TargetFrameToT)

    -- No focus frames in Classic
    if not addon:ProjectIsClassic() then
        table.insert(bits, self.FocusFrame)
        table.insert(bits, self.FocusFrameToT)
    end

    -- Arena comes in in retail
    if addon:ProjectIsRetail() then
        table.insert(bits, self.arena)
    end

    -- Group these together
    bits[1]:SetPoint("TOPLEFT", 5, -5)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end

    local last = bits[#bits]

---@diagnostic disable-next-line: undefined-field
    table.wipe(bits)
    table.insert(bits, self.party)
    table.insert(bits, self.compactraid)
    table.insert(bits, self.boss)

    bits[1]:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -15)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end
end

function panel.refresh()
    xpcall(function()
    if not panel.initialized then
        panel:CreateOptions()
    end

    local opt = addon.settings.blizzframes

    panel.PlayerFrame:SetChecked(opt.PlayerFrame)
    panel.PetFrame:SetChecked(opt.PetFrame)
    panel.TargetFrame:SetChecked(opt.TargetFrame)
    panel.TargetFrameToT:SetChecked(opt.TargetFrameToT)

    if not addon:ProjectIsClassic() then
        panel.FocusFrame:SetChecked(opt.FocusFrame)
        panel.FocusFrameToT:SetChecked(opt.FocusFrameToT)
    end

    if addon:ProjectIsRetail() then
        panel.arena:SetChecked(opt.arena)
    end

    panel.party:SetChecked(opt.party)
    panel.compactraid:SetChecked(opt.compactraid)
    panel.boss:SetChecked(opt.boss)
    end, geterrorhandler())
end

function panel.okay()
    xpcall(function()
    local opt = addon.settings.blizzframes
    opt.PlayerFrame = not not panel.PlayerFrame:GetChecked()
    opt.PetFrame = not not panel.PetFrame:GetChecked()
    opt.TargetFrame = not not panel.TargetFrame:GetChecked()
    opt.TargetFrameToT = not not panel.TargetFrameToT:GetChecked()

    if not addon:ProjectIsClassic() then
        opt.FocusFrame = not not panel.FocusFrame:GetChecked()
        opt.FocusFrameToT = not not panel.FocusFrameToT:GetChecked()
    end

    if addon:ProjectIsRetail() then
        opt.arena = not not panel.arena:GetChecked()
    end

    opt.party = not not panel.party:GetChecked()
    opt.compactraid = not not panel.compactraid:GetChecked()
    opt.boss = not not panel.boss:GetChecked()
    end, geterrorhandler())
end

InterfaceOptions_AddCategory(panel, addon.optpanels.ABOUT)
