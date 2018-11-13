class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  belogns_to :user
end
