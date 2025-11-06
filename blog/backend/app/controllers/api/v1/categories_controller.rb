module Api
  module V1
    class CategoriesController < ApplicationController
      include Authenticable
      before_action :set_category, only: [:show, :update, :destroy]
      before_action :require_admin, only: [:create, :update, :destroy]
      skip_before_action :authorize_request, only: [:index, :show]

      def index
        @categories = Category.all
        render json: @categories, status: :ok
      end

      def show
        render json: @category.as_json(include: { posts: { only: [:id, :title, :published] } }), status: :ok
      end

      def create
        @category = Category.new(category_params)
        
        if @category.save
          render json: @category, status: :created
        else
          render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category, status: :ok
        else
          render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
        render json: { message: 'Category deleted successfully' }, status: :ok
      end

      private

      def set_category
        @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Category not found' }, status: :not_found
      end

      def category_params
        params.permit(:name, :description)
      end
    end
  end
end

