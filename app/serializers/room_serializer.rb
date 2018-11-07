class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :price, :lat, :lng, :state

  belongs_to :user
  belongs_to :zone

  has_many :categories
end
