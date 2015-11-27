class TodoEvent < ActiveRecord::Base
  belongs_to :user

  scope :in_this_day, -> (day) { where(date: (day.beginning_of_day)..day.end_of_day) }

  before_save :set_stretch

  class << self
  	def show_event(date, day=nil)
  		in_this_day(date) if day
  	end
  end

  def set_stretch
		self.stretch = 1 if stretch.nil?
  end

end
