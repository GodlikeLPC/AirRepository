--[[
	使用下面的函数给输入框创建下拉列表

	先定义一个表:
	local value = {
		profile = string,			-- 输入框的名称(必须)
		event = string, 			-- 激活事件(可选, 默认为事件:VARIABLES_LOADED)
		short = bool,				-- 是否减少输入框宽度(可选)
		move = bool,				-- 输入框是否向左移一些
		over = bool,				-- 下拉按钮是否覆盖于输入框右边
		func = function,			-- 验证函数(可选)
		click = function			-- 选择列表后执行(可选),例中可让拍卖行列表选择后即搜索
		hook = function,			-- 应用hook
		check = function,			-- 加载时验证函数,验证通过直接执行，不必等待事件
	}
	再使用下面语句即可:
	__ns.tdCreateDropDown(which, value)
]]

local _, __ns = ...;
-- setfenv(1, __ns.__env);

local _Option = __ns._Option

-- _Option
	-- @Mail		--	邮箱
	-- @AH			--	拍卖行
	-- @Trade		--	商业技能窗口
	-- @Search		--	选择拍卖行列表后即搜索
	-- @Glyph		--	雕文（旧版）
	-- @EJ			--	冒险指南
	-- @Friends		--	好友状态广播（旧版）
	-- @Achieve		--	成就搜索
_Option.MAX = 25


------ create dropdown
local _P = {
	Mail = {
		profile = "SendMailNameEditBox",
		over = true,
		hook = function()
			hooksecurefunc("SendMail", function(recipient, subject, body)
				if _Option.Mail then
					__ns.tdInsertValueIfNotExist("SendMailNameEditBox", recipient);
				end
			end)
		end,
	},

	AH = {
		profile = "BrowseName",
		event = "ADDON_LOADED",
		short = true,
		check = function()
			return IsAddOnLoaded("Blizzard_AuctionUI");
		end,
		func = function(arg1)
			return arg1 == "Blizzard_AuctionUI"
		end,
		hook = function()
			hooksecurefunc("AuctionFrameBrowse_Search", function()
				if _Option.AH and BrowseName:IsVisible() then
					__ns.tdInsertValueIfNotExist("BrowseName", BrowseName:GetText());
				end
			end)
		end,
		click = function()
			if _Option.Search then
				AuctionFrameBrowse_Search()
			end
		end,
	},

	AuctionLite = {
		which = 'AH',
		profile = "BuyName",
		event = "ADDON_LOADED",
		over = true,
		check = function()
			return IsAddOnLoaded("AuctionLite");
		end,
		func = function(arg1)
			return arg1 == "AuctionLite"
		end,
		hook = function()
			hooksecurefunc(AuctionLite, "AuctionFrameBuy_Search", function(...)
				if _Option.AH and BuyName:IsVisible() then
					__ns.tdInsertValueIfNotExist("BuyName", BuyName:GetText());
				end
			end)
		end,
		click = function()
			if _Option.Search then
				AuctionLite:AuctionFrameBuy_Search()
			end
		end,
	},

	Trade = {
		profile = "TradeSkillFrame.SearchBox",
		event = "ADDON_LOADED",
		short = true,
		check = function()
			return IsAddOnLoaded("Blizzard_TradeSkillUI");
		end,
		func = function(arg1) return arg1 == "Blizzard_TradeSkillUI" end,
	},

	--[[
	Glyph ={
		profile = "GlyphFrameSearchBox",
		event = "ADDON_LOADED",
		over = true,
		check = function()
			return IsAddOnLoaded("Blizzard_GlyphUI");
		end,
		func = function(arg1)
			return arg1 == "Blizzard_GlyphUI"
		end,
	},
	]]

	EJ = {
		profile = "EncounterJournalSearchBox",
		event = "ADDON_LOADED",
		short = true,
		check = function()
			return IsAddOnLoaded("Blizzard_EncounterJournal");
		end,
		func = function(arg1)
			return arg1 == "Blizzard_EncounterJournal"
		end,
		hook = function()
			local point, relativeTo, relativePoint, xOffset, yOffset = EncounterJournalSearchBox:GetPoint()
			EncounterJournalSearchBox:SetPoint(point, relativeTo, relativePoint, xOffset-19, yOffset)
			EncounterJournalSearchBox:SetWidth(EncounterJournalSearchBox:GetWidth()-19)
		end,
		click = function()
			RunOnNextFrame(function()
				if EncounterJournalSearchBoxSearchButton1 and EncounterJournalSearchBoxSearchButton1:IsVisible() then
					EncounterJournalSearchBoxSearchButton1:Click()
				end
			end)
		end,
	},

	--[[
	Friends = {
		profile = "FriendsFrameBroadcastInput",	--	FriendsFrameBattlenetFrame.BroadcastFrame.EditBox
		short = true,
		click = function() FriendsFrameBroadcastInput_OnEnterPressed(FriendsFrameBroadcastInput) end,
	},
	--]]

	Achieve = {
		profile = "AchievementFrame.searchBox",
		event = "ADDON_LOADED",
		short = false,
		check = function()
			return IsAddOnLoaded("Blizzard_AchievementUI");
		end,
		func = function(arg1)
			return arg1 == "Blizzard_AchievementUI"
		end,
		click = function()
			RunOnNextFrame(function()
				AchievementFrame.searchBox:SetFocus();
			end)
		end,
	},

	--	WardrobeCollectionFrameSearchBox HeirloomsJournalSearchBox ToyBox.searchBox PetJournalSearchBox RematchPetPanel MountJournalSearchBox
}

for key, value in next, _P do
	local which = value.which or key;
	_Option[which] = true;
	__ns.tdCreateDropDown(which, value);
end
