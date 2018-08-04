class CountriesSerializer
  include FastJsonapi::ObjectSerializer
  set_type :country
  set_id :id

  attributes :iso, :name, :numcode, :latitude, :longitude

  # cities will only be serialized if the record has any associated cities
  has_many :cities, if: Proc.new { |record| record.cities.any? }


end
