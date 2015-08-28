class Article < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30, message: "請勿超過30個字元"}
  validates :content, presence: true
end
