class Auth::FacebookController < ApplicationController
  skip_before_action :authenticate_user, raise: false
  before_action :authenticate

  require "securerandom"
  require "net/http"
  require "open-uri"

  def create
    render json: auth_token, status: :created
  end

  def authenticate
    begin
      if data = get_facebook_user(auth_params[:access_token])
        if @user = User.find_by(fb_uid: data["id"])
          # Update avatar on Login
          attach_avatar_url(@user, data["picture"]["data"]["url"])
          @user.save
          # Render user Info
          serialized_token @user
        else
          # Set default data
          defaults = set_defaults data

          @user = User.new(
            fb_uid: data["id"],
            name: data["first_name"],
            lastname: data["last_name"],
            email: defaults[:email],
            username: defaults[:username],
            password: defaults[:password],
            password_confirmation: defaults[:password],
          )
          # Set Facebook Profile pic
          attach_avatar_url(@user, data["picture"]["data"]["url"])

          if @user.save
            serialized_token @user
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

  def serialized_token(user)
    render json: {
      jwt: user_token(user),
      user: UserSerializer.new(user).as_json
    }, status: :created
  end

  def attach_avatar_url(user, url)
    file = open(url)
    user.avatar.attach(
      io: file,
      filename: "#{@user.username}.jpg",
      content_type: "image/jpg",
    )
  end

  def set_defaults(data)
    username = SecureRandom.base64(8)
    password = SecureRandom.hex(10)
    
    # Set email or default email
    email = nil
    if not data['email']
      email = "#{username}@encontracuarto.com"
    else
      email = data['email']
    end

    return {
      username: username,
      password: password,
      email: email,
    }
  end

  # Generate a token for new user
  def user_token(user)
    Knock::AuthToken.new payload: {sub: user.id}
  end

  def get_facebook_user(access_token)
    url =
      "https://graph.facebook.com/v3.3/me?fields=id%2Cname%2Cfirst_name%2Clast_name%2Cemail%2Cpicture.height(300)&access_token=#{access_token}"

    response = HTTParty.get(url)

    return response.parsed_response
  end

  def auth_params
    params.require(:auth).permit(:access_token)
  end
end
