Given /^I am a registered User with name "([^"]*)", email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  @user = User.create!(:email => email,
               :password => password,
               :password_confirmation => password,
               :first_name => name,
               :last_name => name,
               :nick_name => name)
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


Given /^I have not signed into the system$/ do
  
end

Then /^I should be taken to the sign in page$/ do
  page.should have_content("Sign in") 
end
