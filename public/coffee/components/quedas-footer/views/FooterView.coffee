define [
  'backbone.marionette'
], (Marionette) ->
  class IntroItemView extends Marionette.ItemView
    template: '#quedas-footer-template'
    className: 'container-fluid big-footer'

  IntroItemView