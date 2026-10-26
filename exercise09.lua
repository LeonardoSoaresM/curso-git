local playerBattlefield = {}
local npcBattlefield = {}
local sizeBattlefield = 3
local totalShips = 3
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

local function findCoordinate(battlefield, coordinate)
  for i, targetCoordinate in ipairs(battlefield) do
    if targetCoordinate == coordinate then
        return true
    end
  end
  return false
end

local function createShipsNPC(npcShipsPositions, npcBattlefield, amount)
  while #npcShipsPositions < amount do
    local position = randomPosition(npcBattlefield)
    if findCoordinate(npcShipsPositions, position) == false then
      table.insert(npcShipsPositions, position)
    end
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

local function attackShip(coordinate, npcShipsPositions)
  if findCoordinate(npcShipsPositions, coordinate) then
    print("Acertou.")
    return true
  else
    print("Errou.")
    return false
  end
end

local function playerAddShips(shipsPosition)
  while true do
      print("Insira qual a posição você deseja colocar seu barco (Ex: A1, B2, D7):")

      local inputPosition = io.read()

      local checkShip = true
      for i, shipPosition in ipairs(shipsPosition) do
        if inputPosition == shipsPosition[i] then
          checkShip = false
        end
      end
      if validatePositionInBattlefield(inputPosition, playerBattlefield) and checkShip == true then
          print("Navio inserido na posição " .. inputPosition)
          return inputPosition
      else
        if checkShip == false then
          print("Posição repetida, insira uma nova posição para o navio.")
        else
          print("Posição inválida ou fora do mapa! Tente novamente.")
        end
      end
  end
end

playerBattlefield = createBattlefield(sizeBattlefield)
npcBattlefield = createBattlefield(sizeBattlefield)
createShipsNPC(npcShipsPositions, npcBattlefield, totalShips)

for i = 1, totalShips do
  print("Navio " .. i ..": ")
  table.insert(playerShipsPositions, playerAddShips(playerShipsPositions))
end

os.execute("clear")
while true do
  print("Campo do Jogador: ")
  showBattlefield(playerBattlefield)
  print("Campo do NPC: ")
  showBattlefield(npcBattlefield)
  print()

  local attackCoordinate
  while true do
    print("Realize seu ataque ao inimigo, informe a posição(Ex: A1,B2,C2,)")
    attackCoordinate = io.read()

    if validatePositionInBattlefield(attackCoordinate, npcBattlefield) then
      os.execute("clear")
      print("Você atacou na posição: " .. attackCoordinate)
      os.execute("sleep 2")
      break
    end
  end
  if attackShip(attackCoordinate, npcShipsPositions) then
    for i, ship in ipairs(npcShipsPositions) do
      if ship == attackCoordinate then
        table.remove(npcShipsPositions, i)
        os.execute("sleep 2")
        break
      end
    end
  end

  print()
  local npcAttack = randomPosition(playerBattlefield)
  print("O npc atacou na posição: " .. npcAttack)
  os.execute("sleep 2")
  if attackShip(npcAttack, playerShipsPositions) then
    for i, ship in ipairs(playerShipsPositions) do
      if ship == npcAttack then
        table.remove(playerShipsPositions, i)
        break
      end
    end
  end

  os.execute("sleep 2")
  print()
  print("Vidas do jogador :".. #playerShipsPositions .."/" .. totalShips .. "\nCampo do Jogador: ")
  showBattlefield(playerBattlefield)
  print("Vidas do NPC : ".. #npcShipsPositions .."/" .. totalShips .. "\nCampo do Jogador: ")
  showBattlefield(npcBattlefield)
  print()

  if #playerShipsPositions == 0 then
    print("Você perdeu.")
    break
  end

  if #npcShipsPositions == 0 then
    print("Você venceu Parabéns!!")
    break
  end

  print("Aperter enter para continuar.")
  io.read()
  os.execute("clear")
end
