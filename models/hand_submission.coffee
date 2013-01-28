module.exports = (mongoose) ->

  try
    mongoose.model('HandSubmission') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      Card = require('../models/card.coffee') mongoose

      HandSubmissionSchema = new mongoose.Schema
        user:
          ref: 'User'
          type: mongoose.Schema.ObjectId 
        cards: [Card.Schema]

      mongoose.model('HandSubmission', HandSubmissionSchema)
