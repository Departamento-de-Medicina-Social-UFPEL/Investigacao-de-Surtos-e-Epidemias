define [], ->

  class SlideAnamnese extends Marionette.ItemView

    template: '#caso-slides-anamnese'
    className: 'container slide slideAnamnese'
    tagName: 'section'
    onRender:() ->
      @$el.attr 'id', 'slideAnamnese'


  SlideAnamnese


