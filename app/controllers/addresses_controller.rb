# frozen_string_literal: true

# # AddressesController
class AddressesController < ApplicationController
  before_action :set_addresses

  # GET /
  def index
    render json: AddressSerializer.new(@addresses, jsonapi_params)
                                  .serialized_json
  end

  # @return [ActiveRecord::Relation]
  def set_addresses
    @addresses = Address.all
    if jsonapi_params[:filter][:address_start]
      @addresses = @addresses.address_start(
        jsonapi_params[:filter][:address_start]
      )
    end
    q = @addresses.ransack(jsonapi_params[:filter].except(:address_start))
    q.sorts = jsonapi_params[:sort] if jsonapi_params[:sort]
    @addresses = q.result.page(jsonapi_params[:page][:number])
                  .per(jsonapi_params[:page][:size])
  end
end
