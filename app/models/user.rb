class User < ActiveRecord::Base
  has_many :animals
  has_many :events
  belongs_to :address
  accepts_nested_attributes_for :address
  validates :email, :first_name, :last_name, presence: true

  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(r)
    role.include? r.to_s
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  private
  def set_default_role
    self.role ||= 'user'
  end
end
