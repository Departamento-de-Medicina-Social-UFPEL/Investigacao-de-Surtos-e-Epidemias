define [
  'backbone.modal'
  'utils'
  'uf_municipios'
], (ModalView, utils, Uf) ->

  class Modal extends Backbone.Modal
    initialize: (cpf) ->
      if App.user
        this.cpf = App.user.cpf
      else
        this.cpf = cpf
      console.log this.cpf, 'cpf'

    template: _.template($('#enquetes-cadastro').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'
    # moduloId: "59a0be22a8b9ce7531974290"

    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10
      @marcaRespostas()

    marcaRespostas: ->
      self = @
      if App.user.enquetes
        if App.user.enquetes[App.moduloId]
          enquete = App.user.enquetes[App.moduloId].cadastro
          if enquete
            self.$el.find('input[name=optionRadios1][value='+enquete['pergunta1']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios21][value='+enquete['pergunta21']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios22][value='+enquete['pergunta22']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios23][value='+enquete['pergunta23']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios24][value='+enquete['pergunta24']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios25][value='+enquete['pergunta25']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios3][value='+enquete['pergunta3']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios4][value='+enquete['pergunta4']+']').prop('checked',true)

            self.$el.find('input[name=outrooptionRadios4]').val(enquete['pergunta4outro'])
            self.$el.find('input[name=outrooptionRadios1]').val(enquete['pergunta1outro'])

    naoDesejo: ->
      # console.log 'destroy enquete-cadastro'
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      if App.user
        if not App.user.enquetes
          App.user['enquetes'] = {}
        if not App.user.enquetes[App.moduloId]
          App.user.enquetes[App.moduloId] = {}
        if not App.user.enquetes[App.moduloId].cadastro
          App.user.enquetes[App.moduloId].cadastro = {'naodesejoresponder':true}
        @destroy()
        Backbone.history.navigate '#comp/home', {trigger: yes}
        App.execute 'storeUserEnquete', {cpf:App.user.cpf, modulo:App.moduloId, cadastro: App.user.enquetes[App.moduloId].cadastro }, (resposta)->
          console.log('nao desejo responder salvo server', resposta)

    beforeSubmit: (ev) ->
      console.log 'submit-form'
      # if not @cadastro
      #   return
      @hadFocus = @$el.find 'a.btn.submit-form'
      @$el.find('.btn').attr 'disabled', true
      @$el.find('input').attr 'disabled', true
      @$el.find('select').attr 'disabled', true
      validUser = @validaForm(false)
      if validUser
        @salvaUser validUser
      else
        @$el.find('.btn').removeAttr 'disabled'
        @$el.find('input').removeAttr 'disabled'
        @$el.find('select').removeAttr 'disabled'
      false


    events:
      'click #fechar-enquete-cadastro': 'naoDesejo'

    exibeErro: (mensagemErro, erro = false)->
      if not erro
        @$el.find('.alert').removeClass('alert-success').addClass('alert-danger').empty()
      else
        @$el.find('.alert').removeClass('alert-danger').addClass('alert-sucess').empty()
        @$el.find('.btn').attr 'disabled', false
      @$el.find('input').attr 'disabled', false
      @$el.find('select').attr 'disabled', false
      @$el.find('.alert').append mensagemErro
      @$el.find('.alert').show()

    limpaError: (evt)->
      @$el.find('.alert').removeClass('alert-warning alert-success').hide()
      # self.$el.find('input[name=optionRadios1]').parent().parent().addClass 'has-error'
      $('.has-error').removeClass('has-error');
      $('.has-success').removeClass('has-success');
      $('.has-warning').removeClass('has-warning');
       # has-success has-warning
      # $(evt.target).parent().removeClass 'has-error has-success has-warning'

    concorda: (evt)->
      el = $ evt.target
      chk = el.attr 'checked'
      return el.removeAttr('checked') if chk is 'checked'
      el.attr 'checked', 'checked'

    validaForm: (silent = true)->
      self = this
      self.limpaError()
      campoProblema = []
      mensagemErro = ''
      if ( not self.$el.find('input[name=optionRadios1]:checked').val()) or ( not self.$el.find('input[name=outrooptionRadios1]').val() and self.$el.find('input[name=optionRadios1]:checked').val() == 'outro' )
        if ( not self.$el.find('input[name=outrooptionRadios1]').val() and self.$el.find('input[name=optionRadios1]:checked').val() == 'outro' )
          campoProblema.push self.$el.find('input[name=outrooptionRadios1]')
          self.$el.find('input[name=outrooptionRadios1]').parent().parent().addClass 'has-error'
          mensagemErro += 'A pergunta 1 não foi respondida completamente. Especifique a outra opção.<br>'
        else
          campoProblema.push self.$el.find('input[name=optionRadios1]')
          self.$el.find('input[name=optionRadios1]').parent().parent().addClass 'has-error'
          mensagemErro += 'A pergunta 1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios21]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios21]')
        self.$el.find('input[name=optionRadios21]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 2.1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios22]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios22]')
        self.$el.find('input[name=optionRadios22]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 2.2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios23]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios23]')
        self.$el.find('input[name=optionRadios23]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 2.3 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios24]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios24]')
        self.$el.find('input[name=optionRadios24]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 2.4 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios25]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios25]')
        self.$el.find('input[name=optionRadios25]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 2.5 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios3]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios3]')
        self.$el.find('input[name=optionRadios3]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios4]:checked').val() or ( not self.$el.find('input[name=outrooptionRadios4]').val() and self.$el.find('input[name=optionRadios4]:checked').val() == 'outro')
        if ( not self.$el.find('input[name=outrooptionRadios4]').val() and self.$el.find('input[name=optionRadios4]:checked').val() == 'outro' )
          campoProblema.push self.$el.find('input[name=outrooptionRadios4]')
          self.$el.find('input[name=outrooptionRadios4]').addClass 'has-error'
          mensagemErro += 'A pergunta 4 não foi respondida completamente. Especifique a outra opção.<br>'
        else
          campoProblema.push self.$el.find('input[name=optionRadios4]')
          self.$el.find('input[name=optionRadios4]').parent().parent().addClass 'has-error'
          mensagemErro += 'A pergunta 4 não foi respondida.<br>'
      console.log campoProblema, 'campoProblema'
      if campoProblema.length > 0
        @$el.find('input').attr 'disabled', false
        @$el.find('select').attr 'disabled', false
        @exibeErro(mensagemErro)
        campoProblema[0].focus() if @hadFocus.is 'a.btn.submit-form'
        return false
      else
        enquete = {
          'pergunta1': self.$el.find('input[name=optionRadios1]:checked').val()
          'pergunta1outro': self.$el.find('input[name=outrooptionRadios1]').val()
          'pergunta21': self.$el.find('input[name=optionRadios21]:checked').val()
          'pergunta22': self.$el.find('input[name=optionRadios22]:checked').val()
          'pergunta23': self.$el.find('input[name=optionRadios23]:checked').val()
          'pergunta24': self.$el.find('input[name=optionRadios24]:checked').val()
          'pergunta25': self.$el.find('input[name=optionRadios25]:checked').val()
          'pergunta3': self.$el.find('input[name=optionRadios3]:checked').val()
          'pergunta4': self.$el.find('input[name=optionRadios4]:checked').val()
          'pergunta4outro': self.$el.find('input[name=outrooptionRadios4]').val()
        }
      console.log enquete, 'respostas'
      return {
        'cpf': @cpf
        'modulo': App.moduloId
        'cadastro': enquete
      }

    salvaUser: (user) ->
      self = this
      self.$el.find('input').attr 'disabled', true
      self.$el.find('select').attr 'disabled', true
      self.$el.find('.alert')
      .removeClass 'alert-danger'
      .addClass 'alert-success'
      .empty()

      user.synced = off

      destroyCallback = ()->
        (setTimeout (()->App.modals.destroyAll()), 1) if App.modals.currentView
        Backbone.history.navigate '/', {trigger: yes}
      
      self.$el.find('.alert').html('<h3>Enquete salva neste navegador</h3>')
      self.$el.find('.btn').attr 'disabled', true
      App.execute 'storeUserEnquete', user, (resposta)->
        if resposta.ok
          $('.dropdown-componentes').find('ul.dropdown-menu li').show()
          erro = '<h3>Respostas da enquete salvas no servidor</h3>'
          self.exibeErro erro, false
          setTimeout destroyCallback(), 1000
        else
          erro = '<h3>'+resposta.msg+'</h3>'
          self.exibeErro erro, true

