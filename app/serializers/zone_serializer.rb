class ZoneSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name,
             :city_id,
             :latitude,
             :longitude,
             :created_at,
             :updated_at
end
