class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :user_id
end
