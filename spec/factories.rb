
Factory.define :user1, :class=>User do |user|
  user.first_name "Arun"
  user.last_name "Vydianathan"
  user.nick_name "Arun"
  user.email "arun.vydianathan@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.define :user2, :class=>User do |user|
  user.first_name "Suresh"
  user.last_name "Rajamoney"
  user.nick_name "Suresh"
  user.email "protoiyer@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.define :post do |post|
  post.title "Foo Post"
  post.content "Bar content"
end



