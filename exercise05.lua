local matrix = {
  {".", ".", "."},
  {".", ".", "."},
  {".", ".", "."}
}

local player = {
  name = "Leonardo",
  x = 2,
  y = 2
}

matrix[player.x][player.y] = "P"

local function printMatrix(m)
  for xI = 1, #m do
    for yI = 1, #m[xI] do
      io.write(m[xI][yI] .. " ")
    end
    print()
  end
end

printMatrix(matrix)

print("Insert Player position (x y): ")
matrix[player.x][player.y] = "."
local x, y = io.read("*n", "*n")
player.x = x
player.y = y
matrix[player.x][player.y] = "P"

print("New map: ")
printMatrix(matrix)
