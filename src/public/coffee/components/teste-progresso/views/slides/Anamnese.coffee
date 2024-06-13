define [], ->

  class SlideAnamnese extends Marionette.ItemView

    template: '#caso-progresso-slides-anamnese'
    className: 'container slide slideAnamnese'
    tagName: 'section'
    onRender:() ->
      @$el.attr 'id', 'slideAnamnese'


  SlideAnamnese


