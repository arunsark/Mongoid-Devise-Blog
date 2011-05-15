require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory(:user1)
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
end
