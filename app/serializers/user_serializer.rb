class UserSerializer
  include FastJsonapi::ObjectSerializer
  # set_type :user
  attributes :id, :email, :username, :dni, :created_at, :updated_at, :last_login, :name, :lastname
end
