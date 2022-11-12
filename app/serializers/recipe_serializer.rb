class RecipeSerializer
  include JSONAPI::Serializer

  set_id :id do
    'null'
  end

  attributes :title, :url, :country, :image
end
