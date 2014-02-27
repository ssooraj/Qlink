require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "935182387541.apps.googleusercontent.com", "xGD61KoGpOhnurYtRWNcZJ3l", :max_results => 1000
  
end
