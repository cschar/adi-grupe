require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsReact
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.app_generators.scaffold_controller = :scaffold_controller

    # https://devcenter.heroku.com/articles/rails-4-asset-pipeline#serve-assets
    config.serve_static_assets = true


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    # config.to_prepare do
    #   Devise::SessionsController.layout "devise"
    #   Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application_settings" : "devise" }
    #   Devise::ConfirmationsController.layout "devise"
    #   Devise::UnlocksController.layout "devise"
    #   Devise::PasswordsController.layout "devise"
    # end
  end
end
