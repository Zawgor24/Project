# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  let(:fake_user) { create(:user) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, commentable: post) }

  subject { page }

  describe '#create' do
    before { sign_in(user) }

    context 'when user is authorized' do
      before { visit post_path(post) }

      scenario { is_expected.to have_content(I18n.t(:comment)) }

      context 'when info is invalid' do
        scenario "doesn't create a comment" do
          fill_in_comment_fields 'ROR' * 10, post.body

          is_expected.to have_content(I18n.t('comments.notice.error'))
        end
      end

      context 'when info is blank' do
        scenario 'outputs an error' do
          click_button 'Submit'

          is_expected.to have_content(I18n.t('comments.notice.error'))
        end
      end

      context 'when info is valid' do
        scenario 'creates a comment' do
          fill_in_comment_fields(post.title, post.body)

          is_expected.to have_content(I18n.t('comments.notice.success'))
        end
      end
    end
  end

  describe '#update' do
    before { visit edit_comment_path(comment) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t(:pundit_error)) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit')) }

      scenario 'updates comment' do
        fill_in_comment_fields I18n.t(:hello), I18n.t(:hello)

        is_expected.to have_content(I18n.t('comments.notice.update'))
      end
    end
  end

  describe '#show' do
    before do
      create(:comment, user: user, commentable: post)
      visit post_path(post)
    end

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('posts.edit')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit')) }
    end
  end

  describe '#destroy' do
    before do
      create(:comment, user: user, commentable: post)
      visit post_path(post)
    end

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('posts.delete')) }

      scenario 'deletes comment' do
        delete_comment

        is_expected.to have_content(I18n.t('comments.notice.delete'))
      end
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('comments.delete')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.delete')) }

      scenario 'deletes comment' do
        delete_comment

        is_expected.to have_content(I18n.t('comments.notice.delete'))
      end
    end
  end

  def fill_in_comment_fields(title, body)
    fill_in 'Title', with: title
    fill_in 'Body', with: body

    click_button 'Submit'
  end

  def delete_comment
    click_link I18n.t('comments.delete')

    page.driver.browser.switch_to.alert.accept
  end
end
