# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  subject { page }

  before { sign_in(user) }

  describe '#create' do
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

          is_expected.to have_content(I18n.t('posts.edit.creating'))
        end
      end

      context 'when empty data' do
        before { click_button 'Submit' }

        scenario { is_expected.to have_content(I18n.t('posts.edit.creating')) }
      end
    end
  end
end
