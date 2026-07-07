# Start code coverage before the application boots. `bin/rails test` loads
# controllers and helpers while setting up the runner — before test_helper runs —
# so starting SimpleCov here is the only way Coverage instruments those files.
if ENV["RAILS_ENV"] == "test"
  require "simplecov"
  require "simplecov-cobertura"
  SimpleCov.start "rails" do
    formatter SimpleCov::Formatter::CoberturaFormatter
    enable_coverage :branch
  end
end

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
