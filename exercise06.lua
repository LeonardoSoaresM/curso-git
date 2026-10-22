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

