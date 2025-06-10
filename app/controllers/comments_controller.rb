class CommentsController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        @comment = current_user.comments.new(comment_params)
        @comment.post_id = post.id
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to post_path(post)
        else
            @post = Post.find(params[:post_id])
            @comments = @post.comments.page(params[:page]).per(7)
            render "posts/show", status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        redirect_to post_path(comment.post)
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
    
end
