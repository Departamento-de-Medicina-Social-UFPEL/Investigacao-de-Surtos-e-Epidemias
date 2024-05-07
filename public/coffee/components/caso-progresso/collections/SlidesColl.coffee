define ['../models/Slide'], (Slide) ->

  class SlidesColl extends Backbone.Collection

    'model': Slide

    initialize:(arr, paciente, caso)->
      # console.log paciente
      @paciente = paciente
      @caso = caso

  SlidesColl