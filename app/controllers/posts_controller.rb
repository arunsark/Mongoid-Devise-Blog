class PostsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:new,:create,:destroy,:update]
  
  # load_and_authorize_resource :only=>[:new,:create,:destroy,:update]
  # GET /posts
  # GET /posts.xml
  def index
    # @posts = Post.paginate :page => params[:page]
    @posts = Post.paginate :page => params[:page], :per_page => 2

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find_by_slug(params[:id])
    @comment = Comment.new
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
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    authorize! :create, @post
    unless params[:author].blank?
      @post.users << User.find(params[:author])
    end
    logger.debug "Going to save #{Rails.logger.level} #{@post.title.inspect} #{params[:post]}"
    respond_to do |format|
      if @post.save_post?
        logger.debug "Saved successfully #{@post.title.inspect}"
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
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
    authorize! :update, @post
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
    authorize! :destroy, @post
    @post.destroy
   
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def find
    @posts = Post.where({:month=>params[:month],:year=>params[:year]})
    puts @posts.size
    respond_to do |format|
      format.html {}
      format.js { render :layout => false }
    end
  end
end
 
