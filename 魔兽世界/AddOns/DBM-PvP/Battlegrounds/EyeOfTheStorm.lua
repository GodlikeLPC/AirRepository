if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z566", "DBM-PvP")

mod:SetRevision("20200215161830")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 566 or DBM:GetCurrentArea() == 968 then
			local modz = DBM:GetModByName("PvPGeneral")
			modz:SubscribeAssault(DBM:GetCurrentArea() == 566 and 112 or 397, 4)
			modz:SubscribeFlags()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end