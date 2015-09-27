class Article < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where(state: 1) }
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30, message: "請勿超過30個字元"}
  validates :content, presence: true

  attr_accessor :tag_names
  after_save :assign_tags

  def slug_candidates
    [
      :title
    ]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private
  	def assign_tags
  		if @tag_names
  			self.tags += @tag_names.split(',').map do |name|       
          Tag.find_or_create_by(name: name, user_id: self.user_id)
        end  
  		end
  	end
end
