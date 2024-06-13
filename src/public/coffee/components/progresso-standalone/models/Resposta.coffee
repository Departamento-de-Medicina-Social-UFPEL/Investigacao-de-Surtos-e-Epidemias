define ['backbone'], (Backbone)->

  class Resposta extends Backbone.Model

    'defaults':
      'ts': do Date.now

    'initialize': (options) ->