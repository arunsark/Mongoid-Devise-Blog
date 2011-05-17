class CommentsController < ApplicationController
  authorize_resource :only=>[:destroy,:update]
  def create
    begin
      puts params[:post_id]
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

  def destroy
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    logger.debug "Comment to be deleted is #{@comment._id}"
    flash[:notice] = "Comment deleted."
    redirect_to post_path(@post)
  end

  def update
  end
end
