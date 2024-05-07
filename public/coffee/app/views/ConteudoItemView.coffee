define [
  'backbone.marionette'
  './ModalElegivel'
], (Marionette, ModalElegivel) ->
  class ConteudoItemView extends Marionette.ItemView
    tagName: 'div'
    className: 'conteudo'
    initialize: () ->
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


