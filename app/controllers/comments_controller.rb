class CommentsController < ApplicationController
  authorize_resource :only=>[:destroy,:update]
  def create
    begin
      @post = get_post(params[:post_id])
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
    @post = get_post(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    logger.debug "Comment to be deleted is #{@comment._id}"
    flash[:notice] = "Comment deleted."
    redirect_to post_path(@post)
  end

  def update
    @post = get_post(params[:post_id])
    @comment = get_comment(@post,params[:id])
    @comment.update_attributes(params[:comment])
    logger.debug "Comment has be updated #{@comment._id}"
    flash[:notice] = "Comment updated."
    redirect_to post_path(@post)
  end

  def edit
    @post = get_post(params[:post_id])
    @comment = get_comment(@post,params[:id])
  end

  private
  def get_post(slug)
    Post.find_by_slug(slug)
  end

  def get_comment(post,comment_id)
    post.comments.find(comment_id)
  end
end
