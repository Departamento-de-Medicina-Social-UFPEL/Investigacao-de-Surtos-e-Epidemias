define ['backbone','utils'], (Backbone, utils) ->

  class Caso extends Backbone.Model
    'initialize': (options) ->
      oid = @get '_id'
      unless oid
        return false
      tsPart = oid.slice 0,8
      unixTs = parseInt tsPart, 16
      dataBr = (new utils.databr(unixTs,charMes:0)).fabricate()
      @set 'dataLongaPub', dataBr
      nucleo = @get 'profissional'
      @set 'pro', [
        /medicina/i.test nucleo
        /enfermagem/i.test nucleo
        /odontologia/i.test nucleo
      ]

  Caso