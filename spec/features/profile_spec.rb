# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile', type: :feature do
  let(:user) { create(:user) }

  subject { page }

  describe '#show' do
    context 'when user unauthorized' do
      let(:user) { build(:user) }

      before { sign_in(user) }

      scenario { expect(page.has_no_content?(I18n.t(:log_out))).to be_truthy }
    end

    context 'when user authorized' do
      before { authorize }

      scenario { is_expected.to have_content(I18n.t('profiles.show.profile')) }
    end
  end

  describe '#edit' do
    before(:each) do
      authorize
      click_link 'Edit profile'
    end

    context 'when valid data' do
      let(:user_attrs) { attributes_for(:user, :full) }

      scenario { is_expected.to have_content(I18n.t('profiles.edit.editing')) }

      scenario 'edits user information' do
        fields = %w[email first_name
                    last_name info birthday address]

        fields.each do |field|
          fill_in "user[#{field}]", with: user[field]
        end

        fill_in 'user[password]', with: 'some_password'

        attach_file('user[avatar]', Rails.root.join('spec',
          'support', 'fixtures', 'default-avatar.png'))

        page.select user.sex, from: 'user[sex]'

        click_button 'Submit'

        is_expected.to have_content(I18n.t(:sign_in))
      end
    end

    context 'when invalid info' do
      before { fill_in 'user[info]', with: 'abc' * 100 }
      scenario { is_expected.to have_content(I18n.t('profiles.edit.editing')) }
    end

    context 'with empty fields' do
      scenario { is_expected.to have_content(I18n.t('profiles.edit.editing')) }
    end
  end

  describe 'delete profile' do
    before { authorize }

    scenario { is_expected.to have_content(I18n.t('profiles.show.delete')) }

    scenario 'removes the profile' do
      click_link 'Delete account'

      page.driver.browser.switch_to.alert.accept

      is_expected.to have_content(I18n.t(:sign_in))
    end
  end

  def authorize
    sign_in(user)
    visit user_path(user)
  end
end
