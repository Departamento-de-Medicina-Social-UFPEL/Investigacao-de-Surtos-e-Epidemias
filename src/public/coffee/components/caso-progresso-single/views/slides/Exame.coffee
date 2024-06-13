define [], ->

  class SlideExame extends Marionette.ItemView

    template: '#caso-progresso-single-slides-exame'
    className: 'container slide'
    tagName: 'section'
    ui:
      'feno': '.fenotipo'
    initialize: ->
      console.log @model.collection
      pac = @model.collection.paciente
      @model.set('fenotipo', pac.get 'fenotipo')

    onRender: ->
      @ui.feno.css 'background-image': 'url(./img/fenoSprite.png)'


  SlideExame


