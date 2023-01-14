local AddName, AddonTable = ...
local L = AddonTable.L


----------------------
--		SinLive		--
----------------------
function AddonTable.SinLive(self)

AddonTable.huntersMark, AddonTable.debuffCount, AddonTable.exposeWeakness = 0, 0, 0
	
	for i = 1, 40 do
	local _, _, dcount, _, _, _, _, _, _, debuffId = UnitDebuff("target", i)
		if not debuffId then break end
		
		local targetGUID = UnitGUID("target")
		
		if debuffId then
			AddonTable.debuffCount = i
		end
		
		AddonTable.debuffCount = AddonTable.debuffCount
		
		if AddonTable.HuntsMark[debuffId] then
			AddonTable.huntersMark = AddonTable.HuntsMark[debuffId][1]
		end
		
		if AddonTable.ExposeWeakness[debuffId] then
			AddonTable.exposeWeakness = AddonTable.ExposeWeakness[debuffId][1]
		end
		
	end
end