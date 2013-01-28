module.exports = (mongoose) ->

  try
    mongoose.model('Round') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      HandSubmission = require('../models/hand_submission.coffee') mongoose
      Hand = require('../models/hand.coffee') mongoose

      RoundSchema = new mongoose.Schema
        black_card:
          ref: 'Card'
          type: mongoose.Schema.ObjectId 
        dealer:
          ref: 'User'
          type: mongoose.Schema.ObjectId 
        hands: [Hand.Schema]
        hand_submissions: [HandSubmission.Schema]
        winning_hand_submission:
          ref: 'HandSubmission'
          type: mongoose.Schema.ObjectId 

      RoundSchema.methods.dealCards = (user, cards) ->
        hand = @hands.filter((x) -> x.user._id == user._id)
        console.log hand
        #for card in cards
          #hand.cards.push card
          #
      RoundSchema.methods.findHandByUserId = (user_id) ->
        @hands.filter((x) -> x == user_id)[0]

      mongoose.model('Round', RoundSchema)
