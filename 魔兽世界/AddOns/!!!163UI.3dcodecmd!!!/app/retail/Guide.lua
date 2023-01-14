local __addon, __ns = ...;
local _PatchVersion, _BuildNumber, _BuildDate, _TocVersion = GetBuildInfo();
if _TocVersion < 90000 then
	return;
end

local _SET = {
	['mount'] = true,
	['pet'] = true,
	['toy'] = true,
	['instance'] = true,
	['encounter'] = true,
	['achievement'] = true,
	['achievementacomparison'] = true,
};
local _GUIDE_DATA = __ns._GUIDE_DATA;
setmetatable(_GUIDE_DATA, { __index = function(tbl, key) return {  }; end, });
------------------------------
local function _LF_OpenBrowser(Type, Name, ID)
	-- Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器");
	-- ThreeDimensionsCode_Send("innerbrowser", "http://www.baidu.com/s?wd=" .. Type .. "?id=" .. ID .. "?name=" .. Name);
	-- _163ClientOpenURL("http://www.baidu.com/s?wd=" .. Type .. "?id=" .. ID .. "?name=" .. Name);
	_163ClientOpenURL(_GUIDE_DATA[Type][ID]);
	-- print(Type, Name, ID);
 end
local _LT_Externs = {  };
local _fadein_alpha = 1.0;
local _fadeout_alpha = 0.25;
local function _LF_OnUpdate_Extern(_E, elasped)
	if _E.__action == 'fade-in' then
		local __alpha = _E.__alpha + elasped;
		if __alpha >= _fadein_alpha then
			_E:SetScript("OnUpdate", nil);
			__alpha = _fadein_alpha;
		end
		_E.__alpha = __alpha;
		_E:SetAlpha(__alpha);
	else
		local __alpha = _E.__alpha - elasped * 0.5;
		if __alpha <= _fadeout_alpha then
			_E:SetScript("OnUpdate", nil);
			__alpha = _fadeout_alpha;
		end
		_E.__alpha = __alpha;
		_E:SetAlpha(__alpha);
	end
end
local function _LF_OnEnter_Extern(_E)
	_E.__action = 'fade-in';
	_E:SetScript("OnUpdate", _LF_OnUpdate_Extern);
end
local function _LF_OnLeave_Extern(_E)
	_E.__action = 'fade-out';
	_E:SetScript("OnUpdate", _LF_OnUpdate_Extern);
end
local function _LF_OnClick_Extern(_E, button)
	local _P = _E.__parent;
	--[=[
		MountJournalListScrollFrame.buttons
			@index
			@mountID
			@spellID
			name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID
				= C_MountJournal.GetMountInfoByID(mountID);
				= C_MountJournal.GetDisplayedMountInfo(displayIndex);
		PetJournalListScrollFrame.buttons
			@index
			@speciesID
			C_PetJournal.GetPetInfoByIndex(index)
			C_PetJournal.GetPetInfoByItemID(itemID)
			C_PetJournal.GetPetInfoBySpeciesID(speciesID)
			C_PetJournal.GetPetInfoByPetID(petID)
		ToyBox.iconsFrame[]
			itemID, toyName, icon, isFavorite, hasFanfare, itemQuality
				= C_ToyBox.GetToyInfo(_itemID);
		EncounterJournalInstanceSelectScrollFrameScrollChild[]
			name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty
				= EJ_GetInstanceInfo([instanceID])
		Encounter
			name, description, bossID, rootSectionID, link, journalInstanceID, dungeonEncounterID, instanceID
				= EJ_GetEncounterInfo(encounterID)
				= EJ_GetEncounterInfoByIndex(index [, instanceID])
	--]=]
	if _E.__type == 'mount' then
		local _mountID = _P.mountID;
		if _mountID ~= nil then
			local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID
				= C_MountJournal.GetMountInfoByID(_mountID);
			_LF_OpenBrowser('mount', name, _mountID);
		end
	elseif _E.__type == 'pet' then
		local _speciesID = _P.speciesID;
		if _speciesID ~= nil then
			local speciesName, speciesIcon, petType, companionID, tooltipSource, tooltipDescription, isWild, canBattle, isTradeable, isUnique, obtainable, creatureDisplayID
				= C_PetJournal.GetPetInfoBySpeciesID(_speciesID);
			_LF_OpenBrowser('pet', speciesName, _speciesID);
		end
	elseif _E.__type == 'toy' then
		local _itemID = _P.itemID;
		if _itemID ~= nil then
			local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(_itemID);
			_LF_OpenBrowser('toy', toyName, _itemID);
		end
	elseif _E.__type == 'instance' then
		local _instanceID = _P.instanceID;
		if _instanceID ~= nil then
			local name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty
				= EJ_GetInstanceInfo(_instanceID);
			_LF_OpenBrowser('instance', name, _instanceID);
		end
	elseif _E.__type == 'encounter' then
		local _encounterID = _P.encounterID;
		if _encounterID ~= nil then
			local name, description, bossID, rootSectionID, link, journalInstanceID, dungeonEncounterID, instanceID = EJ_GetEncounterInfo(_encounterID);
			_LF_OpenBrowser('encounter', name, _encounterID);
		end
	elseif _E.__type == 'achievement' or _E.__type == 'achievementacomparison' then
		local id = _P.id;
		if id ~= nil then
			local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(id);
			_LF_OpenBrowser('achievement', name, id);
		end
	end
end
local function _LF_CreateExtern(Type, Parent, Point)
	local _E = CreateFrame('BUTTON', nil, Parent);
	_E:SetSize(60, 16);
	if Point ~= nil then
		_E:SetPoint(Point[1] or "TOPRIGHT", Point[2] or Parent, Point[3] or "TOPRIGHT", Point[4] or -2, Point[5] or -2);
	else
		_E:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", -2, -2);
	end
	_E.__alpha = _fadeout_alpha;
	_E:SetAlpha(_E.__alpha);
	-- _E:SetFrameLevel(9999);
	_E.__parent = Parent;
	_E.__type = Type;
	_E:SetScript("OnEnter", _LF_OnEnter_Extern);
	_E:SetScript("OnLeave", _LF_OnLeave_Extern);
	_E:SetScript("OnClick", _LF_OnClick_Extern);
	-- local _NTexture = _E:CreateTexture(nil, "ARTWORK");
	-- _NTexture:SetAllPoints();
	-- _NTexture:SetColorTexture(0.8, 0.64, 0.0, 1.0);
	-- _E:SetNormalTexture(_NTexture);
	-- local _PTexture = _E:CreateTexture(nil, "ARTWORK");
	-- _PTexture:SetAllPoints();
	-- _PTexture:SetColorTexture(0.5, 0.4, 0.0, 1.0);
	-- _E:SetPushedTexture(_PTexture);
	local _HTexture = _E:CreateTexture(nil, "HIGHLIGHT");
	_HTexture:SetAllPoints();
	_HTexture:SetColorTexture(1.0, 0.5, 0.0, 0.15);
	_E:SetHighlightTexture(_HTexture);
	local _Text = _E:CreateFontString(nil, "OVERLAY");
	_Text:SetFont(GameFontNormal:GetFont(), 14);
	_Text:SetVertexColor(1.0, 0.8, 0.0);
	_Text:SetPoint("CENTER");
	_Text:SetText("查询攻略");
	return _E;
end
local _LW_Updater = CreateFrame('FRAME');
local function _LF_OnUpdate_Updater(self, elasped)
	self:SetScript("OnUpdate", nil);
	if self['mount'] then
		self['mount'] = nil;
		local _externs = _LT_Externs['mount'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local _mountID = _P.mountID;
				if _mountID ~= nil then
					-- local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(_mountID);
					if _GUIDE_DATA['mount'][_mountID] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['pet'] then
		self['pet'] = nil;
		local _externs = _LT_Externs['pet'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local _speciesID = _P.speciesID;
				if _speciesID ~= nil then
					-- local speciesName, speciesIcon, petType, companionID, tooltipSource, tooltipDescription, isWild, canBattle, isTradeable, isUnique, obtainable, creatureDisplayID = C_PetJournal.GetPetInfoBySpeciesID(_speciesID);
					if _GUIDE_DATA['pet'][_speciesID] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['toy'] then
		self['toy'] = nil;
		local _externs = _LT_Externs['toy'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local _itemID = _P.itemID;
				if _itemID ~= nil then
					-- local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(_itemID);
					if _GUIDE_DATA['toy'][_itemID] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['instance'] then
		self['instance'] = nil;
		local _externs = _LT_Externs['instance'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local _instanceID = _P.instanceID;
				if _instanceID ~= nil then
					-- local name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty = EJ_GetInstanceInfo(_instanceID);
					if _GUIDE_DATA['instance'][_instanceID] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['encounter'] then
		self['encounter'] = nil;
		local _externs = _LT_Externs['encounter'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local _encounterID = _P.encounterID;
				if _encounterID ~= nil then
					-- local name, description, bossID, rootSectionID, link, journalInstanceID, dungeonEncounterID, instanceID = EJ_GetEncounterInfo(_encounterID);
					if _GUIDE_DATA['encounter'][_encounterID] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['achievement'] then
		self['achievement'] = nil;
		local _externs = _LT_Externs['achievement'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local id = _P.id;
				if id ~= nil then
					-- local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(id);
					if _GUIDE_DATA['achievement'][id] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	if self['achievementacomparison'] then
		self['achievementacomparison'] = nil;
		local _externs = _LT_Externs['achievementacomparison'];
		for _index = 1, #_externs do
			local _E = _externs[_index];
			local _P = _E.__parent;
			if _P:IsShown() then
				local id = _P.id;
				if id ~= nil then
					-- local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(id);
					if _GUIDE_DATA['achievementacomparison'][id] then
						_E:Show();
					else
						_E:Hide();
					end
				else
					_E:Hide();
				end
			end
		end
	end
	-- print("Update");
end
local function _LF_DelayUpdate(Type)
	_LW_Updater[Type] = true;
	_LW_Updater:SetScript("OnUpdate", _LF_OnUpdate_Updater);
	-- print(Type);
end


--	CollectionsJournal
if _TocVersion > 70000 then
	local function _LF_Hook_MountJournalListScrollFrame_Update()
		if _SET['mount'] then
			_LF_DelayUpdate('mount');
		end
	end
	local function _LF_Hook_MountJournal_UpdateMountList()
		if _SET['mount'] then
			_LF_DelayUpdate('mount');
		end
	end
	local function _LF_Hook_PetJournalListScrollFrame_Update()
		if _SET['pet'] then
			_LF_DelayUpdate('pet');
		end
	end
	local function _LF_Hook_PetJournal_UpdatePetList()
		if _SET['pet'] then
			_LF_DelayUpdate('pet');
		end
	end
	local function _LF_Hook_ToyBox_UpdateButtons()
		if _SET['toy'] then
			_LF_DelayUpdate('toy');
		end
	end
	CoreDependCall(
		"blizzard_collections",
		function()
			--	Mount
			local _MountButtons = MountJournalListScrollFrame.buttons;
			_LT_Externs.mount = {  };
			for _index = 1, #_MountButtons do
				_LT_Externs.mount[_index] = _LF_CreateExtern('mount', _MountButtons[_index]);
			end
			hooksecurefunc(MountJournalListScrollFrame, "update", _LF_Hook_MountJournalListScrollFrame_Update);
			hooksecurefunc("MountJournal_UpdateMountList", _LF_Hook_MountJournal_UpdateMountList);
			--	Pet
			local _PetButtons = PetJournalListScrollFrame.buttons;
			_LT_Externs.pet = {  };
			for _index = 1, #_PetButtons do
				_LT_Externs.pet[_index] = _LF_CreateExtern('pet', _PetButtons[_index]);
			end
			hooksecurefunc(PetJournalListScrollFrame, "update", _LF_Hook_PetJournalListScrollFrame_Update);
			hooksecurefunc("PetJournal_UpdatePetList", _LF_Hook_PetJournal_UpdatePetList);
			--	Toy
			local _ToyBoxIconsFrame = ToyBox.iconsFrame;
			local _ToyButtons = {  };
			_ToyBoxIconsFrame.buttons = _ToyButtons;
			_LT_Externs.toy = {  };
			for _index = 1, 18 do
				local _button = _ToyBoxIconsFrame["spellButton" .. _index];
				_LT_Externs.toy[_index] = _LF_CreateExtern('toy', _button, { nil, nil, nil, 142, 0, });
			end
			hooksecurefunc("ToyBox_UpdateButtons", _LF_Hook_ToyBox_UpdateButtons);
			-- --	Heirloom	--	unnecessary
			-- _LT_Externs.heirloom = {  };
		end
	);
end
--	EncounterJournal
if _TocVersion > 70000 then
	local _LN_EJ_Hooked = 0;
	local function _LF_Hook_EJ_HideInstances(num)
		if num ~= nil then
			num = num - 1;
			local _Frame = EncounterJournalInstanceSelectScrollFrameScrollChild;
			for _index = _LN_EJ_Hooked + 1, num do
				local _button = EncounterJournalInstanceSelectScrollFrameScrollChild["instance" .. _index];
				_LT_Externs.instance[_index] = _LF_CreateExtern('instance', _button, { "TOP", nil, "BOTTOM", 0, 0, });
				_LN_EJ_Hooked = _index;
			end
		end
	end
	local _LN_EJBoss_Hooked = 0;
	local function _LF_BossCreateButtons()
		local _index = _LN_EJBoss_Hooked + 1;
		local _button = _G["EncounterJournalBossButton" .. _index];
		while _button ~= nil do
			_LT_Externs.encounter[_index] = _LF_CreateExtern('encounter', _button, { nil, nil, nil, -2, 10, });
			_LN_EJBoss_Hooked = _index;
			_index = _index + 1;
			_button = _G["EncounterJournalBossButton" .. _index];
		end
	end
	local function _LF_Hook_EncounterJournal_ListInstances()
		if _SET['instance'] then
			_LF_DelayUpdate('instance');
		end
	end
	local function _LF_Hook_EncounterJournal_DisplayEncounter(encounterID, noButton)
		_LF_BossCreateButtons();
		if _SET['encounter'] then
			_LF_DelayUpdate('encounter');
		end
	end
	local function _LF_Hook_EncounterJournal_DisplayInstance(instanceID, noButton)
		_LF_BossCreateButtons();
		if _SET['encounter'] then
			_LF_DelayUpdate('encounter');
		end
	end
	CoreDependCall(
		"blizzard_encounterjournal",
		function()
			_LT_Externs.instance = {  };
			hooksecurefunc("EJ_HideInstances", _LF_Hook_EJ_HideInstances);
			hooksecurefunc("EncounterJournal_ListInstances", _LF_Hook_EncounterJournal_ListInstances);
			_LT_Externs.encounter = {  };
			hooksecurefunc("EncounterJournal_DisplayEncounter", _LF_Hook_EncounterJournal_DisplayEncounter);
			hooksecurefunc("EncounterJournal_DisplayInstance", _LF_Hook_EncounterJournal_DisplayInstance);
		end
	);
end
--	Achievement
if _TocVersion > 30000 then
	local function _LF_Hook_AchievementFrameAchievements_Update()
		if _SET['achievement'] then
			_LF_DelayUpdate('achievement');
		end
		-- print("ACH_UPDATE");
	end
	local function _LF_Hook_AchievementFrameComparison_Update()
		if _SET['achievementacomparison'] then
			_LF_DelayUpdate('achievementacomparison');
		end
		-- print("CMP_UPDATE");
	end
	CoreDependCall(
		"blizzard_achievementui",
		function()
			_LT_Externs.achievement = {  };
			local _achbuttons = AchievementFrameAchievementsContainer.buttons;
			for _index = 1, #_achbuttons do
				_LT_Externs.achievement[_index] = _LF_CreateExtern('achievement', _achbuttons[_index], { "TOPLEFT", nil, "TOPLEFT", 90, -6 });
			end
			hooksecurefunc("AchievementFrameAchievements_Update", _LF_Hook_AchievementFrameAchievements_Update);
			hooksecurefunc(AchievementFrameAchievementsContainer, "update", _LF_Hook_AchievementFrameAchievements_Update);
			hooksecurefunc(ACHIEVEMENT_FUNCTIONS, "updateFunc", _LF_Hook_AchievementFrameAchievements_Update);
			-- hooksecurefunc("AchievementButton_DisplayAchievement", function(button, category, achievementIndex, selection) end);
			--
			_LT_Externs.achievementacomparison = {  };
			local _cmpbuttons = AchievementFrameComparisonContainer.buttons;
			for _index = 1, #_cmpbuttons do
				_LT_Externs.achievementacomparison[_index] = _LF_CreateExtern('achievementacomparison', _cmpbuttons[_index], { "TOPLEFT", nil, "TOPLEFT", 60, -2, });
			end
			hooksecurefunc("AchievementFrameComparison_Update", _LF_Hook_AchievementFrameComparison_Update);
			hooksecurefunc(AchievementFrameComparisonContainer, "update", _LF_Hook_AchievementFrameComparison_Update);
			hooksecurefunc(COMPARISON_ACHIEVEMENT_FUNCTIONS, "updateFunc", _LF_Hook_AchievementFrameComparison_Update);
			-- hooksecurefunc("AchievementFrameComparison_DisplayAchievement", function(button, category, achievementIndex) end);
		end
	);
end

