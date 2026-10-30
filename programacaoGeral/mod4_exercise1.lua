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
