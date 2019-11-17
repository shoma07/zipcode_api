# frozen_string_literal: true

Rails.application.config.consider_all_requests_local = false
Rails.application.configure do
  config.exceptions_app = lambda { |env|
    ErrorsController.action(:show).call(env)
  }
end
