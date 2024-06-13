define [
  './views/lista/LayoutView'
  './views/nova/LayoutView'
  './views/nova/UfsCollView'
  './views/nova/MunCollView'
  './views/nova/UbsCollView'
  './views/nova/InfoModalSelView'
  './collections/UbsColl'
  './models/UbsModel'
  'backbone'
  'marionette'
], (ListaUbsLayoutView, NovaUbsLayoutView, UfsCollView, MunCollView, UbsCollView, InfoModalView, UbsColl, UbsModel, Backbone, Marionette) ->

  selectMunView = new MunCollView
    collection: new Backbone.Collection [nome: 'Selecione o município', ibge: -123]

  'listaUbs': (callback) ->
    # App.main.show new ListaUbsLayoutView
    Backbone.history.navigate 'comp/ubs/nova', trigger: true
    callback.apply @ if callback

  'novaUbs': (callback) ->
    console.log 'novaUbs'
    App.main.show new UfsCollView
    callback.apply @ if callback

  'selecionaEstado': (uf, callback) ->
    current = App.main.currentView
    unless current
      @novaUbs () ->
        @selecionaEstado uf, callback
      return
    # current.selUf.$el.find('select').val uf
    @carregaMuns uf, current
    current.selMun.show selectMunView
    callback.apply @ if callback

  'selecionaMunicipio': (uf, ibgeCod, callback) ->
    current = App.main.currentView
    unless current
      @novaUbs () ->
        @selecionaEstado uf, () ->
          @selecionaMunicipio uf, ibgeCod
      return
    # current.selUf.$el.find('select').val uf
    if selectMunView.collection.length < 2
      estado = _.findWhere App.estados, sigla: uf.toUpperCase()
      selectMunView.collection.reset first.cidade.concat estado.cidades
    @carregaUbs uf, ibgeCod
    current.selMun.show selectMunView
    current.selMun.$el.find('select').val parseInt ibgeCod
    callback.apply @ if callback

  'selecionaUbs': (uf, ibgeCod, cnes, callback) ->
    console.log "'selecionaUbs': (uf, ibgeCod, cnes, callback) ->"
    current = App.main.currentView
    unless current
      @novaUbs () ->
        @selecionaEstado uf, () ->
          @selecionaMunicipio uf, ibgeCod, ()->
            @selecionaUbs uf, ibgeCod, cnes
      return
    ubs = new UbsModel
    ubs.url = "/ubs/#{cnes}"
    ubs.fetch
      'success': (dataModel) ->
        modal = new InfoModalView
          'model': dataModel
        do modal.render
        e = modal.$el
        e.appendTo '#mainStage'
        e.modal()
        # e.find('.modal-backdrop').show()

    callback.apply @ if callback
    # console.log uf, ibgeCod, cnes


  'carregaMuns': (uf)->
    estado = _.findWhere App.estados, sigla: uf.toUpperCase()
    first = [nome: 'Selecione o município', ibge: -123]
    selectMunView = new MunCollView
      collection: new Backbone.Collection first.concat(estado.cidades)

  'carregaUbs': (uf, ibge) ->
    ubsColl = new UbsColl
    ubsColl.url = "/ubs/busca/codibge/#{ibge}"
    ubsColl.fetch
      'success': (collection) ->
        collV = new UbsCollView {collection}
        App.main.currentView.selUbs.show collV
        collV.$el.find('.cidade').text(App.main.currentView.selMun.$el.find('option:selected').text())
        collV.$el.find('.estado').text(uf)

