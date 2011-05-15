require 'spec_helper'


describe CommentsController do

  let (:comment) { mock_model(Comment).as_null_object }
  before(:each) do
    @post = Factory(:post)
    @attr = { :author => "Arun", :email => "arun@gmail.com", :content => "Excellent Post!"}
    Post.stub(:find_by_slug).with("foo-post").and_return(@post)
    @post.comments.stub(:new).and_return(comment)
  end

  context "#success" do
    before(:each) do
      comment.stub(:save!)
    end

    it "should create a comment" do
      comment.should_receive(:save!)
      post :create , :post_id=>@post.slug,:comment=> @attr
      flash[:notice].should =~ /thanks for the comment/i
      response.should redirect_to(post_path(@post))
    end
  end

 context "#failure" do
    before(:each) do
      comment.stub(:save!).and_raise
    end

    it "should not create a comment" do
      comment.should_receive(:save!).and_raise
      post :create , :post_id=>@post.slug,:comment=> @attr
      flash[:alert].should =~ /please fill in all the data/i
      response.should render_template('posts/show')
    end
  end
end
