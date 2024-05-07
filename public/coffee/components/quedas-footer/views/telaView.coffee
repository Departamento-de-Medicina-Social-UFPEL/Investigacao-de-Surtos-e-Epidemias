define [
  'backbone.marionette'
], (Marionette) ->
  class IntroItemView extends Marionette.ItemView
    template: '#intro-tela'
    className: 'container'
    ui: prim: '.intro-primeira', seg: '.intro-segunda'
    onRender: () ->
      self = this
      do @ui.seg.hide
      changeLogo = ()->
        if self.ui.prim.is ':visible'
          self.ui.prim.fadeOut 100, -> do self.ui.seg.fadeIn if self.ui.seg
        else
          self.ui.seg.fadeOut 100, -> do self.ui.prim.fadeIn if self.ui.prim
      self.alterna = setTimeout changeLogo, 3000

    onBeforeDestroy: () ->
      clearInterval @alterna


  IntroItemView