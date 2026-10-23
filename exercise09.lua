local playerBattlefield = {}
local npcBattlefield = {}
local size = 10

local function createBattlefield(size)
  local battlefield = {}
    for i = 1, size do
      battlefield[i] = {}
      for j = 1, size do
        battlefield[i][j] = "."
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

playerBattlefield = createBattlefield(size)
npcBattlefield = createBattlefield(size)
print("Campo de batalha do jogador:")
showBattlefield(playerBattlefield)
print("Campo de batalha do inimigo:")
showBattlefield(npcBattlefield)
