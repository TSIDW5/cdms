require 'support/simplecov'
require 'support/file_helper'
require 'support/asserts/active_link'
require 'support/asserts/breadcrumbs'
require 'support/asserts/redirect_to'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}" if ENV['COVERAGE']
  end

  parallelize_teardown do |_worker|
    SimpleCov.result if ENV['COVERAGE']
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  include FactoryBot::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include ::Asserts::Breadcrumbs
  include ::Asserts::ActiveLink
  include ::Asserts::RedirectTo
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
