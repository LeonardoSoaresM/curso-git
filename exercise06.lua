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
