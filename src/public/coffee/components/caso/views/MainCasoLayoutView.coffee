define [
  '../models/Paciente'
  '../collections/SlidesColl'
  './SlidesCollView'
  './IntroboxView'
  './PacienteView'
  'utils'
], (PacienteModel, SlidesColl, SlidesCollView, IntroboxView, PacienteView, utils)->

  class Caso extends Marionette.LayoutView

    className: 'caso-main container'

    initialize: () ->

    getRespostasDeste: ->
      console.log "'caso' -> #{@model.get '_id'}"
      return null unless App.user and App.user?.progresso
      respostas = App.user.progresso.getByAtividadeId @model.get '_id'
      if respostas.length > 0
        @model.set {respostas}
        do @assinalaMarcadas
        @trigger 'novasRespostas'

    template: '#caso-main'

    ui:
      estResp: '.caso #estadoResposta'
      confirmaReset: '.caso #estadoResposta #confirmaRecomeca'

    events:
      'click @ui.estResp #btnRecomeca': 'confirmaRecomeca'
      'click @ui.estResp #btnContinua': 'vaiPraQuestaoDaVez'

    confirmaRecomeca: () ->
      self = @
      console.log @ui.confirmaReset
      @ui.confirmaReset.modal(
        keyboard: false
      )
      @ui.confirmaReset.find('#delete').on('click', () ->
        self.ui.confirmaReset.modal('hide')
        respDest = App.user.progresso.getByAtividadeId self.model.get('_id')
        do resposta.destroy for resposta in respDest
        do App.user.progresso.calculaProgressoGeral
        App.user.progresso.trigger 'change'
        self.model.unset 'respostas'
        self.rodapeReg.currentView.model.unset 'respostas'
        App.layoutInicial.contents.currentView.render()
        self.rodapeReg.currentView.render()
        # self.model.respostas = null
        $('.modal-backdrop').removeClass('in').addClass('out').one('transitionend webkitTransitionEnd oTransitionEnd otransitionend MSTransitionEnd',() ->
          $('body').removeClass('modal-open')
          $('.modal-backdrop').remove()
        )
        true
      )

    vaiPraQuestaoDaVez: () ->
      $('body').animate(
        scrollTop: $("section.slide.daVez").offset().top - 85
      , 1000)



    onRender: () ->

      @paciente = new PacienteModel @model.get 'paciente'

      @allSlides = new SlidesColl @model.get('slides'), @paciente, @model

      @addRegions
        introReg: '.caso #introducao'
        pacienteReg: '.caso #pacienteTopo'
        slidesReg: '.caso #slidesLista'

      @pacienteReg.show new PacienteView model:@paciente

      @introReg.show new IntroboxView model:@model


      slidesView = new SlidesCollView
        collection: new SlidesColl(@model.get('slides')[1..], @paciente, @model)

      @slidesReg.show slidesView
      _this = @

      handlerAtualizaProgresso = ->
        do @getRespostasDeste
        @rodapeReg.currentView.render()

      @listenTo App.user.progresso, 'fetched', handlerAtualizaProgresso
      @listenTo App.user.progresso, 'change', handlerAtualizaProgresso

      do @getRespostasDeste


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
        quest.ui.btnResp.click()

  Caso