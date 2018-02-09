# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationPostPolicy do
  subject { InvitationPostPolicy.new(user, post) }

  let(:user) { create(:user) }
  let(:sport) { create(:sport) }
  let(:post) { create(:invitation_post, user: user, sport: sport) }
  let(:fake_user) { create(:user) }

  context 'when user is author' do
    it { is_expected.to permit_actions(%i[update destroy]) }
  end

  context 'when user is not owner' do
    let(:post) { create(:invitation_post, user: fake_user, sport: sport) }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'when logged in as manager' do
    let(:user) { create(:user, manager: true) }

    it { is_expected.to permit_actions(%i[update destroy]) }
  end
end
