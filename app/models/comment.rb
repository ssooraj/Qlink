class Comment < ActiveRecord::Base
 attr_accessible :content, :blog_id ,:user_id

  has_one :user
  belongs_to :blog
end
