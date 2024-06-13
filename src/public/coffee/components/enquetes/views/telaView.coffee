define [
  'backbone.marionette'
], (Marionette) ->

  class ListaEnquetesView extends Marionette.ItemView
    initialize: (@user) ->
      console.log 'lista view'
      self = @
      @model = new Backbone.Model({elegivel:false, cadastro:false, conclusao:false, encerramento:false, encerradas:false})
      if App.enquetes
        enquetes = App.user.enquetes[App.moduloId]
        console.log('enquetes', enquetes)
        if enquetes 
          if enquetes.cadastro
            @model.set 'cadastro', true

          if enquetes.conclusao
            @model.set 'conclusao' , true

          if enquetes.encerramento
            @model.set 'encerramento', true
          # console.log('model enquetes', @model.attributes)
          modulo.ofertasAbertas.forEach (o)->
            if not self.model.elegivel
              nc  = o.conteudo.substring(0,1).toUpperCase()+o.conteudo.substring(1)
              console.log(nc, 'nc')
              self.model.elegivel = do App["masterElegivelCert"+nc]
      

    template: _.template($('#enquetes-template').html())
    cancelEl: '.close-modal'
    className: 'container  enf-med-main '

    onRender: ->
      self = @
      #console.log('enquetes', App.enquetes, App.user.enquetes[App.moduloId], @model.attributes)
      
      console.log @model, 'modelo'

  ListaEnquetesView

