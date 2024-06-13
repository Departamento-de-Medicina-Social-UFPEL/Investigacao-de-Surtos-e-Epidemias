define [
  'js/dummy'
  'js/ubsCollection'
  'js/ubsModel'
  'js/ubsInfoItemView'
  'js/selectViews'
], (dummy, UbsCollection, UbsModel, UbsInfoItemView, SelectViews) ->
  rawUfs = _.map staticData.estados, (item) -> _.partial(_.pick, item).apply null, ['sigla','nome']
  rawUfs = rawUfs.map (i)-> value: i.sigla, text: i.nome
  class UbsFormLayout extends Marionette.LayoutView
    tagName: 'form'
    template: '#local-template'
    onRender: ->
      @addRegions
        'uf': '.uf', 'muni': '.muni'
        'ubs': '.ubs', 'info': '.info'
      @uf.show new SelectViews.Estado
        collection: new Backbone.Collection [do dummy].concat rawUfs
      @muni.show new SelectViews.Municipio
        collection: new Backbone.Collection [dummy 'Escolha um estado.']
      @ubs.show new SelectViews.Ubs
        collection: new UbsCollection [dummy 'Escolha um estado e um município.']

    childEvents:

      'mostra:municipiosDeUf': (child, uf)->
        muniColl = @muni.currentView.collection
        ubsColl = @ubs.currentView.collection
        ubsColl.reset [dummy 'Escolha um estado e um município.']
        return muniColl.reset [dummy 'Escolha um estado.'] if uf is '-1'
        estado = _.findWhere staticData.estados, sigla: uf.toUpperCase()
        cidades = estado.cidades.map (i)-> value: i.ibge, text: i.nome
        muniColl.reset [ do dummy ].concat cidades

      'mostra:ubsDeMun': (child, ibge)->
        ubsColl = @ubs.currentView.collection
        return ubsColl.reset [dummy 'Escolha um estado e um município.'] if ibge is '-1'
        ubsColl.reset [dummy 'Carregando...']
        ubsColl.ibge = ibge
        do ubsColl.fetch

      'mostra:ubs': (child, cnes)->
        self = this
        ubsModel = new UbsModel
        ubsModel.set 'id': cnes
        ubsModel.fetch
          success: (model)->
            self.info.show new UbsInfoItemView { model }
