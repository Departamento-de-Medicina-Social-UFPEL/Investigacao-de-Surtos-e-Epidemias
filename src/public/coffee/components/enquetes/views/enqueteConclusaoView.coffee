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

    template: _.template($('#enquetes-conclusao').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'
    # moduloId: "59a0be22a8b9ce7531974290"

    onRender: ->
      b = $('body')
      # # @fillForm() if @user
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10
      @marcaRespostas()

    marcaRespostas: ->
      self = @
      if App.user.enquetes
        if App.user.enquetes[App.moduloId]
          enquete = App.user.enquetes[App.moduloId].conclusao
          if enquete
            self.$el.find('input[name=optionRadios11][value='+enquete['pergunta11']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios12][value='+enquete['pergunta12']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios13][value='+enquete['pergunta13']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios2][value='+enquete['pergunta2']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios31][value='+enquete['pergunta31']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios32][value='+enquete['pergunta32']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios33][value='+enquete['pergunta33']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios34][value='+enquete['pergunta34']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios35][value='+enquete['pergunta35']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios36][value='+enquete['pergunta36']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios37][value='+enquete['pergunta37']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios41][value='+enquete['pergunta41']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios42][value='+enquete['pergunta42']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios43][value='+enquete['pergunta43']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios44][value='+enquete['pergunta44']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios45][value='+enquete['pergunta45']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios5][value='+enquete['pergunta5']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios6][value='+enquete['pergunta6']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios71][value='+enquete['pergunta71']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios72][value='+enquete['pergunta72']+']').prop('checked',true)
            self.$el.find('input[name=optionRadios73][value='+enquete['pergunta73']+']').prop('checked',true)
            self.$el.find('input[name=outrooptionRadios2]').val(enquete['pergunta2outro'])


    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      if App.user
        if not App.user.enquetes
          App.user['enquetes'] = {}
        if not App.user.enquetes[App.moduloId]
          App.user.enquetes[App.moduloId] = {}
        if not App.user.enquetes[App.moduloId].conclusao
          App.user.enquetes[App.moduloId].conclusao = {'naodesejoresponder':true}
          App.execute 'storeUserEnquete', {cpf:App.user.cpf, modulo:App.moduloId, conclusao: App.user.enquetes[App.moduloId].conclusao }, (resposta)->
            console.log('nao desejo responder salvo server', resposta)
      Backbone.history.navigate '#comp/progresso', {trigger: yes}

    beforeSubmit: (ev) ->
      console.log 'submit-form'
      # if not @conclusao
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
      'click #fechar-enquete-conclusao': 'destroy'

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
      if ( not self.$el.find('input[name=optionRadios2]:checked').val()) or ( not self.$el.find('input[name=outrooptionRadios2]').val() and self.$el.find('input[name=optionRadios2]:checked').val() == 'outro' )
        if ( not self.$el.find('input[name=outrooptionRadios2]').val() and self.$el.find('input[name=optionRadios2]:checked').val() == 'outro' )
          campoProblema.push self.$el.find('input[name=outrooptionRadios2]')
          self.$el.find('input[name=outrooptionRadios2]').parent().parent().addClass 'has-error'
          mensagemErro += 'A pergunta 2 não foi respondida completamente. Especifique a outra opção.<br>'
        else
          campoProblema.push self.$el.find('input[name=optionRadios2]')
          self.$el.find('input[name=optionRadios2]').parent().parent().addClass 'has-error'
          mensagemErro += 'A pergunta 2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios31]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios31]')
        self.$el.find('input[name=optionRadios31]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios32]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios32]')
        self.$el.find('input[name=optionRadios32]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios33]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios33]')
        self.$el.find('input[name=optionRadios33]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.3 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios34]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios34]')
        self.$el.find('input[name=optionRadios34]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.4 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios35]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios35]')
        self.$el.find('input[name=optionRadios35]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.5 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios36]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios36]')
        self.$el.find('input[name=optionRadios36]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.6 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios37]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios37]')
        self.$el.find('input[name=optionRadios37]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.7 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios38]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios38]')
        self.$el.find('input[name=optionRadios38]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 3.8 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios41]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios41]')
        self.$el.find('input[name=optionRadios41]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 4.1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios42]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios42]')
        self.$el.find('input[name=optionRadios42]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 4.2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios43]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios43]')
        self.$el.find('input[name=optionRadios43]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 4.3 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios44]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios44]')
        self.$el.find('input[name=optionRadios44]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 4.4 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios45]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios45]')
        self.$el.find('input[name=optionRadios45]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 4.5 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios5]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios5]')
        self.$el.find('input[name=optionRadios5]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 5 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios6]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios6]')
        self.$el.find('input[name=optionRadios6]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 6 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios71]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios71]')
        self.$el.find('input[name=optionRadios71]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 7.1 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios72]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios72]')
        self.$el.find('input[name=optionRadios72]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 7.2 não foi respondida.<br>'
      if not self.$el.find('input[name=optionRadios73]:checked').val()
        campoProblema.push self.$el.find('input[name=optionRadios73]')
        self.$el.find('input[name=optionRadios73]').parent().parent().addClass 'has-error'
        mensagemErro += 'A pergunta 7.3 não foi respondida.<br>'
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
          'pergunta2': self.$el.find('input[name=optionRadios2]:checked').val()
          'pergunta2outro': self.$el.find('input[name=outrooptionRadios2]').val()
          'pergunta31': self.$el.find('input[name=optionRadios31]:checked').val()
          'pergunta32': self.$el.find('input[name=optionRadios32]:checked').val()
          'pergunta33': self.$el.find('input[name=optionRadios33]:checked').val()
          'pergunta34': self.$el.find('input[name=optionRadios34]:checked').val()
          'pergunta35': self.$el.find('input[name=optionRadios35]:checked').val()
          'pergunta36': self.$el.find('input[name=optionRadios36]:checked').val()
          'pergunta37': self.$el.find('input[name=optionRadios37]:checked').val()
          'pergunta41': self.$el.find('input[name=optionRadios41]:checked').val()
          'pergunta42': self.$el.find('input[name=optionRadios42]:checked').val()
          'pergunta43': self.$el.find('input[name=optionRadios43]:checked').val()
          'pergunta44': self.$el.find('input[name=optionRadios44]:checked').val()
          'pergunta45': self.$el.find('input[name=optionRadios45]:checked').val()
          'pergunta5': self.$el.find('input[name=optionRadios5]:checked').val()
          'pergunta6': self.$el.find('input[name=optionRadios6]:checked').val()
          'pergunta71': self.$el.find('input[name=optionRadios71]:checked').val()
          'pergunta72': self.$el.find('input[name=optionRadios72]:checked').val()
          'pergunta73': self.$el.find('input[name=optionRadios73]:checked').val()
        }
      console.log enquete, 'respostas'
      return {
        'cpf': @cpf
        'modulo': App.moduloId
        'conclusao': enquete
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
          Backbone.history.navigate '#', {trigger: yes}
      
      self.$el.find('.alert').html('<h3>Enquete salva neste navegador</h3>')
      self.$el.find('.btn').attr 'disabled', true
      console.log(user, 'user')
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

