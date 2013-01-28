before ->
  mongoose = require 'mongoose'
  mongoose.connect 'localhost', 'cah-test'

  Card = require('../../models/card.coffee') mongoose
  Deck = require('../../models/deck.coffee') mongoose
  Game = require('../../models/game.coffee') mongoose

  Card.remove
  Deck.remove
  Game.remove
