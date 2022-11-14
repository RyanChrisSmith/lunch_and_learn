class TouristSightSerializer
  include JSONAPI::Serializer

  set_id :id do
    'null'
  end
  attributes :name, :address, :place_id
end
