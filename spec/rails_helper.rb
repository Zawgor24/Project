# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

if Rails.env.production?
  abort('The Rails environment is running
          in production mode!')
end
require 'rspec/rails'
require 'capybara/rails'
require 'pundit/matchers'
require 'database_cleaner'

OmniAuth.config.test_mode = true

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include AuthorizationHelper
  config.include OmniauthMacros
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |con|
    con.integrate do |with|
      with.test_framework :rspec

      with.library :active_record
      with.library :active_model
      with.library :action_controller
      with.library :rails
    end
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
