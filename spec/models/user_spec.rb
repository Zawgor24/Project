# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_length_of(:info).is_at_most(256) }
  end
end
