class Article < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where(state: 1) }
  scope :except_recycling_bin, -> { where.not(state: 4)}
  scope :find_by_state, -> (state) { where(state: state) }
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

  def to_trash
    self.state = 4
    self.save
  end


  class << self
    def find_by_date(year=nil, month=nil, day=nil)
      if month
        date = Time.zone.local(year, month, day)
        day ? in_this_day(date).published : in_this_month(date).published
      else
        published 
      end
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
