class ProductSerializer
  include JSONAPI::Serializer
  attributes :title, :published, :price
  belongs_to :user
end
