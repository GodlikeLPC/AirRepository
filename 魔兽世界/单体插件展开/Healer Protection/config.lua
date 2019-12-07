-- Config

D4_HP = D4_HP or {}
D4_HP.name = "Healer Protection"
D4_HP.shortname = "D4HP"
D4_HP.colorname = "|c008888ff"
D4_HP.author = "D4KiR"
D4_HP.colorauthor = "|c0000ffff"

SetCVar("ScriptErrors", 1)
D4_HP.DEBUG = false

D4HP = D4HP or {}

function D4_HP.GetConfig(str, val)
	local setting = val
	if D4HP ~= nil then
		if D4HP[str] == nil then
			D4HP[str] = val
		end
		setting = D4HP[str]
	else
		D4HP = D4HP or {}
	end
	return setting
end
