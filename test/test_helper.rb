ENV["RAILS_ENV"] ||= "test"

require "simplecov"
require "simplecov-cobertura"
SimpleCov.start "rails" do
  formatter SimpleCov::Formatter::CoberturaFormatter
  enable_coverage :branch
end

require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
    end

    parallelize_teardown do |worker|
      SimpleCov.result
    end

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end

module ActionDispatch
  class IntegrationTest
    def sign_in(user)
      post session_url, params: { email_address: user.email_address }
      code = user.magic_links.last.code
      post session_magic_link_url, params: { code: code }
    end
  end
end
