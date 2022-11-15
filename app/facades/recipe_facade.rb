class RecipeFacade
  def self.search(country)
    results = RecipeService.find_recipes(country)
    collect_recipes(results, country)
  end

  def self.random
    country = CountryService.random_country
    search(country)
  end

  def self.collect_recipes(results, country)
    results[:hits].map do |recipe|
      Recipe.new(recipe, country)
    end
  end
end
