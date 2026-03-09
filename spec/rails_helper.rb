# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'devise'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = Rails.root.join('spec', 'fixtures')

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include FactoryBot::Syntax::Methods

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers

  config.include FormHelpers, type: :system
  config.include DeviseHelpers, type: :system
  config.include ExpectHelpers, type: :system
  config.include ExpectHelpers, type: :model

  # Capybara config
  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1920,1080')
    options.add_argument('--no-sandbox')

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 240

    if ENV['SELENIUM_URL']
      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: ENV['SELENIUM_URL'],
        capabilities: [options],
        http_client: client
      )
    else
      Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        capabilities: [options],
        http_client: client
      )
    end
  end

  Capybara.javascript_driver = :headless_chrome
  Capybara.server_port = 3000
  Capybara.always_include_port = true
  Capybara.asset_host = 'http://localhost:3000'

  if ENV['SELENIUM_URL']
    ip = Socket.ip_address_list.find(&:ipv4_private?).ip_address
    Capybara.server_host = ip
    Capybara.asset_host = "http://#{ip}:3000"
    Capybara.app_host = "http://#{ip}:3000"
  end

  Capybara.configure do |capybara_config|
    capybara_config.default_max_wait_time = 30 # seconds
    capybara_config.default_driver = :headless_chrome
  end

  # System tests
  config.before(:each, type: :system) do
    driven_by :headless_chrome
    # driven_by :selenium_chrome_headless
    # driven_by :selenium_chrome
  end

  config.before(:each, type: :system, js: true) do
    if ENV['SELENIUM_URL'].present?
      driven_by :headless_chrome
    else
      # Otherwise, use the local machine's chromedriver
      # driven_by :selenium_chrome_headless
      driven_by :selenium_chrome
    end
  end

  # DatabaseCleaner
  config.before(:suite) do
    system("yarn build", out: File::NULL)
    system("yarn build:css", out: File::NULL)
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end

  # Formulaic
  config.include Formulaic::Dsl, type: :system
end
