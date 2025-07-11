# Pet Query 🐈🐕🕵️‍♂️

## Stack
* Ruby 3.4
* Rails 8
* Sqlite
* Rspec

## TODO:

* [x] Create models for pets
* [ ] Create API endpoints:
  * Store data
  * Query data
  * Outside of zone count
* [ ] Test coverage
  * [x] Models
  * [ ] Requests
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
