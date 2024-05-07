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
      status =
        'status': 'attended'
        'percentage': 0
        'LTIvalue': 0
      return unless window.unasus
      unless unasus.pack?.getStatus()
        unasus.pack.setStatus status

    template: '#caso-progresso-single-main'

    ui:
      estResp: '.caso #estadoResposta'
      confirmaReset: '.caso #estadoResposta #confirmaRecomeca'

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
      , 2000, -> page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove" )

    confirmaRecomeca: () ->
      self = @

      if unasus?.pack
        status =
          'status': 'attended'
          'percentage': 0
          'LTIvalue': 0
        unasus.pack.setStatus status

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
      if @model.get 'paciente'
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

      @listenTo App.progresso, 'fetched change', handlerAtualizaProgresso

      setTimeout ()->
        $.material.init()
      , 10

      do @ajustaHeader

      do @getRespostasDeste


    ajustaHeader: () ->
      pro = @model.get 'pro'
      [e, m, o] = pro
      cor = switch true
        when e and m then 'linear-gradient(90deg, #0091D6 10px, #378A33 27px)'
        when e then '#0091D6'
        when m then '#378A33'
        when o then '#DB160F'
      console.log pro, cor, cor.length
      etiqueta = $('.navbar-brand .pro-tag')
      if etiqueta.length is 0
        tag = "#{if e then 'E ' else ''}#{if m then 'M ' else ''}#{if o then 'O' else ''}"
        style =
          'background': cor
          'padding-left': '5px'
          'padding-right': '5px'
          'margin-right': '5px'
          'padding-bottom': '1px'
          'font-weight': 'bold'
          'border-radius': '4px'
        tag = $('<span></span>')
        .addClass('pro-tag')
        .html(tag.trim())
        .css style

        tag.addClass('single-child') if cor.length is 7

        $('.navbar-brand').prepend tag


    getRespostasDeste: ->
      # console.log "'caso' -> #{@model.get '_id'}"
      # return null unless App.user
      respostas = App.progresso.getByAtividadeId @model.get '_id'
      console.log respostas
      if respostas.length > 0
        @model.set {respostas}
        do @assinalaMarcadas
        @trigger 'novasRespostas'

    'assinalaMarcadas': () ->
      self = @
      if !@slidesReg
        setTimeout( () ->
          self.assinalaMarcadas
        , 100)
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
      persist =
        'status': 'attempted'
        'percentage': 0
        'LTIvalue': 0
      if respostas.length is questoes.length
        @ui.estResp.find('#btnContinua').hide()
        @ui.estResp.find('#btnRecomeca').removeClass('btn-xs').addClass('btn-sm')
        texto = "Você já respondeu todas as #{questoes.length} questões deste caso."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
        texto = "Sua média de acertos final foi de #{mediaG.toFixed(2).replace('.',',')}%."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
        persist.status = if mediaG >= 70 then 'passed' else 'failed'
        persist.percentage = 100
      else
        persist.status = 'attempted'
        persist.percentage = parseInt((respostas.length / questoes.length)*100)
        texto = "Você já respondeu #{respostas.length} das #{questoes.length} questões deste caso."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)
        texto = "Sua média de acertos até agora é de #{mediaG.toFixed(2).replace('.',',')}%."
        @ui.estResp.find('.mensagem').append($('<p></p>').text texto)

      if unasus?.pack
        persist.LTIvalue = mediaG/100
        unasus.pack.setStatus persist

      @ui.estResp.removeClass('hide').show()
      # console.log @ui.estResp

      respostas.forEach (resposta)->
        seqid = resposta.get 'seqid'
        quest = questoes[seqid]
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

  CasoView