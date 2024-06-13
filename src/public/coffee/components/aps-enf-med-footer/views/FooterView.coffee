define [
  'backbone.marionette'
], (Marionette) ->
  class ApsEnfMedFooter extends Marionette.ItemView
    template: '#aps-enf-med-footer-template'
    className: 'container-fluid big-footer'

  ApsEnfMedFooter