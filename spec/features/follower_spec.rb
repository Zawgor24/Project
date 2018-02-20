# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :feature do
  let(:user) { create(:user) }
  let(:fake_user) { create(:user) }

  before { visit user_path(user) }

  subject { page }

  describe '#show' do
    context 'when user is owner' do
      before { sign_in(user) }

      scenario { is_expected.not_to have_content(I18n.t('follows.follow')) }
    end

    context 'when user is not owner' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_link(I18n.t('follows.follow')) }
    end
  end

  describe '#create' do
    before { sign_in(fake_user) }

    scenario 'follows user' do
      click_button I18n.t('follows.follow')

      is_expected.to have_content(I18n.t('follows.notice.follow'))
    end
  end

  describe '#destroy' do
    before do
      fake_user.follow!(user)

      sign_in(fake_user)
    end

    scenario 'unfollows user' do
      click_button I18n.t('follows.unfollow')

      is_expected.to have_content(I18n.t('follows.notice.unfollow'))
    end
  end

  describe '#index' do
    before { visit user_followers_path(user) }
    context 'when user is owner' do
      before { sign_in(user) }

      scenario { is_expected.to have_content(I18n.t('follows.followers')) }
    end

    context 'when user is not owner' do
      before { sign_in(fake_user) }

      scenario { is_expected.to have_content(I18n.t('follows.followers')) }
    end
  end
end
