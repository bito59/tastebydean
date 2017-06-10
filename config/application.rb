require_relative 'boot'

require 'rails/all'
#require 'json'
#require 'aws-sdk'
#require 'aws-sdk-v1'
#require 'base64'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tastebydean
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # 
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.i18n.default_locale = :fr
    I18n.available_locales = [:en, :fr, :bi]

    # Add assets paths
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    # Precompile additional assets
    #config.assets.precompile += %w( .svg .eot .woff .ttf .otf)

    # Accept cross origins from ForestAdmin
    config.middleware.insert_before 0, Rack::Cors do
        allow do
            origins 'app.forestadmin.com'
            resource '*', headers: :any, methods: :any
        end
    end

    # Skip authentication for devise controllers
    config.to_prepare do
      Devise::SessionsController.skip_before_filter :auth_user
      Devise::RegistrationsController.skip_before_filter :auth_user
    end

  end
end
