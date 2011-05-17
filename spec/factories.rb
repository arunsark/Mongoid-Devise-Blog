
Factory.define :user1, :class=>User do |user|
  user.first_name "Arun"
  user.last_name "Vydianathan"
  user.nick_name "Arun"
  user.email "arun.vydianathan@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.role "admin"
end

Factory.define :user2, :class=>User do |user|
  user.first_name "Suresh"
  user.last_name "Rajamoney"
  user.nick_name "Suresh"
  user.email "protoiyer@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.role "author"
end

Factory.define :user3, :class=>User do |user|
  user.first_name "Ananth"
  user.last_name "Krishnan"
  user.nick_name "Ananth"
  user.email "ananth@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.role "author"
end

Factory.define :post do |post|
  post.title "Foo Post"
  post.content "Bar content"
end

Factory.define :post1, :class=>Post do |post|
  post.title "Foo Post1"
  post.content "Bar content1"
end

Factory.define :post_with_author, :parent => :post1 do |post|
  post.after_create { |p| Factory(:user3, :posts => [p]) }
end


#Factory.define :author_with_posts, :parent => :user3 do |user|
#  user.after_create { |u| Factory(:post1, :users => [u]) }
#end


Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
