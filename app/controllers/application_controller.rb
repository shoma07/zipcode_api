# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  def append_info_to_payload(payload)
    super
    return unless @exception.present?

    payload[:exception_object] ||= @exception
    payload[:exception] ||= [@exception.class, @exception.message]
  end
end
