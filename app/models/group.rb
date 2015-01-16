class Group < ActiveRecord::Base
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :messages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
end
