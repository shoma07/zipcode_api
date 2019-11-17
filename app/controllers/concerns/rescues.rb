# frozen_string_literal: true

# # Rescues
module Rescues
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue_500 if Rails.env.production?
    rescue_from ActionController::ParameterMissing, with: :rescue_400
    rescue_from ArgumentError, with: :rescue_400
    rescue_from ApplicationSerializer::FieldsError, with: :rescue_400
    rescue_from ActionController::RoutingError, with: :rescue_404
  end

  private

  # Rescue BadRquest
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_400(exception)
    errors =
      case exception
      when ActionController::ParameterMissing
        { source: { parameter: '/data/type' } }
      .merge(I18n.t('jsonapi.errors.resource_type'))
      when ApplicationSerializer::FieldsError
        { source: { parameter: 'fields' } }.merge(
          title: 'fields invalid', detail: 'fields invalid'
        )
      when ArgumentError
        if Rails.env.production?
          { title: 'Bad Request' }
        else
          { title: 'Bad Request', detail: exception.message }
        end
      else
        { title: 'Bad Request' }
      end
    render_error(errors, status: 400)
  end

  # Rescue NotFound
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_404(exception)
    @exception = exception
    render_error({ title: 'Not Found', detail: 'Not Found.' }, status: 404)
  end

  # Rescue InternalServerError
  #
  # @param [Class] exception
  # @return [NilClass]
  def rescue_500(exception)
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
