require 'spec_helper'

describe Comment do
  before (:each) do
    @post = Factory(:post)
    @attr = {:author=>"Ananth",
      :email=>"ananth@gmail.com",
      :url=>"www.ananth.com",
      :content=>"Lorem Ipsum Tatum Batum"}
      @comment = @post.comments.new(@attr)
  end

  describe "Comment" do
    it "should be valid with valid attributes" do
      @comment.should be_valid
    end

    it "should be invalid without author" do
      @comment.author = nil
      @comment.should_not be_valid
    end

    it "should be invalid without email" do
      @comment.email = nil
      @comment.should_not be_valid
    end
    it "should be invalid without content" do
      @comment.content = nil
      @comment.should_not be_valid
    end
    it "should be valid without url" do
      @comment.url = nil
      @comment.should be_valid
    end
    it "should be embedded in Post" do
      @comment.should be_embedded_in(:post).as_inverse_of(:comments)
    end
  end

  describe "Comment Validations" do
    it "should have published date" do
      @comment.save!
      @comment.published_on.strftime('%Y%m%d').should == Date.today.strftime('%Y%m%d')
    end
  end

  describe "Comment Deletion" do
    it "should destroy the comment" do
      @post.comments.size.should == 1
      lambda do
        @comment.destroy
      end.should change(@post.comments,:size)
    end
  end
  
end
