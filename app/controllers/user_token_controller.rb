class UserTokenController < Knock::AuthTokenController
  include Rails.application.routes.url_helpers
  skip_before_action :verify_authenticity_token

  def create
    render json: {
             jwt: auth_token,
             user: serialize_user,
           }, status: :created
  end

  private

  def serialize_user
    user = {}
    user["name"] = entity.name
    user["lastname"] = entity.lastname
    user["email"] = entity.email
    user["roles"] = entity.roles
    user["dni"] = entity.dni
    if entity.avatar.attached?
      variant = entity.avatar.variant(resize: "118x110")
      user["avatar"] = Rails.application.default_url_options[:host] + rails_representation_url(variant, only_path: true)      
    else
      user["avatar"] = ""
    end
    return user
  end
end
