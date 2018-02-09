# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(user, record) }

  let(:user) { create(:user) }
  let(:record) { user }
  let(:fake_user) { create(:user) }
  let(:fake_manager) { create(:user, manager: true) }

  context 'when user is author' do
    it { is_expected.to permit_actions(%i[update destroy]) }
  end

  context 'when user is not owner' do
    let(:record) { fake_user }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'when logged in as manager' do
    let(:record) { fake_manager }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end
end
