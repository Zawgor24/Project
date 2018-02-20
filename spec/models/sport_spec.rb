# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:invitation_posts) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:info) }

    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end
end
