local playerBattlefield = {}
local npcBattlefield = {}
local sizeBattlefield = 5
local totalShips = 5
local playerShipsPositions = {}
local npcShipsPositions = {}

local function createBattlefield(size)
  local battlefield = {}
  for i = 1, size do
    battlefield[i] = {}
    local letter = string.char(64 + i)
    for j = 1, size do
      battlefield[i][j] = letter .. j
    end
  end
  return battlefield
end

local function showBattlefield(battlefield)
  for i = 1, #battlefield do
    for j = 1, #battlefield[i] do
      io.write(battlefield[i][j] .. " ")
    end
  io.write("\n")
  end
end

local function getRandomPosition(battlefield)
  local row = math.random(1, #battlefield)
  local number = math.random(1, #battlefield[row])
  local letter = string.char(64 + row)
  return letter .. number
end

local function findCoordinate(shipsList, coordinate)
  for i, targetCoordinate in ipairs(shipsList) do
    if targetCoordinate == coordinate then
      return true
    end
  end
  return false
end

local function addNpcShips(npcShipsPositions, npcBattlefield, amount)
  while #npcShipsPositions < amount do
    local position = getRandomPosition(npcBattlefield)
    if not findCoordinate(npcShipsPositions, position) then
      table.insert(npcShipsPositions, position)
    end
  end
end

local function validatePositionInBattlefield(position, battlefield)
  if type(position) ~= "string" or not string.match(position, "^[A-Z]%d+$") then
    print("Invalid format! Use a coordinate like A1 or B2.")
    return false
  end

  for i = 1, #battlefield do
    for j = 1, #battlefield[i] do
      if battlefield[i][j] == position then
        return true
      end
    end
  end
  return false
end

local function addPlayerShips(shipsPosition)
  while true do
    local maxPos = string.char(64 + sizeBattlefield) .. sizeBattlefield
    print("Enter a position for your ship (Ex: A1, B2... max: " .. maxPos .. "):")
    local inputPosition = io.read()

    if validatePositionInBattlefield(inputPosition, playerBattlefield) and not (findCoordinate(shipsPosition, inputPosition)) then
      print("Ship placed at position: " .. inputPosition)
      return inputPosition
    elseif findCoordinate(shipsPosition, inputPosition) then
      print("Position already taken, enter a new position for the ship.")
    else
      print("Invalid position! Please try again.")
    end
  end
end

local function updateBattlefieldMarker(battlefield, coordinate, marker)
  for i = 1, #battlefield do
    for j = 1, #battlefield[i] do
      if battlefield[i][j] == coordinate then
        battlefield[i][j] = marker
        return true
      end
    end
  end
  return false
end

local function processAttack(coordinate, targetShips, targetBattlefield)
  if findCoordinate(targetShips, coordinate) then
    updateBattlefieldMarker(targetBattlefield, coordinate, "XX")
    for i, ship in ipairs(targetShips) do
      if ship == coordinate then
        table.remove(targetShips, i)
        break
      end
    end
    return true
  else
    updateBattlefieldMarker(targetBattlefield, coordinate, "00")
    return false
  end
end

local function showGameBattlefields(playerBattlefield, npcBattlefield, playerShipsPositions, npcShipsPositions)
  print("\nBattlefields (XX = sunken ship, 00 = miss): \n")
  print("Player lives: ".. #playerShipsPositions .."/" .. totalShips .. "\nPlayer Battlefield: ")
  showBattlefield(playerBattlefield)
  print("\nEnemy lives: ".. #npcShipsPositions .."/" .. totalShips .. "\nEnemy Battlefield: ")
  showBattlefield(npcBattlefield)
  print()
end

playerBattlefield = createBattlefield(sizeBattlefield)
npcBattlefield = createBattlefield(sizeBattlefield)
addNpcShips(npcShipsPositions, npcBattlefield, totalShips)

for i = 1, totalShips do
  print("Ship " .. i ..": ")
  table.insert(playerShipsPositions, addPlayerShips(playerShipsPositions))
end

os.execute("clear")
while true do
  showGameBattlefields(playerBattlefield, npcBattlefield, playerShipsPositions, npcShipsPositions)

  local attackCoordinate
  while true do
    local maxPos = string.char(64 + sizeBattlefield) .. sizeBattlefield
    print("Attack the enemy, enter the position (Ex: A1, B2... max: " .. maxPos .. "):")
    attackCoordinate = io.read()

    if validatePositionInBattlefield(attackCoordinate, npcBattlefield) then
      os.execute("clear")
      print("You attacked position: " .. attackCoordinate)
      break
    end
    print("Invalid position! Please try again.")
  end

  if processAttack(attackCoordinate, npcShipsPositions, npcBattlefield) then
    print("You HIT an enemy ship!")
  else
    print("You missed!")
  end

  if #npcShipsPositions == 0 then
    print("\nYou win! Congratulations!!\n")
    showBattlefield(npcBattlefield)
    break
  end

  local npcAttack
  while true do
    npcAttack = getRandomPosition(playerBattlefield)

    if validatePositionInBattlefield(npcAttack, playerBattlefield) then
      break
    end
  end

  print("\nThe enemy attacked position: " .. npcAttack)
  if processAttack(npcAttack, playerShipsPositions, playerBattlefield) then
    print("The enemy HIT one of your ships!")
  else
    print("The enemy missed!")
  end

  if #playerShipsPositions == 0 then
    print("You lost.\n")
    showBattlefield(playerBattlefield)
    break
  end

  showGameBattlefields(playerBattlefield, npcBattlefield, playerShipsPositions, npcShipsPositions)

  print("Press Enter to continue.")
  io.read()
  os.execute("clear")
end
