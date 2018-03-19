# frozen_string_literal: true

require 'rails_helper'
require './app/services/authentication_service'

RSpec.describe 'AuthenticationService' do
  let(:auth) { Faker::Omniauth.facebook }
  let(:valid_info) { AuthenticationService.from_omniauth(auth) }

  context 'when data is valid' do
    it { expect(valid_info.email).to eq(auth[:info][:email]) }

    it { expect(valid_info).to eq(User.first) }
  end
end
