# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  let(:comment) { build(:comment) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  subject { page }

  before { sign_in(user) }

  describe '#create at post' do
    context "when user isn't authorized" do
      let(:user) { build(:user) }

      scenario { expect(page.has_no_content?(I18n.t(:log_out))).to be_truthy }
    end

    context 'when user is authorized' do
      before { visit post_path(post) }

      scenario { is_expected.to have_content(I18n.t(:comment)) }

      context 'when info is invalid' do
        scenario "doesn't create a comment" do
          create_comment 'ROR' * 10, post.body

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
          create_comment(post.title, post.body)

          is_expected.to have_content(I18n.t('comments.notice.success'))
        end
      end
    end
  end

  describe '#destroy at post' do
    scenario 'removes the comment' do
      visit post_path(post)
      create_comment post.title, post.body

      click_link 'Delete comment'

      page.driver.browser.switch_to.alert.accept

      is_expected.to have_content(I18n.t('comments.notice.delete'))
    end
  end

  private

  def create_comment(title, body)
    fill_in 'Title', with: title
    fill_in 'Body', with: body

    click_button 'Submit'
  end
end
