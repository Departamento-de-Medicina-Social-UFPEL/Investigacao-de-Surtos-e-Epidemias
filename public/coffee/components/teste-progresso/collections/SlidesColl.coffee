define ['../models/Slide'], (Slide) ->

  class SlidesColl extends Backbone.Collection

    'model': Slide

    initialize:(arr, paciente, caso)->
      console.log paciente

      @caso = if caso then caso else paciente

  SlidesColl