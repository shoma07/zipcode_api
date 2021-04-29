# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  include Rescues

  def append_info_to_payload(payload)
    super
    return if @exception.blank?

    payload[:exception_object] ||= @exception
    payload[:exception] ||= [@exception.class, @exception.message]
  end
end
