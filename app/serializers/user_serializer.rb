class UserSerializer
  include FastJsonapi::ObjectSerializer
  # set_type :user
  attributes :id, :email, :username, :avatar, :dni, :created_at, :updated_at, :last_login, :name, :lastname

  attribute :avatar do |object|
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.avatar)
    else
      Rails.application.default_url_options[:host] + "/assets/default_user_icon.png"
    end
  end
end
