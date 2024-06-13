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

    template: _.template($('#enquetes-encerramento_oferta').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'
    # moduloId: "59a0be22a8b9ce7531974290"

    onRender: ->
      b = $('body')
      # # @fillForm() if @user
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10
      @$el.find('#inputCpf').val(@cpf)
      if @cpf
        @$el.find('#inputCpf').attr 'disabled', true
      @marcaRespostas()

    marcaRespostas: ->
      self = @
      if App.user.enquetes
        if App.user.enquetes[App.moduloId]
          enquete = App.user.enquetes[App.moduloId].encerramento
          if enquete
            self.$el.find('input[name=optionRadios11][value='+enquete['pergunta11']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios12][value='+enquete['pergunta12']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios13][value='+enquete['pergunta13']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios14][value='+enquete['pergunta14']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios15][value='+enquete['pergunta15']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios16][value='+enquete['pergunta16']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios17][value='+enquete['pergunta17']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios18][value='+enquete['pergunta18']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox21][value='+enquete['pergunta21']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox22][value='+enquete['pergunta22']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox23][value='+enquete['pergunta23']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox24][value='+enquete['pergunta24']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox25][value='+enquete['pergunta25']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox26][value='+enquete['pergunta26']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox27][value='+enquete['pergunta27']+']').prop('checked', true)
            self.$el.find('input[name=optioncheckbox28][value='+enquete['pergunta28']+']').prop('checked', true)
            self.$el.find('input[name=optionRadios3][value='+enquete['pergunta3']+']').prop('checked', true)

    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      if App.user
        if not App.user.enquetes
          App.user['enquetes'] = {}
        if not App.user.enquetes[App.moduloId]
          App.user.enquetes[App.moduloId] = {}
        if not App.user.enquetes[App.moduloId].encerramento
          App.user.enquetes[App.moduloId].encerramento = {'naodesejoresponder':true}
          App.execute 'storeUserEnquete', {cpf:App.user.cpf, modulo:App.moduloId, encerramento: App.user.enquetes[App.moduloId].encerramento }, (resposta)->
            console.log('nao desejo responder salvo server', resposta)
        App.execute 'storeUserEnquete', App.user, (resposta)->
          window.location.href = 'https://dms.ufpel.edu.br/p2k'
      window.location.href = 'https://dms.ufpel.edu.br/p2k'

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
      'click #fechar-enquete-encerramento': 'destroy'

    exibeErro: (mensagemErro)->
      @$el.find('.alert').addClass 'alert-danger'
      @$el.find('.alert').empty()
      @$el.find('.alert').append mensagemErro
      @$el.find('.alert').show()

    limpaError: (evt)->
      @$el.find('.alert').removeClass('alert-warning alert-success').hide()
      $('.has-error').removeClass('has-error')
      $('.has-success').removeClass('has-success')
      $('.has-warning').removeClass('has-warning')

    concorda: (evt)->
      el = $ evt.target
      chk = el.attr 'checked'
      return el.removeAttr('checked') if chk is 'checked'
      el.attr 'checked', 'checked'

    validaForm: (silent = true)->
      self = this
      campoProblema = []
      mensagemErro = ''
      if self.$el.find('input[name=inputCpf]').val().trim().length isnt 11
        campoProblema.push self.$el.find('input[name=inputCpf]')
        self.$el.find('input[name=inputCpf]').parent().parent().addClass 'has-error'
        mensagemErro += 'CPF inválido.<br>'
      if not self.$el.find('input[name=optionRadios11]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios11]')
        self.$el.find('input[name=optionRadios11]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios12]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios12]')
        self.$el.find('input[name=optionRadios12]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios13]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios13]')
        self.$el.find('input[name=optionRadios13]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.3 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios14]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios14]')
        self.$el.find('input[name=optionRadios14]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.4 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios15]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios15]')
        self.$el.find('input[name=optionRadios15]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.5 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios16]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios16]')
        self.$el.find('input[name=optionRadios16]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.6 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios17]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios17]')
        self.$el.find('input[name=optionRadios17]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.7 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios18]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios18]')
        self.$el.find('input[name=optionRadios18]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 1.8 não foi respondida.<br>'
      marcacoesPergunta2 = 0
      if not self.$el.find('input[name=optioncheckbox21]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox22]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox23]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox24]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox25]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox26]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox27]:checked').val()
        marcacoesPergunta2++
      if not self.$el.find('input[name=optioncheckbox28]:checked').val()
        marcacoesPergunta2++
      if marcacoesPergunta2 > 5
        campoProblema.push self.$el.find('input[name=optionRadios28]')
        self.$el.find('input[name=optionRadios21]').parent().parent().addClass 'has-error'
        mensagemErro += 'Para pergunta 2 são necessárias pelo menos 3 marcações.<br>'
      if not self.$el.find('input[name=optionRadios3]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios3]')
        self.$el.find('input[name=optionRadios3]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3 não foi respondida.<br>'
      if campoProblema.length > 0
        @$el.find('input').attr 'disabled', false
        @$el.find('select').attr 'disabled', false
        @exibeErro(mensagemErro)
        campoProblema[0].focus() if @hadFocus.is 'a.btn.submit-form'
        return false
      else
        enquete = {
          'pergunta11': self.$el.find('input[name=optionRadios11]:checked').val()
          'pergunta12': self.$el.find('input[name=optionRadios12]:checked').val()
          'pergunta13': self.$el.find('input[name=optionRadios13]:checked').val()
          'pergunta14': self.$el.find('input[name=optionRadios14]:checked').val()
          'pergunta15': self.$el.find('input[name=optionRadios15]:checked').val()
          'pergunta16': self.$el.find('input[name=optionRadios16]:checked').val()
          'pergunta17': self.$el.find('input[name=optionRadios17]:checked').val()
          'pergunta18': self.$el.find('input[name=optionRadios18]:checked').val()
          'pergunta21': self.$el.find('input[name=optioncheckbox21]:checked').val()
          'pergunta22': self.$el.find('input[name=optioncheckbox22]:checked').val()
          'pergunta23': self.$el.find('input[name=optioncheckbox23]:checked').val()
          'pergunta24': self.$el.find('input[name=optioncheckbox24]:checked').val()
          'pergunta25': self.$el.find('input[name=optioncheckbox25]:checked').val()
          'pergunta26': self.$el.find('input[name=optioncheckbox26]:checked').val()
          'pergunta27': self.$el.find('input[name=optioncheckbox27]:checked').val()
          'pergunta28': self.$el.find('input[name=optioncheckbox28]:checked').val()
          'pergunta3': self.$el.find('input[name=optionRadios3]:checked').val()
        }
      return {
        'cpf': self.$el.find('input[name=inputCpf]').val().trim()
        'encerramento': enquete
        'modulo': App.moduloId
      }

    salvaUser: (user) ->
      self = this
      self.$el.find('input').attr 'disabled', true
      self.$el.find('select').attr 'disabled', true
      self.$el.find('.alert')
      .removeClass 'alert-danger'
      .addClass 'alert-success'
      .empty()

      destroyCallback = ()->
        (setTimeout (()->App.modals.destroyAll()), 1) if App.modals.currentView
        if not App.main.currentView
          Backbone.history.navigate '#comp/home', {trigger: yes}
      
      self.$el.find('.alert').html('<h3>Enquete salva neste navegador</h3>')
      self.$el.find('.btn').attr 'disabled', true
      App.execute 'storeUserEnquete', user, (resposta)->
        if resposta.ok
          $('.dropdown-componentes').find('ul.dropdown-menu li').show()
          self.$el.find('.alert').html('<h3>Respostas da enquete salvas no servidor</h3>')
          self.$el.find('.alert').show()
          self.$el.find('.btn').hide()
          setTimeout destroyCallback(), 1000
        else
          self.$el.find('.alert').removeClass('alert-success').addClass('alert-danger').empty()
          erro = '<h3>'+resposta.msg+'</h3>'
          self.$el.find('.btn').attr 'disabled', false
          self.$el.find('.alert').html(erro)
          self.$el.find('.alert').show()

