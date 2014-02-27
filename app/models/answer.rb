class Answer < ActiveRecord::Base
  attr_accessible :content, :discussion_id ,:user_id

  has_one :user
  belongs_to :discussion

end
