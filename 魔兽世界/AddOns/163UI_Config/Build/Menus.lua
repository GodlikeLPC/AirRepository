--[[
	@ALA / ALEX
--]]
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local BNET_CLIENT_WOW = BNET_CLIENT_WOW;

local locale = GetLocale();

local AddFriend = C_FriendList and C_FriendList.AddFriend or AddFriend or function() end
local SendWho = C_FriendList and C_FriendList.SendWho or SendWho or function() end

do
	local func = {
		NAME_COPY = function(which, frame)
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				editBox:Insert(frame.name .. "-" .. frame.server);
			else
				editBox:Insert(frame.name);
			end
		end,
		FRIEND_ADD = function(which, frame)
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				AddFriend(frame.name .. "-" .. frame.server);
			else
				AddFriend(frame.name);
			end
		end,
		SEND_WHO = function(which, frame)
			SendWho("n-" .. frame.name);
		end,
		GUILD_ADD = function(which, frame)
			GuildInvite(frame.name);
		end,
		BN_TAG_COPY = function(which, frame)
			local tag = select(3, BNGetFriendInfoByID(frame.bnetIDAccount));
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			editBox:Insert(tag);
		end,
		BN_NAME_COPY = function(which, frame)
			local name = string.match(select(3, BNGetFriendInfoByID(frame.bnetIDAccount)), "(.+)#.+");
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			editBox:Insert(name);
		end,
		BN_GUILD_ADD = function(which, frame)
			GuildInvite(self.arg1.name);
		end,
	};

	local UnitPopupButtonsExtra = {
		["SEND_WHO"] = { enUS ="Query Detail",  zhCN = "查询玩家", zhTW = "查詢玩家" },
		["NAME_COPY"] = { enUS ="Get Name",	 zhCN = "获取名字", zhTW = "獲取名字", },
		["GUILD_ADD"] = { enUS ="Guild Invite", zhCN = "公会邀请", zhTW = "公會邀請", },
		["FRIEND_ADD"] = { enUS ="Add Friend",  zhCN = "添加好友", zhTW = "添加好友", },
		["BN_TAG_COPY"] = { enUS ="Get BN Name",  zhCN = "获取战网Tag", zhTW = "獲取戰網Tag", },
		["BN_NAME_COPY"] = { enUS ="Get BN Tag",  zhCN = "获取战网昵称", zhTW = "獲取戰網昵稱", },
		-- ["BN_GUILD_ADD"] = { enUS ="Guild Invite", zhCN = "公会邀请", zhTW = "公會邀請", nested = 1, },
	};
	local locale = GetLocale();
	for key, value in pairs(UnitPopupButtonsExtra) do
		alaPopup.add_meta(key, { value[locale] or value.enUS, func[key], });
	end

	alaPopup.add_list("SELF", "NAME_COPY");
	alaPopup.add_list("_BRFF_SELF", "NAME_COPY");

	alaPopup.add_list("FRIEND", "NAME_COPY");
	alaPopup.add_list("FRIEND", "SEND_WHO");
	alaPopup.add_list("FRIEND", "FRIEND_ADD");
	alaPopup.add_list("FRIEND", "GUILD_ADD");

	alaPopup.add_list("FRIEND_OFFLINE", "NAME_COPY");

	alaPopup.add_list("PLAYER", "NAME_COPY");
	alaPopup.add_list("PLAYER", "SEND_WHO");
	alaPopup.add_list("PLAYER", "FRIEND_ADD");
	alaPopup.add_list("PLAYER", "GUILD_ADD");

	alaPopup.add_list("PARTY", "NAME_COPY");
	alaPopup.add_list("PARTY", "SEND_WHO");
	alaPopup.add_list("PARTY", "FRIEND_ADD");
	alaPopup.add_list("PARTY", "GUILD_ADD");

	alaPopup.add_list("_BRFF_PARTY", "NAME_COPY");
	alaPopup.add_list("_BRFF_PARTY", "SEND_WHO");
	alaPopup.add_list("_BRFF_PARTY", "FRIEND_ADD");
	alaPopup.add_list("_BRFF_PARTY", "GUILD_ADD");

	alaPopup.add_list("RAID", "NAME_COPY");
	alaPopup.add_list("RAID", "SEND_WHO");
	alaPopup.add_list("RAID", "FRIEND_ADD");
	alaPopup.add_list("RAID", "GUILD_ADD");

	alaPopup.add_list("RAID_PLAYER", "NAME_COPY");
	alaPopup.add_list("RAID_PLAYER", "SEND_WHO");
	alaPopup.add_list("RAID_PLAYER", "FRIEND_ADD");
	alaPopup.add_list("RAID_PLAYER", "GUILD_ADD");

	alaPopup.add_list("_BRFF_RAID_PLAYER", "NAME_COPY");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "SEND_WHO");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "FRIEND_ADD");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "GUILD_ADD");

	alaPopup.add_list("CHAT_ROSTER", "NAME_COPY");
	alaPopup.add_list("CHAT_ROSTER", "SEND_WHO");
	alaPopup.add_list("CHAT_ROSTER", "FRIEND_ADD");
	alaPopup.add_list("CHAT_ROSTER", "INVITE");

	alaPopup.add_list("GUILD", "NAME_COPY");
	alaPopup.add_list("GUILD", "FRIEND_ADD");

	alaPopup.add_list("ENEMY_PLAYER", "NAME_COPY");
	alaPopup.add_list("OTHERPET", "NAME_COPY");
	--alaPopup.add_list("PET", "NAME_COPY");
	alaPopup.add_list("TARGET", "NAME_COPY");

	alaPopup.add_list("BN_FRIEND", "BN_TAG_COPY");
	alaPopup.add_list("BN_FRIEND", "BN_NAME_COPY");
	-- alaPopup.add_list("BN_FRIEND", "BN_GUILD_ADD");
	alaPopup.add_list("BN_FRIEND_OFFLINE", "BN_TAG_COPY");
	alaPopup.add_list("BN_FRIEND_OFFLINE", "BN_NAME_COPY");

	alaPopup.add_list("_BRFF_SELF", "NAME_COPY");

	alaPopup.add_list("_BRFF_RAID_PLAYER", "NAME_COPY");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "SEND_WHO");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "FRIEND_ADD");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "GUILD_ADD");
end


do return end

-- local LC = {  };
-- for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
--	 LC[v] = k;
-- end
-- for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
--	 LC[v] = k;
-- end


for k, v in pairs(UnitPopupButtonsExtra) do
	v.text = v[locale] or v.enUS;
	UnitPopupButtons[k] = v;
end
-- UnitPopupMenus["BN_GUILD_ADD"] = {  },

tinsert(UnitPopupMenus["SELF"], 1, "NAME_COPY");

tinsert(UnitPopupMenus["FRIEND"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["FRIEND"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["FRIEND"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["FRIEND"], 1, "GUILD_ADD");

tinsert(UnitPopupMenus["FRIEND_OFFLINE"], 1, "NAME_COPY");

tinsert(UnitPopupMenus["PLAYER"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["PLAYER"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["PLAYER"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["PLAYER"], 1, "GUILD_ADD");

tinsert(UnitPopupMenus["PARTY"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["PARTY"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["PARTY"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["PARTY"], 1, "GUILD_ADD");

tinsert(UnitPopupMenus["RAID"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["RAID"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["RAID"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["RAID"], 1, "GUILD_ADD");

tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "GUILD_ADD");

tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "SEND_WHO");
tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "FRIEND_ADD");
tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "INVITE");

tinsert(UnitPopupMenus["GUILD"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["GUILD"], 1, "FRIEND_ADD");

tinsert(UnitPopupMenus["ENEMY_PLAYER"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["OTHERPET"], 1, "NAME_COPY");
--tinsert(UnitPopupMenus["PET"], 1, "NAME_COPY");
tinsert(UnitPopupMenus["TARGET"], 1, "NAME_COPY");

tinsert(UnitPopupMenus["BN_FRIEND"], 1, "BN_TAG_COPY");
tinsert(UnitPopupMenus["BN_FRIEND"], 1, "BN_NAME_COPY");
-- tinsert(UnitPopupMenus["BN_FRIEND"], 1, "BN_GUILD_ADD");
tinsert(UnitPopupMenus["BN_FRIEND_OFFLINE"], 1, "BN_TAG_COPY");
tinsert(UnitPopupMenus["BN_FRIEND_OFFLINE"], 1, "BN_NAME_COPY");

hooksecurefunc("UnitPopup_OnClick", function(self, info)
	if self.value == "NAME_COPY" then
		local editBox = ChatEdit_ChooseBoxForSend();
		ChatEdit_ActivateChat(editBox);
		editBox:Insert(UIDROPDOWNMENU_INIT_MENU.name);
		-- if editBox:GetText() == "" then
		--	 editBox:HighlightText();
		-- end
	elseif self.value == "FRIEND_ADD" then
		AddFriend(UIDROPDOWNMENU_INIT_MENU.name);
	elseif (self.value == "SEND_WHO") then
		SendWho("n-" .. UIDROPDOWNMENU_INIT_MENU.name);
	elseif self.value == "GUILD_ADD" then
		GuildInvite(UIDROPDOWNMENU_INIT_MENU.name);
	elseif self.value == "BN_TAG_COPY" then
		local tag = select(3, BNGetFriendInfoByID(UIDROPDOWNMENU_INIT_MENU.bnetIDAccount));
		local editBox = ChatEdit_ChooseBoxForSend();
		ChatEdit_ActivateChat(editBox);
		editBox:Insert(tag);
	elseif self.value == "BN_NAME_COPY" then
		local name = string.match(select(3, BNGetFriendInfoByID(UIDROPDOWNMENU_INIT_MENU.bnetIDAccount)), "(.+)#.+");
		local editBox = ChatEdit_ChooseBoxForSend();
		ChatEdit_ActivateChat(editBox);
		editBox:Insert(name);
	-- elseif self.value == "BN_GUILD_ADD" and self.arg1 then
	--	 GuildInvite(self.arg1.name);
	end
end)


-- hooksecurefunc("UnitPopup_ShowMenu",
--	 function(dropdownMenu, which, unit, name, userData)
--		 if which == "BN_FRIEND" and UIDROPDOWNMENU_MENU_VALUE == "BN_GUILD_ADD" and UIDROPDOWNMENU_MENU_LEVEL == 2 then
--			 local index = BNGetFriendIndex(UIDROPDOWNMENU_INIT_MENU.bnetIDAccount);
--			 local i = 1;
--			 local pFaction = UnitFactionGroup('player');
--			 local pRealmID = GetRealmID();
--			 while true do
--				 local gameOnline, charName, client, realm, realmID, faction, race, class = BNGetFriendGameAccountInfo(index, i);
--				 if client == BNET_CLIENT_WOW and realmID == pRealmID and faction == pFaction then
--					 local color = RAID_CLASS_COLORS[LC[class]];
--					 local info = UIDropDownMenu_CreateInfo();
--					 info.text = string.format("\124cff%.2x%.2x%.2x", color.r * 255, color.g * 255, color.b * 255) .. charName .. "\124r";
--					 info.arg1 = { name = charName, };
--					 info.value = UIDROPDOWNMENU_MENU_VALUE;
--					 info.func = UnitPopup_OnClick;
--					 info.notCheckable = true;
--					 UIDropDownMenu_AddButton(info, 2);
--				 end
--				 if gameOnline == nil then
--					 break;
--				 end
--				 i = i + 1;
--			 end
--		 end
--	 end
-- );

