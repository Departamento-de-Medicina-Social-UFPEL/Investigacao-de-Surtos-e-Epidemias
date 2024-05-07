define [
  '../collections/Criterios'
], (CriteriosColl) ->

  class Badge extends Backbone.Model
    'initialize': () ->
      @set 'rules', new CriteriosColl(@get 'rules')