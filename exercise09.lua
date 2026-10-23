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

local function createShipsNPC(npcShipsPositions, npcBattlefield, amount)
  for i = 1, amount do
    local row = math.random(1, #npcBattlefield)
    local col = math.random(1, #npcBattlefield[row])
    local position = npcBattlefield[row][col]
    table.insert(npcShipsPositions, position)
  end
end

playerBattlefield = createBattlefield(sizeBattlefield)
npcBattlefield = createBattlefield(sizeBattlefield)
table.insert(playerShipsPositions, "A1")
table.insert(playerShipsPositions, "A4")
createShipsNPC(npcShipsPositions, npcBattlefield, #playerShipsPositions)
print("Campo de batalha do jogador:")
showBattlefield(playerBattlefield)
print("Campo de batalha do inimigo:")
showBattlefield(npcBattlefield)
print("Posições dos navios do jogador:")
for i, position in ipairs(playerShipsPositions) do
  print(position)
end
print("Posições dos navios do inimigo:")
for i, position in ipairs(npcShipsPositions) do
  print(position)
end
