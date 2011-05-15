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

Then /^I should see my Comment appearing in the Post$/ do
  page.should have_content(@author)
  page.should have_content(@content)
end
