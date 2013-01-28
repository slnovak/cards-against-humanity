module.exports = (Factory, mongoose) ->
  Faker = require 'Faker'

  User = require('../../models/user') mongoose

  Factory.define('user', User)
    .attr('name', -> Faker.Name.firstName())
    .attr('session', -> Faker.Lorem.sentence(6))
