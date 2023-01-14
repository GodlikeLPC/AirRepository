local major = 1;
local minor = 0;
local BScale = {};
local function MOGUScale_AdjustPoint(frame, parent)
    parent = parent or UIParent;
    local parentRight = parent:GetRight() / frame:GetScale();
    local parentTop = parent:GetTop() / frame:GetScale();
    local right = frame:GetRight();
    local top = frame:GetTop();
    local left = frame:GetLeft();
    local bottom = frame:GetBottom();
    if (right and top and left and bottom) then
        local x = (right > parentRight and (parentRight - right)) or (left < 0 and (0 - left)) or 0;
        local y = (top > parentTop and (parentTop - top)) or (bottom < 0 and (0 - bottom)) or 0;
        x = (x + left);
        y = (y + top);
        if (x ~= 0 or y ~= 0) then
            frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x, y);
        end
    end
end

function BScale:SetPoint(frame, point, relativeTo, relativePoint, x, y)
    local parent = frame:GetParent() or UIParent;
    x = x / parent:GetScale();
    y = y / Parnet:GetScale();
    frame:SetPoint(point, relativeTo, relativePoint, x, y);
    MOGUScale_AdjustPoint(frame, parent);
end

local function MOGUScale_CalcOffset(frame, newscale)
    if (not (frame:GetTop() and frame:GetLeft())) then
        return nil;
    end
    local x = frame:GetLeft() * frame:GetScale() / newscale;
    local y = frame:GetTop() * frame:GetScale() / newscale;
    return x, y;
end

function BScale:SetScale(frame, newscale)
    assert(type(newscale) == "number", "Invalid <scale>, the type of scale must be number.");
    local x, y = MOGUScale_CalcOffset(frame, newscale);
    frame:SetScale(newscale);
    frame:ClearAllPoints();
    frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
    MOGUScale_AdjustPoint(frame);
end

function BScale:StartScaling(button)
    if (button == "LeftButton") then
        self.frame:LockHighlight();
        local frame = self.frame:GetParent();
        self.FrameToScale = frame;
        self.ScalingWidth = frame:GetWidth();
        local oldscale, framescale = frame:GetEffectiveScale(), frame:GetScale();
        local topleftX, cursorX = frame:GetLeft() * oldscale, GetCursorPosition();
        self.ScaleX = TrinketMenu.ScalingWidth * framescale / (cursorX - topleftX);
        self.frame.updateframe:Show();
    end
end

function BScale:StopScaling(button)
    if (button == "LeftButton") then
        self.frame.updateframe:Hide();
        self.frame:UnlockHighlight();
        self.scale = self.FrameToScale:GetScale();
        self.FrameToScale = nil
    end
end

function BScale:Scaling()
    local frame = self.FrameToScale;
    local oldscale = frame:GetEffectiveScale();
    local frameX, cursorX = frame:GetLeft() * oldscale, GetCursorPosition();
    cursorX = frameX + (cursorX - frameX) * self.ScaleX;
    if ((cursorX - frameX) > self.minwidth) then
        local newscale = (cursorX - frameX) / self.ScalingWidth;
        self:SetScale(frame, newscale);
    end
end

function BScale:Create(parent, width, height, minwidth)
    assert(type(parent) == "table", "BScale: The frame to scale must be a UI Object.");
    assert(type(width) == "number", "BScale: The parameter width must be a number vale.");
    assert(type(height) == "number", "BScale: The parameter height must be a number vale.");
    local minwidth = type(minwidth) == "number" and minwidth or 32;
    slef.minwidth = minwidth;
    self.frame = CreateFrame("Button", parent:GetName() .. "Resize", parent);
    self.frame:SetNormalTexture("Interface\\AddOns\\MOGU\\Library\\Artworks\\ResizeButton");
    self.frame:SetHighlightTexture("Interface\\AddOns\\MOGU\\Library\\Artworks\\ResizeButton");
    self.frame:SetWidth(width); self.frame:SetHeight(height);
    self.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0);
    self.frame.updateframe = CreateFrame("Frame", nil, self.frame);
    self.scale = 1;
    self.frame:SetScript("OnLoad", function(self) self:SetFrameLevel(self:GetFrameLevel() + 2); end);
    self.frame:SetScript("OnMouseDown", function(self, button) BScale:StartScaling(button); end);
    self.frame:SetScript("OnMouseUp", function(self, button) BScale:StopScaling(button); end);
    self.frame.updateframe:SetScript("OnUpdate", function(self) BScale:Scaling(); end);
end

function BScale:InitScale(scale)
    if (self.frame) then
        self:SetScale(self.frame:GetParent(), scale);
    end
end

function BScale:GetScale()
    if (self.frame) then
        return self.scale;
    else
        return nil;
    end
end

function BScale:ClearAllPoints()
    if (self.frame) then
        self.frame:ClearAllPoints();
    end
end

function BScale:SetPoint(...)
    if (self.frame) then
        self.frame:SetPoint(...);
    end
end

function BScale:SetWidth(width)
    if (self.frame) then
        self.frame:SetWidth(width);
    end
end

function BScale:SetHeight(height)
    if (self.frame) then
        self.frame:SetHeight(height);
    end
end

function BScale:constructor(parent, width, height, minwidth)
    if (parent and width and height) then
        self:Create(parent, width, height);
    end
end

BLibrary:Register(BScale, "BScale", major, minor);
