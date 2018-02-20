# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationPost, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:sport) }
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:comments) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:info) }

    it { is_expected.to validate_length_of(:name).is_at_most(40) }
  end
end
