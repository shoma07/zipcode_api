# frozen_string_literal: true

# Address
class Address < ApplicationRecord
  scope :address_start, lambda { |str|
    lens = select('distinct(length(prefecture_city_town_area)) as len')
           .order(len: :desc).each_with_object([]) do |address, array|
      array << address.len if address.len <= str.size
    end
    lens = [str.size] if lens.empty?
    lens.each_with_index do |len, index|
      addresses = where('prefecture_city_town_area like ?', "#{str[0..len]}%")
      return addresses if addresses.present? || lens.size == index + 1
    end
  }
end
