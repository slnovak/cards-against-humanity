async = require 'async'

module.exports = (mongoose) ->

  try
    mongoose.model('Game') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      Card = require('../models/card.coffee') mongoose
      Round = require('../models/round.coffee') mongoose
      User = require('../models/user.coffee') mongoose
      Hand = require('../models/hand.coffee') mongoose

      GameSchema = new mongoose.Schema
        white_draw_pile: [Card.Schema]
        white_discard_pile: [Card.Schema]
        black_draw_pile: [Card.Schema]
        black_discard_pile: [Card.Schema]
        rounds: [Round.Schema]
        is_active: Boolean
        users: [User.Schema]
        id: String

      GameSchema.methods.currentRound = ->

        if @rounds.length == 0

          round = new Round
            black_card: null
            dealer: @users[0]._id
            hands: []
            hand_submissions: []
            winning_hand_submission: null

          card_count = 10

          for user in @users

            hand = new Hand
              user: user._id

            for _ in [1..card_count]
              hand.cards.push @drawWhiteCard()

            round.hands.push hand

          @rounds.push round

          @save()

        @rounds[@rounds.length-1]

      GameSchema.methods.drawWhiteCard = ->
        @drawCard @white_draw_pile, @white_discard_pile

      GameSchema.methods.drawBlackCard = ->
        @drawCard @black_draw_pile, @black_discard_pile

      GameSchema.methods.drawCard = (draw_pile, discard_pile) ->
        if draw_pile.length == 0
          draw_pile = discard_pile.sort(-> 0.5 - Math.random())
          discard_pile = []

        card = draw_pile.shift()
        discard_pile.push card
        @save()
        card

      GameSchema.methods.attachDeck = (deck) ->
        @black_draw_pile = []
        @black_discard_pile = []
        @white_draw_pile = []
        @white_discard_pile = []
        
        for card in deck.cards
          if card.card_type == "white_card"
            @white_draw_pile.push card
          else if card.card_type == "black_card"
            @black_draw_pile.push card

        @save()

      GameSchema.methods.currentDealer = ->
        dealer = @currentRound().dealer
        @users.filter((user) -> user._id == dealer)[0]

      GameSchema.methods.nextDealer = ->
        if @currentRound() == null
          return @user[0]
        else
          return @users[(@users.indexOf(@currentDealer())+1) % @users.length]

      GameSchema.methods.newRound = () -> #TODO: (round_info_cb, new_cards_cb) ->
        next_dealer = @nextDealer()
        next_black_card = @drawBlackCard()

        round = new Round
          black_card: mongoose.Schema.ObjectId(next_black_card._id)
          dealer: mongoose.Schema.ObjectId(next_dealer._id)

        round.hands = @currentRound().hands

        card_count = next_black_card.requiredWhiteCardCount()

        @current_round = round

        for user in @users
          cards = [@drawWhiteCard() for _ in [1..card_count]]

          @current_round.dealCards user, cards

      mongoose.model('Game', GameSchema)
