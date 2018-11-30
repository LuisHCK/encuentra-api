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
    UserSerializer.new(entity).as_json
  end
end
