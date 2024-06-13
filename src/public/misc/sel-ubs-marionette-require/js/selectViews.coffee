define [], (SelectItemView) ->

  class SelectItemView extends Marionette.ItemView
    tagName: 'select'
    className: 'form-control input-lg'
    template: '#select-template'

  class Estado extends SelectItemView
    events: 'change': 'mostra'
    mostra: -> @triggerMethod 'mostra:municipiosDeUf', @$el.val()

  class Municipio extends SelectItemView
    events: 'change': 'mostra'
    initialize: -> @listenTo @collection, 'reset', @render
    mostra: ->  @triggerMethod 'mostra:ubsDeMun', @$el.val()
    onBeforeRender: -> @$el.empty().attr disabled: 'disabled'
    onRender: -> @$el.removeAttr 'disabled' unless @collection.length <= 1

  class Ubs extends SelectItemView
    events: 'change': 'mostra'
    initialize: -> @listenTo @collection, 'reset', @render
    mostra: -> @triggerMethod 'mostra:ubs', @$el.val()
    onBeforeRender: -> @$el.empty().attr disabled: 'disabled'
    onRender: ->
      @$el.removeAttr 'disabled' unless @collection.length <= 1

  { Estado, Municipio, Ubs }

