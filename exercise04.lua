local num = {56, 12, 5, 10, 49}

print("First value: " .. num[1])
print("Last value: " .. num[#num])

num[2] = 24
num[4] = 31

table.insert(num, 61)

for i = 1, #num do
  print("num[" .. i .. "]: " .. num[i])
end

local var = 78
table.insert(num, var)
var = 1

print("New value inserted : " .. num[#num])
print("Variable value : " .. var)
