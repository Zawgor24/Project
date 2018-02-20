# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationPost, type: :feature do
  let(:fake_user) { create(:user) }
  let(:user) { create(:user) }
  let(:sport) { create(:sport) }
  let(:post) { create(:invitation_post, user: user, sport: sport) }

  subject { page }

  describe '#create' do
    before { sign_in(user) }

    context 'when user unauthorized' do
      let(:user) { build(:user) }

      scenario { is_expected.to have_content(I18n.t('sessions.sign_in')) }
    end

    context 'when user authorized' do
      before { visit new_sport_invitation_post_path(sport) }

      context 'when valid data' do
        scenario 'creates a post' do
          fill_in_post_fields post.name, post.info

          is_expected.to have_content(I18n.t('notices.success',
            name: post.name))
        end
      end

      context 'when invalid data' do
        scenario "doesn't create a post" do
          fill_in 'Name', with: Faker::Lorem.paragraph

          click_button 'Submit'

          is_expected.to have_content(I18n.t('posts.creating'))
        end
      end

      context 'when empty data' do
        before { click_button 'Submit' }

        scenario { is_expected.to have_content(I18n.t('posts.creating')) }
      end
    end
  end

  describe '#update' do
    before { visit edit_invitation_post_path(post) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.editing')) }

      scenario 'updates post' do
        fill_in_post_fields I18n.t(:hello), Faker::Lorem.word

        is_expected.to have_content(I18n.t('notices.update',
          name: I18n.t(:hello)))
      end
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.editing')) }
    end
  end

  describe '#show' do
    before { visit invitation_post_path(post) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('posts.edit')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.edit')) }
    end
  end

  describe '#destroy' do
    before { visit invitation_post_path(post) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.delete')) }

      scenario 'deletes post' do
        delete_post

        is_expected.to have_content(I18n.t('notices.delete', name: post.name))
      end
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('posts.delete')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.delete')) }

      scenario 'deletes post' do
        delete_post

        is_expected.to have_content(I18n.t('notices.delete', name: post.name))
      end
    end
  end

  def delete_post
    click_link I18n.t('posts.delete')

    page.driver.browser.switch_to.alert.accept
  end

  def fill_in_post_fields(name, info)
    fill_in 'Name', with: name
    fill_in 'Info', with: info

    click_button 'Submit'
  end
end
