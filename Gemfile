# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'active_admin_paranoia', '~> 1.0.11'
gem 'activeadmin'
gem 'ancestry'
gem 'bootstrap'
gem 'carrierwave', '~> 1.0'
gem 'coffee-rails', '~> 4.2'
gem 'decent_exposure', '3.0.0'
gem 'devise'
gem 'draper'
gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
gem 'figaro'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'loofah', '~> 2.2', '>= 2.2.1'
gem 'mailboxer'
gem 'omniauth-facebook'
gem 'paranoia', '~> 2.2'
gem 'pg', '~> 0.18'
gem 'popper_js', '~> 1.12.9'
gem 'puma', '~> 3.7'
gem 'pundit'
gem 'rails', '~> 5.1.4'
gem 'rmagick'
gem 'rspec'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'slim'
gem 'socialization'
gem 'toastr-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate-bootstrap'
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver', '~> 2.53.4'
end

group :test do
  gem 'pundit-matchers', '~> 1.4.1'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rbenv', '~> 2.1'

  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
