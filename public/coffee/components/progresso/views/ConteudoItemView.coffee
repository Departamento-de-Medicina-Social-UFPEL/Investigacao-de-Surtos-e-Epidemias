define [
  './ErrorView'
], (ErrorView) ->

  class ConteudoView extends Marionette.ItemView


    initialize: ->
      if(App.socket)
        @model.set('fl_cert_conectado': App.socket.connected)
      @model.set('fl_inscrito', false)
      @model.set('fl_concluinte', false)
      @model.set('cumpriuTempoMinimoParaCertificacao', false)
      #console.log(@model, 'model enf')

    className: 'enf-med-main panel panel-default'

    template: '#progresso-conteudo-nucleo'

    ui:
      'emitirCertificado': '.btn-emitir-certificado'
      'emitirDesempenho': '.btn-emitir-desempenho'
      'checkInscrito': '#check-box-inscrito'
      'checkCaso': '#check-box-casos-clinicos'
      'checkUnidades': '#check-box-todas-unidades'
      'checkTeste': '#check-box-pos-teste'
      'checkInternet': '#check-box-internet'
      'linkInscricao': '.link-inscricao'
      'flInscrito': '#fl-inscrito'
      'flInscritoCriterio': '.check-box-inscrito'
      'barDesempenho': '.progresso-desempenho'
      'barCertificado': '.progresso-certificado'
      'todosChecks':"input[type='checkbox']"
      'concluinte':".concluinte"
      'criterios':".criterios"
    events:
      'click @ui.emitirCertificado': 'emitirCertificado'
      'click @ui.emitirDesempenho': 'emitirDesempenho'
      'click @ui.flInscrito':'inscreva'
      'change @ui.checkInscrito': 'trocaCor'
      'change @ui.checkCaso': 'trocaCor'
      'change @ui.checkUnidades': 'trocaCor'
      'change @ui.checkInternet': 'trocaCor'
      'change @ui.checkTeste': 'trocaCor'
      'click @ui.todosChecks': 'paraClick'
    	# 'click @ui.checkCaso': 'paraClick'
    	# 'click @ui.checkInternet': 'paraClick'
    	# 'click @ui.checkTeste': 'paraClick'

    inscreva:()->
      #console.log 'inscreva-se'
      App.appRouter.navigate '#comp/cadastro', 'trigger': yes

    trocaCor: (evt)->
      ckVal = $(evt.target).prop("checked")
      modiNovo = if ckVal then "success" else "danger"
      modiOld = if not ckVal then "success" else "danger"
      $(evt.target).parent().parent().removeClass('check-'+modiOld).addClass('check-'+modiNovo)

    paraClick: (evt)->
      do evt.preventDefault
      do evt.stopPropagation

    verificaEnquetes: ->
      if App.enquetes && App.user
        if App.user.enquetes
          if App.user.enquetes[App.moduloId]
            enquetes = App.user.enquetes[App.moduloId]
            if enquetes['conclusao']
              return
        Backbone.history.navigate '#comp/enquetes/intro/'+App.user.cpf+'/tipo/conclusao', {trigger: yes}

    emitirCertificado: (evt)->
      self = this
      #console.log("certificado")
      do evt.stopPropagation

      #if not @model.get('cumpriuTempoMinimoParaCertificacao')
      #  do App.modals.destroyAll
      #  App.modals.show(new ErrorView({link:false,titulo:"Erro  ao emitir certificado", msg:"Você não pode certificar, verifique os critérios na tela de progresso!"}))
      #  return

      abreCertificado = (data)->
        window.externa = {}
        veSeExiste = (msg) ->
          unless window.externa
            alert msg
            return no
          return yes
        do window.externa.close if window.externa.alert
        window.externa = window.open data.url, 'externa'
        return setTimeout veSeExiste, 1000, "Destive o bloqueador de pop-ups para acessar o seu certificado."
      if self.model.get('url_certificado')
        return abreCertificado({url: self.model.get('url_certificado')});


      url = "https://"+window.location.host+"/arouca/certifica/oferta/"+self.model.get('id_arouca')+"/user/"+App.user.cpf
      # respostas = JSON.stringify do App.progresso.toJSON
      # if not @model.elegivel
      #   do App.modals.destroyAll
      #   App.modals.show(new ErrorView({link:false,titulo:"Erro  ao emitir certificado", msg:"Você não pode certificar, verifique os critérios na tela de progresso!"}))
      #   return
      self.verificaEnquetes()
      # return
      self.ui.barCertificado.show()
      self.ui.barCertificado.children().css('width':'50%')
      $.ajax
        "type": "post"
        "url": url
        "success": abreCertificado
        "error": (err)->
          do App.modals.destroyAll
          resp = {titulo:"Erro ao emitir certificado", msg:err.responseJSON.msg, url:'', link:false}
          if err.responseJSON.certificado
            resp.link = {url:err.responseJSON.certificado, descricao:"Acesse aqui para emitir a 2˚ via dos seus certificados!"}
          App.modals.show(new ErrorView(resp))
        "complete":()->
          self.ui.barCertificado.children().css('width':'100%')
          self.ui.barCertificado.hide().children().css('width':'10%')

    emitirDesempenho: (evt)->
      #console.log 'desempenho'
      self = this
      #console.log("certificado")
      do evt.stopPropagation
      url = "https://"+window.location.host+"/arouca/desempenho/oferta/"+self.model.get('id_arouca')+"/user/"+App.user.cpf
      # respostas = JSON.stringify do App.progresso.toJSON
      #console.log @model.get('elegivel'), 'fls', @model.get('fl_concluinte')
      if not @model.get('elegivel') and not @model.get('fl_concluinte')
        do App.modals.destroyAll
        App.modals.show(new ErrorView({titulo:"Erro ao emitir declaração de desempenho", msg:"Você só pode imprimir a declaração de desempenho após certificar!", link:false}))
        return
      self.ui.barDesempenho.show()
      self.ui.barDesempenho.children().css('width':'50%')
      $.ajax
        "type": "post"
        "url": url
        "success": (data)->
          #console.log data, 'url'
          window.externa = {}
          veSeExiste = (msg) ->
            unless window.externa
              alert msg
              return no
            return yes
          do window.externa.close if window.externa.alert
          window.externa = window.open data.url, 'externa'
          return setTimeout veSeExiste, 1000, "Destive o bloqueador de pop-ups para acessar o seu desempenho."
        "error": (err)->
          do App.modals.destroyAll
          modelo = {
            titulo:"Erro ao emitir declaração de desempenho"
            msg : err.responseJSON.msg
            link : {url:err.responseJSON.url, descricao:'Contatar Suporte informando seu cpf e nome do módulo.'}
          }
          App.modals.show(new ErrorView(modelo))
        "complete":()->
          self.ui.barDesempenho.children().css('width':'100%')
          self.ui.barDesempenho.hide().children().css('width':'10%')

    verificaInscricao: ()->
      self = @
      diaMinimoParaCertificacao = new Date()
      hoje = new Date()
      fl_inscrito = false
      url_certificado = ""
      if App.user.ofertas
        App.user.ofertas.forEach (o)->
          if o.modulo is App.moduloId and o.conteudo is self.model.get('nucleo').toLowerCase() and o.dt_conclusao
            self.model.set 'id_arouca', o.id_arouca
            self.model.set 'url_certificado', o.url_certificado
            self.model.set 'fl_concluinte', true
          else if o.id_arouca is self.model.get('id_arouca')
            fl_inscrito = true
            diasParaCertificacao = if o.modulo.tempoMinimoParaCertificacao then o.modulo.tempoMinimoParaCertificacao else 5
            diaMinimoParaCertificacao = new Date(o.dt_cadastro)
            diaMinimoParaCertificacao.setDate(diaMinimoParaCertificacao.getDate() + diasParaCertificacao)
            #console.log(hoje, diaMinimoParaCertificacao, hoje >= diaMinimoParaCertificacao)
            #self.model.set 'cumpriuTempoMinimoParaCertificacao', hoje >= diaMinimoParaCertificacao 
            self.model.set 'cumpriuTempoMinimoParaCertificacao', true 
      self.model.set 'fl_inscrito', fl_inscrito
      #console.log('model', self.model)

      if fl_inscrito or self.model.get("fl_concluinte")
        self.$el.find("input[value="+self.model.get('id_arouca')+"]").prop 'checked', true
        self.ui.linkInscricao.hide()
        self.ui.flInscrito.addClass('check-success')
        if self.model.get 'cumpriuTempoMinimoParaCertificacao'
          self.ui.flInscritoCriterio.addClass('check-success')
          if self.model.get 'elegivel'
            self.ui.emitirCertificado.attr('disabled', false)
        else
          self.ui.flInscritoCriterio.addClass('check-danger')
        if self.model.get("fl_concluinte")
          self.ui.flInscrito.html("<div style='margin-left: 7px;padding: 2px;'>Você já concluiu este conteúdo!</div>")
          self.ui.criterios.hide()
          self.ui.concluinte.show()
          self.ui.emitirDesempenho.attr('disabled', false)
          self.ui.emitirCertificado.attr('disabled', false)
        else
          self.ui.criterios.show()
          self.ui.concluinte.hide()
      else
        self.ui.flInscrito.addClass('check-danger')
        self.ui.flInscritoCriterio.addClass('check-danger')
        self.ui.linkInscricao.show()

    onRender: ->
      @verificaInscricao()
      @$el.addClass(@model.get('nucleo').toLowerCase())
      @ui.checkInscrito.prop("checked", @model.get('fl_inscrito') && @model.get('cumpriuTempoMinimoParaCertificacao'))
      @ui.checkCaso.prop("checked", @model.get('fl_cert_casos_clinicos'))
      @ui.checkUnidades.prop("checked", @model.get('elegivel'))
      @ui.checkTeste.prop("checked", @model.get('fl_cert_pos_teste'))
      @ui.checkInternet.prop("checked", @model.get('fl_cert_conectado'))
      #@model.elegivel = App['masterElegivelCert'+@model.get('nucleo')]()
      #console.log @model.elegivel, 'elegivelMed'

      #console.log 'cumpriuTempoMinimoParaCertificacao', @model.get('cumpriuTempoMinimoParaCertificacao')
      #console.log 'elegivel', @model.get('elegivel')
      #console.log 'fl_concluinte', @model.get('fl_concluinte')

  ConteudoView