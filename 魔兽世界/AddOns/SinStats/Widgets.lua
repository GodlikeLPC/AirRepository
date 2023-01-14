local AddName, AddonTable = ...
local L = AddonTable.L

local newTicker, rowWidget
local gttFont, gttFontSize, gttFontFlags
local labelOffsetY, settingsOffsetY, dropLiostandSliderHeight, dropListRowHeight = 35, -15, 25, 18
local checkBoxHeight, radioSize, defaultLabelOsW, defaultLabelOsH, tabLabelOsW, MainMenuButtonHeight, topTabHeight = 30, 14, 40, 10, 6, 21, 25
local topTabColor = { r=0.298, g=0.298, b=0.298, a=0}
local backdropBorderColor = { r=0, g=0, b=0, a=1 }
local greenColor = { r=0.443, g=1, b=0.788 }
local redColor = { r=1, g=0, b=0.658 }
local orangeColor = { r=1, g=0.741, b=0.313 }
--local blueColor = { r=0.258, g=0.631, b=0.960 }

local anchorLableHeight = 10

AddonTable.WidgetDisplayFormat = "%s %s"

local opPoints = {
	LEFT = { point="RIGHT", x=-5, y=0, use="x", },
	RIGHT = { point="LEFT", x=5, y=0, use="x" },
	CENTER = { point="CENTER", use="xy" },
}

local TooltipOffsets = {
	Default = { point="RIGHT", topoint="LEFT", x=96, y=24 },	
	CheckBox = { point="LEFT", topoint="RIGHT", x=1, y=0 },	
}

local Mixins, WidgetPool = { scripts={}, functions={} }, {}

local W = {}
AddonTable.W = W
AddonTable.Mixins = Mixins

local WidgetBG = { 
	bgFile="Interface/BUTTONS/WHITE8X8", 
	--edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false, 
	edgeSize=4, 
	tileSize=0, 
	insets={ left=1, right=1, top=2, bottom=4, },
}

local SliderBG = { 
	bgFile="Interface/BUTTONS/WHITE8X8", 
	--edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false, 
	edgeSize=0, 
	tileSize=0, 
	insets={ left=1, right=1, top=7, bottom=7, },
}

----------------------------------
--			Fonts Init			--
----------------------------------
local LSM = LibStub("LibSharedMedia-3.0")
AddonTable.LSM = LSM
LSM:Register ("font", "Accidental Presidency", [[Interface\Addons\SinStats\fonts\Accidental Presidency.ttf]])
LSM:Register ("font", "Oswald", [[Interface\Addons\SinStats\fonts\Oswald-Regular.otf]])
LSM:Register ("font", "FORCED SQUARE", [[Interface\Addons\SinStats\fonts\FORCED SQUARE.ttf]])
LSM:Register("font", "Bazooka", [[Interface\Addons\SinStats\fonts\Bazooka.ttf]])
LSM:Register("font", "DorisPP", [[Interface\Addons\SinStats\fonts\DORISPP.ttf]])
LSM:Register("font", "Enigmatic", [[Interface\Addons\SinStats\fonts\Enigma__2.ttf]])
LSM:Register("font", "Liberation Sans (U)", [[Interface\Addons\SinStats\fonts\LiberationSans-Regular.ttf]])
LSM:Register("font", "White Rabbit", [[Interface\Addons\SinStats\fonts\WHITRABT.ttf]])
LSM:Register("font", "Monofonto", [[Interface\Addons\SinStats\fonts\MONOFONT.ttf]])
LSM:Register("font", "FSEX300 (U)", [[Interface\Addons\SinStats\fonts\FSEX300.ttf]])
LSM:Register("font", "PT Sans", [[Interface\Addons\SinStats\fonts\PTSansNarrow.ttf]])

----------------------------------------------
--			Droplist Source Tables			--
----------------------------------------------
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
ListData.Strata = { 
	{ text=L["Lowest"], value="BACKGROUND", },
	{ text=L["Low"], value="LOW", },
	{ text=L["Medium"], value="MEDIUM", },
	{ text=L["High"], value="HIGH", },
	{ text=L["Highest"], value="TOOLTIP", },
}

ListData.Decimals = { 
	{ text=L["None"], value="0", },
	{ text=L["1"], value="1", },
	{ text=L["2"], value="2", },
	{ text=L["3"], value="3", },
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

--------------------------------------
--			Local Functions			--
--------------------------------------
local TipFormat = "%s"
local function AdjustCheckTip(self, text)
--	self:SetWidth(self:GetWidth() + self.Label:GetWidth())
	self.Tip:SetText(format(TipFormat, L[text.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
end

local function AdjustTopTabText(self, text)
	self:SetWidth(self.Label:GetWidth() + defaultLabelOsW)
end

local function AddTipText(self)
	self.Tip = self:CreateFontString(nil, "OVERLAY")
	self.Tip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 3) -- CHECKBOX TIP TEXT
	self.Tip:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -6) -- TIP TEXT SIZE
	self.Tip:SetJustifyH("LEFT")
	self.Tip:SetJustifyV("TOP")
end

local function AddLabel(self)
	self.Label = self:CreateFontString(nil, "OVERLAY")
	Mixin(self.Label, Mixins.functions.Labels)
	Mixin(self, Mixins.functions.HasFontString)
	self:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -4)
end

local function AnchorWidget(self, location, x, y, notrelative) -- location = where the lab el will be located in relation to the parent
	location = strupper(location)
	local anchor = (notrelative and location) or opPoints[location] or location  -- because the anchor point will actually be the opposite of the location (topoint)
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

local function GetLabelText(text, myinformation, noicons)
	if noicons then
		return strtrim(L[text])
	else
		return format(AddonTable.WidgetDisplayFormat, AddonTable:GetSpellIcon(myinformation), strtrim(L[text]))
	end
end

local function KillPage(page)
	if AddonTable.ConfigFrame[page] then
		AddonTable:KillWidget(AddonTable.ConfigFrame[page])
		AddonTable.ConfigFrame[page] = nil
	end
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

local function PlayOnTab()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN, "Ambience")
end

local function PlayOnCheck()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON, "Ambience")
end

local function SetAnchorText(self, text, anchorcenter)
	if #self.CurrentWidgets == 0 then
		return
	end
	self:SetAnchor()
end

--------------------------------------
--			Label Functions			--
--------------------------------------
Mixins.functions.Labels = {}

function Mixins.functions.Labels.Anchor(self, location, x, y, notrelative)
	AnchorWidget(self, location, x, y, notrelative)
end

------------------------------------------
--	Parents with Label Functions		--
------------------------------------------
Mixins.functions.HasFontString = {}
function Mixins.functions.HasFontString.AnchorLabel(self, location, x, y, notrelative)
	AnchorWidget(self.Label, location, x, y, notrelative)
end

function Mixins.functions.HasFontString.GetLabel(self)
	return self.Label:GetText()
end

function Mixins.functions.HasFontString.GetLabelHeight(self)
	return math.ceil(self.Label:GetHeight())
end

function Mixins.functions.HasFontString.SetFont(self, font, size, flags)
	local text = self.Label
	local setFont = font or AddonTable.ConfigDefaultFont
	local setSize = size or AddonTable.ConfigDefaultFontSize
	text:SetFont(setFont, setSize)
end

function Mixins.functions.HasFontString.SetFontSize(self, size)
	local f, s = self.Label:GetFont()
	self.Label:SetFont(f, size)
end

function Mixins.functions.HasFontString.SetJustifyH(self, justify)
	self.Label:SetJustifyH(justify)
end

function Mixins.functions.HasFontString.SetJustifyV(self, justify)
	self.Label:SetJustifyV(justify)
end

function Mixins.functions.HasFontString.SetTextColor(self, r, g, b, a)
	self.Label:SetTextColor(r, g, b, a)
end

function Mixins.functions.HasFontString.SetLabel(self, text)
	self.Label:SetText(text)
end


------------------------------------------
--			Widgets and Mixins			--
------------------------------------------

--------------------------------------
--			Anchor Frame			--
--------------------------------------
local count = 0
function W.AnchorFrame(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(5, 5)
	f.SpecialType = "AnchorFrame"
	f:SetFrameStrata("HIGH")
	local borderOffset = AddonTable.maxOptionsWidth / 2.5
	AddLabel(f)
	f:AnchorLabel("TOP", 0, 0, true)
	f.Label:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize + anchorLableHeight)
	f.Label:SetJustifyH("CENTER")

	f.Description = f:CreateFontString()
	f.Description:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -3)
	f.Description:SetPoint("TOP", f.Label, "BOTTOM", -25, -5)
	f.Description:SetJustifyH("TOP")
	f.Description:SetJustifyH("LEFT")
	f.Description:SetWidth(AddonTable.maxOptionsWidth - (borderOffset / 2))

	f.CurrentWidgets = {}
	Mixin(f, Mixins.functions.AnchorFrames)
	hooksecurefunc(f, "SetLabel", SetAnchorText)
	return f
end

Mixins.functions.AnchorFrames = {}
function Mixins.functions.AnchorFrames.AddWidget(self, widget)
	widget:SetParent(self)
	tinsert(self.CurrentWidgets, widget)
end

function Mixins.functions.AnchorFrames.Reset(self)
	self.ActiveWidget = nil
	self.CenterAlign = nil
	self:SetLabel("")
	self.Description:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -3) -- STATS TEXT FIRST BREAKLINE
	for k, v in pairs(self.CurrentWidgets) do
		AddonTable:KillWidget(v)
	end
	wipe(self.CurrentWidgets)
	if self.TopSeparator then
		AddonTable:KillWidget(self.TopSeparator)
		self.TopSeparator = nil
	end
	if self.BottomSeparator then
		AddonTable:KillWidget(self.BottomSeparator)
		self.BottomSeparator = nil
	end
end

function Mixins.functions.AnchorFrames.SetActive(self, widget)
	local w = self.ActiveWidget
	self.ActiveWidget = widget
	if w and w ~= self.ActiveWidget then
		w:Click()
	end
end

function Mixins.functions.AnchorFrames.SetAnchor(self, anchor, width, height)
	if #self.CurrentWidgets == 0 then 
		return
	end
	self.PageAnchor = anchor
	self.BaseWidth = width and width or self.BaseWidth
	self.BaseHeight = height and height or self.BaseHeight
	self:ClearAllPoints()
	self:SetPoint("TOP", anchor, "BOTTOM", 0, settingsOffsetY)
	local reAnchor = self.CurrentWidgets[1]
	local p, r, t, x, y = reAnchor:GetPoint(1)
 	local offsetY = 0
	self:SetSize(self.BaseWidth, self.BaseHeight + offsetY)
end

----------------------------------
--			Separator			--
----------------------------------
function W.Separator(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(AddonTable.SeparatorWidth, 5)
	f.SpecialType = "Separator"
	f.Texture = f:CreateTexture()
	f.Texture:SetAllPoints()
	f.Texture:SetTexture(AddonTable.TexturePath.."Breakline")
	f.Texture:SetVertexColor(redColor.r, redColor.g, redColor.b)
	AddLabel(f)
	f:AnchorLabel("TOPLEFT", 0, 20, true)
	f:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -3)
	f.Label:SetJustifyH("LEFT")
	--f.Label:SetJustifyV("BOTTOM")
	Mixin(f, Mixins.functions.Separator)
	f.OrangeColor = orangeColor
	f:Hide()
	return f
end

Mixins.functions.Separator = {}
function Mixins.functions.Separator.Init(self, bottomlabel)
	if bottomlabel then
		self:AnchorLabel("TOPLEFT", 30, -20, true)
		self:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 5)
		--self.Label:SetJustifyV("TOP")
	end
end

function Mixins.functions.Separator.Reset(self)
	self:SetLabel("")
	self:AnchorLabel("TOPLEFT", 0, 20, true)
	self:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -3)
	self:SetTextColor(1,1,1)
	--self.Label:SetJustifyV("BOTTOM")
end

----------------------------------
--			CheckButton			--
----------------------------------
function W.CheckButton(parent)
	local f = CreateFrame("CheckButton", nil, parent)
	f:SetSize(14, 14)
	f.SpecialType = "CheckButton"
	f:SetNormalTexture(AddonTable.TexturePath.."CheckOff")
	f:SetCheckedTexture(AddonTable.TexturePath.."CheckOn")
	f:GetCheckedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b)
	f:GetCheckedTexture():SetBlendMode("ALPHAKEY")
	Mixin(f, Mixins.functions.CheckButton)
	for k, v in pairs(Mixins.scripts.CheckButton) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.CheckButton = {}
function Mixins.functions.CheckButton.Reset(self)
	self.ParentLink = nil
	self.ChildLink = nil
	self.Settings = nil
	self.Key = nil
	self:SetChecked(false)
	self:SetEnabled(true)
	self:Show()
end

Mixins.scripts.CheckButton = {}
function Mixins.scripts.CheckButton.OnClick(self)
	PlayOnCheck()
	self.Settings[self.Key] = self:GetChecked()
	local parent = self:GetParent()
	if parent.Linked and #parent.Linked > 0 then
		for k, v in ipairs(parent.Linked) do
			v[1]:SetEnabled(self:GetChecked() ~= v[2])
		end
	end
	AddonTable:InitialiseProfile(AddonTable.Profile)
	if self.ParentLink then
		self.ParentLink:SetChecked(self:GetChecked())
	end
	if self.ChildLink then
		self.ChildLink:SetChecked(self:GetChecked())
	end
end

function Mixins.scripts.CheckButton.OnEnable(self)
	self:GetCheckedTexture():SetBlendMode("ALPHAKEY")
	local t = self:GetChecked() and self:GetNormalTexture() or self:GetCheckedTexture()
	t:Show()
end

function Mixins.scripts.CheckButton.OnDisable(self)
	self:GetCheckedTexture():SetBlendMode("ADD")
	local t = self:GetChecked() and self:GetNormalTexture() or self:GetCheckedTexture()
	t:Hide()
	
end

------------------------------
--			Radio			--
------------------------------
function W.Radio(parent)
	local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(checkBoxHeight, checkBoxHeight) 
	f.SpecialType = "Radio"
	f:SetBackdrop(WidgetBG)
	f:SetBackdropColor(0.184, 0.184, 0.184, 0.5)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.5)
	Mixin(f, Mixins.functions.Radio)
	AddTipText(f)
	f.Tip:SetText(format(TipFormat, L["OptionsTip"]))
	f.Radios = {}
	for i=1, 3 do
		local r = CreateFrame("CheckButton", nil, f)
		tinsert(f.Radios, r)
		r:SetSize(radioSize, radioSize)
		r:SetNormalTexture(AddonTable.TexturePath.."RadioOff")
		r:SetCheckedTexture(AddonTable.TexturePath.."RadioOn")
		r:GetCheckedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b)--(0.784, 0.850, 0.941)--(1, 0.737, 0)
		r:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
		r:GetCheckedTexture():SetBlendMode("ALPHAKEY")
		AddLabel(r)
		r:AnchorLabel("RIGHT", 4, 0)
		for k, v in pairs(Mixins.scripts.Radio) do
			r:SetScript(k, v)
		end
		if i == 1 then
			r:SetPoint("BOTTOMLEFT", 6, 6)
		else
			r:SetPoint("LEFT", f.Radios[i-1].Label, "RIGHT", 8, 0)
		end
	end
	return f
end

Mixins.functions.Radio = {}
function Mixins.functions.Radio.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
	self.Option = AddonTable.Options[self.MyInformation.option]
	local width = 0
	for k, v in ipairs(self.Radios) do
		v.OptionVal = k
		v:SetLabel(L[self.MyInformation.labels[k]])
		v:SetChecked(false)
		width = width + v:GetWidth() + v.Label:GetWidth() + 4
	end
	self:SetWidth(width + 32) --(2*8) + 12)
	self.Radios[self.Settings[self.Key]]:SetChecked(true)
end

function Mixins.functions.Radio.Reset(self)
	self.MyInformation = nil
	self.Settings = nil
	self.Key = nil
	self.Option = nil
	self.OptionVal = nil
	for k, v in ipairs(self.Radios) do
		v:SetChecked(false)
	end
end

Mixins.scripts.Radio = {}
function Mixins.scripts.Radio.OnClick(self)
	PlayOnCheck()
	for k, v in ipairs(self:GetParent().Radios) do
		if v == self then
			v:SetChecked(true)
		else
			v:SetChecked(false)
		end
	end
	self:GetParent().Settings[self:GetParent().Key] = self.OptionVal
	AddonTable:InitialiseProfile(AddonTable.Profile)
end

----------------------------------
--			Checkbox			--
----------------------------------
function W.CheckBox(parent)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(10, checkBoxHeight)
	f.SpecialType = "CheckBox"
	Mixin(f, Mixins.functions.CheckBoxFrame)
	f:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	--f:GetHighlightTexture():SetVertexColor(1, 0.737, 0, 1) -- ADD COLOR TEXTURE FOR HIGHLIGHTED CHECKBOXES
	AddLabel(f)
	f:AnchorLabel("LEFT",  35, 0, true)
	f:SetLabel("")
	AddTipText(f)
	for k, v in pairs(Mixins.scripts.CheckBoxFrame) do
		f:SetScript(k, v)
	end
	f.Check = AddonTable:GetWidget("CheckButton", f)
--	f.Check:SetSize(14, 14) -- CHECKBOX SIZE
	f.Check:SetPoint("LEFT", 9, 0) -- DISTANCE BETWEEN BOX AND TEXT
	f.Check:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	f.Check:GetHighlightTexture():ClearAllPoints()
	f.Check:GetHighlightTexture():SetAllPoints(f:GetHighlightTexture())
--	f:SetWidth(f.Label:GetWidth() + f.Check:GetWidth() + 30) -- WIDTH OF CHECKBOX HIGHLIGHT AND CLICKABLE AREA
	f:SetPoint("CENTER")
	return f
end

Mixins.functions.CheckBoxFrame = {}
function Mixins.functions.CheckBoxFrame.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Check.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Check.Key = self.MyInformation.stat
	if self.Linked then
		wipe(self.Linked)
	end
	self.DisableOn = nil
	self.Check:SetChecked(self.Check.Settings[self.MyInformation.stat])
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
--	self:SetWidth(self.Check:GetWidth() + self.Label:GetWidth() + 15) -- WIDTH OF CHECKBOX HIGHLIGHT AND CLICKABLE AREA
	self:SetWidth(self.Check:GetWidth() + self.Label:GetWidth() + 35)
	AdjustCheckTip(self, self.MyInformation.stat)
end

function Mixins.functions.CheckBoxFrame.Reset(self)
	self.Check:Reset()
	self:SetLabel("")
	self:SetWidth(5)
end	
	
function Mixins.functions.CheckBoxFrame.SetLink(self, anchorframe, parent)
	if not self.MyInformation.linked or #self.MyInformation.linked == 0 then
		return
	end
	self.Linked = self.Linked or {}
	wipe(self.Linked)
	local i, total = 1, #self.MyInformation.linked
	while i < total do-- #self.MyInformation.linked do 
		local link = self.MyInformation.linked[i]
		for k, v in ipairs(anchorframe.CurrentWidgets) do
			if parent.DisplayOrder[v:GetID()].stat == self.MyInformation.linked[i] then
				tinsert(self.Linked, { v, self.MyInformation.linked[i+1] })
				v:SetEnabled(self.Check:GetChecked() ~= self.MyInformation.linked[i+1])
				break
			end
		end
		i=i+2
	end
end

Mixins.scripts.CheckBoxFrame = {}
function Mixins.scripts.CheckBoxFrame.OnClick(self)
	PlayOnCheck()
	self.Check:Click()
end

function Mixins.scripts.CheckBoxFrame.OnEnable(self)
	self.Check:SetEnabled(true)
	self:SetAlpha(1)
end

function Mixins.scripts.CheckBoxFrame.OnDisable(self)
	self.Check:SetEnabled(false)
	self:SetAlpha(0.5)
end

----------------------------------
--			Droplists			--
----------------------------------
function W.DropList(parent)
	local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(140, dropLiostandSliderHeight)
	f.SpecialType = "DropList"
	AddTipText(f)
	Mixin(f, Mixins.functions.DropListFrame)
	for k, v in pairs(Mixins.scripts.DropListFrame) do
		f:SetScript(k, v)
	end
	f:SetBackdrop(WidgetBG)
	f:SetBackdropColor(0.184, 0.184, 0.184, 0.5)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.5)
	f.DropButton = CreateFrame("Button", nil, f)
	f.DropButton:SetSize(13, 13)
	-- f.DropButton.Border = f.DropButton:CreateLine()
	-- f.DropButton.Border:SetThickness(1)
	-- f.DropButton.Border:SetStartPoint("TOPLEFT", -4, 2)
	-- f.DropButton.Border:SetEndPoint("BOTTOMLEFT", -4, 1)
	-- f.DropButton.Border:SetColorTexture(1, 0.145, 0.467, 0.2)
	f.DropButton:SetPoint("TOPRIGHT", -4, -6)
	f.DropButton:SetNormalTexture(AddonTable.TexturePath.."DropNormal")
	f.DropButton:GetNormalTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 1)--(0.784, 0.850, 0.941)--(1, 0.737, 0, 1)
	f.DropButton:SetPushedTexture(AddonTable.TexturePath.."DropPushed")
	f.DropButton:GetPushedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 1)--(0.784, 0.850, 0.941)--(1, 0.737, 0, 1)
	f.DropButton:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	for k, v in pairs(Mixins.scripts.DropListButton) do
		f.DropButton:SetScript(k, v)
	end
	f.Text = f:CreateFontString()
	f.Text:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")
	f.Text:SetPoint("TOPLEFT", 4, -5)
	f.Text:SetPoint("BOTTOMRIGHT", f.DropButton, "BOTTOMLEFT", -4, 0)

	f.List = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	f.List:Hide()
	f.List:SetSize(150, 70)
	f.List:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, 0.6)
	f.List:SetBackdrop(WidgetBG)
	f.List:SetBackdropColor(0.150, 0.150, 0.150)
	f.List:SetBackdropBorderColor(0, 0, 0, 0.3)
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
	f:GetNormalTexture():SetVertexColor(0.150, 0.150, 0.150, 0.4)
	f:SetCheckedTexture("Interface/BUTTONS/WHITE8X8") 
	f:GetCheckedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.3)--(0.784, 0.850, 0.941)--(1, 0.737, 0, 0.3)
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
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self:SetEnabled(true)
	self:SetWidth(self.MyInformation.widget.width)
	self.DropButton.MyInformation = parent.DisplayOrder[self:GetID()] 
	self.DropButton.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.DropButton.Key = self.MyInformation.stat ~= "Profiles" and self.MyInformation.stat or parent.Key
	self.DropButton.Data = ListData[self.MyInformation.widget.data]
	for k, v in ipairs(self.DropButton.Data) do
		if v.value == self.DropButton.Settings[self.DropButton.Key] then
			self:SetText(v.text)
			break
		end
	end
	self.Tip:SetText(format(TipFormat, L[self.DropButton.Key.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	self.Tip:Show()
end

function Mixins.functions.DropListFrame.Reset(self)
	self.List:Hide()
end

function Mixins.functions.DropListFrame.SetEnabled(self, enabled)
	local r, g, b, a = self:GetBackdropBorderColor()
	a = enabled and 1 or 0.5
	self:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.5)
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
	PlayOnCheck()
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
	self:SetSize(5, 5)
	local widest = 0
	for k, v in ipairs(self.Data) do
		local row = AddonTable:GetWidget("DropListRow", self, k)
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
	local maxRows = floor((self:GetParent():GetBottom() - SinStatsConfigFrame:GetBottom())/dropListRowHeight)
	local modVal = total > maxRows and maxRows or 1
	local modAnchor = modVal > 1 and "TOPRIGHT" or "BOTTOMLEFT"
	local rows = 1
	for k, v in ipairs(self.Buttons) do
		v:ClearAllPoints()
		v:SetWidth(widest)
		if k == 1 then
			v:SetPoint("TOPLEFT", 2, -2)
			first = v
		elseif modVal > 1 and (k-1) % modVal == 0 then
			v:SetPoint("TOPLEFT", first, modAnchor, 0, 0)
			first = v
			rows = rows + 1
		else
			v:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 0)
		end
		last = v
	end
	local height = modVal > 1 and modVal * dropListRowHeight or total * dropListRowHeight
	self:SetSize((rows * widest) + 2, height + 2)
end

Mixins.functions.DropListRow = {}
function Mixins.functions.DropListRow.Init(self, parent, rowdata)--, id)
	self:SetParent(parent)
	self.Parent = parent
	self.RowData = rowdata
	local t, v = parent.Data[self:GetID()].text, parent.Data[self:GetID()].value
	if parent.Data == ListData.Fonts then
		self.Text:SetFont(AddonTable.LSM:Fetch("font", v), 15)
	else
		self.Text:SetFont(AddonTable.ConfigDefaultFont, 15)
	end
	self.Text:SetText(t)
	self:Show()
	return self.Text:GetWidth()
end

Mixins.scripts.DropListRow = {}
function Mixins.scripts.DropListRow.OnClick(self)
	PlayOnCheck()
	self:GetParent().Settings[self:GetParent().Key] = self.RowData.value
	self:GetParent():GetParent():SetText(self.RowData.text)
	self:GetParent():Hide() -- hide the list
	if self.Parent:GetParent():GetParent().RunAction then -- Used bu Profikles List
		self.Parent:GetParent():GetParent():RunAction("select")
		return
	end
	AddonTable:InitialiseProfile(AddonTable.Profile)
end

function Mixins.scripts.DropListRow.OnEnter(self)
	OnEnterFunc(self:GetParent():GetParent())
end

function Mixins.scripts.DropListRow.OnLeave(self)
	local leaveParent = self:GetParent():GetParent()
	leaveParent:GetScript("OnLeave")(leaveParent)
end

------------------------------------------
--			Main Menu Button			--
------------------------------------------
function W.MainMenuButton(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f.SpecialType = "MainMenuButton"
	f.NoResize = true
	Mixin(f, Mixins.functions.MainMenuButton)
	AddLabel(f)
	f:AnchorLabel("LEFT", 5, 0, true)
	f:SetJustifyH("LEFT")
	f:SetNormalTexture(AddonTable.TexturePath.."HighlightMenu")
	f:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, topTabColor.a	)
	f:SetHighlightTexture(AddonTable.TexturePath.."HighlightMenu")
	f.Collapsed = true
	f:SetSize(width, MainMenuButtonHeight)
	for k, v in pairs(Mixins.scripts.MainMenuButton) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.MainMenuButton = {}
function Mixins.functions.MainMenuButton.Collapse(self)
	if self.Collapsed then 
		return
	end
	self.Collapsed = true
	self:GetNormalTexture():SetAlpha(0)
	local configFrame = self:GetParent()
	if configFrame.MainMenuSelected.Anchor then
		AddonTable:KillWidget(configFrame.MainMenuSelected.Anchor)
		configFrame.MainMenuSelected.Anchor = nil
	end
	configFrame.MainMenuSelected = nil
end

function Mixins.functions.MainMenuButton.Expand(self)
	if not self.Collapsed then 
		return 
	end
	self.Collapsed = false
	self:GetNormalTexture():SetAlpha(1)
	local configFrame = self:GetParent()
	configFrame.MainMenuSelected = self
	if not self.DisplayFunc then
		print("|cffff0000No display function supplied for Main Menu item:", self.MyInformation.stat.."!")
		return
	end
	AddonTable.ConfigFrame.MainAnchor = AddonTable:GetWidget("AnchorFrame", configFrame)
--	AddonTable.ConfigFrame.MainAnchor.Border:Hide()
	AddonTable.ConfigFrame.MainAnchor:SetLabel(format(AddonTable.WidgetDisplayFormat, AddonTable:GetSpellIcon(self.MyInformation), (L[self.MyInformation.stat]))) -- CATEGORY HEADER TEXT
	AddonTable.ConfigFrame.MainAnchor:SetFontSize(20)
	AddonTable.ConfigFrame.MainAnchor:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	AddonTable.ConfigFrame.MainAnchor.Description:SetText(L[self.MyInformation.stat.."Description"])
	AddonTable.ConfigFrame.MainAnchor.CenterAlign = self.MyInformation.centeralign
	self.DisplayFunc(self, AddonTable.ConfigFrame.MainAnchor, AddonTable.TopAnchor, true)
	AddonTable.ConfigFrame.MainAnchor:Show()
end

Mixins.scripts.MainMenuButton = {}
function Mixins.scripts.MainMenuButton.OnClick(self)
	PlayOnTab()
	configFrame = self:GetParent()
--[[
	if not AddonTable.ConfigFrame.Logo.TopLeft then -- Move the logo on first click
		AddonTable.ConfigFrame.Logo.TopLeft = true
		AddonTable.ConfigFrame.Logo:ClearAllPoints()
		AddonTable.ConfigFrame.Logo:SetSize(45, 45)
		AddonTable.ConfigFrame.Logo:SetPoint("TOPLEFT", 5, -5)
	end
]]--
	if  configFrame.MainMenuSelected and configFrame.MainMenuSelected == self then
		return
	end
	if  configFrame.MainMenuSelected and configFrame.MainMenuSelected ~= self then
		KillPage("MainAnchor")
		KillPage("ChildAnchor")
		configFrame.MainMenuSelected:Collapse()
	end
	if self.Collapsed then
		self:Expand()
	else
		self:Collapse()
	end
end


--------------------------------------
--			Minimap Button			--
--------------------------------------
function W.MinimapButton(parent) -- All the funcions to do Profiles
	local f = AddonTable:GetWidget("CheckBox")
	f.SpecialType = "MinimapButton"
	Mixin(f, Mixins.functions.MinimapButton)
	return f
end

Mixins.functions.MinimapButton = {}
function Mixins.functions.MinimapButton.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Check.Settings = parent.SvTable[self.MyInformation.stat]
	self.Check.Key = "Show"
	self.Check:SetChecked(self.Check.Settings[self.Check.Key])
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
	self:SetWidth(self.Check:GetWidth() + self.Label:GetWidth() + 35)
	AdjustCheckTip(self, self.MyInformation.stat)
end

----------------------------------
--			Plain Button		--
----------------------------------
function W.PlainButton(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(50, topTabHeight - 3)
	f.SpecialType = "PlainButton"
	Mixin(f, Mixins.functions.PlainButton)
	AddLabel(f)
	f:AnchorLabel("CENTER")
	f:SetNormalTexture(AddonTable.TexturePath.."ButtonNormal")
	f:SetPushedTexture(AddonTable.TexturePath.."ButtonPushed")
	f:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.8)
	f:GetPushedTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.8)
	for k, v in pairs(Mixins.scripts.PlainButton) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.PlainButton = {}
function Mixins.functions.PlainButton.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
	self:SetWidth(self.Label:GetWidth() + 30)
end

function Mixins.functions.PlainButton.Reset(self)
	self.MyInformation = nil
	self:SetLabel("")
	self:SetWidth(10)
end

Mixins.scripts.PlainButton = {}
function Mixins.scripts.PlainButton.OnClick(self)
	self.Settings[self.Key] = true
	AddonTable:InitialiseProfile(AddonTable.Profile)
end

----------------------------------
--			Profiles			--
----------------------------------
local CurrentProfileFormat = "%s: %s"

local function FindInProfilekys(find)
	for k, v in pairs(SinStatsDB.profileKeys) do
		if v == find then
			return true
		end
	end
end

local function ProfileDisableAll(self) -- To Mixin or not to Mixin, that is.....
	self.Selected:SetEnabled(false)
	self.Delete:SetEnabled(false)
	self.Copy:SetEnabled(false)
	self.Create:SetEnabled(false)
	self.Cancel:Hide()
	self.ConfirmDelete:Hide()
	self.Delete:Show()
	self.Selected:Show()
	self.CopyIcon:Hide()
end

local function ResetProfileConfig(self)
	wipe(self.CurrentProfile)
	self.CurrentProfile[AddonTable.ProfileKey] = SinStatsDB.profileKeys[AddonTable.ProfileKey]
	self.SvTable = self.CurrentProfile
	self.Key = AddonTable.ProfileKey
	self.ProfileList:Init(self, self)
	self.ProfileList.Tip:Hide()
	self:RunAction("select")
end

Mixins.scripts.ProfileConfigButton = {}
function Mixins.scripts.ProfileConfigButton.OnClick(self)
	PlayOnTab()
	self:GetParent():RunAction(self.Action)
end

function Mixins.scripts.ProfileConfigButton.OnEnable(self)
	self:SetAlpha(1)
	self:GetNormalTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.8)
	self:GetPushedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.8)
end

function Mixins.scripts.ProfileConfigButton.OnDisable(self)
	self:SetAlpha(0.5)
	self:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b)	
	self:GetPushedTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b)
	
end

local function CreateProfileButton(self, label, action)
	local f = CreateFrame("Button", nil, self, "TruncatedButtonTemplate")
	f:SetSize(80, 26)
	f.Text = f:CreateFontString()
	f.Text:SetPoint("CENTER")
	f.Text:SetFont(AddonTable.ConfigDefaultFont, 12)
	f.Text:SetJustifyH("CENTER")
	f:SetNormalTexture(AddonTable.TexturePath.."ButtonNormal")
	f:SetPushedTexture(AddonTable.TexturePath.."ButtonPushed")
	f:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.8)--(0.784, 0.850, 0.941)--(1, 0.737, 0, 0.8)
	f:GetPushedTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.8)--(1, 0.737, 0, 0.8)
	f:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	local h = f:GetHighlightTexture()
	h:SetVertexColor(1, 1, 1, 1)
	f.Text:SetText(label)
	f.Action = action
	for k, v in pairs(Mixins.scripts.ProfileConfigButton) do
		f:SetScript(k, v)
	end
	return f
end

function W.ProfileConfig(parent) -- All the funcions to do Profiles
	local f = CreateFrame("Frame", "$parentProfiles", parent )
	f.SpecialType = "ProfileConfig"
	f:SetSize(400, 100)
	Mixin(f, Mixins.functions.ProfileConfig)

	local yOffset = 0
	ListData.Deafults = {} -- grab the default class profiles and format them for a doplist in case of a "Reset From Default"
	for k, v in pairs(AddonTable:GetClassDefaults()) do
		tinsert(ListData.Deafults, { text=k, value=v, })
	end
	sort(ListData.Deafults, function(a, b) 
		return a.text < b.text
	end)

	f.Instruction = f:CreateFontString()
	f.Instruction:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -4)
	f.Instruction:SetPoint("TOPLEFT", 0, 0)
	f.Instruction:SetJustifyH("LEFT")
	f.Instruction:SetText(L["SelectProfile"])	
	
	f.CurrentProfileText = f:CreateFontString()
	f.CurrentProfileText:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -2)
	f.CurrentProfileText:SetTextColor(greenColor.r, greenColor.g, greenColor.b)
	f.CurrentProfileText:SetPoint("CENTER", 0, -15)
	f.CurrentProfileText:SetJustifyH("CENTER")

	f.Selected = CreateProfileButton(f, L["Selected"], "selected") -- apply delete buttons
	f.Selected:SetPoint("CENTER", 50, -67)

	f.Cancel = CreateProfileButton(f, L["Cancel"], "cancel")
	f.Cancel:SetPoint("CENTER", f.Selected)
	f.Cancel:GetNormalTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.8)
	f.Cancel:GetPushedTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.8)

	f.Delete = CreateProfileButton(f, L["Delete"], "delete")
	f.Delete:SetPoint("LEFT", f.Selected, "RIGHT", 15, 0)
	f.Delete:GetNormalTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)
	f.Delete:GetPushedTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)	
	
	f.ConfirmDelete = CreateProfileButton(f, L["ConfirmDelete"], "confirmdelete")
	f.ConfirmDelete:SetPoint("CENTER", f.Delete)
	f.ConfirmDelete:GetNormalTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)
	f.ConfirmDelete:GetPushedTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)

	f.ProfileText = f:CreateFontString()
	f.ProfileText:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -5) -- "Profiles" TEXT
	f.ProfileText:SetPoint("LEFT", 0, -49)
	f.ProfileText:SetJustifyH("CENTER")
	f.ProfileText:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.ProfileText:SetText(L["ProfileSelected"])

	function f.RunAction(self, action) -- The magic happens here.
		ProfileDisableAll(self)
		local newProfile = strtrim(self.Edit:GetText())
		if self.SvTable[self.Key] ~= SinStatsDB.profileKeys[AddonTable.ProfileKey] then
			self.Selected:SetEnabled(true)
		end
		if action == "selected" then
			SinStatsDB.profileKeys[AddonTable.ProfileKey] = self.CurrentProfile[self.Key]
			AddonTable.Profile = SinStatsDB.profiles[SinStatsDB.profileKeys[AddonTable.ProfileKey]]
			AddonTable.NewSettings(AddonTable.Profile, AddonTable.Class)
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], SinStatsDB.profileKeys[AddonTable.ProfileKey]))
			ResetProfileConfig(self)
			AddonTable:UpdateProfile()
			for k, v in pairs(self:GetParent().PageAnchor.CurrentWidgets) do
				v.SvTable = v.Parent.SvTable
			end
			AddonTable:InitialiseProfile(AddonTable.Profile)
		end
		if action == "select" then
			if FindInProfilekys(self.SvTable[self.Key]) then
				if newProfile ~= "" and not FindInProfilekys(newProfile) then
					self.Copy:SetEnabled(true)
					self.CopyIcon:Show()
				end
			else
				self.Delete:SetEnabled(true)
			end
		end
		if action == "edit" then
			if newProfile ~= "" and not FindInProfilekys(newProfile) then
				self.Copy:SetEnabled(true)
				self.CopyIcon:Show()
			end		
		end
		if action == "copy" then
			self.Create:SetEnabled(true)
		end
		if action == "create" then
			SinStatsDB.profiles[newProfile] = {}
			AddonTable.CopyTable(SinStatsDB.profiles[self.SvTable[self.Key]], SinStatsDB.profiles[newProfile])
			UpdateProfiles()
			self.Edit:SetText("")
		end
		if action == "delete" then
			self.Delete:SetEnabled(true)
			self.Selected:SetEnabled(true)
			self.Delete:Hide() 
			self.Selected:Hide()

			self.ConfirmDelete:Show()
			self.Cancel:Show()
		end
		if action == "confirmdelete" then
			SinStatsDB.profiles[self.CurrentProfile[self.Key]] = nil
			UpdateProfiles()
			ResetProfileConfig(self)
		end
		if action == "cancel" then
			ProfileDisableAll(self)
			ResetProfileConfig(self)
		end
	end

	f.createOs = -55
	f.manageOs = -20
	f.Edit = W.EditBox(f, 200, 27)
	f.Edit:SetPoint("LEFT", 0, -120)
	f.Edit.Action = "edit"
	f.Edit:SetScript("OnTextChanged", function(self)
		self:GetParent():RunAction(self.Action)
	end)

	f.CopyIcon = f:CreateTexture()
	f.CopyIcon:SetSize(18, 15)
	f.CopyIcon:SetTexture(AddonTable.TexturePath.."ProfileCopy")
	f.CopyIcon:SetPoint("LEFT", 95, -92)
	f.CopyIcon:SetVertexColor(greenColor.r, greenColor.g, greenColor.b)
	
	f.Copy = CreateProfileButton(f, L["Copy"], "copy")
	f.Copy:SetPoint("CENTER", f.Selected, "CENTER", 0, -53) -- APPLY BUTTON SECOND ROW

	f.Create = CreateProfileButton(f, L["Create"], "create")
--	f.Create:SetPoint("CENTER", 125, f.createOs) -- CREATE BUTTON
	f.Create:SetPoint("LEFT", f.Copy, "RIGHT", 15, 0)
	f.NewProfileText = f:CreateFontString()
	f.NewProfileText:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize -5)
	f.NewProfileText:SetPoint("TOPLEFT", f.Edit, "TOPLEFT", 0, 11) -- NEW PROFILE TEXT
	f.NewProfileText:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.NewProfileText:SetJustifyH("CENTER")
	f.NewProfileText:SetText(L["NewProfile"])

	f.CurrentProfile = {} 

	return f
end

Mixins.functions.ProfileConfig = {}
function Mixins.functions.ProfileConfig.Init(self, anchorframe, parent, displaylist)
	UpdateProfiles()
	self.Anchoreframe = anchorframe
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self.Edit:SetText("")
	self.CurrentProfile[AddonTable.ProfileKey] = SinStatsDB.profileKeys[AddonTable.ProfileKey]
	self.SvTable = self.CurrentProfile
	self.Key = AddonTable.ProfileKey
	self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], SinStatsDB.profileKeys[AddonTable.ProfileKey]))
	self.ProfileList = AddonTable:GetWidget("DropList", self, self:GetID()) -- 4 = entry in AddonTable.SettingsGroupOrder table
	self.ProfileList:SetParent(self)
	self.ProfileList:ClearAllPoints()
	self.ProfileList:SetPoint("LEFT", 0, -67) -- PROFILE DROPLIST
	self.ProfileList:Init(self, self)
	self.ProfileList.Tip:Hide()
	self.ProfileList:Show()

	self:RunAction("select")
end

function Mixins.functions.ProfileConfig.Reset(self)
	AddonTable:KillWidget(self.ProfileList)
	self.ProfileList = nil
end


------------------------------
--		Sliders	    --
------------------------------
function W.Slider(parent)
	local f = CreateFrame("Slider", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(100, dropLiostandSliderHeight)
	f:SetBackdrop(SliderBG)
	f:SetBackdropColor(0.184, 0.184, 0.184, 0.5)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.5)
	AddTipText(f)
	f:SetValueStep(1)
	f:SetObeyStepOnDrag(true)
	f:SetOrientation("HORIZONTAL")
	f:SetFrameLevel(4)
	f:SetThumbTexture(AddonTable.TexturePath.."SliderThumb")
	f:GetThumbTexture():SetSize(10, 22)
	f:GetThumbTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.9)--(0.784, 0.850, 0.941)--(1, 0.737, 0, 0.9)
	f:GetThumbTexture():SetBlendMode("ADD")
	f.Min = f:CreateFontString()
	f.Min:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4)
	f.Min:SetPoint("LEFT", 3, 0)
	f.Min:SetJustifyH("LEFT")
	f.Min:SetJustifyV("BOTTOM")
	f.Max = f:CreateFontString()
	f.Max:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4)
	f.Max:SetPoint("RIGHT", -3, 0)
	f.Max:SetJustifyH("RIGHT")
	f.Max:SetJustifyV("BOTTOM")
	f.Value = f:CreateFontString()
	f.Value:SetFont(AddonTable.ConfigDefaultFont, 12)
	f.Value:SetPoint("CENTER")
	f.Value:SetTextColor(greenColor.r, greenColor.g, greenColor.b)
	f.Value:SetJustifyH("CENTER")
	f.Value:SetJustifyV("CENTER")
	Mixin(f, Mixins.functions.Slider)
	for k, v in pairs(Mixins.scripts.Slider) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.Slider = {}
local minMaxFormat = "- %s -"
function Mixins.functions.Slider.Init(self, anchorframe, parent, displaylist, orderlist)
	self:SetEnabled(true)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
--	self.Settings = self.Settings
	self.Key = self.Key
	self:SetWidth(self.MyInformation.widget.width)
	local min, max, value = self.MyInformation.widget.min, self.MyInformation.widget.max, self.Settings[self.Key]
	self.Min:SetText(type(min) == "string" and L[min] or min)
	self.Max:SetText(type(max) == "string" and L[max] or max)
	self.Value:SetText(type(value) == "string" and L[value] or value)
	self:SetMinMaxValues(min, max)
	self:SetValue(value)
	self.Tip:SetText(format(TipFormat, L[self.Key.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
end

Mixins.scripts.Slider = {}
function Mixins.scripts.Slider.OnValueChanged(self, value)
	self.Value:SetText(value)
	self.Settings[self.Key] = value
	AddonTable:InitialiseProfile(AddonTable.Profile)
end
function Mixins.scripts.Slider.OnDisable(self)
	self:SetAlpha(0.5)
end

function Mixins.scripts.Slider.OnEnable(self)
	self:SetAlpha(1)
end

------------------------------
--			ToolTip			--
------------------------------
function W.Tooltip(parent)
	if not gttFont then
		gttFont, gttFontSize, gttFontFlags = GameTooltipHeaderText:GetFont()
	end
	local f = CreateFrame("Frame")
	f.SpecialType = "Tooltip"
	f:SetSize(12, 12)
	f.Texture = f:CreateTexture()
	f.Texture:SetAllPoints()
	f.Texture:SetTexture(AddonTable.TexturePath.."Misc")
	Mixin(f, Mixins.functions.Tooltip)
	for k, v in pairs(Mixins.scripts.Tooltip) do
		f:SetScript(k, v)
	end
	return f
end
Mixins.functions.Tooltip = {}
function Mixins.functions.Tooltip.Init(self, parent, settings)
	self:SetParent(parent)
	self:Show()
	self:SetFrameStrata(parent:GetFrameStrata())
	self:SetFrameLevel(parent:GetFrameLevel() + 1)
	self:ClearAllPoints()
	local points = TooltipOffsets[parent.SpecialType] or TooltipOffsets.Default
	self:SetPoint(points.point, parent, points.topoint, points.x, points.y)
	self.Tip = settings.stat.."Tooltip"
end

function Mixins.functions.Tooltip.Reset(self)
	self.Tip = nil
	self:Hide()
end

Mixins.scripts.Tooltip = {}
function Mixins.scripts.Tooltip.OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltipHeaderText:SetFont(AddonTable.ConfigDefaultFont, 13, "")
	GameTooltip:SetText(L[self.Tip])
end
function Mixins.scripts.Tooltip.OnLeave(self)
	GameTooltipHeaderText:SetFont(gttFont, gttFontSize, gttFontFlags)
	GameTooltip:Hide()
end

----------------------------------
--			Top Tabs			--
----------------------------------
function W.TopTab(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(50, topTabHeight)
	f.SpecialType = "TopTab"
	Mixin(f, Mixins.functions.TopTab)
	AddLabel(f)
	f:AnchorLabel("CENTER")
	hooksecurefunc(f, "SetLabel", AdjustTopTabText)
	f.Properties = {}
	f:SetNormalTexture(AddonTable.TexturePath.."LabelBG")
	f:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, topTabColor.a)
	f:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	--f:GetHighlightTexture():SetVertexColor(blueColor.r, blueColor.g, blueColor.b, blueColor.a)
	for k, v in pairs(Mixins.scripts.TopTab) do
		f:SetScript(k, v)
	end
	
	f.Status = AddonTable:GetWidget("CheckButton", f) -- TOP TAB CHECKBOX
	f.Status:SetSize(11, 11)
	f.Status:SetPoint("RIGHT", -3, 1)
	f.Status:SetFrameLevel(f:GetFrameLevel() + 4)
	f.Status:SetHighlightTexture(AddonTable.TexturePath.."Highlight")
	return f
end

Mixins.functions.TopTab = {}
function Mixins.functions.TopTab.Init(self, anchorframe, parent, noicons)
	self.AnchorFrame = anchorframe
	self.Parent = parent 
	self.MyInformation = parent.DisplayOrder[self:GetID()]
--	self.GroupOrder = nil
	self.DisplayOrder = parent.NextDisplayOrder
	self.SvTable = parent.SvTable
	self.Key = self.MyInformation.stat.."Menu"
	if self.ActiveOnInit then
		self:Click()
		self.ActiveOnInit = nil
	else
		self:GetNormalTexture():SetAlpha(0.3)
		self.Properties.Checked = false
	end
	self:SetLabel(GetLabelText(self.Key, self.MyInformation, noicons))
	if type(self.SvTable[self.MyInformation.stat]) == "table" then --[self.MyInformation.stat].Show then
		self.Status.MyInformation = parent.DisplayOrder[self:GetID()]
		self.Status.Settings = self.SvTable[self.MyInformation.stat]
		self.Status.Key = "Show"
		self.Status:SetChecked(self.Status.Settings[self.Status.Key])
		self.Status:Show()
		self:AnchorLabel("LEFT", 6, 0, true)

	else
		self:AnchorLabel("CENTER")
		self.Status:Hide()
	end
end

function Mixins.functions.TopTab.Reset(self)
	wipe(self.Properties)
	self.Status:Reset()
end

Mixins.scripts.TopTab = {}
function Mixins.scripts.TopTab.OnClick(self)
	--PlayOnTab()
	local parent = self:GetParent()
	if parent.ActiveWidget and parent.ActiveWidget == self then 
		return
	end
	self.Properties.Checked = not self.Properties.Checked
	if self.Properties.Checked then
		self:GetNormalTexture():SetAlpha(1)
	else
		self:GetNormalTexture():SetAlpha(0.3)
	end
	KillPage("ChildAnchor")
	if self.Properties.Checked then
		self.AnchorFrame:SetActive(self)
		AddonTable.ConfigFrame.ChildAnchor = AddonTable:GetWidget("AnchorFrame", configFrame)
		AddonTable.ConfigFrame.ChildAnchor:SetLabel("")
		AddonTable.ConfigFrame.ChildAnchor.Description:SetText(format(AddonTable.WidgetDisplayFormat, AddonTable:GetSpellIcon(self.MyInformation), L[self.MyInformation.stat.."Menu"])) -- .."Description" STATS TOP LINE TEXT
		AddonTable.ConfigFrame.ChildAnchor.Description:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
		AddonTable.ConfigFrame.ChildAnchor.CenterAlign = self.MyInformation.centeralign
		self.Parent.DisplayFunc(self, AddonTable.ConfigFrame.ChildAnchor, self.AnchorFrame, false, true)
		for k, v in pairs(AddonTable.ConfigFrame.ChildAnchor.CurrentWidgets) do
			if v.Check and v.Check.Key == "Show" then
				v.Check.ParentLink = self.Status
				self.Status.ChildLink = v.Check
			end
		end
		AddonTable.ConfigFrame.ChildAnchor:Show()
	end
end

------------------------------------------
--			Get/Kill Widgets			--
------------------------------------------
function AddonTable:GetWidget(widgettype, parent, id)
	local widget
	if WidgetPool[widgettype] and #WidgetPool[widgettype] > 0 then
		widget = WidgetPool[widgettype][1]
		tremove(WidgetPool[widgettype], 1)
	end
	if not widget then
		widget = W[widgettype](parent, id)
	end
	if type(id) == "number" then
		widget:SetID(id)
	end
	return widget
end

function AddonTable:KillWidget(widget)
	widget:Hide()
	local widgettype = widget.SpecialType or widget:GetObjectType()
	if not WidgetPool[widgettype] then
		WidgetPool[widgettype] = {}
	end
	tinsert(WidgetPool[widgettype], widget)
--	widget:SetParent(UIParent)
	widget:ClearAllPoints()
	widget:SetID(-1)
	if widget.Reset then
		widget:Reset()
	end
	if widget.Tooltip then
		AddonTable:KillWidget(widget.Tooltip)
		widget.Tooltip = nil
	end
end

----------------------------------
--			Edit Box			--
----------------------------------
local function EditBox_Init(self)--, data, index)
	local text = self.Data[self.Index]
	if not text then
		text = ""
	end
	self.prevvalue = text
	self:SetText(text)
end

function W.EditBox(parent, width, height)
	local templates = "InputBoxTemplate"
	if BackdropTemplateMixin then
		templates = templates .. ", BackdropTemplate"
	end
	local f = CreateFrame("EditBox", nil, parent, templates)
	f:SetBackdrop(WidgetBG)
	f:SetBackdropColor(0.184, 0.184, 0.184, 0.5)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.5)
	f.Left:Hide()
	f.Right:Hide()
	f.Middle:Hide()
	f:SetSize(width, height)
	f:SetMaxLetters(80)
	f:SetAutoFocus(false)
	f:SetScript("OnEscapePressed", function(self)
		if self.prevvalue then
			self:SetText(self.prevvalue)
		else
			self:SetText("")
		end
		self:ClearFocus()
	end)
	return f
end
