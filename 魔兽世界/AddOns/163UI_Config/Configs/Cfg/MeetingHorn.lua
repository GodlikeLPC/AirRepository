U1RegisterAddon("MeetingHorn", {
    title = "集结号",
    tags = { "TAG_RAID", },
    desc = "集结号 组队工具",
    load = "NORMAL",
    defaultEnable = 1,
	minimap = 'LibDBIcon10_MeetingHorn', 
    icon = [[Interface\Addons\MeetingHorn\Media\Logo2]],
    nopic = 1,
    runBeforeLoad = function(info, name)
        if LibStub and LibStub('AceLocale-3.0') then
            local L = LibStub('AceLocale-3.0'):GetLocale('MeetingHorn', true);
            if L then
                L.SUMMARY_NEW_VERSION = "|cff00ffff%s|r 当前版本: " .. (GetAddOnMetadata('MeetingHorn', 'Version') or "%s");
            end
        end
        local function Proc(F)
            local w, h = F:GetSize();
            local h2 = F.TitleBg and F.TitleBg:GetHeight() or 17;
            F:SetClampRectInsets(w / 2, -w / 2, -(h - h2 - 7), h - h2 - 5);
        end
        local F = MeetingHornMainPanel;
        if F ~= nil then
            F:HookScript("OnShow",Proc);
        else
            local Ticker;
            Ticker = C_Timer.NewTicker(1.0, function()
                local F = MeetingHornMainPanel;
                if F ~= nil then
                    F:HookScript("OnShow",Proc);
                    Proc(F);
                    Ticker:Cancel();
                    Ticker = nil;
                end
            end);
        end
    end,
    {
        text = "打开关闭界面",
        callback = function(cfg, v, loading)
            if  LibStub and  LibStub('AceAddon-3.0') then
                local addon =  LibStub('AceAddon-3.0'):GetAddon('MeetingHorn', true);
                if addon then
                    addon:Toggle();
                end
            end
        end
    },
});
