--[[
    @ALA / ALEX
--]]

do return end

local Localized = {
    enUS = {
        FOLLOW_UNIT = "Keep following unit",
        FOLLOWING = "Following",
        STOP_FOLLOWING = "Stop",
    },
    zhCN = {
        FOLLOW_UNIT = "一直跟随目标",
        FOLLOWING = "正在跟随",
        STOP_FOLLOWING = "点击停止跟随",
    },
    zhTW = {
        FOLLOW_UNIT = "一直跟随目标",
        FOLLOWING = "正在跟随",
        STOP_FOLLOWING = "点击停止跟随",
    },
};

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

local locale = GetLocale();
local L = Localized[locale] or Localized.enUS;

local AddFriend = C_FriendList and C_FriendList.AddFriend or AddFriend or function() end
local SendWho = C_FriendList and C_FriendList.SendWho or SendWho or function() end
local FollowUnit = FollowUnit;
local UnitClassBase = UnitClassBase;

local cancel_follow = CreateFrame("Button", nil, UIParent);
cancel_follow:SetSize(64, 64);
cancel_follow:EnableMouse(true);
cancel_follow:RegisterForClicks("AnyUp");
cancel_follow:SetNormalTexture("interface\\buttons\\ui-grouploot-pass-up");
cancel_follow:SetPoint("CENTER", 0, 250);
cancel_follow:Hide();
local text_stop = cancel_follow:CreateFontString(nil, "OVERLAY");
text_stop:SetFont(GameFontNormal:GetFont(), 24, "OUTLINE");
text_stop:SetPoint("TOP", cancel_follow, "BOTTOM", 0, -4);
text_stop:SetTextColor(1.0, 0.75, 0.0);
text_stop:SetText(L.STOP_FOLLOWING);
text_stop:Show();
local info = cancel_follow:CreateFontString(nil, "OVERLAY");
info:SetFont(GameFontNormal:GetFont(), 24, "OUTLINE");
info:SetPoint("BOTTOM", cancel_follow, "TOP", 0, 4);
info:Show();

local _FOLLOWING_NAME = nil;
C_Timer.NewTicker(0.5, function()
    if _FOLLOWING_NAME then
        FollowUnit(_FOLLOWING_NAME);
    end
end);

local function start_follow(unit, name)
    _FOLLOWING_NAME = name;
    cancel_follow:Show();
    local class = UnitClassBase(unit);
    if class then
        local color = RAID_CLASS_COLORS[class];
        info:SetText(string.format(L.FOLLOWING .. " [\124cff%.2x%.2x%.2x%s\124r]", color.r * 255, color.g * 255, color.b * 255, name));
    else
        info:SetText(L.FOLLOWING .. " [" .. name .. "]")
    end
end
local function stop_follow()
    cancel_follow:Hide();
    _FOLLOWING_NAME = nil;
end

cancel_follow:SetScript("OnClick", stop_follow);
-- cancel_follow:SetScript("OnUpdate", function() end);

alaPopup.add_meta("FOLLOW_UNIT",
    {
        L.FOLLOW_UNIT, 
        function(which, frame)
            if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
                start_follow(frame.unit, frame.name .. "-" .. frame.server);
            else
                start_follow(frame.unit, frame.name);
            end
        end,
    }
);

alaPopup.add_list("PLAYER", "FOLLOW_UNIT");
alaPopup.add_list("PARTY", "FOLLOW_UNIT");
alaPopup.add_list("_BRFF_PARTY", "FOLLOW_UNIT");
alaPopup.add_list("RAID", "FOLLOW_UNIT");
alaPopup.add_list("RAID_PLAYER", "FOLLOW_UNIT");
alaPopup.add_list("_BRFF_RAID_PLAYER", "FOLLOW_UNIT");

if UnitPopup_OnClick ~= nil then
    hooksecurefunc("UnitPopup_OnClick", function(self, info)
        if self.value == "FOLLOW_UNIT" then
            start_follow(UIDROPDOWNMENU_INIT_MENU.unit, UIDROPDOWNMENU_INIT_MENU.name);
        -- elseif self.value == "NOT_FOLLOW_UNIT" then
            -- _FOLLOWING_NAME = nil;
        end
    end)
end

_G.SLASH_163STARTFOLLOW1 = "/startfollow";
SlashCmdList["163STARTFOLLOW"] = function(msg)
    local name = strsplit("[ ,]", strtrim(msg));
    if name ~= "" then
        return start_follow(name, name);
    end
end

_G.SLASH_163STOPFOLLOW1 = "/stopfollow";
SlashCmdList["163STOPFOLLOW"] = function(msg)
    return stop_follow();
end
