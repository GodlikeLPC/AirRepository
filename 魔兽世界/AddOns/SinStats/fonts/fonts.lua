local LSM = LibStub("LibSharedMedia-3.0")

if not LSM then return end

local folder = [[SinStats\fonts\]]

-- From SharedMedia
LSM:Register("font", "Bazooka", [[Interface\Addons\]] .. folder .. [[Bazooka.ttf]])
LSM:Register("font", "DorisPP", [[Interface\Addons\]] .. folder .. [[DORISPP.ttf]])
LSM:Register("font", "Enigmatic", [[Interface\Addons\]] .. folder .. [[Enigma__2.ttf]])

-- From SharedMediaAdditionalFonts
LSM:Register("font", "Liberation Sans (U)", [[Interface\Addons\]] .. folder .. [[LiberationSans-Regular.ttf]])

-- From UrbanFonts.com
LSM:Register("font", "White Rabbit", [[Interface\Addons\]] .. folder .. [[WHITRABT.ttf]])
LSM:Register("font", "FSEX300", [[Interface\Addons\]] .. folder .. [[FSEX300.ttf]])