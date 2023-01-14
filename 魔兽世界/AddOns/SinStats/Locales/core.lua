local AddName, AddonTable = ...

local defaultLocale, newLocale
function AddonTable.RegisterLocale(locale, default)
	if default then
		if locale == "enUS" and not defaultLocale then
			defaultLocale, newLocale = {}, {}
			AddonTable.L = setmetatable(newLocale, { __index = function(t, k)
				local v = defaultLocale[k] or tostring(k)
				return v
			end})
			return defaultLocale
		end
	end
	return newLocale
end
