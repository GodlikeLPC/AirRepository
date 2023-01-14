local AddName, AddonTable = ...
local L = AddonTable.L


----------------------
--		SinLive		--
----------------------
function AddonTable.SinLive(self)

	AddonTable.shatteringStar, AddonTable.skyreach, AddonTable.radiantSpark, AddonTable.betweenEyes, AddonTable.chaosBrand, AddonTable.mysticTouch, AddonTable.colossusSmash, AddonTable.razorIce = 0, 0, 0, 0, 0, 0, 0, 0
	AddonTable.felSunder = 0
	
	for i = 1, 40 do
	local _, _, dcount, _, _, _, caster, _, _, debuffId = UnitDebuff("target", i)
		if not debuffId then break end
		
		local targetGUID = UnitGUID("target")
		
		if AddonTable.ShatteringStar[debuffId] and AddonTable.classFilename == "EVOKER" then AddonTable.shatteringStar = AddonTable.ShatteringStar[debuffId][1] end
		if AddonTable.Skyreach[debuffId] and caster == "player" then AddonTable.skyreach = AddonTable.Skyreach[debuffId][1] end
		if AddonTable.RadiantSpark[debuffId] and caster == "player" then AddonTable.radiantSpark = dcount * 10 / 100 end
		if AddonTable.BetweenEyes[debuffId] and caster == "player" then AddonTable.betweenEyes = AddonTable.BetweenEyes[debuffId][1] end
		if AddonTable.ChaosBrand[debuffId] then AddonTable.chaosBrand = AddonTable.ChaosBrand[debuffId][1] end
		if AddonTable.MysticTouch[debuffId] then AddonTable.mysticTouch = AddonTable.MysticTouch[debuffId][1] end
		if AddonTable.ColossusSmash[debuffId] and caster == "player" then AddonTable.colossusSmash = AddonTable.ColossusSmash[debuffId][1] end
		if AddonTable.RazorIce[debuffId] and caster == "player" then AddonTable.razorIce = dcount * 3 / 100 end
		if AddonTable.FelSunder[debuffId] and caster == "player" then AddonTable.felSunder = dcount / 100 end
	end
end