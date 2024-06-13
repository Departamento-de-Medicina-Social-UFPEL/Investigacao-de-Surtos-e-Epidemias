define [], ->

  class SlideExame extends Marionette.ItemView

    template: '#caso-progresso-slides-exame'
    className: 'container slide'
    tagName: 'section'

    initialize: ->
      console.log @model.collection
      pac = @model.collection.paciente
      @model.set('fenotipo', pac.get 'fenotipo')



  SlideExame


