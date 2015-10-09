class Tag < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, dependent: :destroy
	has_many :articles, through: :taggings
	  
end
