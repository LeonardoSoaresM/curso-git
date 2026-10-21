local lifeValue = 100
local defenseValue = 15

for i = 1, 5 do
  local attack = math.random(10, 30)

  if attack >= 20 then
    print("Critical Damage!")
  end

  local damage = attack - defenseValue

  if damage < 0 then
    damage = 0
  end

  lifeValue = lifeValue - damage

  if lifeValue <= 0 then
    print("You died")
    break
  end
end

if lifeValue > 0 then
  print("You survived with " .. lifeValue .. " life points left.")
end
