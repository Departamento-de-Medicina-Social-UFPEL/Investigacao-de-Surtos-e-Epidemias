define [
], () ->

  Modal = Backbone.Modal.extend
    initialize: ->
      #console.log @model, 'model'
    template: _.template $('#monitoramento-covid-monitoramento-confirma-remover-amostra').html()
    submitEl: '.btn-excluir'
    cancelEl: '.close-modal'

    submit:()->
      id = @model.get('id')
      l = App.monitoramentos.get(@model.get('id_local'))
      dados = l.get('dados').filter (d)=>
        return d.id != id
      l.set('dados', dados)
      #@model.set('dados', dados)
      App.monitoramentos.update(l)
      App.main.currentView.render()

    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
      #m = $(this.$el.find('a.close-modal')[0])
      #if m
      #  m.attr('href':'#comp/monitoramento-covid/local/'+@model.get('id_local'))
    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      #location.hash = '#comp/monitoramento-covid/local/'+@model.get('id_local')
      #self.local(@model.get('id_local'))
  Modal