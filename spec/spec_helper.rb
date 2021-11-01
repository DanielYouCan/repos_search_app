ENV['SINATRA_ENV'] ||= 'test'
require './app'
require 'rack/test'
require 'rack'
require 'rack/vcr'
require 'vcr'
require 'rspec-html-matchers'
Dir[File.expand_path('./support/*.rb', __dir__)].each { |f| require f }

RSpec.configure do |config|
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.include Rack::Test::Methods
  config.include RSpecHtmlMatchers
  config.include AppHelper
  config.include VcrSetup
end
