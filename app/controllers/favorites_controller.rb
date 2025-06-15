class FavoritesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.new(post_id: @post.id)
        favorite.save
        respond_to do |format|
            format.turbo_stream
            format.html { redirect_to post_path(@post) }
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.find_by(post_id: @post.id)
        favorite.destroy if favorite.present?
        respond_to do |format|
            format.turbo_stream
            format.html { redirect_to post_path(@post) }
        end
    end
end
