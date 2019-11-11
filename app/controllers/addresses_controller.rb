class AddressesController < ApplicationController

  def index
    addresses = if params[:zipcode]
                  Address.zipcode_start(params[:zipcode])
                elsif params[:address]
                  Address.address_start(params[:address])
                else
                  Address.all
                end
    page = params[:page].to_i > 1 ? params[:page].to_i : 1
    addresses = addresses.page(page)
    render json: JSON.pretty_generate({
      meta: {
        version: Rails.application.config.version,
        page: {
          total: addresses.total_count,
          page: page,
          size: addresses.count,
        }
      },
      data: addresses.as_json(
        only: [
          :id,
          :zipcode,
          :prefecture_phonetic,
          :city_phonetic,
          :town_area_phonetic,
          :additional_area_phonetic,
          :prefecture,
          :city,
          :town_area,
          :additional_area,
        ]
      )
    })
  end

end
