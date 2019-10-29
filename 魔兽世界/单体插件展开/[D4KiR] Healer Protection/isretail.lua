-- By D4KiR

local retail = false
function IsRetail()
	local isclassic = false
	if MainMenuBarPerformanceBarFrame ~= nil then
		isclassic = true
	end
	if isclassic == retail then
		D4_HP.msg("You using the wrong version of this addon (Classic/Retail)!")
	end
	return not isclassic
end
IsRetail()
