class User < ActiveRecord::Base
  rolify
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :provider_id, :name, :email
  validates_presence_of :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.provider_id = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

  def update_credentials(auth)
    if auth['credentials']
      self.provider_access_token = auth['credentials']['token']
      self.provider_access_token_secret = auth['credentials']['secret']
      self.save!
    end
  end  

end
