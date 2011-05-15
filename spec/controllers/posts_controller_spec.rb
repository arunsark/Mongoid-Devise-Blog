
require 'spec_helper'

describe PostsController do
  #render_views
  describe "access controls" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(new_user_session_path)
    end
    it "should deny access to 'update'" do
      post :update, :id => "foo-post"
      response.should redirect_to(new_user_session_path)
    end
    it "should deny access to 'delete'" do
      post :destroy, :id => "foo-post"
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "POST :create" do

    let(:article) { mock_model(Post).as_null_object }
    before(:each) do
      @user = sign_in(Factory(:user1))
      # @post = Factory(:post)
      @attr = { :title => "Foo Post", :content => "Bar Content" }
      Post.stub(:new).and_return(article)
    end

    context "#success" do
      before (:each) do
        article.stub(:save_post?).and_return(true)
      end

      it "should show flash[:notice] of success" do
        post :create, :post => @attr
        flash[:notice].should =~ /post was successfully created./i
      end

      it "should redirect to POST show" do
        #.with(:post => {:title => @attr.title, :content =>
        # @attr.content}).and_return(article)
        post :create, :post => @attr
        response.should redirect_to(post_path(article))
      end

      it "should create a new Post" do
        Post.should_receive(:new).and_return(article)
        post :create, :post => @attr
      end
    end

    context "#failure" do
      before (:each) do
        article.stub(:save_post?).and_return(false)
      end
      it "should redirect to the new page" do
        post :create, :post => @attr
        flash[:alert].should =~ /slug cannot be created/i
        response.should render_template('new')
      end
    end
  end
end
