define [
],  (AdmissaoTemplate) ->

    class Admissao extends Marionette.ItemView

      className: 'item admissao container'

      template: '#admissao-monitoramento-inicial'

      model: new Backbone.Model
