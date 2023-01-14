----------------------------------
--			SinStats			--
----------------------------------
local AddName, AddonTable = ...

local L = AddonTable.L
local addVer = GetAddOnMetadata(AddName, "Version")
local LSM = LibStub("LibSharedMedia-3.0")
local headerWidth, headerHeight, updateSpeed = 200,15, 1

AddonTable.ConfigDefaultFontSize = 17 -- OVERALL FONTS RIGHT SIDE
AddonTable.TexturePath = "Interface\\AddOns\\"..AddName.."\\Textures\\"

AddonTable.IgnoreFormat = 0x1 -- just return the icon without any |T...:0|t. Can be used to display in Texture widgets
AddonTable.ForceIcon = 0x2 -- fors the use of the icon key is the source table has both a spell and and icon key
AddonTable.BottomLeft = 1 -- Option 1 use for anchor point of ident (indent???) stat. positioning
AddonTable.BottomRight = 2 -- Option 2 use for anchor point of ident (indent???) stat. positioning

function AddonTable.Band(var, flag)
	if var == nil then 
		return false
	end	
	if bit.band(var, flag) == flag then
		return true
	end
	return false
end

AddonTable.FunctionList = {}

------------------------------------------
--			Initialize Icons			--
------------------------------------------
local function LibInit()
	local MinimapIcon = LibStub("LibDataBroker-1.1"):NewDataObject("SinStats", 
		{
			type = "data source",
			text = "SinStats",
			icon = AddonTable.TexturePath.."MiniMap",
		
			OnTooltipShow = function(tooltip)
				tooltip:SetText("|cff71FFC9SinStats|r")
				tooltip:AddLine("[|cff71FFC9"..L["LeftClick"].."|r]"..L["OpenClose"], 1, 1, 1)
				tooltip:AddLine("[|cff71FFC9"..L["RightClick"].."|r] - "..L["EnableDisable"], 1, 1, 1)
				tooltip:AddLine("[|cff71FFC9"..L["ShiftRightClick"].."|r] - "..L["UnlockHUD"], 1, 1, 1)	
				tooltip:AddLine("[|cff71FFC9"..L["ControlClick"].."|r] - "..L["AttachPanel"], 1, 1, 1)
				tooltip:AddLine("[|cff71FFC9"..L["AltClick"].."|r] - "..L["DetachPanel"], 1, 1, 1)					
				tooltip:Show()
			end,
		
			OnClick = function(self, button, down) 
                if button == "LeftButton" then
                    AddonTable:ToggleConfig()
                elseif button == "RightButton" then
                    if IsShiftKeyDown() then
                        AddonTable.Profile.LockHUD = not AddonTable.Profile.LockHUD
                        AddonTable:InitialiseProfile(AddonTable.Profile)
                    elseif IsControlKeyDown() then
                        SinStatsFrame.HUD:SetParent(PaperDollFrame)
						SinStatsFrame:SetParent(PaperDollFrame)
						
					elseif IsAltKeyDown() then
						SinStatsFrame.HUD:SetParent(UIParent)
						SinStatsFrame:SetParent(UIParent)
                    else
                        AddonTable.Profile.HideHUD = not AddonTable.Profile.HideHUD
                        AddonTable:InitialiseProfile(AddonTable.Profile)
                    end
                end         
                
            end,
		}
	)
	AddonTable.sshMiniButton = LibStub("LibDBIcon-1.0")		
	AddonTable.sshMiniButton:Register("SinStats", MinimapIcon, AddonTable.Profile.Minimap)
end
-- One off function for new users or if they've deleted their WTF folder/SV file
local function InitDefaults()
	if SinStatsDB and SinStatsDB.profileKeys and SinStatsDB.profiles then 
		return 
	end
	SinStatsDB = { profileKeys={}, profiles={} }
	for k, v in pairs(AddonTable.byPlayerClass) do
		AddonTable:CreateProfile(k, nil, k)
	end
end

local function CheckForNewOptions()
	for profile, settings in pairs(SinStatsDB.profiles) do
		for stat, data in pairs(settings.Stats) do
			for _, statkey in pairs(AddonTable.DisplayOrder) do
				if statkey.stat == stat then
					if not statkey.options then
						break
					end
					for option, istrue in pairs(statkey.options) do
						for _, optionentry in pairs(AddonTable.Options) do
							if optionentry.stat == option then
								if istrue and (optionentry.default ~= nil) and data[option] == nil then
									data[option] = optionentry.default
								end
							end
						end
					end
				end
			end
		end
	end
end

function AddonTable.NewSettings(profile, class)
--[[ DO NOT REMOVE! ]]--
	AddonTable:CheckForStats(profile, class) -- Check if any new stats have been added to the AddonTable.DisplayOrder table
	CheckForNewOptions() -- Check if any new options have been added and add them to require SV stats in ALL profiles
--------- END ---------

--[[ 
	if not profile.SomeSetting then
		profile.SomeSetting = NewValue
	end
	if not profile.stats.SomeSetting then
		profile.stats.SomeSetting = NewValue
	end
	if not profile.SomeSetting and class == WARLOCK or class == ROGUE then
		profile.SomeSetting = NewValue
	end
	if not profile.stats.SomeSetting and class == WARLOCK or class == ROGUE then
		profile.stats.SomeSetting = NewValue
	end
	
]]--
end

--------------------------
--			HUD			--
--------------------------
local f = CreateFrame("Frame", "SinStatsFrame", UIParent)
f:SetSize(headerWidth, headerHeight)
f:SetPoint("CENTER", UIParent)
f:EnableMouse(true)
f:SetMovable(true)
f:RegisterForDrag("LeftButton")
f:SetUserPlaced(true)
f:SetClampedToScreen(false)
f:SetFrameStrata("MEDIUM")
f.Background = f:CreateTexture()
f.Background:SetAllPoints()
f.Background:SetColorTexture(0.1, 0.1, 0.1, 0.7)
f.Title = f:CreateFontString(nil, "OVERLAY");
f.Title:SetFontObject("GameFontHighlight");
f.Title:SetTextColor(1, 1, 1)
f.Title:SetText("SinStats")
f.Title:SetPoint("CENTER")
f:SetScript("OnDragStop", function(self) 
	self:StopMovingOrSizing()
end)

f.HUD = CreateFrame("Frame", nil, UIParent)
f.HUD:SetSize(headerWidth, 2)
f.HUD:SetPoint("TOP", f, "BOTTOM", 0, 1)
f.HUD:SetFrameStrata("MEDIUM")
f.HUD.StatList = {}
f:SetScript("OnDragStart", function(self) 
	self:StartMoving()
end)
f.HUD:SetScript("OnEvent", function (self, event, ...)
	if event == "PLAYER_LOGIN" then
		AddonTable:InitialiseVersionData()
--		print("|cff00f26dSinStats v" .. addVer .. "|r. Type |cff00f26d/sinstats|r or |cff00f26d/ss|r to open the settings.")
		AddonTable.Name = UnitName("player")
		AddonTable.ProfileKey = AddonTable.Name .. "-" .. GetRealmName()
		AddonTable.Class = select(2, UnitClass("player"))
		InitDefaults()
		if not SinStatsDB.profileKeys[AddonTable.ProfileKey] then
			if not SinStatsDB.profiles[AddonTable.Class] then
				AddonTable:CreateProfile(AddonTable.Class, nil, AddonTable.Class)
			end
			SinStatsDB.profileKeys[AddonTable.ProfileKey] = AddonTable.Class
		end
		AddonTable.Profile = SinStatsDB.profiles[SinStatsDB.profileKeys[AddonTable.ProfileKey]]
		AddonTable.NewSettings(AddonTable.Profile, AddonTable.Class)
		LibInit()
		AddonTable.talentScan()

		self:SetScript("OnEvent", function(self, event, ...)
			if AddonTable.EventList[event] then
				for _, v in pairs(AddonTable.EventList[event]) do
					v.func(v.widget, v.data, v.options, ...)
				end
			end
			AddonTable.OnEventFunc(event, ...)
		end)
		self.Elapsed = updateSpeed
		self:SetScript("OnUpdate", function(self, elapsed)
			self.Elapsed = self.Elapsed - elapsed
			if self.Elapsed >= 0 then 
				return
			end
			self.Elapsed = updateSpeed
			AddonTable.MeleeUpdate()
			AddonTable.DefenseUpdate()
			AddonTable.RangedUpdate()
			AddonTable.SpellUpdate()
			for k, v in ipairs(AddonTable.OnUpdateList) do
				v.func(v.widget, v.data, v.options, elapsed)
			end
		end)
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
end)
f.HUD:RegisterEvent("PLAYER_LOGIN")

--------------------------------------
--			Slash commands			--
--------------------------------------
SLASH_SINSTATS1 = "/sinstats"
SLASH_SINSTATS2 = "/ss"
function SlashCmdList.SINSTATS()
	AddonTable:ToggleConfig()
end
