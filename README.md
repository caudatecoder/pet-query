# Pet Query 🐈🐕🕵️‍♂️

## Stack
* Ruby 3.4
* Rails 8
* Sqlite
* Rspec
* jsonapi

## Setup

* install ruby 3.4 on your system
* `bundle install`
* `rails s`

To run tests:
 * Make sure the test database is up
   * `RAILS_ENV=test rails db:create`
   * `RAILS_ENV=test rails db:migrate`
 * `rspec` or `rspec _filepath_`

## Usage

For formatting refer to [jsonapi docs](https://jsonapi.org/)

### Creating pets records:
* Dog outside the zone
```shell
curl -X POST http://localhost:3000/pets \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "attributes": {
        "type": "Dog",
        "tracker_type": "medium",
        "owner_id": 123,
        "in_zone": false
      }
    }
  }'
```
* Dog inside the zone
```shell
curl -X POST http://localhost:3000/pets \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "attributes": {
        "type": "Dog",
        "tracker_type": "small",
        "owner_id": 123,
        "in_zone": true
      }
    }
  }'
```

* Cat outside the zone
```shell
curl -X POST http://localhost:3000/pets \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "attributes": {
        "type": "Cat",
        "tracker_type": "small",
        "owner_id": 123,
        "in_zone": false,
        "lost_tracker": false
      }
    }
  }'
```

* Cat inside the zone
```shell
curl -X POST http://localhost:3000/pets \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "attributes": {
        "type": "Cat",
        "tracker_type": "big",
        "owner_id": 123,
        "in_zone": true,
        "lost_tracker": false
      }
    }
  }'
```

### Getting a list of pets
```shell
curl -X GET http://localhost:3000/pets
```

### Getting the number of pets outside the zone

```shell
curl -X GET http://localhost:3000/pets/outside_of_zone
```
