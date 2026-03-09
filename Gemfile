source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 8.0.1'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '~> 1.1.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 6.3', '>= 6.3.1'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '~> 1.1', '>= 1.1.2'

# bundle and process your CSS, then deliver it via the asset pipeline in Rails
gem 'cssbundling-rails', '~> 1.4'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 2.0', '>= 2.0.11'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.3', '>= 1.3.4'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.13', '>= 2.13.0'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0', '>= 5.0.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 2.0', '>= 2.0.6', platforms: [ :windows, :jruby ]

# A database backed ActiveSupport::Cache::Store
gem 'solid_cache', '~> 1.0', '>= 1.0.7'

# Database-backed Active Job backend.
gem 'solid_queue', '~> 1.1', '>= 1.1.3'

# Database-backed Action Cable backend.
gem 'solid_cable', '~> 3.0', '>= 3.0.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18', require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem 'kamal', '~> 2.5', require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'thruster', '~> 0.1', '>= 0.1.11', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '~> 1.10', platforms: [ :mri, :windows ], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', '~> 7.0'

  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 7.1'

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '~> 1.72', require: false

  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '~> 1.23', require: false

  # Automatic Rails code style checking tool
  gem 'rubocop-rails', '~> 2.29', require: false

  # erb-lint is a tool to help lint your ERB or HTML files using the included linters or by writing your own.
  gem 'erb_lint', '~> 0.9.0', require: false

  # Patch-level verification for bundler. Read more: https://github.com/rubysec/bundler-audit
  gem 'bundler-audit', '~> 0.9.2'

  # FactoryBot is a gem to help create object for tests
  gem 'factory_bot_rails', '~> 6.4'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.2'

  # Preview email in the default browser instead of sending it. Read more: https://github.com/ryanb/letter_opener
  gem 'letter_opener', '~> 1.10'

  # Gives letter_opener an interface for browsing sent emails. Read more: https://github.com/fgrehm/letter_opener_web
  gem 'letter_opener_web', '~> 3.0'

  # Thor is a simple and efficient tool for building self-documenting command line utilities.
  # Read more: https://github.com/rails/thor
  gem 'thor', '~> 1.3'

  # It will watch your queries while you develop your application and notify you when you should add eager loading (N+1 queries).
  # Read more: https://github.com/flyerhzm/bullet
  gem 'bullet', '~> 8.0'

  # Add a comment summarizing the current schema to the top of each of your models.
  gem 'annotaterb', '~> 4.13'
  # gem 'annotate', '~> 2.6'

  # Better Errors replaces the standard Rails error page with a much better and more useful error page. It is also usable outside of Rails in any Rack app as Rack middleware.
  gem 'better_errors', '~> 2.10'

  # Code documentation
  gem 'yard', '~> 0.9.37'

  # Export schema to plantuml
  gem 'rails-plantuml-generator', git: 'https://github.com/dfabarbosa/rails-plantuml-generator', branch: 'master'

  # Xray is the missing link between the browser and your app code.
  # Press command+shift+x (Mac) or ctrl+shift+x to reveal an overlay of the files that rendered your UI, and click anything to open the file in your editor.
  gem 'xray-rails', git: 'https://github.com/dfabarbosa/xray-rails', branch: 'main'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.40.0'

  # WebDriver is a tool for writing automated tests of websites.
  gem 'selenium-webdriver', '4.28.0'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 5.2'

  # Strategies for cleaning databases. Can be used to ensure a clean slate for testing
  gem 'database_cleaner', '~> 2.1'

  # time travel
  gem 'timecop', '~> 0.9.10'

  # form filler gem
  gem 'formulaic', '~> 0.4.2'
end

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.9'

# Devise plugin to implement authentication tokens
# gem 'devise_token_auth', '~> 1.2'

# Devise plugin to invite users
gem 'devise_invitable', '~> 2.0'

# Centralization of locale data collection for Ruby on Rails.
gem 'rails-i18n', '~> 8.0'

# Centralization of locale data collection for Devise.
gem 'devise-i18n', '~> 1.12'

# A gem that provides a client interface for the Sentry error logger
gem 'sentry-ruby', '~> 5.22'

# A gem that provides Rails integration for the Sentry error logger
gem 'sentry-rails', '~> 5.22'

# A gem that provides Sidekiq integration for the Sentry error logger
gem 'sentry-sidekiq', '~> 5.22'

# A gem that allows puts to have colors on the console
gem 'colorize', '~> 1.1'

# Awesome Print is a Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation.
# Read more: https://github.com/awesome-print/awesome_print
# rails console: ap User.first
gem 'awesome_print', '~> 1.9'

# A gem that allows you to translate enums
gem 'translate_enum', '~> 0.2.0'

# Official AWS Ruby gem for Amazon Simple Storage Service (Amazon S3). This gem is part of the AWS SDK for Ruby.
gem 'aws-sdk-s3', '~> 1.181'

# Simple, efficient background processing for Ruby.
gem 'sidekiq', '~> 7.3'

# sidekiq-scheduler is an extension to Sidekiq that pushes jobs in a scheduled way, mimicking cron utility.
gem 'sidekiq-scheduler', '~> 5.0'

# Generate fake data to populate objects. Read more: https://github.com/faker-ruby/faker
gem 'faker', '~> 3.5'

# Agnostic pagination in plain ruby. It does it all. Better.
gem 'pagy', '~> 9.3'

# The fastest JSON parser and object serializer.
gem 'oj', '~> 3.16'

# Rack middleware for blocking & throttling abusive requests
gem 'rack-attack', '~> 6.7'

# Pundit provides a set of helpers which guide you in leveraging regular Ruby classes and object oriented design patterns to build a straightforward, robust, and scalable authorization system.
gem 'pundit', '~> 2.4'

# The CSV library provides a complete interface to CSV files and data. It offers tools to enable you to read and write to and from Strings or IO objects, as needed.
gem 'csv', '~> 3.3'

# i18n for javascript
gem 'i18n-js', '~> 4.2'

# The Listen gem listens to file modifications and notifies you about the changes.
gem 'listen', '~> 3.9'

gem 'money', '~> 6.19'

gem 'money-rails', '~> 1.15'

gem 'monetize', '~> 1.4'

gem 'nordigen-ruby', '~> 2.2', '>= 2.2.1'

gem 'turbo_power', '~> 0.7.0'

gem 'rack-cors', '~> 2.0', '>= 2.0.2'

gem "chartkick"
