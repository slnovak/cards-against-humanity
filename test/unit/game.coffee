helper = require './spec_helper'
should = require 'should'

Factory = require('rosie').Factory
Faker = require 'Faker'

describe 'Game', ->
  game = null
  mongoose = null

  before ->
    mongoose = require 'mongoose'

    # Register our factories.
    require('../factories/card') Factory, mongoose
    require('../factories/deck') Factory, mongoose
    require('../factories/user') Factory, mongoose

  after ->
    mongoose.connection.close()

  beforeEach ->
    Game = require('../../models/game.coffee') mongoose
    game = new Game()

    ##describe '#attachDeck()', ->
    ##  it 'should population @white_draw_pile and @black_draw_pile with cards from the deck', ->
    ##    Deck = require('../../models/deck.coffee') mongoose

    ##    game.white_deck = Factory.assoc 'deck:white'
    ##    game.black_deck = Factory.assoc 'deck:white'
    ##    #deck = Deck.loadFromFile __dirname+'/../../data/cards.yml', 'Default', false

    ##    #game.attachDeck deck

    ##    game.should.have.property('white_draw_pile').with.lengthOf deck.cards.filter((card) -> card.card_type == 'white_card').length
    ##    game.should.have.property('black_draw_pile').with.lengthOf deck.cards.filter((card) -> card.card_type == 'black_card').length
    #

  describe '#drawWhiteCard()', ->
    it 'should return the first card within @white_draw_pile', ->
      Card = require('../../models/card.coffee') mongoose

      card_descriptions = ['card_1', 'card_2', 'card_3']

      for card_description in card_descriptions
        game.white_draw_pile.push
          description: card_description
          card_type: 'white_card'

      for card_description in card_descriptions
        game.drawWhiteCard().should.have.property 'description', card_description

  describe '#drawBlackCard()', ->
    it 'should return the first card within @black_draw_pile', ->
      Card = require('../../models/card.coffee') mongoose

      card_descriptions = ['card_1', 'card_2', 'card_3']

      for card_description in card_descriptions
        game.black_draw_pile.push
          description: card_description
          card_type: 'black_card'

      for card_description in card_descriptions
        game.drawBlackCard().should.have.property 'description', card_description

  describe '#newRound()', ->
    beforeEach ->

      Card = require('../../models/card.coffee') mongoose

      for _ in [1..50]
        game.black_draw_pile.push Factory.build('card:black')
        game.white_draw_pile.push Factory.build('card:white')

      for _ in [0..5]
        game.users.push Factory.build('user')

      game.save()

    it 'should specify a new dealer', ->

      game.currentDealer().should.equal game.users[0]

      for i in [1..4]
        game.newRound()
        game.currentDealer().should.equal game.users[i]
      
    it 'should copy hands from the previous round'
    it 'should select a new black card'
    it 'should deal out new cards to users'
