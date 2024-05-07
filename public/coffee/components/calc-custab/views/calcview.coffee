# Generated by CoffeeScript 1.10.0

extend = (child, parent) ->

  ctor = ->
    @constructor = child
    return

  for key of parent
    if hasProp.call(parent, key)
      child[key] = parent[key]
  ctor.prototype = parent.prototype
  child.prototype = new ctor
  child.__super__ = parent.prototype
  child

hasProp = {}.hasOwnProperty
define [
  'backbone'
  'backbone.marionette'
  'jknob'
], (Backbone, Marionette) ->
  custabMainView = undefined
  custabMainView = ((superClass) ->
    `var custabMainView`

    custabMainView = ->
      custabMainView.__super__.constructor.apply this, arguments

    extend custabMainView, superClass
    custabMainView::model = new (Backbone.Model)
    custabMainView::className = 'item calculadoras custab'
    custabMainView::template = '#calc-custab-main-view'
    custabMainView::ui =
      'resposta': '.condutaBox'
      'escoreBox': '.escoreBox'
      'condutaBox': '.condutaBox'
      'cigadia': '#cigadia'
      'anostab': '#anostab'
      'resultado': '.resultado'
    custabMainView::events =
      'keyup @ui.anostab': 'changeDados'
      'keyup @ui.cigadia': 'changeDados'
      # 'change @ui.anostab': 'changeDados'
      # 'change @ui.cigadia': 'changeDados'

    custabMainView::changeDados = ->
      dados = @getDados()
      resultado = dados.cigadia / 20 * dados.anostab * 30
      if resultado >= 0 and dados.cigadia and dados.anostab
        @ui.resultado.text 'R$ ' + resultado.toFixed(2).replace('.', ',') + ' /Mês'
        @ui.escoreBox.fadeIn()
        @ui.resposta.show()
      else if not dados.cigadia or not dados.anostab
        @ui.resultado.text 'Digite dois valores maiores que zero para calcular'
        @ui.escoreBox.fadeOut()
        @ui.resposta.show()
      else
        @ui.escoreBox.fadeOut()
        @ui.resposta.hide()
    custabMainView::getDados = ->
      cigadia = 0
      anostab = 0
      if @ui.anostab.prop('value') > 0
        anostab = @ui.anostab.prop('value')
      if @ui.cigadia.prop('value') > 0
        cigadia = @ui.cigadia.prop('value')
      r =
        cigadia: cigadia
        anostab: anostab
      r

    custabMainView::onRender = (view) ->
      @ui.escoreBox.hide()
      @ui.condutaBox.hide()

    custabMainView
  )(Marionette.ItemView)
  custabMainView

# ---
# generated by js2coffee 2.2.0