class Tag < ActiveRecord::Base
	extend FriendlyId
	belongs_to :user
	has_many :taggings, dependent: :destroy
	has_many :articles, through: :taggings

	friendly_id :slug_candidates, use: [:slugged, :finders]

	
  def slug_candidates
    [
      :name
    ]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

	  
end
