require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory(:user1)
    @author = Factory(:user2)
  end

  it "should not be valid without first name" do
    @user.first_name = nil
    @user.should_not be_valid
  end

  it "should not be valid without last name" do
    @user.last_name = nil
    @user.should_not be_valid
  end

  it "should not be valid without middle name" do
    @user.nick_name = nil
    @user.should_not be_valid
  end

  it "should be able to access posts" do
    @user.should respond_to(:posts)
    @user.should have_and_belong_to_many(:posts)
  end

  it "should not be valid without a role" do
    @user.role = nil
    @user.should_not be_valid
  end

  it "should have a role of author if his base role is admin" do
    @user.role?(:admin).should be_true
    @user.role?(:author).should be_true
  end

  it "should not have a role of admin if his base role is author" do
    @author.role?(:author).should be_true
    @author.role?(:admin).should be_false
  end
end
