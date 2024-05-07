define [
  'marionette'
], (Marionette) ->

  class CarouselCompView extends Marionette.CompositeView

    'className': 'carousel slide'

    'template': '#sobre-carousel'

    'ui':
      'left': '.left .carousel-control'
      'right': '.right .carousel-control'
      'indicators': '.carousel-indicators'
      'content': '.carousel-inner'

    'childViewContainer': '.carousel-inner'

    'childView': Marionette.ItemView.extend
      'className': 'item'
      'template': '#sobre-item'

    'onRender': () ->
      @$el
      .attr
        'id': 'sobre-slides'
      .css
        'height': $(window).innerHeight() / 2
      # @$el.carousel()
      console.log @$el.offset()
      console.log 'render'


  CarouselCompView