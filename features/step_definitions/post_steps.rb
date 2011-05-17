
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

Then /^I should see the updated title in the page$/ do
  page.should have_content(@title)
end


Given /^I have post "([^"]*)" authored by "([^"]*)"$/ do |title,author_name|
  @title = title
  @post = Post.new(:title => title, :content => "Something goes here")
  @user = find_user_by_name(author_name)
  @post.users << @user
  @post.save!
end

When /^I visit Update Post Page$/ do  
  visit edit_post_url(@post)# express the regexp above with the code you wish you had
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

Then /^I should see post in the index page$/ do
  visit posts_path
  page.should have_content(@title)
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

def find_user_by_name(name)
  user = User.where(nick_name:"#{name}").first
  unless user
    puts "create suresh"
    role = "author"
    Given %{I am a user with role "#{role}" and name "#{name}"}
    user = User.where(nick_name:"#{name}").first
  end
  user
end
