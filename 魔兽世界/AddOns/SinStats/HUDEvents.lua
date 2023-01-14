local AddName, AddonTable = ...
local L = AddonTable.L
local frameHidden

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
if event == "PLAYER_ENTERING_WORLD" then

if AddonTable.Profile.EventEnable then
	local inInstance, instanceType = IsInInstance()
	
	if (AddonTable.Profile.EventDungeon and instanceType == "party" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = false
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (AddonTable.Profile.EventDungeon and not inInstance and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (not AddonTable.Profile.EventDungeon and AddonTable.eventChecked and instanceType == "party" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
	
	if (AddonTable.Profile.EventRaid and instanceType == "raids" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = false	
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (AddonTable.Profile.EventRaid and not inInstance and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (not AddonTable.Profile.EventRaid and AddonTable.eventChecked and instanceType == "raids" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
	
	if (AddonTable.Profile.EventPvP and instanceType == "pvp" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat ) then
		AddonTable.Profile.HideHUD = false	
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (AddonTable.Profile.EventPvP and not inInstance and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (not AddonTable.Profile.EventPvP and AddonTable.eventChecked and instanceType == "pvp" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end	

	if (AddonTable.Profile.EventArena and instanceType == "arena" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = false	
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (AddonTable.Profile.EventArena and not inInstance and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	elseif (not AddonTable.Profile.EventArena and AddonTable.eventChecked and instanceType == "arena" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
	
	if (AddonTable.Profile.EventWorld and instanceType == "none" and not AddonTable.Profile.CharPanel and not AddonTable.Profile.EventCombat) then
		AddonTable.Profile.HideHUD = false	
		SinStatsFrame.HUD:Show()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
	
	if (AddonTable.Profile.EventCombat and not AddonTable.Profile.EventWorld and not AddonTable.Profile.EventArena and not AddonTable.Profile.EventPvP and not AddonTable.Profile.EventRaid and not AddonTable.Profile.EventDungeon) and (not UnitAffectingCombat('player') or not InCombatLockdown()) then
		AddonTable.Profile.HideHUD = true	
		SinStatsFrame.HUD:Hide()
		AddonTable:InitialiseProfile(AddonTable.Profile)
	end
end
elseif event == "PLAYER_REGEN_DISABLED" then
	if AddonTable.Profile.EventEnable then 
		if (AddonTable.Profile.EventCombat and not AddonTable.CharPanel and (UnitAffectingCombat('player') or InCombatLockdown())) then
			AddonTable.Profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			AddonTable:InitialiseProfile(AddonTable.Profile)
		end
	end
elseif event == "PLAYER_REGEN_ENABLED" then
	if AddonTable.Profile.EventEnable then 
		if (AddonTable.Profile.EventCombat and not AddonTable.CharPanel and (not UnitAffectingCombat('player') or not InCombatLockdown())) then
			AddonTable.Profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			AddonTable:InitialiseProfile(AddonTable.Profile)
		end
	end
end
end)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")