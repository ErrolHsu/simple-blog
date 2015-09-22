class Tag < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :articles, :through => :taggings
	  
	validates :name, length: { maximum: 20, message: "請勿超過30個字元"}
end
