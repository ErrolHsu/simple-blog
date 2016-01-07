class Article < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  belongs_to :category
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  default_scope -> { order(created_at: :desc) }

  scope :published, -> { where(state: 1) }
  scope :except_recycling_bin, -> { where(state: [1, 2, 3])}
  scope :find_by_state, -> (state) { where(state: state) }
  scope :in_this_month, -> (month) { where(created_at: (month.beginning_of_month)..month.end_of_month) }
  scope :in_this_day, -> (day) { where(created_at: (day.beginning_of_day)..day.end_of_day) }

  validates :user_id, presence: true
  validates :title, presence: { message: "標題請勿空白"}

  attr_accessor :tag_names, :category_name

  before_save :find_or_create_category
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
    ids = self.tags.ids
    Tag.update_counters(ids, articles_count: -1)
    self.state += 10
    self.save
  end

  def original_state
    ids = self.tags.ids
    Tag.update_counters(ids, articles_count: +1)    
    self.state -= 10
    self.save
  end

  def delete_it
    self.delete
    Tagging.where(article_id: self.id).each { |i| i.delete}
  end

  def related_articles
    population, sample = [], []
    self.tags.each { |tag| population << tag.articles.pluck(:id) }
    population.flatten!
    population.delete(self.id) 
    4.times do |i|
      id = population.sample
      population.delete(id)
      sample << id
    end
    sample.compact!
    Article.where(id: sample).shuffle
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
  		if !@tag_names.empty?
  			self.tags += @tag_names.split(',').map do |name|       
          Tag.find_or_create_by(name: name, user_id: self.user_id)
        end  
  		end
  	end

    def find_or_create_category
      if !@category_name.empty?
        category = Category.find_by(name: @category_name, user_id: self.user.id)
        if category.nil?
          self.create_category(name: @category_name, user_id: self.user_id)
        else
          self.category =  category
        end
      end 
    end

end
