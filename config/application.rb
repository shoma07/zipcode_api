# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

module ZipcodeApi
  # ZipcodeApi::Application
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    config.paths.add 'lib', eager_load: true, autoload_once: true
    config.version = File.read(Rails.root.join('VERSION')).chomp
  end
end
