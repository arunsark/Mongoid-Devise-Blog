class CommentsController < ApplicationController

  def create
    begin
      @post = Post.find_by_slug(params[:post_id])
      @comment = @post.comments.new(params[:comment])

      begin
        @comment.save!
        logger.debug "Comment created successfully"
        redirect_to @post, :notice => "Thanks for the comment"
      rescue Exception => e
        flash[:alert] = "Please fill in all the data"
        logger.debug "Comment creation error #{e.inspect}"
        render 'posts/show'
      end
    end  
  end

  def new
  end

end
