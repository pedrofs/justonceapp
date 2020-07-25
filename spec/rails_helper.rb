require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'factory_bot_rails'
require 'shoulda-matchers'
require 'pundit/rspec'
require 'devise'
require 'database_cleaner-active_record'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

DatabaseCleaner.allow_production = true
DatabaseCleaner.allow_remote_database_url = true

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after do
    ActsAsTenant.current_tenant = nil
  end
end
