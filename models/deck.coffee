yaml = require 'js-yaml'
fs = require 'fs'

module.exports = (mongoose) ->

  try
    mongoose.model('Deck') 
  catch e
    if e instanceof mongoose.Error.MissingSchemaError

      Card = mongoose.model('Card')

      DeckSchema = new mongoose.Schema
        cards: [Card.Schema]
        name: String
        is_read_only: Boolean

      loadFromFile = (mongoose) ->
        return (file_name, deck_name, is_read_only) ->

          try
            data = fs.readFileSync file_name, 'utf8'
          catch err
            # TODO: handle error
            console.log 'Unable to load file: ' + err
            return

          try
            deck = new (mongoose.model 'Deck')
              name: deck_name
              is_read_only: is_read_only

            cards = yaml.load(data)

            for card_type in ['white_card', 'black_card']
              for card_description in cards[card_type]

                deck.cards.push
                  description: card_description
                  card_type: card_type

            deck.save()

            return deck

          catch err
            # TODO: handle error
            console.log 'Unable to parse file: ' + err

            try
              deck.remove()
            catch err
              console.log 'Unable to delete deck: ' + err
          return

      DeckSchema.statics.loadFromFile = loadFromFile mongoose

      DeckSchema.methods.shuffle = ->
        @cards = @cards.sort(-> 0.5 - Math.random())
        @save()

      mongoose.model('Deck', DeckSchema)
