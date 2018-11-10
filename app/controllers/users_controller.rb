class UsersController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user, except: [:show, :index, :create]
  before_action :set_user, only: [:show, :update]
  before_action :authorize, only: [:update]
  skip_authorize_resource only: :create

  # Should work if the current_user is authenticated.
  def index
    render json: serialize!(User.all, {}, "User")
  end

  def show
    render json: serialize!(@user)
  end

  # Method to create a new user using the safe params we setup.
  def create
    user = User.new(user_params)
    if user.save
      # Append JWT token to response headers
      response.set_header("JWT", client_token(user).token)
      render json: serialize!(user), status: :created
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  # Method to update a specific user. User will need to be authorized.
  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update(user_params)
      render json: serialize!(@user)
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # Method to delete a user, this method is only for admin accounts.
  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: {status: 200, msg: "User has been deleted."}
    end
  end

  # Call this method to check if the user is logged-in.
  # If the user is logged-in we will return the user's information.
  def current
    current_user.update!(last_login: Time.now)
    json_string = serialize! current_user
    render json: json_string
  end

  private

  # Setting up strict parameters for when we add account creation.
  def user_params
    params.require(:user).permit(:name, :lastname, :dni, :username, :email, :password, :password_confirmation)
  end

  def set_user
    if params[:self] == true
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  # Adding a method to check if current_user can update itself.
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_update_user?(params[:id])
  end

  # Generate a token for new user
  def client_token(user)
    Knock::AuthToken.new payload: {sub: user.id}
  end
end
