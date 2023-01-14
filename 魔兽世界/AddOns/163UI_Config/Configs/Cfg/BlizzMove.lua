
local function ApplyPos(key, frame)
    local __blizzmove = GLOBAL_EXTRA_SAVED.__blizzmove;
    local pos = __blizzmove[key];
    if pos ~= nil then
        frame:ClearAllPoints();
        frame:SetPoint(pos[1], pos[2] or UIParent, pos[3], pos[4], pos[5]);
    end
end
local function SavePos(key, frame)
    local __blizzmove = GLOBAL_EXTRA_SAVED.__blizzmove;
    local pos = { frame:GetPoint() };
    if pos[2] ~= nil then
        pos[2] = pos[2]:GetName() or "UIParent";
    end
    __blizzmove[key] = pos;
    ApplyPos(frame:GetName(), frame);
end


local function OnMouseDown(self)
    local frameToMove = self.frameToMove;
    if frameToMove.__163ui__dragable then
        if frameToMove:IsMovable() then
            local IsUserPlaced = frameToMove:IsUserPlaced();
            frameToMove:StartMoving();
            frameToMove:SetUserPlaced(IsUserPlaced);
        end
    end
end
local function OnMouseUp(self)
	local frameToMove = self.frameToMove;
	frameToMove:StopMovingOrSizing();
    if not self.DoNotSavePos then
        SavePos(frameToMove:GetName(), frameToMove);
    end
end

local function SetMoveHandle(frameToMove, handle)
	if frameToMove then
        handle = handle or frameToMove;
        handle.frameToMove = frameToMove;

        if frameToMove.EnableMouse then
            frameToMove:SetMovable(true);
            handle:RegisterForDrag("LeftButton");

            handle:SetScript("OnMouseDown", OnMouseDown);
            handle:SetScript("OnMouseUp", OnMouseUp);
        end
	end
end

local function Create(FrameToMove, novisual)
    local Dragger = CreateFrame('FRAME', nil, FrameToMove);
    Dragger:SetAllPoints();
    Dragger:Hide();
    Dragger:EnableMouse(true);
    Dragger:SetMovable(true);
    Dragger:SetClampedToScreen(true);
    Dragger:SetFrameLevel(1);
    if not novisual then
        local BGBody = Dragger:CreateTexture(nil, "BACKGROUND");
        BGBody:SetPoint("TOPRIGHT", 0, 0);
        BGBody:SetPoint("TOPLEFT", 0, 0);
        BGBody:SetHeight(20);
        BGBody:SetColorTexture(0.0, 0.0, 0.0, 1.0);
        local BGHead = Dragger:CreateTexture(nil, "BACKGROUND");
        BGHead:SetPoint("BOTTOMRIGHT", 0, 0);
        BGHead:SetPoint("BOTTOMLEFT", 0, 0);
        BGHead:SetHeight(45);
        BGHead:SetColorTexture(0.0, 0.0, 0.0, 0.5);
        local Label = Dragger:CreateFontString(nil, "BORDER", "GameFontNormal");
        Label:SetPoint("RIGHT", Dragger, "TOPRIGHT", -2, -10);
        Label:SetText("左键拖动此处来移动");
        Dragger.BGBody = BGBody;
        Dragger.BGHead = BGHead;
        Dragger.Label = Label;
    end
    --
    FrameToMove.__163ui_dragger = Dragger;
    SetMoveHandle(FrameToMove, Dragger);
    --
    return Dragger;
end

local function RetainPos(Frame)
    local SkipRetainPos = false;
    hooksecurefunc(Frame, "SetPoint", function(...)
        if SkipRetainPos then
            return;
        end
        if Frame.__163ui__movable then
            SkipRetainPos = true;
            ApplyPos(Frame:GetName(), Frame);
            SkipRetainPos = false;
        end
    end);
end

U1RegisterAddon("BlizzMove", {
    title = "面板移动",
    desc = "移动系统的界面框体，支持几乎所有的系统面板，如拍卖行、法术书、好友公会等等，并且支持按住SHIFT拖动玩家能量界面，例如骑士圣能、死骑符文、萨满图腾、鹌鹑日蚀、术士灵魂碎片。` `按住Ctrl点击任意面板可以设置是否保存面板位置；Ctrl+Alt+Shift点击可以重置为默认位置；在面板上按住Ctrl并滚动鼠标滚轮可以缩放面板大小。",
    secure = 1,
    load = "LOGIN",
    defaultEnable = 1,

    tags = { "TAG_INTERFACE", },
    icon = [[Interface\Icons\INV_Gizmo_GoblinBoomBox_01]],
    ------- Options --------
    -- {
    --     var = "powerbar",
    --     text = "允许移动职业能量界面",
    --     tip = "说明`（拖动需要按住SHIFT键）是否允许移动各职业特有的能量界面，包括骑士圣能、死骑符文、萨满图腾、鹌鹑日蚀、术士灵魂碎片，此选项可能会与一些职业专用插件冲突，所以请在遇到问题时关闭。",
    --     reload = 1,
    --     default = 1,
    --     --删除Callback是因为初始DB的情况无法处理，只能用U1GetCfgValue
    -- },
    {
        var = "moveWatchFrame",
        text = "允许移动任务追踪框",
        tip = "说明`允许移动任务追踪框。`注意，此选项可能跟某些插件冲突，导致找不到任务追踪框，请关闭并重载界面。",
        -- reload = 1,
        default = 1,
        callback = function(cfg, v, loading)
            local WatchFrame = WatchFrame;
            if WatchFrame:IsProtected() then
                return;
            end
            if v then
                WatchFrame:SetMovable(true);
                WatchFrame:SetDontSavePosition(true);
                -- if loading then
                --     ApplyPos(WatchFrame:GetName(), WatchFrame);
                -- end
                if WatchFrame.__163ui_dragger == nil then
                    -- local Pos = nil;
                    if GLOBAL_EXTRA_SAVED.__blizzmove ~= nil then
                        -- Pos = GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame;
                        GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame = nil;
                    end
                    local Dragger = Create(WatchFrame, true);
                    Dragger:ClearAllPoints();
                    Dragger:SetPoint("TOPRIGHT", 0, 0);
                    Dragger:SetPoint("TOPLEFT", 0, 0);
                    Dragger:SetHeight(32);
                    -- hooksecurefunc("UIParent_UpdateTopFramePositions", function()
                    --     if WatchFrame.__163ui__movable then
                    --         ApplyPos(WatchFrame:GetName(), WatchFrame);
                    --     end
                    -- end);
                    RetainPos(WatchFrame);
                    local function OnSize(Frame)
                        local w, h = Frame:GetSize();
                        Frame:SetClampRectInsets(w * 0.25, -w * 0.25, 0, max(h - 48, 0));
                    end
                    hooksecurefunc(WatchFrame, "SetWidth", OnSize);
                    hooksecurefunc(WatchFrame, "SetHeight", OnSize);
                    hooksecurefunc(WatchFrame, "SetSize", OnSize);
                    OnSize(WatchFrame);
                    -- if Pos ~= nil then
                    --     if IsLoggedIn() then
                    --         C_Timer.After(0.1, function()
                    --             if WatchFrame.__163ui__movable and GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame == nil then
                    --                 GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame = Pos;
                    --                 ApplyPos(WatchFrame:GetName(), WatchFrame);
                    --             end
                    --         end);
                    --     else
                    --         local F = CreateFrame('FRAME');
                    --         F:RegisterEvent("LOADING_SCREEN_DISABLED");
                    --         F:SetScript("OnEvent", function(self)
                    --             self:UnregisterEvent("LOADING_SCREEN_DISABLED");
                    --             C_Timer.After(2.0, function()
                    --                 if WatchFrame.__163ui__movable and GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame == nil then
                    --                     GLOBAL_EXTRA_SAVED.__blizzmove.WatchFrame = Pos;
                    --                     ApplyPos(WatchFrame:GetName(), WatchFrame);
                    --                 end
                    --             end);
                    --         end);
                    --     end
                    -- end
                end
                WatchFrame.__163ui__movable = true;
                WatchFrame.__163ui__dragable = U1GetCfgValue("blizzmove", "moveWatchFrame/dragable");
                if WatchFrame.__163ui__dragable then
                    WatchFrame.__163ui_dragger:Show();
                end
            elseif not loading then
                WatchFrame:SetMovable(false);
                WatchFrame.__163ui__movable = nil;
                if WatchFrame.__163ui_dragger ~= nil then
                    WatchFrame.__163ui_dragger:Hide();
                end
            end
        end,
        {
            var = "dragable",
            text = "允许拖动",
            tip = "说明`开启此选项将允许玩家拖动任务追踪框。`打开此选项，将框架拖动到想要摆放的位置然后关闭此选项防止误拖动。",
            -- reload = 1,
            default = 1,
            callback = function(cfg, v, loading)
                WatchFrame.__163ui__dragable = not not v;
                if WatchFrame.__163ui_dragger ~= nil then
                    WatchFrame.__163ui_dragger:SetShown(v);
                end
            end,
        },
    },--]]
    {
        var = "movecastbar",
        text = "允许移动施法条",
        tip = "说明`允许移动施法条，施法条出现的时候，用鼠标拖动就可以移了，建议炉石的时候移。`注意，此选项可能跟某些插件冲突，导致找不到施法条，请关闭并重载界面。",
        -- reload = 1,
        callback = function(cfg, v, loading)
            local CastingBarFrame = CastingBarFrame;
            if v then
                CastingBarFrame:SetMovable(true);
                -- CastingBarFrame:SetUserPlaced(true);
                CastingBarFrame:SetDontSavePosition(true);
                CastingBarFrame:SetClampedToScreen(true);
                if loading then
                    ApplyPos(CastingBarFrame:GetName(), CastingBarFrame);
                end
                if CastingBarFrame.__163ui_dragger == nil then
                    local Dragger = Create(CastingBarFrame);
                    Dragger:ClearAllPoints();
                    Dragger:SetPoint("TOPRIGHT", 0, 0);
                    Dragger:SetPoint("TOPLEFT", 0, 0);
                    Dragger:SetHeight(32);
                    Dragger:SetParent(UIParent);
                    Dragger.BGBody:Hide();
                    Dragger.BGHead:ClearAllPoints();
                    Dragger.BGHead:SetAllPoints();
                    Dragger:SetSize(CastingBarFrame:GetSize());
                    RetainPos(CastingBarFrame);
                end
                CastingBarFrame.__163ui__dragable = U1GetCfgValue("blizzmove", "movecastbar/dragable");
                if CastingBarFrame.__163ui__dragable then
                    CastingBarFrame.__163ui_dragger:Show();
                end
                CastingBarFrame.__163ui__movable = true;
            elseif not loading then
                CastingBarFrame.__163ui__movable = nil;
                if CastingBarFrame.__163ui_dragger ~= nil then
                    CastingBarFrame.__163ui_dragger:Hide();
                end
            end
        end,
        {
            var = "dragable",
            text = "显示拖动框",
            tip = "说明`开启此选项后，会出现一个位置指示器，拖动它来移动。`打开此选项，将框架拖动到想要摆放的位置然后关闭此选项防止误拖动。",
            -- reload = 1,
            callback = function(cfg, v, loading)
                CastingBarFrame.__163ui__dragable = not not v;
                if CastingBarFrame.__163ui_dragger ~= nil then
                    CastingBarFrame.__163ui_dragger:SetShown(v);
                end
            end,
        },
    },
    {
        var = "movebuffframe",
        text = "允许移动Buff框体",
        tip = "说明`允许移动右上角玩家Buff框体。`关闭该选项之后，下次进入游戏或者重载界面会重置位置",
        -- reload = 1,
        callback = function(cfg, v, loading)
            local BuffFrame = BuffFrame;
            if v then
                BuffFrame:SetMovable(true);
                -- BuffFrame:SetUserPlaced(true);
                BuffFrame:SetDontSavePosition(true);
                BuffFrame:SetClampedToScreen(true);
                if loading then
                    ApplyPos(BuffFrame:GetName(), BuffFrame);
                end
                if BuffFrame.__163ui_dragger == nil then
                    local Dragger = Create(BuffFrame);
                    Dragger:SetPoint("TOPRIGHT", 0, 20);
                    Dragger:SetSize(300, 65);
                    -- hooksecurefunc("UIParent_UpdateTopFramePositions", function()
                    --     if BuffFrame.__163ui__movable then
                    --         ApplyPos(BuffFrame:GetName(), BuffFrame);
                    --     end
                    -- end);
                    RetainPos(BuffFrame);
                end
                BuffFrame.__163ui__movable = true;
                BuffFrame.__163ui__dragable = U1GetCfgValue("blizzmove", "movebuffframe/dragable");
                if BuffFrame.__163ui__dragable then
                    BuffFrame.__163ui_dragger:Show();
                end
            elseif not loading then
                BuffFrame.__163ui__movable = nil;
                if BuffFrame.__163ui_dragger ~= nil then
                    BuffFrame.__163ui_dragger:Hide();
                end
            end
        end,
        {
            var = "dragable",
            text = "显示拖动框",
            tip = "说明`开启此选项后，会出现一个位置指示器，拖动它来移动。`打开此选项，将框架拖动到想要摆放的位置然后关闭此选项防止误拖动。",
            -- reload = 1,
            callback = function(cfg, v, loading)
                BuffFrame.__163ui__dragable = not not v;
                if BuffFrame.__163ui_dragger ~= nil then
                    BuffFrame.__163ui_dragger:SetShown(v);
                end
            end,
        },
    },
    {
        var = "moveuierrorsframe",
        text = "允许移动提示框体",
        tip = "说明`允许移动屏幕正上方的错误提示框体。`关闭该选项之后，下次进入游戏或者重载界面会重置位置",
        -- reload = 1,
        callback = function(cfg, v, loading)
            local UIErrorsFrame = UIErrorsFrame;
            if v then
                UIErrorsFrame:SetMovable(true);
                -- UIErrorsFrame:SetUserPlaced(true);
                UIErrorsFrame:SetDontSavePosition(true);
                UIErrorsFrame:SetClampedToScreen(true);
                if loading then
                    ApplyPos(UIErrorsFrame:GetName(), UIErrorsFrame);
                end
                if UIErrorsFrame.__163ui_dragger == nil then
                    local Dragger = Create(UIErrorsFrame);
                    Dragger:SetPoint("TOPRIGHT", 0, 20);
                    Dragger:SetSize(300, 65);
                    -- hooksecurefunc("UIParent_UpdateTopFramePositions", function()
                    --     if UIErrorsFrame.__163ui__movable then
                    --         ApplyPos(UIErrorsFrame:GetName(), UIErrorsFrame);
                    --     end
                    -- end);
                    RetainPos(UIErrorsFrame);
                end
                UIErrorsFrame.__163ui__movable = true;
                UIErrorsFrame.__163ui__dragable = U1GetCfgValue("blizzmove", "movebuffframe/dragable");
                if UIErrorsFrame.__163ui__dragable then
                    UIErrorsFrame.__163ui_dragger:Show();
                end
            elseif not loading then
                UIErrorsFrame.__163ui__movable = nil;
                if UIErrorsFrame.__163ui_dragger ~= nil then
                    UIErrorsFrame.__163ui_dragger:Hide();
                end
            end
        end,
        {
            var = "dragable",
            text = "显示拖动框",
            tip = "说明`开启此选项后，会出现一个位置指示器，拖动它来移动。`打开此选项，将框架拖动到想要摆放的位置然后关闭此选项防止误拖动。",
            -- reload = 1,
            callback = function(cfg, v, loading)
                UIErrorsFrame.__163ui__dragable = not not v;
                if UIErrorsFrame.__163ui_dragger ~= nil then
                    UIErrorsFrame.__163ui_dragger:SetShown(v);
                end
            end,
        },
    },
});
