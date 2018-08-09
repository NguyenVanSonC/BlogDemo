class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {maximum: Settings.maxcontent}
  scope :by_userid, -> id {where user_id: id}
  scope :by_order, ->{order "microposts.created_at DESC"}
  delegate :name, to: :user, prefix: :user
end
