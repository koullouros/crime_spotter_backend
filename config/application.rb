require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require 'dotenv/load'
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CrimeSpotterBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    
    config.after_initialize do
      Delayed::Worker.max_attempts = 1
      Delayed::Worker.destroy_failed_jobs = false
      puts "[INFO] Delayed Worker Config Set"
    end 

    config.action_cable.mount_path = '/news'
    
    config.action_cable.url = 'wss://crime-spotter-backend.herokuapp.com/news'
    
    #config.action_cable.allowed_request_origins = [ 'https://crime-spotter-docker.herokuapp.com' ]
    
    config.action_cable.disable_request_forgery_protection = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end


