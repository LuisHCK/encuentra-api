class CitySerializer < ActiveModel::Serializer
  attributes :id, :iso, :latitude, :longitude, :name, :country_id

  belongs_to :country
end
