# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, user: user, commentable: article) }
  let(:fake_user) { create(:user) }

  context 'when user is owner' do
    it { is_expected.to permit_actions(%i[update destroy]) }
  end

  context 'when user is not owner' do
    let(:comment) { create(:comment, user: fake_user, commentable: article) }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'when logged in as manager' do
    let(:user) { create(:user, manager: true) }

    it { is_expected.to permit_actions(%i[update destroy]) }
  end
end
