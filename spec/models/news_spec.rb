# frozen_string_literal: true

require 'rails_helper'

RSpec.describe News, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_length_of(:title).is_at_most(20) }
  end
end
