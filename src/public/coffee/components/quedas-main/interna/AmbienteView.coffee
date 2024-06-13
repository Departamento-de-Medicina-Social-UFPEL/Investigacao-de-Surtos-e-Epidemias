define ['./ImagePile'], (ImageItemView) ->

  class InternaMainView extends Marionette.CompositeView

    className: 'item quedas interna container'

    template: '#quedas-main-interna'

    initialize: () ->
      console.log @model
      @orientacoes = @model.get 'resources'

      pasta = @model.get 'folder'
      imagens = []
      @orientacoes = @orientacoes.map (ori) ->
        return false unless ori.imagens
        for img in ori.imagens
          continue if img.el
          img.src = "#{defaultStaticFileService}/img/#{pasta}/#{pasta}_#{img.url}.png"
          img.ori = ori
          imagens.push img
        ori
      @pasta = pasta
      @imagens = imagens
      @collection = new Backbone.Collection imagens
      console.log imagens

    childViewContainer: '.image-pile'

    childView: ImageItemView

    ui:
      'images': '.image-pile'
      'slices': '.slices svg >'
      'contador': '.contador'
      'desisto':'.btn-desisto'
      'msg': '.full-msg'
      'gotoContent': '.btn-goto-content'
      'msgFinal': '.concluiu-msg'
      'closeConcluido': '.btn-close-concluido'

    events:
      'click @ui.slices': 'showOrienta'
      'click @ui.desisto':'showOrientacoes'
      'click @ui.msg':'showContent'
      'click @ui.closeConcluido':'closeConcluido'


    showContent: ()->
      do @ui.msg.fadeOut

    closeConcluido: ()->
      do @ui.msgFinal.fadeOut

    onRender: (view) ->
      @ui.contador.find(".total").text @imagens.length
      @ui.contador.find(".feitos").text '0'
      @$el.addClass @model.get 'folder'
      $('body').on 'click', (e)->
        nehPopover = $(e.target).data('toggle') isnt 'popover'
        ntemPopAberto = $(e.target).parents('.popover.in').length is 0

        if nehPopover and ntemPopAberto
          $('.imagem-orienta').popover 'hide'
      window.timing = null

      $(window).on 'resize', () ->
        if window.openPop
          clearInterval window.timing
          window.timing = setTimeout (poppper) ->
            poppper.popover 'show'
          , 200, window.openPop

      # @showOrienta @atualOri
      #do @ui.manejo.hide

    onDestroy:() ->
      $('.popover').remove()

    'styles':
      'glowErrado': 'drop-shadow(0 0 10px rgba(255,0,0,1))'
      'glowCerto': 'drop-shadow(0 0 10px rgba(0,255,0,1))'

    showOrienta:(evt) ->
      evt.stopPropagation()
      el = $ evt.target
      id = el.prop 'id'
      unless id
        el = el.parent()
        id = el.prop 'id'

      tag = el.prop 'id'
      qry = '.imagem-orienta[class*="'+tag+'"]'
      allImg = $ '.imagem-orienta'
      # allImg.css
      #     '-webkit-filter': 'none'
      #     'filter': 'none'
      allImg.popover 'hide'
      targets = $ qry

      self = @
      tagOri = $(targets[0]).attr 'ori'

      if @ui.images.find('.sombra').is ':visible'
        do @ui.images.find('.sombra').fadeOut

      if id == 'sombra'
        console.log id
        do @ui.images.find('.sombra').fadeIn
      console.log 'agora certo', targets, qry
      targets.each (a,b,c) ->
        certo = $(this).attr 'certo'
        # cor = self.styles[ if certo is 'true' then 'glowCerto' else 'glowErrado' ]

        cor = self.styles['glowCerto']
        $(this).attr 'meClicou', true
        # cc = {'-webkit-filter': cor, 'filter': 'url(#drop-shadow)'}
        style = $(this).attr('style')
        console.log style, 1
        style = style.split(';');
        style.push('-webkit-filter:'+cor)
        style = style.join(';');
        # style['webkit-filter'] = cor
        console.log style, 2
        $(this).attr 'style', style
        console.log 'css', $(this).attr('style'), style
      clicadas = $(".imagem-orienta[meClicou]").length
      @ui.contador.find(".feitos").text clicadas
      self=@

      if $(".imagem-orienta[meClicou]").length is self.imagens.length and !self.modalConcluido and !self.desistiu
        $(targets[0]).on 'hidden.bs.popover', ()->
          console.log self.desistiu, 'desistiu'
          do self.completo  if $(".imagem-orienta[meClicou]").length is self.imagens.length and !self.modalAberto and !self.desistiu

      setTimeout (me) ->
        me.popover 'show'
      , 300, $ targets[0]

      #do @completo if clicadas is @imagens.length
    completo:()->
      if !@modalConcluido
        do @ui.msgFinal.fadeIn
        @modalConcluido = true

    showOrientacoes:()->
      self = @
      @ui.slices.each (idx, el)->
        id = el.id
        unless id
          el = el.parent()
          id = el.prop 'id'

        tag = el.id
        qry = """.imagem-orienta[class*="#{tag}"]"""
        allImg = $ '.imagem-orienta'
        targets = $ qry
        tagOri = $(targets[0]).attr 'ori'
        if self.ui.images.find('.sombra').is ':visible'
          do self.ui.images.find('.sombra').fadeOut

        if id == 'sombra'
          do self.ui.images.find('.sombra').fadeIn

        targets.each () ->
          certo = $(this).attr 'meClicou'
          cor = self.styles[ if certo is 'true' then 'glowCerto' else 'glowErrado' ]

          # cor = self.styles['glowCerto']
          # $(this).attr 'meClicou', true
          # cc = {'-webkit-filter': cor, 'filter': 'url(#drop-shadow)'}
          style = $(this).attr('style')
          console.log style, 1
          style = style.split(';');
          style.push('-webkit-filter:'+cor)
          style = style.join(';');
          # style['webkit-filter'] = cor
          console.log style, 2
          $(this).attr 'style', style
          console.log 'css', $(this).attr('style'), style
          # certo = $(this).attr 'certo'
          # cor = self.styles[ if certo is 'true' then 'glowCerto' else 'glowErrado' ]
          # $(this).attr 'meClicou', true
          # $(this).css
          #   '-webkit-filter': cor
          #   'filter': 'url(#drop-shadow)'
      @desistiu = true
      #@ui.contador.find(".feitos").text @imagens.length

  InternaMainView
