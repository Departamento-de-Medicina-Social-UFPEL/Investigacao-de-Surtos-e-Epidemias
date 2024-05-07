define [
  '../collections/SlidesColl'
  './SlidesColl'
  './Introbox'
  'utils'
], (SlidesColl, SlidesCollView, IntroboxView, utils)->

  class CasoView extends Marionette.LayoutView

    className: 'saiba-mais-main container'

    initialize: () ->
      this.atual = App.progresso.getByAtividadeId(@model.get('_id')).length
      this.indiceResultado = @model.get('slides').length
      
    template: '#saiba-mais-main'

    ui:
      'item':'.item'
      'next':'.next'
      'prev':'.prev'
      'li':'li'
      'inicio':'.inicio'

    events:
      'click @ui.next': 'next'
      'click @ui.prev': 'prev'
      'click @ui.inicio': 'inicio'

    next:()->
      if @ui.next.hasClass('disabled')
        return
      this.atual = @$el.find('li.active>.link-item').data 'indice'

      if this.atual < this.indiceResultado
        this.atual++

      if @atual is this.indiceResultado-1
        @ui.next.hide()
      else
        @ui.next.show()
      @ui.prev.show()
      @trocaPara(this.atual)

    trocaPara:(indice)->
      this.atual = indice
      console.log 'trocaPara', indice
      @avancou(indice)
      if indice is this.indiceResultado
        return
      @$el.find('.item-'+(indice-1)).addClass('hide')
      @$el.find('.item-'+indice).addClass('active').removeClass('hide')
      @$el.find('li.active').removeClass 'active'
      @$el.find('.p'+indice).addClass('active')

    prev:()->
      if @ui.next.hasClass('disabled')
        return
      this.atual = @$el.find('li.active>.link-item').data 'indice'

      @$el.find('.item.active').addClass('hide')
      @$el.find('.item.active').removeClass 'active'
      console.log this.atual, 'atual'
      if this.atual > 0
        @$el.find('.p'+this.atual).removeClass('active')
        this.atual--

      if @atual is 0
        @ui.prev.hide()
      else
        @ui.prev.show()
      @ui.next.show()
      @$el.find('.item-'+this.atual).addClass('active').removeClass('hide')
      @$el.find('.p'+this.atual).addClass('active')

    
    avancou:(indice)->
      if (App.progresso.where({atividade: @model.get('_id'),seqid: indice })).length is 0
        salvaResposta =
          atividade: @model.get('_id')
          seqid: indice
          modulo: window.modulo._id
          marcadas: [1]
          escore: 100
          ts: do Date.now
        if App.user
          App.progresso.create salvaResposta
    
    getRespostasDeste: ->
      return null unless App.user
      respostas = App.progresso.getByAtividadeId @model.get '_id'
    vaiParaOndeEstava:()->      

    inicio:()->
      console.log 'inicio'
      @ui.li.removeClass 'active'
      @$el.find('.p1').addClass('active')
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      @ui.prev.addClass('disabled')
      @ui.next.removeClass('disabled')
      $('.item-1').addClass('active')
      do @$el.find('.item.active').show

    # vaiPraQuestaoDaVez: () ->
    #   page = $('html, body')
    #   page.on "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", ->
    #     do page.stop
    #     page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove"
    #   page.animate(
    #     scrollTop: $("section.slide.daVez").offset().top - 85
    #   , 600, -> page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove" )

    onRender: () ->
      # console.log @ui.estResp
      # console.log @model, @paciente
      @allSlides = new SlidesColl @model.get('slides'), @paciente, @model

      @addRegions
        introReg: '.caso #introducao'
        slidesReg: '.caso #slidesLista'

      @introReg.show new IntroboxView model: @model

      slides = @model.get('slides')
      slides = slides[1..] if slides[0].tipo is 'intro'
      slidesView = new SlidesCollView
        collection: new SlidesColl(slides, @paciente, @model)
      @slidesReg.show slidesView
      _this = this
      @trocaPara(if @atual is 0 then 0 else @atual-1)
      if @atual is 0
        @ui.prev.hide()
      else
        @ui.prev.show()
      if @atual is this.indiceResultado-1
        @ui.next.hide()
      else
        @ui.next.show()

      setTimeout ()->
        $.material.init()
      , 10

  CasoView