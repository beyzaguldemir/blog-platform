module Api
  module V1
    class UsersController < ApplicationController
      include Authenticable
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :require_admin, only: [:index, :destroy]

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def show
        render json: @user, status: :ok
      end

      def update
        if @user.id == current_user.id || current_user.role == 'admin'
          if @user.update(user_update_params)
            render json: @user, status: :ok
          else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: 'Unauthorized' }, status: :forbidden
        end
      end

      def destroy
        @user.destroy
        render json: { message: 'User deleted successfully' }, status: :ok
      end

      def me
        render json: current_user, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def user_update_params
        params.permit(:name, :email, :password, :password_confirmation, :role)
      end
    end
  end
end

