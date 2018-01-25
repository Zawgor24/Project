# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :feature do
  let(:user) { build(:user) }

  before { visit new_user_registration_path }

  subject { page }

  context 'with invalid info' do
    before { click_button 'Submit' }

    scenario { is_expected.to have_content(I18n.t(:sign_up)) }
  end

  context 'with valid info' do
    before { sign_up(user) }

    scenario { is_expected.to have_content(I18n.t(:log_out)) }
  end
end
