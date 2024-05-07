define [
  'backbone.marionette'
], (Marionette) ->
  class TerminalFooter extends Marionette.ItemView
    template: '#apr-enf-med-footer-template'
    className: 'container-fluid big-footer'

  TerminalFooter
