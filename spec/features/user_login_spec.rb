# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Signins', type: :request do
  let(:user) { create(:user) }

  subject { page }

  context 'when email and password are valid' do
    before { sign_in_with user.email, user.password }

    scenario { is_expected.to have_link(I18n.t(:log_out)) }
  end

  context 'when email is invalid' do
    before { sign_in_with 'invalid_email', 'password' }

    scenario { is_expected.to have_link(I18n.t(:log_in)) }
  end

  context 'when password is blank' do
    before { sign_in_with user.email, '' }

    scenario { is_expected.to have_link(I18n.t(:log_in)) }
  end

  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button 'Sign in'
  end
end
