class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: {maximum: Settings.maxcontent}
  scope :by_userid, -> id {where user_id: id}
  scope :by_order, ->{order "microposts.created_at DESC"}
  delegate :name, to: :user, prefix: :user
  validate  :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
