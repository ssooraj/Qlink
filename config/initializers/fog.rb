CarrierWave.configure do |config|

 config.fog_credentials = {
   :provider               => 'AWS',                                         # required
   :aws_access_key_id      => 'AKIAIS7NMF5PS3DYZRJQ',                        # required
   :aws_secret_access_key  => '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',    # required
 }

 config.fog_directory  = 'qlink'
 config.fog_public     = false                     # required
end

