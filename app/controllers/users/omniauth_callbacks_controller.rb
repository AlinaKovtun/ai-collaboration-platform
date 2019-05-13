# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook')
    end
  end
end
