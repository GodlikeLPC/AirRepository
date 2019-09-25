local _, L = ...;

L["Reputation"] = "Reputation"
L["HideNeutral"] = "Hide neutral or worse"
L["ShowValue"] = "Show value"
L["ShowPercent"] = "Show percentage"
L["ShowHeaders"] = "Show headers"
L["HideMax"] = "Hide maximun"
L["HideExalted"] = "Hide exalted factions"
L["AlwaysShowParagon"] = "Always show Paragon reputations"

if GetLocale() == "ptBR" then
	L["Reputation"] = "Reputação"
	L["HideNeutral"] = "Esconder tolerado ou pior"
	L["ShowValue"] = "Mostrar valor"
	L["ShowPercent"] = "Mostrar percentual"
	L["ShowHeaders"] = "Mostrar cabeçalhos"
	L["HideMax"] = "Esconder máximo"
	L["HideExalted"] = "Esconder facções exaltadas"
	L["AlwaysShowParagon"] = "Sempre mostrar reputações Paragão"

    elseif GetLocale() == "zhCN" then
	L["Reputation"] = "声望"
	L["HideNeutral"] = "不显示中立"
	L["ShowValue"] = "显示值"
	L["ShowPercent"] = "显示百分比"
	L["ShowHeaders"] = "显示标题"
	L["HideMax"] = "隐藏最大"
	L["HideExalted"] = "隐藏崇拜的声望"
	L["AlwaysShowParagon"] = "总是显示声望"
end
