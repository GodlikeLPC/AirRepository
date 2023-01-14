--[=[
	163UI File
--]=]
local addonName, private = ...

if select(2, GetAddOnInfo("!!!!MasterVersion")) == nil then
	private.DeclineInvitation = {
		group = { _Enable_Group, _Disable_Group },
		guild = { _Enable_Guild, _Disable_Guild, },
		club = { _Enable_Club, _Disable_Club, },
		__dev = { core = __core, cmp = _LF_ShouldDecline, upd = _LF_UpdateList, };
	};
	return;
end

-->		upvalue
local format = format;
local C_Timer_After = C_Timer.After;
local Ambiguate = Ambiguate;
local GetNumFriends = C_FriendList ~= nil and C_FriendList.GetNumFriends or GetNumFriends;
local GetFriendInfoByIndex = C_FriendList ~= nil and C_FriendList.GetFriendInfoByIndex or GetFriendInfoByIndex;
local GetNumIgnores = C_FriendList ~= nil and C_FriendList.GetNumIgnores or GetNumIgnores;
local GetIgnoreName = C_FriendList ~= nil and C_FriendList.GetIgnoreName or GetIgnoreName;
local GetNumGuildMembers = GetNumGuildMembers;
local GetGuildRosterInfo = GetGuildRosterInfo;
local BNGetNumFriends = BNGetNumFriends;
local GuildRoster = C_GuildInfo ~= nil and C_GuildInfo.GuildRoster or GuildRoster;

local _enabled_group = true;
local _enabled_guild = true;
local _enabled_club = false;

local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();
local _REALM = GetRealmName();
local _F_noop = function(self, event) end
local _F_coreDebug = _F_coreDebug or _F_noop;
local _F_corePrint = _F_corePrint or print;


local __core = {
	__F = CreateFrame('FRAME'),
	__needUpdate = { friend = true, ignore = true, guild = true, battlenet = true, },
	__list = { whisper = {  }, },
	__func = {  },
};
do
	local __F = __core.__F;
	local _LF_CoreRegisterEvent = __F.RegisterEvent;
	local _LF_CoreUnregisterEvent = __F.UnregisterEvent;
	function __core:RegisterEvent(event, func)
		_LF_CoreRegisterEvent(__F, event);
		if func ~= nil then
			__core[event] = func;
		elseif __core[event] == nil then
			__core[event] = _F_noop;
		end
	end
	function __core:UnregisterEvent(event)
		_LF_CoreUnregisterEvent(__F, event);
	end
	local function _LF__core_OnEvent(self, event, ...)
		__core[event](__core, event, ...);
	end
	__F:SetScript("OnEvent", _LF__core_OnEvent);
end
local __needUpdate = __core.__needUpdate;
local __list = __core.__list;
local __func = __core.__func;

-->		update-func
	function __func.friend(db)			--	retail & classic
		for _index = 1, GetNumFriends() do
			local _info = GetFriendInfoByIndex(_index);
			local _name = _info.name;
			local _GUID = _info.guid;
			if _name ~= nil and _name ~= "" then
				db[Ambiguate(_name, 'none')] = 'friend';
			end
			if _GUID ~= "" and _GUID ~= nil then
				db[_GUID] = 'friend';
			end
		end
	end
	function __func.ignore(db)			--	retail & classic
		for _index = 1, GetNumIgnores() do
			local _name = GetIgnoreName(_index);
			if _name ~= "" and _name ~= nil then
				db[Ambiguate(_name, 'none')] = 'ignore';
			end
		end
	end
	function __func.guild(db)
		for _index = 1, GetNumGuildMembers() do
			local _name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding, _GUID = GetGuildRosterInfo(_index);
			if _name ~= "" and _name ~= nil then
				db[Ambiguate(_name, 'none')] = 'guild';
			end
			if _GUID ~= "" and _GUID ~= nil then
				db[_GUID] = 'guild';
			end
		end
	end
	local _LF_CacheBattleNetInfoString = nil;
	if _toc_version > 90000 then
		local C_BattleNet_GetFriendAccountInfo = C_BattleNet.GetFriendAccountInfo;
		local C_BattleNet_GetFriendNumGameAccounts = C_BattleNet.GetFriendNumGameAccounts;
		local C_BattleNet_GetFriendGameAccountInfo = C_BattleNet.GetFriendGameAccountInfo;
		_LF_CacheBattleNetInfoString = function(db, index)							--	retail
			local _info = C_BattleNet_GetFriendAccountInfo(index);
			local _gameAccountInfo = _info.gameAccountInfo;
			local _accountName = _info.accountName;
			local _battleTag = _info.battleTag;
			if _accountName ~= nil and _accountName ~= "" then
				db[_accountName] = 'battlenet';
			end
			if _battleTag ~= nil and _battleTag ~= "" then
				db[_battleTag] = 'battlenet';
			end
			for _index2 = 1, C_BattleNet_GetFriendNumGameAccounts(index) do
				local _info2 = C_BattleNet_GetFriendGameAccountInfo(index, _index2);
				local _name = _info2.characterName;
				local _realm = _info2.realmName;
				local _charGUID = _info2.playerGuid;
				if _info2.clientProgram == BNET_CLIENT_WOW and _info2.wowProjectID == WOW_PROJECT_ID then
					if _name ~= "" and _name ~= nil then
						if _realm ~= nil and _realm ~= "" and _realm ~= _REALM then
							db[_name .. "-" .. _realm] = 'battlenet';
						else
							db[_name] = 'battlenet';
						end
					end
					if _charGUID ~= "" and _charGUID ~= nil then
						db[_charGUID] = 'battlenet';
					end
				end
			end
		end
	else
		local BNGetFriendInfo = BNGetFriendInfo;
		local BNGetNumFriendGameAccounts = BNGetNumFriendGameAccounts;
		local BNGetFriendGameAccountInfo = BNGetFriendGameAccountInfo;
		_LF_CacheBattleNetInfoString = function(db, index)							--	classic
			local _info = BNGetFriendInfo(index);
			local presenceID, _accountName, _battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(index);
			if _accountName ~= nil and _accountName ~= "" then
				db[_accountName] = 'battlenet';
			end
			if _battleTag ~= nil and _battleTag ~= "" then
				db[_battleTag] = 'battlenet';
			end
			for _index2 = 1, BNGetNumFriendGameAccounts(index) do
				local isOnline, _name, client, realm, _realmID, faction, race, class, _, zone1, level, zone2, _, _, _, _, _, _, _, _charGUID, wowProjectID, r2 = BNGetFriendGameAccountInfo(index, _index2);
				if client == BNET_CLIENT_WOW and wowProjectID == WOW_PROJECT_ID then
					if _name ~= "" and _name ~= nil then
						if _realm ~= nil and _realm ~= "" and _realm ~= _REALM then
							db[_name .. "-" .. _realm] = 'battlenet';
						else
							db[_name] = 'battlenet';
						end
					end
					if _charGUID ~= "" and _charGUID ~= nil then
						db[_charGUID] = 'battlenet';
					end
				end
			end
		end
	end
	function __func.battlenet(db)		--	retail & classic
		local _, _online = BNGetNumFriends();
		for _index = 1, _online do
			_LF_CacheBattleNetInfoString(db, _index);
		end
	end
-->

local function _LF_ShouldDecline(str)
	local _accept = __list.whisper[str] ~= nil or __list.friend[str] ~= nil or __list.guild[str] ~= nil or __list.battlenet[str] ~= nil;
	local _ignore = __list.ignore[str] ~= nil;
	return _ignore or not _accept, not _ignore and _accept, _accept, _ignore;
end
local function _LF_UpdateList()
	for _key, _val in next, __needUpdate do
		if _val then
			__needUpdate[_key] = nil;
			__list[_key] = {  };
			__func[_key](__list[_key]);
		end
	end
end
if _toc_version > 90000 then	--	Club
	local C_Club_GetInvitationInfo = C_Club.GetInvitationInfo;
	local _ticker = nil;
	local _invitation = nl;
	local _count = 0;
	local _loop = nil;
	_loop = function()
		_count = _count + 1;
		if BNToastFrame.duration <= _count * 0.5 then
			--[[dev]]_F_coreDebug("Club Time-out", _count);
			return;
		end
		local _invitationInfo = C_Club_GetInvitationInfo(_invitation.club.clubId);
		local _inviter = _invitationInfo.inviter;
		if _inviter ~= nil then
			local _name = _inviter.name;
			if _name ~= nil and _name ~= "" then
				local _decline, _accept = _LF_ShouldDecline(Ambiguate(_name, 'none'));
				--[[dev]]_F_coreDebug("Inviter", _count, _name, _decline, _accept);
				if _decline then
					RemoveToast(RemoveToast.BNToastEvents.showToastClubInvitation);
					BNToastFrame:Hide();
					return;
				elseif _accept then
					-- BNToastFrame:GetScript("OnEvent")(BNToastFrame, "CLUB_INVITATION_ADDED_FOR_SELF", _invitation);			--	cause tainting
					--[[dev]]_F_coreDebug("BNToast Shown");
					return;
				end
			else
				C_Timer_After(0.5, _loop);
				return;
			end
			local _leaders = _invitationInfo.leaders;
			if leaders ~= nil then
				for _index = 1, #_leaders do
					local _leader = _leaders[_index];
					local _name = _leader.name;
					-- local _GUID = _leader.guid;
					if _name ~= nil and _name ~= "" then
						local _decline, _accept = _LF_ShouldDecline(Ambiguate(_name, 'none'));
						--[[dev]]_F_coreDebug("Leader", _count, _index, _name, _decline, _accept);
						if _decline then
							RemoveToast(RemoveToast.BNToastEvents.showToastClubInvitation);
							BNToastFrame:Hide();
							return;
						elseif _accept then
							-- BNToastFrame:GetScript("OnEvent")(BNToastFrame, "CLUB_INVITATION_ADDED_FOR_SELF", _invitation);	--	cause tainting
							--[[dev]]_F_coreDebug("BNToast Shown");
							return;
						end
					else
						C_Timer_After(0.5, _loop);
						return;
					end
				end
			end
		else
			C_Timer_After(0.5, _loop);
		end
	end
	function __func.RequestClubInviter(invitation)
		_count = 0;
		_invitation = invitation;
		C_Timer_After(0.5, _loop);
	end
end
-->		OnEvent
	function __core:CHAT_MSG_WHISPER_INFORM(event, msg, name, _, _, _, _, _, _, _, _, _, GUID, bnID)
		local _whisper = __list.whisper;
		_whisper[Ambiguate(name, 'none')] = 'whisper';
		_whisper[GUID] = 'whisper';
		_whisper[bnID] = 'whisper';
	end
	function __core:FRIENDLIST_UPDATE()
		__needUpdate.friend = true;
	end
	function __core:IGNORELIST_UPDATE()
		__needUpdate.ignore = true;
	end
	function __core:BN_BLOCK_LIST_UPDATED()
		__needUpdate.ignore = true;
	end
	function __core:GUILD_ROSTER_UPDATE()
		__needUpdate.guild = true;
	end
	function __core:PLAYER_GUILD_UPDATE()
		__needUpdate.guild = true;
	end
	function __core:BN_CONNECTED()
		__needUpdate.battlenet = true;
	end
	function __core:BN_FRIEND_LIST_SIZE_CHANGED()
		__needUpdate.battlenet = true;
	end
	function __core:BN_FRIEND_INFO_CHANGED()
		__needUpdate.battlenet = true;
	end
	function __core:PLAYER_ENTERING_WORLD()
		__needUpdate.friend = true;
		__needUpdate.ignore = true;
		__needUpdate.guild = true;
		__needUpdate.battlenet = true;
	end
	function __core:PARTY_INVITE_REQUEST(event, name)					--	name, isTank, isHealer, isDamage, isNativeRealm, allowMultipleRoles, inviterGUID, questSessionActive
		_LF_UpdateList();
		local _decline, _accept, _good, _bad = _LF_ShouldDecline(name);
		--[[dev]]_F_coreDebug("Group", event, name, _decline, _accept, _good, _bad);
		if _decline then
			-- _F_corePrint("|cffffff00已自动拒绝了[" .. name .. "]的组队邀请|r");
			_F_corePrint(format("|cffffff00已自动拒绝了%s[%s]的组队邀请|r", _bad and "黑名单" or "陌生人", name));
			DeclineGroup();
			StaticPopup_Hide("PARTY_INVITE");
		end
	end
	function __core:GUILD_INVITE_REQUEST(event, name, guild)			--	inviter, guildName, guildAchievementPoints, oldGuildName [, isNewGuild, tabardInfo]
		_LF_UpdateList();
		local _decline, _accept, _good, _bad = _LF_ShouldDecline(name);
		--[[dev]]_F_coreDebug("Guild", event, name, _decline, _accept, _good, _bad);
		if _decline then
			-- _F_corePrint("|cffffff00已自动拒绝了[" .. name .. "]的公会邀请|r");
			_F_corePrint(format("|cffffff00已自动拒绝了%s[%s]的公会邀请|r", _bad and "黑名单" or "陌生人", name));
			DeclineGuild();
			GuildInviteFrame:Hide();
		end
	end
	function __core:CLUB_INVITATION_ADDED_FOR_SELF(event, invitation)	--	invitation
		_LF_UpdateList();
		__func.RequestClubInviter(invitation)
	end
-->

local function _Init()
	__core:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	__core:RegisterEvent("FRIENDLIST_UPDATE");
	__core:RegisterEvent("IGNORELIST_UPDATE");
	__core:RegisterEvent("BN_BLOCK_LIST_UPDATED");
	__core:RegisterEvent("GUILD_ROSTER_UPDATE");
	__core:RegisterEvent("PLAYER_GUILD_UPDATE");
	__core:RegisterEvent("BN_CONNECTED");
	__core:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED");
	__core:RegisterEvent("BN_FRIEND_INFO_CHANGED");
	__core:RegisterEvent("PLAYER_ENTERING_WORLD");
	--	enabled by default
	if _enabled_group then
		__core:RegisterEvent("PARTY_INVITE_REQUEST");
	end
	if _enabled_guild then
		__core:RegisterEvent("GUILD_INVITE_REQUEST");
	end
	if _enabled_club and _toc_version > 90000 then
		-- BNToastFrame.BNToastEvents.showToastClubInvitation = nil;	--	taint
		-- BNToastFrame:UnregisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");	--	taint
		__core:RegisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");
	end
end
local function _Enable_Group()
	_enabled_group = true;
	__core:RegisterEvent("PARTY_INVITE_REQUEST");
end
local function _Disable_Group()
	_enabled_group = false;
	__core:UnregisterEvent("PARTY_INVITE_REQUEST");
end
local function _Enable_Guild()
	_enabled_group = true;
	__core:RegisterEvent("GUILD_INVITE_REQUEST");
end
local function _Disable_Guild()
	_enabled_group = false;
	__core:UnregisterEvent("GUILD_INVITE_REQUEST");
end
local function _Enable_Club()
	-- BNToastFrame.BNToastEvents.showToastClubInvitation = nil;	--	taint
	-- BNToastFrame:UnregisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");	--	taint
	__core:RegisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");
end
local function _Disable_Club()
	-- BNToastFrame.BNToastEvents.showToastClubInvitation = { "CLUB_INVITATION_ADDED_FOR_SELF" };	--	taint
	-- BNToastFrame:RegisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");	--	taint
	__core:UnregisterEvent("CLUB_INVITATION_ADDED_FOR_SELF");
end

private.DeclineInvitation = {
	group = { _Enable_Group, _Disable_Group },
	guild = { _Enable_Guild, _Disable_Guild, },
	club = { _Enable_Club, _Disable_Club, },
	__dev = { core = __core, cmp = _LF_ShouldDecline, upd = _LF_UpdateList, };
};

_Init();


