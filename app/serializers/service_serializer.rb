class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :icon
  belongs_to :room
end
