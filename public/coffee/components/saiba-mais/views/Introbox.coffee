define [
], () ->

  class Introbox extends Marionette.ItemView

    'template': '#saiba-mais-introbox'

    'className': 'container-fluid introbox-container'

    'initialize': (options)->

    # events:
    #   'click .gotoReturn': 'gotoReturn'
    ui:
      'voltarUnidade': '#voltarUnidade'
      'unidade': '#unidade'

    # gotoReturn: ()->
    # 	if App.appRouter.historico.length > 1
    # 		App.appRouter.previous()
    # 	else
    # 		App.appRouter.navigate "comp/selecao-progresso", true
    onRender: ->
      self = @
      console.log @model, 'modelo introbox'
      unis = _.where( window.modulo.components, {folder : 'unidade-progresso'})
      uni = unis.filter (u)->
        if(!u.resource)
          return false
        casos = u.resource.casos.filter (c)->
          c._id == self.model.get('_id')
        casos.length > 0
      if uni.length > 0
        short = uni[0].short
        @ui.voltarUnidade.css({display:'block'})
        @ui.voltarUnidade.attr({href: "#comp/unidade-progresso/"+short})
        @ui.unidade.html(short)



  Introbox