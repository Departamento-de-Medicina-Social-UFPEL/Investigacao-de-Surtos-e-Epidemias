define [], ->

  class SlideQueMultipla extends Marionette.ItemView

    className: 'container-fluid questao'

    tagName: 'section'

    initialize: ->

    template: (data)->
      if _.isArray data.conteudo.opcoes[0]
        opcs = data.conteudo.opcoes.map (arrOp, i)->
          correta: arrOp[1]
          texto: arrOp[0]
          originalIdx: i

        # console.log 'data.dontShuffle----------->', data.dontShuffle
        data.conteudo.opcoes = _.shuffle opcs unless data.dontShuffle
      # console.log data.conteudo.opcoes
      _.template($('script#caso-progresso-slides-queMultipla').html()) data

    ui:
      btnResp: 'button.responder'
      opts: '.checkbox'
      saiba: '.resposta'
      correcao: '.alert'
      corrPorCent: '.alert h2.porcentagem span.valor'
      corrIco: '.alert i'

    events:
      'click button.responder': 'responde'
      'click .checkbox': 'tocado'

    onRender:() ->
      @ui.btnResp.addClass('disabled btn-default').text('Selecione')
      @bind 'respondeu', (self, tipo, desempenho, media) ->
        # console.log desempenho, media, [arguments]
      @verificaConcluinte()


    ehTocado: false

    responde:(evt) ->
      unless @ehTocado
        do evt.stopPropagation
        do evt.preventDefault
        return null

      @ui.opts.bind 'click', ()-> false
      @ui.btnResp.hide()
      @ui.opts
      .addClass('disabled')
      .css( color: '#888' )
      .on 'click', ()-> false
      @ui.opts.find(':input').attr 'tabIndex', '-1'
      do @corrige

    getMarcadas:->
      # console.log @ui.opts
      map = @ui.opts.map (k,opt)->
        i = $(opt).find 'input'
        if i.is(':checked') then i.data('originalidx') else null
      mapArr = map.toArray()
      mapArrFiltered = mapArr.filter (e)-> typeof e is 'number'
      # console.log map, mapArr, mapArrFiltered
      mapArrFiltered

    getCorretas:->
      @model.get('conteudo').opcoes

    corrige:->
      self = @
      corr = do @getCorretas
      resp = do @getMarcadas
      # console.log corr, resp
      opcoes = @ui.opts

      # console.log opcoes

      # cores da correção
      [vermelho, azul, verde] = ['#e74c3c', '#3498db', '#27ae60']

      desempenho = []

      # console.log '_(corr).each (correta, key) ->',opcoes
      corr.forEach (opcao, key) ->

        labelOpcao = self.ui.opts.find(""":input[data-originalidx="#{opcao.originalIdx}"]""").parent()
        marcada = $(labelOpcao).find(':input').is(':checked')
        correta = opcao.correta

        # console.log """
        # OP #{opcao.originalIdx} ( #{if marcada then '*' else ' '} ) #{$(labelOpcao).text().trim()}
        #    opção #{if correta then 'correta' else 'incorreta'}, você #{if !marcada then 'não ' else ''}marcou e #{if correta is marcada then 'acertou' else 'errou'}.
        # """

        labelOpcao.css opacity: '.7'
        labelOpcao.find(':input').css cursor: 'default'
        # opcao é correta
        labelOpcao.css('color', azul) if correta

        # acertou porque marcou
        if correta is marcada
          labelOpcao.css('color', verde) if correta
          desempenho.push true

        # errou porque marcou
        if !correta and marcada
          labelOpcao.css 'color', vermelho
          desempenho.push false

        # errou porque não marcou
        desempenho.push false if correta and !marcada


      # console.log 'desempenho', desempenho

      acertos = (desempenho.filter (c)-> c).length

      media = parseInt acertos / desempenho.length * 100, 10
      # console.log acertos, media
      @ui.corrPorCent.text media
      ico = switch
        when media >= 70 then 'checkbox-marked-circle'
        when media >= 50 then 'alert-circle'
        else 'close-circle'
      tipo = switch
        when media >= 70 then 'success'
        when media >= 50 then 'warning'
        else 'danger'

      @ui.corrIco.addClass "mdi-#{ico}"
      @ui.correcao.removeClass('out hide').addClass "alert-#{tipo} in"
      @ui.saiba.removeClass('out hide').addClass 'in'

      conceito = $ 'li.score'
      scoreAtu = parseInt conceito.data 'score'
      conceito.find('.tit-conceito').text('Conceito') if scoreAtu is 0
      totalScore = scoreAtu + media
      div = 2
      div = 1 if scoreAtu is 0
      score = totalScore / div
      conceito.data 'score', score
      # console.log "score #{score}"
      strConceito = @getConceito score
      conceito.find('.conceito').text strConceito

      if !@silent
        salvaResposta =
          atividade: @model.collection.caso.get '_id'
          seqid: @$el.data 'seqid'
          marcadas: @getMarcadas()
          modulo: window.modulo._id
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

      acertoBadge = switch
        when tipo is 'success' then 'correto'
        when tipo is 'warning' then 'meio'
        else 'errado'
      badge = $ 'li.quest > span[target="' + @$el.prop('id') + '"]'
      badge.addClass 'corrigido'
      badge.addClass "#{acertoBadge}"

      @respondido = true

      @trigger 'respondeu', @, tipo, desempenho, media

    respondido: false

    'getConceito':(conceito)->
      switch
        when conceito >= 95 then 'A+'
        when conceito >= 90 then 'A'
        when conceito >= 80 then 'B+'
        when conceito >= 70 then 'B'
        when conceito >= 60 then 'C+'
        when conceito >= 50 then 'C'
        when conceito >= 40 then 'D+'
        when conceito >= 30 then 'D'
        when conceito >= 20 then 'E+'
        else 'E'

    'tocado':(evt)->
      self = this
      @ehTocado = true
      # if !@respondido and /label/img.test evt.target.tagName
      #   $(evt.target).find('input').prop('checked', (idx, oldAttr)-> !oldAttr )
      return false if @respondido
      # console.log arguments, @, do @getMarcadas
      setTimeout (self) ->
        respostas = do self.getMarcadas
        # console.log respostas
        if respostas.length isnt 0
          # console.log self
          self.ui.btnResp
          .removeClass('disabled btn-default')
          .addClass('btn-info')
          .text 'Responder'
        else
          self.ui.btnResp
          .removeClass('btn-info')
          .addClass('btn-default disabled')
          .text 'Selecione'

      , 100, @

    verificaConcluinte: ()->
      self = @
      App.user.ofertas.forEach (o)->
        nucleos = self.model.get('profissional')
        if o.modulo is App.moduloId and (nucleos.indexOf(o.conteudo) > -1 or o.conteudo is 'interdisciplinar') and o.dt_conclusao
          self.ui.btnResp.hide()


  SlideQueMultipla


