class ProductSerializer
  include JSONAPI::Serializer
  attributes :title, :published, :price
  belongs_to :user
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
