local AddName, AddonTable = ...
local L = AddonTable.L

----------------------------[[ Delete for final ]]-----------------------------------
local TipFormat = "- %s -"
local dropListRowHeight, newTicker, rowWidget = 18
local dropSliderHeight = 25

local WidgetBG = { 
	bgFile="Interface/BUTTONS/WHITE8X8", 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false, 
	edgeSize=8, 
	tileSize=0, 
	insets={ left=0, right=0, top=0, bottom=0, },
}

local W = AddonTable.W
local Mixins = AddonTable.Mixins

local function AddTipText(self)
	self.Tip = self:CreateFontString(nil, "OVERLAY")
	self.Tip:SetPoint("BOTTOM", self, "TOP", 0, 6)
	self.Tip:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -4)
	self.Tip:SetJustifyH("CENTER")
	self.Tip:SetJustifyV("TOP")
end

local function AnchorWidget(self, location, x, y, notrelative) -- location = where the lab el will be located in relation to the parent
	location = strupper(location)
	local anchor = (notrelative and location) or AnchorLocations[location] or location  -- because the anchor point will actually be the opposite of the location (topoint)
	self:ClearAllPoints()
	self:SetPoint(anchor.point or location, self:GetParent(), location, x or anchor.x, y or anchor.y)
end

local function CancelTicker(self, leaveshown)
	self:Cancel()
	if not leaveshown then
		rowWidget:Hide()
	end
	rowWidget = nil
	newTicker = nil
end

local function OnEnterFunc(self)
	if newTicker then
		if rowWidget and rowWidget == self.List then
			CancelTicker(newTicker, true)
		else
			CancelTicker(newTicker)
		end
	end
end

local function OnLeaveFunc(self)
	if not self:IsMouseOver() and not self.List:IsMouseOver() and self.List:IsShown() then
		rowWidget = self.List
		if newTicker then
			CancelTicker()
		end
		newTicker = C_Timer.NewTicker(1, CancelTicker)
	end
end

----------------------------[[ End Delete ]]----------------------------------------------

local ListData = {}
ListData.FontFlags = {
	{ text=L["None"], value="" },
	{ text=L["Thin"], value="OUTLINE", },
	{ text=L["Thick"], value="THICKOUTLINE" },
	{ text=L["Monochrome"], value="MONOCHROME" },
	{ text=L["Thin Monochrome"], value="OUTLINE, MONOCHROME" },
	{ text=L["Thick Monochrome"], value="THICKOUTLINE, MONOCHROME" },
}
ListData.Alignments = {
	{ text=L["Left"], value="TOPLEFT", },
	{ text=L["Right"], value="TOPRIGHT", },
}
ListData.Rows = { 
	{ text=1, value=1, },
	{ text=2, value=2, },
	{ text=3, value=3, },
	{ text=4, value=4, },
	{ text=5, value=5, },
}

ListData.Fonts = {}
for k, v in ipairs(AddonTable.LSM:List("font")) do
	tinsert(ListData.Fonts, { text=v, value=v, })
end

ListData.Profiles = {}
local function UpdateProfiles()
	wipe(ListData.Profiles)
	for k, v in pairs(SinStatsDB.profiles) do
		tinsert(ListData.Profiles, { text=k, value=k })
	end
	sort(ListData.Profiles, function(a, b)
		return a.text < b.text
	end)
end

function W.DropList(parent)
	local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(140, dropSliderHeight)
	f.SpecialType = "DropList"
	AddTipText(f)
	Mixin(f, Mixins.functions.DropListFrame)
	for k, v in pairs(Mixins.scripts.DropListFrame) do
		f:SetScript(k, v)
	end
	f:SetBackdrop(WidgetBG)
	f:SetBackdropColor(0, 0, 0, 0)
	f:SetBackdropBorderColor(backdropBoirderColor.r, backdropBoirderColor.g, backdropBoirderColor.b, backdropBoirderColor.a)
	f.DropButton = CreateFrame("Button", nil, f)
	f.DropButton:SetSize(18, 18)
	f.DropButton.Border = f.DropButton:CreateLine()
	f.DropButton.Border:SetThickness(2)
	f.DropButton.Border:SetStartPoint("TOPLEFT", -4, 2)
	f.DropButton.Border:SetEndPoint("BOTTOMLEFT", -4, -2)
	f.DropButton.Border:SetColorTexture(1, 0.145, 0.467, 0.5)
	f.DropButton:SetPoint("TOPRIGHT", -4, -4)
	f.DropButton:SetNormalTexture(AddonTable.TexturePath.."DropNormal")
	f.DropButton:GetNormalTexture():SetVertexColor(0.765, 0.663, 0)
	f.DropButton:SetPushedTexture(AddonTable.TexturePath.."DropPushed")
	f.DropButton:GetPushedTexture():SetVertexColor(0.765, 0.663, 0)
	f.DropButton:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	for k, v in pairs(Mixins.scripts.DropListButton) do
		f.DropButton:SetScript(k, v)
	end

	f.Text = f:CreateFontString()
	f.Text:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")
	f.Text:SetPoint("TOPLEFT", 4, 0)
	f.Text:SetPoint("BOTTOMRIGHT", f.DropButton, "BOTTOMLEFT", -4, 0)
	
	f.List = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	f.List:Hide()
	f.List:SetSize(150, 70)
	f.List:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, 0.6)
	f.List:SetBackdrop(WidgetBG)
	f.List:SetBackdropColor(1, 0.145, 0.467, 0.2)
	f.List:SetBackdropBorderColor(1, 0.145, 0.467)
	f.List.Buttons = {}
	Mixin(f.List, Mixins.functions.DropList)
	for k, v in pairs(Mixins.scripts.DropList) do
		f.List:SetScript(k, v)
	end

	return f
end

function W.DropListRow(parent)
	local f = CreateFrame("CheckButton", nil, parent)
	f:SetSize(10, dropListRowHeight)
	f.SpecialType = "DropListRow"
	f:SetNormalTexture("Interface/BUTTONS/WHITE8X8")
	f:GetNormalTexture():SetVertexColor(1, 0.145, 0.467, 0.1)
	f:SetCheckedTexture("Interface/BUTTONS/WHITE8X8") 
	f:GetCheckedTexture():SetVertexColor(1, 0.145, 0.467, 0.3)
	f:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	f.Text = f:CreateFontString()
	f.Text:SetPoint("LEFT")
	f.Text:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")

	Mixin(f, Mixins.functions.DropListRow)
	for k, v in pairs(Mixins.scripts.DropListRow) do
		f:SetScript(k, v)
	end
	return f
	
end

Mixins.functions.DropListFrame = {}
function Mixins.functions.DropListFrame.Init(self, anchorframe, parent, displaylist)
print("B", self, anchorframe, parent, displaylist)
	self.MyInformation = anchorframe.DisplayOrder[self:GetID()]
	self:SetEnabled(true)
	self:SetWidth(self.MyInformation.widget.width)
	self.DropButton.MyInformation = parent.DisplayOrder[self:GetID()] 
	self.DropButton.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.DropButton.Key = self.MyInformation.stat
	self.DropButton.Data = ListData[self.MyInformation.widget.data]
	for k, v in ipairs(self.DropButton.Data) do
		if v.value == self.DropButton.Settings[self.DropButton.Key] then
			self:SetText(v.text)
			break
		end
	end
	self.Tip:SetText(format(TipFormat, L[self.DropButton.Key.."Tip"]))
end

function Mixins.functions.DropListFrame.Reset(self)
	self.List:Hide()
end

function Mixins.functions.DropListFrame.SetEnabled(self, enabled)
	local r, g, b, a = self:GetBackdropBorderColor()
	a = enabled and 1 or 0.5
	self:SetBackdropBorderColor(r, g, b, a)
	self.Text:SetAlpha(enabled and 1 or 0.5)
	self.DropButton:SetEnabled(enabled)
	self.DropButton:SetAlpha(enabled and 1 or 0.5)
end

function Mixins.functions.DropListFrame.SetText(self, text)
	self.Text:SetText(text)
end

Mixins.scripts.DropListFrame = {}
function Mixins.scripts.DropListFrame.OnEnter(self)
	OnEnterFunc(self)
end

function Mixins.scripts.DropListFrame.OnLeave(self)
	OnLeaveFunc(self)
end


Mixins.scripts.DropListButton = {}
function Mixins.scripts.DropListButton.OnClick(self)
	local parent = self:GetParent()
	if not self:GetParent().List:IsShown() then
		parent.List.MyInformation = self.MyInformation
		parent.List.Settings = self.Settings
		parent.List.Key = self.Key
		parent.List.Data = self.Data
	end
	self:GetParent().List:SetShown(not self:GetParent().List:IsShown())
end

function Mixins.scripts.DropListButton.OnEnter(self)
	OnEnterFunc(self:GetParent())
end

function Mixins.scripts.DropListButton.OnLeave(self)
	self:GetParent():GetScript("OnLeave")(self:GetParent())
end

Mixins.functions.DropList = {}
function Mixins.functions.DropList.Reset(self)
	self:SetSize(5, 5)
	self.MyInformation = nil
	self.Settings = nil
	self.Key = nil
	self.Data = nil
	for k, v in ipairs(self.Buttons) do
		AddonTable:KillWidget(v)
	end
	wipe(self.Buttons)
end

Mixins.scripts.DropList = {}
function Mixins.scripts.DropList.OnHide(self)
	self:Reset()
end

function Mixins.scripts.DropList.OnEnter(self)
	OnEnterFunc(self:GetParent())
end

function Mixins.scripts.DropList.OnLeave(self)
	self:GetParent():GetScript("OnLeave")(self:GetParent())
end

function Mixins.scripts.DropList.OnShow(self)
	local widest = 0
	for k, v in ipairs(self.Data) do
		local row = AddonTable:GetWidget("DropListRow", self, k)
		row:SetParent(self)
		row:SetChecked(false)
		tinsert(self.Buttons, row)
		local w = row:Init(self, v)
		if w > widest then
			widest = w
		end
		if v.value == self.Settings[self.Key] then
			self:GetParent():SetText(v.text)
			row:SetChecked(true)
		else
			row:SetChecked(false)
		end

	end
	widest = math.max(ceil(widest), ceil(self:GetParent():GetWidth() / 2)) + 4
	local first, last
	local total = #self.Data
	local width = SinStatsConfigFrame:GetRight() - self:GetLeft()
	local height = floor((self:GetParent():GetBottom() - SinStatsConfigFrame:GetBottom())/dropListRowHeight)
	local modVal = total > height and height or 1
	local modAnchor = modVal > 1 and "TOPRIGHT" or "BOTTOMLEFT"
	height = modVal > 1 and modVal * dropListRowHeight or total * dropListRowHeight
	width = modVal > 1 and (width/widest) * widest or widest
	for k, v in ipairs(self.Buttons) do
		v:ClearAllPoints()
		v:SetWidth(widest)
		if k == 1 then
			v:SetPoint("TOPLEFT", 2, -2)
			first = v
		elseif (k-1) % modVal == 0 then
			v:SetPoint("TOPLEFT", first, modAnchor, 0, 0)
			first = v
		else
			v:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 0)
		end
		last = v
	end
	self:SetSize(width + 2, height + 2)
end

Mixins.functions.DropListRow = {}
function Mixins.functions.DropListRow.Init(self, parent, rowdata)--, id)
	self.Parent = parent
	self.RowData = rowdata
	local t, v = parent.Data[self:GetID()].text, parent.Data[self:GetID()].value
	if parent.Data == ListData.Fonts then
		self.Text:SetFont(AddonTable.LSM:Fetch("font", v), 12)
	else
		self.Text:SetFont(AddonTable.ConfigDefaultFont, 12)
	end
	self.Text:SetText(t)
	self:Show()
	return self.Text:GetWidth()
end

Mixins.scripts.DropListRow = {}
function Mixins.scripts.DropListRow.OnClick(self)
	self:GetParent().Settings[self:GetParent().Key] = self.RowData.value
	self:GetParent():GetParent():SetText(self.RowData.text)
	self:GetParent():Hide() -- hide the list
	AddonTable:InitialiseProfile(AddonTable.Profile)
end

function Mixins.scripts.DropListRow.OnEnter(self)
	OnEnterFunc(self:GetParent():GetParent())
end

function Mixins.scripts.DropListRow.OnLeave(self)
	local leaveParent = self:GetParent():GetParent()
	leaveParent:GetScript("OnLeave")(leaveParent)
end


------------------------------------------------------------------------------------------------
function W.ProfileConfig(parent) -- All the funcions to do Profiles
	local f = CreateFrame("Frame", "$parentProfiles", parent )
	f.SpecialType = "ProfileConfig"
	f:SetSize(400, 200)
	Mixin(f, Mixins.functions.ProfileConfig)
	
	f.CurrentProfile = f:CreateFontString()
	f.CurrentProfile:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize)
	f.CurrentProfile:SetPoint("TOPLEFT", 10, -10)
	
	f.Delete = CreateFrame("Button", nil, f)
	f.Delete:SetSize(80, 30)
	f.Delete:SetPoint("LEFT")
	f.Delete:SetNormalTexture(AddonTable.TexturePath.."ButtonNormal")
	f.Delete:SetPushedTexture(AddonTable.TexturePath.."ButtonPushed")

	f.Delete:GetNormalTexture():SetVertexColor(1, 0.145, 0.467, 0.7)
	f.Delete:GetPushedTexture():SetVertexColor(1, 0.145, 0.467, 0.7)
	
	f.Delete:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	local h = f.Delete:GetHighlightTexture()
	h:SetVertexColor(1, 1, 1, 0.5)
	local p, r, t, x, y = h:GetPoint(2)
	AddLabel(f.Delete)
	f.Delete:SetLabelText("Testing")
--	h:ClearAllPoints()
	h:SetPoint(p, r, t, x-2, y-4)
--	h:SetSize(h:GetWidth(), h:GetHeight())
--AddonTable.AddDummyTexture(f)
	return f
end

Mixins.functions.ProfileConfig = {}
function Mixins.functions.ProfileConfig.Init(self, anchorframe, parent, displaylist)
print("Working on ProfileConfig!!!")
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self.Settings = SinStatsDB.profileKeys
	self.Key = AddonTable.ProfileKey
	self.CurrentProfile:SetText( self.Settings[self.Key])

--[[
	
	self.ProfileList = AddonTable:GetWidget("DropList", self, 4) -- 4 = entry in AddonTable.SettingsGroupOrder table
	self.ProfileList:SetPoint("TOPLEFT", self.CurrentProfile, "BOTTOMLEFT", 0, -5)
	self.ProfileList:Init(self, self)
]]--
end

function Mixins.functions.ProfileConfig.Reset(self)
	AddonTable:KillWidget(self.ProfileList)
	
end
