-- LIB Design

lang = lang or {}

function D4_HP.GT(str, tab)
	local strid = string.lower(str)
	local result = lang[strid]
	if result ~= nil then
		if tab ~= nil then
			for i, v in pairs(tab) do
				local find = i -- "[" .. i .. "]"
				local replace = v
				if find ~= nil and replace ~= nil then
					result = string.gsub(result, find, replace)
				end
			end
		end
		return result
	else
		return str
	end
end

function UpdateLanguage()

end
