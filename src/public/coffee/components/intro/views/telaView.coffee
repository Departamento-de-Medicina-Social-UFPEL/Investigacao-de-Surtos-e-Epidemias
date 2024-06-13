define [
  'backbone.marionette'
], (Marionette) ->
  class IntroItemView extends Marionette.ItemView
    template: '#intro-tela'
    className: 'container'
    ui:
      prim: '.intro-primeira'
      seg: '.intro-segunda'
      ter: '.intro-terceira'
      janela: '.janela'
      imagem: '.intro-primeira img'

    onRender: () ->
      self = this
      do @ui.seg.hide
      do @ui.ter.hide
      @ui.prim.css opacity: 0

      changeLogo = ()->
        console.log 'changeLogo'
        if self.ui.prim.is ':visible'
          self.ui.prim.fadeOut ->
            do self.ui.seg.fadeIn if self.ui.seg
            do self.centraliza
            self.ui.prim.hide
        else
          self.ui.seg.fadeOut ->
            do self.ui.ter.fadeIn if self.ui.ter
            do self.centraliza

      @ui.imagem.on 'load', ()->
        do self.centraliza
        self.ui.prim.css opacity: 1
        do self.ui.prim.fadeIn
        self.alterna = setInterval changeLogo, 3000

    centraliza: (self)->
      self ?= this
      altCaixa = do self.ui.janela.height
      heightGlobal = do $(window).height
      widthGlobal = do $(window).width
      centroGlobal = heightGlobal / 2
      novoTop = centroGlobal - (altCaixa/2)
      novoTop += ( novoTop * 0.08)
      self.ui.janela.offset top:novoTop

    onBeforeDestroy: () ->
      clearInterval @alterna

  IntroItemView