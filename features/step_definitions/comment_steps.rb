Given /^a blog post with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  @post = Post.create!(:title => title, :content => content)
end

When /^I visit the Blog Post$/ do
  visit post_path(@post)
end

When /^I fill up Author as "([^"]*)"$/ do |name|
  @author = name
  fill_in "Author", :with => name
end

When /^I fill up Email as "([^"]*)"$/ do |email|
  fill_in "Email", :with => email
end

When /^I fill up the Content as "([^"]*)"$/ do |content|
  @content = content
  fill_in "Content", :with => content
end

When /^I submit the Comment$/ do
  click_button "Create Comment"
end

Then /^I should see the Comment appearing in the Post$/ do
  page.should have_content(@author)
  page.should have_content(@content)
end

When /^I have a comment "([^"]*)"$/ do |comment|  
  When %{I visit the Blog Post}
  When %{I fill up Author as "Arun"}
  When %{I fill up Email as "#{Factory.next(:email)}"}
  When %{I fill up the Content as "#{comment}"}
  When %{I submit the Comment}
end

When /^I visit the Show Post Page$/ do
  visit post_path(@post)
end

Then /^I should see a Delete link for the comment$/ do
  page.should have_link("Delete Comment")
end

When /^I click the "([^"]*)" Link$/ do |link|
  click_link link
end

Then /^I should see the message "([^"]*)"$/ do |message|
  page.should have_content(message)
end

Then /^I should not see the Comment appearing in the Post$/ do
  page.should_not have_content(@content)
end
