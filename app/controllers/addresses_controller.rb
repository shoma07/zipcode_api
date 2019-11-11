# frozen_string_literal: true

# AddressesController
class AddressesController < ApplicationController
  before_action :set_page
  before_action :set_addresses

  # GET /
  def index
    render json: JSON.pretty_generate(
      meta: { page: {
        total: @addresses.total_count, page: @page, size: @addresses.count
      } }, data: @addresses.as_json(
        only: %i[
          id zipcode prefecture_phonetic city_phonetic town_area_phonetic
          additional_area_phonetic prefecture city town_area additional_area
        ]
      )
    )
  end

  private

  # @return [Integer]
  def set_page
    @page = params[:page].to_i > 1 ? params[:page].to_i : 1
  end

  # @return [ActiveRecord::Relation]
  def set_addresses
    @addresses = Address.all
    @addresses = @addresses.zipcode_start(params[:zipcode]) if params[:zipcode]
    @addresses = @addresses.address_start(params[:address]) if params[:address]
    @addresses = @addresses.page(@page)
    @addresses
  end
end
