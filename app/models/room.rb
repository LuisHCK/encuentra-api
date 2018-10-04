class Room < ApplicationRecord
  belongs_to :user
  belongs_to :zone

  has_many_attached :photos

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description
end
