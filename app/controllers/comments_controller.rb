class CommentsController < ApplicationController

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.create!(params[:comment])    
    redirect_to @post, :notice => "Thanks for the comment"
  end

  def new
  end

end
