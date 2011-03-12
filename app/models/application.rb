class Application < ActiveRecord::Base

  validates_presence_of :url, :redirect_uri, :client_secret, :client_id, :user_id

  belongs_to :user
  
end
