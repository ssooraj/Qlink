CarrierWave.configure do |config|

	if Rails.env.development?
    	config.storage = :file
  	end

	if Rails.env.production?
      config.storage = :fog
  	end
end

