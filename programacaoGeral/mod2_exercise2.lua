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

end

function getAvailableRecipes(ingredients)
end

function main()
  setupCraftsByIngredient()

  getRecAipesByIngredientName("wood")
  --getAvailableRecipes({
  --  { name = 'wood', count = 5 },
  --  { name = 'nail', count = 4 },
  --  { name = 'paint', count = 30 },
  --})
end

main()
