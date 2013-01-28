module.exports = (Factory, mongoose) ->
  Faker = require 'Faker'

  Hand = require('../../models/hand') mongoose

  Factory.define('hand', Hand)
    .attr('cards', -> [0..10].map(Factory.build('card:white')))
    .attr('user', -> mongoose.Schema.ObjectId(Factory.build('user')._id))
