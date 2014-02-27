class Event < ActiveRecord::Base



  attr_accessible :allday, :description, :endtime, :start, :title, :user_id,:eventId,:flag

  validates_presence_of :title
  validate :validate_end_date_before_start_date
  has_one :user
  
  def validate_end_date_before_start_date
    if endtime && start && endtime < start
      errors.add(:endtime,"")
    end
  end


end

