class Post
  include Mongoid::Document
  include Mongoid::Slug

  attr_accessor :post_tags
  attr_accessible :title, :content, :post_tags
  field :title
  field :content
  field :slug
  field :published_on, :type => DateTime
  field :tags, :type => Array
  validates_presence_of :title, :content
  embeds_many :comments
  index :slug, unique:true

  validates_uniqueness_of :title, :case_sensitive => false
  before_save :set_published_on, :generate_slug, :generate_tags  
  slug :slug

  has_and_belongs_to_many :users

  #accepts_nested_attributes_for :comment

  def get_tags
    if self.tags
      self.tags.inject{|tag_string,tag| tag_string + ", " + tag}
    end
  end
  private
  def set_published_on
    self.published_on = DateTime.now
  end

  def generate_slug
    self.slug = self.title.downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
  end

  def generate_tags
    if post_tags
      self.tags = post_tags.split(/,/).collect{ |tag| tag.strip }
    end
  end
end
