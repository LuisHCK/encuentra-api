class UserTokenController < Knock::AuthTokenController
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
      user["avatar"] = rails_blob_path(entity.avatar)
    else
      user["avatar"] = ""
    end
    return user
  end
end
