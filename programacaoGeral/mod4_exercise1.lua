math.randomseed(os.time())

function quickSort(values, begin, ends)
  if begin >= ends then
      return
  end

  local i = begin
  local j = ends
  local pivo = values[math.floor(begin + (ends - begin) / 2)]
  local aux = 0

  while i <= j do
      while i < ends and values[i] < pivo do
        i = i + 1
      end
      while j >= begin and values[j] > pivo do
        j = j - 1
      end
      if i <= j then
        aux = values[i]
        values[i] = values[j]
        values[j] = aux
        i = i + 1
        j = j - 1
      end
  end

  if begin < j then
    quickSort(values, begin, j)
  end
  if i < ends then
    quickSort(values, i, ends)
  end
end

function quickSortRandom(values, begin, ends)
  if begin >= ends then
    return
  end

  local i = begin
  local j = ends
  local pivo = values[math.random(begin, ends)]
  local aux = 0

  while i <= j do
    while i < ends and values[i] < pivo do
        i = i + 1
    end

    while j >= begin and values[j] > pivo do
        j = j - 1
    end

    if i <= j then
      aux = values[i]
        values[i] = values[j]
        values[j] = aux
        i = i + 1
        j = j - 1
    end
  end

  if begin < j then
    quickSortRandom(values, begin, j)
  end
  if i < ends then
    quickSortRandom(values, i, ends)
  end
end

function copyTable(t)
  local new_t = {}
  for i = 1, #t do new_t[i] = t[i] end
  return new_t
end

function gerarPiorCaso(n)
  local array = {}
  for i = 1, n do
    array[i] = i
    local mid = math.floor(1 + (i - 1) / 2)
    -- Coloca o maior elemento (i) exatamente na posição do meio
    array[i], array[mid] = array[mid], array[i]
  end
  return array
end

function main()
  --Exemplo para "n log n"
  --local array = {34, 7, 23, 32, 5, 62, 29, 12, 40, 8}
  --print("Array original: " .. table.concat(array, ", "))
  --quickSort(array, 1, #array)
  --print("Array ordenado: " .. table.concat(array, ", "))

  local n = 15000
  print("Gerando array adversário de " .. n .. " elementos...")
  local worstCaseArray = gerarPiorCaso(n)

  print("\nIniciando teste.")

  local arrayOriginal = copyTable(worstCaseArray)
  local startOriginal = os.clock()
  quickSort(arrayOriginal, 1, #arrayOriginal)
  local timeOriginal = os.clock() - startOriginal
  print(string.format("Tempo Original (O(n²)): %.4f segundos", timeOriginal))

  local arrayRandom = copyTable(worstCaseArray)
  local startRandom = os.clock()
  quickSortRandom(arrayRandom, 1, #arrayRandom)
  local timeRandom = os.clock() - startRandom
  print(string.format("Tempo Aleatório (O(n log n)): %.4f segundos", timeRandom))
end

main()
