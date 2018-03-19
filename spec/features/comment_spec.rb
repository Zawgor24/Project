# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :feature do
  let(:fake_user) { create(:user) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, commentable: post) }

  subject { page }

  describe '#create' do
    before { sign_in(user) }

    context 'when user is authorized' do
      before { visit post_path(post) }

      scenario 'shows comment section' do
        is_expected.to have_content(I18n.t('comments.form.leave_comment'))
      end

      context 'when info is blank' do
        scenario 'does not save comment' do
          click_button 'Submit'

          is_expected.to have_content(I18n.t('notices.error'))
        end
      end

      context 'when info is valid' do
        scenario 'creates a comment' do
          fill_in_comment_fields I18n.t(:hello)

          is_expected.to have_content(I18n.t(:hello))
        end
      end
    end
  end

  describe '#update' do
    before { visit edit_comment_path(comment) }

    context 'when user is author' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit.edit')) }

      scenario 'updates comment' do
        fill_in_comment_fields I18n.t(:hello)

        is_expected.to have_content(I18n.t(:hello))
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

      scenario { is_expected.to have_content(I18n.t('comments.edit.edit')) }
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario { is_expected.not_to have_content(I18n.t('posts.edit.edit')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('comments.edit.edit')) }
    end
  end

  describe '#destroy' do
    before do
      create(:comment, user: user, commentable: post)
      visit post_path(post)
    end

    context 'when user is author' do
      before { sign_in(user) }

      scenario 'shows delete button' do
        is_expected.to have_content(I18n.t('comments.comment.delete'))
      end

      scenario 'deletes comment' do
        delete_comment

        is_expected.not_to have_content(I18n.t('comment.edit.edit'))
      end
    end

    context 'when user is not author' do
      before { sign_in(fake_user) }

      scenario 'hides delete button' do
        is_expected.not_to have_content(I18n.t('comments.comment.delete'))
      end
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      before { sign_in(user) }

      scenario 'shows delete button' do
        is_expected.to have_content(I18n.t('comments.comment.delete'))
      end

      scenario 'deletes comment' do
        delete_comment

        is_expected.not_to have_content(I18n.t('comment.edit.edit'))
      end
    end
  end

  def fill_in_comment_fields(body)
    fill_in 'comment[body]', with: body

    click_button 'Submit'
  end

  def delete_comment
    click_link I18n.t('comments.comment.delete')

    page.driver.browser.switch_to.alert.accept
  end
end
