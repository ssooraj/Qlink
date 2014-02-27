class Blog < ActiveRecord::Base



  attr_accessible :content, :tag, :title, :user_id, :image, :remote_image_url
  validates_presence_of :title
  has_one :user
  mount_uploader :image, ImageUploader
  has_many :comments

end
