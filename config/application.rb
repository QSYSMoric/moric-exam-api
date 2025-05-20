require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HomeWork2
  class Application < Rails::Application
    
    config.load_defaults 5.2

    config.paths.add 'app/api', eager_load: true

    config.api_only = true
  end
end
