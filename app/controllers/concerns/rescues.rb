# frozen_string_literal: true

# # Rescues
module Rescues
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue_internal_server_error if Rails.env.production?
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    rescue_from ArgumentError, with: :rescue_argument_error
    rescue_from ActionController::ParameterMissing, with: :rescue_parameter_missing
    rescue_from ActionController::RoutingError, with: :rescue_not_found
  end

  private

  # Rescue BadRquest
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_bad_request(_exception)
    errors = { title: 'Bad Request' }
    render_error(errors, status: 400)
  end

  def rescue_argument_error(exception)
    errors = if Rails.env.production?
               { title: 'Bad Request' }
             else
               { title: 'Bad Request', detail: exception.message }
             end
    render_error(errors, status: 400)
  end

  def rescue_fields_error(_exception)
    errors = { source: { parameter: 'fields' } }.merge(
      title: 'fields invalid', detail: 'fields invalid'
    )
    render_error(errors, status: 400)
  end

  def rescue_parameter_missing(_exception)
    errors = { source: { parameter: '/data/type' } }.merge(
      I18n.t('jsonapi.errors.resource_type')
    )
    render_error(errors, status: 400)
  end

  # Rescue NotFound
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_not_found(exception)
    @exception = exception
    render_error({ title: 'Not Found', detail: 'Not Found.' }, status: 404)
  end

  # Rescue InternalServerError
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_internal_server_error(exception)
    @exception = exception
    render_error({ title: 'Internal Server Error' }, status: 500)
  end

  # render error
  #
  # @param [Integer] status
  # @param [Array] errors
  # @return [NilClass]
  def render_error(errors = [], status: nil)
    errors = [errors] if errors.is_a?(Hash)
    render json: JSON.pretty_generate(errors: errors.map do |e|
      { status: status.to_s }.merge(e.slice(
        :id, :status, :code, :title, :detail
      ).compact.merge(
        source: e[:source]&.slice(:pointer, :parameter)
      ).compact)
    end), status: status
  end
end
