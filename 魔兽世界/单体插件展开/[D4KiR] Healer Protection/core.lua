-- By D4KiR

function ToCurrentChat(msg)
	local _channel = "SAY"
	local inInstance, instanceType = IsInInstance()

	if D4_HP.GetConfig("channelchat", "AUTO") == "AUTO" then
		if inInstance then
			if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				_channel = "INSTANCE_CHAT"
			else
				if instanceType == "raid" then
					_channel = "RAID"
				elseif instanceType == "party" then
					_channel = "PARTY"
				end
			end
		else
			if UnitInRaid("player") then
				_channel = "RAID"
			elseif UnitInParty("player") then
				_channel = "PARTY"
			end
		end
	else
		_channel = D4_HP.GetConfig("channelchat", "AUTO")
	end

	local prefix = D4_HP.GetConfig("prefix", "[Healer Protection]")
	local suffix = D4_HP.GetConfig("suffix", "")

	if prefix ~= "" and prefix ~= " " then
		prefix = prefix .. " "
	elseif prefix == " " then
		prefix = ""
	end
	if suffix ~= "" and suffix ~= " " then
		suffix = " " .. suffix
	elseif suffix == " " then
		suffix = ""
	end

	-- if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then
		SendChatMessage(prefix .. msg .. suffix, _channel)
	-- end
end

local setup = false
function SetupHP()
	if not setup then
		setup = true
		print("|cff8888ffSetup " .. D4_HP.name)

		warning_aggro = CreateFrame("FRAME", nil, UIParent)
		warning_aggro:SetFrameStrata("BACKGROUND")
		warning_aggro:SetWidth(128)
		warning_aggro:SetHeight(64)

		warning_aggro.text = warning_aggro:CreateFontString(nil, "ARTWORK")
		warning_aggro.text:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
		warning_aggro.text:SetPoint("CENTER", 0, 340)
		warning_aggro.text:SetText(D4_HP.GT("youhaveaggro") .. "!")
		warning_aggro.text:SetTextColor(1, 0, 0, 1)

		hooksecurefunc("UpdateLanguage", function()
			warning_aggro.text:SetText(D4_HP.GT("youhaveaggro") .. "!")
		end)

		warning_aggro:SetPoint("CENTER", 0, 0)
		warning_aggro:Hide()

		D4_HP.InitSetting()

		D4_HP.Lang_enEN()
		if GetLocale() == "deDE" then
			D4_HP.msg("Language detected: deDE (Deutsch)")
			D4_HP.Lang_deDE()
		elseif GetLocale() == "ruRU" then
			D4_HP.msg("Language detected: ruRU (Russian)")
			D4_HP.Lang_ruRU()
		elseif GetLocale() == "frFR" then
			D4_HP.msg("Language detected: frFR (French)")
			D4_HP.Lang_frFR()
		else
			D4_HP.msg("Language not found (" .. GetLocale() .. "), using English one!")
			D4_HP.msg("If you want your language, please visit the cursegaming site of this project!")
		end

		UpdateLanguage()
	end
end
hooksecurefunc("UnitFramePortrait_Update", SetupHP)

local nearoom = false
local oom = false
local aggro = false
function pChat()
	if setup and warning_aggro ~= nil then
		local roleToken = "HEALER"
		local ugra = "HEALER"
		if IsRetail() then
			local id = GetSpecialization()
			if id ~= nil then
				roleToken = GetSpecializationRole(id)
				ugra = UnitGroupRolesAssigned("player")
			end
		end
		if ugra == "HEALER" or roleToken == "HEALER" then
			-- Aggro Logic
			if D4_HP.GetConfig("AGGRO", true) then
				local status = nil
				if IsRetail() then
					status = UnitThreatSituation("player")
				else
					status = UnitAffectingCombat("player")
				end
				local hp = UnitHealth("player")
				local hpmax = UnitHealthMax("player")
				local hpperc = hp / hpmax * 100
				if status ~= nil then
					if IsRetail() then
						if status > 0 and not aggro and hpperc < D4_HP.GetConfig("AGGROPercentage", 90) then
							if D4_HP.GetConfig("showaggrochat", true) then
								ToCurrentChat("{rt8}" .. " " .. D4_HP.GT("ihaveaggro"))
							end
							if D4_HP.GetConfig("showaggroemote", true) then
								DoEmote("incoming")
							end
							aggro = true
						elseif status == 0 and aggro then
							aggro = false
						end
					else
						if status and not aggro and hpperc < D4_HP.GetConfig("AGGROPercentage", 90) then
							if D4_HP.GetConfig("showaggrochat", true) then
								ToCurrentChat(D4_HP.GT("ihaveaggro"))
							end
							if D4_HP.GetConfig("showaggroemote", true) then
								DoEmote("incoming")
							end
							aggro = true
						elseif not status and aggro then
							aggro = false
						end
					end
				else
					aggro = false
				end
				if aggro then
					warning_aggro:Show()
				else
					warning_aggro:Hide()
				end
			else
				warning_aggro:Hide()
			end

			-- MANA Logic
			local _, powerToken, _, _, _ = UnitPowerType("player")
			if powerToken == "MANA" then
				local mana = UnitPower("player")
				local manamax = UnitPowerMax("player")
				local manaperc = math.round((mana / manamax) * 100, 1)

				-- Near OOM
				if D4_HP.GetConfig("NEAROOM", true) then
					if manaperc <= D4_HP.GetConfig("NEAROOMPercentage", true) and not nearoom then
						nearoom = true
						local tab = {}
						tab["MANA"] = manaperc
						if D4_HP.GetConfig("shownearoomchat", true) then
							ToCurrentChat(D4_HP.GT("nearoutofmana") .. " (" .. D4_HP.GT("xmana", tab) .. ").")
						end
						if D4_HP.GetConfig("shownearoomemote", true) then
							DoEmote("oom")
						end
					elseif manaperc > D4_HP.GetConfig("NEAROOMPercentage", true) + 20 and nearoom then
						nearoom = false
					end
				end

				-- OOM
				if D4_HP.GetConfig("OOM", true) then
					if manaperc <= D4_HP.GetConfig("OOMPercentage", true) and not oom then
						oom = true
						local tab = {}
						tab["MANA"] = manaperc
						if D4_HP.GetConfig("OOM", true) then
							if D4_HP.GetConfig("showoomchat", true) then
								ToCurrentChat(D4_HP.GT("outofmana") .. " (" .. D4_HP.GT("xmana", tab) .. ").")
							end
							if D4_HP.GetConfig("showoomemote", true) then
								DoEmote("oom")
							end
						end
					elseif manaperc > D4_HP.GetConfig("OOMPercentage", true) + 20 and oom then
						oom = false
					end
				end
			end
		end
	end
end
C_Timer.NewTicker(1, pChat)

local locs = {}
local frame = CreateFrame("Frame")
frame.past = {}
frame:SetScript("OnEvent",function(self, event, id)
	local loctype, _, text, _, _, _, duration, _, _, _ = C_LossOfControl.GetEventInfo(id)

	--[[
	local locTypes = {
		"STUN_MECHANIC",
		"STUN",
		"PACIFYSILENCE",
		"SILENCE",
		"FEAR",
		"CHARM",
		"PACIFY",
		"CONFUSE",
		"POSSESS",
		"SCHOOL_INTERRUPT",
		"DISARM",
		"ROOT",
	}
	]]

	local locTypes = {
		"STUN_MECHANIC",
		"STUN",
		"PACIFYSILENCE",
		"SILENCE",
		"FEAR",
		"CHARM",
		"PACIFY",
		"CONFUSE",
		"POSSESS",
		"SCHOOL_INTERRUPT",
		"ROOT",
	}

	if tContains(locTypes, loctype) then
		local trans = {}
		trans["ART"] = text
		trans["X"] = math.round(duration, 1)

		-- Safe LOCTYPE
		if locs[text] ~= nil then
			if locs[text] < GetTime() then
				locs[text] = nil
			elseif locs[text] > GetTime() then
				return
			end
		else
			locs[text] = GetTime() + duration
		end

		if text and (not self.past[text] or GetTime() > self.past[text]) then
			self.past[text] = GetTime() + duration
			if D4_HP.GetConfig("showloctext", true) then
				ToCurrentChat(D4_HP.GT("loctext", trans))
			end
			if D4_HP.GetConfig("showlocemote", true) then
				DoEmote("helpme")
			end
		end
	end
end)
frame:RegisterEvent("LOSS_OF_CONTROL_ADDED")

print("|c0000ffffLoaded |c008888ff" .. D4_HP.name .. "|c0000ffff by |c008888ff" .. D4_HP.author .. "|c0000ffff!")
