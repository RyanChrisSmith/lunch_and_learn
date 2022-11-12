class LearningResourceSerializer
  include JSONAPI::Serializer
  set_id :id do
    'null'
  end
  attributes :country, :video, :images
end
