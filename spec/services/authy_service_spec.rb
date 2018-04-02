# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthyService do
  context '.start' do
    let(:user) { build(:user) }
    let(:method) { %w[sms call].sample }

    it 'checks presence of method start' do
      allow(described_class).to receive(:start).with(user, method)
    end

    it 'checks presence of method check' do
      allow(described_class).to receive(:check).with(user, user.country_code)
    end
  end
end
