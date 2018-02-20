# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  before { sign_in(user) }

  subject { page }

  describe '#create' do
    before { visit new_category_path }

    context 'when logged in as user' do
      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('categories.create')) }

      scenario 'creates category' do
        fill_in 'Name', with: category.name

        click_button 'Submit'

        is_expected.to have_content(I18n.t('notices.success',
          name: category.name))
      end
    end
  end

  describe '#update' do
    before { visit edit_category_path(category) }

    context 'when logged in as user' do
      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('categories.create')) }

      scenario 'updates category' do
        fill_in 'Name', with: I18n.t(:hello)

        click_button 'Submit'

        is_expected.to have_content(I18n.t('notices.update',
          name: I18n.t(:hello)))
      end
    end
  end

  describe '#destroy' do
    before { visit category_posts_path(category) }

    context 'when logged in as user' do
      scenario { is_expected.not_to have_content(I18n.t('categories.delete')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('categories.delete')) }

      scenario 'deletes post' do
        click_link I18n.t('categories.delete')

        page.driver.browser.switch_to.alert.accept

        is_expected.to have_content(I18n.t('notices.delete',
          name: category.name))
      end
    end
  end
end
