# Pet Query 🐈🐕🕵️‍♂️

## Stack
* Ruby 3.4
* Rails 8
* Sqlite
* Rspec

## TODO:

* [x] Create models for pets
* [x] Create API endpoints:
  * [x] Store data
  * [x] Query data
  * [x] Outside of zone count
* [x] Test coverage
  * [x] Models
  * [x] Requests
* [ ] Basic usage documentation here

## Setup

* install ruby 3.4 on your system
* `bundle install`
* `rails db:create`
* `rails db:migrate`
* `rails s`

To run tests:
 * Make sure the test database is up
   * `RAILS_ENV=test rails db:create`
   * `RAILS_ENV=test rails db:migrate`
 * `rspec` or `rspec _filepath_`
