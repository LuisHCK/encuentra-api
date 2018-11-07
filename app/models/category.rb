class Category < ApplicationRecord
  has_one_attached :image

  validates_presence_of [:name, :code]

  has_and_belongs_to_many :rooms
end
