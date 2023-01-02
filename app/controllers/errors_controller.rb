# frozen_string_literal: true

# ErrorsController
class ErrorsController < ApplicationController
  # @return [Hash<Integer, Symbol>]
  STATUS_CODE_TO_SYMBOL = Rack::Utils::SYMBOL_TO_STATUS_CODE.invert.freeze
  private_constant :STATUS_CODE_TO_SYMBOL

  # @return [String]
  def show
    exception = request.env['action_dispatch.exception']
    status = STATUS_CODE_TO_SYMBOL[Integer(request.path[1..])]

    render json: {
      status: Rack::Utils::HTTP_STATUS_CODES[Rack::Utils.status_code(status)],
      message: exception.message || ''
    }, status:
  end
end
