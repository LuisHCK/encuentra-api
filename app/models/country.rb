class Country < ApplicationRecord
    
  # Fields validation
    validates_presence_of :name
    validates_presence_of :iso
    validates_presence_of :iso3
    validates_uniqueness_of :name
    validates_uniqueness_of :iso
    validates_uniqueness_of :iso3

end
