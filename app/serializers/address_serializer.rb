# frozen_string_literal: true

# AddressSerializer
class AddressSerializer < ProtobufSerializer
  INIT_MESSAGE = lambda do |object|
    Proto::Address.new(
      id: object.id.to_s,
      zipcode: object.zipcode,
      prefecture_phonetic: object.prefecture_phonetic,
      city_phonetic: object.city_phonetic,
      town_area_phonetic: object.town_area_phonetic,
      additional_area_phonetic: object.additional_area_phonetic,
      prefecture: object.prefecture,
      city: object.city,
      town_area: object.town_area,
      additional_area: object.additional_area
    )
  end
end
