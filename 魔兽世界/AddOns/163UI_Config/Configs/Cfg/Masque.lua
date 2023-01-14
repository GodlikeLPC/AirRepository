﻿local tinsert, next, sort = tinsert, next, sort;

--SkinNames = {} for skinName in next, LibStub('Masque'):GetSkins() do SkinNames[skinName] = skinName end wowluacopy(SkinNames)
local names = {
	Apathy = "缩小",
	Classic = "暴雪经典",
	Cainyx = "圆角灰边框",
	["Cainyx - Modded Bartender4 font"] = false,
	["Cainyx Raven Highlights"] = false,
	["Cainyx Raven Highlights - Modded Bartender4 font"] = false,
	Caith = "灰边框",
	Cirque = "圆圈",
	["Cirque - Simple"] = false,
	CleanUI = "清爽",
	["CleanUI Black"] = "清爽: 黑",
	["CleanUI Black and White"] = false,
	["CleanUI Edged"] = false,
	["CleanUI Gray"] = false, --"清爽: 放大高亮",
	["CleanUI Thin"] = "清爽: 放大",
	["CleanUI White"] = false, --"清爽: 白",
	["CleanUI White and Black"] = false,
	Default = "默认",
	Dominos = "多米诺默认",
	Dream = "无边框",
	["Entropy - Adamantite"] = false, --"质感: 精金",
	["Entropy - Bronze"] = false, --"质感: 青铜",
	["Entropy - Cobalt"] = false, --"质感: 钴",
	["Entropy - Copper"] = "质感: 铜",
	["Entropy - Fel Iron"] = false, --"质感: 魔铁",
	["Entropy - Gold"] = "质感: 金",
	["Entropy - Iron"] = false, --"质感: 铁",
	["Entropy - Khorium"] = false, --"质感: 氪金",
	["Entropy - Obsidium"] = false, --"质感: 黑曜石",
	["Entropy - Saronite"] = false, --"质感: 萨隆邪铁",
	["Entropy - Silver"] = "质感: 银",
	["Entropy - Titanium"] = false, --"质感: 泰坦神铁"
	["Entropy - Fel Iron"] = false, --"质感: 魔铁",
	Gears = "齿轮",
	["Gears - Black"] = "齿轮: 黑",
	["Gears - Spark"] = "齿轮: 火花",
	["Gears - Random"] = "齿轮: 随机",
	["Goldpaw's UI: Normal"] = "浮雕",
	["Goldpaw's UI: Normal Bright"] = "浮雕: 高亮",
	["Goldpaw's UI: PetBar"] = false, --"浮雕: 中",
	["Goldpaw's UI: Small"] = "浮雕: 小",
	["Goldpaw's UI: Small Bright"] = "浮雕: 小高亮",
	Onyx = "三角指示标",
	["Onyx Redux"] = false,
	Parabole = "双线边框",
	["Serenity"] = false,
	["Serenity - Redux"] = "圆形白边框",
	["Serenity - Square"] = false,
	["Serenity - Square Redux"] = "方形白边框",
	Zoomed = "无边框放大",
	kenzo = "圆角细黑边",
}

local MasqueCore = nil;
--:ListAddons() :ListGroups(addon)
local function GetMasqueCore()
	if MasqueCore == nil then
		local Masque = Masque or LibStub('AceAddon-3.0'):GetAddon('Masque', true);
		MasqueCore = Masque and Masque.Core or nil;
	end
	return MasqueCore;
end
_G.U1GetMasqueCore = GetMasqueCore;

--	define method
local function ReSkinWithSub(self)
	self:ReSkin(true)
	local Subs = self.SubList
	if Subs then
		for _, Sub in pairs(Subs) do
			ReSkinWithSub(Sub)
		end
	end
end

-- 切换但是不修改状态
local function ToggleWithoutSave(self, enable)
	if enable then
		self:ReSkin(true)
	else
		for Button in pairs(self.Buttons) do
			GetMasqueCore().SkinButton(Button, self.Buttons[Button], "Classic")
		end
	end
	local Subs = self.SubList
	if Subs then
		for _, Sub in pairs(Subs) do
			ToggleWithoutSave(Sub, enable)
		end
	end
end

local MasqueCoreGroup = nil;
local function GetMasqueCoreGroup()
	if MasqueCoreGroup == nil then
		local Core = GetMasqueCore();
		MasqueCoreGroup = Core and Core.GetGroup() or nil;
		if MasqueCoreGroup ~= nil then
			MasqueCoreGroup.ReSkinWithSub = ReSkinWithSub;
			MasqueCoreGroup.ToggleWithoutSave = ToggleWithoutSave;
		end
	end
	return MasqueCoreGroup;
end
_G.U1GetMasqueCoreGroup = GetMasqueCoreGroup;

local orders = { ["Default"] = 1, ["Classic"] = 2, ["Dream"] = 3, ["Zoomed"] = 4, ["Dominos"] = -1, }
local function sortMethod(s1, s2)
	local o1, o2 = orders[s1], orders[s2]
	if o1 ~= nil and o2 ~= nil then
		if o1 > 0 and o2 < 0 then return true end
		if o1 < 0 and o2 > 0 then return false end
		return o1 < o2 -- 1,2 -2,-1
	elseif o1 == nil and o2 == nil then
		return s1 < s2
	elseif o1 ~= nil and o2 == nil then
		return o1 > 0
	elseif o2 ~= nil and o1 == nil then
		return o2 < 0
	end
end

local function get_option()
	local SkinOptions = {  };
	local Masque = LibStub('Masque', true)
	if Masque ~= nil then
		local SkinNames = {  };
		local Skins = Masque.GetSkins and Masque:GetSkins()
		if Skins ~= nil then
			for skinName in next, Skins do
				tinsert(SkinNames, skinName)
			end
			sort(SkinNames, sortMethod)
			for index = 1, #SkinNames do
				local skinName = SkinNames[index];
				local localeName = names[skinName]
				if localeName ~= false then
					tinsert(SkinOptions, localeName or skinName)
					tinsert(SkinOptions, skinName)
				end
			end
		else
			tinsert(SkinOptions, '请先启用插件')
			tinsert(SkinOptions, 'NONE')
		end
	end
	return SkinOptions
end

U1RegisterAddon("Masque", {
	title = "按钮美化",
	defaultEnable = 0,
	--optionsAfterVar = 1,
	minimap = "LibDBIcon10_Masque",
	load = "NORMAL", --支持其他第三方插件

	tags = { "TAG_ACTIONBUTTONCASTBAR", },
	icon = [[Interface\Addons\Masque\Textures\Icon]],
	desc = "为动作条按钮提供样式切换，拥有众多的皮肤类扩展，是此类美化插件的第一选择。`网易有爱在原版的基础上整合了玩家增益美化，并精选了几种有代表性的皮肤样式，可以用控制台轻松选择。当然，您也可以下载任意皮肤包放到插件目录里。",

	runBeforeLoad = function(info, name)
		if MasqueDB == nil then
			info.__firsttimeload = true;
		end
	end,
	toggle = function(name, info, enable, justload)
		local Masque = GetMasqueCore()
		local v;
		v = nil if not enable then v = false end
		U1CfgCallBack(U1CfgFindChild("masque", "hidecap"), v)
		v = nil if not enable then v = false end
		U1CfgCallBack(U1CfgFindChild("masque", "hidebg"), v)

		if info.__firsttimeload then
			GetMasqueCoreGroup():__Set('SkinID', "Classic");
		end
		if U1IsInitComplete() then
			GetMasqueCoreGroup():ToggleWithoutSave(enable)
		end

		-- if not U1DBG.reset_masque then
		-- 	U1DBG.reset_masque = "201910"
		-- 	GetMasqueCoreGroup():__Reset()
		-- end
	end,

	{
		text = "配置选项",
		callback = function() SlashCmdList["MASQUE"]() end,
	},
	{
		text = "重置皮肤",
		confirm = "会把所有皮肤的设置（比如颜色，光泽等）恢复到默认值，您确定吗？",
		callback = function() GetMasqueCoreGroup():__Reset() end,
	},
	{
		type = 'radio',
		var = "style",
		text = '请选择皮肤样式',
		options = get_option,
		default = "kenzo",
		indent = nil,
		cols = 2,
		getvalue = function()
			return GetMasqueCoreGroup().db.SkinID
		end,
		callback = function(cfg, v, loading)
			if loading then return end --会覆盖所有设置，只有手动设置时才调用
			if v~='NONE' and not loading then
				GetMasqueCoreGroup():__Set('SkinID', v)
			end
		end,
	},
	{
		text = "设置动作条布局",
		tip = "说明`打开多米诺动作条的设置面板。",
		callback = function()
			UUI.OpenToAddon("Dominos")
		end,
	},
	{
		var = 'hookbuff',
		default = nil,
		text = '美化玩家增益减益图标',
		callback = function(cfg, v, loading)
			if loading then return end
			local group = LibStub("Masque"):Group('Blizzard Buffs')
			if v then
				group:Enable();
			else
				group:Disable();
			end
		end,
		-- {
		--	 var = "buffSize",
		--	 default = 13,
		--	 type = "spin",
		--	 reload = 1,
		--	 tip = "说明`调整美化后的增益减益下面的计时文字尺寸。",
		--	 range = {9, 15, 1},
		--	 text = "剩余时间文字大小",
		-- }
	},
	-- {
	--	 var = "nameSize",
	--	 default = 13,
	--	 type = "spin",
	--	 reload = 1,
	--	 tip = "说明`调整技能按钮上显示的宏的字体大小。",
	--	 range = {9, 15, 1},
	--	 text = "默认按钮文字大小",
	-- }

	{
		text = "隐藏主动作条两侧材质",
		var = "hidecap",
		default = 1,
		callback = function(cfg, v, loading)
			local L = MainMenuBarLeftEndCap or MainMenuBarArtFrame and MainMenuBarArtFrame.LeftEndCap;
			if L ~= nil then
				L:SetShown(not v);
			end
			local R = MainMenuBarRightEndCap or MainMenuBarArtFrame and MainMenuBarArtFrame.RightEndCap;
			if R ~= nil then
				R:SetShown(not v);
			end
		end
	},
	{
		text = "隐藏主动作条背景材质",
		var = "hidebg",
		default = false,
		callback = function(cfg, v, loading)
			MainMenuMaxLevelBar0:SetShown(not v);
			MainMenuMaxLevelBar1:SetShown(not v);
			MainMenuMaxLevelBar2:SetShown(not v);
			MainMenuMaxLevelBar3:SetShown(not v);
			MainMenuBarTexture0:SetShown(not v);
			MainMenuBarTexture1:SetShown(not v);
			MainMenuBarTexture2:SetShown(not v);
			MainMenuBarTexture3:SetShown(not v);
			MainMenuBarPageNumber:SetShown(not v);
		end
	},
	{
		text = "隐藏经验声望条",
		var = "hiderepexp",
		default = false,
		callback = function(cfg, v, loading)
			if loading then
				C_Timer.After(1.0, function()
					MainMenuExpBar:SetShown(not v and not IsAddOnLoaded("Dominos"));
					ReputationWatchBar:SetShown(not v and not IsAddOnLoaded("Dominos"));
				end);
			else
				MainMenuExpBar:SetShown(not v and not IsAddOnLoaded("Dominos"));
				ReputationWatchBar:SetShown(not v and not IsAddOnLoaded("Dominos"));
			end
		end
	},
	--[[
	{
		text = "隐藏地区动作按钮材质",
		var = "hidezoneabil",
		default = false,
		callback = function(cfg, v, loading)
			if select(4, GetBuildInfo()) < 90000 then
				ZoneAbilityFrame.SpellButton.Style:SetShown(not v);
			end
		end
	}
	--]]
});

--[[
U1RegisterAddon("ButtonFacade", {
	title = "ButtonFacade",
	parent = "Masque",
	desc = "为Masque提供兼容老版的接口,不可关闭",
	protected = 1,
	load = "NORMAL",
	secure = 1,
	hide = 1,
	toggle = function(name, info, enable, justload)
		if justload then
			CoreScheduleTimer(false, 0.2, UUI.Right.ADDON_SELECTED);
		end
	end,
});
--]]
--[[
if hooksecurefunc and MainMenuBar_UpdateExperienceBars then
	--满级以后的条
	hooksecurefunc("MainMenuBar_UpdateExperienceBars", function(newLevel)
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		if ( not newLevel ) then
			newLevel = UnitLevel("player");
		end
		if ( name ) then
			if not ( newLevel < MAX_PLAYER_LEVEL and not IsXPUserDisabled() ) then
				ReputationWatchBar.StatusBar:SetHeight(11)
			end
		end
	end)
end
--]]
--皮肤必须是load=NORMAL的，否则在启用设置之前，Skin还没有加载上
U1RegisterAddon("BlizzBuffsFacade", { load = "NORMAL", title = "默认Buff美化支持" });
U1RegisterAddon("Masque_Apathy", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Cainyx", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Caith", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Cirque", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_CleanUI", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Entropy", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Goldpaw", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Kenzo", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Onyx", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Parabole", { load = "NORMAL", protected = 1, hide = 1, });
U1RegisterAddon("Masque_Serenity", { load = "NORMAL", protected = 1, hide = 1, });

--支持暴雪默认动作条
CoreDependCall("Masque", function()
	CoreLeaveCombatCall("cfgmasque_blizz", nil, function()
		local Masque, GroupName = LibStub('Masque'), '暴雪动作条按钮'
		local AddButtonToGroup = function(btnname, index, subgroup, func)
			local Group = Masque:Group(GroupName, subgroup)
			for i = 1, index do
				local btn = _G[format(btnname, i)]
				if(btn) then
					Group:AddButton(btn)
					if func ~= nil then
						pcall(func, btn)
					end
				end
			end
		end

		AddButtonToGroup('ActionButton%d', NUM_ACTIONBAR_BUTTONS, '主动作条', function(btn)
			if not InCombatLockdown() then
				btn:SetFrameStrata('HIGH')
			end
		end)
		--AddButtonToGroup('BonusActionButton%d', NUM_BONUS_ACTION_SLOTS, '额外动作条')
		AddButtonToGroup('PetActionButton%d', NUM_PET_ACTION_SLOTS, '宠物动作条')
		AddButtonToGroup('MultiBarLeftButton%d', NUM_MULTIBAR_BUTTONS, '右侧动作条1')
		AddButtonToGroup('MultiBarRightButton%d', NUM_MULTIBAR_BUTTONS, '右侧动作条2')
		AddButtonToGroup('MultiBarBottomLeftButton%d', NUM_MULTIBAR_BUTTONS, '左下动作条')
		AddButtonToGroup('MultiBarBottomRightButton%d', NUM_MULTIBAR_BUTTONS, '右下动作条')
		-- AddButtonToGroup('PossessButton%d', NUM_POSSESS_SLOTS, '控制动作条')
		AddButtonToGroup('StanceButton%d', NUM_STANCE_SLOTS, '姿态动作条')
		-- Masque:Group(GroupName, '区域技能按钮'):AddButton(ZoneAbilityFrame.SpellButton)
		--[[
		local SetPoint = ActionButton1Count.SetPoint
		AddButtonToGroup('VehicleMenuBarActionButton%d', VEHICLE_MAX_ACTIONBUTTONS, '载具动作条', function(btn)
			local hotkey = _G[btn:GetName() .. 'HotKey']
			if(hotkey and hotkey.SetPoint ~= SetPoint) then
				hotkey.SetPoint = SetPoint
			end
		end)--]]
		--直接运行不可以
		RunOnNextFrame(function() Masque:Group(GroupName):Enable() end);
	end)
	--7.0 PaperDollItemSlotButton_Update with set IconBorder texture back to Interface\Common\WhiteIconFrame
	--hooksecurefunc("SetItemButtonTexture", function(self) if self:GetName() == "CharacterBag0Slot" then print(debugstack()) end end)
	--hooksecurefunc("PaperDollItemSlotButton_Update", function(self) print(666) if(self:GetName()=="CharacterBag0Slot") then print(111) end end)--[[ 这个不行，会造成开启角色面板时的严重卡顿
	local reskin = function()
		local domino = GetMasqueCore().Groups["Dominos"]
		if domino then
			local group = domino.SubList["Dominos_Bag Bar"]
			if group then
				if not group.db.Disabled then
					group:ReSkin()
				end
				for Button in pairs(group.Buttons) do
					if Button.IconBorder then
						Button.IconBorder:Hide()
					end
				end
			end
		end
	end
	CoreOnEvent("BAG_UPDATE_DELAYED", reskin)
	hooksecurefunc("PaperDollItemSlotButton_OnShow", reskin) --7.2发现宠物战斗投降后这样
end)

