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

for xI = 1, #matrix do
  for yI = 1, #matrix[xI] do
    io.write(matrix[xI][yI] .. " ")
  end
  print()
end
