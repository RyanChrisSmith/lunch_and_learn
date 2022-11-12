class Recipes 
  attr_reader :title,
              :url,
              :image,
              :country

  def initialize(recipe, country)
    @title = recipe[:recipe][:label]
    @url = recipe[:recipe][:url]
    @image = recipe[:recipe][:image]
    @country = country
  end

end