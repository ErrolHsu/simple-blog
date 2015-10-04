require "babosa"

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders] 
	
  has_many :articles, dependent: :destroy
  has_many :tags

	attr_accessor :remember_token

	before_create :email_downcase
  after_create :set_blog_title

	validates :name, presence: {message: "不能為空"}, length: { maximum: 20, message: "請勿超過20個字元" }
  validates :title, length: { maximum: 20, message: "請勿超過20個字元" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: {message: "不能為空"}, length: { maximum: 50 },
										format: { with: VALID_EMAIL_REGEX, message: "格式錯誤" },
										uniqueness: { case_sensitive: false, message: "已被使用" }
  has_secure_password 
  validates :password, length: { minimum: 6, message: "請超過6個字元" }, allow_blank: true	
  
  class << self 
    
    def new_token
    	SecureRandom.urlsafe_base64
    end

    def digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
												    												BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)												    												
    end

  end
  
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
  	return false if remember_digest.nil?
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def slug_candidates
    [
      :name
    ]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end


  private

    def set_blog_title
      self.title = "#{self.name}'s Blog"
      self.save
    end

    def email_downcase
      self.email = email.downcase
    end


end
