define [
  'backbone.marionette'
  './ModalElegivel'
], (Marionette, ModalElegivel) ->
  class ConteudoItemView extends Marionette.ItemView
    tagName: 'div'
    className: 'conteudo'
    initialize: () ->
      console.log @model, 'model'
      conteudo = @model.get('conteudo')
      conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
      g = App.progresso.geral
      sigla = ''
      nr_elegivel = 0
      ofertas = []
      percAcertoPreTeste = g['percAcertoPreTeste'+conteudo].toFixed(1)
      percCasos = g['percCasosConcluNucleo'+conteudo].toFixed(1)
      percAcertoPosTeste = g['percAcertoPosTeste'+conteudo].toFixed(1)
      elegivel =  App["masterElegivelCert"+conteudo]()
      masterLock = App["masterFinalLock"+conteudo]()
      switch conteudo
        when 'Enfermagem'
          sigla = '<span class=\'pro-tag enf\'>E</span>'
        when 'Medicina'
          sigla = '<span class=\'pro-tag med\'>M</span>'
        when 'Odontologia'
          sigla = '<span class=\'pro-tag odo\'>O</span>'
        when 'Interdisciplinar'
          sigla = '<span class=\'pro-tag \' style=\'background: darkgoldenrod!important;\'>I</span>'
        else
          break
      @model.set 'nucleo', conteudo
      @model.set 'elegivel', elegivel
      @model.set 'categories', []
      @model.set 'lockTesteFinal', masterLock
      @model.set 'fl_cert_casos_clinicos', (percCasos >= 70 )
      @model.set 'fl_cert_pos_teste', (percAcertoPosTeste >= 70 )
      @model.set 'titulo', if @model.get('tipo') isnt 'integrador' then conteudo else 'Integral'
      @model.set 'sigla',sigla
      @model.set 'percAcertoPreTeste', percAcertoPreTeste 
      @model.set 'percCasos', percCasos 
      @model.set 'percAcertoPosTeste', percAcertoPosTeste 
      if not @model.get('cor')
        @model.set('corFonte', '#'+window.modulo.corPadrao)
        @model.set('corIntro', 'eee')
        @model.set('corElementos', window.modulo.corPadrao)
        @model.set('unidade', false)
      else
        @model.set('corFonte', 'white')
        @model.set('corIntro', @model.get('cor'))
        @model.set('corElementos', @model.get('cor'))
      @className = @model.get 'style' || ''
    template: _.template($('#item-conteudo-drop-template').html(), {
      interpolate: /\<\@\=(.+?)\@\>/gim
      evaluate: /\<\@([\s\S]+?)\@\>/gim
      escape: /\<\@\-(.+?)\@\>/gim
    })
    ui:
      'progresso':'.progresso-item'
    
    avisaConclusaoRequisitos:->
      conteudo = @model.get('nucleo')
      if @model.get('elegivel')
        key = App.user.cpf + '_fl_elegivel_'+ @model.get('id_arouca')
        jaAvisou = App.local.get key
        if not jaAvisou
          App.local.set key, true
          App.modals.destroyAll() if App.modals.currentView
          modelo = new Backbone.Model({conteudo: conteudo})
          App.modals.show new ModalElegivel({model:modelo});

    onRender: ->
      @avisaConclusaoRequisitos()


