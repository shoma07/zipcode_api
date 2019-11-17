# ZipcodeAPI

Zipcode search API

* Ruby version: 2.6.5

## Usage

```
$ RAILS_ENV=production bundle install
$ RAILS_ENV=production bin/rails db:migrate
$ RAILS_ENV=production bin/rails db:seed
$ RAILS_ENV=production SECRET_KEY_BASE=$(bin/rails secret) bin/rails s
```

* Search address from zip code
    ```
    /?filter[zipcode][start]=<zipcode>
    ```
* Search zip code from address
    ```
    /?filter[address][start]=<address>
    ```
* pagination
    ```
    /?page[number]=<page number>&page[size]=<page size>
    ```

### Response

```
{
  "meta": {
    "version": "20190531",
    "page": {
      "total": 124174,
      "current_page": 1,
      "limit": 100,
      "offset": 0
    }
  },
  "data": [
    {
      "type": "address",
      "id": 1,
      "attributes": {
        "zipcode": "0600000",
        "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
        "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        "town_area_phonetic": null,
        "additional_area_phonetic": null,
        "prefecture": "北海道",
        "city": "札幌市中央区",
        "town_area": null,
        "additional_area": null
      }
    },
    {
      "type": "address",
      "id": 2,
      "attributes": {
        "zipcode": "0640941",
        "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
        "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        "town_area_phonetic": "ｱｻﾋｶﾞｵｶ",
        "additional_area_phonetic": null,
        "prefecture": "北海道",
        "city": "札幌市中央区",
        "town_area": "旭ケ丘",
        "additional_area": null
      }
    },
    {
      "type": "address",
      "id": 3,
      "attributes": {
        "zipcode": "0600041",
        "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
        "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        "town_area_phonetic": "ｵｵﾄﾞｵﾘﾋｶﾞｼ",
        "additional_area_phonetic": null,
        "prefecture": "北海道",
        "city": "札幌市中央区",
        "town_area": "大通東",
        "additional_area": null
      }
    },
    {
      "type": "address",
      "id": 4,
      "attributes": {
        "zipcode": "0600042",
        "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
        "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        "town_area_phonetic": "ｵｵﾄﾞｵﾘﾆｼ",
        "additional_area_phonetic": "1-19ﾁｮｳﾒ",
        "prefecture": "北海道",
        "city": "札幌市中央区",
        "town_area": "大通西",
        "additional_area": "１～１９丁目"
      }
    },
    ...
  ]

}
```

## Docker

```
$ docker build -t zipcode_api .
$ docker run -p 3000:3000 zipcode_api
```

## Version

Zipcode data has been updated to 2019-05-31.

## Feature

* Search additional area
* Fuzzy search
* Limit control
* Roman character correspondence
* Make the container execution user a general user

## License

[MIT License](https://opensource.org/licenses/MIT)
