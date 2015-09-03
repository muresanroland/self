require 'active_support/concern'

module Oauth
  extend ActiveSupport::Concern

  class_methods do
    def from_oauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.password = Devise.friendly_token[0,20]
      end.tap do |user|
        user.profile_picture = auth.info.image
      end
    end
  end

  def admins
    list = Figaro.env.admins.split /,/
    list.map(&:strip)
  end
end