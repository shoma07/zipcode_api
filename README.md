# ZipcodeAPI

Zipcode search API

* Ruby version: 2.7.1

## Usage

```
$ RAILS_ENV=production bundle install
$ RAILS_ENV=production bin/rails db:migrate
$ RAILS_ENV=production bin/rails db:seed
```

## Docker

```
$ docker build -t zipcode_api .
$ docker run -p 3000:3000 zipcode_api
```

## License

[MIT License](https://opensource.org/licenses/MIT)
