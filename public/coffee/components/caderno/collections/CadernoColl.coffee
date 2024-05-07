define ['backbone'], (Backbone) ->

  class Caderno extends Backbone.Collection

    'sync': () ->
      console.log arguments

    'initialize': () ->
      console.log arguments



