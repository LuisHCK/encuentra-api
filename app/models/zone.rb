class Zone < ApplicationRecord
  belongs_to :city

  validates_presence_of :name, :latitude, :longitude
end
