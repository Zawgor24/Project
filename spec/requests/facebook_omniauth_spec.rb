# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Omniauth', type: :request do
  describe 'GET /auth/facebook/callback' do
    context 'when data is valid' do
      before(:each) do
        valid_facebook_login_setup
        get '/users/auth/facebook/callback'
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
      end

      it 'sets user id' do
        expect(session['warden.user.user.key'].flatten[0]).to eq(User.last.id)
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when data is invalid' do
      before do
        facebook_login_failure
        get '/users/auth/facebook/callback'
      end

      it 'does not to register user' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
