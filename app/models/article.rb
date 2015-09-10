class Article < ActiveRecord::Base
  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30, message: "請勿超過30個字元"}
  validates :content, presence: true

  attr_accessor :tag_names
  after_save :assign_tags

  private
  	def assign_tags
  		if @tag_names
  			self.tags = @tag_names.split(/\s+/).map do |name|       
          Tag.find_or_create_by(name: name, user_id: self.user_id)
        end  
  		end
  	end

end
