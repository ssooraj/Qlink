class Post < ActiveRecord::Base

  attr_accessible :description, :user_id, :image, :receiver_id, :video, :kudos
  has_one :user
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader

end
