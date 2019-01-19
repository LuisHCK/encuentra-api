class RoomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id,
             :title,
             :description,
             :price,
             :lat,
             :lng,
             :state,
             :created_at,
             :updated_at,
             :address,
             :currency,
             :city,
             :services,
             :phones,
             :promoted,
             :photos

  belongs_to :user
  belongs_to :zone
  belongs_to :category
  has_many :meetings
end
