class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :content, presence: true
end
