module.exports = (mongoose) ->

  try
    mongoose.model('Card') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      CardSchema = new mongoose.Schema
        card_type: String
        description: String

      CardSchema.methods.requiredWhiteCardCount = ->
        if @card_type != "black_card"
          return 0

        phrase_count = (@description.match(/__________/g) or []).length
        return Math.max phrase_count, 1

      mongoose.model('Card', CardSchema)
