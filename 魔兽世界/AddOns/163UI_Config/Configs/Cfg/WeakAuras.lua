

local ShowCode, Import;
local ShowCode2, Import2;
local function OnShow(self)
    if Import == nil then
        local b = {};
        local List = { self:GetChildren() };
        for _, v in next, List do
            if v:GetName() == "WeakAurasTooltipImportButton" then
                tinsert(b, v);
            end
        end
        if #b >= 2 then
            local l1, l2 = b[1]:GetLeft(), b[2]:GetLeft();
            if l1 > l2 then
                ShowCode, Import = b[2], b[1];
            else
                ShowCode, Import = b[1], b[2];
            end
        end
        Import2 = CreateFrame('BUTTON', nil, WeakAurasTooltipAnchor, "UIPanelButtonTemplate");
        Import2:SetSize(Import:GetSize());
        Import2:SetText(Import:GetText());
        Import2:SetPoint("TOPLEFT", WeakAurasTooltipAnchor, "TOPRIGHT", 4, 0);
        Import2:Hide();
        Import2:SetScript("OnClick", function(self) self.__super:Click(); end);
        Import2.__super = Import;
        ShowCode2 = CreateFrame('BUTTON', nil, WeakAurasTooltipAnchor, "UIPanelButtonTemplate");
        ShowCode2:SetSize(ShowCode:GetSize());
        ShowCode2:SetText(ShowCode:GetText());
        ShowCode2:SetPoint("TOP", Import2, "BOTTOM", 0, -12);
        ShowCode2:Hide();
        ShowCode2:SetScript("OnClick", function(self) self.__super:Click(); end);
        ShowCode2.__super = ShowCode;
    end
    if Import ~= nil then
        if Import:GetBottom() < Import:GetHeight() * 0.333 then
            Import2:SetSize(Import:GetSize());
            Import2:SetText(Import:GetText());
            Import2:Show();
            ShowCode2:SetSize(ShowCode:GetSize());
            ShowCode2:SetText(ShowCode:GetText());
            ShowCode2:Show();
        else
            Import2:Hide();
            ShowCode2:Hide();
        end
    end
end
local function hook()
    if WeakAurasTooltipAnchor ~= nil then
        WeakAurasTooltipAnchor:HookScript("OnShow", OnShow);
    else
        C_Timer.After(1.0, hook);
    end
end
U1RegisterAddon("WeakAuras", {
    title = "WA 法术监控",
    defaultEnable = 0,
    load = "NORMAL",
    minimap = 'LibDBIcon10_WeakAuras', 
    tags = { "TAG_SPELL", },
    icon = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\icon.blp",
    desc = "简单又强大的状态监控模块，和TellMeWhen任选一个喜欢的就好，https://wago.io/weakauras 有一些字符串可以导入",

    minimap = "LibDBIcon10_WeakAuras",

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList.WEAKAURAS("") end,
    },
    runBeforeLoad = function(info, name)
        hook();
    end,
});

U1RegisterAddon("WeakAurasModelPaths", { parent = "WeakAuras", title = "WeakAuras: 模型库", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasOptions", { parent = "WeakAuras", title = "WeakAuras: 配置界面", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasTemplates", { parent = "WeakAuras", title = "WeakAuras: 预设模板", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasArchive", { parent = "WeakAuras", title = "WeakAuras: 档案库", protected = nil, hide = nil });
