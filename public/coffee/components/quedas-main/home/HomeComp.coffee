define [
  './HomeItem'
], (QuedaItemView, quedasTemplate) ->

  class Quedas extends Marionette.CompositeView

    className: 'item quedas container'

    initialize: ->
      @collection = App.quedas

    template: '#quedas-main-home-main'

    childView: QuedaItemView

    childViewContainer: '.lista-quedas'

    childEvents:
      "render": (evt, view)->
        # console.log arguments
        fl = view.model.get 'folder'
        nm = view.model.get 'nome'
        css = 'background': "url(#{defaultStaticFileService}/img/#{fl}/#{fl}_fundo.png) cover no-repeat"
        view.$el.attr 'style',"""
          background: url(#{defaultStaticFileService}/img/#{fl}/#{fl}_fundo.png) center center no-repeat;
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