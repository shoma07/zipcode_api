# frozen_string_literal: true

Rails.application.configure do
  config.consider_all_requests_local = false
  config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }
end
