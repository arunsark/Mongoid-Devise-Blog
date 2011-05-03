class Comment
  include Mongoid::Document
  field :author
  field :email 
  field :url
  field :content
  field :published_on, :type => DateTime

  embedded_in :post, :inverse_of => :comments
end
