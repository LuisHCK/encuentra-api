class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :email, :dni, :name, :lastname, :avatar_url

  def avatar_url
    if object.avatar.attached?
    # .processed.service_url
      variant = object.avatar.variant(resize: "118x110")
      return Rails.application.default_url_options[:host] + rails_representation_url(variant, only_path: true)
    end
  end
end
