
local _B_Enabled = false;

local geterrorhandler = geterrorhandler;
local xpcall = xpcall;
local next = next;
local strlower = string.lower;
local GetItemInfoInstant = GetItemInfoInstant;
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo;

local _M = {  };
local _B = {  };
local _F = CreateFrame('FRAME');

local function OnEvent(self, event, addon)
	addon = strlower(addon);
	local method = _M[addon];
	if method ~= nil then
		xpcall(method, geterrorhandler());
		_M[addon] = nil;
		if next(_M) == nil then
			_F:SetScript("OnEvent", nil);
			_F:UnregisterEvent("ADDON_LOADED");
		end
	end
end

local function RegisterAddOnCallback(addon, method)
	if IsAddOnLoaded(addon) then
		xpcall(method, geterrorhandler());
	else
		_M[strlower(addon)] = method;
		_F:RegisterEvent("ADDON_LOADED");
		_F:SetScript("OnEvent", OnEvent);
	end
end
local function CreateItemlevelText(f)
	if f._ItemlevelText == nil then
		f._ItemlevelText = f:CreateFontString(nil, 'OVERLAY');
		f._ItemlevelText:SetPoint('TOPLEFT', f, 'TOPLEFT', 1, -1);
		f._ItemlevelText:SetFont(STANDARD_TEXT_FONT, 13, 'OUTLINE');
		_B[f] = 1;
	end
end
local function UpdateItemLevelText(f)
	local itemLink = f:GetItem();
	if itemLink then
		local _, _, _, _, _, type = GetItemInfoInstant(itemLink);
		if type == 2 or type == 4 then
			local level = GetDetailedItemLevelInfo(itemLink);
			f._ItemlevelText:SetText(level);
		else
			f._ItemlevelText:SetText(nil);
		end
	else
		f._ItemlevelText:SetText(nil);
	end
end

RegisterAddOnCallback("Bagnon", function()
    hooksecurefunc(Bagnon.Item, "Update", function(self)
		if _B_Enabled then
			CreateItemlevelText(self);
			UpdateItemLevelText(self);
		end
	end);
end);
RegisterAddOnCallback("Combuctor", function()
    hooksecurefunc(Combuctor.Item, "Update", function(self)
		if _B_Enabled then
			CreateItemlevelText(self);
			UpdateItemLevelText(self);
		end
	end);
end);

local function Toggle(enable)
	if enable then
		_B_Enabled = true;
		for b, _ in next, _B do
			UpdateItemLevelText(b);
		end
	else
		_B_Enabled = false;
		for b, _ in next, _B do
			b._ItemlevelText:SetText(nil);
		end
	end
end	
if __core_namespace ~= nil and __core_namespace.__module ~= nil then
	__core_namespace.__module.BagItemLevel = {
		Toggle = Toggle,
	};
else
	_163UI_BagItemLevel_Toggle = Toggle;
end
