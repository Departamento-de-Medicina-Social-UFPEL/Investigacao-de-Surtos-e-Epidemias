define [], ->

  class SlideSaibaMais extends Marionette.ItemView

    className: 'container-fluid item'

    tagName: 'section'

    initialize: ->
      if not @model.get('bibliografia')
        @model.set('bibliografia', false)

    template: (data)->
      if _.isArray data.conteudo.opcoes[0]
        opcs = data.conteudo.opcoes.map (arrOp, i)->
          correta: arrOp[1]
          texto: arrOp[0]
          originalIdx: i
        # console.log 'data.dontShuffle----------->', data.dontShuffle
        unless data.dontShuffle
          data.conteudo.opcoes = _.shuffle opcs
        else
          data.conteudo.opcoes = opcs
      _.template($('script#saiba-mais-item-view').html()) data

    ui:
      btnResp: 'button.responder'
      opts: '.radio'
      saiba: '.resposta'
      correcao: '.alert'
      acerto: '.alert h2.acerto'
      corrIco: '.alert i'

    events:
      'click button.avanca': 'respondeu'
      'click .radio': 'tocado'

    respondeu:(evt) ->
      unless @ehTocado
        evt.stopPropagation()
        evt.preventDefault()
        return false
      @ui.opts.bind 'click', ()-> false
      @ui.btnResp.hide()
      @ui.opts
      .addClass('disabled')
      .css( color: '#888' )
      .on 'click', ()-> false
      @ui.opts.find(':input').attr 'tabIndex', '-1'
      do @corrige

    onRender:->
      @ui.btnResp.addClass 'disabled btn-default'
      @ui.btnResp.text 'Selecione'

    ehTocado: false

    respondido: false

    tocado:(evt)->
      # if !@respondido and /label/img.test evt.target.tagName
      #   $(evt.target).find('input').prop 'checked', true
      return true if @ehTocado
      @ehTocado = true
      @ui.btnResp.removeClass('disabled btn-default').addClass('btn-info').text('Responder')

    getMarcada:->
      m = @ui.opts.find('input:checked')
      # console.log  m
      m.data 'originalidx'

    getCorreta:->
      ops = @model.get('conteudo').opcoes
      for o in ops
        if o.correta then return o.originalIdx

    corrige:->

      self = @

      corr = @getCorreta()
      resp = @getMarcada()

      # console.log "#{corr} is #{resp}"

      acertou = corr is resp

      labelOpcaoCorr = @ui.opts.find(""":input[data-originalidx="#{corr}"]""").parent()
      labelOpcaoMar = @ui.opts.find(""":input[data-originalidx="#{resp}"]""").parent()
      # console.log labelOpcaoCorr, labelOpcaoMar
      [vermelho, azul, verde] = ['#e74c3c', '#3498db', '#27ae60']

      if acertou
        labelOpcaoCorr.css 'color', verde

      else
        labelOpcaoCorr.css 'color', azul
        labelOpcaoMar.css 'color', vermelho

      conceito = $ 'li.score'
      scoreAtu = parseInt conceito.data 'score'
      scoreAtu = 0 if !scoreAtu
      # conceito.find('.tit-conceito').text('Conceito') if scoreAtu is 0
      media = if acertou then 100 else 0
      totalScore = scoreAtu + media
      div = 2
      div = 1 if scoreAtu is 0
      score = totalScore / div
      conceito.data 'score', score
      # console.log "score #{score} = (#{totalScore} = #{scoreAtu} + #{media}) / #{div}"
      strConceito = @getConceito score
      conceito.find('.conceito').text strConceito

      if !@silent
        salvaResposta =
          atividade: @model.collection.caso.get '_id'
          seqid: @$el.data 'seqid'
          modulo: window.modulo._id
          marcadas: [ @getMarcada() ]
          escore: media
          ts: do Date.now

        if App.user
          App.progresso.create salvaResposta

        page = $('html, body')
        page.on "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", ->
          do page.stop
          page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove"
        page.animate(
          scrollTop: self.$el.find('.opcoes').offset().top - 85
        , 300, -> page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove" )



      badge = $ 'li.quest > span[target="' + @$el.prop('id') + '"]'
      badge.addClass 'corrigido'

      @ui.acerto.text(if acertou then 'Acertou' else 'Incorreto')

      ico = if acertou then 'checkbox-marked-circle' else 'emoticon-sad'
      tipo = if acertou then 'success' else 'danger'
      acertoBadge = if acertou then 'correto' else 'errado'

      @ui.corrIco.addClass "mdi-#{ico}"
      @ui.correcao.addClass("alert-#{tipo} in").removeClass('out hide')
      @ui.saiba.addClass('in').removeClass('out hide')

      badge.addClass "#{acertoBadge}"

      @respondido = true

      @trigger 'respondeu', @

    

  SlideSaibaMais


