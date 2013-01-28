module.exports = (mongoose) ->

  try
    mongoose.model('User') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      UserSchema = new mongoose.Schema
        name: String
        session: String

      mongoose.model('User', UserSchema)
