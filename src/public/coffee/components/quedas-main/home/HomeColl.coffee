define [
  './quedaItemView'
  'text!./quedaTemplate.html.ejs'
  'utils'
  # 'less!./quedaStyle.less'
], (QuedaItemView, quedasTemplate, utils) ->

  class Quedas extends Marionette.CompositeView

    className: 'item quedas container'

    initialize: ->
      @collection = App.quedas

    template: (data) ->
      _.template quedasTemplate, data, { 'variable' : 'it' }

    childView: QuedaItemView

    childViewContainer: '.lista-quedas'

    childEvents:
      "render": (evt, view)->
        # console.log arguments
        fl = view.model.get 'folder'
        nm = view.model.get 'nome'
        css = 'background': "url(img/#{fl}/#{fl}_fundo.png) cover no-repeat"
        view.$el.attr 'style',"""
          background: url(img/#{fl}/#{fl}_fundo.png) center center no-repeat;
          background-size: cover;
          """
        view.$el.wrap "<a href='#queda/#{fl}'></a>"
        console.log css
      "onItemClose": ()->
        console.log 'Queda onItemClose'

    ui:
      ok:'ok'

    onRender: ->
       console.log 'quedasModel', @model

  Quedas