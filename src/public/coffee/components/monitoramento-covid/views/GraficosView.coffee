define [
  './GraficoItemView'
], (GraficoItemView) ->

  class GraficosView extends Marionette.CompositeView
    childView: GraficoItemView,
    childViewContainer: '.list-graficos'
    buildChildView: (child, ChildViewClass, childViewOptions)->
      @model.set('tipo', child.get('tipo'))
      @model.set('titulo', child.get('titulo'))
      @model.set('tituloy', child.get('tituloy'))
      GraficoItemView(@model)
    childViewContainer: '.list-graficos'
    initialize: ->
      dados = @model.get('dados')
      dt_menor = dados[0].periodoInicio
      dt_maior = dados[0].periodoFim
      nr_total_casos = 0
      nr_total_contatos = 0
      dados.map (d)=>
        dtMenor = new Date(d.periodoInicio)
        dtMaior = new Date(d.periodoFim)
        if dtMenor < new Date(dt_menor)
          dt_menor = d.periodoInicio
        if dtMaior > new Date(dt_maior)
          dt_maior = d.periodoFim
        nr_total_casos += parseInt(d.nrConfirmado)
        nr_total_contatos += parseInt(d.nrEncerrados)
        d
      @model.set 'dt_inicio', dt_menor
      @model.set 'dt_fim', dt_maior
      @model.set 'nr_total_casos', nr_total_casos
      @model.set 'nr_total_contatos', nr_total_contatos
      @model.set 'ano', dt_menor.split('/')[2]

    className: ' container'

    template: '#monitoramento-covid-graficos'
    
    ui:{}

    onRender: ->
      self = @
      console.log @collection, 'collection'

    events:{}

  GraficosView