class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :messages

  validates :name, presence: true, length: { maximum: 20 }
end
