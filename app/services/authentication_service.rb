# frozen_string_literal: true

module AuthenticationService
  def self.from_omniauth(auth)
    User.where(provider: auth[:provider],
               uid: auth[:uid]).first_or_create do |user|
      user.email = auth[:info][:email]
      user.password = Devise.friendly_token[0, 20]
      user.first_name = facebook_first_name(auth)
      user.last_name = facebook_last_name(auth)
      user.remote_avatar_url = auth[:info][:image]
    end
  end

  def self.facebook_first_name(auth)
    auth[:info][:name].split(' ')[0]
  end

  def self.facebook_last_name(auth)
    auth[:info][:name].split(' ')[1]
  end
end
