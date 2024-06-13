define [
  'backbone.modal'
  'utils'
  'uf_municipios'
], (ModalView, utils, Uf) ->

  class Modal extends Backbone.Modal
    initialize: (@user) ->
      if App.user
        @cadastro = true
      else
        @cadastro = false

    template: _.template($('#cadastro-template').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'
    estagio: 0

    onRender: ->
      @montaComboEstados()
      @user = App.local.get('user')

      # console.log @cadastro, "cadastro", App.moduloId
      if @cadastro
        #$('.form-group').show()
        $(".form-group[data-estagio=" + @estagio + "]").show()
        @$el.find('.btn-avancar').hide()
        @$el.find('.btn-voltar').hide()
        @$el.find('.submit-form').css({display:'inline-block'})
        @$el.find('.close-modal').css({display:'inline-block'})
        @$el.find('.form-group').show()
        @$el.find('.termos').show()
        @$el.find('#inputCpf').attr('disabled', true);
        @$el.find('.ja-cadastrado').hide()
        @marcaInscritas()
      if window.modulo.ofertasAbertas.length is 1
        o = window.modulo.ofertasAbertas[0]
        cx = "input[value="+o.id_arouca+"]"
        @$el.find(cx).prop 'checked', true

      $('.bbm-modal--open').css({"margin-bottom": "235px"})

      b = $('body')
      @fillForm() if @user
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10

    marcaInscritas:()->
      self = @
      if not @user
        return
      hoje = new Date()
      console.log @user.ofertas, 'ofertas do usuario'
      if @user.ofertas
        @user.ofertas.forEach (o)->
          if o.modulo is App.moduloId #and ( (new Date(o.data_inicio)) <= hoje and (new Date(o.data_fim_matricula)) >= hoje  )
            cx = "input[value="+o.id_arouca+"]"
            self.$el.find(cx).prop 'checked', true

    obtemOfertas:()->
      ofertasInscritas = []
      ofertasInscritas = window.modulo.ofertasAbertas.filter (o)->
        $('input[value="'+o.id_arouca+'"]').is(':checked') is true
      ofertasInscritas

    onDestroy: ->
      # console.log 'destroy cadastro', App.appRouter.historico[App.appRouter.historico.length-2]
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      App.appRouter.navigate '/', 'trigger': yes

    fillForm: () ->
      console.log @user, 'user'
      @$el.find('#inputNome').val(@user.nome)
      @$el.find('#inputNomeMae').val(@user.nomeMae)
      @$el.find('#inputCpf').val(@user.cpf)
      @$el.find('#inputEmail').val(@user.email)
      if @user.profissional
        @$el.find('#inputNucleoProfissional').val(@user.profissional)
      if @user.nucleo_profissional
        @$el.find('#inputNucleoProfissional').val(@user.nucleo_profissional)

      @$el.find('#dataNasc_dia').val(@user.dataNasc_dia)
      @$el.find('#dataNasc_mes').val(@user.dataNasc_mes)
      @$el.find('#dataNasc_ano').val(@user.dataNasc_ano)
      @$el.find('#dataNasc_ano').val(@user.dataNasc_ano)
      @$el.find('[name=ibge]').val(@user.ibge)
      @montaComboEstados()
      @obtemMunicipios()
      @$el.find('#concorda-termos').attr('checked', 'checked')
      @$el.find('[value="'+@user.sexo+'"]').prop('checked', true)

      @$el.find('#mala_direta').attr('checked', @user.mala_direta)

      @$el.find('#inputCpf').attr('disabled', 'disabled')
      #@$el.find('#inputNome, #inputNomeMae, #inputCpf, #inputEmail, #dataNasc_dia, #dataNasc_mes, #dataNasc_ano, input[name=sexo]').attr('disabled', 'disabled')

      if not modulo.fl_layout_alternativo then return

      for input in [
        'alt_anos_vigilancia_sus',
        'alt_nome_profissao',
        'alt_tempo_profissao',
      ]
        if @user[input] then $('[name=' + input + ']').val(@user[input])

      for check in [
        'alt_atua_ambulatorio_especializado',
        'alt_atua_atencao_basica',
        'alt_atua_filantropico',
        'alt_atua_gestao_saude',
        'alt_atua_hospital_emergencia',
        'alt_atua_no_sus',
        'alt_atua_pesquisa',
        'alt_atua_pronto_atendimento',
        'alt_atua_saude_privada',
        'alt_atuou_vigilancia_sus',
        'alt_genero',
        'alt_profissao',
        'alt_qual_profissao',
        'alt_raca_cor',
      ]
        if @user[check] then $('[name=' + check + '][value="' + @user[check] + '"]').prop('checked', true)

    beforeSubmit: (ev) ->
      console.log 'submit-form'
      # if not @cadastro
      #   return
      @hadFocus = @$el.find 'a.btn.submit-form'
      @$el.find('.btn').attr 'disabled', true
      @$el.find('input').attr 'disabled', true
      @$el.find('select').attr 'disabled', true
      validUser = @validaForm(false)
      infoAlternativa = if modulo.fl_layout_alternativo then @validaEstagio2() else true
      if validUser and infoAlternativa
        validUser = Object.assign({}, validUser, infoAlternativa)
        @salvaUser validUser
      else
        @$el.find('.btn').removeAttr 'disabled'
        @$el.find('input').removeAttr 'disabled'
        @$el.find('select').removeAttr 'disabled'
      false

    ui:
      'cpf':'#inputCpf'
      'inscricoes':'.conteudos'
      'progresso': '.progresso'

    events:
      "click #concorda-termos": 'concorda'
      'keypress input': 'limpaError'
      'blur #inputCpf': 'normalCpf'
      'blur #inputEmail': 'normalEmail'
      'blur #inputNomeMae,#inputNome': 'prettyNome'
      'change select[name="municipio"]': 'muni_ibge'
      'blur select[name="municipio"]': 'muni_ibge'
      'change select': 'limpaError'
      'click .close-modal': 'destroy'
      'change #inputNucleoProfissional': 'temNucleo'
      'click .btn-avancar': 'avancar'
      'click .btn-voltar': 'voltar'
      'change [name="uf"]': 'obtemMunicipios'
      'blur [name="dataNasc_dia"]': 'normalDateNumber'
      'blur [name="dataNasc_mes"]': 'normalDateNumber'
      'blur [name="dataNasc_ano"]': 'normalDateNumber'
      'blur [name="alt_dia_nascimento"]': 'normalDateNumber'
      'blur [name="alt_mes_nascimento"]': 'normalDateNumber'
      'blur [name="alt_ano_nascimento"]': 'normalDateNumber'
      'change .conteudos':'verificaIntegracao'
      'change #alt_profissao': 'layoutAlternativoMudouProfissao'
      'change #alt_atuou_vigilancia_sus': 'layoutAlternativoMudouAtuacaoSus'

    layoutAlternativoMudouProfissao: () ->
      if $('#alt_profissao:checked').val() == 'Profissional' then $('#alt_se_eh_trabalhador').show()
      else $('#alt_se_eh_trabalhador').hide()

    layoutAlternativoMudouAtuacaoSus: () ->
      if $('#alt_atuou_vigilancia_sus:checked').val() != "N" then $('#alt_se_atuou_sus').show()
      else $('#alt_se_atuou_sus').hide()

    voltar: ()->
      @estagio = @estagio - 1
      console.log 'estagio ', @estagio + 1, ' -> ', @estagio
      @mostraEstagio()

    avancar: ()->
      if      @estagio == 0 and not @validaEstagio0() then return
      else if @estagio == 1 and not @validaEstagio1() then return

      if @estagio != 1 or modulo.fl_layout_alternativo then @estagio = @estagio + 1
      console.log 'estagio ', @estagio - 1, ' -> ', @estagio
      @mostraEstagio()

    mostraEstagio: ()->
      @limpaErro()
      $('.termos[data-estagio=1]').hide()
      $('.form-group[data-estagio=1]').hide()
      $('.form-group[data-estagio=2]').hide()
      $('.form-group[data-estagio=3]').hide()
      if      @estagio == 0 then @estagio0()
      else if @estagio == 1 then @estagio1()
      else if @estagio == 2 then @estagio2()

    estagio0: ()->
      # Vazio propositalmente.

    validaEstagio0: ()->
      cpf = utils.pretty.dig(@$el.find('#inputCpf').val())
      if not (cpf.length is 11 and utils.valCPF(cpf)) #and not App.usuarios.at(0)
        @$el.find('#inputCpf').parent().addClass 'has-warning'
        @$el.find('#inputCpf').focus()
        @exibeErro('O CPF inserido é inválido.<br>')
        return false
      return true

    estagio2: ()->
      $('.form-group[data-estagio=2]').show()
      $('.submit-form').show()
      $('.btn-voltar').show()
      $('.btn-avancar').hide()
      # Refresh
      @layoutAlternativoMudouProfissao()
      @layoutAlternativoMudouAtuacaoSus()

    validaEstagio2: (silent = false)->
      data = {}
      mensagemErro = ''

      if $('[name=alt_raca_cor]:checked').length == 0
        $('[name=alt_raca_cor]').parent().addClass 'has-error'
        mensagemErro += 'Raça/Cor é um campo obrigatório!<br>'
      else data.alt_raca_cor = $('[name=alt_raca_cor]:checked').val()

      if $('[name=alt_genero]:checked').length == 0
        $('[name=alt_genero]').parent().addClass 'has-error'
        mensagemErro += 'Gênero é um campo obrigatório!<br>'
      else data.alt_genero = $('[name=alt_genero]:checked').val()

      if $('[name=alt_profissao]:checked').length == 0
        $('[name=alt_profissao]').parent().addClass 'has-error'
        mensagemErro += 'Profissão é um campo obrigatório!<br>'
      else
        data.alt_profissao = $('[name=alt_profissao]:checked').val()
        if data.alt_profissao == 'Profissional' and $('[name=alt_tempo_profissao]').val() == ''
          $('[name=alt_tempo_profissao]').parent().addClass 'has-error'
          mensagemErro += 'Tempo de profissão é um campo obrigatório!<br>'
        else data.alt_tempo_profissao = $('[name=alt_tempo_profissao]').val()

      if $('[name=alt_qual_profissao]:checked').length == 0
        $('[name=alt_qual_profissao]').parent().addClass 'has-error'
        mensagemErro += 'Nome da profissão é um campo obrigatório!<br>'
      else
        data.alt_qual_profissao = $('[name=alt_qual_profissao]:checked').val()
        if data.alt_qual_profissao == 'Outro' and $('[name=alt_nome_profissao]').val() == ''
          $('[name=alt_nome_profissao]').parent().addClass 'has-error'
          mensagemErro += 'Nome da profissão é um campo obrigatório!<br>'
        else data.alt_nome_profissao = $('[name=alt_nome_profissao]').val()

      if $('[name=alt_atua_no_sus]:checked').length == 0
        $('[name=alt_atua_no_sus]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_no_sus = $('[name=alt_atua_no_sus]:checked').val()

      if $('[name=alt_atua_filantropico]:checked').length == 0
        $('[name=alt_atua_filantropico]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_filantropico = $('[name=alt_atua_filantropico]:checked').val()

      if $('[name=alt_atua_saude_privada]:checked').length == 0
        $('[name=alt_atua_saude_privada]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_saude_privada = $('[name=alt_atua_saude_privada]:checked').val()

      if $('[name=alt_atua_atencao_basica]:checked').length == 0
        $('[name=alt_atua_atencao_basica]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_atencao_basica = $('[name=alt_atua_atencao_basica]:checked').val()

      if $('[name=alt_atua_ambulatorio_especializado]:checked').length == 0
        $('[name=alt_atua_ambulatorio_especializado]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_ambulatorio_especializado = $('[name=alt_atua_ambulatorio_especializado]:checked').val()

      if $('[name=alt_atua_pronto_atendimento]:checked').length == 0
        $('[name=alt_atua_pronto_atendimento]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_pronto_atendimento = $('[name=alt_atua_pronto_atendimento]:checked').val()

      if $('[name=alt_atua_hospital_emergencia]:checked').length == 0
        $('[name=alt_atua_hospital_emergencia]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_hospital_emergencia = $('[name=alt_atua_hospital_emergencia]:checked').val()

      if $('[name=alt_atua_gestao_saude]:checked').length == 0
        $('[name=alt_atua_gestao_saude]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_gestao_saude = $('[name=alt_atua_gestao_saude]:checked').val()

      if $('[name=alt_atua_pesquisa]:checked').length == 0
        $('[name=alt_atua_pesquisa]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else data.alt_atua_pesquisa = $('[name=alt_atua_pesquisa]:checked').val()

      if $('[name=alt_atuou_vigilancia_sus]:checked').length == 0
        $('[name=alt_atuou_vigilancia_sus]').parent().addClass 'has-error'
        mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
      else
        data.alt_atuou_vigilancia_sus = $('[name=alt_atuou_vigilancia_sus]:checked').val()
        if data.alt_atuou_vigilancia_sus in ['S', 'A'] and $('[name=alt_anos_vigilancia_sus]').val() == ''
          $('[name=alt_anos_vigilancia_sus]').parent().addClass 'has-error'
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>'
        else data.alt_anos_vigilancia_sus = $('[name=alt_anos_vigilancia_sus]').val()

      if not silent then @exibeErro(mensagemErro)

      if mensagemErro == '' then return data
      else                       return null

    verificaIntegracao:()->
      inscricoes = []
      @$el.find('.conteudos').filter(':checked').map (k,i)-> inscricoes.push($(i).val())
      fl_integrador_marcada = false
      oferta_integradora = null
      self = @
      window.modulo.ofertasAbertas.forEach (o)->
        if o.tipo is 'integrador'
          oferta_integradora = o
        if inscricoes.indexOf(o.id_arouca) > -1
          if o.tipo is 'integrador'
            self.$el.find('.conteudos').prop('checked':true)
            fl_integrador_marcada = true
      soFaltaUma = window.modulo.ofertasAbertas.length-1 is inscricoes.length
      if soFaltaUma and not fl_integrador_marcada and oferta_integradora
        @$el.find('[value="'+oferta_integradora.id_arouca+'"]').prop('checked', true)

    normalDateNumber: (evt)->
      @hadFocus = $(evt.target)
      str = $(evt.target).val().replace(/\D/g,"")
      $(evt.target).val str

    validaEstagio1: () ->
      console.log @validaForm(false)
      cpf = utils.pretty.dig(@$el.find('#inputCpf').val())
      if not (cpf.length is 11 and utils.valCPF(cpf)) #and not App.usuarios.at(0)
        @$el.find('#inputCpf').parent().addClass 'has-warning'
        @$el.find('#inputCpf').focus()
        @exibeErro('O CPF inserido é inválido.<br>')
        return false
      return true

    estagio1: (evt)->
      self = @

      @$el.find('.btn-avancar').attr('disabled', true) # Desabilita enquanto procura pelo usuário.
      $('.submit-form').hide()
      $('.btn-voltar').hide()
      $('.btn-avancar').show()

      {local, socket, progresso} = App
      if not socket then return

      cpf = utils.pretty.dig(@$el.find('#inputCpf').val())
      console.log "emit getuser", App.moduloId
      socket.emit 'getuser', {cpf:cpf, modulo: App.moduloId}, (resposta) ->
        console.log "ENCONTREI UM USER\n", resposta
        if resposta.ok
          if resposta.user.cpf isnt cpf
            self.exibeErro("O usuário encontrado tem um cpf diferente! Contate o suporte técnico (suporte.moodle.esf@gmail.com), informando seu cpf e nome do módulo.")
            self.$el.find('.btn-avancar').attr('disabled', false)
            erroServidor = "Conflito de cpf enviado: "+cpf+" recebido "+resposta.user.cpf
            socket.emit 'senderror', erroServidor, (r)->
              console.log 'erro salvo no servidor'
            return
          else
            console.log resposta.user, '<- aqui esta'
            u = resposta.user
            self.cadastro = true
            if u.profissional
              u['nucleo_profissional'] = u.profissional
            else
              u['profissional'] = u.nucleo_profissional
            self.user = u
            self.fillForm() if self.user
            self.marcaInscritas() if self.user
        else
          console.log 'tentei buscar user porem:', resposta.msg
          mensagemErro = '<h3>'+resposta.msg+'</h3>'
          if resposta.certificado
            App.local.set 'user', null
            App.user = null
            mensagemErro += '<ul class="list-group">'
            for c in resposta.certificado
              console.log 'uma certificada', c
              mensagemErro += "<li><a class='list-group-item' style='color:white' href='"+c.url_certificado+"'> Para obter a 2˚ via do seu certificado acesse aqui: "+c.conteudo+"</a></li>"
            mensagemErro += '</ul>'
            self.exibeErro(mensagemErro)
        if not resposta.certificado
          if modulo.fl_layout_alternativo
            self.$el.find('.btn-avancar').attr('disabled', false)
            self.$el.find('.btn-voltar').hide()
          else
            self.$el.find('.btn-avancar').hide()
            self.$el.find('.submit-form').css({display:'inline-block'})
          self.$el.find('.close-modal').css({display:'inline-block'})
          $('.form-group[data-estagio=1]').show()
          $('.termos[data-estagio=1]').show()
        else
          self.$el.find('.btn-avancar').attr('disabled', false)

        $('.bbm-modal--open').css({"margin-bottom": "235px"})

    limpaErro: () ->
      $('.alert').empty()

    exibeErro: (mensagemErro)->
      @$el.find('.alert').addClass 'alert-danger'
      @limpaErro()
      @$el.find('.alert').append mensagemErro
      @$el.find('.alert').show()

    temNucleo:(evt)->
      nc = @$el.find('#inputNucleoProfissional').find('option:selected').val()
      if nc == '-1' or nc == '0'
        @$el.find('.temNucleo').hide()
      else
        @$el.find('.temNucleo').show()

    hadFocus: null

    prettyNome: (evt)->
      @hadFocus = $(evt.target)
      str = do $(evt.target).val
      str = utils.pretty.name str
      $(evt.target).val str
      # do @validaForm

    normalCpf: (evt)->
      @hadFocus = $(evt.target)
      str = do $(evt.target).val
      str = utils.pretty.dig str
      $(evt.target).val str
      # do @validaForm

    normalEmail: (evt)->
      @hadFocus = $(evt.target)
      str = do $(evt.target).val
      str = do str.toLowerCase
      $(evt.target).val str
      # do @validaForm

    limpaError: (evt)->
        @$el.find('.alert').removeClass('alert-warning alert-success').hide()
        $(evt.target).parent().removeClass 'has-error has-success has-warning'

    concorda: (evt)->
      el = $ evt.target
      chk = el.attr 'checked'
      return el.removeAttr('checked') if chk is 'checked'
      el.attr 'checked', 'checked'

    validaForm: (silent = true)->
      self = this
      campoProblema = []
      mensagemErro = ''
      concorda = @$el.find('#concorda-termos').attr('checked')
      mala_direta = @$el.find('#mala_direta').is(':checked')
      if @$el.find('#inputCpf').val() == ''
        campoProblema.push @$el.find('#inputCpf')
        @$el.find('#inputCpf').parent().addClass 'has-error'
        mensagemErro += 'CPF é um campo obrigatório.<br>'
      else
        cpf = utils.pretty.dig @$el.find('#inputCpf').val()
        if utils.valCPF(cpf) and cpf.length is 11
          @$el.find('#inputCpf').parent().addClass 'has-success'
        else
          mensagemErro += 'O CPF inserido é inválido.<br>'
          @$el.find('#inputCpf').parent().addClass 'has-warning'
          @$el.find('#inputCpf').focus()

      if @$el.find('#inputNome').val() == ''
        campoProblema.push @$el.find('#inputNome')
        @$el.find('#inputNome').parent().addClass 'has-error'
        mensagemErro += 'Nome é um campo obrigatório.<br>'
      else
        nome = @$el.find('#inputNome').val()
        @$el.find('#inputNome').parent().addClass 'has-success'

      #data nascimento
      if @$el.find('[name="dataNasc_dia"]').val() == '' or @$el.find('[name="dataNasc_mes"]').val() == '' or @$el.find('[name="dataNasc_ano"]').val() == ''
        campoProblema.push @$el.find('[name="dataNasc_dia"]')
        @$el.find('[name="dataNasc_dia"]').parent().addClass 'has-error'
        @$el.find('[name="dataNasc_mes"]').parent().addClass 'has-error'
        @$el.find('[name="dataNasc_ano"]').parent().addClass 'has-error'
        mensagemErro += 'Data de nascimento é um campo obrigatório!<br>'
      else
        dia = @$el.find('[name="dataNasc_dia"]').val()
        mes = @$el.find('[name="dataNasc_mes"]').val()
        ano = @$el.find('[name="dataNasc_ano"]').val()
        @$el.find('[name="dataNasc_dia"]').parent().addClass 'has-success'
        @$el.find('[name="dataNasc_mes"]').parent().addClass 'has-success'
        @$el.find('[name="dataNasc_ano"]').parent().addClass 'has-success'
      #sexo
      sexo = @$el.find('[name="sexo"]:checked').val()
      if not sexo
        campoProblema.push @$el.find('[name=sexo]')
        @$el.find('[name=sexo]').parent().addClass 'has-error'
        mensagemErro += 'Sexo é um campo obrigatório!<br>'


      if @$el.find('#inputNomeMae').val() == ''
        campoProblema.push @$el.find('#inputNomeMae')
        @$el.find('#inputNomeMae').parent().addClass 'has-error'
        mensagemErro += 'Nome da mãe é um campo obrigatório.<br>'
      else
        nomeMae = @$el.find('#inputNomeMae').val()
        @$el.find('#inputNomeMae').parent().addClass 'has-success'

      if @$el.find('#inputEmail').val() == ''
        campoProblema.push @$el.find('#inputEmail')
        @$el.find('#inputEmail').parent().addClass 'has-error'
        mensagemErro += 'E-mail é um campo obrigatório.<br>'
      else
        email = @$el.find('#inputEmail').val()
        if utils.isEmail(email)
          @$el.find('#inputEmail').parent().addClass 'has-success'
        else
          campoProblema.push @$el.find('#inputEmail')
          @$el.find('#inputEmail').parent().addClass 'has-error'
          mensagemErro += 'E-mail inválido.<br>'

      if @$el.find('#inputNucleoProfissional').find('option:selected').val() == '-1'
        campoProblema.push @$el.find('#inputNucleoProfissional')
        @$el.find('#inputNucleoProfissional').parent().addClass 'has-error'
        mensagemErro += 'Núcleo profissional é um campo obrigatório.<br>'
      else
        nucleo = @$el.find('#inputNucleoProfissional').find('option:selected').val()
        @$el.find('#inputNucleoProfissional').parent().addClass 'has-success'

      #uf
      campo = '[name="uf"]'
      if @$el.find(campo).val() == '-1'
        campoProblema.push @$el.find(campo)
        @$el.find(campo).parent().addClass 'has-error'
        mensagemErro += 'Estado é um campo obrigatório!<br>'
      else
        uf = @$el.find(campo).val()
        @$el.find(campo).parent().addClass 'has-success'

      #municipio
      campo = '[name="municipio"]'
      if @$el.find(campo).val() == '-1'
        campoProblema.push @$el.find(campo)
        @$el.find(campo).parent().addClass 'has-error'
        mensagemErro += 'Municipio é um campo obrigatório!<br>'
      else
        municipio = @$el.find(campo).val()
        @$el.find(campo).parent().addClass 'has-success'
      ibge = @$el.find('[name="ibge"]').val()

      if concorda != 'checked'
        campoProblema.push @$el.find('#concorda-termos')
        @$el.find('#concorda-termos').parent().addClass 'has-error'
        mensagemErro += 'Você precisa aceitar os Termos de Uso.<br>'

      ofertasUsuario = @obtemOfertas()
      console.log ofertasUsuario, 'ofertasUsuario', @obtemOfertas
      if ofertasUsuario.length is 0
        campoProblema.push @$el.find('.conteudos')[0]
        @$el.find('.conteudos').parent().parent().addClass 'has-error'
        mensagemErro += 'Você precisa escolher ao menos um conteúdo para certificar.<br>'
      unless silent
        @$el.find('input').attr 'disabled', false
        @$el.find('select').attr 'disabled', false


      if campoProblema.length > 0
        @$el.find('input').attr 'disabled', false
        @$el.find('select').attr 'disabled', false
        @exibeErro(mensagemErro)
        campoProblema[0].focus() if @hadFocus.is 'a.btn.submit-form'
        return false
      else
        obj = {
          cpf
          nome
          nomeMae
          email
          dataNasc_dia: dia
          dataNasc_mes: mes
          dataNasc_ano: ano
          municipio
          uf
          ibge
          mala_direta
          sexo
          profissional: nucleo
          modulo: App.moduloId
          ofertas: ofertasUsuario
        }
        return obj

    salvaUser: (user) ->
      self = this
      self.$el.find('input').attr 'disabled', true
      self.$el.find('select').attr 'disabled', true
      self.$el.find('.progress').show()
      self.$el.find('.carregando').show().css 'width', '10%'
      self.$el.find('.alert')
      .removeClass 'alert-danger'
      .addClass 'alert-success'
      .empty()
      user.synced = off
      self = @
      destroyCallback = ()->
        self.$el.find('.carregando').hide()
        self.destroy()
        console.log 'destriu'
        if App.local
          usr = App.local.get 'user'
          App.user = usr
          respKey = "respostas-#{App.user.cpf}"
          respostas = App.local.get respKey
          App.loadUserMenu()

      self.$el.find('.alert').show().html('<h3>Usuário salvo neste navegador, tentando salvar no servidor...</h3>')
      self.$el.find('.btn').attr 'disabled', true
      self.$el.find('.carregando').css 'width', '60%'
      App.execute 'storeUser', user, (resposta)->
        self.$el.find('.carregando').css 'width', '100%'
        self.$el.find('.alert').removeClass('alert-danger').removeClass('alert-success').show().empty()
        if resposta.ok
          $('.dropdown-componentes').find('ul.dropdown-menu li').show()
          self.$el.find('.alert').html('<h3>Usuário salvo no servidor</h3>')
          setTimeout destroyCallback(), 1000
        else
          msg = '<h3>'+resposta.msg+'</h3>'
          if resposta.certificado
            msg += '<ul class="list-group">'
            for c in resposta.certificado
              msg += "<li><a class='list-group-item' style='color:white' href='"+c.url_certificado+"'> Para obter a 2˚ via do seu certificado acesse aqui: "+c.conteudo+"</a></li>"
            msg += '</ul>'
          if msg.indexOf('SOAP-ERROR') > -1
            msg = 'Devido a problemas de conexão com a plataforma arouca não foi possível gerar seu certificado, por favor, tente mais tarde!'
          self.$el.find('.alert').html(msg)
          self.$el.find('.btn').attr 'disabled', false
          self.$el.find('.progress').hide()

    montaComboEstados:()->
      siglas = staticData.estados.map((v)-> v.sigla)
      @$el.find('[name="uf"]').empty()
      @$el.find('[name="uf"]').append(
        "<option value='-1'>Selecione</option>"
      )
      for sigla in siglas
        @$el.find('[name="uf"]').append(
          "<option value='" + sigla + "'>" + sigla + "</option>"
        )
      if @user
        if @user.uf
          @$el.find('[name="uf"]').val(@user.uf)

    obtemMunicipios:()->
      uf = @$el.find('[name="uf"]').val()
      muniSel = @$el.find('[name="municipio"]');
      muniSel.prop('disabled','disabled');
      cits = []
      for estado,k in staticData.estados
        if estado.sigla is uf
          cits = estado.cidades

      muniSel.empty()
      if uf isnt '-1'
        muniSel.append($('<option value="-1">selecione...</option>'))
        for uma of cits
          cit = cits[uma]
          opt = $('<option value="' + cit.nome + '" data-ibge="' + cit.ibge + '">' + cit.nome + '</option>')
          opt.appendTo muniSel
        muniSel.removeAttr('disabled')
      else
        muniSel.append($('<option value="-1">&#8592; Escolha um estado</option>'))
        muniSel.attr('disabled', true)
      if @user
        if @user.municipio
          @$el.find('[name="municipio"]').val(@user.municipio)

    muni_ibge:()->
      ibge = $('[name="municipio"]').children(':checked').data('ibge');
      $('[name="ibge"]').val(ibge)
