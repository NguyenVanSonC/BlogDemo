class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :reply_comments, class_name: Comment.name, foreign_key: :reply_to, dependent: :destroy
  has_one :parent_comment, class_name: Comment.name, primary_key: :reply_to, foreign_key: :id

  scope :order_by_create, ->{order "comments.create_at DESC"}
  validates :content, presence: true, length: {maximum: Settings.maxcomment}
  delegate :name, to: :user, prefix: :user
end
