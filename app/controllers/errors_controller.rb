# frozen_string_literal: true

# # ErrorsController
class ErrorsController < ApplicationController
  # @raise
  def show
    raise request.env['action_dispatch.exception']
  end
end
