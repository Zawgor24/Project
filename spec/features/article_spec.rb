# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Article', type: :feature do
  let(:user) { create(:user) }

  before { sign_in(user) }

  subject { page }

  describe '#show' do
    context "when user isn't authorized" do
      let(:user) { build(:user) }

      scenario { expect(page.has_no_content?(I18n.t(:log_out))).to eq(true) }
    end

    context 'when user is authorized' do
      scenario { is_expected.to have_content(I18n.t(:log_out)) }
    end
  end
end
