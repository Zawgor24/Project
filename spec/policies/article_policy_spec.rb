# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePolicy do
  subject { ArticlePolicy.new(user, article) }

  let(:article) { create(:article, user: user) }

  context 'when logged in as user' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'when logged in as manager' do
    let(:user) { create(:user, manager: true) }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end
end
