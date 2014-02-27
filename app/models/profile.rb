class Profile < ActiveRecord::Base

  attr_accessible :date_of_birth, :first_name, :last_name, :place, :user_id, :image, :gender
  has_one :user
   mount_uploader :image, ImageUploader

 validates_presence_of :date_of_birth, :first_name, :last_name, :place, :gender

 # searchable do
 #    text :first_name, :last_name
 #  end
end
