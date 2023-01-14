---------------- > Show tooltips when hovering a link in chat (credits to Adys for his LinkHover)
    local function showlink(anchor, link)
		GameTooltip:SetOwner(anchor, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(link);
		GameTooltip:Show();
    end
    local function _OnHyperlinkEnter(_this, linkData, link)
        -- if control_hyperLinkHoverShow then
            local t = linkData:match("^(.-):");
            -- if LinkHoverType[t] then
            if t then
                pcall(showlink, _this, link);
            end
        -- end
    end
    local function _OnHyperlinkLeave(_this, linkData, link)
        -- if control_hyperLinkHoverShow then
            if GameTooltip:IsOwned(_this) then
            --local t = linkData:match("^(.-):");
            --if LinkHoverType[t] then
                GameTooltip:Hide();
            end
        -- end
    end
    local function on()
        for i = 1, NUM_CHAT_WINDOWS do
            local frame = _G["ChatFrame"..i]
            frame:SetScript("OnHyperlinkEnter", _OnHyperlinkEnter)
            frame:SetScript("OnHyperlinkLeave", _OnHyperlinkLeave)
        end
    end
    local function off()
        for i = 1, NUM_CHAT_WINDOWS do
            local frame = _G["ChatFrame"..i]
            frame:SetScript("OnHyperlinkEnter", nil)
            frame:SetScript("OnHyperlinkLeave", nil)
        end
    end
--
--  Colored name in tooltip for CommunitiesFrame
    local _COMMUNITY_MEMBER_CHARACTER_INFO_FORMAT = gsub(COMMUNITY_MEMBER_CHARACTER_INFO_FORMAT, "%%d", "%%s");
    local function OnEnter(self)
        if self.expanded then
            if not self.NameFrame.Name:IsTruncated() and not self.Rank:IsTruncated() and not self.Note:IsTruncated() and not self.Zone:IsTruncated() then
                return;
            end
        end

        local memberInfo = self:GetMemberInfo();
        if memberInfo then
            GameTooltip:SetOwner(self);
            local name = nil;
            if memberInfo.classID then
                local classInfo = C_CreatureInfo.GetClassInfo(memberInfo.classID);
                if classInfo then
                    local color = RAID_CLASS_COLORS[classInfo.classFile];
                    if color then
                        name = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, memberInfo.name);
                    end
                end
            end
            GameTooltip:AddLine(name or memberInfo.name);

            local clubId = self:GetMemberList():GetSelectedClubId();
            if clubId ~= nil then
                local clubInfo = C_Club.GetClubInfo(clubId);
                if not clubInfo or clubInfo.clubType == Enum.ClubType.Guild then
                    GameTooltip:AddLine(memberInfo.guildRank or "");
                else
                    local memberRoleId = memberInfo.role;
                    if memberRoleId then
                        GameTooltip:AddLine(COMMUNITY_MEMBER_ROLE_NAMES[memberRoleId], HIGHLIGHT_FONT_COLOR:GetRGB());
                    end
                end
            end

            if memberInfo.level and memberInfo.race and memberInfo.classID then
                local raceInfo = C_CreatureInfo.GetRaceInfo(memberInfo.race);
                local classInfo = C_CreatureInfo.GetClassInfo(memberInfo.classID);
                if raceInfo and classInfo then
                    local dColor = GetQuestDifficultyColor(memberInfo.level);
                    local level = format(" \124cff%.2x%.2x%.2x%s\124r", dColor.r * 255, dColor.g * 255, dColor.b * 255, memberInfo.level);
                    local className = nil;
                    local color = RAID_CLASS_COLORS[classInfo.classFile];
                    if color then
                        className = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, classInfo.className);
                    end
                    GameTooltip:AddLine(_COMMUNITY_MEMBER_CHARACTER_INFO_FORMAT:format(level, raceInfo.raceName, className or classInfo.className), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true);
                end
            end

            if memberInfo.presence == Enum.ClubMemberPresence.OnlineMobile then
                GameTooltip:AddLine(COMMUNITIES_PRESENCE_MOBILE_CHAT, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true);
            elseif memberInfo.zone then
                if memberInfo.zone == GetRealZoneText() then
                    GameTooltip:AddLine(memberInfo.zone, 0, 1, 0, true);
                else
                    GameTooltip:AddLine(memberInfo.zone, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true);
                end
            end

            if memberInfo.memberNote then
                GameTooltip:AddLine(COMMUNITY_MEMBER_NOTE_FORMAT:format(memberInfo.memberNote), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
            end

            GameTooltip:Show();
        end
    end
    local function proc_hook_CommunitiesFrame()
        -- CommunitiesFrame.MemberList.ListScrollFrame.scrollChild;
        CommunitiesMemberListEntryMixin.OnEnter = OnEnter;
        local buttons = CommunitiesFrame.MemberList.ListScrollFrame.buttons;
        for index = 1, #buttons do
            buttons[index].OnEnter = OnEnter;
            buttons[index]:SetScript("OnEnter", OnEnter);
        end
    end
    local function hook_CommunitiesFrame()
        if IsAddOnLoaded("blizzard_communities") then
            proc_hook_CommunitiesFrame();
        else
            local f = CreateFrame("FRAME");
            f:RegisterEvent("ADDON_LOADED");
            f:SetScript("OnEvent", function(self, event, addon)
                if strlower(addon) == "blizzard_communities" then
                    f:UnregisterAllEvents();
                    f:SetScript("OnEvent", nil);
                    f = nil;
                    proc_hook_CommunitiesFrame();
                end
            end);
        end
    end
--
on();
hook_CommunitiesFrame();
