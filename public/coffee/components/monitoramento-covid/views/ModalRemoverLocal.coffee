define [
], () ->

  Modal = Backbone.Modal.extend
    initialize: ->
      #console.log @model, 'model'
    template: _.template $('#monitoramento-covid-monitoramento-confirma-remover').html()
    submitEl: '.btn-excluir'
    cancelEl: '.close-modal'

    submit:()->
      #console.log 'submit'
      App.monitoramentos.excluir(@model.get('id'))
      App.main.currentView.render()
    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      App.appRouter.navigate '#comp/monitoramento-covid', 'trigger': yes

  Modal
