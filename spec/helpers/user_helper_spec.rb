# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserHelper do
  let(:current_user) { create(:user) }
  let(:companion) { create(:user) }

  before do
    current_user.send_message(
      companion,
      I18n.t('messages.greeting', name: current_user.first_name),
      companion.email
    )
  end

  describe '.conversation' do
    subject { conversation(current_user) }

    it { is_expected.not_to be_nil }
  end
end
