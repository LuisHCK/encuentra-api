class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :iso3, :iso, :numcode, :latitude, :longitude
  has_many :cities
end
