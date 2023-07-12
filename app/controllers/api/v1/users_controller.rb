module Api
  module V1
    class UsersController < ApplicationController
      include BCrypt

      def index
        begin
          @user = User.all.as_json(only: [:name, :email])
          render json: {status: 200 ,data: @user}
        rescue => e
          return "Error : #{e.message}"
        end
      end

      def create
        @user = User.new(user_params)
        @user.password = Password.create(params.require(:user).permit(:password_digest))
        if @user.save
          render json: {code: 200, message: "User has been created successfully" , data: @user}
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])
        if @user.destroy
          render message: "User has been destroyed"
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end


      private
       def user_params
        params.require(:user).permit(:name, :email)
       end
    end
  end
end
