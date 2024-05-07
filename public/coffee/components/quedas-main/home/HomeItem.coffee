define [
], () ->

  class QuedaItemView extends Marionette.ItemView

    tagName: 'a'

    className: 'queda-item col-md-4 col-sm-6 col-xs-12'

    initialize: ->
      console.log arguments, this

    template: '#quedas-main-home-item'

    events:
      'click': 'sayMe'

    onRender:() ->
      folder = @model.get 'folder'
      urlFundo = "url(img/#{folder}/#{folder}_fundo.png)"
      @$el.css
        'background-image': urlFundo

    sayMe: ()->
      App.appRouter.navigate "comp/quedas-main/#{@model.get 'folder'}", trigger: on


  QuedaItemView