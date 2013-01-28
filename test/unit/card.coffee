helper = require './spec_helper'
should = require 'should'

describe 'Card', ->
  card = null
  mongoose = null

  before ->
    mongoose = require 'mongoose'

  after ->
    mongoose.connection.close()

  beforeEach ->
    Card = require('../../models/card.coffee') mongoose
    card = new Card

  describe '#requiredWhiteCardCount', ->
    it 'should exist', ->
      should.exist(card.requiredWhiteCardCount)

    it 'should return 0 for white cards', ->
      card.card_type = "white_card"
      card.requiredWhiteCardCount().should.equal(0)

    it 'should return 1 for black cards without a missing word', ->
      card.card_type = "black_card"
      card.description = "Worst movie ever."
      card.requiredWhiteCardCount().should.equal(1)

    it 'should return 1 for black cards with a single missing phrase', ->
      card.card_type = "black_card"
      card.description = "Worst movie ever: __________."
      card.requiredWhiteCardCount().should.equal(1)

    it 'should return correct value for black cards with multiple missing phrases', ->
      card.card_type = "black_card"
      card.description = "Worst movies ever: __________ and __________."
      card.requiredWhiteCardCount().should.equal(2)
