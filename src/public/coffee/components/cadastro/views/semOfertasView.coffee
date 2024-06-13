define [
  'backbone.marionette'
], (Marionette) ->

  class SemOfertasView extends Marionette.ItemView
    initialize: (@user) ->

    template: _.template($('#cadastro-sem-ofertas').html())
    cancelEl: '.close-modal'
    className: '.container'

    onRender: ->

  SemOfertasView

