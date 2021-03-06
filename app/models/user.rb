class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :posts

  field :first_name
  field :last_name
  field :nick_name
  field :role, :default => "reader"

  ROLES = %w[reader author admin]

  validates_presence_of :first_name, :last_name, :nick_name, :role

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
