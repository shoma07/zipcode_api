# frozen_string_literal: true

require 'csv'
require 'batches/download'
ActiveRecord::Base.logger = nil
Address.delete_all
i = 1
attributes = {}
carry = false
filename = Rails.root.join('db/seeds/KEN_ALL.csv')

Batches::Download.execute(filename) unless File.exist?(filename)

CSV.foreach(filename) do |csv|
  if carry
    attributes[:town_area_phonetic] << csv[5]
    attributes[:town_area] << csv[8]
    next unless attributes[:town_area_phonetic].include?(')')

    carry = false
  else
    attributes = {
      id: i,
      jis: csv[0],
      former_zipcode: csv[1],
      zipcode: csv[2],
      prefecture_phonetic: csv[3],
      city_phonetic: csv[4],
      town_area_phonetic: csv[5],
      additional_area_phonetic: nil,
      prefecture: csv[6],
      city: csv[7],
      town_area: csv[8],
      additional_area: nil
    }
    if attributes[:town_area_phonetic].include?('(') && attributes[:town_area_phonetic].exclude?(')')
      carry = true
      next
    end
  end
  if attributes[:town_area_phonetic] == 'ｲｶﾆｹｲｻｲｶﾞﾅｲﾊﾞｱｲ' && attributes[:town_area] == '以下に掲載がない場合'
    attributes[:town_area_phonetic] = nil
    attributes[:town_area] = nil
  end
  if /^.*\(.*\)$/.match?(attributes[:town_area_phonetic])
    tmp = attributes[:town_area].delete('）').split('（')
    tmp_phonetic = attributes[:town_area_phonetic].delete(')').split('(')
    attributes[:town_area] = tmp[0]
    attributes[:town_area_phonetic] = tmp_phonetic[0]
    if tmp[1] != 'その他' && tmp_phonetic[1] != 'ｿﾉﾀ'
      attributes[:additional_area_phonetic] = tmp_phonetic[1]
      attributes[:additional_area] = tmp[1]
    end
  end
  address = Address.new(attributes)
  address.prefecture_city_town_area = address.prefecture + address.city + address.town_area.to_s
  address.save(validate: false)
  print format("\r\r%<index>06d: %<prefecture>s", index: i, prefecture: address.prefecture.ljust(4))
  i += 1
end
print "\nDone!\n"
