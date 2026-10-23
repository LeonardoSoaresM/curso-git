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



--playerBattlefield = createBattlefield(sizeBattlefield)
--npcBattlefield = createBattlefield(sizeBattlefield)
--print("Campo do Jogador: ")
--showBattlefield(playerBattlefield)
--print("Campo do NPC: ")
--showBattlefield(npcBattlefield)
--print()
--npcShipsPositions[1] = "A1"
--playerAttack("A1", npcShipsPositions)
--playerAttack("A1", npcShipsPositions)
--playerAttack("A3", npcShipsPositions)




--
--while true do
--  playerBattlefield = createBattlefield(sizeBattlefield)
--  npcBattlefield = createBattlefield(sizeBattlefield)
--  local i = true
--  while i do
--    print("Digite a posição do navio (ex: A1, B3):")
--    local position = io.read()
--    if position == "sair" then
--      break
--    end
--    local validPosition = validatePositionShip(position, playerBattlefield)
--
--    if validPosition then
--      table.insert(playerShipsPositions, position)
--      print("Navio adicionado na posição: " .. position)
--    else
--      print("Posição inválida. Tente novamente.")
--    end
--
--    if #playerShipsPositions >= 5 then
--      print("Você adicionou o número máximo de navios.")
--      break
--    end
--  end
--end
