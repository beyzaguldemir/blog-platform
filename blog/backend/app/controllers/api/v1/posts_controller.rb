module Api
  module V1
    class PostsController < ApplicationController
      include Authenticable
      before_action :set_post, only: [:show, :update, :destroy]
      skip_before_action :authorize_request, only: [:index, :show]

      def index
        @posts = params[:published] == 'true' ? Post.published : Post.all
        @posts = @posts.includes(:user, :category, :tags)
        
        render json: @posts.as_json(
          include: {
            user: { only: [:id, :name, :email] },
            category: { only: [:id, :name] },
            tags: { only: [:id, :name] }
          }
        ), status: :ok
      end

      def show
        render json: @post.as_json(
          include: {
            user: { only: [:id, :name, :email] },
            category: { only: [:id, :name] },
            tags: { only: [:id, :name] }
          }
        ), status: :ok
      end

      def create
        @post = current_user.posts.new(post_params)
        
        if @post.save
          # Add tags if provided
          if params[:tag_ids].present?
            @post.tag_ids = params[:tag_ids]
          end
          
          render json: @post.as_json(
            include: {
              user: { only: [:id, :name, :email] },
              category: { only: [:id, :name] },
              tags: { only: [:id, :name] }
            }
          ), status: :created
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.user_id == current_user.id || current_user.role == 'admin'
          if @post.update(post_params)
            # Update tags if provided
            if params[:tag_ids].present?
              @post.tag_ids = params[:tag_ids]
            end
            
            render json: @post.as_json(
              include: {
                user: { only: [:id, :name, :email] },
                category: { only: [:id, :name] },
                tags: { only: [:id, :name] }
              }
            ), status: :ok
          else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: 'Unauthorized' }, status: :forbidden
        end
      end

      def destroy
        if @post.user_id == current_user.id || current_user.role == 'admin'
          @post.destroy
          render json: { message: 'Post deleted successfully' }, status: :ok
        else
          render json: { errors: 'Unauthorized' }, status: :forbidden
        end
      end

      private

      def set_post
        @post = Post.includes(:user, :category, :tags).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Post not found' }, status: :not_found
      end

      def post_params
        params.permit(:title, :content, :category_id, :published)
      end
    end
  end
end

