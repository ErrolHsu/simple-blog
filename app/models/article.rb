class Article < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where(state: 1) }
  scope :in_this_month, -> (month) { where(created_at: (month.beginning_of_month)..month.end_of_month) }
  scope :in_this_day, -> (day) { where(created_at: (day.beginning_of_day)..day.end_of_day) }

  validates :user_id, presence: true
  validates :title, presence: { message: "標題請勿空白"}, uniqueness: { message: "已有同名標題"}

  attr_accessor :tag_names

  before_save :set_article_slug!
  after_save :assign_tags

  def slug_candidates
    [
      :title
    ]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  class << self
    def mark_articles(date, active_day=nil)
      days = Time.days_in_month(date.month, date.year)
      begin_day = date.beginning_of_month
      end_day = date.end_of_month
      marked_days = []
      where(created_at: (begin_day)..end_day).published.each { |i| marked_days << i.created_at.day }  
      marked_days.uniq!

      ary = Array.new(days) { |i| i + 1 }
      block = Proc.new do |day|
        if day == Time.zone.now.day && Time.zone.local(Time.zone.now.year, Time.zone.now.month) == date.beginning_of_month
          {day: day, mark: "today"} 
        elsif marked_days.include?(day)
          if day == active_day
            {day: day, mark: "active"}
          else  
            {day: day, mark: true}
          end  
        else  
          {day: day, mark: false}
        end
      end     
      ary.map(&block)    
    end
  end

  private
  	def assign_tags
  		if @tag_names
  			self.tags += @tag_names.split(',').map do |name|       
          Tag.find_or_create_by(name: name, user_id: self.user_id)
        end  
  		end
  	end

    def set_article_slug!
      self.slug = self.title.to_slug.normalize.to_s if self.title
    end

end
