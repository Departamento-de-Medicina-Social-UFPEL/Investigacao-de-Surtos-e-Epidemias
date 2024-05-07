define [
  './models/Caso'
  './views/MainCasoLayout'
  './views/NotFound'
], (CasoModel, MainCasoView, NotFoundView) ->

  "mostraCaso": (id) ->
    return unless App.user
    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10
    teste = App.testes.findWhere _id: id.toLowerCase()
    ehFinal = /final/img.test teste.get 'titulo'

    # console.log teste, teste.get('titulo'), ehFinal

    pro = teste.get('profissional')
    nc = pro.slice(0,1)+pro.slice(1).toLowerCase()
    if nc.indexOf(' ') > -1
      nc = nc.split(' ')[0]
    uni = teste.get('unidade')
    console.log(uni, 'unidade teste progresso')
    if window.modulo.fl_por_unidade
      block = App.masterFinalLockUnidade(uni)
    else
      block = App['masterFinalLock'+nc]()
    if ehFinal
      if App
        if block
          mainRoute = window.modulo.navigateOnStart
          return Backbone.history.navigate "#{mainRoute}/teste-bloqueado", {trigger: true}

    ViewType = NotFoundView
    if teste
      ViewType = MainCasoView
      opt = {model: teste}
    mainView = new ViewType opt
    App.main.show mainView

