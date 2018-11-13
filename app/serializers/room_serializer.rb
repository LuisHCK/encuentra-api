class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :lat, :lng, :state, :created_at, :updated_at, :address, :currency

  belongs_to :user
  belongs_to :zone
  belongs_to :category
  has_many :services
  has_many :meetings
end
