require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  Capybara.server = :puma
  ActionDispatch::IntegrationTest
  Capybara.server_port = 3001
  Capybara.app_host = 'http://localhost:3001'

  config.include AcceptanceHelpers, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end
