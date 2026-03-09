Sentry.init do |config|
  config.enabled_environments = %w[production staging]

  config.dsn = Rails.application.credentials[:sentry_dsn]
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = Rails.env.production? ? 0.2 : 1.0
end
