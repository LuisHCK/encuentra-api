class ZoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude

  belongs_to :city
end
