class KudosToPosts < ActiveRecord::Base
  attr_accessible :kudos, :user_id, :post_id
end
