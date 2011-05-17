require 'spec_helper'


describe CommentsController do

  context "Create Comment" do
    let (:comment) { mock_model(Comment).as_null_object }
    before(:each) do
      @post = Factory(:post)
      @attr = { :author => "Arun", :email => "arun@gmail.com", :content => "Excellent Post!"}
      Post.stub(:find_by_slug).with(@post.slug).and_return(@post)
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

  describe "PUT destroy" do

    before(:each) do
      @post = Factory(:post)
      @attr = { :author => "Arun", :email => "arun@gmail.com", :content => "Excellent Post!"}
      @comment = @post.comments.new(@attr)
      @comment.save!
      puts "enter before each"
    end
    context "Admin" do
      before(:each) do
        @admin = sign_in(Factory(:user1))
      end

      it "should destroy any comment" do
        @post.comments.size.should == 1
        delete :destroy, :post_id => @post.slug, :id => @comment._id
        @comment = @post.comments.find(@comment._id)
        puts @comment._id
        response.should redirect_to(post_path(@post))
      end
    end
    context "Author" do
      before(:each) do
        @author = sign_in(Factory(:user2))
      end
      it "should not destroy any comment" do
        lambda do
          delete :destroy, :post_id => "foo-post", :id => @comment._id
        end.should_not change(@post.comments,:size)
      end
    end
  end

end
