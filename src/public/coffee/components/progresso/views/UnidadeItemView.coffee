define [
  './ErrorView'
], (ErrorView) ->

  class ConteudoView extends Marionette.ItemView


    initialize: ->
      if(App.socket)
        @model.set('fl_cert_conectado': App.socket.connected)
      @model.set('fl_inscrito', false)
      @model.set('fl_concluinte', false)
      #console.log 'cor', @model
      if not @model.get('cor')
        @model.set('corFonte', '#'+window.modulo.corPadrao)
        @model.set('corIntro', 'eee')
        @model.set('corElementos', window.modulo.corPadrao)
      else
        @model.set('corFonte', 'white')
        @model.set('corIntro', @model.get('cor'))
        @model.set('corElementos', @model.get('cor'))

    className: ''
    tagName:'li'

    template: '#progresso-unidade-item'

    ui:
      'concluinte':'#checkbox-concluinte'
      'checkCaso':'#check-box-casos-clinicos'
      'checkTeste':'#check-box-pos-teste'
    events: {}


    onRender: ->
      #console.log @model.attributes, 'model unidade'
      @ui.concluinte.prop("checked", @model.get('elegivel'))
      @$el.addClass(@model.get('nucleo').toLowerCase())
      @ui.checkCaso.prop("checked", @model.get('fl_cert_casos_clinicos'))
      @ui.checkTeste.prop("checked", @model.get('fl_cert_pos_teste'))




  ConteudoView