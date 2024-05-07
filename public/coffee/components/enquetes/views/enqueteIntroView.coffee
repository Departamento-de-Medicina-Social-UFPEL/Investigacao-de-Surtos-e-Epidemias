define [
  'backbone.modal'
  'utils'
  'uf_municipios'
], (ModalView, utils, Uf) ->

  class Modal extends Backbone.Modal
    initialize: (cpf, tipo) ->
      if App.user
        this.cpf = App.user.cpf
      else
        this.cpf = cpf

      this.model = new Backbone.Model({tipo:tipo})
      switch tipo
        when 'conclusao'
          subtitulo = 'Conclusão da Oferta'
        when 'encerramento'
          subtitulo = 'Encerramento de Oferta'
        else
          subtitulo = 'Cadastro'
      this.model.set 'subtitulo', subtitulo
      
      # console.log cpf, 'cpf', tipo, 'tipo', this.model

    template: _.template($('#enquetes-introducao').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'
    # moduloId: "59a0be22a8b9ce7531974290"

    onRender: ->
      console.log 'render enquete cadastro'
      b = $('body')
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10

    naoDesejo: ->
      if App.user
        if not App.user.enquetes
          App.user['enquetes'] = {}
        if not App.user.enquetes[App.moduloId]
          App.user.enquetes[App.moduloId] = {}
        if not App.user.enquetes[App.moduloId][this.model.get('tipo')]
          App.user.enquetes[App.moduloId][this.model.get('tipo')] = {'naodesejoresponder':true}
        @destroy()
        Backbone.history.navigate '#comp/home', {trigger: yes}
        UserEnquete = {cpf:App.user.cpf, modulo:App.moduloId}
        UserEnquete[this.model.get('tipo')] = App.user.enquetes[App.moduloId][this.model.get('tipo')]
        App.execute 'storeUserEnquete', UserEnquete , (resposta)->
          console.log('nao desejo responder salvo server', resposta)

    events:
      'click #fechar-enquete': 'naoDesejo'
      'click #btn-responder': 'responder'

    responder:->
      Backbone.history.navigate '#comp/enquetes/'+this.model.get('tipo')+'/'+App.user.cpf, {trigger: yes}
      @destroy()

