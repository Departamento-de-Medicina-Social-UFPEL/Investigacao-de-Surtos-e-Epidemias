define ['backbone'], (Backbone)->

  class Monitoramento extends Backbone.Model
    'defaults':
      'ts': do Date.now

    'initialize': (options) ->

        