class UserService < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create_for(provider, oauth_user = {})
    auth = UserService.find_by_provider_and_uid oauth_user[:provider], oauth_user[:uid]

    unless auth
      u = User.find_by email: oauth_user[:email]
      u ||= User.new_for_oauth(oauth_user)

      u_service = oauth_user.slice(:uid, :token, :provider)
      u.services.build(u_service)
      u.save!

      auth = u.services.last
    end

    auth
  end

end
