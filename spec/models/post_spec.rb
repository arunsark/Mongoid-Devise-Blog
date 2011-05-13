
require 'spec_helper'

describe Post do

  before(:each) do
    @attr = {
      :title => "Foo Post",
      :content => "Bar Content"
    }
    @post = Post.new(@attr)
  end

  describe "create post" do
    it "should create a post with title and content" do
      @post.should be_valid
    end

    it "should not create a post without title" do
      @post.title = nil
      @post.should_not be_valid
    end

    it "should not create a post without content" do
      @post.content = nil
      @post.should_not be_valid
    end

    it "should not create a post with blank title" do
      @post.title = "  "
      @post.should_not be_valid
    end

    it "should embed many comments" do
      @post.should embed_many(:comments).with_dependent(:destroy)
    end

    it "should have one or many authors" do
      @post.should have_and_belong_to_many(:users)
    end
  end

  context "create post validations" do

    describe "#slug" do
      it "should be generated while saving" do
        @post.save!
        @post.slug.should_not be_nil
        @post.slug.should == "foo-post"
      end

      it "should truncate unwanted spaces and put - in slug" do
        @post.title = "Foo    Post"
        @post.save!
        @post.slug.should == "foo-post"
        @post.title.should == "Foo    Post"
      end

      it "should replace all special characters with -" do
        @post.title = "Foo+Post#Test"
        @post.save!
        @post.slug.should == "foo-post-test"
        @post.title.should == "Foo+Post#Test"
      end

      it "should replace all consecutive occurences of -'s to a single -" do
        @post.title = "Foo+-Post*#Test"
        @post.save!
        @post.slug.should == "foo-post-test"
        @post.title.should == "Foo+-Post*#Test"
      end

      it "should not accept duplicates while saving" do
        @post.save!
        post1 = Post.new(@attr.merge(:title=>"Foo+Post"))
        post1.safely.save.should raise_error
      end
    end

    describe "#tags" do
      it "should be nil if not given" do
        @post.tags.should be_nil
      end

      it "should have one element if input has one tag" do
        @post.post_tags = "Ruby"
        @post.save!
        @post.tags.should_not be_empty
        @post.tags.should include("Ruby")
        @post.tags.size.should == 1
      end

      it "should have n elements if input has n tags" do
        @post.post_tags = "Ruby,Rails,Sinatra,Merb"
        @post.save!
        @post.tags.should == ["Ruby","Rails","Sinatra","Merb"]
      end
    end

    describe "#title" do
      it "should not accept duplicates" do
        @post.save!
        post1 = Post.new(@attr)
        post1.should_not be_valid
      end
    end

    describe "#published_on" do
      it "should be a valid date time" do
        @post.save!
        @post.published_on.should_not be_nil
      end
    end
  end
end
