define [
  './ModalRemoverLocal'
], (ModalRemoverLocal) ->

  class ItemView extends Marionette.ItemView
    initialize: ->
      #console.log @model, 'model'
    tagName: 'li'
    className: 'list-group-item'

    template: '#monitoramento-covid-local-item'

    ui:
      'btnRemove': '.btn-remove'

    events:
      'click @ui.btnRemove':'remover'
    
    remover:(e)->
      r = new ModalRemoverLocal
        model: @model
      App.modals.show r

    onRender: ->
      #console.log 'view item'


  ItemView