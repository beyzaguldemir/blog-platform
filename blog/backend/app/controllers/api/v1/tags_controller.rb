module Api
  module V1
    class TagsController < ApplicationController
      include Authenticable
      before_action :set_tag, only: [:show, :update, :destroy]
      before_action :require_admin, only: [:create, :update, :destroy]
      skip_before_action :authorize_request, only: [:index, :show]

      def index
        @tags = Tag.all
        render json: @tags, status: :ok
      end

      def show
        render json: @tag.as_json(include: { posts: { only: [:id, :title, :published] } }), status: :ok
      end

      def create
        @tag = Tag.new(tag_params)
        
        if @tag.save
          render json: @tag, status: :created
        else
          render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @tag.update(tag_params)
          render json: @tag, status: :ok
        else
          render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @tag.destroy
        render json: { message: 'Tag deleted successfully' }, status: :ok
      end

      private

      def set_tag
        @tag = Tag.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Tag not found' }, status: :not_found
      end

      def tag_params
        params.permit(:name)
      end
    end
  end
end

