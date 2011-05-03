class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find_by_slug(params[:id])
    logger.debug "No. of comments for post #{@post.title} is #{@post.comments.size}"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by_slug(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    logger.debug "Going to save #{Rails.logger.level} #{@post.title.inspect}"
    respond_to do |format|      
      begin
        @post.safely.save!
          logger.debug "Saved successfully #{@post.title.inspect}"
          format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
          format.xml  { render :xml => @post, :status => :created, :location => @post }
      rescue Exception => e
          logger.debug "Could not save #{@post.title.inspect}"
          flash[:alert] = "Slug cannot be created"
          format.html { render 'new' }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    logger.debug "Going to update post #{params[:id]}"
    @post = Post.find_by_slug(params[:id])

    respond_to do |format|
      begin
        @post.update_attributes!(params[:post])
        logger.debug "Updated successfully #{@post.title.inspect}"
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      rescue Exception => e
        logger.debug "Update failed for #{@post.title.inspect} #{e.inspect}"
        flash[:alert] = "Slug not unique"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find_by_slug(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
