if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
local DGV = DugisGuideViewer
local UIE = DGV.Modules.UIEventHandlers

UIE.GearOptionItemButton = {}
function UIE.GearOptionItemButton.OnShow(widget, ...)
    local item = widget:GetParent().item
    local name, texture, _
    if item then
        name, _, _, _, _, _, _, _, _, texture = GetItemInfo(item)

    else
        name, texture = DugisGuideViewer.Modules.GearAdvisorEquip:GetSlotBackgroundInfo(DugisEquipPromptFrame.slot)
    end
    widget.Name:SetText(name);
    SetItemButtonTexture(widget, texture)
    SetItemButtonNameFrameVertexColor(widget, 1.0, 1.0, 1.0);
end

UIE.ResetBanButton = {}
function UIE.ResetBanButton.OnClick(widget, ...)
    if DugisGuideViewer.chardb.GA_Blacklist then
        wipe(DugisGuideViewer.chardb.GA_Blacklist)
        DugisGuideViewer.Modules.GearAdvisorEquip.ContinueEquip(true)
    end
    local parent = widget:GetParent()
    parent.action = "CANCEL"
    parent.blacklist:SetChecked(false)
    parent:Hide()
end

UIE.BlacklistCheckButton = {}
function UIE.BlacklistCheckButton.OnClick(widget, ...)
    local checked = widget:GetChecked()
    local forAll = widget:GetParent().forAll
    if checked then
        forAll:SetChecked(false)
        forAll:Disable()
        forAll.text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
        DugisGuideViewer.Modules.GearAdvisorEquip:OnGearOptionClicked(DugisEquipPromptFrameExistingGearOptionItemButton:GetParent())
        DugisEquipItemHighlight:SetPoint("TOPLEFT", DugisEquipPromptFrameExistingGearOptionItemButton, "TOPLEFT", -8, 7)
        DugisEquipItemHighlight:Show()
    else
        forAll:Enable()
        forAll.text:SetTextColor(1.0, 0.82, 0)
        DugisGuideViewer.Modules.GearAdvisorEquip:OnGearOptionClicked(DugisEquipPromptFrameRecommendedGearOptionItemButton:GetParent())
        DugisEquipItemHighlight:SetPoint("TOPLEFT", DugisEquipPromptFrameRecommendedGearOptionItemButton, "TOPLEFT", -8, 7)
        DugisEquipItemHighlight:Show()
    end
end

UIE.DugisEquipPromptFrame = {}
function UIE.DugisEquipPromptFrame.OnHide(widget, ...)
    DugisGuideViewer.Modules.GearAdvisorEquip:OnPromptHidden(widget)
end