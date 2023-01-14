local UIDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0");

local _, __ns = ...;
__ns._Option = {  };
-- __ns.__env = setmetatable({  }, {
-- 	__index = _G,
-- 	__newindex = function(tbl, key, value)
-- 		rawset(tbl, key, value);
-- 		print("Dev Assign Global ", key, value);
-- 		return value;
-- 	end,
-- }
-- );
-- setfenv(1, __ns.__env);

local __DropDownButtons = {  };

local UIDropDownMenuTemplate = "UIDropDownMenuTemplate"

_G.tdDropDownDB = {}

local L = __ns._Locale
local _Option = __ns._Option

StaticPopupDialogs["TDDROPDOWN_DELETE_ALL"] = {preferredIndex = 3,
    text = L.DelAll,
    button1 = YES,
    button2 = CANCEL,
    OnAccept = function(self, profile)
        if tdDropDownDB[profile] then
            wipe(tdDropDownDB[profile])
        end
    end,
    timeout = 0,
    hideOnEscape = 1,
    whileDead = 1,
    exclusive = 1,
}

local function IsInList(list, text)
	for key, value in ipairs(list) do
		if value == text then
			return key
		end
	end
end

local function RemoveFromList(list, text)
	for key, value in ipairs(list) do
		if value and text and value:lower() == text:lower() then
            tremove(list, key)
			return key
		end
	end
end

local function StringSortMethod(text1, text2)
	local len1, len2 = strlen(text1), strlen(text2);
	return (len1 < len2) or (len1 == len2 and text1 < text2) or false
end

local function tdDropDown_HeaderClick(self)
	local pos = IsInList(tdDropDownDB[self.owner.profile], self.value)
	if pos then
		tremove(tdDropDownDB[self.owner.profile], pos)
		self.owner.editbox:SetText("")
	else
		tinsert(tdDropDownDB[self.owner.profile], self.value)
	end
	sort(tdDropDownDB[self.owner.profile], StringSortMethod)
end

local function tdDropDown_ButtonClick(self)
	self.owner.editbox:SetText(self.value)
	if self.owner.click then
		self.owner.click()
	end
end

local function tdDropdown_DeleteAll(self, arg1)
    StaticPopup_Show("TDDROPDOWN_DELETE_ALL", nil, nil, arg1);
end

local function tdDropDown_Initialize(self, dropdown, level)
	level = level or 1

	local list = tdDropDownDB[dropdown.profile]
	local text = dropdown.editbox:GetText()
	local info = {}

	if not text or text == "" or text == L.Search then text = nil end

	if text and level == 1 then
		local str = IsInList(list, text) and L.Del or L.Add

		info = { owner = dropdown, notCheckable = 1,}
		info.text = format(str, text)
		info.value = text;
		info.func = tdDropDown_HeaderClick
		UIDD:UIDropDownMenu_AddButton(info, 1)

		if #(list) > 0 then
			info.isTitle = 1
			info.text = ""
			info.value = ""
			info.func = nil
			UIDD:UIDropDownMenu_AddButton(info, 1)
		end
	end

	info = { owner = dropdown, func = tdDropDown_ButtonClick,}

	local start  = (level - 1) * _Option.MAX + 1
	for i = start, start + _Option.MAX - 1 do
		if not list[i] then
			break
		end
		info.text = list[i]
		info.value = list[i];
		UIDD:UIDropDownMenu_AddButton(info, level)
	end

	if #(list) > start + _Option.MAX - 1 then
		info.notCheckable = 1
		info.text = L.Next
		info.value = nil
		info.func = nil
		info.hasArrow = true
		UIDD:UIDropDownMenu_AddButton(info, level)
    end

    --增加删除全部的功能
    if #list > 0 and level == 1 then
        info = { owner = dropdown, notCheckable = 1, }
        info.isTitle = 1
        info.text = ""
        info.value = ""
        info.func = nil
        UIDD:UIDropDownMenu_AddButton(info, 1)

        info = { owner = dropdown, notCheckable = 1, }
        info.text = L.DelAll;
        info.value = L.DelAll;
        info.func = tdDropdown_DeleteAll;
        info.arg1 = dropdown.profile;
        UIDD:UIDropDownMenu_AddButton(info, 1)
    end
end

local function GetObjectByPath(path)
    local curr = _G
    for _, v in ipairs({strsplit(".", path)}) do
        local next = curr[v]
        if not next then return end
        curr = next
    end
    return curr
end

local function CreateDropDown(which, profile, short, move, click, over)
	if not profile then return end

	local editbox = GetObjectByPath(profile)
	if not editbox then return end

	tdDropDownDB[profile] = tdDropDownDB[profile] or {}

	local name = editbox:GetName() or profile
	local dropdown = CreateFrame("Frame", name.."Dropdown", editbox, UIDropDownMenuTemplate)

	local width = editbox:GetWidth()
	if short then
		editbox:SetWidth(width - 19)
	end
	if move then
        for i=1, editbox:GetNumPoints() do
			local point, relative, rpoint, x, y = editbox:GetPoint(i)
			if strfind(point, "RIGHT") then
				--editbox:ClearAllPoints()
				editbox:SetPoint(point, relative, rpoint, x - 19, y)
			end
		end
	end

	local button = CreateFrame("Button", name.."Button", editbox)
	button:SetWidth(24);button:SetHeight(24)
	button:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
	button:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	if over then
		button:SetPoint("RIGHT", editbox, "RIGHT", 2, 0)
	else
		button:SetPoint("LEFT", editbox, "RIGHT", -5, 0)
	end
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	button.dropdown = dropdown
	dropdown.editbox = editbox
	dropdown.profile = profile
	dropdown.click = click

	button:SetScript("OnClick", function(self, arg1)
		if arg1 == "LeftButton" then
			UIDD:ToggleDropDownMenu(1, nil, self.dropdown, self, - width , 0)
		else
			self.dropdown.editbox:SetText("")
		end
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(format(L.Num, #(tdDropDownDB[self.dropdown.profile])), 1, 1, 1)
		GameTooltip:AddLine(L.ShowList)
		GameTooltip:AddLine(L.ClearInput)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	__DropDownButtons[which] = button;

	UIDD:UIDropDownMenu_Initialize(dropdown, function(self, level) tdDropDown_Initialize(self, dropdown, level) end, _Option.Menu and "MENU" or nil);
end

local profiles = {}

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	local _P = profiles[event];
	if _P then
		for _index = #_P, 1, -1 do
			local value = _P[_index];
			if value.func(...) then
				CreateDropDown(value.which, value.profile, value.short, value.move, value.click, value.over)
				if value.hook then value.hook() end
				tremove(_P, _index);
			end
		end
		if #_P <= 0 then
			self:UnregisterEvent(event)
		end
	end
end)

function __ns.tdInsertValueIfNotExist(profile, value)
	local list = tdDropDownDB[profile];
	if value and value:len()> 0 then
        RemoveFromList(list, value);
		tinsert(list, 1, value);
	end
end

function __ns.tdCreateDropDown(which, value)
	if not value or not value.profile then return end

	if value.check ~= nil and value.check() then
		CreateDropDown(which, value.profile, value.short, value.move, value.click, value.over)
		if value.hook then value.hook() end
	else
		local event = value.event or "VARIABLES_LOADED"
		local func = value.func or function() return true end

		if profiles[event] == nil then
			profiles[event] = {}
			f:RegisterEvent(event)
		end
		tinsert(profiles[event], {
			which = which,
			profile = value.profile,
			func = func,
			short = value.short,
			move = value.move,
			click = value.click,
			over = value.over,
			hook = value.hook,
		})
	end
end

__ns.tdCreateDropDownDirect = CreateDropDown

function _G.tdDDConfig(key, val)
	local button = __DropDownButtons[key];
	if button ~= nil then
		button:SetShown(val);
	end
	_Option[key] = val;
end
