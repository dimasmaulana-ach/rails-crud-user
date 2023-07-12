class Api::V1::AuthController < ApplicationController
  include BCrypt

  # Not Works
  def login
      @user = User.find_by_email(params[:email])
      puts @user.password
      if @user && @user.authenticate(params[:password])
        # session[:user_id] = user.id
        render json: {user: @user, message: "loggin success"}
      else
        render json: { message: "login failed", data: @user }
      end
  end

  private
  def authenticate(password)
    BCrypt::Password.create(password)
  end

end
