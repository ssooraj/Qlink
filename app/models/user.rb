class User < ActiveRecord::Base

  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :confirmable,
  	# :lockable, :timeoutable and :omniauthable

  	devise :database_authenticatable, :registerable, :token_authenticatable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  	# Setup accessible (or protected) attributes for your model

  	attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :passwordflag,:token,:refresh_token
    
    
    
  	# attr_accessible :title, :body

has_many :post   
has_many :event
has_many :blog
has_many :discussion
has_one :profile



  	def self.find_for_google_oauth2(access_token, signed_in_resource=nil)

		    data = access_token['info']
		    if user = User.where(:email => data['email']).first
			     return user
		    else #create a user with stub pwd
			     User.create!(:email => data['email'], :password => Devise.friendly_token[0,20],  :passwordflag => :false)

		    end
	  end

    def self.create_password(password)
        if password.present?
           encrypted_password = Digest::SHA512.hexdigest(password)
        end
        return encrypted_password
    end
end