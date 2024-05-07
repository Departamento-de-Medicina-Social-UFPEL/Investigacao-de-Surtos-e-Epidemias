define [

],  () ->

  class AdmissaoApresentacao extends Marionette.ItemView

    model: new Backbone.Model

    # id: 'carouselAdmissao'

    # className: 'item admissaoIntroducao'

    fitScreen: () ->
      fitView = @ui.innerContainer
      h = $(window).innerHeight() - 145
      console.log h
      fitView.css('minHeight': "#{h}px") if fitView

    topSetas: () ->
      fitView = @ui.setas
      h =  @ui.innerContainer.height()
      hf = ($(fitView[0]).height() / 2) - (h / 2)
      console.log hf
      fitView.css('top': "#{hf}px") if fitView

    paddingTopCont: (item) ->
      fitView = @ui.innerContainer
      hf = (item.height() / 2)
      console.log hf
      fitView.css('padding-top': "#{hf}px") if fitView





    template: '#admissao-monitoramento-apresentacao'

    'ui':
      'carouselAdmissao': '#carousel-adimissao'
      'innerContainer': '.carousel-inner'
      'setas': '.carousel-control'
      'setaProx': '.carousel-control.right'
      'setaAnte': '.carousel-control.left'



    onRender: () ->
      self = @
      @ui.carouselAdmissao.carousel 'pause'
      @ui.carouselAdmissao.swiperight ()->
        self.ui.carouselAdmissao.carousel 'prev'

      @ui.carouselAdmissao.swipeleft ()->
        self.ui.carouselAdmissao.carousel 'next'

      fit = ()->
        self.fitScreen

      $(window).on 'resize', fit

      do fit






