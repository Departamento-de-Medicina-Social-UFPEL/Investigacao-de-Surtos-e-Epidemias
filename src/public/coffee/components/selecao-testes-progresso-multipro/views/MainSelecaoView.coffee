define [
  'marionette'
], (Marionette) ->
  class MainSelecaoLayout extends Marionette.ItemView
    template: '#selecao-testes-progresso-multipro-main'
    className: 'container selecao-teste-multipro'
    initialize: () ->
      {user, progresso} = App
      @collection.each (teste)->
        if user
          rs = progresso.where('atividade': teste.get '_id').map (i)-> i.attributes
          g = progresso.geral
          lockTesteFinal = off
          unless (g.percCasosConcluTotal >= 70) and (g.percGeralAcertoCasos >= 70)
            lockTesteFinal = yes
        teste.set 'respostas': rs || []
        teste.set {lockTesteFinal}

      this

    events:
      'click .emitir-certificado': 'emitirCertificado'


    emitirCertificado: (evt)->
      do evt.stopPropagation
      App.execute 'certificado', ()->
        console.log arguments
    
    gotoTeste: (evt) ->
      id = $(evt.target).closest('.teste').data('id')
      url = "comp/selecao-testes-progresso/teste-bloqueado"
      lock = do App.masterFinalLock
      teste = App.testes.where(_id: id)
      isPos = off
      if teste.length > 0
        isPos = teste[0].get 'posTeste'
      unless isPos and lock
        url = App['selecao-testes-progresso-multipro'].routeFactory id
      
      console.log id, url, lock, isPos

      Backbone.history.navigate url, {trigger: on}


    onRender: () ->
      @$el.find('.teste').on 'click', @gotoTeste
    	# console.log @collection
    


