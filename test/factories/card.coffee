module.exports = (Factory, mongoose) ->
  Faker = require 'Faker'

  Card = require('../../models/card') mongoose

  Factory.define('card:white', Card)
    .attr('card_type', 'white_card')
    .attr('description', -> Faker.Lorem.sentence(6))

  Factory.define('card:black', Card)
    .attr('card_type', 'black_card')
    .attr('description', ->
      Faker.Lorem.sentence(6) + ' ' + [0..Math.floor(Math.random()*2)].map((x) -> '__________').join(' '))
