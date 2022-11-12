class RecipeFacade
  def self.search(country)
    results = RecipeService.find_recipes(country)
    results[:hits].map do |recipe|
      Recipes.new(recipe, country)
    end
  end

end