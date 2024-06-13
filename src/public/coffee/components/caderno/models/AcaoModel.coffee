define ['backbone'], (Backbone) ->

  class Acao extends Backbone.Model
    'sync': (method, model, options) ->
      # "create", "read", "update", or "delete"
      console.log method
      console.log model

  Acao


