class CommentsController < ApplicationController

  def create
    begin
      @post = Post.find_by_slug(params[:post_id])
      @comment = @post.comments.new(params[:comment])
      @comment.save!
      redirect_to @post, :notice => "Thanks for the comment"
    rescue Exception => e
      logger.debug "Comment creation error #{e.inspect}"
      flash[:alert] = "Please fill in all the data"
      render 'posts/show'
    end  
  end

  def new
  end

end
