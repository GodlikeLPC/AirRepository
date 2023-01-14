local addon = ...
--/run ObjectiveTrackerBonusBannerFrame_PlayBanner(ObjectiveTrackerBonusBannerFrame, 41318)
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown;
local _CFG = {  };

local U1CT = WW:Frame("U1CT", UIParent):Size(90, 27):TOP(0, -50)
:CreateTexture():Key("bg"):ALL():SetAtlas("search-select"):up()
:CreateFontString():Key("text"):CENTER():SetFont(NumberFontNormal:GetFont(), "18", "OUTLINE")
:SetText("0.00"):SetTextColor(0, 1, 0):up()
:CreateAnimationGroup():Key("Anim"):SetLooping("BOUNCE")
:CreateAnimation("Scale"):SetChildKey("bg"):SetDuration(0.2):SetFromScale(0.8, 1):SetToScale(1, 1):up()
:CreateAnimation("Alpha"):SetChildKey("bg"):SetDuration(0.2):SetFromAlpha(0.5):SetToAlpha(1):up()
:up():un()
CoreUIMakeMovable(U1CT)

local function U1CT_Enter(encounter)
    if encounter then U1CT.encounter = true end
    if U1CT.start then return end

    U1CT.StartTimer(true)

    if _CFG["enter_anim"] then
        U1CT.PlayBanner(true)
    end

    if _CFG["enter_sound"] then
        U1CT.PlaySound(true)
    end
end

local function U1CT_Leave(encounter)
    if not U1CT.start then return end
    if U1CT.encounter and not encounter then return end
    U1CT.encounter = nil

    U1CT.StartTimer(false)

    if _CFG["leave_anim"] then
        U1CT.PlayBanner(false)
    end

    if _CFG["leave_sound"] then
        U1CT.PlaySound(false)
    end
end

U1CT.onUpdate = function(self, elapsed)
    if not InCombatLockdown() then
        U1CT_Leave(true);
        U1CT_Leave(false);
        return
    end
    --self.timer = self.timer + elapsed
    local now = GetTime()
    local combat = now - self.start
    if combat < 60 then
        self.text:SetText(format("%.2f", combat))
    else
        self.text:SetText(format("%d:%04.1f", combat / 60, combat % 60))
    end
end

function U1CT.Set(key, val)
    _CFG[key] = val;
end
function U1CT.PlayBanner(enter)
    local banner, title, label
    if enter then
        banner = CombatTimerEnterBanner
        CombatTimerLeaveBanner:Hide()
        title = _CFG["enter_anim/title"] or ""
        label = _CFG["enter_anim/label"] or "战斗开始"
    else
        banner = CombatTimerLeaveBanner
        CombatTimerEnterBanner:Hide()
        title = _CFG["leave_anim/title"] or "战斗结束"
    end

    banner:Show()
	banner.Title:SetText(title);
	banner.TitleFlash:SetText(title);
	if label then banner.BonusLabel:SetText(label); end

    local trackerFrame = U1CT:IsVisible() and U1CT or banner
    -- offsets for anims
    local x, y = trackerFrame:GetCenter()
    local xb, yb = banner:GetCenter()
	local xOffset = (x - xb) * 0.8
	local yOffset = (y - yb) * 0.8
    banner.Anim.BG1Translation:SetOffset(xOffset, yOffset);
    banner.Anim.TitleTranslation:SetOffset(xOffset, yOffset);
    if label then
        banner.Anim.BonusLabelTranslation:SetOffset(xOffset, yOffset);
        banner.Anim.IconTranslation:SetOffset(xOffset, yOffset);
    end
	-- show and play
	banner:Show();
	banner.Anim:Stop();
	banner.Anim:Play();
end

function U1CT.PlaySound(enter)
    if enter then
        local ogg = _CFG["enter_sound/ogg"]
        PlaySoundFile(ogg)
    else
        PlaySoundFile("Sound\\Character\\EmoteCatCallWhistle02.ogg")
        -- PlaySound(7963)
    end
end

function U1CT.StartTimer(start)
    if start then
        U1CT.start = GetTime()
        U1CT:SetScript("OnUpdate", U1CT.onUpdate)
        U1CT.text:SetTextColor(1, .2, .2, 1)
        U1CT.Anim:Play()
    else
        U1CT.start = nil
        U1CT.text:SetTextColor(0, 1, 0, 1)
        U1CT:SetScript("OnUpdate", nil)
        U1CT.Anim:Stop()
    end
end

U1CT:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" or event == "ENCOUNTER_START" then
        U1CT_Enter(event == "ENCOUNTER_START")
    elseif event == "PLAYER_REGEN_ENABLED" or event == "ENCOUNTER_END" then
        U1CT_Leave(event == "ENCOUNTER_END")
    end
end)

U1CT.tooltipTitle = "网易有爱战斗计时"
U1CT.tooltipLines = "网易有爱战斗计时`进入/离开战斗提示`记录战斗持续时间`<右键点击>进行设置"
U1CT:SetScript("OnEnter", function()
    if InCombatLockdown() then return end
    CoreUIShowTooltip(U1CT, "ANCHOR_BOTTOM")
end)
U1CT:SetScript("OnLeave", function(self) if GameTooltip:GetOwner() == self then GameTooltip:Hide() end end)
U1CT:HookScript("OnMouseUp", function(self, button)
    if button == "RightButton" and not InCombatLockdown() then
        UUI.OpenToAddon("163UI_CombatTimer", true)
    end
end)