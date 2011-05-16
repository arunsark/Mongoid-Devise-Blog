require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  before(:each) do
    @admin = Factory(:user1)
    @author = Factory(:user2)
    @post_by_ananth = Factory(:post_with_author)          
  end

  context "Admin Role" do
    before(:each) do
      @ability = Ability.new(@admin)
    end

    it "should be able manage Posts" do
      @ability.should be_able_to(:manage,Post)
    end

    it "should be able to manage Comments" do
      @ability.should be_able_to(:manage,Comment)
    end

    it "should be able to destroy any Post" do
      @ability.should be_able_to(:destroy,@post_by_ananth)
    end

    it "should be able to destroy any Post" do
      @ability.should be_able_to(:update,@post_by_ananth)
    end
    
  end

  context "Author Role without any Posts" do
   before(:each) do
      @ability = Ability.new(@author)
    end

    it "should be able to create Posts" do
      @ability.should be_able_to(:create,Post)
    end

    it "should be able to update Posts" do
      @ability.should be_able_to(:update,Post)
    end

    it "should be able to destroy Posts" do
      @ability.should be_able_to(:destroy,Post)
    end

    it "should not be able to manage Comments" do
      @ability.should_not be_able_to(:manage,Comment)
    end

    it "should not be able to destroy Posts written by some other Author" do
      @ability.should_not be_able_to(:destroy,@post_by_ananth)
    end

    it "should not be able to update Posts written by some other Author" do
      @ability.should_not be_able_to(:update,@post_by_ananth)
    end
    
  end

  context "Author Role with a Post" do
    before(:each) do
      @ability = Ability.new(User.find(@post_by_ananth.user_ids[0]))
    end

    it "should be able to destroy Post written by himself" do
      @ability.should be_able_to(:destroy,@post_by_ananth)
    end

    it "should be able to update Post written by himself" do
      @ability.should be_able_to(:update,@post_by_ananth)
    end

  end
  

  context "Guest Role" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should be able to read Posts" do
      @ability.should be_able_to(:read,Post)
    end

    it "should be able to create comments" do
      @ability.should be_able_to(:create,Comment)
    end

    it "should not be able to update comment" do
      @ability.should_not be_able_to(:update,Comment)
    end

    it "should not be able to create Post" do
      @ability.should_not be_able_to(:create,Post)
    end

  end
end
