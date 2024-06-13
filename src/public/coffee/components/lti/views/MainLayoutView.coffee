define [
  'backbone.marionette'
], (Marionette) ->
  class MainLayoutView extends Marionette.LayoutView

    'className': 'container-static sobre-main'

    'template': '#sobre-main-layout'

    'regions':
      'contents': '#sobre-main-container'

    'ui':
      'indicators': '.carousel-indicators'
      'inner': '.carousel-inner'
      'next': 'a.right'
      'prev': 'a.left'

    'onRender': ->
      # console.log 'SobreMainViewOnRender'
      self = @
      @$el.find('[data-toggle="tooltip"]').tooltip()
      console.log @ui
      @ui.indicators.empty()
      slides = @ui.inner.children()
      if slides.length > 1
        slides.each (idx, el) ->
          indicator = $ "<li data-target='#carousel-example-generic' data-slide-to='#{idx}'></li>"
          indicator.css
            'margin-left': 2
            'margin-right': 2
          if $(el).hasClass 'active'
            indicator.addClass 'active'
          self.ui.indicators.append indicator
      else
        @ui.indicators.hide()
        @ui.next.hide()
        @ui.prev.hide()

      window._tempLoh = setTimeout ()->
        altMenu = $('.navbar-fixed-top').first().height()
        $('.carousel-inner .item').css 'min-height', ($(window).height()/2)
      , 500

      w = $ window
      w.on 'resize', ->
        clearTimeout window._tempLoh
        window._tempLoh = setTimeout ()->
          altMenu = $('.navbar-fixed-top').first().height()
          console.log altMenu
          $('mainStage').css 'padding-top', altMenu + 10
          $('.carousel-inner .item').css 'min-height', altMenu + 10
        , 500



  MainLayoutView