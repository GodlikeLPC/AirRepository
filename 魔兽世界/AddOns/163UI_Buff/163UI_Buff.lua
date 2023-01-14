local __addon, __plugins = ...;

__plugins.__env = setmetatable(
	{  },
	{
		__index = _G,
		__newindex = function(tbl, key, value)
			rawset(tbl, key, value);
			print("163UI_Buff Assign Global ", key, value);
			return value;
		end,
	}
);
setfenv(1, __plugins.__env);

_G[__addon] = __plugins;

local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();

----------------------------------------------------------------

-->		upvalue
	local strsub, strmatch, format = _G.string.sub, _G.string.match, _G.string.format;
	local IsAddOnLoaded = _G.IsAddOnLoaded
	local InCombatLockdown = _G.InCombatLockdown
	local UnitAura, UnitBuff, UnitDebuff = _G.UnitAura, _G.UnitBuff, _G.UnitDebuff
	local UnitName, UnitClassBase, UnitVehicleSeatInfo = _G.UnitName, _G.UnitClassBase, _G.UnitVehicleSeatInfo
	local UnitIsPlayer, UnitPlayerControlled = _G.UnitIsPlayer, _G.UnitPlayerControlled
	local GameTooltip = GameTooltip;

do										--	CastBy & SpellID
	local _enabled_SpellID = false;
	local _enabled_CastBy = false;

	local ColorTable = setmetatable(
		{  },
		{
			__index = function(tbl, key)
				if key ~= nil then
					tbl[key] = "|cffffffff";
				end
				return "|cffffffff";
			end
		}
	);

	local function _3rdAddonEnabledThisFeature_SpellID()
		return
		(
				(IsAddOnLoaded("TipTacItemRef") and (TipTac_Config == nil or TipTac_Config.if_showSpellIdAndRank))	--	TipTacItemRef could work without TipTac
			or	(IsAddOnLoaded("EventAlertMod"))	--	bullshit EAM couldnot be disabled
		);
	end
	local function _3rdAddonEnabledThisFeature_CastBy()
		return
		(
				(IsAddOnLoaded("TipTacItemRef") and (TipTac_Config == nil or TipTac_Config.if_showAuraCaster))	--	TipTacItemRef could work without TipTac
		);
	end

	local function Hook(auraFunc, showSpellID, showCastBy, ...)
		local caster = nil;
		local name, texture, count, debuffType, duration, expirationTime, source, _, _, spellID, _, _, _, _, timeMod = auraFunc(...)
		if showCastBy and source ~= nil then
			if UnitIsPlayer(source) then
				caster = ColorTable[UnitClassBase(source)] .. UnitName(source) .. "|r";
			elseif UnitPlayerControlled(source) then
				local _, name = UnitVehicleSeatInfo(source, 1);
				if name ~= nil then
					local _, name2 = UnitVehicleSeatInfo(source, 2);
					if name2 then
						caster = ColorTable[UnitClassBase(name)] ..  name .. "|r & " .. ColorTable[UnitClassBase(name2)] .. name2 .. "|r";
					else
						caster = ColorTable[UnitClassBase(name)] ..  name .. "|r";
					end
				else
					if source == "pet" then
						caster = "|cffffffff" .. UnitName(source) .. "|r (" .. ColorTable[UnitClassBase('player')] .. UnitName('player') .. "|r)";
					elseif strsub(source, 1, 8) == "partypet" then
						local owner = "party" .. strsub(source, 9);
						caster = "|cffffffff" .. UnitName(source) .. "|r (" .. ColorTable[UnitClassBase(owner)] .. UnitName(owner) .. "|r)";
					elseif strsub(source, 1, 7)=="raidpet" then
						local owner = "raid" .. strsub(source, 8);
						caster = "|cffffffff" .. UnitName(source) .. "|r (" .. ColorTable[UnitClassBase(owner)] .. UnitName(owner) .. "|r)";
					else
						caster = "|cffffffff" .. UnitName(source) .. "|r";
					end
				end
			else
				caster = "|cffffffff" .. UnitName(source) .. "|r";
			end
		end
		if showSpellID and spellID ~= nil then
			GameTooltip:AddLine(" ");
			if caster ~= nil then
				GameTooltip:AddDoubleLine("|cff00ffff法术ID: |r|cffffffff" .. spellID, "|cff00ffff施法者: |r" .. caster);
			else
				GameTooltip:AddLine("|cff00ffff法术ID: |r|cffffffff" .. spellID);
			end
			GameTooltip:Show();
		elseif caster ~= nil then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine("|cff00ffff施法者: |r|cffffffff" .. caster);
			GameTooltip:Show();
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		for class, val in next, CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS do
			ColorTable[class] = ("|c" .. val.colorStr) or format("|cff%02x%02x%02x", val.r * 255, val.g * 255, val.b * 255);
		end
		hooksecurefunc(GameTooltip, "SetUnitAura", function(tip, ...)
			local showSpellID =  _enabled_SpellID and not _3rdAddonEnabledThisFeature_SpellID();
			local showCastBy =  _enabled_CastBy and not _3rdAddonEnabledThisFeature_CastBy();
			if showSpellID or showCastBy then
				Hook(UnitAura, showSpellID, showCastBy, ...);
			end
		end);
		hooksecurefunc(GameTooltip, "SetUnitBuff", function(tip, ...)
			local showSpellID =  _enabled_SpellID and not _3rdAddonEnabledThisFeature_SpellID();
			local showCastBy =  _enabled_CastBy and not _3rdAddonEnabledThisFeature_CastBy();
			if showSpellID or showCastBy then
				Hook(UnitBuff, showSpellID, showCastBy, ...);
			end
		end);
		hooksecurefunc(GameTooltip, "SetUnitDebuff", function(tip, ...)
			local showSpellID =  _enabled_SpellID and not _3rdAddonEnabledThisFeature_SpellID();
			local showCastBy =  _enabled_CastBy and not _3rdAddonEnabledThisFeature_CastBy();
			if SpellID or showCastBy then
				Hook(UnitDebuff, showSpellID, showCastBy, ...);
			end
		end);
	end

	local function _Enable_SpellID(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_SpellID = true;
	end
	local function _Disable_SpellID(loading)
		_enabled_SpellID = false;
	end
	__plugins['SpellID'] = { _Enable_SpellID, _Disable_SpellID, };

	local function _Enable_CastBy(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_CastBy = true;
	end
	local function _Disable_CastBy(loading)
		_enabled_CastBy = false;
	end
	__plugins['CastBy'] = { _Enable_CastBy, _Disable_CastBy, };
end


if _toc_version >= 70000 then			--	MountTip
	local C_MountJournal_GetNumMounts = _G.C_MountJournal.GetNumMounts;
	local C_MountJournal_GetDisplayedMountInfo = _G.C_MountJournal.GetDisplayedMountInfo;
	local C_MountJournal_GetMountInfoExtraByID = _G.C_MountJournal.GetMountInfoExtraByID;

	local _enabled = false;

	local mountsData = {  };
	local function UpdateMountsData()
		for i = 1, C_MountJournal_GetNumMounts() do
			local creatureName, spellID, icon, active, summonable, source, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal_GetDisplayedMountInfo(i);
			if spellID ~= nil then
				if isCollected then
					mountsData[spellID] = mountID;
				else
					mountsData[spellID] = -mountID;
				end
			end
		end
	end

	local function HookMountBuffInfo(self, unit, index, filter)
		if not InCombatLockdown() and UnitIsPlayer(unit) then
			local name, texture, count, debuffType, duration, expirationTime, _, _, _, spellID, _, _, _, _, timeMod = UnitAura(unit, index, filter);
			local mountID = mountsData[spellID];
			if mountID ~= nil then
				GameTooltip:AddLine(" ")
				if mountID > 0 then
					GameTooltip:AddDoubleLine("坐骑来源：", "(已收集)", 0, 1, 0, 0, 1, 0)
					local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal_GetMountInfoExtraByID(mountID);
					GameTooltip:AddLine(sourceText, 1, 1, 1)
				else
					GameTooltip:AddDoubleLine("坐骑来源：", "(未收集)", 1, 0, 0, 1, 0, 0)
					local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal_GetMountInfoExtraByID(-mountID);
					GameTooltip:AddLine(sourceText, 1, 1, 1)
				end
				GameTooltip:Show()
			end
		end
	end

	local NumHookedBuff = 0;
	local function HookTargetFrame_UpdateAuras(frame)
		local Buff = frame.Buff;
		if Buff ~= nil then
			local num = #Buff;
			if num > NumHookedBuff then
				for index = NumHookedBuff + 1, num do
					SetOrHookScript(Buff[index], "OnClick", function(self)
						if not InCombatLockdown() then
							local name, texture, count, debuffType, duration, expirationTime, _, _, _, spellID, _, _, _, _, timeMod = UnitAura(self.unit, self:GetID(), nil);
							local mountID = mountsData[spellID];
							if mountID ~= nil then
								if not IsAddOnLoaded("Blizzard_Collections") then
									CollectionsJournal_LoadUI()
								end
								if not CollectionsJournal:IsVisible() then
									ToggleFrame(CollectionsJournal)
								end
								MountJournal.selectedSpellID = spellID;
								MountJournal.selectedMountID = abs(mountID);
								MountJournal_UpdateMountDisplay();
							end
						end
					end);
					NumHookedBuff = index;
				end
			end
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		hooksecurefunc(GameTooltip, "SetUnitAura", HookMountBuffInfo);
		hooksecurefunc(GameTooltip, "SetUnitBuff", HookMountBuffInfo);
		CoreDependCall("Blizzard_Collections", function()
			if CollectionsJournal then
				CollectionsJournal:HookScript("OnHide", UpdateMountsData);
			end
		end)
		UpdateMountsData();
		hooksecurefunc("TargetFrame_UpdateAuras", HookTargetFrame_UpdateAuras);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled = true;
		UpdateMountsData();
	end
	local function _Disable(loading)
		_enabled = false;
	end

	__plugins['MountTip'] = { _Enable, _Disable, };
end


do										--	BuffFrame & TemporaryEnchantFrame
	local _enabled = false;
	local _FontSize = 10;
	local _enabled_NA = false;
	local _enabled_Seconds = false;
	local _enabled_SecondsGE10 = false;

	local BuffFrame = _G.BuffFrame;
	local NAString = "|cff00ff00N/A|r";
	local ManualButtonArray = _toc_version < 90000;
	local NumHookedBuff = 0;
	local NumHookedDebuff = 0;

	local function ButtonDurationSetFont(buttonDuration)
		local font, _, flag = buttonDuration:GetFont();
		buttonDuration:SetFont(font, _FontSize, flag);
	end
	local HookedButtonDurations = {  };
	local function HookButtonDuration(buttonDuration)
		HookedButtonDurations[buttonDuration] = true;
		buttonDuration:SetWidth(40);
		ButtonDurationSetFont(buttonDuration);
	end
	local function HookDebuffButton_UpdateAnchors(buttonName, index)
		local button = nil;
		if ManualButtonArray then
			button = _G["DebuffButton" .. index];
			BuffFrame.DebuffButton[index] = button;
		else
			button = BuffFrame.DebuffButton[index];
		end
		local buttonDuration = button.duration;
		if HookedButtonDurations[buttonDuration] == nil then
			HookButtonDuration(buttonDuration);
		end
	end
	local function HookBuffButton_OnLoad(button)
		if ManualButtonArray then
			-- BuffFrame.BuffButton[button:GetID()] = button;
			BuffFrame.BuffButton[#BuffFrame.BuffButton + 1] = button;
		end
		local buttonDuration = button.duration;
		if HookedButtonDurations[buttonDuration] == nil then
			HookButtonDuration(buttonDuration);
		end
	end

	--/run local a,b,c,d,f=debugprofilestart,debugprofilestop,1,2,format;a()for i=1,1000 do e=f("124%d:%02d",c,d) end print(b())a()for i=1,1000 do if d<10 then e="124"..c..":0"..d.."d"else e="124"..c..":"..d.."d"end end print(b())
	--/run local a,b,c,d,f=debugprofilestart,debugprofilestop,1,2,format;a()for i=1,1000 do if d<10 then e="124"..c..":0"..d.."d"else e="124"..c..":"..d.."d"end end print(b())a()for i=1,1000 do e=f("124%d:%02d",c,d) end print(b())
	--/run local a,b,c,d,f=debugprofilestart,debugprofilestop,1,2,format;a()for i=1,1000 do e=f("12400:%02d",d) end print(b())a()for i=1,1000 do if d<10 then e="12400:0"..d.."d"else e="124"..c..":"..d.."d"end end print(b())
	--/run local a,b,c,d,f=debugprofilestart,debugprofilestop,1,2,format;a()for i=1,1000 do if d<10 then e="12400:0"..d.."d"else e="124"..c..":"..d.."d"end end print(b())a()for i=1,1000 do e=f("12400:%02d",c,d) end print(b())
	local function SecondsToTimeAbbrev(sec)
		local d, h, m, s = nil;
		if sec > 86400 then				--	1d
			d = sec / 86400; d = d - d % 1.0;
			h = (sec % 86400) / 3600; h = h - h % 1.0;
			return format("|cffffd100%dd%02dh", d, h);
		elseif sec > 3600 then			--	3h
			h = sec / 3600; h = h - h % 1.0;
			m = (sec % 3600) / 60; m = m - m % 1.0;
			return format("|cffffd100%dh%02dm", h, m);
		elseif sec >= 600 then
			m = sec / 60; m = m - m % 1.0;
			if _enabled_SecondsGE10 then
				s = sec % 60;
				return format("|cff00ff00%d:%02d", m, s);
			else
				return format("|cff00ff00%dm", m);
			end
		elseif sec >= 60 then
			m = sec /60; m = m - m % 1.0;
			s = sec % 60;
			return format("|cff00ff00%d:%02d", m, s);
		elseif sec > 0 then
			sec = sec - sec % 1.0;
			return (sec < 10 and "|cffff00000:0" or "|cffff00000:") .. sec;
		else
			return NAString;
		end
	end

	local function HookAuraButton_UpdateDuration(button, timeleft)
		if _enabled_Seconds and SHOW_BUFF_DURATIONS == "1" then
			if timeleft ~= nil then
				local buttonDuration = button.duration;
				if buttonDuration:IsShown() then
					buttonDuration:SetText(SecondsToTimeAbbrev(timeleft));
				end
			end
		end
	end
	local function HookAuraButton_Update(buttonName, index, filter)
		if _enabled_NA and SHOW_BUFF_DURATIONS == "1" then
			local button = BuffFrame[buttonName][index];			--	The same key on client 9.0.x
			if button ~= nil then
				local buttonDuration = button.duration;
				if buttonDuration ~= nil then
					local name, _, _, _, _, expirationTime = UnitAura('player', index, filter);
					if name ~= nil and expirationTime == 0 then
						buttonDuration:SetText(NAString);
						buttonDuration:Show();
					end
				end
			end
		end
	end
	local function UpdateAllNA()
		if SHOW_BUFF_DURATIONS == "1" then
			local BuffButton = BuffFrame.BuffButton;
			local DebuffButton = BuffFrame.DebuffButton;
			if BuffButton ~= nil then
				for index = 1, #BuffButton do
					local button = BuffButton[index];
					local buttonDuration = button.duration;
					if _enabled_NA then
						if button:IsShown() and not buttonDuration:IsShown() then
							buttonDuration:SetText(NAString);
							buttonDuration:Show();
						end
					else
						if buttonDuration:GetText() == NAString then
							buttonDuration:Hide();
						end
					end
				end
			end
			if DebuffButton ~= nil then
				for index = 1, #DebuffButton do
					local button = DebuffButton[index];
					local buttonDuration = button.duration;
					if _enabled_NA then
						if button:IsShown() and not buttonDuration:IsShown() then
							buttonDuration:SetText(NAString);
							buttonDuration:Show();
						end
					else
						if buttonDuration:GetText() == NAString then
							buttonDuration:Hide();
						end
					end
				end
			end
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		hooksecurefunc("BuffButton_OnLoad", HookBuffButton_OnLoad);
		local _Buff = BuffFrame.BuffButton;
		if ManualButtonArray and _Buff == nil then
			_Buff = {  };
			BuffFrame.BuffButton = _Buff;
			if BUFF_ACTUAL_DISPLAY > 0 then
				for _index = 1, BUFF_ACTUAL_DISPLAY do
					_Buff[_index] = _G["BuffButton" .. _index];
				end
			end
		end
		if _Buff ~= nil then
			for _index = 1, #_Buff do
				HookButtonDuration(_Buff[_index].duration);
			end
			NumHookedBuff = #_Buff;
		end
		hooksecurefunc("TempEnchantButton_OnLoad", HookBuffButton_OnLoad);
		local _TempEnchant = TemporaryEnchantFrame.TempEnchant;
		if ManualButtonArray and _TempEnchant == nil then
			_TempEnchant = {};
			TemporaryEnchantFrame.TempEnchant = _TempEnchant;
			for _index = 1, 1024 do
				local _F = _G["TempEnchant" .. _index];
				if _F == nil then
					break;
				end
				_TempEnchant[_index] = _F;
			end
		end
		for _index = 1, #_TempEnchant do
			HookButtonDuration(_TempEnchant[_index].duration);
		end
		local _Debuff = BuffFrame.DebuffButton;
		if ManualButtonArray and _Debuff == nil then
			_Debuff = {  };
			BuffFrame.DebuffButton = _Debuff;
			if DEBUFF_ACTUAL_DISPLAY > 0 then
				for _index = 1, DEBUFF_ACTUAL_DISPLAY do
					_Debuff[_index] = _G["DebuffButton" .. _index];
				end
			end
		end
		if _Debuff ~= nil then
			for _index = 1, #_Debuff do
				HookButtonDuration(_Debuff[_index].duration);
			end
			NumHookedDebuff = #_Debuff;
		end
		hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButton_UpdateAnchors);

		hooksecurefunc("AuraButton_UpdateDuration", HookAuraButton_UpdateDuration);
		hooksecurefunc("AuraButton_Update", HookAuraButton_Update);
	end

	local function _Enable_NA(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_NA = true;
		UpdateAllNA();
	end
	local function _Disable_NA(loading)
		_enabled_NA = false;
		UpdateAllNA();
	end
	__plugins['BuffFrame-NA'] = { _Enable_NA, _Disable_NA, };

	local function _Enable_Seconds(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_Seconds = true;
	end
	local function _Disable_Seconds(loading)
		_enabled_Seconds = false;
	end
	__plugins['BuffFrame-Seconds'] = { _Enable_Seconds, _Disable_Seconds, };

	local function _Enable_SecondsGE10(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_SecondsGE10 = true;
	end
	local function _Disable_SecondsGE10(loading)
		_enabled_SecondsGE10 = false;
	end
	__plugins['BuffFrame-SecondsGE10'] = { _Enable_SecondsGE10, _Disable_SecondsGE10, };

	__plugins['BuffFrame-FontSize'] = {
		nil,
		nil,
		function(cfg, value, loading)
			_FontSize = value;
			for buttonDuration in next, HookedButtonDurations do
				ButtonDurationSetFont(buttonDuration);
			end
		end
	};
end


do										--	TargetFrame & FocusFrame
	local ManualButtonArray = _toc_version < 90000;

	local function _proc0(frame)
		if ManualButtonArray then
			frame._NumBuff = frame._NumBuff or 0;
			frame._NumDebuff = frame._NumDebuff or 0;
			hooksecurefunc(
				"TargetFrame_UpdateAuraPositions",
				function(self, auraName, numAuras, numOppositeAuras, largeAuraList, func)
					if auraName == "TargetFrameBuff" or auraName == "FocusFrameBuff" then
						if numAuras > self._NumBuff then
							local _Buff = self.Buff;
							for _index = self._NumBuff + 1, numAuras do
								local _button = _G[auraName .. _index];
								_Buff[_index] = _button;
								_button.Cooldown = _G[auraName .. _index .. "Cooldown"];
							end
							self._NumBuff = numAuras;
						end
					elseif auraName == "TargetFrameDebuff" or auraName == "FocusFrameDebuff" then
						if numAuras > self._NumDebuff then
							local _Debuff = self.Debuff;
							for _index = self._NumDebuff + 1, numAuras do
								local _button = _G[auraName .. _index];
								_Debuff[_index] = _button;
								_button.Cooldown = _G[auraName .. _index .. "Cooldown"];
							end
							self._NumDebuff = numAuras;
						end
					end
				end
			);
			local _Buff = frame.Buff;
			if _Buff == nil then
				_Buff = {  };
				frame.Buff = _Buff;
				for _index = 1, MAX_TARGET_BUFFS do
					local _button = _G["TargetFrameBuff" .. _index];
					if _button ~= nil then
						_Buff[_index] = _button;
						_button.Cooldown = _G["TargetFrameBuff" .. _index .. "Cooldown"];
					else
						break;
					end
				end
				frame._NumBuff = #_Buff;
			end
			local _Debuff = frame.Debuff;
			if _Debuff == nil then
				_Debuff = {  };
				frame.Debuff = _Debuff;
				for _index = 1, MAX_TARGET_DEBUFFS do
					local _button = _G["TargetFrameDebuff" .. _index];
					if _button ~= nil then
						_Debuff[_index] = _button;
						_button.Cooldown = _G["TargetFrameDebuff" .. _index .. "Cooldown"];
					else
						break;
					end
				end
				frame._NumDebuff = #_Debuff;
			end
		end
	end
	local _isInitialized0 = false;
	local function _Init0()
		if not _isInitialized0 then
			_isInitialized0 = true;
			_proc0(TargetFrame);
			if FocusFrame ~= nil then
				_proc0(FocusFrame);
			end
		end
	end
--										--	LargeAura
	local _enabled_Buff = false;
	local _enabled_Debuff = false;
	local _LargeBuffSize = 21;
	local _SmallBuffSize = 17;
	local _LargeDebuffSize = 21;
	local _SmallDebuffSize = 17;

	local function HookTargetFrame_UpdateAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, func)
		if _enabled_Buff and func == TargetFrame_UpdateBuffAnchor then
			if numAuras > 0 then
				local Buff = self.Buff;
				for index = 1, numAuras do
					local size = largeAuraList[index] and _LargeBuffSize or _SmallBuffSize;
					local buff = Buff[index];
					buff:SetSize(size, size);
					if buff.Stealable ~= nil then
						buff.Stealable:SetSize(size + 2, size + 2);
					end
				end
			end
		elseif _enabled_Debuff and func == TargetFrame_UpdateDebuffAnchor then
			if numAuras > 0 then
				local Debuff = self.Debuff;
				for index = 1, numAuras do
					local size = largeAuraList[index] and _LargeDebuffSize or _SmallDebuffSize;
					local debuff = Debuff[index];
					debuff:SetSize(size, size);
					if debuff.Border ~= nil then
						debuff.Border:SetSize(size + 2, size + 2);
					end
				end
			end
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		_Init0();
		hooksecurefunc("TargetFrame_UpdateAuraPositions", HookTargetFrame_UpdateAuraPositions);
	end

	local function _Enable_Buff(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_Buff = true;
		TargetFrame_UpdateAuras(TargetFrame);
		if FocusFrame ~= nil then
			TargetFrame_UpdateAuras(FocusFrame);
		end
	end
	local function _Disable_Buff(loading)
		_enabled_Buff = false;
		TargetFrame_UpdateAuras(TargetFrame);
		if FocusFrame ~= nil then
			TargetFrame_UpdateAuras(FocusFrame);
		end
	end
	__plugins['LargeAura-Buff'] = { _Enable_Buff, _Disable_Buff, };
	__plugins['LargeAura-BuffLargeSize'] = {
		nil,
		nil,
		function(cfg, value, loading)
			_LargeBuffSize = value;
			TargetFrame_UpdateAuras(TargetFrame);
			if FocusFrame ~= nil then
				TargetFrame_UpdateAuras(FocusFrame);
			end
		end,
	};
	__plugins['LargeAura-BuffSmallSize'] = {
		nil,
		nil,
		function(cfg, value, loading)
			_SmallBuffSize = value;
			TargetFrame_UpdateAuras(TargetFrame);
			if FocusFrame ~= nil then
				TargetFrame_UpdateAuras(FocusFrame);
			end
		end,
	};

	local function _Enable_Debuff(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_Debuff = true;
		TargetFrame_UpdateAuras(TargetFrame);
		if FocusFrame ~= nil then
			TargetFrame_UpdateAuras(FocusFrame);
		end
	end
	local function _Disable_Debuff(loading)
		_enabled_Debuff = false;
		TargetFrame_UpdateAuras(TargetFrame);
		if FocusFrame ~= nil then
			TargetFrame_UpdateAuras(FocusFrame);
		end
	end
	__plugins['LargeAura-Debuff'] = { _Enable_Debuff, _Disable_Debuff, };
	__plugins['LargeAura-DebuffLargeSize'] = {
		nil,
		nil,
		function(cfg, value, loading)
			_LargeDebuffSize = value;
			TargetFrame_UpdateAuras(TargetFrame);
			if FocusFrame ~= nil then
				TargetFrame_UpdateAuras(FocusFrame);
			end
		end,
	};
	__plugins['LargeAura-DebuffSmallSize'] = {
		nil,
		nil,
		function(cfg, value, loading)
			_SmallDebuffSize = value;
			TargetFrame_UpdateAuras(TargetFrame);
			if FocusFrame ~= nil then
				TargetFrame_UpdateAuras(FocusFrame);
			end
		end,
	};

--										--	Cooldown
	local _enabled_Buff = false;
	local _enabled_Debuff = false;

	local NumHookedBuff = 0;
	local function _SetBuff(frame, value)
		local Buff = frame.Buff;
		if Buff ~= nil then
			local num = #Buff;
			if num > NumHookedBuff then
				for index = NumHookedBuff + 1, num do
					NumHookedBuff = index;
					Buff[index].Cooldown.noCooldownCount = false;
				end
			end
		end
	end
	local NumHookedDebuff = 0;
	local function _SetDebuff(frame, value)
		local Debuff = frame.Debuff;
		if Debuff ~= nil then
			local num = #Debuff;
			if num > NumHookedDebuff then
				for index = NumHookedDebuff + 1, num do
					NumHookedDebuff = index;
					Debuff[index].Cooldown.noCooldownCount = false;
				end
			end
		end
	end

	local function HookTargetFrame_UpdateAuras(frame)
		if _enabled_Buff then
			_SetBuff(frame, false);
		end
		if _enabled_Debuff then
			_SetDebuff(frame, false);
		end
	end


	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		_Init0();
		hooksecurefunc("TargetFrame_UpdateAuras", HookTargetFrame_UpdateAuras);
	end

	local function _Enable_Buff(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_Buff = true;
		NumHookedBuff = 0;
		_SetBuff(TargetFrame, false);
		if FocusFrame ~= nil then
			_SetBuff(FocusFrame, false);
		end
	end
	local function _Disable_Buff(loading)
		_enabled_Buff = false;
		NumHookedBuff = 0;
		_SetBuff(TargetFrame, true);
		if FocusFrame ~= nil then
			_SetBuff(FocusFrame, true);
		end
	end
	__plugins['Cooldown-Buff'] = { _Enable_Buff, _Disable_Buff, };


	local function _Enable_Debuff(loading)
		if not _isInitialized then
			_Init();
		end
		_enabled_Debuff = true;
		NumHookedDebuff = 0;
		_SetDebuff(TargetFrame, false);
		if FocusFrame ~= nil then
			_SetDebuff(FocusFrame, false);
		end
	end
	local function _Disable_Debuff(loading)
		_enabled_Debuff = false;
		NumHookedDebuff = 0;
		_SetDebuff(TargetFrame, true);
		if FocusFrame ~= nil then
			_SetDebuff(FocusFrame, true);
		end
	end
	__plugins['Cooldown-Debuff'] = { _Enable_Debuff, _Disable_Debuff, };
end


do										--	ToTDebuffCount
	local _enabled = false;

	local MAX_PARTY_DEBUFFS = _G.MAX_PARTY_DEBUFFS;
	local TargetFrameToT = _G.TargetFrameToT;

	local DebuffFrames = {  };

	local function main(frame, unit, numDebuffs, suffix, checkCVar)
		if _enabled and frame == TargetFrameToT and frame:IsVisible() then
			local filter;
			if SHOW_DISPELLABLE_DEBUFFS == "1" and UnitCanAssist("player", unit) then
				filter = "RAID";
			end
			for i = 1, MAX_PARTY_DEBUFFS do
				local debuffFrame = DebuffFrames[i];
				if debuffFrame:IsShown() then
					local name, icon, count, debuffType, duration, expirationTime, caster = UnitDebuff(unit, i, filter);
					local countFrame = debuffFrame.countFrame
					if count > 1 then
						countFrame:SetText(count);
						countFrame:Show();
					else
						countFrame:Hide();
					end
				end
			end
		end
	end
	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		for index = 1, MAX_PARTY_DEBUFFS do
			local frame = _G["TargetFrameToTDebuff" .. index];
			if frame ~= nil then
				DebuffFrames[index] = frame;
				frame.Cooldown = frame.Cooldown or _G["TargetFrameToTDebuff" .. index .. "Cooldown"];
				frame.countFrame = frame:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall");
				frame.countFrame:SetJustifyH("RIGHT");
				frame.countFrame:SetPoint("BOTTOMRIGHT", 4, -2);
				frame.Cooldown.noCooldownCount = true;
			end
		end
		hooksecurefunc("RefreshDebuffs", main);
	end
	local function _Enable(cfg, v, loading)
		if not _isInitialized then
			_Init();
		end
		_enabled = true;
		--	No need to refreh manually. 'RefreshDebuffs' is called every frame.
	end
	local function _Disable(cfg, v, loading)
		_enabled = false;
		for index = 1, MAX_PARTY_DEBUFFS do
			local frame = DebuffFrames[index];
			if frame.countFrame ~= nil then
				frame.countFrame:Hide();
			end
			frame.Cooldown.noCooldownCount = false;
		end
		--	No need to refreh manually. 'RefreshDebuffs' is called every frame.
	end

	__plugins['ToTDebuffCount'] = { _Enable, _Disable, };
end

