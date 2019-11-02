-- By D4KiR

function D4_HP.InitSetting()
	local D4HP_Settings = {}
	D4HP_Settings.panel = CreateFrame("Frame", "D4HP_Settings", UIParent)
	D4HP_Settings.panel.name = D4_HP.colorauthor .. D4_HP.author .. " " .. D4_HP.colorname .. D4_HP.name

	local BR = 16
	local HR = 20
	local SR = 40
	local Y = -10

	local settings_header = {}
	settings_header.frame = D4HP_Settings.panel
	settings_header.parent = D4HP_Settings.panel
	settings_header.x = 10
	settings_header.y = Y
	settings_header.text = D4_HP.colorauthor .. D4_HP.author .. " " .. D4_HP.colorname .. D4_HP.name
	settings_header.textsize = 24
	D4_HP.CreateText(settings_header)
	Y = Y - 30

	local settings_aggro = {}
	settings_aggro.name = "aggro"
	settings_aggro.parent = D4HP_Settings.panel
	settings_aggro.checked = D4_HP.GetConfig("AGGRO", true)
	settings_aggro.text = "aggro"
	settings_aggro.x = 10
	settings_aggro.y = Y
	settings_aggro.dbvalue = "AGGRO"
	D4_HP.CreateCheckBox(settings_aggro)
	Y = Y - BR

	local settings_showaggrochat = {}
	settings_showaggrochat.name = "showaggrochat"
	settings_showaggrochat.parent = D4HP_Settings.panel
	settings_showaggrochat.checked = D4_HP.GetConfig("showaggrochat", true)
	settings_showaggrochat.text = "showaggrochat"
	settings_showaggrochat.x = 10
	settings_showaggrochat.y = Y
	settings_showaggrochat.dbvalue = "showaggrochat"
	D4_HP.CreateCheckBox(settings_showaggrochat)
	Y = Y - BR

	local settings_showaggroemote = {}
	settings_showaggroemote.name = "showaggroemote"
	settings_showaggroemote.parent = D4HP_Settings.panel
	settings_showaggroemote.checked = D4_HP.GetConfig("showaggroemote", true)
	settings_showaggroemote.text = "showaggroemote"
	settings_showaggroemote.x = 10
	settings_showaggroemote.y = Y
	settings_showaggroemote.dbvalue = "showaggroemote"
	D4_HP.CreateCheckBox(settings_showaggroemote)
	Y = Y - SR

	local settings_aggro_percentage = {}
	settings_aggro_percentage.name = "underhealthprintmessage"
	settings_aggro_percentage.parent = D4HP_Settings.panel
	settings_aggro_percentage.text = "underhealthprintmessage"
	settings_aggro_percentage.x = 10 + 30
	settings_aggro_percentage.y = Y
	settings_aggro_percentage.min = 30
	settings_aggro_percentage.max = 100
	settings_aggro_percentage.value = D4_HP.GetConfig("AGGROPercentage", 90)
	settings_aggro_percentage.dbvalue = "AGGROPercentage"
	D4_HP.CreateSlider(settings_aggro_percentage)
	Y = Y - BR



	Y = Y - HR
	local settings_oom = {}
	settings_oom.name = "outofmana"
	settings_oom.parent = D4HP_Settings.panel
	settings_oom.checked = D4_HP.GetConfig("OOM", true)
	settings_oom.text = "outofmana"
	settings_oom.x = 10
	settings_oom.y = Y
	settings_oom.dbvalue = "OOM"
	D4_HP.CreateCheckBox(settings_oom)
	Y = Y - BR

	local settings_showoomchat = {}
	settings_showoomchat.name = "showoomchat"
	settings_showoomchat.parent = D4HP_Settings.panel
	settings_showoomchat.checked = D4_HP.GetConfig("showoomchat", true)
	settings_showoomchat.text = "showoomchat"
	settings_showoomchat.x = 10
	settings_showoomchat.y = Y
	settings_showoomchat.dbvalue = "showoomchat"
	D4_HP.CreateCheckBox(settings_showoomchat)
	Y = Y - BR

	local settings_showoomemote = {}
	settings_showoomemote.name = "showoomemote"
	settings_showoomemote.parent = D4HP_Settings.panel
	settings_showoomemote.checked = D4_HP.GetConfig("showoomemote", true)
	settings_showoomemote.text = "showoomemote"
	settings_showoomemote.x = 10
	settings_showoomemote.y = Y
	settings_showoomemote.dbvalue = "showoomemote"
	D4_HP.CreateCheckBox(settings_showoomemote)
	Y = Y - SR

	local settings_oom_percentage = {}
	settings_oom_percentage.name = "undermanaprintmessage"
	settings_oom_percentage.parent = D4HP_Settings.panel
	settings_oom_percentage.text = "undermanaprintmessage"
	settings_oom_percentage.x = 10 + 30
	settings_oom_percentage.y = Y
	settings_oom_percentage.min = 1
	settings_oom_percentage.max = 10
	settings_oom_percentage.value = D4_HP.GetConfig("OOMPercentage", 10)
	settings_oom_percentage.dbvalue = "OOMPercentage"
	D4_HP.CreateSlider(settings_oom_percentage)
	Y = Y - BR



	Y = Y - HR
	local settings_nearoom = {}
	settings_nearoom.name = "nearoutofmana"
	settings_nearoom.parent = D4HP_Settings.panel
	settings_nearoom.checked = D4_HP.GetConfig("NEAROOM", true)
	settings_nearoom.text = "nearoutofmana"
	settings_nearoom.x = 10
	settings_nearoom.y = Y
	settings_nearoom.dbvalue = "NEAROOM"
	D4_HP.CreateCheckBox(settings_nearoom)
	Y = Y - BR

	local settings_shownearoomchat = {}
	settings_shownearoomchat.name = "shownearoomchat"
	settings_shownearoomchat.parent = D4HP_Settings.panel
	settings_shownearoomchat.checked = D4_HP.GetConfig("shownearoomchat", true)
	settings_shownearoomchat.text = "shownearoomchat"
	settings_shownearoomchat.x = 10
	settings_shownearoomchat.y = Y
	settings_shownearoomchat.dbvalue = "shownearoomchat"
	D4_HP.CreateCheckBox(settings_shownearoomchat)
	Y = Y - BR

	local settings_shownearoomemote = {}
	settings_shownearoomemote.name = "shownearoomemote"
	settings_shownearoomemote.parent = D4HP_Settings.panel
	settings_shownearoomemote.checked = D4_HP.GetConfig("shownearoomemote", true)
	settings_shownearoomemote.text = "shownearoomemote"
	settings_shownearoomemote.x = 10
	settings_shownearoomemote.y = Y
	settings_shownearoomemote.dbvalue = "shownearoomemote"
	D4_HP.CreateCheckBox(settings_shownearoomemote)
	Y = Y - SR

	local settings_nearoom_percentage = {}
	settings_nearoom_percentage.name = "undermanaprintmessage"
	settings_nearoom_percentage.parent = D4HP_Settings.panel
	settings_nearoom_percentage.text = "undermanaprintmessage"
	settings_nearoom_percentage.x = 10 + 30
	settings_nearoom_percentage.y = Y
	settings_nearoom_percentage.min = 11
	settings_nearoom_percentage.max = 30
	settings_nearoom_percentage.value = D4_HP.GetConfig("NEAROOMPercentage", 30)
	settings_nearoom_percentage.dbvalue = "NEAROOMPercentage"
	D4_HP.CreateSlider(settings_nearoom_percentage)
	Y = Y - BR



	Y = Y - HR
	local settings_showlocchat = {}
	settings_showlocchat.name = "showlocchat"
	settings_showlocchat.parent = D4HP_Settings.panel
	settings_showlocchat.checked = D4_HP.GetConfig("showlocchat", true)
	settings_showlocchat.text = "showlocchat"
	settings_showlocchat.x = 10
	settings_showlocchat.y = Y
	settings_showlocchat.dbvalue = "showlocchat"
	D4_HP.CreateCheckBox(settings_showlocchat)
	Y = Y - BR

	local settings_showlocemote = {}
	settings_showlocemote.name = "showlocemote"
	settings_showlocemote.parent = D4HP_Settings.panel
	settings_showlocemote.checked = D4_HP.GetConfig("showlocemote", true)
	settings_showlocemote.text = "showlocemote"
	settings_showlocemote.x = 10
	settings_showlocemote.y = Y
	settings_showlocemote.dbvalue = "showlocemote"
	D4_HP.CreateCheckBox(settings_showlocemote)
	Y = Y - BR



	Y = Y - HR
	local settings_channel = {}
	settings_channel.name = "channelchat"
	settings_channel.parent = D4HP_Settings.panel
	settings_channel.text = "channelchat"
	settings_channel.value = D4_HP.GetConfig("channelchat", "AUTO")
	settings_channel.x = 0
	settings_channel.y = Y
	settings_channel.dbvalue = "channelchat"
	settings_channel.tab = {}
	settings_channel.tab[0] = "AUTO"
	settings_channel.tab[1] = "PARTY"
	settings_channel.tab[2] = "RAID"
	settings_channel.tab[3] = "SAY"
	settings_channel.tab[4] = "YELL"
	settings_channel.tab[5] = "INSTANCE_CHAT"
	D4_HP.CreateComboBox(settings_channel)
	Y = Y - SR



	local settings_prefix = {}
	settings_prefix.name = "prefix"
	settings_prefix.parent = D4HP_Settings.panel
	settings_prefix.value = D4_HP.GetConfig("prefix", "[Healer Protection]")
	settings_prefix.text = "prefix"
	settings_prefix.x = 10
	settings_prefix.y = Y
	settings_prefix.dbvalue = "prefix"
	D4_HP.CreateTextBox(settings_prefix)

	local settings_suffix = {}
	settings_suffix.name = "suffix"
	settings_suffix.parent = D4HP_Settings.panel
	settings_suffix.value = D4_HP.GetConfig("suffix", "")
	settings_suffix.text = "suffix"
	settings_suffix.x = 10 + 250 + 10
	settings_suffix.y = Y
	settings_suffix.dbvalue = "suffix"
	D4_HP.CreateTextBox(settings_suffix)
	Y = Y - BR



	InterfaceOptions_AddCategory(D4HP_Settings.panel)
end
