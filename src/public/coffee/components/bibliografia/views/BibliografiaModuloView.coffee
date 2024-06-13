define [
  'backbone.marionette'
], (Marionette) ->
  class BibliografiaView extends Marionette.ItemView
    template: '#bibliografia-main'
    className: 'item biblioGeral container'

    onRender: () ->

  BibliografiaView