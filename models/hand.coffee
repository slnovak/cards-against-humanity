module.exports = (mongoose) ->

  try
    mongoose.model('Hand') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      Card = require('../models/card.coffee') mongoose

      HandSchema = new mongoose.Schema
        cards: [Card.Schema]
        user:
          ref: 'User'
          type: mongoose.Schema.ObjectId 

      mongoose.model('Hand', HandSchema)
