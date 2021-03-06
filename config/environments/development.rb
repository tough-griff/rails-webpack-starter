Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=172800",
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  if ENV["HTTPS"].present?
    config.force_ssl = true
    config.ssl_options = { hsts: { subdomains: true } }
  else
    config.force_ssl = false
  end

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Allow rake notes to pick up annotations in scss and jsx files.
  config.annotations.register_extensions "scss", "jsx" do |annotation|
    %r{\/\/\s*(#{annotation}):?\s*(.*)$}
  end

  # ActionMailer & Mailcatcher
  config.action_mailer.default_url_options = { host: "#{ENV['APP_HOST'] || 'lvh.me'}:#{ENV['PORT'] || 5000}" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: "localhost", port: ENV["MAILCATCHER_PORT"] || 1025 }
  config.action_mailer.raise_delivery_errors = true

  # Webpack
  if ENV["SIMULATE_PROD"]
    puts "Simulating production."
    # In a production-like environment, pull assets straight from public/assets.
    config.assets.compile = false
    config.assets.debug = false
    config.public_file_server.enabled = true
  else
    # Request javascript assets from the webpack dev server.
    config.action_controller.asset_host = proc do |asset|
      "//#{ENV['APP_HOST'] || 'lvh.me'}:#{ENV['NODE_PORT'] || 5050}/assets" if asset.ends_with?("bundle.js")
    end
  end
end
