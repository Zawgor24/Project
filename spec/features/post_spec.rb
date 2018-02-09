# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:fake_user) { create(:user) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  subject { page }

  describe '#create' do
    before { sign_in(user) }

    context 'when user unauthorized' do
      let(:user) { build(:user) }

      scenario { expect(page.has_no_content?(I18n.t(:title))).to be_truthy }
    end

    context 'when user authorized' do
      before { visit new_user_post_path(user) }

      context 'when valid data' do
        scenario 'creates a post' do
          fill_in 'Title', with: post.title
          fill_in 'Body', with: post.body

          attach_file('post[avatar]', Rails.root.join('spec',
            'support', 'fixtures', 'default-post-image.jpg'))

          click_button 'Submit'

          is_expected.to have_content(post[:title])
        end
      end

      context 'when invalid data' do
        scenario "doesn't create a post" do
          fill_in 'Title', with: 'ROR' * 10

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
    before { visit edit_post_path(post) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t(:pundit_error)) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.edit')) }
    end
  end

  describe '#show' do
    before { visit post_path(post) }

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
    before { visit post_path(post) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.delete')) }

      scenario 'deletes post' do
        delete_post

        is_expected.to have_content(I18n.t('posts.notice.delete'))
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

        is_expected.to have_content(I18n.t('posts.notice.delete'))
      end
    end
  end

  def delete_post
    click_link I18n.t('posts.delete')

    page.driver.browser.switch_to.alert.accept
  end
end
