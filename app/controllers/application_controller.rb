# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  include Rescues

  def append_info_to_payload(payload)
    super
    return unless @exception.present?

    payload[:exception_object] ||= @exception
    payload[:exception] ||= [@exception.class, @exception.message]
  end

  private

  # @return [Hash]
  def jsonapi_params
    @jsonapi_params ||= {
      fields: fields_params,
      sort: sort_params,
      pretty: pretty_params,
      filter: filter_params,
      page: page_params
    }
  end

  # @return [Hash]
  def page_params
    @page_params ||= params.fetch(:page, {}).permit(%i[number size])
  end

  # @see https://jsonapi.org/format/#fetching-filtering jsonapi fetching-filtering
  # @return [Hash]
  def fields_params
    unless @fields_params
      @fields_params = {}
      params[:fields]&.each do |k, v|
        @fields_params[k.to_sym] = v.to_s.split(',').map(&:to_sym)
      end
    end
    @fields_params
  end

  def fields_permits; end

  # @return [Hash]
  def filter_params
    unless @filter_params.present?
      @filter_params = {}
      params[:filter]&.each do |k, v|
        if v.is_a? ActionController::Parameters
          v.each { |l, w| @filter_params["#{k}_#{l}".to_sym] = w }
        else
          @filter_params[k.to_sym] = v
        end
      end
    end
    @filter_params
  end

  # @return [Array]
  def sort_params
    params[:sort].to_s.split(',').map do |s|
      s[0] == '-' ? "#{s[1..-1]} desc" : "#{s} asc"
    end
  end

  # @return [TrueClass, FalseClass]
  def pretty_params
    ActiveRecord::Type::Boolean.new.cast(params[:pretty] || false)
  end
end
