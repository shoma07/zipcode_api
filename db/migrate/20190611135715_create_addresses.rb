class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :jis
      t.string :former_zipcode
      t.string :zipcode
      t.string :prefecture_phonetic
      t.string :city_phonetic
      t.string :town_area_phonetic
      t.string :additional_area_phonetic
      t.string :prefecture
      t.string :city
      t.string :town_area
      t.string :additional_area
      t.string :prefecture_city_town_area

      t.timestamps
    end

    add_index :addresses, :zipcode
    add_index :addresses, :prefecture_city_town_area
  end
end
