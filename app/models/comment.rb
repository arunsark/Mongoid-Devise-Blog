class Comment
  include Mongoid::Document
  field :author
  field :email 
  field :url
  field :content
  field :published_on, :type => DateTime

  validates_presence_of :author, :email, :content

  before_save :set_published_on

  embedded_in :post, :inverse_of => :comments

  private
  def set_published_on
    self.published_on = DateTime.now
  end
end
