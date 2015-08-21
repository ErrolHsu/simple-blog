class User < ActiveRecord::Base

	before_save { self.email.downcase! }

	validates :name, presence: {message: "不能為空"}, length: { maximum: 20, message: "請勿超過20個字元" } 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: {message: "不能為空"}, length: { maximum: 50 },
										format: { with: VALID_EMAIL_REGEX, message: "格式錯誤" },
										uniqueness: { case_sensitive: false, message: "已被使用" }
  has_secure_password 
  validates :password, length: { minimum: 6, message: "請超過6個字元" }, allow_blank: true	
  


end
