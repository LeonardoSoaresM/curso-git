local playerBattlefield = {}
local npcBattlefield = {}
local sizeBattlefield = 3
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

local function randomPosition(battlefield)
  local row = math.random(1, #battlefield)
  local col = math.random(1, #battlefield[row])
  return battlefield[row][col]
end

local function createShipsNPC(npcShipsPositions, npcBattlefield, amount)
  for i = 1, amount do
    local position = randomPosition(npcBattlefield)
    table.insert(npcShipsPositions, position)
  end
end

local function validatePositionInBattlefield(position, battlefield)
  if type(position) ~= "string" or not string.match(position, "^[A-Z]%d+$") then
        print("Formato inválido! Use algo como A1, B2, etc.")
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

local function npcAttack(battlefield)
  local attackPosition = randomPosition(battlefield)
  print("Ataque feito na posição: " .. attackPosition)
  return attackPosition
end

local function findCoordinate(battlefield, coordinate)
  for i, targetCoordinate in ipairs(battlefield) do
    if targetCoordinate == coordinate then
        return true
    end
  end
  return false
end

local function playerAttack(coordinate, npcShipsPositions)
  if findCoordinate(npcShipsPositions, coordinate) then
    print("Você acertou.")
    return true
  else
    print("Você errou.")
    return false
  end
end

local c = true
while c == true do
  playerBattlefield = createBattlefield(sizeBattlefield)
  npcBattlefield = createBattlefield(sizeBattlefield)

  print("Campo do Jogador: ")
  showBattlefield(playerBattlefield)
  print("Campo do NPC: ")
  showBattlefield(npcBattlefield)
  print()

  local shipIndex = 1
  while shipIndex <= 3 do
      print("Navio " .. shipIndex .. "/3: Insira qual a posição você deseja colocar seu barco (Ex: A1, B2, D7):")

      local input_position = io.read()

      if validatePositionInBattlefield(input_position, playerBattlefield) then
          playerShipsPositions[shipIndex] = input_position
          shipIndex = shipIndex + 1
      else
          print("Posição inválida ou fora do mapa! Tente novamente.")
      end
  end
  print(playerShipsPositions[2])
  c = false
end
