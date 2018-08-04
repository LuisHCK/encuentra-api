class CitiesSerializer
  include FastJsonapi::ObjectSerializer
  set_type :city
  set_id :id
  attributes :id, :name
end
