define [
  'backbone.marionette'
], (Marionette) ->
  class TerminalFooter extends Marionette.ItemView
    template: '#footer-template'
    className: 'container-fluid big-footer'

  TerminalFooter
