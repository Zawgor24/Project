# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationHelper do
  let(:current_user) { create(:user) }
  let(:recipient) { create(:user) }
  let(:user_conversation) { current_user.mailbox.conversations.first }

  before do
    current_user.send_message(
      recipient,
      I18n.t('messages.greeting', name: current_user.first_name),
      recipient.email
    )
  end

  describe '.companion' do
    subject { companion(user_conversation) }

    it { is_expected.to eq(recipient) }
  end
end
