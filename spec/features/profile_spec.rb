# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile', type: :feature do
  let(:fake_user) { create(:user) }
  let(:user) { create(:user) }

  subject { page }

  describe '#show' do
    context 'when user unauthorized' do
      let(:user) { build(:user) }

      scenario { expect(page.has_no_content?(I18n.t(:log_out))).to be_truthy }
    end

    context 'when user authorized' do
      before { visit user_path(user) }

      context 'when user is owner' do
        before { sign_in(user) }

        scenario { is_expected.to have_content(I18n.t('profiles.show.edit')) }
      end

      context 'when user is not owner' do
        before { sign_in(fake_user) }

        scenario 'has edit content' do
          is_expected.not_to have_content(I18n.t('profiles.show.edit'))
        end
      end

      context 'when user is manager' do
        let(:manager) { create(:user, manager: true) }

        before { sign_in(manager) }

        scenario 'has not edit content' do
          is_expected.not_to have_content(I18n.t('profiles.show.edit'))
        end
      end
    end
  end

  describe '#update' do
    before { visit edit_user_path(user) }

    context 'when user is owner' do
      before { sign_in(user) }

      context 'when valid data' do
        let(:user_attrs) { attributes_for(:user, :full) }

        scenario 'has editing content' do
          is_expected.to have_content(I18n.t('profiles.edit.editing'))
        end

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

          click_button I18n.t(:submit)

          is_expected.to have_content(I18n.t(:sign_in))
        end
      end

      context 'when invalid info' do
        scenario 'does not update profile' do
          fill_in 'user[info]', with: 'abc' * 100

          click_button I18n.t(:submit)

          is_expected.to have_content(I18n.t(:error))
        end
      end

      context 'with empty fields' do
        scenario 'does not update profile' do
          click_button I18n.t(:submit)

          is_expected.to have_content(I18n.t(:error))
        end
      end
    end

    context 'when user is not owner' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t(:pundit_error)) }
    end

    context 'when fake user is manager' do
      let(:manager) { create(:user, manager: true) }

      before { sign_in(manager) }

      scenario { is_expected.to have_content(I18n.t(:pundit_error)) }
    end
  end

  describe '#destroy' do
    before { visit user_path(user) }

    context 'when user is owner' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('profiles.delete')) }

      scenario 'removes the profile' do
        click_link 'Delete account'

        page.driver.browser.switch_to.alert.accept

        is_expected.to have_content(I18n.t(:sign_in))
      end
    end

    context 'when user is not owner' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('profiles.delete')) }
    end

    context 'when fake user is manager' do
      let(:manager) { create(:user, manager: true) }

      before { sign_in(manager) }

      scenario { is_expected.not_to have_content(I18n.t('profiles.delete')) }
    end
  end
end
