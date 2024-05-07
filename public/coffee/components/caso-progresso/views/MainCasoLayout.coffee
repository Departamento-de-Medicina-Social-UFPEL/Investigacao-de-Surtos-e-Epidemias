define [
  '../models/Paciente'
  '../collections/SlidesColl'
  './SlidesColl'
  './Introbox'
  './Paciente'
  'utils'
], (PacienteModel, SlidesColl, SlidesCollView, IntroboxView, PacienteView, utils)->

  class CasoView extends Marionette.LayoutView

    className: 'caso-main container'

    initialize: () ->


    template: '#caso-progresso-main'

    ui:
      estResp: '.caso #estadoResposta'
      confirmaReset: '.caso #estadoResposta #confirmaRecomeca'
      recomeca: '#btnRecomeca'
      continua: '#btnContinua'

    events:
      'click @ui.estResp #btnRecomeca': 'confirmaRecomeca'
      'click @ui.estResp #btnContinua': 'vaiPraQuestaoDaVez'


    vaiPraQuestaoDaVez: () ->
      page = $('html, body')
      page.on "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", ->
        do page.stop
        page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove"
      page.animate(
        scrollTop: $("section.slide.daVez").offset().top - 85
      , 600, -> page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove" )

    confirmaRecomeca: () ->
      self = @

      @ui.confirmaReset.modal
        keyboard: false

      @ui.confirmaReset.find('#delete').on 'click', () ->
        respDest = App.progresso.getByAtividadeId self.model.get('_id')
        do resposta.destroy for resposta in respDest
        do App.progresso.calculaProgressoGeral
        App.progresso.trigger 'change'
        # self.model.unset 'respostas'
        page = $('html, body')
        page.removeClass 'modal-open'
        Backbone.history.loadUrl Backbone.history.fragment



    onRender: () ->
      # console.log @ui.estResp
      @paciente = new PacienteModel @model.get 'paciente'


      # console.log @model, @paciente
      @allSlides = new SlidesColl @model.get('slides'), @paciente, @model

      @addRegions
        introReg: '.caso #introducao'
        pacienteReg: '.caso #pacienteTopo'
        slidesReg: '.caso #slidesLista'

      @pacienteReg.show new PacienteView model: @paciente

      @introReg.show new IntroboxView model: @model

      slides = @model.get('slides')
      slides = slides[1..] if slides[0].tipo is 'intro'
      slidesView = new SlidesCollView
        collection: new SlidesColl(slides, @paciente, @model)

      @slidesReg.show slidesView
      _this = this

      handlerAtualizaProgresso = ->
        do @getRespostasDeste
        # @rodapeReg.currentView.render()

      if App.user
        @listenTo App.progresso, 'fetched change', handlerAtualizaProgresso
      if App.progresso
        App.progresso.temNovosBadges yes

      setTimeout ()->
        $.material.init()
      , 10

      do @getRespostasDeste
      do @verificaConcluinte

    getRespostasDeste: ->
      # console.log "'caso' -> #{@model.get '_id'}"
      return null unless App.user
      respostas = App.progresso.getByAtividadeId @model.get '_id'
      if respostas.length > 0
        @model.set {respostas}
        do @assinalaMarcadas
        @trigger 'novasRespostas'

    'assinalaMarcadas': () ->
      self = @
      if !@slidesReg
        setTimeout( () ->
          self.assinalaMarcadas
        , 300)
        return null
      # @slidesReg
      casoId = @model.get '_id'
      slides = @slidesReg.currentView.children
      # console.log "slides = do @slidesReg.currentView.children", slides
      respostas = @model.get 'respostas'

      return null if !slides

      questoes = slides.filter (view) -> view.model.get('tipo').match /questao.*/ig

      soma = respostas.reduce(
        (memo, resp)-> memo + resp.get('escore')
      , 0)
      mediaG = soma / respostas.length

      texto = ''
      @ui.estResp.find('.mensagem').empty()
      if respostas.length is questoes.length
        @ui.estResp.find('#btnContinua').hide()
        @ui.estResp.find('#btnRecomeca').removeClass('btn-xs').addClass('btn-sm')
        texto = "Você já respondeu todas as #{questoes.length} questões deste caso."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
        texto = "Sua média de acertos final foi de #{mediaG.toFixed(2).replace('.',',')}%."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
      else
        texto = "Você já respondeu #{respostas.length} das #{questoes.length} questões deste caso."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
        texto = "Sua média de acertos até agora é de #{mediaG.toFixed(2).replace('.',',')}%."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)

      @ui.estResp.removeClass('hide').show()
      # console.log @ui.estResp

      respostas.forEach (resposta)->
        seqid = resposta.get 'seqid'
        quest = questoes[seqid]
        if quest 
          opcs = quest.$el.find('.opcoes')
          marcadas = resposta.get('marcadas')
          for marca in marcadas
            e = opcs.find """[data-originalidx="#{marca}"]:input"""
            # console.log "MARCA RESPOSTA",seqid, marca, e
            e.attr 'checked', true
            e.parent().removeClass('unchecked').addClass 'checked'
          quest.silent = true
          quest.tocado()
          quest.ui.btnResp.click()
    
    verificaConcluinte: ()->
      self = @
      # console.log 'modelo caso', self.model
      App.user.ofertas.forEach (o)->
        nucleos = self.model.get('profissional').split(',').map (n)-> n.trim().toLowerCase()
        # console.log nucleos, self.model.get('profissional').split(','), 'nucleos'
        if o.modulo is App.moduloId and (nucleos.indexOf(o.conteudo) > -1 or o.conteudo is 'interdisciplinar') and o.dt_conclusao
          self.ui.recomeca.hide()
          self.ui.continua.hide()
  CasoView