-- LIB Output

D4_HP = D4_HP or {}

function D4_HP.msg(str)
	print("|c0000ffff" .. "[" .. "|cff8888ff" .. D4_HP.name .. "|c0000ffff" .. "] " .. str)
end

function D4_HP.deb(str)
	if D4_HP.DEBUG then
		print("[DEB] " .. str)
	end
end

function pTab(tab)
	print("pTab", tab)
	for i, v in pairs(tab) do
		if type(v) == "table" then
			pTab(v)
		else
			print(i, v)
		end
	end
	print("----------------------------------")
end
