class Room < ApplicationRecord
  belongs_to :user
  belongs_to :zone

  has_many_attached :photos
end
