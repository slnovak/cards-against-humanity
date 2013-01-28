module.exports = (mongoose) ->

  try
    mongoose.model('RoundSumission') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      RoundSubmissionSchema = new mongoose.Schema
        user:
          ref: 'User'
          type: mongoose.Schema.ObjectId 
        hand_submission:
          ref: 'HandSubmission'
          type: mongoose.Schema.ObjectId 

      mongoose.model('RoundSubmission', RoundSubmissionSchema)
