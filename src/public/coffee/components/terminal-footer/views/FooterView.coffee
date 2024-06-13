define [
  'backbone.marionette'
], (Marionette) ->
  class TerminalFooter extends Marionette.ItemView
    template: '#terminal-footer-template'
    className: 'container-fluid big-footer'

  TerminalFooter