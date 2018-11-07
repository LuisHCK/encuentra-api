class CategorySerializer
  include FastJsonapi::ObjectSerializer
  set_type :city
  set_id :id
  attributes :id, :name, :code

  has_many :rooms
end
