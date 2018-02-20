# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Conversation', type: :feature do
  let!(:user) { create(:user) }
  let(:user_conversation) { user.mailbox.conversations.first }

  let!(:companion) { create(:user) }
  let(:companion_conversation) { companion.mailbox.conversations.first }

  before do
    user.send_message(companion,
      I18n.t('messages.greeting', name: user.first_name), companion.email)
  end

  subject { page }

  describe '#create' do
    before do
      sign_in(user)
      visit user_path(companion)
    end

    scenario 'creates new conversation' do
      click_link I18n.t('buttons.message')

      is_expected.to have_content(I18n.t('messages.greeting',
        name: user.first_name))
    end
  end

  describe '#show' do
    describe 'conversations' do
      context 'when logged in as user' do
        before do
          sign_in(user)
          visit conversation_path(user_conversation)
        end

        scenario 'shows conversation' do
          is_expected.to have_content(I18n.t('messages.greeting',
            name: user.first_name))
        end
      end

      context 'when logged in as companion' do
        before do
          sign_in(companion)
          visit conversation_path(companion_conversation)
        end

        scenario 'shows conversation' do
          is_expected.to have_content(I18n.t('messages.greeting',
            name: user.first_name))
        end
      end
    end

    describe 'inbox' do
      context 'when logged in as companion' do
        before do
          sign_in(companion)
          visit mailbox_inbox_path
        end

        scenario 'shows inbox messages' do
          is_expected.to have_content(I18n.t('messages.greeting',
            name: user.first_name))
        end
      end
    end

    describe 'sentbox' do
      context 'when logged in as companion' do
        before do
          sign_in(user)
          visit mailbox_sentbox_path
        end

        scenario 'shows sentbox messages' do
          is_expected.to have_content(I18n.t('messages.greeting',
            name: user.first_name))
        end
      end
    end
  end

  describe '#index' do
    context 'when logged in as user' do
      before do
        sign_in(user)
        visit user_conversations_path(user)
      end

      scenario { is_expected.to have_content(I18n.t('conversations.index')) }
    end

    context 'when logged in as companion' do
      before do
        sign_in(companion)
        visit user_conversations_path(companion)
      end

      scenario { is_expected.to have_content(I18n.t('conversations.index')) }
    end
  end

  describe '#destroy' do
    context 'when logged in as user' do
      before { sign_in(user) }

      scenario 'moves conversation to trash' do
        visit user_conversations_path(user)

        click_link 'Delete'

        page.driver.browser.switch_to.alert.accept

        is_expected.not_to have_content(I18n.t('messages.greeting',
          name: user.first_name))
      end

      scenario 'shows thashed conversation' do
        visit mailbox_trash_path

        is_expected.not_to have_content(I18n.t('messages.greeting',
          name: user.first_name))
      end
    end
  end
end
