# frozen_string_literal: true

# # AddressSerializer
class AddressSerializer < ApplicationSerializer
  set_type :address
  set_id :id

  attributes :zipcode, :prefecture_phonetic, :city_phonetic,
             :town_area_phonetic, :additional_area_phonetic, :prefecture, :city,
             :town_area, :additional_area
end
