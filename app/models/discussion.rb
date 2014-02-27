class Discussion < ActiveRecord::Base

  attr_accessible :content, :title, :tag, :user_id
  has_one :user
  has_many :answers

end
