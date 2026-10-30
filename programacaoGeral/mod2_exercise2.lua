local craftRecipes = {
  {
    name = 'chair',
    ingredients = {
      { name = 'wood', count = 4 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'table',
    ingredients = {
      { name = 'wood', count = 8 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'halloween costume',
    ingredients = {
      { name = 'pumpkin', count = 1 },
      { name = 'cloth', count = 8 },
    },
  },
  {
    name = 'stone axe',
    ingredients = {
      { name = 'wood', count = 2 },
      { name = 'stone', count = 2 },
    },
  },
}

local craftsByIngredient = {}

function setupCraftsByIngredient()
  for _, item in ipairs(craftRecipes) do
    for _, ingredient in ipairs(item.ingredients) do
      if not craftsByIngredient[ingredient.name] then
        craftsByIngredient[ingredient.name] = {}
      end
      table.insert(craftsByIngredient[ingredient.name], item)
    end
  end
end

function getRecipes()
  return craftRecipes
end

function getRecipesByIngredientName(name)
  local Valor_Desejado = craftsByIngredient[name]
  local Valor_De_Seguranca = {}
  return Valor_Desejado or Valor_De_Seguranca
end

function getAvailableRecipes(ingredients)
  local availableRecipes = {}
  local checkedRecipes = {}

  local playerInventory = {}
  for _, item in ipairs(ingredients) do
    playerInventory[item.name] = item.count
  end

  for _, item in ipairs(ingredients) do
    local recipesList = getRecipesByIngredientName(item.name)

    for _, recipe in ipairs(recipesList) do
      if not checkedRecipes[recipe.name] then
        checkedRecipes[recipe.name] = true
        local canCraft = true

        for _, req in ipairs(recipe.ingredients) do
          local playerHasCount = playerInventory[req.name] or 0
          if playerHasCount < req.count then
            canCraft = false
          end
        end

        if canCraft then
          table.insert(availableRecipes, recipe)
        end
      end
    end
  end

  return availableRecipes
end

function main()
  setupCraftsByIngredient()

  local playerInventory = {
    { name = 'wood', count = 5 },
    { name = 'nail', count = 4 },
    { name = 'paint', count = 1 },
    { name = 'stone', count = 2 }
  }

  local recipes = getAvailableRecipes(playerInventory)

  print("\nRecipes Found:")
  if #recipes == 0 then
    print("No recipes available with these items.")
  else
    for _, recipe in ipairs(recipes) do
      print("You can craft: " .. recipe.name)
    end
  end
end

main()
