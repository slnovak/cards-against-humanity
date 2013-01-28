module.exports = (Factory, mongoose) ->
  Faker = require 'Faker'

  Deck = require('../../models/deck') mongoose

  define_deck = (color) ->
    Factory.define('deck:'+color, Deck)
      .attr('cards', -> [10..(10 + Math.floor Math.random()*10)].map(Factory.build('card:'+color)))
      .attr('name', -> Faker.random.catch_phrase_noun())
      .attr('is_read_only', false)

  define_deck 'white'
  define_deck 'black'
