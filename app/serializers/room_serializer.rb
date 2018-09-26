class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :price, :lat, :lng, :state
end
