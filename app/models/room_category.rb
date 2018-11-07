class RoomCategory < ApplicationRecord
  belongs_to :category
  belongs_to :room
end
