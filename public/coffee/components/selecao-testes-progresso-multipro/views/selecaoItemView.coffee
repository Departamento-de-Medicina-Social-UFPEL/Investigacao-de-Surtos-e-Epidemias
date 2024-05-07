define [
  'marionette'
], (Marionette) ->
  class ItemListaCaso extends Marionette.ItemView

    template: '#selecao-testes-progresso-itemView'
    className: 'item-lista-caso-selecao-progresso'
    initialize: ->
      {user, progresso} = App
      if user
        rs = progresso.where('atividade': @model.get '_id').map (i)-> i.attributes
        g = progresso.geral
        lockTesteFinal = off
        unless (g.percCasosConcluTotal >= 70) and (g.percGeralAcertoCasos >= 70)
          lockTesteFinal = yes
      @model.set 'respostas': rs || []
      @model.set {lockTesteFinal}

    events:
      'click': 'gotoCaso'
      'click .gotoInicial': 'gotoInicial'
      'click .gotoFinal': 'gotoFinal'

    gotoCaso: ->
      url = "comp/selecao-testes-progresso-multipro/teste-bloqueado"
      console.log App.masterFinalLock
      unless do App.masterFinalLock
        url = App['selecao-testes-progresso'].routeFactory @model.get('_id')

      Backbone.history.navigate url, {trigger: on}

    gotoInicial: () ->
      p = App.user.profissional
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap[p]
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinal: () ->
      p = App.user.profissional
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap[p]

      if (uPro is 9) or do App.masterFinalLock
        return Backbone.history.navigate "comp/selecao-testes-progresso-multipro/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    onRender: ->
