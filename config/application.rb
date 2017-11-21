require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tesi
  class Application < Rails::Application
    # Settings in config/environments/*
    # take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_view.field_error_proc = proc { |html_tag, _instance|
      html_tag.sub(/class="/, 'class="errored ').html_safe
    }
  end
end
