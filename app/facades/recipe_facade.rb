class RecipeFacade
  def self.search(country)
    results = RecipeService.find_recipes(country)
    find_recipes(results, country)
  end

  def self.random
    country = CountryService.random_country
    results = RecipeService.find_recipes(country)
    find_recipes(results, country)
  end

  private
  def self.find_recipes(results, country)
    results[:hits].map do |recipe|
      Recipes.new(recipe, country)
    end
  end
end