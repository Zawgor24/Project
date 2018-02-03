# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:title) }
  end
end
