module.exports = (Factory, mongoose) ->
  Faker = require 'Faker'

  Round = require('../../models/round') mongoose

  Factory.define('round', Round)
    .attr('black_card', -> mongoose.Schema.ObjectId(Factory.build('card:black')._id))
    .attr('dealer', -> mongoose.Schema.ObjectId(Factory.build('user')._id))
    .attr('hands', [])
    .attr('hand_submissions', [])
    .attr('winning_hand_submission', null)
