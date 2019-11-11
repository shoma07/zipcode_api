# ZipcodeAPI

Zipcode search API

* Ruby version: 2.6.3

## Usage

```
$ RAILS_ENV=production bundle install
$ RAILS_ENV=production bin/rails db:migrate
$ RAILS_ENV=production bin/rails db:seed
$ RAILS_ENV=production SECRET_KEY_BASE=$(bin/rails secret) bin/rails s
```

* Search address from zip code
    ```
    /?zipcode=<zipcode>
    ```
* Search zip code from address
    ```
    /?address=<address>
    ```
* pagination
    ```
    /?page=<page number>
    ```

### Response

```
{
  "meta": {
    "version": "20190531",
    "page": {
      "total": 124174,
      "page": 1,
      "size": 25
    }
  },
  "data": [
    {
      "id": 1,
      "zipcode": "0600000",
      "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
      "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
      "town_area_phonetic": null,
      "additional_area_phonetic": null,
      "prefecture": "北海道",
      "city": "札幌市中央区",
      "town_area": null,
      "additional_area": null
    },
    {
      "id": 2,
      "zipcode": "0640941",
      "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
      "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
      "town_area_phonetic": "ｱｻﾋｶﾞｵｶ",
      "additional_area_phonetic": null,
      "prefecture": "北海道",
      "city": "札幌市中央区",
      "town_area": "旭ケ丘",
      "additional_area": null
    },
    {
      "id": 3,
      "zipcode": "0600041",
      "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
      "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
      "town_area_phonetic": "ｵｵﾄﾞｵﾘﾋｶﾞｼ",
      "additional_area_phonetic": null,
      "prefecture": "北海道",
      "city": "札幌市中央区",
      "town_area": "大通東",
      "additional_area": null
    },
    {
      "id": 4,
      "zipcode": "0600042",
      "prefecture_phonetic": "ﾎｯｶｲﾄﾞｳ",
      "city_phonetic": "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
      "town_area_phonetic": "ｵｵﾄﾞｵﾘﾆｼ",
      "additional_area_phonetic": "1-19ﾁｮｳﾒ",
      "prefecture": "北海道",
      "city": "札幌市中央区",
      "town_area": "大通西",
      "additional_area": "１～１９丁目"
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
