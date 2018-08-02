class Auth::FacebookController < ApplicationController
  skip_before_action :authenticate_user, raise: false
  before_action :authenticate

  require "securerandom"
  require "net/http"

  def create
    render json: auth_token, status: :created
  end

  def authenticate
    begin
      if data = get_facebook_user(auth_params[:access_token])
        if @user = User.find_by(fb_uid: data["id"])
          # Update avatar on Login
          @user.remote_avatar_url = data["picture"]["data"]["url"]
          @user.save
          # Render user Info
          render json: {jwt: user_token(@user).token}, status: :created
        else
          @user = User.new(
            fb_uid: data["id"],
            name: data["first_name"],
            lastname: data["last_name"],
            email: data["email"],
            username: SecureRandom.hex(10),
            password: SecureRandom.base64(10),
          )
          # Set Facebook Profile pic
          @user.remote_avatar_url = data["picture"]["data"]["url"]

          if @user.save
            render json: {jwt: user_token(@user).token}, status: :created
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      else
        render json: {message: "Usuario no encontrado"}, status: :unprocessable_entity
      end
    rescue => exception
      puts(exception)
      render json: {message: exception.message}, status: :unprocessable_entity
    end
  end

  private

  # Generate a token for new user
  def user_token(user)
    Knock::AuthToken.new payload: {sub: user.id}
  end

  def get_facebook_user(access_token)
    url =
      "https://graph.facebook.com/v3.1/me?fields=id%2Cname%2Cfirst_name%2Clast_name%2Cemail%2Cpicture.height(300)&access_token=#{access_token}"

    response = HTTParty.get(url)

    return response.parsed_response
  end

  def auth_params
    params.require(:auth).permit(:access_token)
  end
end
