# frozen_string_literal: true

# # AddressesController
class AddressesController < ApplicationController
  # GET /
  def index
    render json: AddressListResponseSerializer.new(Address.all.page(params[:page]))
  end
end
