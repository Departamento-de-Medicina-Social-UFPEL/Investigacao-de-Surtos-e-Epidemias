define [
], () ->
  class GraficoEmpilhadoItemView extends Marionette.ItemView
    initialize: ->
      console.log @model, 'model'
    className: 'col-md-12'
    template: '#monitoramento-covid-grafico-item'
    el:'#area'
    ui:{}
    events:{}
    onRender: ->
      setTimeout 20000, ()->
        Highcharts.chart 'area',
          chart: type: 'column'
          title: text: @model.get('titulo')
          xAxis: categories: @model.get('categorias')
          yAxis:
            min: 0
            title: text: @model.get('tituloy')
          tooltip:
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>'
            shared: true
          plotOptions: column: stacking: 'percent'
          series: @model.get('series')
  GraficoEmpilhadoItemView
