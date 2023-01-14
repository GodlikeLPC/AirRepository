local Check = nil;
local function GetCheck()
    if INTERFACEOPTIONS_ADDONCATEGORIES ~= nil then
        for _, panel in next, INTERFACEOPTIONS_ADDONCATEGORIES do
            if panel.name == "BattleInfo" then
                for _, v in next, { panel:GetChildren() } do
                    if v.text ~= nil and (
                        v.text:GetText() == "Show statistics panel" or
                        v.text:GetText() == "显示统计窗口" or
                        v.text:GetText() == "顯示統計面板"
                    ) then
                        return v;
                    end
                end
            end
        end
    end
end
local function ButtonOnClick(Button)
    Check = Check or GetCheck();
    if Check ~= nil then
        Check:Click();
        if Check:GetChecked() then
            PVPFrame.BattleInfoToggleTitle:SetText("<<");
        else
            PVPFrame.BattleInfoToggleTitle:SetText(">>");
        end
    end
end
local function PVPFrameOnShow(PVPFrame)
    Check = Check or GetCheck();
    if Check ~= nil then
        if Check:GetChecked() then
            PVPFrame.BattleInfoToggleTitle:SetText("<<");
        else
            PVPFrame.BattleInfoToggleTitle:SetText(">>");
        end
    end
end
local function Create()
    local Button = CreateFrame('BUTTON', nil, PVPFrame);
    Button:SetSize(15, 15);
    Button:SetPoint("TOP", PVPParentFrameCloseButton, "BOTTOM", -2, 0);
    local Title = Button:CreateFontString(nil, "ARTWORK");
    Title:SetFont(GameFontNormal:GetFont(), 14);
    Title:SetPoint("CENTER");
    PVPFrame.BattleInfoToggle = Button;
    PVPFrame.BattleInfoToggleTitle = Title;
    -- Button:SetNormalTexture([[Interface\PvPFrame\RandomPvPIcon]]);
    local HL = Button:CreateTexture(nil, "HIGHLIGHT");
    HL:SetColorTexture(1.0, 1.0, 1.0, 0.25);
    Button:SetHighlightTexture(HL);
    Button:SetScript("OnClick", ButtonOnClick);
    PVPFrame:HookScript("OnShow", PVPFrameOnShow);
end

U1RegisterAddon("BattleInfo", {
    title = "战场信息",
    tags = { "TAG_PVP", },
    desc = "战场信息，显示双方团员统计和据点统计",
    load = "LOGIN",
    defaultEnable = 0,
    -- icon = [[Interface\Addons\VanasKoS\Artwork\tie]],
    nopic = 1,

    runBeforeLoad = function(info, name)
        if Create ~= nil then
            Create();
            Create = nil;
        end
    end,
    runAfterLoad = function(info, name)
        if Create ~= nil then
            Create();
            Create = nil;
        end
    end,

});
