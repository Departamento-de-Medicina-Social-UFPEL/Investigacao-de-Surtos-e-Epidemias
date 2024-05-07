define [
  'backbone.marionette'
], (Marionette) ->
  class TerminalFooter extends Marionette.ItemView
    template: '#aps-odo-footer-template'
    className: 'container-fluid big-footer'

  TerminalFooter