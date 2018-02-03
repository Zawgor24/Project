# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:posts) }
  end
end
