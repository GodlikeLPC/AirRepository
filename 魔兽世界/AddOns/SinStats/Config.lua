local AddName, AddonTable = ...
local L = AddonTable.L
local menuItemHeight = 20
local itemPool = { menuitems={} }
local borderColor = { 1, 0, 0.658, 0.7 }
local borderColor2 = { 1, 0, 0.658, 0 }
local iconText = "%s %s"
local HOptionsOffsetX, HOptionsOffsetY, VOptionsOffsetY,  mainMenuYOffset, separatorOffsetY = 10, 6, 10, -82, 30
local sidePanelWidth -- set when f.SideBorder is created
local useGrp, useKey = true, true
--local greenColor = { r=0.443, g=1, b=0.788 }
local redColor = { r=1, g=0, b=0.658 }
local orangeColor = { r=1, g=0.741, b=0.313 }
local white = { r=1, g=1, b=1 }
AddonTable.ConfigDefaultFont = "Fonts/ARIALN.ttf"
local addVer = GetAddOnMetadata(AddName, "Version")

if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' or GetLocale() == 'koKR' then
    AddonTable.ConfigDefaultFont = AddonTable.LSM:Fetch("font", AddonTable.LSM:GetDefault("font"))
end
AddonTable.ConfigDefaultFontSize = 17

--------------------------------------
--			Config Setup			--
--------------------------------------

-----------------------------------------------
--			SV Items and Groupings			---
-----------------------------------------------
AddonTable.SettingsGroupOrder = {
	[1] = { stat="HUD", svnotintable=true, icon="HUD", widget={ type="TopTab" }, activeonload=true, },
	[2] = { stat="Fonts", svnotintable=true, centeralign=true, icon="Fonts", widget={ type="TopTab" }, },
	[3] = { stat="Display", svnotintable=true, icon="Display", widget={ type="TopTab" }, },
	[4] = { stat="Events", svnotintable=true, icon="Events", widget={ type="TopTab" }, },
	[5] = { stat="Profiles", svnotintable=true, icon="Profiles", widget={ type="TopTab" }, },
}

-- linked table: Odd keys (1, 3, ...) are the stat keys to act on (only works on stats that are shown together). Even keys (2, 4, ...) are the value that when set will disable the linked stat (otherwise enabled)
AddonTable.SettingsDisplayOrder = { -- stat key is the same name as used in SinStatsDB
	{ stat="HideHUD", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, },
	{ stat="LockHUD", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, },
	{ stat="PanelDisplay", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, },
	{ stat="HUDStrata", icon="", spellclass="HUD", default="MEDIUM", widget={ type="DropList", data="Strata", width=120, }, },
	{ stat="ResetPosition", icon="", spellclass="HUD", default=false, widget={ type="PlainButton", }, newline=true, },
	{ stat="StatFont", icon="", spellclass="Fonts", default=AddonTable.ConfigDefaultFont,  widget={ type="DropList", data="Fonts", width=170, }, },
	{ stat="StatFontSize", icon="", spellclass="Fonts", default=12, widget={ type="Slider", min=8, max=45, width=140, }, },
	{ stat="StatFontFlags", icon="", spellclass="Fonts", default="", widget={ type="DropList", data="FontFlags", width=140, }, }, -- no table="Stat" entry uses the AddonTable.DropListTables[stat] table  -- ["OutlineTable"] is in a table of tables in Config.
	{ stat="StatIcons", icon="", spellclass="Display", default=true, widget={ type="CheckBox", }, },
	{ stat="StatTextAbreviate", spellclass="Display", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="StatTextCaps", spellclass="Display", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="GroupOrder", icon="", spellclass="Display", default=false, widget={ type="CheckBox", }, },
	{ stat="Vertical", icon="", spellclass="Display", linked={"StatRows", true, "StatAlignment", false, "StatSpacingH", true, "StatSpacingV", false, }, default=true, widget={ type="CheckBox", }, newline=true, subgroup={ text="VerticalGroupText", icon="Spacing", },  },
	{ stat="StatAlignment", icon="", spellclass="Display", default="TOPLEFT", widget={ type="DropList", data="Alignments", width=90, }, newline=true, },
	{ stat="StatSpacingV", icon="", spellclass="Display", default=0, widget={ type="Slider", min=0, max=20, width=140, }, },
	{ stat="StatRows", icon="", spellclass="Display", default=2, widget={ type="DropList", data="Rows", width=90, }, newline=true, },
	{ stat="StatSpacingH", icon="", spellclass="Display", default=7, widget={ type="Slider", min=1, max=60, width=140, }, },
	{ stat="Minimap", icon="", spellclass="HUD", default={ Show=true, }, widget={ type="MinimapButton", }, newline=true, subgroup={ text="MinimapGroupText", icon="MinimapIcon", }, },
	{ stat="EventEnable", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventWorld", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="EventDungeon", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventRaid", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },	
	{ stat="EventPvP", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="EventArena", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventCombat", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="Profiles", icon="", svnotintable=true, spellclass="Profiles", widget={ type="ProfileConfig", data="Profiles", width=200, }, },
}

----------------------------------Tables used by DopLists ------------------------------------------
-- The Order entry table is the setting that will be stored in the SV file and controls the text displayed in the drop list, passed to the second parameter of the SetList(table, order)
-- The pairs() loop below the table creates and Options table in AddonTable.DropListTables["xxx"} key that is the ["stat"] = L["stat"] tables passed to the first parameter of the SetList(table, order) method
-- xxx:SetCallback("OnValueChanged" , function(widget, event, key)

function AddonTable.CopyTable(src, dest)
	for index, value in pairs(src) do
		if type(value) == "table" then
			dest[index] = {}
			AddonTable.CopyTable(value, dest[index])
		else
			dest[index] = value
		end
	end
end

function AddonTable:CheckForStats(currentprofile, class)
	local statSettings = AddonTable:GetClassDefaults(class)
	for k, v in pairs(AddonTable.DisplayOrder) do
		if not currentprofile.Stats[v.stat] then
			currentprofile.Stats[v.stat] = {}
			currentprofile.Stats[v.stat].Show = statSettings[v.stat] or false
			if v.options then
				for o,_ in pairs(v.options) do
					for _, so in pairs(AddonTable.Options) do
						if so.stat == o and so.default then
							currentprofile.Stats[v.stat][so.stat] = so.default
							break
						end
					end
				end
			end
		end
	end
end

function AddonTable:CreateProfile(newprofile, currentprofile, class) -- copies settings from the current to the new one
	if not currentprofile then
		if not class then
			print("Nothing to copy from!!!")
			return
		end
		currentprofile = {}
		for _, options in pairs(AddonTable.SettingsDisplayOrder) do
			currentprofile[options.stat] = options.default
		end
		currentprofile.Stats = {}
		AddonTable:CheckForStats(currentprofile, class)
	end
	SinStatsDB.profiles[newprofile] = {}
	AddonTable.CopyTable(currentprofile, SinStatsDB.profiles[newprofile])
end

------------------------------------------
--			Design Functions			--
------------------------------------------
local function DisplayHorizontal(self, anchorframe, align, astab, noicons)--, displayOrder, key, matchwith, noicons)
	widget = widget and strtrim(widget) or nil
 	local largestWidgetWidth, largestWidgetHeight = 0, 0
 	local widetType, b, c, d
	for k, v in ipairs(self.DisplayOrder) do
		if not v.spellclass or v.spellclass == self.MyInformation.stat or (self.MyInformation.options and self.MyInformation.options[v.spellclass]) then
			local stat = v.stat
			local setting = self.SvTable[stat]
			local f = AddonTable:GetWidget(astab and "TopTab" or v.widget.type, AddonTable.ConfigFrame, k)
			anchorframe:AddWidget(f)
			f.ActiveOnInit = astab and v.activeonload -- must come before f:Init
			f:Init(anchorframe, self, noicons)
			local w = f:GetWidth()
			local h = f:GetHeight()
			if w > largestWidgetWidth then
				largestWidgetWidth = w
			end
			if h > largestWidgetHeight then
				largestWidgetHeight = h
			end
			if v.tooltip then
				f.Tooltip = AddonTable:GetWidget("Tooltip", f)
				f.Tooltip:Init(f, v)
			end
		end
	end
	largestWidgetHeight = ceil(largestWidgetHeight)
	largestWidgetWidth = ceil(largestWidgetWidth)
 	local maxItemsPerRow = floor(AddonTable.maxOptionsWidth / (largestWidgetWidth + HOptionsOffsetX))
 	local firstOnRow, lastAnchor = anchorframe, anchorframe
 	local rows, modOffset, savYos = 0, 1, 0
 	local cols = min(maxItemsPerRow, #anchorframe.CurrentWidgets)
 	local pageAlignment = anchorframe.CenterAlign and "TOP" or "TOPLEFT"
 	local headerHeight = anchorframe.Description:GetHeight() + 16 -- y offset between header and top tabs
 	local SubGroupOs, SubGroupLabel
	for k, v in ipairs(anchorframe.CurrentWidgets) do
		if astab then
			v:SetWidth(largestWidgetWidth)
		end
		v:ClearAllPoints()
		local modVal = (k-modOffset) % maxItemsPerRow
		if k == 1 or v.MyInformation.newline or modVal == 0 then
			local yos = 0
			if k == 1 then
				yos = (HOptionsOffsetY * 2) + (headerHeight + 5) + anchorframe.Label:GetHeight()
			else
				if v.MyInformation.newline then
					modOffset = modOffset + modVal
				end
			end
			if v.Tip then
				yos = yos + 15-- CHANGES THE Y OFFSET OF 1ST ROW AND 2ND ROW OPTIONS - TOGETHER
			end
			rows = rows + 1
			yos = k == 1 and -yos or -(yos + largestWidgetHeight + HOptionsOffsetY)
			if v.MyInformation.newline and v.MyInformation.subgroup then
				SubGroupOs = (rows + 2) * largestWidgetHeight + separatorOffsetY + 20 -- 2nd breakline y offset
				local text = v.MyInformation.subgroup.text and v.MyInformation.subgroup.text or v.MyInformation.subgroup.stat
				SubGroupLabel = format(AddonTable.WidgetDisplayFormat, AddonTable:GetSpellIcon(v.MyInformation.subgroup), L[text])
				local text = v.MyInformation.subgroup.text and v.MyInformation.subgroup.text or v.MyInformation.subgroup.stat
				local iconSource = v.MyInformation.subgroup.icon and v.MyInformation.subgroup or v
				yos = yos - (HOptionsOffsetY * 15) -- 2ND ROW OPTIONS Y OFFSET
			end
			v:SetPoint("TOPLEFT", firstOnRow, "TOPLEFT", 0, yos)
			firstOnRow = v
			savYos = yos
		else
			v:SetPoint(pageAlignment, lastAnchor, largestWidgetWidth + HOptionsOffsetX, 0)
		end
		lastAnchor = v
		if v.SetLink then
			v:SetLink(anchorframe, self)
		end
		v:Show() -- required because widgets are hidden when they are "killed"
	end
	local width
	if SubGroupLabel or not astab then
		anchorframe.TopSeparator = AddonTable:GetWidget("Separator", anchorframe)
		anchorframe.TopSeparator:SetPoint("CENTER", anchorframe, "TOP", 0, -28) -- TOP BREAKLINE POSITION
		anchorframe.TopSeparator:Show()
		SubGroupOs = SubGroupOs or (rows + 1) * (largestWidgetHeight + separatorOffsetY)

		if SubGroupLabel then -- Adds bottom separator Minimap/Alignment
			anchorframe.BottomSeparator = AddonTable:GetWidget("Separator", anchorframe)
			anchorframe.BottomSeparator:Init()
			anchorframe.BottomSeparator:SetTextColor(anchorframe.BottomSeparator.OrangeColor.r, anchorframe.BottomSeparator.OrangeColor.g, anchorframe.BottomSeparator.OrangeColor.b) -- OPTION SECOND BREAKLINE COLOR TEXT
			anchorframe.BottomSeparator:SetLabel(SubGroupLabel)
			anchorframe.BottomSeparator:SetPoint("CENTER", anchorframe, "TOP", 0, -SubGroupOs)
			anchorframe.BottomSeparator:Show()
		else -- Adds bottom separator with description text
			anchorframe.BottomSeparator = AddonTable:GetWidget("Separator", anchorframe)
			anchorframe.BottomSeparator:Init(true)
			anchorframe.BottomSeparator:ClearAllPoints()
			anchorframe.BottomSeparator:SetPoint("CENTER", anchorframe.Description, "BOTTOM", 0, -SubGroupOs + 15) -- +20 reduces the 2nd breakline y offset from the checkboxes
			if self.MyInformation.options then
				anchorframe.BottomSeparator:SetLabel(L[self.MyInformation.stat.."Description"])
			end
			anchorframe.BottomSeparator:SetTextColor(1,1,1) -- COLOR FOR STATS DESCRIPTION TEXT
			anchorframe.BottomSeparator:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 4) -- FONT SIZE FOR STATS DESCRIPTION TEXT
			anchorframe.BottomSeparator:Show()
		end
		width = AddonTable.SeparatorWidth
	else
		width = cols * (largestWidgetWidth + HOptionsOffsetX) - (rows == 1 and HOptionsOffsetX or 0)
	end
	local height = rows * (largestWidgetHeight + HOptionsOffsetY) + HOptionsOffsetY + headerHeight + anchorframe.Label:GetHeight() + 20
	anchorframe:SetAnchor(align, width, height)-- + headerHeight)
end

function AddonTable:UpdateProfile()
	for i=0, #AddonTable.ConfigFrame.MainMenuItems do
		if i == 0 then
			AddonTable.ConfigFrame.MainMenuItems[i].SvTable = AddonTable.Profile
		else
			AddonTable.ConfigFrame.MainMenuItems[i].SvTable = AddonTable.Profile.Stats
		end
	end
end

----------------------------------
--			Main Menu			--
----------------------------------
local function CreateMainMenu()
	local last, click
	for i=0, #AddonTable.SpellClass do
		local v = AddonTable.SpellClass[i]
		local f = AddonTable:GetWidget("MainMenuButton", AddonTable.ConfigFrame, sidePanelWidth) -- -10)
		AddonTable.ConfigFrame.MainMenuItems[i] = f
		f:SetID(i)
		f:SetFontSize(15) -- LEFT MENU TEXT SIZE
		f:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b) -- LEFT MENU TEXT COLOR
		f:SetLabel(format(AddonTable.WidgetDisplayFormat, AddonTable:GetSpellIcon(v), L[AddonTable:GetSpellClass(i)]), "THICKOUTLINE")
		f.SpellClass = v.stat
		if i == 0 then -- Settings Tabs
			click = f
			f.DisplayOrder = AddonTable.SettingsGroupOrder
			f.GroupOrder = AddonTable.SettingsGroupOrder
			f.NextDisplayOrder = AddonTable.SettingsDisplayOrder
--			f.SvTable = AddonTable.Profile
		else  -- SpellClass Tabs
			f.DisplayOrder = AddonTable.DisplayOrder
			f.GroupOrder = AddonTable.SpellClass
			f.NextDisplayOrder = AddonTable.Options --AddonTable.OptionsList --AddonTable.GetStatOptionDefaults
--			f.SvTable = AddonTable.Profile.Stats
		end
		f.MyInformation = v
		f.DisplayFunc = DisplayHorizontal
		if i == 0 then
			f:SetPoint("TOPLEFT", AddonTable.ConfigFrame.TopBorder, "LEFT", 0, mainMenuYOffset) -- the first main menu item position relative to the top border line
			last = f
		else
			f:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -5)
			last = f
		end
 		AddonTable:UpdateProfile()
	end
	click:Click()
end

--------------------------------------
--			Config frame			--
--------------------------------------
local f = CreateFrame("frame", "SinStatsConfigFrame", UIParent)
f:SetPoint("CENTER")
f:SetMovable(true)
f:SetUserPlaced(true)
f:EnableMouse(true)
f:Hide()

local function InitConfig()
	local f = SinStatsConfigFrame
	AddonTable.ConfigFrame = f
	f.MainMenuItems = {} -- Toplevel items always visible

	f.Background = f:CreateTexture()
	f.Background:SetAllPoints()
	f.Background:SetColorTexture(0.05, 0.05, 0.05, 0.95)
	f:SetSize(AddonTable.ConfigWidth or 800, AddonTable.ConfigHeight or 500)
 
	f:SetClampedToScreen(false)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	f:SetFrameStrata("HIGH")
	tinsert(UISpecialFrames, AddonTable.ConfigFrame:GetName())
	f.Close = CreateFrame('Button', '$parentClose', f, "UIPanelCloseButton")
	f.Close:SetPoint('TOPRIGHT', -1,-1)
	f.Close:SetSize(15, 15)
	f.Close:SetFrameLevel(4)
	f.Close:SetHighlightTexture(AddonTable.TexturePath.."Highlight")	
	f.Close:SetNormalTexture(AddonTable.TexturePath.."Close")
	f.Close:GetNormalTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)
	f.Close:SetPushedTexture(AddonTable.TexturePath.."CloseDown")
	f.Close:GetPushedTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)
	f.Close:SetScript('OnClick', function(self)
		self:GetParent():Hide()
	end)	

	f.Title = f:CreateFontString("$parentTitle", "OVERLAY")
	f.Title:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize) -- SINSTATS TITLE TEXT SIZE
	f.Title:SetPoint("TOP", 0, -15)
	--f.Title:SetText("|cff71FFC9SinStats|r")-- |cffFFC515".. _G["EXPANSION_NAME"..GetExpansionLevel()].."|r")
	f.Logo = f:CreateTexture("$parentLogo", "OVERLAY")
	f.Logo:SetTexture(AddonTable.TexturePath.."SinStatsLogo")
--[[
	f.Logo:SetSize(300, 300) -- So the frame isn't mostly blank when first opened (MainMenuScripts.OnClick for where it's moved)
	f.Logo:SetPoint("CENTER", 70, -10)
]]--
	f.Logo:SetSize(75, 75)
	f.Logo:SetPoint("TOPLEFT", 25, 3)	

	f.Caption = CreateFrame("Frame", nil, f) -- Does the actual dragging
	--f.Caption:EnableMouse(true)
	f.Caption:SetPoint("TOPLEFT")
	f.Caption:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0, -50)
	-- f.Caption:RegisterForDrag("LeftButton")
	-- f.Caption:SetScript("OnDragStart", function(self) self:GetParent():StartMoving() end)
	-- f.Caption:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)
	
	f.TopBorder = f:CreateLine()
	f.TopBorder:SetDrawLayer("OVERLAY", 1)
	f.TopBorder:SetThickness(3)
	f.TopBorder:SetAlpha(0.5)
	--f.TopBorder:SetStartPoint("BOTTOMLEFT", f.Caption, 10, -2)
	f.TopBorder:SetStartPoint("BOTTOMLEFT", f.Caption, 10, 100)
	f.TopBorder:SetEndPoint("BOTTOMRIGHT", f.Caption, -10, -2)
	--f.TopBorder:SetColorTexture(unpack(borderColor))
	f.TopBorder:SetColorTexture(0.05, 0.05, 0.05, 0)

	f.SideBorder = f:CreateLine()
	f.SideBorder:SetDrawLayer("OVERLAY", 1)
	f.SideBorder:SetThickness(1)
	f.SideBorder:SetAlpha(0.5)
	f.SideBorder:SetStartPoint("LEFT", f.TopBorder, 141, 0)
	f.SideBorder:SetEndPoint("BOTTOMLEFT", f, 151, 0)
	f.SideBorder:SetColorTexture(unpack(borderColor))
	
	f.Version = f:CreateFontString("$parentTitle", "OVERLAY")
	f.Version:SetFont(AddonTable.ConfigDefaultFont, AddonTable.ConfigDefaultFontSize - 6)
	f.Version:SetPoint("BOTTOMLEFT", 65, 1)
	f.Version:SetText("|cff71ffc9" .. addVer .. "|r")	

	local point, relative, x, y = f.SideBorder:GetStartPoint()
	sidePanelWidth = select(3, f.SideBorder:GetStartPoint())
	AddonTable.maxOptionsWidth = f:GetWidth() - sidePanelWidth - 30 -- -30 right indent size
	AddonTable.SeparatorWidth  = AddonTable.maxOptionsWidth / 1.15
	f.TopAnchor = CreateFrame("Frame", nil, f)
	f.TopAnchor:SetSize(5, 2)
	f.TopAnchor:SetPoint("TOP", (sidePanelWidth/2), y-10) -- x,y entire right side panel content
	AddonTable.TopAnchor = f.TopAnchor
	
	CreateMainMenu()
end

function AddonTable:ToggleConfig()
	if not AddonTable.ConfigFrame then
		InitConfig()
	end
	AddonTable.ConfigFrame:SetShown(not AddonTable.ConfigFrame :IsShown())
end

--------------------------------------
--			Interface Panel			--
--------------------------------------
SinStatsInterface = {};
SinStatsInterface.panel = CreateFrame( "Frame", "SinStatsOptionsPanel", UIParent );
SinStatsInterface.panel.name = "SinStats";
InterfaceOptions_AddCategory(SinStatsInterface.panel);

local maintitle = SinStatsInterface.panel:CreateFontString("MainTitle", "OVERLAY", "GameFontHighlightLarge")
maintitle:SetPoint("TOP", "SinStatsOptionsPanel", "TOP", 0, -15)
maintitle:SetText("|cff71FFC9SinStats|r")
maintitle:SetFont("Fonts\\FRIZQT__.TTF", 45)

local _, _, _, tocversion = GetBuildInfo()
local OptionButton = CreateFrame('Button', '$parentSinStatsOptionsPanel', SinStatsOptionsPanel, "UIPanelButtonTemplate")
OptionButton:SetPoint("TOP", "MainTitle", "BOTTOM", 0, -40)
OptionButton:SetSize(160, 25)
OptionButton:SetText("|cffFFFFFFOpen SinStats Settings|r")

if tocversion >= 100000 then
OptionButton:SetScript('OnClick', function(self)
	HideUIPanel(SettingsPanel)
	HideUIPanel(GameMenuFrame)
	AddonTable:ToggleConfig()
end)
else
OptionButton:SetScript('OnClick', function(self)
	InterfaceOptionsFrame:Hide()
	HideUIPanel(GameMenuFrame)
	AddonTable:ToggleConfig()
end)
end

local tipText = SinStatsInterface.panel:CreateFontString("TipText", "OVERLAY", "GameFontHighlight")
tipText:SetPoint("TOP", "MainTitle", "BOTTOM", 0, -150)
tipText:SetText("|cffF2A427The settings panel can be accessed with the commands " .. "|cff00f26d/sinstats|r" .. " or " .. "|cff00f26d/ss|r")

local tipTextSnd = SinStatsInterface.panel:CreateFontString("TipTextSnd", "OVERLAY", "GameFontHighlight")
tipTextSnd:SetPoint("TOP", "TipText", "BOTTOM", 0, -3)
tipTextSnd:SetText("|cffF2A427The" .." |cff00f26dminimap button|r" .. " |cffF2A427can also be used to quickly access the settings.|r")

local VersionText = SinStatsInterface.panel:CreateFontString("VersionText", "OVERLAY", "GameFontHighlight")
VersionText:SetPoint("TOP", "TipTextSnd", "BOTTOM", 0, -70)
VersionText:SetText("|cffF2A427Version:|r " .. "|cff00f26d" .. addVer .. "|r")

local authorText = SinStatsInterface.panel:CreateFontString("authorText", "OVERLAY", "GameFontHighlight")
authorText:SetPoint("TOP", "VersionText", "BOTTOM", 0, -10)
authorText:SetText("|cffF2A427Author:|r |cff00f26dSinba|r")