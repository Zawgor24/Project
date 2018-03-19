# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    FACEBOOK = 'Facebook'

    def facebook
      user = AuthenticationService.from_omniauth(request.env['omniauth.auth'])

      if user.persisted? && is_navigational_format?
        sign_in_and_redirect user, event: :authentication
        set_flash_message(:notice, :success, kind: FACEBOOK)
      else
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end
end
