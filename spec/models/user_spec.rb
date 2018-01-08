# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:info).is_at_most(256) }
  end

  describe 'custom validations' do
    describe 'birthday validations' do
      subject { user.valid? }

      context 'user with valid birthday' do
        let(:user) { FactoryBot.build(:user) }

        it { is_expected.to be_truthy }
      end

      context 'user with invalid birthday' do
        let(:user) do
          FactoryBot.build(:user, birthday: Faker::Date.birthday(1, 5))
        end

        it { is_expected.to be_falsy }
      end
    end
  end
end
