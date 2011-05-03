class Post
  include Mongoid::Document
  include Mongoid::Slug
  
  field :title
  field :content
  field :slug
  field :published_on, :type => DateTime
  validates_presence_of :title, :content
  embeds_many :comments
  index :slug, unique:true

  validates_uniqueness_of :title, :case_sensitive => false

  before_save :set_published_on, :generate_slug

  slug :slug
  private
  def set_published_on
    self.published_on = DateTime.now
  end

  def generate_slug
    self.slug = self.title.downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    puts "Generated slug #{self.slug}"
  end
end
