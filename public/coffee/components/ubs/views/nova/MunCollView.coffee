define [
  'marionette'
  'backbone'
], (Marionette, Backbone, Ubs, UbsCollView) ->

  class MunCollView extends Marionette.CollectionView
    template: () -> ''

    tagName: 'ul'
    className: 'lista-municipios'

    'events':
      'change': 'doChange'

    'doChange': (evt)->
      self = @
      current = App.main.currentView
      codibge = @$el.val()
      return current.selUbs.empty() unless codibge > 0
      ufSel = current.selUf.$el.find('select').val()
      App.appRouter.navigate "comp/ubs/new/#{ufSel}/#{codibge}", true

    'childView': Marionette.ItemView.extend
      'template': (leanModel) -> _.template '<%-nome%>', leanModel
      'tagName': 'li'
      'initialize': ()-> @$el.attr value: @model.get 'ibge'

    'onRender': () ->
      console.log 'MunCollView::render Done'

  MunCollView