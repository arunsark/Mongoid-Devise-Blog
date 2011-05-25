
require 'spec_helper'
require 'factories'
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
      lambda do
        @post.save_post?
      end.should change(Post, :count).by(1)
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
        @post.save_post?
        @post.slug.should_not be_nil
        @post.slug.should == "foo-post"
      end

      it "should truncate unwanted spaces and put - in slug" do
        @post.title = "Foo    Post"
        @post.save_post?
        @post.slug.should == "foo-post"
        @post.title.should == "Foo    Post"
      end

      it "should replace all special characters with -" do
        @post.title = "Foo+Post#Test"
        @post.save_post?
        @post.slug.should == "foo-post-test"
        @post.title.should == "Foo+Post#Test"
      end

      it "should replace all consecutive occurences of -'s to a single -" do
        @post.title = "Foo+-Post*#Test"
        @post.save_post?
        @post.slug.should == "foo-post-test"
        @post.title.should == "Foo+-Post*#Test"
      end

      it "should not accept duplicates while saving" do
        @post.save_post?
        post1 = Post.new(@attr.merge(:title=>"Foo+Post"))
        post1.save_post?.should be_false
      end
    end

    describe "#tags" do
      it "should be nil if not given" do
        @post.tags.should be_nil
      end

      it "should have one element if input has one tag" do
        @post.post_tags = "Ruby"
        @post.save_post?
        @post.tags.should_not be_empty
        @post.tags.should include("Ruby")
        @post.tags.size.should == 1
      end

      it "should have n elements if input has n tags" do
        @post.post_tags = "Ruby,Rails,Sinatra,Merb"
        @post.save_post?
        @post.tags.should == ["Ruby","Rails","Sinatra","Merb"]
      end

      it "should be retreived as comma separated string" do
        @post.post_tags = "Ruby,Rails,Sinatra,Merb"
        @post.save_post?
        post = Post.find_by_slug("foo-post")
        post.tags.should == %w(Ruby Rails Sinatra Merb) #["Ruby","Rails","Sinatra","Merb"]
        post.get_tags.should == "Ruby, Rails, Sinatra, Merb"
      end

      it "should be retrieved as nil if tags not present" do
        @post.save_post?
        post = Post.find_by_slug("foo-post")
        post.tags.should be_nil
        post.get_tags.should be_nil
      end
    end

    describe "#title" do
      it "should not accept duplicates" do
        @post.save_post?
        post1 = Post.new(@attr)
        post1.should_not be_valid
      end
    end

    describe "#published_on" do
      it "should be a valid date time" do
        @post.save_post?
        @post.published_on.should_not be_nil
        @post.published_on.strftime('%Y%m%d').should == Date.today.strftime('%Y%m%d')
      end
    end

    describe "#month and #year" do
      it "should have a valid month and year" do
        @post.save_post?
        @post.month.should_not be_nil
        @post.year.should_not be_nil
        @post.month.should == @post.published_on.strftime('%b')
        @post.year.should == @post.published_on.year()
      end
    end

    describe "#authors" do
      before(:each) do
        @arun = Factory(:user1)
        @suresh = Factory(:user2)
      end

      it "should be able to assoicate one author to a post" do
        @post.users << @arun
        @post.should be_valid
        @post.users = [@arun]
        @post.save_post?
        #not sure if factory girls works so well with mongoid
        #so query back and check the authors
        post = Post.find_by_slug("foo-post")
        post.users == [@arun]
      end

      it "should be able to assoicate more than author to a post" do
        @post.users << @arun
        @post.users << @suresh
        @post.should be_valid
        @post.users = [@arun,@suresh]
        @post.save_post?

        post = Post.find_by_slug("foo-post")
        post.users == [@arun,@suresh]
      end

      it "should be able to retrieve authors as comma separated string" do
        @post.users << @arun
        @post.users << @suresh
        @post.save_post?

        post = Post.find_by_slug("foo-post")
        post.authors.should == @arun.nick_name + ", " + @suresh.nick_name
      end

      it "should be None if no authors are present" do
        @post.save_post?
        post = Post.find_by_slug("foo-post")
        post.authors.should == "None"
      end

    end
  end

  describe "group by aggregation" do
    before(:each) do
      year = 2011
      month = 4
      day = 30
      30.times do
        generate_post_from_factory(year,month,day)
        day -= 1
      end
      day = 31
      month = 3
      31.times do
        generate_post_from_factory(year,month,day)
        day -= 1
      end
    end
    
    it "should aggregate posts by month and year" do
      post_aggs = Post.count_and_agg_by_month
      post_aggs.should_not be_nil
      post_aggs.size.should == 2
      post_aggs[0]["count"].truncate.should == 30
      post_aggs[0]["month"].should == "Apr"
      post_aggs[0]["year"].truncate.should == 2011
      post_aggs[1]["count"].truncate.should == 31
      post_aggs[1]["month"].should == "Mar"
      post_aggs[1]["year"].truncate.should == 2011
    end
  end


end
