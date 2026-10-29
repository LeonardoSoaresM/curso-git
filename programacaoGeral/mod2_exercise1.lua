function setupRootElement()
  local root = {}
  root.id = 'rootElement'
  root.visible = true
  root.color = 'red'
  root['background color'] = 'yellow'
  root.text = 'Main Window'
  root.children = {
    { id = 'child1', zOrder = 1, visible = true, parent = root },
    { id = 'child2', zOrder = 2, visible = true, parent = root },
    { id = 'child3', zOrder = 3, visible = false, clickVolume = 0.02, parent = root },
  }
  root.savedIndexes = { 4, 1, 3, 2, 5, total = 5 }
  root.layoutPositions = { 'top', 'left', 'bottom', 'right' }
  root.innerLengths = { x = 1, l = { x = 2, l = { x = 3, l = { x = 4, l = { x = 5, l = { x = 6 } } } } } }

  return root
end

function table.tostring(t, maxDepth, indent)
  indent = indent or "  "
  maxDepth = maxDepth or math.huge

  local visitedTables = {}
  local processTable

  local function formatValue(value, depth)
    if type(value) == "table" then
      return processTable(value, depth)
    elseif type(value) == "string" then
      return string.format("%q", value)
    else
      return tostring(value)
    end
  end

  local function formatKey(key)
    if type(key) == "string" then
      if key:match("^[%a_][%w_]*$") then
        return key
      else
        return "[" .. string.format("%q", key) .. "]"
      end
    else
      return "[" .. tostring(key) .. "]"
    end
  end

  processTable = function(currentTable, currentDepth)
    if visitedTables[currentTable] then
      return string.format("%q", tostring(currentTable))
    end

    if currentDepth > maxDepth then
      return string.format("%q", "{...}")
    end

    visitedTables[currentTable] = true

    local currentIndentStr = string.rep(indent, currentDepth)
    local nextIndentStr = string.rep(indent, currentDepth + 1)

    local lines = {}

    local arrayLength = 0
    for i, value in ipairs(currentTable) do
      arrayLength = i
      local valueStr = formatValue(value, currentDepth + 1)
      table.insert(lines, nextIndentStr .. valueStr)
    end

    for key, value in pairs(currentTable) do
      local isArrayElement = (type(key) == "number" and key >= 1 and key <= arrayLength and math.floor(key) == key)

      if not isArrayElement then
        local keyStr = formatKey(key)
        local valueStr = formatValue(value, currentDepth + 1)

        table.insert(lines, nextIndentStr .. keyStr .. " = " .. valueStr)
      end
    end

    if #lines == 0 then
      return "{}"
    end

    return "{\n" .. table.concat(lines, ",\n") .. "\n" .. currentIndentStr .. "}"
  end

  return processTable(t, 0)
end

function main()
  local rootElement = setupRootElement()
  local tableStr = table.tostring(rootElement, 3, '  ')

  print(tableStr)

  local createTable, syntaxError = loadstring("return " .. tableStr)

  if createTable then
    local loadedTable = createTable()
    print("\n[Success] The generated table has valid Lua syntax!")
    print("Access test -> background color: " .. tostring(loadedTable["background color"]))
  else
    print("\n[Syntax Error]: " .. tostring(syntaxError))
  end
end

main()
