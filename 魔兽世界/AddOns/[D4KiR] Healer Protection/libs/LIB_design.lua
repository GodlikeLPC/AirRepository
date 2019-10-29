-- LIB Design

function D4_HP.CreateText(tab)
	tab.textsize = tab.textsize or 12
	local text = tab.frame:CreateFontString(nil, "ARTWORK")
	text:SetFont(STANDARD_TEXT_FONT, tab.textsize, "OUTLINE")
	text:SetPoint("TOPLEFT", tab.parent, "TOPLEFT", tab.x, tab.y)
	text:SetText(D4_HP.GT(tab.text))

	hooksecurefunc("UpdateLanguage", function()
		text:SetText(D4_HP.GT(tab.text))
	end)

	return text
end

function D4_HP.CreateTextBox(tab)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	local f = CreateFrame("Button", nil, tab.parent)
	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},})
	f:SetBackdropColor(1, 0, 0, 0)
	f:SetPoint("TOPLEFT", tab.x, tab.y)
	f:SetSize(250, 50)

	tab.frame = f
	tab.parent = f
	tab.x = 4
	tab.y = -4
	tab.text = tab.text
	f.header = D4_HP.CreateText(tab)

	f.Text = CreateFrame("EditBox", nil, f)
	f.Text:SetPoint("TOPRIGHT", -2, -25)
	f.Text:SetPoint("BOTTOMLEFT", 2, 2)
	f.Text:SetMultiLine(false)
	f.Text:SetMaxLetters(20)
	f.Text:SetFontObject(GameFontNormal)
	f.Text:SetAutoFocus(false)
	tab.value = tab.value or ""
	tab.value = string.gsub(tab.value, "\n", "")
	f.Text:SetText(tab.value or "")
	f.Text:SetCursorPosition(0)
	f.Text:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},})
	f.Text:SetBackdropColor(0, 0, 0, 0.9)
	f.Text:SetScript("OnTextChanged", function(self)
		local text = self:GetText()
		self:SetText(text)
		D4HP[tab.dbvalue] = text

		SetupHP()
	end)

	return f
end

function D4_HP.CreateCheckBox(tab)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.tooltip = tab.tooltip or ""
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	local CB = CreateFrame("CheckButton", nil, tab.parent, "ChatConfigCheckButtonTemplate")
	CB:SetPoint("TOPLEFT", tab.x, tab.y)
	CB.tooltip = tab.tooltip
	CB:SetChecked(tab.checked)
	CB:SetScript("OnClick", function(self)
		local status = CB:GetChecked()
		self:SetChecked(status)
		D4HP[tab.dbvalue] = status

		SetupHP()
	end)

	tab.frame = CB
	tab.x = tab.x + 26
	tab.y = tab.y - 6
	CB.text = D4_HP.CreateText(tab)

	return CB
end

function D4_HP.CreateComboBox(tab)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.tooltip = tab.tooltip or ""
	tab.x = tab.x or 0
	tab.y = tab.y or 0

	local CB = CreateFrame("Frame", tab.name, tab.parent, "UIDropDownMenuTemplate")
	CB:SetPoint("TOPLEFT", tab.x, tab.y)

	UIDropDownMenu_SetWidth(CB, 120)
	UIDropDownMenu_SetText(CB, tab.value)

	-- Create and bind the initialization function to the dropdown menu
	UIDropDownMenu_Initialize(CB, function(self, level, menuList)
		for i, v in pairs(tab.tab) do
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			info.text, info.arg1, info.checked = v, v, v == tab.value
			UIDropDownMenu_AddButton(info)
		end
	end)

	function CB:SetValue(newValue)
		D4HP[tab.dbvalue] = newValue
		UIDropDownMenu_SetText(CB, newValue)
		CloseDropDownMenus()
	end

	return CB
end

function D4_HP.CreateSlider(tab)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	tab.value = tab.value or 0
	local SL = CreateFrame("Slider", tab.name, tab.parent, "OptionsSliderTemplate")
	SL:SetPoint("TOPLEFT", tab.x, tab.y)
	SL.Low:SetText(tab.min)
	SL.High:SetText(tab.max)
	SL:SetMinMaxValues(tab.min, tab.max)
	SL:SetValue(tab.value)
	SL:SetWidth(500)
	SL:SetObeyStepOnDrag(1)
	tab.steps = tab.steps or 1
	SL:SetValueStep(tab.steps)
	SL.decimals = tab.decimals or 0
	SL:SetScript("OnValueChanged", function(self, val)
		val = math.round(val, self.decimals)
		val = val - val % tab.steps
		D4HP[tab.dbvalue] = val
		local trans = {}
		trans["VALUE"] = val
		SL.Text:SetText(D4_HP.GT(tab.text, trans))
		if tab.func ~= nil then
			tab:func()
		end
	end)

	hooksecurefunc("UpdateLanguage", function()
		local trans = {}
		trans["VALUE"] = SL:GetValue()
		SL.Text:SetText(D4_HP.GT(tab.text, trans))
	end)

	return EB
end

function D4_HP.CTexture(frame, tab)
	tab.layer = tab.layer or "BACKGROUND"
	local texture = frame:CreateTexture(nil, tab.layer)
	tab.texture = tab.texture or ""
	if tab.texture ~= "" then
		tab.color.r = tab.color.r or 1
		tab.color.g = tab.color.g or 0
		tab.color.b = tab.color.b or 0
		tab.color.a = tab.color.a or 1
	 	texture:SetTexture(tab.texture)
		texture:SetVertexColor(tab.color.r, tab.color.g, tab.color.b, tab.color.a)
	elseif tab.color ~= nil then
		tab.color.r = tab.color.r or 1
		tab.color.g = tab.color.g or 0
		tab.color.b = tab.color.b or 0
		tab.color.a = tab.color.a or 1
		texture:SetColorTexture(tab.color.r, tab.color.g, tab.color.b, tab.color.a)
	else
		texture:SetTexture(tab.texture)
	end

	if tab.autoresize then
		texture:SetAllPoints(frame)
	else
		tab.w = tab.w or frame:GetWidth()
		tab.h = tab.h or frame:GetHeight()
		texture:SetSize(tab.w, tab.h)

		tab.x = tab.x or 0
		tab.y = tab.y or 0
		texture:SetPoint(tab.align or "TOPLEFT", frame, tab.x, tab.y)
	end

	return texture
end

function D4_HP.createF(tab)
	tab.w = tab.w or 2
	tab.h = tab.h or 2
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	tab.align = tab.align or "CENTER"
	tab.text = tab.text or "Unnamed"
	tab.textalign = tab.textalign or "CENTER"
	tab.textsize = tab.textsize or tonumber(string.format("%.0f", tab.h * 0.69))
	tab.parent = tab.parent or UIParent
	local frame = CreateFrame("FRAME", nil, tab.parent)
	frame:SetWidth(tab.w)
	frame:SetHeight(tab.h)
	frame:ClearAllPoints()
	frame:SetPoint(tab.align, tab.parent, tab.align, tab.x, tab.y)

	tab.layer = tab.layer or "BACKGROUND"
	frame.texture = D4_HP.CTexture(frame, tab)

	tab.textlayer = tab.textlayer or "ARTWORK"
	frame.text = frame:CreateFontString(nil, tab.textlayer)
	frame.text:SetFont(STANDARD_TEXT_FONT, tab.textsize, "OUTLINE")
	frame.text:SetPoint(tab.textalign, 0, 0)
	frame.text:SetText(tab.text)

	function frame:SetText(text)
		frame.text:SetText(text)
	end

	return frame
end

function D4_HP.CreateBar(tab)
	tab.w = 800
	tab.h = D4_HP.GetConfig("barheight") --13
	tab.alpha = 0.7
	tab.text = ""
	tab.bgcolor = tab.bgcolor or {}
	tab.bgcolor.r = tab.bgcolor.r or 0.2
	tab.bgcolor.g = tab.bgcolor.g or 0.2
	tab.bgcolor.b = tab.bgcolor.b or 0.2
	tab.bgcolor.a = tab.bgcolor.a or tab.alpha
	tab.color = tab.bgcolor
	tab.texture = "Interface/TargetingFrame/UI-StatusBar"
	local bar = {}
	tab.autoresize = true
	bar.background = D4_HP.createF(tab)

	tab.parent = bar.background
	tab.barcolor = tab.barcolor or {}
	tab.barcolor.r = tab.barcolor.r or 0.3
	tab.barcolor.g = tab.barcolor.g or 0.1
	tab.barcolor.b = tab.barcolor.b or 1
	tab.barcolor.a = tab.barcolor.a or tab.alpha
	tab.color = tab.barcolor
	tab.text = ""
	tab.align = "LEFT"
	tab.texture = "Interface/TargetingFrame/UI-StatusBar"
	tab.autoresize = true
	bar.bar = D4_HP.createF(tab)
	--tab.autoresize = false

	tab.align = "CENTER"
	tab.texture = ""
	tab.color.a = 0
	tab.text = ""
	bar.overlay = D4_HP.createF(tab)
	local bars = {}
	bars.layer = "BORDER"
	bars.color = {}
	bars.color.r = 0.2
	bars.color.g = 0.2
	bars.color.b = 0.2
	bars.color.a = tab.alpha
	bars.thickness = 1.1
	bars.w = tab.w
	bars.h = bars.thickness
	bars.align = "TOP"
	bar.overlay.t = D4_HP.CTexture(bar.overlay, bars)
	bars.y = 0
	bars.align = "BOTTOM"
	bar.overlay.b = D4_HP.CTexture(bar.overlay, bars)
	bars.w = bars.thickness
	bars.h = tab.h
	bars.y = 0
	bars.align = "LEFT"
	bar.overlay.l = D4_HP.CTexture(bar.overlay, bars)
	bars.x = 0
	bars.align = "RIGHT"
	bar.overlay.r = D4_HP.CTexture(bar.overlay, bars)
	local perc = 10
	local amount = 100 / perc
	for i = 1, amount - 1 do
		bars.x = tonumber(string.format("%.0f", (bar.overlay:GetWidth() / amount) * i) - (bars.thickness / 2))
		bars.align = nil
		bar.overlay[i] = D4_HP.CTexture(bar.overlay, bars)
	end

	function bar:Hide()
		bar.background:Hide()
	end
	function bar:Show()
		bar.background:Show()
	end

	function bar:GetHeight()
		return self.background:GetHeight()
	end

	function bar:SetHeight(h)
		bar.background:SetHeight(h)
		bar.bar:SetHeight(h)

		bar.overlay:SetHeight(h)
		bar.overlay.l:SetHeight(h)
		bar.overlay.r:SetHeight(h)
		for i = 1, amount - 1 do
			bar.overlay[i]:SetHeight(h)
		end
		bar.overlay.text:SetFont(STANDARD_TEXT_FONT, tonumber(string.format("%.0f", h * 0.69)), "OUTLINE")
		--bar.overlay.text:SetTextHeight(tonumber(string.format("%.0f", h * 0.69)))
	end

	function bar:GetWidth()
		return self.background:GetWidth()
	end

	function bar:SetWidth(w)
		w = math.round(w, 0)
		bar.background:SetWidth(w)

		bar.overlay:SetWidth(w)
		bar.overlay.t:SetWidth(w)
		bar.overlay.b:SetWidth(w)
		for i = 1, amount - 1 do
			local x = tonumber(string.format("%.0f", (bar.overlay:GetWidth() / amount) * i) - (bars.thickness / 2))
			bar.overlay[i]:SetPoint("TOPLEFT", bar.overlay, x, 0)
		end
	end

	bar.overlay:EnableMouse()
	bar.overlay:SetScript("OnEnter", function() bar.overlay.text:Hide() end)
	bar.overlay:SetScript("OnLeave", function() bar.overlay.text:Show() end)

	return bar
end
