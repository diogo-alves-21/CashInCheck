require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CashInCheck
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.i18n.default_locale = :en
    config.i18n.load_path += Rails.root.glob('config/locales/**/*.{rb,yml}')

    begin
      if Rails.env.local?
        credentials_encrypted_file = ActiveSupport::EncryptedConfiguration.new(
          config_path: "config/credentials/#{Rails.env}.yml.enc",
          key_path: "config/credentials/#{Rails.env}.key",
          env_key: "RAILS_MASTER_KEY",
          raise_if_missing_key: true
        )

        credentials_encrypted_file.change do |tmp_path|
          File.open(tmp_path, 'w') do |file|
            file.puts(File.read("config/local_env.yml"))
          end
        end
      end
    rescue StandardError
      Rails.logger.debug 'Missing Credentials'
    end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Europe/Lisbon"
    #config.hosts << "https://ob.gocardless.com/"
    # config.eager_load_paths << Rails.root.join("extras")

  end
end
