# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  before { sign_in(user) }

  subject { page }

  context 'when user is not authorized' do
    let(:user) { build(:user) }

    scenario 'stays at log in page' do
      expect(page.has_no_content?(I18n.t('sessions.log_out'))).to be_truthy
    end
  end

  context 'when logged in as user' do
    describe '#show' do
      scenario 'has not article edit content' do
        visit article_path(article)

        is_expected.not_to have_content(I18n.t('articles.edit'))
      end
    end

    describe '#create' do
      scenario 'causes an error' do
        visit new_user_article_path(user)

        is_expected.to have_content(I18n.t('pundit.error'))
      end
    end

    describe '#update' do
      scenario 'causes an error' do
        visit edit_article_path(article)

        is_expected.to have_content(I18n.t('pundit.error'))
      end
    end

    describe '#destroy' do
      scenario 'has not article delete content' do
        visit article_path(article)

        is_expected.not_to have_content(I18n.t('articles.delete'))
      end
    end
  end

  context 'when user is manager' do
    let(:user) { create(:user, manager: true) }

    describe '#show' do
      scenario 'shows edit content' do
        visit article_path(article)

        is_expected.to have_content(I18n.t('articles.edit'))
      end
    end

    describe '#create' do
      before { visit new_user_article_path(user) }

      scenario { is_expected.to have_content(I18n.t('articles.create')) }

      scenario 'creates article' do
        fill_in 'Title', with: article.title
        fill_in 'Body', with: article.body

        attach_file('article[avatar]', Rails.root.join('spec',
          'support', 'fixtures', 'default-post-image.jpg'))

        click_button I18n.t('buttons.submit')

        is_expected.to have_content(article[:title])
      end
    end

    describe '#update' do
      let(:fake_article) { build(:article, user: user) }

      scenario 'updates article' do
        visit edit_article_path(article)

        fill_in 'Title', with: fake_article.title
        fill_in 'Body', with: fake_article.body

        attach_file('article[avatar]', Rails.root.join('spec',
          'support', 'fixtures', 'default-post-image.jpg'))

        click_button I18n.t('buttons.submit')

        is_expected.to have_content(fake_article[:title])
      end
    end

    describe '#destroy' do
      before { visit article_path(article) }

      scenario { is_expected.to have_content(I18n.t('articles.delete')) }

      scenario 'deletes article' do
        click_link I18n.t('articles.delete')

        page.driver.browser.switch_to.alert.accept

        is_expected.to have_content(I18n.t('notices.delete',
          name: article.title))
      end
    end
  end
end
