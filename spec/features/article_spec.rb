# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Article', type: :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  before { sign_in(user) }

  subject { page }

  context "when user isn't authorized" do
    let(:user) { build(:user) }

    scenario 'stays at log in page' do
      expect(page.has_no_content?(I18n.t('sessions.log_out'))).to be_truthy
    end
  end

  describe '#show' do
    before { visit article_path(article) }

    context 'when logged in as user' do
      scenario { is_expected.not_to have_content(I18n.t('articles.edit')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('articles.edit')) }
    end
  end

  describe '#create' do
    before { visit new_user_article_path(user) }

    context 'when logged in as user' do
      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('articles.create')) }

      scenario 'creates article' do
        fill_in 'Title', with: article.title
        fill_in 'Body', with: article.body

        attach_file('article[avatar]', Rails.root.join('spec',
          'support', 'fixtures', 'default-post-image.jpg'))

        click_button 'Submit'

        is_expected.to have_content(article[:title])
      end
    end
  end

  describe '#update' do
    let(:fake_article) { build(:article, user: user) }

    before { visit edit_article_path(article) }

    context 'when logged in as user' do
      scenario { is_expected.to have_content(I18n.t('pundit.error')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('articles.create')) }

      scenario 'updates article' do
        fill_in 'Title', with: fake_article.title
        fill_in 'Body', with: fake_article.body

        attach_file('article[avatar]', Rails.root.join('spec',
          'support', 'fixtures', 'default-post-image.jpg'))

        click_button 'Submit'

        is_expected.to have_content(fake_article[:title])
      end
    end
  end

  describe '#destroy' do
    before { visit article_path(article) }

    context 'when logged in as user' do
      scenario { is_expected.not_to have_content(I18n.t('articles.delete')) }
    end

    context 'when user is manager' do
      let(:user) { create(:user, manager: true) }

      scenario { is_expected.to have_content(I18n.t('articles.delete')) }

      scenario 'deletes post' do
        click_link I18n.t('articles.delete')

        page.driver.browser.switch_to.alert.accept

        is_expected.to have_content(I18n.t('notices.delete',
          name: article.title))
      end
    end
  end
end
