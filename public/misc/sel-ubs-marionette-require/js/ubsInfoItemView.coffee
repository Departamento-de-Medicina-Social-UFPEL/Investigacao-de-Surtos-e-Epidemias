define [], ->

  class UbsInfoItemView extends Marionette.ItemView
    template: '#infoUbs-template'
    initialize: -> @listenTo @model, 'sync', @render
