# frozen_string_literal: true

# # ErrorsController
class ErrorsController < ApplicationController
  # @raise
  def show
    raise env['action_dispatch.exception'] if env.present?
  end
end
