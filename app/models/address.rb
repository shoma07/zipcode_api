# frozen_string_literal: true

# Address
class Address < ApplicationRecord
  scope :zipcode_start, ->(str) { where('zipcode like ?', "#{str}%") }

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

  scope :page, ->(i = 1, l = 25) { offset((i - 1) * l).limit(l) }

  scope :total_count, lambda {
    records = dup
    records.limit_value = nil
    records.offset_value = nil
    records.count
  }
end
