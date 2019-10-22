# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
create table task (
  id integer
  detail string
  deadline date
  status integer, default 0
  label string
  )
create table user (
  id integer
  name string
  password password
  admin integer default 0
  )
* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
