local users = {
  {name = "Leonardo", age = 24},
  {name = "Bruna", age = 22},
  {name = "Carlos", age = 14}
}

local function validation(name, age)
  if #name < 4 then
    print("Error: name must have at least 4 characters.")
    return false
  elseif age < 18 then
    print("Error: age must be at least 18.")
    return false
  end
  return true
end

local function addUser(name, age)
  if validation(name, age) then
    table.insert(users, {name = name, age = age})
    print("User added successfully.")
  else
    print("Failed to add user.")
  end
end

local function listUsers()
  print("List of users:")
  for i, user in ipairs(users) do
    print(i .. " - Nome: " .. user.name .. " - Idade: " .. user.age)
  end
end

local function removeUser(index)
  if index < 1 or index > #users then
    print("Error: invalid index.")
    return
  end
  table.remove(users, index)
  print("User removed successfully.")
end

addUser("André", 20)
addUser("Roberto", 41)
addUser("Ana", 19)
addUser("Enzo", 12)
print()
listUsers()
print()
removeUser(3)
print()
listUsers()
