require "babosa"

class User < ActiveRecord::Base
  extend FriendlyId

  store :settings, accessors: [:event_days, :article_days, :today]

  friendly_id :slug_candidates, use: [:slugged, :finders] 
	
  has_many :articles, dependent: :destroy
  has_many :todo_events
  has_many :tags

	attr_accessor :remember_token

	before_create :email_downcase
  after_create :set_blog_title

	validates :name, presence: {message: "Name 請勿空白"}, length: { maximum: 20, message: "Name 請勿超過20個字元" }
  validates :title, length: { maximum: 20, message: "Title 請勿超過20個字元" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: {message: "Email 請勿空白"}, length: { maximum: 50 },
										format: { with: VALID_EMAIL_REGEX, message: "Email 格式錯誤" },
										uniqueness: { case_sensitive: false, message: "Email 已被使用" }
  has_secure_password 
  validates :password, length: { minimum: 6, message: "密碼至少6字以上" }, allow_blank: true	
  
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
    input.to_s.to_slug.normalize.to_s
  end


  def special_days(date)
    find_article_days(date)
    find_event_days(date)       
    {article_days: @article_days.uniq, event_days: @event_days}
  end

  def find_article_days(date)
    @article_days = []
    now = Time.zone.now
    articles.where(created_at: (date.beginning_of_month)..date.end_of_month).published.each do |i|
      @article_days << i.created_at.day 
    end
  end

  def find_event_days(date)
    now = Time.zone.now
    @event_days = []
    if date.beginning_of_month == now.beginning_of_month
      todo_events.where(date: (now.beginning_of_day)..now.end_of_month).each do |i|
        @event_days << {day: i.date.day, event: i}
      end
    elsif date > now
      todo_events.where(date: (date.beginning_of_month)..date.end_of_month).each do |i|
        @event_days << {day: i.date.day, event: i} 
      end
    end        
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
