-- LIB Math

function math.round(num, dec)
	dec = dec or 2
	return tonumber(string.format("%." .. dec .. "f", num))
end

function RGBToDec(rgb)
	return math.round(rgb / 255, 2)
end
