define [
  'marionette',
  'backbone'
], (Marionette, Backbone) ->

  class UbsCollView extends Marionette.CompositeView
    'className': 'list-group lista-ubs-container'

    template: '#ubs-nova-lista-ubs-container'

    'childViewContainer': '.ubsDeMunSel'

    'childView': Marionette.ItemView.extend
      'template': '#ubs-nova-lista-ubs-item'
      'className': 'list-group-item'
      'events':
        'click': ->
          currV = App.main.currentView
          uf = currV.selUf.$el.find('select').val()
          mun = currV.selMun.$el.find('select').val()
          App.appRouter.navigate "comp/ubs/new/#{uf}/#{mun}/#{@model.get 'cnes'}", true

      'onRender': () ->
        @$el.css 'cursor': 'pointer'

    'onRender': () ->
      @children.each (child) ->
        # $ '<div class="list-group-separator"></div>'
        # .insertAfter child.$el


  UbsCollView