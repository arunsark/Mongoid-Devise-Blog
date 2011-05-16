Given /^I am an "([^""]*)" with name "([^"]*)", email "([^"]*)" and password "([^"]*)"$/ do |role, name, email, password|
  @user = User.create!(:email => email,
               :password => password,
               :password_confirmation => password,
               :first_name => name,
               :last_name => name,
               :nick_name => name,
               :role => role)
end

Given /^I sign in as "(.*)\/(.*)"$/ do |email, password|  
  Given %{I go to the sign in page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

When /^I visit Create Post Page$/ do
  visit posts_path
  click_link 'New Post'  
end

When /^I fill up Title as "([^"]*)"$/ do |title|
  @title = title
  fill_in "Title", :with => title
end

When /^I fill up Content as "([^"]*)"$/ do |content|
  fill_in "Content", :with => content
end

When /^I publish the Post$/ do
  click_button "Create Post"
end

Then /^I should see post in the index page$/ do
  post = Post.find_by_slug(PostsHelper.generate_slug(@title))  
  page.should have_content(@title)
  page.should have_content("Comment")
end

Given /^I have post "([^"]*)" authored by me$/ do |title|
  @title = title
  @post = Post.new(:title => title, :content => "Something goes here")
  @post.users << @user
  @post.save!
end

When /^I visit Update Post Page$/ do
  visit edit_post_path(@post)# express the regexp above with the code you wish you had
end

When /^I fill up the Title as "([^"]*)"$/ do |title|
  @title = title
  fill_in "Title", :with => title
end

When /^I update the Post$/ do
  click_button "Update Post"
end

When /^I delete the post$/ do
  visit posts_path
  click_link "Destroy"
end

Then /^I should not see the post in the index page$/ do
  visit posts_path
  page.should_not have_content(@title)
end

Given /^I have post "([^"]*)" authored by "([^"]*)"$/ do |title, author|
  @user = Factory(:user2)
  @title = title
  @post = Post.new(:title => title, :content => "Something goes here")
  @post.users << @user
  @post.save!
end

When /^I visit Posts Page$/ do
  visit posts_path
end

Then /^I should see the post$/ do
  page.should have_content(@title)
end

Then /^I should not have the link to "([^"]*)" or "([^"]*)"$/ do |link1, link2|
  page.should_not have_link(link1)
  page.should_not have_link(link2)
end

Then /^I should have the link to "([^"]*)" or "([^"]*)"$/ do |link1, link2|
  page.should have_link(link1)
  page.should have_link(link2)
end

