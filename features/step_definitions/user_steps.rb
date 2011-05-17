Given /^I am an "([^"]*)" with name "([^"]*)", email "([^"]*)" and password "([^"]*)"$/ do |role,name,email,password|
  puts "create user"
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

Given /^I am logged in as a "([^"]*)" with name "([^"]*)"$/ do |role, name|
  Given %{I am a user with role "#{role}" and name "#{name}"}
  And %{I sign in as "#{@email}/#{@password}"}
end

Given /^I am a user with role "([^"]*)" and name "([^"]*)"$/ do |role,name|
  @email = Factory.next(:email)
  @password = "foobar"
  puts @email
  Given %{I am an "#{role}" with name "#{name}", email "#{@email}" and password "#{@password}"}
  puts "success"
end
